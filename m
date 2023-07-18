Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D992F7574BD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 08:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbjGRG6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 02:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbjGRG6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 02:58:05 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DABE41B5;
        Mon, 17 Jul 2023 23:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1689663484; x=1721199484;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P6VvQvFvwkNOAOvrLhOm+eEGUjR865o3HtvDrNiPEjE=;
  b=qCDlazY/cgVjUGP61hJjNl7Kar/BT6irxDX+qu1S5zRA77hUuAc9thh6
   L3tLA3f85H3xPgzmnM/EIANjna+VUI5lFYmcjqSbOnedFOEJdtyrEiuj2
   2UFypevXSpigf63IO1eEgVcTNMFVC1rxpz2WSLieXMB/pGLSBOa44a+0v
   TWyOVZ1vrhGYcp+s/L8pPXxKb6PpvEz14Q3xAGuXj2i1iWzrE7Q+RPIHq
   r2MU/kmJZ2qVn1OlAv1As/FTDBpxnwzqRy8HRpmTyojsY3yhYzy14KMaP
   BECpbBWRkfJZN5NwgkvvYrq+KKYk6dRTeNXpShqS4juAUmJPAztJE2ej4
   g==;
X-IronPort-AV: E=Sophos;i="6.01,213,1684825200"; 
   d="scan'208";a="236147753"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Jul 2023 23:58:03 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 17 Jul 2023 23:58:03 -0700
Received: from che-lt-i66125lx.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Mon, 17 Jul 2023 23:57:52 -0700
From:   Durai Manickam KR <durai.manickamkr@microchip.com>
To:     <Hari.PrasathGE@microchip.com>,
        <balamanikandan.gunasundar@microchip.com>,
        <manikandan.m@microchip.com>, <varshini.rajendran@microchip.com>,
        <dharma.b@microchip.com>, <nayabbasha.sayed@microchip.com>,
        <balakrishnan.s@microchip.com>, <cristian.birsan@microchip.com>,
        <nicolas.ferre@microchip.com>, <krzysztof.kozlowski@linaro.org>,
        <alexandre.belloni@bootlin.com>, <davem@davemloft.net>,
        <arnd@arndb.de>, <olof@lixom.net>, <soc@kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Kavyasree.Kotagiri@microchip.com>,
        <Horatiu.Vultur@microchip.com>, <robh+dt@kernel.org>,
        <andrew@lunn.ch>, <michael@walle.cc>, <jerry.ray@microchip.com>,
        <conor+dt@kernel.org>, <jesper.nilsson@axis.com>,
        <andre.przywara@arm.com>, <ada@thorsis.com>,
        <radu_nicolae.pirea@upb.ro>, <richard.genoud@gmail.com>,
        <gregkh@linuxfoundation.org>, <linux-spi@vger.kernel.org>,
        <linux-serial@vger.kernel.org>
CC:     Durai Manickam KR <durai.manickamkr@microchip.com>
Subject: [PATCHv3 1/2] dt-bindings: serial: atmel,at91-usart: update compatible for sam9x60
Date:   Tue, 18 Jul 2023 12:27:34 +0530
Message-ID: <20230718065735.10187-2-durai.manickamkr@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230718065735.10187-1-durai.manickamkr@microchip.com>
References: <20230718065735.10187-1-durai.manickamkr@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is only one debug unit in the sam9x60 SOC and it has the chipid
register. So, the dbgu compatible strings are valid only for debug usart.
Defining these dbgu compatible strings are not valid for flexcom usart.
So adding the items which is valid only for flexcom usart and removing
the microchip,sam9x60-usart compatible string from the enum list as no
usart node defines only this specific compatible string.

Signed-off-by: Durai Manickam KR <durai.manickamkr@microchip.com>
---
 .../devicetree/bindings/serial/atmel,at91-usart.yaml          | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml b/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
index 30b2131b5860..65cb2e5c5eee 100644
--- a/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
+++ b/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
@@ -16,13 +16,15 @@ properties:
       - enum:
           - atmel,at91rm9200-usart
           - atmel,at91sam9260-usart
-          - microchip,sam9x60-usart
       - items:
           - const: atmel,at91rm9200-dbgu
           - const: atmel,at91rm9200-usart
       - items:
           - const: atmel,at91sam9260-dbgu
           - const: atmel,at91sam9260-usart
+      - items:
+          - const: microchip,sam9x60-usart
+          - const: atmel,at91sam9260-usart
       - items:
           - const: microchip,sam9x60-dbgu
           - const: microchip,sam9x60-usart
-- 
2.25.1

