Return-Path: <linux-kernel+bounces-109177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0808815C6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 17:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED3F31F23758
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41D815CB;
	Wed, 20 Mar 2024 16:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FE/W/R+b"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8C64685;
	Wed, 20 Mar 2024 16:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710952767; cv=none; b=ecqNNU+DpfsOBr+mwDPpg6NEHRJbtgZm2FF8Mv0pdNoIc51e0koQNiAZ2gIpl3zHjdEDz8u5eZmgYuwcz9Acm4zJCmFkD9v8bjaxwsxIMOT5K8UlRi7YcS+sapnRwOhIzzH5A2AUdOcczeHw+99sI1Ixi8dYUFLBLyLJvdQIhnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710952767; c=relaxed/simple;
	bh=b3Wgrv370MNhkIWJDgsfRqLYrGNcOEH8Dzj361MsETU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CVqXS78unQCeuxayiODTTN1eb4GNEkYUFhTalNZuCak1QNAAXfgLXrodMvXckIos5oopii2Mj/v5hkqDYhWkYam67WaamOEMHLmjTDsWI/mdnps0jIPBs/KgXu4EbBtOdwUiO3fuqkLDdbNlAfgz+pzA446VOrwFpoPPhbIoNLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FE/W/R+b; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1deffa23bb9so37053495ad.2;
        Wed, 20 Mar 2024 09:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710952766; x=1711557566; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wQauky859kuXAuDXbgdFBECQEJeQkaoXwKu7AZgTe6c=;
        b=FE/W/R+bJtFICSj9lX9Hr9zOaQW7WbXdTCpSsxEJcStwdooRjbF7Gfqq8xi1Tn9z6y
         vRiUxgLm8jrE9vwRgrTBsRjq1MbpzFUu9RBwuGTsw4mmayd8jYmVVSmmOB+65xsptv1z
         RRnuHpSXqI/Y144aJOYbfEeJMLSmVyWEecoNp2bDwC3VAiYPJ9UuV/PjgtegCmUXu3QB
         L60QYGbXB6B+Vi3kZEZ4i2i4LGIwUerOQF0eZqcHby17q46QVo/QhKo8Hgh9YrUYTpHC
         E6XsGmBX3Te0HDdzKQSsKQ7yBAYLv2VqJnyuk3aBmMkbMFTTjDaz5s30Idf8O7oVCD+Y
         VKvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710952766; x=1711557566;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wQauky859kuXAuDXbgdFBECQEJeQkaoXwKu7AZgTe6c=;
        b=f/zgDxQka/Z/8HIpKkCrorpup+j7XHVxwlYvLLUC0Q1FicPv7aw8ZYAkCkgm31Q3a3
         u2kUAJgVz7mfmRCR6+A9s8VwOZlP+mY8D4Ye1QYefWUB6FBKluiIDZ7et7yq5wrTcj0D
         FyqnKN3GP05AVQnFwhSU578HDHZ0SshQYBXWJFE6KULgnVbdtWqa8+IWDC8X38iVR+55
         Jcvib3E+0UUBCgFTbK/YL6CPSSxLaYbo+h4kljDmZjXKJxhOmJu6n0AKy5l4+dYqV+zJ
         Qij17nlsN6u23FB7dMbfXc4q40WF1Qc6I9CVjDHyJK39Yg9rni+kZmwN0b4yEiIZ6n35
         /czA==
X-Forwarded-Encrypted: i=1; AJvYcCX1Qiu4FuoCH3yVapsx9NTiavar0gjy6nMXOIXM1ccbMXK9jCsZSRvVfmpJ49tMYZL1Zemz56TFnXv97jkhW25tUmXnMcfMlZit+uUeccMbDTkzSPrZ+hcaWxGzBOQU9KprHspk6/m1Y+BfD8RjyVIfTLQfXpyrR/XW51pe9PmanamR+A==
X-Gm-Message-State: AOJu0Ywu4UboA7TdmyekRqJ89wepFf7kHbvYypLU/UtkHjIMYEPXyGTJ
	XY3OFkGOwMCWr8sp+aP5RMIJrmMGRhG2aBF7afHJVU4+H+/0PnKs
X-Google-Smtp-Source: AGHT+IHRwH0VWCUf9JBVUF6vi6xAR3lOSAEpU0/xZlFkKgm6Ojvm2NjLdbfGrZw09mEv5vUlHe6IFg==
X-Received: by 2002:a17:902:e5c2:b0:1de:e026:1b8e with SMTP id u2-20020a170902e5c200b001dee0261b8emr23472945plf.41.1710952765579;
        Wed, 20 Mar 2024 09:39:25 -0700 (PDT)
