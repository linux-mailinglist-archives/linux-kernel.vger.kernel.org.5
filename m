Return-Path: <linux-kernel+bounces-83330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 331D3869314
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:41:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDA571F22967
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0342913DB92;
	Tue, 27 Feb 2024 13:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="bBQMnjYS"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820992F2D;
	Tue, 27 Feb 2024 13:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709041294; cv=none; b=ayc3L4R1Gj+qUsPsLePjlb1m+Sf+ngrQyvBZmk8D7+UtTL/BYhCzh4RoyxlixFeXFXu1/Th3MQXM9dHNPi8kObCjdVtUF+3lFi3ZSWt/WKwHqGjYh5RSTvWVBJ1blufsAuAFSj6uh/ZzyA+Yv817Qq1s3pCB6KjZtgJcEO/ObiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709041294; c=relaxed/simple;
	bh=5u5tAoSnP+fgrFG9HWWLZrfA/Q1EvEkQTUTzPe58IaM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SQ+LH7ZG1bhaO8m8Eo0/FWFVrmT9MspbIueby/LQfSzkHw9pT6WBp/OhTvNAlcLMIXql8g3O+BP3Kwc3v1YRaI5tuXO2Zs6VOVEOB6CEz9SQkiwUiiNeU/iKpf22jg116/B8HWXY3lYDwC1fx2Lshjm4OarGTEFmXu97uSevN04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=bBQMnjYS; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1709041281; x=1709646081; i=w_armin@gmx.de;
	bh=5u5tAoSnP+fgrFG9HWWLZrfA/Q1EvEkQTUTzPe58IaM=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=bBQMnjYS9HssAUH49/ieREQwg7MvFi0AlG1ViLFcJvbKjCjfrjyIcjbqf16WaK3n
	 yRwdR4I9v1gtYRW/zs0pNbRzU1EOIf25ND503yhv1U97D6KXq5Lk3IsY1BMS0CqCp
	 xDV6n5A8IR0fjCo/Hz+0dOT1MCC4LHSHg7hDW9FC2VIrMZZ2AGbCb5JiE3h+eBAEN
	 Ks9aT3Mk6ly1nHEfUT0oOR7ndLBLnRHQSDvYCR4HPHk4ESfeu6pyrrX9G1EMBYA4s
	 tndjxlq2yFHBAFzTIcWkU7+bdpURcIqimVZq7I2rHy3scahlUop04WWWXBx+EtMiB
	 1OEW3snGOzHxbnN8wg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N8obG-1qrmkR0YQY-015pjB; Tue, 27
 Feb 2024 14:41:21 +0100
