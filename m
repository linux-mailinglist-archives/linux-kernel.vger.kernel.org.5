Return-Path: <linux-kernel+bounces-148418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A83D8A8248
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8950286CFD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B442E13CF88;
	Wed, 17 Apr 2024 11:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Co17iC6C"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256935680
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 11:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713354185; cv=none; b=oBjO3/lscq02GMbkn2GJP29lEiofuFr6TYQcbXi7JxEXW+bkQ1Go1bEVQ+J9OI25YW0EREqQYOKEl57ghSC2pCwLFFu6+iSrkLsN/fU2OfsQ4meYXzxe4iCLtvleJk/Cc4d4PmqhTElvLUPBlVRXJiwyd8jELCInGCK/gTOh+h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713354185; c=relaxed/simple;
	bh=2j74h0iIytH6PRZNFrTHCHmNEPwJygBB1ndVw5tJ/MQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=etak4/Q8qJY/Wi0R3dF0/aeZRrDnObAJ9XhkcTF+M5X5B3PvBapEQwUUUbNhuWh0a5v5ZQJ2NS3ccjpNr5wBP+UuyRBepSl8cN2rr1Yg649k0rHmKB8WPE55TyOE4xK3KeFd9vrv1Y+42uX8lUBw35seSnFCHPQeKD+G0yXfMX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Co17iC6C; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d715638540so65246791fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 04:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713354180; x=1713958980; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PKy5Kxap6cM6mtyJpA2QMaShqvinZmDMbb6nqhab/os=;
        b=Co17iC6Czo0ZCZF8gIxSGkwXc15HM7JLzXExfHOqvOCpwAjGJKkv1h7ebNrzNLkZ2d
         nqq37E3N1t2rOaPQDMRqeFhuadRMBnknN3AaHCyyNm/YDZTVZQB5NNRlWDIrPsZUTVdI
         ZSvk0ut8za/y3bUVZLd8mwsdcnDHFfsdsyp8LIRCJtbFc1fe2dYK7SMt8rSH+HeXwcta
         QeeZh15UqXNwlY/E4M9pXwyLXrT32w2iyskgZd3wJBLmlM/apaYjDY/wdQrh3MFce3c8
         mzTH/RobFsMXUuIbj3Y6USPynzYvcHLmrnKhgNeQDFzr6HlOsjk3330gHu6wwrOWJowi
         3M0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713354180; x=1713958980;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PKy5Kxap6cM6mtyJpA2QMaShqvinZmDMbb6nqhab/os=;
        b=Wtl9ivVcbfBSurpGczK5eFcGi6uC0ED2QL0m7QKL+/tdWSzI7id4PBoHwk62AtR6ia
         6WYh1UC5prnC6DMcz7HedSbnAXSPpU0DZpW4vREB74APpaNrxOdZqFmUrF8oS/AIDtWZ
         OB9nzd/J3AGafTdEg8IWrjDl2378OLsRkRdX4oafqjEfCRJCj3D6Twyfe4lqduTAi5q9
         uFZx54B/jbHJbkU2HQcrAN8yc4PnoYt5YcMflb1Ov2MDEVKBsd3fPTO9JouHFKTWt8IG
         kjkU9q84qc3aB8IUFYb+88Z6EB6LrkSHKZ8t3wS+DIXBvrOr2WgM93VSo8GpDAAEZ3w1
         WePg==
X-Forwarded-Encrypted: i=1; AJvYcCU4z+4B6c1vECDpeOPRv5at8wUAYZY0wqdDKZpKoK2I3JNSFcDCbdmstuFQpXAX509W92NeJlU8XlaiD02T0pm4Q3PxEZJ8Blvhhhy0
X-Gm-Message-State: AOJu0YwpP7x8FDs704hr9kNjwDXXUtaQxAMm/jw4tMYyy1nHY1gPpjQU
	I2c0Y1V4tyY0eq9lkQZN7EjtGRYbh/BwMgRFy34/s4hUaCcy/wB++5m0MkJI4PeaWrmcDawFRXB
	b
