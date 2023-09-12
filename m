Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77FE979D42B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 16:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236129AbjILO6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 10:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236120AbjILO6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 10:58:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD0D1BB
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 07:58:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 413D8C433C7;
        Tue, 12 Sep 2023 14:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694530726;
        bh=xuo3FQJBuHtKVaZ47fDycI+jaARYxTGdjsIR1CB+gpQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=N+yz3y4fbg0tyoshpVBvM3cZdgcpeOdeH5TYWk9OJruL6rMM9GPJT/ow/9KZc+/KD
         FUcLv3z9uz+tY7WTax0F4wVZ+12zSTd3XhMvcEpkG9eVi+QfN1T0BixL6SemZRq3Gt
         6KAV2trBEDW9ldFaUI8y7vgcdCuKDuFANOE3ESusez3OF9kI8ItOVQd+JXORuzTVW8
         c+hKZp6pipFW9FbEqD1/4gNcBJyIOFc/HEVxFOggTDpfupzvcYxWfxs+7ze1FNV1h3
         Vulem5hSJB/DkhP9SBcOa2A8uYBf6+l34Oupd67ikntb6AWuLDtaNMgQxHQyrVZNti
         sCzqKJ9yhghwA==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        August Wikerfors <git@augustwikerfors.se>
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev
In-Reply-To: <20230911213409.6106-1-git@augustwikerfors.se>
References: <20230911213409.6106-1-git@augustwikerfors.se>
Subject: Re: [PATCH] ASoC: amd: yc: Fix non-functional mic on Lenovo 82QF
 and 82UG
Message-Id: <169453072498.64014.17577108685886768504.b4-ty@kernel.org>
Date:   Tue, 12 Sep 2023 15:58:44 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Sep 2023 23:34:09 +0200, August Wikerfors wrote:
> Like the Lenovo 82TL and 82V2, the Lenovo 82QF (Yoga 7 14ARB7) and 82UG
> (Legion S7 16ARHA7) both need a quirk entry for the internal microphone to
> function. Commit c008323fe361 ("ASoC: amd: yc: Fix a non-functional mic on
> Lenovo 82SJ") restricted the quirk that previously matched "82" to "82V2",
> breaking microphone functionality on these devices. Fix this by adding
> specific quirks for these models, as was done for the Lenovo 82TL.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: yc: Fix non-functional mic on Lenovo 82QF and 82UG
      commit: 1263cc0f414d212129c0f1289b49b7df77f92084

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

