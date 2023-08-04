Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FEA177089F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 21:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbjHDTHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 15:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbjHDTHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 15:07:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E6D4C04
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 12:07:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8810862115
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 19:07:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D1127C433C8;
        Fri,  4 Aug 2023 19:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691176019;
        bh=9SxRxvvQH7hH+iDAi4wCpaOFbBMxgX+3IZnoRmnh+8k=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=hRZOKhodsChzkmcEx+DjZbGy37PekDtitt4faZ2dGc84xbyLbAjBxN81DZB/sNinJ
         0T9GL246RpKd95xBrlpoSJgLgf0DJYnuqqvozbgkOvSz+WbHrbO5mXfcR6GeSoz5Y0
         HgWjp0ZgD81oid2lZnsve0MT8kXAVqAdTzIOUC9ga7lbGdXoje4hsPrEgD/FWOR9zM
         oVrZ0+w6Z3zCQXu2puLp1orB4XubSevutgUwYPCg8Mm6p2dYePv/YV62/LJ5rl5ydu
         TeQsxZBB5M8QLMsX1+bmHP2BMBnwSzGu+LAUkx5z3wsdtEB7G0YAKR0uERH5JFnz/q
         d1ySC1Ndj8KTQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BC638C41620;
        Fri,  4 Aug 2023 19:06:59 +0000 (UTC)
Subject: Re: [GIT PULL] mtd: Fixes for v6.5-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230804092401.18b19001@xps-13>
References: <20230804092401.18b19001@xps-13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230804092401.18b19001@xps-13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/fixes-for-6.5-rc5
X-PR-Tracked-Commit-Id: c6abce60338aa2080973cd95be0aedad528bb41f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c8273a25864e74ab66601459686d6f78b0eb666b
Message-Id: <169117601976.19359.4920113291718690296.pr-tracker-bot@kernel.org>
Date:   Fri, 04 Aug 2023 19:06:59 +0000
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <Tudor.Ambarus@linaro.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <pratyush@kernel.org>,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 4 Aug 2023 09:24:01 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/fixes-for-6.5-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c8273a25864e74ab66601459686d6f78b0eb666b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
