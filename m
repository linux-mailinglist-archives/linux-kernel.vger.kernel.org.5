Return-Path: <linux-kernel+bounces-73886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C96485CD20
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 01:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46D33B221A9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 00:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417A8882D;
	Wed, 21 Feb 2024 00:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J7USTkxr"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C0C6FBE;
	Wed, 21 Feb 2024 00:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708476710; cv=none; b=G70z3ExGM1bX0n3PrvQdG5q5XOjBH+tCTJhD5F6pblwnYaFthvXbXqDFbmfOc4ErIuebnPpblipHtoeiTPbYFkRm/WzojMJUn/h29dhkvplk2fj0Tpw05s5wczgwWNTu8N41GjZODl6mdCyds9Q79NW5Si8l6djHHphkjR+MbvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708476710; c=relaxed/simple;
	bh=MieXVm22ma551iVFmKtgUAOJPGMkvDbr5o0lgBA3X8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fmfl4VOaLuYtYH6ZHqr11iDUSSrchBmA1gfxyWaC1G/78AcX/rn6IAfe3dGzyShgCsDW34IQJbwvHGTv4sNHWl3vz+diygWcA5LM6gAqEUaw4zPGP5tWJhvJOWCAQw9kTZZ/EiZyq0XpFm6eMIoL8ElaWOYtFMJuLsTxIeNET0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J7USTkxr; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d8da50bffaso30966745ad.2;
        Tue, 20 Feb 2024 16:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708476708; x=1709081508; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B0SlzYf9q4r5oo3cnCmgPLBf9yL53UG8nb29+3uRtXs=;
        b=J7USTkxr/V0zCXI/6QuqmR4yBLA7UTlue+U6jYfCGfz8FOTFbXnN5ddjTflQL98o7n
         Ej24WbK7Q9mxP0IFjgmFAyAkjtjLFkuVK71IrQE459mBQur1Vsc8pA9Qn3ujZLmVt6QQ
         OMEdn8dP64qTXbHakZRRqU8m4Feyv5txGSnwnohsnjEnWL6DMo86V5z+E2+6WMPaIhQP
         PWg5b6+G6n1O5dXCwZd67ulI2UTTr4O/ps2fvv/Jf/IY+nkeknXXqfxph0k0TuGe+wqT
         Ms5w6J5NWjwap0/xqQif8vVuqX9php8F0vHDzyxCA8pOL3z1WqSFoLzgOrwHNPgTd6iA
         cLeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708476708; x=1709081508;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B0SlzYf9q4r5oo3cnCmgPLBf9yL53UG8nb29+3uRtXs=;
        b=i3pBjz1FA/sBxcf1yzegSxFIvIn1buj/T9XvERJHlfPzkDM4fYFGsaJ1HfKKgYMkNP
         cLNfI/mUciMml1KzgobsrnrgF+HJXOQKOc+kxBge/eWzfsTM3vjD7vieUHqAnHuuRoqR
         LAFdJNYJqDTFkJetwIyjbE71e5SL/yioKpfaUIuQAsU5CgX5MOedb8VrYzlCK3x5Ua6a
         AK9VUZmiD252Bn/1XKe4G2cVR5uXr4KnErkpV0Lix9t+i6+f3dTmruOXv1eHXV3FiAhe
         99g4p/p0ryu8annH1e9D01a+cLYkLRU6E6cChDKO2IDPeZYG6ECOx29XpkJdK1cyGqJ/
         OlFg==
X-Forwarded-Encrypted: i=1; AJvYcCVrrmtvuayv/ZL0aE/89lZ7lSt1dU7F/WHKnB3sInL2bL2/hJmKbRna7Ir0W6hh1PH+fVPGjDEjZZxYidODH7SqViFtf4ztXSSTXBlPxsHIhZjGVt/TRygiEuJ967Jbq4CJcY8Prxj9+HWnLudlq2AANyI6nUm6P9CdNVrYjnMNUfvy++c=
X-Gm-Message-State: AOJu0YxWbAZUSm1pbFSI8Ch3VzUZHP/5LHWAmzBnUrhS7/ya12o1ys1n
	ww0lu9gx0JOwhZJPfvny44U5yG3ONhJ61hZnoEzaKuRVP49ZBweF
X-Google-Smtp-Source: AGHT+IHpWBNu8g6t7YfE+qIGbFSW1RZzQSg9X2TrRyMpgRBhzWoeu63O8KOYi+IXdOVYZh0DRmDQOg==
X-Received: by 2002:a17:902:c084:b0:1dc:20f2:77bb with SMTP id j4-20020a170902c08400b001dc20f277bbmr2027961pld.29.1708476708315;
        Tue, 20 Feb 2024 16:51:48 -0800 (PST)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id w16-20020a1709029a9000b001db7ee44ff9sm6790232plp.263.2024.02.20.16.51.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 16:51:47 -0800 (PST)
Message-ID: <9c0f9285-4418-4ae9-9f72-ea74bfcf92cc@gmail.com>
Date: Wed, 21 Feb 2024 08:51:43 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/4] pinctrl: nuvoton: Add ma35d1 pinctrl and GPIO
 driver
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 linus.walleij@linaro.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 p.zabel@pengutronix.de, j.neuschaefer@gmx.net
Cc: linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 ychuang3@nuvoton.com, schung@nuvoton.com
References: <20240220004159.1580108-1-ychuang570808@gmail.com>
 <20240220004159.1580108-5-ychuang570808@gmail.com>
 <b40f5b2d-d41f-47fa-8aae-30290e0d2737@linaro.org>
Content-Language: en-US
From: Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <b40f5b2d-d41f-47fa-8aae-30290e0d2737@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Krzysztof,


On 2024/2/20 下午 04:28, Krzysztof Kozlowski wrote:
> On 20/02/2024 01:41, Jacky Huang wrote:
>> From: Jacky Huang <ychuang3@nuvoton.com>
>>
>> Add common pinctrl and GPIO driver for Nuvoton MA35 series SoC, and
>> add support for ma35d1 pinctrl.
>>
>> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
>> ---
>>   drivers/pinctrl/nuvoton/Kconfig          |   19 +
>>   drivers/pinctrl/nuvoton/Makefile         |    2 +
>>   drivers/pinctrl/nuvoton/pinctrl-ma35.c   | 1211 +++++++++++++++
>>   drivers/pinctrl/nuvoton/pinctrl-ma35.h   |   51 +
>>   drivers/pinctrl/nuvoton/pinctrl-ma35d1.c | 1797 ++++++++++++++++++++++
>>   5 files changed, 3080 insertions(+)
>>   create mode 100644 drivers/pinctrl/nuvoton/pinctrl-ma35.c
>>   create mode 100644 drivers/pinctrl/nuvoton/pinctrl-ma35.h
>>   create mode 100644 drivers/pinctrl/nuvoton/pinctrl-ma35d1.c
> Driver cannot depend on DTS, so please reorganize patchset so DTS is not
> in the middle or even split the DTS to separate patchset.
>
> Best regards,
> Krzysztof
>

Thank you for your explanation. In the next version, I will adjust the 
order and move the DTS to the end of this patchset. Best Regards, Jacky 
Huang

