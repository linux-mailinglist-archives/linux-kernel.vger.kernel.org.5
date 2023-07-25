Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 587DD762726
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 01:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbjGYXB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 19:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbjGYXBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 19:01:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 010CF1737;
        Tue, 25 Jul 2023 16:01:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6CCEF6192D;
        Tue, 25 Jul 2023 23:01:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 531F2C433C8;
        Tue, 25 Jul 2023 23:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690326082;
        bh=wOUzfezAhBuQ9O9A0eCypYAtr74aYdAOMGNyaZrRDYE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=OvU51YhW7xFdnFxGM5Ga4LE7OXb+RvJaDcRcBFI2zZdNRobaQ2bxtt+xj4hi8KqGx
         L0uI5pKLOwtvDM81+HNkMVCntlFG0Wu4/8FwBJE26glO8x2smTOh7fWDhRh31kE2gC
         t3WklBJPr2YQlKHfp73dGh5eRrlZcBqxe59cTTbOzWYhWdJ7adDuP7NWBnfbYcQhCJ
         RpEJvKXnKZUiIIxmsULAnvBsVMCCwd00qBvP5tYUIK2v3a1KnSC20+4NdoILGROuc8
         nlQPHCACYh9R6AIbnOFJ/WZ41zjyHXDYtujjmlM6iPxMN1XAyi+zLofUneCZqTbQrJ
         QWYTqo9IQX/Mw==
From:   Mark Brown <broonie@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     stable@vger.kernel.org
In-Reply-To: <20230725164047.368892-1-krzysztof.kozlowski@linaro.org>
References: <20230725164047.368892-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] regulator: dt-bindings: qcom,rpm: fix pattern for
 children
Message-Id: <169032608005.1636970.13530519930947403367.b4-ty@kernel.org>
Date:   Wed, 26 Jul 2023 00:01:20 +0100
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

On Tue, 25 Jul 2023 18:40:47 +0200, Krzysztof Kozlowski wrote:
> The "or" (|) in regular expression must be within parentheses,
> otherwise it is not really an "or" and it matches supplies:
> 
>   qcom-apq8060-dragonboard.dtb: regulators-1: vdd_ncp-supply: [[34]] is not of type 'object'
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: dt-bindings: qcom,rpm: fix pattern for children
      commit: 75d9bf03e2fa38242b35e941ce7c7cdabe479961

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

