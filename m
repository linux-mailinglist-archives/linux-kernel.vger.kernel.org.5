Return-Path: <linux-kernel+bounces-55537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9F084BDCD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 20:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EFA01C249CF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 19:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE16168DE;
	Tue,  6 Feb 2024 19:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zozxX+5M"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6698014AB0
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 19:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707246265; cv=none; b=GutAoIMS18hfa6aDxVFEcslwR4hIjO3hnvKtknROXlwnwCvu6LT0GI8Z16VuDRbn3uwPIEhyCmOoM8WBm9Wl0OxSAGvYEHfNG1rznFdkCXi0PPGMpR9JpubMlTe0sYeRZRdIMozyPJhLquox2/6P3I9kg9+tdhBe2HbbD9UIAQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707246265; c=relaxed/simple;
	bh=zRHmJlM4tIrnLxMfugc/EEGTgX+ffGcwMiWg1WAmpFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gcOCVw5MxOPPVv8ECBq1a1TqBuUIBwQKeg0unImxpTiXPAR8DTaqWWtYlRHIYN2hOBs55We77Ony6iWb/bGSocPc2f7JUGf36IkD5xJIZLza2wWW52vrt89B4EytP32QpXymrNU7HZOWatfUlDF2plfAbITFuRxuoA8DUI9knEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zozxX+5M; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a30f7c9574eso787371066b.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 11:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707246262; x=1707851062; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M1K7cv26IOW42D7RL96je5yDREvxZv+IVIufJKflhsw=;
        b=zozxX+5MWrb7+wbBBl9nXvv7c3gs8JEKSpsajtkwjCKZQUNlgB6xpJY9hrpIBcGuTd
         P/D015lXW4EIJzRfeK9pzDa4P3+bS1oSekFHBq8sCthVOc4VB0iXFwqc0zqMo7jrp0um
         ChUHC3bJ8tg9zw+ayz09F0Zmlwuo+64rcBiNghflNLaCL2OKd8mcIFXIlROpzweesR3J
         qaOXURFxHLkcHRXNA6KI3mdOb6lDQ01Ww+9GJqD+9pXCQdwo81hSqatYsoX552kKeblO
         N1IjItLjJ5bxAJEs2abdDGVJQ5ufXRbPJfF4vwvojSXqHQRfMZQTkjnpgMUqyGKd64lm
         L+1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707246262; x=1707851062;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M1K7cv26IOW42D7RL96je5yDREvxZv+IVIufJKflhsw=;
        b=Q4FFle+mBhO3+dJdrJTPcIiD9Ure/sgTfuG09ZVUotzpoMcYmHf8M3SZ85AZTT7g1r
         Wk3NdoWJ+lDXdQmZq6cvOI3Pwws5C8z3PQxdf54QALucNbUmGAMXMT/EszfFTPG0Qh59
         5LT40UTVUfg6TwpRYdV6N2s7ae84AQyyKJAiS9yOdh900uD49aTlTOl/rwAxu606Fq3v
         oNpT5yPJrDIIIIJ40T4pIAWavmDTCk/EL219BggiXaa4+Gt9XX1h1vT2QCIfaLQ9L9GE
         i/llBoLtGMTdduSHf09rlER45fDFtt1sVbWYkwbADXHgyl/FMA+t/biipUgbEODXamgt
         4Z9w==
X-Gm-Message-State: AOJu0Yyzcle5yobT1mvdUX35WSNtWKQw80FFrRbl+rlB4U3xVawG44sd
	sJxCXZn+xkrhU+x5mk+LqLOav7cytC08OKTO6+GSqwDZeyB81G5f4/b7q8lREU0=
X-Google-Smtp-Source: AGHT+IGtwi6ulZKoQxVpMLjEAQ4wbo3pNLubNLE1AIKVKyziMp5gRQU8Ytor/CXeX/K4nhwwipuapw==
X-Received: by 2002:a17:906:5fc2:b0:a37:ad9c:c146 with SMTP id k2-20020a1709065fc200b00a37ad9cc146mr2396846ejv.62.1707246261655;
        Tue, 06 Feb 2024 11:04:21 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVnNagwUm6lzBzAis1QLt9NQR8Ho6wNkyv9Fip8te+aViYR0+OzUb4jidIbafT3dAs8lSNlE0yNfSH+ediUh2axXKeVKrR+4U3ry6n+qmnl2jL+SG1Okyhz1MXG3v8FenGgRBHNq4FA6/N1OduGaNKmCdSiw4nwMOqsUyRNP6UIRQIkdk0QzQUxkURgXRiMdtLZ9fFlPm31Gn+Nv/jan83MvVzwiLiSs/61SrLkblNxPeuSsoMbqcUqfb4jGP8Q83Yl2ST7/XP7hM1hOEFxmmXQSAqmv3TlGp4B187BGyytWrbCLf6NBFhx4ylTID+LRCjIEVhhBAJ4Yh29P2ZBYtNW2tXDZ33uT0I3pClfwF0uxgPhtcNzUrWJh8g=
Received: from [192.168.192.207] (037008245233.garwolin.vectranet.pl. [37.8.245.233])
        by smtp.gmail.com with ESMTPSA id h16-20020a17090619d000b00a385535a02asm224018ejd.171.2024.02.06.11.04.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 11:04:21 -0800 (PST)
Message-ID: <4c2939ea-0666-41b0-9885-3eea4130c623@linaro.org>
Date: Tue, 6 Feb 2024 20:04:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: defconfig: enable audio drivers for SM8650 QRD
 board
Content-Language: en-US
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240125-topic-sm8650-upstream-audio-dt-v1-0-c24d23ae5763@linaro.org>
 <20240125-topic-sm8650-upstream-audio-dt-v1-3-c24d23ae5763@linaro.org>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240125-topic-sm8650-upstream-audio-dt-v1-3-c24d23ae5763@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25.01.2024 17:42, Neil Armstrong wrote:
> Enable the SM8650 LPASS driver and the WCD939x codec driver
> as module which are used to support Audio on the SM8650 QRD board.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

