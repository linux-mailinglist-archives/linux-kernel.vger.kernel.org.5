Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0E9B78594E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 15:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236048AbjHWN3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 09:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236034AbjHWN3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 09:29:00 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E91001718
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 06:28:38 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-99df11828c6so1386044666b.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 06:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692797288; x=1693402088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Po0Cjg3C1rN8c8fqj5mDXBBf8xDUIggifQYVVJsMcc=;
        b=xN6e9qtylN1hsXgdFmZHlmfpPXh9CNK0ozDyPU2d+sJ4qjh3xP0pdh5rYoiAyCQjMD
         tH4gcrZ4aIXIMcD+sqUlrhFt+E+I51sTMU3vZA08cmG3g06kdBhAwBydeFPWroy7q0VA
         vHiPiH31LkSCwzYchzd6pVhyfCeGKwngniF8LkwmiXJesJNtyXMh48+54vzmkyMjLzCh
         ddzefQkCL19hQ/kGtS79iVgcp2w8jQtA62yw/S4GjzQhhqPC/L5ag5by2Q+uAQP4iUZQ
         0acRKaPsNil7vuFnT2oioZrlK1C8j1ZlBhUdlo5RZkojX7W3j/iZj/RSuRAAitQ73/A6
         jOYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692797288; x=1693402088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Po0Cjg3C1rN8c8fqj5mDXBBf8xDUIggifQYVVJsMcc=;
        b=Yf15fh7RylwQaln0WWd2g0Crcc2m3LAudPDiXRlW+xOdotNoh71RZxq3+Vlt72Tiav
         rv85p5yjGbYdTkM3t1OH62nsA7vQAOCBVea8JsmbFSaVzJJXU87wfGIhO719BOonoTMB
         t2BlUWVTRZskvLYVoxXUkOY0p6ARaohzuwR2pZEz26iPN7GR6Vx0y5VQ2ZlW5j0FfLiY
         aE828aeDomAkob0c/iNsZw/a2G/RRe//8tRDGKqHQ4k7OjV0qlvYMJfFU/vRNOdOcsSM
         ZAsDncq6PSpjPgn0uUL7YEmhlCV1/NkaS7B9mzagfEbTYG4fLo3aR1Gytuqib9qzZMxn
         bxdg==
X-Gm-Message-State: AOJu0Ywlmm+hqkYnQYgO2hu4q2+ydDygyFvtrsz2fJOWWeRNYaT4+NDp
        a8spUInf/Da2DrxVHeYDMi5c3Q==
X-Google-Smtp-Source: AGHT+IFQ7ZBoWyGJnyM3wR4lxLwaABkyfmzPVWPn3nBb4dg6VizlcE8iOxa/J7RO80vb+lY4pMnJ1w==
X-Received: by 2002:a17:907:7e8c:b0:978:8979:c66c with SMTP id qb12-20020a1709077e8c00b009788979c66cmr14911646ejc.18.1692797288065;
        Wed, 23 Aug 2023 06:28:08 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id l9-20020a1709066b8900b009a168ab6ee2sm8918202ejr.164.2023.08.23.06.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 06:28:06 -0700 (PDT)
From:   srinivas.kandagatla@linaro.org
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Richard Alpe <richard@bit42.se>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 11/22] dt-bindings: nvmem: Add t1023-sfp efuse support
Date:   Wed, 23 Aug 2023 14:27:33 +0100
Message-Id: <20230823132744.350618-12-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230823132744.350618-1-srinivas.kandagatla@linaro.org>
References: <20230823132744.350618-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1459; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=1cjACcaM5mn9GzVS+HtF5Uwe7y7QX0kihzmbQYQS62s=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBk5glInAepEvWKb7vh4FKvdVRfiP0D5wqc7k8yt v6kpZT/VDSJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZOYJSAAKCRB6of1ZxzRV N7QVB/0ezBdfgJWvZpQ/zot4iPnkk73Ddyt95ZwNRtamOOXfYyEHxK3K4gDkRP14grK1gu1Z9GR aYnmN8IZLwdgFyvpG3hCtbDUp2gnaPFleZ6IU5mFFovGZHc7PEiMX94ZHGq3NlCKjqIEvM7QcPa /DonTSExcyit2t0eaGCqp/tJNyyoO1aK2R8zV1iV5c3owjEHjh5Qe+InD3KOsoNP7K++CDdS2Km V3Zea5UFRT0KeHeCmbgpOHx9unvl/uwuqbskHx5YeBTwT6Hv2t33naYHDrRRAoQpp/Xs84WdoYf afmE0HOmhwFvdxpyfcaOIIr99cmTONcNAq7UOk5aKb0nR+Mv
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Alpe <richard@bit42.se>

Add a schema for the NVMEM eFuse (SFP) layout on the NXP QorIQ SOC.

Signed-off-by: Richard Alpe <richard@bit42.se>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../bindings/nvmem/fsl,t1023-sfp.yaml         | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/fsl,t1023-sfp.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/fsl,t1023-sfp.yaml b/Documentation/devicetree/bindings/nvmem/fsl,t1023-sfp.yaml
new file mode 100644
index 000000000000..df826b40d8ca
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/fsl,t1023-sfp.yaml
@@ -0,0 +1,37 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/fsl,t1023-sfp.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP QorIQ eFuse support
+
+maintainers:
+  - Richard Alpe <richard@bit42.se>
+
+description:
+  Read support for the eFuses (SFP) on NXP QorIQ series SoC's.
+
+allOf:
+  - $ref: nvmem.yaml#
+
+properties:
+  compatible:
+    const: fsl,t1023-sfp
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    efuse@e8000 {
+        compatible = "fsl,t1023-sfp";
+        reg = <0xe8000 0x1000>;
+    };
+...
-- 
2.25.1

