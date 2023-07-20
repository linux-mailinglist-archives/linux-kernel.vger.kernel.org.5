Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93C0C75A642
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 08:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbjGTGX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 02:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjGTGX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 02:23:57 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8522EC
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 23:23:55 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1b730eb017bso329292fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 23:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689834235; x=1690439035;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dggPtmEGP3dy2drILjs+2wJcfDExdIGBOAMBxwJ/ru0=;
        b=YGJo5uBkh5DK+RbkpdeUjv9QK7FaD7XvAYXUeR8crp+cMG8rVUsJQYuSAi2TmQeBCZ
         JHEcnBp/8I+cpDoScwq5uHKwShPkspV/RKRLU4VDDBSpQQYkydrOpKqGrXIWaU/ziPqU
         Mj/IuZF/4PLn3g0sijzuJZcY2fTHzKgIF61jkGQXl4iY2xXtj4u+4NhwpB68s8pkUUuv
         kU5W2PfOrQrt8qfmRf4Dbn5VbWi5TvoRh4792XAbFSKRd42qKla5i6LNH7zJBk3KORBV
         38g1MhbYHYTHYxumQphc9ug0CQH7PBPW5QtYMSy5bixxXAtSJ/dPB6esGijXz1txBW8M
         RF/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689834235; x=1690439035;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dggPtmEGP3dy2drILjs+2wJcfDExdIGBOAMBxwJ/ru0=;
        b=HCuXODtNa2wL4vxBJ1Ak0O8mnJAR/DJLVEzCLX2AreT3XKrtGXotJPeT6dUozL7GTq
         OkMSse9KmsoJCyN1V1n9yJUCHKE/M2MSpUVn1pTeK3qqCclwC1FLahDVwDit6cgs3oXn
         SGm/JhYkxKO72jcEj+ZzgvTB/bohKnPscRqKBg1oJB7JYWKOU3NM2lV8TIoPIHrWc9n6
         MiBFKl8BHhH33XPiWe7l8wrZiQofPuCdGKEk4saebC9Ap0rqkBOzyY0nR7Ctb3X/lUx+
         nykQYHEAkaNM0chkCTKx80uFqJhc4H6g+fKzeJscuUNZVsG2a3LzwzqmeHxFlRIaXzo1
         w9Lw==
X-Gm-Message-State: ABy/qLaC+0OuejUtzyV2pukKtOAT2EAj0fMCo4UXU4eFOXikqKb/B7ft
        WJ+CD4lnMbrlfviE19X9ENs6sQ==
X-Google-Smtp-Source: APBJJlExIjV3DaaCX+IY2BnB8DwXP9PsmHQe+SGYNQ77zENXqJRz7/CK2GToA7iFfw3voNH5JAqsbg==
X-Received: by 2002:a05:6870:f144:b0:1b3:738e:a341 with SMTP id l4-20020a056870f14400b001b3738ea341mr837573oac.46.1689834235120;
        Wed, 19 Jul 2023 23:23:55 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id i127-20020a639d85000000b0055c656ef91asm252677pgd.77.2023.07.19.23.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 23:23:54 -0700 (PDT)
Date:   Thu, 20 Jul 2023 11:53:51 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>, soc@kernel.org,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: spear: Explicitly include correct DT includes
Message-ID: <20230720062351.mc4lqzckgqoosftl@vireshk-i7>
References: <20230717225414.3210914-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717225414.3210914-1-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-07-23, 16:54, Rob Herring wrote:
> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it was merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other. They also include platform_device.h
> and of.h. As a result, there's a pretty much random mix of those include
> files used throughout the tree. In order to detangle these headers and
> replace the implicit includes with struct declarations, users need to
> explicitly include the correct includes.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  arch/arm/mach-spear/spear1340.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-spear/spear1340.c b/arch/arm/mach-spear/spear1340.c
> index a391f154eff9..70986ef6c877 100644
> --- a/arch/arm/mach-spear/spear1340.c
> +++ b/arch/arm/mach-spear/spear1340.c
> @@ -10,7 +10,7 @@
>  
>  #define pr_fmt(fmt) "SPEAr1340: " fmt
>  
> -#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
>  #include <asm/mach/arch.h>
>  #include "generic.h"

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
