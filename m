Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA31077D3E9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 22:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240168AbjHOUFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 16:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240151AbjHOUFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 16:05:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2100119AD;
        Tue, 15 Aug 2023 13:05:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B21196612E;
        Tue, 15 Aug 2023 20:04:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 231CAC433C8;
        Tue, 15 Aug 2023 20:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692129898;
        bh=8lLhtJMPw1BYSS76drJ7lqsVyc1w4WAplWlg1g56lXs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=d4XNppdbjlm/EBUihpd4H0BCg4NbPmX5C4zWmQaEuFzH0TytAbtG6VRhb4GKIdfH2
         OcEZ4dzqLKDOSLqSdgudFro8eL/zoDZiCmfp0UcHwCrcg6MV6ADSD6uGdNHkDYB1iD
         4NYMiw/D7MrDWMbgyoq0LZ5MXoQxvc+eNKcq+wXeUWngR+XHlCJLaGrggMBUXgqruW
         3ZG9uJ8t/7fOFQQEJtlh4W/ztrLhDA+Zr0xVjbu+GaJLKyoQV/ckJHFt1Ygh3vzpkH
         PQj5nG18UN07ex54tg58s+mXFZIhZByldyY56K6oBsqf7vWKS15piFr/zbxvU8wLGS
         +RLqRLm/gWyHw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 12BB7E93B38;
        Tue, 15 Aug 2023 20:04:58 +0000 (UTC)
Subject: Re: [GIT PULL] SMB3 client fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mt9bY7hGagfTPS_uK9KnbTQVsWaO9JciJ6XekLb36Zusg@mail.gmail.com>
References: <CAH2r5mt9bY7hGagfTPS_uK9KnbTQVsWaO9JciJ6XekLb36Zusg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-cifs.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mt9bY7hGagfTPS_uK9KnbTQVsWaO9JciJ6XekLb36Zusg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/6.5-rc6-smb3-client-fixes
X-PR-Tracked-Commit-Id: 7b38f6ddc97bf572c3422d3175e8678dd95502fa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2d7b8c6b90e4054a35eb59cd6d7c66e903e8ae4b
Message-Id: <169212989806.25399.3668953853499344484.pr-tracker-bot@kernel.org>
Date:   Tue, 15 Aug 2023 20:04:58 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 15 Aug 2023 14:59:27 -0500:

> git://git.samba.org/sfrench/cifs-2.6.git tags/6.5-rc6-smb3-client-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2d7b8c6b90e4054a35eb59cd6d7c66e903e8ae4b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
