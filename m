Return-Path: <linux-kernel+bounces-152718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEDD48AC35E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 06:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A06D281766
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 04:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0842112B71;
	Mon, 22 Apr 2024 04:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NH3c9vP8"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EF7DDC3;
	Mon, 22 Apr 2024 04:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713759046; cv=none; b=r6M5RUk8JL1VWaYhSrsv3Q6svhGNVz8OW3HObpyUqIZVui4I+9fIY4t8XX9zlYdHxaXq7+uAUUfZuqW5oYt7bzJpk45fTRmFKo+TW1K5MUvu1fH1RhWbQ3GT49I5oCsfjXlu/SXaA/wew8HiZazuj7FYEKr2vJXEr9xauUSWqm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713759046; c=relaxed/simple;
	bh=5NjCtgLGkoY3Wj6Pp66QEPbSYudtfJ487DFWfPIF2oo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tVSVnYNFDrVwUlE6dAmL5eRKMdYj+w6n3K5TDS5sOSC0U+oxdX7Pl27dMOPfuCq91ECE5T7n0rIjU6pQlZcj7VrcLtViVSLU3Ip9cFKQ8hKTPvh3IM552HtTN9stvKxh6HnbWhbiDw+RsjB2MmRJ/WYYI6qq6eDxplTTb+pdb+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NH3c9vP8; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6f0b9f943cbso2400009b3a.0;
        Sun, 21 Apr 2024 21:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713759044; x=1714363844; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pk53pkCaqYMsqJlJXTFGI4Htbwc6vRAfCe+dNH9x0Uk=;
        b=NH3c9vP8LzsYg2Ks0ktfwHw+MpTNOp8GzfJnjhyaTEkEhOsE7EiQ/Q/F4wnGdyi2nm
         HcmtFAeZkTq9IkiE8O57KJ1zp6jGRCZ5lkIK/v66qkTNI8K5Xp6SKjnqAm/NrswxED4d
         wyI6pyZRv+jL0z74m0Vdga+oRAqnbPiYJX2AwnfDdYN0VH3TaeVSMpYr83JiizA0gfAP
         RPyXcfX7C+6+eY5yxfbJKnTx7F95zlSyxWMMUQMu/DmGT59WbTxEWI4c+3bltOXTEdY8
         CHUGaTCl4bDuoiViEpiLwtx7m4l9mY/N2pLJ0kxiMGKRf3WhJPars6TO+9SvZ49qIQGb
         e56Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713759044; x=1714363844;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pk53pkCaqYMsqJlJXTFGI4Htbwc6vRAfCe+dNH9x0Uk=;
        b=LohgQ28Qya4qzY5BmXUu7ZYNzygqNFnUYrflOplatMRd6JnB7Biq4MYdtoyuFeE1BB
         qcqFJb2Nz15p9BCiK2q3TvC94EAG0AnxvL+gu1silNWakdxDU40lLF7Nc13AYvQE+FmT
         yX/v6D9DjVTFzihbli9/IiS9BZTikXWJrJDCDDmC5fYoURDny2Y20ujanruordRW5wL/
         rnwDUk7jeXlzoJe0lYwYHCMW9z710tCCBWVAV5PypbnXVJuu564uNrFCNhPG+TNjVI/K
         bDTjOa/m9s/pU8L9pLguX/DHgb/Rdxa//04qHmgj94fZUIL3POtCWbvMVZNd9vqFZfzx
         Oe3A==
X-Forwarded-Encrypted: i=1; AJvYcCVotnSF2qr8p4cCpbLe/SN7tVN8XPbc50Q3KtVvTb2fg72phreOZ/k5X8K36Rql1PKmEcqDZEyzCI5254bUvwZfQDvJ4YZP7MZXdG8F/iIOJNG7s3mr/AQiGx8hyWTzfeLBngOfxT1W5EuZRle/9cwRPtu8crrjXpVVgnbPPUbZ9/a9rCg=
X-Gm-Message-State: AOJu0YwRZduyTpBNE/foP8hdG86mrFY2aFDjqFj55Yht/2wC7DvBW5Qc
	Mne2zxZ9PPgxIHOjPqPifT5Vi1H1E1YCYmDaiWGRcByPtIrpUKXt
X-Google-Smtp-Source: AGHT+IGFt8U7KmMFD2+/CWAl67eRHju1Lq06X2sawXRedrU19UaPukWLdszh4oIbJL97SCLd8XMg2g==
X-Received: by 2002:a05:6a20:2d12:b0:1ad:1168:a415 with SMTP id g18-20020a056a202d1200b001ad1168a415mr3363140pzl.2.1713759044165;
        Sun, 21 Apr 2024 21:10:44 -0700 (PDT)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id g4-20020aa79f04000000b006e7324d32bbsm6854370pfr.122.2024.04.21.21.10.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Apr 2024 21:10:43 -0700 (PDT)
Message-ID: <643a0d80-3d99-420e-9e77-acc67728fbe7@gmail.com>
Date: Mon, 22 Apr 2024 12:10:39 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/3] pinctrl: nuvoton: Add ma35d1 pinctrl and GPIO
 driver
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linus.walleij@linaro.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 p.zabel@pengutronix.de, j.neuschaefer@gmx.net,
 linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 ychuang3@nuvoton.com, schung@nuvoton.com
References: <20240409095637.2135-1-ychuang570808@gmail.com>
 <20240409095637.2135-4-ychuang570808@gmail.com>
 <ZhZTsV3RKpuyeUr4@surfacebook.localdomain>
Content-Language: en-US
From: Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <ZhZTsV3RKpuyeUr4@surfacebook.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Andy,


On 2024/4/10 下午 04:54, Andy Shevchenko wrote:
>> +#define MA35_GP_MODE_MASK_WIDTH              2
>> +
>> +#define MA35_GP_SLEWCTL_MASK_WIDTH   2
> I looked at the code how you use these... Oh, please switch to FIELD_GET() /
> FIELD_PREP() (don't forget to include bitfield.h)
>
> ...
>
> ...
>> +             regval &= ~GENMASK(setting->shift + MA35_MFP_BITS_PER_PORT - 1,
>> +                                setting->shift);
> This will generate an awful code. Use respective FIELD_*() macros.
>
> ...
>
>> +     regval &= ~GENMASK(gpio * MA35_GP_MODE_MASK_WIDTH - 1,
>> +                        gpio * MA35_GP_MODE_MASK_WIDTH);
>> +     regval |= mode << gpio * MA35_GP_MODE_MASK_WIDTH;
> Ditto.
>
> ...
>
>> +     regval &= GENMASK(gpio * MA35_GP_MODE_MASK_WIDTH - 1,
>> +                       gpio * MA35_GP_MODE_MASK_WIDTH);
>> +
>> +     return regval >> gpio * MA35_GP_MODE_MASK_WIDTH;
> Ditto.
>
> ...
>
>

Allow me to remove irrelevant parts.

I attempted to follow your advice and use FIELD_GET() and FIELD_PREP(), 
but found
it impractical. The reason is that these two macros require their 'mask' 
argument
to be a constant, otherwise compilation errors occur, which is the issue 
I encountered.
Since the mask here is calculated and not a constant, compilation errors 
occur.

Taking MA35_GP_REG_MODE as an example, within 32 bits, every 2 bits 
represent
the mode of a GPIO pin, and the mask is obtained by GENMASK(gpio * 2 -1, 
gpio * 2),
where the 'gpio' argument is a variable, not a constant, leading to 
compilation
errors.

Due to this reason, I will leave this part unchanged, or do you have any 
other suggestions?


Best Regards,
Jacky Huang




