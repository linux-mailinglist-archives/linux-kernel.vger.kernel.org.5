Return-Path: <linux-kernel+bounces-60524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42544850613
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 20:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C789F1F21A3A
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 19:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32151D696;
	Sat, 10 Feb 2024 19:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f64Zw5KF"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275845F57A;
	Sat, 10 Feb 2024 19:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707592298; cv=none; b=HTJuOlQwJxZB0Br4nka16MU0ShGBq3fJxiP8U4pBsQFw0p+hJqu87UlKi4tzzTWqxbsv/1o6njA2+8y9oIn57GyEDWKob+ZmJ4DbAMqQmTdKZnxJzSdE2uECBjx2EwD+HhZAf3c4nezsAKswXVCS2ccM2c5kgyON1SB4PJjdKhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707592298; c=relaxed/simple;
	bh=wPeUBhUW2kGlW/V/wnA9rBebGr/4opFq9eXbSXTtkLw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=iL3GaqkpxhEy57O8Kjr3CGGCC7CEDgVH7/YMy2sWdH6J5jhi6p5YADqPAnfKQ6D0P8STjlf0IxZL0gBEV7xTdgMjzJs8Eu6fx9uUHvtL8cmjU4BPNsLHJkcyHDyzIj+0+QC7or1yFIxENdI5cwa2Qf3WZrOgSCJpBNFAfDLaZcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f64Zw5KF; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3392b12dd21so1133297f8f.0;
        Sat, 10 Feb 2024 11:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707592295; x=1708197095; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QW25N2uFVlcGVDUOyFnfK3R2q7dwZNGEqtVFP6wqDnQ=;
        b=f64Zw5KF9BTmaIUORXZEqLSyZTvg8B0ikdMjEzAe/JfzlCMhSFgmGataAGH8ufOZC8
         XXX15eBvvAialYedAbNBuWBlAWmWAsM+FE3xUlLhnnVX3v4NYbIdbeVeqfMZqgIMxEah
         swY33F5hIqTE8TpMkFU4PFdoDroMI3TeOZfKVn4v4LsAOm0ipaLSYiQ8A/wXEhqk2967
         rmU7P6coizAwchIf5y3mXqXdA/W/RaXCLX39zX8AdZM66KdVCT7/rg/hKUvOkTurpQ2h
         rVLs2b5K7vPaEbw8GKg8NOf3z/yXCd0Afu6mh359PAinN+WEdgnpSpzeTsnixtPatNqg
         xjKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707592295; x=1708197095;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QW25N2uFVlcGVDUOyFnfK3R2q7dwZNGEqtVFP6wqDnQ=;
        b=RWVsfoWqpjK/k7yEAjBxIu7JKvRtM3CE6lxgLABrHqiXaAc81/hoHyg84Qi+E9C/t+
         9OHlfZE7avnrVMlFf9cYHYAt2tc221rPhrRAEi4JwfcoBm8yY1kFNcfR20u/2PxvZ2ku
         nh5H7XlXncDLXVBsn51wiRGlBNUGuDRS0x3eNMRseOcW410dyHoEg12EUs8ILlJCY4lu
         kL8urtuw2oxT/T1DaVHQ7O1lKVyx4zZUfwUJUGyY5dDkNYXfUWP7bQuUPT/X1g5M/txv
         mu64RcHZA3mnphAsLxD3q9rqIjsfrOH7FUIxnDybL2g3c1OriYtHaGxVehWPVWePDG9X
         HJIA==
X-Forwarded-Encrypted: i=1; AJvYcCVX8iyIjCqnVkOeTbWA8IWncAsyvvfT/zav14p/sGVjbm+t+Qv94S0/MJuqLGXcySWP7dLVOV9egAO/FC/FfBpHaMuh54liAGmWAnjeYlDQRPTD30R0jUPZo7WbUkPEBUWx5doV+5kNp2qwPN4Go1obIUbG1G4jmnrNmMK9ApYO
X-Gm-Message-State: AOJu0YyKiYGtXfObIDPL7eV4eX5vZRx26na76FEQ/YXdfJLqWmDS9UHy
	7mV1zHCXpzuJpC75muWOqVPPn92hc6uAQcrWnYDeLcWB3WhT0j0R
X-Google-Smtp-Source: AGHT+IEryM5P8h6J3uUG3S+tq0f18GWvILq30FogFBn9Xv7zPtHu2+tMusX3jagyXFqcA4h+zbhGFQ==
X-Received: by 2002:a5d:64ca:0:b0:33b:6d3a:acf6 with SMTP id f10-20020a5d64ca000000b0033b6d3aacf6mr2483948wri.2.1707592295004;
        Sat, 10 Feb 2024 11:11:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUVuPzPLq6vPk+5Yu46weucEEQHTQ71FQHvz0000d38MLBx1o1ZRQjqlEQb4N3WJjaYp115IQkVyUiupBndFVpBtxhkn/Zd9ryu4I/aC2WgMNKoHj0DZsqWj4vhXRhDnbJ8gKx4cFK6SedC04JdMvdnmbQR6IoL7xcs2WosNQtBSFuYPZ1RkFj6byzrU9SKE5yWxg92LHYrIRxzZeaUcug2EfsjpZEH+VG7yTup8HjWIWOo6m/TMbio4Hg39M2V00O/AIXjtAEMw/p3x4BOSno=
