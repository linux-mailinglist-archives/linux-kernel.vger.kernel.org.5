Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3050A752B33
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 21:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233149AbjGMTvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 15:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232321AbjGMTvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 15:51:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A2F32D41
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 12:51:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE6AC61B30
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 19:51:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BC08C433C7;
        Thu, 13 Jul 2023 19:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689277864;
        bh=RtiaTGckWKbZxwOmj5pBEFw8EKpdYqkAlq63iDnjx6s=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Vtu3uPpMb5pm/wBYPqYMM4Alrfq/ud3nBWROfaO7qmIan8fxXcsZMb0tBJgWHwZcF
         RYXwuH6WJ0lfPC6BigFJxBHcbb44HB0iq0mRZLWzOl1EZNSIHTh3HBs2rGam7mhW6x
         HOJHFNfh0AKe4cL6yXN5p2S6dYGt7PjfAKB/X7X2/RriEf6Diii1W5QePtIbe/dLZk
         R1C3Sw57xTYmQxE1oObv//WB6Ysw3OEGCfgePAGFdAFhsVVvkmFGNQSO99bcE4L8f5
         tb/dAZEY2juN/XUUBbaBxB9w4i6kMzkxE+v6oJ3UyOLHxGsl3yUvX17GrOs/UmS97Y
         rnLK4X8zeWzjw==
From:   Mark Brown <broonie@kernel.org>
To:     linux-arm-kernel@lists.infradead.org,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc:     Support Opensource <support.opensource@diasemi.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Marek Vasut <marex@denx.de>, kernel@dh-electronics.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230713090328.3879-1-cniedermaier@dh-electronics.com>
References: <20230713090328.3879-1-cniedermaier@dh-electronics.com>
Subject: Re: [PATCH V5] regulator: da9062: Make the use of IRQ optional
Message-Id: <168927786232.267267.7055463236282761197.b4-ty@kernel.org>
Date:   Thu, 13 Jul 2023 20:51:02 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jul 2023 11:03:28 +0200, Christoph Niedermaier wrote:
> This patch makes the use of IRQ optional to make the DA9061/62 usable
> for designs that don't have the IRQ pin connected, because the regulator
> is usable without IRQ.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: da9062: Make the use of IRQ optional
      commit: 497897cb200d03b89524e6b4dfb71c77af324766

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

