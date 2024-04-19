Return-Path: <linux-kernel+bounces-151745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B53A8AB350
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 18:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19B191F237AE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6FA3131BD8;
	Fri, 19 Apr 2024 16:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GUxiIJAm"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEA313118B;
	Fri, 19 Apr 2024 16:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713544096; cv=none; b=C6XazGlR/s7h5sPTkRMJKbQ+QuylALro08VEwvJ2Szvm9BG/s16SfZEo8oo1U0XuksKp1dp81oKufQIbzNhL6eUp0F5TfQyCLlzcARo3ue67voJFHnRGicnZ+p4IBVVJyy00tPg1RUVfW+yMMCCXx/yHvwd+4aohh6qWv6vtrA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713544096; c=relaxed/simple;
	bh=QvlnKcfUXd9ghJBIsUKXVa09unyUXlbufFJu5bfaDws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fCpqYzaQoeb1Hr27sxPIEQb0EO1r73jHBgU72XX9GaKsw0msOGntVV75lQ1Tzm/QfaQiNZfpCxnF/NYqxR5+Uvgd6GU9pUOFcQMFopEciRPkHberNQXjc0WFUa/j+LLcFm0YTPaWbTEQ+31dzVODBLq8885jEdqkGxSGkKW8PE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GUxiIJAm; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-349a33a9667so329299f8f.3;
        Fri, 19 Apr 2024 09:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713544092; x=1714148892; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NKvBaK8IulYDHeht15hMBBpdCFxjrVh7TLjc+u1RIOQ=;
        b=GUxiIJAmU+vbLM9hbkiBDczV56cKLMu8me74VA1Lkth5jxwXjM11eCucCNUqolrsGO
         oqpLdGdAqk4ela3IX9y7RGhHRBvRzqr1aBM5+g7NS3cbPJEcBBLkx9gmXdhLOcaACwrT
         pHHx1k/tNLNQJDHuPbQEuriK1c0NjR3TKJyNJEpoWVzu4NF/WX2P0j/Ex/V/bWI0JEm+
         R2eXw2FVTxBKh5WVTdLlEBY7yUePdGmyba6CGe3FTJy/HQB52l2ZO9y6/k9zIfpKI5L1
         l2H5+MsZyRxy7Kpn6BvO5nn6pkqdn+w/DXyk2X9VUwNXCYEMMrvVx3E7XF4skvg/i5Y7
         RUkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713544092; x=1714148892;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NKvBaK8IulYDHeht15hMBBpdCFxjrVh7TLjc+u1RIOQ=;
        b=ubJfyrq8IxFu1nkVab49BvmrFWU1h9r+sATxZGCGvIW8eOBMZ//Arag7QJ7mepOkdM
         Lng2LOpdaDmoMigtAwna+XhwkSgvgTGvU9rgmn9vsdrawjjbivwmmyTDPw2kg10Yxahi
         NnfdTDT/y/iMmFdzsH5V/7cJPDyFNz/nO3bSxGnpRg2GCVRx8d1pFZ9v9kLQLrgX1Q0V
         keO1/FKzyv5YzJDX7xZk4nkwmWv5LsHhR0Zl/WCmyI3lJv5eOuGHg4JOhS03wOc2DdfN
         e/zuZkZvIZysLr9UEvCeWmXL9k5zlZypAus39xy9v5Py26ZTDBIOs8CI8z0Lgm/6XKe9
         v5SA==
X-Forwarded-Encrypted: i=1; AJvYcCWTf0FX5CJ153qiQl1yeWv5sgHTjW+oP9wEjhfr+DUxyUNY7/Y+KfKfcblKZtzaCIcJos1tZAq8+eDcGg6m2Qj2Lg8YVSpQEeT1fez/+Dlv
X-Gm-Message-State: AOJu0YzMJW9WipI6CMZMZAp9xyfP3mdhSVnTorRqF0KkIxp6vDPb8flq
	9vBfdrvHJQtQx9bQFVyKFbBDoDZajcBFRV+7QlusLbfpqJPhjbeeswgLhA==
X-Google-Smtp-Source: AGHT+IGxBbMeD6JeHgbcoxTwOlr8/cHIKrumJiQ8lj5PZ20CNcGeGXoJHXDV0DoRchV6zbdmfc41sw==
X-Received: by 2002:a05:600c:1c9c:b0:418:ef65:4b5f with SMTP id k28-20020a05600c1c9c00b00418ef654b5fmr1848314wms.3.1713544092302;
        Fri, 19 Apr 2024 09:28:12 -0700 (PDT)
Received: from [172.16.102.219] ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id j1-20020a05600c1c0100b0041895d1c7bfsm10900543wms.42.2024.04.19.09.28.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Apr 2024 09:28:11 -0700 (PDT)
Message-ID: <cff8eeeb-ae4c-42b8-8a85-4838959c1e28@gmail.com>
Date: Fri, 19 Apr 2024 17:28:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] string: Merge separate tests into string_kunit.c
To: Kees Cook <keescook@chromium.org>, Andy Shevchenko <andy@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20240419140017.work.012-kees@kernel.org>
Content-Language: en-US
From: Ivan Orlov <ivan.orlov0322@gmail.com>
In-Reply-To: <20240419140017.work.012-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/19/24 15:01, Kees Cook wrote:
> Hi,
> 
> We have a few lone function tests (strscpy and strcat) that are better
> collected into the common string_kunit.c test suite. Perform various
> renamings, merge everything, and clean up after them.
> 
> -Kees
> 
> Kees Cook (5):
>    string: Prepare to merge strscpy_kunit.c into string_kunit.c
>    string: Merge strscpy KUnit tests into string_kunit.c
>    string: Prepare to merge strcat KUnit tests into string_kunit.c
>    string: Merge strcat KUnit tests into string_kunit.c
>    string: Convert KUnit test names to standard convention
> 
>   MAINTAINERS         |   2 -
>   lib/Kconfig.debug   |  10 --
>   lib/Makefile        |   2 -
>   lib/strcat_kunit.c  | 104 ------------------
>   lib/string_kunit.c  | 258 +++++++++++++++++++++++++++++++++++++++-----
>   lib/strscpy_kunit.c | 142 ------------------------
>   6 files changed, 230 insertions(+), 288 deletions(-)
>   delete mode 100644 lib/strcat_kunit.c
>   delete mode 100644 lib/strscpy_kunit.c
> 

I tested all of the patches in the series with kunit_tool, and 
everything works correctly.

Thank you for doing this!

Tested-by: Ivan Orlov <ivan.orlov0322@gmail.com>
-- 
Kind regards,
Ivan Orlov


