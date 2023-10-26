Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C14CA7D7D63
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 09:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344370AbjJZHJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 03:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbjJZHI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 03:08:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B932118F;
        Thu, 26 Oct 2023 00:08:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5C687C433CA;
        Thu, 26 Oct 2023 07:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux.dev; s=korg;
        t=1698304136; bh=hz+nOTC5E+8gnzYA2BexlgejiqntKVvvG4MRarols1w=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=OlDVuwxwRA5eo6ln7+feW3zIEu7eLneL3ze9wDaRWhqMSVQzXGy/NSfZtfbUHDTvc
         1CGxzztF5euJIaQf1hystKbSJwqTK3auuapWeGZBSnmuI7V5hQcLh0zd6DiyHYmd2A
         BF9WVjrxK2cXl/sKVAnkr03nb4O65xpuRRd0EvYU=
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 39907C25B70;
        Thu, 26 Oct 2023 07:08:56 +0000 (UTC)
From:   Richard Leitner <richard.leitner@linux.dev>
Date:   Thu, 26 Oct 2023 09:08:50 +0200
Subject: [PATCH v2 2/2] dt-bindings: hwmon: ti,ina2xx: add ti,ina237
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231026-ina237-v2-2-dec44811a3c9@linux.dev>
References: <20231026-ina237-v2-0-dec44811a3c9@linux.dev>
In-Reply-To: <20231026-ina237-v2-0-dec44811a3c9@linux.dev>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org,
        Richard Leitner <richard.leitner@linux.dev>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698304135; l=711;
 i=richard.leitner@linux.dev; s=20231025; h=from:subject:message-id;
 bh=hz+nOTC5E+8gnzYA2BexlgejiqntKVvvG4MRarols1w=; =?utf-8?q?b=3D52V4KetWDgyI?=
 =?utf-8?q?jvgRhZArF8xqDkr7222pycFNSta1cRJ7abK31jjnVIwHzCJpR5h76SRAt7q+Ok0L?=
 93Y4ZIZ7Awa8ZBIkJkNAvTda5MMabZh/+JOVsOR2Eu4XWKtS6POu
X-Developer-Key: i=richard.leitner@linux.dev; a=ed25519;
 pk=ZYa5+0m9RFYtnNU6DLet7sHyPehnVHa0ucJlYiAu2NU=
X-Endpoint-Received: by B4 Relay for richard.leitner@linux.dev/20231025 with auth_id=90
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        T_SPF_PERMERROR,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ti,ina237 binding to ti,ina2xx as they are very similar and may
share the same properties.

Signed-off-by: Richard Leitner <richard.leitner@linux.dev>
---
 Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml b/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
index 8648877d2d01..378d1f6aeeb3 100644
--- a/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
+++ b/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
@@ -26,6 +26,7 @@ properties:
       - ti,ina226
       - ti,ina230
       - ti,ina231
+      - ti,ina237
       - ti,ina238
 
   reg:

-- 
2.40.1

