Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2E807D81CB
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 13:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344799AbjJZLaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 07:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjJZLaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 07:30:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B5D1A6;
        Thu, 26 Oct 2023 04:30:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79B78C433C7;
        Thu, 26 Oct 2023 11:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698319821;
        bh=mrj+jRQ7eALdQSSe/rfsL2a+nPWSmU9ma8e+2zA+glc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=GFQHWuzZQm1aUqab2ZxHnPOygyBTqIwPkpMInuQ8mibnthAKO1PalqzR1edz00S9a
         z2Wi2zFaUSpc6g+3He6qDNheWP5pR+6mpTkroS6AJfJoaG/av2m6n5fQlE5+VA1jBp
         xEZdkuNrNu8QSKUXJzvkzr5ej5jPUnxjGpFgJHxjTXr+S2p9skNwXgzmzrwe9BIDSV
         jZAmorOgzJWBlPT6ltd05yMMBMv4jhQLADjs8DIjjIt3v5IApTU0lqABufRFOOmris
         LJxkx9bpHphFIA2kGaz1PZDamPwjchZsppINSG9RAwtPHANeslotTS83uvzrmLcpbH
         efPj57uLLZ4Qg==
From:   Mark Brown <broonie@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Abel Vesa <abel.vesa@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20231024134626.2364426-1-abel.vesa@linaro.org>
References: <20231024134626.2364426-1-abel.vesa@linaro.org>
Subject: Re: [PATCH] regulator: qcom-rpmh: Fix smps4 regulator for pm8550ve
Message-Id: <169831981905.21747.5399232474484029599.b4-ty@kernel.org>
Date:   Thu, 26 Oct 2023 12:30:19 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Oct 2023 16:46:26 +0300, Abel Vesa wrote:
> The type of the smps4 regulator from pm8550ve is actually FTSMPS525
> medium voltage. So fix it accordingly.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: qcom-rpmh: Fix smps4 regulator for pm8550ve
      commit: bc00d9f3813a40bc2d854ae0edab14c6b43a3219

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

