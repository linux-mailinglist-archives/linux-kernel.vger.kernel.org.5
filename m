Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD7F76F1D2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 20:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbjHCS06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 14:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjHCS04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 14:26:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF82110;
        Thu,  3 Aug 2023 11:26:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 93DC261E4A;
        Thu,  3 Aug 2023 18:26:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C1F9C433CA;
        Thu,  3 Aug 2023 18:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691087214;
        bh=Q3uryC5AfEfviZ5zXlW6Ny1GlYaDkFVU5+HJuXFBsRY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=LJ0OSp4tGOCg8LUGcQrPRo11ZDSzEq6U296i9IENIojREOTscTz0YDOCmvNYC1ADN
         FIsBcNErRn7ywzlqD0DA28t/BvCMIM8iaUOfCVIC50J2rG3OiPKfmudCdC4sq+e0L4
         7xHcYpL4A/pMap+dosFnR4wJGvQtLCEtcgUTSwWVVzs7wvn+JayCsBBTj79Dt9FdWf
         1DQN2hkHhTqWbloXlC3s1BA1W+ZlrQ4N1DF4rPzjJsBGw3AmwNPLx0bZSiyB+Zy9Ju
         Q8RG0A14zAnWwla/D+4zwJeph7qh5VzAVJ4czkS+kvOMzYotBzj8zPt1RklFvHUkAP
         Rd0yIdhouCpPw==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com,
        Michal Simek <michal.simek@amd.com>,
        Michal Simek <michal.simek@amd.com>
Cc:     Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-spi@vger.kernel.org
In-Reply-To: <987430ee905fd299fe962663d94f848b341c87df.1691047461.git.michal.simek@amd.com>
References: <987430ee905fd299fe962663d94f848b341c87df.1691047461.git.michal.simek@amd.com>
Subject: Re: [PATCH 1/2] dt-bindings: spi: spi-cadence: Describe
 power-domains property
Message-Id: <169108721189.116022.1831144665244060073.b4-ty@kernel.org>
Date:   Thu, 03 Aug 2023 19:26:51 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 03 Aug 2023 09:24:24 +0200, Michal Simek wrote:
> ZynqMP Cadence SPI IP core has own power domain that's why describe it as
> optional property.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] dt-bindings: spi: spi-cadence: Describe power-domains property
      commit: 88362275240303455bbec05c249daa84aff07059
[2/2] dt-bindings: spi: spi-cadence: Add label property
      commit: ffae65fb1ae4738151158b4435fad822cb1ca29c

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

