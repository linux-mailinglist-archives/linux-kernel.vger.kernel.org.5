Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3ABD7C51AE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 13:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234838AbjJKLTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 07:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234658AbjJKLTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 07:19:18 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37474B0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 04:19:16 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-4053e6e8ca7so19944285e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 04:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1697023154; x=1697627954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y5dECHie5t7w/LFj+hSn2EZYYIuSxKSWdwgSHs3GrYQ=;
        b=paOaubDpSR+Z2YXae5A3aOp7dykvVsDwwtVI3IXsqZ3yl+3b5Lejk7TeZKU9Bk7oRq
         6mReQYe1T2S5mibvGYrut7fLqf9DhNtczvYVWS5OIVhxnSllWe4ogBwjHYvLsk8/V31a
         OrjKh3utE//AJQlQgDYtuT7l/GKkV78RTtmpMpCNTfmFMdGEGhuRZQwORPNJBv8RIZdR
         rsWGJhxBsQD5V+Kmi/WoI4CFMSeBDnAa28tBRxiVTnaCVwmY92nK4PDcUdcxLrHhlYOP
         7q44ySqZs5hnRKxgt/bWrGdCUsT6y2+CDuSFGWO3UugQuRDj4DLWMIYrns6XKoDMZu5K
         niqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697023154; x=1697627954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y5dECHie5t7w/LFj+hSn2EZYYIuSxKSWdwgSHs3GrYQ=;
        b=gNPiiWnkMOkE6xgX7LGM3eqf/S62QSPEfwLVSK6GAM0i3TRFD2NTFqlkT0x9pnMAnK
         189RWAUd7V+PtenDDN127/ktx7m+KiXYJRFCISoEISf851vzz1Vq8HRBsQYNe3Z7EY92
         AHpIR4/8QYlkPUqIoALF3zJ5upHEWgvyRsNkAGQbbkYgewr6pCS7QmuX+1B5K6YOB231
         b3/GZNheV8/20ht4rYvSAkjzXGRSs174wM0NvZIWZeJ4q4XQRNFz4+gUE2ut0QDjRFHA
         Ykgl50U7A49434BJpJnHJbWewtqNWof8k0/AU6XVSFgXeUAcLqd99Mz7vUTAnLmAuSnm
         igxQ==
X-Gm-Message-State: AOJu0YwO1olfOwcQ+x/rZiQ+wxeW7kUK+uK2vrq64DGlfmhbGOhWx5H0
        U4cDdIe+hSS4siE5pXx6oQidbMYx6aaFho52uqz9Kg==
X-Google-Smtp-Source: AGHT+IGqaMr2lbwiCk/m+ySyisBsIBIICm+Ha1304s+KwZsHP3G7Q7GtnKq3prSiP3Z7bET+xFCu8A==
X-Received: by 2002:a05:600c:214f:b0:406:513d:738f with SMTP id v15-20020a05600c214f00b00406513d738fmr18787352wml.2.1697023154659;
        Wed, 11 Oct 2023 04:19:14 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:9134:b302:d8b:a200])
        by smtp.gmail.com with ESMTPSA id a4-20020a05600c224400b003fe2b081661sm18945715wmm.30.2023.10.11.04.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 04:19:14 -0700 (PDT)
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
        Evan Green <evan@rivosinc.com>, Conor Dooley <conor@kernel.org>
Subject: [PATCH v1 01/13] riscv: fatorize hwprobe ISA extension reporting
Date:   Wed, 11 Oct 2023 13:14:26 +0200
Message-ID: <20231011111438.909552-2-cleger@rivosinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231011111438.909552-1-cleger@rivosinc.com>
References: <20231011111438.909552-1-cleger@rivosinc.com>
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
 arch/riscv/kernel/sys_riscv.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
index 473159b5f303..5ce593ce07a4 100644
--- a/arch/riscv/kernel/sys_riscv.c
+++ b/arch/riscv/kernel/sys_riscv.c
@@ -145,20 +145,18 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
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
+		} while (false)							\
+
+		CHECK_ISA_EXT(ZBA);
+		CHECK_ISA_EXT(ZBB);
+		CHECK_ISA_EXT(ZBS);
+#undef CHECK_ISA_EXT
 	}
 
 	/* Now turn off reporting features if any CPU is missing it. */
-- 
2.42.0

