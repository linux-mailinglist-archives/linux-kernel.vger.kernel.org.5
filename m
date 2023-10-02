Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 682A17B5A89
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 20:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238851AbjJBSvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 14:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjJBSvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 14:51:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3D2AC
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 11:51:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F348C433C7;
        Mon,  2 Oct 2023 18:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696272665;
        bh=D2Ch6QB5+LSN74GAsXtnMHwOYH38o0GTJQkjHu+KEUY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=dToGKMr75xfA+w4iupZ0zNYc2qF7+kEP/hVZWSfV8KRhsc/Lrh48nVbEpy1fp9abs
         RmpxAx1XlSXX5NGEHT7QhlJbkFD4+OLupraY2v4JBEmtU0Ljx7m+haPb7zW/ybOM1B
         mObpP8YbdtAuYn1VZVQBNrK54JAjkgAz26H3khHL20TwlkxZ2tHbN+j23XXx64XE9i
         TdwmtAgYNWvAVe2asihI0ptSVzGz3zl9Jq4c9OmwoOb/X86lM0ThCGqsS2XqwE68bg
         sV9BcOZUKOCgammOfLPRXVfgDPU9Y4DvNtzFtqffsdQSLX9bdAjHQeK/udxkAJyMpw
         GtK1LSSx+Zx+w==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org,
        Antoine Gennart <gennartan@disroot.org>
Cc:     shenghao-ding@ti.com, kevin-lu@ti.com, baojun.xu@ti.com,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org
In-Reply-To: <20230929130117.77661-1-gennartan@disroot.org>
References: <20230929130117.77661-1-gennartan@disroot.org>
Subject: Re: [PATCH] audio: tlv320adc3xxx: BUG: Correct micbias setting
Message-Id: <169627266313.110968.13103747417901977042.b4-ty@kernel.org>
Date:   Mon, 02 Oct 2023 19:51:03 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Sep 2023 15:01:17 +0200, Antoine Gennart wrote:
> The micbias setting for tlv320adc can also have the value '3' which
> means that the micbias ouput pin is connected to the input pin AVDD.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] audio: tlv320adc3xxx: BUG: Correct micbias setting
      commit: e930bea4124b8a4a47ba4092d99da30099b9242d

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

