Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C14776F54
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 07:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232754AbjHJFCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 01:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbjHJFCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 01:02:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBE41BCF;
        Wed,  9 Aug 2023 22:02:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DEB1264D22;
        Thu, 10 Aug 2023 05:02:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 38E3AC433C8;
        Thu, 10 Aug 2023 05:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691643760;
        bh=A2VJ0L4yOT0ZO77U83OfwXD8T8Pk9HLu/MR2DsKOdfg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=bGFPF4GDjBr8PtNT7jtFU9nPvk2snc3BZJtoLG+KortoJFMhHr1Wkry7/EbRKlBad
         Px+TshPpUlC8gHpQvKN0VoXd443hX7cpu/Dmuv1+cDB1C0ZzLuuJsJIlqzd8x/juAa
         kuFlEe2NRT0E5IsA1bV/WJoOBcaASUiDdb9PaTxUTpuJ+Ayjk3JLV/DjSirhppJXs3
         8XV8yz3IEkQw8cXadLGFPRSK4Z5N6vFRM1XNEt3CVkUS8NW8AOJpqguy01J1DzjARO
         x+Iq89z0PlWRqMv5oSLH2ps0cHa+BbXWBZGvMmpOxSv0WQLdVIpq6D87Zln9rxxwXS
         NdUoldYWfDmFQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 26601C395C5;
        Thu, 10 Aug 2023 05:02:40 +0000 (UTC)
Subject: Re: [GIT PULL] perf tools fixes for v6.5: 3rd batch
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230809211019.121189-1-acme@kernel.org>
References: <20230809211019.121189-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-perf-users.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230809211019.121189-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v6.5-3-2023-08-09
X-PR-Tracked-Commit-Id: 487ae3b42d1040b4cd5ff9754e7516b409204029
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b4f63b0f2d170b9dfae0de3fd2981424873cce2b
Message-Id: <169164376014.10677.2525945242591254111.pr-tracker-bot@kernel.org>
Date:   Thu, 10 Aug 2023 05:02:40 +0000
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
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed,  9 Aug 2023 18:10:19 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v6.5-3-2023-08-09

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b4f63b0f2d170b9dfae0de3fd2981424873cce2b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
