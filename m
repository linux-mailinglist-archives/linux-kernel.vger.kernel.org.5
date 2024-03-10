Return-Path: <linux-kernel+bounces-98137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A83A877588
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 07:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E3E71C21FF3
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 06:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB2D1804A;
	Sun, 10 Mar 2024 06:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="qLQNttj/"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B8611723;
	Sun, 10 Mar 2024 06:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710052070; cv=none; b=A7Bjoisk0RvW3jyYjl8kdLDJC/ktlprJxQasUUwwuUSoKbpG07bSzmj2MrmFiqFtGXaUth88I54fJ5fyCE+Jeimapx+YpWGPWIyuuuO12zc5M+EOMIPOcoRKy2o/91CaQyoCQW6faaguHSqyyZAJGxz6hjHT3Q7kCCB+TmgwSc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710052070; c=relaxed/simple;
	bh=DyLgsmM96BmqfyVZoTdyh2YQQOsjw3sgd/mTOm/5Yl0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d9PMYFF9NeHktAGMsMfLjE3h2qDVKjBEDpNsLtx4mqmY2Ogit/AN5gPdu6LfDgYiK0fzFXZyRhl6AW674B0ZtWClr7NABbMzfGx3wEH6Xx/t2mQTGSiwHEnn4ebK3ThibgFmeFnLw1RqXjY5R31N68l1RvmfTF2ALB0YVxzZob8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=qLQNttj/; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1710052051; x=1710656851; i=w_armin@gmx.de;
	bh=DyLgsmM96BmqfyVZoTdyh2YQQOsjw3sgd/mTOm/5Yl0=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=qLQNttj/GxnmA1i/Zto9Q/zaEATcqpVydej6VpDg5Tun+6STQIPTOfd7/YcVH4c9
	 XqOLfJYe+4vpxGIKGDmSWij1ku5jIxfOP9ZrfDIUcv1Jxn1E9BqYQTo/2VrVIE2qT
	 wpXjnJo+qsZsJu+5aDRO6gN+9yOWaYuNyui1TO4bfxWjjf7RiY+2rGwzChkwdgf3A
	 SfytEZ4KrtRllZEvTrvj3cpQ5uyjy/OlWZJne4cTr/IEzfGrfw8U/1QsG+AkKoI2q
	 wfgl0CAVf4O+Kz2N4Ff5miPUTFxUehtI1UqVlvAyIoRDSZ2nRWGy+anXvexMNfttZ
	 m/OgYI8x+3g4hxlang==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MoO6C-1r3ZJj1vvE-00olWv; Sun, 10
 Mar 2024 07:27:31 +0100
Message-ID: <f23e2390-a054-4958-98a1-103327fb6bd5@gmx.de>
Date: Sun, 10 Mar 2024 07:27:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] platform/x86: wmi: Support reading/writing 16 bit
 EC values
