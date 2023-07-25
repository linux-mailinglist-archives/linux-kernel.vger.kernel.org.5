Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE59762724
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 01:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjGYXBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 19:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjGYXBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 19:01:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F110173F;
        Tue, 25 Jul 2023 16:01:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1232261926;
        Tue, 25 Jul 2023 23:01:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CF3CC433C8;
        Tue, 25 Jul 2023 23:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690326078;
        bh=iV3xUiwOHTrhFt9wUr0FeVlZv27jP66uxTykWyFKkfk=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=oNfHNHw0bDNS0a2njsIrxfLKQ9zux5Jv56T8cIiZtkJ5Qb6KlLqhmPELMf/QqxbNR
         Kz2d4kZRb3hzZFGtz7PXq46jUHCJYsrzNJkw2n+WgWtAaQbFp25Eyk3hBmWWHAWbpM
         B0DLqkW/Ll0J7bs1pqBeHqyfXfrcD+vL9001QmiFbv9UmV1/5HvbonctvaeOR1FKE3
         w/i7Bs+G081vhpubG09HqfcL4F/ls1p1GEcxuVk9znz2uB9sjISm9aqY3dR127SVWq
         d/QzhVCtu0JAG82QevopBuSIzenBItGEosW0e6Vlf4V3xDrTtTcTv8DUq7/mIpQr2m
         tNDdrQG8NNEsA==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Adam Ward <Adam.Ward.opensource@diasemi.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230725124629.150113-1-krzysztof.kozlowski@linaro.org>
References: <20230725124629.150113-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 1/3] regulator: dt-bindings: dlg,da9121: add buck2
 constraints
Message-Id: <169032607621.1636970.15088372653295681523.b4-ty@kernel.org>
Date:   Wed, 26 Jul 2023 00:01:16 +0100
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

On Tue, 25 Jul 2023 14:46:27 +0200, Krzysztof Kozlowski wrote:
> Instead of describing the constraints for some devices (buck2 not
> present), code it in allOf:if:then section to actually allow validation
> of this requirement.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/3] regulator: dt-bindings: dlg,da9121: add buck2 constraints
      commit: 9b7e0645ba65e4824436a2f1817843291e744443
[2/3] regulator: dt-bindings: dlg,da9121: allow different names
      commit: e5481cc40d00b9f4a3250b2fd4a805e3d000b229
[3/3] regulator: dt-bindings: active-semi,act8846: correct supplies
      commit: 7631a0c5b093fe1bc27b4770021c4aa0d06fb3c5

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

