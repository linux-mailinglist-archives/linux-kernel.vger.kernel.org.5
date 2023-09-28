Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 727B87B1622
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 10:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbjI1Ifi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 04:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbjI1If3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 04:35:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1AB6B7;
        Thu, 28 Sep 2023 01:35:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A92CAC433C8;
        Thu, 28 Sep 2023 08:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695890126;
        bh=BXKuSwxQYMZDWnHeMh42197Xtc39WY9qj+WS4SHJKmY=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=aLAEB6nQNFQk9VXuJ/YvDtCbAmn8kXfuahY6BDRz35KHAywS8C/S9m1gx0vntDQ1G
         L/mj8e/K7IIAH53Cc7fM9rO2aNr3TQJQUVSiVemyreCqmpqWAHeQin1BT4/A2R0KrW
         C1N8VzbRlhAlTWP2GYbHqXfsOLZ68yLGL4b1dF7RCS91zmUZKAaIpnmL3b2AeR7dlc
         jOpT0kijBgVZPMzgwRGWw0FVBx7PzmrlImvmniZHcnl3DexpD2UfbUxr8wpWh8zT/X
         ojDB94CcmXzjfOc6+C+Pl+9E+YotJrqzpUO99WM5C9f0YT7d+IHSLq7JdayazlK25E
         dFeChPMK6Yfsg==
From:   Mark Brown <broonie@kernel.org>
To:     verdun@hpe.com, nick.hawkins@hpe.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, charles.kearney@hpe.com
In-Reply-To: <20230920215339.4125856-1-charles.kearney@hpe.com>
References: <20230920215339.4125856-1-charles.kearney@hpe.com>
Subject: Re: [PATCH v1 0/1] spi: spi-gxp: BUG: Correct spi write return
 value
Message-Id: <169589012541.2716525.12263477961965733985.b4-ty@kernel.org>
Date:   Thu, 28 Sep 2023 10:35:25 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Sep 2023 21:53:38 +0000, charles.kearney@hpe.com wrote:
> Bug fix to correct return value of gxp_spi_write function to zero.
> Completion of succesful operation should return zero.
> 
> Fixes: 730bc8ba5e9e spi: spi-gxp: Add support for HPE GXP SoCs
> 
> Charles Kearney (1):
>   spi: spi-gxp: BUG: Correct spi write return value
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-gxp: BUG: Correct spi write return value
      commit: 1a8196a93e493c0a50b800cb09cef60b124eee15

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