To: sathyanarayanan.kuppuswamy@linux.intel.com
Cc: hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com, rafael@kernel.org,
 lenb@kernel.org, mario.limonciello@amd.com, linux-acpi@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240308210519.2986-1-W_Armin@gmx.de>
 <a6152da8-5f3a-458b-bc48-4bc654677ece@linux.intel.com>
 <2fcd7176-108a-47dc-8096-99a5b6a69641@gmx.de>
 <CAC41dw88TfH472rFG2+WnG=BuHThBXSUfWOzRV0aJacdYHjFOQ@mail.gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <CAC41dw88TfH472rFG2+WnG=BuHThBXSUfWOzRV0aJacdYHjFOQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Pt77kOH82n/uRUyYM0r1VGD6aqmBdWLV6bXm6Qr2snNJiWwYx6x
 A0aQHdtH3KLMZItgbRVpo3VqV1JX3uWf63OS1pci//XHADouohoSvqJgTJgS5PO6J5wqYEp
 bo7LmWogviwBg4Zd4xAh7DKxXmUjlFXEEZ+FkSJTOTC8lx5LXOSXRGpNCgobaD3fEu7g9In
 NFg1dcenDsh5r4tC7aIVw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:iFk5KlLPr8w=;4aPoaGbHCA1tww3bw20A+WPNalQ
 HcSTlOLgb7YNvJ923Od0dq2paLBi8zgq9Em+GHY73jdWLz5kluG66jRJ/xIgEDQm7xpvjIHp8
 zFX8E93dPFbc5M7lnMzRjVzgqKe7tuaUqOUiHpLvKQHHCJDulzODKgH34fVYqhNJQqNKCVm34
 nYhTkqTZad67WFOnjxl7epd5VuMzQJ/GK/eyPnxhE+bUtsk04b9Qc1k3Ds72Cy/UuzraCeY2M
 M7KuQG86m5KMMPKnC/MKdO5CAOyES2fUcP3nWNRDPmP1XEZVyU/UAOOGdjh8dnCL6G8k1MnbP
 FJOND4Zy1DmspVzFQbyEk8noUoov0o7C2Fl3Yu+ETHNEfj85AzxMGuFsCE6JnzX3VQ/Lzb5io
 vJaGPYwyw1bS4G/YYR+EHBVQGQaAxkxipFTXLWNdECicGl8BRfhe3g30Ii873esWebMj5VFg8
 jtJKM53NpMmkLEX/dw1+RcdqvLfsWQKAAn+VfklmDju2lYC6qkr1jRbOcXsg7xDrbl2Pu2/ln
 DAVkOhRihKE3Z8wk7i8mrChR3qvwOf/2CituAbAmOS2a9o5SnOeY0PhXRejYVpEg23cMhBL4h
 CjgkzPsBNyenm1fcTB2AwoT8XA4iTKggm0GPJlZ8jFp29t40RIvXZnRJnJe+AtvX3eIhZqWox
 cJXdt8aCJ/zJOfN1SVLL75WiNgPGrgfXEHZCKirf/3F6O6uU7t2gUTqduW1vk5GioS7AEM23J
 xrcSQKXAPNHmlbm2kDvmfRL8HJDv5jMB+PjUjBQ7i0VI/mt5ydpww8TevA+A7e3DrDpxEU19B
 ZnlxGiF5Nq0PZeMNXGMZ+tl175FE4CVykyxHu0TrYr/as=

Am 10.03.24 um 03:39 schrieb Kuppuswamy Sathyanarayanan:

> On Sat, Mar 9, 2024 at 11:17=E2=80=AFAM Armin Wolf <W_Armin@gmx.de> wrot=
e:
>> Am 09.03.24 um 18:07 schrieb Kuppuswamy Sathyanarayanan:
>>
>>> On 3/8/24 1:05 PM, Armin Wolf wrote:
>>>> The ACPI EC address space handler currently only supports
>>>> reading/writing 8 bit values. Some firmware implementations however
>>>> want to access for example 16 bit values, which is prefectly legal
> /s/prefectly/perfectly
>
>>>> according to the ACPI spec.
>>>>
>>>> Add support for reading/writing such values.
>>>>
>>>> Tested on a Dell Inspiron 3505 and a Asus Prime B650-Plus.
>>>>
>>>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>>>> ---
>>>> Changes since v3:
>>>> - change type of variable i to size_t
>>>>
>>>> Changes since v2:
>>>> - fix address overflow check
>>>>
>>>> Changes since v1:
>>>> - use BITS_PER_BYTE
>>>> - validate that number of bytes to read/write does not overflow the
>>>>     address
>>>> ---
>>>>    drivers/platform/x86/wmi.c | 49 ++++++++++++++++++++++++++++++----=
----
>>>>    1 file changed, 39 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
>>>> index 1920e115da89..d9bf6d452b3a 100644
>>>> --- a/drivers/platform/x86/wmi.c
>>>> +++ b/drivers/platform/x86/wmi.c
>>>> @@ -1153,6 +1153,34 @@ static int parse_wdg(struct device *wmi_bus_de=
v, struct platform_device *pdev)
>>>>       return 0;
>>>>    }
>>>>
>>>> +static int ec_read_multiple(u8 address, u8 *buffer, size_t bytes)
>>>> +{
>>>> +    size_t i;
>>>> +    int ret;
>>>> +
>>>> +    for (i =3D 0; i < bytes; i++) {
>>>> +            ret =3D ec_read(address + i, &buffer[i]);
>>>> +            if (ret < 0)
>>>> +                    return ret;
>>>> +    }
>>>> +
>>>> +    return 0;
>>>> +}
>>> Why not use ec_transaction?
>> Hi,
>>
>> because ec_transaction() is meant to send raw commands to the EC. And A=
FAIK read/write transactions can only transfer a
>> single byte at once, so using ec_transaction() would yield no benefit h=
ere.
>  From the implementation, I don't see any length restriction. If it is
> a functional restriction, then fine.
>
> int ec_transaction(u8 command,
>                     const u8 *wdata, unsigned wdata_len,
>                     u8 *rdata, unsigned rdata_len)
> {
>          struct transaction t =3D {.command =3D command,
>                                  .wdata =3D wdata, .rdata =3D rdata,
>                                  .wlen =3D wdata_len, .rlen =3D rdata_le=
n};
>
>          if (!first_ec)
>                  return -ENODEV;
>
>          return acpi_ec_transaction(first_ec, &t);
> }
> EXPORT_SYMBOL(ec_transaction);

