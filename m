Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0F479E6F0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 13:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240306AbjIMLgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 07:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238945AbjIMLgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 07:36:45 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11AE9173E
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 04:36:41 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-31c73c21113so6313938f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 04:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694604999; x=1695209799; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k7yF/0QjDLbvhSG9tY7YzfHnYU4U2fXlGE3GLuAl8Lk=;
        b=kwzCFwuRHnC/EEpFivzmbKd0+Y2Zb3nvGdyLA91QH8ZLuoP0fPQmpo60X4UzUptK/4
         grFZU41GG7CBn0TIKImzrV5N/SzLKeDV3uejyRtQOInYB03y3MMl1BCNkZ1MBmrFbVfM
         3wW5QaOENwdzoAgbqG91/eD77myx0qCNOFWFdBR+yGoC06z0VtDZQAtQEpGEPYNYY+js
         nYhoQBYJOm0P3oJYSdGOR/C943vSDBzE/JGpdH13VwczKo1f71YxYTWcmRRTmEFUR7Q1
         sGWjXAR5GIuc9KgMyKJYrsv1Xn7uhOiPrQ+rd16jXuOIPjjTUDyMi9SiT/XM/Jd2sDbd
         arWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694604999; x=1695209799;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k7yF/0QjDLbvhSG9tY7YzfHnYU4U2fXlGE3GLuAl8Lk=;
        b=COehfoDQAO5k9Yp/xtfF3LuaW60kH/pZoMsw8mdZ7OcPgG2BqDP+6e47u6g1YQ6PJ6
         T78AevfmuFzt260MXOqyHIz3bUnIi6lTnaJtgvzRrGu2GDcI0cEbaRDx314LKMRwsDgz
         w0uKQWNor9LqxfW7VHLmDP81WcE+SSWBF5qiRtv6651E3vBghb9m0qojR7HRmjXP+lWN
         VgWGTR/KwnUfUaxBFdwgXE6ZflTh8b3x2UGNl0p+Bwypp68PSqDdrYoyUjdBX7aFBO0W
         lVjdq1io3BlZBpjjkZbVwEBf/yLjwTKoMCU05Khh2izvDgbm+Hl3TvcNCHDf1zfIHTes
         sN1Q==
X-Gm-Message-State: AOJu0YyEdO4TDx67h15IpQXoKkDzIbGetCicQnlsfH2umdriVvCBBQPC
        7+G2J/l8OgP6OeBmo6qrzEpqFdM1PJwRTbTV5tw=
X-Google-Smtp-Source: AGHT+IHinq1u6ZWZxDJndTwA0su6ZxNjrWV5Z0ekma4hngYGIrOJOQjkUM9eTx0RpHhT3Rgf/4JSkA==
X-Received: by 2002:adf:f809:0:b0:317:7448:6613 with SMTP id s9-20020adff809000000b0031774486613mr1693950wrp.55.1694604999465;
        Wed, 13 Sep 2023 04:36:39 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id e14-20020adfa44e000000b0031c5d74ecd8sm8610826wra.84.2023.09.13.04.36.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 04:36:38 -0700 (PDT)
Message-ID: <8b4ee62e-ec6a-6a7d-aac7-0746c8cd17a3@linaro.org>
Date:   Wed, 13 Sep 2023 13:36:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v6 4/4] remoteproc: k3-m4: Add a remoteproc driver for M4F
 subsystem
Content-Language: en-US
To:     Hari Nagalla <hnagalla@ti.com>, andersson@kernel.org,
        mathieu.poirier@linaro.org, p.zabel@pengutronix.de,
        martyn.welch@collabora.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
References: <20230913111644.29889-1-hnagalla@ti.com>
 <20230913111644.29889-5-hnagalla@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230913111644.29889-5-hnagalla@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/09/2023 13:16, Hari Nagalla wrote:
> From: Martyn Welch <martyn.welch@collabora.com>
> 
> The AM62x and AM64x SoCs of the TI K3 family has a Cortex M4F core in
> the MCU domain. This core is typically used for safety applications in a
> stand alone mode. However, some application (non safety related) may
> want to use the M4F core as a generic remote processor with IPC to the
> host processor. The M4F core has internal IRAM and DRAM memories and are
> exposed to the system bus for code and data loading.
> 


>  drivers/remoteproc/Kconfig               |  13 +
>  drivers/remoteproc/Makefile              |   1 +
>  drivers/remoteproc/ti_k3_m4_remoteproc.c | 331 +++++++++++++++++++++++
>  3 files changed, 345 insertions(+)
>  create mode 100644 drivers/remoteproc/ti_k3_m4_remoteproc.c
> 
> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> index 48845dc8fa85..85c1a3a2b987 100644
> --- a/drivers/remoteproc/Kconfig
> +++ b/drivers/remoteproc/Kconfig
> @@ -339,6 +339,19 @@ config TI_K3_DSP_REMOTEPROC
>  	  It's safe to say N here if you're not interested in utilizing
>  	  the DSP slave processors.
>  
> +config TI_K3_M4_REMOTEPROC
> +	tristate "TI K3 M4 remoteproc support"
> +	depends on ARCH_K3


Missing compile testing.

...

> +
> +static int k3_m4_rproc_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	const struct k3_rproc_dev_data *data;
> +	struct k3_rproc *kproc;
> +	struct rproc *rproc;
> +	const char *fw_name;
> +	bool r_state = false;
> +	bool p_state = false;
> +	int ret = 0;
> +	int ret1;
> +
> +	data = of_device_get_match_data(dev);
> +	if (!data)
> +		return -ENODEV;
> +
> +	ret = rproc_of_parse_firmware(dev, 0, &fw_name);
> +	if (ret) {
> +		dev_err(dev, "failed to parse firmware-name property, ret = %d\n",
> +			ret);
> +		return ret;

Nope, the syntax is dev_err_probe().

> +	}
> +
> +	rproc = rproc_alloc(dev, dev_name(dev), &k3_m4_rproc_ops, fw_name,
> +			    sizeof(*kproc));
> +	if (!rproc)
> +		return -ENOMEM;
> +
> +	rproc->has_iommu = false;
> +	rproc->recovery_disabled = true;
> +	if (data->uses_lreset) {
> +		rproc->ops->prepare = k3_rproc_prepare;
> +		rproc->ops->unprepare = k3_rproc_unprepare;
> +	}
> +	kproc = rproc->priv;
> +	kproc->rproc = rproc;
> +	kproc->dev = dev;
> +	kproc->data = data;
> +
> +	kproc->ti_sci = ti_sci_get_by_phandle(np, "ti,sci");
> +	if (IS_ERR(kproc->ti_sci)) {
> +		ret = PTR_ERR(kproc->ti_sci);
> +		if (ret != -EPROBE_DEFER) {

No, really, do not open-code existing code.

> +			dev_err(dev, "failed to get ti-sci handle, ret = %d\n",
> +				ret);
> +		}
> +		kproc->ti_sci = NULL;
> +		goto free_rproc;
> +	}
> +
> +	ret = of_property_read_u32(np, "ti,sci-dev-id", &kproc->ti_sci_id);
> +	if (ret) {
> +		dev_err(dev, "missing 'ti,sci-dev-id' property\n");
> +		goto put_sci;
> +	}
> +
> +	kproc->reset = devm_reset_control_get_exclusive(dev, NULL);
> +	if (IS_ERR(kproc->reset)) {
> +		ret = PTR_ERR(kproc->reset);
> +		dev_err(dev, "failed to get reset, status = %d\n", ret);

Syntax is return dev_err_probe. And everywhere else as well...


Best regards,
Krzysztof

