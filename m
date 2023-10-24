Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96FBC7D4B05
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 10:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234015AbjJXIxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 04:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234082AbjJXIxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 04:53:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7051C1728;
        Tue, 24 Oct 2023 01:52:47 -0700 (PDT)
Date:   Tue, 24 Oct 2023 08:52:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698137565;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Torrz4DvFgyBpq5YRoDhNiX3Xla+aWY17z7TTn3BOUk=;
        b=gN3hWjQ8uNrPg9zL/Ihrn6OfWaFP+kZjiB9wduB7Bu/SXjZ3kXCqiAHgPjk/sQ2WnYE6ju
        r12SxDe2QmpWJugvlFzLpvwXQm27AtjnuizFnqGTU6a08K74duD7vqSZj3ZM+dLUm2ijq8
        U1MuaqH2vSVGRPvjK/Owev4bPqHMQgiOBCdMu9BrxsHOGW0qiq3WXjMcmdIFKaLwjvXQP+
        9iOWNA2H/zJFYFpUsAuCpOVMwF5Ab1T9zJm5oh0+0YFJOW7xxUJadnaFVur6LpXBFbj3XU
        36d05TpmyJH8hJKonpSik1GnfW2eTtN+6C6uBZtTYq/TqCxzftnfeRp+kReh+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698137565;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Torrz4DvFgyBpq5YRoDhNiX3Xla+aWY17z7TTn3BOUk=;
        b=dT+Y99vvD5XKo0i8vK1/GecOHgzv9LjYnx9exm9geXH55/sR9IIV4X5VNTLBN/lRqNnSaK
        gUWvkrsfnm2CY/AA==
From:   "tip-bot2 for Aaron Plattner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Remove max symbol name length limitation
Cc:     Aaron Plattner <aplattner@nvidia.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C41e94cfea1d9131b758dd637fecdeacd459d4584=2E16963?=
 =?utf-8?q?55111=2Egit=2Eaplattner=40nvidia=2Ecom=3E?=
References: =?utf-8?q?=3C41e94cfea1d9131b758dd637fecdeacd459d4584=2E169635?=
 =?utf-8?q?5111=2Egit=2Eaplattner=40nvidia=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <169813756504.3135.9831690835814050444.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     f404a58dcf0c862b05602f641ce5fdd8b98fbc3a
Gitweb:        https://git.kernel.org/tip/f404a58dcf0c862b05602f641ce5fdd8b98fbc3a
Author:        Aaron Plattner <aplattner@nvidia.com>
AuthorDate:    Wed, 04 Oct 2023 17:08:19 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Thu, 05 Oct 2023 17:01:28 -07:00

objtool: Remove max symbol name length limitation

If one of the symbols processed by read_symbols() happens to have a
.cold variant with a name longer than objtool's MAX_NAME_LEN limit, the
build fails.

Avoid this problem by just using strndup() to copy the parent function's
name, rather than strncpy()ing it onto the stack.

Signed-off-by: Aaron Plattner <aplattner@nvidia.com>
Link: https://lore.kernel.org/r/41e94cfea1d9131b758dd637fecdeacd459d4584.1696355111.git.aplattner@nvidia.com
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/elf.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 081befa..3d27983 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -22,8 +22,6 @@
 #include <objtool/elf.h>
 #include <objtool/warn.h>
 
-#define MAX_NAME_LEN 128
-
 static inline u32 str_hash(const char *str)
 {
 	return jhash(str, strlen(str), 0);
@@ -515,7 +513,7 @@ static int read_symbols(struct elf *elf)
 	/* Create parent/child links for any cold subfunctions */
 	list_for_each_entry(sec, &elf->sections, list) {
 		sec_for_each_sym(sec, sym) {
-			char pname[MAX_NAME_LEN + 1];
+			char *pname;
 			size_t pnamelen;
 			if (sym->type != STT_FUNC)
 				continue;
@@ -531,15 +529,15 @@ static int read_symbols(struct elf *elf)
 				continue;
 
 			pnamelen = coldstr - sym->name;
-			if (pnamelen > MAX_NAME_LEN) {
-				WARN("%s(): parent function name exceeds maximum length of %d characters",
-				     sym->name, MAX_NAME_LEN);
+			pname = strndup(sym->name, pnamelen);
+			if (!pname) {
+				WARN("%s(): failed to allocate memory",
+				     sym->name);
 				return -1;
 			}
 
-			strncpy(pname, sym->name, pnamelen);
-			pname[pnamelen] = '\0';
 			pfunc = find_symbol_by_name(elf, pname);
+			free(pname);
 
 			if (!pfunc) {
 				WARN("%s(): can't find parent function",
