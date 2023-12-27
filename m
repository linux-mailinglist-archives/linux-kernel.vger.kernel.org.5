Return-Path: <linux-kernel+bounces-11995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E223C81EEA4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 12:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58D06B22396
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 11:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0BD1446BB;
	Wed, 27 Dec 2023 11:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P+s7m0QV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C154E446AC
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 11:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-50e7dd8bce8so1785082e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 03:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703677688; x=1704282488; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UWgo0Nu/8bGQ9XPxNxU+NjxOsPf0CklHHmO+hsalEdc=;
        b=P+s7m0QVrkraiajpxH0YMzR0egaKBzVcb9dujPV/8NC54ul60fv5AJ3Y6/etpDon3W
         wUnO47AGnSym1GjjWCNTjmHwjybw68mR0K+39ecv8XzHcn7J+PK6KHfKRCLhhXV5KEDM
         KV5qFNA/VCdo0RhjfFYNxFbpLHMA0wZ2ccdE21yxQcs3MWy4+wrBjATgAISBL1PJ4Q96
         nziaHmWuRNjCL1TfwQctprLmRDHREtUpmM+jxLJo61BUk535pHU+6ThiFLNTXmUqoyv7
         n1WGJhXtEIyAHhrAsLT3drThdh1yMJK5iZaCEYyZa2LKLvWhXQMR7kOTkObm921Deqng
         DzPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703677688; x=1704282488;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UWgo0Nu/8bGQ9XPxNxU+NjxOsPf0CklHHmO+hsalEdc=;
        b=eNuhWnYTCSkfSWiFWfn4HP4gYw1LYV4lI9djbuR1hIaLeqJt+hPmutUrVvG1ID7rRh
         e7ndBVsbHvhVQhUuxZ+gwu7LqPiUw50lHtRUlaHV89bERTp7eM6YcF/wENME9H+IIh5d
         puovkj8mmVNxBVqkkniaxfbRvpfVAELBZ3zcmvEDroHTOjEACNuW2FUs+rDBR2Is+Hmn
         SH9L1M6L+DSzXjyMaBsxljYpTDNx8yBOYlp9ZYV/uqTEiRiL02W+7mKarumoNbaY7r2+
         p3dYsO6crcAqQLuIrMtz9rRpxWy+D+5N1ArG/0FczcNnD+NA8RX1hQzryOcJ9sgX9mNE
         gVpA==
X-Gm-Message-State: AOJu0YwhVDmQceug9GjfDI7IRac7Qqvw6fjQxEJIVYx4mXkRBXUka+Yi
	tY5kG3NXtOce4K/gQj6pfDGgCzeMN8+tXA==
X-Google-Smtp-Source: AGHT+IExhAzXrwAipulv5QIKsguVKmEN9CNh9lndgg4Ie4v/xheFiX4142BGx+/QU/OXi0hR6k8Ejw==
X-Received: by 2002:a05:6512:2805:b0:50e:7f5c:521d with SMTP id cf5-20020a056512280500b0050e7f5c521dmr1565155lfb.104.1703677687545;
        Wed, 27 Dec 2023 03:48:07 -0800 (PST)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id n3-20020a056512388300b0050e6d797536sm1464060lft.230.2023.12.27.03.48.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Dec 2023 03:48:07 -0800 (PST)
