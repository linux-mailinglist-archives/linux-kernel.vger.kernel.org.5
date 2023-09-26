Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 212D87AED76
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 14:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234750AbjIZM7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 08:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234749AbjIZM7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 08:59:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C161120
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 05:59:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92312C433C7;
        Tue, 26 Sep 2023 12:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695733154;
        bh=8OPH6fdZmxW9hzhSZ6GTdizBjGtF8h0BxZvvcOHPmH0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=LFTvn0+GPAs5FoSR92isRJYAcjceYWTmaywhqFLwDqGSKMiBGiJbU/SPtQYQ2GhH0
         Cds5mzhyzmLqnC54zrcP7IZE8Lqqr//p0MYLd3db/LdQNE7w+Z25ZoIMYfEsUV4nb0
         rAzU6A7xDPRRebkHeGLCcEf3tvKMYBmdaICjTwZh8cAl1dBj4wxnQCJmrVeVk0AW17
         YpzC3fv1AfoOmqxNj5bpkBqfcIN7xQ8tyJCI8LwYoVYdrtqrOWrQBbD6LqQ9SHIkiA
         dL6nqiu9fxsEdSt7cbT/qz3708CnSgV20BUN5vLkxTTAjLtcd2ermsv8pDfeC8aBdm
         scUTbMnECpTXQ==
From:   Mark Brown <broonie@kernel.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Iskren Chernev <me@iskren.info>,
        Christoph Fritz <chf.fritz@googlemail.com>,
        Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20230925212658.1975419-1-robh@kernel.org>
References: <20230925212658.1975419-1-robh@kernel.org>
Subject: Re: [PATCH] regulator: dt-bindings: Add missing
 unevaluatedProperties on child node schemas
Message-Id: <169573315231.2623509.9216058282613646020.b4-ty@kernel.org>
Date:   Tue, 26 Sep 2023 14:59:12 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Sep 2023 16:26:53 -0500, Rob Herring wrote:
> Just as unevaluatedProperties or additionalProperties are required at
> the top level of schemas, they should (and will) also be required for
> child node schemas. That ensures only documented properties are
> present for any node.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: dt-bindings: Add missing unevaluatedProperties on child node schemas
      commit: 66af368359816d62cf91ed1b02fe99f9a4015f3a

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

