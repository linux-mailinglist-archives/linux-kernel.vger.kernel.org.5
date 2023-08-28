Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8A078B96D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 22:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234186AbjH1UPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 16:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233543AbjH1UOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 16:14:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F21EC;
        Mon, 28 Aug 2023 13:14:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 203ED6513F;
        Mon, 28 Aug 2023 20:14:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7E5DFC433CB;
        Mon, 28 Aug 2023 20:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693253691;
        bh=wGhF7EuXJqNVSTB3Dp3kmq11CJkRkdQN0/EBu35wj7c=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Uv29Ja8kUrvS0TQSDoPqnDl5x1DXCs4Lq75n0JAjGcalKA84ddkFHsaxYmWot0Gti
         1NLQL52re6BU98YY2w70hDPPdJqMKS4gXpkGJxX/mkn90Quo8mIDI3r39bUkeT39HB
         k/s7WtH2j2IHIzuYoBqSFlIXC3YIMt5yvJI3ttocO8AbGSduUMdjc8W+5mFTHXoO08
         4H0MwxtoaGcDqsvxTJHk8NCdNgwk3ZEnLQX8yAxIGG1OuTmEqWrAMDHtH3uZH9JIEf
         eubve9nW1PQ9e9sLF8XR2jkkDEE58ilzd2e0r4HS1Iyg+8vhTDWuKef6L29GJUGgTc
         MSFrYtkLI0Rag==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 69DA6C3959E;
        Mon, 28 Aug 2023 20:14:51 +0000 (UTC)
Subject: Re: [GIT PULL] hardening updates for v6.6-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202308281138.5E9835A@keescook>
References: <202308281138.5E9835A@keescook>
X-PR-Tracked-List-Id: <linux-hardening.vger.kernel.org>
X-PR-Tracked-Message-Id: <202308281138.5E9835A@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.6-rc1
X-PR-Tracked-Commit-Id: 5f536ac6a5a7b67351e4e5ae4f9e1e57d31268e6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 727dbda16b83600379061c4ca8270ef3e2f51922
Message-Id: <169325369142.5740.5192469254334945438.pr-tracker-bot@kernel.org>
Date:   Mon, 28 Aug 2023 20:14:51 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        David Windsor <dwindsor@gmail.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Hans Liljestrand <ishkamiel@gmail.com>,
        Jann Horn <jannh@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Justin Stitt <justinstitt@google.com>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Song Liu <song@kernel.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        linux-hardening@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 28 Aug 2023 11:42:58 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.6-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/727dbda16b83600379061c4ca8270ef3e2f51922

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
