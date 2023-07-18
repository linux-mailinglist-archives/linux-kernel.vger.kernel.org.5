Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8066B75885E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 00:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbjGRWXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 18:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjGRWXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 18:23:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9458198E
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 15:23:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E5366126C
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 22:23:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01F29C433C8;
        Tue, 18 Jul 2023 22:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689719024;
        bh=TVSaMHy6xqrGvah1BP5eyrd/c06CocVOjTmlLYNQoU0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=MIWWC72RM+yQhMhQw9zkYVYXzn5160svXESkw6jq4k+WW5F9LL2u/IysPVWlQk6AF
         V3rI0cngCPbWxhl+/snMBW5QJ2AU+FawiXX6Bvda89jEQG0qm7Ai01Tj8hKAwReOJY
         vrbE36AblheOnTurtf22nWNrKzqso8GfasUSIvd24ChxAN/fxskjJTeSnZtrZwiwWb
         qsFhAE6f4nh8UKlvIJiktdan1oxt+4xGNmtYcg09MUVZohlPbiXRECC9I8bmaQokWl
         iLHcEgUxluwCtt5G4g3ptxDChPRDAwp+P48i7oZHKYF4xFaqhnuKv+NWVV6SFaJqeo
         ayIYRnffamPRA==
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
In-Reply-To: <20230718144625.39634-1-rf@opensource.cirrus.com>
References: <20230718144625.39634-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: cs35l56: Patch soft registers to defaults
Message-Id: <168971902372.127447.16837220353075580193.b4-ty@kernel.org>
Date:   Tue, 18 Jul 2023 23:23:43 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jul 2023 15:46:25 +0100, Richard Fitzgerald wrote:
> The soft (firmware) registers for volume/mute/posture are not reset by
> a chip soft-reset, so use a regmap patch to set them to defaults.
> 
> cs35l56_reread_firmware_registers() has been removed. Its intent was to
> use whatever the firmware set as a default. But the driver now patches the
> defaults to the registers.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs35l56: Patch soft registers to defaults
      commit: df4167d658d45946677f91d84e9d40570c875cb8

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

