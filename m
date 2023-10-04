Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D20B7B8279
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 16:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242442AbjJDOe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 10:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242814AbjJDOey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 10:34:54 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F12DCCE
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 07:34:50 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-4053e6e8ca7so5615385e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 07:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1696430089; x=1697034889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OyQJmck1/pI5OX/IX07IDtTyF+FKPIka6gVUOADEZr8=;
        b=HuiX6L5hojurAbfmxheJJzTFOLB3kiq38MPPBpO6IIf2HKgom5FfHDxWnDnQ7HkUgz
         DRlnzfQeDaFmqGom0Jy4ZaSvdNnbQ5dqftYwklkcJJQUmGr84CJtE9kz/5om9oEwmQV2
         s1N3K6HVmcb7pzY3wPXY07Ne3VMsiHfl4TWQYaWjWfevxmD2mJsFF+9wqG7zsb4sDJV7
         kK9jTH9IzwsH088wAgCXrrdPxq45zLaGvmWeKKZ4rTg04p6t3gbrTFEn4NPXAbiML69x
         eij7XkZ5ISob9947THJfb5fbmWny1J6+6FkEHX9uAH+0lXS+kQEGdkDloiNkVqPGOFKr
         W5Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696430089; x=1697034889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OyQJmck1/pI5OX/IX07IDtTyF+FKPIka6gVUOADEZr8=;
        b=ZIRyB0mHqhg+cHVyvUBCN6Lbc4YxPNYd6K8KyVJ0Jo7wXRTSZ4YD1k84CTuR3Yj3Kf
         MUzyRCDen9isK+ZOlMByTp26l3RTNSQhsQ0DIzyp79KRCVQFEu2oFhekeqKRl+JUzONP
         cIk+dYnVIVNlxi4QLSbQT8XLz5cr44bfDHF2DArq+0uNLqgYRPl2D11pxkwLqJz7UWME
         X/Oy9/miLbd1WjhgLzM4oypAPJd2xF8ow597Hb5ceTTN3wVyDCF2Sh05UtyLRgxwVu9D
         24a4wLfj6W2aqy8w5ldqYSVi2JIUcUSFf0izC8p4STZRNC5Uvg8It5qgDjVe5HASCj+A
         LJLQ==
X-Gm-Message-State: AOJu0YxDHQA6ijJZIvsdYcbr1n6YSwbKRHBimutQpn4wJxTMWUIhBBFs
        GzS8d8iLSYjMm93m1QGR6NDj2g==
X-Google-Smtp-Source: AGHT+IGzp/S6AMTHi02JDakLFsQHybTWZ0pEAN4ECemzds5xOO34p1aXoKuAUJwbGsZ5rcqs2qdXOQ==
X-Received: by 2002:adf:ecc3:0:b0:31f:edc3:c5fb with SMTP id s3-20020adfecc3000000b0031fedc3c5fbmr2087729wro.5.1696430089475;
        Wed, 04 Oct 2023 07:34:49 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:9474:8d75:5115:42cb])
        by smtp.gmail.com with ESMTPSA id t20-20020a1c7714000000b00401e32b25adsm1686205wmi.4.2023.10.04.07.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 07:34:49 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>
Cc:     =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, kvm-riscv@lists.infradead.org
Subject: [PATCH 5/5] riscv: kvm: use ".L" local labels in assembly when applicable
Date:   Wed,  4 Oct 2023 16:30:54 +0200
Message-ID: <20231004143054.482091-6-cleger@rivosinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004143054.482091-1-cleger@rivosinc.com>
References: <20231004143054.482091-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the sake of coherency, use local labels in assembly when
applicable. This also avoid kprobes being confused when applying a
kprobe since the size of function is computed by checking where the
next visible symbol is located. This might end up in computing some
function size to be way shorter than expected and thus failing to apply
kprobes to the specified offset.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 arch/riscv/kvm/vcpu_switch.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kvm/vcpu_switch.S b/arch/riscv/kvm/vcpu_switch.S
index 8b18473780ac..0c26189aa01c 100644
--- a/arch/riscv/kvm/vcpu_switch.S
+++ b/arch/riscv/kvm/vcpu_switch.S
@@ -45,7 +45,7 @@ SYM_FUNC_START(__kvm_riscv_switch_to)
 	REG_L	t0, (KVM_ARCH_GUEST_SSTATUS)(a0)
 	REG_L	t1, (KVM_ARCH_GUEST_HSTATUS)(a0)
 	REG_L	t2, (KVM_ARCH_GUEST_SCOUNTEREN)(a0)
-	la	t4, __kvm_switch_return
+	la	t4, .Lkvm_switch_return
 	REG_L	t5, (KVM_ARCH_GUEST_SEPC)(a0)
 
 	/* Save Host and Restore Guest SSTATUS */
@@ -113,7 +113,7 @@ SYM_FUNC_START(__kvm_riscv_switch_to)
 
 	/* Back to Host */
 	.align 2
-__kvm_switch_return:
+.Lkvm_switch_return:
 	/* Swap Guest A0 with SSCRATCH */
 	csrrw	a0, CSR_SSCRATCH, a0
 
-- 
2.42.0

