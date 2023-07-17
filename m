Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28C96755DDF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 10:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjGQIHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 04:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjGQIHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 04:07:11 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39E71995
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 01:06:33 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R4F5b6Y4BzBR7b4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 16:06:11 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689581171; x=1692173172; bh=HCbBZb7kJTmDWi3ebtccrSL5d75
        7N5zS4lsS2prlWPg=; b=HMJGniy9XMp5geCvp2erwRPS115Sp/ay58HDPX855QY
        KTbDCh4bfoLyh0gyCsmZe+c9dGDmIxPldukRa/4MGiOoK6q5bpMZYyNIPwp1Z/Pu
        rDs1ndiT8GkjOceqlXGj3+ZLc1s62HJw1T3thGqLQWoL0prFS9gBQpdHDEHphv/N
        bm6hnHZUsST7rpj2oPEUUrLk/gesN0qdJoO2mcIsvWQplmEiDRScaBg7x7FsnipL
        ay0sM31+DHu8IAIXiw4C3UZsOCePsaLsOtSXKhSKeqchDvuCvogmXrTpkERrWcdM
        AYI8h2VNcY87jw4MA88A0IoxHtayy/f8Ouu5gZBlmQw==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id OV-t-ra7Q_3K for <linux-kernel@vger.kernel.org>;
        Mon, 17 Jul 2023 16:06:11 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R4F5b26ShzBQt1h;
        Mon, 17 Jul 2023 16:06:11 +0800 (CST)
MIME-Version: 1.0
Date:   Mon, 17 Jul 2023 16:06:11 +0800
From:   hanyu001@208suo.com
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, atishp@rivosinc.com, maz@kernel.org,
        apatel@ventanamicro.com, guoren@kernel.org,
        sunilvl@ventanamicro.com, ben-linux@fluff.org, vschneid@redhat.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: kernel: insert space before the open parenthesis '('
In-Reply-To: <tencent_7D5EADDF79970079F568A5C4F801910DED06@qq.com>
References: <tencent_7D5EADDF79970079F568A5C4F801910DED06@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <b90d162c4fb8062355634fb53b05173d@208suo.com>
X-Sender: hanyu001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix below checkpatch error:

/riscv/kernel/smp.c:93:ERROR: space required before the open parenthesis 
'('

Signed-off-by: ztt <1549089851@qq.com>
---
  arch/riscv/kernel/smp.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
index 23e533766a49..1454f2415b7f 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -90,7 +90,7 @@ static inline void ipi_cpu_crash_stop(unsigned int 
cpu, struct pt_regs *regs)
          cpu_ops[cpu]->cpu_stop();
  #endif

-    for(;;)
+    for (;;)
          wait_for_interrupt();
  }
  #else
