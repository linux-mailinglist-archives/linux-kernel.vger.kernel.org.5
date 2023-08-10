Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA0C776F55
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 07:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232868AbjHJFCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 01:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbjHJFCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 01:02:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5292112;
        Wed,  9 Aug 2023 22:02:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8050564D5E;
        Thu, 10 Aug 2023 05:02:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DDB86C433D9;
        Thu, 10 Aug 2023 05:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691643760;
        bh=1JWYfYzQIxC8qLRUPGAeiYfCj7cQn8F2X277FTh1lyA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Hxw/UWAP9Lqe1oYxbXDg9CMXAGfi8k+ENeNzYzjexnplLQg64JXCOxQbVg1AFO0dS
         xWx1qNDGhTreuuwP0DNqRZXG3xa31ki6FYaqaPqlE3Pm579Afb/GoBFesE3zx1b2Lo
         D4ZnvPbEGtGTcqtoL9EaD7ZYQRbKAblWobOWzGdZ3ERTW4CtNHQOYNv8W083jiIocj
         JbGSO+2uwPs9XPH21yvlfL9X/jaQ4E2UserM3BZXBMQ8aUaAUfMoze91fUeygQjZ5l
         JmFN7xMah+hVNZASvc/R1G+cAK/u5a8KRY/Jv1gNTbjVUGQy6jw1SJMJ7ijnzqD7e6
         Qw4ndyfuR0Y8w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CBDCAC395C5;
        Thu, 10 Aug 2023 05:02:40 +0000 (UTC)
Subject: Re: [GIT PULL] ksmbd server fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mv+Sy5mrZThrQUf1na-mg-B9DiLd5fkYs9sPo97GWirCA@mail.gmail.com>
References: <CAH2r5mv+Sy5mrZThrQUf1na-mg-B9DiLd5fkYs9sPo97GWirCA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-cifs.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mv+Sy5mrZThrQUf1na-mg-B9DiLd5fkYs9sPo97GWirCA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/ksmbd.git tags/6.5-rc5-ksmbd-server
X-PR-Tracked-Commit-Id: 79ed288cef201f1f212dfb934bcaac75572fb8f6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 374a7f47bf401441edff0a64465e61326bf70a82
Message-Id: <169164376083.10677.9868147352244358392.pr-tracker-bot@kernel.org>
Date:   Thu, 10 Aug 2023 05:02:40 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        Namjae Jeon <linkinjeon@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 9 Aug 2023 18:11:07 -0500:

> git://git.samba.org/ksmbd.git tags/6.5-rc5-ksmbd-server

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/374a7f47bf401441edff0a64465e61326bf70a82

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
