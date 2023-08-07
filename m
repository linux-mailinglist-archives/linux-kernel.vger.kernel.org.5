Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D74F7727E7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 16:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234412AbjHGOfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 10:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234091AbjHGOfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 10:35:39 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 713AF10E5;
        Mon,  7 Aug 2023 07:35:36 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-99c47ef365cso689491366b.0;
        Mon, 07 Aug 2023 07:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691418935; x=1692023735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=asTM4rKFSzp+icJaUkDK1RLj/Utx4x2PWtAP4aO5Afg=;
        b=hoJl9W9qSFU+nbBgkpjrBd7pg3z2yqFs/Sgdljv3EEXWkXxBFMd9YqhpbR1K/+gbtT
         mFsK0CopCClhN2AaPqDAp+ZjOOsIEca6KuBq8qZIh/b+wSD8UT857URmRODNU1Nja+T2
         fIa5zlxYOk30k7EizulVFt+7ZU/kJryvT54jOlPWZnHAmN1tkLRsOE7s32Egk4ZwCorV
         FX54PCIMZeoD57Y1zpd4LnKbhqTH0gR2RHCSVDoN5q+4JbbxxkdxKwCrnhQHfcsc9Ryo
         ihfkVPkgJfUNECsilJHguDxAvt69YfWaCX80fsuam6SIyIBs0N3OYIPC91Vfhlax1UlX
         NUXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691418935; x=1692023735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=asTM4rKFSzp+icJaUkDK1RLj/Utx4x2PWtAP4aO5Afg=;
        b=RME9DpNYSQFTB8lrKWitWzyuXSfjwT/ikpMUuwYdPzJEsH3mvjNYXLOQ2RtAqD0EqW
         HKyknZf0AtuuTFtzxi/2FOqjy3fUrAFK5wKLpvwkYjk1OCpMfsloMJBPjhHQraGKEzQZ
         M04E/TeBFZXwlnwAOfxl8pHkzJF1wsbZfxkR8fnwjAI7hfX/zXA3inz1DZx03vBtEXq5
         +QEmUeM5Ic1jma3nN8dsNZN+Z4mX5cO/3GNliATAyUJCvNgXIdZttgngiAMMcbJ+725V
         Ds9OYruMX3BG+pN/raSFYHOZxVVK+PStl5c4+v4pRnvJUKeTJBef2TnP2idxKR2KmNm4
         YkrA==
X-Gm-Message-State: AOJu0YxDhnwKsr64CBmtK7dz+9WCXtBwuQ+IdxrUmzDv4tfWcsP782PZ
        w8Qle+MS+Q0ogVrVTUlwmHs=
X-Google-Smtp-Source: AGHT+IEnSoGoSBbAkGwZZ6QVhfXEkQngtjQdyaY+wAvqyNycQ2LNqaPQeBes0NVHHROa9A2oaaJDUQ==
X-Received: by 2002:a17:906:76d4:b0:99c:75f7:19c1 with SMTP id q20-20020a17090676d400b0099c75f719c1mr7516516ejn.39.1691418934744;
        Mon, 07 Aug 2023 07:35:34 -0700 (PDT)
Received: from xeon.. ([188.163.112.48])
        by smtp.gmail.com with ESMTPSA id e3-20020a170906504300b0099329b3ab67sm5323292ejk.71.2023.08.07.07.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 07:35:34 -0700 (PDT)
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/5] dt-bindings: display: tegra: nvidia,tegra20-hdmi: Add HDMI output port node
Date:   Mon,  7 Aug 2023 17:35:13 +0300
Message-Id: <20230807143515.7882-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230807143515.7882-1-clamor95@gmail.com>
References: <20230807143515.7882-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxim Schwalm <maxim.schwalm@gmail.com>

Either this node, which is optional, or the nvidia,panel property can be
present.

Signed-off-by: Maxim Schwalm <maxim.schwalm@gmail.com>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 .../display/tegra/nvidia,tegra20-hdmi.yaml    | 32 +++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-hdmi.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-hdmi.yaml
index f77197e4869f..f8292551b9c8 100644
--- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-hdmi.yaml
+++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-hdmi.yaml
@@ -82,9 +82,39 @@ properties:
     description: phandle of a display panel
     $ref: /schemas/types.yaml#/definitions/phandle
 
+  port:
+    description: HDMI output port
+    $ref: /schemas/graph.yaml#/properties/port
+
   "#sound-dai-cells":
     const: 0
 
+anyOf:
+  - if:
+      not:
+        properties:
+          nvidia,panel: false
+    then:
+      not:
+        properties:
+          port: true
+  - if:
+      not:
+        properties:
+          port: false
+    then:
+      not:
+        properties:
+          nvidia,panel: true
+
+if:
+  properties:
+    port: false
+then:
+  required:
+    - nvidia,ddc-i2c-bus
+    - nvidia,hpd-gpio
+
 additionalProperties: false
 
 required:
@@ -97,8 +127,6 @@ required:
   - reset-names
   - pll-supply
   - vdd-supply
-  - nvidia,ddc-i2c-bus
-  - nvidia,hpd-gpio
 
 examples:
   - |
-- 
2.39.2

