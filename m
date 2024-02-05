Return-Path: <linux-kernel+bounces-53065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F99284A03B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:09:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80ED01C220D5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E2541770;
	Mon,  5 Feb 2024 17:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="d6jz3Gdl"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5315444C7F;
	Mon,  5 Feb 2024 17:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707152928; cv=none; b=Td4XR2gS/CkWzJFEDF8dXEMGXEM834fFY8YDSt4RWGxNs4eWi1k4AT67gC6/8nO6MJBZW+zITtKpIo+cVWuB4hnuZGp2OlM78XzfVl38fhi8cbF2oHiNbWsmwMcbYwCmnXSplSqwJnhzqjbe6brQTE809+ANj/unlk5CDdfnEDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707152928; c=relaxed/simple;
	bh=6hNaaG/8oJZcN6VD13NiOeX06CYfaL53eZydv1sk94A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EO1cSKGPIBTonDepboTM8jYG6uh4+EXGi7N9cl8OXJMRWn9II65y+AWsrumYDHp/XRw4585hxvvqswOX6VdOCy5UTxNX460IjXlmRdl0QRERZyies1O/oFO+Sgbxdzb8Wzf84z6yMkjvB5E2oHV23hNGgEfnL8/itpilS8OgCfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=d6jz3Gdl; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1707152869; x=1707757669; i=w_armin@gmx.de;
	bh=6hNaaG/8oJZcN6VD13NiOeX06CYfaL53eZydv1sk94A=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=d6jz3Gdls9Dh8s8BdM9Gg6wc27fk4qvfSQLJSkDF1qKFmo57q94SShyXOm1a3vtH
	 G2gHIlx75kFXnaSMvaNAL4i0KpMVNWd77kycf6qYM4Lmlyc9xu+5UwjxJpUGg+ijf
	 CJVjlCN0zZfLUUC+4la45HD85M4QiH10EtkzmfrS1PfQ/iX5uhpvIXEFwuWKS0IFM
	 vfL20QLY6QJdGMtrNSadUx4ggcpvNuUFxaAmoDP5sDWjckQskmCf+tv6DknGZOJXB
	 TRVZuo7ZUWxsO83SQnBPsqzXBME6cu7UftbhB1X6EgmzeUTXshghaJPnIugHN8eQq
	 8XTKV9Tmtnj8yMsmmQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.14] ([141.30.226.119]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M5fIQ-1reBKB048Q-007Gm6; Mon, 05
 Feb 2024 18:07:49 +0100
Message-ID: <df011292-48cd-4fbb-856c-20a3db9f99e8@gmx.de>
Date: Mon, 5 Feb 2024 18:07:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2] platform/x86/fujitsu-laptop: Add battery charge
 control support
Content-Language: en-US
To: Szilard Fabian <szfabian@bluemarch.art>
Cc: hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com, jwoithe@just42.net,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20240129163502.161409-2-szfabian@bluemarch.art>
 <20240129175714.164326-2-szfabian@bluemarch.art>
 <fabf391c-933c-4a7b-a23c-d361ad3d7cc0@gmx.de> <Zb2GMCSIz1MuWpQZ@N>
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <Zb2GMCSIz1MuWpQZ@N>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:9jOyCVzgEG/WOK2QiLHZdi4aqCWEUsTJ1xjpyhB/b35LltZX1zS
 09Kk5oWyw3XuPROLRKaHwak37v0XjG+kbrb3GbpLRiialtw49hJ/e5eMP91qbAVXgRHcyQa
 ZhcxqG7V0/t4QgMg716VKKW550HLFiO5nLCHErZxdlaZEO6hoOKmN46n7tET0rYgXsUJYET
 o/6l4WjtV3Lg1YnF1Axtg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:FywLzaAvvJs=;vhBNhZOl0/1zIX+ZbwQKLzw2SwO
 l6nqcTQInmbCUF3ba1JWmvRYn+j7n4xYLwZg1JR/w94Uu6Xit+vJ+SylGrdrIcpv2tJXQZcGf
 ug4FYg03KWiwuepndu8PjqcG6AQ+UQZx5e7yaEmcVuDceGCAAZzTScWA532LAYAAnTEHZVvzC
 cRqZ7Vsm+INQowLQKjWqsVd8/XBveWMzIg76IWt2U60iW3QW9hCtdFOVO146TdHbGbBXoy/gn
 xVeqNVQcHAtcbmPaPByyEouHL6LuTEcNZgdqVvtJRT5fXvUx3hL/mf+E2lqbJ1PPQE5u15xZo
 qS8Ijuhc0lM6YNaNU0SCIGLLflb7FgVs//Q1BXIf9VC626dECJD1eTxhv64uQYUsybZJ2TnSu
 3QOTNMD5iv7a8DH/YfUcOgvnKor/+iT5iuHwS0oe+pnMAAPFF9JX+fH+YPoh9zdWINcHDYzva
 ejGnSYToJPERYm6SM1b10hroPuI2m+v+yGGOFXCPqaOL8xBiusoD1vvFAxwe/cJJGw16Y5z/1
 auI7nNCxx+vGY9NUrA3h+z3vtG4cFxOwTgEfLHEuiSsVQhVTA5HCvnoJ0MR9NCG5DwAfzMp4Z
 /fF4Ur+42ep6gGPmqi7UabPjEt5euiNP9W+mHe/hOjOeLNZpi210KSSsrhdqhA8IO8dFtW5Z+
 UnCrfUY5A7BD3D+sON0d1LzBLBuiCDCo9/nvO5HcWvPSI5EjdBpg+ebqoB/Ym5CFljtooxHkm
 ch4X6pLq7qw/7dsZwReVF2XNWBLjG2/ATzt0uD9QdOGHDWvhTFxgJFAx0NENfPWuz432k7as+
 FW1XNMUndEGeNP90l/4LYum+Bi84tFyQhSQH/QOIyCGqg=

