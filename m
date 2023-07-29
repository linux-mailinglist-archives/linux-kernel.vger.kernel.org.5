Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77F6176797A
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 02:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236139AbjG2A1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 20:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232604AbjG2A1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 20:27:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9937B2680;
        Fri, 28 Jul 2023 17:27:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D6126221B;
        Sat, 29 Jul 2023 00:27:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8269DC433C7;
        Sat, 29 Jul 2023 00:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690590427;
        bh=vf6eqh+hSbOXZ3cuyP/fJ3KKwC+CL5pgf5FhKK74odg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GC0L/qOEANg6FkerGDtCauy/cOKxaNuVgydkmCmcx069785084iccxV7qyHaR3sGC
         nL1Etcve8Ed3LlnoTxHFqY/vTXYNzGzXuZe45v8M9nScj8wWji2mZMjCHW4eCmJSe2
         rwhq+wtviH1++ry+377D96gofw6KBOW38eyEYlslOO/nI1Psik4stAJUeYSYlxo72H
         ARJi9be1KsF0dZt3VpnOikYdKEUun0LfTfaBiuiVf8yJdoqmvWcG03xeqPARCO13QC
         yt5gqJuSgXAlLIrNAHSoTdb4+JGr7OziCAJzGY+nE1+w+dkuBdf82ycOgTu6qXxNiu
         xxTdQ7h1XElNw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6FB5BC39562;
        Sat, 29 Jul 2023 00:27:07 +0000 (UTC)
Subject: Re: [GIT PULL] tpmdd changes for v6.5-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230728183322.16359-1-jarkko@kernel.org>
References: <20230728183322.16359-1-jarkko@kernel.org>
X-PR-Tracked-List-Id: <linux-integrity.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230728183322.16359-1-jarkko@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-v6.5-rc4
X-PR-Tracked-Commit-Id: 513253f8c293c0c8bd46d09d337fc892bf8f9f48
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2b17e90d3f92f394a6dea9243aac70a5aa0d0c57
Message-Id: <169059042744.2110.8212659249499335251.pr-tracker-bot@kernel.org>
Date:   Sat, 29 Jul 2023 00:27:07 +0000
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        David Howells <dhowells@redhat.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org, Lino Sanfilippo <l.sanfilippo@kunbus.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 28 Jul 2023 18:33:22 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-v6.5-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2b17e90d3f92f394a6dea9243aac70a5aa0d0c57

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
