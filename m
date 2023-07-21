Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD81375C512
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 12:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbjGUKyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 06:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbjGUKyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 06:54:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7DB1719;
        Fri, 21 Jul 2023 03:54:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58ADE619BD;
        Fri, 21 Jul 2023 10:54:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 859E1C433CB;
        Fri, 21 Jul 2023 10:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689936884;
        bh=UfcFzCnVYie6vKPWZ/3LUMZroWuNQRGTQy9ESlj0NHU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=IR/vYx+KcC+hY+nU/jBsHbvgzog6GaJSP477Jv0KUAo2tunuo3bs4qjxToAeSC3H/
         z9A8Br+SJFAQbLpL6TbphmOS8ZYQ0t9VLNMMV+0gxN9m08VMnmBLv/B2UjFQNpsloX
         wQHhrAkKv2USg2YU/kVi58sRBGUKv4qf9OQJXG2MVbwzTbZpBD1kMzwyCtJQArX+0I
         bAPQGOBCUePagTvQOSAMqFDXFdRxbVQ6UclSvyLeR8GIxlMQjTvhpHPXvHa2wHQ79O
         cMPdiinCAifFKS96Q3B2qB4+xxgnUX6oJI0BXw0eqnMc3m36A85ivjIWOgB9wd3tyw
         Dnx3RCI9IgydA==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Francesco Dolcini <francesco@dolcini.it>
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        patches@opensource.cirrus.com
In-Reply-To: <20230719121918.247397-1-francesco@dolcini.it>
References: <20230719121918.247397-1-francesco@dolcini.it>
Subject: Re: [PATCH v1] ASoC: dt-bindings: wm8904: Convert to dtschema
Message-Id: <168993688226.20527.6554353152363123006.b4-ty@kernel.org>
Date:   Fri, 21 Jul 2023 11:54:42 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jul 2023 14:19:18 +0200, Francesco Dolcini wrote:
> Convert the WM8904 audio CODEC bindings to DT schema.
> 
> Compared to the original binding #sound-dai-cells and the missing power
> supplies are added. The latter are all required as described in the
> datasheet.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: wm8904: Convert to dtschema
      commit: 83759352fd0b941c3ab3d365bf5f754b9e2f1af9

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

