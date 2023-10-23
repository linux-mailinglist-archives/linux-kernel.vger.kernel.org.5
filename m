Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB477D3AC0
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 17:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbjJWPa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 11:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbjJWPa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 11:30:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6EB103
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 08:30:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1A375C433C7;
        Mon, 23 Oct 2023 15:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698075025;
        bh=V7CY16dZcqj1cI8ePj7b2E7EEEYuy7K8Hf/oHcEVGRI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=PFh1xyb5FicPOqrPCP+Pl3CeBIYQfVbiBUQClV1JDiHesbOl/R/VwGH84uuMGRGZy
         /YpvV2Un/hFkqHyfLcyJB0FRgrCur409DA3w+X3sqhp1a6bHKYjT4MeKGr7KSSHRBM
         SW6GjwtiQZ1SC14MWItdNVHTbOzC7OS8IAyVYRDuEJXaGX/ssi+wWlWT2SPZHtae4i
         wZOABadTP16BxNE17Udanta3OvM2E7Y1XO7wMU9yM35uZAs5ywtQ3Y4ydInjBtmXc2
         +jD+8FWEbPVd9esQkfwXB+0E9QHsU7SClYEULYhsfTHxN5GR8hrE31RL5Loj4vXukl
         5wOKabgxDxP7g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F2EE4E4CC11;
        Mon, 23 Oct 2023 15:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH V2] f2fs: fix error path of __f2fs_build_free_nids
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <169807502498.26537.15785065563477697728.git-patchwork-notify@kernel.org>
Date:   Mon, 23 Oct 2023 15:30:24 +0000
References: <1697455651-11124-1-git-send-email-zhiguo.niu@unisoc.com>
In-Reply-To: <1697455651-11124-1-git-send-email-zhiguo.niu@unisoc.com>
To:     Zhiguo Niu <zhiguo.niu@unisoc.com>
Cc:     jaegeuk@kernel.org, chao@kernel.org, niuzhiguo84@gmail.com,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon, 16 Oct 2023 19:27:31 +0800 you wrote:
> If NAT is corrupted, let scan_nat_page() return EFSCORRUPTED, so that,
> caller can set SBI_NEED_FSCK flag into checkpoint for later repair by
> fsck.
> 
> Also, this patch introduces a new fscorrupted error flag, and in above
> scenario, it will persist the error flag into superblock synchronously
> to avoid it has no luck to trigger a checkpoint to record SBI_NEED_FSCK
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,V2] f2fs: fix error path of __f2fs_build_free_nids
    https://git.kernel.org/jaegeuk/f2fs/c/a5e80e18f268

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


