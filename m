Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FAF577AEF5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 01:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbjHMXlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 19:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjHMXkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 19:40:39 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7EB9C
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 16:40:38 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-584243f84eeso43599527b3.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 16:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691970037; x=1692574837;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yhdw9hv+q/7KjoOBUK62MpaF5MY8pFyZ6M1X/RS+eD0=;
        b=Jg8pDlrqElPlOWaacBJ5528Dzg99bfGXsdRme0ZpxGA4HEDxShtbkg2zu19EJBkAcK
         Ct4BNwhIBaOgJnnanvYxvjpZ712HnXFcG0PU67TmdTwl6agYbWlEhfT4u2rthQrJ0I9d
         /LkTq2fKYv1Gt5+dw02ayAmaIHo6Lvftk0PJptNxIiI1OOQJh9gypfYWvHwXoG+8C57O
         4exPsQEPHOYIRnof5Uz46o5o6PM9ARquUgg63LaiRwZKjkiMrDsAglV3mEJuZBOk5gzr
         z3jpt+hAH2KNzed10YuAERHqz+L63M6MEmoo2CErXcKH6HAv8FxWckEb5OoIBxLeMfDy
         S4Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691970037; x=1692574837;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yhdw9hv+q/7KjoOBUK62MpaF5MY8pFyZ6M1X/RS+eD0=;
        b=WR4VtmwX8d+zOuqq/8ISUjHqU+BxARvzCjqK51EWo0Wb7a24M0HftWtj4+jpGD+3X3
         o+FUf3b8bAzWxXKDzte28Dl9UyUm9QGA9JRZbzM43kwXlDoroZ9IcrZTX/3UQGtgDS4l
         tLtwJF4ONd3+GB6fmyVHgt5QG+T1hw+BhS78L79Uq9ETTD2ZAmwIUYkecHsbVMCN0Ky5
         ahkGNNanw/b5RCx9+vUV6ggOMv3TGLEXHvXqhj9BKSCjw9qMSwDjKhlqi+e52PBxRx3Y
         fGJ/skIkf53zkZXKAiSyYo2oT1SsrFOCddy5CCQNl2KXO2Q/C+YvRITybwuDU0PHmMqS
         Or2g==
X-Gm-Message-State: AOJu0YwDW/oAhk6ZgEnjOUfD2+OpjsyUMII9bY3G1pLpFYK4iJN3BtFc
        wQvcd+ufZ+ZPK30VVLObUK8Abe4i3ejKsCAbHkaQAXb8ivcP5Q==
X-Google-Smtp-Source: AGHT+IEOPEb7PsiF1q39GdW5UQ/CTgRRrx4vdQdXtjGUClMwGFtqjwg4KXUDfglkhD4nu2SBwKAlScYyeTkpfPQxMh0=
X-Received: by 2002:a05:690c:4587:b0:584:3f4a:b790 with SMTP id
 gu7-20020a05690c458700b005843f4ab790mr10356823ywb.33.1691970037242; Sun, 13
 Aug 2023 16:40:37 -0700 (PDT)
MIME-Version: 1.0
From:   Fawad Lateef <fawadlateef@gmail.com>
Date:   Mon, 14 Aug 2023 00:40:26 +0100
Message-ID: <CAGgoGu7Vim82Hu1JKc+m6cPkcn7+WWDFwK5P_YE6grFQS9E21Q@mail.gmail.com>
Subject: Question regarding Linux-6.3.5 and Sunxi A20 NAND/NFC support
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernelnewbies <kernelnewbies@kernelnewbies.org>
Content-Type: multipart/mixed; boundary="0000000000000a7c1a0602d6793c"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000000a7c1a0602d6793c
Content-Type: text/plain; charset="UTF-8"

Hi,

I am trying to make Linux-6.3.5 working on Olimex/Sunxi A20 SOM with NAND.

