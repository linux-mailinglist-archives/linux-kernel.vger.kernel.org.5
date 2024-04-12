Return-Path: <linux-kernel+bounces-143427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C438A38DC
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 01:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FA7B1F237FA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 23:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F065E15251F;
	Fri, 12 Apr 2024 23:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="OTuqDoOk"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FCA8827;
	Fri, 12 Apr 2024 23:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712963965; cv=none; b=A/0oeZhxcpzP4q23T9WGQHI/c/18oOvqzXsQ2IGGqh2XVTs0IMkfosWZDgs3BQGpR+9juEAvFfKq58oJXRXaxr2014SVe563ZIQlod39Wdroxx1l5L+dOwFuRFPwscb8Jj7wwNLP4krs4MGZsx2ZWwG/YsLw5wRpDglSC9FKJWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712963965; c=relaxed/simple;
	bh=1PqmQOz7f6Mg34nrwW1LWtgdcqFL46uiZRxe1KeZ1Ao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pUm2/mzqtaCBMGjw4KA1Li14xajyzeZ21wgUl4ga9O8/bkLCURxSymPPluRT34jlGr2zs6X2MThMeiaKHBWuSSxUE3c0ry2oBFGxvlGKvY9xPOpVVnA0fRis6QoiY5OwOXietl9qBlvGEBXbChCOh2dVG11JTcOgzwzQmfBRIbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=OTuqDoOk; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1712963933; x=1713568733; i=w_armin@gmx.de;
	bh=GCKN2GrkE/h3UBU7HQPua1iMX32XMHXFjTvuZe6xhbg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=OTuqDoOk4IPxwMvmTwzGXfvWEWIFNvEcYYN/mC4DUfENtZIHmgufkd5AvEC62kAV
	 p3nJy7Kz4S1XHdMdotlRmVX8hvZPRgwfGI44up3DrBwgG2bXDJgQ9tEsp/HUEF/eD
	 vbrB6Xd+OgPQhBxwsEV4Mz9kbi5+05UjYRhOuyalRqRrZ/cuUzIBN9D9YOcdSNJe9
	 2ttwZgIztp/QRroIyk99MmvWQ7oXhsmPP+BIlKQPCht+VABhmkxHc1Pn97RlsWtZJ
	 sud5AC+OXWacVFfZye4dRt0QxcOXPXYxUAn2rPtJzFs5+i/jrDWNY2rKh4lj/Qd/C
	 0MV8kqN4bNrCDDaE6w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MryXN-1sZlGa2kfV-00o1SG; Sat, 13
 Apr 2024 01:18:53 +0200
