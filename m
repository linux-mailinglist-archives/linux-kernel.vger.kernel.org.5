Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC0575DDEE
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 19:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjGVRgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 13:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjGVRgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 13:36:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7E7213B;
        Sat, 22 Jul 2023 10:36:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D12EE60677;
        Sat, 22 Jul 2023 17:36:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 41968C433C8;
        Sat, 22 Jul 2023 17:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690047391;
        bh=gnnN2kNFZJiCcT8hxDUsG1HZ3P33IlzeLxlGvBtDKvU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Hxc8U6dpen/ZGCEzG6UBFxU7q0g21q06tQoLnihnMPaJRPkYFo8lPyW5Dxm5SMAdC
         g6yX/TVRPAXiR+gZxYOI1ghw7QWgjQfy/BGks5C1aAcDcc2xdfVTB7v1rBamMe4VKc
         6r8q5IJTU8s21Ex6wW7SQE8Xd7vSE+lEuW4uQjosLZHIlR2WZyUJtvv2X+yqRZ8xdo
         OUIXX5L+oDJAMTK1s3uTFIJXg2ALm5VCemnqtDMGGC30sFlnq2Ctu/aJX2SssJoKMs
         DgL996x0AKnin8N56MvhEQ4kyLfYKlGQtzzuLmmfYvw47TGjLbz9pKfJwEbx5JKeRE
         Mmg3hkJisLfVQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2DC63C595C0;
        Sat, 22 Jul 2023 17:36:31 +0000 (UTC)
Subject: Re: [GIT PULL] gpio: fixes for v6.5-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230721175134.186223-1-brgl@bgdev.pl>
References: <20230721175134.186223-1-brgl@bgdev.pl>
X-PR-Tracked-List-Id: <linux-gpio.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230721175134.186223-1-brgl@bgdev.pl>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.5-rc3
X-PR-Tracked-Commit-Id: 644ee70267a934be27370f9aa618b29af7290544
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c0842db5e52441174f347dd185bb06e841d7cfab
Message-Id: <169004739117.21373.8005551419389127039.pr-tracker-bot@kernel.org>
Date:   Sat, 22 Jul 2023 17:36:31 +0000
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 21 Jul 2023 19:51:34 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.5-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c0842db5e52441174f347dd185bb06e841d7cfab

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
