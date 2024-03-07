Return-Path: <linux-kernel+bounces-95089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D984874921
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 08:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9586286307
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 07:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3AF6312F;
	Thu,  7 Mar 2024 07:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HBIAHMwx"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7434D6311B
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 07:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709798083; cv=none; b=lQjGaXxzxgJlHrLpCA0aLfHDR1yfABDfqcj+EyJ90C9IIDL5FcDFoL1+VeE9lRVeaX8mC0G6MtoXoKAM4Q5qa1uBH2vnOoi86wcQMNa90yL/7jlqq0DZszoeKW5uSiowqhY2e22Hc5gsJ5jh6T884tZhey7FQ4ot1QguUv05ES4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709798083; c=relaxed/simple;
	bh=WVvKgTLfvQMB6s8QTW/ib7vjwYL2GH5Jgp+ZD0KntvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jRrnvcvKTVJqs3b+eAdBRFv+ez204ayaZiyaOcR2kt4zHY4yabamjIdrYwjyT1FlaRxNyxeywGPdH2/F1FKjIriCmDpyjY7FX+cOKARuek8zd5+XQ6X1bAsyetfOV+SPjqPWZEs5P6Vmr8WLiD+Y0ST/BEkYtnxn8IzlCkMQAPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HBIAHMwx; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d3b93e992aso6656131fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 23:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709798079; x=1710402879; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QZVyaPXyxnHBzkGori0wDj7gYVC/KSQjx0nG8XqxD4E=;
        b=HBIAHMwxZT5IlpI6fNzTBHJJBuskQrLfMpfY/r1jMkEsnVdhByIPyojiJ/hqndxs8v
         OHHfKeUqb0yc8rfpklNKSNMUHu3daW3pYQF4ekDfGnX2i2Xbk2Eqfk/8R/L1QkY0lg8n
         LxdIr/JTlYlsNHaQRTZ55Ft23aQrkNbvsICMJJ4XKrGljfFtUkDwmMZ2yvA8zgITrP3K
         XCASA3jrOiknWoy6daW3UxkuISMcyiu/zmJ+E0XYbJGBGdLDmtdYriODL09NAAh5lmF8
         LK2JnBKfgFxSyKIiQBXvrYvjDiZLjdhxpEBHrZttjQjLypUakcVFebhwnqBJvdri0gko
         g4Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709798079; x=1710402879;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QZVyaPXyxnHBzkGori0wDj7gYVC/KSQjx0nG8XqxD4E=;
        b=ehskkAjNQz2PsTIG42A5td/D6WPTEMqZJdKhoGACrM2cyPZ8FisKWg7Blzr8QSDA97
         SEJX4Ac3AAWsyHJ8PUjr2LsD0wVMYHKu2CILPMIY5KNsM3zKOZkuvKLKN1DmDa2jLLTo
         5tos76t/8gH70/upOqilMnzU3xjkgjYBl49Kw0KA0PK7gvJvDKmmOk666Pqhq1n0FssX
         yAF5HjTHyGAPINrApsHOcHCL3673/VSBJwaOBlnkvZUKR1tY4H/XD7CuzQOgrCiwIpf9
         xawZ5+ssLIlKMCMKy2J6QkZwwDrAXcn0yRl0SAt5tu5IVepfenLfaicEM8yxvj6Uf4Fn
         bIWw==
X-Forwarded-Encrypted: i=1; AJvYcCVA64nuzWVzBZN5Zy24lY2GrUB2P8p2n/GyZeanZKqbulf55um95tVe7frmrcVaTrv/xomI+pO7rm8rs2UQeKtf9TfX9tIa9pmo/Rt1
X-Gm-Message-State: AOJu0YyIdoA4G35PUG6OEg6Nt9ZimZB9r8OnWEwqsHoF5XlgWWarY5uN
	5xFOZS95PDC8xcszKcSNxoWtA7j/ZpKnAEnWl4RxPB+6eN8rmS4KbWG4nmqVS3I=
X-Google-Smtp-Source: AGHT+IFYAtHoH3EvWp9UvtGiuO64dinos9YEOO4NqcHFCHvNVnn0L16EUzIG8BcdVZlYCa5w9RYoGg==
X-Received: by 2002:a05:651c:a05:b0:2d3:f4f1:ad7f with SMTP id k5-20020a05651c0a0500b002d3f4f1ad7fmr1145761ljq.33.1709798079657;
        Wed, 06 Mar 2024 23:54:39 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id ew5-20020a056402538500b005667a11b951sm7746135edb.86.2024.03.06.23.54.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 23:54:39 -0800 (PST)
Message-ID: <298784cc-819c-4372-94a8-bb7a2978ab16@linaro.org>
Date: Thu, 7 Mar 2024 08:54:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: sm8150: add reset name for ethernet
 node
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
Cc: Sumit Garg <sumit.garg@linaro.org>, Bjorn Andersson
 <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240306200910.2732835-1-volodymyr_babchuk@epam.com>
 <CAA8EJppNopEF0DmgjCAJyxe8HRebD26Q8heKKLKbPstdfBOv6A@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAA8EJppNopEF0DmgjCAJyxe8HRebD26Q8heKKLKbPstdfBOv6A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/03/2024 08:10, Dmitry Baryshkov wrote:
> On Thu, 7 Mar 2024 at 00:22, Volodymyr Babchuk
> <Volodymyr_Babchuk@epam.com> wrote:
>>
>> Add reset-names property to the ethernet@20000 node. This patch does
>> not change behavior on Linux, but it is needed for U-Boot, as it tries
>> to find the reset by name, not by index.
>>
>> Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
>> ---
>>  arch/arm64/boot/dts/qcom/sm8150.dtsi | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
>> index 761a6757dc26f..c2e65d6a2ac62 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
>> @@ -951,6 +951,7 @@ ethernet: ethernet@20000 {
>>
>>                         power-domains = <&gcc EMAC_GDSC>;
>>                         resets = <&gcc GCC_EMAC_BCR>;
>> +                       resets-names = "emac";
> 
> According to the snps,dwmac.yaml schema the "emac" is invalid here.
> Only "stmmaceth" and / or "ahb" are permitted here.

If only there was a tool which can tell this, without the need to
involve reviewers...

Best regards,
Krzysztof


