Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 516537BB712
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 13:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbjJFL7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 07:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232062AbjJFL7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 07:59:00 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C5ACF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 04:58:58 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-50433d8385cso2731696e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 04:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696593537; x=1697198337; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z2YpB56g1ZO1fSiYdcPlJQvvw/UXo2TENQoVjkamjCU=;
        b=xI946+//04rQ0jPmocOod+66G722zdL1/ZV8F8EC1R/CwYRETxj+LwVzmZY270mwBO
         yU3475OG1LH4AwetLCJwUvJfzjZ+Dfggl1Cz3NXzddy+j5aQsyBO6lmCuG70Kf5lVS4d
         QKlhVex1l1blQHRNPTb2Bq0+69ggRgQfpzWHa5C77T3pHgg+3UwTknrrng5PwbD0g8Yc
         G3ZaquaCPS1RH4TmprzSW4nZHgqI7Oj/Tbna0jRog9XhqTEBmOySBWfktzqgIqGrgxS8
         LhEnezyGmIlmEAIyKLFrN4Gddn81iQWXzZezMMI0LGj84EgFCmXI8VAJClJGT5i5K1vo
         G6MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696593537; x=1697198337;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z2YpB56g1ZO1fSiYdcPlJQvvw/UXo2TENQoVjkamjCU=;
        b=lWGx7mwmBHWnWlnKflyMfR2oXJARMapdtC6s0DG30zpBdhBPQUrrEYmYWRGe0bnXjG
         tuOonFlDkecAS3nvNgjzXtRNukavHpfKvU0kbsSrAHH7LGwF6vNKHGiChCS/nNUU24xn
         /nFdXzmSrqNFqHap5Sg+v4Hyhwz5d036cb+qrvR8ItsGX38aoP5Y6SJSeckYq9sNKqxQ
         YrOMdNWgTXDhg+l3IZ1Qeus3jfG6pWjxzVUwDfLTjLXeTYu9vPNpBjVRO7+5fn5xps/2
         EZ6t0lyWCz2ptkXGEoaMBvR5Wd8d4fW75os+41Unsone9pfqtyosrrL1M7ZmljBaUfMW
         KG5Q==
X-Gm-Message-State: AOJu0YyB52Sz2mKr9jmcBvdlBRESwHiJAuiAOuFPidNn/iULTiuBSzUs
        v3+qI0er/pMOE4XZn+EkYSRCbg==
X-Google-Smtp-Source: AGHT+IH84a71c5BUHDM1pKyIDMouzqtoIUSHA953dJgVF6Zwilo+8mTZnAaSlaCCnjxKHEIfmAhrJA==
X-Received: by 2002:a19:5e48:0:b0:500:91ac:c0b5 with SMTP id z8-20020a195e48000000b0050091acc0b5mr6202802lfi.30.1696593537025;
        Fri, 06 Oct 2023 04:58:57 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id t9-20020a19ad09000000b00503fb2e5594sm275387lfc.211.2023.10.06.04.58.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Oct 2023 04:58:56 -0700 (PDT)
Message-ID: <520c3a22-4e16-4346-a20c-26adbc6bc0d6@linaro.org>
Date:   Fri, 6 Oct 2023 14:58:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/7] drm/msm/dp: move of_dp_aux_populate_bus() to eDP
 probe()
Content-Language: en-GB
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@gmail.com,
        agross@kernel.org, andersson@kernel.org
Cc:     quic_abhinavk@quicinc.com, quic_jesszhan@quicinc.com,
        quic_sbillaka@quicinc.com, marijn.suijten@somainline.org,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1696436821-14261-1-git-send-email-quic_khsieh@quicinc.com>
 <1696436821-14261-8-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1696436821-14261-8-git-send-email-quic_khsieh@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/2023 19:27, Kuogee Hsieh wrote:
