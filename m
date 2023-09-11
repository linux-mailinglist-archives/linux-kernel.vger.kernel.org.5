Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98F9379C25F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237425AbjILCJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243647AbjILCGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:06:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50181FDCB5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 18:37:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A551C2BCFE;
        Mon, 11 Sep 2023 23:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694476657;
        bh=yezDdDMnUXme+vgUL7Ot3zqUa+TcohvH6piJqWM0UIQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=IfIlqB6EYCWyXCFurW4QyFPcjPrt8klX/JTocTlFQK2UotbqWoRQnkbALZNtWBsKz
         S3jIAEM7eXjSfIGX/2rmda7K4rcCc8Ogwh4Gg3+3/s9MmsBwciv5uM3te/Mh6MxPBg
         Mvjfq9GiDTq3rjUY+LL/lhzbCvbbLLMD1QSBsmvKq5MYH1g3JRSMTemHMEIpIwQo0j
         CD7iqUxiXcFp7d/qUrC8daCzNTeepxpFuZxzei6mn5GJiVUZcnIrQ3QZ8TE6IBWpd7
         H0p0ireBrPIFOpRrPSGxysy6p5I+CcJuJKXlDsB1xRD6N26OWkp28PE5LwGED0jbpK
         nXycV9HqEk/xQ==
From:   Mark Brown <broonie@kernel.org>
To:     Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
        Baojun Xu <x1077012@ti.com>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230831194622.87653-1-biju.das.jz@bp.renesas.com>
References: <20230831194622.87653-1-biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH v3 0/3] Match data improvements for tlv320aic32x4
 driver
Message-Id: <169447665505.2387538.666074818019583223.b4-ty@kernel.org>
Date:   Tue, 12 Sep 2023 00:57:35 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Aug 2023 20:46:19 +0100, Biju Das wrote:
> This patch series aims to add match data improvements for tlv320aic32x4
> driver.
> 
> This patch series is only compile tested.
> 
> v2->v3:
>  * Added Rb tag from Andy for patch#1 and patch#2
>  * Simplified aic32x4_spi_probe() in patch#3.
> v1->v2:
>  * Created patch#1 for adding enum aic32x4_type to aic32x4_probe() and
>    drop using dev_set_drvdata() from tlv320aic32x4_{i2c,spi} drivers.
>  * Return value of i2c_get_match_data() passed to type paramemter in
>    aic32x4_probe().
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: codec: tlv320aic32x4: Add enum aic32x4_type to aic32x4_probe()
      commit: cac1636e214930b01b2f8ac9867771486554271a
[2/3] ASoC: tlv320aic32x4-i2c: Simplify probe()
      commit: d44f7bc9d181a2bec0dcff694d00b08c8f99284d
[3/3] ASoC: tlv320aic32x4-spi: Simplify probe()
      commit: c6d86149db94c0289b0e5950fa23c5b19031ab8d

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

