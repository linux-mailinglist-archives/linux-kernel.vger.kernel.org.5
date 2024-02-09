Return-Path: <linux-kernel+bounces-59150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD3084F228
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 10:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A94C01F2A03A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 09:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D16A664DD;
	Fri,  9 Feb 2024 09:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m/IebFax"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAF7664C5
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 09:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707470326; cv=none; b=GsRcg0ZHF2Wu035bBvOh9RvJngL8fAvIEczIJGb31jC7s7fxc3G0A/wAg1nGyXsGfjsv3L3gNCbj+qRuP8nNqc435ZCE2sKVReH6s8pXsDemw9xSCEmdx/nSZNdLDWp1A50/9YRh0RN8PpEnLyympO2Fy3CoKD2EeyJpMBQ7tF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707470326; c=relaxed/simple;
	bh=FuiLMUNR35fAc1/d9wihkrvfiBpf567FylCxKmHhmZ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j1UVs3WyebIsi4j8+34bZgIERYDZ4WqSwvIW5VID8R0OVG1ydYi76fQBJnGOs369PkrEqXz1uBiBaYYV5ag5neJFfO3bL2ljmkiIJ/XYN8hO4m/zUgCzKnkNS/lZcCt4ISGEaO3nZE2j1eVsG2+OJDSHnfSV2wHhPF+8IcgKKS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m/IebFax; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-41059577f26so6721185e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 01:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707470323; x=1708075123; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J4gYgBrA+9Uu/Lx4Jd5+Im9Pi4snmBOhFNslLS19f9g=;
        b=m/IebFaxd9JjOT6r88qRmea8qIBxSXO1kVkL1Ab6Iv0WT7cfP+LR8WYUUvK66Vhfx6
         uz7YR0ASnpaFcdShuqMlmORx9Rn0iVH0ls+77KfTwXqrEWGjBzgLmoJnGPSFj+UoESDC
         YqVYDlJro8VeXSJjxJ+N2c/1wxl68SvOmrWSMiPZWzu0ZNydTtmjZH5/x2pbw5YAiJOG
         KFyKSaFupo0kNGGI5kpggnTIprf5Qr57f919UrQTllEZsRSVYI28b8Y6xS4uu7ZGNAfO
         sund11rC/pO7g9qwfBVClnlt6b8a/+BAZdBpmSQqRZxxIdeHkib0+A3q+Pu8f4PQsIXc
         E9RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707470323; x=1708075123;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J4gYgBrA+9Uu/Lx4Jd5+Im9Pi4snmBOhFNslLS19f9g=;
        b=YS82TMn7W/nHptGuG0+5ki1VvTUX7RMDdybfzRCGi42DYtKEJ9hSVvdoQEnInAbG1J
         Ev5JHehrw7fNaqs3dG5vN2U/s2z39JrtZCAmNfNf9k9eF0WUfpH5J2SKVFidD7/nDre+
         AGwWakW2fQUVE3JjpUa3u9DiKoboImnz9iErlHfb48ZqohIEov+thswC4eRU0aRnHFSs
         jUiepR7n0x/keKmLPhjqPRnPOHR3ZntpSt4fBe8DI6K/vSv2zBm3+wDeF9mc/sniyv5a
         dEzGoVa76u5Wsx6N8zxeeJgXOGWsVsYwabOWtCs+kW5W2Z3vABaHL3sSr/pwnptCI/jE
         4M9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXXBU6JEUKcCfw1AVWDmjdN/C0MvcF51y9cjVZ0AQY4Rtn0LM1oIp0GMgJEH7EQOYSClF5yj0VxbjTDo7Af48Bn/FlIG0tf/+wDLzAm
X-Gm-Message-State: AOJu0YyAlmLhN93wLpzX6JGZ95/8N51h1Em3eqs/7gSvJv50KwITYOvt
	1DxOaWajM0h0eSSt8x4znnPUF4Ht28fefpjX8mTBZ6s2jvgcmThFiPKw8joRstgdTIY7Byi7bpx
	S
X-Google-Smtp-Source: AGHT+IFn/avJYqYixpBgOnKGNv+5CyG3V5HPjz3fCHwdCDT3BVG+cO+KkYI5QoOV+TjiChZMS1BNTw==
X-Received: by 2002:adf:b192:0:b0:33b:5239:18b1 with SMTP id q18-20020adfb192000000b0033b523918b1mr751139wra.5.1707470323558;
        Fri, 09 Feb 2024 01:18:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUag55xM+7F1agl+K/rspIBp3elaL2nCxxl946xljQE6m8/td2h40VXWRDCeUpFjYXDXN6EOVzBUud563kE78/wgvCInx/s6D4407BEPIvhQ40dFveAGNKRpNIy4k5ZT/zTWjVm2Sb7SR5daPCCktSZ5HfNpBL7h+PSZx2y3XarxvkLytxQ1/7gaORRTmvVXpJvPeRV8MWjjStszweq8dIT5RCfbzIp30AjDm5ngZerIdiqW22yP1iYMukzJ6uG78WbnGnqs5uytmBZ+sBe0Kt5awg3LiGv+/QmW8c0QybqpA4YxqZV3RlyRSkDM+KgfjAHQOJ7bNY1Cg==
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id e5-20020a5d5305000000b0033af5086c2dsm1295848wrv.58.2024.02.09.01.18.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Feb 2024 01:18:43 -0800 (PST)
Message-ID: <7760700f-8dd0-4d4c-9f19-9bb525dbb7e4@linaro.org>
Date: Fri, 9 Feb 2024 10:18:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 14/15] dt-bindings: auxdisplay: Add Maxim MAX6958/6959
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Miguel Ojeda <ojeda@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Robin van der Gracht
 <robin@protonic.nl>, Paul Burton <paulburton@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>
References: <20240208165937.2221193-1-andriy.shevchenko@linux.intel.com>
 <20240208165937.2221193-15-andriy.shevchenko@linux.intel.com>
 <20240208-chute-bacteria-75425bd34dc9@spud>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240208-chute-bacteria-75425bd34dc9@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/02/2024 18:50, Conor Dooley wrote:
> On Thu, Feb 08, 2024 at 06:58:57PM +0200, Andy Shevchenko wrote:
>> Add initial device tree documentation for Maxim MAX6958/6959.
> 
> Why "initial"? Are there elements this display that you've not
> documented yet? 
> 

Why there are multiple versions of this patchset? This leads to
different reviewers commenting in different patchsets?

Andy,
please implement feedback given to all your patchsets...

Best regards,
Krzysztof


