Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B79C783C06
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 10:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233971AbjHVIpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 04:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233958AbjHVIpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 04:45:44 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00CF3CE5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 01:45:40 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-68a4025b5e8so1563852b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 01:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692693940; x=1693298740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uWvqEYx7nigLStoTHfBNGDNnZRGlEQKlFX9KEKxxWao=;
        b=jZv7Hu3uyjMHvZQPJZuxOzNjrT44nxbUjsoA5wMpqxP3QTGgr5mvNpeRrAZlXVFI1O
         wjJnR3722qCjZYmkUdTqeAS3LQSGR/N+mgDw6oU5vf2UQsfQEbQ+8Mo5QAHXjek0D+4D
         +T0FFLVlm+5+pS+Qi2nVB5tZOW74+MqSDCjDM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692693940; x=1693298740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uWvqEYx7nigLStoTHfBNGDNnZRGlEQKlFX9KEKxxWao=;
        b=FVgMyIvO689ALmDmEJGbZsjFp/iH4Sa20zbCOA0z/eS1YOrFgSSd5zSeXvD6iz3sfX
         BjOfmS4mZzJ+DFeknW3CGrontkvQQRROyeeVsGa4OwJeNdF1HhxX46/MrBG1HSofdaPT
         VZ5/dpriUBJR52T4UpUfZBDYouaUw/U6A1+WzBLdm41ptx6i07O/16XzPM1ReynsSqfa
         3y0RF6svDqziGg0LnCiUrhXquDaMPt0nhb66xBZKRUdJoWlAlxKmT/bm2tEBTovIS5XO
         wLVkXbKCG7ASm6Yvyst3qsX6C+N4lGrlhxUQmaVIuElnwCC2vwWE4WdEuJB+4L4cvXao
         4G3Q==
X-Gm-Message-State: AOJu0Yy865yR8o5z6R3jj791l926ZxH6N6X5V4ug9ZM9QLitUuRBFnca
        C5M+7wW8lxVVtoOCH1TuO3gL7g==
X-Google-Smtp-Source: AGHT+IFb23fhs9Apos2oL1dgOhgh6KyRZEOAL6GURDoRrpRHDeYzqpoHYXqhuvJFd8+IVfDagjd+2Q==
X-Received: by 2002:a05:6a00:2190:b0:687:8417:ab51 with SMTP id h16-20020a056a00219000b006878417ab51mr7254197pfi.8.1692693940475;
        Tue, 22 Aug 2023 01:45:40 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:e619:3fa0:1a90:6bb0])
        by smtp.gmail.com with ESMTPSA id s26-20020aa78d5a000000b00666b012baedsm7304790pfe.158.2023.08.22.01.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 01:45:40 -0700 (PDT)
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
Subject: [PATCH v2 04/11] regulator: dt-bindings: mt6358: Add regulator supplies
Date:   Tue, 22 Aug 2023 16:45:12 +0800
Message-ID: <20230822084520.564937-5-wenst@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230822084520.564937-1-wenst@chromium.org>
References: <20230822084520.564937-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MT6358 PMIC has various regulator power supply pins that should be
supplied from external power sources or routed from one of its outputs.

Add these regulator supplies to the binding. The names are the actual
names from the datasheet, with hyphens replacing underscores.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 .../regulator/mediatek,mt6358-regulator.yaml  | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/mediatek,mt6358-regulator.yaml b/Documentation/devicetree/bindings/regulator/mediatek,mt6358-regulator.yaml
index 4d7924c5cc7d..82328fe17680 100644
--- a/Documentation/devicetree/bindings/regulator/mediatek,mt6358-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/mediatek,mt6358-regulator.yaml
@@ -18,6 +18,41 @@ properties:
   compatible:
     const: mediatek,mt6358-regulator
 
+  vsys-ldo1-supply:
+    description: Supply for LDOs vfe28, vxo22, vcn28, vaux18, vaud28, vsim1, vusb, vbif28
+  vsys-ldo2-supply:
+    description: Supply for LDOs vldo28, vio28, vmc, vmch, vsim2
+  vsys-ldo3-supply:
+    description: Supply for LDOs vcn33, vcama1, vcama2, vemc, vibr
+  vsys-vcore-supply:
+    description: Supply for buck regulator vcore
+  vsys-vdram1-supply:
+    description: Supply for buck regulator vdram1
+  vsys-vgpu-supply:
+    description: Supply for buck regulator vgpu
+  vsys-vmodem-supply:
+    description: Supply for buck regulator vmodem
+  vsys-vpa-supply:
+    description: Supply for buck regulator vpa
+  vsys-vproc11-supply:
+    description: Supply for buck regulator vproc11
+  vsys-vproc12-supply:
+    description: Supply for buck regulator vproc12
+  vsys-vs1-supply:
+    description: Supply for buck regulator vs1
+  vsys-vs2-supply:
+    description: Supply for buck regulator vs2
+  vs1-ldo1-supply:
+    description: Supply for LDOs vrf18, vefuse, vcn18, vcamio, vio18
+  vs2-ldo1-supply:
+    description: Supply for LDOs vdram2
+  vs2-ldo2-supply:
+    description: Supply for LDOs vrf12, va12
+  vs2-ldo3-supply:
+    description: Supply for LDOs vsram-gpu, vsram-others, vsram-proc11, vsram-proc12
+  vs2-ldo4-supply:
+    description: Supply for LDO vcamd
+
 patternProperties:
   "^buck_v(core|dram1|gpu|modem|pa|proc1[12]|s[12])$":
     description: Buck regulators
-- 
2.42.0.rc1.204.g551eb34607-goog

