Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C28D07AAC85
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 10:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbjIVIZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 04:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbjIVIZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 04:25:07 -0400
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039D81B8;
        Fri, 22 Sep 2023 01:15:29 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 8B185120008;
        Fri, 22 Sep 2023 11:15:27 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 8B185120008
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
        s=mail; t=1695370527;
        bh=K1IdM7b2w3Jp7BqUE1a2gm3KjIWU/wcpomoHzmDaVCg=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:From;
        b=NqChQCJB5VrtPsxCf4DXrKDDVhQ3xfSBgHj5B1TC+Pna+YdUQIsgNI+u3IWFFa6Zf
         qf3qHxEIFOX7hdQr3VLZeYJAnuk7YFeJ0oGmiVPQVrIwo4wG2lwPHu7hPAIJZXopL3
         Z5RPnOKylezELRtaTl7BPE1JBRKYxBwlHejCQ5dds/Il2RXjqJU3QPfPihdOHp0z67
         Mj4HEgAxudLMBxB+s/BLBEEqMGpMpR4Cx1p5DRDYDIiDS7hj24PN4i+MGzjf/Pn1yo
         le8AbSDCZVzKLw0rYXiX6i1x51YbNdj4AnMSqppCQXn7C89JnpIOuYzvBW+FvnZtH3
         aTdSJuX/p6ozA==
Received: from p-i-exch-sc-m02.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Fri, 22 Sep 2023 11:15:27 +0300 (MSK)
Received: from p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 22 Sep 2023 11:15:27 +0300
Received: from p-i-exch-sc-m01.sberdevices.ru ([::1]) by
 p-i-exch-sc-m01.sberdevices.ru ([fe80::80e5:bab:4999:4480%7]) with mapi id
 15.02.1118.030; Fri, 22 Sep 2023 11:15:27 +0300
From:   Alexey Romanov <avromanov@salutedevices.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
CC:     Alexey Romanov <avromanov@salutedevices.com>,
        "narmstrong@baylibre.com" <narmstrong@baylibre.com>,
        "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
        "olivia@selenic.com" <olivia@selenic.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "conor@kernel.org" <conor@kernel.org>,
        "khilman@baylibre.com" <khilman@baylibre.com>,
        "jbrunet@baylibre.com" <jbrunet@baylibre.com>,
        "martin.blumenstingl@googlemail.com" 
        <martin.blumenstingl@googlemail.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "lists@kaiser.cx" <lists@kaiser.cx>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>
Subject: Re: [PATCH v3 1/3] drivers: rng: meson: add support for S4
Thread-Topic: [PATCH v3 1/3] drivers: rng: meson: add support for S4
Thread-Index: AQHZ5JhbK/N+gymR9EW47MRKmDtTx7AjAeSAgANcfQA=
Date:   Fri, 22 Sep 2023 08:15:27 +0000
Message-ID: <20230922081514.p7patdvkp4mujk6k@cab-wsm-0029881.sigma.sbrf.ru>
References: <20230911101129.10604-1-avromanov@salutedevices.com>
 <20230911101129.10604-2-avromanov@salutedevices.com>
 <ZQp7Rf3qzoN6c2Le@gondor.apana.org.au>
In-Reply-To: <ZQp7Rf3qzoN6c2Le@gondor.apana.org.au>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.18.92]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <649DC8FD1411CD4C87B0DBDF3645D2E3@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 180037 [Sep 22 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 534 534 808c2ea49f7195c68d40844e073217da4fa0d1e3, {Tracking_uf_ne_domains}, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;gondor.apana.org.au:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;p-i-exch-sc-m02.sberdevices.ru:5.0.1,7.1.1;cab-wsm-0029881.sigma.sbrf.ru:5.0.1,7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2023/09/22 07:23:00
X-KSMG-LinksScanning: Clean, bases: 2023/09/22 07:23:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/09/22 02:22:00 #21944311
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Herbert,

On Wed, Sep 20, 2023 at 12:55:33PM +0800, Herbert Xu wrote:
> On Mon, Sep 11, 2023 at 01:11:27PM +0300, Alexey Romanov wrote:
> >
> > +struct meson_rng_priv {
> > +	int (*read)(struct hwrng *rng, void *buf, size_t max, bool wait);
> > +};
> > =20
> >  struct meson_rng_data {
> >  	void __iomem *base;
> >  	struct hwrng rng;
> > +	struct device *dev;
> > +	const struct meson_rng_priv *priv;
> >  };
>=20
> Is data->priv really necessary? It doesn't seem to be used anywhere
> after the probe.
>=20

Are you suggesting remove meson_rng_priv and putting a pointer to read
function in meson_rng_data?


> Thanks,
> --=20
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--=20
Thank you,
Alexey=
