Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F1A7B5672
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 17:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238030AbjJBPRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 11:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238018AbjJBPRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 11:17:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9929790
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 08:17:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6901C433C8;
        Mon,  2 Oct 2023 15:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696259850;
        bh=hF16LqSa4Syn4jn5dAWKbpzCRm2q1LVCGwoK56BnfY4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=chvy6+gEVKMrMyTwo76gNnMqZNgcqeIh0iCT+slnWvKswqcF2RysWxQb0BQlS06dr
         QVmasCtcr3hB+/LZ5OIXgt4k2tU3+/RsOUpEJsCKMXvU3t/BWJcdd9XBI4/1ZKeFmQ
         1/FHkTlRsVFpuNYehLzlvpqT6f+5IrQjVDMFzKlakeDBZXnHWuia392P4RaI9QdS/O
         3NIVUUDkY7aInCuLN1xAdp/qsGyapkLzIG6sZ7w3shP7pQn4MWFP0nnEKw21aptPfm
         armmcBXB8HwZqMBOsYJAkZ2NsV2piwnHngfTEJtWrGjYcBMgHTxBpWyz3obqfyM12g
         pHc6Srxhp+Kow==
From:   Mark Brown <broonie@kernel.org>
To:     oder_chiou@realtek.com, Zhang Shurong <zhang_shurong@foxmail.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <tencent_4F37C9B5315B7960041E8E0ADDA869128F08@qq.com>
References: <tencent_4F37C9B5315B7960041E8E0ADDA869128F08@qq.com>
Subject: Re: [PATCH] ASoC: rt5682: Fix regulator enable/disable sequence
Message-Id: <169625984853.65718.1048649527672207151.b4-ty@kernel.org>
Date:   Mon, 02 Oct 2023 16:17:28 +0100
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

On Sat, 30 Sep 2023 17:55:50 +0800, Zhang Shurong wrote:
> This will attempt to disable the regulators if the initial enable fails
> which is a bug.
> 
> Fix this bug by modifying the code to the correct sequence.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rt5682: Fix regulator enable/disable sequence
      commit: 892fbdb203945d887ad2a109a3700b091a8e3b97

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

