Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4C9C7531BD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 08:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235050AbjGNGHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 02:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235063AbjGNGHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 02:07:14 -0400
Received: from mailrelay3-1.pub.mailoutpod2-cph3.one.com (mailrelay3-1.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:402::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165712D61
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 23:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=9BNhLabwdAiJ2voXZND9Ot8F6P98Zou8nlUh3VEOLss=;
        b=QJDeNA+cKXc1jcUiTb4/MnC4WvT3IyKVpf1aFlSE1FYrZy6sGblDu/yvCZY7YbeFS6SR9PGe7g2sr
         bce6TekbTverVIEqIA9MtqELPgpIqj2gYydDsRY3VvRY4Q/geBF5GnZ480/bQW4s9E4vax+n9+Oy5u
         EqPzdX874opkA2lzdDeRfyZcqwgStI2ZaHUDX086pplyabKYnS1F4XUQEV3g1vjS6N6KkdNJE8yfXf
         x8kjP+z17kZ439D3blAFhjcfoVFvWMCIqoBZT4GWvWwwbZPO47Futg6Cyf2hT+FYP2EUQuC0BTmcIW
         Yssa2v/sEC5GOiVL3WS1XryylccHNqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=9BNhLabwdAiJ2voXZND9Ot8F6P98Zou8nlUh3VEOLss=;
        b=J1JhG5hCP7f9455vM3SCN+NdM6tlr9oW5YE7dl+VEXM/oeDKonA54F22t3XbBc5cwyWQh3Wd66Tzo
         ERtBQkXBQ==
X-HalOne-ID: a18a2382-220c-11ee-9f80-b90637070a9d
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay3 (Halon) with ESMTPSA
        id a18a2382-220c-11ee-9f80-b90637070a9d;
        Fri, 14 Jul 2023 06:06:56 +0000 (UTC)
Date:   Fri, 14 Jul 2023 08:06:55 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     liubin001@208suo.com
Cc:     davem@davemloft.net, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] floppy:ERROR: missing put_device; call
 of_find_device_by_node on line 589, but without a corresponding object
 release within this function. Add the put_device function before return to
 release memory
Message-ID: <20230714060655.GA50441@ravnborg.org>
References: <tencent_0C9506095848D9427102ED415071D0F3420A@qq.com>
 <0f4dc280605c4700556d88d6f59cd1c4@208suo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f4dc280605c4700556d88d6f59cd1c4@208suo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi LiuBin

On Fri, Jul 14, 2023 at 12:56:29PM +0800, liubin001@208suo.com wrote:
> Signed-off-by: LiuBin <liubin001@208suo.com>
> ---
>  arch/sparc/include/asm/floppy_64.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/sparc/include/asm/floppy_64.h
> b/arch/sparc/include/asm/floppy_64.h
> index 070c8c1f5c8f..c4c51f494f25 100644
> --- a/arch/sparc/include/asm/floppy_64.h
> +++ b/arch/sparc/include/asm/floppy_64.h
> @@ -588,6 +588,7 @@ static unsigned long __init sun_floppy_init(void)
> 
>          op = of_find_device_by_node(dp);
>          if (!op)
> +            put_device(op);
>              return 0;

This does not look right as the code will always return 0 now,
independent on the if test. You missed a set of curly braces.

	Sam

> 
>          state_prop = of_get_property(op->dev.of_node, "status", NULL);
