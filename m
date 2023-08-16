Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4142E77E60B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 18:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344021AbjHPQIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 12:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344628AbjHPQIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 12:08:11 -0400
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B1C114;
        Wed, 16 Aug 2023 09:08:08 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 16518100003;
        Wed, 16 Aug 2023 19:08:07 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 16518100003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1692202087;
        bh=wGqvJOn5fP6VPclwBqfTYsb4NWORtmmUmxW9yBj0C14=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:From;
        b=pu+ViZnBT4SSAr62uJNCBMvDiuJCilFDki3AXaaLXyz4XH2VnUEiTE9Huf8B701oc
         bxprMscRUVXlinABZqkwEkHGqofS+XCEHJp8oy6z8Z94iXDblbqV1pr7VRm24s0DQK
         KwvnNuE+iWW2TIFXdBdCUGVcLz9JEvmBpmfTqEtLNBnkqdys9TvxZEg3zU+j7bU5IE
         30rB589keO2aD3Nb3crBHjBYsVwxrxSSm5d9NrcLgzbb2o4qxgm10Ys7X+b2CXe6xG
         Y+LIx72CggsxaVqPKn62YzN/FDyraKHJ1wrU1QwQhFq2zgcSio+B7CaDq3ZQpTWZaw
         Z97Awe+AvAX1Q==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Wed, 16 Aug 2023 19:08:06 +0300 (MSK)
Received: from p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 16 Aug 2023 19:08:05 +0300
Received: from p-i-exch-sc-m01.sberdevices.ru ([::1]) by
 p-i-exch-sc-m01.sberdevices.ru ([fe80::80e5:bab:4999:4480%7]) with mapi id
 15.02.1118.030; Wed, 16 Aug 2023 19:08:05 +0300
From:   Alexey Romanov <AVRomanov@sberdevices.ru>
To:     "narmstrong@baylibre.com" <narmstrong@baylibre.com>,
        "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
        "olivia@selenic.com" <olivia@selenic.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
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
        "lists@kaiser.cx" <lists@kaiser.cx>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>
Subject: Re: [PATCH v2 0/3]  Meson S4 HW RNG Support
Thread-Topic: [PATCH v2 0/3]  Meson S4 HW RNG Support
Thread-Index: AQHZyS/okR/Cmydlp02gvetqwMngtK/s8v8A
Date:   Wed, 16 Aug 2023 16:08:05 +0000
Message-ID: <20230816160802.pi75gl2smx2llcf4@cab-wsm-0029881.sigma.sbrf.ru>
References: <20230807130611.63914-1-avromanov@sberdevices.ru>
In-Reply-To: <20230807130611.63914-1-avromanov@sberdevices.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.18.93]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7146A6B2EA2EED4BA4EE46F3C863E684@sberdevices.ru>
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
X-KSMG-AntiSpam-Info: LuaCore: 526 526 7a6a9b19f6b9b3921b5701490f189af0e0cd5310, {Track_E25351}, {Tracking_internal2}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;cab-wsm-0029881.sigma.sbrf.ru:5.0.1,7.1.1;sberdevices.ru:5.0.1,7.1.1;127.0.0.199:7.1.2;p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1, FromAlignment: s, {Tracking_white_helo}
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

Hi!

Really sorry for the noise, but
I would like to receive some feedback on my patchset.

On Mon, Aug 07, 2023 at 04:06:08PM +0300, Alexey Romanov wrote:
> Hello!
>=20
> This patch series adds hwrng support for Amlogic S4-series.
> Now, S4 uses a new random number generation algorithm.
> This changes implemnents new algo and also adds description
> to meson-s4.dtsi.
>=20
> V2:
>=20
> - Use readl_relaxed_poll_timeout_atomic() function instead of loop.
> - Use two different functions: meson_rng_read() and meson_s4_rng_read().
> - Fix naming in DT schema (meson-s4-hwrng instead of meson-hwrng-s4).
> - A little code style fixes.
>=20
> Alexey Romanov (3):
>   drivers: rng: meson: add support for S4
>   dt-bindings: rng: meson: add meson-rng-s4 compatible
>   arch/arm64: dts: meson-s4: add hwrng node
>=20
>  .../bindings/rng/amlogic,meson-rng.yaml       |  1 +
>  arch/arm64/boot/dts/amlogic/meson-s4.dtsi     |  5 ++
>  drivers/char/hw_random/meson-rng.c            | 80 ++++++++++++++++++-
>  3 files changed, 83 insertions(+), 3 deletions(-)
>=20
> --=20
> 2.38.1
>=20

--=20
Thank you,
Alexey=
