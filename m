Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A376E7EE83D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 21:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345529AbjKPUWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 15:22:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjKPUWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 15:22:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B04D4D;
        Thu, 16 Nov 2023 12:22:07 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2552DC433CB;
        Thu, 16 Nov 2023 20:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700166127;
        bh=Tk4VsI3q7+2p/BjMyvGCqbKi/6B2IcPsL/NYpb93qWQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=OBGG+yXG+xhEmE3lcKicd/ekzT1LDf0GFJQ8X07qXI/H+VXyHbLUZGhoarpaNKQIR
         xZCF4GKxuCLUorhVMFXggT/HubCG+9FxTCgX8+m3iR5mZ1BuFautofiPgF9zb87/xa
         PyKjMq9VQiKDFL1usaKyLgW+9RTkBjKwfyBYfA0lbNu80mKps8q5VC7bdHsS1fogQo
         SO0N/Hw+K+hx2179GY++mV0FI0uVUuuEZp7Q1kj88kxpXFRJdbPSejD6ycNpU7+8Qv
         CLtw+p2rfqqWfo+TewBhLwkXuU+Uh1NGGXkEWv/nnzffNfqxtxpDv5iCcd0/5fFy8O
         mxgMlawr4gA/A==
From:   Mark Brown <broonie@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, netdev@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-spi@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20231113111249.3982461-1-andriy.shevchenko@linux.intel.com>
References: <20231113111249.3982461-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] treewide, spi: Get rid of
 SPI_MASTER_HALF_DUPLEX
Message-Id: <170016612386.72552.14423257472508429993.b4-ty@kernel.org>
Date:   Thu, 16 Nov 2023 20:22:03 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Nov 2023 13:12:49 +0200, Andy Shevchenko wrote:
> The SPI_MASTER_HALF_DUPLEX is the legacy name of a definition
> for a half duplex flag. Since all others had been replaced with
> the respective SPI_CONTROLLER prefix get rid of the last one
> as well. There is no functional change intended.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] treewide, spi: Get rid of SPI_MASTER_HALF_DUPLEX
      commit: 3fc6350fc8470d42f5e700ecd1c3d90f9dd9fd2d

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

