Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC34F7AC2BF
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 16:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbjIWOf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 10:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbjIWOfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 10:35:24 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F80136;
        Sat, 23 Sep 2023 07:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
 t=1695479685; x=1696084485; i=j.neuschaefer@gmx.net;
 bh=AWu2JIQ2eEUreKlgs/1K7W1DpBjaukkQaZGcD3bxik0=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=RPrgq7JvbozdTCvOzIiNzHoXBMhiNAXJxR8xh1sfwVo4W55kutrWL7VHEG265jR3zeZP1TG08gH
 quMw5/EfnhWJQ0zT0qLuEsMa1AMzJnnk6Z03IHUcj48625vOXUzE0mMgmv3zZS7xgS2R55nOsOltK
 9ekwpWrZoCHQd5tQJwKCOacctQh1ulFBRTCEZ6SGKUNwX7yZHcGXj76TyiRIT+G9BF2kfMVRYvPKT
 L5j9c78l7+HOsmc1FmET8TR9j3wdE2qkGmpGJKE6/zqES1pe43peAAqRmHSxbGY5fDq8p5g9dXqTW
 CdoMsNnzGQxYjUGkKaf6xyp75z8pMdn3RF7w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([89.0.47.152]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N1Obb-1rgwdr3FJj-012sd2; Sat, 23
 Sep 2023 16:34:44 +0200
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-clk@vger.kernel.org, openbmc@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH v9 2/3] ARM: dts: wpcm450: Remove clock-output-names from reference clock node
Date:   Sat, 23 Sep 2023 16:34:37 +0200
Message-Id: <20230923143438.1895461-3-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230923143438.1895461-1-j.neuschaefer@gmx.net>
References: <20230923143438.1895461-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fZTP3iEedJx5jU6DD2233C/N9kQ3S1oI5FemAJqETR2hK93qaPY
 c+9OBtrH1jgBy7W+xap7l2CQ3fkM3nJurats90HJ22XHW1SJTb0R94nraV6wzSGrfNz4MOc
 Oj8+aKP6cneQfBBxiOLZo97NOwuXXqembW/9fiWU5eS6+gkK/fUi4fC2x8pbLShkf/b6O+4
 QrwifuTszaMUwQP3tpDwA==
UI-OutboundReport: notjunk:1;M01:P0:gxIcBNTOonc=;MYBE4x++C3AM5pYcNl+vVbUgDS7
 ++fUU3YZrng3P2s33M2M/JmBW4KCS7NgR2y7XjYffv+5HFebRfa5Z/2lUiz8ZEjg7CTsW2rlm
 Hv9HVnDbzdFv25Nju0hnCywKVztposB4m/4vMsKJKpzla9RAH64vZAJvfGr2U5b1amuC6cGP/
 FIEY+TQDu1tXfjyidMdHFcSA9LcYqB8ubR6TGJSyMzD2PDexMG8y6e9RyyQqP28tRVzoldtrr
 reoENad3bqouU86MXFpCMx3k8OdWvwvXCr6sYoscpyyIShGMhBa87naW+ogYCbuDMiE+BEZPt
 PGpyEqTueuQ8QotqkxbIrsJA1mGrBnPoD5OGKYHCeZ2HafgPQVejTQjo57gTIsrmZx6a7ImS4
 +VjsrOSyo70qiccEDrMp+fpUKNxk7ADQO+zSZjORwJ1iINm96UBvPDk+PWjw6GihkaqSgW1Wx
 e7Ep/fUQu0h32/SdUfEPLusO8v67VIH4VoPkl96QIcSnHIk3eCxQzAU3d1qOJwa/woBAqW1iD
 opgAX2TigJD+p5FQpFXfV/9x/t3yOAN2fscM8idCj4+3wTTCz3rj4VgQj/yWrQf6quqfeWTxD
 ZKLiDsZK3yA8ujOGVwr2gsOShQ48q40p3hsydme3OO0XmK06S6AtcJLmOLq23mG9x8Pbh+X5a
 Q2uzPSf3NUCxKd04IqgmGXXcR2puBsHJ9Ui//pAuKJULxfWimDnYSL/0+aKFO9v4XNn8QEkm8
 v9OynfFsjdO+YRsM20dY5q1g/wUCj4t7AmZnkMH03oXAbvce1SQyKp20aDEj2uzuzPvk0MaTm
 GfkH6TqltSqvK5K/Cw5YkAEHF3mJtMGFEGbzNkleHd8N8kjEpQXeKwY7PWUmAN4g7dXohgWim
 21FmuS19smXTpYDlBV5L7NbN3TSIxIEU0ySHwp6nYVjmkv6I+nP6K9X39jT+pnpY5Bd/6AaLe
 9P6oCCuAXD2HxhLDmdWq1nAEP14=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is not necessary anymore, because the clk-wpcm450 driver doesn't
rely on global clock names anymore.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--

v9:
- New patch
=2D--
 arch/arm/boot/dts/nuvoton/nuvoton-wpcm450.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/nuvoton/nuvoton-wpcm450.dtsi b/arch/arm/boo=
t/dts/nuvoton/nuvoton-wpcm450.dtsi
index fd671c7a1e5d6..b7d9b9ebdb1e2 100644
=2D-- a/arch/arm/boot/dts/nuvoton/nuvoton-wpcm450.dtsi
+++ b/arch/arm/boot/dts/nuvoton/nuvoton-wpcm450.dtsi
@@ -40,7 +40,6 @@ clk24m: clock-24mhz {
 	refclk: clock-48mhz {
 		/* 48 MHz reference oscillator */
 		compatible =3D "fixed-clock";
-		clock-output-names =3D "ref";
 		clock-frequency =3D <48000000>;
 		#clock-cells =3D <0>;
 	};
=2D-
2.40.1

