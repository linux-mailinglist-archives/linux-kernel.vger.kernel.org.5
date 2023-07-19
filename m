Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73CFF758EF3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 09:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjGSH1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 03:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjGSH1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 03:27:01 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC807E43
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 00:26:58 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-992f6d7c7fbso915025566b.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 00:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689751617; x=1692343617;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fyfO5lsrlJXVidyRvvPQwDaGq7oltGO0YP6DN+snoCw=;
        b=AjSciQ9vitluZtJ0iIt94Np5PvkEbxDdQ3s084RB9U5x8sTLF/XnZd6fz5YTdnB/wy
         BkXCzNlUHc8NhKuk1YrOO8m3M0k8mWa1mS9qxzFYW3q8X+hjmR0hThqW4nEe2qbBGyKi
         85IxZGTdgqjziTpBEnlDNcQAA3SP6ujzpGHEPHM3YYj1AqfgkTtJZIH9BXRb0vqCl7BF
         lsxcVQ+Mvnnts0SW+NaPUEKZyGcBzxRysgWNg0rSznkQCIttPbeK5QR8BIF7HQm3eem6
         ynv8mMFF8GtB+dH66Y6gsoK8LbUsbWoSRYYZoCF0SduzqZ5oT9ePb458opbM3gJoIMCQ
         WZWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689751617; x=1692343617;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fyfO5lsrlJXVidyRvvPQwDaGq7oltGO0YP6DN+snoCw=;
        b=gE2qfyLl6aos0/amUGFWquf7wdPpohU8WpwDiagdSUbpx7qW+sPJ6x8XQf5wn2LSGZ
         wPYZNin6u9A/nyXS07mfyrxAj/vk78Fb6uzrPLP17VGEVMFpk7mThcBlcLAcZXmSfYwr
         cdI1QPrDnrJmTseDztCuVjm/6cG2T1Tb670mPfIo8ZymcgRuHznQB68DlUVMFwhSlYr3
         rHYROc6aFYfLHFC8oOMCAxHohCfAvtgkuvxrg/o3zSuqfjKeYUIwKaSro4eWayWFkZpa
         hDm2RrckwIsxsNtJcAlHSovH3/Mm+N+7ftyJW2jBa72EMeAhSjnVHQXfwnK/mhKl/PES
         0+UQ==
X-Gm-Message-State: ABy/qLazgDgLGcM1XABCjtewBarfGyH1v2DuYvauZ8FUXmYsfAjEBTJd
        p4R/lsf56pbQrB4h4rnDxJ9dOQ==
X-Google-Smtp-Source: APBJJlEQENMPwak7uAMJQP5lUd7qaD8836fd2duRgHWK7IwO9mD8HFp/b3gvoraUz2Hfh88Imp/n4g==
X-Received: by 2002:a17:906:5388:b0:98d:cd3e:c193 with SMTP id g8-20020a170906538800b0098dcd3ec193mr1290513ejo.46.1689751617114;
        Wed, 19 Jul 2023 00:26:57 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id k2-20020a170906128200b0098e2eaec394sm1925666ejb.101.2023.07.19.00.26.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 00:26:56 -0700 (PDT)
Message-ID: <fedea75a-a5f1-fbe4-7f12-75bfdf9bfcf2@linaro.org>
Date:   Wed, 19 Jul 2023 09:26:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [V3,09/11] remoteproc: qcom: Add Hexagon based multipd rproc
 driver
Content-Language: en-US
To:     Manikanta Mylavarapu <quic_mmanikan@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mathieu.poirier@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        quic_eberman@quicinc.com, kvalo@kernel.org,
        loic.poulain@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Cc:     quic_srichara@quicinc.com, quic_sjaganat@quicinc.com,
        quic_kathirav@quicinc.com, quic_anusha@quicinc.com
References: <20230718120501.3205661-1-quic_mmanikan@quicinc.com>
 <20230718120501.3205661-10-quic_mmanikan@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230718120501.3205661-10-quic_mmanikan@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/07/2023 14:04, Manikanta Mylavarapu wrote:
> It adds support to bring up remoteproc's on multipd model.
> Pd means protection domain. It's similar to process in Linux.
> Here QDSP6 processor runs each wifi radio functionality on a
> separate process. One process can't access other process
> resources, so this is termed as PD i.e protection domain.
> 
> Here we have two pd's called root and user pd. We can correlate
> Root pd as root and user pd as user in linux. Root pd has more
> privileges than user pd. Root will provide services to user pd.
> 


