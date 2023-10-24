Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A656E7D5372
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 15:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343682AbjJXN5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 09:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234823AbjJXN46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 09:56:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0897D2109
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 06:55:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B29C9C433C7;
        Tue, 24 Oct 2023 13:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698155723;
        bh=8jvIMLGisAcUgtRBNwIN/hemzPipfyGWCOmlGRRca60=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=XbFIkH1MxZ31QF+UmkqPQgoR+l+Jr5YkvCH9oicW3/7GU/wIzoW0Khxi7Iz6H7SAk
         q6cdH2boSDYKN8Sjj4xhwuiC34jQSi7DcoT4Xh7XDjNLZuXVlVtQjeAvf8ToiLd5T5
         Sn0N5sZNJl++46kVuPmjo3WM/2Yx+5ZAusCkuMw8anZiBAVMc7+dpwxtPN5YXO2S0X
         5hH8QN2X0b+ekvP6AiaYZsjmqjTjljZw4hRMC0x55jCEqzl7b63kSljt8jlHv08Ff/
         h5lCWsafPdfF0s0NR+PKiYNvAIRvce88+nhrOouowBqORxx+/m7KqszvDuXmUF27OK
         qzzAJukUyBuJw==
From:   Mark Brown <broonie@kernel.org>
To:     Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc:     alsa-devel@alsa-project.org, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        Marian Postevca <posteuca@mutex.one>,
        open list <linux-kernel@vger.kernel.org>
In-Reply-To: <20231020062822.3913760-1-Vijendar.Mukunda@amd.com>
References: <20231020062822.3913760-1-Vijendar.Mukunda@amd.com>
Subject: Re: [PATCH 1/5] ASoC: amd: Add acpi machine id for acp6.3 version
 based platform
Message-Id: <169815572028.69390.10419908653780701208.b4-ty@kernel.org>
Date:   Tue, 24 Oct 2023 14:55:20 +0100
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

On Fri, 20 Oct 2023 11:58:11 +0530, Vijendar Mukunda wrote:
> Add acpi machine id for ACP6.3 version based platform and configure
> driver data to enable SOF sound card support on newer boards.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/5] ASoC: amd: Add acpi machine id for acp6.3 version based platform
      commit: bb98b592cfd387eccc9430d4cd5ebc1678775a88
[2/5] ASoC: SOF: amd: add support for acp6.3 based platform
      commit: 848c0d34f70c4c9f6f166ec891d309936a26aa14
[3/5] ASoC: SOF: amd: increase DSP cache window range
      commit: 4dbee5104b7858e39d94b2512ab99b82b8feb894
[4/5] ASoC: SOF: amd: refactor acp dram usage for data bin loading
      commit: 135e0d49cde383395afcaf285d6304be9230a06f
[5/5] ASoC: SOF: amd: add option to use sram for data bin loading
      commit: 145d7e5ae8f4e553478232fe3095379b60fa5496

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

