Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 912E77FC2B2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346371AbjK1OyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 09:54:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346341AbjK1OyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 09:54:01 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B087510FB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 06:54:07 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1cfb30ce241so28801525ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 06:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1701183247; x=1701788047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5oGoP2GtxpZiKciaDqaxx+4G6dOpwmCS0pkpDHBsR78=;
        b=eKvUmA/tZfVGUUtsS1mCGBo/vNlQGQd1FrNz1E7SLPArwfsQbyuWL6Qtz4400DYPPi
         U44PQtoPiY9zFOHVhrrkdOVAlgcYlOMhyHi5sek/KBloT7MSN5kK9N/aTJthMxvb5Waw
         7wDeT+N/ztpSHg4WmHIuEWN47OhCnf3m74zathhqhQemMexJozVMWfnryXRoJmec5rdb
         VqBWVdQV+jxhuOhF5zd/tlqw8ZtjyvHXIGaPeUrIVYig2BBSFy+WmuhiEj69e1ee7Gag
         +uJqrr5uAmGDz42hQW+ZU+YU2O/N1VOfSNx21UZdHbrlFpUdTDyUVXZWT9rJEqTQR9qg
         sB5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701183247; x=1701788047;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5oGoP2GtxpZiKciaDqaxx+4G6dOpwmCS0pkpDHBsR78=;
        b=OQheta/klP5MjR+mxfqxsixD47UcOj8fC1b6WcvITOo3MnMXAEqWpNTI/S8t3KFLh4
         HIdOV7BIcnWQ8D9jCNjlpE9/KZ7knPvnIM8QwJ3nih2SEWTIWXUWajO4h568sFwhfo1b
         OX/Jiw8qBJ6mj5/MhRlCifaz+eBaLIgfR08uyIlmY92NL34TPpKNSwpl0SqqcPDIj/lS
         bHPoV5/AlPsAGooVzyfiaErLapuO6AbXEbOmQEgHcFxPRsvWasILYuxILV2AFs2GpWsS
         dBbXMJVmHN4ZHSl3f393ldVKHu9n72Rp7wC3zS+Cy0GabPuYowTC0lONEiztq2OFM1m6
         7XuA==
X-Gm-Message-State: AOJu0YzieS93Z6gfsI5+VaApZee+7HZGVJCPFvIxwwpRZLdq/rC8bBWO
        nMgcTBWTCLKM3jjyqhvicIa0tA==
X-Google-Smtp-Source: AGHT+IGsBlwznYL+eO1YLtU9utrEhljJYsPZTHdTwczY6ki0/qgSD6wR3fyYBpktQqzZ0f4ggbB5sQ==
X-Received: by 2002:a17:902:e88a:b0:1cf:cf34:d504 with SMTP id w10-20020a170902e88a00b001cfcf34d504mr8424957plg.36.1701183247023;
        Tue, 28 Nov 2023 06:54:07 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id u11-20020a170902e80b00b001bf11cf2e21sm10281552plg.210.2023.11.28.06.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 06:54:06 -0800 (PST)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Anup Patel <anup@brainfault.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        devicetree@vger.kernel.org, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH 00/15] KVM RISC-V report more ISA extensions through ONE_REG
Date:   Tue, 28 Nov 2023 20:23:42 +0530
Message-Id: <20231128145357.413321-1-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This extends the KVM RISC-V ONE_REG interface to report more ISA extensions
namely: Zbz, scalar crypto, vector crypto, Zfh[min], Zihintntl, Zvfh[min],
and Zfa.

This series depends upon the "riscv: report more ISA extensions through
hwprobe" series.from Clement.
(Link: https://lore.kernel.org/lkml/20231114141256.126749-1-cleger@rivosinc.com/)

To test these patches, use KVMTOOL from the riscv_more_exts_v1 branch at:
https://github.com/avpatel/kvmtool.git

These patches can also be found in the riscv_kvm_more_exts_v1 branch at:
https://github.com/avpatel/linux.git

Anup Patel (15):
  KVM: riscv: selftests: Generate ISA extension reg_list using macros
  RISC-V: KVM: Allow Zbc extension for Guest/VM
  KVM: riscv: selftests: Add Zbc extension to get-reg-list test
  RISC-V: KVM: Allow scalar crypto extensions for Guest/VM
  KVM: riscv: selftests: Add scaler crypto extensions to get-reg-list
    test
  RISC-V: KVM: Allow vector crypto extensions for Guest/VM
  KVM: riscv: selftests: Add vector crypto extensions to get-reg-list
    test
  RISC-V: KVM: Allow Zfh[min] extensions for Guest/VM
  KVM: riscv: selftests: Add Zfh[min] extensions to get-reg-list test
  RISC-V: KVM: Allow Zihintntl extension for Guest/VM
  KVM: riscv: selftests: Add Zihintntl extension to get-reg-list test
  RISC-V: KVM: Allow Zvfh[min] extensions for Guest/VM
  KVM: riscv: selftests: Add Zvfh[min] extensions to get-reg-list test
  RISC-V: KVM: Allow Zfa extension for Guest/VM
  KVM: riscv: selftests: Add Zfa extension to get-reg-list test

 arch/riscv/include/uapi/asm/kvm.h             |  27 ++
 arch/riscv/kvm/vcpu_onereg.c                  |  54 +++
 .../selftests/kvm/riscv/get-reg-list.c        | 439 ++++++++----------
 3 files changed, 265 insertions(+), 255 deletions(-)

-- 
2.34.1

