Return-Path: <linux-kernel+bounces-49686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AACB3846E1F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D5E1293844
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC27C13BE92;
	Fri,  2 Feb 2024 10:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fOeCWLTy"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8112628B;
	Fri,  2 Feb 2024 10:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706870430; cv=none; b=XJh9D5LSmqx2Dnqr470Nx/4IhIAZu1SEeUt/xratEel49upENg9yZCQOYYsSq2hT/YNrt+Xe65xugk73Dd5XAoZutP5a5zLkhTKS8EoyUhUhfqgVHzkht+8NcTEGLPKg9BKKF2/rMtv4KB9egxjfUfYXj7np8UMkFXQvAaWCGRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706870430; c=relaxed/simple;
	bh=TLymezzE5+r0wlZC85xmYHZmI6YZpMuucXlhRm0pcTY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=F/JINvj5hcjfS1gAdAwv6di4xGoPc/MfjcniGTMzG1iKuQ8YQ+yGez8/S+DsWWe2fcCDzr/8mKIMPhDQmQPor3kAUexnVbmzA5j0o+TbxJB2sPrRIuPjTwpPh4y7eqxFoA8sS+cx6XqQS74Cn2DjbLjGMKkzqcIF5j/cN94KcMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fOeCWLTy; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a359446b57dso248794266b.3;
        Fri, 02 Feb 2024 02:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706870426; x=1707475226; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yr18VgKkUR0Z6xA+Bp01IdzSAv15CAC3JbNxjaal7xE=;
        b=fOeCWLTytEfYLS5v1YJWd+ZVymGQ7FW08cJ1DffK/09AUn34WOfFnfgVGHJ4fHLpJN
         ZcjoyTviGQdtB9/Q9RDIieFscRJQnxI1zBKK8Yj94DtPWMfK7ziCK4LdsRmCc800b54V
         dNtAhbVVF3fAAIQRMDEdBz2aot5+aXFMOrGozNC/MmUonL6KIBpqfIaMsjKmm5s4qgni
         Y7u0mnvhA01IjC6nJ3qllbLf4gJPZ4Vum0G4uYn//lce39vduxPYBoyW6v3E9t5E5iGm
         m8gjI7ZzahUgrkPT6Mupu8gUMOYdaIFcnqU/ffBjqoXUBe8pyARp4NvpjkOs6Nrg9xZp
         Zo8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706870426; x=1707475226;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yr18VgKkUR0Z6xA+Bp01IdzSAv15CAC3JbNxjaal7xE=;
        b=G2iSR5aZ5qk/LHnx/nmv2fiSN5ah581D61FsirSC7JhNFPsCeeqqIlg8eNZWypyus2
         8pvpyL64D1Zl0WyrlC+baHS+2YMnFVKpmSyghmnKkNFRv2B2grjq03tv//k4Xz8rUzF2
         vs0gkN1bodD3wEpJC29b1Wcx9XExbju7ts6OMEYpU2AS6Z+KljjZiJkPjJqDXZuAkB9j
         ayUICwcI7ACWIiurAWmO3c+aaQlXnmjY0f0mxMABnHtVbwmGh6OVCJudZG9l8g1at94q
         1qz5nhaIzMEjlsHzIA4D1YJWWSV7QwSQqnPHj01HfUH/B//tSY9WtTPO3QOzSEEEw6eF
         O50A==
X-Gm-Message-State: AOJu0YyYNJn656ESNoB0YsJBWgi0FWrt0OFmIezj8wn9UcRt6BcXqgNV
	vqLew3AuuBHL1zzHhpb2au+KZ+DbGhrPpQ10/DSlC1qNOfZiXoBL
