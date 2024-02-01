Return-Path: <linux-kernel+bounces-48411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE09845B9B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79EC8B2D822
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5469626AD;
	Thu,  1 Feb 2024 15:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="SvAuDzH3"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6008062159;
	Thu,  1 Feb 2024 15:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706801447; cv=none; b=bwCVclce53dC6C2RmzUdZGjGCInUZ4iNAX1JprRmjoY1jx8BKj9SVNPxOcMIjv4oTEZ0oNbwAB3+ITmmTQA2u4zf5GpMiIbUomPgnsUZtgM0LBPYiGQ86yiHB1UUnzdcJxGbAoSFY0ngsPjHvs+YDB+rymOFxg1ZJBJBzuYYmaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706801447; c=relaxed/simple;
	bh=UBsgRb65IbCHVuFHwEksGNoBBhdRATWCBmHVs9FqonE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=inkJt2CRi/YE4eVkijb3UvB+WyrgBiRlPpUf0p/US0QGVbImsfWzytCroYbAnQmxGcc84r1C2b6ew6bzCqwUE3HZnG/yoWc+OSwJZvJH/EfW9l87Ob1YTEZkR9M6Uv4026rCcmihbAd8DYVLsmyadd44MdkWTIYIeIxn1t0hUHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=SvAuDzH3; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id D7F37100005;
	Thu,  1 Feb 2024 18:30:33 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru D7F37100005
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1706801433;
	bh=p1bQsKSegFtZAaGaurs4tDBuXh5/mEUC+VLJOhGs7yQ=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:From;
	b=SvAuDzH3d3UK4ys99dyebtKrSe4P8lTraNmRQGxf0HpTzFzIUGH1tFbnLJyjIurCo
	 3DHo0ZQbdAU6z64ulwNVTCpl/gBOaLD8U26/VsEPKTn9qfFAkGyK91uJo+PidxV4Qk
	 /LjmXXdJIXU77o37fbVTljXAj7ET2z0CRrYqGJ2uY2SbOvyUhrDI4+uLdV9cTFJ3HA
	 TFCKIFdyl6fA4HLzhuEKK77N6Q7CmCvS+AkU5HpXMLLreBDs7sf1s1TY+1c3exYo+N
	 vAgApQQmItUB3L81QNQe9mNU3itwgCqpuESMOvF/uOycuwSnV615u0K0zwiLaTTYOt
	 +CGxrz0xkCXhA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Thu,  1 Feb 2024 18:30:33 +0300 (MSK)
Received: from p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 1 Feb 2024 18:30:33 +0300
Received: from p-i-exch-sc-m01.sberdevices.ru ([fe80::25de:2e74:8821:eb9a]) by
 p-i-exch-sc-m01.sberdevices.ru ([fe80::25de:2e74:8821:eb9a%7]) with mapi id
 15.02.1118.040; Thu, 1 Feb 2024 18:30:33 +0300
From: Alexey Romanov <avromanov@salutedevices.com>
To: "robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "neil.armstrong@linaro.org"
	<neil.armstrong@linaro.org>, "khilman@baylibre.com" <khilman@baylibre.com>,
	"jbrunet@baylibre.com" <jbrunet@baylibre.com>,
	"martin.blumenstingl@googlemail.com" <martin.blumenstingl@googlemail.com>
CC: "linux-amlogic@lists.infradead.org" <linux-amlogic@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, kernel <kernel@sberdevices.ru>,
	Dmitry Rokosov <ddrokosov@salutedevices.com>
Subject: Re: [PATCH v1] arch: arm64: dts: meson: a1: add assigned-clocks for
 usb node
Thread-Topic: [PATCH v1] arch: arm64: dts: meson: a1: add assigned-clocks for
 usb node
Thread-Index: AQHaTsYqvR6S+noZREWdvbdJ/XH6MbD1d1KA
Date: Thu, 1 Feb 2024 15:30:33 +0000
Message-ID: <20240201153027.ecxqx3ehh6tbkgrc@cab-wsm-0029881>
References: <20240124130623.3471236-1-avromanov@salutedevices.com>
In-Reply-To: <20240124130623.3471236-1-avromanov@salutedevices.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D0EC4508C98A5C4E8C8FFBA89D684531@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 183128 [Feb 01 2024]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;smtp.sberdevices.ru:5.0.1,7.1.1;salutedevices.com:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/02/01 13:26:00 #23335101
X-KSMG-AntiVirus-Status: Clean, skipped

Hello! Ping.

On Wed, Jan 24, 2024 at 04:06:23PM +0300, Alexey Romanov wrote:
> To ensure proper functionality of USB, it is necessary to use
> the rate of 64000000 for CLKID_USB_BUS. For instance, adb may
> not function correctly without this setting. This information
> has been derived from the vendor SDK.
>=20
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-a1.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi b/arch/arm64/boot/=
dts/amlogic/meson-a1.dtsi
> index cf150f568335..b9fd69112535 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
> @@ -668,6 +668,8 @@ usb: usb@fe004400 {
>  				 <&clkc_periphs CLKID_USB_BUS>,
>  				 <&clkc_periphs CLKID_USB_CTRL_IN>;
>  			clock-names =3D "usb_ctrl", "usb_bus", "xtal_usb_ctrl";
> +			assigned-clocks =3D <&clkc_periphs CLKID_USB_BUS>;
> +			assigned-clock-rates =3D <64000000>;
>  			resets =3D <&reset RESET_USBCTRL>;
>  			reset-name =3D "usb_ctrl";
> =20
> --=20
> 2.34.1
>=20

--=20
Thank you,
Alexey=

