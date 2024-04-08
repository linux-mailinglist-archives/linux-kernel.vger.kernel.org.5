Return-Path: <linux-kernel+bounces-134855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3236B89B7E2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B08C2281F5F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 06:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2255F1F93E;
	Mon,  8 Apr 2024 06:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XsJUhdhX"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A78111A8
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 06:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712558899; cv=none; b=lcP/OrsPgvvhfKcR6h3JHUU0m3K6tN8Eg9ZoSGtSbydTFCXXeMvc3XN+LLnFvj5t8gdhNrTciHjJUCubC3Rjj+1nrLeDbzs41lHmVhkfuNjH1SU1vFvLhhYdAvq2pKaDFjw28/OlWs62V+KZSZoNTQm2mtbFGt7i46jXgNnHI9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712558899; c=relaxed/simple;
	bh=HyA+6mhstgVPP/a7zFiKijsRqPoKdO1rUjEHmFlUNbc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jGEvv74C51KYHzJZwnh/d/OiWeAgFbrw3mSQV6Ng6A9B/FjHNKa5DoDMJYimTt/0RT0bf9+EhqOygztBJvY9C/uBZyfx6chsaug30l/t1PABaLCc82ugsEClFhL2jhCDYomiWMlBPmQIfid2CHmaEVInDuDayQvdo6T2ErEkhjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XsJUhdhX; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-343f1957ffcso1228499f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2024 23:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712558896; x=1713163696; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yI1uiCLOQpv/+K4dcA8iKWw5IGXMa3uNcLHhqf2sN4A=;
        b=XsJUhdhXB6J/LKHXTENcD7NrTLwg5w9mUNzd99N5CmJdZulXYvxrZcvmncrWjI1f/e
         H33FBM8+zUDpFwQ+KyGOtrh3V7FFrr0Q9zozgAC6zXhk+nv86CAtDc/Ao4qS80BcOUrr
         JypRJBXQEgxvDVE9byc9XLyPea2Ofn7K3IPTnZzQYAFMT/Qpq/7bBCBoLg+rWE/b3Kvh
         MLXxphOUlozqZ84GLWXFUGy8v/wjyHCZcVerawLx8OHmncUwPY6qLYI8LGEwm8n5bshM
         Vkw+ETw28cSJXPvAUhQob/whcVGlJrJFA+J9do0FcPy10FTAx2MOvREklDlMbT6P8GOW
         PzRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712558896; x=1713163696;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yI1uiCLOQpv/+K4dcA8iKWw5IGXMa3uNcLHhqf2sN4A=;
        b=lC+hHSDH/64I+2CsiYyorKVLRvDHs8tkRI7tVzohU9b2NHqBh1YpOaa+gGk57Ca77j
         9/HlYCjREQioXOcsXsekjRnqMFzZQCHffs9x2ZrR+00BJ0A0hVxyos8aifiU7bCyL3R6
         AAlJz9bNDmmoMaoJuzgozCrv6A8BWBNU9K1B2xj81CJt+HG1aCbIeA76pIQ/g3RSbjF3
         FWe/3XXZIjwtSYxMIwEHJ8Sy+VPR5qEm0p08ckcW3oxuTIF/JKalZgZ8qfxBm8IO3TUh
         oE6Vgk+LXOUu+4DYUgJslLYmhgB3JXH696azo+s4wdoF/xOoRk3cwQZ6WKdxEr6vGE9H
         Az+A==
X-Forwarded-Encrypted: i=1; AJvYcCUoiqhaDCZ4Gkk+qISx3OLch20fNhpMC3WoA9Z2qdAanMM3Da8eKn6Yy9eni2aZArF1+3GV7emegWMb+IA73PMttDipUJGF/sEXJsjx
X-Gm-Message-State: AOJu0YyQdjvVYsNOB2r2uYdFMgulXj36Mj9sMMx4Ly3B6IYYyy47qwFs
	ViYEMTwr5tXD2ESR2rpWUc8amWDdyWTBqeVoXl3jlYr5HU8ArQabDCeZ3QnSrso=
X-Google-Smtp-Source: AGHT+IH+1QZmvQ8bMeYKGXg67Cc2kEziVs/rt+NYdYh5OhJtziQcmomn8MuoreErTdomBvfGLtYCgA==
X-Received: by 2002:adf:f24f:0:b0:343:7ed6:765a with SMTP id b15-20020adff24f000000b003437ed6765amr6382151wrp.20.1712558896082;
        Sun, 07 Apr 2024 23:48:16 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.144.67])
        by smtp.gmail.com with ESMTPSA id w18-20020a5d4b52000000b00343723c126asm8162013wrs.48.2024.04.07.23.48.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Apr 2024 23:48:15 -0700 (PDT)
Message-ID: <17e04ad9-350a-4f6e-b932-9881b7898c5a@linaro.org>
Date: Mon, 8 Apr 2024 08:48:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/9] MIPS: debug: Implement low-level debugging
 functions
To: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240326-mips_debug_ll-v2-0-b64abc76f2a1@flygoat.com>
 <20240326-mips_debug_ll-v2-2-b64abc76f2a1@flygoat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240326-mips_debug_ll-v2-2-b64abc76f2a1@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 26/3/24 21:35, Jiaxun Yang wrote:
> Currently we have three sets of early debugging functions
> for MIPS: zboot putc/puts, cps-vec-ns16550, and prom_putc.
> 
> This is a attempt to bring them all to one by providing
> a interface similar to arm's debug_ll, which is very portable
> and allows you to support new platforms easily.
> 
> Two examples of output interfaces are provided, including
> 8250 uart and MIPS UHI semihosting, which already covered
> most of the platforms.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>   arch/mips/Kconfig.debug        |  80 +++++++++++++++++++++++++
>   arch/mips/include/debug/8250.S |  60 +++++++++++++++++++
>   arch/mips/include/debug/uhi.S  |  48 +++++++++++++++
>   arch/mips/kernel/Makefile      |   2 +
>   arch/mips/kernel/debug.S       | 130 +++++++++++++++++++++++++++++++++++++++++
>   5 files changed, 320 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


