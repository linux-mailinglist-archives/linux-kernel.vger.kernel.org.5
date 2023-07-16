Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21DF77550FB
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 21:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjGPTaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 15:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjGPTaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 15:30:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9C4E4E
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 12:30:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4E7F60E15
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 19:30:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 45846C433CA;
        Sun, 16 Jul 2023 19:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689535804;
        bh=Q4q6k8Rw+AgnwQAtrZuzjvSEhnmZ9oT4DHXxqkAhvgw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=G7XH1Q1NsSXjovghE/kIaS5u2t8boOM2mPxm4Kvni+542bxGQ3XAF9mpNp97C2VQd
         ut5aUi8S8Lu0XFJ66W+2s4eHYETf6XAoQ0MRgbCWnGvE4f5+qnXQx/3Cx/5osA6BKk
         cFVoiIe/bJ3/QLWPgjiCplm4SgUieXKdtFXrvvc6suqLGr/Ctc3xf69vGOv1kkoaW8
         XHO9D+ILA0kYLHolHbzylo/eYieIFLECc/AGB4TQghQM5mrvp90O3eVFbV0HSikG7F
         xWMjAoR5kDZnZdWTU7/61iJKkPhV8vgV0Iu4sOGLeb8Fyq+sbF46xBTcDPkTHJbJAM
         HLfuJ0Tg2vB9g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 272FDC6445A;
        Sun, 16 Jul 2023 19:30:04 +0000 (UTC)
Subject: Re: [GIT PULL] hardening fixes for v6.5-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202307151737.BF9E8B84@keescook>
References: <202307151737.BF9E8B84@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202307151737.BF9E8B84@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.5-rc2
X-PR-Tracked-Commit-Id: ec7633de404e7ce704d8f79081b97bca5b616c23
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6eede0686f2f4a1b026a5714cb0481d074085855
Message-Id: <168953580415.22660.14756231239346878570.pr-tracker-bot@kernel.org>
Date:   Sun, 16 Jul 2023 19:30:04 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Petr Pavlu <petr.pavlu@suse.com>,
        Sam Ravnborg <sam@ravnborg.org>, Song Liu <song@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Zhen Lei <thunder.leizhen@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 15 Jul 2023 17:42:32 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.5-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6eede0686f2f4a1b026a5714cb0481d074085855

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
