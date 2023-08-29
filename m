Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C39278CCC3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 21:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239337AbjH2TOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 15:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239781AbjH2TMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 15:12:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11119B8;
        Tue, 29 Aug 2023 12:12:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A398361CE5;
        Tue, 29 Aug 2023 19:12:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 975DEC433C8;
        Tue, 29 Aug 2023 19:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693336355;
        bh=nKFWWSD6tkdLWsvN0IJ+6k1X0di+ynGgA5GvfxyERBY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=IgAwv+9vS+xmhm9d8GUXeCVq8QacgbDEUEYlrTHiF6jE5IkxTx3MHTZl8PO5TlyP5
         dMnezpq0CHLKn+mMyR+my7QsvL76iPsNBkAjGgpfKd2um+wYEw2HDvIOWaoKbgJsS+
         BdeEOVFpMsqiYFj7/TSOxeyX1sZaHcAsr2l0EUXBwnoM38Gow9LMIRo0BhZiEANLy5
         iIK9NuWKqWX634jXNONaefqXpfgTjYzTdNtEv6BCzNNb+7PH0Jg7ibiXuGeCu7rVCi
         vbiUbMVELU0RTkiEJJtd6Zg4/PSrNTB3409G6xjnc/6NalAV8wcHF3bFX/8U2DRY0K
         Q855C388rWe9g==
From:   Mark Brown <broonie@kernel.org>
To:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vlad Karpovich <vkarpovi@opensource.cirrus.com>
Cc:     alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        RicardoRivera-Matosricardo.rivera-matos@cirrus.com
In-Reply-To: <20230828170525.335671-1-vkarpovi@opensource.cirrus.com>
References: <20230828170525.335671-1-vkarpovi@opensource.cirrus.com>
Subject: Re: (subset) [PATCH 1/7] ASoC: cs35l45: Add support for Chip ID
 0x35A460
Message-Id: <169333634962.3145573.7194230299890982862.b4-ty@kernel.org>
Date:   Tue, 29 Aug 2023 20:12:29 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Aug 2023 12:05:19 -0500, Vlad Karpovich wrote:
> The 0x35A460 chip is a different variant of the cs35l45.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/7] ASoC: cs35l45: Add support for Chip ID 0x35A460
      commit: bfd73b601ac880d7cfbafbb770c3d6195e73add3
[2/7] ASoC: cs35l45: Fix "Dead assigment" warning
      commit: a47f7bf97c9836ff312b421fe392f13401c60c7b
[5/7] ASoC: cs35l45: Rename DACPCM1 Source control
      commit: e041b85006f40a4f9799c385ec1a7fb8bdb0c228

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

