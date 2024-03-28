Return-Path: <linux-kernel+bounces-122879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC3588FECB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAA85286C66
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 12:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC0E7E767;
	Thu, 28 Mar 2024 12:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hLh1uB6v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1487EEF4;
	Thu, 28 Mar 2024 12:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711628203; cv=none; b=Ma3kITK442u0ol++MCpQsHrIycLwAJS8eYqglnQC8AoQ/ib93xc8eiMCnVD8zYzoRHSKNqvlTFWoV2Ezr6v8fp55uLqGimz6nwLJWDLKPvhm2U+jAiUcQ3mDVSKkvfhVYxD7qc4gGj8PLPZFu/nv5wqbE0wCSYabtl7hsuASZVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711628203; c=relaxed/simple;
	bh=r8WiuBMEDOnZXmOwtjMLobp6E4cT8EUzw14CtqK7r8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lF9MDGKB8vce85/lgCzeS9ppuSRLDphuOKLjRZYqZPd0NhTyCFe2VnFGDKrTsyhC5y/PIQsIkhH5ELJzbjzeiICIGLGUjG4paT6pdgiCtfPvb0zerEZA27KEbaboiNaJJjTR/aCbam9U1DqEvkvv2DNcu4RkH+/MAUJI97jLaRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hLh1uB6v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20A6EC433F1;
	Thu, 28 Mar 2024 12:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711628203;
	bh=r8WiuBMEDOnZXmOwtjMLobp6E4cT8EUzw14CtqK7r8I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hLh1uB6vkY2Bs6HMjKyC0rb9Cdt3yu8s1mZ6h5rIY5rT3ITP6rBZWEggx168/a6wL
	 C1+pHHj2FfdMudBHPU0q1X6yk0dBZDMo3wWeQWq7E8pUy1lVqxLyMav8Uamn2qUt/V
	 loWubfmMc8JlVP4O3AD5/iHjdH6OIBs/Z8o+lGdJGxbEcSjj7vdoIr/RBh5GeD6mpv
	 u3b6z829udAF1mtVFcdFv+67cB4GYEJIYLqejHtaZEMXdxJ9z7wsSVRntzDyCWvxWv
	 RxZtcG4u4zH8fLyrzdvFHriQow6Zqklv3OVyKPyjYsPASo9HOxzbIemn082cw63LQc
	 z9WBDICjQZa/w==
Message-ID: <d71c51ab-e59e-409e-bafd-22c1528c6774@kernel.org>
Date: Thu, 28 Mar 2024 13:16:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] platform/chrome: cros_ec_ucsi: Implement UCSI PDC
 driver
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Pavan Holla <pholla@chromium.org>, abhishekpandit@chromium.org,
 bleung@chromium.org, chrome-platform@lists.linux.dev,
 gregkh@linuxfoundation.org, groeck@chromium.org,
 heikki.krogerus@linux.intel.com, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org
References: <03e1941b-0c8a-450d-9b83-76260817d303@kernel.org>
 <20240328023233.2568230-1-pholla@chromium.org>
 <2357d78f-8879-41ca-b0e1-6593400252c8@kernel.org>
 <ZgU_H4zceFlQUz8f@google.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzk@kernel.org>
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <ZgU_H4zceFlQUz8f@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 28/03/2024 10:57, Tzung-Bi Shih wrote:
> On Thu, Mar 28, 2024 at 09:36:54AM +0100, Krzysztof Kozlowski wrote:
>> On 28/03/2024 03:32, Pavan Holla wrote:
>>> On Tue, Mar 26, 2024 at 9:59 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>>>
>>>> On 27/03/2024 04:39, Pavan Holla wrote:
>>>>> Hi Krzysztof,
>>>>>
>>>>> Thanks for the review.
>>>>>
>>>>> On Tue, Mar 26, 2024 at 1:47 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>>>>> Nothing improved.
>>>>>
>>>>> Yes. I only added maintainers of drivers/platform/chrome in v2. I am
>>>>> still investigating why MODULE_ALIAS() is required.
>>>>
>>>> Heh, I wrote why. You miss ID table.
>>>
>>> This driver is going to be used by the cros_ec_dev.c MFD. The UCSI device doesn’t
>>> have an ACPI or OF entry, so I am not sure how I can use MODULE_DEVICE_TABLE
>>> here. If I don’t use MODULE_ALIAS(“platform:” DRV_NAME),
>>> https://elixir.bootlin.com/linux/latest/source/drivers/mfd/cros_ec_dev.c#L206
>>> isn’t able to automatically associate the driver with the device at boot.
>>> I haven’t upstreamed the change in cros_ec_dev.c yet, but the code is similar to
>>> existing code for drivers/platform/chrome/cros_usbpd_logger.c. There are many
>>> other occurrences of the same MODULE_ALIAS pattern:
>>
>> Just open other platform drivers and look how it is done there. Or ask
>> colleagues. There is absolutely no one in entire Chromium/google who
>> ever wrote platform_driver? platform_driver has ID table for matching.
>>
>> Otherwise how do you expect this to be matched? How your driver is being
>> matched and device bound? By fallback, right? So what is the primary method?
> 
> Those platform devices are adding in drivers/mfd/cros_ec_dev.c via
> mfd_add_hotplug_devices().

This is not matching.

> 
> By looking other use cases of mfd_add_hotplug_devices():
> $ grep -R --files-with-matches mfd_add_hotplug_devices drivers/mfd/
> drivers/mfd/dln2.c
> drivers/mfd/cros_ec_dev.c
> drivers/mfd/viperboard.c
> 
> They also have no ID tables and need MODULE_ALIAS().
> - drivers/gpio/gpio-dln2.c
> - drivers/i2c/busses/i2c-dln2.c
> - drivers/spi/spi-dln2.c
> - drivers/iio/adc/dln2-adc.c
> - drivers/gpio/gpio-viperboard.c
> - drivers/i2c/busses/i2c-viperboard.c
> - drivers/iio/adc/viperboard_adc.c

So if there is a bug in some driver, you are allowed to add it? :) There
is plenty of poor examples, so what I was suggesting to look for good
examples. I agree that itself might be a tricky task.

> I'm not sure whether using the path results in:
> - Lack of device ID table.
> - Need MODULE_ALIAS().
> in the platform device drivers.  And perhaps it relies on the fallback match?

Guys, think for a sec. If you are adding module alias being equivalent
to platform ID table entry, then why you are not using the platform ID
table entry in the first? That's the entire point.

So to repeat myself:
If you need it, usually it means your device ID table is wrong (e.g.
misses either entries or MODULE_DEVICE_TABLE()).

MODULE_ALIAS() is not a substitute for incomplete ID table.

Best regards,
Krzysztof


