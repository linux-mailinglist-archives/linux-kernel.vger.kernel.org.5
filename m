Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8695E79093F
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 20:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbjIBSsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 14:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbjIBSsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 14:48:30 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1E2DD
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 11:48:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B6A38CE2621
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 18:48:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E2DC8C433C8;
        Sat,  2 Sep 2023 18:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693680504;
        bh=tbjemBdsSFrzYapabman+WiW7maKxo597atrS/poxDA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Zr9NI8P3Uu2DqqQjGYpi6qtJqag0yJkQUuSBkd32BM+M8FnfFzSQBfkUogChMoSNz
         rMUYkCBQG7wlbiacnW6RB4Il/gshwGWIGrLDk64/k9ocIS2DOpAYuOcWn42cxSn7a8
         wfAjCs9iSLfhRYcm24ik5/+AfpLzvgHDWSOHm34983hxzQijv+Gwiz2oKemKy+7KZD
         4ttYLPlPl3ziUbS0/n/y79sE/ojOfA18J4O7lhc3qJwuKP2ZllQWtT39gupDfYKRI4
         aZb4/GiJRApLoWz2mazNSI2tifJokZ5pmiM74nO+ZZMsZiaKNWCFUb5FJrXqgeAlR5
         Z/+6IaZy2Xrug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C62E4E26D49;
        Sat,  2 Sep 2023 18:48:23 +0000 (UTC)
Subject: Re: [GIT PULL] pstore fix for v6.6-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202309011125.B1C2550792@keescook>
References: <202309011125.B1C2550792@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202309011125.B1C2550792@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v6.6-rc1-fix
X-PR-Tracked-Commit-Id: 94160062396d7e7cff4ed69320ffc5e22d51a0ab
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 82c5561b57f8e871939e7fed02104c2572e8f48d
Message-Id: <169368050375.9288.3770785883041965071.pr-tracker-bot@kernel.org>
Date:   Sat, 02 Sep 2023 18:48:23 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 1 Sep 2023 11:27:10 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v6.6-rc1-fix

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/82c5561b57f8e871939e7fed02104c2572e8f48d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
