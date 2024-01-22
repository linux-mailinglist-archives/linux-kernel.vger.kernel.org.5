Return-Path: <linux-kernel+bounces-32691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 739F1835EFE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BA83B2B7BB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F4339FF7;
	Mon, 22 Jan 2024 10:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hFtMbXEl"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8642839FD9;
	Mon, 22 Jan 2024 10:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705917762; cv=none; b=R+DBXnLNdIUSOB46ipNoUF7QNSSuS7fLLYVPuVsvLCWwuREHWlwjXDqJgkp5lzTKeIxB9JL7H1+DIycUQUVxCs1m7eahFz8hlIjJZQKzbTYYh60MwVl0PWmhV/DfUone42WDFoXiglF0PqbFG1UHG+h6op3HGfPn0NqnCqejSc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705917762; c=relaxed/simple;
	bh=UH0mdAbH8q5JrDsA2LzVVD1Mcxs8cBxlGirxEvwPeAg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rgU4Wqrx80A12r3l9mggnUk9AwB/vaxmSOOc6dSZLDRSqw6sNFonoruI+NQM7TG8GdGAoscqP+66hGrNX76iKbpSJKsmpZ97+3aZiXbchVJ2dY7d+ZpF8PyDswC92iDM8mN3mrqkCDF78QLwyb6SS6xLAcHFNj0h3pNmvmNldqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hFtMbXEl; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40e913e3f03so38052965e9.3;
        Mon, 22 Jan 2024 02:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705917759; x=1706522559; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NIKwavFbvvA1J3UDsxgakKoE4Y+95NujtFu74c8W3GQ=;
        b=hFtMbXEl+9f0CIhL/Qa6Pxd0+uq0054OAa/FW/xOfrk8idhnMN4DE/gE+YCDip/hvJ
         wbdvisOT5BJnednVjdhw+H7drDQs99flaMT6mnn/BZY33zEeb38ZQoEdGkEUclaq97Mp
         i++k5NekZMP0vcX2P3fqgHZFQKRDDBP20or5CTALUktOO1md5RfoBYJ14a70DKwF+URj
         kh2uw4USRDayXlyYC2eWmRtvBp5h1Qd7TT+ypSfAZW4SOYXjPSFcnKE2I3ih2TjOXhHQ
         CuRWrFrsCVtJ/Pn4BwGsyHMj7lDOCv8KMz1ykAFxsgKiSYkHlmnIRNS30RxyZDw7a60p
         jH4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705917759; x=1706522559;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NIKwavFbvvA1J3UDsxgakKoE4Y+95NujtFu74c8W3GQ=;
        b=UT8hCjDLWyjw0IyitsfoeXf8rhhhMFv68gVpMO8GPN/Z57i2TI0KVf4Ooo1GKVlCfl
         3OEOb41Ee1FOiydnq9g6bD3+ipVw0AYFAunwSxzkOnSItUQhcter+X2MA6ZaAWtxHK92
         fnOpCPRTfJ2FEwz9VrXTTVTpxF4VKz13qHgnvZB2K8wC4pw6gs/TpheMM0vluNWXt6Ne
         /hMFtzu+afCOkCxg13QjyK1+2oCmOsO6XbvyUjaZIFPms0Xb4EX9jaUbbGPum+Tsa7Gg
         PnDjLVZGUyFWNyUuwpb5sOVGEA38OYETKYQLycMr3u+y7/HRcMCkP0wT211gdhETt68U
         sYOA==
X-Gm-Message-State: AOJu0YxZD/z4jMoBPawHQIBz/+3F0WcENnd/gwlUS3sKWK2KYQ2CmsHx
	kYMOX6mP9VB2u2S4fvF5079Gazr5S6nqa0jW0kBtYkSXe7SBr1pr
X-Google-Smtp-Source: AGHT+IGeyqBOITq8jREpyuTUcxtpiIv0d34MO0QtTVuRNkHPEAXvAHfiSpk4u7R8nGVDsWBOQ04NCg==
X-Received: by 2002:a05:600c:3ca3:b0:40d:8fe1:2f7d with SMTP id bg35-20020a05600c3ca300b0040d8fe12f7dmr2228289wmb.4.1705917758360;
        Mon, 22 Jan 2024 02:02:38 -0800 (PST)
Received: from [172.25.98.130] ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id j7-20020a05600c190700b0040e52cac976sm41891825wmq.29.2024.01.22.02.02.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 02:02:37 -0800 (PST)
Message-ID: <57ea42b3-106b-4361-8d07-4e1656bf6e58@gmail.com>
Date: Mon, 22 Jan 2024 12:02:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 2/2] iio: adc: ad7173: add AD7173 driver
To: Jonathan Cameron <jic23@kernel.org>
Cc: linus.walleij@linaro.org, brgl@bgdev.pl, andy@kernel.org,
 linux-gpio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Michael Walle <michael@walle.cc>,
 Andy Shevchenko <andy.shevchenko@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 ChiaEn Wu <chiaen_wu@richtek.com>, Niklas Schnelle <schnelle@linux.ibm.com>,
 =?UTF-8?Q?Leonard_G=C3=B6hrs?= <l.goehrs@pengutronix.de>,
 Mike Looijmans <mike.looijmans@topic.nl>, Haibo Chen <haibo.chen@nxp.com>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 David Lechner <dlechner@baylibre.com>,
 Ceclan Dumitru <dumitru.ceclan@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240118125001.12809-1-mitrutzceclan@gmail.com>
 <20240118125001.12809-2-mitrutzceclan@gmail.com>
 <20240121155041.3fc1a85d@jic23-huawei>
Content-Language: en-US
From: Ceclan Dumitru <mitrutzceclan@gmail.com>
In-Reply-To: <20240121155041.3fc1a85d@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/21/24 17:50, Jonathan Cameron wrote:
>> +	ret = devm_ad_sd_setup_buffer_and_trigger(dev, indio_dev);
> If the error interrupt is provided either first, or as the only interrupt
> this is going to use the wrong one.
> 
> Probably need to have a variant of that which takes an explicit irq so that
> figuring out which irq is relevant becomes a driver problem rather than the
> library having a go based on spi->irq.

Would it be acceptable to check if spi->irq interrupt number is equal to
fwnode_irq_get_byname(dev_fwnode(dev), "rdy")?

If not, a message could be passed that specifies either that "rdy" is
needed or that it must be placed first.


Another alternative would be adding irq to ad_sigma_delta_info so a
driver could specify the desired interrupt to be used for conversions.

