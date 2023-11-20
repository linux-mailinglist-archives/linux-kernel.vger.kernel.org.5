Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C149C7F0D7E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 09:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbjKTI1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 03:27:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjKTI1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 03:27:19 -0500
Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch [IPv6:2001:1600:4:17::bc0c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 264FDB9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 00:27:13 -0800 (PST)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4SYgbg06tLzMq6V7;
        Mon, 20 Nov 2023 08:27:11 +0000 (UTC)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4SYgbf3Vgkz3W;
        Mon, 20 Nov 2023 09:27:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bigler.io;
        s=20200409; t=1700468830;
        bh=hJY+0a7f7nMEG4eRpYQt92v8giqTHlccQnioHdPElB4=;
        h=Date:Subject:From:Reply-To:To:Cc:References:In-Reply-To:From;
        b=B/H3/p95yVi2IM+RHZ12uqxgevL1ibw0KOUL1IWgyYw6wM2e2wi0czH6+u2nkjlKk
         8MnpqD3bdPAKA8V8ZhCPHRXEzLFktDSYjva5Y9B0p4cvx4IA1Xj1c0ARurFdm9Oznh
         CX9UYOtcHIIQU4WN8m6MeYiTSn0Meyhdn5qqjRmc=
Message-ID: <86566391db9c5044f1a082bc8ec697a2@mail.infomaniak.com>
Date:   Mon, 20 Nov 2023 09:27:10 +0100
Subject: Re: spi: imx: Increase imx51 ecspi burst length fails on imx6dl and
 imx8mm
From:   linux@bigler.io
Reply-To: linux@bigler.io
To:     Stefan Moring <stefan.moring@technolution.nl>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-WS-User-Origin: eyJpdiI6IkV3Mk5VdVY2d1h3dEFCTW1jQm16YXc9PSIsInZhbHVlIjoiTmlQSGxaQzR5OVg3ZDJycHZ5VUxodz09IiwibWFjIjoiMzMyNTdhZDkyYWVmYWVjZGQ2NmU4NDcwNGM5MmMyMDY4MjU2OTdiYjIwYWQwZjg0NjA0NDJmN2RlMWY1MmQ0MCIsInRhZyI6IiJ9
X-WS-User-Mbox: eyJpdiI6ImM5VDdoRWc5ZTBUMTNhcmplVDlOcGc9PSIsInZhbHVlIjoiaFlaUTNDVDZDT1RSN1dwTWF0MERudz09IiwibWFjIjoiNzJmNjRjYzI1NTdjMjI1NzA3ZTEzNTBhOGEwNzZmY2I2YjM5MmM3MzhmY2FmNWJkMDM0MTRkODA2NzVkMDJhNSIsInRhZyI6IiJ9
X-WS-Location: eJxzKUpMKykGAAfpAmU-
X-Mailer: Infomaniak Workspace (1.3.596)
References: <8a415902c751cdbb4b20ce76569216ed@mail.infomaniak.com>
 <e4f12422-1c47-4877-88b3-dfa9917331a2@leemhuis.info>
 <f4439fd1-7c2d-4a96-9116-1dbe04fceac0@leemhuis.info>
 <CAB3BuKA+qOY+UhWR-9Ov3qsz3wQr8q8n38MrEMf3FMCthr04yA@mail.gmail.com>
 <2fcdd99eee9ee4f5d34fa1abab2f51bb@mail.infomaniak.com>
 <CAB3BuKARgJhaVNFsP1FQ+2yLe18QU9H17fHKjc-Sf3izE+MZ1Q@mail.gmail.com>
In-Reply-To: <CAB3BuKARgJhaVNFsP1FQ+2yLe18QU9H17fHKjc-Sf3izE+MZ1Q@mail.gmail.com>
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan

Thanks for analyzing the problem and sorry for the delay, I had to simplify=
 the code to a minimum so that I can send to you.
Now I was able to use spidev.
I have an environment with yocto kirstone 4.0.10.
Load the spi-dma (imx-sdma 302c0000.dma-controller: loaded firmware 4.5), r=
un the spi_imx and the spidev as kenelmodule.

I run the code on a Toradex Verdin Development Board and use the imx8mm-ver=
din-nonwifi-dev.dts

To add the spidev I patched imx8mm-verdin.dtsi
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi b/arch/arm64/=
boot/dts/freescale/imx8mm-verdin.dtsi
index 6f0811587142..262500940adc 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
@@ -209,6 +209,15 @@ &ecspi2 {
        cs-gpios =3D <&gpio5 13 GPIO_ACTIVE_LOW>;
        pinctrl-names =3D "default";
        pinctrl-0 =3D <&pinctrl_ecspi2>;
+
+       spidev@0{
+               compatible =3D "micron,spi-authenta";
+               reg =3D <0>;
+               #address-cells =3D <1>;
+               #size-cells =3D <0>;
+               spi-max-frequency =3D <20000000>;
+               status =3D "okay";
+       };
 };

as a spidev test program I used=20
https://raw.githubusercontent.com/raspberrypi/linux/rpi-3.10.y/Documentatio=
n/spi/spidev_test.c

I changed the transmitted data
diff --git a/recipes-spi/spidev/files/spidev_test.c b/recipes-spi/spidev/fi=
les/spidev_test.c
index 16feda9..6056ffd 100644
--- a/recipes-spi/spidev/files/spidev_test.c
+++ b/recipes-spi/spidev/files/spidev_test.c
@@ -39,13 +39,22 @@ static void transfer(int fd)
 {
        int ret;
        uint8_t tx[] =3D {
-               0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
-               0x40, 0x00, 0x00, 0x00, 0x00, 0x95,
-               0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
-               0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
-               0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
-               0xDE, 0xAD, 0xBE, 0xEF, 0xBA, 0xAD,
-               0xF0, 0x0D,
+               0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
+        0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f, 0x10, // 16
+        0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x18,
+        0x19, 0x1a, 0x1b, 0x1c, 0x1d, 0x1e, 0x1f, 0x20, // 32
+        0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27, 0x28,
+        0x29, 0x2a, 0x2b, 0x2c, 0x2d, 0x2e, 0x2f, 0x20, // 48
+        0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38,
+        0x39, 0x3a, 0x3b, 0x3c, 0x3d, 0x3e, 0x3f, 0x40, // 64
+        0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
+        0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f, 0x10, // 80
+        0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x18,
+        0x19, 0x1a, 0x1b, 0x1c, 0x1d, 0x1e, 0x1f, 0x20, // 96
+        0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27, 0x28,
+        0x29, 0x2a, 0x2b, 0x2c, 0x2d, 0x2e, 0x2f, 0x20, // 112
+        0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38,
+        0x39, 0x3a, 0x3b, 0x3c, 0x3d, 0x3e, 0x3f,       // 127
        };
        uint8_t rx[ARRAY_SIZE(tx)] =3D {0, };

sending the content showed again the bad data
spidev_test --device /dev/spidev1.0 --speed 20000000 --bpw 8

0x00,0x00,0x01,  =20
0x00,0x00,0x00,0x02,
0x00,0x00,0x00,0x03,
0x00,0x00,0x00,0x04,

I you need more information let me know.

Best Regards
Stefan Bigler

Am 2023-11-19T08:52:54.000+01:00 hat Stefan Moring <stefan.moring@technolut=
ion.nl> geschrieben:
>  Hi Stefan,
>=20
> Can you maybe share me your test code? I can try to reproduce it tomorrow=
.
>=20
> Kind regards,
>=20
> Stefan Moring
