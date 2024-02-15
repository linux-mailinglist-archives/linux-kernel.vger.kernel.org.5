Return-Path: <linux-kernel+bounces-66668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9BA855FD3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CA3D285B70
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F29712D76F;
	Thu, 15 Feb 2024 10:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YkP2KpTe"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D643133416
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 10:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707993376; cv=none; b=XlSF46CTTor6hA4OaY32ZDxKtZQu1uTMCJsZ42QJzZ8XssrUw4MpNPm7aHxbekRu+vPZJXmjDWYgVv+rzD5MqMlSwrn7s7Np479kvil69zvmXv+YqzH8upc782Ke+NB7bFQ+rK7vh9dEdTjNbcLMLZZC1hKEGCPAqIHI/fM25k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707993376; c=relaxed/simple;
	bh=11oYkl9ZkxYy7KWSDC4IMM2JkbglL8sRs6RXiYwDyAQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o+PTq8mhqR+lxNENmMMlNYWjtqHm+Z+B+1D4mfBPOClud69Wwt9aH5SOTodWZyEpPptlyWHdDtza1X5wYpe9tWMlo1Puuh4eDGCxB/LhW0AlEoJDAA8G+WMExGmBRZF+FUR92XrXU7e5MqPhOqda9Og9aNGiotM98XzXdK3/m7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YkP2KpTe; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a3d6d160529so85738566b.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 02:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707993372; x=1708598172; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=STa2oLZBFBMUPR8Jzc0nI7GOTVmKblKkt7T7A8BOCxc=;
        b=YkP2KpTeSS2t3kekRipAncjBcFLrYTimDo3CmUg6jd1RQqvlryfI93HosAWboofIQC
         dtDVsbef0YjPqlZSsugtllNuM8pjmoSCwbHCkRw5Zvg0Dmr69EQRpYEewySPWJt4htDi
         dKuyPQZMtkPpCrJs5ajxgoX2tk4aIOW59NVvIhz8BhBTWhjF4B7+asH5KELBWD99JTff
         98a4FXL5EzAQU0oxBRGOwWFc+LHfbn34wNNsvV2SGnZ5GfFHmKH4lc92lV6jqayXQkzA
         AjxkcdslrJ0Yh1lNqnc6eP7po7rlyn1cw4gQG+avWZ5BGGjg3yHox8wa9Zi41rJzSgnd
         dJiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707993372; x=1708598172;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=STa2oLZBFBMUPR8Jzc0nI7GOTVmKblKkt7T7A8BOCxc=;
        b=Y8AatbLaid/4lUZ9HHWrKav38rwpfe8hR0eo+9G2xHc1QW4xkmpQin0lyrsQsb0Vpc
         F2pE4zGWWEFt61/D0+8ol+lejvg4eMGO08Z1XeSgdpIkXN8L2VKNlkL3mj3k9KP1+TNi
         b4DMZ6vHDLWcM76cJT58SYxIiIFit7u1HzBXY5dnG7JZoA9Mbg4CBQRdLDMUwd8SLGGO
         fmTYxUTwP4AQsdT3axTtUNvnv571JofutgiaB3jWJYGqI7Zv0FPB8QP6nmkkAdc/G583
         S5ejy1VQq3K+CIzEvqC9rD7GoXmdj9NcdxAjNjUzcClP8eED1ecS0E6QxqtSSKDUMiwB
         fQCw==
X-Forwarded-Encrypted: i=1; AJvYcCWtQWpCBF34FIlsobvgmntFM5/4aHK/ltZbYC4WQAJm1bYn3Te8ZZui7ig8IFZlWDu9WNfVk/ONYfbFPxbymNe0MT6VrWtCcHySX/zj
X-Gm-Message-State: AOJu0YxNkmdDMNb6PximDoTEHv0MOArk6g6+ZrX6ZMvb0E95AiVoPgZA
	wcjN6ouIFRzfBzlLpacbQqpNoMdZK2LE8lsnmls9Xgb3d+nHIYy/ZJCq4zEQMfw=
X-Google-Smtp-Source: AGHT+IH9ipuKJXciacYhkuCO6cSAEbNFjzPJ0N4bPDVYrWpn1P9JnTeL2DZeFALfWkY+jzFZnmJ7RA==
X-Received: by 2002:a17:906:fa94:b0:a3c:a15c:407d with SMTP id lt20-20020a170906fa9400b00a3ca15c407dmr1078337ejb.72.1707993372446;
        Thu, 15 Feb 2024 02:36:12 -0800 (PST)
