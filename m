Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F7075146F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 01:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233285AbjGLX2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 19:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232923AbjGLX2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 19:28:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C644D170E
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 16:28:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 646B66199D
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 23:28:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BBA28C433CB;
        Wed, 12 Jul 2023 23:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689204481;
        bh=UinOWn1W7XrHdKI9DfCWvGwpYk+vXX3WdK72wgeynfM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ClnysLPmFpxYB2NSWSEq+9PhmhIGoqHPJF1ftP5coe4+06oCOx6z7ygUwKZt2hiM9
         LF1qwYG5CUKlOQ7cd6PgcIH1DwbOWR4trASbefYq5B+yJMki9O962JWqz/CBZFesFc
         pmavdFLRwD4Daz9eY40TzAgPs1uyTw1Ks6tSfnOEnj+hcFZaBwbOTecgVvjRk7dd1D
         BMWprPhW0y9wFRsWMdsq2RpMG4sfKMiPTdrZTMAE32jd/1pcJmX1yTFOFhKUo1qtDv
         FUAMFTQL7eHCLZ4isqXLN4WIen+Pr09CZGbgdmrL41y6rrkHXqTn2TZ8Dw5u66RGSC
         1EWykeLgtkIcg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A7445C04E32;
        Wed, 12 Jul 2023 23:28:01 +0000 (UTC)
Subject: Re: [GIT PULL] probes: Fixes for 6.5-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230711234728.e9f386a44657240b7e1cda49@kernel.org>
References: <20230711234728.e9f386a44657240b7e1cda49@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230711234728.e9f386a44657240b7e1cda49@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git probes-fixes-v6.5-rc1
X-PR-Tracked-Commit-Id: 195b9cb5b288fec1c871ef89f78cc9a7461aad3a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9a3236ce48406c3190dfa06137636525001b32f5
Message-Id: <168920448167.20936.3883216522164494381.pr-tracker-bot@kernel.org>
Date:   Wed, 12 Jul 2023 23:28:01 +0000
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Olsa <jolsa@kernel.org>, Li zeming <zeming@nfschina.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>,
        Ze Gao <zegao2021@gmail.com>, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 11 Jul 2023 23:47:28 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git probes-fixes-v6.5-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9a3236ce48406c3190dfa06137636525001b32f5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
