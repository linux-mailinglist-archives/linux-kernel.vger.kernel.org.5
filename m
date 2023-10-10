Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC327C037C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 20:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343588AbjJJSdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 14:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234201AbjJJSdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 14:33:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 565E8CA;
        Tue, 10 Oct 2023 11:33:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E1C5C433C7;
        Tue, 10 Oct 2023 18:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696962827;
        bh=sZ/2OHJxY8bHQQM3jwEjvDUlRp1QAdM//5vOwwb3o2E=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ulwJccVIH8VHg2vRllrc2ydedgCGB0pR75FnjaW3/bmybxhrLTMYSEWWjxnc5IJbf
         mjZnYn8Mg8Mnph8NFaPMlbNiY0Tzu6AYm+jmcPrgasGzdeHLi1ZwCuDm97cnxrfdMC
         IGw7zMUjXaj5MFFo1ZIRHEb5tzIB6/XbkXLjkvycVTTDcxPgu64lGGCsdgQ56pNodT
         ieJJmuAMXEFX4JuqInJOGZ9U17z9gc1FrZJ83gCLB0NuBhGTYhu9uQqJFGAfMhflAa
         9797BcTG0LuP/axkuVkwMe+GiV1lTzheQsCXNVnCU4CU8TnCJ2pEwtx4LXDU63c8e7
         WLSjv0A+6xcKQ==
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20230927162508.328736-1-fabrizio.castro.jz@renesas.com>
References: <20230927162508.328736-1-fabrizio.castro.jz@renesas.com>
Subject: Re: [PATCH v2 0/2] Add RZ/V2M CSI slave support
Message-Id: <169696282402.222014.2482702719398525940.b4-ty@kernel.org>
Date:   Tue, 10 Oct 2023 19:33:44 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Sep 2023 17:25:06 +0100, Fabrizio Castro wrote:
> the CSI IP found inside the Renesas RZ/V2M SoC supports
> both SPI host and target.
> This series extends the CSI dt-bindings and driver to
> add SPI target support.
> 
> v1->v2: I have dropped properties renesas,csi-ss and
>         renesas,csi-ss-high. I have added property
> 	renesas,csi-no-ss, and to configure SS as active
> 	high one now needs to use property spi-cs-high.
> 	I have also purged "master" and "slave" as naming
> 	schemes (besides for the title of the cover letter,
> 	to make it easier to follow this discussion), I
> 	am now using "host" and "target" and related APIs
> 	instead.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: renesas,rzv2m-csi: Add CSI (SPI) target related property
      commit: 4056d88866e5941ebd15fb2523119f0ddc5186da
[2/2] spi: rzv2m-csi: Add target mode support
      commit: a4f7ef6db74197898c48236ad01f8e0eccc1e52b

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

