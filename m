Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E393779CD8
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 04:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236827AbjHLCz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 22:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236660AbjHLCz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 22:55:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC91D30EC;
        Fri, 11 Aug 2023 19:55:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4FE07635E7;
        Sat, 12 Aug 2023 02:55:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B5577C433C7;
        Sat, 12 Aug 2023 02:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691808956;
        bh=0TjtylDv1MFJyV0CaPpSs0bWS6u1BXohk1sq0tnY/qw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KHcyJPi2ufMzW8VpPwEMriLn52UTeaReLVUJtHqgWYn4Y8SfWpfnwRLaKuWxtuGOj
         yHdpx5lEi11lRk9NzL5nkpplewIItL+h/tCMx+Hso4f5UaTYwHACsD+1BtKJIeXbQX
         QZ5irm14a2vZ3E9+wuDgQCtqrSY9cDQB8jRieKpI71eW68vpjtQIJESZiCTRxcyTib
         JuJ0ZqeNwvwnOP2TqUBXN3hzaKF7RnyYKSFA6kxEggORpYOhzsMDt1WwhkdzVQEphO
         /oMuDteFInnrM8ALRjkvv/qnSFBeZsSkcNSPWTpDlUilK+QfkmrO8/EGRAjehI9bWy
         LuN2IY/MG8kPA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A2228C395C5;
        Sat, 12 Aug 2023 02:55:56 +0000 (UTC)
Subject: Re: [GIT PULL] tpmdd changes for v6.5-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230812000440.2663553-1-jarkko@kernel.org>
References: <20230812000440.2663553-1-jarkko@kernel.org>
X-PR-Tracked-List-Id: <linux-integrity.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230812000440.2663553-1-jarkko@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-v6.5-rc7
X-PR-Tracked-Commit-Id: 6aaf663ee04a80b445f8f5abff53cb92cb583c88
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f8de32cc060ba3f63171aaa0e8764d22d8c37978
Message-Id: <169180895665.32599.4025915481313983803.pr-tracker-bot@kernel.org>
Date:   Sat, 12 Aug 2023 02:55:56 +0000
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        David Howells <dhowells@redhat.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org, Lino Sanfilippo <l.sanfilippo@kunbus.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 12 Aug 2023 03:04:40 +0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-v6.5-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f8de32cc060ba3f63171aaa0e8764d22d8c37978

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
