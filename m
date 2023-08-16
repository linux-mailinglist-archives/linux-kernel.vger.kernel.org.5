Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDBC277E60F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 18:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344516AbjHPQKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 12:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344531AbjHPQJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 12:09:51 -0400
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12029E56;
        Wed, 16 Aug 2023 09:09:50 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id B16B0100003;
        Wed, 16 Aug 2023 19:09:48 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru B16B0100003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1692202188;
        bh=B2HLvs94ZpyDjEhHgl0bKYdQrJ2OEIc58j+r5lejfDQ=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:From;
        b=LAnKxNz9piHUK42ZplcB8KzTmUxxA+nY6EfsKwIOs/7kdjQhCymNtDfUB28H4FzbG
         YDHbFrLY2y/i9S8zBmi9VWX4WnyntIFAcT04Qfd3Ey1IC0yO0/DhMg6X3dTe425gcF
         ZhI2NHcWBzTXxXcZ4G1vgOmzDkQiqZM6Yqbl8crWxZOoRUS4PZbBSxHZGA0ouQyumv
         GrXMohBoE5F5JxjoQPMRf1lt5/Dm0modDbsl37AZmA3rF+zKHktzSNN2aHndvTLvRR
         BQK19d9UeQ5FgQhMPt/Bh2NnJkWUYeFelU9ExOhpu1pQWnrsE0UHl7skOBdHaIf+WZ
         E7Z6pWnpWEBlw==
Received: from p-i-exch-sc-m02.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Wed, 16 Aug 2023 19:09:48 +0300 (MSK)
Received: from p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 16 Aug 2023 19:09:47 +0300
Received: from p-i-exch-sc-m01.sberdevices.ru ([::1]) by
 p-i-exch-sc-m01.sberdevices.ru ([fe80::80e5:bab:4999:4480%7]) with mapi id
 15.02.1118.030; Wed, 16 Aug 2023 19:09:47 +0300
From:   Alexey Romanov <AVRomanov@sberdevices.ru>
To:     Conor Dooley <conor@kernel.org>
CC:     "narmstrong@baylibre.com" <narmstrong@baylibre.com>,
        "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
        "olivia@selenic.com" <olivia@selenic.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
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
Subject: Re: [PATCH v2 2/3] dt-bindings: rng: meson: add meson-rng-s4
 compatible
Thread-Topic: [PATCH v2 2/3] dt-bindings: rng: meson: add meson-rng-s4
 compatible
Thread-Index: AQHZyS/vZjB/sdAqbUylJEW+ne6EZq/gHcWAgAAAdgCADNU+AA==
Date:   Wed, 16 Aug 2023 16:09:47 +0000
Message-ID: <20230816160944.wwewoej4oj35irwa@cab-wsm-0029881.sigma.sbrf.ru>
References: <20230807130611.63914-1-avromanov@sberdevices.ru>
 <20230807130611.63914-3-avromanov@sberdevices.ru>
 <20230808-calcium-smasher-5f6c410fb226@spud>
 <20230808-diabetes-ultimate-f3f4afc53d6d@spud>
In-Reply-To: <20230808-diabetes-ultimate-f3f4afc53d6d@spud>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.18.93]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <190233EA3A283247AF55BB59E5C1E2B4@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 179289 [Aug 16 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: AVRomanov@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 526 526 7a6a9b19f6b9b3921b5701490f189af0e0cd5310, {Track_E25351}, {Tracking_internal2}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;cab-wsm-0029881.sigma.sbrf.ru:5.0.1,7.1.1;sberdevices.ru:5.0.1,7.1.1;p-i-exch-sc-m02.sberdevices.ru:5.0.1,7.1.1;127.0.0.199:7.1.2, FromAlignment: s, {Tracking_white_helo}
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/08/16 12:02:00 #21629266
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

Hi, Conor!

Thank you for the review.

On Tue, Aug 08, 2023 at 01:11:24PM +0100, Conor Dooley wrote:
> On Tue, Aug 08, 2023 at 01:09:45PM +0100, Conor Dooley wrote:
> > On Mon, Aug 07, 2023 at 04:06:10PM +0300, Alexey Romanov wrote:
> > > Now the driver has a separate algo for S4 SoC.
> > >=20
> > > Signed-off-by: Alexey Romanov <avromanov@sberdevices.ru>
> >=20
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
>=20
> Actually, one comment, please, for bindings, write commit messages that
> relate to the hardware rather than drivers. The bindings describe the
> hardware, after all.

Yeah, will fix this in V3.

--=20
Thank you,
Alexey=
