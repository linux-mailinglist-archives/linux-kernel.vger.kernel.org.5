Return-Path: <linux-kernel+bounces-33010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C8C836327
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 13:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5EC21C24184
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232053C08F;
	Mon, 22 Jan 2024 12:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ULQV3npW"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DE33BB21
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 12:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705926259; cv=none; b=EOtaxzWgbCIuHqMvFU7BRzm++QtBvac0Z4yE75Vwl7+v+Fv+lUZFnG40iv42BHMEyo2tA5wigpQNKF+9Q64fhwGWi08cpgckMaU2IIJtJFFcJsorR5uGrCUwKy8qdhfaQ3FzM5rgqa6nTPmAjy3K7JTll6frtBEW2WDiuZD/QuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705926259; c=relaxed/simple;
	bh=Vz32kzkbeL2Zr+wgLX6Q7B1/7gOSnu296mUulHULbq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H2oPPUsWMO4ZDtofWSJSD5l/hVLJtHDYg1wQQmf0+F+bqnvBJsZm303b7vZrvIUVxI/7VWg6fZwMxsqv17JsA8VYaCDsLrQQFJoxxYYjbjKzE4tj/fHPFvLPdO+vaqy1jduKspmOPYPpQWo5SYjM/C5Yk5gqBpjzp85zMTdfjyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ULQV3npW; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40e9101b5f9so35568235e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 04:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705926256; x=1706531056; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kZJGpEI+8uNMExqErbVnz4UqS42fV5fp6AD62CM0PWE=;
        b=ULQV3npWG1oxm1n8AZiM4rVKNtfcWxe0wxWdZmo9HV8nmQZNhaNz5oIv2IIsjM9lGm
         GkXSrfvwk0TbCjzQCD9tGtWHUE/YEqnNpgFmivYf8Kq/+jKPwFWwUyQkVW5NzpR60p1m
         s/CxV5JkJv+LOFDintKT23LvDKNNNBUAtIpmyHvmXskjQFqFLNsjC/S8h1e+LIAIhDqJ
         NfbGN3AV4OPbzGC/yzauvw3bTsYFoLZfa2Ked867MK5BEKzh/IywGT3FxxFPWGEJQaz/
         7BnQFj/fnaMET0rSJMfkjPn6XG06zMcsoY4bOAuluMaF9e7BV6iXsUhYIbuNgwgbZgD3
         9dQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705926256; x=1706531056;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kZJGpEI+8uNMExqErbVnz4UqS42fV5fp6AD62CM0PWE=;
        b=k2i3G+5dH+dni9sFf7zXpSSvDJf3k/ynI1o/cbOf8fAMibeYGosXJGoAV7QKurmxYy
         I12S+llfqoYz3n4Tvr3wz1GAuD46DZqooN3wbYUB/xWoyAOKuScDeBoXkQ1csoXextsZ
         eYUbPGOVukLEbn/uR2yXzqoS53MyjozxQgxAu4BHukRzdjsOeylS1QFy2DBr97SMvfxc
         WFboKaBjFjXqqx2MdmtM+ZYFttRv7iIGbDMCkhwfiTHT1zeAAtz7dWIdlb5wx/Y8y7pd
         DQi43uJnk1IoaSdPlAIvgt0JEYwRzc/fEhoByxPN7gPsLHpOADXOUa/zFz/duWWmweKB
         QdOA==
X-Gm-Message-State: AOJu0YwXvOpucbqXitgLMqa/zsS4qk4Sr98tAnjGB35HXxWTNnZNTStj
	D4iL3i7u0WJHS32AwLym3dnoThI6kdeZ5kikF2MCskdMPXBAufw2RBvcmeKfeG4=
X-Google-Smtp-Source: AGHT+IFVdv96gsMr1qQIommC2gSuKrxPezh5tWaaYCPVKl18rbSddGGUdJfOXSm2951n3lqNLi9ikw==
X-Received: by 2002:a05:600c:1554:b0:40e:7dcf:69ef with SMTP id f20-20020a05600c155400b0040e7dcf69efmr2177240wmg.10.1705926255890;
        Mon, 22 Jan 2024 04:24:15 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id z10-20020a05600c0a0a00b0040e4bcfd826sm39688484wmp.47.2024.01.22.04.24.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 04:24:15 -0800 (PST)
Message-ID: <ddd6ab2d-095d-4d05-81fa-75f378da357e@linaro.org>
Date: Mon, 22 Jan 2024 13:24:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clocksource: ti-32K: fix misuse of "/**" comment
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>
References: <20240120173624.16769-1-rdunlap@infradead.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240120173624.16769-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 20/01/2024 18:36, Randy Dunlap wrote:
> Change "/**" to a common "/*" comment in a non-kernel-doc comment to
> avoid a kernel-doc warning:
> 
> timer-ti-32k.c:42: warning: expecting prototype for timer(). Prototype was for OMAP2_32KSYNCNT_REV_OFF() instead
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


