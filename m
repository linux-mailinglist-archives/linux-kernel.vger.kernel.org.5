Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 934337D536F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 15:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343652AbjJXN5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 09:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234796AbjJXN46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 09:56:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6DF1BFF;
        Tue, 24 Oct 2023 06:55:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7372C433CA;
        Tue, 24 Oct 2023 13:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698155720;
        bh=0930Zc5PLhlW9IrMow+5YSnJulYTnXkVZpf2XT9rHOM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=aITkYplfcCnRGR/37STiRK0dmzVAM1C8P/IWpqqiCKonXeRQetrProLGxHxpt2ZXV
         Ixk4p1ujlVbHhe9oMyd/SReKDd7Zt+P916hOFIQl+gbQquM4PXd43p4xisiKRdzTiy
         5WzCVcG9Kt+HOPS6W0iCHTQnQyVrlmAhvGn/mUfA51Z4fYQx6dt9V33z1Hq3RmL0vd
         Br6LnVqOad3LV0JD60eL5VeULq9+cHF6yl/WTaH2Way6PDqczuS1t57nkytMT4vD9f
         HQv80iqs2nDvzhh25kPTVm6xaxktlqxTIatflBcvzDd5eg1t5r+k5QQjAqWC3wwN8p
         JDxE4tcwV24oA==
From:   Mark Brown <broonie@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Mark Hasemeyer <markhas@chromium.org>
Cc:     Curtis Malainey <cujomalainey@chromium.org>,
        stable@vger.kernel.org,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        sound-open-firmware@alsa-project.org
In-Reply-To: <20231020145953.v1.1.Iaf5702dc3f8af0fd2f81a22ba2da1a5e15b3604c@changeid>
References: <20231020145953.v1.1.Iaf5702dc3f8af0fd2f81a22ba2da1a5e15b3604c@changeid>
Subject: Re: [PATCH v1] ALSA: SOF: sof-pci-dev: Fix community key quirk
 detection
Message-Id: <169815571552.69390.1942183928809208155.b4-ty@kernel.org>
Date:   Tue, 24 Oct 2023 14:55:15 +0100
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

On Fri, 20 Oct 2023 14:59:53 -0600, Mark Hasemeyer wrote:
> Some Chromebooks do not populate the product family DMI value resulting
> in firmware load failures.
> 
> Add another quirk detection entry that looks for "Google" in the BIOS
> version. Theoretically, PRODUCT_FAMILY could be replaced with
> BIOS_VERSION, but it is left as a quirk to be conservative.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ALSA: SOF: sof-pci-dev: Fix community key quirk detection
      commit: 7dd692217b861a8292ff8ac2c9d4458538fd6b96

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

