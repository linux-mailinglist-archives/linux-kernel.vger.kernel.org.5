Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1F47E9E19
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 15:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbjKMOGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 09:06:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbjKMOFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 09:05:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F22A172B
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 06:05:48 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22D82C433C8;
        Mon, 13 Nov 2023 14:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699884348;
        bh=GhWzSotOWXrDEUhwukgKiBLKTrshxt25sfB01raAiBw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Slm7VjkOeslkgpRKjJrpdF2Wk8+skpOROmMWN1oxmvtGkLEWl8DU2jluWvVzOJGYj
         vFS/7/F/LV6eblKONBQcBjo8XBvKPXOckvUIbgs5u8Sbkc7Ue4UW4QG6ouzHgoN7n3
         qoQWcUiRXFpm1+prxV0Rz5MBmPEfMoACw196M7WN068LvR5J2S6qgSfQmHnvJ1dVXZ
         e2XE5VpdMoMlmHVDsSF3oqDUbAvNsXDLidouNmwgdp0y7ZPAhnsHeAZlU2i/wTXzaJ
         mFFQS4YL82aE2NWlhzYPHmVMQfVBvKo7wJ54y3325G36Du4LfN5b1m1KV4nsn7wox/
         BYmESNCcCvpzg==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org,
        Ben Wolsieffer <ben.wolsieffer@hefring.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
In-Reply-To: <20231102203039.3069305-1-ben.wolsieffer@hefring.com>
References: <20231102203039.3069305-1-ben.wolsieffer@hefring.com>
Subject: Re: [PATCH 1/2] regmap: ram: support noinc semantics
Message-Id: <169988434652.3280981.12852638097343584206.b4-ty@kernel.org>
Date:   Mon, 13 Nov 2023 14:05:46 +0000
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

On Thu, 02 Nov 2023 16:30:38 -0400, Ben Wolsieffer wrote:
> Support noinc semantics in RAM backed regmaps, for testing purposes. Add
> a new callback that selects registers which should have noinc behavior.
> Bulk writes to a noinc register will cause the last value in the buffer
> to be assigned to the register, while bulk reads will copy the same
> value repeatedly into the buffer.
> 
> This patch only adds support to regmap-raw-ram, since regmap-ram does
> not support bulk operations.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/2] regmap: ram: support noinc semantics
      commit: 02e3564a344064aca49f147e8a4eecbe5d3459fc
[2/2] regmap: kunit: add noinc write test
      commit: d958d97848a6604d024221920d300d07869715a2

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

