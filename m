Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44DC6772E80
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 21:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbjHGTIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 15:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjHGTIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 15:08:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5A61701;
        Mon,  7 Aug 2023 12:08:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A800762166;
        Mon,  7 Aug 2023 19:08:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72776C433C8;
        Mon,  7 Aug 2023 19:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691435328;
        bh=9hJaF99KfuyO0MAbT/sVT9KSXAiWpGzLkHZqHLnTTH8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=L9iynZphM10jPqIO2cUXBMFJW+En1wuWXz5+RESQbepD588n08srg7U6xoKOeA407
         h/9Kveuyo2HHsU4GP8SmhH33D/zxQ3UWnjPdFUztEizsMX6+LtPaCVxrDUKIHa4soc
         p+WWhiBXHU3ITlQtUJon5c767iwZjSks2427je+uKJoYraCFIu2z6AXpLErtpzLgaV
         +4PGy6kKvIsPZo+Oiv7LG/JTub3Z9LG4SY3qO1oiuuY8kPzDUlJD6rX3UThR0CjEOk
         S4BlsdF/GGEtcvQsK9r8Thf/1tN+U2UhLL/wTmf1cc+NP48sNyyNuC9u3ggXIkRWCB
         qlLenWrh97b1w==
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
Message-Id: <169143532617.213897.12646437489915335366.b4-ty@kernel.org>
Date:   Mon, 07 Aug 2023 20:08:46 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
      commit: 7cdf55462c5533a1c78ae13ab8563558e30e4130

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

