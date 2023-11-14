Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0487A7EB1EB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 15:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233499AbjKNOOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 09:14:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233430AbjKNOOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 09:14:18 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD08719B3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 06:13:54 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3b2d9a9c824so804155b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 06:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1699971234; x=1700576034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mh7tTRDZwkplFE7US+z6W8VzyVO8RyK0Ie0Y8NEIF5E=;
        b=PEZcIcbGBEo0y6V1wpVuwE5qZ//Zpnf17+QQWQXOKXcMgcplY7Kjgy3qPrQjcRoyYd
         T0VTgtpfcdB4sortegvMrdXTWeCJn26Boaf92ufEHtigFmu0RPdmEMZdDwp+0J25IAxQ
         w05qf/8a7wIgilGEkQNqd5TPU/E720kcCIjLKOfY6eSDRdtE2f2kGI4sgBhkyf6KORB1
         NR5zzPObND2Cq4hc/UpxTCQqdWiHdQLvFNeXinpiLUVo+uR5KQzkcE6xqsh6hObzVHgE
         bJR5zZQXWU49fxe2Coa7uo9SZFwd54YkP/LZ+wQugBMkdIssWRK/GrD6NogoxMyrtl8a
         idUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699971234; x=1700576034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mh7tTRDZwkplFE7US+z6W8VzyVO8RyK0Ie0Y8NEIF5E=;
        b=Gl6kqD9vsluIirJ0atPlp4sCwu4S+LnzFX824RpJDKPXG4sK1IB4+o8z0BVkVRY3Lp
         11cW2qw5mru58a6W/iWVKETRHMJU0TOJsxsKDL3CfkRXhaa+pJwioFAZyYxolLos1vZQ
         ECxadWYMss+xRx0IUc/6mnd86e9gpqdW/3oIGkoVnn6o80J5/yaVwHrKLr61ZgVNDCTE
         53ErT8XBAOMoDw723qqcOIFtTIIIKWKTPCsl6W0+oWAhSOvnviw44xsmSBf36/ZLj2uH
         h1PC22MynyeIIxDzIGWj6uXdBT95UanUl6N8dAKluzj5N8Z7No+C5LjCO050OJNTqS/g
         BHNQ==
X-Gm-Message-State: AOJu0YxDbdW6akV4aXY12IDTRswWp+LiO1oCpQ+rU4KnTbKc6+cIfmHf
        InZssIgiKvXlugTD527nCZWiaA==
X-Google-Smtp-Source: AGHT+IGkxt/nZ/twmuaXiKz9xS1+QSbiEolPjI0eAyguNp2BxYnPRpCdPEUVfljS4ZnrA7PBhdlykg==
X-Received: by 2002:a05:6808:1a2a:b0:3b5:65c2:fef4 with SMTP id bk42-20020a0568081a2a00b003b565c2fef4mr2571171oib.5.1699971229027;
        Tue, 14 Nov 2023 06:13:49 -0800 (PST)
Received: from carbon-x1.. ([12.186.190.2])
        by smtp.gmail.com with ESMTPSA id m2-20020a05620a220200b00777611164c5sm2701263qkh.106.2023.11.14.06.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 06:13:48 -0800 (PST)
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Jones <ajones@ventanamicro.com>,
        Evan Green <evan@rivosinc.com>,
        Conor Dooley <conor@kernel.org>,
        Samuel Ortiz <sameo@rivosinc.com>,
        Jerry Shih <jerry.shih@sifive.com>
Subject: [PATCH v4 13/20] riscv: hwprobe: export Zhintntl ISA extension
Date:   Tue, 14 Nov 2023 09:12:49 -0500
Message-ID: <20231114141256.126749-14-cleger@rivosinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231114141256.126749-1-cleger@rivosinc.com>
References: <20231114141256.126749-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export Zihintntl extension[1] through hwprobe.

Link: https://drive.google.com/file/d/13_wsN8YmRfH8YWysFyTX-DjTkCnBd9hj/view [1]
Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Evan Green <evan@rivosinc.com>
---
 Documentation/arch/riscv/hwprobe.rst  | 3 +++
 arch/riscv/include/uapi/asm/hwprobe.h | 1 +
 arch/riscv/kernel/sys_riscv.c         | 1 +
 3 files changed, 5 insertions(+)

diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
index 397d53195f49..aa8ebeeddfe6 100644
--- a/Documentation/arch/riscv/hwprobe.rst
+++ b/Documentation/arch/riscv/hwprobe.rst
@@ -146,6 +146,9 @@ The following keys are defined:
   * :c:macro:`RISCV_HWPROBE_EXT_ZFHMIN`: The Zfhmin extension version 1.0 is
        supported as defined in the RISC-V ISA manual.
 
+  * :c:macro:`RISCV_HWPROBE_EXT_ZIHINTNTL`: The Zihintntl extension version 1.0
+       is supported as defined in the RISC-V ISA manual.
+
 * :c:macro:`RISCV_HWPROBE_KEY_CPUPERF_0`: A bitmask that contains performance
   information about the selected set of processors.
 
diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
index 2d960777ea43..d72c69ea0740 100644
--- a/arch/riscv/include/uapi/asm/hwprobe.h
+++ b/arch/riscv/include/uapi/asm/hwprobe.h
@@ -52,6 +52,7 @@ struct riscv_hwprobe {
 #define		RISCV_HWPROBE_EXT_ZVKT		(1 << 26)
 #define		RISCV_HWPROBE_EXT_ZFH		(1 << 27)
 #define		RISCV_HWPROBE_EXT_ZFHMIN	(1 << 28)
+#define		RISCV_HWPROBE_EXT_ZIHINTNTL	(1 << 29)
 #define RISCV_HWPROBE_KEY_CPUPERF_0	5
 #define		RISCV_HWPROBE_MISALIGNED_UNKNOWN	(0 << 0)
 #define		RISCV_HWPROBE_MISALIGNED_EMULATED	(1 << 0)
diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
index d776c6c39fcd..a46e4f6821dd 100644
--- a/arch/riscv/kernel/sys_riscv.c
+++ b/arch/riscv/kernel/sys_riscv.c
@@ -173,6 +173,7 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
 		EXT_KEY(ZKSED);
 		EXT_KEY(ZKSH);
 		EXT_KEY(ZKT);
+		EXT_KEY(ZIHINTNTL);
 
 		if (has_vector()) {
 			EXT_KEY(ZVBB);
-- 
2.42.0