Since we are using the ACPI_EC_COMMAND_READ/_WRITE, we can only read/write=
 a single byte, as specified
in ACPI (12.3.1 and 12.3.2).

Thanks,
Armin Wolf

>>>> +
>>>> +static int ec_write_multiple(u8 address, u8 *buffer, size_t bytes)
>>>> +{
>>>> +    size_t i;
>>>> +    int ret;
>>>> +
>>>> +    for (i =3D 0; i < bytes; i++) {
>>>> +            ret =3D ec_write(address + i, buffer[i]);
>>>> +            if (ret < 0)
>>>> +                    return ret;
>>>> +    }
>>>> +
>>>> +    return 0;
>>>> +}
>>> Same as above.
>>>> +
>>>>    /*
>>>>     * WMI can have EmbeddedControl access regions. In which case, we =
just want to
>>>>     * hand these off to the EC driver.
>>>> @@ -1162,27 +1190,28 @@ acpi_wmi_ec_space_handler(u32 function, acpi_=
physical_address address,
>>>>                         u32 bits, u64 *value,
>>>>                         void *handler_context, void *region_context)
>>>>    {
>>>> -    int result =3D 0;
>>>> -    u8 temp =3D 0;
>>>> +    int bytes =3D bits / BITS_PER_BYTE;
>>>> +    int ret;
>>>> +
>>>> +    if (!value)
>>>> +            return AE_NULL_ENTRY;
>>>>
>>>> -    if ((address > 0xFF) || !value)
>>>> +    if (!bytes || bytes > sizeof(*value))
>>>>               return AE_BAD_PARAMETER;
>>>>
>>>> -    if (function !=3D ACPI_READ && function !=3D ACPI_WRITE)
>>>> +    if (address > U8_MAX || address + bytes - 1 > U8_MAX)
>>>>               return AE_BAD_PARAMETER;
>>>>
>>>> -    if (bits !=3D 8)
>>> Since you want to support only 16 bit reads/writes, can you check for =
>16
>> The 16 bit reads/writes where meant as an example, ACPI code can reques=
t much larger values.
>> The WMI EC handler should be able to handle those, just like the regula=
r ACPI EC handler.
>>
> Got it.
>
>> Thanks,
>> Armin Wolf
>>
>>>> +    if (function !=3D ACPI_READ && function !=3D ACPI_WRITE)
>>>>               return AE_BAD_PARAMETER;
>>>>
>>>>       if (function =3D=3D ACPI_READ) {
>>>> -            result =3D ec_read(address, &temp);
>>>> -            *value =3D temp;
>>>> +            ret =3D ec_read_multiple(address, (u8 *)value, bytes);
>>>>       } else {
>>>> -            temp =3D 0xff & *value;
>>>> -            result =3D ec_write(address, temp);
>>>> +            ret =3D ec_write_multiple(address, (u8 *)value, bytes);
>>>>       }
>>>>
>>>> -    switch (result) {
>>>> +    switch (ret) {
>>>>       case -EINVAL:
>>>>               return AE_BAD_PARAMETER;
>>>>       case -ENODEV:
>>>> --
>>>> 2.39.2
>>>>
>>>>

