Return-Path: <linux-kernel+bounces-92466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3818720BB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 837101C211B1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027FC8613A;
	Tue,  5 Mar 2024 13:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="mew/wGtc"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8108593E;
	Tue,  5 Mar 2024 13:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709646471; cv=none; b=aKCW+eudsMqLWrU/lcGRBmaGOOSKzYRScb+UorgPV+i0TzviljT1BY66RTSRFDl+a7p3cKyqrsFTBeege8t1wMaaZBiTQA1D3mZK7UeqQWID75xpZ2nuSRnbu5KVmaTGCqmmggfWacIxCiI7l7M5/S9bMuu7Yw7q0mighZFlfe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709646471; c=relaxed/simple;
	bh=PSQDKOjTYlxyNhw+5gg0aHr6AbyCsuy0sLTOZ2AjNf0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WgavJDu0foTNTKV6izsrRx8Pa4gXOE3uEUcLS1Mt61YqR/b+bK+gAe5Cfsj9pvMXbTBwVob9/XnOifC5rptkvj5usMmaQhh5s1N5vUwGBeSSDWdU1tLmqQV3ytm4dAL7ohdcnsjAq9DlocsNH4YmNil/98mfM9rZLvOlHy4iC3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=mew/wGtc; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 4492B10000D;
	Tue,  5 Mar 2024 16:47:38 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 4492B10000D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1709646458;
	bh=fcKXA9lISEMg682+/DBPrSA2kktQOMdU0ud7akHaBpk=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:From;
	b=mew/wGtcPW1yjR9vUouwfuKRMUg+JtvkzC4/2j5wsnQXzRLPwZmgrl0cUEQ3k/xE/
	 CozZw8m7QSBItRa1G3ZgTkzGy0Ymcq81Ea023w2lx9UqH4dxLk23oTRC/BNp/wrPmO
	 BaHRuPzJJ7Iuyn6pZ2pZmLBSwLZRh2wvUgf3Wgi0M03ffVAP2+o78/QzEpQ2gyoNo+
	 JQl3fvzl0FSBJg+xKM7fOT6RpYd5JCf+G9dvXAgqX8G2Zg3yr8TCUYyAiD+IzHATW2
	 3dpkEnPIJ0Lp6Q9NxSAlTGuAIuxC8iVvsQHQkSkAeE1DeXzH7mDD1pGYvOzcFSaBcU
	 jUIyLIdAXPBrQ==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue,  5 Mar 2024 16:47:38 +0300 (MSK)
Received: from p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 5 Mar 2024 16:47:37 +0300
Received: from p-i-exch-sc-m01.sberdevices.ru ([fe80::6d41:e8f1:b95e:ba1]) by
 p-i-exch-sc-m01.sberdevices.ru ([fe80::6d41:e8f1:b95e:ba1%7]) with mapi id
 15.02.1118.040; Tue, 5 Mar 2024 16:47:37 +0300
From: Alexey Romanov <avromanov@salutedevices.com>
To: Jerome Brunet <jbrunet@baylibre.com>
CC: "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
	"clabbe@baylibre.com" <clabbe@baylibre.com>, "herbert@gondor.apana.org.au"
	<herbert@gondor.apana.org.au>, "davem@davemloft.net" <davem@davemloft.net>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "khilman@baylibre.com"
	<khilman@baylibre.com>, "martin.blumenstingl@googlemail.com"
	<martin.blumenstingl@googlemail.com>, "vadim.fedorenko@linux.dev"
	<vadim.fedorenko@linux.dev>, "linux-crypto@vger.kernel.org"
	<linux-crypto@vger.kernel.org>, "linux-amlogic@lists.infradead.org"
	<linux-amlogic@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, kernel <kernel@sberdevices.ru>
Subject: Re: [PATCH v5 03/21] drivers: crypto: meson: make CLK controller
 optional
Thread-Topic: [PATCH v5 03/21] drivers: crypto: meson: make CLK controller
 optional
Thread-Index: AQHaa9yRWJ/V2yQniEGD1LRIiVhVdrEizjUAgASdYgCAAZG9AA==
Date: Tue, 5 Mar 2024 13:47:37 +0000
Message-ID: <20240305134732.z6eyo4nppj7oc2su@cab-wsm-0029881.sigma.sbrf.ru>
References: <20240301132936.621238-1-avromanov@salutedevices.com>
 <20240301132936.621238-4-avromanov@salutedevices.com>
 <1jwmqmrmva.fsf@starbuckisacylon.baylibre.com>
 <20240304134923.hk5xp5rs3itgw3pk@cab-wsm-0029881.sigma.sbrf.ru>
