Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35B977AB482
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 17:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbjIVPM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 11:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbjIVPMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 11:12:24 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7C2100;
        Fri, 22 Sep 2023 08:12:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1695395535; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=hWeDzpkxWLkdNuHYY8IrBC7CF0ZtWuXUBDbORkM2wDWbEFJaBdqsAE8pE6A3QS0Puc
    s8loRn0BA/BkzCCJuti1FMJAUV0jsh6i2xrXcbJbbIC7dMz3IufcVSSlRdUcxkU5qNeF
    t709PKt7reNcegyBf5d+ZhM4EeVpMCBYC7bIxhpJ6s3z3lnP+Wm/wELGsW57KRwmnk4X
    /erz4v2O6CckO0MI+8gYhZ9Kpg/bSOTFHWX9MQ4xvvijcKUamX5/YVYyTcaqg1Gnhnli
    f99Hfc0ZQCb77uCSY/W3v2eANJ022lb4jhS6MlEbzTvbO6peahPSUlEBVXVKJKjKsk8p
    I5BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1695395535;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=6GNziuA5bPGmA8agGZsLkyePalgcQb3kwfHxsfFp+NM=;
    b=bWmlR1LnEB3A7Ufa1BacvZ5Z8FaGOsuheXyMqE4BME2EgmEy9+xZ7UNUvhwiMTv7JK
    3q1Wgjh9Hc87mMX9zTid6sHFPbwbzZZr6W31e83lhsjb35k4z2WFtahpycgKgb9RA5gh
    S/DXW8378W+6L6lTrwBkt1l3hbGoeb/xWm7YuaRIHTOmr6s06z/wHbaHmzHSIQM7AX22
    4fSE+QAv0y9cye9B1bmygUbIIRu+hcdEvYED2lLX/TnGqQ5R/D9sse3Gg2newvpZfJcy
    a1RAZslbCd9Q/YsSYLQ9CmUxJhIZwU66IngL/m5WrGwPiGwBxRfBixg22U4v30vjGyTQ
    d0og==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1695395535;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=6GNziuA5bPGmA8agGZsLkyePalgcQb3kwfHxsfFp+NM=;
    b=D8U2yPhbXLcsCv5P+96WTdXXCeLBZYqAXfZMZQa15fDKkH/0gtaJSeD6mVzWuMsdIn
    I9x3e5h7o45TXatHNNagwvpmUlXX/pYQR1gcJN1ylz62OIsTngnC82cNOJHksVGsWBWL
    38Q+FK1DtZqnaksVdrssU6RFr3GkppiY8ZhXf/bV/yk2g4XiHNr+3hz0zKIJA+tMAfuV
    vBfMb0c9HdDU7UiHFVu/4gkYq6FKtRZS1Cj+dthodl0d4w7eYzxzYHJ274kA9brRb+J7
    K7UDD8sLgyN940ktNuSth9puvX0reBSUk+sugOIcEZMH+Qkyt42QFCWXWLD5dSL7gRPN
    Juvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1695395535;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=6GNziuA5bPGmA8agGZsLkyePalgcQb3kwfHxsfFp+NM=;
    b=gR2vEI/uw9AfNPGMqJWkk3P3iZCNZrqtXdK5G8TfqG2V8UJTwDv5IoD2ZLn9KBrve7
    OGrwsztD+S7+7xRPGDCg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn9VOL59w=="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.8.2 DYNA|AUTH)
    with ESMTPSA id R04c57z8MFCEUd7
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 22 Sep 2023 17:12:14 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Fri, 22 Sep 2023 17:11:57 +0200
Subject: [PATCH 2/2] arm64: dts: qcom: apq8016-sbc-d3-camera: Convert to DT
 overlay
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230922-apq8016-sbc-camera-dtso-v1-2-ce9451895ca1@gerhold.net>
References: <20230922-apq8016-sbc-camera-dtso-v1-0-ce9451895ca1@gerhold.net>
In-Reply-To: <20230922-apq8016-sbc-camera-dtso-v1-0-ce9451895ca1@gerhold.net>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Follow the example of the recently added apq8016-sbc-usb-host.dtso and
convert apq8016-sbc-d3-camera-mezzanine.dts to a DT overlay that can be
applied on top of the apq8016-sbc.dtb. This makes it more clear that
this is not a special type of DB410c but just an addon board that can
be added on top.

