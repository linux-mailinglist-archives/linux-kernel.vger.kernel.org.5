Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5665D7B7EBA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 14:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242296AbjJDMHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 08:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233212AbjJDMHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 08:07:38 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C30F0
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 05:07:35 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-53639fb0ba4so3624686a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 05:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1696421254; x=1697026054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DcpgkwL12FHEODFIbiIinUiJz0ey3tDqVJ4nMPpi9XQ=;
        b=V9RCFdlJxJPeN2qqsrEOkUbdbMF+s1l7AbJ8SVSHF1CpLqDU0jAn7W6yIBckYTOF+F
         j+MEGX1ENQFHf1Qt9oVU1/zSaKL5ZG+2tX/nWl1KbTMDLeKAN6kqLhmjuYajxEaBWWIb
         8XZ1ysD/dinxHrXCCqPTPkhm1Pcq1OPUslnholPy7j/W6E/B+EfqljJ5J+SqfvOQilfe
         O/3VGquhkIbKpC6kNeZ//kEDnEwdzuvRl9FiQ3gXr67QnccPAH1mhN1/WRgk2ABwWl1z
         69fsbmrq4oVfpFYXrfxcNe7wGrtMO0XHa8vkW2QcY/SWu+/CwOk6H2t8Upo3uqucjpcf
         ZPuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696421254; x=1697026054;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DcpgkwL12FHEODFIbiIinUiJz0ey3tDqVJ4nMPpi9XQ=;
        b=o78IqHIzXFwR6KXlfNP5aXw+d+mIlzC81YQ+g68h2oCyywZlnApa84sJqVXcaXyhnl
         Z7670i2L8M674cwxHkorDQMsiqWFvGYA6BrYNshg6jAXS8z/79zWw9BwrbxBbHT8iPJD
         6cjLq8oaNawtX+u+ZuIaj5NF+YTwI7bcXU23JXSwP8dSzSg8oq+u08COMK7FFJH+SJ49
         K/5kl5ai1HoEVgyOQ5xOy8pqC8ac16xLR2RHxB7vy45C38cUdHh4cBLw3pd2Gy+v+IlG
         AxfEvz3dpV+rz2MkBc7BQIAyKX3PIl6FG0wNICH8xL3yvOKEpDLb4C3/gycCNIE4hxxG
         BGuQ==
X-Gm-Message-State: AOJu0Yx16mVTugU9zgrgBnKL8FhCpOdq4q/aUN7pVGYQRtAL96efIKHJ
        I6IMd9z73EsOT+pYMAxUVofGTw==
X-Google-Smtp-Source: AGHT+IGQl+QJ56FDZS+Rm/TD4LkArvBTO1OLeqKs2GJ6Eeu1DmI7zlmFkJRsD3WjQIyjfsMQ/3eTzg==
X-Received: by 2002:aa7:c58f:0:b0:531:f4:57a8 with SMTP id g15-20020aa7c58f000000b0053100f457a8mr1872504edq.26.1696421253763;
        Wed, 04 Oct 2023 05:07:33 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id e6-20020aa7d7c6000000b005362bcc089csm2324665eds.67.2023.10.04.05.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 05:07:33 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
To:     broonie@kernel.org, zev@bewilderbeest.net,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Naresh Solanki <naresh.solanki@9elements.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: regulator: regulator-output: Multiple supplies
Date:   Wed,  4 Oct 2023 14:05:26 +0200
Message-ID: <20231004120529.1155700-1-naresh.solanki@9elements.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for multiple supplies.

Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
---
 .../devicetree/bindings/regulator/regulator-output.yaml  | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/regulator-output.yaml b/Documentation/devicetree/bindings/regulator/regulator-output.yaml
index 078b37a1a71a..6d077f123729 100644
--- a/Documentation/devicetree/bindings/regulator/regulator-output.yaml
+++ b/Documentation/devicetree/bindings/regulator/regulator-output.yaml
@@ -21,13 +21,13 @@ properties:
   compatible:
     const: regulator-output
 
-  vout-supply:
+patternProperties:
+  ".*-supply":
     description:
       Phandle of the regulator supplying the output.
 
 required:
   - compatible
-  - vout-supply
 
 additionalProperties: false
 
@@ -37,3 +37,8 @@ examples:
           compatible = "regulator-output";
           vout-supply = <&output_reg>;
       };
+      output1 {
+          compatible = "regulator-output";
+          sw0-supply = <&output_reg0>;
+          sw1-supply = <&output_reg2>;
+      };

base-commit: f9a1d31874c383f58bb4f89bfe79b764682cd026
-- 
2.41.0

