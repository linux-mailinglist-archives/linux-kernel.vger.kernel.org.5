Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4164C7A6000
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 12:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbjISKrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 06:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbjISKrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 06:47:39 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64CB312B
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 03:47:32 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-690bc3f82a7so1005293b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 03:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695120452; x=1695725252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DfsDvbPSiwYQ6ykzK/+9gGTqaEflNO3ef5+ehoxsuns=;
        b=nLVfyZneTcBJ/lTRGHVYuKIhZKV9MUSv/+e5lYgHPZIrNtLR1Q4Jp+e6/q4YqWg4cJ
         9w/sAHM68WJnsjp0tw1+qejgP5qMnYJ0QXLvAsm/ftp+xnC8d2QnCp7I2jKZ19EP/J9d
         iBN6pqwtESAE+nAm7qvjfi3oi8FeSnlKetiDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695120452; x=1695725252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DfsDvbPSiwYQ6ykzK/+9gGTqaEflNO3ef5+ehoxsuns=;
        b=jyTqU/aYQGWXaAOwUy0/uV66rPhgwIFIC2RqhMXhvzPZvay23GHBWhc7+432XPI9yv
         CAehncKM1la3yUEUTSh9lSmg3KP+io2o1uNuyB8YjEF4mg+UP64uztbGmNN5V2+ued4C
         byTy0cBJbWJLrkJoz7tD3VGgZhV+F078hSZqeW8z22vxMl8+HA1nz8fUD/4HvRm2W18B
         WqJRW60Y+5is2hX2tRtXw7f7/GtmBEztpmmT7jvMz9f5w0y8/BlFNIvDAbIWgSMu5Y8+
         d/iO95TxKGaMnuq+LRNiJkCfDOoBDGaeKsA+MW2ZWDvxFaUiqZ1f8KaDO2U9MdFmwObQ
         77Ww==
X-Gm-Message-State: AOJu0YznvQAqtkQlk5xC3wSiBgACSc3d5ziuoklBDAxaCko4c4lZNwio
        GSBAlSCKge+7hMn5JFZyRYAObA==
X-Google-Smtp-Source: AGHT+IE5Vei5aZs2np5Axe2YBgPyKwPoboQ8aw1zKo4wXP/xj7KGpl92oYuS6GOzCirq4QXhP1nLtg==
X-Received: by 2002:a05:6a21:498e:b0:142:aced:c643 with SMTP id ax14-20020a056a21498e00b00142acedc643mr10956371pzc.31.1695120451840;
        Tue, 19 Sep 2023 03:47:31 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:40a:900d:e731:5a43])
        by smtp.gmail.com with ESMTPSA id c10-20020a170902d48a00b001bc445e249asm6719578plg.124.2023.09.19.03.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 03:47:31 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v3 03/12] regulator: dt-bindings: mt6358: Add regulator-allowed-modes property
Date:   Tue, 19 Sep 2023 18:43:46 +0800
Message-ID: <20230919104357.3971512-4-wenst@chromium.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
In-Reply-To: <20230919104357.3971512-1-wenst@chromium.org>
References: <20230919104357.3971512-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MT6358 PMIC allows changing operating modes for the buck regulators,
but not the LDOs. Existing device trees and the Linux implementation
already utilize this through the standard regulator-allowed-modes
property.

The values currently used in existing device trees are simply raw
numbers. The values in the Linux driver are matching numbers defined
with macros denoting the two supported modes. Turns out these two
modes are common across parts of the larger MT63xx PMIC family. The
MT6397 regulator binding already has macros for the two modes, with
matching numbers.

Codify the supported values for regulator-allowed-modes for the MT6358
in the device tree binding: 0 and 1 are supported for buck regulators,
and the property should not be present for LDO regulators. Users should
use the dt-bindings/regulator/mediatek,mt6397-regulator.h header for
the macros, instead of using raw numbers.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v2:
- new patch

 .../regulator/mediatek,mt6358-regulator.yaml  | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/mediatek,mt6358-regulator.yaml b/Documentation/devicetree/bindings/regulator/mediatek,mt6358-regulator.yaml
index 5daef024de3e..62e8fa6b4306 100644
--- a/Documentation/devicetree/bindings/regulator/mediatek,mt6358-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/mediatek,mt6358-regulator.yaml
@@ -23,48 +23,71 @@ patternProperties:
     description: Buck regulators
     type: object
     $ref: regulator.yaml#
+    properties:
+      regulator-allowed-modes:
+        description: |
+          Buck regulatpr operating modes allowed. Valid values below.
+          Users should use the macros from dt-bindings/regulator/mediatek,mt6397-regulator.h
+            0 (MT6397_BUCK_MODE_AUTO): Auto PFM/PWM mode
+            1 (MT6397_BUCK_MODE_FORCE_PWM): Forced PWM mode
+        items:
+          enum: [0, 1]
     unevaluatedProperties: false
 
   "^ldo_v(a|rf)12$":
     description: LDOs with fixed 1.2V output and 0~100/10mV tuning
     type: object
     $ref: regulator.yaml#
+    properties:
+      regulator-allowed-modes: false
     unevaluatedProperties: false
 
   "^ldo_v((aux|cn|io|rf)18|camio)$":
     description: LDOs with fixed 1.8V output and 0~100/10mV tuning
     type: object
     $ref: regulator.yaml#
+    properties:
+      regulator-allowed-modes: false
     unevaluatedProperties: false
 
   "^ldo_vxo22$":
     description: LDOs with fixed 2.2V output and 0~100/10mV tuning
     type: object
     $ref: regulator.yaml#
+    properties:
+      regulator-allowed-modes: false
     unevaluatedProperties: false
 
   "^ldo_v(aud|bif|cn|fe|io)28$":
     description: LDOs with fixed 2.8V output and 0~100/10mV tuning
     type: object
     $ref: regulator.yaml#
+    properties:
+      regulator-allowed-modes: false
     unevaluatedProperties: false
 
   "^ldo_vusb$":
     description: LDOs with fixed 3.0V output and 0~100/10mV tuning
     type: object
     $ref: regulator.yaml#
+    properties:
+      regulator-allowed-modes: false
     unevaluatedProperties: false
 
   "^ldo_vsram_(gpu|others|proc1[12])$":
     description: LDOs with variable output
     type: object
     $ref: regulator.yaml#
+    properties:
+      regulator-allowed-modes: false
     unevaluatedProperties: false
 
   "^ldo_v(cama[12]|camd|cn33|dram2|efuse|emc|ibr|ldo28|mc|mch|sim[12])$":
     description: LDOs with variable output and 0~100/10mV tuning
     type: object
     $ref: regulator.yaml#
+    properties:
+      regulator-allowed-modes: false
     unevaluatedProperties: false
 
 required:
@@ -74,6 +97,8 @@ additionalProperties: false
 
 examples:
   - |
+    #include <dt-bindings/regulator/mediatek,mt6397-regulator.h>
+
     regulator {
         compatible = "mediatek,mt6358-regulator";
 
@@ -83,6 +108,8 @@ examples:
             regulator-max-microvolt = <900000>;
             regulator-ramp-delay = <6250>;
             regulator-enable-ramp-delay = <200>;
+            regulator-allowed-modes = <MT6397_BUCK_MODE_AUTO
+                                       MT6397_BUCK_MODE_FORCE_PWM>;
         };
 
         ldo_vsram_gpu {
-- 
2.42.0.459.ge4e396fd5e-goog