Message-ID: <ae1c1cb6-00f9-41ce-afd1-d557fbf3034f@linaro.org>
Date: Wed, 27 Dec 2023 13:48:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] regulator: qcom_smd: Keep one rpm handle for all vregs
Content-Language: en-GB
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231227-topic-rpm_vreg_cleanup-v1-1-949da0864ac5@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20231227-topic-rpm_vreg_cleanup-v1-1-949da0864ac5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/12/2023 03:29, Konrad Dybcio wrote:
> For no apparent reason (as there's just one RPM per SoC), all vregs
> currently store a copy of a pointer to smd_rpm. Introduce a single,
> global one to save up on space in each definition.
> 
> bloat-o-meter reports:
> 
> Total: Before=43944, After=43924, chg -0.05%
> 
> plus sizeof(ptr) on every dynamically allocated regulator :)
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   drivers/regulator/qcom_smd-regulator.c | 18 +++++++-----------
>   1 file changed, 7 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/regulator/qcom_smd-regulator.c b/drivers/regulator/qcom_smd-regulator.c
> index d1be9568025e..905c15df8c85 100644
> --- a/drivers/regulator/qcom_smd-regulator.c
> +++ b/drivers/regulator/qcom_smd-regulator.c
> @@ -11,11 +11,10 @@
>   #include <linux/regulator/of_regulator.h>
>   #include <linux/soc/qcom/smd-rpm.h>
>   
> +struct qcom_smd_rpm *smd_vreg_rpm;
> +
>   struct qcom_rpm_reg {
>   	struct device *dev;
> -
> -	struct qcom_smd_rpm *rpm;
> -
>   	u32 type;
>   	u32 id;
>   
> @@ -70,7 +69,7 @@ static int rpm_reg_write_active(struct qcom_rpm_reg *vreg)
>   	if (!reqlen)
>   		return 0;
>   
> -	ret = qcom_rpm_smd_write(vreg->rpm, QCOM_SMD_RPM_ACTIVE_STATE,
> +	ret = qcom_rpm_smd_write(smd_vreg_rpm, QCOM_SMD_RPM_ACTIVE_STATE,
>   				 vreg->type, vreg->id,
>   				 req, sizeof(req[0]) * reqlen);
>   	if (!ret) {
> @@ -1391,7 +1390,7 @@ MODULE_DEVICE_TABLE(of, rpm_of_match);
>    * Return: 0 on success, errno on failure
>    */
>   static int rpm_regulator_init_vreg(struct qcom_rpm_reg *vreg, struct device *dev,
> -				   struct device_node *node, struct qcom_smd_rpm *rpm,
> +				   struct device_node *node,
>   				   const struct rpm_regulator_data *pmic_rpm_data)
>   {
>   	struct regulator_config config = {};
> @@ -1409,7 +1408,6 @@ static int rpm_regulator_init_vreg(struct qcom_rpm_reg *vreg, struct device *dev
>   	}
>   
>   	vreg->dev	= dev;
> -	vreg->rpm	= rpm;
>   	vreg->type	= rpm_data->type;
>   	vreg->id	= rpm_data->id;
>   
> @@ -1440,11 +1438,10 @@ static int rpm_reg_probe(struct platform_device *pdev)
>   	const struct rpm_regulator_data *vreg_data;
>   	struct device_node *node;
>   	struct qcom_rpm_reg *vreg;
> -	struct qcom_smd_rpm *rpm;
>   	int ret;
>   
> -	rpm = dev_get_drvdata(pdev->dev.parent);
> -	if (!rpm) {
> +	smd_vreg_rpm = dev_get_drvdata(pdev->dev.parent);
> +	if (!smd_vreg_rpm) {

I thought about having a mutex around (I don't remember if secondary 
PMICs and/or chargers can be routed through RPM or not).

Then I went on checking other RPM and SMD-RPM drivers.

clk-rpm: global variable, field
clk-smd-rpm: struct field
regulator_qcom-smd-rpm: struct field

Probably it's worth using the same approach in all four drivers?

>   		dev_err(&pdev->dev, "Unable to retrieve handle to rpm\n");
>   		return -ENODEV;
>   	}
> @@ -1460,8 +1457,7 @@ static int rpm_reg_probe(struct platform_device *pdev)
>   			return -ENOMEM;
>   		}
>   
> -		ret = rpm_regulator_init_vreg(vreg, dev, node, rpm, vreg_data);
> -
> +		ret = rpm_regulator_init_vreg(vreg, dev, node, vreg_data);
>   		if (ret < 0) {
>   			of_node_put(node);
>   			return ret;
> 
> ---
> base-commit: 39676dfe52331dba909c617f213fdb21015c8d10
> change-id: 20231227-topic-rpm_vreg_cleanup-fa095cd528ec
> 
> Best regards,

-- 
With best wishes
Dmitry


