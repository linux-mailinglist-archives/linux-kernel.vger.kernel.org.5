Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F45B758855
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 00:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbjGRWQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 18:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbjGRWQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 18:16:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08E3198D;
        Tue, 18 Jul 2023 15:16:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4DF546126C;
        Tue, 18 Jul 2023 22:16:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A7597C433C7;
        Tue, 18 Jul 2023 22:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689718574;
        bh=fAsWtDGuusE0QW9q58XQTB8JznHo+i2FpUyePvySw8E=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=pN1sC0enqj/iR8ea/VxSxwpd/TWn/xY7B0jyZ+SUXzOvfN67BjpmuI6zzh/k9tm+f
         DpMv9NpeUSec0qKFRbMVedhZZQdNkNOAOXQZj7w6I+aWsIS8S8/IO7VHJjueUBDKGZ
         JkZfjybaIFKpIeT89Ih4qRtK++07dxuT8DPo4ZHlT6JQl+oyowRSzFPVzTgNUIXWrr
         afuFoVP6ichnpb6FyKte0KX84dr1L6cjH2abLNnIlKEun4eH0xka8kFxF40dZe4fWK
         x3vWjQ0Dx61JniLrNF9Q3ppLYOhnhOcVLwOJ6h3W/P6wCCAD0iD7s0X7Nfeyso/253
         9hoa8iCYwxSdA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 94053C64458;
        Tue, 18 Jul 2023 22:16:14 +0000 (UTC)
Subject: Re: [GIT PULL] perf tools fixes for v6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230718194602.444597-1-acme@kernel.org>
References: <20230718194602.444597-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230718194602.444597-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v6.5-1-2023-07-18
X-PR-Tracked-Commit-Id: 2480232c61b888a160153b9022858ac8c4362d5f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ccff6d117d8dc8d8d86e8695a75e5f8b01e573bf
Message-Id: <168971857459.2335.8703651309773236737.pr-tracker-bot@kernel.org>
Date:   Tue, 18 Jul 2023 22:16:14 +0000
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
        Ayush Jain <ayush.jain3@amd.com>,
        =?UTF-8?q?Georg=20M=C3=BCller?= <georgmueller@gmx.net>,
        James Clark <james.clark@arm.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
        Sandipan Das <sandipan.das@amd.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 18 Jul 2023 16:46:02 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v6.5-1-2023-07-18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ccff6d117d8dc8d8d86e8695a75e5f8b01e573bf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
