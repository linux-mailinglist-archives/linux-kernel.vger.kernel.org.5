Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC49F7F9358
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 16:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbjKZPSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 10:18:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbjKZPR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 10:17:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B370519B3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 07:18:04 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45156C433C7;
        Sun, 26 Nov 2023 15:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701011884;
        bh=cG0xmrQqzxNCm05ACdLm/5/wezI54OJYvdcq4wahVlc=;
        h=From:To:Cc:Subject:Date:From;
        b=kSkP8/+6o6D6pMMWo7R5finvJU7XC84qa0YeX3ftxsSvBq60BfDAOxfxmVJwITASc
         UTgQapkKZ9T0/AkgotOqXj15PswtR+hxYJ7blYv4hoo3muPWO9ZvxNC+FCFHSg8SyQ
         1l4+moHZbwj7WTUORxad6zCw2Lqms3BbNJLduWq5cJ2J+LDFI9SDeLPvKtYlTwEggy
         Q+KNABR2uSwv+7K2mAnkWt8YV06mbejx2dk7fBVDnjHSAyYW1I8o0B4UCnKPsFzfqu
         XOKB4MC5bRaP+tUkjwp5NV4axgRCL/M+Bu1d0GdBYUQjqMNu0D5Csgr7QAhv0Ri1DZ
         S0dqiHCr0OCTA==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] riscv: remove unneeded #include <asm-generic/export.h>
Date:   Mon, 27 Nov 2023 00:17:38 +0900
Message-Id: <20231126151739.1557369-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no EXPORT_SYMBOL() line there, hence
"#include <asm-generic/export.h>" is unneeded.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/riscv/kernel/mcount-dyn.S | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/riscv/kernel/mcount-dyn.S b/arch/riscv/kernel/mcount-dyn.S
index 58dd96a2a153..952233aa273a 100644
--- a/arch/riscv/kernel/mcount-dyn.S
+++ b/arch/riscv/kernel/mcount-dyn.S
@@ -8,7 +8,6 @@
 #include <asm/unistd.h>
 #include <asm/thread_info.h>
 #include <asm/asm-offsets.h>
-#include <asm-generic/export.h>
 #include <asm/ftrace.h>
 
 	.text
-- 
2.40.1

