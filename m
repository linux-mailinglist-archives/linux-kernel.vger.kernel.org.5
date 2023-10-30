Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1DCD7DC268
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 23:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbjJ3W1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 18:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjJ3W1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 18:27:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F393FC6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 15:26:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85AD1C433C7;
        Mon, 30 Oct 2023 22:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698704818;
        bh=dBrSuxwaeIg1FualshzSIk3eH/YFMtHDZ8yNgS5Qxqo=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=E/oJigprznhoKI3zHaDXPq1e6rIE7wtAHgrlkGq438SZqY0mE56rCQKCxYTVBfn2q
         w7799v94OuTgPOHl+Cfz/HqydOkR5Kf/a38stW1zXkzNMqpB3NDr5H+pS51W+Q0x0s
         eYS4jXYaaYFgHPkoVXpKknv24wPjieQ7mfnpJ1BeBBwY2WGaGlw56j0i3YsT2VYajR
         iDwHvWTlx6pIM+xMzmSlWvMcZpS+V+r3JnO4LV+jLNLxd5a6ixnxPvxvANzBPrVF6F
         yhWP+k3LheFhRbghRbWDlQQwjMiSU22BBfOdLXtvV3kkr9sTkHZBc1GqH/3S3DbZp3
         dbHLbm1bYzhFg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 27005CE0BDD; Mon, 30 Oct 2023 15:26:58 -0700 (PDT)
Date:   Mon, 30 Oct 2023 15:26:58 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        riel@surriel.com, imran.f.khan@oracle.com, leobras@redhat.com,
        peterz@infradead.org, vschneid@redhat.com, jgross@suse.com
Subject: [GIT PULL] CSD-lock diagnostic changes for v6.7
Message-ID: <5a551b5a-7430-4916-9a23-b235b19d6283@paulmck-laptop>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus,

Please pull the following CSD-lock change:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/csd-lock.2023.10.23a
  # HEAD: 94b3f0b5af2c7af69e3d6e0cdd9b0ea535f22186: smp,csd: Throw an error if a CSD lock is stuck for too long (2023-10-16 16:06:37 -0700)

----------------------------------------------------------------
CSD lock commits for v6.7

This series adds a kernel boot parameter that causes the kernel to
panic if one of the call_smp_function() APIs is stalled for more than
the specified duration.  This is useful in deployments in which a clean
panic is preferable to an indefinite stall.

----------------------------------------------------------------
Rik van Riel (1):
      smp,csd: Throw an error if a CSD lock is stuck for too long

 Documentation/admin-guide/kernel-parameters.txt |  7 +++++++
 kernel/smp.c                                    | 13 ++++++++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)
