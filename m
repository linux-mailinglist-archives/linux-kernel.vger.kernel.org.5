Return-Path: <linux-kernel+bounces-86724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 553DA86C9AF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 14:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70E961C21235
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 13:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451507E108;
	Thu, 29 Feb 2024 13:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="Z0ZSWkfl"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7377D1EB46;
	Thu, 29 Feb 2024 13:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709211929; cv=none; b=mUPuqffHXyiIR4sgVAaH0x8TerJSRrcAcPAqSpf3sljHJvk40md3+doV81o4EPrE18tkrmElZTDIz5oGa3mLBOjgI41ecIS5f4ug5f/hLbTylKJ6p9NAAT1J/DZg4dVgUExal8NM//e6horgABvKh3UR9eYyv3zeGjTg5bv9D3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709211929; c=relaxed/simple;
	bh=XoeSuzG8jqCz1UT3PLYTSpgiX+WG8nr3dkKjB0srM1w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KER6XS+I6JWIyC8BmSnb1MfaQtbvNk2pf7B0cv5dmyGgBuQeAB1dl38wdsxk3yKAADQOd5xfspXv2joWY3V6YMeXF92foVdWdXnsl4SwvcTsBBLPEwbxGbaxjg7Gd5xTDIt8KA9uFCl0WMMZ9S91mBAbEiEMYFr+KkWNNDxny08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=Z0ZSWkfl; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 43A361200E1;
	Thu, 29 Feb 2024 16:05:15 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 43A361200E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1709211915;
	bh=umX0LQkKpv8OA4NwzbRwcDsOZahJ/+JAK3alNhNh6mY=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:From;
	b=Z0ZSWkflb/3WTeTWGLCVaFAvggT1+HLi6gWtWUbklDrHudg9ZgRq6Bj9yneR5TOIx
	 YQvXnqsNchedAAQnKPIwYYs2lhTqrqNWDlgGZ9ZWSdO8B/Tc0J0bj2/YN1/H8uk6H/
	 4wbjRYAq2nHaQOuCj05/yhgq+BsiXoTxg5cz4CbDrPw7sLLvt/RK3eb3PF29E1Tcqa
	 ilTjzHjWDJXQTehH22Rwh0afOnufZOvNOfos6RXOfmG+8N6t0Aq6oyUV+X+slLLqUz
	 y3v3nDhYbT68rLt4sG91YEeJNuymzq630EmLd92UV0vpaZgLWpvpDYmumivivRg8vU
	 HpW02/xEMY6SA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Thu, 29 Feb 2024 16:05:14 +0300 (MSK)
Received: from p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 29 Feb 2024 16:05:14 +0300
Received: from p-i-exch-sc-m01.sberdevices.ru ([fe80::6d41:e8f1:b95e:ba1]) by
 p-i-exch-sc-m01.sberdevices.ru ([fe80::6d41:e8f1:b95e:ba1%7]) with mapi id
 15.02.1118.040; Thu, 29 Feb 2024 16:05:14 +0300
From: Alexey Romanov <avromanov@salutedevices.com>
To: Corentin Labbe <clabbe.montjoie@gmail.com>
CC: "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
	"clabbe@baylibre.com" <clabbe@baylibre.com>, "herbert@gondor.apana.org.au"
	<herbert@gondor.apana.org.au>, "davem@davemloft.net" <davem@davemloft.net>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "khilman@baylibre.com"
	<khilman@baylibre.com>, "jbrunet@baylibre.com" <jbrunet@baylibre.com>,
	"martin.blumenstingl@googlemail.com" <martin.blumenstingl@googlemail.com>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
	"linux-amlogic@lists.infradead.org" <linux-amlogic@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, kernel <kernel@sberdevices.ru>
Subject: Re: [PATCH v4 00/20] Support more Amlogic SoC families in crypto
 driver
Thread-Topic: [PATCH v4 00/20] Support more Amlogic SoC families in crypto
 driver