Found that the Sunxi A20 NAND is supported in mainline kernel
(drivers/mtd/nand/raw/sunxi_nand.c) and following the guidelines here
(https://linux-sunxi.org/Mainline_NAND_Howto); I added the NFC chip
pin information in sunxi-a20.dtsi and defined/enabled the nfc
controller in the sunxi-a20-olinuxino-micro.dts files.

The changes I made are below. Problem is when I define the nfc node
entry in dts file "without" pinctrl entry (pinctrl-0 = <&nand_pins_a>,
<&nand_cs0_pins_a>, <&nand_rb0_pins_a>;), the sunxi_nfc_probe function
is called (though the No NAND chip is detected).

And if I define the pinctrl-0  in the nfc node, all I see related to
NAND/sunxi in the kernel boot log is this line:  platform
1c03000.nand-controller: deferred probe pending.

Can someone please guide me why the deferred probe is pending but
never call the sunxi_nfc_probe function?  And without pinctrl-0 entry
why probe function is being called?

Seems like I am missing something basic here and any pointers to debug
this will be appreciated.


--- linux-6.3.5.orig/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
2023-05-30 14:17:29.000000000 +0100
+++ linux-6.3.5/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
2023-08-13 23:27:22.405058025 +0100
@@ -56,7 +56,7 @@

  aliases {
  serial0 = &uart0;
- serial1 = &uart6;
+ serial1 = &uart2;
  serial2 = &uart7;
  spi0 = &spi1;
  spi1 = &spi2;
@@ -66,17 +66,6 @@
  stdout-path = "serial0:115200n8";
  };

- hdmi-connector {
- compatible = "hdmi-connector";
- type = "a";
-
- port {
- hdmi_con_in: endpoint {
- remote-endpoint = <&hdmi_out_con>;
- };
- };
- };
-
  leds {
  compatible = "gpio-leds";
  pinctrl-names = "default";
@@ -90,16 +79,55 @@
  };
 };

