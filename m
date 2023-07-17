Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C083575655F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 15:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbjGQNq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 09:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbjGQNqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 09:46:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE6394;
        Mon, 17 Jul 2023 06:46:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E0BE060F04;
        Mon, 17 Jul 2023 13:46:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC886C433C7;
        Mon, 17 Jul 2023 13:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689601582;
        bh=ltbT0neaTI80Kv3uMvqwGiUa139evSlEeXzktSAdHZ8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=iCp1ic08pw/vUCChN53tyAHS/JocJG8x0BrvsA0ogBciQSPr5Wro3WafJQkmLVGnI
         AaZl1BtIIYU2LA/I+e/jHTj4VLN9aMea/Lm+q+XKuR0piMIilu1boaflynVLd9yYFk
         nylTQqnARHhmLHocGJIrKia04qY6ULpO7NXDsOKDHXUicsl58LtJnPry4Y0rkDwhXd
         aUhFzkCeaU9j5a51j/2g9bM9AVLpotZz5ouhx2GBiEdd49vLnkNqE5+Fm5ZoAO3msy
         CkAn1IPGLGbERAtjDOnrtk1yH6QPhAWS/rKV3Issu/+20cIV/CPs6AjCuHGNbG/6ce
         S0B7/ZKPv7vAw==
From:   Mark Brown <broonie@kernel.org>
To:     Okan Sahin <okan.sahin@analog.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20230711162751.7094-1-okan.sahin@analog.com>
References: <20230711162751.7094-1-okan.sahin@analog.com>
Subject: Re: [PATCH v2 0/2] Add MAX77857/59/MAX77831 Regulator Support
Message-Id: <168960158041.186271.14250946295408785273.b4-ty@kernel.org>
Date:   Mon, 17 Jul 2023 14:46:20 +0100
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

On Tue, 11 Jul 2023 19:27:46 +0300, Okan Sahin wrote:
> High efficiency buck-boost regulator driver and bindings for
> MAX77857/59/MAX77831. The patches are required to be applied
> in sequence.
> 
> Changes in v2:
> * Patch 1: "dt-bindings: regulator: max77857: Add ADI MAX77857/59/MAX77831
>     Regulator"
>   * Add max77859 support
> * Patch 2: "regulator: max77857: Add ADI MAX77857/59/MAX77831 Regulator Support"
>   * Add max77859 support
>   * Drop interrupt support
>   * Change regmap cache_type
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/2] dt-bindings: regulator: max77857: Add ADI MAX77857/59/MAX77831 Regulator
      (no commit info)
[2/2] regulator: max77857: Add ADI MAX77857/59/MAX77831 Regulator Support
      commit: af71cccadecedad3484c2208e2c4fc8eff927d4a

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

