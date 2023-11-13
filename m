Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB887EA3E7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 20:40:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbjKMTkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 14:40:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbjKMTkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 14:40:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE50D72
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 11:40:32 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1E1EC433CA;
        Mon, 13 Nov 2023 19:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699904432;
        bh=Pku/AXmSkmETBoNY2XfS16sT2QpxqRxPSU/j8yciQ/M=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=vGEzhC91V07BOuK8Jbxel2UenXl9kJFd7nA88SPftbENAyZeJcErL7BR6g38rRobQ
         tzPrf+hUjVwEcBqwtdQUMBdlVjo90V2wqukXwQFpzlTl9PVT1Z90AJ14ltvEHY5Ttg
         wNYx2U9rASpyT9LAX2/H9JKMI1kkuROoa7FbbCEvVhUwKUcPs8+N3XvAONshd+tjrV
         CejvZC7O6zxZFLNdCkzqBwEaodp30foC84rjldsbtmoaXl6DUQeJvirIuah6vsCEuf
         eENr4GGXtokqYKW9/kvaSSiD2LwWzQtDZDYhEb9DmNm9HwUdJ2nBjRaDazhbt7HHQQ
         Eb/pScxJSGhBQ==
From:   Mark Brown <broonie@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Robert Marko <robimarko@gmail.com>,
        Dang Huynh <danct12@riseup.net>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
In-Reply-To: <20231106-pm8937-v1-0-ec51d9eeec53@riseup.net>
References: <20231106-pm8937-v1-0-ec51d9eeec53@riseup.net>
Subject: Re: (subset) [PATCH 0/8] Add PM8937 PMIC support
Message-Id: <169990442820.3294075.3854725538330307845.b4-ty@kernel.org>
Date:   Mon, 13 Nov 2023 19:40:28 +0000
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

On Mon, 06 Nov 2023 19:08:28 +0700, Dang Huynh wrote:
> PM8937 is a power management IC. It is used in various boards with
> MSM8917, MSM8937, MSM8940 and APQ variants.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[3/8] regulator: qcom_spmi: Add PM8937 SPMI regulator
      commit: c0d6b2acf78e3195a6b100a236210f2e6e42b0c0
[4/8] dt-bindings: regulator: qcom,spmi-regulator: Document PM8937 PMIC
      commit: f2b003c8235e0afed60ed426e891e41dab131821
[5/8] regulator: qcom_smd: Add PM8937 regulators
      commit: 18cc1cd011131d878be2619b56eff7bc2a278bdf
[6/8] dt-bindings: regulator: qcom,smd-rpm-regulator: Document PM8937 IC
      commit: 40e13ae67c6fc2897b49398d6f804b5d1ec63fff

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

