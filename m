Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 783FB7EA10D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 17:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbjKMQO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 11:14:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbjKMQOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 11:14:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0C71702
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 08:14:52 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BDF1C433CB;
        Mon, 13 Nov 2023 16:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699892092;
        bh=WraYibxcFpwh29fu+H1LVMSLBqa+WIpRvlITsxKnioo=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=aLJ4RQ1VqJTdzm9uRXmkVtqFcn8XCIOAUogY+EXoEj2Nh6AdF30lLc7FkV5x8R7Zt
         ZMCBqrixP6NxMn9PX2V7HmZq0xl6h1hqPADayrmD1LpYQxNHVycSgw6SbT1DnDwO4+
         pxyfgZIScbbemY6hPIpNSST+rbncKv66dFmZmcslUFrJJaB6LWIxtf1uhPZGXn8GDs
         0D/ivwj0bmKmSwSlSDw+FB/B8JuUzGmCq0eMmhd6IpQWv+6y0rmzPhwtH4KwIsqshV
         V7WdMBb5cXVvGGCodq9LpAN1gXaguGeX1SvPyDJz2L69dPDx9wQkAMI6fdHBsiDEZX
         oqFWNs3k/EELg==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org,
        Daniel Baluta <daniel.baluta@oss.nxp.com>
Cc:     pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com,
        peter.ujfalusi@linux.intel.com, yung-chuan.liao@linux.intel.com,
        ranjani.sridharan@linux.intel.com, daniel.baluta@gmail.com,
        kai.vehmanen@linux.intel.com, linux-imx@nxp.com,
        iuliana.prodan@nxp.com, linux-kernel@vger.kernel.org
In-Reply-To: <20231109135900.88310-1-daniel.baluta@oss.nxp.com>
References: <20231109135900.88310-1-daniel.baluta@oss.nxp.com>
Subject: Re: [PATCH 0/2] ASoC: SOF: Add support for MICFIL PDM interface
Message-Id: <169989208903.3289099.3550583225886938735.b4-ty@kernel.org>
Date:   Mon, 13 Nov 2023 16:14:49 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 Nov 2023 15:58:58 +0200, Daniel Baluta wrote:
> This is used for configuring MICFIL PDM with i.MX8MPlus. Tested
> with 8MIC-RPI-MX8 microphone array.
> 
> Daniel Baluta (2):
>   ASoC: SOF: imx8m: Add DAI driver entry for MICFIL PDM
>   ASoC: SOF: Add support for configuring PDM interface from topology
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: SOF: imx8m: Add DAI driver entry for MICFIL PDM
      commit: fc85d9d0b3ba8f8934963c760af98fc38029d9da
[2/2] ASoC: SOF: Add support for configuring PDM interface from topology
      commit: 89ef42088b3ba884a007ad10bd89ce8a81b9dedd

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