> +static int q6_get_inbound_irq(struct qcom_q6v5 *q6,
> +			      struct platform_device *pdev,
> +			      const char *int_name,
> +			      int index, int *pirq,
> +			      irqreturn_t (*handler)(int irq, void *data))
> +{
> +	int ret, irq;
> +	char *interrupt, *tmp = (char *)int_name;
> +	struct q6_wcss *wcss = q6->rproc->priv;
> +
> +	irq = platform_get_irq(pdev, index);
> +	if (irq < 0) {
> +		if (irq != -EPROBE_DEFER)
> +			dev_err_probe(&pdev->dev, irq,
> +				      "failed to retrieve %s IRQ: %d\n",
> +				      int_name, irq);

Wait, what? This does not make any sense. dev_err_probe is to replace
all this dance. return dev_err_probe which I explicitly asked last time:

https://lore.kernel.org/all/2061a641-4b97-1aa6-27cd-99f01a785033@linaro.org/

> +		return irq;
> +	}
> +
> +	*pirq = irq;
> +
> +	interrupt = devm_kzalloc(&pdev->dev, BUF_SIZE, GFP_KERNEL);
> +	if (!interrupt)
> +		return -ENOMEM;
> +
> +	snprintf(interrupt, BUF_SIZE, "q6v5_wcss_userpd%d_%s", wcss->pd_asid, tmp);
> +
> +	ret = devm_request_threaded_irq(&pdev->dev, *pirq,
> +					NULL, handler,
> +					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
> +					interrupt, q6);
> +	if (ret) {
> +		dev_err_probe(&pdev->dev, ret,
> +			      "failed to acquire %s irq\n", interrupt);
> +		return ret;
> +	}
> +	return 0;
> +}
> +
> +static int q6_get_outbound_irq(struct qcom_q6v5 *q6,
> +			       struct platform_device *pdev,
> +			       const char *int_name)
> +{
> +	struct qcom_smem_state *tmp_state;
> +	unsigned  bit;
> +
> +	tmp_state = qcom_smem_state_get(&pdev->dev, int_name, &bit);
> +	if (IS_ERR(tmp_state)) {
> +		dev_err_probe(&pdev->dev, IS_ERR(tmp_state),
> +			      "failed to acquire %s state\n", int_name);
> +		return PTR_ERR(tmp_state);

So it is everywhere...


> +	}
> +
> +	if (!strcmp(int_name, "stop")) {
> +		q6->state = tmp_state;
> +		q6->stop_bit = bit;
> +	} else if (!strcmp(int_name, "spawn")) {
> +		q6->spawn_state = tmp_state;
> +		q6->spawn_bit = bit;
> +	}
> +
> +	return 0;
> +}
> +
> +static int init_irq(struct qcom_q6v5 *q6,
> +		    struct platform_device *pdev, struct rproc *rproc,
> +		    int crash_reason, const char *load_state,
> +		    void (*handover)(struct qcom_q6v5 *q6))
> +{
> +	int ret;
> +	struct q6_wcss *wcss = rproc->priv;
> +
> +	q6->rproc = rproc;
> +	q6->dev = &pdev->dev;
> +	q6->crash_reason = crash_reason;
> +	q6->handover = handover;
> +
> +	init_completion(&q6->start_done);
> +	init_completion(&q6->stop_done);
> +	init_completion(&q6->spawn_done);
> +
> +	ret = q6_get_outbound_irq(q6, pdev, "stop");
> +	if (ret)
> +		return ret;
> +
> +	ret = q6_get_outbound_irq(q6, pdev, "spawn");
> +	if (ret)
> +		return ret;
> +
> +	/* Get pd_asid to prepare interrupt names */
> +	wcss->pd_asid = qcom_get_pd_asid(rproc);
> +
> +	ret = q6_get_inbound_irq(q6, pdev, "fatal", 0, &q6->fatal_irq,
> +				 q6v5_fatal_interrupt);
> +	if (ret)
> +		return ret;
> +
> +	ret = q6_get_inbound_irq(q6, pdev, "ready", 1, &q6->ready_irq,
> +				 q6v5_ready_interrupt);
> +	if (ret)
> +		return ret;
> +
> +	ret = q6_get_inbound_irq(q6, pdev, "stop-ack", 3, &q6->stop_irq,
> +				 q6v5_stop_interrupt);
> +	if (ret)
> +		return ret;
> +
> +	ret = q6_get_inbound_irq(q6, pdev, "spawn-ack", 2, &q6->spawn_irq,
> +				 q6v5_spawn_interrupt);
> +	if (ret)
> +		return ret;
> +	return 0;
> +}
> +
> +static void q6_release_resources(struct platform_device *pdev)
> +{
> +	struct rproc *upd_rproc;
> +	struct device_node *upd_np;
> +	struct platform_device *upd_pdev;
> +
> +	/* Release userpd resources */
> +	for_each_available_child_of_node(pdev->dev.of_node, upd_np) {

You should not iterate over OF to get devices to unregister. What if you
have more nodes than before because of overlay?


> +		upd_pdev = of_find_device_by_node(upd_np);
> +		if (!upd_pdev)
> +			continue;
> +
> +		upd_rproc = platform_get_drvdata(upd_pdev);
> +		if (!upd_rproc) {
> +			platform_device_unregister(upd_pdev);
> +			continue;
> +		}
> +
> +		rproc_del(upd_rproc);
> +		rproc_free(upd_rproc);
> +	}
> +}
> +
> +static int q6_register_userpd(struct platform_device *pdev)
> +{
> +	struct q6_wcss *wcss;
> +	struct rproc *rproc = NULL;
> +	int ret;
> +	struct device_node *userpd_np;
> +	struct platform_device *userpd_pdev;
> +	const char *firmware_name = NULL;
> +
> +	for_each_available_child_of_node(pdev->dev.of_node, userpd_np) {
> +		ret = of_property_read_string(userpd_np, "firmware-name",
> +					      &firmware_name);
> +		if (ret < 0)
> +			continue;
> +
> +		dev_info(&pdev->dev, "%s node found\n", userpd_np->name);
> +
> +		userpd_pdev = of_platform_device_create(userpd_np,
> +							userpd_np->name,
> +							&pdev->dev);
> +		if (!userpd_pdev) {
> +			ret = -ENODEV;
> +			dev_err_probe(&pdev->dev, ret,
> +				      "failed to create %s platform device\n",
> +				      userpd_np->name);
> +			goto release_resource;
> +		}
> +		userpd_pdev->dev.driver = pdev->dev.driver;
> +		rproc = rproc_alloc(&userpd_pdev->dev, userpd_pdev->name,
> +				    &wcss_ops, firmware_name,
> +				    sizeof(*wcss));
> +		if (!rproc) {
> +			ret = -ENOMEM;
> +			goto release_resource;
> +		}
> +
> +		wcss = rproc->priv;
> +		wcss->dev = &userpd_pdev->dev;
> +
> +		ret = q6_alloc_memory_region(wcss);
> +		if (ret)

How do you release the resource allocated in rproc_alloc() for this
node? drvdata is not set, so your cleanup function will skip it.

> +			goto release_resource;
> +
> +		ret = init_irq(&wcss->q6, userpd_pdev, rproc,
> +			       WCSS_CRASH_REASON, NULL, NULL);
> +		if (ret)
> +			goto release_resource;
> +
> +		rproc->auto_boot = false;
> +		ret = rproc_add(rproc);
> +		if (ret)
> +			goto release_resource;
> +
> +		platform_set_drvdata(userpd_pdev, rproc);
> +		qcom_add_ssr_subdev(rproc, &wcss->ssr_subdev, userpd_pdev->name);
> +	}
> +	return 0;
> +
> +release_resource:
> +	q6_release_resources(pdev);
> +	return ret;
> +}
> +
> +static int q6_wcss_probe(struct platform_device *pdev)
> +{
> +	const struct wcss_data *desc;
> +	struct q6_wcss *wcss;
> +	struct rproc *rproc;
> +	int ret;
> +	char *subdev_name;
> +	const char **firmware;
> +
> +	desc = of_device_get_match_data(&pdev->dev);
> +	if (!desc)
> +		return -EINVAL;
> +
> +	firmware = devm_kcalloc(&pdev->dev, MAX_FIRMWARE,
> +				sizeof(*firmware), GFP_KERNEL);
> +	if (!firmware)
> +		return -ENOMEM;
> +
> +	ret = of_property_read_string_array(pdev->dev.of_node, "firmware-name",
> +					    firmware, MAX_FIRMWARE);
> +	if (ret < 0)
> +		return ret;
> +
> +	rproc = rproc_alloc(&pdev->dev, pdev->name, desc->ops,
> +			    firmware[0], sizeof(*wcss));
> +	if (!rproc)
> +		return -ENOMEM;
> +
> +	wcss = rproc->priv;
> +	wcss->dev = &pdev->dev;
> +	wcss->desc = desc;
> +	wcss->firmware = firmware;
> +
> +	ret = q6_alloc_memory_region(wcss);
> +	if (ret)
> +		goto free_rproc;
> +
> +	ret = desc->init_irq(&wcss->q6, pdev, rproc,
> +			     desc->crash_reason_smem, NULL, NULL);
> +	if (ret)
> +		goto free_rproc;
> +
> +	if (desc->glink_subdev_required)
> +		qcom_add_glink_subdev(rproc, &wcss->glink_subdev, desc->ssr_name);
> +
> +	subdev_name = (char *)(desc->ssr_name ? desc->ssr_name : pdev->name);

Wrong cast. Why are you dropping const? That's a bug.

> +	qcom_add_ssr_subdev(rproc, &wcss->ssr_subdev, subdev_name);
> +
> +	rproc->auto_boot = false;
> +	ret = rproc_add(rproc);
> +	if (ret)
> +		goto free_rproc;
> +
> +	platform_set_drvdata(pdev, rproc);
> +
> +	ret = q6_register_userpd(pdev);
> +	if (ret) {
> +		dev_err_probe(&pdev->dev, ret, "Failed to register userpd\n");
> +		return ret;

return dev_err_probe

> +	}
> +
> +	return 0;
> +
> +free_rproc:
> +	rproc_free(rproc);
> +
> +	return ret;

Best regards,
Krzysztof

