Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16A8075D0B4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 19:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbjGUR3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 13:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjGUR3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 13:29:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6271FD9;
        Fri, 21 Jul 2023 10:28:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 82F9C61D65;
        Fri, 21 Jul 2023 17:28:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EB584C433C9;
        Fri, 21 Jul 2023 17:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689960535;
        bh=/OceTP9DYyC1HG/LuBY6gGTlx79HSUUoYZTc3iY1Oww=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ngn2q/TeVmEF4lrqJuZpFWWg0XXg9iRgX9uNE8d1j+fhyEEBsfW74ae2W5um+Fpx9
         h+5EksgVPerLk9KUEehuFgCZ3NFLSIHzDqAws6UbMCR13/fqiOMSQ+uL+aFSeSXHDW
         8tOj/3yssLCaUqyzvEHWu2QHuElWb5JY32GHMoJoeJLdyvJM9PEaChR396vbuaB0VZ
         rmBheJr+jo0G3PzkshswScmbIBubx4rbCLM80WmgW1Af3FIMyU385gOZLzHdiuzqXe
         2lAdn/7xnLmwNq6HqTepm1+BGlVr85DDiocrFY84PGJ20lwxn2D9kbL78BlAgAs8tL
         1k2qQs+J8i84w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CF93AC595C1;
        Fri, 21 Jul 2023 17:28:54 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fixes for v6.5-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jX-UshVsdTMQVDxmdTKXTeiCNVqocWTCWnyS_nV3pEWQ@mail.gmail.com>
References: <CAJZ5v0jX-UshVsdTMQVDxmdTKXTeiCNVqocWTCWnyS_nV3pEWQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jX-UshVsdTMQVDxmdTKXTeiCNVqocWTCWnyS_nV3pEWQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.5-rc3
X-PR-Tracked-Commit-Id: 5534f44627418897cd901d725303ce3dedd7bc1e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 892d7c1b29555cd145f0bf85818148c47bb7ac16
Message-Id: <168996053483.13720.6349957419889321018.pr-tracker-bot@kernel.org>
Date:   Fri, 21 Jul 2023 17:28:54 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 21 Jul 2023 17:48:15 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.5-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/892d7c1b29555cd145f0bf85818148c47bb7ac16

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
