Return-Path: <linux-kernel+bounces-933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB67814837
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 13:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FB651C227D6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20B62C68E;
	Fri, 15 Dec 2023 12:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sKRRPT+e"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56A72DB7B
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 12:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40c317723a8so6991305e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 04:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702643885; x=1703248685; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BsXmPIAmJl60XYRsMDSLfbrKydUJT24PwhIFCDJUrBM=;
        b=sKRRPT+ebjBOmZ8vzfuyi8AjPStVXjOHsM3CkR8AFc4Tet5py47NCGi6qZYyZIog3C
         cmdQKtTLKiPJpx6/Er6IItlVAIWDn6zS9oTb5sNV9zfTCTFn6fuJ06l/KPGXw2FIPfOD
         8BVsJgOHr13cknpKnXAXuG9rYnNBwudKjtptYaitsxgoyd+FQhOfDp5pX5k6WjuY+bmD
         IuNnHE1B4g8ng4ed+HpvForAKQ/lrbG32l8hyFjVPfGs20V9w5Nz2GxAIAlEsh/IWGAa
         1mq8NWnbSlYw3z86MT3fP1dHmhiXsnahsq8y4moW7hByFyBmhruTbu8JvynXOvFFfTHW
         lTiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702643885; x=1703248685;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BsXmPIAmJl60XYRsMDSLfbrKydUJT24PwhIFCDJUrBM=;
        b=MnUbGDlYbvF2qa2RuDGFY+NTp8dZ07OQ2jWWicDtiy6MsXKnudLsuFsqkJlaJEMZaH
         y2Nls2aeZZNE0PtiXsJjtVPumEjHl7j/3W1Q905ga3ECQJKXsk7ZTxZpYVg7fFLvASqV
         BOT3SoCnp01zs8mc37H9ukquK+gdpgQOtPiPJvFTSeofwZCISxWddQfX+1EDasJ8ruRG
         EwbQtyx4g5bVSTdE6Y5MT4R4uy6/qwzAAnNhs75f3iazUHztYzTKork+7X/hnVLyqXu8
         0pQJFLg3WgXVZVlGOnV2+tWd4UcDGhULi1LWW1LmE3v0Xqni0CiFlYXGuaSPDTogf0eD
         AW+A==
X-Gm-Message-State: AOJu0YyBSzc/gHV6GDw5q+Ns9N+66lz92WPTgQ9XxrcCacRYk0TZA0sF
	OVEjk0JFKc2wDvBF8oRtyI3sew==
X-Google-Smtp-Source: AGHT+IHBxBMgBiBWpwXzUIkpbdwQ+qcVVdthMh7pL80QCiPqI0Z2+8i9M1xYjMIM103e8Rksoud9LA==
X-Received: by 2002:a05:600c:2804:b0:40c:3eab:d987 with SMTP id m4-20020a05600c280400b0040c3eabd987mr5514403wmb.125.1702643884813;
        Fri, 15 Dec 2023 04:38:04 -0800 (PST)
Received: from [192.168.100.102] ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id g10-20020a05600c4eca00b0040c11fbe581sm28680591wmq.27.2023.12.15.04.38.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Dec 2023 04:38:04 -0800 (PST)
Message-ID: <bf4abdf4-a61c-422c-8042-69a53e62dff4@linaro.org>
Date: Fri, 15 Dec 2023 12:38:03 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/10] clk: qcom: Add camcc clock driver for x1e80100
Content-Language: en-US
To: Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 Rajendra Nayak <quic_rjendra@quicinc.com>
References: <20231214-x1e80100-clock-controllers-v2-0-2b0739bebd27@linaro.org>
 <20231214-x1e80100-clock-controllers-v2-10-2b0739bebd27@linaro.org>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20231214-x1e80100-clock-controllers-v2-10-2b0739bebd27@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/12/2023 16:49, Abel Vesa wrote:
> From: Rajendra Nayak <quic_rjendra@quicinc.com>
> 
> Add the camcc clock driver for x1e80100
> 
> Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>


> ---
		.name = "cam_cc-x1e80100",

This is some very akward naming here.

"camcc-x1e80100"

Same comment with the defines not "CAM_CC_THING" just "CAMCC_THING"

With those two nits fixed.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Tested-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>


> +		.of_match_table = cam_cc_x1e80100_match_table,
> +	},
> +};
> +
> +module_platform_driver(cam_cc_x1e80100_driver);
> +
> +MODULE_DESCRIPTION("QTI CAM_CC x1e80100 Driver");

Again with the "CAM_CC" this should be -> "QTI Camera Clock Controller"

---
bod

