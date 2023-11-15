Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 442CE7ECB03
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 20:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjKOTLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 14:11:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbjKOTLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 14:11:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0745BC7;
        Wed, 15 Nov 2023 11:11:31 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71F14C433C8;
        Wed, 15 Nov 2023 19:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700075491;
        bh=utQMX46a5Id7Ojp2vJ/SRydjItBXfZmfdXR1HetZfx0=;
        h=From:To:Cc:Subject:Date:From;
        b=R05TC6VBCJwPVHLA8t2VDACEiReA2YxNYa68NSIqyUEAnMq1DZGNVV9mN4aAj+ogZ
         NSjZF51Q61tiSRIHpYuWLUpy0Zziv9CtAjIc893tEiGsSlIqCa1ev3XyY/hm+3DbNr
         QoJvE2vKh2vs5Z/SGNbiutmRb7n0Bn0Wi7+uRL3ZwwCiPhT0rtHGJ+A10AxKZutuvH
         pkeKV5StC4qOxcPj3kRvjWAFWggeAZp5iGJBdB9JVcnz96Lfj1ATyhA+sJ47QJYW9o
         2OO5NDp0qkT8aYJYUUF/9gGJ0xkbxsLZL4kEw/u70ADBgwz894G7MyNocVVkHSMysX
         oHfMIy7OCzgqw==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 0/3] rcu/nocb updates v2
Date:   Wed, 15 Nov 2023 14:11:25 -0500
Message-ID: <20231115191128.15615-1-frederic@kernel.org>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is a re-issue of some leftovers from a previous patchset.
Changes since last time:

1) Use rcu_get_jiffies_lazy_flush() instead of the raw variable (thanks Joel)
2) Further comment ordering expectations between grace period end and
   callbacks execution.
   
Thanks.

Frederic Weisbecker (3):
  rcu: Rename jiffies_till_flush to jiffies_lazy_flush
  rcu/nocb: Remove needless LOAD-ACQUIRE
  rcu/nocb: Remove needless full barrier after callback advancing

 kernel/rcu/rcu.h       |  8 ++++----
 kernel/rcu/rcuscale.c  |  6 +++---
 kernel/rcu/tree.c      |  6 ++++++
 kernel/rcu/tree_nocb.h | 26 ++++++++++++--------------
 4 files changed, 25 insertions(+), 21 deletions(-)

-- 
2.42.1

