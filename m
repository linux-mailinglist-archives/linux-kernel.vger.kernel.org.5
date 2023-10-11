Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 807577C5A7B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 19:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbjJKRqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 13:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232642AbjJKRqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 13:46:18 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFEF0C4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 10:46:17 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1e96c9c4597so15435fac.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 10:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697046377; x=1697651177; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7KT2lGeLwtQTB/P6/+Ge2h+4ZxKBka/i3DIq7lu38l0=;
        b=Nr7rRhNaT0ULaP7g7EXB11BpmhJWUcfCbVDbKqJpgBj4b4HG1VpBSDrgTLw9WYBdYH
         N+pkdJseSKpimavfu/8X5Qkdxy0cZy7m8ZUx7EvRVF8hGLSc0+ylxHE6QR4Jheb1TftG
         UZc+85BVAah85JAumNrAStRU/yRZftgcC5oX/VM3Z99XF8yPdfvETpp8lhKWA1Juyklc
         lmgI0DuFj+UnULbL4s1b18XxNI3b2Gf6WxB70t1UIHtSSNiVepkY7UGCYOjUzulTWPCb
         V+txPvM0+xfn423XIAsXTlX1Tz9fFRPDHsm9xy0/XyaLjFODXS1ihCvVbfe+bU8t7uSL
         BKAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697046377; x=1697651177;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7KT2lGeLwtQTB/P6/+Ge2h+4ZxKBka/i3DIq7lu38l0=;
        b=fA1V5L1+dmMoHeNF/dj8jy3CMUT+SW47UgT7OBXBxcf44FZQKu7avo2e8TMWFg4aCm
         7vOk8trAHlGgryUM31qBDUepdXYPnm1gJe7NdvbeRCpelD/8NGqYB/R9U9YyG8xuYDEW
         LzllvZX0M3Klp4Pnt7LkEVeF3UpAs5ViLgzjjg0s7eHuXP2OGQT7MPy/cpRbfJmCdAL/
         CQBYZSBKVRWldYsNvjl/0KNIVQgQvPPODT5ue7QjNGQsO34K6R5I7eKM/txNtWA8Zkqf
         XtefMD2w0OEmt1bcMfVqkKaS07ZoXzH+Zh1Js7fWTlP2bnvOdPnBZGgAyd6qkvlYKnog
         3TBQ==
X-Gm-Message-State: AOJu0YwIU3ISdSrzlho/wws+1QkX2ShTnFRf/apsCI6wsCaIRZbST+vs
        k2Bh8aY2E5QGqvjFKijOcZ+wGEuElfqnfj3F1dk=
X-Google-Smtp-Source: AGHT+IHm2w7sS5fQYEdtfUV3xeYuE81hOMu1l4YBnnpyYQgzOJ8pLWde9SSOYgV61kWZpxepTZ3Okg==
X-Received: by 2002:a05:6870:d695:b0:1d0:f5bd:6e9 with SMTP id z21-20020a056870d69500b001d0f5bd06e9mr21630202oap.22.1697046376987;
        Wed, 11 Oct 2023 10:46:16 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:fbd6:ce83:3759:dbcc])
        by smtp.gmail.com with ESMTPSA id i5-20020a639d05000000b0058dc763f449sm147777pgd.1.2023.10.11.10.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 10:46:16 -0700 (PDT)
Date:   Wed, 11 Oct 2023 11:46:14 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Patrice Chotard <patrice.chotard@foss.st.com>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remoteproc: st: Use device_get_match_data()
Message-ID: <ZSbfZuHHicFoMPAz@p14s>
References: <20231009211356.3242037-10-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009211356.3242037-10-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 04:13:40PM -0500, Rob Herring wrote:
> Use preferred device_get_match_data() instead of of_match_device() to
> get the driver match data. With this, adjust the includes to explicitly
> include the correct headers.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/remoteproc/st_remoteproc.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
>

Applied.

Thanks,
Mathieu

> diff --git a/drivers/remoteproc/st_remoteproc.c b/drivers/remoteproc/st_remoteproc.c
> index e3ce01d98b4c..b0638f984842 100644
> --- a/drivers/remoteproc/st_remoteproc.c
> +++ b/drivers/remoteproc/st_remoteproc.c
> @@ -16,10 +16,9 @@
>  #include <linux/mfd/syscon.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_address.h>
> -#include <linux/of_device.h>
>  #include <linux/of_reserved_mem.h>
>  #include <linux/platform_device.h>
> +#include <linux/property.h>
>  #include <linux/regmap.h>
>  #include <linux/remoteproc.h>
>  #include <linux/reset.h>
> @@ -341,7 +340,6 @@ static int st_rproc_parse_dt(struct platform_device *pdev)
>  static int st_rproc_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> -	const struct of_device_id *match;
>  	struct st_rproc *ddata;
>  	struct device_node *np = dev->of_node;
>  	struct rproc *rproc;
> @@ -349,19 +347,15 @@ static int st_rproc_probe(struct platform_device *pdev)
>  	int enabled;
>  	int ret, i;
>  
> -	match = of_match_device(st_rproc_match, dev);
> -	if (!match || !match->data) {
> -		dev_err(dev, "No device match found\n");
> -		return -ENODEV;
> -	}
> -
>  	rproc = rproc_alloc(dev, np->name, &st_rproc_ops, NULL, sizeof(*ddata));
>  	if (!rproc)
>  		return -ENOMEM;
>  
>  	rproc->has_iommu = false;
>  	ddata = rproc->priv;
> -	ddata->config = (struct st_rproc_config *)match->data;
> +	ddata->config = (struct st_rproc_config *)device_get_match_data(dev);
> +	if (!ddata->config)
> +		goto free_rproc;
>  
>  	platform_set_drvdata(pdev, rproc);
>  
> -- 
> 2.42.0
> 
