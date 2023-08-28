Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C82FE78A3E2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 03:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjH1BWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 21:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjH1BVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 21:21:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86103106
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 18:21:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 24E336175C
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 01:21:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68712C433C7;
        Mon, 28 Aug 2023 01:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693185697;
        bh=nVQkoRp5KIedOJnMaua87s4ql4u4L/iw9uIp4Xn/oiM=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=BC4yegCAKqjeYnhllWqoGwGz4QmHgYqbq+oo4RQAi/0FUfO8nobb1ejP9e+in1w56
         ewSwpnyDL2HDluroiQ9Ki6swEs3DcpfejORIwvQM/psj/dZfuSO0bLr+Ku90NsyWuW
         sE0weW/07x1UrmeMl4DWddKNjjLJQhT38kYAHtRpGRqUnfwZvgAkPP92gj8toc69xB
         Se3LHXC+GqhAblNjbhOqpWS3oQBJKX2YV3IUkAHKPFWeg75kexoKOr82epXHtfA2hd
         AS5vcX/D5NDGOmxWf0Yy047Gius9ut0mJa3NeL2KwinRYFZzSPfkYS+ExO2FC5n+n6
         9mtAFq0zAx4oQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 6CFD5CE0D0C; Sun, 27 Aug 2023 18:21:35 -0700 (PDT)
Date:   Sun, 27 Aug 2023 18:21:35 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com, x86@kernel.org,
        feng.tang@intel.com, tglx@linutronix.de
Subject: [GIT PULL clocksource] Clocksource watchdog commits for v6.3 (to
 complete the set for v6.6)
Message-ID: <8016ce16-e049-4e27-9f98-29c52bb60145@paulmck-laptop>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus,

Once the v6.6 merge window opens, please pull these clocksource changes:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/clocksource.2023.08.15a
  # HEAD: 233756a640be811efae33763db718fe29753b1e9: x86/tsc: Extend watchdog check exemption to 4-Sockets platform (2023-07-14 15:17:09 -0700)

Next merge window, I will take care to double-check beforehand to ensure
that the subject line does not assume that you have a time machine.  In
the meantime, why not continue the trend?  ;-)

----------------------------------------------------------------
Clocksource watchdog commits for v6.6

This pull reqeust contains the following:

o	Handle negative skews in "skew is too large" messages.

o	Extend watchdog check exemption to 4-Socket platforms

----------------------------------------------------------------
Feng Tang (1):
      x86/tsc: Extend watchdog check exemption to 4-Sockets platform

Paul E. McKenney (1):
      clocksource: Handle negative skews in "skew is too large" messages

 arch/x86/kernel/tsc.c     | 2 +-
 kernel/time/clocksource.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)
