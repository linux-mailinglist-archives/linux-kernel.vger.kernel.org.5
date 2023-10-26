Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B97F7D877F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 19:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbjJZRXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 13:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbjJZRX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 13:23:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9ABD59;
        Thu, 26 Oct 2023 10:23:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 911E5C433C8;
        Thu, 26 Oct 2023 17:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698341003;
        bh=KHEtv2BW5ufcLceTLdIMBqabDXWqTImDiZvqNq1ZFoo=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Y2nuw3nr5k9IH1ntILq8GvFLs0t2MvQiD2LoKcrMDcVykD60U9AojdjxDDmDzg2U5
         XSP0AC4essXZBjMCAt/q5uQer4x5Qr+OYvtZYW1pnBgnr9O11paHnmLZBgVO9bC4iZ
         WuhGbb72T+nKsCJFbn1dQRlS8dyjlYSVUEkQqwL2W3xEN900bUIoGw1TWMDO3YGEbu
         obNEUHnKrdVgMZj0+L9TRCdi9QKhGoi9WlhAldcAuaMr43XqMW/bvEMKLpOW3Lo1ma
         2A1N/L1b8igEVExKuzs9Q6ihYxcO0Y7sFOMx9mNGeI9loH6voS+g1geObl7hvwBHEq
         OeSHNM0T6c+DA==
From:   Mark Brown <broonie@kernel.org>
To:     Hector Martin <marcan@marcan.st>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Cc:     stable@vger.kernel.org
In-Reply-To: <20231026-regmap-fix-selector-sync-v1-1-633ded82770d@kernel.org>
References: <20231026-regmap-fix-selector-sync-v1-1-633ded82770d@kernel.org>
Subject: Re: [PATCH] regmap: Ensure range selector registers are updated
 after cache sync
Message-Id: <169834100229.152944.3846879997258619017.b4-ty@kernel.org>
Date:   Thu, 26 Oct 2023 18:23:22 +0100
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

On Thu, 26 Oct 2023 16:49:19 +0100, Mark Brown wrote:
> When we sync the register cache we do so with the cache bypassed in order
> to avoid overhead from writing the synced values back into the cache. If
> the regmap has ranges and the selector register for those ranges is in a
> register which is cached this has the unfortunate side effect of meaning
> that the physical and cached copies of the selector register can be out of
> sync after a cache sync. The cache will have whatever the selector was when
> the sync started and the hardware will have the selector for the register
> that was synced last.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: Ensure range selector registers are updated after cache sync
      commit: 0ec7731655de196bc1e4af99e495b38778109d22

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