Received: from smtpclient.apple ([167.99.200.149])
        by smtp.gmail.com with ESMTPSA id bp21-20020a5d5a95000000b0033afcc899c1sm2540508wrb.13.2024.02.10.11.11.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Feb 2024 11:11:34 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Re: [PATCH 1/2] net: asix: add 0b95:1790 to AX88179A device list
From: Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <CANEJEGuVPfdteBfY_LyQ+D=t4HGHLvDut-Vj2xFjRM4e8kgh=Q@mail.gmail.com>
Date: Sat, 10 Feb 2024 23:11:21 +0400
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Grant Grundler <grundler@chromium.org>,
 linux-usb@vger.kernel.org,
 netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <D050DF05-8745-42E8-8ED1-890A4DC0380B@gmail.com>
References: <20240205104049.48900-1-christianshewitt@gmail.com>
 <CANEJEGuVPfdteBfY_LyQ+D=t4HGHLvDut-Vj2xFjRM4e8kgh=Q@mail.gmail.com>
To: Grant Grundler <grundler@google.com>
X-Mailer: Apple Mail (2.3774.400.31)

> On 10 Feb 2024, at 10:20=E2=80=AFpm, Grant Grundler =
<grundler@google.com> wrote:
>=20
> On Mon, Feb 5, 2024 at 2:40=E2=80=AFAM Christian Hewitt
> <christianshewitt@gmail.com> wrote:
>>=20
>> Add a generic AX88179A entry for the 0b95:1790 device id:
>>=20
>> kernel: usb 2-1: New USB device found, idVendor=3D0b95, =
idProduct=3D1790, bcdDevice=3D 2.00
>> kernel: usb 2-1: New USB device strings: Mfr=3D1, Product=3D2, =
SerialNumber=3D3
>> kernel: usb 2-1: Product: AX88179A
>> kernel: usb 2-1: Manufacturer: ASIX
>> kernel: usb 2-1: SerialNumber: 00D24DC0
>> kernel: asix 2-1:1.0 (unnamed net_device) (uninitialized): Failed to =
read reg index 0x0000: -32
>> kernel: asix: probe of 2-1:1.0 failed with error -32
>> kernel: ax88179_178a 2-1:1.0 (unnamed net_device) (uninitialized): =
Failed to read reg index 0x0040: -32
>> kernel: ax88179_178a 2-1:1.0 eth1: register 'ax88179_178a' at =
usb-0000:01:00.0-1, ASIX AX88179 USB 3.0 Gigabit Ethernet, =
20:7b:d2:d2:4d:c0
>>=20
>> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
>> ---
>> The change is tested by a LibreELEC (distro) user who reports the NIC =
to be working
>> fine (and logs support this) but the "Failed to read reg index =
0x0000: -32" errors
>> suggest ax88178_info might not be the correct choice. I'm not a =
serious coder so I
>> need to "ask the audience" for suggestions on what more might be =
needed?
>>=20
>> drivers/net/usb/asix_devices.c | 4 ++++
>> 1 file changed, 4 insertions(+)
>>=20
>> diff --git a/drivers/net/usb/asix_devices.c =
b/drivers/net/usb/asix_devices.c
>> index f7cff58fe044..9a7b1136cd98 100644
>> --- a/drivers/net/usb/asix_devices.c
>> +++ b/drivers/net/usb/asix_devices.c
>> @@ -1506,6 +1506,10 @@ static const struct usb_device_id        =
products [] =3D {
>>        // ASIX AX88178 10/100/1000
>>        USB_DEVICE (0x0b95, 0x1780),
>>        .driver_info =3D (unsigned long) &ax88178_info,
>> +}, {
>> +       // ASIX AX88179A 10/100/1000
>> +       USB_DEVICE(0x0b95, 0x1790),
>> +       .driver_info =3D (unsigned long)&ax88178_info,
>> }, {
>=20
> Hi Christian!
> Seems like there are two problems here:
> 1) The USB output is telling you this device is a AX88179A : the
> changes most likely should be in ax88179_178a.c using the
> ax881798_info:
>   =
https://elixir.bootlin.com/linux/latest/source/drivers/net/usb/ax88179_178=
a.c#L1690

Yup, having sent the patch some git grep=E2=80=99ing showed me the newer =
driver
already has the ID for the card included.

> 2) What Andrew Lunn said. I'll add the asix driver should not be
> probing (or claiming) this device - or at least be quiet about it when
> it does.

So the problem now is .. I have both drivers enabled in kernel config:

=
https://github.com/LibreELEC/LibreELEC.tv/blob/master/projects/RPi/devices=
/RPi5/linux/linux.aarch64.conf#L2324-L2325

And This is a Linux 6.6.10 kernel boot (without this patch):

https://paste.libreelec.tv/oriented-mastodon.log

The card is visible on the USB bus but why isn=E2=80=99t the correct =
(newer)
driver probing? =C2=AF\_(=E3=83=84)_/=C2=AF=20

Christian


