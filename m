Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1F57C76F6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 21:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442716AbjJLTda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 15:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442344AbjJLTcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 15:32:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E75C9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 12:32:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F39AC433B9;
        Thu, 12 Oct 2023 19:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697139156;
        bh=hun9/RUzoWExp8MgqBBAg7pNHjTsuXi2cQ9T4PCTrTE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SIPjXo00rB0aSsBaRhnubgdJIZtacb1kR9lPi6VoJilYMFY4/vEcdcg7wGm/Y5/Jq
         IeS3yyeszMpKEzjnogkUU7MbKPa3PrbpPw2eYC9bvq8ExWIO/E0IRxdeElqcjFPA1Q
         bmKqTXA7XUO1QWWWKqNV2IRh2hPuzgdzVN/qEz7ZMoQMcIwKMNvylPXUrQeHbQeXhF
         wQevaSsx3q4CGVXfXEi395vLAFVXarpKAYQRegPkuAdoddoc0DALZ51pHHGKROeomb
         MaDTqdLF9BZPYOTAvwfnzL7Cywe5NykpQPHSTzNC1NFCBGKD8GHNVLlQpoUd8S1TaX
         yR55HhuAbs1wg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 6882FCE0FEC; Thu, 12 Oct 2023 12:32:35 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@meta.com, w@lwt.eu,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH nolibc 18/19] selftests/nolibc: use qemu-system-ppc64 for ppc64le
Date:   Thu, 12 Oct 2023 12:32:32 -0700
Message-Id: <20231012193233.207857-18-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <b34ce3cf-3fcc-4eb0-a658-229c197455ef@paulmck-laptop>
References: <b34ce3cf-3fcc-4eb0-a658-229c197455ef@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Weißschuh <linux@weissschuh.net>

qemu-system-ppc64 can handle both big and little endian kernels.

While some setups, like Debian, provide a symlink to execute
qemu-system-ppc64 as qemu-system-ppc64le, others, like ArchLinux, do not.

So always use qemu-system-ppc64 directly.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Link: https://lore.kernel.org/lkml/20231008-nolibc-qemu-ppc64-v1-1-29e2326e0420@weissschuh.net/
Acked-by: Willy Tarreau <w@1wt.eu>
---
 tools/testing/selftests/nolibc/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 891aa396163d..af60e07d3c12 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -82,7 +82,7 @@ QEMU_ARCH_arm        = arm
 QEMU_ARCH_mips       = mipsel  # works with malta_defconfig
 QEMU_ARCH_ppc        = ppc
 QEMU_ARCH_ppc64      = ppc64
-QEMU_ARCH_ppc64le    = ppc64le
+QEMU_ARCH_ppc64le    = ppc64
 QEMU_ARCH_riscv      = riscv64
 QEMU_ARCH_s390       = s390x
 QEMU_ARCH_loongarch  = loongarch64
-- 
2.40.1

