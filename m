Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9321D78B96F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 22:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234206AbjH1UPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 16:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234076AbjH1UPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 16:15:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A26109
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 13:15:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C9E3F6511A
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 20:15:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3B51DC433CA;
        Mon, 28 Aug 2023 20:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693253706;
        bh=99PzP22nluIpNi/suvnSaV0VAUrLrTk0+TGcj9u9A2o=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Ci2yuYIxG8lZkRxjg9vsv3GbMf1Ns9vROf98PL90cTAx68SFETJ2xjwh1C+J+2i8E
         vaA7It96zKIE8p6/hsDe0ZcLB2OHfZM1wbBh6V3K3MlSdkdG3uYMivPGWR7KD0svE+
         O+IiJw32L5ZHYByeCfhTNlyjJVnaSNzUvEB6xFLGkePz8yB4IBr8a45rjDTvOZRzIM
         R6p8PG6p7OKPRso2OrKiKBKMbPHTTiVv6oLBN6HfRRBjEzCMb8fCD4KxlApn7+3XH+
         7gud3uFugKE2ewK2YhVmkF2tkdmL0UQdrCfkpSnmjGRAx5tNC1dkZ5Ooe3e5YH41Yi
         IynMLHN2rzsKg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2A8CBC3274C;
        Mon, 28 Aug 2023 20:15:06 +0000 (UTC)
Subject: Re: [GIT PULL] pstore updates for v6.6-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202308281119.10472FC7@keescook>
References: <202308281119.10472FC7@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202308281119.10472FC7@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v6.6-rc1
X-PR-Tracked-Commit-Id: af58740d8b06a6a97b7594235a1be11bd6aa37fa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5b07aaca1809f459d74589c38b20f87da554027f
Message-Id: <169325370616.5740.8013796598006117050.pr-tracker-bot@kernel.org>
Date:   Mon, 28 Aug 2023 20:15:06 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Enlin Mu <enlin.mu@unisoc.com>,
        Eric Biggers <ebiggers@google.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Kees Cook <keescook@chromium.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Yunlong Xing <yunlong.xing@unisoc.com>,
        Yuxiao Zhang <yuxiaozhang@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 28 Aug 2023 11:21:23 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v6.6-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5b07aaca1809f459d74589c38b20f87da554027f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
