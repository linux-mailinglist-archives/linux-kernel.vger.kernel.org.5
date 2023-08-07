Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D726F77314A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 23:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjHGVeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 17:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjHGVeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 17:34:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E63C610C0
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 14:34:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 690516225E
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 21:34:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2843C433C8;
        Mon,  7 Aug 2023 21:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691444054;
        bh=/3daNd2d4UXnyYIeDbX+DccKN7TYtrFuNKljmVJOiGQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=uPs1EnpddP4YPBm0yDzy7Wxmh4rvMQsN6wbkH4l1Ft3tSX8Q9t9IV+zNqfsehp1dg
         G6dg9rUycepfPc5P2z0z+2pZAWFMSw6+ht4Csz+t3ZguqHo3N5L7i3xGH1gki2Kkik
         507ek7qeZNQVYuCETA7zPaD3Pqg/q+oD19OsHjKCP98/OWcJGICwjtSTyC+QBmVQuj
         SMmsJR3+t5o6AaaeXF3ROMYd9gTF/lw+vM19l9T6HDMaSHi1uI/MeNL1abX9OZ0Q4P
         ayX3hoT9twMANlPzIrHON8G6kLlzQpXahHSmhIt3u8FA9BMIEW2zptKAnKy+FMZaQ4
         ACpBmkiVM+Gwg==
From:   Mark Brown <broonie@kernel.org>
To:     peter.ujfalusi@linux.intel.com,
        pierre-louis.bossart@linux.intel.com,
        ranjani.sridharan@linux.intel.com, yung-chuan.liao@linux.intel.com,
        cujomalainey@chromium.org, noah.klayman@intel.com,
        daniel.baluta@nxp.com, rander.wang@intel.com,
        Xia Fukun <xiafukun@huawei.com>
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <20230807075118.128122-1-xiafukun@huawei.com>
References: <20230807075118.128122-1-xiafukun@huawei.com>
Subject: Re: [PATCH] ASoC: SOF: Fix incorrect use of sizeof in
 sof_ipc3_do_rx_work()
Message-Id: <169144405265.324168.7306091555135777709.b4-ty@kernel.org>
Date:   Mon, 07 Aug 2023 22:34:12 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Aug 2023 15:51:18 +0800, Xia Fukun wrote:
> Here hdr is a pointer, and we should measure the size of
> struct sof_ipc_cmd_hdr.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: Fix incorrect use of sizeof in sof_ipc3_do_rx_work()
      commit: 41aad0905568508070842e22ebc5398f8b733939

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

