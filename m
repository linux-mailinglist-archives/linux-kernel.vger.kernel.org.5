Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D60A81102C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 12:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378396AbjLMLdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 06:33:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377733AbjLMLdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 06:33:32 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF4012C
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 03:33:20 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2c9ebc04891so16179291fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 03:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1702467199; x=1703071999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nWX/zjp+iAoc0sTO0EE360u/fHh1vFE2puPVRvnlJSg=;
        b=QqJV3DhQ6ASn3wBywS585XZ8tatasBB+VWjS6bpB+Lh6xbLL+3fHeQ4ypAICs3Kban
         FCOvu1L9UZA+W26yp3rwLoe7IEypPJ0U09kxgk5Ei4MDYoGzFiTwocaTsQIXcnc0MCYY
         SjBqCMwGhi3ZW8bF77p+VsXsL9MtmKI4dLHIFjCYXMRsHOClhsgz7k7Q0kaOuDwaZZBG
         1gnCTVrouE2fsxLNeH2Zm7RV1qlzyltplavBz6aU+oEZDSGa6rM/EbWreC2GRX8dRi17
         +Y88FMIt2AFjhb12AzUDvWiHEV/1m+nVW/Joh8WUsbrnf3tJrQqUno5U6ymmmZdK7QxA
         eFtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702467199; x=1703071999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nWX/zjp+iAoc0sTO0EE360u/fHh1vFE2puPVRvnlJSg=;
        b=O4XFjw17WVV0Jr/MsIVU5Sqp62Ubovd1fQD1J8Sxn6kMqulG8ntxUtcFx1gnf/ZcCr
         H0zlG8/PhYVNfv9xZRHUyC4WcKXG2qwhXDavhV2wTg7CQVsljJiCzS0y3EH9T87kS5hE
         cxQh1ZHAHUBMg4Ab7dtnOI8Q6Yh8Tr+xikcBF9F0mpWJQIABoa+USr4Ir2mFosK8xRGm
         G1PNwAmDbbFeo0agDAeX52etkWFS8Xs6B+1isrbyHZTl7XV0GPmo5p07BA8F30nT28Ln
         Z5QIUdvpKHiiFabHVdfki89ry1fIKAwqSm/FrmtXFBSq+tMURJGZmcr+BCjs7g7F3h7h
         6omw==
X-Gm-Message-State: AOJu0YxU2HJXmsE3DBuxsJk2IptVgOJHIsqtBkHT+RNX9X79nwL+KE5E
        zkf21aHSNWyXLHfLwlxytf2b2Q==
X-Google-Smtp-Source: AGHT+IEuXYkwYCdXUnQRj5u26PSyylqZ1NgdfvKlwWU8/MoItLq0cyd9mcOkAanUk5MDzRp5gaQUuA==
X-Received: by 2002:a2e:918b:0:b0:2cb:2d8a:a28a with SMTP id f11-20020a2e918b000000b002cb2d8aa28amr5882241ljg.5.1702467199112;
        Wed, 13 Dec 2023 03:33:19 -0800 (PST)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:c564:f167:d072:5672])
        by smtp.gmail.com with ESMTPSA id m27-20020a05600c3b1b00b0040b38292253sm22433137wms.30.2023.12.13.03.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 03:33:18 -0800 (PST)
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To:     linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robbin Ehn <rehn@rivosinc.com>
Subject: [PATCH 6/9] dt-bindings: riscv: add Zacas ISA extension description
Date:   Wed, 13 Dec 2023 12:33:02 +0100
Message-ID: <20231213113308.133176-7-cleger@rivosinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231213113308.133176-1-cleger@rivosinc.com>
References: <20231213113308.133176-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add description for the Zacas ISA extension which was ratified recently.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 Documentation/devicetree/bindings/riscv/extensions.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index 912cc6a42eb4..264114fa943e 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -171,6 +171,12 @@ properties:
             memory types as ratified in the 20191213 version of the privileged
             ISA specification.
 
+        - const: zacas
+          description: |
+            The Zacas extension for Atomic Compare-and-Swap (CAS) instructions
+            is supported as ratified at commit 5059e0ca641c ("update to
+            ratified") of the riscv-zacas.
+
         - const: zam
           description: |
             The standard Zam extension for misaligned atomics is supported as
-- 
2.43.0

