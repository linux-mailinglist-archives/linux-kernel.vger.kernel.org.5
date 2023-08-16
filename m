Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC18E77DE54
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 12:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243803AbjHPKP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 06:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243862AbjHPKPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 06:15:52 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59CCA138
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 03:15:50 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-3180fd48489so5279992f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 03:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692180949; x=1692785749;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wKKgBBisqytUj4cW8xuK5eYALL8492/KSwF6veUAcHE=;
        b=D3OP/V2exGjRUPhNnd7mGYofJlGZYIoAMiTRSkHe1/kbuyqR9SDdop2M/iKTYMBGw9
         3m5tzQFVHeZbGfb7jRLxPjxzcTexkHieMOMxdr/cVXWd0mt+tDY72tmkv+Gh3q8pes96
         vdFuLcFUbeJ97MDzTNFBTKlwAiv8XD4L7FeNsX19BCOYARRBNnIeCZn+0I83EZE3PWgl
         lPZjQFMJzSN4AVizI8LujDhHp1jBlS6OFpibP+wCOBx5RM6f/zDxj9jV9F4hRZ7uPhdu
         zE7tiLqlphc0M3e0GZnQ7rVKDjGqaBbtn3uPztFdOJlZxKamXnYHQ6D1ZStQjNBnoY8O
         KKuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692180949; x=1692785749;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wKKgBBisqytUj4cW8xuK5eYALL8492/KSwF6veUAcHE=;
        b=fMEgYzhVJ5atGtTmMxUlqlZOESSQ0/xwrbunWapfOWY237Mobh05i3gkqStWf0IPav
         frGSKubbFmas3PqGyKP1WNG/d/w1uWOKymzOkNUzXlV4uSXxW3fXOn2yDCZfXJvvoFzH
         SQ/1n+XU5L6D07f4kEwB+CwAaEYobR5xz2S6y1Ltmb1/Xqss5pWlRESmL7Chrd0EUpeh
         moovg5+84XUHVaDUdqPPWpQJQQdbo6kXuMpAGj26AWXI6bUVuT+8odt8zI883bG0FBmo
         O1zNhnEunyAwVb3zQLPmuK2Ls3wf/warlMPAI3ZchZReZw/fBYvmSYmhzu61u4t/xAtY
         yP0g==
X-Gm-Message-State: AOJu0YyAb9yISFXMOoXjlKva5dqze51TAXRuw3VNdc5Jn8PF2qEAspzH
        rvYUjY9KkNefd4N3fGTO07CWgA==
X-Google-Smtp-Source: AGHT+IGuxahEpScu0GulwO2zvI7Rhyna98xQswwF5RjaDjtX792Tt4gc3qCKw7lITa7rBCJG1GKeKQ==
X-Received: by 2002:adf:e68a:0:b0:319:75e0:c49 with SMTP id r10-20020adfe68a000000b0031975e00c49mr951649wrm.13.1692180948643;
        Wed, 16 Aug 2023 03:15:48 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id e1-20020a5d5941000000b003141f96ed36sm20892952wri.0.2023.08.16.03.15.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 03:15:48 -0700 (PDT)
Message-ID: <8ea8370a-50bd-99e9-064c-66b006aa454b@linaro.org>
Date:   Wed, 16 Aug 2023 12:15:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/3] thermal: k3_j72xx_bandgap: Add cooling device support
Content-Language: en-US
To:     Apurva Nandan <a-nandan@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rafael J Wysocki <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Udit Kumar <u-kumar1@ti.com>, Keerthy J <j-keerthy@ti.com>
References: <20230809173905.1844132-1-a-nandan@ti.com>
 <20230809173905.1844132-2-a-nandan@ti.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230809173905.1844132-2-a-nandan@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08/2023 19:39, Apurva Nandan wrote:
> From: Keerthy <j-keerthy@ti.com>
> 
> Add cpufreq as a cooling device, based on the inputs from the thermal
> sensors.

I don't understand these changes.

By using the DT, it is all done automatically, no ?

> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> ---
>   drivers/thermal/k3_j72xx_bandgap.c | 121 +++++++++++++++++++++++++++++
>   1 file changed, 121 insertions(+)
> 
> diff --git a/drivers/thermal/k3_j72xx_bandgap.c b/drivers/thermal/k3_j72xx_bandgap.c
> index a5a0fc9b9356..c844cb527761 100644
> --- a/drivers/thermal/k3_j72xx_bandgap.c
> +++ b/drivers/thermal/k3_j72xx_bandgap.c
> @@ -19,6 +19,9 @@
>   #include <linux/of.h>
>   #include <linux/delay.h>
>   #include <linux/slab.h>
> +#include <linux/cpufreq.h>
> +#include <linux/cpumask.h>
> +#include <linux/cpu_cooling.h>
>   
>   #define K3_VTM_DEVINFO_PWR0_OFFSET		0x4
>   #define K3_VTM_DEVINFO_PWR0_TEMPSENS_CT_MASK	0xf0
> @@ -183,10 +186,28 @@ struct k3_j72xx_bandgap {
>   /* common data structures */
>   struct k3_thermal_data {
>   	struct k3_j72xx_bandgap *bgp;
> +	struct cpufreq_policy *policy;
> +	struct thermal_zone_device *ti_thermal;
> +	struct thermal_cooling_device *cool_dev;
> +	struct work_struct thermal_wq;
>   	u32 ctrl_offset;
>   	u32 stat_offset;
> +	enum thermal_device_mode mode;
> +	int prev_temp;
> +	int sensor_id;
>   };
>   
> +static void k3_thermal_work(struct work_struct *work)
> +{
> +	struct k3_thermal_data *data = container_of(work,
> +					struct k3_thermal_data, thermal_wq);
> +
> +	thermal_zone_device_update(data->ti_thermal, THERMAL_EVENT_UNSPECIFIED);
> +
> +	dev_info(&data->ti_thermal->device, "updated thermal zone %s\n",
> +		 data->ti_thermal->type);
> +}
> +
>   static int two_cmp(int tmp, int mask)
>   {
>   	tmp = ~(tmp);
> @@ -251,8 +272,40 @@ static int k3_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
>   	return k3_bgp_read_temp(thermal_zone_device_priv(tz), temp);
>   }
>   
> +static int k3_thermal_get_trend(struct thermal_zone_device *tz, int trip, enum thermal_trend *trend)
> +{
> +	struct k3_thermal_data *data = tz->devdata;
> +	struct k3_j72xx_bandgap *bgp;
> +	u32 temp1, temp2;
> +	int tr, ret = 0;
> +
> +	bgp = data->bgp;
> +
> +	ret = k3_thermal_get_temp(tz, &temp1);
> +	if (ret)
> +		return ret;
> +	temp2 = data->prev_temp;
> +
> +	tr = temp1 - temp2;
> +
> +	data->prev_temp = temp1;
> +
> +	if (tr > 0)
> +		*trend = THERMAL_TREND_RAISING;
> +	else if (tr < 0)
> +		*trend = THERMAL_TREND_DROPPING;
> +	else
> +		*trend = THERMAL_TREND_STABLE;
> +
> +	dev_dbg(bgp->dev, "The temperatures are t1 = %d and t2 = %d and trend =%d\n",
> +		temp1, temp2, *trend);
> +
> +	return ret;
> +}
> +
>   static const struct thermal_zone_device_ops k3_of_thermal_ops = {
>   	.get_temp = k3_thermal_get_temp,
> +	.get_trend = k3_thermal_get_trend,
>   };
>   
>   static int k3_j72xx_bandgap_temp_to_adc_code(int temp)
> @@ -342,6 +395,63 @@ struct k3_j72xx_bandgap_data {
>   	const bool has_errata_i2128;
>   };
>   
> +static int k3_thermal_register_cpu_cooling(struct k3_j72xx_bandgap *bgp, int id)
> +{
> +	struct k3_thermal_data *data;
> +	struct device_node *np = bgp->dev->of_node;
> +
> +	/*
> +	 * We are assuming here that if one deploys the zone
> +	 * using DT, then it must be aware that the cooling device
> +	 * loading has to happen via cpufreq driver.
> +	 */
> +	if (of_find_property(np, "#thermal-sensor-cells", NULL))
> +		return 0;
> +
> +	data = bgp->ts_data[id];
> +	if (!data)
> +		return -EINVAL;
> +
> +	data->policy = cpufreq_cpu_get(0);
> +	if (!data->policy) {
> +		pr_debug("%s: CPUFreq policy not found\n", __func__);
> +		return -EPROBE_DEFER;
> +	}
> +
> +	/* Register cooling device */
> +	data->cool_dev = cpufreq_cooling_register(data->policy);
> +	if (IS_ERR(data->cool_dev)) {
> +		int ret = PTR_ERR(data->cool_dev);
> +
> +		dev_err(bgp->dev, "Failed to register cpu cooling device %d\n",
> +			ret);
> +		cpufreq_cpu_put(data->policy);
> +
> +		return ret;
> +	}
> +
> +	data->mode = THERMAL_DEVICE_ENABLED;
> +
> +	INIT_WORK(&data->thermal_wq, k3_thermal_work);
> +
> +	return 0;
> +}
> +
> +static int k3_thermal_unregister_cpu_cooling(struct k3_j72xx_bandgap *bgp, int id)
> +{
> +	struct k3_thermal_data *data;
> +
> +	data = bgp->ts_data[id];
> +
> +	if (!IS_ERR_OR_NULL(data)) {
> +		cpufreq_cooling_unregister(data->cool_dev);
> +		if (data->policy)
> +			cpufreq_cpu_put(data->policy);
> +	}
> +
> +	return 0;
> +}
> +
>   static int k3_j72xx_bandgap_probe(struct platform_device *pdev)
>   {
>   	int ret = 0, cnt, val, id;
> @@ -452,6 +562,7 @@ static int k3_j72xx_bandgap_probe(struct platform_device *pdev)
>   	/* Register the thermal sensors */
>   	for (id = 0; id < cnt; id++) {
>   		data[id].bgp = bgp;
> +		data[id].sensor_id = id;
>   		data[id].ctrl_offset = K3_VTM_TMPSENS0_CTRL_OFFSET + id * 0x20;
>   		data[id].stat_offset = data[id].ctrl_offset +
>   					K3_VTM_TMPSENS_STAT_OFFSET;
> @@ -477,6 +588,12 @@ static int k3_j72xx_bandgap_probe(struct platform_device *pdev)
>   		writel(val, data[id].bgp->cfg2_base + data[id].ctrl_offset);
>   
>   		bgp->ts_data[id] = &data[id];
> +
> +		if (id == 1)
> +			ret = k3_thermal_register_cpu_cooling(bgp, 1);
> +		if (ret)
> +			goto err_alloc;
> +
>   		ti_thermal = devm_thermal_of_zone_register(bgp->dev, id, &data[id],
>   							   &k3_of_thermal_ops);
>   		if (IS_ERR(ti_thermal)) {
> @@ -514,6 +631,7 @@ static int k3_j72xx_bandgap_probe(struct platform_device *pdev)
>   	return 0;
>   
>   err_free_ref_table:
> +	k3_thermal_unregister_cpu_cooling(bgp, 1);
>   	kfree(ref_table);
>   
>   err_alloc:
> @@ -525,6 +643,9 @@ static int k3_j72xx_bandgap_probe(struct platform_device *pdev)
>   
>   static int k3_j72xx_bandgap_remove(struct platform_device *pdev)
>   {
> +	struct k3_j72xx_bandgap *bgp = platform_get_drvdata(pdev);
> +
> +	k3_thermal_unregister_cpu_cooling(bgp, 1);
>   	pm_runtime_put_sync(&pdev->dev);
>   	pm_runtime_disable(&pdev->dev);
>   

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

