Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B21376E110
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 09:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233697AbjHCHPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 03:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233691AbjHCHPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 03:15:38 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65AB230FB;
        Thu,  3 Aug 2023 00:15:30 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id CF9DBE0004;
        Thu,  3 Aug 2023 07:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
        t=1691046928;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=LjGFKsUkXrE+rpidnNYpg/TMPfZDDeKhRMGOSFloqow=;
        b=crCqEc7kbtjJRl93F39ALtfZBMb2QNm33QH8hDy/sL2iJyeNe7X9xGMBv5ClvekKKaFCtq
        skUGX3ZLhNumkTv3xu6uKNqsdfbjGqRAGR5o3N6Yew32K/gz2ZUry8CklF0QANzGua2+wU
        VQ61cNj3z8XncJfjHH+b4OIUYUE/3XSlRDgonqzZ4BIhKiS24PP2wgZoqNcp77Z0bwb28q
        SHoRKlzVdIEyGoTfydV9nZuiw2hID+3dQBIxL+1AyZX38VSYeNkl0IGRhPwsPWT0Q/j9tD
        nss8rlFoYIww0tHwtWhgFd00Fy+IUN414Rc23c4REPgp4UA8bbXY8CoYcG3Wrg==
From:   =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     Rob Herring <robh@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        Baruch Siach <baruch@tkos.co.il>,
        Wei Xu <xuwei5@hisilicon.com>, erkin.bozoglu@xeront.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/2] dt-bindings: arm: bcm: add bindings for ASUS RT-AC3100
Date:   Thu,  3 Aug 2023 10:14:53 +0300
Message-Id: <20230803071454.5902-1-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ASUS RT-AC3100 under BCM47094 based boards.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.yaml b/Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.yaml
index 5c3ac97e8728..4cc4e6754681 100644
--- a/Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.yaml
+++ b/Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.yaml
@@ -66,6 +66,7 @@ properties:
       - description: BCM47094 based boards
         items:
           - enum:
+              - asus,rt-ac3100
               - asus,rt-ac88u
               - dlink,dir-885l
               - dlink,dir-890l
-- 
2.39.2

