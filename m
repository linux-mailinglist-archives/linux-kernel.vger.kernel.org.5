Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86AA876F5DC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 00:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjHCWwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 18:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbjHCWwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 18:52:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9D2AC;
        Thu,  3 Aug 2023 15:52:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3234561ED0;
        Thu,  3 Aug 2023 22:52:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8B467C433C8;
        Thu,  3 Aug 2023 22:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691103162;
        bh=OIyXXsm8FvvLOGXhQpy/rnsQg7NCQW7MIKRY8FnIOuw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=f9fzrFXAC+pVRDuA6p2+3jw1oR1NAgGB7+BwdxiTWNtxcQiLfbYc1IesdRE6owdSZ
         XONB3GPrLprSwty0sdbU6EJQJIng/5Jv9VPKsXZwYgmuQlRCyMKAKxtGyJfUpO5igS
         Uyc2TfciB78RLz41EDSgYPcIM4aZ3Z2zwEOqDx3ZTFr/3Gyik8EgXKv0lCUA997h3+
         Q3YacZ7pjc6f4zxUQjhz/Uezfyw+ScdAhs71bB8SlpNkZznS1UC+Zo+ZJD3skfeTEP
         3IR5ZcWglc/Yjm3Om2p4h5OjLJtMkHNx1OPdXoLE5kZT5tMemnGLEg90SAUzBWK8ev
         VchPPzRu7fidg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 723B7C3274D;
        Thu,  3 Aug 2023 22:52:42 +0000 (UTC)
Subject: Re: [GIT PULL] perf tools fixes for v6.5: 2nd batch
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230803214502.19504-1-acme@kernel.org>
References: <20230803214502.19504-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-perf-users.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230803214502.19504-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v6.5-2-2023-08-03
X-PR-Tracked-Commit-Id: 07d2b820fd75b96f550c93503f19c8cfcbc577cf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c1a515d3c0270628df8ae5f5118ba859b85464a2
Message-Id: <169110316244.15224.406660124051677766.pr-tracker-bot@kernel.org>
Date:   Thu, 03 Aug 2023 22:52:42 +0000
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        =?UTF-8?q?Georg=20M=C3=BCller?= <georgmueller@gmx.net>,
        Haixin Yu <yuhaixin.yhx@linux.alibaba.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu,  3 Aug 2023 18:45:02 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v6.5-2-2023-08-03

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c1a515d3c0270628df8ae5f5118ba859b85464a2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
