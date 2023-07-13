Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39985752C56
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 23:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234469AbjGMVmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 17:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234395AbjGMVly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 17:41:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9956230E2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 14:41:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A3EAA61B7F
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 21:41:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 05BD3C433CD;
        Thu, 13 Jul 2023 21:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689284505;
        bh=kP1MGy58qbYa7DWmuKgG59Yl0Q4uzzNs9RJNFxtO1Rg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=R4q96ZdhDAMaiLJ8PojsI/nzYMcLMucQFuAgK8aOP7eTFbQc8210KRqTDD2p663TD
         s8jo46yogkwSpIOatnVxnrn8ojUp7V1exQ7MY9I5TpFdgPf2UYXED4b1KYO6FXkfPj
         M6h85TVBEAkxn532vdFVMqiHpOW14a6rx3kiHvWYPo8hVy29EO/05LvInc9Vsdac9S
         mpUgMPx7wTP7IkyRghkfbncheh1MCY8k0vXhFDcSGk1KbKs2MfWDhhog44iKZInYSD
         CsDmcr8ju1YRZbKrhcPtrhxE9p0XZRab34X4Xlcg8UPkPt96un5u2zd2pdthCBdZ5S
         TsuaX4bGJdkFw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E4483E29F46;
        Thu, 13 Jul 2023 21:41:44 +0000 (UTC)
Subject: Re: [GIT PULL v3] tracing: Fixes for v6.5-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230713144650.2ce87be1@gandalf.local.home>
References: <20230713144650.2ce87be1@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230713144650.2ce87be1@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.5-rc1-3
X-PR-Tracked-Commit-Id: d5a821896360cc8b93a15bd888fabc858c038dc0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ebc27aaceeb9c4c988dbf321e849fcb75c6b55fa
Message-Id: <168928450492.12038.10394088925376645081.pr-tracker-bot@kernel.org>
Date:   Thu, 13 Jul 2023 21:41:44 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        Florent Revest <revest@chromium.org>,
        Mohamed Khalfella <mkhalfella@purestorage.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Zheng Yejian <zhengyejian1@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 13 Jul 2023 14:46:50 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.5-rc1-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ebc27aaceeb9c4c988dbf321e849fcb75c6b55fa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
