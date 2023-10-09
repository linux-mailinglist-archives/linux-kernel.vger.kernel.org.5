Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E512F7BEA91
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 21:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378390AbjJIT2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 15:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378395AbjJIT2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 15:28:16 -0400
Received: from forward100a.mail.yandex.net (forward100a.mail.yandex.net [178.154.239.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 020EAA6;
        Mon,  9 Oct 2023 12:28:14 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1d:3e8e:0:640:2b73:0])
        by forward100a.mail.yandex.net (Yandex) with ESMTP id A3BA942B1A;
        Mon,  9 Oct 2023 22:28:12 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id cRi0fk6DeCg0-YKn8TPPD;
        Mon, 09 Oct 2023 22:28:11 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=6tel.net; s=mail;
        t=1696879691; bh=yUgbniaymaplXh58CVULTjy+821cujog1UtQo54FcWc=;
        h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=WGSyZ3yg3Abpi12OgA0iu13YTPOA3SJt5uy22ubd+/7kwHk6BcDVcsI/cXq86ErUE
         FZiNcukrTnDwp0FO+EoAQfLXdNPkTUZvUhG6TGb7GJgAlvur4OKCzYJpIQF0NwC0Kt
         M98DmF6EmB7JZCTmxGK8bCrHAsO1eR8yu1GyHarA=
Authentication-Results: mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net; dkim=pass header.i=@6tel.net
From:   Muhammed Efe Cetin <efectn@6tel.net>
To:     linux-rockchip@lists.infradead.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        heiko@sntech.de, sebastian.reichel@collabora.com, jonas@kwiboo.se,
        megi@xff.cz, d-gole@ti.com, Muhammed Efe Cetin <efectn@6tel.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 1/3] dt-bindings: arm: rockchip: Add Orange Pi 5 board
Date:   Mon,  9 Oct 2023 22:27:25 +0300
Message-ID: <89e92c8df546a0b926ba7481aa83c1945e81e8a4.1696878787.git.efectn@6tel.net>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1696878787.git.efectn@6tel.net>
References: <cover.1696878787.git.efectn@6tel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,T_SPF_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Orange Pi 5 SBC from Xunlong.

Signed-off-by: Muhammed Efe Cetin <efectn@6tel.net>
Reviewed-by: Dhruva Gole <d-gole@ti.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index ca5389862887..b9649e27bc82 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -877,6 +877,11 @@ properties:
               - xunlong,orangepi-r1-plus-lts
           - const: rockchip,rk3328
 
+      - description: Xunlong Orange Pi 5
+        items:
+          - const: xunlong,orangepi-5
+          - const: rockchip,rk3588s
+
       - description: Zkmagic A95X Z2
         items:
           - const: zkmagic,a95x-z2
-- 
2.42.0

