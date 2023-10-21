Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4731F7D1EC6
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 19:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231945AbjJUR5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 13:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbjJUR5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 13:57:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2DF9188;
        Sat, 21 Oct 2023 10:57:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AB858C433C9;
        Sat, 21 Oct 2023 17:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697911027;
        bh=UdYYyXcbibc9Zo8KuCRiWZRiJKBRaEOHrA6cF5q26Vo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=aNjv4E7YNkDC9LYvx09vXxj6IqlSEGA1ZSthRFc7jpPP7RtO3ou8JUPgFnzkgmvlj
         fIl2lHcJlPVngO3XGTuDhFCLgwjZiWB7aj84qE9QjPStmtd4MG+4xBWUYX3hAAw0vZ
         VkeTYyXiccocRHIssdz9dNBhEvsNPy9mA491sBW29YaX9sSVNYYfVPtyZcKqioh+yb
         iL+yWd1IfOZcdfMlNrT/BWIia1TWvOQ1qf63kuC3gLgU0L7A45eEOM/dqv3PeoGfIf
         cJAsgqi++gYhRoVZGK5UOuTkW16RfBczHqVCj3jmZFoOs5D/lFiokNbFR2/NmIh1qN
         JtVNyqk1NHJdw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 98DD8E4E9B6;
        Sat, 21 Oct 2023 17:57:07 +0000 (UTC)
Subject: Re: [GIT PULL] Crypto Fixes for 6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZTOYe9lZvPxxFDm+@gondor.apana.org.au>
References: <Y1thZ/+Gh/ONyf7x@gondor.apana.org.au>
 <Y7fmtJHWT1Zx+A1j@gondor.apana.org.au>
 <ZARrt99wJb7IhoY4@gondor.apana.org.au>
 <ZFeldCJcieIlXKJ8@gondor.apana.org.au>
 <ZHQe9A8CC93iCFMG@gondor.apana.org.au>
 <ZKtH5zrS4pR22PGT@gondor.apana.org.au>
 <ZOLcCC523FoBAyv0@gondor.apana.org.au>
 <ZPAiMYaqUslSyZ6+@gondor.apana.org.au>
 <ZQz3qxwwAjDaqi5V@gondor.apana.org.au>
 <ZSUPdPFo+M/rQhwo@gondor.apana.org.au> <ZTOYe9lZvPxxFDm+@gondor.apana.org.au>
X-PR-Tracked-List-Id: <linux-crypto.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZTOYe9lZvPxxFDm+@gondor.apana.org.au>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git v6.6-p5
X-PR-Tracked-Commit-Id: b11950356c4b416d2e87941f3aa7a8bf089db72b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f1de9aced809f1751bc97703bdf678c75da3fed3
Message-Id: <169791102762.24251.9920455221817967817.pr-tracker-bot@kernel.org>
Date:   Sat, 21 Oct 2023 17:57:07 +0000
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 21 Oct 2023 17:23:07 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git v6.6-p5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f1de9aced809f1751bc97703bdf678c75da3fed3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
