Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 417F4791F98
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 00:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237175AbjIDWuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 18:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjIDWuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 18:50:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E688CA;
        Mon,  4 Sep 2023 15:50:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E2965B80F3B;
        Mon,  4 Sep 2023 22:50:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8ED2BC433C8;
        Mon,  4 Sep 2023 22:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693867803;
        bh=p1h6qhSZRhLTCKkGkmqhOSzkpsbbph2fRwATNnvkK3c=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=RHqlKF4mp4iZv7hhwmMzXkBm3tQW7OW/m7zfSgOlUXL82R0vnMGnxiccBaMb1NQ4t
         jFzIFPCftahVfuZ8HDeUZmV++VYbeMjqNCm1Iw8a9kHREKsQCqM7bv21y+OFyXI6Zp
         mgx6sEEuC6ns3Gs+i2zyObg4ZMhb2A2b3AVBTAFfrzKFVJyln/VZOMOpMZb5fJXZ5U
         TnZ9oHP/l4f49uJE61OPd7t7faD9ASrZ/88JWSHhpr3G9myVpG3xudyUNBK8CZ4e6T
         FpbNaMYGOsYvocJAi3c1Yt7RkCFaARMZBOGKV8QAsNLDjFguxpkcG+bD5ajSKKSFtZ
         0U1bYlzTdVN+Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 66A90C04DD9;
        Mon,  4 Sep 2023 22:50:03 +0000 (UTC)
Subject: Re: [GIT PULL] More thermal control updates for v6.6-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0i5XLwN8vpR+MdECHVusMBowtWfDb-fQZDjip+hcoagMA@mail.gmail.com>
References: <CAJZ5v0i5XLwN8vpR+MdECHVusMBowtWfDb-fQZDjip+hcoagMA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0i5XLwN8vpR+MdECHVusMBowtWfDb-fQZDjip+hcoagMA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.6-rc1-2
X-PR-Tracked-Commit-Id: 8289d810ea85755a9d22f75785806cb34eecd5e5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0ca4080a884329759a08c76f0aeabe3d24350c62
Message-Id: <169386780338.10061.11861574350980260137.pr-tracker-bot@kernel.org>
Date:   Mon, 04 Sep 2023 22:50:03 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 4 Sep 2023 19:17:40 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.6-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0ca4080a884329759a08c76f0aeabe3d24350c62

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
