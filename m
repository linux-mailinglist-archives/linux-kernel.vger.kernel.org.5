Return-Path: <linux-kernel+bounces-98102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 890B487752C
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 03:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02DE11F21835
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 02:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19E1FC11;
	Sun, 10 Mar 2024 02:39:53 +0000 (UTC)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21011C2C7;
	Sun, 10 Mar 2024 02:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710038393; cv=none; b=KSp2pLElGX8F17DSXy2vJe4VneofXBbCrNzdfe3lQUqSwOLTE0C7obY54EO8t9ZsVh/oVFmIazsdB4r1xhjbrBb6FJ4JZMUJsKP9W2o97ZbMK7EIew583LF5Py0rQhOGsyTbWXqMblIJSD+NosCc1AR+qByVmD2cdojKnTEhp+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710038393; c=relaxed/simple;
	bh=Omvempoqd+sngk7mKffsFzvLt9TugmoWalTt/XjmIHA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NWKokxPWP2LilvR9Mmf6ORMP4NiFVbkGcXFWBHPez8DhxMBLqDtvnGgLyFJvw2VZGKyCeIyjy7/tXu4CFP9hpHZJEws7/0y10QzO8pBH7MZpooG58RDrl2Vx4S3SzE9NYwCYjKvwrrNsv1jVOrG1kjKCZDTvfzRq4We4MkYKLNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a44e3176120so422429966b.1;
        Sat, 09 Mar 2024 18:39:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710038389; x=1710643189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AvNvYyH9dy7cH6SHuAgl0UQLbOc0nmvCaU9MsuXg9kg=;
        b=i6iq5++QeNI2Nx5EmpAWayu3+9M/8Endw8IDujqNuiJxf4FaJBcvUm5j4NYXtx5K+F
         8PXZkaahVPIp4LIVoMyHD1uULtZntvkL6hQ4cZGHF5zdivPMpFiXFy3ZoweC27yE3eax
         ixTPpttjvtJFfElE7hg3qjKa487JsQ3FQZGgKCcDtIqud48X0DFOF4L8jItNdenmdvYx
         ZPFQabiyzX4ksYZKaV3yKiEdMWSR4ZpMBYWqI++uU+JyoiukAz57hM5SF94cglb/htAV
         8b+sMr6zyTDTD7c3903z1g1wnR9UtAXA+6MKYvdyqLM9UG4m+0vD1gdUmbavFvzMuSTC
         ixJQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+VutJJCLF797UmDqHM30TB+dvjHHjIhh1TKmpp3j2/STAEF23nIB371p9mnP47mQIlhp1nlMqOheNBsPh2RPL+XUH6Uk467tV54GkWajoBD4UbBcHCQZsyleWHC+BpAPy5E9bnCfxXnJc5wKNwhY46p/+0R2hNWQzqyq6aBVsKrjuHruP9jcfVmgeGEY=
X-Gm-Message-State: AOJu0YwS0qGEej5KW5nbIzCNdaUAZ7GKkRVHteDbLuB/I4RVkbTVJWCB
	OajxNcc0spafuFT1yAqMbnc5cGHJtelY4vOykze/h2x50IvPoTYMM7EwG6iuWbg=
X-Google-Smtp-Source: AGHT+IE7htx7lspAXEdARTCDXzGOvObX6gJSB8jhg3mHB0wVom63N/cQPlE+nasJPbfIznuVYgbe9A==
X-Received: by 2002:a17:906:710c:b0:a45:f4e9:a234 with SMTP id x12-20020a170906710c00b00a45f4e9a234mr1687042ejj.14.1710038388921;
        Sat, 09 Mar 2024 18:39:48 -0800 (PST)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id k16-20020a1709067ad000b00a4537466591sm1473579ejo.32.2024.03.09.18.39.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Mar 2024 18:39:48 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56829f41f81so2920517a12.2;
        Sat, 09 Mar 2024 18:39:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXb8WkqO17qyurtM8mcIABniqtvPW3RViMHCLFWV0DfpWO5d3RBOR6/Iiy0XWiK88wbbz3QG+5tPzLdjfK63Zep5FDXeLqZb0KG8cvT6lR1CCotki+4nbbxrQIsULhimJY5vqOw14HPo0ZP5mH8WTTNvFZsU1DRVYo+MFfzeaCsYkuxI2ciDSE1T1ngNIU=
X-Received: by 2002:a50:d642:0:b0:566:ab45:e6c0 with SMTP id
 c2-20020a50d642000000b00566ab45e6c0mr2046054edj.33.1710038388571; Sat, 09 Mar
 2024 18:39:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240308210519.2986-1-W_Armin@gmx.de> <a6152da8-5f3a-458b-bc48-4bc654677ece@linux.intel.com>
 <2fcd7176-108a-47dc-8096-99a5b6a69641@gmx.de>
In-Reply-To: <2fcd7176-108a-47dc-8096-99a5b6a69641@gmx.de>
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Date: Sat, 9 Mar 2024 18:39:37 -0800
X-Gmail-Original-Message-ID: <CAC41dw88TfH472rFG2+WnG=BuHThBXSUfWOzRV0aJacdYHjFOQ@mail.gmail.com>
Message-ID: <CAC41dw88TfH472rFG2+WnG=BuHThBXSUfWOzRV0aJacdYHjFOQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] platform/x86: wmi: Support reading/writing 16 bit
 EC values
To: Armin Wolf <W_Armin@gmx.de>
Cc: hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com, rafael@kernel.org, 
	lenb@kernel.org, mario.limonciello@amd.com, linux-acpi@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 9, 2024 at 11:17=E2=80=AFAM Armin Wolf <W_Armin@gmx.de> wrote:
