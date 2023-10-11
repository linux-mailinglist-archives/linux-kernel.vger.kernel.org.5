Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07BBB7C4929
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 07:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjJKFXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 01:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjJKFXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 01:23:03 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE4C98E
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 22:23:00 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c9bca1d96cso10175205ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 22:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697001780; x=1697606580; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Yd6bY2jeOYPiGoBLqHgpAOXMIaT9UW6PlUc9Ge/NMwY=;
        b=QK537KTWAZDpVxT8hVhq/ldQse2qAiHTDZr9cCWmZpC6DHg6ShHFvO/3AdGAXvHglH
         pF+4qK0mIjElQv5aCYseWRglogJw6bP8f9ZKfNUgd6P6emwoRzuneks1hpOFXwNJt5G2
         +ASdCoF5qIcZBVpaJRNLO8qRbDLNxmyUTHkm5yXdbOMa1wT7RbQTISwIvuUSHyyVHRH9
         hk6Gx1M254Ikh0bNTpDpMEQjltf3brVj+K7TfyOVpW4p+k/r1X2a7oLzqxiABImsc2jS
         fUEyhSwkykyaCNfCSS7TFpArR7my1TDGaHIPPXWTAW72udkkmmooiPBiM/h6rkac9U/p
         7osg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697001780; x=1697606580;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yd6bY2jeOYPiGoBLqHgpAOXMIaT9UW6PlUc9Ge/NMwY=;
        b=ps//wuuKhdOyZ+ZTn6UT9+RMAK2FaISfFRiq+QPsNFSZBi5zy1z7DEQxWvYAw3F+bW
         la04Foec016K1wFCyfQR94zV4AYAmY1QutNxHnHC6EpMPtD/HWI1hHHuNo7d+nzhK1iB
         fz4Esca1bEyLPV7OerXOyqPTMMBKinHHYXqAk4YjJ7o6rPKUAuMdMntfkpHZsaeGUi7m
         F6g6uGnmO8tH7cHajVRkzdn05ALJmes/rz99fVFn7zi1ENJDCOO53T4tplQo0luwxpli
         0pGgLTfyFjqQeMWDk+MdWKi9lDGbrb82RDetJQ9RyaSkCmafm2PxsLQf6L2jJ1ToB5F5
         ODmg==
X-Gm-Message-State: AOJu0YwIUZdqbisBwOQkQZYabeJ6vqo1+jizMztQit9eJ282yHMM5Rg9
        HO1p5dWLY8EebmnXhk6adHea4CcDNRgPaSsx3Xg=
X-Google-Smtp-Source: AGHT+IFFch8XhhW5FVKRD1ftq3ydV2OUtAQX2dMkC9Xm4ZBmUHqzpv2pnzUIv8pgy4KFsYI7apOtag==
X-Received: by 2002:a17:90b:1e02:b0:27d:775:56d9 with SMTP id pg2-20020a17090b1e0200b0027d077556d9mr327774pjb.15.1697001780213;
        Tue, 10 Oct 2023 22:23:00 -0700 (PDT)
Received: from localhost ([122.172.81.92])
        by smtp.gmail.com with ESMTPSA id cf11-20020a17090aebcb00b00276bde3b8cesm12975235pjb.15.2023.10.10.22.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 22:22:59 -0700 (PDT)
Date:   Wed, 11 Oct 2023 10:52:57 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Florian Fainelli <florian.fainelli@broadcom.com>
Cc:     linux-kernel@vger.kernel.org, mmayer@broadcom.com,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "open list:CPU FREQUENCY SCALING FRAMEWORK" 
        <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] cpufreq: ARM_BRCMSTB_AVS_CPUFREQ cannot be used with
 ARM_SCMI_CPUFREQ
Message-ID: <20231011052257.ly5g5zm5quqpcgfb@vireshk-i7>
References: <20231010181626.3449090-1-florian.fainelli@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010181626.3449090-1-florian.fainelli@broadcom.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-10-23, 11:16, Florian Fainelli wrote:
> The brcmstb-avs-cpufreq driver is considered a legacy driver and since
> 2018, ARCH_BRCMSTB systems have been using scmi-cpufreq. As a matter of
> fact, when SCMI is in use, brcmstb-avs-cpufreq is unusable since the
> SCMI firmware takes over, this can result in various problems, including
> external synchronous aborts.
> 
> Express those constraints such that the driver is not enabled by default
> when SCMI CPU frequency scaling is in use.
> 
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>  drivers/cpufreq/Kconfig.arm | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index 123b4bbfcfee..c287305820b7 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -90,7 +90,7 @@ config ARM_VEXPRESS_SPC_CPUFREQ
>  
>  config ARM_BRCMSTB_AVS_CPUFREQ
>  	tristate "Broadcom STB AVS CPUfreq driver"
> -	depends on ARCH_BRCMSTB || COMPILE_TEST
> +	depends on ARCH_BRCMSTB && !(ARM_SCMI_PROTOCOL && ARM_SCMI_CPUFREQ) || COMPILE_TEST

ARM_SCMI_CPUFREQ already implies ARM_SCMI_PROTOCOL, you don't need to
add both here.

-- 
viresh