Thread-Index: AQHaXbqRFptCyAwKyUyy1Cn5x5FmZLEHrLEAgANeQYCABgkagIAOlJgAgABwfQCAAG4bgA==
Date: Thu, 29 Feb 2024 13:05:14 +0000
Message-ID: <20240229025337.ftbvoaafmu5zvyha@cab-wsm-0029881>
References: <20240212135108.549755-1-avromanov@salutedevices.com>
 <ZcsYaPIUrBSg8iXu@Red>
 <20240215104719.njq6ie2niisntcnv@cab-wsm-0029881.sigma.sbrf.ru>
 <ZdL713ae1swwTU_B@Red> <20240228133656.24bic6djmjvkill7@cab-wsm-0029881>
 <Zd-VVGXHoH2ikbmV@Red>
In-Reply-To: <Zd-VVGXHoH2ikbmV@Red>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5ABEBF99DA6D414FA14316970D4C439A@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 183854 [Feb 29 2024]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a, {Tracking_uf_ne_domains}, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;gist.github.com:7.1.1;smtp.sberdevices.ru:7.1.1,5.0.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/02/29 11:23:00
X-KSMG-LinksScanning: Clean, bases: 2024/02/29 11:23:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/02/29 08:31:00 #23888373
X-KSMG-AntiVirus-Status: Clean, skipped

Hello!

On Wed, Feb 28, 2024 at 09:19:32PM +0100, Corentin Labbe wrote:
> Le Wed, Feb 28, 2024 at 01:37:02PM +0000, Alexey Romanov a 'ecrit :
> > Hello,
> >=20
> > On Mon, Feb 19, 2024 at 07:57:27AM +0100, Corentin Labbe wrote:
> > > Le Thu, Feb 15, 2024 at 10:47:24AM +0000, Alexey Romanov a 'ecrit :
> > > > On Tue, Feb 13, 2024 at 08:21:12AM +0100, Corentin Labbe wrote:
> > > > > Le Mon, Feb 12, 2024 at 04:50:48PM +0300, Alexey Romanov a 'ecrit=
 :
> > > > > > Hello!
> > > > > >=20
> > > > > > This patchset expand the funcionality of the Amlogic
> > > > > > crypto driver by adding support for more SoC families:
> > > > > > AXG, G12A, G12B, SM1, A1, S4.
> > > > > >=20
> > > > > > Also specify and enable crypto node in device tree
> > > > > > for reference Amlogic devices.
> > > > > >=20
> > > > > > Tested on AXG, G12A/B, SM1, A1 and S4 devices via
> > > > > > custom tests [1] and tcrypt module.
> > > > > >=20
> > > > > > ---
> > > > > >=20
> > > > >=20
> > > > > added patchs up to  "drivers: crypto: meson: process more than MA=
XDESCS descriptors"
> > > >=20
> > > > Including this patch or not?
> > >=20
> > > The crash start with "drivers: crypto: meson: move algs definition an=
d cipher API to cipher.c"
> >=20
> > Unfortunately I was unable to reproduce this. I use Khadas Vim1 board
> > and my custom tests (https://gist.github.com/mRrvz/3fb8943a7487ab7b943e=
c140706995e7).
> > Tried both build as module and built-in.
> >=20
> > Can you, please, give more information? Maybe your test cases?
>=20
> My test case is simple, simply load the driver.
>=20
> The problem is that you moved the algs[i].mc =3D mc after the register of=
 algs (in drivers: crypto: meson: move algs definition and cipher API to ci=
pher.c)
> Test could happen as soon the register is done and so mc is deferenced.

Yeah, you are right. Will fix it. Thank you.

>=20
> Since you didnt hit the case, I suspect you didnt test the driver as modu=
le.

No, I test the driver as module.
I think the problem is that on my system no one uses this crypto backend
outside of my tests module, unlike your system.

>=20
> Regards

--=20
Thank you,
Alexey=

