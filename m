Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6601A7CC98E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 19:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbjJQRLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 13:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343868AbjJQRLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 13:11:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5572FAB
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 10:11:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60623C433C8;
        Tue, 17 Oct 2023 17:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697562664;
        bh=I75tXN/hSuP3k5KEmspEJCqjhfY968ybw0OVuKwVQ30=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=bZW70CBXMrChmnwcUc5VtmQ14TyQRx1pt8zBpz2tp7UPSkBmD9e+jyBcsHDWLEgG0
         2XK76MzByQ/uIJGZlSYGS5K+DXrc561Yz5Gz02nU4C2Q+qMG9tcQUb1BfsQtY0Ok/p
         ZN9ZCqUPsAIcW7W3RAWi1yR+H5PFWqo845I4j+LoO9+9VgurR3mGY5akjZdgpqH2TW
         AWGRb5OUTt3ytwnYRzS7IhTWW2mN7JYmDuAxu9r+j5LTXwQ2CuiJvmFE3Z/gbWWDzf
         qcnPH85zp8s2Jm2bpWVxAn/CHMck+0HHgku862supfQSkrh1cG8m/rf6v607oCKqTu
         fAd2jLqmOYN4g==
From:   Mark Brown <broonie@kernel.org>
To:     David Rau <David.Rau.opensource@dm.renesas.com>
Cc:     support.opensource@diasemi.com, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231017021258.5929-1-David.Rau.opensource@dm.renesas.com>
References: <20231017021258.5929-1-David.Rau.opensource@dm.renesas.com>
Subject: Re: [PATCH] ASoC: da7219: Correct the process of setting up Gnd
 switch in AAD
Message-Id: <169756266208.1643819.1484143250686725896.b4-ty@kernel.org>
Date:   Tue, 17 Oct 2023 18:11:02 +0100
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

On Tue, 17 Oct 2023 10:12:58 +0800, David Rau wrote:
> Enable Gnd switch to improve stability when Jack insert event
> occurs, and then disable Gnd switch after Jack type detection
> is finished.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: da7219: Correct the process of setting up Gnd switch in AAD
      commit: e8ecffd9962fe051d53a0761921b26d653b3df6b

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

