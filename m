Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6234275991A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 17:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbjGSPGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 11:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjGSPGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 11:06:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CC21722
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 08:06:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B63661720
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 15:06:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BA8DC433C8;
        Wed, 19 Jul 2023 15:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689779171;
        bh=wWsF04L3+JcVTYX353xMP+c06Dg1DmVPDdiQWYeDml8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O7fJY6e0EOfiKSmA1JrE/FolxFkrmQIvA+XSYn9IvtGY8GsLCTI0xntI/w8Zz6V4z
         NJ3cwOHwsmbQcemT8tptEUzUz+2jaZGvZ4xuOM73KiRk1058IF/sp+aEy6hY56OkNM
         FYAtcyqajqrNP93SXRXygKAH2NCsGJNBPEZqs1f/vVFCsCD06CxabMkR4DRb1WUaLz
         MyqDIETva9pWDc+fQFE6rxagqPaoXn8nKzMIBp8XNZ5Lm0fT0oc+SCECu8xEqOBA1N
         Goak4/7kk4kAJY9GQQT5jVJk64NZTg2MMa9coCrqDgPt+YQilll8INPNrDKiLjtwzq
         hkTJ4uSoyLG6w==
Date:   Wed, 19 Jul 2023 22:54:38 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: berlin: Drop unused includes
Message-ID: <ZLf5LpHSBAkDvVhO@xhacker>
References: <20230717225654.3215215-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230717225654.3215215-1-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 04:56:54PM -0600, Rob Herring wrote:
> Several includes are not needed, so drop them.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Thanks for the patch. I will send a PR during RC6
> ---
>  arch/arm/mach-berlin/berlin.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/arch/arm/mach-berlin/berlin.c b/arch/arm/mach-berlin/berlin.c
> index 2424ad40190c..13d5c899f09e 100644
> --- a/arch/arm/mach-berlin/berlin.c
> +++ b/arch/arm/mach-berlin/berlin.c
> @@ -8,11 +8,6 @@
>   *  (c) Marvell International Ltd.
>   */
>  
> -#include <linux/init.h>
> -#include <linux/io.h>
> -#include <linux/kernel.h>
> -#include <linux/of_platform.h>
> -#include <asm/hardware/cache-l2x0.h>
>  #include <asm/mach/arch.h>
>  
>  static const char * const berlin_dt_compat[] = {
> -- 
> 2.40.1
> 
