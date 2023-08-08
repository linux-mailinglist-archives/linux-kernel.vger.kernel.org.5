Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28BED774978
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbjHHT4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233803AbjHHT4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:56:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782BD6BD06;
        Tue,  8 Aug 2023 11:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=SAlx/kIleh+28h3Essv318fiwR/vLM7vg9luSDD7/ek=; b=EszhTjzFjJGc2q3cfCIBNY0J5B
        s3f49m/TmRhmp8c5Kt8TXvdNjc0eyRj15pq0L3DtxBTcd6/HDfwlMw0LIN4R7SLuRAX8gxeMhV+Fn
        WB+o1GdfZsexzT3IpW+znIAFMGkKHYY17burpvqPBHOm4opGZLLxMQiH577FNqXl/Olxwp/8AQxPF
        MV0XWm8/lCsjZFcqVsgABCNgX4oLi2s40y+aA7CcE3osa5JTQtx5Y3wGbw4BBg0DheFvs/QPLlMup
        0tGG5ahyg0VrWdAHD4cn6Ybkzznd+EAJyn1nI0NiDCUVDTnEW+92xqzn3dgh/oTj/zZJkcCVPSRXl
        qD94ixmg==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qTOzO-002qfQ-0e;
        Tue, 08 Aug 2023 15:51:18 +0000
Message-ID: <90be12db-6aa5-cb8d-df98-fca3c994e4e8@infradead.org>
Date:   Tue, 8 Aug 2023 08:51:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3] sparc: Use shared font data
Content-Language: en-US
To:     linux@treblig.org, davem@davemloft.net, sam@ravnborg.org,
        benh@kernel.crashing.org, akpm@linux-foundation.org
Cc:     sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        mpe@ellerman.id.au, glaubitz@physik.fu-berlin.de
References: <20230807010914.799713-1-linux@treblig.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230807010914.799713-1-linux@treblig.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/6/23 18:09, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> sparc has a 'btext' font used for the console which is almost identical
> to the shared font_sun8x16, so use it rather than duplicating the data.
> 
> They were actually identical until about a decade ago when
>    commit bcfbeecea11c ("drivers: console: font_: Change a glyph from
>                         "broken bar" to "vertical line"")
> 
> which changed the | in the shared font to be a solid
> bar rather than a broken bar.  That's the only difference.
> 
> This was originally spotted by PMD which noticed that PPC does
> the same thing with the same data, and they also share a bunch
> of functions to manipulate the data.
> 
> Tested very lightly with a boot without FS in qemu.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

This survives lots of build testing with no problems, so

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> 
> v3
>   Added 'select FONT_SUPPORT' (to stop modconfig causing the font to be
>    linked into a module rather than the main kernel)
> 
> ---
>  arch/sparc/Kconfig        |   2 +
>  arch/sparc/kernel/btext.c | 365 +-------------------------------------
>  2 files changed, 11 insertions(+), 356 deletions(-)

-- 
~Randy
