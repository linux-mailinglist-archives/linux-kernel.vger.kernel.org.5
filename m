Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38D3C811EC8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 20:23:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442140AbjLMTXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 14:23:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442035AbjLMTXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 14:23:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6091C99
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 11:23:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAD56C433C7;
        Wed, 13 Dec 2023 19:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702495423;
        bh=z+0td+atuCMZBsdE4LHxDWAVwopd34cSV4sCDtgxUk8=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=f5BMFybzIoHt3p6Ht9nHZTJqWl7hZijHve4qJZ2SZhCoGFji2301nAh5JVVEzBN73
         HQvFcOwfhAWuMAfsw9u7vdZlEwuHEdoy2uRmpE4k76BCqWBwmOHFX6YD3eTL8MZh3d
         Ev/nl2/4YPwZfVe+3iIbfTwzsh40bANkNoYf6NsBgjZ9cdo2jnhg3o/n15karvZuVE
         nphvtnev1uh/gRbzxgWqmO1Qz+SsP+vRLpqVzx9914fkMvQTXGHr87Iq8sQwxIklmm
         wjEj/JedAIp9sbwXFqGP0bHkbY1OgnvF/NG9vbqQAw240gQxNqLYezqHY6M2X+x0Y5
         TfZ8d4YQGFCVw==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Maso Huang <maso.huang@mediatek.com>,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Daniel Golle <daniel@makrotopia.org>
In-Reply-To: <b941a404d97c01ef3e30c49925927b9a7dafeb19.1702422544.git.daniel@makrotopia.org>
References: <b941a404d97c01ef3e30c49925927b9a7dafeb19.1702422544.git.daniel@makrotopia.org>
Subject: Re: [PATCH v2] ASoC: mediatek: mt7986: silence error in case of
 -EPROBE_DEFER
Message-Id: <170249542061.33569.6338427444807634963.b4-ty@kernel.org>
Date:   Wed, 13 Dec 2023 19:23:40 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Dec 2023 23:10:07 +0000, Daniel Golle wrote:
> If probe is defered no error should be printed. Use dev_err_probe() to
> have it muted.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: mt7986: silence error in case of -EPROBE_DEFER
      commit: 6475b8e1821c9d14e60592a74c10d75431500c7c

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

