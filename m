Return-Path: <linux-kernel+bounces-102593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5C087B459
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 23:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8888285604
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 22:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48BD159B53;
	Wed, 13 Mar 2024 22:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="id6RFgIT"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076FB59B4E;
	Wed, 13 Mar 2024 22:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710368944; cv=none; b=Szuy3aCYg0nyORkpZ+GRQWkB02RW7Vb/zsRiOR2al8npN0nnaBkPGrhsxQ3s11mlKKxVLsFtnCQwJbb80hitvlZyXGpQrz/yR3wESmnW/91fC/7eDA9gAUVU16GCfii+m7dt1lpTG9Gjk4BtqdTJGnc1DfVgivjbDDoGYYlwbaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710368944; c=relaxed/simple;
	bh=cD01GlzbpDft9/egkt97qgIoWlbkMTHG3rZa/g6LfpM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qx+s3dhLOwodz/LLa6D2d6j6ou3OUzDD8xrKXDH/nldVrM+4h2J6nZe1u8OO0vv+SPWBAMzzudQOS01vuiTu4F2rX+iAw2NlcQ4u3JITVi0JuOKMoXpIKtbgl1A7MdQNxNykc2HA2bkshquo6r09c5c9FOoWS5pXg1VUquM4WXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=id6RFgIT; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1710368935; x=1710973735; i=w_armin@gmx.de;
	bh=20CbePg34fNBEaE5jWgFVZCXbm8KLekGbiZqGqIC5I4=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=id6RFgITiDN9dNIZ1+pwKLeZgGpJUGo19CHjCLJD2Ai8oDRD0YMZYlvxAYEtbNjM
	 /IzUSC+wbUK85WCx7oeDPgbSDKGI4mUlioHn/z8KIEShrvFuIVtObUggwaY2Uoy5p
	 4jyKgONPMbom6rV4zkBfAc5e3QM+z5NGKquAfBp/vVwIXxFqGl0q9Z9tWa7o6ZM7V
	 e3rER6JWZxASKiVG5T0A4x3uJ+60+bLs9JDjvczalR9eax9K6VbE98fZ8h7mG6qPQ
	 RvZGauXQZrxh72zpDxA6xemf2ZnS4VhVnUcQODogcOcZ3blcT1sjgb+pHj2+lYQEL
	 hTMLdJ3v4wPniev1Rg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M89Gj-1rfsWq324h-005Ewb; Wed, 13
 Mar 2024 23:28:55 +0100
