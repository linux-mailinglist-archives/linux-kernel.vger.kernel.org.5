Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28E657A235A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 18:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234741AbjIOQOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 12:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236243AbjIOQNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 12:13:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928A21FE5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 09:13:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 254FEC433C9;
        Fri, 15 Sep 2023 16:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694794416;
        bh=C71tN8ZIhlVIDV9QKHTbB9EmSGHavmQk0JRFq/aLG+U=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=r0ophIMJxc2q+fkdkYDTRxogvZGxJE1bpdqk6N3OYryTsGALno9ruuy5mLyIMg6DD
         sVv1wk+j4YqRa+q+PCFvjyvPqjpa9EcDqH4B73wn6QwRFidGJRzZGvz04yUfizK1C+
         bZExmfz7YE9wCmtyyud/3FdduH1tRRd/m+reRwwCCNGpQllFv2nMP2Dv7QxcR7PA5l
         XrPfxm3UremLdzzcJkMxoZnvvUZoqhQCaqsLyqseJZCWppVAqCvQ9UoHdn/QU/hxgM
         nWbCm575/xJqYGmf0KQDeGj0S3lC4h6lrO2xxETubNyo1C1+5FU8ZyZ0aPBYruKOoE
         M9uHzxg0DHzhg==
From:   Mark Brown <broonie@kernel.org>
To:     cezary.rojewski@intel.com, pierre-louis.bossart@linux.intel.com,
        liam.r.girdwood@linux.intel.com, peter.ujfalusi@linux.intel.com,
        yung-chuan.liao@linux.intel.com, ranjani.sridharan@linux.intel.com,
        kai.vehmanen@linux.intel.com, perex@perex.cz, tiwai@suse.com,
        kuninori.morimoto.gx@renesas.com, brent.lu@intel.com,
        amadeuszx.slawinski@linux.intel.com, Chen Ni <nichen@iscas.ac.cn>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230915021344.3078-1-nichen@iscas.ac.cn>
References: <20230915021344.3078-1-nichen@iscas.ac.cn>
Subject: Re: [PATCH] ASoC: hdaudio.c: Add missing check for devm_kstrdup
Message-Id: <169479441287.352295.6511877103194317709.b4-ty@kernel.org>
Date:   Fri, 15 Sep 2023 17:13:32 +0100
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

On Fri, 15 Sep 2023 02:13:44 +0000, Chen Ni wrote:
> Because of the potential failure of the devm_kstrdup(), the
> dl[i].codecs->name could be NULL.
> Therefore, we need to check it and return -ENOMEM in order to transfer
> the error.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: hdaudio.c: Add missing check for devm_kstrdup
      commit: c04efbfd76d23157e64e6d6147518c187ab4233a

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