X-Google-Smtp-Source: AGHT+IES3tCk3jxs0f3dtCVujdQihB3Cb/dce9FqfXLgDJYCUO6WQa6kZawzBG6V58Qd4NgHObwTrQ==
X-Received: by 2002:a17:906:3b8e:b0:a35:9cf0:56d4 with SMTP id u14-20020a1709063b8e00b00a359cf056d4mr3995076ejf.30.1706870426176;
        Fri, 02 Feb 2024 02:40:26 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUrmf6/v+Xa22VMbRqu6wSX1b6ijQWy9+2d8Xa5a3K+X3iJVkwzB+5zIAQXNGGuZ5E5UFGMJ7Q1Dh/QNeQ63qRHwfiyw9jwMY8OHcYK/R6yOn7wvrXzLCFKoqsAZj2UoJDqKeVG6hvyjB6Ws0ZZv53cl+fY0ZdLXYsqVfdShBFmcVxWbrqeUMfyZ6p+E9WceIHEd4pgUbCiGmQe34PuiWOWwW64RXGNxxk3GfZCCCA9PvFcZLkR0QrVXDNQoYYoMFuk4Edo59wnJ4JOGHfRwS7bBtcE7evMek8oNdgBY0ILQ1ugKAtK856CGhw5iuPhbluweg==
Received: from [192.168.3.110] ([86.38.153.11])
        by smtp.gmail.com with ESMTPSA id vk7-20020a170907cbc700b00a371a1b40c1sm256385ejc.23.2024.02.02.02.40.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Feb 2024 02:40:25 -0800 (PST)
Message-ID: <cc1572a4-f2e4-4f26-a505-09db5dcdfdfa@gmail.com>
Date: Fri, 2 Feb 2024 12:40:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Arturas Moskvinas <arturas.moskvinas@gmail.com>
Subject: Re: [PATCH v2] pinctrl: mcp23s08: Check only GPIOs which have
 interrupts enabled
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linus.walleij@linaro.org, biju.das.jz@bp.renesas.com,
 akaessens@gmail.com, thomas.preston@codethink.co.uk,
 preid@electromag.com.au, u.kleine-koenig@pengutronix.de,
 linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240201141406.32484-2-arturas.moskvinas@gmail.com>
 <ZburBq7ZJhK_X_t0@smile.fi.intel.com>
Content-Language: en-US
In-Reply-To: <ZburBq7ZJhK_X_t0@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2/1/24 16:30, Andy Shevchenko wrote:
> On Thu, Feb 01, 2024 at 04:14:07PM +0200, Arturas Moskvinas wrote:
>> GPINTEN register contains information about GPIOs with enabled
>> interrupts no need to check other GPIOs for changes.
>>
>> Signed-off-by: Arturas Moskvinas<arturas.moskvinas@gmail.com>
>> ---
> You forgot to add a changelog here, but no need to resend, just you can respond
> to the email since it's not a big issue in this case.
Ack.
>> +	if (mcp_read(mcp, MCP_GPINTEN, &gpinten))
>> +		goto unlock;
> Do all hw variants have this register available?
> Esp. I2C part, wouldn't it be problematic (exception with NACK on the bus)?
According to specification sheets MCP(s0)17 [1] page 19, MCP(s0)18 [2] 
page 19, MCP(s0)08 [3] page 11 - all supported expanders have that 
register also that register needs to be used [4] to mask/unmask 
interrupts on given GPIO, without it - expander won't even fire an 
interrupt. I tested on MCP23018 I2C expander though but module itself is 
not treating that expander differently for interrupt handling purposes.

Do you want that information to be added as part of commit message or 
information in the mailing thread will be enough?

[1] 
https://ww1.microchip.com/downloads/aemDocuments/documents/APID/ProductDocuments/DataSheets/MCP23017-Data-Sheet-DS20001952.pdf
[2] 
https://ww1.microchip.com/downloads/aemDocuments/documents/APID/ProductDocuments/DataSheets/MCP23018-Data-Sheet-DS20002103.pdf
[3] 
https://ww1.microchip.com/downloads/aemDocuments/documents/APID/ProductDocuments/DataSheets/MCP23008-MCP23S08-Data-Sheet-DS20001919.pdf
[4] 
https://elixir.bootlin.com/linux/v6.7/source/drivers/pinctrl/pinctrl-mcp23s08.c#L473

Arturas Moskvinas