Message-ID: <2e8100b0-d87c-413e-bcb1-b91c3ce41633@gmx.de>
Date: Wed, 13 Mar 2024 23:28:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] ACPI: bus: _OSC fixes
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240309201310.7548-1-W_Armin@gmx.de>
 <CAJZ5v0hKwThcAO4jMOzi7ySqSv_jHvs_+paBB212qVsaf7LZng@mail.gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <CAJZ5v0hKwThcAO4jMOzi7ySqSv_jHvs_+paBB212qVsaf7LZng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wI++P+1b+yKc3YfUm2hj1g7DmaS99w7cJz6RXTctsALxs2etRWd
 ywx1NcFkSLsO8QpJQIVn8/1XbUkmdt10xTqWn0DdzXFBHyFey3Y2eekSkWtgK7oEuJ9VNDT
 6B1nA/6qiefS6P0fcSt7ogVznZkh4DVh7KfG8otKP+7SawOeJ1bG7nzNvyX7sv3Un+PlI2+
 DB3NIafcmslS8mOecEM0A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:P2LB0CjAtRs=;UnbPdXSB8tyXnF5xg20gQT1w9ys
 JMctO74RNrzAl1GH29HunkOTFQ4sZqPUDY7ohOKeMMfsloHeDZgDOyer2mLzK5FFPpMu1IBeD
 0H1ZHWTSFrzfFaeJtvOXm6HI5bpyxTEVL5E9cawTXXxT0STq6R0452CERoHHG1w2AXhHdzsNI
 0mmEynM9voaN7qRJfmC4ZiUEnJ6zQi1E2FssXXQVJ/JPAxq82Dih2mr0VsTJb5CHh10WEdBcQ
 pmqQ4qO36zcQg1gwdltwAK8NyRk+EADiqYokRmaTA9JNj1Z1o2wFvWp5S+bE7nJuuGcYZoAIG
 KLxzIuPgTltbvHXKkhb1N27Zxuf/1ke77+MbkJQOST8Mbq5etdubuiTDQ9y1BYzQuFDzn+LM5
 z9IlF3o5Dum4pjBEUekolvUrBPtdZH8aAqI9g7z7JcU10PwqdNj9Ay0+q0RYxaUtuFYX0Qth/
 lB7nebHVcsQciVE53u7RLJaVnSfCH4kRnoKc5KB5KWNXbacHdDNto3OkI10uPfuBQt5Oqysob
 OTseHYAl6Xc6WRhcA8Gi9M1s1tXzIC5Gv2FlnhVj5RaqcWqXEsauHp6iUUts1IjqFxVz0d2Bi
 UyZLY3eOBt10hEy92CwH5PDk19CH+/URD2BBoPdTM3tlOxzD20XW5EccPjSftUeJFiQ50+aNr
 N/NMDlEuj+w8T3SrCP62hdElmBygnk4CLzcUHByKOm3mX1LT7UKIyNK2wtTx3+2F7Uz26s9ZK
 5PSwEJJbxY6NX/6EY59gacnsH1jMdG85RcGCr81DyUJ4fsFNhFGoIx+J2NiM9Ubmm/mzWRXVl
 7q8K79JU8z9B51bF+B20paDAWyz2EN1uuB6rkvMZ+nVSc=

Am 12.03.24 um 21:10 schrieb Rafael J. Wysocki:

> On Sat, Mar 9, 2024 at 9:13=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wrote=
:
>> This patch series fixes the handling of various ACPI features bits
>> when evaluating _OSC.
>>
>> The first three patches fix the reporting of various features supported
>> by the kernel, while the fourth patch corrects the feature bit used to
>> indicate support for the "Generic Initiator Affinity" in SRAT.
>>
>> The last patch fixes the reporting of IRQ ResourceSource support. Unlik=
e
>> the other feature bits, the ACPI specification states that this feature
>> bit might be used by the ACPI firmware to indicate whether or not it
>> supports the usage of IRQ ResourceSource:
>>
>>          "If not set, the OS may choose to ignore the ResourceSource
>>           parameter in the extended interrupt descriptor."
>>
>> Since the code responsible for parsing IRQ ResourceSource already check=
s
>> if ResourceSource is present, i assumed that we can omit taking this
>> into account.
>>
>> All patches where tested on a Asus Prime B650-Plus and a Dell Inspiron
>> 3505.
>>
>> Armin Wolf (5):
>>    ACPI: bus: Indicate support for _TFP thru _OSC
>>    ACPI: bus: Indicate support for more than 16 p-states thru _OSC
>>    ACPI: bus: Indicate support for the Generic Event Device thru _OSC
>>    ACPI: Fix Generic Initiator Affinity _OSC bit
>>    ACPI: bus: Indicate support for IRQ ResourceSource thru _OSC
>>
>>   drivers/acpi/bus.c   | 5 +++++
>>   include/linux/acpi.h | 6 +++++-
>>   2 files changed, 10 insertions(+), 1 deletion(-)
>>
>> --
> All of that looks reasonable to me, but do you know about systems in
> the field where any of these patches actually fix functionality?
>
> If not, I'd prefer to queue them up for 6.10 as they are likely to
> change behavior, at least in corner cases.
>
> Thanks!

Hi,

i know no system which even queries those feature bits, so i am fine with
this landing in 6.10.

Thanks,
Armin Wolf


