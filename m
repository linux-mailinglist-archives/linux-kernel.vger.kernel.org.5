Return-Path: <linux-kernel+bounces-90680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B58870345
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21BECB237C5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A923F9D5;
	Mon,  4 Mar 2024 13:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="Vq9e9s+A"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271683EA88;
	Mon,  4 Mar 2024 13:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709560199; cv=none; b=LOyn8vr5U83G02nbi1SjDT6iqIsLkawLdW0krpZA73m3Qhp9KNXAnj98YJrws2XQdzIo92h3PdObEeUuymR5f8M0xE2E3FlqoxFjnzsFEKzTV8sNWXedntLyxzEI6+hD6E/WzdAr5ez3A9n0CkJWJMRxTgoIAaCzlG2LNHw140w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709560199; c=relaxed/simple;
	bh=58D6ebcjk8KLk8CII8GL/GHVhbo+dUmqw9nPg10UTCQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gXP1MbIpebWZjXGRXl+bnW1hzNfYTzAObVCBlTjsiYuw0uDGNt2lDOgMlddY/vAGf/y8vl4Cry3mIYDASo+rxqp4fuX2xexthttxeIrrJvLePOYUC72yn2VfCNImCgp9lj5y/mtaKv/3nmtlmxs2GS1+uqEAnd+RQagzhXizFy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=Vq9e9s+A; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id D4D3810000A;
	Mon,  4 Mar 2024 16:49:46 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru D4D3810000A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1709560186;
	bh=pwwpRwyfONwWk//y+tBtyGsJGgbXPSMvyR6jl6OmDgI=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:From;
	b=Vq9e9s+AuV3T+kHpKUXL7fwvjVXrQvM8PiWG6SUPXWPPNRgwFPdbeNYk90w8mi9h+
	 Juol9IeA7kOFdpR9iSu0TGl+NL0YrwbJAnI1t5ro0kt4CfqMHLeqtE9yaw4CX0w4li
	 9bNCgZ3PjtaBqPo5L19tiK2tmrrl7VgO7gbaZI0DYEzijYtBWcGiKItGrIwzhZd4p7
	 yjkT8Q/ovtweJV8I+do01U4dcqprsYtrZ0p/Zq0TBHJoeLKUbnb99Uw4KTX4bw//2b
	 g/jyPFrlKEqypPcPOBOv4CUkMi2a+lXG7xqweEdIAT7XbY9hYyM6p3vqXwuiaNqKFf
	 tTpYVxZr+2sZw==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Mon,  4 Mar 2024 16:49:46 +0300 (MSK)
Received: from p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 4 Mar 2024 16:49:46 +0300
Received: from p-i-exch-sc-m01.sberdevices.ru ([fe80::6d41:e8f1:b95e:ba1]) by
 p-i-exch-sc-m01.sberdevices.ru ([fe80::6d41:e8f1:b95e:ba1%7]) with mapi id
 15.02.1118.040; Mon, 4 Mar 2024 16:49:46 +0300
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
Thread-Index: AQHaa9yRWJ/V2yQniEGD1LRIiVhVdrEizjUAgASdYgA=
Date: Mon, 4 Mar 2024 13:49:46 +0000
Message-ID: <20240304134923.hk5xp5rs3itgw3pk@cab-wsm-0029881.sigma.sbrf.ru>
References: <20240301132936.621238-1-avromanov@salutedevices.com>
 <20240301132936.621238-4-avromanov@salutedevices.com>
 <1jwmqmrmva.fsf@starbuckisacylon.baylibre.com>
In-Reply-To: <1jwmqmrmva.fsf@starbuckisacylon.baylibre.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4B84D65356BE894DBF25ACCD733B0601@sberdevices.ru>
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

Hello Jerome,

On Fri, Mar 01, 2024 at 04:21:20PM +0100, Jerome Brunet wrote:
>=20
> On Fri 01 Mar 2024 at 16:29, Alexey Romanov <avromanov@salutedevices.com>=
 wrote:
>=20
> > Amlogic crypto IP doesn't take a clock input on some
> > SoCs: AXG / A1 / S4 / G12. So make it optional.
> >
>=20
> I commented this patch on v2 and the comment keep on being un-addressed.
>=20
> The SoC either:
> * has a clock that is required for the IP to work
> * Or does not
>=20
> It is not something you are free to provide or not.
>=20
> For the record, I find very hard believe that some SoC would have clock,
> and other would not, for the same HW.
>=20
> Isn't it more likely that the clock just happens to be left enabled by
> the bootloader on some SoC and it conviently allows to ignore it ?


S905X and newer SoC's uses DMA engine for crypto HW and they
don't required clock input to work. Clock input is needed for
blkmv engine.

Therefore, I'm not sure that it is needed for GXL too (and the second
interrupt line). I tested it on vim1 board witouht them and everything
works correctly.

>=20
> > Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> > ---
> >  drivers/crypto/amlogic/amlogic-gxl-core.c | 14 +++-----------
> >  1 file changed, 3 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/crypto/amlogic/amlogic-gxl-core.c b/drivers/crypto=
/amlogic/amlogic-gxl-core.c
> > index e9e733ed98e0..a3a69a59f476 100644
> > --- a/drivers/crypto/amlogic/amlogic-gxl-core.c
> > +++ b/drivers/crypto/amlogic/amlogic-gxl-core.c
> > @@ -269,16 +269,11 @@ static int meson_crypto_probe(struct platform_dev=
ice *pdev)
> >  		dev_err(&pdev->dev, "Cannot request MMIO err=3D%d\n", err);
> >  		return err;
> >  	}
> > -	mc->busclk =3D devm_clk_get(&pdev->dev, "blkmv");
> > +
> > +	mc->busclk =3D devm_clk_get_optional_enabled(&pdev->dev, "blkmv");
> >  	if (IS_ERR(mc->busclk)) {
> >  		err =3D PTR_ERR(mc->busclk);
> > -		dev_err(&pdev->dev, "Cannot get core clock err=3D%d\n", err);
> > -		return err;
> > -	}
> > -
> > -	err =3D clk_prepare_enable(mc->busclk);
> > -	if (err !=3D 0) {
> > -		dev_err(&pdev->dev, "Cannot prepare_enable busclk\n");
> > +		dev_err(&pdev->dev, "Cannot get and enable core clock err=3D%d\n", e=
rr);
> >  		return err;
> >  	}
> > =20
> > @@ -306,7 +301,6 @@ static int meson_crypto_probe(struct platform_devic=
e *pdev)
> >  	meson_unregister_algs(mc);
> >  error_flow:
> >  	meson_free_chanlist(mc, mc->flow_cnt - 1);
> > -	clk_disable_unprepare(mc->busclk);
> >  	return err;
> >  }
> > =20
> > @@ -321,8 +315,6 @@ static void meson_crypto_remove(struct platform_dev=
ice *pdev)
> >  	meson_unregister_algs(mc);
> > =20
> >  	meson_free_chanlist(mc, mc->flow_cnt - 1);
> > -
> > -	clk_disable_unprepare(mc->busclk);
> >  }
> > =20
> >  static const struct meson_pdata meson_gxl_pdata =3D {
>=20
>=20
> --=20
> Jerome

--=20
Thank you,
Alexey=

