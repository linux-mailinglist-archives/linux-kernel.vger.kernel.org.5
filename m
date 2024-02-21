Return-Path: <linux-kernel+bounces-75326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD05485E699
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A94EB27276
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ACF985C68;
	Wed, 21 Feb 2024 18:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ikMTKqv8"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390718593D;
	Wed, 21 Feb 2024 18:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708541242; cv=none; b=SHdzfFcfgi+mvxSELB+Mcc0f570Q+pqPkF09xLaBsi+2HYxFZB/6pMPys8wcvOQfbHFHT5LYZqDstF/uW+avOzTQblUymT3RJP9ggQPMhpbb8ztO7jJbl4hbGFb8mImEqDB/kRGqMpQcdIBWydZdIIggNs0itu0u8hGx8pG2Oqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708541242; c=relaxed/simple;
	bh=LUU1Rkl4c+QRLz6MyaqjCw9HT8I98TjWteejzBLVee4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kxrPeno16FwXFiB7m3gOFkwdOhd0h5iU2olmZnfexVWKhQI2hsJitU1ccx2hrrCSGZK0U0u4dlZHAjeGJhQcv0A1k9pzZBpg10iAlWxMD1wML2FjR+l3CrRqOoIsph4MjgLgQOiBcEXppyOOjBuHrVSRMWRJZXYIrnq5HprkMCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ikMTKqv8; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-68f74fb38a8so13415116d6.3;
        Wed, 21 Feb 2024 10:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708541240; x=1709146040; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q7SIaGYdisTVbA/n7KzE5hLJekskq0uRcaV69//27Xg=;
        b=ikMTKqv80OeG//5DWdPsjuoHgNRt+yokMy40Pz7tct+tmbOd4VTM/j+8EoFvG/rCGz
         BUK5c5OAC7/3u1gHfLqtYs2LAgi1KY47rurWMzHDum3a3yavo/Od9ksZ6+dKBNZoKLWn
         g7RabCLFvAX6NHgRa5xuNFZkM8qX7Wi768rnGMUppVIu/AGDemVs36p2anncpicqfFuo
         UI3VuHMVBZU3pIBtGRa9OCxC0Pt5KBx8j8fkQC1wxwKbKB3NP5WFluv7M3SC7b1Cu7Ll
         b4MliB1YushxaCR4w70tDT/GoHfjHixPRsUSceHamUpwrh8Dg+FSLvISvm93eICBSw0N
         K77g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708541240; x=1709146040;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q7SIaGYdisTVbA/n7KzE5hLJekskq0uRcaV69//27Xg=;
        b=tt4o2PCCwJPN6f9VOpd5GgFFM3LSJXQ6oc13A9qXzj1jezzdFwiTJdVGmjzhFefCvd
         wZlNEEivCc5gmfAR3sO+Lt8wlz2th7jpzs0dV6pMtQVWR6ccILZV1VRnaWYZL9Nwd/v1
         jSYNzEpgGSnyk1pT04lIphJkoBiHjbM+GbgHXVkW+r4LddbptKRYr0lrFQ50VpKpwD0H
         SnyQXKbuVNTG7MOJpEnTq7JUv0kcfAS6cy5+2pR2B30TLCulJmnJav3pXNAi/Wo2QUm0
         6d5nykT3iyFwOTL3KKQFr2Q8CxoSh4QqMC4e7327/Q+fuCG8ChROE0ajoy17+5wyNvN4
         FidA==
X-Forwarded-Encrypted: i=1; AJvYcCU3zgOoHhpwWvdOZOYrgQim966huFDdoTpgHCyUJE2o7LfIiYrJqiOdqMOsH4huEB7pd5kHWq9cGJLMlmrnyKVYzkhWTUdntvzBa57P6emDCt8Y6t9MfcpxishK7OndpMsqzTqP0VEsQqHSv5uKiael0IsKK0+1TM3NoQ1d4InibWg7VqQxJDyr26Eu9k64w824e4wgH/zcSTerWfZQk2gwCFUz
X-Gm-Message-State: AOJu0YwFXvANTCA5dnGquGcteLzoynzDWvdNOIZymUpaZlF+MCHLD/tX
	+T3v8ffXz5X5E4725YR4Dl8oOoNpkYyfNfs1fcavYMVKPRIwfFmn
X-Google-Smtp-Source: AGHT+IFdbZ328wwAUNMxAd88W261f5wjo6+4Kn7PQaQtkczXw7PuuAqsGk3SFKLmDE8GyF5oAKU83g==
X-Received: by 2002:a05:6214:2a48:b0:68f:3f86:c2cc with SMTP id jf8-20020a0562142a4800b0068f3f86c2ccmr10584099qvb.59.1708541239928;
        Wed, 21 Feb 2024 10:47:19 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id lr10-20020a0562145bca00b0068c968c3b33sm5759444qvb.20.2024.02.21.10.47.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 10:47:19 -0800 (PST)
Message-ID: <d18d4488-aa48-4156-8087-a117664cea7b@gmail.com>
Date: Wed, 21 Feb 2024 10:47:13 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 02/14] serial: core: Add UPIO_UNSET constant for unset
 port type
Content-Language: en-US
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org, linux-rpi-kernel@lists.infradead.org,
 linux-mips@vger.kernel.org, linux-tegra@vger.kernel.org
Cc: Jiri Slaby <jirislaby@kernel.org>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Al Cooper <alcooperx@gmail.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Paul Cercueil <paul@crapouillou.net>, Vladimir Zapolskiy <vz@mleia.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Masami Hiramatsu <mhiramat@kernel.org>
References: <20240221183442.4124354-1-andriy.shevchenko@linux.intel.com>
 <20240221183442.4124354-3-andriy.shevchenko@linux.intel.com>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240221183442.4124354-3-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/21/24 10:31, Andy Shevchenko wrote:
> In some APIs we would like to assign the special value to iotype
> and compare against it in another places. Introduce UPIO_UNSET
> for this purpose.
> 
> Note, we can't use 0, because it's a valid value for IO port access.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   include/linux/serial_core.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> index 2d2ec99eca93..2b0526ae1fac 100644
> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -470,6 +470,7 @@ struct uart_port {
>   
>   	unsigned char		iotype;			/* io access style */
>   
> +#define UPIO_UNSET		((unsigned char)~0U)	/* UCHAR_MAX */

Nit: I would name this UPIO_UNKNOWN, or UPIO_NOTSET, unset means to me 
that it was previously set and we undid that action, whereas unknown or 
not set means we never did.
-- 
Florian


