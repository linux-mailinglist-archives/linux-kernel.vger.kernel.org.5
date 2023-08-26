Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E10578989A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 20:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbjHZSJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 14:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbjHZSI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 14:08:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1C01711
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 11:08:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C039262437
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 18:08:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 103CEC433C8;
        Sat, 26 Aug 2023 18:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693073334;
        bh=ifnoNNwq6D5LDNLUIVQ0u3oj+uGHxFSLn2T8iZuNR7I=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=nlFEHPPVJ7vILA3dhnbdeLguHpLiQKDIEZ0/4l4qOmCz7m0zCYtBxzyOMiz+UBvON
         02BSq/3mdQl0om4SMRLEA2i5TnD0mOYLEj3CUM8eCXHjHpX54zydeUYA4SKgpgxvk+
         kT8pBhlAe0exrC85H9ZGc2sMfidRN8TseA5nlio2tORrYu/0kBftNjS8hoIrZwJywu
         6pb6YCIeTbT1rIV8FiNYFZa5SF4vWTgIMTaawY0C8uuzOVerPQiUjv6GBZpFOhXK17
         CM1XbAs7m+z0W0YbkJ1/Gl7/17A+rqGeqNESwMsrOoDwpLn0mGngdmBFDInsJmp7Hi
         PnzbrlzsfkjzQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DD3B0C595C5;
        Sat, 26 Aug 2023 18:08:53 +0000 (UTC)
Subject: Re: [GIT PULL] x86 fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZOo8XxiWEKL+BJeB@gmail.com>
References: <ZOo8XxiWEKL+BJeB@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZOo8XxiWEKL+BJeB@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2023-08-26
X-PR-Tracked-Commit-Id: 2c66ca3949dc701da7f4c9407f2140ae425683a5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 28f20a19294da7df158dfca259d0e2b5866baaf9
Message-Id: <169307333383.28172.7712860656083367167.pr-tracker-bot@kernel.org>
Date:   Sat, 26 Aug 2023 18:08:53 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 26 Aug 2023 19:54:39 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2023-08-26

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/28f20a19294da7df158dfca259d0e2b5866baaf9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
