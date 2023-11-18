Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8926A7F03B1
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 00:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbjKRX6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 18:58:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjKRX6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 18:58:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD89593;
        Sat, 18 Nov 2023 15:58:44 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28A60C433C8;
        Sat, 18 Nov 2023 23:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700351924;
        bh=QA4uppqGFR2tJvIX1b8EhVR3/u1V+ni09uqTla3cndc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=gm9vrwrtzWlJCm6rZyD9olZMZC5ts3PVqfzPi3yj+C/906Ty+aq4IKg1BJiuVE8L5
         AKkOAEOG7NQJn0ww7IjKFEWuDE9uJTVRGQ0BQrARjB8GeZInCmd0aFCgXRoRSRv2AC
         I+hFMNf8vHTYnPp/IckzX34GpEq8GPHUmdvgtHAwzJl/Tq8m0tBrzoaRNfcP3SUl5E
         g/8LcttPnlZ1ggxNJmVV3rkW/874ojeljNUlc5P3a6B2K5mPW+L7iwGdiLm+SvJtie
         UvUSqK/+XNEEgOtQgEpLV4tTKKJ+pidxaHpHgZuhX+dKG45ilxdFr2IFLgCk5XDrqz
         9Ws7bD3LYvDzw==
From:   Mark Brown <broonie@kernel.org>
To:     mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com,
        Raag Jadav <raag.jadav@intel.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231117144053.24005-1-raag.jadav@intel.com>
References: <20231117144053.24005-1-raag.jadav@intel.com>
Subject: Re: [PATCH v1] spi: intel: make mem_ops comparison unique to
 opcode match
Message-Id: <170035192268.1651611.14278116345561111783.b4-ty@kernel.org>
Date:   Sat, 18 Nov 2023 23:58:42 +0000
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

On Fri, 17 Nov 2023 20:10:53 +0530, Raag Jadav wrote:
> Instead of comparing parameters for every supported mem_ops, only compare
> on opcode match, which is relatively more efficient.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: intel: make mem_ops comparison unique to opcode match
      commit: 18a813a1f94abbab14248071ca551e491bbc2abe

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

