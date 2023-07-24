Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFABA75FF08
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 20:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjGXS2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 14:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjGXS2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 14:28:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16BCBA6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 11:28:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9AC4961374
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 18:28:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9648CC433C7;
        Mon, 24 Jul 2023 18:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690223289;
        bh=Y5BZ90s7VncOPk/FjooP6FsblsLhIzYhA3fNDj4Hjb4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Yx/KqbS8eULe1hAuvi7MQ2Y+vpce4EGyxZpfKKmrHEaPLAKAm+9QztqMv/+s0JPPf
         q0GAvn+H5cjTQF7qgRmjfA0WC6l6hNc30+YAR+s7jnc1titTuLx7gGczDnDxIxLpOV
         xNY96uzVYOooRSuwQAiXw9+quHy+VnGoQ6+9RBa9zS+YFYMHYFReim/yLpGUIJqg4M
         KurdvqfmMY/IikXg2INw0ETdzmlZ4/VnCKSD0s2hTY8tUafmYMOEtD41+o471KnUCq
         t9okbb57wKPZp5dpQvGqn39AsyVuvE5AMCqa/XLD9lIhniq+lZPRra3+NK6CCtf9jU
         j6ME4n4ZeXG+g==
From:   Mark Brown <broonie@kernel.org>
To:     tiwai@suse.com, Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     perex@perex.cz, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
In-Reply-To: <20230721132120.5523-1-rf@opensource.cirrus.com>
References: <20230721132120.5523-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH v5 00/11] ALSA: hda: Adding support for CS35L56 on HDA
 systems
Message-Id: <169022328831.1044066.6080075080661040862.b4-ty@kernel.org>
Date:   Mon, 24 Jul 2023 19:28:08 +0100
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

On Fri, 21 Jul 2023 14:21:09 +0100, Richard Fitzgerald wrote:
> This set of patches adds support for using the CS35L56 boosted smart
> amplifier on HDA systems. In these systems the CS35L56 audio is
> routed through a HDA-to-I2S bridge codec.
> 
> This doesn't include the changes to the Realtek driver to actually hook
> up the CS35L56 driver, because we don't yet have the QUIRK IDs to
> associate it with. But we want to publish the driver now so that it is
> available for bringing up hardware with the CS35L56.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[01/11] ASoC: cs35l56: Move shared data into a common data structure
        commit: 898673b905b9318489430663083f629bc38c7461
[02/11] ASoC: cs35l56: Make cs35l56_system_reset() code more generic
        commit: cf6e7486de80b680fe178a6517dd7c4166a12dbc
[03/11] ASoC: cs35l56: Convert utility functions to use common data structure
        commit: 0a2e49230f7f1796aa79c532426d56e8739ee4b1
[04/11] ASoC: cs35l56: Move utility functions to shared file
        commit: 8a731fd37f8b33026e545f5ee5cdd7b9a837cbeb
[05/11] ASoC: cs35l56: Move runtime suspend/resume to shared library
        commit: 9974d5b57697770cba2a99c6fe925d01152cd544
[06/11] ASoC: cs35l56: Move cs_dsp init into shared library
        commit: 22e51dbb257a218e43de42764b5bdc5302f27cd1
[07/11] ASoC: cs35l56: Move part of cs35l56_init() to shared library
        commit: 84851aa055c890f2ea731a128e8feb64520c2c8e
[08/11] ASoC: cs35l56: Make common function for control port wait
        commit: f32a2bcbc092d60ba8a1b00a22607b220d53a25e
[09/11] ASoC: cs35l56: Make a common function to shutdown the DSP
        commit: 444dfa0912639fb2431553e8e54d2b35fdf590c2
[10/11] ALSA: hda: Fix missing header dependencies
        commit: 64e05321506261b737abdbfc7a82144f30d0a925
[11/11] ALSA: hda/cs35l56: Add driver for Cirrus Logic CS35L56 amplifier
        commit: 73cfbfa9caea8eda54b4c6e49a9555533660aa1e

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

