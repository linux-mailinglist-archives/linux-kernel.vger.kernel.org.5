Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5229D76233B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 22:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjGYUXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 16:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbjGYUXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 16:23:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65C71988
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 13:23:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4445B618CE
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 20:23:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F39BDC433C8;
        Tue, 25 Jul 2023 20:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690316625;
        bh=XzknAnHSqY6Kmrsuhoy2qmKABi3wVUdAv+56ZMRKUQw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=joorJfRsge6tlNlvB3Etwesa0ZDfY3Mvxd3mis6qSVipX+GavrKkdIwpY6WDk9Jei
         r3O8mzu8d0HuLH1XjpJxMAklNK6l2wao9MbYseHw/Psm9zuo9xZpGdLZqYAqrPWun7
         yYq/Cziga3uSffdT1WHl2GOKDVz3OQycTH9n601w813ZUsjqn1RapChMDgMr+9udOq
         De7daob1vIVNdTfFWSJENel9FCPhNl0R5Wf41hn0pCm+gbg9DEewfPa5MYYdJQ0RK/
         fEHKjGsgW/HAfHXjFMIPbG7USYG0DXvIIUVQqffFSbxpJrf2Dau4UUTC0OU15hSpYP
         Z8ALNCj9XI5Xw==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Cristian Ciocaltea <cristian.ciocaltea@gmail.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Chen-Yu Tsai <wenst@chromium.org>
Cc:     linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20230609075032.2804554-1-wenst@chromium.org>
References: <20230609075032.2804554-1-wenst@chromium.org>
Subject: Re: [PATCH v2] regulator: Use bitfield values for range selectors
Message-Id: <169031662371.1614869.934342295001385013.b4-ty@kernel.org>
Date:   Tue, 25 Jul 2023 21:23:43 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 09 Jun 2023 15:50:30 +0800, Chen-Yu Tsai wrote:
> Right now the regulator helpers expect raw register values for the range
> selectors. This is different from the voltage selectors, which are
> normalized as bitfield values. This leads to a bit of confusion. Also,
> raw values are harder to copy from datasheets or match up with them,
> as datasheets will typically have bitfield values.
> 
> Make the helpers expect bitfield values, and convert existing users.
> Include bitops.h explicitly for ffs(), and reorder the header include
> statements. While at it, also replace module.h with export.h, since the
> only use is EXPORT_SYMBOL_GPL.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: Use bitfield values for range selectors
      commit: 269cb04b601dd8c35bbee180a9800335b93111fb

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

