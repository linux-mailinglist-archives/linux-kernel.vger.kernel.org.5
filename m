Return-Path: <linux-kernel+bounces-22148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A21278299FC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:59:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4920A287EED
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07974487B3;
	Wed, 10 Jan 2024 11:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mWFAff6h"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A5148787
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 11:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40e5521dab6so7745795e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 03:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704887878; x=1705492678; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nk5CcraP8tb0HLUYKKWn5feJXh3b9PprQEz09+8nh94=;
        b=mWFAff6hlAJfcJYKtTHBD1ri2vNE7cjYzc7coMBpTdkhNuoGBf1sB9L8Kfv7na/jTr
         mFPibPdlc5snztvZAd7xkh6iVRXMNYiRWESbz5BCJPsONt9GkEABdZB4gwHjGvca3SOS
         vqnbv3DPOXWyCnG+oGg7b57Og0yNfPz1BjO3QtZbsCTLLnHb7r2TkFbUgZ2T6dM2+mjp
         OPUNFjo84BuTeUj1hg1G++sbpkA7sc5dVhW9L4apx2uVJV88UPizj1uedezwhOZuxeLf
         wnYhoiMua/cYY0bMeDTNKruy2KLSJMX/b5VIBjkpLcF7Bi9PbYQcJCrKbjsj7VSsjt9e
         iq0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704887878; x=1705492678;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nk5CcraP8tb0HLUYKKWn5feJXh3b9PprQEz09+8nh94=;
        b=PEMfIIpMSRl2abso2fN35edC7xrde8UiNvtvIMJ1oPBEBysI5t7xBj1tlnV0pVAL8Z
         AXSzXhyZ2omhUnhvbOFOdxrKWsZpOdSm/mAdu4p/C5uY4IoYSemhexw67YsRA1LK5BAm
         OH0IoB2IuuqbSaBh0SU6jKPwCB1LS9uxieIyLHgJEvWrXfOJf2a4cP7pBsJYXoC0EcHX
         sgJ+rvO1f0ZatuDylUzgdoD9Lzrxr9pJnPe6wJMVpQR+C+fa1KvBukDTHcJVRtG/26SF
         qEda6DmzgYp7Dts9Th1zhddRcOIPLip5R+fDEJSf9XH63OU71ixq8dbY6zkBOPqya/Vr
         CTKw==
X-Gm-Message-State: AOJu0YyLmDnZA1y7Ewm8fKq7AbZRaeYefK4WN/x6t3f2YNkqCiuGxjH5
	+v3eebKJvLxTEZgsCobGExN6HdZ8rp6a3Q==
X-Google-Smtp-Source: AGHT+IHspS3WBHNq8pc7wZVlvwZCg/EF5lgWNe6VwhEdGt3wjVjh3C6jYUZHj3niz7zmNxfUOpodKw==
X-Received: by 2002:a05:600c:1c13:b0:40e:5332:1939 with SMTP id j19-20020a05600c1c1300b0040e53321939mr598054wms.50.1704887877866;
        Wed, 10 Jan 2024 03:57:57 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.112])
        by smtp.gmail.com with ESMTPSA id j17-20020a05600c1c1100b0040c46719966sm1973854wms.25.2024.01.10.03.57.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 03:57:57 -0800 (PST)
Message-ID: <3f18b997-46a7-466c-ad89-10dbafe2708d@linaro.org>
Date: Wed, 10 Jan 2024 12:57:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] arm64: dts: qcom: ipq5332: Add RDP441 board device
 tree
Content-Language: en-US
To: Luo Jie <quic_luoj@quicinc.com>, andersson@kernel.org,
 konrad.dybcio@linaro.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 quic_kkumarcs@quicinc.com, quic_suruchia@quicinc.com, quic_soni@quicinc.com,
 quic_pavir@quicinc.com, quic_souravp@quicinc.com, quic_linchen@quicinc.com,
 quic_leiwei@quicinc.com
References: <20240110112059.2498-1-quic_luoj@quicinc.com>
 <20240110112059.2498-6-quic_luoj@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240110112059.2498-6-quic_luoj@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/01/2024 12:20, Luo Jie wrote:
> From: Lei Wei <quic_leiwei@quicinc.com>
> 
> RDP441 board has onboard QCA8386 switch and 10G SFP port.
> 
> Signed-off-by: Lei Wei <quic_leiwei@quicinc.com>
> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/ipq5332-rdp441.dts | 51 +++++++++++++++++++++
>  1 file changed, 51 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq5332-rdp441.dts b/arch/arm64/boot/dts/qcom/ipq5332-rdp441.dts
> index 846413817e9a..d51968e9d601 100644
> --- a/arch/arm64/boot/dts/qcom/ipq5332-rdp441.dts
> +++ b/arch/arm64/boot/dts/qcom/ipq5332-rdp441.dts
> @@ -12,6 +12,15 @@
>  / {
>  	model = "Qualcomm Technologies, Inc. IPQ5332 MI01.2";
>  	compatible = "qcom,ipq5332-ap-mi01.2", "qcom,ipq5332";
> +
> +	soc@0 {

Nope, DTS does not define soc nodes.

> +		sfp1: sfp-1 {

Why is this soc? Where is the MMIO address?

> +			compatible = "sff,sfp";
> +			i2c-bus = <&blsp1_i2c1>;
> +			los-gpios = <&tlmm 45 GPIO_ACTIVE_HIGH>;
> +			tx-disable-gpios = <&tlmm 24 GPIO_ACTIVE_HIGH>;
> +		};
> +	};
>  };
>  
>  &blsp1_i2c1 {
> @@ -63,3 +72,45 @@ data-pins {
>  		};
>  	};
>  };
> +
> +&qcom_ppe {
> +	qcom,port_phyinfo {

Eh... We talk now about basics: please don't post downstream code, but
first clean it up from all the junk. All the basic issues which you have
in downstream and which we do not accept upstream.

I do not believe that this code passed internal review.

NAK.

Best regards,
Krzysztof


