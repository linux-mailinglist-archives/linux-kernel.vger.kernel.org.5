Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB3267E8A6C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 11:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbjKKKzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 05:55:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjKKKzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 05:55:10 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330183AA8
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 02:55:07 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-4083cd3917eso22295985e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 02:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699700105; x=1700304905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Simk5WZob06j68nmgozjYw81rVx8Bg3CzVtDugt3jEM=;
        b=hfhOP1iK4qynzaTKXdQpHcGTGsxiO9YINsPATPBFnBN/RFtTFKKa+Wlbp6K/ICSJrN
         LNC8Nsik7Ubq120itIbeX/6RWkFTywgb17CtymIoh5z00ZVamwRq+6ORyaqSAmO+9VLD
         AukPoxOjwIQuESxeWQhzOmj5glHiD+qjbkcHJfNorKxejFLWKX+8t9sC9Z0gp9eU0VLO
         RrJBsZe5D1mjhTg2qRz+3RWHf1TnfRFlf2vtgHYIqJmjnRI6qC9P2CleJI5xJctFhlcO
         UW5l9pML85z8sY14IC3QHB1JNsuNU/U2bY5p5toFU8BebrxPmtFMzY9OKiE80mK9Xtq5
         6r6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699700105; x=1700304905;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Simk5WZob06j68nmgozjYw81rVx8Bg3CzVtDugt3jEM=;
        b=aB+L/xt4ZPbIMSPaSgZpWCXuaifOIDM4xW0aK1vQPGApH2xK+1E8q4baeOFrlzLz/E
         qY4M/ffquD1dahNh+GMGtPdQhjRIOT84PG4DAs5xoN3hY/aHB1fmOa9YDuOpt2lY8vhu
         DrQKYYZMPJ/l9CVdpgYJFphI72VBVmWHhFRSYHfSmC3mTQH46Rzvm2nSGlv2jtzK77tV
         t6//BVRPWBHPEpklbk4HKZc92OzYcS7R+nYlrmte4F1EH6IDN8PqPm7osfZi3hTUeFkC
         YDZIx9TxoC3n2hMt4Sr7eDdbbV96DTrE8ZmLvIclJKlwubjjIrfDs6Bt1glvyw07UobB
         JcBg==
X-Gm-Message-State: AOJu0YzEHDXW9PyiqMTlrg6LM8KNG1RXTDSDCKiI0Y8zMDYLPUbGuznz
        8Vhe/lmuFy4Zub8TPY4Oon2L7ZDnTOg=
X-Google-Smtp-Source: AGHT+IEhh85MDbRvWqZJuHcspgdHaWznnY4aaa+xkaFl/RbaQ34k8lgI9aCdHxlhDAR4sEn40ym4vg==
X-Received: by 2002:a05:600c:2d15:b0:404:6ed9:98d1 with SMTP id x21-20020a05600c2d1500b004046ed998d1mr1369580wmf.41.1699700105114;
        Sat, 11 Nov 2023 02:55:05 -0800 (PST)
Received: from localhost.localdomain (host86-136-214-82.range86-136.btcentralplus.com. [86.136.214.82])
        by smtp.gmail.com with ESMTPSA id iv10-20020a05600c548a00b0040535648639sm1829858wmb.36.2023.11.11.02.55.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 11 Nov 2023 02:55:04 -0800 (PST)
From:   Levi Yun <ppbuk5246@gmail.com>
To:     Liam.Howlett@oracle.com
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Levi Yun <ppbuk5246@gmail.com>
Subject: [PATCH] mpale_tree: remove redundant check on mas_wr_append.
Date:   Sat, 11 Nov 2023 10:54:55 +0000
Message-ID: <20231111105455.37917-1-ppbuk5246@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checking data appending on node is done by
    mas->offsest == end
which is identical with:
    mas->offset == wr_mas->node_end

Remove redundant check and there shouldn't be functional change.

Signed-off-by: Levi Yun <ppbuk5246@gmail.com>
---
 lib/maple_tree.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index bb24d84a4922..d16b8e211174 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4141,9 +4141,6 @@ static inline bool mas_wr_append(struct ma_wr_state *wr_mas,
 	if (mt_in_rcu(mas->tree))
 		return false;
 
-	if (mas->offset != wr_mas->node_end)
-		return false;
-
 	end = wr_mas->node_end;
 	if (mas->offset != end)
 		return false;
-- 
2.41.0

