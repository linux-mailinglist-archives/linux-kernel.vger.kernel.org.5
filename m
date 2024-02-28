Return-Path: <linux-kernel+bounces-85686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5A586B943
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 21:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 852B2B26560
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 20:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B8513541F;
	Wed, 28 Feb 2024 20:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="A1km7Vpv"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4632573509;
	Wed, 28 Feb 2024 20:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709153330; cv=none; b=IsdCo8vWT9OphyvDMWLgL8G1vDJZXN8YHpRPNqMUlr4ynzhQg4ZMOaOTRlAKbnvDg43Ng2mYp3PHnHnlICaMlhnPGeHOC+VWrf/X5ljMfcR2FWU2J9tyV0AAy4BpfRL4fDy7Qh1tsAMiUynpUH4oEbOlW+NvT44XnpUymZoXbNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709153330; c=relaxed/simple;
	bh=xB/Lvc3pAyy3aE4uSGlVi5mHrvCghaImnICZTejHVYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pSR96rcfW3F5XvZIZZ6R0TuT0ypwpbjxi3B5ui4jrl4INqe6QPnpm1e47XR1l0Q8adl9FjEGti2EnAuexgExLSR/m67vM41egiutVSK3/+iGsCrHJafpZREYHm+n+Du5ZeK1AJI2TeFXt4DMtara+ZTGeO2YKLsEyjaKTRGXtqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=A1km7Vpv; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1709153316; x=1709758116; i=w_armin@gmx.de;
	bh=xB/Lvc3pAyy3aE4uSGlVi5mHrvCghaImnICZTejHVYw=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=A1km7VpvR1RYpB9+WhwCVsuYxvp7u1Qta2kWyER8RKFnhcOaPAu2yOXLYxp4/hE5
	 lLPqHMa3XODQkPUWCcG+BXgK17XtkA13je+bWjGOgmLYzCqtiRQ/6EbvCevLaNHvb
	 FafPjVNeUpt7j0UQDI7gLkCxoQz3V7Z83bIIkwD4rJA2BKTEPQkxnlRJ8CJe5yLqS
	 Oy2LQqlK7F2hApnxsLDWQobYy6tewA4gIukrz7tFEhd4WLlpCnwKgqT0J3Fkr7Hqg
	 OmxSnmXzrXsmy4ELoiGv1v0UoIE8uVmym/ahLJ9xEfDYYIg7ZAEx4GeoGO2e82N8j
	 J6a5wzG30a07vpUpug==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mk0NU-1rCirs0w36-00kLYJ; Wed, 28
 Feb 2024 21:48:36 +0100
Message-ID: <63ba267a-27db-456e-be32-2efe27fa26e1@gmx.de>
Date: Wed, 28 Feb 2024 21:48:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] platform/x86/amd/pmf: Fix possible out-of-bound
 memory accesses
Content-Language: en-US
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: <20240227145500.299683-1-W_Armin@gmx.de>
 <20240227145500.299683-2-W_Armin@gmx.de>
 <2dd63b5b-cf60-9f28-55b3-35eab537dc9b@linux.intel.com>
 <0e70681f-85c2-43f9-822a-2e07776c37c9@amd.com>
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <0e70681f-85c2-43f9-822a-2e07776c37c9@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SyH/nmgU2774H+komsiu5jOrBKM93Q/lDfp/A1JMDlijW0dIDIo
 qlGTzGn7y8GRGiDajuHEYxJ/8IAyXhgLGTRMKEg0w2Uv5W2xm+2MWSqyQfJURXQOxH7xJrz
 FpzohwyTTv3a8VzhO2LSYuiWrxyc1dFAWgtdmKz4Ol/8LVZN4JDUV+qRkUGCN8nsHo8b37p
 tgW1bI2nxusE0TUNTHKgA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3dRI2+X09JY=;HcDYDkXd0mggqMRwvx12MJ+gSuD
 wxAdLYrEYvIh+3wvZzfD/rMEJsg8giRmFEma0zrmUbENt6E/ZIrpem6++hOo9s5Yvnxc35EWo
 2tkW16cwpOmWHGqum5wrCBcqSaAwpKfou6yVMV+fMOFrcGZ7oMdU9tOH6x0xohQ6wOI5/SarM
 rsR1HOPHmGzt4It/ooa3XNHSJEo5sj9fnSdTZso/uViJ25FSTcTKGyZCoYpUa4x+UCBSHbmlY
 2UkT4xS1YkC7w5Ylz3ytN15z4VvAer2CNktcOCkKCrb9pqi1awjMj2naJXjD1Y4paWK92tZ1I
 lF+6+9nR9QEI+lqM+N7ZuN+06aaYwTGA7n86Jm5d5Kd/qkrLKP2Ux24fX42bQEoYaIKER20c0
 trqeorVSGJJ15ziLMZZRGMiCR+fEOFKBZ6bqXrwr0Tjn214M5aldunvOdBraqvas8pv32eY+v
 FbzP/Z7TPnOzL0u3bRS6YMavIVakTFjKcfqyiu4IZYRs7ljj5JAUNeMGYrQR9GcuPQhAAZdzw
 8+U5GS1td1zj7nUrC14UbgphUu9RaZKagBUry6aNNfnYExN8Ocx+JIPKKipedS/1PlXsvJPMQ
 h7D+wMyBCSrnd2MLn1pvpQ+Z8zMA6gE+Qx6GlVwojYyNwp7ziuJaA2ehHpUGVRXwAtcvl0FDk
 7KkrWXOrqxGbyFdDA1mlcZdZgm2RqhiHbFQ0izUs3OG/at7708pHbvd+qmwuxTkdu8bSay3RT
 fSz9jRTvhpCkqEciKO7cVRknGbbgZCrWCUDloyeYUK3DX9+nmcMwuxehZ3PLY43KluiraGQe4
 u1HzZOmsJ1xfh9pkSaWWoouPsTx03xzJ09N+BkBMb65/w=