Message-ID: <9cdc844a-ba39-4215-b21e-1e1629edc549@gmx.de>
Date: Tue, 27 Feb 2024 14:41:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] platform/x86/amd/pmf: Do not use readl() for
 policy buffer access
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Shyam-sundar.S-k@amd.com,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 sathyanarayanan.kuppuswamy@linux.intel.com,
 Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: <20240223163901.13504-1-W_Armin@gmx.de>
 <20240223163901.13504-2-W_Armin@gmx.de>
 <e2b81849-3435-3efb-f2da-b74ac7f99a50@linux.intel.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <e2b81849-3435-3efb-f2da-b74ac7f99a50@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JeUudHQ5pVWclUwEZ92R41Un4vqTi4Zt4ZM4rzRZQt+q/Ov/a0x
 Y5ptzKU5OBaqr3s08JO5zz3d98FS15PUbBNGA0KKYgwC0rbICPePaKik8RXrKmp5pbU6ii6
 qL2aWrfcT7ar2kI+PntWnGknT86kBp/Hd4/E/WqNxmtbqAQCofADl/9VnsNmdGg5Sa2qiwT
 23a25WLKXVIrmJ2dSOdAw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jGXMkxGEvM8=;nEpE8Pav61acMaOjKg8A/6YVz9I
 hcJitECHEWEGlY7MYueYYKm9DaIsBMWQfq3/Wnr+Ql3TERk+KI/vQAHcElpWP2uHuhnFVjGZ1
 CSmiMWt2QWjoipA1LCOiki1YIbMtxqP6tw+ZORwNzVCRXfNUh40/E5bK3kR1uzUAi34Lun6FI
 8hjgpAOs3kJ4ffisIshU2TTRbgpyrnWeYNEYv80tNXr5RWgURCEmeEZD21L4LataEVhb4hqli
 haLkxYcaCMPQYL98eIy4aYIxfQic6ceyDp3xFxMa1pQgolXyGZm8o/7NJ004HJ2FO3/GSM001
 n6ijoJcoi9iJ3CN7iH0t74cQrcvjFU8JvFQ3bm4LUTll22Gvn/2SckJ6vSMZT/CqGMQYMhih0
 ljOsRTu2dfHEX0xfhZvF13sOgq2DPPY6Bo/K8cs2cwR0wfy+C82qB4712GkbGE/n6Hjnhu4BA
 rTguqaeL/rHrk7nIP1dUOR1CVxgAdvjA9InLaMlQrMYs/wwWFCRwSO2HfClZKCIUx+Gkpil9X
 j1EOm4OLI+m7ACIGjvu98ezpidfFcBuu3M8Pb9EDJAJkLdl07sZoPrsZixY0uAgiR9IOHMsdW
 UH55S/F0rA/tLvakWBYK9f2I6nP/zYebRpAQdPYUMR0yhy3nvmALz8QQjxv6wfAtltIdBKfRs
 bMrCo+ihRp5f6mGX6fqSBIBC3/vIELRvEQdUvJ/ALlZgU+YrohRibZhBk8te5IXcnRxgM21DM
 1vPxtxHRq0Faegn3XqJR1NtG5M0irkB51A2HymwZaQZGiK202mddsv03ZxOc0mV4CeoB9GRFk
 8aFClDsdXcxWUz4RJ7/sEdybsy0SIxe7cuVpGHcx9kRLs=

Am 27.02.24 um 13:59 schrieb Ilpo J=C3=A4rvinen:

> On Fri, 23 Feb 2024, Armin Wolf wrote:
>
>> The policy buffer is allocated using normal memory allocation
>> functions, so readl() should not be used on it.
>>
>> Use get_unaligned_le32() instead.
>>
>> Compile-tested only.
>>
>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>> ---
>>   drivers/platform/x86/amd/pmf/tee-if.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/platform/x86/amd/pmf/tee-if.c b/drivers/platform/x=
86/amd/pmf/tee-if.c
>> index 16973bebf55f..3220b6580270 100644
>> --- a/drivers/platform/x86/amd/pmf/tee-if.c
>> +++ b/drivers/platform/x86/amd/pmf/tee-if.c
>> @@ -11,6 +11,7 @@
>>   #include <linux/debugfs.h>
>>   #include <linux/tee_drv.h>
>>   #include <linux/uuid.h>
>> +#include <asm/unaligned.h>
>>   #include "pmf.h"
>>
>>   #define MAX_TEE_PARAM	4
>> @@ -249,8 +250,8 @@ static int amd_pmf_start_policy_engine(struct amd_p=
mf_dev *dev)
>>   	u32 cookie, length;
>>   	int res;
>>
>> -	cookie =3D readl(dev->policy_buf + POLICY_COOKIE_OFFSET);
>> -	length =3D readl(dev->policy_buf + POLICY_COOKIE_LEN);
>> +	cookie =3D get_unaligned_le32(dev->policy_buf + POLICY_COOKIE_OFFSET)=
;
>> +	length =3D get_unaligned_le32(dev->policy_buf + POLICY_COOKIE_LEN);
> I don't understand you need _unaligned_ here, the offsets should be dwor=
d
> aligned, no?
>
> #define POLICY_COOKIE_OFFSET      0x10
> #define POLICY_COOKIE_LEN         0x14
>
Hi,

you are right about this.

However i just noticed that the driver does not validate that the policy b=
uffer is big enough
before accessing the data.

I will prepare a separate patch series to address this.

Thanks,
Armin Wolf


