Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57D3A762756
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 01:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232191AbjGYX3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 19:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231886AbjGYX3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 19:29:43 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019491FE2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 16:29:34 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-77a62a84855so261093439f.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 16:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1690327773; x=1690932573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ynoALsv1aca8y8xpjhuiunc/CTMUKjN2qeAE0MoxzWk=;
        b=T1/qgW80ZW0ruvAexTl3SwPC/VD8efNMinccPq8SOmll1PeYaL7nJcC+rT2y/ICCI/
         Zm7HzPisHr2CWscQ8DNq4ATfmZQ4copg8Byy3hFGTtKvq0+ing3UNCdbIzc4z9yskHeM
         i6XYgDFBYacc8aSIAdToK+pj+H/fS21Ias0jU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690327773; x=1690932573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ynoALsv1aca8y8xpjhuiunc/CTMUKjN2qeAE0MoxzWk=;
        b=BmhENbGzzU2H1WTFNohYWsDAnjGcgw7mxMbuoCk1FE9kS7HBzjveNVMdbsyMznwrPM
         mHvGuButh43zvqOT/UY9UUD79WqtRHcEVyxyafzeqv/cLCiM2BILkmuxj1KjqhpIO2hj
         UrymULVR/8OUkMavZqM2JT4Zoc1SYsK9Dy+rAlrR4OW4AiYn7/IUZanyLYhr/jQxQstq
         y9ntZJ5LIJUYmLWmy21QQR6DnYd1UhNRYIi23FE5yRsMxLHb/XvCzJDAvRF8kgGQKdGy
         k4wpSH/zLd+hLlcVYLZFfwovpo836amUy/i3gPzjdmikQyvBoqiDbLseW+xoC9iAhUFw
         Gxjw==
X-Gm-Message-State: ABy/qLarL7LrvOv8dy1yAp7oZiZR9SEn9KBPSpsK9f76m6kwYQ+gRNfJ
        buR0T71MffvyxPhQnN5zfDABtEKRMPjOon+GHYs=
X-Google-Smtp-Source: APBJJlFOYFaGXIDd2DLLQ0HZ+PPI+wBB+NlGxhegixuv5PbL5oqsOrir68iUsUdxnVKRboGwsYrdZA==
X-Received: by 2002:a5e:8a4c:0:b0:787:34d:ee9e with SMTP id o12-20020a5e8a4c000000b00787034dee9emr356394iom.7.1690327773744;
        Tue, 25 Jul 2023 16:29:33 -0700 (PDT)
Received: from joelboxx5.c.googlers.com.com (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id m18-20020a02c892000000b0041d859c5721sm3932053jao.64.2023.07.25.16.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 16:29:32 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org, Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     rcu@vger.kernel.org, paulmck@kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH 5/5] Revert "checkpatch: Error out if deprecated RCU API used"
Date:   Tue, 25 Jul 2023 23:29:10 +0000
Message-ID: <20230725232913.2981357-6-joel@joelfernandes.org>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
In-Reply-To: <20230725232913.2981357-1-joel@joelfernandes.org>
References: <20230725232913.2981357-1-joel@joelfernandes.org>
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

