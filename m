Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E434C7FF1A0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 15:20:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345989AbjK3OTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 09:19:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345898AbjK3OTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 09:19:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5E9D4A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 06:19:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17432C433C9;
        Thu, 30 Nov 2023 14:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701353998;
        bh=QDL1PaO7K7mLVf0K1HVNsqEPDe8kw6NvsEJ0X7bDfWk=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=BgEI/lwgmmGylsQSkxMkaEcz8mgHCqZAyiAXQdIAxWOuxNTvOGSUdxji6Ca1Kbp+Z
         UE+Z8gDb5OYXiuAjahCzQqyRBFcu+qcNVuWggjtQQqMrqoi8+6wLkGxuyCnhU8NymR
         HRO3h8+HGOpLrHXxkJT3KixyVdVeEkRtFVbEUTsWcdZezKjYj1/Iz8OU5IO8k0RzxL
         uaeHMlSsu7bqBZeQwlpAW8yo1lZb8zG7ompN79D9X9t2vp+wgF4WaRsgxLy17MkGfK
         uMyQsPbsdR4NG6leef22iiWOBCiq/lilMIOZaBkC9o21ZL31B0diqWC3Ha8UDElujr
         YsG0/1g7e0EGA==
From:   Mark Brown <broonie@kernel.org>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Dhruva Gole <d-gole@ti.com>, linux-mtd@lists.infradead.org,
        Kamal Dasu <kamal.dasu@broadcom.com>,
        =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Mario Kicherer <dev@kicherer.org>,
        Chuanhong Guo <gch981213@gmail.com>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, AceLan Kao <acelan.kao@canonical.com>
In-Reply-To: <20231129064311.272422-1-acelan.kao@canonical.com>
References: <20231129064311.272422-1-acelan.kao@canonical.com>
Subject: Re: [PATCH v7 1/2] spi: Unify error codes by replacing -ENOTSUPP
 with -EOPNOTSUPP
Message-Id: <170135399481.77996.14013825490187287215.b4-ty@kernel.org>
Date:   Thu, 30 Nov 2023 14:19:54 +0000
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

On Wed, 29 Nov 2023 14:43:10 +0800, AceLan Kao wrote:
> This commit updates the SPI subsystem, particularly affecting "SPI MEM"
> drivers and core parts, by replacing the -ENOTSUPP error code with
> -EOPNOTSUPP.
> 
> The key motivations for this change are as follows:
> 1. The spi-nor driver currently uses EOPNOTSUPP, whereas calls to spi-mem
> might return ENOTSUPP. This update aims to unify the error reporting
> within the SPI subsystem for clarity and consistency.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: Unify error codes by replacing -ENOTSUPP with -EOPNOTSUPP
      commit: cff49d58f57e5667c10a0db85d7461790bb85cf8
[2/2] mtd: spi-nor: Stop reporting warning message when soft reset is not suported
      commit: 7a030abc0185b30a3fd19a7431347c6f5a82c588

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

