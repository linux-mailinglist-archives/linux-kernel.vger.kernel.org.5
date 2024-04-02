Return-Path: <linux-kernel+bounces-128172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D1989572A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79F101C20B77
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829921332A1;
	Tue,  2 Apr 2024 14:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k1C+h3+n"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47AC1327ED
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 14:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712068779; cv=none; b=UOG3Vj0lpGGjSbviK/iszlfe5Ln5wrpEoeV/yOaC2mRJEsUAu2y0AZV3dGXtoXChiZhivEg2WsBgwyTrsj0wu24mlyUnWu5inL816MHQ4L82rx0D5auFflfygqequAXLpfkBr0WbNPqCNxkwxChc9s27v6o0xXWvw84K3HjTxkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712068779; c=relaxed/simple;
	bh=KEPz0wlA1n71vRk5wZJSdjHxhvsG5VCy6LFeTD914sM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tMNiuxCqwa4nCYXQYp0fTw5AWFo+4QLxC3nJZyvRxnjd2dZG+EkqxtRAL7Jhy5SQY2/uFknfxE4wzK2MIydluJIZEelVcg4frAbBkxONr97iI7TMjn8Uieut5B3tnCHBFzmpHReokr/6Lu/OIZerkZQhtmQ6/58CCW0Y+B/e120=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k1C+h3+n; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-516ab4b3251so1880260e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 07:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712068776; x=1712673576; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VmmeyJ8WE2Ux58JopJdYKyaf2Mo4BEQrjCIyQrTk66c=;
        b=k1C+h3+nJDcXQyQq31BlWN3HkmQjxcsN35Gt6OFuavJamvSDLru7x+shBNgNUe6Ted
         Q3zh6D9I6BnJTSGfRtWijEl0+vlXpjkY8cKYgdhVTQCmP7wHNb3Sq0ceAWO6V/QxfPwS
         RsGjDJu/6Rgg0illqUjwTGMJMZFIdG+v4PvWmOme4eHkGFrGhnqC4NzEat4Hpcm1EZrl
         StESqocTiDrojR+LQQrbtuUVEsbuh1+xMhRT8YH1ZLjFYZz2Yri2pR3MgsTioqpqxIAA
         Cwq39/1V9ddkbBT9rFT1DLmJqjOWwvu4+dXwz45msqZKnb9Z5nOu8mt8zXuHInb4mFnq
         HdHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712068776; x=1712673576;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VmmeyJ8WE2Ux58JopJdYKyaf2Mo4BEQrjCIyQrTk66c=;
        b=JPDNAODfgo0MytUh5//lvzesC7fXo5GqR/I/HXkMKuOO7IP/iFNCbun7uqzLdCKPMN
         F3pdtidwlpfcgqzn29EKScSfHhis1QiSEgRlhBj4W/FqZPj0f9pr27kOl+PR0L5zTg2c
         BZuugxz1Vyl9tliz60qf9ONGCrGIs0TaUmVpYhMSoi2VIn6ZMMTgzmJDtY8XQA5pZWuz
         ES1lMuooGH6jIkVFChjBrIlC0Ry0fSF+sb/nqYEdW2yQudxvdiIlD4IERKT+2b0OOi8l
         EyL6De2C7zQRwmYhy2dPbPwyzxpxsgyoCwr+tNXo7clxYNHTHS3Z6QsBfsxSyH7XrAf9
         7kJg==
X-Forwarded-Encrypted: i=1; AJvYcCW5ku3n0fwtShvJuYXu/hhfzdPFmm0LILJRKHRTXBTIZZXZnP04RWNsG0M0dKvfjrT0If1O9HknA07ZLkRHoyewEeYv9VRtsSG90EbQ
X-Gm-Message-State: AOJu0Yx2e3oT8Hft2es8MRaMKuoPsCNlj5RUU8kT02OQoql8ShihvnXE
	NmXwHFmlpRCxq/e8v7gUH3PrHkrKlA/YOBSjZoudPuQP8eg5wNCE8HGSoV4ulBw=
X-Google-Smtp-Source: AGHT+IEgDpAH4/YS4uRuGsxqk3Iib97eJF0+OLcaJAkEC4t9sfMYanmV6vvSLXZodkUjd0ZmN4TtAg==
X-Received: by 2002:a19:4359:0:b0:513:b159:e711 with SMTP id m25-20020a194359000000b00513b159e711mr9786889lfj.4.1712068776046;
        Tue, 02 Apr 2024 07:39:36 -0700 (PDT)
Received: from [192.168.92.47] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id g22-20020a1709063b1600b00a47423b4c33sm6623351ejf.128.2024.04.02.07.39.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 07:39:35 -0700 (PDT)
Message-ID: <1522b186-862b-4439-8050-e5197bcc9faa@linaro.org>
Date: Tue, 2 Apr 2024 16:39:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/9] arm64: dts: qcom: sm8250: add a link between DWC3
 and QMP PHY
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
References: <20240401-typec-fix-sm8250-v3-0-604dce3ad103@linaro.org>
 <20240401-typec-fix-sm8250-v3-4-604dce3ad103@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240401-typec-fix-sm8250-v3-4-604dce3ad103@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1.04.2024 10:33 PM, Dmitry Baryshkov wrote:
> The SuperSpeed signals originate from the DWC3 host controller and then
> are routed through the Combo QMP PHY, where they are multiplexed with
> the DisplayPort signals. Add corresponding OF graph link.
> 
> Reported-by: Luca Weiss <luca.weiss@fairphone.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

