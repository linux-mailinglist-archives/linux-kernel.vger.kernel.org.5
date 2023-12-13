Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06D4F811813
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 16:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442322AbjLMPrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 10:47:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235439AbjLMPr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 10:47:26 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06DB110;
        Wed, 13 Dec 2023 07:47:32 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-50bf26b677dso6803007e87.2;
        Wed, 13 Dec 2023 07:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702482451; x=1703087251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xIWhGTiO6IreVCPqf6sdV9Yh0S4ilyzxwc53Fb/1j7o=;
        b=FMCToy1l3eYm8kJEgewCav4UsOch2bhO1sPZnDTF0Xhs/zODL894bQIXrd9h4+Ti3B
         NuDKPyzrjRP9gxFpoBlhdcMMMEEyK6bh63OZRwfF/KN83CX2fscZDEWaVfh6AOft3eMI
         2Vc+byFcr6p38P3jOd/4hUXzJcY9snCK9GXnD/qTQdCzJ24eQ80rRaJCe1Q9945NnZm4
         FeTCbADxbm2l3+0X1DlXVlkhCFrt0N1DEXsmRhvrUcwvS5emW0r2wURe5z3Amzms2E2q
         Zd4gpDkCe9HnTK9Xz6F6EtSpq0mfyvLDDcxrz93F/s7rrrtsJSlvAK5SzZJeeDLl0ml6
         ZB2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702482451; x=1703087251;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xIWhGTiO6IreVCPqf6sdV9Yh0S4ilyzxwc53Fb/1j7o=;
        b=b0viB8b4Yfg72ShhRzHei08uxRqz1Lf0RurXnf4nPdvI70G9/YrOFJJtjtQbk1LiWi
         DiGe0KaT6lx1LN7tiroefUVNKNN1NKRdnGhRSBcL3iPQ6mIOevY/TjAqzOfTRM6cGlDR
         pKlPbwp03X562nJm/hGmlb9Gn93vya574D+z/QvYFSbAUUE0Bp6cKvoRXqkMGr27MVUt
         Q8/XJC8oG/0xRa4CwTlKzwJds1BGrydCjN+Rc3IBY3hGtuY/mxOnTJgII5c4NKMENELR
         sFMqFcEOeiCbvbfehv8G5mdRrghFxO4kdZH3UoT+FT/w53HO9e6fRmc516+Oq0dKOGqV
         k7mg==
X-Gm-Message-State: AOJu0YzLS2viuzYZoGoDsZ+1H7u7/8sCaYbpEsLgVn4DUOzqvzW14i9g
        JJeleUQkSE3I5xvhgtvkIiY=
X-Google-Smtp-Source: AGHT+IFrMT+u8qQaDQTwx3+NlXxfeelFAxVsphLHBdElGrEIev2ru44NUGDr5dvFrt6ZhLh5ybjxdg==
X-Received: by 2002:a05:6512:ea3:b0:50b:fc06:7a2b with SMTP id bi35-20020a0565120ea300b0050bfc067a2bmr2974785lfb.110.1702482450523;
        Wed, 13 Dec 2023 07:47:30 -0800 (PST)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id 28-20020a508e5c000000b0054b686e5b3bsm5972810edx.68.2023.12.13.07.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 07:47:30 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH 1/2] dt-bindings: nvmem: add "data-size" property
Date:   Wed, 13 Dec 2023 16:47:20 +0100
Message-Id: <20231213154721.5037-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

Allow specifying NVMEM device content size in case it differs from
device total size.

Cc: Christian Marangi <ansuelsmth@gmail.com>
Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 Documentation/devicetree/bindings/nvmem/nvmem.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/nvmem/nvmem.yaml b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
index 4fd015d402ce..095aed4250de 100644
--- a/Documentation/devicetree/bindings/nvmem/nvmem.yaml
+++ b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
@@ -26,6 +26,13 @@ properties:
   "#size-cells":
     const: 1
 
+  data-size:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      NVMEM device actual data (content) size. It may be need to be specified
+      if it differs by design from the total NVMEM device size and it's
+      impossible to determine it on runtime.
+
   read-only:
     $ref: /schemas/types.yaml#/definitions/flag
     description:
-- 
2.35.3

