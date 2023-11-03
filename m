Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACBB7DFE0A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 03:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235137AbjKCChm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 22:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344031AbjKCChk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 22:37:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5014111;
        Thu,  2 Nov 2023 19:37:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 71973C433C7;
        Fri,  3 Nov 2023 02:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698979058;
        bh=WMgjxWCo6SyAR8qQ3SczccWNmzKLgKe1P7YcdIRyByg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HTj0uj84MW4ixSM+XWshw+fS4/yKKRqlGHfeIHNDsva3DIwmTCqaTUW6VYNf6XB7T
         Re7rIe357HIrTpbsVHnhCwXuPswWtXnh2x4/R8Sf2KIRBukv+lgrX44EtlGAM+gD3I
         +BWoA9b8QXVcFlmiHyzx2JYc5WC/rqtYVSOSl+nH+CMnKiNS+VPyPskXwf4v2xUtOd
         su+fVgrWTIqHvj2wbwUorVK08mWDJgHKg5eXG86IemI6x3PBAd/rtgn4wz7H+vFooc
         DOsW4RSvLUfWbAGdK8DKkrD1Pyc5tzUyPRXfem0wQJfdpQPeVqCZ7Rqcb2XlcJw2aa
         IYtzhmMTlsXUQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 60DAFC395F0;
        Fri,  3 Nov 2023 02:37:38 +0000 (UTC)
Subject: Re: [GIT PULL] Crypto Update for 6.7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZUNIBcBJ0VeZRmT9@gondor.apana.org.au>
References: <YjE5yThYIzih2kM6@gondor.apana.org.au>
 <YkUdKiJflWqxBmx5@gondor.apana.org.au>
 <YpC1/rWeVgMoA5X1@gondor.apana.org.au>
 <Yui+kNeY+Qg4fKVl@gondor.apana.org.au>
 <Yzv0wXi4Uu2WND37@gondor.apana.org.au>
 <Y5mGGrBJaDL6mnQJ@gondor.apana.org.au>
 <Y/MDmL02XYfSz8XX@gondor.apana.org.au>
 <ZEYLC6QsKnqlEQzW@gondor.apana.org.au>
 <ZJ0RSuWLwzikFr9r@gondor.apana.org.au>
 <ZOxnTFhchkTvKpZV@gondor.apana.org.au> <ZUNIBcBJ0VeZRmT9@gondor.apana.org.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZUNIBcBJ0VeZRmT9@gondor.apana.org.au>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git v6.7-p1
X-PR-Tracked-Commit-Id: a312e07a65fb598ed239b940434392721385c722
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bc3012f4e3a9765de81f454cb8f9bb16aafc6ff5
Message-Id: <169897905838.11650.13981583074688101494.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Nov 2023 02:37:38 +0000
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 2 Nov 2023 14:56:05 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git v6.7-p1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bc3012f4e3a9765de81f454cb8f9bb16aafc6ff5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
