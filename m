Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA632764A26
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 10:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233791AbjG0IHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 04:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233768AbjG0IG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 04:06:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70830128
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 01:03:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0DFEA61DA2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 08:03:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A108C433C7;
        Thu, 27 Jul 2023 08:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690445002;
        bh=2TyIJyHYASUoeAuNBExQ7Upn2naOgOozjwpfY0cvE/Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pbos+VHSeeXMtK4cSodDIHutWXua9CUJD7cAoyTRRg/2DxQHGCEC9HLFT56RjVr/2
         dkPcQgvKsnfI6aFOl8udayaXch9OTD3QFVYauHoB0F8Nmr3RTQ8STxnGkMZqjMFI3V
         MT4kISx9cznxh8zJ9Bz31hLX5obsJ3fSrzcrIiEs=
Date:   Thu, 27 Jul 2023 10:03:19 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alexon Oliveira <alexondunkan@gmail.com>
Cc:     martyn@welchs.me.uk, manohar.vanga@gmail.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: vme_user: fix check alignment should match open
 parenthesis
Message-ID: <2023072729-sensitive-spyglass-ec96@gregkh>
References: <ZKjeHx/zqrNIqaA6@alolivei-thinkpadt480s.gru.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZKjeHx/zqrNIqaA6@alolivei-thinkpadt480s.gru.csb>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 08, 2023 at 12:55:11AM -0300, Alexon Oliveira wrote:
> Adhere to Linux kernel coding style.
> 
> Reported by checkpatch:
> 
> CHECK: Alignment should match open parenthesis
> 
> #132: FILE: drivers/staging/vme_user/vme_bridge.h:132
> #135: FILE: drivers/staging/vme_user/vme_bridge.h:135
> #139: FILE: drivers/staging/vme_user/vme_bridge.h:139
> #142: FILE: drivers/staging/vme_user/vme_bridge.h:142
> #144: FILE: drivers/staging/vme_user/vme_bridge.h:144
> #146: FILE: drivers/staging/vme_user/vme_bridge.h:146
> #148: FILE: drivers/staging/vme_user/vme_bridge.h:148
> #152: FILE: drivers/staging/vme_user/vme_bridge.h:152
> #163: FILE: drivers/staging/vme_user/vme_bridge.h:163
> #173: FILE: drivers/staging/vme_user/vme_bridge.h:173
> #175: FILE: drivers/staging/vme_user/vme_bridge.h:175

We don't need all of these lines.

>     Signed-off-by: Alexon Oliveira <alexondunkan@gmail.com>

Please don't indent your signed-off-by line, that should be to the left.

> 
> diff --git a/drivers/staging/vme_user/vme_bridge.h b/drivers/staging/vme_user/vme_bridge.h
> index 11df0a5e7f7b..a0d7a8db239d 100644
> --- a/drivers/staging/vme_user/vme_bridge.h
> +++ b/drivers/staging/vme_user/vme_bridge.h
> @@ -128,28 +128,21 @@ struct vme_bridge {
>  	struct mutex irq_mtx;
> 
>  	/* Slave Functions */
> -	int (*slave_get)(struct vme_slave_resource *, int *,
> -		unsigned long long *, unsigned long long *, dma_addr_t *,
> -		u32 *, u32 *);
> -	int (*slave_set)(struct vme_slave_resource *, int, unsigned long long,
> -		unsigned long long, dma_addr_t, u32, u32);
> +	int (*slave_get)(struct vme_slave_resource *, int *, unsigned long long *,
> +			 unsigned long long *, dma_addr_t *, u32 *, u32 *);
> +	int (*slave_set)(struct vme_slave_resource *, int, unsigned long long, unsigned long long, dma_addr_t, u32, u32);

Did you run your patch through checkpatch.pl after making this change?
I think you just added more warnings...

thanks,

greg k-h
