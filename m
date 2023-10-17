Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B21A97CD0EE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 01:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344148AbjJQXl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 19:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjJQXl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 19:41:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8568C98;
        Tue, 17 Oct 2023 16:41:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84FA1C433C7;
        Tue, 17 Oct 2023 23:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697586085;
        bh=PZdgpkAaVuDpoTwI/pZyJZapPPLuDvDgBIRrvAyEbiQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=bRY2AgSWcAGt7Faxr0pff/R5TZ0PCaZdVM/Nnc9xLEZSgst8aYVWc9WYaPR45sYqW
         0ionzrtvgbHwYnxQLiKq63XODvQ9aE3XVmwDjT/khPAzIiRR/EpTDuVddx0Ke0dNrH
         gfjHTnldy/RVmFdal81wXF8SJVBjqfslXwXQqkhYnx7fg4hGSwgAfDjNRMqWaxZVOv
         OvDC009YBkxtmxsGmpIPbmqUzme6LSSYws0XQwIHEzr+eCTdVi7osu/CTD6wa5fCJ0
         7Q6XCNEp8FXXEUDhk6bgOBfOzuLT554oGX7bNQA1zlFaE57GKpz7x/hfYPyR3dtWSD
         sAs2FkN+dt1AA==
From:   Mark Brown <broonie@kernel.org>
To:     Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
        Baojun Xu <baojun.xu@ti.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        Colin Ian King <colin.i.king@gmail.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231017170436.176615-1-colin.i.king@gmail.com>
References: <20231017170436.176615-1-colin.i.king@gmail.com>
Subject: Re: [PATCH][next] ASoC: tas2781: make const read-only array
 magic_number static
Message-Id: <169758608220.3230119.5780419992173270730.b4-ty@kernel.org>
Date:   Wed, 18 Oct 2023 00:41:22 +0100
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

On Tue, 17 Oct 2023 18:04:36 +0100, Colin Ian King wrote:
> Don't populate the const read-only array magic_number on the stack,
> instead make it static const.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: tas2781: make const read-only array magic_number static
      commit: 9a4bf1f0be01582806e85322d18bf5c9f21d0b40

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

