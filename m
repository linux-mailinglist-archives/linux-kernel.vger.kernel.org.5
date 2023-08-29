Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BCC678CBC9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 20:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbjH2SIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 14:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238233AbjH2SII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 14:08:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F17B132
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 11:08:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF54A65390
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 18:08:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 20811C433C9;
        Tue, 29 Aug 2023 18:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693332485;
        bh=lbo/eAw3tvZy/TMTDTUOLtW0n7eKg0rYb7Jr1Qal9d0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=aoPk8/9kaBkSnOnMXEIb4xJHZkZKuvF1EFajpWbM1X/DxsLpufdzBtKYZJZj6bnvF
         RdpkBds7fUQzlPKVpofRVvN5FYsjmKXQV0MorwK3nczdadUqThCDWfBXR9gJ4lXM3C
         7lQhPss4C7Wubn4dvSWbMATxIOQPNZ/eAk9Bqaj/I9rBkZDcppWdTZntm0ydagkSSt
         bb+XAqq4uaqK2N2mAc8HYrAjUB4Zd1ssqp7VreKGIpjTYc8/5VlleOCaRXacjwxcgV
         NOpY9tfC52GDn/+keIDUS4DrcSjFPdx7c3w3JCS4DRKxSju8bqdmllwvEjtHYQmfgR
         eTYGyMA9Ob40A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0D52BC3959E;
        Tue, 29 Aug 2023 18:08:05 +0000 (UTC)
Subject: Re: [GIT PULL] Rust for 6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230824214024.608618-1-ojeda@kernel.org>
References: <20230824214024.608618-1-ojeda@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230824214024.608618-1-ojeda@kernel.org>
X-PR-Tracked-Remote: https://github.com/Rust-for-Linux/linux.git tags/rust-6.6
X-PR-Tracked-Commit-Id: 4af84c6a85c63bec24611e46bb3de2c0a6602a51
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a031fe8d1d32898582e36ccbffa9847d16f67aa2
Message-Id: <169333248504.16601.3296363879442058002.pr-tracker-bot@kernel.org>
Date:   Tue, 29 Aug 2023 18:08:05 +0000
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 24 Aug 2023 23:40:22 +0200:

> https://github.com/Rust-for-Linux/linux.git tags/rust-6.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a031fe8d1d32898582e36ccbffa9847d16f67aa2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