-&ahci {
- target-supply = <&reg_ahci_5v>;
+&nfc {
+ pinctrl-names = "default";
+ pinctrl-0 = <&nand_pins_a>, <&nand_cs0_pins_a>, <&nand_rb0_pins_a>;
  status = "okay";
+
+ nand@0 {
+ #address-cells = <2>;
+ #size-cells = <2>;
+ reg = <0>;
+ allwinner,rb = <0>;
+
+ nand-ecc-mode = "hw";
+ nand-on-flash-bbt;
+ };
+
+ boot0@0 {
+ label = "boot0";
+ reg = /bits/ 64 <0x0 0x200000>;
+ };
+
+ boot0-rescue@200000 {
+ label = "boot0-rescue";
+ reg = /bits/ 64 <0x200000 0x200000>;
+ };
+
+ uboot@400000 {
+ label = "uboot";
+ reg = /bits/ 64 <0x400000 0x200000>;
+ };
+
+ uboot-rescue@600000 {
+ label = "uboot-rescue";
+ reg = /bits/ 64 <0x600000 0x200000>;
+ };
+
+ main@800000 {
+ label = "main";
+ reg = /bits/ 64 <0x800000 0xff800000>;
+ };
+
 };

-&codec {
+&ahci {
+ target-supply = <&reg_ahci_5v>;
  status = "okay";
 };

 &cpu0 {
+ clock-frequency = <900000000>;
  cpu-supply = <&reg_dcdc2>;
 };

@@ -123,34 +151,24 @@
  status = "okay";
 };

-&hdmi {
- status = "okay";
-};
-
-&hdmi_out {
- hdmi_out_con: endpoint {
- remote-endpoint = <&hdmi_con_in>;
- };
-};
-
 &i2c0 {
- status = "okay";
+        status = "okay";

- axp209: pmic@34 {
- reg = <0x34>;
- interrupt-parent = <&nmi_intc>;
- interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
- };
+        axp209: pmic@34 {
+                reg = <0x34>;
+                interrupt-parent = <&nmi_intc>;
+                interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+        };
 };

 &i2c1 {
- status = "okay";
+        status = "okay";

- eeprom: eeprom@50 {
- compatible = "atmel,24c16";
- reg = <0x50>;
- pagesize = <16>;
- };
+        eeprom: eeprom@50 {
+                compatible = "atmel,24c16";
+                reg = <0x50>;
+                pagesize = <16>;
+        };
 };

 &i2c2 {
@@ -160,55 +178,6 @@
 &lradc {
  vref-supply = <&reg_vcc3v0>;
  status = "okay";
-
- button-191 {
- label = "Volume Up";
- linux,code = <KEY_VOLUMEUP>;
- channel = <0>;
- voltage = <191274>;
- };
-
- button-392 {
- label = "Volume Down";
- linux,code = <KEY_VOLUMEDOWN>;
- channel = <0>;
- voltage = <392644>;
- };
-
- button-601 {
- label = "Menu";
- linux,code = <KEY_MENU>;
- channel = <0>;
- voltage = <601151>;
- };
-
- button-795 {
- label = "Search";
- linux,code = <KEY_SEARCH>;
- channel = <0>;
- voltage = <795090>;
- };
-
- button-987 {
- label = "Home";
- linux,code = <KEY_HOMEPAGE>;
- channel = <0>;
- voltage = <987387>;
- };
-
- button-1184 {
- label = "Esc";
- linux,code = <KEY_ESC>;
- channel = <0>;
- voltage = <1184678>;
- };
-
- button-1398 {
- label = "Enter";
- linux,code = <KEY_ENTER>;
- channel = <0>;
- voltage = <1398804>;
- };
 };

 &gmac_mdio {
@@ -239,10 +208,6 @@
  status = "okay";
 };

-&otg_sram {
- status = "okay";
-};
-
 &pio {
  gmac_txerr: gmac-txerr-pin {
  pins = "PA17";
@@ -323,9 +288,9 @@
  status = "okay";
 };

-&uart6 {
+&uart2 {
  pinctrl-names = "default";
- pinctrl-0 = <&uart6_pi_pins>;
+ pinctrl-0 = <&uart2_pi_pins>;
  status = "okay";
 };

@@ -352,3 +317,28 @@
  usb2_vbus-supply = <&reg_usb2_vbus>;
  status = "okay";
 };
+
+&fe0 {
+ status = "disabled";
+};
+
+&fe1 {
+ status = "disabled";
+};
+
+&be0 {
+ status = "disabled";
+};
+
+&be1 {
+ status = "disabled";
+};
+
+&tcon0 {
+ status = "disabled";
+};
+
+&tcon1 {
+ status = "disabled";
+};
+


--- linux-6.3.5.orig/arch/arm/boot/dts/sun7i-a20.dtsi 2023-05-30
14:17:29.000000000 +0100
+++ linux-6.3.5/arch/arm/boot/dts/sun7i-a20.dtsi 2023-08-08
00:30:04.689288733 +0100
@@ -345,6 +345,58 @@
  #size-cells = <0>;
  };

+ nand_pins_a: nand_base0@0 {
+ allwinner,pins = "PC0", "PC1", "PC2",
+ "PC5", "PC8", "PC9", "PC10",
+ "PC11", "PC12", "PC13", "PC14",
+ "PC15", "PC16";
+ allwinner,function = "nand0";
+ allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+ allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+ };
+
+ nand_cs0_pins_a: nand_cs@0 {
+ allwinner,pins = "PC4";
+ allwinner,function = "nand0";
+ allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+ allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+ };
+
+ nand_cs1_pins_a: nand_cs@1 {
+ allwinner,pins = "PC3";
+ allwinner,function = "nand0";
+ allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+ allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+ };
+
+ nand_cs2_pins_a: nand_cs@2 {
+ allwinner,pins = "PC17";
+ allwinner,function = "nand0";
+ allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+ allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+ };
+
+ nand_cs3_pins_a: nand_cs@3 {
+ allwinner,pins = "PC18";
+ allwinner,function = "nand0";
+ allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+ allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+ };
+
+ nand_rb0_pins_a: nand_rb@0 {
+ allwinner,pins = "PC6";
+ allwinner,function = "nand0";
+ allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+ allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+ };
+
+ nand_rb1_pins_a: nand_rb@1 {
+ allwinner,pins = "PC7";
+ allwinner,function = "nand0";
+ allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+ allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+ };
+
  spi0: spi@1c05000 {
  compatible = "allwinner,sun4i-a10-spi";
  reg = <0x01c05000 0x1000>;


Thanks and regards,

-- Fawad Lateef

--0000000000000a7c1a0602d6793c
Content-Type: text/x-patch; charset="US-ASCII"; name="sun7i-a20-olinuxino-micro.dts.patch"
Content-Disposition: attachment; 
	filename="sun7i-a20-olinuxino-micro.dts.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lla2yf5x1>
X-Attachment-Id: f_lla2yf5x1

LS0tIGxpbnV4LTYuMy41Lm9yaWcvYXJjaC9hcm0vYm9vdC9kdHMvc3VuN2ktYTIwLW9saW51eGlu
by1taWNyby5kdHMJMjAyMy0wNS0zMCAxNDoxNzoyOS4wMDAwMDAwMDAgKzAxMDAKKysrIGxpbnV4
LTYuMy41L2FyY2gvYXJtL2Jvb3QvZHRzL3N1bjdpLWEyMC1vbGludXhpbm8tbWljcm8uZHRzCTIw
MjMtMDgtMTMgMjM6Mjc6MjIuNDA1MDU4MDI1ICswMTAwCkBAIC01Niw3ICs1Niw3IEBACiAKIAlh
bGlhc2VzIHsKIAkJc2VyaWFsMCA9ICZ1YXJ0MDsKLQkJc2VyaWFsMSA9ICZ1YXJ0NjsKKwkJc2Vy
aWFsMSA9ICZ1YXJ0MjsKIAkJc2VyaWFsMiA9ICZ1YXJ0NzsKIAkJc3BpMCA9ICZzcGkxOwogCQlz
cGkxID0gJnNwaTI7CkBAIC02NiwxNyArNjYsNiBAQAogCQlzdGRvdXQtcGF0aCA9ICJzZXJpYWww
OjExNTIwMG44IjsKIAl9OwogCi0JaGRtaS1jb25uZWN0b3IgewotCQljb21wYXRpYmxlID0gImhk
bWktY29ubmVjdG9yIjsKLQkJdHlwZSA9ICJhIjsKLQotCQlwb3J0IHsKLQkJCWhkbWlfY29uX2lu
OiBlbmRwb2ludCB7Ci0JCQkJcmVtb3RlLWVuZHBvaW50ID0gPCZoZG1pX291dF9jb24+OwotCQkJ
fTsKLQkJfTsKLQl9OwotCiAJbGVkcyB7CiAJCWNvbXBhdGlibGUgPSAiZ3Bpby1sZWRzIjsKIAkJ
cGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsKQEAgLTkwLDE2ICs3OSw1NSBAQAogCX07CiB9Owog
Ci0mYWhjaSB7Ci0JdGFyZ2V0LXN1cHBseSA9IDwmcmVnX2FoY2lfNXY+OworJm5mYyB7CisJcGlu
Y3RybC1uYW1lcyA9ICJkZWZhdWx0IjsKKwlwaW5jdHJsLTAgPSA8Jm5hbmRfcGluc19hPiwgPCZu
YW5kX2NzMF9waW5zX2E+LCA8Jm5hbmRfcmIwX3BpbnNfYT47CiAJc3RhdHVzID0gIm9rYXkiOwor
CisJbmFuZEAwIHsKKwkJI2FkZHJlc3MtY2VsbHMgPSA8Mj47CisJCSNzaXplLWNlbGxzID0gPDI+
OworCQlyZWcgPSA8MD47CisJCWFsbHdpbm5lcixyYiA9IDwwPjsKKworCQluYW5kLWVjYy1tb2Rl
ID0gImh3IjsKKwkJbmFuZC1vbi1mbGFzaC1iYnQ7CisJfTsKKworCWJvb3QwQDAgeworCQlsYWJl
bCA9ICJib290MCI7CisJCXJlZyA9IC9iaXRzLyA2NCA8MHgwIDB4MjAwMDAwPjsKKwl9OworCisJ
Ym9vdDAtcmVzY3VlQDIwMDAwMCB7CisJCWxhYmVsID0gImJvb3QwLXJlc2N1ZSI7CisJCXJlZyA9
IC9iaXRzLyA2NCA8MHgyMDAwMDAgMHgyMDAwMDA+OworCX07CisKKwl1Ym9vdEA0MDAwMDAgewor
CQlsYWJlbCA9ICJ1Ym9vdCI7CisJCXJlZyA9IC9iaXRzLyA2NCA8MHg0MDAwMDAgMHgyMDAwMDA+
OworCX07CisKKwl1Ym9vdC1yZXNjdWVANjAwMDAwIHsKKwkJbGFiZWwgPSAidWJvb3QtcmVzY3Vl
IjsKKwkJcmVnID0gL2JpdHMvIDY0IDwweDYwMDAwMCAweDIwMDAwMD47CisJfTsKKworCW1haW5A
ODAwMDAwIHsKKwkJbGFiZWwgPSAibWFpbiI7CisJCXJlZyA9IC9iaXRzLyA2NCA8MHg4MDAwMDAg
MHhmZjgwMDAwMD47CisJfTsKKwogfTsKIAotJmNvZGVjIHsKKyZhaGNpIHsKKwl0YXJnZXQtc3Vw
cGx5ID0gPCZyZWdfYWhjaV81dj47CiAJc3RhdHVzID0gIm9rYXkiOwogfTsKIAogJmNwdTAgewor
CWNsb2NrLWZyZXF1ZW5jeSA9IDw5MDAwMDAwMDA+OwogCWNwdS1zdXBwbHkgPSA8JnJlZ19kY2Rj
Mj47CiB9OwogCkBAIC0xMjMsMzQgKzE1MSwyNCBAQAogCXN0YXR1cyA9ICJva2F5IjsKIH07CiAK
LSZoZG1pIHsKLQlzdGF0dXMgPSAib2theSI7Ci19OwotCi0maGRtaV9vdXQgewotCWhkbWlfb3V0
X2NvbjogZW5kcG9pbnQgewotCQlyZW1vdGUtZW5kcG9pbnQgPSA8JmhkbWlfY29uX2luPjsKLQl9
OwotfTsKLQogJmkyYzAgewotCXN0YXR1cyA9ICJva2F5IjsKKyAgICAgICAgc3RhdHVzID0gIm9r
YXkiOwogCi0JYXhwMjA5OiBwbWljQDM0IHsKLQkJcmVnID0gPDB4MzQ+OwotCQlpbnRlcnJ1cHQt
cGFyZW50ID0gPCZubWlfaW50Yz47Ci0JCWludGVycnVwdHMgPSA8MCBJUlFfVFlQRV9MRVZFTF9M
T1c+OwotCX07CisgICAgICAgIGF4cDIwOTogcG1pY0AzNCB7CisgICAgICAgICAgICAgICAgcmVn
ID0gPDB4MzQ+OworICAgICAgICAgICAgICAgIGludGVycnVwdC1wYXJlbnQgPSA8Jm5taV9pbnRj
PjsKKyAgICAgICAgICAgICAgICBpbnRlcnJ1cHRzID0gPDAgSVJRX1RZUEVfTEVWRUxfTE9XPjsK
KyAgICAgICAgfTsKIH07CiAKICZpMmMxIHsKLQlzdGF0dXMgPSAib2theSI7CisgICAgICAgIHN0
YXR1cyA9ICJva2F5IjsKIAotCWVlcHJvbTogZWVwcm9tQDUwIHsKLQkJY29tcGF0aWJsZSA9ICJh
dG1lbCwyNGMxNiI7Ci0JCXJlZyA9IDwweDUwPjsKLQkJcGFnZXNpemUgPSA8MTY+OwotCX07Cisg
ICAgICAgIGVlcHJvbTogZWVwcm9tQDUwIHsKKyAgICAgICAgICAgICAgICBjb21wYXRpYmxlID0g
ImF0bWVsLDI0YzE2IjsKKyAgICAgICAgICAgICAgICByZWcgPSA8MHg1MD47CisgICAgICAgICAg
ICAgICAgcGFnZXNpemUgPSA8MTY+OworICAgICAgICB9OwogfTsKIAogJmkyYzIgewpAQCAtMTYw
LDU1ICsxNzgsNiBAQAogJmxyYWRjIHsKIAl2cmVmLXN1cHBseSA9IDwmcmVnX3ZjYzN2MD47CiAJ
c3RhdHVzID0gIm9rYXkiOwotCi0JYnV0dG9uLTE5MSB7Ci0JCWxhYmVsID0gIlZvbHVtZSBVcCI7
Ci0JCWxpbnV4LGNvZGUgPSA8S0VZX1ZPTFVNRVVQPjsKLQkJY2hhbm5lbCA9IDwwPjsKLQkJdm9s
dGFnZSA9IDwxOTEyNzQ+OwotCX07Ci0KLQlidXR0b24tMzkyIHsKLQkJbGFiZWwgPSAiVm9sdW1l
IERvd24iOwotCQlsaW51eCxjb2RlID0gPEtFWV9WT0xVTUVET1dOPjsKLQkJY2hhbm5lbCA9IDww
PjsKLQkJdm9sdGFnZSA9IDwzOTI2NDQ+OwotCX07Ci0KLQlidXR0b24tNjAxIHsKLQkJbGFiZWwg
PSAiTWVudSI7Ci0JCWxpbnV4LGNvZGUgPSA8S0VZX01FTlU+OwotCQljaGFubmVsID0gPDA+Owot
CQl2b2x0YWdlID0gPDYwMTE1MT47Ci0JfTsKLQotCWJ1dHRvbi03OTUgewotCQlsYWJlbCA9ICJT
ZWFyY2giOwotCQlsaW51eCxjb2RlID0gPEtFWV9TRUFSQ0g+OwotCQljaGFubmVsID0gPDA+Owot
CQl2b2x0YWdlID0gPDc5NTA5MD47Ci0JfTsKLQotCWJ1dHRvbi05ODcgewotCQlsYWJlbCA9ICJI
b21lIjsKLQkJbGludXgsY29kZSA9IDxLRVlfSE9NRVBBR0U+OwotCQljaGFubmVsID0gPDA+Owot
CQl2b2x0YWdlID0gPDk4NzM4Nz47Ci0JfTsKLQotCWJ1dHRvbi0xMTg0IHsKLQkJbGFiZWwgPSAi
RXNjIjsKLQkJbGludXgsY29kZSA9IDxLRVlfRVNDPjsKLQkJY2hhbm5lbCA9IDwwPjsKLQkJdm9s
dGFnZSA9IDwxMTg0Njc4PjsKLQl9OwotCi0JYnV0dG9uLTEzOTggewotCQlsYWJlbCA9ICJFbnRl
ciI7Ci0JCWxpbnV4LGNvZGUgPSA8S0VZX0VOVEVSPjsKLQkJY2hhbm5lbCA9IDwwPjsKLQkJdm9s
dGFnZSA9IDwxMzk4ODA0PjsKLQl9OwogfTsKIAogJmdtYWNfbWRpbyB7CkBAIC0yMzksMTAgKzIw
OCw2IEBACiAJc3RhdHVzID0gIm9rYXkiOwogfTsKIAotJm90Z19zcmFtIHsKLQlzdGF0dXMgPSAi
b2theSI7Ci19OwotCiAmcGlvIHsKIAlnbWFjX3R4ZXJyOiBnbWFjLXR4ZXJyLXBpbiB7CiAJCXBp
bnMgPSAiUEExNyI7CkBAIC0zMjMsOSArMjg4LDkgQEAKIAlzdGF0dXMgPSAib2theSI7CiB9Owog
Ci0mdWFydDYgeworJnVhcnQyIHsKIAlwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOwotCXBpbmN0
cmwtMCA9IDwmdWFydDZfcGlfcGlucz47CisJcGluY3RybC0wID0gPCZ1YXJ0Ml9waV9waW5zPjsK
IAlzdGF0dXMgPSAib2theSI7CiB9OwogCkBAIC0zNTIsMyArMzE3LDI4IEBACiAJdXNiMl92YnVz
LXN1cHBseSA9IDwmcmVnX3VzYjJfdmJ1cz47CiAJc3RhdHVzID0gIm9rYXkiOwogfTsKKworJmZl
MCB7CisJc3RhdHVzID0gImRpc2FibGVkIjsKK307CisKKyZmZTEgeworCXN0YXR1cyA9ICJkaXNh
YmxlZCI7Cit9OworCismYmUwIHsKKwlzdGF0dXMgPSAiZGlzYWJsZWQiOworfTsKKworJmJlMSB7
CisJc3RhdHVzID0gImRpc2FibGVkIjsKK307CisKKyZ0Y29uMCB7CisJc3RhdHVzID0gImRpc2Fi
bGVkIjsKK307CisKKyZ0Y29uMSB7CisJc3RhdHVzID0gImRpc2FibGVkIjsKK307CisK
--0000000000000a7c1a0602d6793c
Content-Type: text/x-patch; charset="US-ASCII"; name="sun7i-a20.dtsi.patch"
Content-Disposition: attachment; filename="sun7i-a20.dtsi.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lla2yf4h0>
X-Attachment-Id: f_lla2yf4h0

LS0tIGxpbnV4LTYuMy41Lm9yaWcvYXJjaC9hcm0vYm9vdC9kdHMvc3VuN2ktYTIwLmR0c2kJMjAy
My0wNS0zMCAxNDoxNzoyOS4wMDAwMDAwMDAgKzAxMDAKKysrIGxpbnV4LTYuMy41L2FyY2gvYXJt
L2Jvb3QvZHRzL3N1bjdpLWEyMC5kdHNpCTIwMjMtMDgtMDggMDA6MzA6MDQuNjg5Mjg4NzMzICsw
MTAwCkBAIC0zNDUsNiArMzQ1LDU4IEBACiAJCQkjc2l6ZS1jZWxscyA9IDwwPjsKIAkJfTsKIAor
CQluYW5kX3BpbnNfYTogbmFuZF9iYXNlMEAwIHsKKwkJCWFsbHdpbm5lcixwaW5zID0gIlBDMCIs
ICJQQzEiLCAiUEMyIiwKKwkJCQkJIlBDNSIsICJQQzgiLCAiUEM5IiwgIlBDMTAiLAorCQkJCQki
UEMxMSIsICJQQzEyIiwgIlBDMTMiLCAiUEMxNCIsCisJCQkJCSJQQzE1IiwgIlBDMTYiOworCQkJ
YWxsd2lubmVyLGZ1bmN0aW9uID0gIm5hbmQwIjsKKwkJCWFsbHdpbm5lcixkcml2ZSA9IDxTVU40
SV9QSU5DVFJMXzEwX01BPjsKKwkJCWFsbHdpbm5lcixwdWxsID0gPFNVTjRJX1BJTkNUUkxfTk9f
UFVMTD47CisJCX07CisKKwkJbmFuZF9jczBfcGluc19hOiBuYW5kX2NzQDAgeworCQkJYWxsd2lu
bmVyLHBpbnMgPSAiUEM0IjsKKwkJCWFsbHdpbm5lcixmdW5jdGlvbiA9ICJuYW5kMCI7CisJCQlh
bGx3aW5uZXIsZHJpdmUgPSA8U1VONElfUElOQ1RSTF8xMF9NQT47CisJCQlhbGx3aW5uZXIscHVs
bCA9IDxTVU40SV9QSU5DVFJMX05PX1BVTEw+OworCQl9OworCisJCW5hbmRfY3MxX3BpbnNfYTog
bmFuZF9jc0AxIHsKKwkJCWFsbHdpbm5lcixwaW5zID0gIlBDMyI7CisJCQlhbGx3aW5uZXIsZnVu
Y3Rpb24gPSAibmFuZDAiOworCQkJYWxsd2lubmVyLGRyaXZlID0gPFNVTjRJX1BJTkNUUkxfMTBf
TUE+OworCQkJYWxsd2lubmVyLHB1bGwgPSA8U1VONElfUElOQ1RSTF9OT19QVUxMPjsKKwkJfTsK
KworCQluYW5kX2NzMl9waW5zX2E6IG5hbmRfY3NAMiB7CisJCQlhbGx3aW5uZXIscGlucyA9ICJQ
QzE3IjsKKwkJCWFsbHdpbm5lcixmdW5jdGlvbiA9ICJuYW5kMCI7CisJCQlhbGx3aW5uZXIsZHJp
dmUgPSA8U1VONElfUElOQ1RSTF8xMF9NQT47CisJCQlhbGx3aW5uZXIscHVsbCA9IDxTVU40SV9Q
SU5DVFJMX05PX1BVTEw+OworCQl9OworCisJCW5hbmRfY3MzX3BpbnNfYTogbmFuZF9jc0AzIHsK
KwkJCWFsbHdpbm5lcixwaW5zID0gIlBDMTgiOworCQkJYWxsd2lubmVyLGZ1bmN0aW9uID0gIm5h
bmQwIjsKKwkJCWFsbHdpbm5lcixkcml2ZSA9IDxTVU40SV9QSU5DVFJMXzEwX01BPjsKKwkJCWFs
bHdpbm5lcixwdWxsID0gPFNVTjRJX1BJTkNUUkxfTk9fUFVMTD47CisJCX07CisKKwkJbmFuZF9y
YjBfcGluc19hOiBuYW5kX3JiQDAgeworCQkJYWxsd2lubmVyLHBpbnMgPSAiUEM2IjsKKwkJCWFs
bHdpbm5lcixmdW5jdGlvbiA9ICJuYW5kMCI7CisJCQlhbGx3aW5uZXIsZHJpdmUgPSA8U1VONElf
UElOQ1RSTF8xMF9NQT47CisJCQlhbGx3aW5uZXIscHVsbCA9IDxTVU40SV9QSU5DVFJMX05PX1BV
TEw+OworCQl9OworCisJCW5hbmRfcmIxX3BpbnNfYTogbmFuZF9yYkAxIHsKKwkJCWFsbHdpbm5l
cixwaW5zID0gIlBDNyI7CisJCQlhbGx3aW5uZXIsZnVuY3Rpb24gPSAibmFuZDAiOworCQkJYWxs
d2lubmVyLGRyaXZlID0gPFNVTjRJX1BJTkNUUkxfMTBfTUE+OworCQkJYWxsd2lubmVyLHB1bGwg
PSA8U1VONElfUElOQ1RSTF9OT19QVUxMPjsKKwkJfTsKKwogCQlzcGkwOiBzcGlAMWMwNTAwMCB7
CiAJCQljb21wYXRpYmxlID0gImFsbHdpbm5lcixzdW40aS1hMTAtc3BpIjsKIAkJCXJlZyA9IDww
eDAxYzA1MDAwIDB4MTAwMD47Cg==
--0000000000000a7c1a0602d6793c--
