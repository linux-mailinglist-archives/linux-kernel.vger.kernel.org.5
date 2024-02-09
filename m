Return-Path: <linux-kernel+bounces-59095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC58484F122
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 08:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6AF01C21452
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 07:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6968665BC4;
	Fri,  9 Feb 2024 07:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QMZ6sjR/"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38BC65BB7
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 07:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707465416; cv=none; b=Qkf84h4dnj5vx7CkePegYonSCZkjKrOHHa6BnrB1YwU4RNfVtIVEOqb78VV6SRVTaz/PqSv+zwPhjeOdVmppkMjRDwHd1+0jK8cFwgQ9NVmgqluXYWwMIEgrqU96wLRe1dgNhSNJtYj8cwX9RRoTrnKxMRdcibC96zzBPAMBZGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707465416; c=relaxed/simple;
	bh=2i+wHHIMHFIA3tShi/3MXXZIYsXEC76xkIKh7ZZzjOw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NJm9basFm2MePWt3NOdhaRYQFZvIv1OKOJvP1tyiQf6oOMfFQ3mo+cwX6b6T1XLCFLLkBPy8qiZHOqR/T77PLU9Cypxw5MkWni9r8H1k+9n9U2It2YRaPJyMWrS835Bo4fPcglHdiW9pqQHVJ5LJPMqGgOAKHEYOkdgxSXC/Kdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QMZ6sjR/; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4105a6be071so3409115e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 23:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707465413; x=1708070213; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NFU6VprDaen7RWlu2XI3+Yx/fXxu3FdETMuSYSFUvtQ=;
        b=QMZ6sjR/OOYMYJW8U6VcD+5fcip/sqPf8u/fS3H58DlQx2qr04xhp8sXH6K3fclwwJ
         irCTNBUr8OKEzEoJBUEj6rBbd9XhMK0ayVfVz/eVsJEaqt5wxZSMDjCklj/NQMK8Hzv2
         /xKaS7P3ROZZTuK/X2D6IVAadjj788CbWTG17p/BHGCKye8Vn5Ir19PEUiOH78JRrCm9
         OhxXcHUbW8e1m8AhVOrc4iTFdROBKMCCqKiqHqRCMFc3PnyFjxgw1ru/ZmfIGXtbLsQz
         xhQqiLNNqu99crBnJn1UethLJrqqK1DxGAkg00RhMAZNVQzaMvBP9u5f8IStfa1RI3JY
         DTMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707465413; x=1708070213;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NFU6VprDaen7RWlu2XI3+Yx/fXxu3FdETMuSYSFUvtQ=;
        b=AvKmwOYPoHmw69GtxkPng+5qlfHtJH1EojZ4+i/FSK6RqB23xJmqVBqXiM7t44yMyP
         YLycuchsI9PaYV371EaETC5bqMe++pSBGzyt+TEHwuuWI/sCMcdrW2WUzhq8yY9ikzNK
         A1GEVSPU/LihxtlwsMvlfkG8dG5PAlC0FFkorggHfRueZOD1d6P+SqupsTDwKNIj9wHQ
         nlMHmEibpuEzqhZy29plwsCVJo43ZZMKRWnciTeGJ8pkJsbCMVx7E1omX67UsvtITgk+
         07/LExaX4RSi5vAgMbSh9xMirlFv/e4zLG6cQ/Fl1ffRg+l1Av+0u/kscl/tHgmXCgGi
         nZqw==
X-Forwarded-Encrypted: i=1; AJvYcCW62OAQ2t5V8XQR9bzlfVhOtbD/CgjwZ0FK70EO0IGrx0i5PDFWGPAZurRj23phRAslsUcRhgZyqdTkeHr3eCNOsX0K0RGNl9SIopS0
X-Gm-Message-State: AOJu0YyEb1yu4H9n3uQPojW/kR7ziGXcIHfjRd0CLA1j8URTJDiUGHzG
	cX+p/FZY8qeHV5N/VlNeophuPwygAy4p6M7OegtPD/LSzZ52FxuSpUJWNM8PBo4=
X-Google-Smtp-Source: AGHT+IG9JKWy/OdmVlDi6L1bm3QCVsr289K5642r1rNClNPlq4kkh3auBxOrGrrAAdShft0u+A+2QA==
X-Received: by 2002:a05:600c:3512:b0:40f:de25:f9a9 with SMTP id h18-20020a05600c351200b0040fde25f9a9mr310418wmq.15.1707465412889;
        Thu, 08 Feb 2024 23:56:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVWFoFId/14WV+ApBhbMyPMSsicb8EGs2yBnvimkUV9gu2+tr2WSrz0cLKefemk1gFIFD8grfEQnWvPnIRIjB8zpfVgnPZYf5G8tiesgCGr2a1CQtjbAaIWxjjGQyw3V2YtvrDumIJsPP/1T5ANZdVhkMFLQnoLPmkXnythNselXwVMjjyfqFc6aGEKNnrvKrA6N8vD/kwLrDyImWR4/ov/3jTgpMXj/iWuB8vs/2a12e2oL4gYIUvINCNAkZMwOYwEIm7pVjQGyDCKWsAfNXJ+gaESaPE3IBEzvRVkETCnUV8uU/pv1Vew1ETpWE/mhp0BDLEsGyo3qMl2nmtl8uvVd4SennKcDJ7gk3kxaIVBMpeLevQ5KuyV5+uywI3McKvzjm94GEfsHDwngUGY4D46KeJvWmffvyBZzGv+0cWG7Q6GuSIQVUERFwSJMH2oQsptbOVZEiDFY8ZedngHeYaIDFP3UDuOkjvDHBKLdCIydG8cGafNIj31mxJtAA23XoETRkeQjsdhw0MGLYnzvjEAOGLLZD/Kf7fXK+jpdxxgGKEzvuH/RksM8G+WTgYklw==
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id bi19-20020a05600c3d9300b004107219c664sm559395wmb.32.2024.02.08.23.56.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Feb 2024 23:56:52 -0800 (PST)
Message-ID: <2ca67a77-b51c-4f7f-828f-8d91d8971c75@linaro.org>
Date: Fri, 9 Feb 2024 08:56:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/17] dt-bindings: clock: renesas,rzg2l-cpg: Update
 #power-domain-cells = <1>
Content-Language: en-US
To: Claudiu <claudiu.beznea@tuxon.dev>, geert+renesas@glider.be,
 mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 magnus.damm@gmail.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu
Cc: linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20240208124300.2740313-1-claudiu.beznea.uj@bp.renesas.com>
 <20240208124300.2740313-7-claudiu.beznea.uj@bp.renesas.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240208124300.2740313-7-claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/02/2024 13:42, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> The driver will be modified (in the next commits) to be able to specify
> individual power domain ID for each IP. Update the documentation to cope
> with this.

You are affecting existing users, so you should explain that you keep
ABI intact or if you break it, why it is fine to do so.



Best regards,
Krzysztof


