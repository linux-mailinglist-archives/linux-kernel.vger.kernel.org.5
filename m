Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 623E178F5BC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 00:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347890AbjHaWnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 18:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234541AbjHaWmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 18:42:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396B5E8;
        Thu, 31 Aug 2023 15:42:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C42AB60BBA;
        Thu, 31 Aug 2023 22:42:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2ED51C433CC;
        Thu, 31 Aug 2023 22:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693521765;
        bh=lBuLmR7sMzaYvwSC0UjddYmyisoAQY7yO4HT3g9vVbA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=T1eMSkl63WiEfXphFDmJy5pa8pqRkOvTbJ7mbbupufMMa1qbgQ4JC7U1SBVPPeY4p
         ZcSXUEICeTkp5bbu3T9YrumWhWP/+FcEqzeRwhqYcHx3HBb+LeJfnZH255FDnrDvcu
         EbL+kq3v0dxq/XTO/PSsSdW0najyOcA/L/74sX9FbR13NGujirRITTLGtdZlcw7DbG
         6gdhG8+vy0V/YASvRFWIS+k3mlCJlOHeDVGhh0tHfl9KWrSOPQmPS03qdEQe73Io0n
         hlf/GKNqgsfz6qH5pS+P5ibreMZWz2szrDllsttBIl27LXzeofbCGJfePg7nzLBa3C
         BCW+nh6k/BKeg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1E327C595D2;
        Thu, 31 Aug 2023 22:42:45 +0000 (UTC)
Subject: Re: [GIT PULL] ksmb server fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mvMSeqLQkNqwrxr5Q1FpJrQ85VUkp7_c4WP0BugQfpHPg@mail.gmail.com>
References: <CAH2r5mvMSeqLQkNqwrxr5Q1FpJrQ85VUkp7_c4WP0BugQfpHPg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mvMSeqLQkNqwrxr5Q1FpJrQ85VUkp7_c4WP0BugQfpHPg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/ksmbd.git tags/6.6-rc-ksmbd-fixes-part1
X-PR-Tracked-Commit-Id: 0e2378eaa2b3a663726cf740d4aaa8a801e2cb31
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8ae5d298ef2005da5454fc1680f983e85d3e1622
Message-Id: <169352176511.24475.1672811562650246330.pr-tracker-bot@kernel.org>
Date:   Thu, 31 Aug 2023 22:42:45 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Namjae Jeon <linkinjeon@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 31 Aug 2023 10:30:05 -0500:

> git://git.samba.org/ksmbd.git tags/6.6-rc-ksmbd-fixes-part1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8ae5d298ef2005da5454fc1680f983e85d3e1622

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
