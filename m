Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A51779C25B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237316AbjILCIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237140AbjILCCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:02:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C3F1A39A9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 18:32:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33F01C32788;
        Mon, 11 Sep 2023 23:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694476698;
        bh=Vf1KxpdwUrifBsn/L+PcvWIGONxvAk4a1BJzLQvU3s0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=BQ3ZFXSySssfjC5WgEgxJEUw27HilJpSP2sFk+HETLCK66HNGbSEvbty73Pgncweb
         8sa602qkiyk06H1AsQu/QbeGKhTynPXY8VFMN9VctHWOyNxJV5hJ0MtotsAHcG6mY1
         Rp6F/Pet931IDgZU0ZgvMVbW6okL5Bz856V2Qi9PN+37hSzXbPiBclUHNQWCqCjD9v
         OR2ZaBwXgr+iPq7+DtMUftIXgTR17hfh27UnG0hDw3FqPZIa2xPDVaaZhCOpf7+bIx
         7OdRr6JQk/zZ0iX7njotODlzRdYszgVaHM+FPOitsf3VaRiW5Ya7zSTzMkZ9cIDDyT
         LBb4lcEkAZOig==
From:   Mark Brown <broonie@kernel.org>
To:     Saravanan Sekar <sravanhome@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230903160301.79111-1-biju.das.jz@bp.renesas.com>
References: <20230903160301.79111-1-biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH v2] regulator: mp5416: Make similar OF and ID table
Message-Id: <169447669683.2387765.9814299038432822756.b4-ty@kernel.org>
Date:   Tue, 12 Sep 2023 00:58:16 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 03 Sep 2023 17:03:01 +0100, Biju Das wrote:
> Make similar OF and ID table to extend support for ID match using
> i2c_match_data(). Currently it works only for OF match tables as the
> driver_data is wrong for ID match.
> 
> While at it, remove trailing comma in the terminator entry for OF/ID
> table and drop a space from terminator entry for ID table.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: mp5416: Make similar OF and ID table
      commit: 969b033a77a8fa59a5fe9320b371eadd4f4321a6

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

