Return-Path: <linux-kernel+bounces-7117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B037881A1DC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D47FB1C221FF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B49F3E47F;
	Wed, 20 Dec 2023 15:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="HA3rBzvq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8689D3E467;
	Wed, 20 Dec 2023 15:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1703084992; x=1703689792; i=w_armin@gmx.de;
	bh=qhG3JEYtczaYqpd6vjtfBVybBteTkGpA87cR/MSHPlI=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=HA3rBzvqLE5fuosDh39Wsz650AgeWgd+EM123XUEi0rRQeCqc5IM1TFQR1fMQFEa
	 UFGX7m8xFJyZnUhrzVZuIImkU/ZKk+7vxugaQJ1IW/lR0O9z2vojjeHc6q8PUYcOC
	 8Yuq6FwQN3xGC1rg0bFdOCE6BWSPcpQeD93EnJmWS7sDAWI9IEPlReemA2f9xi6yM
	 E13cKAZkNbrVln0OG9WzpO/l2UIvPkh5M6tEat6X5NaFqWsHpR9sydbfx1zzjHOmZ
	 hbDaoggxClkEJAVTL95yh9Kr5Notd0A5t74nFDhij8Osbh2o8l7AqRnmKwPrX5uBi
	 4onEmBXIBkSVhF+Erw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M6DWi-1rMaz237w8-006ckQ; Wed, 20
 Dec 2023 16:09:52 +0100
Message-ID: <d8e455b9-0a27-4361-8f92-9f1cb1fff537@gmx.de>
Date: Wed, 20 Dec 2023 16:09:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hwmon: (acpi_power_meter) Install IPMI handler for Dell
 systems
To: Kai-Heng Feng <kai.heng.feng@canonical.com>, jdelvare@suse.com,
 linux@roeck-us.net
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231220051350.392350-1-kai.heng.feng@canonical.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20231220051350.392350-1-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+uFY2EtJJvAKtG9sOckP3KeI20V3v0lxatL9nlEfHmFKY+Ukusk
 cPvpEXgyK200UrGdWk01qIpU2D2g4dQ5a8uMOAVm8MMNI9X1iuS4JL2h/tVCw/c9/cHCAse
 2lWmO/WQoiG3DxaObLGcKbHsargq5XeyS8FtGYnCHfU3RXzOgMjSJBHoSeVG9kDfNcXnCOL
 F1eyBJYmInuaKCMxWTraA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tKS1Lk1+9CI=;yjbvVaAnZS2MS8n59Q+kv8j0bjP
 c5UlZlTALQTLNlrooBrnnmBWSjEslLxGyqRici9Bu5rDAzVWI+kskOlGz0T1DLM5oajNJuYgL
 vk9Vy4xry7Ig6ywzVT+jcU5/SNK9GN3VbcpEYIV78P/T5FKOlbmhUi9UblOhWAxsMSf1+JTOz
 0SdC9o3reqpfSRDgTVB0peMbWDpiEyc0f8fzoMTGtNBIkQNXJxszO1Q9oYGs8h/WEV42XnqBc
 edszaYTX/JsrOGH98wk+Vib3STf1N5mpv2ZAlYZfENcBg0Zu8X6JTDdRgey8sn07LXm+zNN4r
 dwPFZigXVYJWRamwrfSU2h9D6YERwh06Q1ugYawZ+lk4bnerHkYzUQcEmBEvu1AAH7eXbbIFe
 jAMgJG2o/kDjxN0rw9dEgX/ggjYcICG9BKJjiJALQRsuUxXU0uMgWozIS/vUcUab7a9qoqLia
 32w8r6QaQgKZYWe8XaahFrfLpHXUDKUipAomS5Q65O4w6vFNIni0Uu9/Ff1Pf7riQCdU0oTrO
 G8Nw61LTuHBHi+WgH+orz9vD+CmfsNzhxelLnvPazZmPKuJhcVxz6rzdsb5YslF6BN0mas7CU
 2w/LrRiON1L22AR7cFXZAMALojK+W1aAoj8zi7CTEYDk2zQoNsKHOSit2B/IhJV21afCcnDdR
 VNQxnE4E2lKL91H+N6ZKi5/AQDs0CSMDzIhB9xI4YYq2lz8SoEUEtHSTNugJJJyXlPM8rgu55
 QK0mah29bJ5rwglUkrP1b3na9seQ2izJu0k4W5TmWfA8EZ+m34N82tGontGyAs1fcUw3P9YDp
 Cttz7RQVXUV/obzgK68h69YqXruPFQC04mQfSgeI2ZtKLtkJZA6DVCexeI2HyOUjYCWrFQ4CF
 Jl3bqAzZnNEaKxoFhZehdoYh3rvYg3aWjj3nT4ixG0ETYy1CTw1nDydUlMTKGhxP6Q8xfiS+L
 2DVbkQSp6SfSLusb2XfMxh+x0RM=

Am 20.12.23 um 06:13 schrieb Kai-Heng Feng:

> The following error can be observed at boot:
> [    3.717920] ACPI Error: No handler for Region [SYSI] (00000000ab9e62c=
5) [IPMI] (20230628/evregion-130)
> [    3.717928] ACPI Error: Region IPMI (ID=3D7) has no handler (20230628=
/exfldio-261)
>
> [    3.717936] No Local Variables are initialized for Method [_GHL]
>
> [    3.717938] No Arguments are initialized for method [_GHL]
>
> [    3.717940] ACPI Error: Aborting method \_SB.PMI0._GHL due to previou=
s error (AE_NOT_EXIST) (20230628/psparse-529)
> [    3.717949] ACPI Error: Aborting method \_SB.PMI0._PMC due to previou=
s error (AE_NOT_EXIST) (20230628/psparse-529)
> [    3.717957] ACPI: \_SB_.PMI0: _PMC evaluation failed: AE_NOT_EXIST
>
> On Dell systems several methods of acpi_power_meter access variables in
> IPMI region [0], so request module 'ipmi_si' which will load 'acpi_ipmi'
> and install the region handler accordingly.

Hi,

this driver should be loaded automatically if an ACPI IPMI device is prese=
nt.
Can you share the output of "acpidump"?

Armin Wolf

> [0] https://www.dell.com/support/manuals/en-us/redhat-enterprise-linux-v=
8.0/rhel8_rn_pub/advanced-configuration-and-power-interface-acpi-error-mes=
sages-displayed-in-dmesg?guid=3Dguid-0d5ae482-1977-42cf-b417-3ed5c3f5ee62
>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>   drivers/hwmon/acpi_power_meter.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power=
_meter.c
> index 703666b95bf4..b9db53166bc9 100644
> --- a/drivers/hwmon/acpi_power_meter.c
> +++ b/drivers/hwmon/acpi_power_meter.c
> @@ -882,6 +882,8 @@ static int acpi_power_meter_add(struct acpi_device *=
device)
>   	strcpy(acpi_device_name(device), ACPI_POWER_METER_DEVICE_NAME);
>   	strcpy(acpi_device_class(device), ACPI_POWER_METER_CLASS);
>   	device->driver_data =3D resource;
> +	if (dmi_match(DMI_SYS_VENDOR, "Dell Inc."))
> +		request_module("ipmi_si");
>
>   	res =3D read_capabilities(resource);
>   	if (res)

