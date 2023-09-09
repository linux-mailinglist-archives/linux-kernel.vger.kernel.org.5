Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52706799A23
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 18:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235056AbjIIQ5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 12:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234339AbjIIQ5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 12:57:51 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B57A2BB;
        Sat,  9 Sep 2023 09:57:47 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-99cce6f7de2so377482766b.3;
        Sat, 09 Sep 2023 09:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694278666; x=1694883466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PLeaJCLz4aKF6pNRbZh3yUGqtlOqJYp5l8oD95FhXdw=;
        b=ds6hGbtg13rjV9nF5/LZKkvjQ3KZ/Ede7vkI9ln5ixtjJmK8tN45qHxlygNjJO2ybC
         mWYsfw3m///UOzOJY8szNeNX4aDzm4oh3pNKTboSCE1o0JWO31R+AGGfkz2A9K34IH9U
         Wcy7JmPrtH7CaAz3om5lIbzrkfZAubz1hN6bOHZKh1+wg8+Viv6Iy4UdsoxvG5eLGE+j
         1o/P29esf/O+fNIE0+2NApgJIYTurP+GQiMuR+YLw3YxMm244K5l+svvphAnGzPNH0pf
         /xab+iFYZYqO80LlKE1LoNEoVNhuefOA1LRk6p9Yezgu1JyPMK+aMQsvLxSKZLmysnYD
         Kcqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694278666; x=1694883466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PLeaJCLz4aKF6pNRbZh3yUGqtlOqJYp5l8oD95FhXdw=;
        b=YuTISG1m5u3ynRm0VdyJhhBwWj4eKS81ayqFAuzqMkxHIIboeeso5DNN2ZW95NKMts
         pOiVWGvc6CUzLBvQAoP/fascVJrE84GUK9xKVzn8MEecwqC1sNYIYfpueTcyVl/3VdZK
         BYML38skLEeXfNJ/lhYszuHTDAN788JZdck1QhS/9A4P1D3ESCqxRVIah1JAsVvNsqLu
         Rq9cMDLVhp6T9XeVeYVC/1NhxzrrzzRNl+13qeEAmKzycaRI3arhAztyqWCXj9wImBVx
         vhXjW1/ZuSEgnBOiaocKQyChCvzVSlQHpwy4EUfxoc4t2FDXrUxCINcrtzow699/Gsq0
         Mznw==
X-Gm-Message-State: AOJu0YxBJOWpyIiZCb9GkLRtuOdi+FUgyVfjB595Y7xvtW4/+D9yr470
        FJuFLP5uUYD8eE7WDxSm6Kg=
X-Google-Smtp-Source: AGHT+IEeKBpNtb0BYe7+yHxJ7qJTJfLFiOE1wljDqDsJRdeAlSnIxJalgx9x0M3wwmyrZoSbc+vPhg==
X-Received: by 2002:a17:906:7684:b0:9a1:d29c:6a9d with SMTP id o4-20020a170906768400b009a1d29c6a9dmr4518449ejm.46.1694278665854;
        Sat, 09 Sep 2023 09:57:45 -0700 (PDT)
Received: from fedora.. (dh207-96-186.xnet.hr. [88.207.96.186])
        by smtp.googlemail.com with ESMTPSA id si16-20020a170906ced000b00993470682e5sm2569357ejb.32.2023.09.09.09.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Sep 2023 09:57:45 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     ilia.lin@kernel.org, vireshk@kernel.org, nm@ti.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        rafael@kernel.org, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, dmitry.baryshkov@linaro.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        Robert Marko <robimarko@gmail.com>
Subject: [PATCH v3 2/3] dt-bindings: opp: opp-v2-kryo-cpu: Document named opp-microvolt property
Date:   Sat,  9 Sep 2023 18:56:01 +0200
Message-ID: <20230909165739.1036263-2-robimarko@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230909165739.1036263-1-robimarko@gmail.com>
References: <20230909165739.1036263-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Marangi <ansuelsmth@gmail.com>

Document named opp-microvolt property for opp-v2-kryo-cpu schema.
This property is used to declare multiple voltage ranges selected on the
different values read from efuses. The selection is done based on the
speed pvs values and the named opp-microvolt property is selected by the
qcom-cpufreq-nvmem driver.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 .../bindings/opp/opp-v2-kryo-cpu.yaml         | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml b/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
index bbbad31ae4ca..6f216306a7eb 100644
--- a/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
+++ b/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
@@ -63,6 +63,12 @@ patternProperties:
           5:  MSM8996SG, speedbin 1
           6:  MSM8996SG, speedbin 2
           7-31:  unused
+
+          Bitmap for IPQ806X SoC:
+          0:  IPQ8062
+          1:  IPQ8064/IPQ8066/IPQ8068
+          2:  IPQ8065/IPQ8069
+          3-31:  unused
         enum: [0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7,
                0x9, 0xd, 0xe, 0xf,
                0x10, 0x20, 0x30, 0x70]
@@ -71,6 +77,24 @@ patternProperties:
 
       required-opps: true
 
+    patternProperties:
+      '^opp-microvolt-speed[0-9]+-pvs[0-9]+$':
+        description: |
+          Named opp-microvolt property following the same generic
+          binding for named opp-microvolt.
+
+          The correct voltage range is selected based on the values
+          in the efuse for the speed and the pvs.
+
+          The qcom-cpufreq-nvmem driver will read all these values
+          and assign the correct named property.
+        $ref: /schemas/types.yaml#/definitions/uint32-matrix
+        minItems: 1
+        maxItems: 8   # Should be enough regulators
+        items:
+          minItems: 1
+          maxItems: 3
+
     required:
       - opp-hz
 
@@ -256,6 +280,22 @@ examples:
             };
         };
 
+        /* Dummy opp table to give example for named opp-microvolt */
+        opp-table-2 {
+            compatible = "operating-points-v2-kryo-cpu";
+            nvmem-cells = <&speedbin_efuse>;
+
+            opp-384000000 {
+                opp-hz = /bits/ 64 <384000000>;
+                opp-microvolt-speed0-pvs0 = <1000000 950000 1050000>;
+                opp-microvolt-speed0-pvs1 = <925000 878750 971250>;
+                opp-microvolt-speed0-pvs2 = <875000 831250 918750>;
+                opp-microvolt-speed0-pvs3 = <800000 760000 840000>;
+                opp-supported-hw = <0x7>;
+                clock-latency-ns = <100000>;
+            };
+        };
+
         smem {
             compatible = "qcom,smem";
             memory-region = <&smem_mem>;
-- 
2.41.0

