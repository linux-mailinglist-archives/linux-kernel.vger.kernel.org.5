Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E277477D185
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 20:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238222AbjHOSJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 14:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238150AbjHOSJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 14:09:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ABF2106
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 11:09:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 33A146548E
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 18:09:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F0BDC433C8;
        Tue, 15 Aug 2023 18:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692122953;
        bh=Dwt2P3n6A9/tnC8wtKE1Ytw/tSXcGuR/aA4YHtP5ODA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=MIoKTvSAb7bTlfsdn27WdD/DTNXriEamdH2ALNvemFqyCjWZSPiNUnxx8Ayg5MmNi
         i19Y9b5JvDAxoG0xdsESY1AwN2+y3LrVHQw9Dhv3n9+r0tWlU9oUiC4is7RH4ODjMm
         Rcb1XALpvM3YxX4l3sUECGMhxOkI5rPC3raDoMSB2E280jDOsK1yYoN39hAa6FSfWg
         PGRllGia1ST/r2RrLkYBVT2esq2b6Ky3gjhVNR7mZ1Bwadsg9ktAR3YJbd9I9pKQOI
         fqML16piMQ2WikNCSkrSSZFQpbbf6k1WHVIMkFIM8XUuPwzC97AXPJjRlkt2nfSHpx
         W0B0R4XsIgQ/w==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org,
        Ajye Huang <ajye_huang@compal.corp-partner.google.com>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Akihiko Odaki <akihiko.odaki@gmail.com>,
        Yong Zhi <yong.zhi@intel.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        "balamurugan . c" <balamurugan.c@intel.com>,
        Libin Yang <libin.yang@intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        David Lin <CTLIN0@nuvoton.com>, Brent Lu <brent.lu@intel.com>,
        Takashi Iwai <tiwai@suse.com>,
        Terry Cheong <htcheong@chromium.org>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Gongjun Song <gongjun.song@intel.com>,
        Arnd Bergmann <arnd@arndb.de>, apoorv <apoorv@intel.com>,
        alsa-devel@alsa-project.org
In-Reply-To: <20230804085648.3721416-1-ajye_huang@compal.corp-partner.google.com>
References: <20230804085648.3721416-1-ajye_huang@compal.corp-partner.google.com>
Subject: Re: [PATCH v1] ASoC: Intel: Add rpl_nau8318_8825 driver
Message-Id: <169212294815.59295.2130257990585943471.b4-ty@kernel.org>
Date:   Tue, 15 Aug 2023 19:09:08 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 04 Aug 2023 16:56:48 +0800, Ajye Huang wrote:
> Boards were using this in older kernels before adl and rpl ids were
> split. Add this back to maintain support.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: Add rpl_nau8318_8825 driver
      commit: 273bc8bf2227108ed2851bea71786a026e34ecbb

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

