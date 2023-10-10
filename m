Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE6DF7BF953
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 13:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbjJJLLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 07:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbjJJLLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 07:11:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801F5B4;
        Tue, 10 Oct 2023 04:11:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9943DC433C8;
        Tue, 10 Oct 2023 11:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696936260;
        bh=7E3Mgn8qXJeUH1aP4ft2CNwb5IC4XU/kYtU/S6Xhah8=;
        h=From:To:Cc:Subject:Date:From;
        b=RA2YvVxnqYDvDbjK5OZy+HU268qwocPitmuvZWLnXB9r9rOnzJDD+PhMjdNac5Df3
         KUgg2S+lXTcfLqhQsH9DutNN6BGPbG6FmnfEhxeVsSnstik+dkaoNcXWa8Z8QWKuzp
         I5ck1rUR2RqGiuFl5CzIgFBQUMSch8DCiYSPyT/6OSlW73pFyNXfr0lTCprWvY3Rjw
         spjjrDOA9yqRGKsqf9DXnuF72pjYzI5ikGTelwkkzPhkCjezMO1VzLxk16xn9ggbsf
         0QoLINdzCFfxrx16eH2KvxsdqjlpgqoaRoYjn+ZQlYjnhGqC+kJFfSMQ8BUCU4RcYq
         cDYioGYa6vcCQ==
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
Subject: [PATCH 0/3] RCU docs updates for v6.7
Date:   Tue, 10 Oct 2023 13:10:50 +0200
Message-Id: <20231010111053.986507-1-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
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

Hello,

This series contains RCU documentation updates:

1. RCU: Fix section numbers after adding Section 7 in whatisRCU.rst

2. Describe listRCU read-side guarantees

3. Remove references to rcu_migrate_callbacks() from diagrams

Thanks,
        Frederic.

 .../Design/Memory-Ordering/TreeRCU-callback-registry.svg | 9 ---------
 Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg  | 9 ---------
 Documentation/RCU/listRCU.rst                            | 9 +++++++++
 Documentation/RCU/whatisRCU.rst                          | 4 ++--
 4 files changed, 11 insertions(+), 20 deletions(-)

-- 
2.34.1

