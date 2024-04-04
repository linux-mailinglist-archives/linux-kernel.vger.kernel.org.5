Return-Path: <linux-kernel+bounces-131044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07839898253
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 09:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58CFC1F29BE2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 07:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4515B1FB;
	Thu,  4 Apr 2024 07:41:42 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639411CFBD
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 07:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712216502; cv=none; b=Om99IyK7fynHg+8jzu1BXi7HeQcMHgQTEgkcp3dV6WmkNZWTVBTKzP/OGRvTG1+hogJbAIugR6bnlSE5xpcTTb2uFs6kcJ8niZS2Zvl8K6T5DtEAeNsCidSP5YU5JxFdC7ut05jiqrRBVQQntGM904mVE0AoTithkcI5yMpcDhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712216502; c=relaxed/simple;
	bh=Ior+dp/Myvyx8DDqC8/TDNbfggvtW4FD5QOKYwJ4qsE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H+qP44Ok4Eh/TvmuGbLQoG/Nsq3/4PWWPxO5XBnnc3MCAU8ZcArZDJDKEreXg5n7+0LwDwnqfolTsyb3BKMYr6VvcsGHqRKiujEq1QZQE53BawnyL+DUGxUl5sAyTlEJ/lP1A4KsaPhnjIUDiz8dtEEZUmXtvkTWLoSEzF6UVqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3437efea211so592502f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 00:41:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712216499; x=1712821299;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4YTmrklZRV6jW/HZ0TsvAHosNpfgWBD5hKPM6rhkzbM=;
        b=poUBjLTDXY+nuVaIQj0xwKqnNHEWjEP4cRf+RcwoJHvKipob2iTXAiagzRLDZAKaio
         nLr8ZcH8NrAXX1qnZK2W7pJ3Pj7Wmgrqp/u1oorVj/CXR8Cn/jTOgJhegFIS4HISS3MG
         I1HFmYFhfaTxuUOA7ZWntOnTptNBUXF5779uDG2GRJ41jPh9rFXtee45x/EDi0HkOaeg
         ww8aqknp7jS0N5EMzLOxp238pKqRg3cckQSB1CadvBmQh9mJlJsvnghjarRIOFQmx+qn
         20rnTO4vUV6w9sEiMfmsWJ9EjfdyiZhHAtkcjxbHoAMEsuvMVNo5dBt8y/TGnMZ3JLhg
         KZXw==
X-Forwarded-Encrypted: i=1; AJvYcCX+6D3+doOY6JUmhISA2o5gV8p0Fv4Ss2E2LkHw/aZ2lXt55Jt5pP6wA0YjHWGjunV7aQXRP9iJznSfJqAIFbNmpb/J59hrdx9reAZQ
X-Gm-Message-State: AOJu0Yw2d1BKDmBwH/pgNbzMXFq32jQk0r3m+DAwUbfkS6MnuS9x/kXI
	/IW4LxR9NzSQdYPcBJaO1WnXmvSG3p3B1AuuiNzpFH2Crvwuk7mt
X-Google-Smtp-Source: AGHT+IHaD1T/e8RsDqYeRVmqhYBOA+3EfaRSAStSpzoIimsoMqwP10V0vpfkwb4HawPU1HcGYGTMHQ==
X-Received: by 2002:a5d:6283:0:b0:33e:dbc0:773 with SMTP id k3-20020a5d6283000000b0033edbc00773mr1494228wru.44.1712216498574;
        Thu, 04 Apr 2024 00:41:38 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id ay26-20020a5d6f1a000000b0034355b7e995sm8350225wrb.13.2024.04.04.00.41.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 00:41:37 -0700 (PDT)
Message-ID: <528c6824-287e-4be2-82f3-7fcdd254eb15@kernel.org>
Date: Thu, 4 Apr 2024 09:41:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tty: xtensa/iss: Use min() to fix Coccinelle warning
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: chris@zankel.net, gregkh@linuxfoundation.org, jcmvbkbc@gmail.com,
 linux-kernel@vger.kernel.org
References: <fba2102e-aefc-4be4-905a-57061c1f8cce@kernel.org>
 <20240404073801.5716-2-thorsten.blum@toblux.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20240404073801.5716-2-thorsten.blum@toblux.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04. 04. 24, 9:38, Thorsten Blum wrote:
> Use unsigned size_t to improve len data type and min() to fix the
> following Coccinelle/coccicheck warning reported by minmax.cocci:
> 
> 	WARNING opportunity for min()
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> ---
> Changes in v2:
> - Use min() instead of umin() as suggested by Jiri Slaby
> ---
>   arch/xtensa/platforms/iss/console.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/xtensa/platforms/iss/console.c b/arch/xtensa/platforms/iss/console.c
> index 8896e691c051..d2380767f3a4 100644
> --- a/arch/xtensa/platforms/iss/console.c
> +++ b/arch/xtensa/platforms/iss/console.c
> @@ -167,8 +167,9 @@ late_initcall(rs_init);
>   static void iss_console_write(struct console *co, const char *s, unsigned count)
>   {
>   	if (s && *s != 0) {
> -		int len = strlen(s);
> -		simc_write(1, s, count < len ? count : len);
> +		size_t len = strlen(s);
> +
> +		simc_write(1, s, min(count, len));

So do you need 'len' after all :)?

if (s && *s != 0)
   simc_write(1, s, min(count, strlen(s)));

sounds good.

>   	}
>   }
>   

-- 
js
suse labs


