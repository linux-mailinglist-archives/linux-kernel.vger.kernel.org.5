Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38DC47F1D37
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 20:19:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjKTTTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 14:19:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjKTTS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 14:18:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08062F4;
        Mon, 20 Nov 2023 11:18:54 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11DFAC433C7;
        Mon, 20 Nov 2023 19:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700507933;
        bh=j06BuuFm+JMAFgBv4pra+sWaWElq3RAU0IqrIOtdgg0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=TSlNZY5dLL0aWTx5yWgFDonGBMRY4LB9UryaSoU+Ae0/2k0AFYBJd9Ix60IuPHPPQ
         eZh6zdjsJ/ZoeshQFbfLPRmf9LWKCodu6lJ/zbcN8mJRsrlqtJu8aZx9LyrDM0ox3X
         k/okPit3L7AJcWCRiPND0FFDqYhD2WAlh94vLQ2T+xObb6tPNtm4jpJLR3CDNpRzA+
         3dYFpywA88gU4Ckv/4TAcUG7968ZFnyX4gyhJIHiPDw63XkRHvmHMiEfLa8OMXSPSA
         hDKVMT6mO5VMvJIKp5LDymu2KK+hwlJo08pjQ1aY3BO7flV8MtAPqUhQZPhjqmKJFR
         vNoCQFQS0M3qw==
From:   Mark Brown <broonie@kernel.org>
To:     Maciej Strozek <mstrozek@opensource.cirrus.com>
Cc:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231120141734.76679-1-mstrozek@opensource.cirrus.com>
References: <20231120141734.76679-1-mstrozek@opensource.cirrus.com>
Subject: Re: [PATCH v3] ASoC: cs43130: Allow driver to work without IRQ
 connection
Message-Id: <170050793178.1294254.1258854570735859586.b4-ty@kernel.org>
Date:   Mon, 20 Nov 2023 19:18:51 +0000
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

On Mon, 20 Nov 2023 14:17:34 +0000, Maciej Strozek wrote:
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
      commit: 009eab8baa4d46c2b20d0c2c1cbdba61c81829e4

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

