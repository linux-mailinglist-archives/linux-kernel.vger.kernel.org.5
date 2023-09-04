Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 151A7791FA0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 00:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242469AbjIDWuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 18:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237853AbjIDWur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 18:50:47 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479E2E56;
        Mon,  4 Sep 2023 15:50:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A2217CE0F08;
        Mon,  4 Sep 2023 22:50:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ED997C433C7;
        Mon,  4 Sep 2023 22:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693867826;
        bh=bul7XTQH+Odep7p/owSDkFaCfYCDCqsUnX0WOMdnahk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Dvavh2ChjX2jFdMvxdcayHuqIXqa1dppJPI/UBJlpn4tvaITrmwdMeLJ95212QSMp
         /rFfXJdsxoaPPae+6p1WQng6SztHCl4y89NmwfUNne5CnVoy1mTpKvFI+W83zmsJDw
         DYYoiAZfdR9X+DhsdaV9hPykgrTgLNMCMQu9dfiL6rh0ILv6WMjXc4v8WsNYhusmOg
         6gd3WswraWy/afHiQ5naNFuvCUMY3/JoBL5wwDUzhtnkFtl6unMDb9aXG/chN9FDUC
         WIsSmAyU8QNlC6lkQ7Pfpxwet1hEAzxCEgRoyedU/zZkzlc8C2Hdw1K+hhMoWcLMl3
         Ysi6iafDbK94g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D79F1C0C3FD;
        Mon,  4 Sep 2023 22:50:25 +0000 (UTC)
Subject: Re: [GIT PULL] hwspinlock updates for v6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230904155508.2950832-1-andersson@kernel.org>
References: <20230904155508.2950832-1-andersson@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230904155508.2950832-1-andersson@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git tags/hwlock-v6.6
X-PR-Tracked-Commit-Id: 23316be8a9d450f33a21f1efe7d89570becbec58
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e3a6fa001dbbf36833159baffc584d1aaa4b11e3
Message-Id: <169386782587.10061.11044927776636844963.pr-tracker-bot@kernel.org>
Date:   Mon, 04 Sep 2023 22:50:25 +0000
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Kang Chen <void0red@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon,  4 Sep 2023 08:55:06 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git tags/hwlock-v6.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e3a6fa001dbbf36833159baffc584d1aaa4b11e3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
