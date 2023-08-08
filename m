Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E234774BF6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 23:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233286AbjHHVBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 17:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235021AbjHHVAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 17:00:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD980660A
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 13:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=6eKGWV+qXBOmXib4CH5Q5ZonD3D+jdcD2iPRNMQYDUk=; b=a3g8FEOddyrqjCqTRZ1q+zPw7z
        fkLukIqE640YENNCXDa8maIEuKT2w71FPQ2faM0KUkRDtkJVGLEFUd3RBRGFOPYWKyH6cVq36oTYm
        kZJV8HgqNXCMieknQrGI397rm6F2V+TGepvWdhRDPsrJBzLFg6dj7AsdyA39J3lCdNupkftNuKekA
        LEd9qgfK8OxNusous4QBhGmmB7oCa5IX0c6mmFxkuKqaobANr1GIcg3hgt4Otl/XSBdCtj6jdJuwG
        Oez1iaXSEW/LfZBIakcEQbbDXE0qt0HZU8Eban0MerDMozdKZNVePY60Mm7VRNrGGv93+TlEf/b78
        rNxcd2ew==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qTTni-003Se7-0L;
        Tue, 08 Aug 2023 20:59:34 +0000
Message-ID: <3c11047c-0ef7-2316-6d77-70aca59b555d@infradead.org>
Date:   Tue, 8 Aug 2023 13:59:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2] LoongArch: Remove redundant "source
 drivers/firmware/Kconfig"
Content-Language: en-US
To:     Xi Ruoyao <xry111@xry111.site>, loongarch@lists.linux.dev
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>, linux-kernel@vger.kernel.org
References: <20230808075505.2481-1-xry111@xry111.site>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230808075505.2481-1-xry111@xry111.site>
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



On 8/8/23 00:55, Xi Ruoyao wrote:
> In drivers/Kconfig, drivers/firmware/Kconfig is sourced for all ports so
> there is no need to source it in the port-specific Kconfig file.  And
> sourcing it here also caused the "Firmware Drivers" menu appeared two
> times: once in the "Device Drivers" menu, another time in the toplevel
> menu.  This was really puzzling.
> 
> Signed-off-by: Xi Ruoyao <xry111@xry111.site>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  arch/loongarch/Kconfig | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index e71d5bf2cee0..465759f6b0ed 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -662,5 +662,3 @@ source "kernel/power/Kconfig"
>  source "drivers/acpi/Kconfig"
>  
>  endmenu
> -
> -source "drivers/firmware/Kconfig"

-- 
~Randy
