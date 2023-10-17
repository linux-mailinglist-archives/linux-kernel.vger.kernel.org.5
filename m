Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45FDE7CC2E4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 14:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235020AbjJQMTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 08:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234974AbjJQMT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 08:19:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D927135A3;
        Tue, 17 Oct 2023 05:19:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8A0DC433C8;
        Tue, 17 Oct 2023 12:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697545152;
        bh=peWbdB3NVwogy8Kxbp1KdReSf6V9bIbkVM7IJYnEM7g=;
        h=From:To:Cc:Subject:Date:From;
        b=QphODzLTNavMBHR/yEN39KVGmkfWXEmVVXfyytXt6SI48U0zriPBGiurlZeAy73R4
         TvoPH8OKz7zDVbrvaOpHG3lXCdkbmNOKVOvMHdAB4GnLM/G9ZmdVyt7kZbUdDaPzSM
         dWxkCrAvsEljucw2ihOWEp6ZFwN8AZ7T7yUv7JksBkn1etKqZVl7kPFxo1RgyonRXd
         MCjD5Z7AKx0+6muAp3HyExXZDj6BKfLjBo3QGsbyCmlHI8MKnQdjE4shfvE761jN3v
         go3K9/3p1IyYzhBE8+mo9gAFdu/TKHN0jrllMxUrmn0e0RCsCKHchKl1UaEBi0o7z8
         oSkSMkTjdzesw==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Uladzislau Rezki <urezki@gmail.com>, rcu <rcu@vger.kernel.org>
Subject: [PATCH 0/3] RCU tasks for v6.7
Date:   Tue, 17 Oct 2023 14:19:02 +0200
Message-Id: <20231017121905.1156166-1-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Please find below the RCU tasks updates for the next merge window:

Jiapeng Chong (1):
  rcu-tasks: Make rcu_tasks_lazy_ms static

Paul E. McKenney (2):
  rcu-tasks: Add printk()s to localize boot-time self-test hang
  rcu-tasks: Pull sampling of ->percpu_dequeue_lim out of loop

Thanks,
        Frederic.

 kernel/rcu/tasks.h | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

-- 
2.34.1

