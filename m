Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F39027848F0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 20:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbjHVSBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 14:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjHVSBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 14:01:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B53CC;
        Tue, 22 Aug 2023 11:01:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C8112618CB;
        Tue, 22 Aug 2023 18:01:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3B000C433C8;
        Tue, 22 Aug 2023 18:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692727308;
        bh=0LnknR8qBqZGndnVZ1B1VYT8J1I3MAz228Nm/9/lMFY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=IK3QnoUHHj3Y9szgAvpML4Z/4gEx/qiVmR7xRiRzay2e/T3FVmJXd32hg9Us9j8kT
         3/WjNYP4fRWIRltHWadIaPhPG3xo9VDncFizrPwM4qK1xSFWG1yeLd4yUvINqJ9FPP
         WZAeHkhbcUM9J51d0nXEa4UcwMH2oT3V4a3uwnfPfV+oWLTUMnPSeoaE6SOoahrCCa
         RBLUA8YMPDLF3oWmfSFfRoaSE152u4024/6tcXsy9zK5kq876ZbKTogHGvqbf2Gpvn
         5OWX5i9Ju9GtTzLSc4KM8V+KcY7Dw+QRYeVdyeQp9j4BFjByPuROnz/ul7UjUtXX/g
         CVzD7CUS5BF0A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 26CDDC3274B;
        Tue, 22 Aug 2023 18:01:48 +0000 (UTC)
Subject: Re: [GIT PULL] SELinux fixes for v6.5 (#1)
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhTEeicj__ys3duEhmv4WuLgZupWanr_bXwObRCz_jxatw@mail.gmail.com>
References: <CAHC9VhTEeicj__ys3duEhmv4WuLgZupWanr_bXwObRCz_jxatw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAHC9VhTEeicj__ys3duEhmv4WuLgZupWanr_bXwObRCz_jxatw@mail.gmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20230821
X-PR-Tracked-Commit-Id: 70d91dc9b2ac91327d0eefd86163abc3548effa6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e4311f7c0508d6d0d1176a0d7b7ef3ab4a24be1e
Message-Id: <169272730814.11168.9334889730666192075.pr-tracker-bot@kernel.org>
Date:   Tue, 22 Aug 2023 18:01:48 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 21 Aug 2023 17:20:47 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20230821

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e4311f7c0508d6d0d1176a0d7b7ef3ab4a24be1e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
