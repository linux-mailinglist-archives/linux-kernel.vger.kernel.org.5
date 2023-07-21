Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E787775CA6E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 16:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbjGUOpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 10:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbjGUOo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 10:44:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C44C30C8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 07:44:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 94AB161CB8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 14:44:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26062C433C7;
        Fri, 21 Jul 2023 14:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689950697;
        bh=rlyB+sy+WhRa2JNPXaX/Hutse8mr4ySjwviNUusdn1Q=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=JX2MGiN8Wc6GTWm9jn0q41NUJM1mQCwV74eOwwlJmQEdZ66G2AdhNfoki5Eh9+X6m
         MrITou7Pzx26tcuuhGsa81dsVW0gC9T/xr/J+s4GNwhqzxLwXxplIJyMp4yC7fBgMS
         QJiYVgw3lrbqUJgkKJtcein3UwkLmtPaaRkEPAK+6LbyF5GWAIbHZI0usNJxpwkWPZ
         K3CXO7Fivox6nLqjfPFu2ziuUbfHgn65tqH3ZPUBkIFfg2gxEGVn/dMNlHHUASws6e
         lYsFAR8PCBVUYlj3a4Hprv+BWxdk0kG5+U7lh4YD71WScinONJLlFC2y9FDs+gQJLT
         22pnoW3wuJDXA==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
In-Reply-To: <20230721073303.112597-1-u.kleine-koenig@pengutronix.de>
References: <20230721073303.112597-1-u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] regulator: max8893: Drop "_new" from probe callback
Message-Id: <168995069586.110341.5283976279358056645.b4-ty@kernel.org>
Date:   Fri, 21 Jul 2023 15:44:55 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jul 2023 09:33:03 +0200, Uwe Kleine-König wrote:
> The driver was introduced when .probe_new was the right probe callback
> to use for i2c drivers. Today .probe is the right one (again) and the
> driver was already switched in commit 964e186547b2 ("regulator: Switch
> i2c drivers back to use .probe()") but the name continued to include
> "_new". To prevent code readers wondering about what might be new here,
> drop that part of the name.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: max8893: Drop "_new" from probe callback
      commit: 813ebba3b100997a24984040673d35cb2dc9f418

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

