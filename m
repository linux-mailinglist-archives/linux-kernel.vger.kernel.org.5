Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59B0F80DA86
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 20:04:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344405AbjLKTET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 14:04:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344760AbjLKTDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 14:03:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E251A5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 11:03:49 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90A17C433D9;
        Mon, 11 Dec 2023 19:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702321428;
        bh=yWThp71BPUxv4/KM7FUZO9Ix5YZfhhJSOKJIqpWflWg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=I80xyihPgIMqLZmWx2BnpqcTeeXB+Cy4P6BrjX0yfeAXpVK0Hh6je/ke4PGAJP3n5
         oZdu58WMnhSZ05nbgw/I5vFe5QhjxcRUwVkJokZaw5a9optQmkv/b+fgaUimIGfWPe
         OvycWmswcZI2+xdAk3w3n4VH4oTTU6OlUkJ6hrqvQsc5rLX18Eew5f1fxdwbSstAEk
         q9tMNbIOJK5gxVFmYjt/GuRGp0XyTLBFGk26hxCIIQznl7YQH7w0t8NDWGxdB13pOc
         pQEImgMubtAtBpqBTJFXyRsqB6sYQn60ZMfSLkFS9C5a0q705tFmxj16GTLY//U29u
         I7k0/aDrWFjyw==
From:   Mark Brown <broonie@kernel.org>
To:     pierre-louis.bossart@linux.intel.com,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     peter.ujfalusi@linux.intel.com, yung-chuan.liao@linux.intel.com,
        kai.vehmanen@linux.intel.com, cezary.rojewski@intel.com,
        ranjani.sridharan@linux.intel.com, alsa-devel@alsa-project.org,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
In-Reply-To: <20231205115715.2460386-1-rf@opensource.cirrus.com>
References: <20231205115715.2460386-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: Intel: soc-acpi-intel-mtl-match: Change CS35L56
 prefixes to AMPn
Message-Id: <170232142629.117554.17625573039640052470.b4-ty@kernel.org>
Date:   Mon, 11 Dec 2023 19:03:46 +0000
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

On Tue, 05 Dec 2023 11:57:15 +0000, Richard Fitzgerald wrote:
> Change the ALSA prefix for the CS35L56 to "AMPn".
> 
> This keeps them consistent with the CS35L56 HDA driver. It also
> avoids coding the chip ID into the control name, so that other
> Cirrus amps with the same controls can have the same control
> names.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: soc-acpi-intel-mtl-match: Change CS35L56 prefixes to AMPn
      commit: 02a914ed475dd928c7b2b6c9d1da9b0b27fa724d

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

