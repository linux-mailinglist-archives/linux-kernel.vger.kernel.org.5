Return-Path: <linux-kernel+bounces-98292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFC28777FC
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 19:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F4111C209D0
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 18:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D1C39AF9;
	Sun, 10 Mar 2024 18:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="JTMi37VH"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB4E39AD5;
	Sun, 10 Mar 2024 18:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710095235; cv=none; b=oP80rBsm9ufi+j68ljUdx1dWDQX0STRNOq9Nb1V2gpgoujfAxs4IKVkWDcELhZ4n15vP3r+wWAybaMOOqjwx9EQklxlR5cGTMnfsGZHJVGMN2Tfi4w/rRnjtRU7f8mi6pNZtNHRnDa0Oo6+XUQ49nqyzTd8ILKNxZt279btgE8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710095235; c=relaxed/simple;
	bh=7m/DLakGgAobc6nOAFJVDjSHsgVihXjVdE0rngDWrNs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EjgxVW/XHGxO0X1UmqTTLtn9toejOhogpsrMC2t8YD9vJh9EJiuxKO6pG3BGef+YY/qnLSzNisYM33J0UdNr4kfwzksGyqjeCqp7wxG8julygulRNIDPrLlM+lhjGh9XD0j6PJD+pH+K0rlkmC4cLjT7F1MCx/g1UIIFjFZVnMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=JTMi37VH; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1710095211; x=1710700011; i=w_armin@gmx.de;
	bh=7m/DLakGgAobc6nOAFJVDjSHsgVihXjVdE0rngDWrNs=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=JTMi37VHsjnU8TH27hHNmt1aXypjU1PJ/NkyrzIosyRQBt74XM9EA1m/O/oeGOaA
	 k6oOmoTZ1+EgOAyyPMCjsVhUXRPdTNQwAsMmJ+1xSdKyCfivsSwyMgZDlc4H85CAq
	 p9QR1arMwXOYlfwsP0sMN1obaVAaGK6CHifjogp94mMLDnCWZ18N5Y3CK0djRUiG4
	 p6RXJ3pFO9cZhEcCJeylea1yQ+vXpjAZhtPBeVJ76DaSNcVkT6SOSoFp05NBNJoOp
	 F6XBf4kseFFmNTc4zqwSOS33dOeHmR0ty/WFh7xc2dQjsqYPWp+ojs6aw8hX76lYL
	 YUWRx9Bln/MgWMIAZA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MowKi-1r2qG51kw2-00qQSD; Sun, 10
 Mar 2024 19:26:51 +0100
Message-ID: <96a938d4-f5c4-4eb9-8406-94102d4b3312@gmx.de>
Date: Sun, 10 Mar 2024 19:26:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hwmon: (dell-smm) Add Dell G5 5505 to DMI table
To: tjakobi@math.uni-bielefeld.de, =?UTF-8?Q?Pali_Roh=C3=A1r?=
 <pali@kernel.org>, Jean Delvare <jdelvare@suse.com>,
 Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240310174144.859510-1-tjakobi@math.uni-bielefeld.de>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20240310174144.859510-1-tjakobi@math.uni-bielefeld.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tKcnxFggjTDqM+X60Hn+e/OTGF9icHaFjGkdkEYCgPWpgBZYuJq
 Mwy7IqTy7u2Lz/CpYI+s0xFyMtxVd1mQALoILDwo9qHLRjwWLHAFcaJUFyOGjYki/OyWQ7U
 FAerywnpMGp5GW0AbZyP2TLpav9MvcCvclOmtR0uBeDfnbJ7eXKRCnbQ7dWSYreVvy4UyRU
 2HILckoq5PcIhvg/tCAjg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yUMZ9XzHdA0=;kD6XaqyNTLIqde9GX+C8Mua0j84
 1fyDC0miOcrKVtdkSR0G8hs5e0xRPWxgnBpAxh7CTrHfFa1SHwy2RGxOZy0aKOvD4L7ficaYK
 IMPGupxhcOqmeIrNJMMNh7fFe26bl/Q05rTpiZ03L5iwh7eHWD9MR3io0DXK3pcRSt956J+Xk
 5uJlV0w8zvP69c8JuPzqjG/5u5YUHAseHpdOW/FjzGpNr3fkTrCK6oKMqdpSGab1Nu4PSsaza
 5q7sH/hqisxzqJ1WqRb9m+wz4nKdYTm01Qc0EMFK9r26dz9LI5k2a9G49mUWP6jGOzUm1D7Kl
 zRbVpzapOCmDiL4Q+zf+iuUktNMcjRbaLYBEh4A0AbtgbtYJmozjpYv6lOVGmJI9yfbwoU+8A
 6/ZHbsoeguN+AlI1tpE6eYCcTOSGsmMEZafgUMbhk/2PLumtiXrbrMX6WopyVVtCfRi9NiRbr
 Y6GBDJjfDsKDp7J8T3w097IcyQ4LU3A9ZRcu5SoZPuNjnxHyF5+RcpuBjRWAlxHFiqq1ef2Ee
 QT+mP8KPWPxi212eYfA0O736Wz5KrpPzvuyb9nE8+R8D1XTVKsFvczXUUgGC+PJS2jStU38xC
 jYWetNCj+w+4JKCE+DneOaSjCS8GKAGxlkx78LfbZUbMiFmvrKv7yaxSxkLLLU4aaPOrEMqTb
 a0uCgYIlrMbZMWLjuaLIidXaSaJldMF14fLBDjBnA3hWo2H6Ixz7rUW/8tnJvV+EYvkDMwutx
 OtLt31uQr+eekmVff2C//AArlx3hebsEaXa9sCRUX57o5PKIxYzL1LeNz6Glk0ecWEUz2d9dm
 OW/eSc10edpnCgF8O80xexensG0VFG3W7MnW2YDlKk9Qw=

Am 10.03.24 um 18:41 schrieb tjakobi@math.uni-bielefeld.de:

> From: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
>
> Enables reading the speed of the CPU and GPU fan on the G5.
>
> Signed-off-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
> ---
>   drivers/hwmon/dell-smm-hwmon.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwm=
on.c
> index 44aaf9b9191d..bee9cca2f768 100644
> --- a/drivers/hwmon/dell-smm-hwmon.c
> +++ b/drivers/hwmon/dell-smm-hwmon.c
> @@ -1192,6 +1192,14 @@ static const struct dmi_system_id i8k_dmi_table[]=
 __initconst =3D {
>   			DMI_MATCH(DMI_PRODUCT_NAME, "XPS"),
>   		},
>   	},
> +	{
> +		.ident =3D "Dell G5 5505",
> +		.matches =3D {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_MATCH(DMI_PRODUCT_FAMILY, "GSeries"),

Hi,

i think you can omit the match of DMI_PRODUCT_FAMILY. Also we already have=
 another G5-series machine
in the DMI list (somewhere at the top). Maybe you can put this entry close=
 to this entry?

Thanks,
Armin Wolf

> +			DMI_MATCH(DMI_PRODUCT_NAME, "G5 5505"),
> +		},
> +	},
>   	{ }
>   };
>

