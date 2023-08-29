Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD3BA78CD7E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 22:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240425AbjH2UUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 16:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240524AbjH2UUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 16:20:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A8BCCC9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 13:20:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D8C7A64D63
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 20:20:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25A52C433C7;
        Tue, 29 Aug 2023 20:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693340413;
        bh=hmczMxk5Tb+LSifp81lNXLuIlpPE7KAr0vIfZkNK45E=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=HWYoolPwkP41e7ypLxDxBp2KDwF2vuH3HWv5KZbwRSBrom+DF1IcUUM/C+yZ1mJkV
         2d0Z0y2LMPNtTVuRz4rkqgVd6mKX0RwqLWMReXILpy4sqCgL4g5bFL8SWcA1sh6T+K
         Ew5n0LArehgDopM1pF4Ds/WoSLZdZLh0uwczAhKsH/UAwwVCad2KCLNGksK9fzAQeK
         ZgXAh5Z8bcQsXH1WViEgbgfW6Vj87w2vlV8ZLADhh5wuyV+ff64nK16gSdNMzStEe6
         MX0PktRNDZjDe8lfqMaRnl4ePv2D3utFX+T7xKgkvYUKGA14DtfRorTWfzcDiz6j7D
         64zIhyJSO8oWA==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     Axel Lin <axel.lin@ingics.com>, linux-kernel@vger.kernel.org,
        kernel@axis.com
In-Reply-To: <20230829-tps-voltages-v1-1-7ba4f958a194@axis.com>
References: <20230829-tps-voltages-v1-1-7ba4f958a194@axis.com>
Subject: Re: [PATCH] regulator: tps6287x: Fix n_voltages
Message-Id: <169334040852.3149293.966084932580849949.b4-ty@kernel.org>
Date:   Tue, 29 Aug 2023 21:20:08 +0100
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

On Tue, 29 Aug 2023 16:04:12 +0200, Vincent Whitchurch wrote:
> There are 256 possible voltage settings for each range, not 256 possible
> voltage settings in total.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: tps6287x: Fix n_voltages
      commit: c69290557c7571dff3d995fa27619b965915e8a1

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

