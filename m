Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0010D7EA3ED
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 20:41:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbjKMTlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 14:41:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232172AbjKMTkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 14:40:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDAE01988;
        Mon, 13 Nov 2023 11:40:50 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E15FC433C8;
        Mon, 13 Nov 2023 19:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699904450;
        bh=Sww/WWaJ51nm84r2fYUy70d6PRu+fd6AVzmVnWzJ8Js=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Kxr8pe7ZY2+J5nJ3lS//8qGM7EfFPIW/4giAq2x9J2xGT/AX4MkvGW4gLQXy1McRX
         3MLKYj2V/ljB5JAgItq/LeuArUb81ZxdqmnevzKXzxmcoYVzo9MAN17Swm5OQjG84y
         MfZYR2aJz0fr2LL5CMB/fTF9efF7mqgOE2YQzaTLmY5pY+Tz3EAA7xD1y6XNCTmMsR
         YrfyynmdlLaQNUtWhoja90G0TGrvyQGhrCwwDlIhckTlRkOdygohQFzvH/tLEZYg6G
         pVQ/jETK0OmYzkSVEZpNLZL2qjvURE7pIopB3zeZugdOMAAI0kT29kuVhAd/lXEAfy
         4q6CyN/Y+i/RA==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ben Wolsieffer <ben.wolsieffer@hefring.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        Erwan Leray <erwan.leray@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <20231102193722.3042245-1-ben.wolsieffer@hefring.com>
References: <20231102193722.3042245-1-ben.wolsieffer@hefring.com>
Subject: Re: (subset) [PATCH v2 0/5] Add STM32F7 SPI support
Message-Id: <169990444654.3294163.14589555385933393439.b4-ty@kernel.org>
Date:   Mon, 13 Nov 2023 19:40:46 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 02 Nov 2023 15:37:17 -0400, Ben Wolsieffer wrote:
> This series adds support for SPI on STM32F7 processors. The STM32F7 SPI
> peripheral is nearly identical to the STM32F4, with the only significant
> differences being that it supports a wider range of word sizes, and the
> addition of 32-bit transmit and receive FIFOs.
> 
> v2:
>   - Add missing commit body
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/5] spi: stm32: rename stm32f4_* to stm32fx_*
      commit: adde8a55daf640515edd78b7ac5f3293c3960b8e
[2/5] spi: stm32: use callbacks for read_rx and write_tx
      commit: 247ba5ea058290824862902f7ee64c20a744c461
[3/5] dt-bindings: spi: add stm32f7-spi compatible
      commit: 09388379b6d7143ed12fc06900ec9db3bb82ca8f
[4/5] spi: stm32: add STM32F7 support
      commit: a84dcb410b5f928899a53ba79ec71108700872d6

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