Functionally there should not be any difference since
apq8016-sbc-d3-camera-mezzanine.dtb is still generated as before
(but now by applying the overlay on top of apq8016-sbc.dtb).

Since dtc does not know that there are default #address/size-cells in
msm8916.dtsi, repeat those in the overlay to avoid dtc warnings because
it expects the wrong amount of address/size-cells.

It would be nice to have a generic overlay for the D3 camera mezzanine
(that can be applied to all 96Boards) but that's much more complicated
than providing a board-specific DT overlay as intermediate step.

Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
NOTE: I haven't tried booting this (since I don't have the camera
mezzanine) but I compared the resulting apq8016-sbc-d3-camera-mezzanine.dtb
which seems to be equivalent to the old one (aside from phandle
numbering and ordering).

It wouldn't hurt if someone could try booting this to be sure. :-)
---
 arch/arm64/boot/dts/qcom/Makefile                            |  5 +++--
 ...ra-mezzanine.dts => apq8016-sbc-d3-camera-mezzanine.dtso} | 12 ++++++++++--
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index d6cb840b7050..641d770662a1 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -1,10 +1,11 @@
 # SPDX-License-Identifier: GPL-2.0
 dtb-$(CONFIG_ARCH_QCOM)	+= apq8016-sbc.dtb
 
-apq8016-sbc-usb-host-dtbs	:= apq8016-sbc.dtb apq8016-sbc-usb-host.dtbo
+apq8016-sbc-d3-camera-mezzanine-dtbs	:= apq8016-sbc.dtb apq8016-sbc-d3-camera-mezzanine.dtbo
+apq8016-sbc-usb-host-dtbs		:= apq8016-sbc.dtb apq8016-sbc-usb-host.dtbo
 
-dtb-$(CONFIG_ARCH_QCOM)	+= apq8016-sbc-usb-host.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= apq8016-sbc-d3-camera-mezzanine.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= apq8016-sbc-usb-host.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= apq8039-t2.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= apq8094-sony-xperia-kitakami-karin_windy.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= apq8096-db820c.dtb
diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc-d3-camera-mezzanine.dts b/arch/arm64/boot/dts/qcom/apq8016-sbc-d3-camera-mezzanine.dtso
similarity index 89%
rename from arch/arm64/boot/dts/qcom/apq8016-sbc-d3-camera-mezzanine.dts
rename to arch/arm64/boot/dts/qcom/apq8016-sbc-d3-camera-mezzanine.dtso
index f9cbf8c1d689..d739ece6b44f 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc-d3-camera-mezzanine.dts
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc-d3-camera-mezzanine.dtso
@@ -5,10 +5,12 @@
  */
 
 /dts-v1/;
+/plugin/;
 
-#include "apq8016-sbc.dts"
+#include <dt-bindings/clock/qcom,gcc-msm8916.h>
+#include <dt-bindings/gpio/gpio.h>
 
-/ {
+&{/} {
 	camera_vdddo_1v8: regulator-camera-vdddo {
 		compatible = "regulator-fixed";
 		regulator-name = "camera_vdddo";
@@ -38,6 +40,9 @@ &camss {
 	status = "okay";
 
 	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
 		port@0 {
 			reg = <0>;
 			csiphy0_ep: endpoint {
@@ -53,6 +58,9 @@ &cci {
 };
 
 &cci_i2c0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
 	camera@3b {
 		compatible = "ovti,ov5640";
 		reg = <0x3b>;

-- 
2.42.0

