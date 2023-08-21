Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04AC378230D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 07:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233111AbjHUFJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 01:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbjHUFJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 01:09:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C55AA3;
        Sun, 20 Aug 2023 22:09:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF49A6211D;
        Mon, 21 Aug 2023 05:09:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1EC99C433C8;
        Mon, 21 Aug 2023 05:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692594572;
        bh=j6ij77EnFm9Ol/Rp1lfopR1wSlmY0sGy4B+cFqNmg9Q=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ADubpugw0evkRGlevVMJjr2IfeppPUVyqQv3eKb6rRDfPDrcZ0simMVqJHv6AB2qI
         /+vcXu5d00t4s/xUMzloiZI89k9Sn+O2iLFLk/YiuBDlCjmGZRsSsbRxAL8fHWGr5T
         p/lnvPlBb5cAMX81zL9ZFT4qhstmxRcS+NtOb6nH8aWFaMjew0h5dnJaIl4RoaNQRf
         wwFKi0S9xrcv8/LrhnJ4xAoQesT+RKCLRiYh9Oywx0KNkq16CO5DdMXlZb1TpFs23V
         FmdDm///secAb+cU6SkFkC8Nmuya7NcpH4rorSMFQKBcvghQ1nKqn1CC6RNjF03l43
         bkZ1vIt4zAOWw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0A98BE4EAF9;
        Mon, 21 Aug 2023 05:09:32 +0000 (UTC)
Subject: Re: [GIT PULL] Crypto Fixes for 6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZOLcCC523FoBAyv0@gondor.apana.org.au>
References: <YpC1/rWeVgMoA5X1@gondor.apana.org.au>
 <Yqw7bf7ln6vtU/VH@gondor.apana.org.au>
 <Yr1XPJsAH2l1cx3A@gondor.apana.org.au>
 <Y0zcWCmNmdXnX8RP@gondor.apana.org.au>
 <Y1thZ/+Gh/ONyf7x@gondor.apana.org.au>
 <Y7fmtJHWT1Zx+A1j@gondor.apana.org.au>
 <ZARrt99wJb7IhoY4@gondor.apana.org.au>
 <ZFeldCJcieIlXKJ8@gondor.apana.org.au>
 <ZHQe9A8CC93iCFMG@gondor.apana.org.au>
 <ZKtH5zrS4pR22PGT@gondor.apana.org.au> <ZOLcCC523FoBAyv0@gondor.apana.org.au>
X-PR-Tracked-List-Id: <linux-crypto.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZOLcCC523FoBAyv0@gondor.apana.org.au>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6 tags/v6.5-p3
X-PR-Tracked-Commit-Id: 080aa61e370b9c5cafe71cacadbfe0e72db4d6df
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f7757129e3dea336c407551c98f50057c22bb266
Message-Id: <169259457203.2079.5816344460258595111.pr-tracker-bot@kernel.org>
Date:   Mon, 21 Aug 2023 05:09:32 +0000
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 21 Aug 2023 11:37:44 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6 tags/v6.5-p3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f7757129e3dea336c407551c98f50057c22bb266

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
