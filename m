Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1448E7FEA48
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 09:16:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbjK3IPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 03:15:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjK3IPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 03:15:52 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C172A3;
        Thu, 30 Nov 2023 00:15:58 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id ABE3760004;
        Thu, 30 Nov 2023 08:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701332156;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s69TJTYmQM2Na6w0MNv4Zxu5ZAZSHQgLCcpXlVWiE5Q=;
        b=lxUKTMQX8E2vo+LCDvXlICGZucgDDgZYYV9wpbwQn4UHEzCvIDDO7nf/zE79tvnzjwVJSE
        6F9wnSwCtwUz4rPsCF7/U8PaXIfwRS/nhEbcEmuyIk3C/XXm0x9ckfhLILqMHLxEN59dHG
        ErWJmVlip+O3niyxS7Lfac43KHct0grhDa58gx+0pWyVqc2TW5Txz9qmB1zacLqMvwTU1A
        maDt0RCjA8Jpz+LdPH5BS6ti77Q/6bhA2e4F9NsvWTuP6rPtbZUUR7sV8S2CcG0IbZUzfM
        /Da1FsSyGY4X4nvL/YgEBKbK45nD2qJ2iVcwSXVomZHdgAqXXi8XYXqjPAvNMg==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH 0/2] MIPS: Adjust SPARSEMEM Kconfigs
In-Reply-To: <20231028-mm-v1-0-45377cd158cf@flygoat.com>
References: <20231028-mm-v1-0-45377cd158cf@flygoat.com>
Date:   Thu, 30 Nov 2023 09:15:56 +0100
Message-ID: <878r6ffygz.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: gregory.clement@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jiaxun,

> Hi,
>
> This series adjusted some mm Kconfigs, mainly sparsemem related.

Following your feedback on my series adding support for EyeQ5[1]. I
tested those 2 patches and as expected it reduces a lot the memory
consumption, memap consumes 512 pages again while without these patches
it consumed 8672 pages.

You can add on both patches my

Tested-by: Gregory CLEMENT <gregory.clement@bootlin.com>

Thanks,

Gregory
>
> Hope it is not too late for 6.7 :-)
>
> Thanks
> - Jiaxun 
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
> Jiaxun Yang (2):
>       MIPS: Enable SPARSEMEM option unconditionally on 64BIT
>       MIPS: generic: Set SPARSEMEM by default for 64BIT kernel
>
>  arch/mips/Kconfig             | 14 +++++++++-----
>  arch/mips/loongson2ef/Kconfig |  4 ++--
>  2 files changed, 11 insertions(+), 7 deletions(-)
> ---
> base-commit: 66f1e1ea3548378ff6387b1ce0b40955d54e86aa
> change-id: 20231028-mm-82dc717e9e49
>
> Best regards,
> -- 
> Jiaxun Yang <jiaxun.yang@flygoat.com>
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
