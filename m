Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A68157731B6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 23:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjHGV5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 17:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbjHGV5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 17:57:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DBFEB5;
        Mon,  7 Aug 2023 14:57:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9777C62291;
        Mon,  7 Aug 2023 21:57:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FFF0C433C9;
        Mon,  7 Aug 2023 21:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691445449;
        bh=0ML2gOYbMi7q53kXMKWrJvXK+l8hYBQXTku7bV36CMo=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=lh3hUamZnvbGM2wdoODzGDJn8TbJNpCSR2qurv8mhAmjhHrgUL9V5A7TQr/NYXus4
         WJBzO7jJQ2pS8eNKxsgN94eXSLkUk0X4Wu2F+meAtwH3arotNNFW4qeuclApLwXfzm
         rkga/zCfhm9k6Kuauby6WgJBqHcYtJlcyJiBn1hHjQOokG8DFIDn+pTNbhDkK4+ON7
         80OKd+/Vaepn6ausIzIhS0LM4DosbhwNpBTPEUdhQK4Gq4liR/1UuYtWW/907FDtzV
         tx7RS9ikgNifHMeYHrl13W5ZhuDb5e3/GP5jfxf2Cg4TDIIaSetMcR++ibXJHvp/6g
         agmfgS2KTJbCg==
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonas Gorski <jonas.gorski@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230727070806.12205-1-jonas.gorski@gmail.com>
References: <20230727070806.12205-1-jonas.gorski@gmail.com>
Subject: Re: [PATCH v2] dt-bindings: spi: convert spi-brcm63xx.txt to YAML
Message-Id: <169144544711.329334.14827967819427624275.b4-ty@kernel.org>
Date:   Mon, 07 Aug 2023 22:57:27 +0100
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

On Thu, 27 Jul 2023 09:08:06 +0200, Jonas Gorski wrote:
> Changes done during conversion:
> 
> * added a description, lifting and adapting the limitation sentence from
>   brcm,bcm63xx-hsspi.yml
> * added appropriate compatibles for all SoCs that are supported by
>   bcm63xx/bmips
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] dt-bindings: spi: convert spi-brcm63xx.txt to YAML
      commit: 0e19118ab24beea86dac16ce3c550c47d31f777d

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

