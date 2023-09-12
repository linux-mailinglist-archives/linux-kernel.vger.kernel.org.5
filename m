Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE9B79C838
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 09:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbjILHcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 03:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbjILHcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 03:32:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3F9E79
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 00:32:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC59AC433C8;
        Tue, 12 Sep 2023 07:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694503932;
        bh=HBWl5TsWAKAoTzbm8Bwf+YOEMz6NMlDFOMNBVCJ92PE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OvVipaHJZ3zN6VWZ13xySJscIIb9lQcwQwf2SKfyd22P78oZNNTLrW+qPfdhupd5j
         1LH0ujc0/BogPiGdv044Ht/xolxVdwAg0WVA27P2R8L53y2TSDLR0j/rVGRW050or1
         ktvn0XBB2FE3O5Vs52vpqCaPDsQNrLOj1aVUptRkuY1ezxJhGZiZFoVgBqbVF/uwZo
         oBpMTx372X/0B4DbYcwOAxS+wBOuhAhQOqHVSZemrTrW8dQokYUXQNHIgj+TkprJPK
         +alxjlXZPeMlumYoYHle6QTNRZlrHCkx1SYVzH1RX1AAinxnB91xL1TmlitQ2GkuqJ
         BhoGw/P1VwzKQ==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Andrew Jones <ajones@ventanamicro.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
Subject: [RESEND PATCH 1/3] riscv: vdso.lds.S: drop __alt_start and __alt_end symbols
Date:   Tue, 12 Sep 2023 15:20:13 +0800
Message-Id: <20230912072015.2424-2-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230912072015.2424-1-jszhang@kernel.org>
References: <20230912072015.2424-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These two symbols are not used, remove them.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Tested-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
---
 arch/riscv/kernel/vdso/vdso.lds.S | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/riscv/kernel/vdso/vdso.lds.S b/arch/riscv/kernel/vdso/vdso.lds.S
index 82ce64900f3d..d43fd7c7dd11 100644
--- a/arch/riscv/kernel/vdso/vdso.lds.S
+++ b/arch/riscv/kernel/vdso/vdso.lds.S
@@ -42,9 +42,7 @@ SECTIONS
 
 	. = ALIGN(4);
 	.alternative : {
-		__alt_start = .;
 		*(.alternative)
-		__alt_end = .;
 	}
 
 	.data		: {
-- 
2.40.1