> Currently eDP population is done at msm_dp_modeset_init() which happen
> at binding time. Move eDP population to be done at display probe time
> so that probe deferral cases can be handled effectively.
> wait_for_hpd_asserted callback is added during drm_dp_aux_init()
> to ensure eDP's HPD is up before proceeding eDP population.
> 
> Changes in v5:
> -- inline dp_display_auxbus_population() and delete it
> 
> Changes in v4:
> -- delete duplicate initialize code to dp_aux before drm_dp_aux_register()
> -- delete of_get_child_by_name(dev->of_node, "aux-bus") and inline the function
> -- not initialize rc = 0
> 
> Changes in v3:
> -- add done_probing callback into devm_of_dp_aux_populate_bus()
> 
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>   drivers/gpu/drm/msm/dp/dp_aux.c     | 34 ++++++++++++++++-----
>   drivers/gpu/drm/msm/dp/dp_display.c | 59 +++++++++++++++----------------------
>   2 files changed, 51 insertions(+), 42 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_aux.c b/drivers/gpu/drm/msm/dp/dp_aux.c
> index 10b6eeb..03f4951 100644
> --- a/drivers/gpu/drm/msm/dp/dp_aux.c
> +++ b/drivers/gpu/drm/msm/dp/dp_aux.c
> @@ -479,7 +479,6 @@ void dp_aux_deinit(struct drm_dp_aux *dp_aux)
>   
>   int dp_aux_register(struct drm_dp_aux *dp_aux)
>   {
> -	struct dp_aux_private *aux;
>   	int ret;
>   
>   	if (!dp_aux) {
> @@ -487,12 +486,7 @@ int dp_aux_register(struct drm_dp_aux *dp_aux)
>   		return -EINVAL;
>   	}
>   
> -	aux = container_of(dp_aux, struct dp_aux_private, dp_aux);
> -
> -	aux->dp_aux.name = "dpu_dp_aux";
> -	aux->dp_aux.dev = aux->dev;
> -	aux->dp_aux.transfer = dp_aux_transfer;
> -	ret = drm_dp_aux_register(&aux->dp_aux);
> +	ret = drm_dp_aux_register(dp_aux);
>   	if (ret) {
>   		DRM_ERROR("%s: failed to register drm aux: %d\n", __func__,
>   				ret);
> @@ -507,6 +501,21 @@ void dp_aux_unregister(struct drm_dp_aux *dp_aux)
>   	drm_dp_aux_unregister(dp_aux);
>   }
>   
> +static int dp_wait_hpd_asserted(struct drm_dp_aux *dp_aux,
> +				 unsigned long wait_us)
> +{
> +	int ret;
> +	struct dp_aux_private *aux;
> +
> +	aux = container_of(dp_aux, struct dp_aux_private, dp_aux);
> +
> +	pm_runtime_get_sync(aux->dev);
> +	ret = dp_catalog_aux_wait_for_hpd_connect_state(aux->catalog);
> +	pm_runtime_put_sync(aux->dev);
> +
> +	return ret;
> +}
> +
>   struct drm_dp_aux *dp_aux_get(struct device *dev, struct dp_catalog *catalog,
>   			      bool is_edp)
>   {
> @@ -530,6 +539,17 @@ struct drm_dp_aux *dp_aux_get(struct device *dev, struct dp_catalog *catalog,
>   	aux->catalog = catalog;
>   	aux->retry_cnt = 0;
>   
> +	/*
> +	 * Use the drm_dp_aux_init() to use the aux adapter
> +	 * before registering AUX with the DRM device so that
> +	 * msm eDP panel can be detected by generic_dep_panel_probe().
> +	 */
> +	aux->dp_aux.name = "dpu_dp_aux";
> +	aux->dp_aux.dev = dev;
> +	aux->dp_aux.transfer = dp_aux_transfer;
> +	aux->dp_aux.wait_hpd_asserted = dp_wait_hpd_asserted;
> +	drm_dp_aux_init(&aux->dp_aux);
> +
>   	return &aux->dp_aux;
>   }
>   
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index 79e56d9..df15145 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -1207,6 +1207,17 @@ static const struct msm_dp_desc *dp_display_get_desc(struct platform_device *pde
>   	return NULL;
>   }
>   
> +static int dp_auxbus_done_probe(struct drm_dp_aux *aux)
> +{
> +	int rc;
> +
> +	rc = component_add(aux->dev, &dp_display_comp_ops);
> +	if (rc)
> +		DRM_ERROR("eDP component add failed, rc=%d\n", rc);
> +
> +	return rc;
> +}
> +
>   static int dp_display_probe(struct platform_device *pdev)
>   {
>   	int rc = 0;
> @@ -1272,10 +1283,18 @@ static int dp_display_probe(struct platform_device *pdev)
>   	if (rc)
>   		goto err;
>   
> -	rc = component_add(&pdev->dev, &dp_display_comp_ops);
> -	if (rc) {
> -		DRM_ERROR("component add failed, rc=%d\n", rc);
> -		goto err;
> +	if (dp->dp_display.is_edp) {
> +		rc = devm_of_dp_aux_populate_bus(dp->aux, dp_auxbus_done_probe);
> +		if (rc) {
> +			DRM_ERROR("eDP auxbus population failed, rc=%d\n", rc);
> +			goto err;
> +		}
> +	} else {
> +		rc = component_add(&pdev->dev, &dp_display_comp_ops);
> +		if (rc) {
> +			DRM_ERROR("component add failed, rc=%d\n", rc);
> +			goto err;
> +		}
>   	}
>   
>   	return rc;
> @@ -1291,7 +1310,6 @@ static int dp_display_remove(struct platform_device *pdev)
>   
>   	component_del(&pdev->dev, &dp_display_comp_ops);
>   	dp_display_deinit_sub_modules(dp);
> -

Nit: irrelevant to this patch.

>   	platform_set_drvdata(pdev, NULL);
>   
>   	return 0;
> @@ -1388,29 +1406,8 @@ static int dp_display_get_next_bridge(struct msm_dp *dp)
>   {
>   	int rc;
>   	struct dp_display_private *dp_priv;
> -	struct device_node *aux_bus;
> -	struct device *dev;
>   
>   	dp_priv = container_of(dp, struct dp_display_private, dp_display);
> -	dev = &dp_priv->pdev->dev;
> -	aux_bus = of_get_child_by_name(dev->of_node, "aux-bus");
> -
> -	if (aux_bus && dp->is_edp) {
> -		/*
> -		 * The code below assumes that the panel will finish probing
> -		 * by the time devm_of_dp_aux_populate_ep_devices() returns.
> -		 * This isn't a great assumption since it will fail if the
> -		 * panel driver is probed asynchronously but is the best we
> -		 * can do without a bigger driver reorganization.
> -		 */
> -		rc = of_dp_aux_populate_bus(dp_priv->aux, NULL);
> -		of_node_put(aux_bus);
> -		if (rc)
> -			goto error;
> -	} else if (dp->is_edp) {
> -		DRM_ERROR("eDP aux_bus not found\n");
> -		return -ENODEV;
> -	}
>   
>   	/*
>   	 * External bridges are mandatory for eDP interfaces: one has to
> @@ -1423,17 +1420,9 @@ static int dp_display_get_next_bridge(struct msm_dp *dp)
>   	if (!dp->is_edp && rc == -ENODEV)
>   		return 0;
>   
> -	if (!rc) {
> +	if (!rc)
>   		dp->next_bridge = dp_priv->parser->next_bridge;
> -		return 0;
> -	}
>   
> -error:
> -	if (dp->is_edp) {
> -		of_dp_aux_depopulate_bus(dp_priv->aux);
> -		dp_display_host_phy_exit(dp_priv);
> -		dp_display_host_deinit(dp_priv);
> -	}
>   	return rc;
>   }
>   

-- 
With best wishes
Dmitry

