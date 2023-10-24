Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8557D5371
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 15:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234818AbjJXN5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 09:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234814AbjJXN45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 09:56:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C0C110C3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 06:55:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAB6BC433D9;
        Tue, 24 Oct 2023 13:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698155712;
        bh=ZwRGvdK1vLRyYCBNB8H0GmRZoD2LA6Gw+YOD+d7uvu0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=NxD9Ggy+9A7RNU1Bjgd9K1z8hWPbQi879G28Ip41uwiWe84uVlCmqllbF9PsZlh0d
         G2rydM2Pm8bPxq1DGXAswrBQZaiBbtD2nUQOq/dVx5Pe+M5aMmb3ce+hLcuhcpm99n
         IBA6YnK4LsJEuNRmBOYuEghoNzNXPErkIBxjHaPUOHv1v7qVBy0MthbcJ1+gwhZ8TN
         h9yAceinSkCQwzwPw8MHnSgTlhdJXuXwl97QknJRHl8UEhqKYWOP4McA0UZK58HDoH
         g4kDqFM2pCzLdXK7VuOeMRZCRt9fIJak9Q0FPTgpZp7THk5I2meWR09NCmKYrks+Ee
         5AhaJ8ROchJgQ==
From:   Mark Brown <broonie@kernel.org>
To:     shengjiu.wang@gmail.com, Zhang Shurong <zhang_shurong@foxmail.com>
Cc:     Xiubo.Lee@gmail.com, festevam@gmail.com, nicoleotsuka@gmail.com,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <tencent_C0D62E6D89818179A02A04A0C248F0DDC40A@qq.com>
References: <tencent_C0D62E6D89818179A02A04A0C248F0DDC40A@qq.com>
Subject: Re: [PATCH v2] ASoC: fsl: Fix PM disable depth imbalance in
 fsl_easrc_probe
Message-Id: <169815570943.69390.931793622764684694.b4-ty@kernel.org>
Date:   Tue, 24 Oct 2023 14:55:09 +0100
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

On Thu, 12 Oct 2023 21:03:15 +0800, Zhang Shurong wrote:
> The pm_runtime_enable will increase power disable depth. Thus
> a pairing decrement is needed on the error handling path to
> keep it balanced according to context. We fix it by calling
> pm_runtime_disable when error returns.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl: Fix PM disable depth imbalance in fsl_easrc_probe
      commit: 9e630efb5a4af56fdb15aa10405f5cfd3f5f5b83

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

