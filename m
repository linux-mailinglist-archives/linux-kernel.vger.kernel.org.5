Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EDC98089B1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 15:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442733AbjLGN7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 08:59:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235269AbjLGN7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 08:59:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 152D310FB
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 05:59:53 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6281AC433C9;
        Thu,  7 Dec 2023 13:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701957592;
        bh=ZuC5Sg0qcx3RtpmbuKgYYlSi24reNt2keYVou/b9iGA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=dF7VDSiEmvkU9E45dhqgHWEkwRy7zOwN9AQAmSbRBaNnGI8NWqXL/Mp9BdIL0x9n6
         QWi3xts7w45kOhz9VWG3DY9yjMBtyvSdTnq4NEa0C//AEtUVf1dPgARlPMIv5hJszd
         8IeNi6a9uZKsubM1YmySbnPVY8JBrDAPhIDfVB3ZSorV3h/94pMahlBx45UhhU+hpN
         EETx/x/S2wzncUXiqRWJEi2l+2tmmWphMgqpCvBH74oUEyEm2GU0c+hawqyRLc7ffC
         8KBAKdLwQqhnsrrDcQ9uahkqXvsWIW4ckFOFob7u7VFi8lxS+o+dNAly7pRZo/vaqY
         7/a3NJ33QuLYg==
From:   Mark Brown <broonie@kernel.org>
To:     Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc:     alsa-devel@alsa-project.org, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, Mario.Limonciello@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        Marian Postevca <posteuca@mutex.one>,
        "open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <linux-sound@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
In-Reply-To: <20231207045505.1519151-1-Vijendar.Mukunda@amd.com>
References: <20231207045505.1519151-1-Vijendar.Mukunda@amd.com>
Subject: Re: [PATCH] ASoC: amd: acp: modify config flag read logic
Message-Id: <170195759012.40629.1653590710406299836.b4-ty@kernel.org>
Date:   Thu, 07 Dec 2023 13:59:50 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Dec 2023 10:25:01 +0530, Vijendar Mukunda wrote:
> Modify acp config flag read logic from ACP v7.0 onwards.
> Instead of reading from DMI table match entry, read the
> config flag value from BIOS ACPI table.
> This will remove updating DMI table when new platform support
> is added.
> Use FLAG_AMD_LEGACY_ONLY_DMIC flag as default one.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: acp: modify config flag read logic
      commit: 8527ecc6cf25417a1940f91eb91fca0c69a5c553

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