Am 03.02.24 um 01:17 schrieb Szilard Fabian:

> Hello,
>
> On Tue, Jan 30, 2024 at 03:02:09AM +0100, Armin Wolf wrote:
>> Am 29.01.24 um 19:00 schrieb Szilard Fabian:
>>> +
>>> +	return sprintf(buf, "%d\n", status);
>>> +}
>>> +
>>> +static DEVICE_ATTR_RW(charge_control_end_threshold);
>>> +
>>> +/* ACPI battery hook */
>>> +
>>> +static int fujitsu_battery_add(struct power_supply *battery,
>>> +			       struct acpi_battery_hook *hook)
>>> +{
>>> +	/* Check if there is an existing FUJ02E3 ACPI device. */
>>> +	if (fext == NULL)
>>> +		return -ENODEV;
>> Can you put the struct acpi_battery_hook into the struct fujitsu_laptop
>> and then use container_of() to retrieve the ACPI device from there?
>> The dell-wmi-ddv driver does something similar.
>>
>> This would guarantee that the battery hook always accesses the correct ACPI device
>> and you could drop this check.
>>
>>> +
>>> +	/*
>>> +	 * Check if the S006 0x21 method exists by trying to get the current
>>> +	 * battery charge limit.
>>> +	 */
>>> +	int s006_cc_return;
>>> +	s006_cc_return = call_fext_func(fext, FUNC_S006_METHOD,
>>> +					CHARGE_CONTROL_RW, 0x21, 0x0);
>>> +	if (s006_cc_return == UNSUPPORTED_CMD)
>>> +		return -ENODEV;
>> Maybe this check should be done once during probe?
> What about the following scenario?
> - Put a bool into the struct fujitsu_laptop to store information about the
>    machine's charge control ability.
> - The S006 0x21 method check with `battery_hook_register` gets moved into
>    an 'init function'. In that 'init function' the bool gets set accordingly.
> - `battery_hook_unregister` gets moved into an 'exit function', where the
>    bool gets read and when it's false nothing happens.
> - `fext` check gets removed from `fujitsu_battery_add` because it's
>    redundant (more about that later).
> - The 'init function' gets called in `acpi_fujitsu_laptop_add` and the 'exit
>    function' gets called in `acpi_fujitsu_laptop_remove`.
>
> With that scenario the code could be a little bit clearer in my opinion.
> And it is possible to drop the `fext` check because if the FUJ02E3 ACPI
> device exists `fext` gets set in the `acpi_fujitsu_laptop_add` function with
> an error check.
> (And the `fujitsu_battery_add` `fext` check was already redundant because
> `battery_hook_register` got called in `acpi_fujitsu_laptop_add`. `fext`
> gets set in the same function, and there is an error check already.)
>
> Thanks,
> Szilard
>
This would work too.

Armin Wolf


