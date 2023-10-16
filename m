Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4787CAD07
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 17:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232483AbjJPPLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 11:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233634AbjJPPLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 11:11:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A04FE8;
        Mon, 16 Oct 2023 08:11:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95E09C433C8;
        Mon, 16 Oct 2023 15:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697469070;
        bh=/227UfKX32JYe+eKrbqR7BK2JZtah+TQm9kqJBQ4C44=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=dM2yYtv1fDayz6soPEJaCmH4nND/2Wu7Xuy0abNb9rzJ9cJ9F0pa88lzUj3fHt1Gm
         NWynLpYzt+kWfISgMhqflE6SDnYb2oz68XiLRu962YWbEeHgRSwHwOk5NGS+Qa2efz
         +EZQFJd7R5CJvxrwcgu/LUYbVuYa3ywq/jNLKpqUPPoVcMP1MkMSs7+bjcDnIstlB2
         53BKFmw/A4/GJjMg1XEO5OqemMRYxgUACLDl8nTITT6UAxOhRN2LW/w1qRReIIcC0v
         bPF74PHnBz+Efd0dJX6PqvrpRAI5VuMQDYCOvGSwmltMBTB5sCZeXcrBBPGVuHpVlS
         t1X6wPywFWKFw==
From:   Mark Brown <broonie@kernel.org>
To:     Haibo Chen <haibo.chen@nxp.com>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>,
        Adam Ford <aford173@gmail.com>, Han Xu <han.xu@nxp.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231010201524.2021340-1-han.xu@nxp.com>
References: <20231010201524.2021340-1-han.xu@nxp.com>
Subject: Re: [PATCH] spi: nxp-fspi: use the correct ioremap function
Message-Id: <169746906931.40704.1616418494806230701.b4-ty@kernel.org>
Date:   Mon, 16 Oct 2023 16:11:09 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Oct 2023 15:15:24 -0500, Han Xu wrote:
> AHB memory as MMIO should be mapped with ioremap rather than ioremap_wc,
> which should have been used initially just to handle unaligned access as
> a workaround.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: nxp-fspi: use the correct ioremap function
      commit: c3aa5cb264a38ae9bbcce32abca4c155af0456df

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

