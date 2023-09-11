Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACBBA79C21E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235321AbjILCHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237177AbjILCCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:02:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0401A39B4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 18:32:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 678E8C32786;
        Mon, 11 Sep 2023 23:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694476694;
        bh=nU4ZuFvsBssXbipEtoX7o9m1hbZ5hIIfhTqwXxXj7Y8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ltXzJO0akvu6yiBqZ77m3S8vHMCwul3IJqPpgDcc2aKSFlKW5NV15tVftrg4tHTtt
         OE+v35dwW5gEFjZgqG5HKryeLihLkvPJLUcekQKF4Q5yDtl6QUdlm9XOOHUdLxr88l
         K9IZkSsB/fNKt+SPSQoBY0ZCpK2oEwdoCVF1I3WP89BzF4+R3ikM8KtdC+Eh7xPqEj
         mJJhrhrRtu06QndOYXsLo0kaVF5IHo2qj7VLxQ0XR2zr0fPgAaHt0F6kloWCOZGZvv
         IPDUbBrUBAOYhcsuK8X13wN0N6qpUUOn/14Zx8k59CfOy0VfUGt6lfEHkgN8TdPEMT
         oxBn40XSuxf1w==
From:   Mark Brown <broonie@kernel.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230903154257.70800-1-biju.das.jz@bp.renesas.com>
References: <20230903154257.70800-1-biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH v2] regulator: max20086: Make similar OF and ID table
Message-Id: <169447669303.2387765.3897130383603819526.b4-ty@kernel.org>
Date:   Tue, 12 Sep 2023 00:58:13 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 03 Sep 2023 16:42:57 +0100, Biju Das wrote:
> Make similar OF and ID table to extend support for ID match using
> i2c_match_data(). Currently it works only for OF match tables as the
> driver_data is wrong for ID match.
> 
> While at it, drop blank lines before MODULE_DEVICE_TABLE* and remove
> trailing comma in the terminator entry for OF/ID table.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: max20086: Make similar OF and ID table
      commit: 9d9cd8e6a4572efa328ef72a83bbc78a39deca37

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

