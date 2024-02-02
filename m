Return-Path: <linux-kernel+bounces-49955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69BAD8471FD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 15:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD3D9B239C0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 14:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0320418E11;
	Fri,  2 Feb 2024 14:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MwS/uEMt"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E0218036
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 14:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706884454; cv=none; b=m0RfZfu/agfqpsdIAS3YEw2OPCaCRtcOe9ysGtXGQWwfpidxoL5mBgwtTDDHpsGR+JDyRDiZmu68QMLRF5kXvCSyZwh7QTAzrLg6XTKr6bToXsSUrpyGqL7NYYi24Mnvs9HlkfkGeGf+fqAuJxLARzRD+5Jp+BnOvQm8OTy/jKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706884454; c=relaxed/simple;
	bh=smELjAc+1lxu7z3cmyggWXvk5TEfu9w8DqoHbL7V/Sk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U7dU/n1iYKZs4B49zbcYcLP+t3P3F4BBHprzfaOsHv+t+wokqeXteD79skAg93Ii6qxZMulimUThorb82c57P/15HDwpItrM8eX5orP4pFPPnkUL5HmIU8b284QBCxiz9F42Wib9NT1GfI+BPvpQjSmHg+YbaWnnGOSpubmtdaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MwS/uEMt; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a30f7c9574eso309932466b.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 06:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706884450; x=1707489250; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cZAWF8WNyPIOZBGCeXYXz44JlQLAqQAUYrdryEsZijM=;
        b=MwS/uEMtCSoLHwpqkQOTzsj6AsPwpt/XIWi5Dd74ab4LRsI0F0+SK5RSAJ7pPWzlqh
         N1Bo9oQkupjUM8KJ5AlhYxuXN0cm2QuHlF6coOIS2l0o7RPqxqSIfY+H35RTBkv2GAv4
         YP1huzY5SYenBtmttpsY83UsqG31k9CMFQGkcWCURIP3tg6t9/WsW1HpbTt8B4FxL3ZT
         u5H1Bx2K42jz4WJrtgP9fiql4jkvy/eHltv9Y2ob/1xHAGpdOd52rCTQAHei21Iz/q46
         xsJ5/jTDYL8Qd58ekoonMar1eYAL4DOq/LYWQX6gJ/QZqA1TxpAxQu3jLgBdtRDyPo9S
         YGig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706884450; x=1707489250;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cZAWF8WNyPIOZBGCeXYXz44JlQLAqQAUYrdryEsZijM=;
        b=V5UadIwF/Fr0OywwfW9u9ZI3+sfZ5INH3E1NqtB2sQtspPlOrlfQK8jp9RmZM5jeGs
         jm3sCnfe7H1ZQWhR+YRozMnuBlTC4de5RY+6xHiSh+KwJ6Xjn5DncExPm1gvBQqW6OJU
         tVxq8Zdr7it9dhz06lEhjy3JFzjXO0xm2P7BtdR3uaCjNZu/AiO9IJe8HTVc0/sasmU7
         jeOQLkMggordkVjwX8jOMJ53HLlTpAL9c1bh3npLDUYeL02/HbQ0OjpaQtGCPAIQGkP7
         CILUqQbLwr9VBAyy2PwatCSXOeb6/n0J9hDrsWLkud5xC5TWwWmVdzMV0Vy/wYmsMd/I
         7fMg==
X-Gm-Message-State: AOJu0YzKebJjDwexuiv/itsEN5yN//b+sK9IxSnMG2OHCrOJY66P1196
	ogBvLTb7hTe0armKuvEid0LDwaLdoXjkktBD8fJQttCyLnRwmiXDHozcUsYdP7I=
X-Google-Smtp-Source: AGHT+IGXuaTTYhVenIjzovitfKix3bgmDZdzjbESI6N5z4LDL1eDMWWfGVRPtwxUruoQW7Ka5UHeJg==
X-Received: by 2002:a17:906:cecc:b0:a36:5b1c:fb4b with SMTP id si12-20020a170906cecc00b00a365b1cfb4bmr4122804ejb.13.1706884450450;
        Fri, 02 Feb 2024 06:34:10 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXYmZXJ+RWUJegx40QB/r2pp3Jr8YWrATIFHx8G7qlJxkzSeYSDGDVaiaO2LMtiDXSlDXsUH369aGGIoZZ230i8i32jLBLqxiNBvU/w+AM59d1g4tXXOKwLVC377h25Bd2UMiS+O8hGAeJJ/xoee1cGoRXOsV0+3+bwlDXgqzDiLKfmJXdBQLTrKo8ncMarZKm9Wj82GjGcZaSvOMSwLmrRj5PzQWtCoDhtF5C29a4clzXDgYlEN+Kvy4YjYjywXbDQIGRBOaGHdLAJX1ylTKtXvS2FrACm4ztiFKbCXM8ggLNJz++6ymXHC6qMjMMq3ngdtuZF5whtiN076J+cqjINYvjH8jl7hwyhsHp3EQoc+bdiivcA
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id uz12-20020a170907118c00b00a3685526ed6sm922654ejb.183.2024.02.02.06.34.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Feb 2024 06:34:09 -0800 (PST)
Message-ID: <7e7bc8ba-f349-47f5-b6ba-6594edccaaa8@linaro.org>
Date: Fri, 2 Feb 2024 15:34:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/6] dt-bindings: arm: qcom: Document QCM8550, QCS8550
 SoC and board
Content-Language: en-US
To: Tengfei Fan <quic_tengfan@quicinc.com>, andersson@kernel.org,
 konrad.dybcio@linaro.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 dmitry.baryshkov@linaro.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@quicinc.com
References: <20240119100621.11788-1-quic_tengfan@quicinc.com>
 <20240119100621.11788-2-quic_tengfan@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240119100621.11788-2-quic_tengfan@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/01/2024 11:06, Tengfei Fan wrote:
> Document QCM8550, QCS8550 SoC and the AIM300 AIoT board bindings.
> QCS8550 and QCM8550 processor combines powerful computing, extreme edge
> AI processing, Wi-Fi 7, and robust video and graphics for a wide range
> of use cases for the Internet of Things (IoT). QCS8550 is a QCS version
> for QCM8550. Modem RF only in QCM8550 but not in QCS8550.
> AIM300 Series is a highly optimized family of modules designed to
> support AIoT applications. The module is mounted onto Qualcomm AIoT
> carrier board to support verification, evaluation and development. It
> integrates QCS8550 SoC, UFS and PMIC chip etc.
> AIM stands for Artificial Intelligence Module. AIoT stands for AI IoT.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

I want to unreview it.

Please fix your commit msg to drop marketing and instead describe the
SoC. I don't see for example any explanation why there is qcm8550 and
sm8550. Aren't they the same?



Best regards,
Krzysztof


