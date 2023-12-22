Return-Path: <linux-kernel+bounces-9692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F6381C9B5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 13:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A96601F2613A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 12:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E20179A6;
	Fri, 22 Dec 2023 12:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="i+svumC3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEB217992;
	Fri, 22 Dec 2023 12:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1703246893; x=1703851693; i=w_armin@gmx.de;
	bh=lIEDc4eP/tBcRvutzo/u5pew9rRgWJOCWE+lCcDBNOU=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=i+svumC3e4SfjQdWFbnN6tDNPORQOCSMSreAU4TlB43DzqvoBZCuFw5DkQQelvCv
	 P0JIRPXG5AOAY5klEKty0PtkLum6kqDU+CadUxATeazWwJ3mH6UZDbxhImKk7qmyv
	 Noi/EmAogSfR93PwrG6YS/yCujwTi/eUEYq5eXUZghk/5PuipOzo7k/f4HtwSCF3d
	 sqpXFEmW1Vy4+1lnWDy5auPF7/cp4+PzFOEplAJANLD0WmyTfA0rs1gd51IvPDMTK
	 xXOMBQeRM5UjTDho9ooqg+Cvnzbfg9nhqJS3SIruP8yeMamTDnSHEK5V5av1BAaws
	 ppy7LsXMOTxcgDf5Bg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M5wPb-1rNV9L3ZZj-007RYv; Fri, 22
 Dec 2023 13:08:12 +0100
Message-ID: <3d777aee-9ec1-4236-98d2-f56b8026b96a@gmx.de>
Date: Fri, 22 Dec 2023 13:08:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hwmon: (acpi_power_meter) Install IPMI handler for Dell
 systems
To: Kai-Heng Feng <kai.heng.feng@canonical.com>,
 Guenter Roeck <linux@roeck-us.net>
Cc: jdelvare@suse.com, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20231220051350.392350-1-kai.heng.feng@canonical.com>
 <5a81eda0-5044-4088-9aba-cf725e6fca9a@roeck-us.net>
 <CAAd53p4NNX9c5pUJgv12V=s_1YJxM3=G+OCYTgcRPqSJVbdi8w@mail.gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <CAAd53p4NNX9c5pUJgv12V=s_1YJxM3=G+OCYTgcRPqSJVbdi8w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Qq3MJFMyL2mPhYT8DMla8fOeCYwbJv/9HGLu9SfkSWNowFqtgWe
 07/fbz07PBe0c2pRW51QNWSx9vhc7VK4Xs7vJh1PtjQ1vJ694GX29vsBQEgUuecmolYHlS9
 iL3q9zP9Ry/wS/SP1L1m1EucJ41fGKdbwjWOIRbuu2noffq9WCKcoKcZlYa/ub/lISgVQ4i
 MAv8PxBG2q3fsSqSz+Urg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5RsHu0gclA4=;y2UR1gVUmKlLxfrJyBkfLFLGNMo
 88cSs0CvJhubhsCZ+GwIsDDUtVu2wyLW7tmP0uqH9F9Yg1HBYYRK/b2fW3DQwy3RakIwkwwWu
 BEAcE7J+Jx5buRkhz3ec4bs9nLGJgW61cizo0U8CcWb/gOwYx3ZfJqNbjqRhsLO8PCy5CgwAp
 GBgYc8JXqpAcBqtocnjBrtu7TDPH/zwYrjltkOYyqDjJsm8Lfc3n3yd/Uk4n8G28asqRf0ALw
 656um/xU0yHZY0x8Izu3LLIwQamSf7saga8N15gscZBf2BuLF5PP//LOHBA/2QXePfVS2rcDr
 JzipGk5Y6kSG/wxoLx1D1otk1ysYvmkhkrlphlZ9t/OSZwueSLex35Z+q3Hb7UbHm3QPLBco6
 cSXI7Rp7xQcJiB29k9aJJta090euFjB7XzqhJhaBNVZZrD7aX+sZcKcbYEXCFWekMWmILCGAI
 sd8CP+t02/Fy9EZW7pz5ExSxtrPO60EHiC3y4+UB8xaLYAg5vlG/I8YFHhLeVCoEu8yPwBd11
 xPILuEQ7XN4DyiLr40Vvs+w6LdBTMe4KLReghWDpd8Geee1AbmiOhqN7G+5IVVIjGbvAQ0YPl
 sUO+KWLTnXwJLFB0tiHPXWQ0KgeQl2jFFmle3MaDQ9XMHE06FScvlX9Ux4xkR4wJHVpeaPtzQ
 x0UCS7n9T+5ORDOpnrz9TekxdxvNkjSuMjmnh+F3v2jFpZ1KBKpFZqdhczsiK6oxQ0J8NYsga
 ti44ScB8A0qltFyIbcSeZlPtNb1bfI1Ma8lCeBz2V14UhIK6whTKYU4gKmZiTcryDeobCcSRG
 9EIGdKVLZzLJgHJ9savcUDDCxeqMAtzHuRN/nJ6ULOPUt6XFVbGOevKXH9enHxYh9+VphV1O1
 aNqbu418IaRlKYR0HWe6OROZFtdxm+eWDuZMXqlTUjDpzMDmdvqRhHQd73rbZqC3IHUtV8WXY
 KMHz3XJ7w3J7weKHrWWUhdzQDJ8=

