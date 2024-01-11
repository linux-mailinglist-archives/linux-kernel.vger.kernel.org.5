Return-Path: <linux-kernel+bounces-23907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D219482B389
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 18:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5658FB26BD7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 17:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F581524BD;
	Thu, 11 Jan 2024 17:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y91CnuyM"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3921D524AB
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 17:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-50e759ece35so6265338e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 09:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704992400; x=1705597200; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l8IcJn882ZENlg2qEEENksJucf6hT6H3VJSc8mUcJzI=;
        b=Y91CnuyM7pTmak8Bsgv0srfWAxL0t4NSJDrxAVMQyuTkjjkdyTaQ0IZEg8Wzucs0rR
         DzvAoJD7yqjY5/WAM354mfj986ZKjCoGY/rS2V9RfOX0xRdT1gILAA7mlhYp/6gSxadh
         xhorNfo0R6rYRjeon4fOhzPN+pEzCLJibwHeg/H3CEhbpoiba1w19m8s5AM0fVUJTT1x
         mjLzieIMRQm5GnbY2ap5y/PLfTC4XqCXfDLNJo6aPDc+sdPCj2G0QhRvkSHw6ki52AMQ
         vRcWGlCh5ZG1CR7nzl/wyxy49AvhREC8OOmL2GE4z8iC/kPBygbkuTdRSg3LSo2jan93
         nyog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704992400; x=1705597200;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l8IcJn882ZENlg2qEEENksJucf6hT6H3VJSc8mUcJzI=;
        b=vKAjGKCaYPMjmOOtbkhw8vqj53Q7xyryFDGH5S5+fpVpUERaiXCxzGHcn9WTPRwnpZ
         YeVKJDhFshrstw686E3n1rZM3yiJ9ROGK3Cn0yWPFXWFNlMZOddW4+LTmAOP1pbzMXN6
         IX2wcuQuX9N1fFq67M9u0N/m0a8Jx/CIKHPA9rYKSBvXoYBDDVfkZLz+kSgmI5QHLTF1
         +5F1Vcid0RkKIiNX02rZJtN1IXmOJD+Ap628pzMrmghLLJYK0CoSd9godDcrBgYmFSIW
         ubJSonPv+02WGVhZ4VBy1vGMoc+rTIWc2w8O1FEFB4VcKfd1A2FJSMH2fpRRCul3acnM
         +PGw==
X-Gm-Message-State: AOJu0YycGQHXniIxpgZMVKwj2BxXxdhEJRZa2Ri5xIVRlnBmwJmXm4uz
	OHIFXCb9DaqhreVMZ2DNQ/06DR4jrl7SFZbWtWQI43SVFGzHZQ==
X-Google-Smtp-Source: AGHT+IEVXqMFZz3mSFHYrFcrvpVDnPktf3QK2oTY1tJI9wlboM5Q4HyQe6EBmHDj4bRkh1S5bZ5C+Q==
X-Received: by 2002:a05:6512:33c2:b0:50e:c8ec:8c42 with SMTP id d2-20020a05651233c200b0050ec8ec8c42mr862048lfg.130.1704992400254;
        Thu, 11 Jan 2024 09:00:00 -0800 (PST)
Received: from [172.30.204.205] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id u12-20020a196a0c000000b0050e64b558fbsm242640lfu.79.2024.01.11.08.59.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jan 2024 08:59:59 -0800 (PST)
Message-ID: <384635f4-e4e8-4a84-82be-dca71b06a9ff@linaro.org>
Date: Thu, 11 Jan 2024 17:59:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm64: dts: qcom: sm8650-qrd: add gpio74 as reserved
 gpio
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Georgi Djakov <djakov@kernel.org>
References: <20240111-topic-sm8650-upstream-qrd-fix-gpio-reserved-v1-0-fad39b4c5def@linaro.org>
 <20240111-topic-sm8650-upstream-qrd-fix-gpio-reserved-v1-1-fad39b4c5def@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240111-topic-sm8650-upstream-qrd-fix-gpio-reserved-v1-1-fad39b4c5def@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/11/24 17:58, Neil Armstrong wrote:
> The TLMM gpio74 is also used to communicate with the secure NFC
> on-board module, some variants of the SM8650-QRD board requires
> this GPIO to be dedicated to the secure firmware and set reserved
> in order to successfully initialize the TLMM GPIOs from HLOS (Linux).
> On the other boards this GPIO is unused so it's still safe to mark
> the GPIO as reserved.
> 
> Fixes: a834911d50c1 ("arm64: dts: qcom: sm8650: add initial SM8650 QRD dts")
> Reported-by: Georgi Djakov <djakov@kernel.org>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

