Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340717CC429
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 15:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343822AbjJQNPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 09:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234960AbjJQNPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 09:15:31 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE8A2F7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 06:15:29 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-406aaccb41dso18299135e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 06:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1697548528; x=1698153328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gsST45qXCpXW6hXAZjZQAx82ZOViPLGcbU4pTeMM644=;
        b=uyB2M5R+DJ/rHyT6Pmb69lo81ITr7UvFocveAU7syQsTuFPZxtnivmU/7djjdH/e6y
         jqgjPATS5uES8wvBOPABCuOv4f/R+zRAN3MdNnMzTncivzd5IZH+DqPJjLzjIdcoe7Ba
         /oa7xLRjmNZHwV6KbrMMXEJFfO8mj1Qrikef9zh4o1Zwe0Dxxm28SpQXViBtQNm3S+sW
         H11nLtitzYJ9AuozwHdAWW7oC9/9zQWJXRRIkqj0iR+GscKQSF/kVuux8aCcvsdpeZvW
         yjHjr54HHK8XFYFurSGbMdcwOtOOTcWJly8QKti6dxieiw8Oo+GiIzxiAww27Rtnjbua
         EthA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697548528; x=1698153328;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gsST45qXCpXW6hXAZjZQAx82ZOViPLGcbU4pTeMM644=;
        b=GxXoJcMAWUSXWYkJP7ZoB+rbF4bJ/vCs5Ljd8Y40Ol3VpY2LRJnKD5g+8rLH+9wBjd
         fODJsUMJAysddRHt13MChC0M70VkkVtPP06ey/hIQpKe6Kl0TJFRgjnBSL50T+SXzjAP
         EYFgSRg8vfz7N2gW95LXThI2v9Uf275H9wVYAvUVf1z5YHYsHONEYnU5+FWYweMjpZWN
         s2upJGIY2G1OODiDLbWE3v/w6xijXtmxrUOY311r0HRnALFJkaDqrQaA8lj1fUDgphEZ
         W7ZCgfptxOO23hpUBrlNBfT8odhMVmgq9nl4EQ6tHYJGGrIZ4RWEhNuqe/v09i3e/huB
         +UKQ==
X-Gm-Message-State: AOJu0Yzd2bbzARXZh9bIcSeNnMplq59b3XFybP5UUHP4m2oyuW3R314D
        jeDu4dKbU+tMceJMnM6+h3pRcko6gj4bVH3JGUjDuA==
X-Google-Smtp-Source: AGHT+IFnvMoT3qyr2NCLvQJOx6T+CGM+XTBB3O4jbC4CPq2HYp9VCIzFJSZf5tnuM4q6zh/FfvWWOA==
X-Received: by 2002:a05:600c:4f88:b0:405:3cc1:e115 with SMTP id n8-20020a05600c4f8800b004053cc1e115mr1603989wmq.3.1697548527550;
        Tue, 17 Oct 2023 06:15:27 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:96:820c:ecf7:a817])
        by smtp.gmail.com with ESMTPSA id fj7-20020a05600c0c8700b0040772138bb7sm9873393wmb.2.2023.10.17.06.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 06:15:26 -0700 (PDT)
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
        Samuel Ortiz <sameo@rivosinc.com>
Subject: [PATCH v2 01/19] riscv: hwprobe: factorize hwprobe ISA extension reporting
Date:   Tue, 17 Oct 2023 15:14:38 +0200
Message-ID: <20231017131456.2053396-2-cleger@rivosinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231017131456.2053396-1-cleger@rivosinc.com>
References: <20231017131456.2053396-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Factorize ISA extension reporting by using a macro rather than
copy/pasting extension names. This will allow adding new extensions more
easily.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 arch/riscv/kernel/sys_riscv.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
index 473159b5f303..e207874e686e 100644
--- a/arch/riscv/kernel/sys_riscv.c
+++ b/arch/riscv/kernel/sys_riscv.c
@@ -145,20 +145,24 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
 	for_each_cpu(cpu, cpus) {
 		struct riscv_isainfo *isainfo = &hart_isa[cpu];
 
-		if (riscv_isa_extension_available(isainfo->isa, ZBA))
-			pair->value |= RISCV_HWPROBE_EXT_ZBA;
-		else
-			missing |= RISCV_HWPROBE_EXT_ZBA;
-
-		if (riscv_isa_extension_available(isainfo->isa, ZBB))
-			pair->value |= RISCV_HWPROBE_EXT_ZBB;
-		else
-			missing |= RISCV_HWPROBE_EXT_ZBB;
-
-		if (riscv_isa_extension_available(isainfo->isa, ZBS))
-			pair->value |= RISCV_HWPROBE_EXT_ZBS;
-		else
-			missing |= RISCV_HWPROBE_EXT_ZBS;
+#define CHECK_ISA_EXT(__ext)							\
+		do {								\
+			if (riscv_isa_extension_available(isainfo->isa, __ext))	\
+				pair->value |= RISCV_HWPROBE_EXT_##__ext;	\
+			else							\
+				missing |= RISCV_HWPROBE_EXT_##__ext;		\
+		} while (false)
+
+		/*
+		 * Only use CHECK_ISA_EXT() for extensions which can be exposed
+		 * to userspace, regardless of the kernel's configuration, as no
+		 * other checks, besides presence in the hart_isa bitmap, are
+		 * made.
+		 */
+		CHECK_ISA_EXT(ZBA);
+		CHECK_ISA_EXT(ZBB);
+		CHECK_ISA_EXT(ZBS);
+#undef CHECK_ISA_EXT
 	}
 
 	/* Now turn off reporting features if any CPU is missing it. */
-- 
2.42.0

