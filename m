Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B994B7E8ECE
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 07:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbjKLGUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 01:20:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjKLGTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 01:19:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A0B59EA
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 22:18:55 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE88DC433CD;
        Sun, 12 Nov 2023 06:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699769935;
        bh=AwoQnmBHOr8wX0BVa478M177ccT62CL+qVUXJhTICuI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sJXr4K7CMCXTwmO5X1pmQnRLyFyMAWwG0wfgQ3IgYD0i9bjqWX0shBQhZKtCQsnIA
         v4K4s+1F6Ic7Y9U7q5L0ZO3sGGyTeu/F4hGL2KKPl2fTc17E3FOorTcARLkRvgK/ni
         B6AR82CJfxt0k+42b3M1nzdqY3B9+Knf0yrg2DCUxkRgdLWPwGhTOMjWD0+iZLTK0t
         mcIYpcO9Kkxyg5pkjKS9UnbhajiDqAdiJ4C6a5PTfaV4PcQjP7+QLva36W6RF9JN8q
         GLdQ1t9VZx/UzjEDXZtEfagDjw9CwcKjFswIm+AugiUmEqxKBVunP9X9y4kJg8muBa
         OxEwx3teBIcTw==
From:   guoren@kernel.org
To:     arnd@arndb.de, guoren@kernel.org, palmer@rivosinc.com,
        tglx@linutronix.de, conor.dooley@microchip.com, heiko@sntech.de,
        apatel@ventanamicro.com, atishp@atishpatra.org, bjorn@kernel.org,
        paul.walmsley@sifive.com, anup@brainfault.org, jiawei@iscas.ac.cn,
        liweiwei@iscas.ac.cn, wefu@redhat.com, U2FsdGVkX1@gmail.com,
        wangjunqiang@iscas.ac.cn, kito.cheng@sifive.com,
        andy.chiu@sifive.com, vincent.chen@sifive.com,
        greentime.hu@sifive.com, wuwei2016@iscas.ac.cn, jrtc27@jrtc27.com,
        luto@kernel.org, fweimer@redhat.com, catalin.marinas@arm.com,
        hjl.tools@gmail.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [RFC PATCH V2 34/38] riscv: Cleanup rv32_defconfig
Date:   Sun, 12 Nov 2023 01:15:10 -0500
Message-Id: <20231112061514.2306187-35-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20231112061514.2306187-1-guoren@kernel.org>
References: <20231112061514.2306187-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Remove unnecessary configs to make rv32_defconfig have a minimal
difference from the defconfig. CONFIG_ARCH_RV32I selects the
CONFIG_32BIT, so putting it in the file is unnecessary. Also, there is
no need to comment on CONFIG_PORTABLE; it should come from carelessness.

Next rv64ilp32_defconfig would like:
  CONFIG_ARCH_RV64ILP32=y
  CONFIG_NONPORTABLE=y

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/riscv/configs/32-bit.config | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/riscv/configs/32-bit.config b/arch/riscv/configs/32-bit.config
index f6af0f708df4..eb87885c8640 100644
--- a/arch/riscv/configs/32-bit.config
+++ b/arch/riscv/configs/32-bit.config
@@ -1,4 +1,2 @@
 CONFIG_ARCH_RV32I=y
-CONFIG_32BIT=y
-# CONFIG_PORTABLE is not set
 CONFIG_NONPORTABLE=y
-- 
2.36.1

