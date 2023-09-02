Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9172A7908A1
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 18:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234095AbjIBQN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 12:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234010AbjIBQNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 12:13:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D32EE72
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 09:13:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C790A602F3
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 16:13:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 39479C433CB;
        Sat,  2 Sep 2023 16:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693671201;
        bh=w9l+29EAlY5G9t8mknRVsSA342zXuViuIvYgQa2PX1E=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=WM2Lagk+zoj2qkGMWpoLDq4xSElipI2h9zLPAogHuRMtGHs3+7X7TPIpXS8/Ew6zX
         ECW/yuD0dAlFTF5tRB+1F3p1fiVGw35n6xZs6jILP5kUtukupb7T3roFppV0GiWk+b
         b0IIj5TxiZXi72lJVZ7h0bsAprOplFEcTbo0KsndPvo3NQ2HBU3p0PmYxz0I4QmxcU
         L/3j0tDvy0XPi+LoyXuBNmMyShNUvGVgmaUIli8DLVYn+h785Vhca4+6divceMqjuR
         fJ2FLioUmu+kwe2oQ+vjtkuGyX7waRU0mUBRHKeYXDpsmmbHaerA1UZerosukH36Fg
         nKaNC9X8kIkvQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 24906C595D2;
        Sat,  2 Sep 2023 16:13:21 +0000 (UTC)
Subject: Re: [GIT PULL] x86 fix
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZPMNXtbIPMdjdn3o@gmail.com>
References: <ZPMNXtbIPMdjdn3o@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZPMNXtbIPMdjdn3o@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2023-09-02
X-PR-Tracked-Commit-Id: 6ea7bb00c1ba180f8bf8320b8d59b532501c5271
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fdde6187804782dce49c78d00e04bac6535628c7
Message-Id: <169367120114.31473.13592544231829289350.pr-tracker-bot@kernel.org>
Date:   Sat, 02 Sep 2023 16:13:21 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 2 Sep 2023 12:24:30 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2023-09-02

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fdde6187804782dce49c78d00e04bac6535628c7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
