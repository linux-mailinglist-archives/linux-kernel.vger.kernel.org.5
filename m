Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8187E22AF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 14:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbjKFNDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 08:03:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbjKFNDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 08:03:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C7791
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 05:03:33 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA393C433C9;
        Mon,  6 Nov 2023 13:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699275813;
        bh=c2QlOKGHQKRqJ8EHXE6QadmeF5FbUeU59kjhrGvz5yw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=V2L8VwqFv/HrOK4xFKDjH29GWomWmFlUcCZcQMYqb1rlKaBtBZ+D1M//7VlYGOqG+
         rqNp3CJvqGVoIzCopKDshQvznXDQKbtmTk1EEJ7rRXF8wWbY/KUcOu43OVhHPyMZlI
         mke7Qyza5Ggc830Zcz/tUOQAE0Hu+OnMvfEwzU7l2noHWTU7DpAX1n7YhVoEZltqyw
         GhnUnb44SP/MvFtediHFQIE2rRWdbprGGIIEDzv1EaPpSDKfb78O34hgY3v9Zp65y1
         VqqeHVNFZQfdnqrSPCkpxbhysCYtlKr+RzsH2ImpPw9jrlF59oKfGFO0RNI6vmu/XS
         LHFvp60OyLaxg==
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231106103712.703962-1-jbrunet@baylibre.com>
References: <20231106103712.703962-1-jbrunet@baylibre.com>
Subject: Re: [PATCH] ASoC: dapm: fix clock get name
Message-Id: <169927581117.3037292.10632201210620631466.b4-ty@kernel.org>
Date:   Mon, 06 Nov 2023 13:03:31 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Nov 2023 11:37:09 +0100, Jerome Brunet wrote:
> The name currently used to get the clock includes the dapm prefix.
> It should use the name as provided to the widget, without the prefix.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dapm: fix clock get name
      commit: 4bdcbc31ad2112385ad525b28972c45015e6ad70

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

