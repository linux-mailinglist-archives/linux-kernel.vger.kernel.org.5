Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C291756560
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 15:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbjGQNq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 09:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbjGQNq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 09:46:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962FB8F;
        Mon, 17 Jul 2023 06:46:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28F546105D;
        Mon, 17 Jul 2023 13:46:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C65BFC433CC;
        Mon, 17 Jul 2023 13:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689601584;
        bh=GYuAFLQlU7QtDBYLmj873EiJYSJScF5qsZTE60TG3GA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ShbBzxd2CgJ+5rZ9bUnb7yFRNy93qMJAXCTgfID+Vn9fLyzMugaBXq+BppsvAPRP0
         bv5lJIBGdd3DaEk64QtOxtDbv7TbPC7WRD8/SNS62G5iQo/n85HVHtPMV29t8h7Il4
         m79R3Ox2IBDbGZQWgxjjgYQ6h4VyN3b8gkK+JPJpNjLA07ku+Ju/3pLfS2HQb8Udxs
         +G5Iz+FwDjPtRsUMLrO+oVcGu+UGyG8BhSurX9iTCBxmgyoafCMBOKSORRfN4puwwv
         JrHUW93AZBIukqW5q4ezbJwopbHYW27H1yMfQ8f77dWLsJCMsFTLJXlLzH1TXAa/xg
         W/T+DC5tdLlTQ==
From:   Mark Brown <broonie@kernel.org>
To:     Okan Sahin <okan.sahin@analog.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        Okan Sahin <Okan.Sahin@analog.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20230717050736.10075-1-okan.sahin@analog.com>
References: <20230717050736.10075-1-okan.sahin@analog.com>
Subject: Re: [PATCH v3 0/2] Add MAX77857/59/MAX77831 Regulator Support
Message-Id: <168960158252.186271.4753370129649728027.b4-ty@kernel.org>
Date:   Mon, 17 Jul 2023 14:46:22 +0100
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

On Mon, 17 Jul 2023 08:07:33 +0300, Okan Sahin wrote:
> High efficiency buck-boost regulator driver and bindings for
> MAX77857/59/MAX77831. The patches are required to be applied
> in sequence.
> 
> Changes in v3:
> * Patch 1: "dt-bindings: regulator: max77857: Add ADI MAX77857/59/MAX77831
>     Regulator"
>   * Add second maintainer
> * Patch 2: "regulator: max77857: Add ADI MAX77857/59/MAX77831 Regulator Support"
>   * Change regmap cache_type
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/2] dt-bindings: regulator: max77857: Add ADI MAX77857/59/MAX77831 Regulator
      commit: 6d5373e98b37721987c16fd1c0f9500ecbb69f20
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

