Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E24E7D5AEF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 20:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344197AbjJXSxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 14:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344169AbjJXSxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 14:53:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA5210DE;
        Tue, 24 Oct 2023 11:53:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16E3DC433C7;
        Tue, 24 Oct 2023 18:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698173613;
        bh=tqKKyqDACaNThpvov4ZEREo0ocu9Uu1TB1KubL2Jyrk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=upJ/xPXUUl2MVFWJAnynPy1fEw+RcVMCd7BRbMNgQG8LRpN+NXeVsBxbbX7DTvVQ1
         MxxK2JTWCB3XWh6z0nqsuBV47X9edm7/QsIS86/UgbOMgRzDYUW8QIyXY+ea773pjU
         yPLTSX0U1EZwK92rSSpGag2/n5im7zDXFwWWpxEU3/RV0aY4dWgrP1pGDfBOrDmWVE
         quaW4R4NBl50hwxFKo/Sw1IbFixev5TDxpWX5HdjB71o/Sx/a0Bk7MVf0IpZIn17Cy
         TC8KpsHAXYh4IB25/glnpHNIe9tDyrcvgFGxaNvTm/bqskNYwovn/Bg6ukA93+JfZq
         2FVlR1jK+zR9w==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Colin Ian King <colin.i.king@gmail.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231023151704.670240-1-colin.i.king@gmail.com>
References: <20231023151704.670240-1-colin.i.king@gmail.com>
Subject: Re: [PATCH][next] ASoC: mediatek: mt8186: remove redundant
 assignments to variable tdm_con
Message-Id: <169817361079.82257.18121881250208985059.b4-ty@kernel.org>
Date:   Tue, 24 Oct 2023 19:53:30 +0100
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

On Mon, 23 Oct 2023 16:17:04 +0100, Colin Ian King wrote:
> There are two occurrences where variable tdm_con is being initialized
> to zero and the next statement re-assigns tdm_con to a new value. The
> initializations are redundant and can be removed.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: mt8186: remove redundant assignments to variable tdm_con
      commit: 2e2a1613342658962250873cb8a0406bebdab9e3

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