In-Reply-To: <20240304134923.hk5xp5rs3itgw3pk@cab-wsm-0029881.sigma.sbrf.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="us-ascii"
Content-ID: <591DBD4D237CE74D9FE5610D447E944D@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 183875 [Feb 29 2024]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/02/29 19:21:00 #23899999
X-KSMG-AntiVirus-Status: Clean, skipped

On Mon, Mar 04, 2024 at 01:49:46PM +0000, Alexey Romanov wrote:
> Hello Jerome,
>=20
> On Fri, Mar 01, 2024 at 04:21:20PM +0100, Jerome Brunet wrote:
> >=20
> > On Fri 01 Mar 2024 at 16:29, Alexey Romanov <avromanov@salutedevices.co=
m> wrote:
> >=20
> > > Amlogic crypto IP doesn't take a clock input on some
> > > SoCs: AXG / A1 / S4 / G12. So make it optional.
> > >
> >=20
> > I commented this patch on v2 and the comment keep on being un-addressed=
.
> >=20
> > The SoC either:
> > * has a clock that is required for the IP to work
> > * Or does not
> >=20
> > It is not something you are free to provide or not.
> >=20
> > For the record, I find very hard believe that some SoC would have clock=
,
> > and other would not, for the same HW.
> >=20
> > Isn't it more likely that the clock just happens to be left enabled by
> > the bootloader on some SoC and it conviently allows to ignore it ?
>=20
>=20
> S905X and newer SoC's uses DMA engine for crypto HW and they
> don't required clock input to work. Clock input is needed for
> blkmv engine.
>=20
> Therefore, I'm not sure that it is needed for GXL too (and the second
> interrupt line). I tested it on vim1 board witouht them and everything
> works correctly.

Amlogic says that the crypto HW based on DMA engine doesn't require
a clock input. GXL uses DMA engine, so, I think we have to remove
whole clock controller calls in the next series from driver/dts/bindings.
And the second interrupt line from crypto node in meson-gxl.dtsi too.

>=20
> >=20
> > > Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> > > ---
> > >  drivers/crypto/amlogic/amlogic-gxl-core.c | 14 +++-----------
> > >  1 file changed, 3 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/drivers/crypto/amlogic/amlogic-gxl-core.c b/drivers/cryp=
to/amlogic/amlogic-gxl-core.c
> > > index e9e733ed98e0..a3a69a59f476 100644
> > > --- a/drivers/crypto/amlogic/amlogic-gxl-core.c
> > > +++ b/drivers/crypto/amlogic/amlogic-gxl-core.c
> > > @@ -269,16 +269,11 @@ static int meson_crypto_probe(struct platform_d=
evice *pdev)
> > >  		dev_err(&pdev->dev, "Cannot request MMIO err=3D%d\n", err);
> > >  		return err;
> > >  	}
> > > -	mc->busclk =3D devm_clk_get(&pdev->dev, "blkmv");
> > > +
> > > +	mc->busclk =3D devm_clk_get_optional_enabled(&pdev->dev, "blkmv");
> > >  	if (IS_ERR(mc->busclk)) {
> > >  		err =3D PTR_ERR(mc->busclk);
> > > -		dev_err(&pdev->dev, "Cannot get core clock err=3D%d\n", err);
> > > -		return err;
> > > -	}
> > > -
> > > -	err =3D clk_prepare_enable(mc->busclk);
> > > -	if (err !=3D 0) {
> > > -		dev_err(&pdev->dev, "Cannot prepare_enable busclk\n");
> > > +		dev_err(&pdev->dev, "Cannot get and enable core clock err=3D%d\n",=
 err);
> > >  		return err;
> > >  	}
> > > =20
> > > @@ -306,7 +301,6 @@ static int meson_crypto_probe(struct platform_dev=
ice *pdev)
> > >  	meson_unregister_algs(mc);
> > >  error_flow:
> > >  	meson_free_chanlist(mc, mc->flow_cnt - 1);
> > > -	clk_disable_unprepare(mc->busclk);
> > >  	return err;
> > >  }
> > > =20
> > > @@ -321,8 +315,6 @@ static void meson_crypto_remove(struct platform_d=
evice *pdev)
> > >  	meson_unregister_algs(mc);
> > > =20
> > >  	meson_free_chanlist(mc, mc->flow_cnt - 1);
> > > -
> > > -	clk_disable_unprepare(mc->busclk);
> > >  }
> > > =20
> > >  static const struct meson_pdata meson_gxl_pdata =3D {
> >=20
> >=20
> > --=20
> > Jerome
>=20
> --=20
> Thank you,
> Alexey

--=20
Thank you,
Alexey=

