Return-Path: <linux-kernel+bounces-125824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F342892CC0
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 20:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DB851C2173A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 19:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B5541AAB;
	Sat, 30 Mar 2024 19:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LaXMt+et"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BBA3D0C4
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 19:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711826390; cv=none; b=VsHpU571SWJsxY9D96v6+uIDDPwfU/pyDehS2tA6kV22VK/kAc/wRoYjxdNXJOV8eatQW/xYhNjZ3wFjcVa5+jrSHpekLYvS/HTXFmTXU7HK0n8J+Rde2mIDpMwDgDlRha12uRiBZGRjfdbUrdYML8VRBHjwwP4+YhJusX5nZv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711826390; c=relaxed/simple;
	bh=s/AwPUhJ0aRLUuGYau+JvXs3KYWIU0SQhCOqBkT6LcA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jvLd8e6ovfyGpUfhrIIAKiDJfb6GSJsC7HJXw73ANXKFMzD2TW1dZGWTDfLtS6X9L0sPIUn2v1mCn4D19P7MsrtUmI2gsxnPQCTEAgDtFMf0DCwV0HxJU8tMdnpT2Zw6V8KaWTCdSAzMQRs3yP91wZA1k8lZxbGGzVYk2+ctEdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LaXMt+et; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-341cce3e5f0so2581647f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 12:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711826387; x=1712431187; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yN4PuKSWEeinPRzZJmmEfOJ5USQg5a2CBtV9qfnhNZY=;
        b=LaXMt+etgaM1k9zGx6DLJ8DV12KbZchQ1jgsu+awUW4xO7DlSeExs/Zf4LVQtQoE93
         CUEZrj6xBjlhciXJxymeOGk5b5qQSSeL4EcIX2Nk81+lYj86o+bgtOdagdXAdDHMrlaz
         33WsKV36tcyIInSHHvKw7rRApWLwZzX7KWAo08w4AIK3+xeYSpcma1NDKmdM59KUt6o2
         cf/0r8bnwcWq9vuUF0nHLYNgoB7YJ1X9GcFSYmudlwdJ6w9Ks/9AL8imrz/fbFmkQ6kC
         zBpj9Ac/tpWvfjBKpAR+0E08qmIIQYDP8ok0xYdM715mhTswOeZ3midGBSa6jv9tHEWj
         XqUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711826387; x=1712431187;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yN4PuKSWEeinPRzZJmmEfOJ5USQg5a2CBtV9qfnhNZY=;
        b=oLUn6UH6joS0rvyy64HfIjBqVzm1ZelBnCdmeMrsHtsyNLsds/Hrxnn+6vAzutcRrk
         Slglm3DpcYosXfms37tBeO/y0RtS28ugirg+Xj0bzDmKzRsgqrNXLlzqQHxrieV1ZPxF
         b65N2Zmqk6OCLU7QMEpWmONFsUujiKC+ju+CUKKBCK3t8/Iucx2wg5O1hMG4Vg8mKYlP
         pVlMOtAJ3CKy3VjtTwCghhsZOG9e2buHyhLE0sS4ftxIVG3mlkz99pxIRA5q2P0zGbmP
         vNZ7m6Wz7EzwTcCvyYXOoNMVDw4zAPCnER6mloffuTlAIFQkxUxRmBBFAm6eNTqLZ0i2
         zwfg==
X-Forwarded-Encrypted: i=1; AJvYcCXN/+5nrfxgWm97OL0fel133o8+zoWq6LHDsuGRiiFZvS+XnPfKj4D9DZSOplkr2CVkZdO0c6sd7qtOc0saB+q6gh/JKnb2zafEpoyT
X-Gm-Message-State: AOJu0YycGZ76t/SwapzZUK+UbGWYPghNP0lFPKfCw8QfQ9gcGPhu8y8Y
	lOotW7K4Tvy53cGVME74bx8vErI0jnAtCmAJdbBi+fWmt8hn2Z10+oq8hoLC+Zg=
X-Google-Smtp-Source: AGHT+IHWUVRhoHArAcPvftJYbBm/R5fHZ1fgFhrb/Gp8SUH7ld3DR/QCLBtk2UAnG5eR9YKtJPY7pQ==
X-Received: by 2002:adf:9b83:0:b0:343:41f7:7eca with SMTP id d3-20020adf9b83000000b0034341f77ecamr1520461wrc.33.1711826387447;
        Sat, 30 Mar 2024 12:19:47 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id t1-20020adfe441000000b0033e756ed840sm7089641wrm.47.2024.03.30.12.19.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Mar 2024 12:19:46 -0700 (PDT)
Message-ID: <d8c0ca00-7e14-454e-8a65-5dcf14ed7796@linaro.org>
Date: Sat, 30 Mar 2024 20:19:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] clk: qcom: clk-alpha-pll: Fix CAL_L_VAL override for
 LUCID EVO PLL
To: Ajit Pandey <quic_ajipan@quicinc.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Vinod Koul <vkoul@kernel.org>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, Taniya Das <quic_tdas@quicinc.com>,
 Jagadeesh Kona <quic_jkona@quicinc.com>,
 Imran Shaik <quic_imrashai@quicinc.com>,
 Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
References: <20240330182817.3272224-1-quic_ajipan@quicinc.com>
 <20240330182817.3272224-2-quic_ajipan@quicinc.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240330182817.3272224-2-quic_ajipan@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/03/2024 19:28, Ajit Pandey wrote:
> In LUCID EVO PLL CAL_L_VAL and L_VAL bitfields are part of single
> PLL_L_VAL register. Update for L_VAL bitfield values in PLL_L_VAL
> register using regmap_write() API in __alpha_pll_trion_set_rate
> callback will override LUCID EVO PLL initial configuration related
> to PLL_CAL_L_VAL bit fields in PLL_L_VAL register.
> 
> Observed random PLL lock failures during PLL enable due to such
> override in PLL calibration value. Use regmap_update_bits() with
> L_VAL bitfield mask instead of regmap_write() API to update only
> PLL_L_VAL bitfields in __alpha_pll_trion_set_rate callback.
> 
> Fixes: 260e36606a03 ("clk: qcom: clk-alpha-pll: add Lucid EVO PLL configuration interfaces")
> 

No blank lines between tags.

Add Cc-stable tag.

Please do not combine fixes with new features.

Best regards,
Krzysztof


