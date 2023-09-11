Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88F4A79C248
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236988AbjILCIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237138AbjILCCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:02:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A01F61A39A0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 18:32:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55B4EC32783;
        Mon, 11 Sep 2023 23:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694476691;
        bh=/cX8u92nzX7967bMnEAMXu1/q2BfKrbeSrVphg927kY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=q8qoY4g5/QdsGA81yJXVm59f90PvTpCi6yafTXWs5Fyhvx5Zx6Z572mgsCL7YSQa9
         1Say0zExXOZ4laOJNEs5mGMGieGnqvkqbYtw4FiS31LdD/kWatE2W+npNybDQZW+qJ
         f4v9LU/vcwdH+oEv0+52pHnqEzGVh7HZ+uG+AS1sT2aeDakLGF6UJNA1OMS3n850k4
         gFZdevUz9XDwCBpWUVWlXgw19aoNncVEYsGkSRndY4SReM8YFmYX8jqUa3GD6hbdwe
         DG9fK1aXFYMVftdaJ5C5OkaO3aViPCI1eZcIEbCU+0fxjoSNA8wOifcirx3QV8dG6W
         OyAbl1NyIBhWA==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230828164746.102992-1-biju.das.jz@bp.renesas.com>
References: <20230828164746.102992-1-biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH v2] regulator: fan53555: Simplify probe()
Message-Id: <169447668996.2387765.10257545572341009321.b4-ty@kernel.org>
Date:   Tue, 12 Sep 2023 00:58:09 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Aug 2023 17:47:46 +0100, Biju Das wrote:
> Simplify probe() by replacing of_device_get_match_data() and ID lookup for
> retrieving match data by i2c_get_match_data().
> 
> While at it, use dev_fwnode() API instead of 'client->dev.of_node'.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: fan53555: Simplify probe()
      commit: 364a399b7ca35e8f2291ab95bff28baa6e119efe

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

