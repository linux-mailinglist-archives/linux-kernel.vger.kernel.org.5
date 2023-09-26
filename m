Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5AB87AED75
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 14:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234759AbjIZM7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 08:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234751AbjIZM7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 08:59:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7875F11F
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 05:59:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96DC6C433C8;
        Tue, 26 Sep 2023 12:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695733152;
        bh=UdXp7/c8ut306XYvTzfbHKmn3lSMCaBtkxOMszStqKE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=PZFvLk87Q413q3LN6ydWJV2pQrGIQ8xU9ZpkCa3MIYBHcC99H3Q/XXkFEacqtgd4r
         HVn2hYeXxVrfj4oAtTKhkXA1oOJD8ROYcZcHbIVNWTa9oZ5lOBLD0q2pGGfA5u5g34
         /AuCwAEn5iMDMKbug9VXAp28nTpfDfXItO0s9jQD42Ub7eFK7di0RCUhMBwGCSEiuw
         sT04zdKqLIr8WnTKuBmf2IKZd3ytZwA2I8/AI/OOxCUaB2IsyQ4A7GIxZAQd7dUMXH
         oRYO28D/hNuAucWeApr60xMs/Xxvs05EFBc5WGCZS1N8f2BQlAdPxhryMIL7WmS33E
         zkzZAQ2SZuk3A==
From:   Mark Brown <broonie@kernel.org>
To:     Lee Jones <lee@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>
Cc:     Zhiyong Tao <zhiyong.tao@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
In-Reply-To: <20230913082919.1631287-1-wenst@chromium.org>
References: <20230913082919.1631287-1-wenst@chromium.org>
Subject: Re: [PATCH v3 0/3] regulator: mt6358: Remove bogus regulators and
 improvements
Message-Id: <169573315033.2623509.11014819361960340290.b4-ty@kernel.org>
Date:   Tue, 26 Sep 2023 14:59:10 +0200
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

On Wed, 13 Sep 2023 16:29:15 +0800, Chen-Yu Tsai wrote:
> This is v3 of the remainder of the MT6358 regulator driver cleanup
> and improvement series. v1 can be found here [1]; v2 is here [2].
> 
> Changes since v2:
> - Merged patches dropped
> - Fixed up pickable linear ranges' selector values
> - Collected tags
> - Patch adding missing regulator definitions squashed into patch using
>   the definitions; recommended by Krzysztof on my MT6366 series.
> - Remaining dts patch split out to be sent separately
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/3] regulator: mt6358: Fail probe on unknown chip ID
      commit: 7442edec72bc657e6ce38ae01de9f10e55decfaa
[2/3] regulator: mt6358: Add output voltage fine tuning to fixed regulators
      commit: cf08fa74c716cf20e5038d1e7dbbd7dba1b76062
[3/3] regulator: mt6358: Add output voltage fine tuning to variable LDOs
      commit: 017c6658fd59740f9845ca0d3369ddd778e3e0c0

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

