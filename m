Return-Path: <linux-kernel+bounces-17134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C07C8248C0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 20:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDD3EB212F4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 19:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3355C2C193;
	Thu,  4 Jan 2024 19:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VBp8jDrF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E981B2C18C
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 19:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-50e80d40a41so996507e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 11:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704395573; x=1705000373; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=04Sj92+QLWqEQ6y2Wbd70hX6tL6uLlbH/Urgy/yOj4k=;
        b=VBp8jDrFkqzX5/kscWpep8v25Oi6831bBl+MxbIByHBZMifWUZDrrscrUOUoqf4jWZ
         9L7WguU80AHzYnrDGy4qEkGjpRMvp/r1O/VoIqXGPbwpcpcejA8fzljn55viFIoX7swA
         62iaZLxxx3S9tCgsxYk2NaCy6fWmaAXczb1bwSHW+gx8iO9cyayXEvyrgKlAbHOzXDUG
         ZZS0IcB+L2GOGCrgQ/RkaY5pUsRO160zWY7t4eoOS0gkJQoH7vWU1JK0xHTFqCDPkUNT
         /0s/ZVKHKCN6RWnQZvlJlj+M2vUUfBAr1Nab77ZntZtCJEeUEtheZMDGmd2rgy48RoZC
         NPdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704395573; x=1705000373;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=04Sj92+QLWqEQ6y2Wbd70hX6tL6uLlbH/Urgy/yOj4k=;
        b=gS4pG2vv4NkxREOwbC755kFaq+fzgZ+ja2ktP8ocdRIujUGo5IiPW1nK87FR4Bd1q5
         PXq86jz54xXf6t55FoQIL/zJpPcIi+K4kUI5mQpemcqS1uhP8snZNIHQ8dbKSUyL2jME
         JxqZLmmezHsgycfuw4UIbUNDIArRIY7Bd7OR+2RDshcVhfmdRXPn9JUhUJlJyUU5ouwT
         ljMEZN3wLmOBYYazfsQaNGYJ+ZbkxZuBLLGNUXbF+Zoe2ycq2VebZBvXyRPiVOWSSDug
         4TeAETGjAcQcAZF2mvVOrLQ7w28HzGq3ZAcNjapAD758PMN4EyqVmNX2jVrlLjNku+nO
         7bIg==
X-Gm-Message-State: AOJu0YyRn6hcPCCtN0JAjV7q+3EB9+FBuWa7HZlTR6uJTall7IaX4bTD
	/P3gzwIeNEBAHqdTqwfEvG8AnPqYxO0B7A==
X-Google-Smtp-Source: AGHT+IGhYsG+HQD4oALPgtDqlROhyrgVD1QlXnV8T4qjomqRtAxBfF7MsbhciIOKImhEgYZaEHJelA==
X-Received: by 2002:a05:6512:3c84:b0:50e:8983:8743 with SMTP id h4-20020a0565123c8400b0050e89838743mr734425lfv.87.1704395572914;
        Thu, 04 Jan 2024 11:12:52 -0800 (PST)
Received: from linaro.org ([79.115.23.25])
        by smtp.gmail.com with ESMTPSA id zr16-20020a170907711000b00a26af4d96c6sm13068108ejb.4.2024.01.04.11.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 11:12:52 -0800 (PST)
Date: Thu, 4 Jan 2024 21:12:51 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] phy: qualcomm: eusb2-repeater: Fix the regfields for
 multiple instances
Message-ID: <ZZcDM1CU3e1XfS/B@linaro.org>
References: <20240104-phy-qcom-eusb2-repeater-fixes-v1-0-047b7b6b8333@linaro.org>
 <20240104-phy-qcom-eusb2-repeater-fixes-v1-1-047b7b6b8333@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104-phy-qcom-eusb2-repeater-fixes-v1-1-047b7b6b8333@linaro.org>

On 24-01-04 16:52:11, Abel Vesa wrote:
> The global regmap fields offsets currently get incremented with the base
> address of the repeater. This issue doesn't get noticed unless the probe
> defers or there are multiple repeaters on that platform. So instead of
> incrementing the global ones, copy them for each instance of the
> repeater.
> 
> Fixes: 4ba2e52718c0 ("phy: qualcomm: phy-qcom-eusb2-repeater: Use regmap_fields")
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c b/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c
> index a623f092b11f..5f5862a68b73 100644
> --- a/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c
> +++ b/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c
> @@ -101,6 +101,7 @@ struct eusb2_repeater {
>  	struct regmap_field *regs[F_NUM_FIELDS];
>  	struct phy *phy;
>  	struct regulator_bulk_data *vregs;
> +	struct reg_field *regfields;
>  	const struct eusb2_repeater_cfg *cfg;
>  	enum phy_mode mode;
>  };
> @@ -140,8 +141,8 @@ static int eusb2_repeater_init_vregs(struct eusb2_repeater *rptr)
>  
>  static int eusb2_repeater_init(struct phy *phy)
>  {
> -	struct reg_field *regfields = eusb2_repeater_tune_reg_fields;
>  	struct eusb2_repeater *rptr = phy_get_drvdata(phy);
> +	struct reg_field *regfields = rptr->regfields;

Oups, this is not needed. Will drop after I get some more comments on
this.

>  	struct device_node *np = rptr->dev->of_node;
>  	u32 init_tbl[F_NUM_TUNE_FIELDS] = { 0 };
>  	u8 override;
> @@ -262,15 +263,21 @@ static int eusb2_repeater_probe(struct platform_device *pdev)
>  	if (!regmap)
>  		return -ENODEV;
>  
> +	rptr->regfields = devm_kmemdup(dev, eusb2_repeater_tune_reg_fields,
> +				       sizeof(eusb2_repeater_tune_reg_fields),
> +				       GFP_KERNEL);
> +	if (!rptr->regfields)
> +		return -ENOMEM;
> +
>  	ret = of_property_read_u32(np, "reg", &res);
>  	if (ret < 0)
>  		return ret;
>  
>  	for (i = 0; i < F_NUM_FIELDS; i++)
> -		eusb2_repeater_tune_reg_fields[i].reg += res;
> +		rptr->regfields[i].reg += res;
>  
>  	ret = devm_regmap_field_bulk_alloc(dev, regmap, rptr->regs,
> -					   eusb2_repeater_tune_reg_fields,
> +					   rptr->regfields,
>  					   F_NUM_FIELDS);
>  	if (ret)
>  		return ret;
> 
> -- 
> 2.34.1
> 

