Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4A697A8911
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 17:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235562AbjITP50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 11:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235018AbjITP5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 11:57:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A461B9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 08:57:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6055C433C7;
        Wed, 20 Sep 2023 15:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695225438;
        bh=pB4XNqlP7pg+a9UE5lhowbM1SsYWcw8dZscEk4AuXlk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=qc+be3qOzO6VB+dZL4dfLkCb7wkLMLG0vl/oxiGCveaxOQcDgBbgyLORlBQK/eVIB
         OtuJqCoB8Pqqw6O1zcY3SSKqIi9VR9n9Uhxamjgtno7SefbM0C/HilakhQ64Ht9ZhP
         jiUjMiyPMEZd4bF5iyo4YQee2BbRU4/cOPXs02EhVUcXlBj2Dfhyo4ecRKucKa5qrS
         RmIYhZ+AnESLwFZEq04c48G1xCxKY32MLXaEI+l8/jEbfuD39mzTW909Tf4QPAKcib
         Bf9KAjGbAGu6a9icOi8RHRhjiGBmeABgOLO8YtTLLOhTZ1KGLHG5PCyHtHFKSRu6Vs
         KFo2jEHqdnCkQ==
From:   Mark Brown <broonie@kernel.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>
Cc:     Zhiyong Tao <zhiyong.tao@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
In-Reply-To: <20230920085336.136238-1-wenst@chromium.org>
References: <20230920085336.136238-1-wenst@chromium.org>
Subject: Re: [PATCH v2] regulator: mt6358: split ops for buck and linear
 range LDO regulators
Message-Id: <169522543613.83620.1878609936860596842.b4-ty@kernel.org>
Date:   Wed, 20 Sep 2023 16:57:16 +0100
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

On Wed, 20 Sep 2023 16:53:34 +0800, Chen-Yu Tsai wrote:
> The buck and linear range LDO (VSRAM_*) regulators share one set of ops.
> This set includes support for get/set mode. However this only makes
> sense for buck regulators, not LDOs. The callbacks were not checking
> whether the register offset and/or mask for mode setting was valid or
> not. This ends up making the kernel report "normal" mode operation for
> the LDOs.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: mt6358: split ops for buck and linear range LDO regulators
      commit: 7e37c851374eca2d1f6128de03195c9f7b4baaf2

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

