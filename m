Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AAAB7735F5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 03:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbjHHBc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 21:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjHHBcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 21:32:51 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947D81FC6
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 18:32:27 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 74A7D2C02A5;
        Tue,  8 Aug 2023 13:32:23 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1691458343;
        bh=mceb6e8GZD8N2t1BnOJ3Ku2TSMK9s9DDBNQyN/+XfTA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AW/LRgiEoavGhC6ZAIx9S6rjuo9EQeWjgvJvpYTc/LyYHNUwt6qo5yZI6+uGONiaS
         5G8T1JXEM2yqAnzBT5FHIKkGhw4gnM+u2TvWTwvE6++wJQNQN2XPkIWnb5AGTw3FJR
         vXPXT++qOJ5QQwI/+7cVVLVU/ZTVfr1qWI4/7MuA99afXGORJmqZhEnAsBOKXRM7AB
         hDQ8a7O55UB1hAkqKloKCZpz33+h8lOnESLyPwcl+Bol+uGO0Zk4tTw2Iadpvyyeiq
         99y91QNK0xDmZwZ2xKpz4IdIeQqkwxWWE9QkEcGlqTjttAQadkFUH6qUK25OkeTFAF
         MOLQww4mfGlig==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B64d19b270001>; Tue, 08 Aug 2023 13:32:23 +1200
Received: from markto-dl.ws.atlnz.lc (markto-dl.ws.atlnz.lc [10.33.23.10])
        by pat.atlnz.lc (Postfix) with ESMTP id 44D6D13EE40;
        Tue,  8 Aug 2023 13:32:23 +1200 (NZST)
Received: by markto-dl.ws.atlnz.lc (Postfix, from userid 1155)
        id 48CA144494; Tue,  8 Aug 2023 13:32:23 +1200 (NZST)
From:   Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Mathew McBride <matt@traverse.com.au>,
        Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
Subject: [PATCH 2/2] dt-bindings: hwmon: add EMC181x
Date:   Tue,  8 Aug 2023 13:31:57 +1200
Message-ID: <20230808013157.80913-2-mark.tomlinson@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230808013157.80913-1-mark.tomlinson@alliedtelesis.co.nz>
References: <20230808013157.80913-1-mark.tomlinson@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=boIy+3Si c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=IkcTkHD0fZMA:10 a=UttIx32zK-AA:10 a=gEfo2CItAAAA:8 a=d0t0iNI6APqrSpnZPF8A:9 a=QEXdDO2ut3YA:10 a=sptkURWiP4Gy88Gu7hUp:22
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The EMC181x range are I2C temperature sensors with a varying number of
sensors in each device. Each has one internal sensor, and one to four
external sensor diodes.

The default range is from 0=C2=B0C to +127=C2=B0C, but can be extended to=
 -64=C2=B0C to
+191=C2=B0C.

Signed-off-by: Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
---
 .../bindings/hwmon/microchip,emc181x.yaml     | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/microchip,emc=
181x.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/microchip,emc181x.ya=
ml b/Documentation/devicetree/bindings/hwmon/microchip,emc181x.yaml
new file mode 100644
index 000000000000..5967f98ad7ba
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/microchip,emc181x.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+
+$id: http://devicetree.org/schemas/hwmon/microchip,emc181x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip EMC1812/EMC1813/EMC1814/EMC1815/EMC1833 temperature sen=
sors
+
+maintainers:
+  - Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
+
+properties:
+  compatible:
+    enum:
+      - microchip,emc1812
+      - microchip,emc1813
+      - microchip,emc1814
+      - microchip,emc1815
+      - microchip,emc1833
+
+  reg:
+    maxItems: 1
+
+  emc181x,extended-range:
+    description: Allow for reading of extended temperature range (-64-19=
2C)
+
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells =3D <1>;
+        #size-cells =3D <0>;
+
+        temperature-sensor@7c {
+            compatible =3D "microchip,emc1812";
+            reg =3D <0x7c>;
+        };
+    };
--=20
2.41.0

