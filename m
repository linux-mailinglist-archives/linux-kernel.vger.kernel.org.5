Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF0EE7BC4B5
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 06:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343552AbjJGEgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 00:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343508AbjJGEgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 00:36:36 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE48BF;
        Fri,  6 Oct 2023 21:36:34 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-351365e47f6so10283805ab.1;
        Fri, 06 Oct 2023 21:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696653394; x=1697258194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xqdx5SQOCITW8sdpcW8PF7BxUYMoI+j3/zmoixXSHL0=;
        b=GtqQCo/4BLECe8n79YJPzmg3in94WNC3Pbg9Uz2rjGhPX6c3ZhdygynLkL6U94WSJR
         0edRWq5RxEp9iPaOCFKfntiPmnoLYV6dYwq8fXqazVE3uHVXrJIl9XwcCDmAqVnHgXGe
         xuL0tARwXMI5Wwfur6u/YVSbvFAEs53cq+l01iBkoQocAuTkqcEjfCHwgorDx3z9dhJy
         AKgG54GD1b5M3CMN+kO+rCzr4TnyWvU3mzwQ0gPA6IRtczf+uqDiSz3mZsur017GI4P5
         1bBfgNO+4qIkisomD0DPaYSyZqpAdcECTt2OEg9RScNHOJXH5sJgfife46zWFaNwTxof
         QtkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696653394; x=1697258194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xqdx5SQOCITW8sdpcW8PF7BxUYMoI+j3/zmoixXSHL0=;
        b=XsP7H87t2Wap/GQRr8B8tHUcdM9wgD1O87Abs1zYehHjK5dVDc3T7+YQMx6G9t6CIn
         L6GTC0xO9/DE0oZJJ69yka3qEwO08U0ZXdWo2gbTrzDdzCHxvlsuX0dDMrK7p1CxN3ZB
         kUHl7Y0NwCTgPLO5eQU6JCcV15EMXteAiRwUiTRp5TifX+jOkh32amKpzvNN5Ug6M1E0
         KSQcUmAZMYDMFCpwQhCi1/X+bXA0ZuFNjP8bjlSNxQ6tZO5azJJ+0G3d80XSsIajUwde
         VSW9/PXy3LDyqC6XqTWitm/dLLcwBlmi1EulE1PyOFae2dHJ8mGAkh94ryBcICaZrXaO
         Gc/w==
X-Gm-Message-State: AOJu0YxWEZc/9E6PUM7niw9y+S2mwn9jVMhl7r+oYjz74G5LdxvXFNA9
        hm79GFmFsnBH51L7IvAEUhE=
X-Google-Smtp-Source: AGHT+IEgSad7mZWzRlttOGMzT36e0pj1PjBfODX/XrtdM22WnJ1/PoeBLZ8ZbAp3GL42xtkMPIFIxA==
X-Received: by 2002:a92:1a46:0:b0:352:a73a:16f9 with SMTP id z6-20020a921a46000000b00352a73a16f9mr9210546ill.18.1696653393932;
        Fri, 06 Oct 2023 21:36:33 -0700 (PDT)
Received: from celestia.nettie.lan ([2001:470:42c4:101:8a60:ad5:1051:21e3])
        by smtp.gmail.com with ESMTPSA id x7-20020a92de07000000b0035129b9c61bsm1520910ilm.45.2023.10.06.21.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 21:36:33 -0700 (PDT)
From:   Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        =?UTF-8?q?Daniel=20Kukie=C5=82a?= <daniel@kukiela.pl>,
        Sven Rademakers <sven.rademakers@gmail.com>,
        Lokesh Poovaragan <loki@gimmeapis.com>,
        Sam Edwards <CFSworks@gmail.com>
Subject: [PATCH 1/3] dt-bindings: vendor-prefixes: add turing
Date:   Fri,  6 Oct 2023 22:35:58 -0600
Message-ID: <20231007043600.151908-2-CFSworks@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231007043600.151908-1-CFSworks@gmail.com>
References: <20231007043600.151908-1-CFSworks@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vendor prefix for Turing Machines, Inc.
(https://turingpi.com)

Signed-off-by: Sam Edwards <CFSworks@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 573578db9509..07f164e1ca2e 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1420,6 +1420,8 @@ patternProperties:
     description: Truly Semiconductors Limited
   "^tsd,.*":
     description: Theobroma Systems Design und Consulting GmbH
+  "^turing,.*":
+    description: Turing Machines, Inc.
   "^tyan,.*":
     description: Tyan Computer Corporation
   "^u-blox,.*":
-- 
2.41.0

