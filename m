Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E21A67CAE57
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 17:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233948AbjJPP4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 11:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233952AbjJPPz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 11:55:57 -0400
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58EAA109;
        Mon, 16 Oct 2023 08:55:54 -0700 (PDT)
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6c665b2469dso3181022a34.0;
        Mon, 16 Oct 2023 08:55:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697471753; x=1698076553;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bYqTlxzJpgPZHi0SFQeGZeZ+UqJkgDA/Fe8BpwAySnI=;
        b=LeRqlsXFavZF/pAgOwuOwgFtG2IZZ5wRQ/ZHB/78Eo/j7URCy6yy8P3YcIEomdLFkQ
         R0gmmScS3djnixodnRzq5eFsnbrLPHjXx6V/TXg2Lp2xidEqys5bQCN2J7oYLms3aBZn
         yvJGoxP4D5iSfZKvK1cXY5QuPs+gnLzT+9RtHn0d0cZkvM7qrtI+V/f7u9RHSBiqmm7k
         OvzKFjMRhP5/Gvbt0ctS0l/HLvKvZm/cXsT6mj7dOUa2wwGnFnmPCzZ5KSMiMafxV1Qk
         gpdVrMh85x0jiu6KCoVy790jSUkzjZu+/pe3MUH61oaiS656fBxb+MiJEGPGGyFPmyz0
         fbtw==
X-Gm-Message-State: AOJu0YxvjRTxFRh5KiNAZBp8DEZhdRQotJaPXU4WeDA3ZZgFx+u4c6Je
        36S1ujtA9ouXqCuR18oydA==
X-Google-Smtp-Source: AGHT+IEYO0DVPg5dp2+bVEWXMrPE9XhLRSLjbH9Y4SXF1r+s0lXGRz4Tf3jf1v0cAjqE7L7uP7K+Gw==
X-Received: by 2002:a9d:74d9:0:b0:6b8:7eef:a236 with SMTP id a25-20020a9d74d9000000b006b87eefa236mr36034676otl.30.1697471753539;
        Mon, 16 Oct 2023 08:55:53 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q6-20020a9d4b06000000b006b89dafb721sm1726248otf.78.2023.10.16.08.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 08:55:52 -0700 (PDT)
Received: (nullmailer pid 2973998 invoked by uid 1000);
        Mon, 16 Oct 2023 15:55:51 -0000
From:   Rob Herring <robh@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Beer <daniel.beer@igorinstitute.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: dt-bindings: tas5805m: Disallow undefined properties
Date:   Mon, 16 Oct 2023 10:55:47 -0500
Message-ID: <20231016155547.2973853-1-robh@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Device specific bindings should not allow undefined properties. This is
accomplished in json-schema with 'additionalProperties: false'.

Examples should be last in the schema, so move additionalProperties up
while we're here.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/sound/tas5805m.yaml | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/tas5805m.yaml b/Documentation/devicetree/bindings/sound/tas5805m.yaml
index 63edf52f061c..12c41974274e 100644
--- a/Documentation/devicetree/bindings/sound/tas5805m.yaml
+++ b/Documentation/devicetree/bindings/sound/tas5805m.yaml
@@ -37,6 +37,8 @@ properties:
       generated from TI's PPC3 tool.
     $ref: /schemas/types.yaml#/definitions/string
 
+additionalProperties: false
+
 examples:
   - |
     i2c {
@@ -52,5 +54,4 @@ examples:
                 ti,dsp-config-name = "mono_pbtl_48khz";
         };
     };
-
-additionalProperties: true
+...
-- 
2.42.0

