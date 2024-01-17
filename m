Return-Path: <linux-kernel+bounces-29247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E833F830B90
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 17:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 086651C21B27
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 16:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD043225A1;
	Wed, 17 Jan 2024 16:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ML4j8902"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C863B224EF
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 16:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705510656; cv=none; b=Ko/s9J5TLQtS3b6m8489c/9YPpwT1h7Pp9JrlurRitEIPx+eTa36znpBMuGFIfs9eWBysc5nbxIwqbJixRzQhEA+PwfZiV+BR4PSbNNEQPbZMnsWZojxUnEk73x8f1Ryw5bhK0qeZYnp1PrxuXBQIuhkMBRgvCnPZf1eAshZeMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705510656; c=relaxed/simple;
	bh=agOJXwUo3pe4u6UcQAJG/G+WFkj+/Us7iLnr5KStv+I=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=YeXDeBDGftMYIzqdoviJPVcaSR2vp4lekppheh04Feq069/k0sKFp+yyTfeDjd96hPKn0LhNFB7RrsPd/RfBKmN9gv68BNJpMUS989+ZcKO2+iewuqBjTj9UI5Aetr5i70UurIGMblZN3wSM2+K/DFlUx2Z5vD7WLZJpHf/e/Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ML4j8902; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40e883287baso11290835e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 08:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705510652; x=1706115452; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zf6BccYfszVQynsVkDHGRUDX6cGTvvaMJYhAaFuhcDo=;
        b=ML4j89029fD1WkoqZC+ZpZCDLYfZeB7UXhh0453ffpplkteuen1JPG5qyDgAB13SnM
         iZqCzrzH3Pb83tErsGN5a3Vuam/13SN4U6tt3Xzvh7Gb9+Wo1FR7VuDjYpvu0kqpbZPY
         hex2XO14nnGUleApXNsY4E0NTyFjnohq6kOWvJ9bGIJp7FxZrgB2RrVcD9Rao5NbHo7Z
         Mnc3OcyZTeAGFVzf2wInAddUbSfZByuGN10T1D9zL6pyVkTyEEw9fTqHCbGoTVxIvNdR
         k3n8s+63NoUgFsIoVxZGldPexy4CbVkLYETeJUyCfT3Un+BKiPOSk42sBBhaOZAOqcMc
         V5jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705510652; x=1706115452;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zf6BccYfszVQynsVkDHGRUDX6cGTvvaMJYhAaFuhcDo=;
        b=Jr8Z843UhjIezAY37KdCuSyxeOL68w79/xdIFZZMSaclpMIhg+wETrWayJYm7U1eKb
         9NeZUAvgh2nzgCbOAK4GFASeEcefUVkAAja2zMahqvIrpVUeNaqeAp4zmfv1Jn5LxuCJ
         rICXnUVrFTOHj9i+r6FKAlBbLKTNEitJZZ4pHB6HZIYMQ6YCbSETVIFSpjtSjOBcY4OV
         PFi28VbqhM67WHd/OOe+fVC+jJe93232Y8offzUGtfI0own35qvD6Nk9if2rfgfM2uo8
         JUU2upzI/At9v72g+NFjMxLXV0sxl1RjqEYYRvpEFMHtHt0lUbByP42Nk+g5QUhfkxOf
         TmfA==
X-Gm-Message-State: AOJu0YzTf/i36UJ8GTBXA3KGLXB554Onv7x1u8Sx+VMVSlqtYIJJhut2
	Nrr4CP5V6woj7XxtqOi3vXxFMMbazybK/X7ETNYEOUiqTVE=
X-Google-Smtp-Source: AGHT+IF4aFSEVWFWZvI4X0t+poUXcnqZyrrkfJkH6j68c8CpcmuCocBQn3qAChOwhfi4UY4HXKcapQ==
X-Received: by 2002:a7b:ce8a:0:b0:40d:685c:3880 with SMTP id q10-20020a7bce8a000000b0040d685c3880mr4993310wmj.176.1705510651900;
        Wed, 17 Jan 2024 08:57:31 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:a2f4:93df:1b67:8ad0? ([2a05:6e02:1041:c10:a2f4:93df:1b67:8ad0])
        by smtp.googlemail.com with ESMTPSA id v4-20020a05600c470400b0040e5945307esm23192566wmo.40.2024.01.17.08.57.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jan 2024 08:57:31 -0800 (PST)