Am 22.12.23 um 04:57 schrieb Kai-Heng Feng:

> Hi Guenter,
>
> On Thu, Dec 21, 2023 at 7:49=E2=80=AFAM Guenter Roeck <linux@roeck-us.ne=
t> wrote:
>> On Wed, Dec 20, 2023 at 01:13:50PM +0800, Kai-Heng Feng wrote:
>>> The following error can be observed at boot:
>>> [    3.717920] ACPI Error: No handler for Region [SYSI] (00000000ab9e6=
2c5) [IPMI] (20230628/evregion-130)
>>> [    3.717928] ACPI Error: Region IPMI (ID=3D7) has no handler (202306=
28/exfldio-261)
>>>
>>> [    3.717936] No Local Variables are initialized for Method [_GHL]
>>>
>>> [    3.717938] No Arguments are initialized for method [_GHL]
>>>
>>> [    3.717940] ACPI Error: Aborting method \_SB.PMI0._GHL due to previ=
ous error (AE_NOT_EXIST) (20230628/psparse-529)
>>> [    3.717949] ACPI Error: Aborting method \_SB.PMI0._PMC due to previ=
ous error (AE_NOT_EXIST) (20230628/psparse-529)
>>> [    3.717957] ACPI: \_SB_.PMI0: _PMC evaluation failed: AE_NOT_EXIST
>>>
>>> On Dell systems several methods of acpi_power_meter access variables i=
n
>>> IPMI region [0], so request module 'ipmi_si' which will load 'acpi_ipm=
i'
>>> and install the region handler accordingly.
>>>
>>> [0] https://www.dell.com/support/manuals/en-us/redhat-enterprise-linux=
-v8.0/rhel8_rn_pub/advanced-configuration-and-power-interface-acpi-error-m=
essages-displayed-in-dmesg?guid=3Dguid-0d5ae482-1977-42cf-b417-3ed5c3f5ee6=
2
>>>
>>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>> ---
>>>   drivers/hwmon/acpi_power_meter.c | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_pow=
er_meter.c
>>> index 703666b95bf4..b9db53166bc9 100644
>>> --- a/drivers/hwmon/acpi_power_meter.c
>>> +++ b/drivers/hwmon/acpi_power_meter.c
>>> @@ -882,6 +882,8 @@ static int acpi_power_meter_add(struct acpi_device=
 *device)
>>>        strcpy(acpi_device_name(device), ACPI_POWER_METER_DEVICE_NAME);
>>>        strcpy(acpi_device_class(device), ACPI_POWER_METER_CLASS);
>>>        device->driver_data =3D resource;
>>> +     if (dmi_match(DMI_SYS_VENDOR, "Dell Inc."))
>>> +             request_module("ipmi_si");
>>>
>> This looks like a terrible hack to me. Is there precedent of similar ha=
cks
>> elsewhere showing that this is the "way to go" ?
> Yes it's ugly.
>
> The error happens in the ACPI ASL code, so it's not possible to know
> if any method of apci_power_meter requires IPMI region.
> I really can't think of any better solution for it.
>
> Kai-Heng

Maybe we could use an ACPI scan handler for that?
Basically we would call request_module() upon discovering an ACPI IPMI dev=
ice,
so that the necessary module is available for handling the IPMI opregion.
This would also prevent any issues should other devices also require IPMI =
access.

Armin Wolf

>> Guenter
>>
>>>        res =3D read_capabilities(resource);
>>>        if (res)
>>> --
>>> 2.34.1
>>>

