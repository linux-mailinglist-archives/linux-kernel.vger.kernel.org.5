Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FABD79D218
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 15:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235523AbjILN3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 09:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235447AbjILN3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 09:29:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66EC010CE
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 06:29:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 428C6C433C9;
        Tue, 12 Sep 2023 13:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694525377;
        bh=uY0Oi+X4/Huxf94eLk8ai1egE6LUjmikE0f0j20nWn8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Q8Tw7ZW6+KUCcFhb3EaKUPjQulLmEearjDXdN/f3hUoPgREoogrMqYQxBGOOL5Vgb
         33DIZGMezdd3QfDw/4NFNvxAWxx08BCnfW5U+a8NwbMQcNE+/LS2A+6KvnBliWi22S
         Gnk+ucJ9mSRK5JNm5VFpQNWYJQEXmLJcCZEXXOO6/maoIAHOj7ipTv+I4spFE9xMGz
         jPj0Nc/Y5lDzxox45B+n1tkYZ3ieXXq17bUjfjztPx0doqVAO9kEKBfgeVCoQUYWmG
         i09H/Uo4ESHMc1FAxEF8TGMZfOvpUydz72vmifouzbGJrAxD78pGo4yuLSF/08BVIo
         FCdA6ZR+PsOfw==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Cc:     linux-kernel@vger.kernel.org, Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230903164832.83077-1-biju.das.jz@bp.renesas.com>
References: <20230903164832.83077-1-biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH v3 0/2] Match data improvements for pv880x0 regulator
 driver
Message-Id: <169452537465.2406132.16400593952945851153.b4-ty@kernel.org>
Date:   Tue, 12 Sep 2023 14:29:34 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 03 Sep 2023 17:48:30 +0100, Biju Das wrote:
> This patch series aims to add match data improvements for pv880x0
> regulator driver.
> 
> This patch is only compile tested.
> 
> v2->v3:
>  * Swapped the patch#1 and patch#2
>  * Removed trailing comma in the terminator entry for OF/ID table.
>  * Updated commit description of patch#1
>  * Restored OF table position in patch#1 and moved OF tables close to the
>    user in patch#2.
>  * Dropped extra space from OF table entry.
> v1->v2:
>  * Moved OF/ID tables close to the user
>  * Removed trailing comma in the terminator entry for OF/ID tables.
>  * Created patch#2 for dropping CONFIG_OF ifdeffery.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/2] regulator: pv880x0: Drop ifdeffery
      commit: c187b8f87d553cc124c568ecc010a8bf73cf745f
[2/2] regulator: pv880x0: Simplify probe()
      commit: 1b4daf643a3a21cff4bcad5b799960d5a0673d11

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

