Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95F59778029
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 20:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235359AbjHJSXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 14:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232921AbjHJSXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 14:23:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF50128
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 11:23:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D989E66583
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 18:23:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C2B4C433CB;
        Thu, 10 Aug 2023 18:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691691802;
        bh=cN4uP7iHK+iZaX7UWlOkL78N0inEwg9N34IDm9LJIfc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=AE5vgLS4o4sTjhhQBgt6dPRk/tbXEVyCgLnfg8GJPi5TPSo7Dr7CFRqZJ8CH1MGcM
         WL+DhnGNdTjkuMaMPGikGbsBjKoHzaVUBry79+WPKzM9gMhm10uNgPu9Y+wkJ2nbOU
         ebv4xJgv/bAC9G1pgjbBC26oCEREbmtkJdPRRGTwMuVqE71RbeCdo2B6/ED4AmtKv3
         95gFBXwXam/lUp154bduuG4MFPMMaBaBr39sA+tIsIkcgTstoN9gg9wQEcYkpfZwiO
         Dsl0DzHTYkG68fxgnTPGudc1TZJ9lxhpFBMhKrXFz+9m3eVfSTplk+9GHX9znGFrsw
         jGRmDWWtRTAgA==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andi Shyti <andi.shyti@kernel.org>
In-Reply-To: <20230810111914.204847-1-krzysztof.kozlowski@linaro.org>
References: <20230810111914.204847-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 1/3] regulator: ltc3589: Fix Wvoid-pointer-to-enum-cast
 warning
Message-Id: <169169180116.623172.11825167108444824984.b4-ty@kernel.org>
Date:   Thu, 10 Aug 2023 19:23:21 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2023 13:19:12 +0200, Krzysztof Kozlowski wrote:
> 'variant' is an enum, thus cast of pointer on 64-bit compile test with
> W=1 causes:
> 
>   ltc3589.c:394:22: error: cast to smaller integer type 'enum ltc3589_variant' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/3] regulator: ltc3589: Fix Wvoid-pointer-to-enum-cast warning
      commit: fddc9bb6e277b99b0410410794d156e963aa8f0b
[2/3] regulator: max77857: Fix Wvoid-pointer-to-enum-cast warning
      commit: b29f42c6629bb3bd3d479592d40a7e4c73461a01
[3/3] regulator: lp872x: Fix Wvoid-pointer-to-enum-cast warning
      commit: c418920567ae6101826cc05cda042f71435830d0

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

