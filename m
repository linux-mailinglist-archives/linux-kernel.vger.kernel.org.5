Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE4A791A19
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 16:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353155AbjIDOz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 10:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236384AbjIDOz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 10:55:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF781B7
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 07:55:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0E2661807
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 14:55:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE14AC433C8;
        Mon,  4 Sep 2023 14:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693839318;
        bh=6ta1H1SO5AL7wZ6YLXn2VSihZbdu5lIUUcM8Iy6JTnE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=sHP2SNnDUsBdeagUhh2OVza/4crpSmg8m97YFIa/lCwJWEwe33LAG4Bk98a2q8XYu
         ZkKNQtYXeprXXpdNjSoAjHAXQteTULJkrkehBtm9GLzu6u+cHRGLeMEuHLfnR+hYw0
         C38zIrauRj825B+MHA1d89dgFj0U/DnDrbNsLhabiAD8YezOh5c/sr439Z7OlX2/NA
         iPReXKcIAd45EkFw1Axl1fLowSwStk3tSQPJf1qfBM/KQqpg57GoJjcTLOqirl9YVR
         Ppcro5/bSd7g0xbAjNUDHsaSi3BV96+U2hWQrxHRknjKKWBVprUhX4ryFTtt6znLmw
         a/EbMQG1K1lNw==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org, Brent Lu <brent.lu@intel.com>
Cc:     Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20230904104046.4150208-1-brent.lu@intel.com>
References: <20230904104046.4150208-1-brent.lu@intel.com>
Subject: Re: [PATCH] ASoC: rt5645: NULL pointer access when removing jack
Message-Id: <169383931669.34217.8836745562314083087.b4-ty@kernel.org>
Date:   Mon, 04 Sep 2023 15:55:16 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 04 Sep 2023 18:40:46 +0800, Brent Lu wrote:
> Machine driver calls snd_soc_component_set_jack() function with NULL
> jack and data parameters when removing jack in codec exit function.
> Do not access data when jack is NULL.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rt5645: NULL pointer access when removing jack
      commit: 5366a64033ef46d7fc36db097d4bde12af22c405

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

