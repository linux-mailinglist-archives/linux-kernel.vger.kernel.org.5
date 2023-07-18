Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6742757AD6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 13:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbjGRLrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 07:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbjGRLrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 07:47:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0C0E3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 04:47:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD2856153B
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 11:47:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1932C433C8;
        Tue, 18 Jul 2023 11:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689680860;
        bh=ZvqThxrRF3azwHa8S6/JSLLxksS+HHQlbfFAk7L6Oe4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=NiyIriaVDpbfpBBavIbmRiv2u8PnwyYoC11x/yVLsL8p8CCjVEDh2j4KeymwMZmkJ
         p8wsaLShwILFEDbEuSei/n/AQ+DZfB8bhV67lMZseBDXL5HwxxG4eh4TprvyACTwb6
         MBuHauz7LZm0c0omsmB7nO3KtGyB/RH7SetrcWypVSEdZC1uBeHTOD7vKhkwXS+gc9
         4mnK2i9Mi6W5ybAsdow/KBDfBwm76sdzKItlfTStf52ceFbxabgRi8O83C4BLEzCjY
         +Sr+BP4iatGJjSAKSsQhJAteHieNHZT6chdS3DmTyauRHyBvrdgGVQj50ERgnJv+DO
         fL8t9lbrIuotQ==
From:   Mark Brown <broonie@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matus Gajdos <matuszpd@gmail.com>
Cc:     alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230712124934.32232-1-matuszpd@gmail.com>
References: <20230712124934.32232-1-matuszpd@gmail.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Disable bit clock with transmitter
Message-Id: <168968085762.37584.16109191743669606574.b4-ty@kernel.org>
Date:   Tue, 18 Jul 2023 12:47:37 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jul 2023 14:49:33 +0200, Matus Gajdos wrote:
> Otherwise bit clock remains running writing invalid data to the DAC.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_sai: Disable bit clock with transmitter
      commit: 269f399dc19f0e5c51711c3ba3bd06e0ef6ef403

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

