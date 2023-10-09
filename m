Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E947BE9A5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 20:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378076AbjJISgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 14:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378087AbjJISga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 14:36:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FCDFF1
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 11:36:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10013C433C8;
        Mon,  9 Oct 2023 18:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696876588;
        bh=UtdyveDWWHHSkdK1+oJvfL+FiLXQ7l2c311dluDzelU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=uxuNNY0sThcuwVxrYphBlkuSBPNWfnzGkDNxML7k/Hou8MQkd00Qfxl2YwaimkfGN
         6wAapn2vvS1rnDCjIEHWaqrl3OId3Nt4Y1uPMDCR1vydZIHzlJZXhPgjz/U0BLfX+6
         wqw2Qq04JE6+tCBICIHk85It9iMmHISTkMUJ6bntoUwziLI4Pu9Ajd0E1iCuHCuoGM
         tzmtACWskzx/esXjeQP0otf/trpF5EerF3FYqLkC7/lOX6bUgGBW5LyOo/sHA5ZSJB
         e6PyBN/HMMV16On9Gf5Q4axJKpbsmCoTm/To4wIpSCJcTyOf33mVtVg+fdhnxqe7RC
         Zks7PAdBgJIpw==
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
In-Reply-To: <20231006164405.253796-1-rf@opensource.cirrus.com>
References: <20231006164405.253796-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: cs35l56: Fix illegal use of init_completion()
Message-Id: <169687658644.138823.563040829634157998.b4-ty@kernel.org>
Date:   Mon, 09 Oct 2023 19:36:26 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 06 Oct 2023 17:44:05 +0100, Richard Fitzgerald wrote:
> Fix cs35l56_patch() to call reinit_completion() to reinitialize
> the completion object.
> 
> It was incorrectly using init_completion().
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs35l56: Fix illegal use of init_completion()
      commit: af5fd122d7bd739a2b66405f6e8ab92557279325

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

