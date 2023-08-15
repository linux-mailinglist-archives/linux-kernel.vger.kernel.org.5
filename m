Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B74077D0FD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 19:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238844AbjHOR2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 13:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238691AbjHOR2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 13:28:08 -0400
X-Greylist: delayed 203 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 15 Aug 2023 10:27:47 PDT
Received: from mo6-p02-ob.smtp.rzone.de (mo6-p02-ob.smtp.rzone.de [IPv6:2a01:238:400:300::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1962C1FFA
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 10:27:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1692120072; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=FFWPbbPGCxBPNWSfAzf2SbeMSJkx4v1DZ3NFEGPLJiNNFHidJrMRcrRbewctFJOItV
    8iX37sWvKl6t0tCkw22qFM2/dE2ocDjLIlNhpWQCHK3SYs0L+Nc4HZ74MMtG7++lgDqh
    30c+wNRTslEPzoCd4yRWcIP/mqBPU95ztgzDe8ko8n+xElyG2FsY1HlbxyRl0Y4kFfdg
    u9Nlcc+Vngr7/Zw32EVO5fGonF550yob5mJw7gJkwY/CMSx4GMNGK5GgHkMfDgp81Kl3
    HMJXaLcCgOQ1RmqzlkSFoZdDy3GqYjF7VI0549RoZD5TEQVTeiFrdBRO8bLDuninwOUY
    JHbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1692120072;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=OvXjeQ3KhCC7JaRMJrhSDALEMowi+xqTH2TinBMCtJI=;
    b=D6+5WEgIDrnhd0VE4Eh6LHCy0vPTkP6IDO66QBU9Ael3Wdq3DV/g2ErMiBBFnnQioo
    SyYPct1Kza3sNIcsGe7YotTp+VnAOmdjRBpgEsLxJk42Ky8eYL/QwrUe1bV9sjKCU643
    Gbm7qqbm0dAM062PAzlZ5jBYnR5LdYi19WCNQyH9nwISgH8TkiuAS0vjI71/Qj9wnGPi
    NAWh+zKPQUC7chQufXoQs6eSUPyD2Y6oeT9p7SDuGLfRW3E0ranC2Tp/dfn54sS8CFDr
    EQNC80flCxgBKsoI733g0SM2I/uXWbE1u8xcwskiNT1cfuvXEPFpvH6mgl8fJP+23o4J
    OiJA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1692120072;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=OvXjeQ3KhCC7JaRMJrhSDALEMowi+xqTH2TinBMCtJI=;
    b=mef6YkzGbqLzk/v9Qs34e3e6mwrDglZdTn7hVEL1WVRX/FAK36MCV29l79oF6e8C5d
    nbByfm5+J/6HEwyXyDIlahFGDTsEMyv7GxeioyPAhTme47mZ4GA+6f9+vFbTSc0OvEMk
    BRCahe/xZNNicOjjnPayqseRih6yMYqjzhM9tuvNjAOuwn5H7F4LxipM8hz/nleZij+3
    P/vYH56lIW4FY+IKnu/GXCc44v+xK6TFfQV7hMK2fJZWaIvrzAqWRX7S5qAEWOtrzVuf
    htodEceRxbv02f67gSiTgFUelXWU8/0g3RlAvHI9usbecB1dwpnA0vZnaNAdEwYtFTlo
    fqOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1692120072;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=OvXjeQ3KhCC7JaRMJrhSDALEMowi+xqTH2TinBMCtJI=;
    b=iimXrnM/KNIli5yVYzOeJWkUZwqORTN6GA0GjFxMVLEPm8VH+XwhX11fTPB9NDLsNN
    U9h7kCDXBhQ2OX+BTsDQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u4F1mw=="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.8.0 DYNA|AUTH)
    with ESMTPSA id v41b8bz7FHLC0YV
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 15 Aug 2023 19:21:12 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Tue, 15 Aug 2023 19:21:05 +0200
Subject: [PATCH v3 2/3] dt-bindings: leds: Document pull-up supply for
 interrupt and I2C
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230815-aw2013-vio-v3-2-2505296b0856@gerhold.net>
References: <20230815-aw2013-vio-v3-0-2505296b0856@gerhold.net>
In-Reply-To: <20230815-aw2013-vio-v3-0-2505296b0856@gerhold.net>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Nikita Travkin <nikita@trvn.ru>, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Lin, Meng-Bo" <linmengbo0689@protonmail.com>,
        Stephan Gerhold <stephan@gerhold.net>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the interrupt and I2C lines of AW2013 operate in open drain low
active mode a pull-up supply is needed for correct operation.
Unfortunately there is no ideal place to describe it in the DT: The
pull-up needed for the I2C lines could be described on the I2C bus.
However, the pull-up needed for the interrupt line belongs neither
directly to the interrupt controller nor to AW2013. Since the AW2013
driver will be typically in control of the power management and
interrupt masking it makes more sense to describe it inside the AW2013
device tree node.

Add it to the AW2013 DT schema together with a comment that makes it
clear what exactly it represents.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
Related previous discussion:
https://lore.kernel.org/linux-leds/20230321220825.GA1685482-robh@kernel.org/
---
 Documentation/devicetree/bindings/leds/leds-aw2013.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/leds/leds-aw2013.yaml b/Documentation/devicetree/bindings/leds/leds-aw2013.yaml
index a0a0dabcfbf3..26238446f2bd 100644
--- a/Documentation/devicetree/bindings/leds/leds-aw2013.yaml
+++ b/Documentation/devicetree/bindings/leds/leds-aw2013.yaml
@@ -28,6 +28,12 @@ properties:
   vcc-supply:
     description: Regulator providing power to the "VCC" pin.
 
+  vio-supply:
+    description: Regulator providing power for pull-up of the I/O lines.
+      "VIO1" in the typical application circuit example of the datasheet.
+      Note that this regulator does not directly connect to AW2013, but is
+      needed for the correct operation of the interrupt and I2C lines.
+
   "#address-cells":
     const: 1
 

-- 
2.41.0

