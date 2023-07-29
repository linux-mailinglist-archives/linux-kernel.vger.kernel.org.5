Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 353E7768008
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 16:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbjG2O2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 10:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231934AbjG2O2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 10:28:02 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB4930F7
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 07:28:00 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-3491516c4aeso113825ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 07:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1690640879; x=1691245679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ynoALsv1aca8y8xpjhuiunc/CTMUKjN2qeAE0MoxzWk=;
        b=w+eXq0b+xVCeRwLimsIFDmDvgRjcNTvCTtckAuYL+NxLFVlICU0f2/cWdwaY8mOG/Z
         q9zwNJwGGpEOV3xOiYldmz0Ht7ao1zWta1BbZEEjXcNOnH9EHP0dAD99T3uBoMbvXql5
         a9TVjh54Y30EGW5rDrtC/vX3tjxDAXxWkwGk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690640879; x=1691245679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ynoALsv1aca8y8xpjhuiunc/CTMUKjN2qeAE0MoxzWk=;
        b=VgdKRdQgcTNwzM2zjm0h74DbYqdLftVp+6thIve500eUcLIG1WYdddc4jkH6CRYDEJ
         7yIIwRAOG5Eqct5HD6kAuzLPZzL1dIZ4pxsyIt5ImNPRe2L0/KV+j2g+D0m7vROx/G7F
         RASr/tHmzuqhQbqKtZuUEDA7oE+krJ9Puuu33Qu7OCSRzpU7cSMuLsrDw4ctYYJ3Vc4w
         NOCEMAGNh1V4BF8OcxZs43vEHmKs4I3TP1adnWeAQZGWDRdrdRMtqCCP6raRduyYp2pj
         zu2ckpj14ZZWzcJ0Er6t+CEM+dmbrNuf+Nd4sOqGLQHjM0X8TRhwpj/LvL8fbvlEk/HK
         iLnA==
X-Gm-Message-State: ABy/qLa1VxqNfADMrNPJ/ZH1/Dp+dW8cHsqMY6k4KRRCAl7LjgHRc1PD
        aXrSMiZXK6GYmRNkdek9Qhn+vvdS1cEySwJCUek=
X-Google-Smtp-Source: APBJJlFNIZPWUROiB89przJra0uGXRoZjzPe5M07xGkhX3SWIVZXoL08l9IiN4nUOnSpcobgTvOV7A==
X-Received: by 2002:a5e:d717:0:b0:790:9460:6304 with SMTP id v23-20020a5ed717000000b0079094606304mr657721iom.5.1690640879700;
        Sat, 29 Jul 2023 07:27:59 -0700 (PDT)
Received: from joelboxx5.c.googlers.com.com (254.82.172.34.bc.googleusercontent.com. [34.172.82.254])
        by smtp.gmail.com with ESMTPSA id q9-20020a0566380ec900b0042b35c7b8c5sm1855362jas.61.2023.07.29.07.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jul 2023 07:27:59 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     rcu@vger.kernel.org, paulmck@kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 5/5] Revert "checkpatch: Error out if deprecated RCU API used"
Date:   Sat, 29 Jul 2023 14:27:35 +0000
Message-ID: <20230729142738.222208-6-joel@joelfernandes.org>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
In-Reply-To: <20230729142738.222208-1-joel@joelfernandes.org>
References: <20230729142738.222208-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The check for single-argument kfree_rcu() is no longer needed as all
users have been converted.

This reverts commit 1eacac3255495be7502d406e2ba5444fb5c3607c.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 scripts/checkpatch.pl | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index a9841148cde2..528f619520eb 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6422,15 +6422,6 @@ sub process {
 			}
 		}
 
-# check for soon-to-be-deprecated single-argument k[v]free_rcu() API
-		if ($line =~ /\bk[v]?free_rcu\s*\([^(]+\)/) {
-			if ($line =~ /\bk[v]?free_rcu\s*\([^,]+\)/) {
-				ERROR("DEPRECATED_API",
-				      "Single-argument k[v]free_rcu() API is deprecated, please pass rcu_head object or call k[v]free_rcu_mightsleep()." . $herecurr);
-			}
-		}
-
-
 # check for unnecessary "Out of Memory" messages
 		if ($line =~ /^\+.*\b$logFunctions\s*\(/ &&
 		    $prevline =~ /^[ \+]\s*if\s*\(\s*(\!\s*|NULL\s*==\s*)?($Lval)(\s*==\s*NULL\s*)?\s*\)/ &&
-- 
2.41.0.487.g6d72f3e995-goog

