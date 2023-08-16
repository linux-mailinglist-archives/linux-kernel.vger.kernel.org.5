Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F60B77E192
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 14:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245221AbjHPM0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 08:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245146AbjHPMZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 08:25:21 -0400
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C3D26B7;
        Wed, 16 Aug 2023 05:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
        s=default2211; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=Jw6Xj4AHLs/mvoGawLbbzyE/G0/S+Blp97r2CL4A/Tw=; b=J3ZpgKKo5EYFekN3Q8SBhX9wzE
        x5mwYysVFHuoL40NqluYwKNiOu5s1Lj3sLQFZLqcHBVNr/oWaprMRVfF3ZvbXYS6vtiG6BYmPEfFq
        LOj13Dcaip2a6p5woJUsOh3QCOB5ymrkAZd2BwhqfFrTw2PO1M3ilDPXaJkwenFFpRzeCR5Joczjo
        apCpQ9MjbFsG6Nr832WxdxsV2jGOsxCKvqG+IGm/mlzsVxRfbldRTUWc4fkoTNu4sWF2zOtbkoEQS
        1PkQPD8VshfP/vprmTuoWqJh5KEYR7duBBy8BhB6LfUTPyADGwvGrebdQ05yseP/1rk5LtylYY35R
        w+naZS/w==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <sean@geanix.com>)
        id 1qWFaL-000NC2-D7; Wed, 16 Aug 2023 14:25:13 +0200
Received: from [185.17.218.86] (helo=zen..)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sean@geanix.com>)
        id 1qWFaK-000HIl-Fd; Wed, 16 Aug 2023 14:25:12 +0200
From:   Sean Nyekjaer <sean@geanix.com>
To:     l.goehrs@pengutronix.de, a.fatoum@pengutronix.de,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     Sean Nyekjaer <sean@geanix.com>, dantuguf14105@gmail.com,
        Conor Dooley <conor.dooley@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 8/9] dt-bindings: arm: stm32: add extra SiP compatible for oct,stm32mp157c-osd32-red
Date:   Wed, 16 Aug 2023 14:24:28 +0200
Message-ID: <20230816122435.3153513-8-sean@geanix.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230816122435.3153513-1-sean@geanix.com>
References: <20230816122435.3153513-1-sean@geanix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.8/27002/Wed Aug 16 09:38:26 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding support for the Octavo OSD32MP1-RED development board.

General features:
 - STM32MP157C
 - 512MB DDR3
 - CAN-FD
 - HDMI
 - USB-C OTG
 - UART

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes since v4:
 - As per Krzysztof, removed indent of previous boards

 Documentation/devicetree/bindings/arm/stm32/stm32.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
index 4bf28e717a56..df087c81c69e 100644
--- a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
+++ b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
@@ -146,6 +146,7 @@ properties:
               - lxa,stm32mp157c-mc1      # Linux Automation MC-1
               - lxa,stm32mp157c-tac-gen1 # Linux Automation TAC (Generation 1)
               - lxa,stm32mp157c-tac-gen2 # Linux Automation TAC (Generation 2)
+              - oct,stm32mp157c-osd32-red # Octavo OSD32MP1 RED board
           - const: oct,stm32mp15xx-osd32
           - enum:
               - st,stm32mp157
-- 
2.41.0