>
> Am 09.03.24 um 18:07 schrieb Kuppuswamy Sathyanarayanan:
>
> > On 3/8/24 1:05 PM, Armin Wolf wrote:
> >> The ACPI EC address space handler currently only supports
> >> reading/writing 8 bit values. Some firmware implementations however
> >> want to access for example 16 bit values, which is prefectly legal

/s/prefectly/perfectly

> >> according to the ACPI spec.
> >>
> >> Add support for reading/writing such values.
> >>
> >> Tested on a Dell Inspiron 3505 and a Asus Prime B650-Plus.
> >>
> >> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> >> ---
> >> Changes since v3:
> >> - change type of variable i to size_t
> >>
> >> Changes since v2:
> >> - fix address overflow check
> >>
> >> Changes since v1:
> >> - use BITS_PER_BYTE
> >> - validate that number of bytes to read/write does not overflow the
> >>    address
> >> ---
> >>   drivers/platform/x86/wmi.c | 49 ++++++++++++++++++++++++++++++------=
--
> >>   1 file changed, 39 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
> >> index 1920e115da89..d9bf6d452b3a 100644
> >> --- a/drivers/platform/x86/wmi.c
> >> +++ b/drivers/platform/x86/wmi.c
> >> @@ -1153,6 +1153,34 @@ static int parse_wdg(struct device *wmi_bus_dev=
, struct platform_device *pdev)
> >>      return 0;
> >>   }
> >>
> >> +static int ec_read_multiple(u8 address, u8 *buffer, size_t bytes)
> >> +{
> >> +    size_t i;
> >> +    int ret;
> >> +
> >> +    for (i =3D 0; i < bytes; i++) {
> >> +            ret =3D ec_read(address + i, &buffer[i]);
> >> +            if (ret < 0)
> >> +                    return ret;
> >> +    }
> >> +
> >> +    return 0;
> >> +}
> > Why not use ec_transaction?
>
> Hi,
>
> because ec_transaction() is meant to send raw commands to the EC. And AFA=
IK read/write transactions can only transfer a
> single byte at once, so using ec_transaction() would yield no benefit her=
e.

From the implementation, I don't see any length restriction. If it is
a functional restriction, then fine.

int ec_transaction(u8 command,
                   const u8 *wdata, unsigned wdata_len,
                   u8 *rdata, unsigned rdata_len)
{
        struct transaction t =3D {.command =3D command,
                                .wdata =3D wdata, .rdata =3D rdata,
                                .wlen =3D wdata_len, .rlen =3D rdata_len};

        if (!first_ec)
                return -ENODEV;

        return acpi_ec_transaction(first_ec, &t);
}
EXPORT_SYMBOL(ec_transaction);


>
> >
> >> +
> >> +static int ec_write_multiple(u8 address, u8 *buffer, size_t bytes)
> >> +{
> >> +    size_t i;
> >> +    int ret;
> >> +
> >> +    for (i =3D 0; i < bytes; i++) {
> >> +            ret =3D ec_write(address + i, buffer[i]);
> >> +            if (ret < 0)
> >> +                    return ret;
> >> +    }
> >> +
> >> +    return 0;
> >> +}
> > Same as above.
> >> +
> >>   /*
> >>    * WMI can have EmbeddedControl access regions. In which case, we ju=
st want to
> >>    * hand these off to the EC driver.
> >> @@ -1162,27 +1190,28 @@ acpi_wmi_ec_space_handler(u32 function, acpi_p=
hysical_address address,
> >>                        u32 bits, u64 *value,
> >>                        void *handler_context, void *region_context)
> >>   {
> >> -    int result =3D 0;
> >> -    u8 temp =3D 0;
> >> +    int bytes =3D bits / BITS_PER_BYTE;
> >> +    int ret;
> >> +
> >> +    if (!value)
> >> +            return AE_NULL_ENTRY;
> >>
> >> -    if ((address > 0xFF) || !value)
> >> +    if (!bytes || bytes > sizeof(*value))
> >>              return AE_BAD_PARAMETER;
> >>
> >> -    if (function !=3D ACPI_READ && function !=3D ACPI_WRITE)
> >> +    if (address > U8_MAX || address + bytes - 1 > U8_MAX)
> >>              return AE_BAD_PARAMETER;
> >>
> >> -    if (bits !=3D 8)
> > Since you want to support only 16 bit reads/writes, can you check for >=
16
>
> The 16 bit reads/writes where meant as an example, ACPI code can request =
much larger values.
> The WMI EC handler should be able to handle those, just like the regular =
ACPI EC handler.
>

Got it.

> Thanks,
> Armin Wolf
>
> >> +    if (function !=3D ACPI_READ && function !=3D ACPI_WRITE)
> >>              return AE_BAD_PARAMETER;
> >>
> >>      if (function =3D=3D ACPI_READ) {
> >> -            result =3D ec_read(address, &temp);
> >> -            *value =3D temp;
> >> +            ret =3D ec_read_multiple(address, (u8 *)value, bytes);
> >>      } else {
> >> -            temp =3D 0xff & *value;
> >> -            result =3D ec_write(address, temp);
> >> +            ret =3D ec_write_multiple(address, (u8 *)value, bytes);
> >>      }
> >>
> >> -    switch (result) {
> >> +    switch (ret) {
> >>      case -EINVAL:
> >>              return AE_BAD_PARAMETER;
> >>      case -ENODEV:
> >> --
> >> 2.39.2
> >>
> >>

