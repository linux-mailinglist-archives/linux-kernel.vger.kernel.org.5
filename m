Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3947F7EA3EB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 20:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbjKMTlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 14:41:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbjKMTkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 14:40:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB6910EC;
        Mon, 13 Nov 2023 11:40:46 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 095DCC433C7;
        Mon, 13 Nov 2023 19:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699904446;
        bh=4ft+W7e+56ayf3hnhHhrmG47YLLOJwojtC3zh2s7l/0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ASHuhqkAoHjUyQSSVONaoi7JiYqdYq4sy2xjW86aOhJIKL8FhIx+1jf0uiyklTcYJ
         +7BJeWXqxrUrsysHdrkZ6f2n12ZCBy1Ulrs3TxJPg1y/iOnaBlpcU8juc48COnAsp1
         dKN3Zw+rlS/pHfQdgaKEEUtYDWFqbc5xCtQOr+R/oAtWrwyOtzhvdspUH8YZSHFf2H
         38E82OXs2TbfUMpeTlnDlvL/G+2SHxmOElRs9aRVH/xErcuHApDL9K4h5aaTuB9B1y
         budzlF45sgFyoyaveE2Z19mEbGKy/UmhPT23sOPtEkn572ZyyXYsbomdVj6qS+Yrny
         q6yA9EAFmXnhQ==
From:   Mark Brown <broonie@kernel.org>
To:     amit.kumar-mahapatra@xilinx.com, michal.simek@amd.com,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        git@amd.com, Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
In-Reply-To: <1699282435-884917-1-git-send-email-radhey.shyam.pandey@amd.com>
References: <1699282435-884917-1-git-send-email-radhey.shyam.pandey@amd.com>
Subject: Re: [PATCH] spi: spi-zynqmp-gqspi: fix driver kconfig dependencies
Message-Id: <169990444437.3294163.12116886943969269718.b4-ty@kernel.org>
Date:   Mon, 13 Nov 2023 19:40:44 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Nov 2023 20:23:55 +0530, Radhey Shyam Pandey wrote:
> ZynqMP GQSPI driver no longer uses spi-master framework. It had been
> converted to use spi-mem framework. So remove driver dependency from
> spi-master and replace it with spi-mem.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-zynqmp-gqspi: fix driver kconfig dependencies
      commit: 424a8166764e462258fdccaaefbdeb07517c8b21

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