Message-ID: <77d99950-5abe-4e36-822f-351cd3c51954@gmx.de>
Date: Sat, 13 Apr 2024 01:18:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] ACPI: fan: Add hwmon support
To: Guenter Roeck <linux@roeck-us.net>
Cc: mlj@danelec.com, rafael.j.wysocki@intel.com, lenb@kernel.org,
 jdelvare@suse.com, linux@weissschuh.net, ilpo.jarvinen@linux.intel.com,
 linux-acpi@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20240412160857.79858-1-W_Armin@gmx.de>
 <20240412160857.79858-2-W_Armin@gmx.de>
 <4a07f4d1-bbee-445c-a7cc-377506de850d@roeck-us.net>
 <aace96e3-8645-469b-9056-0199af9d220c@gmx.de>
 <cff6f5f3-d883-4509-819d-9d2307bdcd56@roeck-us.net>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <cff6f5f3-d883-4509-819d-9d2307bdcd56@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:LAHJi+DHrkiXvbuRf4us5LkGPBSxNV7qQWebIqbdkO/DYkhGyVe
 M/UCM1asToK63JefNSkGrRx8q/+W3q1XAc49DVWeVTHkEEpYyaCpN8vp0PBXtTICT9Pn8hu
 1jEfTXRt7IhoRez5xtSVD/vEzu13KJ+CCrfYWcc0CEZIhiNHX31sEY5eLiwVMPxa2hBea3t
 /1D299e1LwerttjEWn++w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:RadTmnZ2Nlc=;MNOyrJnEFyMqLNa/F7e6IzXjNMd
 HpS6fBfhb2Z5eGZLmdNZzwxveleYIyGagaVcr/r3xDvmNp3zOsfMtATQEtMd6piy38P2gIf25
 +O2eZzukAWx17r3O3OYEnxLcjTUa5Q1cSBEvWp1aeAeX6NRZXHozeWs+Wkvdh0ttYalpoTm97
 IH8fRaadwv39//NIX/fFMNjgAuHJp6gngi+ZTdP3AeaBNGk+nu19KONYiJmnyQYXRwOzPRQGU
 TWaC+0rMO9V7MJwpSLlx4bLWcem6pu2qgdBUIIT2OYKcakEulDwjgpmoHXCu6G8GqNOLsTWzr
 CDBS9IR6sRFPwHbA4bulLf6NEqw6qjoCd1NEHGSLTFovkTxABWMpnmzUpKK9ovBzW+HEsj9M9
 VPGuT92U4JqqURQmQwHKZdbN9gklV03+P9ywdCEBAtjXEMLyH5FyrtXlh2+8cWNNREie74PPi
 P2s02cwEkEHfVIzuewDWnIlqed6q0pbL3NNtchQWmivOfJtsQkZzj5kW17YFA9Q8aUv3Tnctj
 74ZeS0kp7wpTxS6AV4bS+XUicRoemAEoeQ0ptb7JfjzdqIwbdQ0rFUCbDdZ/JwTGxNWuML8RK
 Sezn5tCerKqrn83xwtH5QKxIrzaTuCOyzpZZWD8bKu9uWjAovRhOLi+teg1Iu49BESQpZj1fp
 emXkH9D/cRmcN0p24NEPNbtg27q5nSnO0R0/FnEjmtKoRBvr5v2cXPFmhrqzRuuO2J0+CcpZu
 5ZogBgzQJwu0Y1Z/9tPL3SexRHbs67C3wZMlA8jO5SS4DX+4oo4bKUYJaICYLVrwMRZdwg3AA
 fOuQCDHgcwD0ZmpKxAi//NoczSr0RslO5BEVSvzAKOCSI=

Am 12.04.24 um 23:01 schrieb Guenter Roeck:

> On Fri, Apr 12, 2024 at 10:27:56PM +0200, Armin Wolf wrote:
>>>> +		case hwmon_fan_fault:
>>>> +			*val = (fst.speed == FAN_SPEED_UNAVAILABLE);
>>> Is it documented that this is indeed a fault (broken fan) ?
>>>
>> Hi,
>>
>> it actually means that the fan does not support speed reporting.
>>
>>>> +			return 0;
>>>> +		default:
>>>> +			break;
>>>> +		}
>>>> +		break;
>>>> +	case hwmon_power:
>>>> +		fps = acpi_fan_get_current_fps(fan, fst.control);
>>>> +		if (!fps)
>>>> +			return -ENODATA;
>>>> +
>>>> +		switch (attr) {
>>>> +		case hwmon_power_input:
>>>> +			if (fps->power == FAN_POWER_UNAVAILABLE)
>>>> +				return -ENODATA;
>>>> +
>>>> +			if (fps->power > LONG_MAX / MICROWATT_PER_MILLIWATT)
>>>> +				return -EOVERFLOW;
>>>> +
>>>> +			*val = fps->power * MICROWATT_PER_MILLIWATT;
>>>> +			return 0;
>>>> +		case hwmon_power_fault:
>>>> +			*val = (fps->power == FAN_POWER_UNAVAILABLE);
>>> Is it documented that this is indeed a power supply failure ?
>>> What if the value is simply not reported ? "UNAVAILABLE" is not
>>> commonly associated with a "fault".
>>>
>>> Guenter
>>>
>> FAN_POWER_UNAVAILABLE signals that the power value is not supported.
>> Would it be more suitable to drop the fault attributes and just return -ENODATA in such a case?
>>
> There should be no fault attributes unless a real fault
> is reported, and if power reporting is not supported the
> hwmon_power_input attribute should not even be created.
>
> The same really applies to the fan speed atribute: If reading
> the fan speed is not supported, the attribute should not even
> exist.
>
> Guenter
>
I see, however it seems that some ACPI implementations also return a fan speed of 0xffffffff
to signal an error, so we cannot use this value to check if the BIOS supports fan speed
reporting.

I will send a v4 patch witch will drop the fault attributes. When encountering a fan speed
of 0xffffffff, returning -ENODATA should be ok i think.

Thanks,
Armin Wolf


