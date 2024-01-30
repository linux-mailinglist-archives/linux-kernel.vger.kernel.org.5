Return-Path: <linux-kernel+bounces-44406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9BD8421A3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63BD01F2B40B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECCE767740;
	Tue, 30 Jan 2024 10:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RPz7Py+a"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55232664B9
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 10:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706611249; cv=none; b=p+cIZhT9g2+kBvPnomf8UDFo2osziXwADBV01GGStRSO2prilpY1yxpGTI645PQvEGc7zj5iiaIuhKQq8u7Tn6igcVhIPWXbmWfgCTIE/sbtABrwPnWZg0si+iP+vZo8ejCLiCgYdvIP9evB5rbSItHEQU/s87V8qukZAx22k0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706611249; c=relaxed/simple;
	bh=i5YiiQ7bg7wuD/RiKd60lDs/l1J+lJ1xk5N97Z7zlGU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KDYwKfMK0GQyJ2Yj/WnmpFb3RaI1vQkoFQYrRKwiC7t2d2oenFg1X0z/0xIqA2l22tJcjumul4ZtwOaxL8yRKdYntiZmCkijLIXVdE3wrWdsOcmsWvLU6LqaxdMlkTLS8Y0SYKIGb01diMeAx0/ETjvLEOzHf2vuogaLo46tWJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RPz7Py+a; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-556c3f0d6c5so3938620a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 02:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706611245; x=1707216045; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qFLwa3UQcdOnGrCTl945Oaq6U4cRv5l6NG+wON7vkHo=;
        b=RPz7Py+a675d8x/sdSfsRT5V2YLd3Y7akzy43Bb97vMRYiFP3x2J7CamfZJ8wOrSZ9
         Hjh0Dz/jKYdutih6ZpPAZonnBHEmvPZ7kZOy/dsAHSAa5Jxj1OqKcPRPApyc0Ioiw1Zy
         wiX9HeIkSjAujsydRlBIefWXqNy118szUU+rRI18G589bnATeYdp/eEedbUqlMtYweD/
         EjfKtpGmOeF2Qr3Fsjd7eEwPF0CYUROrX99Ru1Atyz1PapsUg8WaB5af2KtHhxe1ZZt8
         lrMT+HFa5x7X+NCEIZX5ZyWE/cEntnAfvruTv/N06YaQxdFfu3LAdJ78overRipX1XqG
         pxMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706611245; x=1707216045;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qFLwa3UQcdOnGrCTl945Oaq6U4cRv5l6NG+wON7vkHo=;
        b=utd2N2WE/8M4dvIm5GabjmgZSe8jKIyARuo30mo5CUANJnGDgKnSStLLqqht1WLNKy
         w1ms3fHgIV2g5vG/v5ZEZk5BrMbrq0aENil8p1PWKj14LW8LkWtufGxLnowzUzoZym+Y
         7I+LihC4AFrmyecQgKjsTNTHv4ufMZTfpvTI60z/BBfkVC5eDD95Dm5SRpaeR56Rt1tZ
         gbNcH+bOFvu4UGSIElAd7zzQyTjEECK0nsTT7G+v9bLEho2wITJR6QVLRybIHoQaScjz
         b8KSo7/RU3cdxoabKNLE0W+wkldU6GWrOsgDjpnCiZH1CVCXwZ0J8c+xFpwX4dntx1JR
         sFew==
X-Gm-Message-State: AOJu0YxJZOlBijLam/uqPcj37pGSZUorpIv/hwXQaOxlM3duh219Dcz6
	NHjbmiUQ1gfXkzovwt6Tv/R09IkwlT5di8MLLOjeEwr0I0JF+OaTohScI+SZxvY=
X-Google-Smtp-Source: AGHT+IHCNFb7FMA8kU95tZdChdnP005nbUcHExixBUxTToV5eAyWEsQ5XA1fAj7gKoKCQsermEbU4Q==
X-Received: by 2002:a17:906:c20c:b0:a35:78e1:2d1f with SMTP id d12-20020a170906c20c00b00a3578e12d1fmr4823022ejz.71.1706611245537;
        Tue, 30 Jan 2024 02:40:45 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX05fQGyKIagmkhzHeMedDVupb+uPr9ILZtFlRnpn1nsL1PXYFqHGc6Gk1/mYMItGHBDufW+3Xn1qP7uxgNqlKGSCceld+0ZfykMEsfkOXWk5szudrp3rCdHhScCExZGPK2IIDLJeS9sjyDaRUkw/QstmgYAibFRtzuxTClkoigqN42IDRvxrbLVJrcNYFQg63C6dd0p5zbQiGcgCN3mdjh17KfOm1irkJkvc2/epoWJhptdG9bMQRN5xqWGZr8i2zk2nd1vFga/gcwDXMvUrVND4JxH0HUtWSLs2aUzrOp6FwwjF33aYoHHczBq8FPM48DH0tPNNTEe7udetcIn6lPhHrteUsbpcG/iWRRWtFL4iFB0t2PKMQePJ63J0SGj2VRHGSyEH1L36NZcmC9YJbOtIVLa51z2wur9zbN6zj1J3F5A5nYhYZ5HIR5eUcOv0kLa9Lc4mTxY7nYSur97LHiwjPjnxVgyc+8K/aLpLWJ+nXW6dYkRElBkAJ6gekOaoTp1YGud26REOJ3DtadaP94I4GdfoeKGB/kg0iAEz5f2+kWeYYQPU/J3eX+DiTgNYtB7hHdpNhNAwO0Ofnm+H37wEcw2SE=
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id st14-20020a170907c08e00b00a35c5491b58sm1947720ejc.174.2024.01.30.02.40.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 02:40:45 -0800 (PST)
Message-ID: <5c6dbb39-2db9-40bf-b593-9cb28f257db7@linaro.org>
Date: Tue, 30 Jan 2024 11:40:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: dt-bindings: qcom,sc7280-venus: Allow one IOMMU
 entry
Content-Language: en-US
To: Luca Weiss <luca.weiss@fairphone.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 Stanimir Varbanov <stanimir.varbanov@linaro.org>,
 linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240129-sc7280-venus-bindings-v1-1-20a9ba194c60@fairphone.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240129-sc7280-venus-bindings-v1-1-20a9ba194c60@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/01/2024 08:48, Luca Weiss wrote:
> Some SC7280-based boards crash when providing the "secure_non_pixel"
> context bank, so allow only one iommu in the bindings also.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


