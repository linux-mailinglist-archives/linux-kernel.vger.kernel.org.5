Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 344E275CA73
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 16:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbjGUOpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 10:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbjGUOpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 10:45:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2BF30D1;
        Fri, 21 Jul 2023 07:45:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 57FDF61CE0;
        Fri, 21 Jul 2023 14:45:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9572CC433C9;
        Fri, 21 Jul 2023 14:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689950699;
        bh=wljKIvIhCAvwUWXLNlEVuBqrMB/ZTYdEiw5PLP21L/U=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=aoVRPxTv2cZdKFwy8pruBkqJdAxrkZS1Enz4YEjXKY2vGWRrdTaOkpVi7I6deANqJ
         IB6ihinirsNLh8KjTuk/0TQG90sEXwucqCYn6deFj1qwWaCc/vt4rrnDvBdT2zHbXw
         VBWvut6LgIlcAkwzlgMaUslgCTCUl2Iu5Zd9uCPOz8kwfpR1iSYtOFnjBM7wWISBuh
         WrYlMxLLKTAj+OCKEJ5cZOwm+o6CVYpzib9Sh5B67MHP0NcyqAi1uGNi3ZHvyR4z4u
         cEn1+Gd+TyLPTqJYBXJ//jayUPoOuk9gmiag4Am9wWzpuEd9Q3bjmX8E7g5kOAvf6C
         LJBglMnfLjYrQ==
From:   Mark Brown <broonie@kernel.org>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1689062414-3654-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1689062414-3654-1-git-send-email-quic_rohiagar@quicinc.com>
Subject: Re: [PATCH v3 0/3] Add regulators support for PMX75
Message-Id: <168995069730.110341.11733110436595300118.b4-ty@kernel.org>
Date:   Fri, 21 Jul 2023 15:44:57 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jul 2023 13:30:11 +0530, Rohit Agarwal wrote:
> Changes in v3:
>  - Created a separate patch for updating the entry in pmx65 bindings.
>  - Changed the subject of patches [1/3] and [2/3] according to the convention.
> 
> Changes in v2:
>  - Addressed Krzysztof to update the if:then: in bindings patch.
>  - Breaking the original series [1] into smaller series.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/3] regulator: dt-bindings: qcom,rpmh: Update PMX65 entry
      commit: 4fdef8553df58953f572f1cb46d357c735c683a9
[2/3] regulator: dt-bindings: qcom,rpmh: Add PMX75 compatible
      commit: 0ef3d931632e3fce51ed5510935238937d644c97
[3/3] regulator: qcom-rpmh: Add regulators support for PMX75
      commit: 0b294ed669ead34a348d17d06b6d4d58712b14e2

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

