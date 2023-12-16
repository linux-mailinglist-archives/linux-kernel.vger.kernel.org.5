Return-Path: <linux-kernel+bounces-2381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B7E815C0A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 23:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 481601C21524
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 22:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3625F358A7;
	Sat, 16 Dec 2023 22:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DqkRTEKL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7AE36AE6;
	Sat, 16 Dec 2023 22:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-67ee17ab697so16830006d6.0;
        Sat, 16 Dec 2023 14:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702764473; x=1703369273; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jwJtOVzDALEiJLugl6CGKr+41IZkmLCFTtfJq15ISN4=;
        b=DqkRTEKL4h/rtlHt8Pn94FE1e3ODKansgseDG738nFP1TQbr3aEV/EahzJH3iLIwY2
         oB07uFa1Md2nZAWlcwMNC3QwJkuTgrUFAo6+wxWUl8wPjPCINNlkE7SIN3Y0O3qeBYCK
         TnGj1lJqhTz0GNsBZ9kiffOXDBulxjh4lF8PWMDuQBhK4/an5lp2hMxRkei+OGarHVMF
         gfJtXTUpHTbfwlRnsW8vJ4AZOPGitkjYO/QvzNETwYBHR/WeFMBAP8Rnzk6qp97RcPib
         33pMpujQOdqSiO8zEgdw98gtYXg2aZpy0RIniBvyOx7avD264JMW38yAU5pLWwbTuasE
         wLMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702764473; x=1703369273;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jwJtOVzDALEiJLugl6CGKr+41IZkmLCFTtfJq15ISN4=;
        b=vRscS9VdOLE2NyGjjtO+N/7e93VAf4yj8frLALys7sPTdTejBvDB/2TqkCH8AIl38e
         VTnFmDWlULP/5sgJv65kpMFE8H5MT3ApZSPRni7JF2zWhlvfzLSmfl0Zk3PtqGtxQGIL
         eB5pCLjuGwFJguYfOdtx6Hm2rne4X1H0VI1Ab4HgENT93qK7MmpJVJCSh5afK4baTlKc
         3z9Id2SN9L/MSwtUHoIk1Y1UPHGjDouFY9WkPUBFF5a4iVADU9MZ1Ed16YUd31M9kUkY
         6ifx/xa1s2mKBbMASonmUVJS2fgL5NehUIb1/jbNQevM8ztbUI85VAjrXahH82jX4dHi
         Deaw==
X-Gm-Message-State: AOJu0Ywm870QB3VibPwOOKyYTvXXSHFwC7tA2SBzfjSzGk2lpk+YiUU/
	lTfpoOCOV2TcukorOn1cIKE=
X-Google-Smtp-Source: AGHT+IE3+UOgYbTWfDhQYqYlMvxrqc3oL7PkPxf8DD+XLHf9CF2u2jUNttsRs0fbcYgsJ9isAUifTQ==
X-Received: by 2002:a05:6214:1023:b0:67a:be9a:e9df with SMTP id k3-20020a056214102300b0067abe9ae9dfmr15601156qvr.17.1702764473088;
        Sat, 16 Dec 2023 14:07:53 -0800 (PST)
Received: from abdel ([174.95.13.129])
        by smtp.gmail.com with ESMTPSA id u3-20020a0cf883000000b0067eec0ef4b7sm3122821qvn.66.2023.12.16.14.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 14:07:52 -0800 (PST)
Date: Sat, 16 Dec 2023 17:07:42 -0500
From: Abdel Alkuor <alkuor@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/2] hwmon: Add AMS AS6200 temperature sensor
Message-ID: <ZX4frjGqOGb4zMmx@abdel>
References: <149032e99136a9fe47c3533b57a71092646e497d.1702744180.git.alkuor@gmail.com>
 <63e352150ed51eefce90ca4058af5459730174b2.1702744180.git.alkuor@gmail.com>
 <aa93010a-7ab0-4b9d-bb5d-25ea15b81120@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa93010a-7ab0-4b9d-bb5d-25ea15b81120@roeck-us.net>

On Sat, Dec 16, 2023 at 10:46:53AM -0800, Guenter Roeck wrote:
> On 12/16/23 08:39, Abdel Alkuor wrote:
> Please explain why the lm75 driver would not work for this chip.
> I don't immediately see the problem, especially with TMP112 using almost
> the same configuration register layout.
> 
Hi Guenter,

That's a good point, tmp112 is very similar to as6200 except R0/R1 and
EM bits don't exist in as6200. That being said, the current config for
tmp112 in lm75 driver can be used for as6200 as the default R0/R1 is
set to 12bits which is the only resolution supported in as6200.

Should I use tmp112 params for as6200?

Also, can we add support for hwmon_temp_alarm and alert interrupt?

Thanks,
Abdel

