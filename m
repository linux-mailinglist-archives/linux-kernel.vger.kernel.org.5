Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78BF7784B7D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 22:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbjHVUfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 16:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbjHVUfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 16:35:00 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9F7CEE
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 13:34:59 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-7909307ecd1so167943939f.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 13:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692736498; x=1693341298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IAoCNyZqfvnfH/0/0Sp/bNbHBZV5FWrs/u1Wpi/L2lY=;
        b=LT5Eqx/qlnBPzXAqQIgggqVZHv+YCKJ+0iWbylurX1QFNVV18FyFBIyuIoD9FU/0eg
         0JUuimV6sFdex20VLm+bcsgHJ+a542gNwqwX/Kwr6lWylmlmK92K8pIIXEi6OlaEv7au
         a/wps5s1f+rdlw80rXaimfr2ZjQyq39JTggvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692736498; x=1693341298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IAoCNyZqfvnfH/0/0Sp/bNbHBZV5FWrs/u1Wpi/L2lY=;
        b=jdQ2xWWKO7eWVNlvQwXS120+4IrDt8VI2dlfX6zUTGekhgv6d4f/nwQe/oZGVgdOP9
         ae7u03AG/TR5V3Zf3r3lukKSEDnF1PYisxmuB38F8/eJpn/0dGFVHZt4J1lhUo72blGP
         b/c8clkCAbUh78h3UQfz1bwlH9ogzIjTvQMLb6GHpbXcx+R6UwTQI7RJzrPhDAjEvZND
         1qTbGOXSfeDIovob51E8Bmu20nE2kGMYh3qN7lMRyR6XOb0gKiFCeX2O8+v6y0Nbk7Rv
         9Tm+k/3KLJ9OZbE9jj5/LBMGaJMlt7ipalHs/fQdUBLmy4yDIg1+dFGe1jnj8xpCHEAL
         afRA==
X-Gm-Message-State: AOJu0Yzumu+hjmdz3+1P8wqIKPWWhtjO8a6ZIp0DEuxklBI9rhBWWQZi
        fIAPkxAm5DbVJlCYmWULuKytGg==
X-Google-Smtp-Source: AGHT+IGrtcKkLUDbfM2/xR8cobFWMcEKBMWgBL9b5Nhq1+ovWu1dKbVkA9ITN/X9uDBnaMJz55KHKg==
X-Received: by 2002:a6b:dd08:0:b0:783:3899:e1d0 with SMTP id f8-20020a6bdd08000000b007833899e1d0mr1007976ioc.6.1692736498725;
        Tue, 22 Aug 2023 13:34:58 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:b7f:10f7:eb5:da54])
        by smtp.gmail.com with ESMTPSA id s20-20020a5eaa14000000b0078754bed499sm3500745ioe.37.2023.08.22.13.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 13:34:57 -0700 (PDT)
From:   Simon Glass <sjg@chromium.org>
To:     devicetree@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        Chiu Chasel <chasel.chiu@intel.com>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Gua Guo <gua.guo@intel.com>, linux-acpi@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        Yunhui Cui <cuiyunhui@bytedance.com>,
        ron minnich <rminnich@gmail.com>,
        Tom Rini <trini@konsulko.com>,
        Lean Sheng Tan <sheng.tan@9elements.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 2/2] memory: Add ECC property
Date:   Tue, 22 Aug 2023 14:34:43 -0600
Message-ID: <20230822203446.4111742-2-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230822203446.4111742-1-sjg@chromium.org>
References: <20230822203446.4111742-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some memories provides ECC correction. For software which wants to check
memory, it is helpful to see which regions provide this feature.

Add this as a property of the /memory nodes, since it presumably follows
the hardware-level memory system.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Add new patch to update the /memory nodes

 dtschema/schemas/memory.yaml | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/dtschema/schemas/memory.yaml b/dtschema/schemas/memory.yaml
index 1d74410..981af04 100644
--- a/dtschema/schemas/memory.yaml
+++ b/dtschema/schemas/memory.yaml
@@ -34,7 +34,14 @@ patternProperties:
         description:
           For the purpose of identification, each NUMA node is associated with
           a unique token known as a node id.
-
+      attr:
+        $ref: /schemas/types.yaml#/definitions/string-array
+        description: |
+          Attributes possessed by this memory region:
+
+            "single-bit-ecc" - supports single-bit ECC
+            "multi-bit-ecc" - supports multiple-bit ECC
+            "no-ecc" - non-ECC memory
 
     required:
       - device_type
-- 
2.42.0.rc1.204.g551eb34607-goog