Received: from [192.168.192.135] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id oq25-20020a170906cc9900b00a3cd41b3c19sm400567ejb.199.2024.02.15.02.36.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 02:36:12 -0800 (PST)
Message-ID: <5f6e505b-78c7-4bb3-ba57-fb7601c80a10@linaro.org>
Date: Thu, 15 Feb 2024 11:36:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] phy: qcom: edp: Add set_mode op for configuring
 eDP/DP submode
Content-Language: en-US
To: Abel Vesa <abel.vesa@linaro.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I
 <kishon@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Johan Hovold <johan@kernel.org>,
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
References: <20240129-x1e80100-phy-edp-compatible-refactor-v3-0-e71f3359c535@linaro.org>
 <20240129-x1e80100-phy-edp-compatible-refactor-v3-2-e71f3359c535@linaro.org>
 <CAA8EJpr5Ci7M92ibsCMec3wcQTVqFkaVgRQUhKUSdhg66YhW1Q@mail.gmail.com>
 <Zbdcao0emQyBodCK@linaro.org>
 <CAA8EJppkEksTL90KLcaw0adg73K=ngoYp8semB_u5YFk6rChhA@mail.gmail.com>
 <Zc3o32p1i0GtmmQj@linaro.org>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <Zc3o32p1i0GtmmQj@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15.02.2024 11:35, Abel Vesa wrote:
