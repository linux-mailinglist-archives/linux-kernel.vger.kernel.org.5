Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1BCA7903F6
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 01:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243995AbjIAXTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 19:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbjIAXTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 19:19:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155CBE5C;
        Fri,  1 Sep 2023 16:19:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9DC31616B5;
        Fri,  1 Sep 2023 23:19:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 119E6C433C7;
        Fri,  1 Sep 2023 23:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693610390;
        bh=iA92oyI/lX4GeRvw1+GmRWqcv+DqrVwLzM1/NQM3dA8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ixAO4n8FS3A1oBAPZLtrHkvKJg7sCCiBWL8IIA5Py7oC7MiR0/AR+vk3T5IDYppFw
         OJjtmw+2v0DWweamDVSpFcgJ2MEYb2lBfn67UvvbS21nqFAe4lTzgs19z6AGTpNUz6
         l+Gl0dbpsixSkaeGMHjrm1QblwRYS9msNxcATRIzY9c42oFxUpukAvvHAWin0ZjnB/
         Rl5Qv5/rdOO8gnH+uxQUN7RugXtx04focnzfJL6v1TaAC1jABkx/5nfP/analv4TVr
         t/CcUTRgkuDSqlTad26yXNerTAqP5p5iwsfA2lqZZShVq1xs/5GzvxvxBq5om2GmV1
         9LLs4GycJNGmA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F1A4EC595D2;
        Fri,  1 Sep 2023 23:19:49 +0000 (UTC)
Subject: Re: [GIT PULL] Crypto Fixes for 6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZPAiMYaqUslSyZ6+@gondor.apana.org.au>
References: <Yqw7bf7ln6vtU/VH@gondor.apana.org.au>
 <Yr1XPJsAH2l1cx3A@gondor.apana.org.au>
 <Y0zcWCmNmdXnX8RP@gondor.apana.org.au>
 <Y1thZ/+Gh/ONyf7x@gondor.apana.org.au>
 <Y7fmtJHWT1Zx+A1j@gondor.apana.org.au>
 <ZARrt99wJb7IhoY4@gondor.apana.org.au>
 <ZFeldCJcieIlXKJ8@gondor.apana.org.au>
 <ZHQe9A8CC93iCFMG@gondor.apana.org.au>
 <ZKtH5zrS4pR22PGT@gondor.apana.org.au>
 <ZOLcCC523FoBAyv0@gondor.apana.org.au> <ZPAiMYaqUslSyZ6+@gondor.apana.org.au>
X-PR-Tracked-List-Id: <linux-crypto.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZPAiMYaqUslSyZ6+@gondor.apana.org.au>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git v6.6-p2
X-PR-Tracked-Commit-Id: ba22e81872c1232ea4ba421251d8109a5ed68c52
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0fe2b86c21253bb365947ceed3531eb214d4c5b5
Message-Id: <169361038998.4205.4876437177983409690.pr-tracker-bot@kernel.org>
Date:   Fri, 01 Sep 2023 23:19:49 +0000
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

The pull request you sent on Thu, 31 Aug 2023 13:16:33 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git v6.6-p2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0fe2b86c21253bb365947ceed3531eb214d4c5b5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