Am 28.02.24 um 12:16 schrieb Shyam Sundar S K:

> Hi Ilpo,
>
> On 2/27/2024 21:15, Ilpo J=C3=A4rvinen wrote:
>> Hi Shyam & Armin,
>>
>> Shyam, please take a look at the question below.
>>
>> On Tue, 27 Feb 2024, Armin Wolf wrote:
>>
>>> The length of the policy buffer is not validated before accessing it,
>>> which means that multiple out-of-bounds memory accesses can occur.
>>>
>>> This is especially bad since userspace can load policy binaries over
>>> debugfs.
> IMO, this patch is not required, reason being:
> - the debugfs patch gets created only when CONFIG_AMD_PMF_DEBUG is
> enabled.
> - Sideload of policy binaries is only supported with a valid signing
> key. (think like this can be tested & verified within AMD environment)
> - Also, in amd_pmf_get_pb_data() there are boundary conditions that
> are being checked. Is that not sufficient enough?

IMHO, amd_pmf_get_pb_data() only checks if the length of the binary is
between 0 and the maximum buffer size.

If for example the binary contains only 4 bytes, then there will be an
out-of-bounds access when trying to read the cookie and length.

Or if the length is bigger than the binary buffer, then the driver just
updates the buffer length even if the buffer is too small.

I think the driver should catch such cases and return an error.

(Please note that we are talking about the binary buffer, not the internal
structure of the remaining policy binary itself).

>>> +	if (dev->policy_sz < POLICY_COOKIE_LEN + sizeof(length))
>>> +		return -EINVAL;
>>> +
>>>   	cookie =3D *(u32 *)(dev->policy_buf + POLICY_COOKIE_OFFSET);
>>>   	length =3D *(u32 *)(dev->policy_buf + POLICY_COOKIE_LEN);
>> This starts to feel like adding a struct for the header(?) would be bet=
ter
>> course of action here as then one could compare against sizeof(*header)
>> and avoid all those casts (IMO, just access the header fields directly
>> w/o the local variables).
> Not sure if I get your question clearly. Can you elaborate a bit more
> on the struct you are envisioning?

I think he envisions something like this:

struct __packed cookie_header {
	u32 magic;
	u32 length;
};

>
> but IHMO, we actually don't need a struct - as all that we would need
> is to make sure the signing cookie is part of the policy binary and
> leave the rest of the error handling to ASP/TEE modules (we can rely
> on the feedback from those modules).
>
>> Shyam, do you think a struct makes sense here? There's some header in
>> this policy, right?
> Yes, the policy binary on a whole has multiple sections within it and
> there are multiple headers (like signing, OEM header, etc).
>
> But that might be not real interest to the PMF driver. The only thing
> the driver has to make sure is that the policy binary going into ASP
> (AMD Secure Processor) is with in the limits and has a valid signing
> cookie. So this part is already taken care in the current code.
>
>>
>> There are more thing to address here...
>>
>> 1) amd_pmf_start_policy_engine() function returns -EINVAL & res that is
>>     TA_PMF_* which inconsistent in type of the return value
>>
> ah! it has mix of both int and u32 :-)
>
> Armin, would you like to amend this in your current series? or else I
> will submit a change for this in my next series.
>
> Thanks,
> Shyam

I can do so, but i will be unable to send a new patch series for the rest =
of this week.

Thanks,
Armin Wolf

>> 2) Once 1) is fixed, the caller shadowing the return code can be fixed =
as
>>     well:
>>          ret =3D amd_pmf_start_policy_engine(dev);
>>          if (ret)
>>                  return -EINVAL;
>>
>>

