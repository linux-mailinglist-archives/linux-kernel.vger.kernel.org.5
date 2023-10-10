Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD9C7C03D3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 20:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343786AbjJJSyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 14:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343735AbjJJSyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 14:54:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D7AAC;
        Tue, 10 Oct 2023 11:54:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2DB09C433CC;
        Tue, 10 Oct 2023 18:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696964077;
        bh=3nliYFIhzBhPD+aGytcKvg0fY/dyUUsiJxa6eb+/EB8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Kg/jPogsNZ3atEo6+w3BimYrq57Uxrj0q6n/YFsBI6/ZC3ga0//0K5K0gkb/CA9D7
         JeCR5ahd27+8x4OlurCdxq6eIfBv752kDFYHQoV0TAa7rXpnU7fP95fa+GZObyMFXa
         MoAGKqSGSgP11BqvxXMvmsyp+AaJaeXRsSC6AjLUP2RzrGsXeCANwuI1jvSYwbGLE4
         iQ7LE0YopLnOUNKBoFahI5t2NeVPxfib6mDzczoBPrroD/EKgGukaxovENjn/Ves1l
         T7NZD02XSivC4i/B6WZgRDONqXXjH594P67AmhFaFbQlcELJaoQGMsvwp/5G22yA09
         z2j1rU+WbtsOw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1790CC41671;
        Tue, 10 Oct 2023 18:54:37 +0000 (UTC)
Subject: Re: [GIT PULL] Crypto Fixes for 6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZSUPdPFo+M/rQhwo@gondor.apana.org.au>
References: <Y0zcWCmNmdXnX8RP@gondor.apana.org.au>
 <Y1thZ/+Gh/ONyf7x@gondor.apana.org.au>
 <Y7fmtJHWT1Zx+A1j@gondor.apana.org.au>
 <ZARrt99wJb7IhoY4@gondor.apana.org.au>
 <ZFeldCJcieIlXKJ8@gondor.apana.org.au>
 <ZHQe9A8CC93iCFMG@gondor.apana.org.au>
 <ZKtH5zrS4pR22PGT@gondor.apana.org.au>
 <ZOLcCC523FoBAyv0@gondor.apana.org.au>
 <ZPAiMYaqUslSyZ6+@gondor.apana.org.au>
 <ZQz3qxwwAjDaqi5V@gondor.apana.org.au> <ZSUPdPFo+M/rQhwo@gondor.apana.org.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZSUPdPFo+M/rQhwo@gondor.apana.org.au>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git v6.6-p4
X-PR-Tracked-Commit-Id: 152d0bcdf1efcb54a4fa20f694e9c7bbb6d06cbf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 832b5d0bf94cab3ab1ca690fca3c3d931f5fa7cd
Message-Id: <169696407709.29903.11877447157183182158.pr-tracker-bot@kernel.org>
Date:   Tue, 10 Oct 2023 18:54:37 +0000
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 10 Oct 2023 16:46:44 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git v6.6-p4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/832b5d0bf94cab3ab1ca690fca3c3d931f5fa7cd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
