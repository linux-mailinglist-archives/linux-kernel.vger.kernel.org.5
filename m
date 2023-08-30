Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDF378D2A0
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 05:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241920AbjH3D60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 23:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241856AbjH3D6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 23:58:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B427ECC;
        Tue, 29 Aug 2023 20:58:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5209761849;
        Wed, 30 Aug 2023 03:58:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ACE4FC433C7;
        Wed, 30 Aug 2023 03:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693367894;
        bh=8eJm2umkBvn6T+8obX8Fe/8clowchwHQAEIUxR9hPf4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Nh9j1H/EsI0xm+ObwygKrU9tQD9abAxLFn14aY+qFi6QVoQmZS063Mln7i43vE56g
         dBS8Y+Vi9ceCQIfP1rnyl8GwCDKDBeSEMtDgjunoxUnaUJdOzE/8V75NApSpQ/Cjv5
         /s6WaJHf1OXY6lcmsMWZZ39uOu9z56VTCOUQWjbwlUOEYKqwvzZw2rp0ek7lEt1Q9P
         AAvE8NHwMknt22+Y/J+oa0MGYqqSEbVLVHm42VrvunadFlyCcVwLwQNU0j/4cm6bc/
         wpetxY5B0f1dAoW/pI1N77W8AiViKJTWSbVc+K5LGwfIzS4m5TWjc6NoZiBvQ0iM53
         blagCdrmNw/NA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9ADD5E29F34;
        Wed, 30 Aug 2023 03:58:14 +0000 (UTC)
Subject: Re: [GIT PULL] Modules changes for v6.6-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZO5M45JsJYzNF59H@bombadil.infradead.org>
References: <ZO5M45JsJYzNF59H@bombadil.infradead.org>
X-PR-Tracked-List-Id: <linux-modules.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZO5M45JsJYzNF59H@bombadil.infradead.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ tags/modules-6.6-rc1
X-PR-Tracked-Commit-Id: a419beac4a070aff63c520f36ebf7cb8a76a8ae5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: daa22f5a78c27412e88d31780c4a6262cda559cd
Message-Id: <169336789462.6268.1786295356990012160.pr-tracker-bot@kernel.org>
Date:   Wed, 30 Aug 2023 03:58:14 +0000
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-modules@vger.kernel.org, patches@lists.linux.dev,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        hch@lst.de, gregkh@linuxfoundation.org, manuel.lauss@gmail.com,
        kuba@kernel.org, kumba@gentoo.org, palmer@rivosinc.com,
        masahiroy@kernel.org, rdunlap@infradead.org, zeming@nfschina.com,
        rongtao@cestc.cn, arnd@arndb.de, pmladek@suse.com,
        chenjiahao16@huawei.com, christian@bricart.de,
        peterz@infradead.org, song@kernel.org, keescook@chromium.org,
        thunder.leizhen@huawei.com, mcgrof@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 29 Aug 2023 12:54:11 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ tags/modules-6.6-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/daa22f5a78c27412e88d31780c4a6262cda559cd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
