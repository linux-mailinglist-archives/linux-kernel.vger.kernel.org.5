Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 313807A36DE
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 19:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237534AbjIQRee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 13:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237657AbjIQReY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 13:34:24 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E82F12B
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 10:34:18 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-402cc6b8bedso43123815e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 10:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694972057; x=1695576857; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=FgpZGfCF8PPy5QW9KstupOXEJ+E1I8kQTRXlqrDGWvU=;
        b=Qtyawhj++53auIOXSSV28pGzVUkZj3yBm9asiwM87jL8Wl7fZ3YJs4BN/K26siZK3w
         6/99RXkhcroxfLssw0tIjul8XCBiBpxlw50OwQztO9OAHelo1xnz97w7MeGZ3UlLIrRS
         voNWbVba19E1dSS4cXIFQLKgAY0xRWGyY0f28ahbFYiL4pSDJKSavPkTnmk9Nb+z2Ecl
         V/aPc85/S9IfFPzAQxy4CuGdJivik5cuon1vgJxTAfqIv/JngeUzWUfw4gHcjUgjlhr1
         XhEXCdp5JAe15id5FdxVdn4z2k06wI35iGIk2Ef62XXNnPWsXZYrj7bht5ng/M295nul
         A8oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694972057; x=1695576857;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FgpZGfCF8PPy5QW9KstupOXEJ+E1I8kQTRXlqrDGWvU=;
        b=p7q6jHC551wdy97XCZX7/TRJq2kwU1yWh2O76m74dbXoeYvuTeii/ukl4IrKWVZsTN
         ua7sw1SFPWR3uVuvJNu3LDY6xvQMhn1Bvmi3MkkyvuliNzRGQLnC3Rwyg+BR+tVAL9j3
         7YPNVyUk6qR3RMQCZrmxmoVHQN9jTKplKZ138iqZwghJ90MVW/ukUeTuA9ZFutq3Rcmt
         4PcRu4l/X2ls9TB4giztJN2OBJb1rmdrKSbumVb3uLf50G2cQSQITJiRs2ovn0yCm/HE
         gv0gI2dYGnDK+Fkbvr/NXDDxCeblLVqnvBX67OLBTbvyOgihbejHPlqq5hCuNG4Mfeba
         gMqg==
X-Gm-Message-State: AOJu0Yy5dFSklX4f3WSGiKV99jTwBucpOW7CbeblB274PNPI28TmTI/c
        4qTtrowcVJkHtMna8dACB/M=
X-Google-Smtp-Source: AGHT+IEYLt0BIAi+NvKm7K68x73IKC1OUno8GN7qkWoQVwiode8GeSCthDKEQJH2a3bXxVC/kC4QZA==
X-Received: by 2002:a05:600c:2a54:b0:3fe:4cbc:c345 with SMTP id x20-20020a05600c2a5400b003fe4cbcc345mr6611385wme.41.1694972056715;
        Sun, 17 Sep 2023 10:34:16 -0700 (PDT)
Received: from gmail.com (1F2EF265.nat.pool.telekom.hu. [31.46.242.101])
        by smtp.gmail.com with ESMTPSA id er3-20020a05600c84c300b003fe24df4182sm5613599wmb.1.2023.09.17.10.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Sep 2023 10:34:15 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sun, 17 Sep 2023 19:34:13 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] objtool fix
Message-ID: <ZQc4lawqy8NnDzys@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest objtool/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-urgent-2023-09-17

   # HEAD: 72178d5d1a38dd185d1db15f177f2d122ef10d9b objtool: Fix _THIS_IP_ detection for cold functions

Fix a cold functions related false-positive objtool warning
that triggers on Clang.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
 Thanks,

	Ingo

------------------>
Josh Poimboeuf (1):
      objtool: Fix _THIS_IP_ detection for cold functions


 tools/objtool/check.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 1384090530db..e308d1ba664e 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4333,7 +4333,8 @@ static int validate_ibt_insn(struct objtool_file *file, struct instruction *insn
 			continue;
 		}
 
-		if (insn_func(dest) && insn_func(dest) == insn_func(insn)) {
+		if (insn_func(dest) && insn_func(insn) &&
+		    insn_func(dest)->pfunc == insn_func(insn)->pfunc) {
 			/*
 			 * Anything from->to self is either _THIS_IP_ or
 			 * IRET-to-self.
