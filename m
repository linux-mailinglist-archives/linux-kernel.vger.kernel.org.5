Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBCA7F917D
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 06:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjKZFtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 00:49:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKZFts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 00:49:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BFB2FC
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 21:49:55 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB308C433C8;
        Sun, 26 Nov 2023 05:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700977794;
        bh=4C/rZswEC+KNZtxPpel7E8H6NyrVNRA1dZZz67OEKKc=;
        h=From:To:Cc:Subject:Date:From;
        b=Nzv4qbsT8IWJ1LE2WTeLRQMxnAhTInR4SVQjPUCIguaiGxh0gtlsSy+AMk3FZNjRs
         M+BI6OkkEdCBcHExl/F0kT8lZ9fs++NxBA8zcz2NuvDomcyeMhAfJqA6A17wVzk1/s
         SnjilwSYrgRtK6txmCVW5sjUCcIXo9xtPq4RyfaVAFoH5PLny6riP2+xPXBHWOGXrJ
         AWi338pllchscT9MOFbD4l7tZghMvdvmpMZFJjvztdJ75eGYCoxQVb7/EEdiKiu3RW
         0KNcxNEAQTMSuDR4GSWQA9nop63rqUIzXLJQ9SbwY7DfkYPSs2lxX+C94Mu0wggyfT
         4DlAiqebrJOLQ==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] export.h: remove include/asm-generic/export.h
Date:   Sun, 26 Nov 2023 14:49:17 +0900
Message-Id: <20231126054917.930324-1-masahiroy@kernel.org>
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

With the removal of all <asm/export.h> inclusion except tools/,
include/asm-generic/export.h is no longer needed and can be removed.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 include/asm-generic/export.h | 11 -----------
 1 file changed, 11 deletions(-)
 delete mode 100644 include/asm-generic/export.h

diff --git a/include/asm-generic/export.h b/include/asm-generic/export.h
deleted file mode 100644
index 570cd4da7210..000000000000
--- a/include/asm-generic/export.h
+++ /dev/null
@@ -1,11 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-#ifndef __ASM_GENERIC_EXPORT_H
-#define __ASM_GENERIC_EXPORT_H
-
-/*
- * <asm/export.h> and <asm-generic/export.h> are deprecated.
- * Please include <linux/export.h> directly.
- */
-#include <linux/export.h>
-
-#endif
-- 
2.40.1

