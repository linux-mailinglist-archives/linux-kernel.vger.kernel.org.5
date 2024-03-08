Return-Path: <linux-kernel+bounces-97180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3570787668B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 15:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5804C1C21CB5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41644A2A;
	Fri,  8 Mar 2024 14:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qKCHTOIi"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480881865
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 14:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709909145; cv=none; b=Dh5JWaeyGAxsfUH4ZTuwLkPivOhW6vj/wnWCWbJ3iU1SCCrZyuT0pOVotQLAJWEFOenkXV9RJi0SIWLLwywu2dlKaadJPlaj/fyiZF15DbBDR4EAH3/xQyJpovEJYxH5BAWI0M5nGmvN/yTYXJfO8BDd9HUBq5BnIBYogqAA3zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709909145; c=relaxed/simple;
	bh=Em1F929Mn1mPrn47t685mqMI8vaGLknlocnaygZx4Hs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OVf/btrkfotUOzvkIDSDYS7OF7IzKKu8KVPiEWpGSidqzNpdBr8ZSRnv7WEoc0rK95JeTwTV7PmsNFhVRjtszs4oQ4IhJfjqrgDc1LZADPkrK6uWU3sKM4yYgnz/SsP4ywmU6jPxSM2xZSF6vEO+RfJdRM1Z9rrq0zpw6O8jqYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qKCHTOIi; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a458eb7db13so318774866b.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 06:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709909141; x=1710513941; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zP41Zi/mvVoGN7hu7NP8sEaRzDXJMEZcIHHfHI2Tt3E=;
        b=qKCHTOIi20QQc7RHat9XMt8Njeo4p0xsM+oKsVQ8FmGpPtV24jLZXqpDyMvfyQOxyy
         HJQR36rvZYQWSDJeRLql8XQ3ZmslOptcf17uC3XMhC/2hmkc/vdVPhizHhX0v2XdmLzI
         Wm/ML31Y23EMU7xOyxxJ5fOpff5u3hksCDPjnqd5ZmOIJVZ0IsOd6r1pM/EOgBiBBEzS
         i4ObaMnaykFrSV6KdV76cokD1aasz+HAg3/BwdvyT0yKRvLG3fkLlb367v0677HbL4ry
         a6FCiF+Mw2MXHCS9uA3JF76gF6huM8e59kaGKTBag1S9k7MzOZSS3KoLaq4zMFKFipMt
         2G3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709909141; x=1710513941;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zP41Zi/mvVoGN7hu7NP8sEaRzDXJMEZcIHHfHI2Tt3E=;
        b=YUZp5tL2elpbpRMqF/9oM/Vz1CCClAkENQUSSx4vSdLmRwtlqtr3y1LTN8ZPzdO6LR
         s5jZdsCR0U1WAbCQTzoekdRNv1iVbyj/rCoxB9mLOVsD9iDppnlDXgimf36qwvCMND+n
         mqDHFHoqjDasl+4AvkAWN+UXCkDYl/muqc0bfFm/rRbROhQKsRTWI4YZvPGjGt9JwBLw
         RVfj54rmANooP8kbiF0MvoRP3V8KgpNENdJ4Yjtr3hLYc+pbLkiYonamsbavKugR6rKo
         YfR4xoHDJOn5Isib5GbUSbFoHPD/YflmRLoqlTr0AXpc1hYz+RQdI0y6hZkhwGctBaP+
         HOkg==
X-Forwarded-Encrypted: i=1; AJvYcCVDOGupP1KsCLKHAHuRD62iKoNQ0ampHFdSLMu7JF0Gfa3bx8NVHaYCYAH/iMf7RHTdNhxT+NE/U4AD3Zb6ehWsjboUGTUj5ZFP7WIS
X-Gm-Message-State: AOJu0YyixA/aCwnIp0qj2NBxiASSPv3pWUdnlBpZJt2u6xHbjRMcM2Rh
	Dr/jalJ1R+W2c8L4b6mYNof4YzgvFwCPUXglar+7Ti5xli/uLcmK43DeZFmzALU=
X-Google-Smtp-Source: AGHT+IFzr7uIBzprrII6sDcFB9zm6dRvFyrKG7ykYhwxdSAW3eP/ZuRLedW0GrFDNK30PIfI2/mYVQ==
X-Received: by 2002:a17:906:1cc2:b0:a44:4578:c79d with SMTP id i2-20020a1709061cc200b00a444578c79dmr13044343ejh.4.1709909141616;
        Fri, 08 Mar 2024 06:45:41 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id me14-20020a170906aece00b00a45c9474442sm2096353ejb.18.2024.03.08.06.45.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Mar 2024 06:45:41 -0800 (PST)
Message-ID: <72f29fd6-9d83-4a69-957e-bf3630878784@linaro.org>
Date: Fri, 8 Mar 2024 15:45:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/4] dt-bindings: arm: qcom: Document QCS8550 SoC and
 the AIM300 AIoT board
Content-Language: en-US
To: Tengfei Fan <quic_tengfan@quicinc.com>, andersson@kernel.org,
 konrad.dybcio@linaro.org, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 dmitry.baryshkov@linaro.org
Cc: keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 kernel@quicinc.com
References: <20240308070432.28195-1-quic_tengfan@quicinc.com>
 <20240308070432.28195-2-quic_tengfan@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240308070432.28195-2-quic_tengfan@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/03/2024 08:04, Tengfei Fan wrote:
> Document QCS8550 SoC and the AIM300 AIoT board bindings.
> QCS8550 is derived from SM8550. The difference between SM8550 and
> QCS8550 is QCS8550 doesn't have modem RF system. QCS8550 is mainly used
> in IoT scenarios.
> AIM300 Series is a highly optimized family of modules designed to
> support AIoT applications. It integrates QCS8550 SoC, UFS and PMIC chip
> etc.
> AIM stands for Artificial Intelligence Module. AIoT stands for AI IoT.
> 
> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


