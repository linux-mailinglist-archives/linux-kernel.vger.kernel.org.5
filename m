Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BAD376879A
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 21:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjG3Tnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 15:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbjG3Tn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 15:43:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C513210DE
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 12:43:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C93460D30
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 19:43:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 77E42C433CA;
        Sun, 30 Jul 2023 19:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690746206;
        bh=7wwvn9mrGDBqlHH1nu+dBlbubHd1T8vrGcKcaPVbzV0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=BvG+sDXXOE+R+Jc7NnkyrKgcDlUkB3snrviHeaGc7nFFdvhFwPtZ96/nni1Ag4NNm
         lvwCyQktTik2tk9Ti6q/VYiXNbYlmsSALbqgkYJNe+SdO5Yj8qvUSt0QUkQ5q4zOt6
         AslE/6XeeEki0WsbVx7gD6A0pwyMZr0oqKwG2vMcKz3Qob9HTYpDix/UKnX5yYs0u5
         UHYWDL+rar+0zY801Yx2sx1WAUC7POy5PlOFJ0fImqpy65RRoGIzFXDBnnEd3keh6k
         WFacf7oQoPCvQ8J/ZCZZGVQcRSDS6uYRFJQ/MMpNfQtph18nu8/G3oNcZoy9WiMUrV
         KZil6AVtQ9SQw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 624F3C43169;
        Sun, 30 Jul 2023 19:43:26 +0000 (UTC)
Subject: Re: [GIT PULL] locking/urgent for v6.5-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230730094410.GCZMYw6t2O0L+N/93z@fat_crate.local>
References: <20230730094410.GCZMYw6t2O0L+N/93z@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230730094410.GCZMYw6t2O0L+N/93z@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/locking_urgent_for_v6.5_rc4
X-PR-Tracked-Commit-Id: f7853c34241807bb97673a5e97719123be39a09e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c959e90094d6db8ee1bfbe1a9c571fbd35d4daac
Message-Id: <169074620639.25913.9055307350740898891.pr-tracker-bot@kernel.org>
Date:   Sun, 30 Jul 2023 19:43:26 +0000
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 30 Jul 2023 11:44:10 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/locking_urgent_for_v6.5_rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c959e90094d6db8ee1bfbe1a9c571fbd35d4daac

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
