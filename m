Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08CC0790C88
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 16:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240063AbjICOni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 10:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjICOnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 10:43:37 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D16F5
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 07:43:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 03E6FCE0A05
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 14:43:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6B85C433C7;
        Sun,  3 Sep 2023 14:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693752209;
        bh=ttlE3ok8BQbOnf1ACAmLjfWl3fHYfC2CoxqqsrbpSQk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lL1tLxJM/3DAbT9CjlVRgdjhJ9SnlCFEcJRKougTIVGembhYtWExp62H31GJLmwPC
         zf2gi2DcflUkjKA5a1FP+hIrVL3GRM+NsOczdSyQIgpfwt1BKmiJCSPwOre1lKvu4X
         UXiFFhsuDDMXFVKiOHfxGoEy4Xfivw6nAemM0Nn4=
Date:   Sun, 3 Sep 2023 16:43:15 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Bergh <bergh.jonathan@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vme_user: Add missing '*' in multiline comments
Message-ID: <2023090301-emission-scarce-8272@gregkh>
References: <20230903140617.567850-1-bergh.jonathan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230903140617.567850-1-bergh.jonathan@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 03, 2023 at 04:06:17PM +0200, Jonathan Bergh wrote:
> This patch resolves a warning reported by checkpatch where multiline
> block comments should use '*' on intermediate lines in order to adhere
> to the Linux kernel coding-style guidelines.
> 
> Signed-off-by: Jonathan Bergh <bergh.jonathan@gmail.com>
> ---
>  drivers/staging/vme_user/vme_fake.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/vme_user/vme_fake.c b/drivers/staging/vme_user/vme_fake.c
> index 7c53a8a7b79b..90aaf650524d 100644
> --- a/drivers/staging/vme_user/vme_fake.c
> +++ b/drivers/staging/vme_user/vme_fake.c
> @@ -1010,8 +1010,8 @@ static void fake_free_consistent(struct device *parent, size_t size,
>  {
>  	kfree(vaddr);
>  /*
> -	dma_free_coherent(parent, size, vaddr, dma);
> -*/
> + *	dma_free_coherent(parent, size, vaddr, dma);
> + */

As this code isn't being used, why not just delete it instead?

thanks,

greg k-h
