Return-Path: <linux-kernel+bounces-116504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0CB889FEF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49FE21C36BF3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092371BC23;
	Mon, 25 Mar 2024 07:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ro+EHill"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF2C184419
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 07:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711350921; cv=none; b=h3EkhkM0k3SSy0BsPpWrHATrz9e6F/fAJHu1bQmezBNmjNJkbSelMmWgQGOlHLLMcuD10ES/FtBkYvUZhSB6W6Qbl8ZxQ4227NzaoP2tjxsfnfTlWSfAi/ER71PPpCGa42KNFUrotD7pOarJa9bPz8oh4snP2Zx1mHKFjF8xDps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711350921; c=relaxed/simple;
	bh=+OyKK7IkvwEV/w7UMcTxO7cG4x4rvzI12pOx3LK8JQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l8qAYSl7m2Edp3etXwrHLXo1oxsdDNlxGFlMa2DTipuSaWvxDbwc57lNvtzYlfxm+vE0yea6FS5AClY9sWeFoPFE7U+Sj350QmG4wU8OKc13anXIoZZeOwlxW283QvZnWs3SgIeytDML+i6ZPRRyPwBUewhiRbWTChtYtk9iG7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ro+EHill; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a4702457ccbso513679566b.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 00:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711350918; x=1711955718; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OxdjCTpMFkU2iy+O7js4KexQH/nrED/NHR9zVi08e94=;
        b=Ro+EHillAS5+CDQHhQK4soZHh7bpfFrTib9LvmTZVs8Ly2G1rUmmcohhmIZlBMvaHK
         c4Kb/5XrxeJf0TW5VTppJN6JhiEW94jA+Gs9A09YpbmJbCkfGZWLDbP8xFZkDFWoqClN
         98Aq2zLtar/buAvu92upr0lEPLhuTrptxcgWMn2YuD62uFrXn/+AcwOI68P921sxAJj8
         1Vlif5PkCVs4x0VxJLtdPzohIorlDlcMCjYAWUzoNlkSI4cl1s7yHyKu6h9Iz8KPhIip
         Gfw1glFi/5TfOHSUu4wk6uLexNLSif9U/yPvcZXE6x8nU/8SrTaN8u73b+YmBnIcrMkR
         /TbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711350918; x=1711955718;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OxdjCTpMFkU2iy+O7js4KexQH/nrED/NHR9zVi08e94=;
        b=miY72I2LK9ZferqPS6IT6MYLn4jO3We1+TRssJlKYOLvd1pfiRkPCppKobaoYimyGR
         qf4RIr9bTalv3Zxz1Jj91tzB6H8HIYu2STtG8gm16ynFkzMrgLtOzd77/IzDrNjw5X+O
         +2Cs3aUuL/PT01g8fzbJ+Mb5yH8RTkFi0n4Wx5WCjbZr0ImCGgwhSR4AL9gJYPSqgwPB
         grrEB+wDtpFqIgRHkrxjZ6QfZlW30rR2/8t6kVjPmK5dy2E+i7l8NODzCOLOJBM1wUBJ
         eWU2VK4nsB+OCNKOoi1I9NjpC+U4IXrtKUlFRDvCCk5rmw9U23dVD+2ldyCpVxZBnLcv
         uOPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtX4Nm2BxETxYFMwzLTlSSHWaum6plcVOiNX8WrO/WMIlfp2Gz9Rsiz+IFytetrNGIsQz+5d2Amah6F/TbENquQjAb5TMRrLbq9Eoh
X-Gm-Message-State: AOJu0Yxfcsud8j2PvFdLE5dUGFh47+0aECivO/WOd/ksVn6r4xMR24zP
	A2rOqYvOuBVUrGsXTYQoDPNHbp03i+WR0T7OQa0pHw0FzmIFmGU0UZMaxDfKuXw=
X-Google-Smtp-Source: AGHT+IEABScS/uWpH8mLPgka5W2OjNZXv8LwGqs+ViqHFZf7wcLBOPPQPWhOE5l5IRTB8EdwF1y6ig==
X-Received: by 2002:a17:906:1d04:b0:a47:34c8:900b with SMTP id n4-20020a1709061d0400b00a4734c8900bmr3993917ejh.0.1711350917368;
        Mon, 25 Mar 2024 00:15:17 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.252])
        by smtp.gmail.com with ESMTPSA id lv16-20020a170906bc9000b00a464f709687sm2723321ejb.59.2024.03.25.00.15.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 00:15:16 -0700 (PDT)
Message-ID: <20deadca-48e2-4359-ae6e-82e44651a2e6@linaro.org>
Date: Mon, 25 Mar 2024 07:15:14 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] clk: samsung: exynos850: fix propagation of SPI IPCLK
 rate
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: =?UTF-8?B?6rmA7J6s7JuQL0pBRVdPTiBLSU0=?= <jaewon02.kim@samsung.com>,
 krzysztof.kozlowski@linaro.org, s.nawrocki@samsung.com,
 cw00.choi@samsung.com, alim.akhtar@samsung.com, mturquette@baylibre.com,
 sboyd@kernel.org, peter.griffin@linaro.org, andre.draszik@linaro.org,
 linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 willmcvicker@google.com, kernel-team@android.com
References: <20240229122021.1901785-1-tudor.ambarus@linaro.org>
 <20240229122021.1901785-5-tudor.ambarus@linaro.org>
 <CAPLW+4=jSr6ZsB7XekXsiUBm0SmVpVFnqpgjViuF3=HpT4gRAg@mail.gmail.com>
 <867158d7-0d98-4058-9c2e-6b573ec68516@linaro.org>
 <CAPLW+4=nRjRPdu80Y3izifxQDNUaJymU3di0hGErm1dHry3EfQ@mail.gmail.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <CAPLW+4=nRjRPdu80Y3izifxQDNUaJymU3di0hGErm1dHry3EfQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/22/24 18:09, Sam Protsenko wrote:
> Yes, please leave Exynos850 out of it, if possible. 

Sure, Sam, thanks for the feedback!

Cheers,
ta

