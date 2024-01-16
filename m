Return-Path: <linux-kernel+bounces-27387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4430D82EF23
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 13:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2A271F244E7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 12:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19781BC3E;
	Tue, 16 Jan 2024 12:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bNYZs5c8"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751D41BC25
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 12:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-50ea9daac4cso10059226e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 04:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705408940; x=1706013740; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+EKrm2JO+zcDUrpvnESCba76qUcUIJTz/jyzkgv6D5k=;
        b=bNYZs5c85GVuDZlN/D67ZdQvXxNkpQqgl1diz8rdzKa7aTm6lELLTY7vTB6IVHEdnN
         lgC0GPnU7jfSE6mUXjS3HHp6+pVyNORvcaSSkXY16iIw1GUChTyeRZuhqWENCb9LCH2/
         z/gygFduGiohc6cHh1KIPikVLwtuzjTVHCzCb10Fa+mtQ6qDmFG1Ovt7mIyqATTzturS
         RjdzRFzPD5KafdZLJOVfZi2G4Myg5TC7oHVR0/3AQWwVFJuuOOvK4fLpvtAMiTvVY1Az
         AngX9Ho1CqFjvGWHRkTgxNFvZ+JbVlUq7w7PiKL3+ar9LWEVSv3Od6H6H+xL/1VKq84E
         cW3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705408940; x=1706013740;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+EKrm2JO+zcDUrpvnESCba76qUcUIJTz/jyzkgv6D5k=;
        b=E1iAdEGai28qNwo66A1wlqmxJEqH6ZEMhow7y3pBebNfah/hZQHgizh8zWAHbKATKe
         9tdt0EESXHoEZzEyM6ffNnDywqrfvKpNV5UEnHuW4JsXgCixamOcavWaKzvrxb0+cagN
         X3Mb6khkyaLQp+zLUWg9ZPqiVR8YNmhCfNiWTbmSQchXV99KRX1A4u6E6lPZwqMTunZC
         GmNWXO2udZS0fCR13L09FXkc3roGGDcGuPPg4SPia7F7eGovhdsoX06Md96ucBpbk04q
         ngpUUQqkM06pFVEtZqxw5/9S1bLVLzuRdViIOvdpvO915ORuxgQSZJSBYYWPfeXfEGQc
         m5BQ==
X-Gm-Message-State: AOJu0YzDFyeNMNEaY51y/Dv2MjgUuMXUu72+lS/EuNJHmvJ1AF4Es51z
	0qb4zXiPsSDaPh/+GpRg0u2UCo1cnLEX2Peyew+ZGEtGrBc=
X-Google-Smtp-Source: AGHT+IFlNMNId0iaZItO0V8VSaiL7I1mJzSPu7gjYOhbLEcWbsUx5dyGejHJionR3QYOqAif9med+Q==
X-Received: by 2002:a05:6512:3987:b0:50e:e1e6:e1c8 with SMTP id j7-20020a056512398700b0050ee1e6e1c8mr3978085lfu.35.1705408940482;
        Tue, 16 Jan 2024 04:42:20 -0800 (PST)
Received: from [172.30.204.234] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id h12-20020a0565123c8c00b0050e87c5b837sm1742064lfv.263.2024.01.16.04.42.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jan 2024 04:42:20 -0800 (PST)
Message-ID: <efadbf5d-bec9-4127-8928-ea0def4326fc@linaro.org>
Date: Tue, 16 Jan 2024 13:42:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] media: qcom: camss: Add sc8280xp resources
Content-Language: en-US
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Hans Verkuil <hverkuil-cisco@xs4all.nl>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Robert Foss <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240111-linux-next-24-01-09-sc8280xp-camss-changes-v1-0-b92a650121ba@linaro.org>
 <20240111-linux-next-24-01-09-sc8280xp-camss-changes-v1-3-b92a650121ba@linaro.org>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240111-linux-next-24-01-09-sc8280xp-camss-changes-v1-3-b92a650121ba@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/11/24 20:57, Bryan O'Donoghue wrote:
> This commit describes the hardware layout for the sc8280xp for the
> following hardware blocks:
> 
> - 4 x VFE, 4 RDI per VFE
> - 4 x VFE Lite, 4 RDI per VFE
> - 4 x CSID
> - 4 x CSID Lite
> - 4 x CSI PHY
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> 
> ---

[...]

> +static const struct camss_subdev_resources csiphy_res_sc8280xp[] = {
> +	/* CSIPHY0 */

Are there any cases where a platform has PHYs with different
capabilities? Might be another nice thing to clean up in the
future..

[...]

> +
> +static const struct camss_subdev_resources vfe_res_sc8280xp[] = {
> +	/* IFE0 */
> +	{
> +		.regulators = {},
> +		.clock = { "gcc_axi_hf", "gcc_axi_sf", "cpas_ahb", "camnoc_axi", "vfe0", "vfe0_axi" },

VFE->IFE?

> +		.clock_rate = { { 0 },
> +				{ 0 },
> +				{ 19200000, 80000000},

Missing space

Also, the source of this clock has shared_ops, which means it's
parked to XO on disable.. Is the first frequency here useful?

> +				{ 19200000, 150000000, 266666667, 320000000, 400000000, 480000000 },

Similar story here

> +				{ 400000000, 558000000, 637000000, 760000000 },

And you (perhaps correctly) omitted 19.2MHz here

Same story for all other IFE/_LITEs in this patch

> +
> +static const struct resources_icc icc_res_sc8280xp[] = {
> +	{
> +		.name = "cam_ahb",
> +		.icc_bw_tbl.avg = 150000,
> +		.icc_bw_tbl.peak = 300000,
> +	},
> +	{
> +		.name = "cam_hf_mnoc",
> +		.icc_bw_tbl.avg = 2097152,
> +		.icc_bw_tbl.peak = 2097152,
> +	},
> +	{
> +		.name = "cam_sf_mnoc",
> +		.icc_bw_tbl.avg = 2097152,
> +		.icc_bw_tbl.peak = 2097152,
> +	},
> +	{
> +		.name = "cam_sf_icp_mnoc",
> +		.icc_bw_tbl.avg = 2097152,
> +		.icc_bw_tbl.peak = 2097152,

Mbps_to_icc()?


>   static const struct of_device_id camss_dt_match[] = {
>   	{ .compatible = "qcom,msm8916-camss", .data = &msm8916_resources },
>   	{ .compatible = "qcom,msm8996-camss", .data = &msm8996_resources },
>   	{ .compatible = "qcom,sdm660-camss", .data = &sdm660_resources },
>   	{ .compatible = "qcom,sdm845-camss", .data = &sdm845_resources },
>   	{ .compatible = "qcom,sm8250-camss", .data = &sm8250_resources },
> +	{ .compatible = "qcom,sc8280xp-camss", .data = &sc8280xp_resources },
"sc" < "sd"

Konrad