X-Google-Smtp-Source: AGHT+IEhy7phkNh8GPAYWeNKIjEQ2zGqofF6B3DRQvcLUKP1Pajvk5PVp8xJ6WRzpZYatNNIwww+sg==
X-Received: by 2002:a2e:998a:0:b0:2d7:61ac:b392 with SMTP id w10-20020a2e998a000000b002d761acb392mr10489311lji.29.1713354180124;
        Wed, 17 Apr 2024 04:43:00 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id g3-20020a05600c310300b00417bab31bd2sm2619839wmo.26.2024.04.17.04.42.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Apr 2024 04:42:59 -0700 (PDT)
Message-ID: <3b245ae8-31ee-4576-a123-0dc3aba4ce10@linaro.org>
Date: Wed, 17 Apr 2024 12:42:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] soundwire: qcom: disable stop clock on 1.3.0 and
 below
To: Anton Bambura <jenneron@postmarketos.org>, Andy Gross
 <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Vinod Koul <vkoul@kernel.org>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Sanyog Kale <sanyog.r.kale@intel.com>
Cc: linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
References: <20240413064225.39643-1-jenneron@postmarketos.org>
 <20240413064225.39643-2-jenneron@postmarketos.org>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20240413064225.39643-2-jenneron@postmarketos.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 13/04/2024 07:42, Anton Bambura wrote:
> This patch returns back the behavior of disabling stop clock on soundwire
> 1.3.0 and below which seems to have been altered by accident which
> results in broken audio on sdm845 + wcd9340. For example, on AYN Odin and
> Lenovo Yoga C630 devices.
> 
> Fixes: 4830bfa2c812 ("soundwire: qcom: set clk stop need reset flag at runtime")
> Signed-off-by: Anton Bambura <jenneron@postmarketos.org>
> ---
>   drivers/soundwire/qcom.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
> index a1e2d6c98186..bc03484a28e8 100644
> --- a/drivers/soundwire/qcom.c
> +++ b/drivers/soundwire/qcom.c
> @@ -628,6 +628,9 @@ static int qcom_swrm_enumerate(struct sdw_bus *bus)
>   			}
>   		}
>   
> +		if (ctrl->version <= SWRM_VERSION_1_3_0)
> +			ctrl->clock_stop_not_supported = true;
> +

This is not the right fix, this can be determined from codec 
clk_stop_mode1 flag.

can you try this patch:

----------------------------->cut<-----------------------------
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Wed, 17 Apr 2024 12:38:49 +0100
Subject: [PATCH] ASoC: codecs: wsa881x: set clk_stop_mode1 flag

WSA881x codecs do not retain the state while clock is stopped, so mark
this with clk_stop_mode1 flag.

Fixes: a0aab9e1404a ("ASoC: codecs: add wsa881x amplifier support")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
  sound/soc/codecs/wsa881x.c | 1 +
  1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/wsa881x.c b/sound/soc/codecs/wsa881x.c
index 3c025dabaf7a..1253695bebd8 100644
--- a/sound/soc/codecs/wsa881x.c
+++ b/sound/soc/codecs/wsa881x.c
@@ -1155,6 +1155,7 @@ static int wsa881x_probe(struct sdw_slave *pdev,
  	pdev->prop.sink_ports = GENMASK(WSA881X_MAX_SWR_PORTS, 0);
  	pdev->prop.sink_dpn_prop = wsa_sink_dpn_prop;
  	pdev->prop.scp_int1_mask = SDW_SCP_INT1_BUS_CLASH | SDW_SCP_INT1_PARITY;
+	pdev->prop.clk_stop_mode1 = true;
  	gpiod_direction_output(wsa881x->sd_n, !wsa881x->sd_n_val);

  	wsa881x->regmap = devm_regmap_init_sdw(pdev, &wsa881x_regmap_config);
-- 
2.21.0
----------------------------->cut<-----------------------------


thanks,
Srini

>   		if (!found) {
>   			qcom_swrm_set_slave_dev_num(bus, NULL, i);
>   			sdw_slave_add(bus, &id, NULL);

