Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36CEE78CDE1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 22:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240520AbjH2U55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 16:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240566AbjH2U54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 16:57:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A02193
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 13:57:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B10FF61031
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 20:57:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AD6EC433C7;
        Tue, 29 Aug 2023 20:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693342673;
        bh=X/dvtRLB9aS4Mm8IC9aF3IMr0YP9VbjRxqIhlkw5NV8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=fYPvskLJJo4TDTBIal60pg43xsR6kl/2N+7XkEgHZvGRHeLEjK15EE5hH5jlZf2Qu
         Yyx4HG04i5ILhYd6/maWZikMY26wfCDIYCaO53QdoAqk3fnSSGKp3IkHDI07njd2hA
         +o1I6FZN2sjz/+hIkGBIZpLG8wfEzSVIc6oqT4V/AD+uhEnATDfwY9MHGrusw7k8iK
         eOju1laecm0QREM0LiOAHn5aEFfS9Bc9dYpoqGht5fv8qTy50lonq2LaQOHGvwZx6d
         657YlfTqiixa5EALalBmxnBIGyzdiOm1u0iaEWi8IcULxTrk+5fHRLa3hoUyQ52iW5
         n4ByFm1QS5NAQ==
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org,
        Simon Trimmer <simont@opensource.cirrus.com>
In-Reply-To: <20230829160433.2647889-1-rf@opensource.cirrus.com>
References: <20230829160433.2647889-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: cs35l56: Waiting for firmware to boot must be
 tolerant of I/O errors
Message-Id: <169334267086.3156492.16645897237264725852.b4-ty@kernel.org>
Date:   Tue, 29 Aug 2023 21:57:50 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Aug 2023 17:04:33 +0100, Richard Fitzgerald wrote:
> Ignore failure to read from the cs35l56 when polling as the device will
> NAK i2c accesses until it has booted and this would terminate the poll
> of regmap_read_poll_timeout().
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs35l56: Waiting for firmware to boot must be tolerant of I/O errors
      commit: 06afec5c988acb2c4f566eac2f6ec53d30d3a1b5

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

