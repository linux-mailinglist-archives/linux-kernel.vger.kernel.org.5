Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1787B169C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 10:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbjI1I4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 04:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbjI1I4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 04:56:04 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D280419E
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 01:56:01 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-692a9bc32bcso9287722b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 01:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695891361; x=1696496161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B70I1HVdZcndWp3UgCKKWWEd0o3XW1h61Xx1jg7vsRI=;
        b=STdE94ax3Z39WAKjmhlLgC1uQBg706Vmep1Pa/tWPShKzm88JcQxUzoc8nu+VNC7EB
         G1z7pn/YIf7UapQ1vXQafj+DGc/Pu7INBhXz0elnqB3OqpvCi8w2Gx5d4idROyAXmv3M
         mLghEoCRzNY6c2vxPuPntF/m63mU7sfFVjfN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695891361; x=1696496161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B70I1HVdZcndWp3UgCKKWWEd0o3XW1h61Xx1jg7vsRI=;
        b=oR5vmiVoAWEqyOM0j3gQAFUFH6KGe9ie+Ty+CLXhiRPDHolaAaJQ5QXmtbII12PX1h
         JaMInb6PizBejTCwWo4g7HAVrs7Z90lA9sZSIIzFni1TizC5BYyBUg5cfDS1wmNkFpfZ
         Ol1U4vhDPyFhXZ4qj9p6jAS5KpISfk7+j/aEG4VfVwGgGKApfnbCiQxX64SnOgNm4kdS
         /UisgBv4GnQaobSY5Mm+BpG1+j5PeadSAb70Lc08uyjBUFeE+AwR36msWbJ2wNNkx06E
         Ao6dZAW/J72W1G/kKt6Uu1elQ2iHwi7VjjowI3iSQZTl1BSSX4nhJW8qyWddhHybvi86
         NcaQ==
X-Gm-Message-State: AOJu0Yz5hA1b3gWDBh6NVKSfl4HD3PWx5KY9MXVyynqXV/J0TPfy0hid
        J0v8ERkH7CB03onl8pl0hfI4Nw==
X-Google-Smtp-Source: AGHT+IFl04ON4D1Ic/k0X0ZMnVLo7gttKdtn9tcBSXQrLi5Wav4rpOb6iw9rZiRkyCAm/WOP7TMYPw==
X-Received: by 2002:a05:6a00:17a1:b0:693:3c11:4293 with SMTP id s33-20020a056a0017a100b006933c114293mr628490pfg.14.1695891361353;
        Thu, 28 Sep 2023 01:56:01 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:6747:c12a:dbfd:2cc7])
        by smtp.gmail.com with ESMTPSA id y7-20020aa78047000000b006879493aca0sm1754016pfm.26.2023.09.28.01.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 01:56:01 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, Lee Jones <lee@kernel.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v4 03/12] regulator: dt-bindings: mt6358: Add regulator-allowed-modes property
Date:   Thu, 28 Sep 2023 16:55:26 +0800
Message-ID: <20230928085537.3246669-4-wenst@chromium.org>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
In-Reply-To: <20230928085537.3246669-1-wenst@chromium.org>
References: <20230928085537.3246669-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
Changes since v3:
- adapt to ldo_vxo22 and ldo_vusb movement to properties

Changes since v2:
- new patch

 .../regulator/mediatek,mt6358-regulator.yaml  | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/mediatek,mt6358-regulator.yaml b/Documentation/devicetree/bindings/regulator/mediatek,mt6358-regulator.yaml
index 126f502a2bda..e8c3299d698f 100644
--- a/Documentation/devicetree/bindings/regulator/mediatek,mt6358-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/mediatek,mt6358-regulator.yaml
@@ -22,12 +22,16 @@ properties:
     description: LDOs with fixed 2.2V output and 0~100/10mV tuning
     type: object
     $ref: regulator.yaml#
+    properties:
+      regulator-allowed-modes: false
     unevaluatedProperties: false
 
   ldo_vusb:
     description: LDOs with fixed 3.0V output and 0~100/10mV tuning
     type: object
     $ref: regulator.yaml#
+    properties:
+      regulator-allowed-modes: false
     unevaluatedProperties: false
 
 
@@ -36,36 +40,55 @@ patternProperties:
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
 
   "^ldo_v(aud|bif|cn|fe|io)28$":
     description: LDOs with fixed 2.8V output and 0~100/10mV tuning
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
@@ -75,6 +98,8 @@ additionalProperties: false
 
 examples:
   - |
+    #include <dt-bindings/regulator/mediatek,mt6397-regulator.h>
+
     regulator {
         compatible = "mediatek,mt6358-regulator";
 
@@ -84,6 +109,8 @@ examples:
             regulator-max-microvolt = <900000>;
             regulator-ramp-delay = <6250>;
             regulator-enable-ramp-delay = <200>;
+            regulator-allowed-modes = <MT6397_BUCK_MODE_AUTO
+                                       MT6397_BUCK_MODE_FORCE_PWM>;
         };
 
         ldo_vsram_gpu {
-- 
2.42.0.582.g8ccd20d70d-goog

