Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B3B78CBC2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 20:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238248AbjH2SIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 14:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238832AbjH2SIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 14:08:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FACBBE;
        Tue, 29 Aug 2023 11:08:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1234E61793;
        Tue, 29 Aug 2023 18:08:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6EC7EC433C8;
        Tue, 29 Aug 2023 18:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693332480;
        bh=Pz/d+6fwfzPPGjk35dJjbBjpALL5ToEzcQEv1tJyo5U=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=EEkVhb9j8yqC0Uq0UPVWsCCYYu4Sbgs3MhqoXLBKPWoHEhisS2rz9Tlwh5mR6s1gQ
         oXy+OujmYNxqNx9RtyptOsOn09rXMKW0Dnfld9/YNpTMcDzXhDisb16w13WFaHqUHB
         qGI/olUQJDpNDF2l9/Zdh2w8StJ3Y66hL5OOjb0Rx7QLUNuRqprvKu+YS4EIB6+Jry
         oGt8mMXq2bc4kHFE8rDjig1mpjc+PVI8yoi/AizKr4aGWj2sTSCCc6C3qcr5W7duzd
         jwrEnI8G0wDd/ELb4oCzPipyTq5LDofd1Gep3AHKWDVgmCppc8QMxeeCImIAUn4SwP
         n+SrtvEyXb6jA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5AFB3C595D2;
        Tue, 29 Aug 2023 18:08:00 +0000 (UTC)
Subject: Re: [GIT PULL] tpmdd changes for v6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230817201935.31399-1-jarkko@kernel.org>
References: <20230817201935.31399-1-jarkko@kernel.org>
X-PR-Tracked-List-Id: <linux-integrity.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230817201935.31399-1-jarkko@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-v6.6
X-PR-Tracked-Commit-Id: 218a2680624cba1611e3dfc7d9b646d240e5f855
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f2586d921cea4feeddd1cc5ee3495700540dba8f
Message-Id: <169333248036.16601.2171559733705933999.pr-tracker-bot@kernel.org>
Date:   Tue, 29 Aug 2023 18:08:00 +0000
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        David Howells <dhowells@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 17 Aug 2023 20:19:35 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-v6.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f2586d921cea4feeddd1cc5ee3495700540dba8f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
