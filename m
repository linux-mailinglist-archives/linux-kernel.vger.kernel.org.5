Return-Path: <linux-kernel+bounces-94563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 417B9874178
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 21:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7A991F25D14
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 20:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4164E171B0;
	Wed,  6 Mar 2024 20:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LkeX6wk/"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B040C14265;
	Wed,  6 Mar 2024 20:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709757519; cv=none; b=TPoiB5fuZLBAk9NGFRsaDqlk2Mq98Dm28Kpj6+cQdBQsWBTYdo5tS85SFQeIudrMQYo9yPAFrGjxNOJYGf9VwBBWu1abJPES10LBCxlDp3OxF/iW1x0JdEQcJn9SavauviVsjGUYe+I5VZkvaJcDuRq4IXl/z0MLyF6SFCbmhEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709757519; c=relaxed/simple;
	bh=38OEKRfn74KFGnHAvL+jbKr6c1wUSS8VibXaPFS527w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P02WsIiGiDfuvOVxj9ViMX9x6Fr+JC9tQ3RUxRR91PEXBFSwtpwt/jd2WshNSRMWyF5w99SuKGvPESyYQWwEDodeGT1aCjWAhCV51381/0rKcWI/CJeChYsDXzScnWwQBjemXcjW/4oocY8s54lQcQoxZWjGDWTyeJGWkZ0XCTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LkeX6wk/; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a4467d570cdso21116166b.3;
        Wed, 06 Mar 2024 12:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709757516; x=1710362316; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LIHGDnVwjlB3bFV2/OxEZvORXLdLEUbgaLsv0VpkxxU=;
        b=LkeX6wk/f6aNi9zAmcLDXkMh2cBDXyl8LC8s/9bEMBhyd1BBGN8+/V2W67lBMIc0E7
         X/MGYHSqQTtFJXVYNAlVafcPUqIS8A3YCkr7et/BthUimNHsvO0SQiZtkXdavJZbpoT6
         GqyiJ8dMctQuYEViy3R1JAE57HMTLxTLKJ1Hjd0fJv/UdIVIfFwF+uB7j05DdJsoV5Pp
         fWwzxJ72R7N0cNK4h6VNQn4woW63Lz+24zzXHE5LfXSL0DNWpFatzZJ2UPgob9WRzx3Z
         5/sMU3JC+7Dw7hGYEQVP0iA0nKK7MbF7X4n089cOS/Bz8hvHaFlaX93Aj84NyY+zh3al
         O3Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709757516; x=1710362316;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LIHGDnVwjlB3bFV2/OxEZvORXLdLEUbgaLsv0VpkxxU=;
        b=pbp16W1OU7h80Ur0+Cixznauk9yEbAp+wH25yktSaV5YaFcn2XEXl+pmA3CYbjdQkw
         bObk4G2EBbjxoPveBBBQPbgx/0GKCafMAL9h/nAODmyr+EqO9AbnXbUv5Fysa8j/d2ud
         mxgE4f68HpKkQiifF8YeKmFYOqi9/R/8NgeQCr24eY3z5thrxahwXlKy8Dy1mcYrBTOM
         Jpx1qc44v/Jf9I/rzQDGZuTLFWdwkFM71kzsxanjNgcJ1dqNHhz5/TGclSXOfBz20n7r
         V4lrYoOPNhzg8I3a7jmAbEnkzsiZ1JoyCrizJMslMi5//gVGd6veuVMnvbq3XZLd3etb
         Taxg==
X-Forwarded-Encrypted: i=1; AJvYcCUKkBahGj3WyYp12qgNyeHKheCy/6Lw1TtkTh7c1w8YxTSpokP5yJX4Q05G3RxWJHSFztYukHsczQ+Ph0FmXcBCa2PB48wNwmsnRhi4FClbjc0MrKb9ZFeLXn2biwawMTCOiQiPF90BoEv7GA8WgPR3C/N4R67RYTS0ma/6/uukMbxOCf7Dmhs=
X-Gm-Message-State: AOJu0Yz0VEjRH3Glr7A0LSF3Z4VAiaYMVsrwFOfMSI/ZvBuxb2jGF7e0
	ZqAK6xlkMB1aYPk35z5aIRJPik6PJ+EAkQ62ricHsPAU+Po5edcKMsQUi5Aj
X-Google-Smtp-Source: AGHT+IHowL85QhlEdCZSN5hpntFZlCGw82REqCz1KmGif3B+xuNJvBW1Gka8+iduV5sWDhamnJtCEw==
X-Received: by 2002:a17:906:4546:b0:a45:aef0:c449 with SMTP id s6-20020a170906454600b00a45aef0c449mr3699324ejq.39.1709757515922;
        Wed, 06 Mar 2024 12:38:35 -0800 (PST)
Received: from [192.168.3.32] (d-zg1-234.globalnet.hr. [213.149.36.248])
        by smtp.gmail.com with ESMTPSA id j15-20020a1709062a0f00b00a45a96a9c37sm2093773eje.65.2024.03.06.12.38.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 12:38:35 -0800 (PST)
Message-ID: <0b032929-f525-4b2e-a176-1a447cf0fa7f@gmail.com>
Date: Wed, 6 Mar 2024 21:38:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] arm64: dts: qcom: ipq6018: add 1.2GHz CPU
 Frequency
To: Chukun Pan <amadeus@jmu.edu.cn>, Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240306140306.876188-1-amadeus@jmu.edu.cn>
 <20240306140306.876188-2-amadeus@jmu.edu.cn>
Content-Language: en-US
From: Robert Marko <robimarko@gmail.com>
In-Reply-To: <20240306140306.876188-2-amadeus@jmu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 06. 03. 2024. 15:03, Chukun Pan wrote:
> Some IPQ6000 SoCs have CPU frequencies up to 1.2GHz,
> so add this frequency.
>
> Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
> ---
>   arch/arm64/boot/dts/qcom/ipq6018.dtsi | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> index 4e29adea570a..7fdb119083a2 100644
> --- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> @@ -119,6 +119,13 @@ opp-1056000000 {
>   			clock-latency-ns = <200000>;
>   		};
>   
> +		opp-1200000000 {
> +			opp-hz = /bits/ 64 <1200000000>;
> +			opp-microvolt = <850000>;
Can I ask the source of this voltage level?
Because, its not present in the downstream QCA tree at all.

Regards,
Robert
> +			opp-supported-hw = <0x4>;
> +			clock-latency-ns = <200000>;
> +		};
> +
>   		opp-1320000000 {
>   			opp-hz = /bits/ 64 <1320000000>;
>   			opp-microvolt = <862500>;

