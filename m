Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9727B56A9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 17:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238028AbjJBPRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 11:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238027AbjJBPRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 11:17:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33252D7
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 08:17:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B693C433C8;
        Mon,  2 Oct 2023 15:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696259857;
        bh=ER6oLVHxt79NWJRk4i6TQYMDnVPa/mQSBVn1tmMNCvk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=NxQuX+QICNK9ffUBus5qmweKQ0JZMHcxdvRWiiOil8fkQD3VXK9x+JEoOLi4NFTo2
         ewJI1kBalKZbVTai3b5QD1rs202AWarmW5ZmYm/NP4UoNLOcuS2zmaD8IzLBb53GUk
         bpeutcVFTgB1KxBNFjxVRIPHsWVgDN/C83drI2xrr0wb1KzpmZPSMuv8gD9H0dKBMD
         6ixWQzbSVb5P5xKChC/JILDPZJvq+wHzjpC29cOI6GD74AITUhHjWKnVsKOOkqJxe4
         r3PK+Nw/rvhYkCGNG7y7+QYUoZtpBh3ExDZu+/ZOG/ImJMQUiFd2vrFARfFXRBpYWw
         zriimCuzJOerw==
From:   Mark Brown <broonie@kernel.org>
To:     Shenghao Ding <shenghao-ding@ti.com>
Cc:     robh+dt@kernel.org, andriy.shevchenko@linux.intel.com,
        lgirdwood@gmail.com, perex@perex.cz,
        pierre-louis.bossart@linux.intel.com, kevin-lu@ti.com,
        13916275206@139.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, liam.r.girdwood@intel.com,
        mengdong.lin@intel.com, baojun.xu@ti.com,
        thomas.gfeller@q-drop.com, peeyush@ti.com, navada@ti.com,
        tiwai@suse.de
In-Reply-To: <20231002090434.1896-1-shenghao-ding@ti.com>
References: <20231002090434.1896-1-shenghao-ding@ti.com>
Subject: Re: [PATCH v1] ASoC: tas2781: fixed compiling issue in m68k
Message-Id: <169625985375.65718.17717967920351925508.b4-ty@kernel.org>
Date:   Mon, 02 Oct 2023 16:17:33 +0100
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

On Mon, 02 Oct 2023 17:04:33 +0800, Shenghao Ding wrote:
> fixed m68k compiling issue: mapping table can save code field; storing the
> dev_idx as a member of block can reduce unnecessary  time and system
> resource comsumption of dev_idx mapping every time the block data writing
> to the dsp.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: tas2781: fixed compiling issue in m68k
      commit: 4c556d1ea5a771a91f946964d931b4974a6b917e

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

