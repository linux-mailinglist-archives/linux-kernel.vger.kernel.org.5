Return-Path: <linux-kernel+bounces-102907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5462887B83F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 08:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EA54283847
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 07:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF32CA6F;
	Thu, 14 Mar 2024 07:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XnvOjuOQ"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668BE5677
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 07:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710399944; cv=none; b=oAT00+zVUEneuvRBxix0QGhQSvjmkIhRuGurzRGdd8UL3xr5bSSqHfit+NuGhZcqM0wnp3ZzNkGNcNSuk/eFDMeqIZVX3kORV7O0r7fpckb2KPn9xjzAark8sRyoJkdQcvylffS9I5diE33gsM3+TtQBhwQabNhjSut4ARGgGpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710399944; c=relaxed/simple;
	bh=gczMRuZ2fsGRpoCXUBhl7NeVLE82+ehtyW2OQrB7AVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rRdCCCc+hH7C0vNXHn5biQeFSsGUfCuuWsRJvMgmHKArXBGj8pmnHv4/bJ7vTvoaVGP6MhxJrRfzxFzQYtFVQZGLgCu6zHuUROFKKQ0cyY33CKuf0C2AH+kG0Zn6rsuhFmKzwIbxObo2ru85nCF0D3xgR2qChHE9/+iJ89GTeZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XnvOjuOQ; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-512e39226efso637483e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 00:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710399940; x=1711004740; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gczMRuZ2fsGRpoCXUBhl7NeVLE82+ehtyW2OQrB7AVI=;
        b=XnvOjuOQMO5rm41/7v74x9amXbVw0dW/3YFEO0qvJ8bWUHLzMHs5G0O+oPeMsdYsXu
         kverySlewD4RBgA3+pDrlZIT3NzSN9b3jAkhkrNM1WONHCj5sRlEoQ5UvLkc/mNQX6EH
         Pj4yPjoDVNRDMzXOMm7JggdrGRmqhioakRxkHAHzo4m/SdcsRQkjghHZtBMFTmMoY7Xy
         Tf8knEZnacMzVYRqkHA6VEKc5rdSE74/GU1UjISZEUKQfnVvFuM+CfjsX1Bq0MhPTIFY
         9mxGFQwOyAGWE62aisMX106Cp1epRD5yj55HLeMjwVDp1vjwpT2JHprbs0y35r/LDDkF
         W02Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710399940; x=1711004740;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gczMRuZ2fsGRpoCXUBhl7NeVLE82+ehtyW2OQrB7AVI=;
        b=NsrgSP+XlAVcOQl11oBVZ4t8/0YWkRTDLvLWkZkHwgsPF8wnSGJ3gfyEfHZATTshzo
         ChWbfX0n7A0Dn3R4TAZ+V4QuEm2xRQMfwd/8imEoQ8Dl6Kw7BK5XxAqzV5OHY8tiGax1
         dv0f6D80iwFwFUaRv26Q/APbZZkwgBLmlmtUK1dORsxslq4jDA/YgUGcxPFO6COQDeHr
         wF7dliT8QmRSZzv/eUbkPffkTxpqUqILiUw+Fnxdyd6zzNm0cAGquX4VBJsRwHgx4g/a
         5y/X/f29jN/xjgoe5NYzPnW/AiE+mPBHtRlxvR5+DPyNo8zebrMDMMf+CLeyWcV6humI
         woSw==
X-Forwarded-Encrypted: i=1; AJvYcCUDdqL7DoHT9ezlBBI7sz1f4dnpvCfHU2M8OqPWM8gascdbUHfCxNZpY8eXjrZGV9xwgLbxLGcdB33rlHVkw2wA5F6ukqTiJCPqYNbd
X-Gm-Message-State: AOJu0YwrnwrCnY6iwhp5IB04e+s+FNj8GWEVehpddS00ue64OeSLl6aG
	5MUb/sfvht0u5DuoNlNfVQic5oY6U3DuXqlJHMQBcH90HQW9P8OooeIsgwvCqbc=
X-Google-Smtp-Source: AGHT+IF6AKlpHi/SbY50G3BjSHsIPRHiOFvTYICSs7fONjFyEnVxxF2SrMSlne0E/phDX1Sflk2yAw==
X-Received: by 2002:a19:741a:0:b0:513:5c68:9646 with SMTP id v26-20020a19741a000000b005135c689646mr484483lfe.43.1710399940587;
        Thu, 14 Mar 2024 00:05:40 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.252])
        by smtp.gmail.com with ESMTPSA id hg23-20020a170906f35700b00a4380e85e5csm391461ejb.202.2024.03.14.00.05.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 00:05:40 -0700 (PDT)
Message-ID: <a9c3ebb0-2ea2-47f6-b630-7f661d0bf33f@linaro.org>
Date: Thu, 14 Mar 2024 07:05:38 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] spi: Fix error code checking in spi_mem_exec_op()
To: Florian Fainelli <florian.fainelli@broadcom.com>,
 linux-spi@vger.kernel.org
Cc: Michael Walle <mwalle@kernel.org>, Pratyush Yadav <pratyush@kernel.org>,
 Mark Brown <broonie@kernel.org>, Michael Walle <michael@walle.cc>,
 "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 open list <linux-kernel@vger.kernel.org>
References: <20240313194530.3150446-1-florian.fainelli@broadcom.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20240313194530.3150446-1-florian.fainelli@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