Message-ID: <921c2f90-fb8b-4e70-9e3d-6e185fec03b6@linaro.org>
Date: Wed, 17 Jan 2024 17:57:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal/sysfs: Always enable hysteresis write support
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240106191502.29126-1-quic_manafm@quicinc.com>
 <CAJZ5v0gE6eEpALrfxHvCd5TRqjB+v8pffG4CKLTVXiSvuiWhHg@mail.gmail.com>
 <d7b82fc8-0ed8-80b8-9eb8-c77f9277178f@quicinc.com>
 <CAJZ5v0g4hnRqRCseRnTjfEF+-2=ZT8U9=2m9FODqh3G8eDd=Sw@mail.gmail.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0g4hnRqRCseRnTjfEF+-2=ZT8U9=2m9FODqh3G8eDd=Sw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/01/2024 13:48, Rafael J. Wysocki wrote:
> Hi Manaf,
> 
> On Wed, Jan 10, 2024 at 9:17 AM Manaf Meethalavalappu Pallikunhi
> <quic_manafm@quicinc.com> wrote:
>>
>> Hi Rafael,
>>
>> On 1/9/2024 7:12 PM, Rafael J. Wysocki wrote:
>>
>> On Sat, Jan 6, 2024 at 8:16 PM Manaf Meethalavalappu Pallikunhi
>> <quic_manafm@quicinc.com> wrote:
>>
>> The commit 2e38a2a981b2("thermal/core: Add a generic
>> thermal_zone_set_trip() function") adds the support to update
>> trip hysteresis even if set_trip_hyst() operation is not defined.
>> But during hysteresis attribute creation, if this operation is
>> defined then only it enables hysteresis write access. It leads
>> to a case where hysteresis sysfs will be read only for a thermal
>> zone when its set_trip_hyst() operation is not defined.
>>
>> Which is by design.
>>
>> I think it is regression after recent re-work. If a sensor is registered with thermal framework via thermal_of,
>>
>> sensor driver doesn't need to know the trip configuration and nothing to do with set_trip_hyst() in driver.
>>
>> Without this change, if a sensor needs to be monitored from userspace(trip/hysteresis),
> 
> What exactly do you mean by "monitored" here?
> 
>> it is enforcing sensor driver to add  dummy set_trip_hyst() operation. Correct me otherwise
> 
> With the current design, whether or not trip properties can be updated
> by user space is a thermal zone property expressed by the presence of
> the set_trip_* operations, so yes, whoever registers the thermal zone
> needs to provide those so that user space can update the trip
> properties.
> 
>> For some thermal zone types (eg. acpi), updating trip hysteresis via
>> sysfs might lead to incorrect behavior.
>>
>> To address this issue, is it okay to  guard  hysteresis write permission under CONFIG_THERMAL_WRITABLE_TRIPS defconfig ?
> 
> Not really, because it would affect all of the thermal zones then.

It seems like there is an inconsistency here with the writable trip 
points and the writable hysteresis [1].

My understanding is it does not make sense to have the hysteresis 
writable even if the driver has a hysteresis dedicated ops. The code 
allowing to change the hysteresis was done regardless the consistency 
with the trip temperature change and writable trip points kernel option IMO.

It would make sense to have:

if enabled(CONFIG_WRITABLE_TRIP_POINT)
  -> trip_temp RW
  -> trip_hyst RW
else
  -> trip temp RO
  -> trip hyst RO
fi

But if the interface exists since a long time, we may not want to change 
it, right ?

However, we can take the opportunity to introduce a new 'user' trip 
point type in order to let the userspace to have dedicated trip point 
and receive temperature notifications [2]

> TBH, the exact scenario in which user space needs to update trip
> hysteresis is not particularly clear to me, so can you provide some
> more details, please?

IIUC changing the hysteresis value is useful because the temperature 
speed will vary given the thermal contribution of the components 
surrounding the thermal zone, that includes the ambient temperature.

However, that may apply to slow speed temperature sensor like the skin 
temperature sensor where we may to do small hysteresis variation.

The places managed by the kernel have an insane temperature transition 
speed. The userspace is unable to follow this speed and manage the 
hysteresis on the fly.

So that brings us to userspace trip point handling again.

   -- Daniel

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/ABI/testing/sysfs-class-thermal?h=v6.7#n66

[2] https://lpc.events/event/17/contributions/1423/contribution.pdf

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


