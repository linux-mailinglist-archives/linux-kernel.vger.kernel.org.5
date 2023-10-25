Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEE7F7D7299
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 19:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233876AbjJYRsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 13:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233387AbjJYRsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 13:48:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 362D6CC
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 10:48:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2775C433CB;
        Wed, 25 Oct 2023 17:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698256079;
        bh=IC6yiDX3Kjh1tzMkFWq00Eim5ssTBfQdN1nJyO1CAvA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=mUeWrquFevWR3hn1l8bX9tf4vPYywaoVnvqlW88qhO66W3kYHK6amFmhho0/lLwhy
         uQAeaXH9pcwoHiuZQmpU8pOgp5EvYh3CxVX5Qaf8GrYaJYzAlKuP6JtUGmEENpNGsi
         /wRx/mf9QbPMriUoAXYS9NtfbuoJsf29AtjZ7WO+jFNbszP7clUUIEOJ1f8jnM1+Gl
         jEHarE3xbWR2dDBKOZLdFGA21aZlA0FYO7gIOg07HeMuOUnh4JxpQbos4gwwVx1rTk
         wQ4ZM2zkrnfujhRiS9TKujGDh0HauD8SklsQ8tjk4QlkaDVoVnivfGsAtZishcJH8U
         T9/OUeDL/z2og==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Oleksij Rempel <linux@rempel-privat.de>
Cc:     kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
In-Reply-To: <20231025084614.3092295-1-o.rempel@pengutronix.de>
References: <20231025084614.3092295-1-o.rempel@pengutronix.de>
Subject: Re: (subset) [PATCH v3 0/7] regulator: add under-voltage support
Message-Id: <169825607763.44380.12067191932471513673.b4-ty@kernel.org>
Date:   Wed, 25 Oct 2023 18:47:57 +0100
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

On Wed, 25 Oct 2023 10:46:07 +0200, Oleksij Rempel wrote:
> This series add under-voltage and emergency shutdown for system critical
> regulators
> 
> changes v3:
> - add system-critical-regulator property
> - add regulator-uv-survival-time-ms property
> - implement default policy for system critical uv events
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[3/7] regulator: dt-bindings: fixed-regulator: Add under-voltage interrupt support
      commit: 0ab1dc9c657f30434ca55a3dcc87e624af0b2116
[5/7] regulator: fixed: add support for under-voltage IRQ
      commit: ecb6f1f456144e9ade5a492192287decbeef4cfe

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

