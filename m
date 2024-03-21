Return-Path: <linux-kernel+bounces-109729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B8F8854EC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 08:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 314272826AC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 07:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A70756B8B;
	Thu, 21 Mar 2024 07:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CEC1ytEu"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3844DA10
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 07:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711005921; cv=none; b=P+VVzK3PXTEO0vVF/vHwO5dH+2VjgV+OdqdvrlSs7DKdjjWy/QfzMd9TLzyE3cZ8MNGIhp+MRxTdiICu80J6shP1iIU+pQWGp+gLMwXPtKusGcHwsT1Qkd/+ZerSzmCKRdbs6u7ObSLoOGhSHbWXmmZPOiC34tI73RNq6X1K2Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711005921; c=relaxed/simple;
	bh=SQYENTXYS/IBQjccIXgLfwO104lv0QCzfCjn0Q0BqZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=D3N2sbRGXr1HNqHiRB+VqwnK52Jrt72r4O39bCHz0+uYBqkfzPEZEWp0Gc86Ne2AxFwp3XqX0vYwiuyiVMwJ552Lpv4gKpVbjvZxWkvAVnXOQjjMUgSRvk66bS3wghXdegIij0AqTFCRaq+0PoKsfSnFOQZ+dUsQljrYLemuq/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CEC1ytEu; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-56b85146589so1180407a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 00:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711005918; x=1711610718; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dW/DVr6H9lxXs8kj3uemHI4cq9jKqtvmA1r7vUJK6aQ=;
        b=CEC1ytEu7SS2BPDZYPJMOdzoU7nwGASq0KL5485UxTcAsVKR4OHVwctE88JphJghc0
         0qx9nkxz+WqIkwZRW66oH8XaPxixHaGJL4qzWQTmNvfhN+Jcx6ykqnPc4yR2q5J1rJmp
         e+YsmfNLwQIPi0YrhxVkMrOGb9OcFOtd5kfObrfmInsVf6DuUd7FjCMvmoUSls86iVoa
         aJ9in6HL6VYbVOR27p6L/LCpNv9psMSlXE38JEgDZ9BdUmwOUKJTcqMdsKd1fEZfED6c
         VA5dMTN+EJziuv8M1wsizMIMIat4H02Xg1sjNu65DD13BfN3K30qPpOLL64HSMY8Xcsd
         TaLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711005918; x=1711610718;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dW/DVr6H9lxXs8kj3uemHI4cq9jKqtvmA1r7vUJK6aQ=;
        b=l8R/MpFwtxp5ICTOQ0HsVLHd4tzlm0P0n2TubKrQdKqzepdo9SgtUGxKlMM4MSlmXA
         1oedTDuHVFxbhKklN+tWVPNC6V3Cy0UrCm2zwKMpfTY3KVBKPq66l4ypeRzZ8TsmhlS0
         JzcmgOjz4t7Eqm8n6tWCqV3wupXMTM2Y2G4qn1nZaklQmmsU4HZ3hrikKu2/eShZbQEV
         +d03eVawkae/Tp1UJ+tBw9VPS9tj9M+Wc6nyXkJsKuYoSzEZU1XR4fJny1B/iQLCMYBh
         Y68dLdrpmGui/cSMdOhfW4Vp1tiNvjUPI9Or2Q7EzYPsspIu9kxPAp080mxbKsfjcyNj
         cpaA==
X-Forwarded-Encrypted: i=1; AJvYcCX9k5yKVmv3+2Gp2nSrC9aRCmJGydy79Bb7XAfETCgdcRa6l0T9wsdE5CSZ4ghMp+90tve3imQOCk9OlFvGqz35wo1RmQ68g/gRgKtc
X-Gm-Message-State: AOJu0YwVmRT5g5PW2AFu4fdEsITinYo1mGQZt5rZ3sOWVSwLD6fyggSw
	otds34NLUoeIHaPgWZ4pSC7a4XPDrAql2wzMhLw3GnULSvhpf9+zTFJWRb96Yrw=
X-Google-Smtp-Source: AGHT+IHWwIH8of0S0V3kJihlWI36GOZcqY3zh8uiP8wMtrqpKL4zCWfNie8voIhlde61btxAhfckMA==
X-Received: by 2002:a50:9b4c:0:b0:567:efec:6d81 with SMTP id a12-20020a509b4c000000b00567efec6d81mr1755502edj.11.1711005917779;
        Thu, 21 Mar 2024 00:25:17 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id fe4-20020a056402390400b00567e27c72c4sm7707124edb.62.2024.03.21.00.25.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Mar 2024 00:25:17 -0700 (PDT)
Message-ID: <4079ddcf-425d-4194-93b8-ee113864541e@linaro.org>
Date: Thu, 21 Mar 2024 08:25:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] clk: qcom: add IPQ9574 interconnect clocks support
To: Varadarajan Narayanan <quic_varada@quicinc.com>, andersson@kernel.org,
 konrad.dybcio@linaro.org, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 mturquette@baylibre.com, sboyd@kernel.org, djakov@kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20240321043149.2739204-1-quic_varada@quicinc.com>
 <20240321043149.2739204-3-quic_varada@quicinc.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240321043149.2739204-3-quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/03/2024 05:31, Varadarajan Narayanan wrote:
> Unlike MSM platforms that manage NoC related clocks and scaling
> from RPM, IPQ SoCs dont involve RPM in managing NoC related
> clocks and there is no NoC scaling.

If these are clocks, expose them as clocks, not as interconnects.

> 
> However, there is a requirement to enable some NoC interface
> clocks for accessing the peripheral controllers present on
> these NoCs.
> 
> Hence adding a minimalistic interconnect driver that can enable
> the relevant clocks. This is similar to msm8996-cbf's usage of
> icc-clk framework.
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/ipq9574.dtsi |  2 +

DTS is always, ALWAYS, separate.

>  drivers/clk/qcom/gcc-ipq9574.c        | 75 ++++++++++++++++++++++++++-
>  2 files changed, 76 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> index 7f2e5cbf3bbb..efffbd085715 100644
> --- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> @@ -11,6 +11,7 @@
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/reset/qcom,ipq9574-gcc.h>
>  #include <dt-bindings/thermal/thermal.h>
> +#include <dt-bindings/interconnect/qcom,ipq9574.h>

Keep the order,

Best regards,
Krzysztof


