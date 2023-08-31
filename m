Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19E4E78F3AF
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 21:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347290AbjHaTyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 15:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243079AbjHaTyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 15:54:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A9FE5C
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 12:54:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8DE096336F
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 19:54:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E7EC0C433C7;
        Thu, 31 Aug 2023 19:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693511669;
        bh=4xBwQYrDYvELTUVIq5HoKyekNXLiRMNL1WiKGCIHSGE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=rPB36fpt8aXiurhkM9PYEXHy+mON8p24DqHQ3HoO+zGOLNZtLX9v3tuvUUqk9XYfW
         H7NwzRTGzmDlKUHFX6S9bMDtHVn9XP2notR++pRw9OOiVN3csEEMSc71Thw+GtblCi
         n9HIrmiP5syeoV14aNdncQcBN6ekqOMTz0wfhVVUKwpuRhx+REzkYupEC2fttYws7U
         1nm2vbJ2MWU4ayRjNbU57Z9ld/CCBjWHyynV1CjzYA12KRYgZ+GerlNgycnxySXMCz
         52GHe7VnpoqzAJSOKcKK5ZQH3WwLUT1lJHcGibgSWe5VB7mGEoiSJRFQLoZp95M6eN
         b8Vb5Bmakj8tA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D3380C595D2;
        Thu, 31 Aug 2023 19:54:28 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.6-1 tag
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87o7in1iz3.fsf@mail.lhotse>
References: <87o7in1iz3.fsf@mail.lhotse>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87o7in1iz3.fsf@mail.lhotse>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.6-1
X-PR-Tracked-Commit-Id: 85a616416e9e01db0bfa92f26457e92642e2236b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4ad0a4c2343d3981e92df2b39fa262be62a9091a
Message-Id: <169351166885.26416.7613414703938254596.pr-tracker-bot@kernel.org>
Date:   Thu, 31 Aug 2023 19:54:28 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, ajd@linux.ibm.com,
        aneesh.kumar@linux.ibm.com, arnd@arndb.de, bgray@linux.ibm.com,
        bhelgaas@google.com, christophe.leroy@csgroup.eu,
        fbarrat@linux.ibm.com, gautam@linux.ibm.com,
        hbathini@linux.ibm.com, joel@jms.id.au, justinstitt@google.com,
        kjain@linux.ibm.com, krzysztof.kozlowski@linaro.org,
        ldufour@linux.ibm.com, linus.walleij@linaro.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        mahesh@linux.ibm.com, masahiroy@kernel.org, mirimmad17@gmail.com,
        msuchanek@suse.de, nathanl@linux.ibm.com, naveen@kernel.org,
        ndesaulniers@google.com, npiggin@gmail.com, osandov@fb.com,
        rdunlap@infradead.org, robh@kernel.org, ruanjinjie@huawei.com,
        ruscur@russell.cc, sourabhjain@linux.ibm.com, tanyuan@tinylab.org,
        twoerner@gmail.com, u.kleine-koenig@pengutronix.de,
        vaibhav@linux.ibm.com, wangxiongfeng2@huawei.com, windhl@126.com,
        zhangjialin11@huawei.com, zhengzengkai@huawei.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 31 Aug 2023 22:42:24 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.6-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4ad0a4c2343d3981e92df2b39fa262be62a9091a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
