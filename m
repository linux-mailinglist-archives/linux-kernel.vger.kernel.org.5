Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F21D67C8527
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 14:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbjJML7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 07:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbjJML72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 07:59:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2118D12F;
        Fri, 13 Oct 2023 04:59:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A457C433BB;
        Fri, 13 Oct 2023 11:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697198362;
        bh=V2xBqcl5Jr08RnnZZIquxtDdCbLnvcU07W9cRLP2q50=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jMY7dv0K23sSU7UdaQvzsEmkbED8rLf2EQb5J8g/Sw5WYyE33w0AqV3jmDQzlSlcY
         A5AcxbukrW0BQosRi2IiAqfhA5V5S5TZ2vzt0bAKT4zvCM6qsNj0e4p9hcB6DvTitF
         /eA9NC6lKwr6j63syaOd41h86TlZ16Zu5QkZ0oKSZl6+miH3GIV2bidz1ZA3bQ07g4
         f2S8zCV714HZ/Xhs04JOIoyEwNvQe2nRt/0i7HK7w9jGw+p37jaXgWIjDmVe0hsg3y
         aZG2thaFom2op33POFplc7DpC9lZovN8oWGJkhDthVC2cJH0079ZaJsYIQTV+uFcrT
         4/9/yWRx8owPw==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Yue Haibing <yuehaibing@huawei.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Uladzislau Rezki <urezki@gmail.com>, rcu <rcu@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 05/18] rcu: Remove unused function declaration rcu_eqs_special_set()
Date:   Fri, 13 Oct 2023 13:58:49 +0200
Message-Id: <20231013115902.1059735-6-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013115902.1059735-1-frederic@kernel.org>
References: <20231013115902.1059735-1-frederic@kernel.org>
MIME-Version: 1.0
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

From: Yue Haibing <yuehaibing@huawei.com>

Commit a86baa69c2b7 ("rcu: Remove special bit at the bottom of the ->dynticks counter")
left behind this, remove it.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/rcutree.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index 126f6b418f6a..153cfc7bbffd 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -37,7 +37,6 @@ void synchronize_rcu_expedited(void);
 void kvfree_call_rcu(struct rcu_head *head, void *ptr);
 
 void rcu_barrier(void);
-bool rcu_eqs_special_set(int cpu);
 void rcu_momentary_dyntick_idle(void);
 void kfree_rcu_scheduler_running(void);
 bool rcu_gp_might_be_stalled(void);
-- 
2.34.1

