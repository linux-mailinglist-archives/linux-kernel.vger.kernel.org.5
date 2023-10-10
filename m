Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27C167BFA9B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 14:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbjJJMBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 08:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231880AbjJJMBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 08:01:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097F2101;
        Tue, 10 Oct 2023 05:00:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60636C433C7;
        Tue, 10 Oct 2023 12:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696939235;
        bh=djkWvlb7qH5eChUEk8EFGaJLa6/2+lr0bMWAb+ydsPY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G1l3+AWSPYPCmmaWwpqB8mWw0/lhV3pCOif2vBSSJpSnfG3PRWIazRpni+5zAlCTk
         cD51VTH5hWl9z5K6wdgHD//uoKonwbgf3QGsA9/QndjQweSxpTYZaKsh6VR9BW03GH
         v8xmmbJ67KOAvd1todHcoCVq2aY+vVZSA1r7yJ3CtLhCYGIY7OLzx4C5KJyjQCoAj6
         VxxcHA8ArwsjYW/awLXObGH8uThWiuC1UHCOE7GK9IEy1RZ5yqGUFDAgkuB0Go42Uh
         zkNIxiaywfhtMZpW4hrxsTX10aoQhA8n+/nvs012YEOYPN8PdZu6rOndic0we6hGF/
         wFccDab5MnBVQ==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Uladzislau Rezki <urezki@gmail.com>, rcu <rcu@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 22/23] torture: Convert parse-console.sh to mktemp
Date:   Tue, 10 Oct 2023 13:59:20 +0200
Message-Id: <20231010115921.988766-23-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231010115921.988766-1-frederic@kernel.org>
References: <20231010115921.988766-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit does the long-overdue conversion of the parse-console.sh
file to use mktemp to create its temporary directory.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/parse-console.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/parse-console.sh b/tools/testing/selftests/rcutorture/bin/parse-console.sh
index e3d2f69ec0fb..b07c11cf6929 100755
--- a/tools/testing/selftests/rcutorture/bin/parse-console.sh
+++ b/tools/testing/selftests/rcutorture/bin/parse-console.sh
@@ -11,7 +11,7 @@
 #
 # Authors: Paul E. McKenney <paulmck@linux.ibm.com>
 
-T=${TMPDIR-/tmp}/parse-console.sh.$$
+T="`mktemp -d ${TMPDIR-/tmp}/parse-console.sh.XXXXXX`"
 file="$1"
 title="$2"
 
-- 
2.34.1

