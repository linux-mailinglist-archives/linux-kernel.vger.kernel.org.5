Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A186F7AA58C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 01:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjIUXUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 19:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbjIUXUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 19:20:20 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DAD478BF1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        sang-engineering.com; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=k1; bh=P2UTB5t8XD9NtlqSsq8WH+UKGF31k4LPyuXnRCJcSsU=; b=aQRTvR
        IoCDhpscqTqS5VyqB969XMkC7KAhmznJ6gBMwQb1g1R7DPY64LTt/yzJOMrq7CWD
        C0h6BfMfn2sR8cYw/0BCkgxE06v4opOIJA4pqlTX77OxMeMEg9ynsFhTZka6OW+g
        eEwQkRArMvYq3rfrFtPIktzJihiUbeUzkfQDpdF1tAQpyP4H5VxTmZt5lXDlDdDQ
        OnWIdM6VUbgA/WeiMQ/9BGPYRuyuv9qZhuawB+VWA1EJNZsfsd8dKhMsnCz2X0yy
        51najsSf09NGgEgYyWml7ju2tHDYB+LlikF3jQn96M3Z07f5RhIRnhS4Xn+w/eFc
        Ft+LEjQ9mCueLt1w==
Received: (qmail 964439 invoked from network); 21 Sep 2023 15:32:12 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 21 Sep 2023 15:32:12 +0200
X-UD-Smtp-Session: l3s3148p1@qKP8hN4FxgcuciJ+
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Johan Hovold <johan@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] dt-bindings: gnss: u-blox: add "reset-gpios" binding
Date:   Thu, 21 Sep 2023 15:32:00 +0200
Message-Id: <20230921133202.5828-3-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230921133202.5828-1-wsa+renesas@sang-engineering.com>
References: <20230921133202.5828-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Needed to enable this chip on a Renesas KingFisher board. Description
copied over from the Mediatek driver which already supports it.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/gnss/u-blox,neo-6m.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/gnss/u-blox,neo-6m.yaml b/Documentation/devicetree/bindings/gnss/u-blox,neo-6m.yaml
index 4835a280b3bf..8e97e475613f 100644
--- a/Documentation/devicetree/bindings/gnss/u-blox,neo-6m.yaml
+++ b/Documentation/devicetree/bindings/gnss/u-blox,neo-6m.yaml
@@ -41,6 +41,9 @@ properties:
     description: >
       Backup voltage regulator
 
+  reset-gpios:
+    maxItems: 1
+
 required:
   - compatible
   - vcc-supply
@@ -49,10 +52,12 @@ unevaluatedProperties: false
 
 examples:
   - |
+    #include <dt-bindings/gpio/gpio.h>
     serial {
         gnss {
             compatible = "u-blox,neo-8";
             v-bckp-supply = <&gnss_v_bckp_reg>;
             vcc-supply = <&gnss_vcc_reg>;
+            reset-gpios = <&gpio 1 GPIO_ACTIVE_LOW>;
         };
     };
-- 
2.35.1

