Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DAD57BE6BF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 18:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377720AbjJIQnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 12:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377261AbjJIQnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 12:43:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690BAB6;
        Mon,  9 Oct 2023 09:43:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93EC1C433C8;
        Mon,  9 Oct 2023 16:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696869783;
        bh=ojEg4vS1s6w91/rGNqe1tcFiAbxuqBund5Hiq11kpNE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=b9rRd32QOk1B4PyUItat5mTW8GrPBYS2uiM+q+6GrQvpp7jBQrPEI+e5MvbCfIDkO
         EwCt1z/F0rJhs+leDYlBGcizDeP6dq8VFWfQiRmVQPzVfHdLUGaezY0FZTt/qzPlCk
         g1oLnLv61KrHNZetqCji35hJHhK4GIvkaMDRX9gMM/o3kCbZtr3Wot9RNb0t4yKMkL
         giPyxJRlJEf4dtxWdjz7hhzRj5rqi0mNd9TkFm+j+zA5u/4c5av2GlHbMjnQbw1zzf
         /igU7sI6tJ945+lI2OHfsVqCdD66OVD4+HRzUSrnJMHcMRfLmFPfcnQQMV+X362C9F
         tA+RizR9pd/qA==
From:   Mark Brown <broonie@kernel.org>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Cc:     quic_msavaliy@quicinc.com, dianders@chromium.org, mka@chromium.org,
        swboyd@chromium.org, quic_vtanuku@quicinc.com
In-Reply-To: <1696614170-18969-1-git-send-email-quic_vnivarth@quicinc.com>
References: <1696614170-18969-1-git-send-email-quic_vnivarth@quicinc.com>
Subject: Re: [PATCH] spi: spi-geni-qcom: Rename the label unmap_if_dma
Message-Id: <169686978029.107832.8830412614471622963.b4-ty@kernel.org>
Date:   Mon, 09 Oct 2023 17:43:00 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 06 Oct 2023 23:12:50 +0530, Vijaya Krishna Nivarthi wrote:
> The code at unmap_if_dma label doesn't contain unmapping dma anymore but
> has only fsm reset.
> 
> Rename it to reset_if_dma accordingly.
> 
> No functional change.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-geni-qcom: Rename the label unmap_if_dma
      commit: 8a6b446d8a13673bfcf44fbd09d737ae4ccf0bfd

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

