Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E24A79B9A5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344476AbjIKVOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243852AbjIKSDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 14:03:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02754103;
        Mon, 11 Sep 2023 11:03:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B114AC433C9;
        Mon, 11 Sep 2023 18:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694455398;
        bh=8VUHQIE2bSECn1O0T1XpJ7Vzs1gNAY1Lke9jXYxNgpc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=HqDRjIs4lIt69JcxecmjXusNSPXcNtC+h7GNDtfbzFmtuukxb7VLzaJLfvyGGUbgE
         GDMiHWCHVyVSZqhK277+7e8sw3xoasyxxvCSlnYukTIUvBAzASuGil6xgJui4I3Zv8
         kn3ukN00P4df4oeFNCBOJL0fqyCo4cBvknZLfdqRzQ4c4nNv/Fyn3dOa/M693pWL4l
         9CWc7JT9WNQq+stcP4K6uT/YGsXeyJdUtX+y+R7pVjVMRrPHEUU0kiBWAYgUwavKN+
         6hn40V7oJbpTmt4pH6CNqHKVwXgMLUfpcUdAOWgWnamfsudEsodiKkqv8Fyef/46u4
         bP3lxeVi351Iw==
From:   Mark Brown <broonie@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Dimitris Papastamos <dp@opensource.wolfsonmicro.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Mark Brown <broonie@opensource.wolfsonmicro.com>
In-Reply-To: <8595de2462c490561f70020a6d11f4d6b652b468.1693857825.git.christophe.jaillet@wanadoo.fr>
References: <8595de2462c490561f70020a6d11f4d6b652b468.1693857825.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] regmap: debugfs: Fix a erroneous check after
 snprintf()
Message-Id: <169445539626.1864802.2526626192884158313.b4-ty@kernel.org>
Date:   Mon, 11 Sep 2023 19:03:16 +0100
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

On Mon, 04 Sep 2023 22:04:06 +0200, Christophe JAILLET wrote:
> This error handling looks really strange.
> Check if the string has been truncated instead.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: debugfs: Fix a erroneous check after snprintf()
      commit: d3601857e14de6369f00ae19564f1d817d175d19

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

