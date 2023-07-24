Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8FF175FF0B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 20:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjGXS20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 14:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbjGXS2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 14:28:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB7110EC;
        Mon, 24 Jul 2023 11:28:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D7B1C6137C;
        Mon, 24 Jul 2023 18:28:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B60CC433C7;
        Mon, 24 Jul 2023 18:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690223300;
        bh=PKZT/f9kEO15ObxVb4uDCgsik4xstwNkFBHIeXf5KIc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=BT6HEQv0l3zOKhSzGl6ozeNZpY9eq+9cssh/yG+7MhrsUAfnEcOepzg8PSV9x+XK+
         rv+PhA2ntqsBM9XR/2tFoN5vPdnrFWe3nJhf2a12uEOoi4YvTLr2Ctc6uVanXz+qlC
         WnyhQ9T2lhFAPvk3n53fIrZWsE0I4qbN/cjhrSlbFytzZW1CpNPoUyvUqIFKb1AlzU
         hJZ0XisT5k/s+N7rN611k6zWcRkh+FAbHErVClyWuAfu9kdJ8F6Rptupn82+jennli
         C87wGRDRPE84tIrFvi1/Xme3QVfDgzwwL5fP5p50l7DcPJisvbHym9yueiPTISfa1e
         ObHyGxL7KwLRQ==
From:   Mark Brown <broonie@kernel.org>
To:     devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        William Qiu <william.qiu@starfivetech.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Linus Walleij <linus.walleij@linaro.org>
In-Reply-To: <20230713090015.127541-1-william.qiu@starfivetech.com>
References: <20230713090015.127541-1-william.qiu@starfivetech.com>
Subject: Re: (subset) [PATCH v2 0/3] Add SPI module for StarFive JH7110 SoC
Message-Id: <169022329775.1044366.2232599476103441607.b4-ty@kernel.org>
Date:   Mon, 24 Jul 2023 19:28:17 +0100
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

On Thu, 13 Jul 2023 17:00:12 +0800, William Qiu wrote:
> This patchset adds initial rudimentary support for the StarFive
> SPI controller. And this driver will be used in StarFive's
> VisionFive 2 board. The first patch constrain minItems of clocks
> for JH7110 SPI and Patch 2 adds support for StarFive JH7110 SPI.
> 
> Changes v1->v2:
> - Rebaed to v6.5rc1.
> - Submitted reference file separately.
> - Dropped 'status' node as it was 'okay' by default.
> - Dropped Co-developed-by message.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] dt-bindings: spi: add reference file to YAML
      commit: 8858babff615ee366bf570c1facfbd0845dd924e
[2/3] dt-bindings: spi: constrain minItems of clocks and clock-names
      (no commit info)

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

