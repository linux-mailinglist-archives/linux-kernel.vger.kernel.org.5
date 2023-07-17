Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C361756BBF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 20:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbjGQSUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 14:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjGQSUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 14:20:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD33BE;
        Mon, 17 Jul 2023 11:20:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B80CD61191;
        Mon, 17 Jul 2023 18:20:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D01FC433C8;
        Mon, 17 Jul 2023 18:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689618029;
        bh=zvX/fJR4ixMTHVYFjHXgwp7yRxlCkcIyvkGIOEznGqc=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=DnxKFRct5cI0jyM5Y5p6z+tg2zKGbSacYRAVJjZ8E5GDzm3zdjDRYFYv2Z6So8dp8
         SdJEqo4ecCIdhxDuD7Y9BNYP0pXpBZuqpyM2Onxvy6n4azZkqy7E4PPE2uPKCT5RqE
         yTG8lkVddD6qwivxPxByy5Csu5YdhYMQmLzTneiGDGgOcJSAKXVZaEj26oijHv5a6D
         FekRCP2HV1cMxRz23g2ni37n7ikQGY7q1QM+KqdW28a6elo5UrS6xNas5DD3TI1pBF
         Gfdg43TiYRycG6qLRURGxZgsfkxgy8YMpbRR00nViKKZ2hCVNmTxjkZYLyTrTwFaKL
         8/a2p8HZCKh1g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id BE636CE03F1; Mon, 17 Jul 2023 11:20:28 -0700 (PDT)
Date:   Mon, 17 Jul 2023 11:20:28 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org
Subject: [PATCH rcu 0/9] Torture-test updates for v6.6
Message-ID: <bca717ca-a83a-4540-80ec-732c12623d2d@paulmck-laptop>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series contains torture-test updates:

1.	Dump grace-period state upon rtort_pipe_count incidents.

2.	Support randomized shuffling for proxy exec testing, courtesy
	of Connor O'Brien.

3.	Add lock_torture_writer_fifo module param, courtesy of Dietmar
	Eggemann.

4.	Make torture_hrtimeout_*() use TASK_IDLE.

5.	Move torture_onoff() timeouts to hrtimers.

6.	Move torture_shuffle() timeouts to hrtimers.

7.	Move stutter_wait() timeouts to hrtimers.

8.	Stop right-shifting torture_random() return values.

9.	Stop right-shifting torture_random() return values.

						Thanx, Paul

------------------------------------------------------------------------

 b/kernel/locking/locktorture.c |    3 ++-
 b/kernel/rcu/rcutorture.c      |    1 +
 b/kernel/torture.c             |   10 ++++++++--
 kernel/rcu/rcutorture.c        |    6 +++---
 kernel/torture.c               |   31 +++++++++++++++++++++----------
 5 files changed, 35 insertions(+), 16 deletions(-)
