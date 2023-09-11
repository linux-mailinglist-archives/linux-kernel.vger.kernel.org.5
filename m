Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D49B79C222
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236267AbjILCHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237227AbjILCCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:02:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A0B1A73E5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 18:32:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8C46C32782;
        Mon, 11 Sep 2023 23:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694476689;
        bh=tQGNk98XYtCJLZgvi9soOGOKZ00Qj0lVYS7ZhI9QdgI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=j6oKgaBRxZN4UkjLOpE+0xjC5S2m5hhc4LZ1iazVJozGmvyinvPAy0fyMQey8x8Ya
         3lsdO4aRt0HP8tkwx6mOcf/FDGwzgyDTAvimBqamWhnj3QHlJ1AEn7tiIfSWPzbwwc
         OKIj1IZQt/EilhBreiAB1Cm5V8LEcNg3l0wR4nHhvesDMrvF5KvkS6tAVIKJmzWCX9
         Em9gMbKZWxn5sXFEe93hDaovQ9Sk71K2ieY75enNb8ceGx0QxD0G4HPbvAm2k9SjgA
         nFY2jEUXHFw7WuQXOjWakUZMUN7u8PGn0JwG/cEOc1ZE0p6/blT7JKAf82vwjumDnc
         DOQwQ5ykfQ0Xg==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230828162830.97881-1-biju.das.jz@bp.renesas.com>
References: <20230828162830.97881-1-biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH v2] regulator: ltc3589: Convert enum->pointer for data
 in the match tables
Message-Id: <169447668844.2387765.7666072783132700197.b4-ty@kernel.org>
Date:   Tue, 12 Sep 2023 00:58:08 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Aug 2023 17:28:30 +0100, Biju Das wrote:
> Convert enum->pointer for data in the match tables, so that the hw
> differences can be stored in pointer and there by simpily the code.
> 
> Add struct ltc3589_info for hw differences between the devices and replace
> ltc3589_variant->ltc3589_info for data in the match table. Simplify the
> probe() by replacing of_device_get_match_data() and ID lookup for
> retrieving data by i2c_get_match_data(). Drop enum ltc3589_variant and
> variant from struct ltc3589_info as there are no users.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: ltc3589: Convert enum->pointer for data in the match tables
      commit: 7169654ce0f754679c60a6e2f904f6f19e54bad1

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

