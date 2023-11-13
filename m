Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E917E9E0F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 15:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbjKMOFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 09:05:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbjKMOFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 09:05:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E1ED69;
        Mon, 13 Nov 2023 06:05:31 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D8CEC433C9;
        Mon, 13 Nov 2023 14:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699884331;
        bh=BImJbQdyy8K/BwKo67blmm2PDHtl8GBMMx8PUF5IKjI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Drbs0YDGgEsOUazwUsnBEIw4aoWbnNZQOWwkHKSyFutPSiDzEvqO+Wqr+EBcEWb90
         +15VhmbfYsGx/LopTqZg1fRWozFvBr8a0Ex7/WQI0ShRjp682Bm7M39SAcWnCwMSw9
         504WJ/b4SNY6nE+NTUTBFiRDerz2fxO1/NBf6aWVvUj+PV0Cz4RaZNjO2lAxRKuzjK
         WtYgtYybkdGkLsQ9dGw2R6048DQFux+DHvW17Y/DSLTCU1MUKGFpnjB51D0pNKIzVl
         20qyKVlu53f2KIFf16Y6rfJ4viBI+ZwF3JWTWTPcK7B15iCK2z6r6XZPJLILQkcw0k
         fNsazvLHCl0FQ==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Rob Herring <robh@kernel.org>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
In-Reply-To: <20231101140923.16344-2-robh@kernel.org>
References: <20231101140923.16344-2-robh@kernel.org>
Subject: Re: [PATCH] ASoC: dt-bindings: Simplify port schema
Message-Id: <169988432788.3280890.8324291358177866186.b4-ty@kernel.org>
Date:   Mon, 13 Nov 2023 14:05:27 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Nov 2023 09:09:22 -0500, Rob Herring wrote:
> The use of 'definitions' is not necessary and also problematic because the
> dtschema tools don't process 'definitions' resulting in this spurious
> warning:
> 
> Documentation/devicetree/bindings/sound/renesas,rsnd.example.dtb: sound@ec500000: port:endpoint: Unevaluated properties are not allowed ('phandle' was unexpected)
>         from schema $id: http://devicetree.org/schemas/sound/renesas,rsnd.yaml#
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: Simplify port schema
      commit: 6d02f355c3d2fe86f503793e4df09898e9f9e703

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

