Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCCA97AFF2D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 10:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjI0I6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 04:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjI0I6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 04:58:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75080BF;
        Wed, 27 Sep 2023 01:58:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9A2EC433CD;
        Wed, 27 Sep 2023 08:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695805090;
        bh=5NESgz9NKBwccsQ0Ujo74kHMO5OzmxrWwiJfaekpyDs=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=oKyjTmXEnqst1LSzcib9B0n6Kb/BIaQHmWuymqnxqjaxCgqEjre4/pB1ZwEdS4yzx
         LgfxNEPc/rbI5k4Mx0/MYoszoX1yq0SDFflpdCEDoSUKAzTJTzmofAtYHAgsDTku7g
         nbntNbvvnEUq+4kpmjld6tuQw0Fpx6ZM2GoXOqo+cV5mK+gCAyf47YxW2An6dS4GJw
         Dy8/bwwqR+9o0Jbt7HuLDXOqE226g4K2+DoEgQU8wRFykpLWEMNoeReJk1lEeJB4OU
         UEY91HUAQP2HxVDrQRRMGEem1YIJNTxbgdaZNbzwDDWq8jQSiaVS0sewBn/T3yHHon
         DtaJjak5rKvxA==
From:   Mark Brown <broonie@kernel.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Robert Marko <robimarko@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>
In-Reply-To: <20230912-spmi-pm8909-v1-0-ba4b3bfaf87d@gerhold.net>
References: <20230912-spmi-pm8909-v1-0-ba4b3bfaf87d@gerhold.net>
Subject: Re: [PATCH 0/6] regulator: qcom_spmi: Add PM8909, PM8019 and
 PMA8084
Message-Id: <169580508696.2677308.6259946007338687878.b4-ty@kernel.org>
Date:   Wed, 27 Sep 2023 10:58:06 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Sep 2023 09:49:48 +0200, Stephan Gerhold wrote:
> Add the necessary definitions for the PM8909, PM8019 and PMA8084 PMIC to
> the qcom_spmi-regulator driver to allow reading the actual voltages
> applied to the hardware at runtime. This is mainly intended for
> debugging since the regulators are usually controlled through the
> RPM firmware (via qcom_smd-regulator).
> 
> These PMICs are used on totally different platforms (MSM8909, MDM9607,
> MSM8974/APQ8084). Each PMIC addition is independent and useful on it
> own. I only bundled them to simplify review.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/6] dt-bindings: regulator: qcom,spmi: Document PM8909
      commit: 6f20872035378ab2311cc901f8f94f8718f1b17f
[2/6] regulator: qcom_spmi: Add PM8909 regulators
      commit: 813d01a40ae7c0c67681c82edce8463fbbd84b08
[3/6] dt-bindings: regulator: qcom,spmi: Document PM8019
      commit: 350aab7f8f2c7d7368d2bbc47717696a51014078
[4/6] regulator: qcom_spmi: Add PM8019 regulators
      commit: 5b30cb2a317a8e2636f724e8ebf5cbe3849e786e
[5/6] dt-bindings: regulator: qcom,spmi: Document PMA8084
      commit: f72d04235781cf89410ffd750109f4b9931c50ea
[6/6] regulator: qcom_spmi: Add PMA8084 regulators
      commit: 317aa3c4fe708fcbee5b9fe5fc25e1b9e92b83f5

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