Received: from [172.16.116.58] ([103.15.228.94])
        by smtp.gmail.com with ESMTPSA id mm14-20020a1709030a0e00b001dd2b965a8esm13846928plb.163.2024.03.20.09.39.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 09:39:25 -0700 (PDT)
Message-ID: <c3223f90-6e7c-4fdc-905a-770c474445e2@gmail.com>
Date: Wed, 20 Mar 2024 22:09:05 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] dt-bindings: misc: Add mikrobus-connector
To: Andrew Lunn <andrew@lunn.ch>
Cc: Vaishnav Achath <vaishnav.a@ti.com>, Michael Walle <mwalle@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 open list <linux-kernel@vger.kernel.org>, jkridner@beagleboard.org,
 robertcnelson@beagleboard.org, lorforlinux@beagleboard.org,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
 Derek Kiernan <derek.kiernan@amd.com>, Dragan Cvetic
 <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mark Brown <broonie@kernel.org>, Johan Hovold <johan@kernel.org>,
 Alex Elder <elder@kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "moderated list:ARM/TEXAS INSTRUMENTS K3 ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 "open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
 "moderated list:GREYBUS SUBSYSTEM" <greybus-dev@lists.linaro.org>,
 Vaishnav M A <vaishnav@beagleboard.org>
References: <d4dc4d94-d323-4158-8c08-b7d37d8750d3@gmail.com>
 <0f3f56d4-3381-44f1-91bc-c126f3ced085@linaro.org>
 <c8031e17-5ae8-4794-8b8c-1736be6452d3@gmail.com>
 <CZXMK3W52AFO.1APK080GVJESK@kernel.org>
 <5a9b1cd9-05ec-4606-92b6-eadbc7af6202@gmail.com>
 <CZXPQZY8PUGE.QZM8XSOUNMT4@kernel.org>
 <81ec4156-8758-406e-876b-5acf13951d09@gmail.com>
 <CZXSKOLK6S1S.N86E2AZG2V90@kernel.org>
 <2eec6437-dd11-408d-9bcb-92ba2bee4487@ti.com>
 <28c995cb-1660-435f-9ee4-1195439231f0@gmail.com>
 <f53cd006-5eb0-47f2-8f84-e7915154f12d@lunn.ch>
Content-Language: en-US
From: Ayush Singh <ayushdevel1325@gmail.com>
In-Reply-To: <f53cd006-5eb0-47f2-8f84-e7915154f12d@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/20/24 01:02, Andrew Lunn wrote:

>> Yes, after discussion with Vaishnav and trying to brainstorm some way to do
>> the same thing with dt overlays, it seems that trying to use dt overlays
>> will mean need to have completely separate implementation of mikroBUS for
>> local ports and mikroBUS over greybus.
> Could you explain why please?
>
> Are greybus I2C bus masters different from physical I2C bus masters?
> Are greybus SPI bus masters different from physical SPI bus masters?

Well, they are virtual, so they are not declared in the device tree. I 
have linked the greybus i2c implementation. It basically allocates an 
i2c_adpater and then adds it using `i2c_add_adapter` method. This 
adapter can then be passed to say mikroBUS driver where it can be used 
as a normal i2c_adapter, and we can register the device to it.

>> Additionally, trying to put dt overlays in EEPROM would mean they
>> will be incompatible with use in local ports and vice versa.
> I don't think you need to put the DT overlay in the EEPROM. All you
> need to do is translate the manifest into DT for those simple devices
> which can be described by the limited manifest format. For more
> complex devices, you use the ID to go find a DT fragment which
> describes the board, and skip the manifest to DT transformation.
>
> 	Andrew

I am not familiar enough to know if the device tree can work with 
virtual devices created by greybus subsystem.

Maybe the problem stems from the fact that mikroBUS does not have a 
physical controller (and my inability to explain the patch properly). 
However, the purpose of this patchset is to in fact provide a virtual 
mikroBUS controller to allow us to register a mikroBUS addon board 
described by board_info struct similar to how it is possible to create 
and register an i2c device on an i2c adapter using 
`i2c_new_client_device` or spi device using `spi_new_device`. The 
manifest is used to populate this board_info struct, but it will be 
possible to use something other than mikroBUS manifest if someone wants 
to. I can make the necessary adjustments by moving manifest support to 
its own config option.


Link: 
https://elixir.bootlin.com/linux/latest/source/drivers/staging/greybus/i2c.c#L230 
Greybus i2c


Ayush Singh


