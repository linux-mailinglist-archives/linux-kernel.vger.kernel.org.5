Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67E5076D71F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 20:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbjHBSsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 14:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbjHBSsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 14:48:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F982119
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 11:48:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 17D7661B04
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 18:48:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 793CFC433C7;
        Wed,  2 Aug 2023 18:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691002113;
        bh=yFFhUNzea8Y77SmUyxR12Mkaxlu3IOENybNvwkRTtBM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=gN9IPwcTEGg2Sg8/ZG6rJmKKERdvbXrIfTjYjmh+IudlsQDO0pBKAHJieHtQS5mau
         luoe2Z+l/6PhP71Ce2zHRcwc59QJQt4PCpxXR68+MCYPnZMxNk9sQm0sz9FEnnVDt7
         x6Z17f2aOw0tcTohfXX4egjwc+Ej+zrC4DCyJlnzppwDin6Josb4giyxoidIjpDv93
         pBq6RUkE8iGeA4PRAzf46DpL0oFWyOeDNg0DbNLD+btziUk3cVMREmF0VSzbBB2shc
         FQOa+BW/MburKkNkfgqyOVrYcrp0l+rW9TbE89STdoJtkYErr+XtlbVrGhbj5p5slh
         s/za7rhRrdowg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 61039C6445B;
        Wed,  2 Aug 2023 18:48:33 +0000 (UTC)
Subject: Re: [GIT PULL] exfat fixes for 6.5-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAKYAXd8zp6HW2rA_ivTG9FEOcrOanNLEg0RBKPkNh_2kSS+rcw@mail.gmail.com>
References: <CAKYAXd8zp6HW2rA_ivTG9FEOcrOanNLEg0RBKPkNh_2kSS+rcw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAKYAXd8zp6HW2rA_ivTG9FEOcrOanNLEg0RBKPkNh_2kSS+rcw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git tags/exfat-for-6.5-rc5
X-PR-Tracked-Commit-Id: ff84772fd45d486e4fc78c82e2f70ce5333543e6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4b954598a47ba07034aab9af8ddd485bdc3d5b16
Message-Id: <169100211339.11440.16745802312809777177.pr-tracker-bot@kernel.org>
Date:   Wed, 02 Aug 2023 18:48:33 +0000
To:     Namjae Jeon <linkinjeon@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 2 Aug 2023 22:54:24 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git tags/exfat-for-6.5-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4b954598a47ba07034aab9af8ddd485bdc3d5b16

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
