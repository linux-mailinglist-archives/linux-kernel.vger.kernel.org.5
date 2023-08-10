Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45ADD777B13
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 16:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235903AbjHJOog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 10:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbjHJOof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 10:44:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C48C211C
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 07:44:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E521C65E8C
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 14:44:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49CFDC433C7;
        Thu, 10 Aug 2023 14:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691678674;
        bh=taD2g2HjEYDDGyrJ7xRRjV/D/Ew9sTSpuCtEVhiSMVI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ZARSl0Qu0dWqGyMxPdHwUP4DCJXIgtofaovntgVIS1O8ERbxLpTmxuHTv9htJBcgi
         WnOU4Pq1u+xdYUNAJHVHy7ODTKkDFS39Hx7degKqwA4krDXV1XR6zaeQ7RsQRjP2Jm
         DzbhrPVv9Vqlb0ex7NZlhzM1Pp7wYmXEdWPJGIbNp5zYrz3GM2KYg6fOxCDk4hQu+u
         8eXtM6ZGUxWZnrK04WseN8x+n0Ebk9FrCUbWn/enYf3qtg5kY492toI26QiP6MwiOd
         RNVWiZC5PsVaJRDeDGYHKgEDepoObxLt5I2EIif7/uZu0OHYQ+8jVh16FILmtrcPQO
         osZj5w+PuJ3xw==
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230809171931.1244502-1-jbrunet@baylibre.com>
References: <20230809171931.1244502-1-jbrunet@baylibre.com>
Subject: Re: [PATCH] ASoC: meson: axg-tdm-formatter: fix channel slot
 allocation
Message-Id: <169167867301.482967.10999028538152637796.b4-ty@kernel.org>
Date:   Thu, 10 Aug 2023 15:44:33 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 09 Aug 2023 19:19:31 +0200, Jerome Brunet wrote:
> When the tdm lane mask is computed, the driver currently fills the 1st lane
> before moving on to the next. If the stream has less channels than the
> lanes can accommodate, slots will be disabled on the last lanes.
> 
> Unfortunately, the HW distribute channels in a different way. It distribute
> channels in pair on each lanes before moving on the next slots.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: meson: axg-tdm-formatter: fix channel slot allocation
      commit: c1f848f12103920ca165758aedb1c10904e193e1

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

