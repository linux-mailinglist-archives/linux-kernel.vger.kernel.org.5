Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2BF07B16A9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 10:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbjI1I4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 04:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231506AbjI1I4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 04:56:18 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 892FB198
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 01:56:04 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-692c02adeefso7572925b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 01:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695891364; x=1696496164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8VUxLWLgQ80Pm3L1prBCg/hMI4tne1YjHqrpTBd8u2Q=;
        b=W/oSGHxU0Y+ACv009W1WQs6exmL8vRwYtpNbpjkyjCuvEvKg1UhhG9BO1D5+c+5Ea6
         2qm/zJzyS3BOfspONaJ6hcNJhKsDEHPj017woZJ/YReky8qbGAWYwnTKKPxKW3mKa3Ck
         Wg1NVpTAwW7UmtzNdSsXcLiNqfHjJp1KAyGus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695891364; x=1696496164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8VUxLWLgQ80Pm3L1prBCg/hMI4tne1YjHqrpTBd8u2Q=;
        b=HGzTIgifbqDXbU3EenumpW2qvaWwbbaOEii87hA3lP90DFPI+7E6MeJ9P/HjzH+CyR
         KvQ6SrMf/QkZiM5ZCycZ2xjvIrsF7noO6r0QdsVReqCDMwIFdCiZeYhQrpxv/GFCXvPB
         v47+oAoOJAaCXqEXej4Jn4tIQeQYmuOUWhLVNitKVaowFHGRBDF21TP5yJtrOfkidlRh
         eSJZrxRHHQbBiEs1AVX10pObtu3b3+8GChUL3rxOhipTd3ScFLJ2l43e+V1cH1z6ZLPH
         Yhs5+4DSw4WXWKhwNRLXRID4XgpJ+xQNHx7yXdBAmG4cUQZ4iAc0nokPh0iohXnXdud/
         B4YA==
X-Gm-Message-State: AOJu0Yxx4933oCG1XnPfS4GqgqYe7Ij4KpAwHbu4R8joxVq4MVci4hpc
        MRI2E9d2Z2fH4ptPvIRcF45a3g==
X-Google-Smtp-Source: AGHT+IHtrWewxnhjNB2afm44QHya+LkWPvHNgUDR7Ji3onSnvYMF6drgVnRdKj2wM7M/V1Ql8GZGLA==
X-Received: by 2002:a05:6a00:1381:b0:690:4362:7012 with SMTP id t1-20020a056a00138100b0069043627012mr612979pfg.28.1695891364006;
        Thu, 28 Sep 2023 01:56:04 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:6747:c12a:dbfd:2cc7])
        by smtp.gmail.com with ESMTPSA id y7-20020aa78047000000b006879493aca0sm1754016pfm.26.2023.09.28.01.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 01:56:03 -0700 (PDT)
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
Subject: [PATCH v4 04/12] regulator: dt-bindings: mt6358: Add regulator supplies
Date:   Thu, 28 Sep 2023 16:55:27 +0800
Message-ID: <20230928085537.3246669-5-wenst@chromium.org>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
In-Reply-To: <20230928085537.3246669-1-wenst@chromium.org>
References: <20230928085537.3246669-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
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
 .../regulator/mediatek,mt6358-regulator.yaml  | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/mediatek,mt6358-regulator.yaml b/Documentation/devicetree/bindings/regulator/mediatek,mt6358-regulator.yaml
index e8c3299d698f..f2219d8656c2 100644
--- a/Documentation/devicetree/bindings/regulator/mediatek,mt6358-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/mediatek,mt6358-regulator.yaml
@@ -34,6 +34,40 @@ properties:
       regulator-allowed-modes: false
     unevaluatedProperties: false
 
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
 
 patternProperties:
   "^buck_v(core|dram1|gpu|modem|pa|proc1[12]|s[12])$":
-- 
2.42.0.582.g8ccd20d70d-goog

