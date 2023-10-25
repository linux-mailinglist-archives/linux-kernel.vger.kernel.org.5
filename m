Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2807D7298
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 19:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233381AbjJYRsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 13:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbjJYRsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 13:48:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D59181
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 10:47:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4297AC433C7;
        Wed, 25 Oct 2023 17:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698256077;
        bh=7vCImhAy/djrVdzvnhfX4P8W3qXogIjUQ+V/wfWi/00=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=kOQSU+3nk0dQ+Hv5JJT9gxQfFdsDCc052I4UmnMXP/WUt9BEXML1WQSC4wZKxO4Sn
         GNG0djPn5j5iWGsJ7fEdWHqwf077bkM+Px4zywVbB3ONUgDYtb5vlMXjUlu45NXIB6
         V9ESq38pxoZMf4aSYbf9sJLpy5QBwXCznwUg4tTG2DjMAAY90jdkk9k3FIQMPolZ+V
         n4y3C6BSE4W5rqOzPKCFl3MBV9WmAd7KFUz83frwevbfGXaLnQQpUchJTtDkfCPYC8
         p0ufRLVXncYf6JXYMIDCyHZIo8fr2T6RjWPqsb4FOioC4xxgGSLWSq5HKHc8DCXkzr
         Y67YkHYaI1FRA==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Oleksij Rempel <linux@rempel-privat.de>
Cc:     kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
In-Reply-To: <20231010085906.3440452-1-o.rempel@pengutronix.de>
References: <20231010085906.3440452-1-o.rempel@pengutronix.de>
Subject: Re: (subset) [PATCH v1 1/3] regulator: dt-bindings:
 fixed-regulator: Add under-voltage interrupt support
Message-Id: <169825607496.44380.1474728681067592948.b4-ty@kernel.org>
Date:   Wed, 25 Oct 2023 18:47:54 +0100
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

On Tue, 10 Oct 2023 10:59:04 +0200, Oleksij Rempel wrote:
> Add under-voltage interrupt support. This can be used with simple
> regulators having no other way to communicate an under-voltage event
> except as by toggling some GPIO line.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> 
> diff --git a/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml b/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml
> index ac0281b1cceb..0f8760ed2fb1 100644
> --- a/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml
> +++ b/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml
> @@ -100,6 +100,14 @@ properties:
>    vin-supply:
>      description: Input supply phandle.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/3] regulator: dt-bindings: fixed-regulator: Add under-voltage interrupt support
      commit: 0ab1dc9c657f30434ca55a3dcc87e624af0b2116
[2/3] regulator: fixed: add support for under-voltage IRQ
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

