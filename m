Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8916278CC97
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 21:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238753AbjH2TAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 15:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238879AbjH2TAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 15:00:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF0BCDB;
        Tue, 29 Aug 2023 12:00:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6126E64DAE;
        Tue, 29 Aug 2023 19:00:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C8E43C433C8;
        Tue, 29 Aug 2023 19:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693335604;
        bh=aCgkYGY98g3EKBI0AJ7Uxw1j4MUR/DcCFtg+btnL2Xc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=IW8TZmS890jMqMNm5Q6/CJKBTazwbi60z3Cwwm3M5OTt2SRJiX2EUvhgIfLKHwUCC
         /Xkm2RhJx1A6pYn88uE61DwKbkOnFdj+y23s5BWjBt37dFI99AhK9dJSVfEQBrAUek
         eRmvGO+ttq9ymb4xZ1GZRcslzT0AgffS0CBMEV1aJ0tQwf2Nbt2biSjokTXJebQ2ZE
         W/ZQhXlj7acfwC1zvDgw16Q0ps+gD6Hycg8qAQ4AklOuLXCueOAD0R9Pdslk7tQhDu
         ETpglB8932/S9nbh9puxI0kpCXQC56xKdGzkTDdVKSaH962I18p5lCHOFAGLQAVb9F
         yLer1mCl0Vrpg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B0EFEE26D49;
        Tue, 29 Aug 2023 19:00:04 +0000 (UTC)
Subject: Re: [GIT PULL] Crypto Update for 6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZOxnTFhchkTvKpZV@gondor.apana.org.au>
References: <YgMn+1qQPQId50hO@gondor.apana.org.au>
 <YjE5yThYIzih2kM6@gondor.apana.org.au>
 <YkUdKiJflWqxBmx5@gondor.apana.org.au>
 <YpC1/rWeVgMoA5X1@gondor.apana.org.au>
 <Yui+kNeY+Qg4fKVl@gondor.apana.org.au>
 <Yzv0wXi4Uu2WND37@gondor.apana.org.au>
 <Y5mGGrBJaDL6mnQJ@gondor.apana.org.au>
 <Y/MDmL02XYfSz8XX@gondor.apana.org.au>
 <ZEYLC6QsKnqlEQzW@gondor.apana.org.au>
 <ZJ0RSuWLwzikFr9r@gondor.apana.org.au> <ZOxnTFhchkTvKpZV@gondor.apana.org.au>
X-PR-Tracked-List-Id: <linux-crypto.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZOxnTFhchkTvKpZV@gondor.apana.org.au>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git v6.6-p1
X-PR-Tracked-Commit-Id: 85b9bf9a514d991fcecb118d0a8a35e754ff9265
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 68cf01760bc0891074e813b9bb06d2696cac1c01
Message-Id: <169333560469.15412.17633919990369937789.pr-tracker-bot@kernel.org>
Date:   Tue, 29 Aug 2023 19:00:04 +0000
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 28 Aug 2023 17:22:20 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git v6.6-p1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/68cf01760bc0891074e813b9bb06d2696cac1c01

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
