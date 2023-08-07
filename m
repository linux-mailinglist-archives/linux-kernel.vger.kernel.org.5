Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07D977727EA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 16:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234731AbjHGOf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 10:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234092AbjHGOfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 10:35:39 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FBD310DC;
        Mon,  7 Aug 2023 07:35:35 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-986d8332f50so628620466b.0;
        Mon, 07 Aug 2023 07:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691418934; x=1692023734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ZvPUmeI/1EMGUSu/xpT/NIbYPZbxTYJRvOXwkEg1y4=;
        b=nx3VdgiKuT2WAB9KWAoKXJPbURnaLo0c7g2k8OCRZ8JX+DDucBlkvE79w7wqREmoAv
         5m7FMByQLnWy4CKH1Dv4uJlEb3ClC3MUvCJCJzVOELztu8Bwb8UvEnYwfynQk/JUNYSx
         +MS/6zWN36ApBG3RZEbKdTwu3whwBIpZDKUFQpIUwgJBVeslLFD0WUa2KIR4gjIZl0AR
         31Tjy5cxqNBWmZjIo90FvvCkObwmUMp2i/HPzTAGn9i021AaopRAcOp1bHgvGI7+UelC
         FTRsHz8dxGIa9J04nv8A/KMFn9WutCosf0k7vXOoVhhYkk8k4Kd+RcEaQUl3NQ63Oe8z
         EwyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691418934; x=1692023734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ZvPUmeI/1EMGUSu/xpT/NIbYPZbxTYJRvOXwkEg1y4=;
        b=EKb8WFtT3EhYXvtgAQ4cPG2sh6KjF+5T7lqNSsDTxVlNpH66qV1XJbzy8j8w7eB2Yd
         Xq6kif49UGJVSiZQx5P090j/oIR+lQK0SH1m4sNIDeeI/xCCXNJHAD4xFHo0YC50RMZb
         VwIU+xtpSOWYCqL4FZ4jK8dDq0IB3L+RSW88KuPiGrk9Z7B7Oa/iSMR8pkzkl8xFGaDA
         OqhlSwUckPkcg0xW8UgpKGv1ejJXMxKlmUo0q2rPht7ezidzHq0Pqc8j9LS17+3/ULlY
         UMWiy/Cp1U5dtES8QWAJmOQhTEDAePYsoSTN2g96RSDvfGBKGAA6q/7cPfSmSO5z3q5M
         +7lQ==
X-Gm-Message-State: AOJu0YxHxJcXa7oACUedlQbAgH0Op523ckHVlepmNLEhVloKW0MBsabg
        01YucjW6iew2ed+6INx5hHg=
X-Google-Smtp-Source: AGHT+IFieJ8bZzt1TPzOApOQ7/Q2X9S0DhUWYiPxMLc7XZT0uMY2JEoLmpSSXlAl5GIQWxhXlFs4wA==
X-Received: by 2002:a17:907:b09:b0:99c:5707:f458 with SMTP id h9-20020a1709070b0900b0099c5707f458mr6661271ejl.72.1691418933549;
        Mon, 07 Aug 2023 07:35:33 -0700 (PDT)
Received: from xeon.. ([188.163.112.48])
        by smtp.gmail.com with ESMTPSA id e3-20020a170906504300b0099329b3ab67sm5323292ejk.71.2023.08.07.07.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 07:35:33 -0700 (PDT)
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
Subject: [PATCH v3 2/5] dt-bindings: display: tegra: nvidia,tegra20-dc: Add parallel RGB output port node
Date:   Mon,  7 Aug 2023 17:35:12 +0300
Message-Id: <20230807143515.7882-3-clamor95@gmail.com>
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
 .../display/tegra/nvidia,tegra20-dc.yaml      | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dc.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dc.yaml
index 69be95afd562..102304703062 100644
--- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dc.yaml
+++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dc.yaml
@@ -127,6 +127,37 @@ allOf:
               $ref: /schemas/types.yaml#/definitions/phandle
               description: phandle of a display panel
 
+            port:
+              $ref: /schemas/graph.yaml#/$defs/port-base
+              description: Parallel RGB output port
+
+              properties:
+                endpoint:
+                  $ref: /schemas/media/video-interfaces.yaml#
+                  unevaluatedProperties: false
+
+              unevaluatedProperties: false
+
+          anyOf:
+            - if:
+                not:
+                  properties:
+                    nvidia,panel: false
+              then:
+                not:
+                  properties:
+                    port: true
+            - if:
+                not:
+                  properties:
+                    port: false
+              then:
+                not:
+                  properties:
+                    nvidia,panel: true
+
+          additionalProperties: false
+
   - if:
       properties:
         compatible:
-- 
2.39.2

