Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7712C8135BC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 17:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443704AbjLNQJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 11:09:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbjLNQJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 11:09:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE46121
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 08:09:21 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85324C433C9;
        Thu, 14 Dec 2023 16:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702570160;
        bh=BtuX+LpIHpPDBUaCyCsL0E10EY6M/BLs3C/xlRTLU0k=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=qInvvByS98yo7+5vVUjNAWfHGwpi9LfLFaIJ7qe5JFHRkzsc4kDKIj+NBMmjc3n9y
         xiVay+M9u52dj6grCGdtbCtSTENlECHmW9hPyF1GUpMWH/+gUP3HwZcdrl4OeB9JrH
         IckheFu8KVQoVXK2MMJxzs3n1R0R5jmVeI19Zi7qlOcZtEW87kyRfcwS7GHp5y9NqD
         lMVZFxEWsoAU1A7SN7gm8TNFHPSctfI+NEkugpvYqneGXQ0dfPUJPF7lKuDR+LU154
         q4TPCtPHk81eQ7rPrGZO0n/jfenHspUt8IbHIQrrFtfVQQTYkelHTlkv990dffl6CF
         uidRNr7/WSv7A==
From:   Mark Brown <broonie@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, kernel@quicinc.com,
        Fenglin Wu <quic_fenglinw@quicinc.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, quic_collinsd@quicinc.com,
        quic_subbaram@quicinc.com, quic_jprakash@quicinc.com
In-Reply-To: <20231214-pm8010-regulator-v2-0-82131df6b97b@quicinc.com>
References: <20231214-pm8010-regulator-v2-0-82131df6b97b@quicinc.com>
Subject: Re: (subset) [PATCH v2 0/5] Add pm8010 RPMH regulators for sm8550
 boards
Message-Id: <170257015715.68407.2531628045925276337.b4-ty@kernel.org>
Date:   Thu, 14 Dec 2023 16:09:17 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Dec 2023 10:59:10 +0800, Fenglin Wu wrote:
> There are 2 PM8010 PMICs present in sm8550-mtp/sm8550-qrd boards and
> each of them exposes 7 LDOs. Add RPMH regulator support for them.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/5] regulator: qcom-rpmh: extend to support multiple linear voltage ranges
      commit: 27591ea2f7751223e79fa41f11bf687777a38399
[2/5] regulator: dt-bindings: qcom,rpmh: add compatible for pm8010
      commit: 638baabe951eb16607b7e4bb197998562afd57a6
[3/5] regulator: qcom-rpmh: add support for pm8010 regulators
      commit: 2544631faa7f3244c9bcb9b511ca4f1a4f5a3ba0

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

