Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 364707DF1B5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 12:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345062AbjKBLwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 07:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjKBLwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 07:52:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3ED0112
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 04:52:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CAB8C433C9;
        Thu,  2 Nov 2023 11:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698925955;
        bh=g9escDvN6ku6BqYbqY+l322NYgA3VorPfFSdKmB2GUo=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=uztCRR3g+/T6WH9hkLlXl+cSOxKWrcmcxTapVU4II24UbifaHVZjKbb4Yauj5PNRk
         +p58kd+UdbENIHkPKt6ExYwono8YqP4mNfIrLQgNOJoWTzAWzaP1TOVnXqQg/X+t58
         WvQWHOMk3VZcOHV5aucSSKOhYnClU90FXRlKB5ZVIg6kXbjVZ3NVLT9FWC5gd6AH8l
         IRSZAkpLZiJIMU05z1SwJfRCfl2kiImBYpRCp26Na2i4P+pdr9tC+FiFVPr0K9ollp
         C5thoApq/BjgIzZPIQRYkHDtaWd1mXsiJqOL1SonNNW+Kb/lXSuoqoe3TvzXsD3Bbq
         LiKcfXQS6f90w==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org,
        Ben Wolsieffer <ben.wolsieffer@hefring.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ben Whitten <ben.whitten@gmail.com>
In-Reply-To: <20231101142926.2722603-2-ben.wolsieffer@hefring.com>
References: <20231101142926.2722603-2-ben.wolsieffer@hefring.com>
Subject: Re: [PATCH] regmap: prevent noinc writes from clobbering cache
Message-Id: <169892595379.21289.10256522456378482544.b4-ty@kernel.org>
Date:   Thu, 02 Nov 2023 11:52:33 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Nov 2023 10:29:27 -0400, Ben Wolsieffer wrote:
> Currently, noinc writes are cached as if they were standard incrementing
> writes, overwriting unrelated register values in the cache. Instead, we
> want to cache the last value written to the register, as is done in the
> accelerated noinc handler (regmap_noinc_readwrite).
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: prevent noinc writes from clobbering cache
      commit: 984a4afdc87a1fc226fd657b1cd8255c13d3fc1a

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

