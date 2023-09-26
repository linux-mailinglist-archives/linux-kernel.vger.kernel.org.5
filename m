Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 557E37AED74
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 14:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234752AbjIZM7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 08:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234745AbjIZM7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 08:59:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1801194
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 05:59:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AC51C433C8;
        Tue, 26 Sep 2023 12:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695733147;
        bh=PU0fWrPi2wnyXnpIwY9YIk3MU1KBxKDqXRUb7dlII4M=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=b+YpagnepcbUHx80T7k3ml7KCb3JhFC31t8LW9vdMVJk/kcJ5IWDTxpS9u61qoXzE
         2kXBApS+UwtcgzL4CeoYqjXb0atf/X2582EqKA7bZbuaXzptBxPVdqG2LmTiJRmJLt
         dEtD099OPi6qilVxVuJ+dlS+9D/2Nh8j+78QtRi9DabSCTCVXqbA5vUoJKNg93hjWm
         RmmF1zjt3dEybUn1HgY8zR4LwekJgQcq2yexzKaoYuVJv3V4tPW2xJcDHSJ6EL5dz1
         NY3Wba5i5N7PlxOGWGzplO+FDF2m78r/BZ2MsjCmyZMpc6N3uNXnay5fWP5ebW5Thc
         YTihssY+1phMg==
From:   Mark Brown <broonie@kernel.org>
To:     shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Shengjiu Wang <shengjiu.wang@nxp.com>
In-Reply-To: <1695202992-24864-1-git-send-email-shengjiu.wang@nxp.com>
References: <1695202992-24864-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: fsl-asoc-card: use integer type for fll_id and
 pll_id
Message-Id: <169573314495.2623437.8401087365242286082.b4-ty@kernel.org>
Date:   Tue, 26 Sep 2023 14:59:04 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Sep 2023 17:43:12 +0800, Shengjiu Wang wrote:
> As the pll_id and pll_id can be zero (WM8960_SYSCLK_AUTO)
> with the commit 2bbc2df46e67 ("ASoC: wm8960: Make automatic the
> default clocking mode")
> 
> Then the machine driver will skip to call set_sysclk() and set_pll()
> for codec, when the sysclk rate is different with what wm8960 read
> at probe, the output sound frequency is wrong.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl-asoc-card: use integer type for fll_id and pll_id
      commit: 2b21207afd06714986a3d22442ed4860ba4f9ced

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

