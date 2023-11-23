Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2A987F649C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 18:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345177AbjKWRAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 12:00:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbjKWRAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 12:00:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B0A3D41
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 09:00:03 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9510EC43397;
        Thu, 23 Nov 2023 17:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700758802;
        bh=EvzPaWl4rEWWAqN92zDuxih44+QveIo6CQqfvVtHmxQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Ut51JJ2B31MOyFR3mR2gsVC1yQJUTnd2mInxrcNp6lXSoTIHMr6anHzBixsognlP/
         ATUOchYc+UKMA3zGAjkvppOWxiokiEu+uYPaPnrIONO3YRtkruLyAPzVSPfE7AbIC+
         9lUSCrewRfLkLgcJuUdg7g/PTXgt2KrVVWoa5opbf1RM6E64gBDR7zT+JWZs5YZrhP
         K2P4DYJMZ23yHKAv4XGHHdTH2RgRZlq58RuieGmAJDlewM/gSB95zR8oInLZOGVoco
         ls0t1bfjcfvhoZi46iN1OJXzxbMkEhK8YevIhDGzFxvEDtJZX+2Go4raS8IAfTKBeg
         SX/kMRMjp42TQ==
From:   Mark Brown <broonie@kernel.org>
To:     Maciej Strozek <mstrozek@opensource.cirrus.com>
Cc:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231123090658.10418-1-mstrozek@opensource.cirrus.com>
References: <20231123090658.10418-1-mstrozek@opensource.cirrus.com>
Subject: Re: [PATCH v5] ASoC: cs43130: Allow driver to work without IRQ
 connection
Message-Id: <170075880043.2448402.15081787699005605640.b4-ty@kernel.org>
Date:   Thu, 23 Nov 2023 17:00:00 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Nov 2023 09:06:58 +0000, Maciej Strozek wrote:
> Add a polling mechanism that will keep the driver operational even in
> absence of physical IRQ connection. If IRQ line is detected, the driver
> will continue working as usual, in case of missing IRQ line it will
> fallback to the polling mechanism introduced in this change.
> This will support users which choose not to connect an IRQ line as it
> is not critical to part's operation.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs43130: Allow driver to work without IRQ connection
      commit: fa91703dc2e010e48a230dc92967cb5ae23f8680

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

