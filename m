Return-Path: <linux-kernel+bounces-111296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7992B886A5A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 11:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D8881F23B56
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223843C684;
	Fri, 22 Mar 2024 10:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EDd8JIZ/"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FE33D968
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 10:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711103484; cv=none; b=bkcHrd0Vi2R50eyAH+bPgmuIQjvxgM4ayf4sftUJXgj1JpII2kFd1oyNgw2nCYWb38vEXEMCXSGi1adjnwS/b5tBClYv6YIEHM/0l4IXgyPP7p6vzHAcZvs5ilFr4GA2d1BLTUTTbWf07tZw3U3uBAQvypWr2wYN29/uw0pPmUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711103484; c=relaxed/simple;
	bh=1yqsyEAyrbQEKMO+oY3gj7fVZXoAvDp07LGSjGWG+cs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=af4Vj6m2VsseRJle6y4kUZsakGRqNVXDcYdooxsjAr+YbYuVsNI/iKZ643B8xBe1+Xr+IJFhJsuzV9c2QUIkCZyXXIGcNai9BAq1IEmIuyuR74W4H0dRPlq1uojI7lQMQh1eipqD3iMyea2m0RSteJmhDZtj6cI0F5KfStGXR1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EDd8JIZ/; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33e17342ea7so884920f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 03:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711103480; x=1711708280; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sEcFM3t3rGGDrrs+wuw2zDXHWzgkXtTmhLNSeATLAvk=;
        b=EDd8JIZ/ZjhQC1y97lTkWBOymL7GIFTHdQdCowTzSjDziNHFjpuecRQt3TOIwjNbKa
         fKEYrgHIHo+oqu46ecu+2CyvyI6PI8YFk5HogBYbwJyNjSBzjtb3z5xgf8kydq4Wfy5r
         99CsjaoR8OHuFbUjf4AKmkPpqTH+7DEQOIug23jIhClHAP0wgSUZhOCat2psXOpPTXCH
         9RyrPO8m62h+toTEU0JCUGJPkl7va47cbBNiauiQ36sigFCAgIWRNwB52xjAeKNjOlby
         wuFHZ0TGbuXnJPdWAplkg8Bk7Utc+Kn3LxIy3Y7qi3oHGBxhe6VUOiQkk5NHe7qq7QYX
         aKRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711103480; x=1711708280;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sEcFM3t3rGGDrrs+wuw2zDXHWzgkXtTmhLNSeATLAvk=;
        b=UKnAId64KkyxY1JEipAdsBhsaC+FPNSdmZR0HHlQvm3pY87QbUkkAf/VWy5czlcN1H
         84Jqckqaa1rDFi9k1ZeW6npzJEtQRA4mS6AKoljohd9ZKaGov3n1SPAXGeCf1iMFidMT
         o7QAtDen3lBAm71J3Oa72ElOnAYagAtJlufLzBW1zY+a1P4JwHkkNjHtjj22F0kPj1o9
         u5lHkLkH83kTxm/nmpQIkV4CQXZoF+MzaUcgnC3XFMY6mhy/H0UmNpovC+XL71YkgbWR
         OwUcXK+fbOGOZwyI4ekZ7lUXCnEeJIPrZAKpQRORc+tBpxjhS0Wf111k1TJvsE2P0QyN
         1wow==
X-Forwarded-Encrypted: i=1; AJvYcCVwoOgQXdEZ15tHvbZ5eW/j1cvnzdG5CIiu3/UNgtJ4Oeg2LN7sShHkvWwdO5wux29Z4iYEy8qB0YOBaNCcU/VIPHCb/PhrCJXz/ZEE
X-Gm-Message-State: AOJu0Yyqydwg0obKeJu1JDougmlpA+DQSBoB1obEXPQW139p377JuAVA
	WnSHt7AvkVDYj/M53VTwzFbheZbl6bONj3Xl6LxOEk3suiJD1fd1CBAW9gaXlxE=
X-Google-Smtp-Source: AGHT+IFLWeyHAKmJFDuY1LyMfeP1uoswUUuBKiCoUA5Ty/5Z3a1YZV4wAVHf2fG9BBV8WWxxQGLgrw==
X-Received: by 2002:adf:e2cc:0:b0:33e:cf33:bb1a with SMTP id d12-20020adfe2cc000000b0033ecf33bb1amr1518380wrj.12.1711103480298;
        Fri, 22 Mar 2024 03:31:20 -0700 (PDT)
Received: from [192.168.0.102] ([176.61.106.68])
        by smtp.gmail.com with ESMTPSA id x15-20020a5d60cf000000b0033cf4e47496sm1759496wrt.51.2024.03.22.03.31.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Mar 2024 03:31:20 -0700 (PDT)
Message-ID: <72b68358-6621-46d0-a0f5-b48fdbc54678@linaro.org>
Date: Fri, 22 Mar 2024 10:31:19 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] arm64: dts: qcom: pm7250b: Add node for PMIC VBUS
 booster
Content-Language: en-US
To: Luca Weiss <luca.weiss@fairphone.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Wesley Cheng <quic_wcheng@quicinc.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-usb@vger.kernel.org
References: <20240322-fp4-tcpm-v1-0-c5644099d57b@fairphone.com>
 <20240322-fp4-tcpm-v1-3-c5644099d57b@fairphone.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20240322-fp4-tcpm-v1-3-c5644099d57b@fairphone.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/03/2024 08:01, Luca Weiss wrote:
> Add the required DTS node for the USB VBUS output regulator, which is
> available on PM7250B. This will provide the VBUS source to connected
> peripherals.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>   arch/arm64/boot/dts/qcom/pm7250b.dtsi | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/pm7250b.dtsi b/arch/arm64/boot/dts/qcom/pm7250b.dtsi
> index 3bf7cf5d1700..91a046b3529c 100644
> --- a/arch/arm64/boot/dts/qcom/pm7250b.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pm7250b.dtsi
> @@ -45,6 +45,12 @@ pmic@PM7250B_SID {
>   		#address-cells = <1>;
>   		#size-cells = <0>;
>   
> +		pm7250b_vbus: usb-vbus-regulator@1100 {
> +			compatible = "qcom,pm7250b-vbus-reg", "qcom,pm8150b-vbus-reg";
> +			status = "disabled";
> +			reg = <0x1100>;
> +		};
> +
>   		pm7250b_temp: temp-alarm@2400 {
>   			compatible = "qcom,spmi-temp-alarm";
>   			reg = <0x2400>;
> 

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

