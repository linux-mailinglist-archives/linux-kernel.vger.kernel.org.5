Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDF647D1B78
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 09:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjJUHQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 03:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjJUHQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 03:16:28 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB5AD79;
        Sat, 21 Oct 2023 00:16:25 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9bf0ac97fdeso228634266b.2;
        Sat, 21 Oct 2023 00:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697872583; x=1698477383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=319tOWKiJxTmOU+nAUz609yxNAFpaNDWP/G7nIp2qzU=;
        b=i3ZgMJs7SRd58uk17jQYoyK3XIpmj4eha5pKpc8RKgzZiLpQUpAA+onu0H88M1BB33
         vosslIoVtnWilOssmowBv94ik7nXykn6xcz/x5O7ucV+IhFXBwsrVS3t9VkNggM06gRT
         gh0oiy6KEjW3sT5hHmgmlITOqh0zyodPD/KEWpXGPd/2r5yxxYMmJ6vwQWkHSCQNQNQT
         XuvHnrF9JjbJR5jzoydjnLH+kCrIE+TsAyk32LE56w6QrgjrZ4TLghIbx4GUsbMNUgHb
         VOX+rssSu5NOKPy1c7AHB3OG8D34sN1zRsP2N2gsTWnCvPbgi2zUvzW9BJulEGnY+92l
         4pAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697872583; x=1698477383;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=319tOWKiJxTmOU+nAUz609yxNAFpaNDWP/G7nIp2qzU=;
        b=Pq1G6FP1LOgV+pmaOXBkIUWZZmhtIv3Xq95buKEm+a0XSI7x7ftVaVbefzmV7RmZX1
         rW7zl/4bBvCESKkMa42fJCxC8Mh2XhKV1FOEG2XN5LFOY953lFVQO/fMIEM/eaYluBwX
         uumR2haNGsfXWua12n+WbrsVCNMGukxxBsBqe+4zLj+aODzHrIkNkpwajlqU88a0ZCcU
         JVIwgbGOjjHb5/JenP0Gb+I/burF5oellGYCZ2GOhsVH/i7CZ+zE3WsFltX8eO1F8AHW
         x2G4IGu4BofH3naiORZuh05CMuRvgtPFGc8J7NrcDg7tfRN7uz7JFEC4I4QFCstgCusq
         77kA==
X-Gm-Message-State: AOJu0YzuAJodXPmpfFab7+DeKVJ/5kRRYRXGlFTcEBahpO2Reycr6wg3
        A9KcFUAzQMSh/ZdbIVSHE1A=
X-Google-Smtp-Source: AGHT+IG39ADzdAQp/8lOcwMvnmWHY3WX5i0z7a25QTQrnwEW962Woy8xP2oOCPaDakreZrUU/rVAjg==
X-Received: by 2002:a17:907:31c5:b0:9c3:cefa:93c0 with SMTP id xf5-20020a17090731c500b009c3cefa93c0mr2732945ejb.38.1697872583289;
        Sat, 21 Oct 2023 00:16:23 -0700 (PDT)
Received: from david-ryuzu.fritz.box ([188.195.202.64])
        by smtp.googlemail.com with ESMTPSA id c11-20020a170906340b00b009be23a040cfsm2992035ejb.40.2023.10.21.00.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Oct 2023 00:16:22 -0700 (PDT)
From:   David Wronek <davidwronek@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        devicetree@vger.kernel.org, Joe Mason <buddyjojo06@outlook.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        David Wronek <davidwronek@gmail.com>
Subject: [PATCH] dt-bindings: arm: cpus: Add Qualcomm Kryo 465
Date:   Sat, 21 Oct 2023 09:16:19 +0200
Message-ID: <20231021071619.187374-1-davidwronek@gmail.com>
X-Mailer: git-send-email 2.42.0
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

Add a compatible for the Qualcomm Kryo 465 found in SM7125.

Signed-off-by: David Wronek <davidwronek@gmail.com>
---
 Documentation/devicetree/bindings/arm/cpus.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
index ad7fee0245fa..ffd526363fda 100644
--- a/Documentation/devicetree/bindings/arm/cpus.yaml
+++ b/Documentation/devicetree/bindings/arm/cpus.yaml
@@ -190,6 +190,7 @@ properties:
       - qcom,kryo280
       - qcom,kryo360
       - qcom,kryo385
+      - qcom,kryo465
       - qcom,kryo468
       - qcom,kryo485
       - qcom,kryo560
-- 
2.42.0

