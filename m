Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 292B1785D38
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 18:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237565AbjHWQ04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 12:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237554AbjHWQ0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 12:26:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C933B10CB;
        Wed, 23 Aug 2023 09:26:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5903565B5F;
        Wed, 23 Aug 2023 16:26:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9647C433C9;
        Wed, 23 Aug 2023 16:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692807995;
        bh=Al2E1druB0P3ejb2/nbyyV1nrydyUGxUz/KKinqoeXw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Wnav+mQ7zbUlOMYQy6oS6fixkqGNt2FlLDc2v8vrglE5YyJQ1a7GiUs7OjmqDvMvw
         DDsNUIHB59d38kmDd/eNN0329fmotS9z4R3p15rnukg5qco5x2ptral36+D1mtKR5e
         rxM4XGvYEzzvMHp3qaJCU8PM5UUZkshIWQ5WhrqQyVr6IaL2B1126H+3f7Gfh5CPzi
         k6r2szuFPGlrQwoioGiJW2SvIzdZsrezVjzWZnypry1U2Blw4N53XGEQ/KE3lARmqu
         /SHFtjpVIi83YKv68phgAGTj2+0sB8xr2c9tI+1qswmnitl6lkFEyHszkozr17ElRu
         fcf4MqhhApPfw==
From:   Mark Brown <broonie@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>
Cc:     Rajendra Nayak <quic_rjendra@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-msm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20230801095702.2891127-1-abel.vesa@linaro.org>
References: <20230801095702.2891127-1-abel.vesa@linaro.org>
Subject: Re: [PATCH] regulator: qcom-rpmh: Fix LDO 12 regulator for PM8550
Message-Id: <169280799363.53966.9265296180737310826.b4-ty@kernel.org>
Date:   Wed, 23 Aug 2023 17:26:33 +0100
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

On Tue, 01 Aug 2023 12:57:02 +0300, Abel Vesa wrote:
> The LDO 12 is NLDO 515 low voltage type, so fix accordingly.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: qcom-rpmh: Fix LDO 12 regulator for PM8550
      commit: fb0db7f2d010e41fceffe801b2fb254e83785165

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

