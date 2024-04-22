Return-Path: <linux-kernel+bounces-154006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2408AD60D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 22:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37AB81F227FA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 20:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16BA61BC4F;
	Mon, 22 Apr 2024 20:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NlrgckWE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E51E2F5E;
	Mon, 22 Apr 2024 20:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713818757; cv=none; b=L8MsnGSCtwtRpOJzImgSDTGu5d/kAlsD/MTlI0TgQTp5YkXoUxB64CiBqGXWWrZKm39TY2dZUNTU/9gfEC44EfefS6IOGIeibN185ag5OsSzcsuRFRlNI3hCq6bj62AVtG8/p+Xewc1/EgKE4bUBquwK49U5EA7hmMlZqJm+Wm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713818757; c=relaxed/simple;
	bh=Z5rccZXDv3XBwhOl4JuXrCFjJrjOQyfx+9Poe8LdT1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OdKlJgXxEKP9ufdRlPFujUScYSfk9z+d3DmLlTkSP/mFrYe+bHcVcxQe5LJI/vNDDs8+vOjLzCj7qKkJb7lgAYn8ro7+PTXuH0KhPmXTyENxWCcr7EJEmGZqb4KCR9bFK84XJabp1QOnqLWWqrkXVHVrmFlbcMLfKu2whQMsKUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NlrgckWE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23829C113CC;
	Mon, 22 Apr 2024 20:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713818756;
	bh=Z5rccZXDv3XBwhOl4JuXrCFjJrjOQyfx+9Poe8LdT1U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NlrgckWEG2OcunMtzW6KDKAQm8focTpHB+mjIf9UyoRw9SkVWK96XovoApiLXDZ0j
	 RyvcgpyQR60ViwjNHIG0dxVw/5uGm/oW7AUnFtguZdK0GcvPIoaJpAMhzvojggUQP2
	 p0fxzhRqEOiL8qS8uXQDjPG8igs2TRWBV7q8686k1cQ0YxH9/yzONRWQzhTUYEoNl9
	 tMMn25o5P9CmEvUGNHd8FXeMFHv1QN5WhRFEqHnCbVds82jGuwEgXoODuIkzejKKZG
	 zArcLkI6OyDSOsDcG+jxV28dRZOXPW4Q7vyp4I/9Aymudx8XrWwQbQBPgx14PQl/8I
	 WEcQEWon+xoWw==
Message-ID: <2be75d82-0427-4c06-adfc-a59a804ce337@kernel.org>
Date: Mon, 22 Apr 2024 22:45:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] serial: sc16is7xx: add support for EXAR XR20M1172
 UART
To: "Konstantin P." <ria.freelander@gmail.com>,
 Jiri Slaby <jirislaby@kernel.org>
Cc: Konstantin Pugin <rilian.la.te@ya.ru>, Conor Dooley <conor@kernel.org>,
 lkp@intel.com, Vladimir Zapolskiy <vz@mleia.com>,
 Rob Herring <robh@kernel.org>, jcmvbkbc@gmail.com,
 nicolas.ferre@microchip.com, manikanta.guntupalli@amd.com, corbet@lwn.net,
 ychuang3@nuvoton.com, u.kleine-koenig@pengutronix.de,
 Maarten.Brock@sttls.nl, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Herve Codina <herve.codina@bootlin.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Lech Perczak <lech.perczak@camlingroup.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20240420182223.1153195-1-rilian.la.te@ya.ru>
 <20240420182223.1153195-4-rilian.la.te@ya.ru>
 <7cf31245-b2a1-419c-add6-a6a50a3f3cf1@kernel.org>
 <CAF1WSuwCdonhyzAKX6EeyWAHNX11bV+tgCLJ4vXuEXTAceVvzA@mail.gmail.com>
 <afeae80e-d854-4f38-981e-7e9f414400b7@kernel.org>
 <CAF1WSuxQJ9RF-s_gdkE3W933rzXrVn6ZmHbFCawwdWufie3BZA@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <CAF1WSuxQJ9RF-s_gdkE3W933rzXrVn6ZmHbFCawwdWufie3BZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 22/04/2024 22:35, Konstantin P. wrote:
> On Mon, Apr 22, 2024, 23:11 Jiri Slaby <jirislaby@kernel.org> wrote:
> 
>> On 22. 04. 24, 14:00, Konstantin P. wrote:
>>> On Mon, Apr 22, 2024 at 9:30 AM Jiri Slaby <jirislaby@kernel.org> wrote:
>>>>
>>>> On 20. 04. 24, 20:22, Konstantin Pugin wrote:
>>>>> From: Konstantin Pugin <ria.freelander@gmail.com>
>>>>>
>>>>> XR20M1172 register set is mostly compatible with SC16IS762, but it has
>>>>> a support for additional division rates of UART with special DLD
>> register.
>>>>> So, add handling this register by appropriate devicetree bindings.
>>>> ...
>>>>> --- a/drivers/tty/serial/sc16is7xx.c
>>>>> +++ b/drivers/tty/serial/sc16is7xx.c
>>>> ...
>>>>> @@ -555,18 +578,43 @@ static bool sc16is7xx_regmap_noinc(struct device
>> *dev, unsigned int reg)
>>>>>        return reg == SC16IS7XX_RHR_REG;
>>>>>    }
>>>>>
>>>>> +static bool sc16is7xx_has_dld(struct device *dev)
>>>>> +{
>>>>> +             struct sc16is7xx_port *s = dev_get_drvdata(dev);
>>>>> +
>>>>> +             if (s->devtype == &xr20m1172_devtype)
>>>>> +                     return true;
>>>>> +             return false;
>>>>
>>>> :) so this should simply be:
>>>>
>>>> return s->devtype == &xr20m1172_devtype;
>>>>
>>> I especially want to avoid this construction, because it will lead to
>>> idea than we does not have other
>>> DLD-capable UARTS, which is simply not true, there is, for example,
>>> XR20M1280 UART, which has roughly the same register set
>>> (
>> https://www.alldatasheet.com/datasheet-pdf/pdf/445109/EXAR/XR20M1280.html
>> ).
>>> I simply do not have other devices, so I do not
>>> want to risk sending untested patches upstream.
>>
>> Sorry, what?
>>
>> --
>> js
>> suse labs
>>
> 
> I do not wish those function to be less generic than I did. If you think
> this change is required - I will change. But if it would be okay without a
> change - I prefer to stay as is.

The code does exactly the same, so what do you mean "less generic"? What
does it even mean?

Best regards,
Krzysztof