> On 24-01-29 11:40:24, Dmitry Baryshkov wrote:
>> On Mon, 29 Jan 2024 at 10:06, Abel Vesa <abel.vesa@linaro.org> wrote:
>>>
>>> On 24-01-29 06:05:09, Dmitry Baryshkov wrote:
>>>> On Mon, 29 Jan 2024 at 02:26, Abel Vesa <abel.vesa@linaro.org> wrote:
>>>>>
>>>>> Future platforms should not use different compatibles to differentiate
>>>>> between eDP and DP mode. Instead, they should use a single compatible as the
>>>>> IP block is the same. It will be the job of the controller to set the submode
>>>>> of the PHY accordingly.
>>>>>
>>>>> The existing platforms will remain with separate compatibles for each mode.
>>>>>
>>>>> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
>>>>> ---
>>>>>  drivers/phy/qualcomm/phy-qcom-edp.c | 71 ++++++++++++++++++++++++++-----------
>>>>>  1 file changed, 51 insertions(+), 20 deletions(-)
>>>>>
>>>>> diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
>>>>> index 8e5078304646..af941d6c5588 100644
>>>>> --- a/drivers/phy/qualcomm/phy-qcom-edp.c
>>>>> +++ b/drivers/phy/qualcomm/phy-qcom-edp.c
>>>>> @@ -14,6 +14,7 @@
>>>>>  #include <linux/module.h>
>>>>>  #include <linux/of.h>
>>>>>  #include <linux/phy/phy.h>
>>>>> +#include <linux/phy/phy-dp.h>
>>>>>  #include <linux/platform_device.h>
>>>>>  #include <linux/regulator/consumer.h>
>>>>>  #include <linux/reset.h>
>>>>> @@ -68,19 +69,21 @@
>>>>>
>>>>>  #define TXn_TRAN_DRVR_EMP_EN                    0x0078
>>>>>
>>>>> -struct qcom_edp_cfg {
>>>>> -       bool is_dp;
>>>>> -
>>>>> -       /* DP PHY swing and pre_emphasis tables */
>>>>> +struct qcom_edp_swing_pre_emph_cfg {
>>>>>         const u8 (*swing_hbr_rbr)[4][4];
>>>>>         const u8 (*swing_hbr3_hbr2)[4][4];
>>>>>         const u8 (*pre_emphasis_hbr_rbr)[4][4];
>>>>>         const u8 (*pre_emphasis_hbr3_hbr2)[4][4];
>>>>>  };
>>>>>
>>>>> +struct qcom_edp_phy_cfg {
>>>>> +       bool is_edp;
>>>>> +       const struct qcom_edp_swing_pre_emph_cfg *swing_pre_emph_cfg;
>>>>> +};
>>>>> +
>>>>>  struct qcom_edp {
>>>>>         struct device *dev;
>>>>> -       const struct qcom_edp_cfg *cfg;
>>>>> +       const struct qcom_edp_phy_cfg *cfg;
>>>>>
>>>>>         struct phy *phy;
>>>>>
>>>>> @@ -96,6 +99,8 @@ struct qcom_edp {
>>>>>
>>>>>         struct clk_bulk_data clks[2];
>>>>>         struct regulator_bulk_data supplies[2];
>>>>> +
>>>>> +       bool is_edp;
>>>>>  };
>>>>>
>>>>>  static const u8 dp_swing_hbr_rbr[4][4] = {
>>>>> @@ -126,8 +131,7 @@ static const u8 dp_pre_emp_hbr2_hbr3[4][4] = {
>>>>>         { 0x04, 0xff, 0xff, 0xff }
>>>>>  };
>>>>>
>>>>> -static const struct qcom_edp_cfg dp_phy_cfg = {
>>>>> -       .is_dp = true,
>>>>> +static const struct qcom_edp_swing_pre_emph_cfg dp_phy_swing_pre_emph_cfg = {
>>>>>         .swing_hbr_rbr = &dp_swing_hbr_rbr,
>>>>>         .swing_hbr3_hbr2 = &dp_swing_hbr2_hbr3,
>>>>>         .pre_emphasis_hbr_rbr = &dp_pre_emp_hbr_rbr,
>>>>> @@ -162,18 +166,28 @@ static const u8 edp_pre_emp_hbr2_hbr3[4][4] = {
>>>>>         { 0x00, 0xff, 0xff, 0xff }
>>>>>  };
>>>>>
>>>>> -static const struct qcom_edp_cfg edp_phy_cfg = {
>>>>> -       .is_dp = false,
>>>>> +static const struct qcom_edp_swing_pre_emph_cfg edp_phy_swing_pre_emph_cfg = {
>>>>>         .swing_hbr_rbr = &edp_swing_hbr_rbr,
>>>>>         .swing_hbr3_hbr2 = &edp_swing_hbr2_hbr3,
>>>>>         .pre_emphasis_hbr_rbr = &edp_pre_emp_hbr_rbr,
>>>>>         .pre_emphasis_hbr3_hbr2 = &edp_pre_emp_hbr2_hbr3,
>>>>>  };
>>>>>
>>>>> +static const struct qcom_edp_phy_cfg sc7280_dp_phy_cfg = {
>>>>> +};
>>>>> +
>>>>> +static const struct qcom_edp_phy_cfg sc8280xp_dp_phy_cfg = {
>>>>> +       .swing_pre_emph_cfg = &dp_phy_swing_pre_emph_cfg,
>>>>> +};
>>>>> +
>>>>> +static const struct qcom_edp_phy_cfg sc8280xp_edp_phy_cfg = {
>>>>> +       .is_edp = true,
>>>>> +       .swing_pre_emph_cfg = &edp_phy_swing_pre_emph_cfg,
>>>>> +};
>>>>> +
>>>>>  static int qcom_edp_phy_init(struct phy *phy)
>>>>>  {
>>>>>         struct qcom_edp *edp = phy_get_drvdata(phy);
>>>>> -       const struct qcom_edp_cfg *cfg = edp->cfg;
>>>>>         int ret;
>>>>>         u8 cfg8;
>>>>>
>>>>> @@ -200,7 +214,7 @@ static int qcom_edp_phy_init(struct phy *phy)
>>>>>                DP_PHY_PD_CTL_PLL_PWRDN | DP_PHY_PD_CTL_DP_CLAMP_EN,
>>>>>                edp->edp + DP_PHY_PD_CTL);
>>>>>
>>>>> -       if (cfg && cfg->is_dp)
>>>>> +       if (edp->cfg->swing_pre_emph_cfg && !edp->is_edp)
>>>>
>>>> I think (!edp->is_edp) should be enough here.
>>>
>>> Actually, in case of DP, the cfg8 needs to be 0xb7 for sc8280xp, while for sc7280 it should be 0x37.
>>>
>>> So to differentiate between first and second we check if the config
>>> provides a swing_pre_emph_cfg
>>
>> Using swing_pre_emph_cfg to distinguish between those two cases is a pure hack.
>> Is there any sensible meaning behind those bits? If not, just put
>> those values into the configuration data.
> 
> So the only thing that I was able to find is that this reg has to do
> with some TX and RX zero bits preamble. It seems it needs to be
> different between DP configurations (with or without swing and pre-emph).
> 
> But leaving that aside, unless we add another knob that actually depends
> on swing and pre-emph configuration being available, there is no other
> way around it, for now, at least.

Until we know better, I'd say this hack is fine, but please leave a comment
so that we don't fully forget about it.

Konrad

