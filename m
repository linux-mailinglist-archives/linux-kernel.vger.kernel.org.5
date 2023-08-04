Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1914B770679
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 18:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbjHDQ5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 12:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbjHDQ5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 12:57:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD494C0B
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 09:57:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3452620B6
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 16:57:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A87BC433C7;
        Fri,  4 Aug 2023 16:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691168249;
        bh=EypImsegK9bJKnJsBqy304+rYPk0LV8Bbnk7RSxHhMQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=EqmSMS7TudlJ8JTc68GnSkQ6v1QbSvx9urhSxPhIn/xrw5CTd1uycJqW1/W0L5bC3
         ljN6G13tUtgvK7PVwW47ThVqaEbCpgUF6+uD7cN6LDO93uFywUhiGt/bBv3J9TL5NK
         YLbNxe2WbSqUI1beL+vIS4IxDbYPZpqbt5NWHblnyiXGY7AgyTp0nuGuoLBr4bpmQO
         WH5YwDEOcPn9xfBYlZ0kmRoWo8qzvdsJmb/IW2ackNKNMZS62bmq2VVla2dIBe1+Iq
         zZlRnfWHNJtbL/AOvQZOv7fQ2i7V/QD96XsnUNt3kzRhTDBaX+AH8tuYpYy72Hx6sh
         zUSZwSs/CmwHg==
From:   Mark Brown <broonie@kernel.org>
To:     pierre-louis.bossart@linux.intel.com,
        peter.ujfalusi@linux.intel.com, yung-chuan.liao@linux.intel.com,
        ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
        daniel.baluta@nxp.com, lgirdwood@gmail.com, tiwai@suse.com,
        perex@perex.cz, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        Trevor Wu <trevor.wu@mediatek.com>
Cc:     yc.hung@mediatek.com, allen-kh.cheng@mediatek.com,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230803075028.32170-1-trevor.wu@mediatek.com>
References: <20230803075028.32170-1-trevor.wu@mediatek.com>
Subject: Re: [PATCH] ASoC: SOF: mediatek: mt8186 modify dram type as
 non-cache
Message-Id: <169116824521.110745.9626523635220489877.b4-ty@kernel.org>
Date:   Fri, 04 Aug 2023 17:57:25 +0100
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

On Thu, 03 Aug 2023 15:50:28 +0800, Trevor Wu wrote:
> To prevent incorrect access between the host and DSP sides, we need to
> modify DRAM as a non-cache memory type. Additionally, we can retrieve
> the size of shared DMA from the device tree.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: mediatek: mt8186 modify dram type as non-cache
      commit: 1d54134df47684ee29d4d4bbe28174a4282389e0

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

