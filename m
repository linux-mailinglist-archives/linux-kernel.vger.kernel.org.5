Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB537DF4E5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 15:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376803AbjKBO0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 10:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376794AbjKBO0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 10:26:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559A912D;
        Thu,  2 Nov 2023 07:26:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D694DC433C8;
        Thu,  2 Nov 2023 14:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698935188;
        bh=N61FOLlzGjZfDLM5psX5nhlLEctf0TEJwdUj9EFXRZk=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=ebQdTQNQOdfYg5fW44PWKj7jORcpsJAuFTXN0lqt1IkszBrD6DQHcuAWEOLWWYDDA
         4a0Lu32/+MUpgSA6PZJtx/mfNMtxFiwLEurHaSqStqA5weg0alBNH9als0/6XEpO1Z
         V4pwgctsggd3j3helUUl2uEarIze9c2fL7DQXjRIkLV9pkIPEyLLBxZtazDZI3ida6
         7WiIW/f+9LMndEXh6R+2yju5sS2XJLfgKpBlFgLEexjdLoctCemwhl6G6YZcOdpWe3
         O9Onq7Ady5tT2wY1W12NxRYtykQC6j2EFXWZYKj5ED069sh7fqc2Y+drdK/tkYmBSB
         nt/FE024pYcjA==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        liweilei@awinic.com, u.kleine-koenig@pengutronix.de,
        yang.lee@linux.alibaba.com, nathan@kernel.org,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangweidong.a@awinic.com
In-Reply-To: <20231101090211.177125-1-wangweidong.a@awinic.com>
References: <20231101090211.177125-1-wangweidong.a@awinic.com>
Subject: Re: [PATCH V2 0/3] ASoC: codecs: Modify some error codes
Message-Id: <169893518558.36738.243491245634528224.b4-ty@kernel.org>
Date:   Thu, 02 Nov 2023 14:26:25 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Nov 2023 17:02:07 +0800, wangweidong.a@awinic.com wrote:
> The maximum value that calib can set should be
> consistent with the maximum value of re.
> 
> An error code should be return when the re is greater
> than the maximum value or less than the minimum value
> 
> The value of vsense_select should be either 32
> or 0 in both cases, so modify the
> AW88399_DEV_VDSEL_VSENSE macro to 32.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: codecs: Modify the maximum value of calib
      commit: c9e920ffa752b9047d65041cd70495409c768dd7
[2/3] ASoC: codecs: Modify the wrong judgment of re value
      commit: baf46c3c763809fbeabcff5ec6e2ff3081f755f2
[3/3] ASoC: codecs: Modify macro value error
      commit: b729598c1747576bb9a4c997190be3f7c2915726

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

