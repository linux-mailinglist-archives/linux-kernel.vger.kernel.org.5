Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB607F4E6C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 18:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344260AbjKVRbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 12:31:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344075AbjKVRbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 12:31:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1322D1A5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 09:31:41 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB6AAC433CA;
        Wed, 22 Nov 2023 17:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700674301;
        bh=b3bPrHVvEfkj5yHIcwFXP8t5jf2bdOaikqngl5P4eqA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=eIvJnsMSKRo0Sxw8ALRT2YlbDfHrwaCl4YEAwMm986k4Dg9IwdqWMGtbGBHsKJKzZ
         f6v1eyWxzKyoWRxoOlHO3W+boQ4GKyXb/fjK29H5IDuMwhkyYKykD7Bk8xISP1YIyP
         O6riwcErC+giYU07cCtlZiU+hCJ8hMG1JldyNvUPl5Za7DGJrhRy+1ivpxDzpJ1CEw
         SEApaVSTVEFhF3WswP7cG7HuOSHV0KvVUGsLtS/C/DTBK7C/uvDFut0UPmxifb6/hG
         rf9FnGbbYI2mlAVDOIlZkA8lNN/k74pCRL5RJq4SJMLE5TLFh7fucTK4DGvIsNPKs+
         bzfVfx0hiHHow==
From:   Mark Brown <broonie@kernel.org>
To:     nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        shengjiu.wang@gmail.com, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <1700617373-6472-1-git-send-email-shengjiu.wang@nxp.com>
References: <1700617373-6472-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_xcvr: Enable 2 * TX bit clock for spdif only
 case
Message-Id: <170067429848.2197522.15067671352238530085.b4-ty@kernel.org>
Date:   Wed, 22 Nov 2023 17:31:38 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Nov 2023 09:42:53 +0800, Shengjiu Wang wrote:
> The bit 10 in TX_DPTH_CTRL register controls the TX clock rate.
> If this bit is set, TX datapath clock should be = 2* TX bit rate.
> If this bit is not set, TX datapath clock should be 10* TX bit rate.
> 
> As the spdif only case, we always use 2 * TX bit clock, so
> this bit need to be set.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_xcvr: Enable 2 * TX bit clock for spdif only case
      commit: c33fd110424dfcb544cf55a1b312f43fe1918235

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

