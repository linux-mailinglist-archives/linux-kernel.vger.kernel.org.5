Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF6F87675A7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 20:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233862AbjG1Sj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 14:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235536AbjG1Sjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 14:39:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779E5449C
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 11:39:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 000DB621E2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 18:39:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 516BBC433B9;
        Fri, 28 Jul 2023 18:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690569573;
        bh=Urp2oTKX6hV72Y1p+mRfeCSlCVxGkLgP6+KbZj+9N+A=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=sGLp8JrhIEz+JLD/Qv8Z0XNG4gxFJ1+E3cEOiQGHmhPVMboD5T0MIDJdGdBJb77l1
         vNW7KY/NwyuM8zao2NdmCwVv62YscVjWQ72H7f4wVN5JyASJ+jSSIrsMsLoWv+JUdS
         fY/PfT9UJ9u+6x7MYxgTq41RU7KUewLq6/gpVkZ/7Qt2eqIj4nOYzlH3r7/ITR9jS+
         LmXkASwYAu7tBpftYoUsiQhSGVT9PwgisU+3YOOmz6yLZ7yjWTKiyo2IqjNe+Kp5QK
         RoHGcMveAu/qu2wCUuvtDTtr0odupmuh6cmkJwx/7ZVorv8cemgpPS+csl4soO5fC+
         eKIImGFQ77t8Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2C8A7C4166F;
        Fri, 28 Jul 2023 18:39:33 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 6.5-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <873518ck97.wl-tiwai@suse.de>
References: <873518ck97.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <873518ck97.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.5-rc4
X-PR-Tracked-Commit-Id: 3b9adfbba5af9e1e83897e832fbe6f5778bfc5d3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6fb9f7f839e0928dd15e68d4006729d1a9782c75
Message-Id: <169056957317.21363.6629965579714767398.pr-tracker-bot@kernel.org>
Date:   Fri, 28 Jul 2023 18:39:33 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 28 Jul 2023 14:07:16 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.5-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6fb9f7f839e0928dd15e68d4006729d1a9782c75

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
