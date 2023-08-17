Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6C2078011F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 00:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355833AbjHQWgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 18:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355797AbjHQWge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 18:36:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC8530C2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 15:36:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8559E63292
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 22:36:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB8A5C433C7;
        Thu, 17 Aug 2023 22:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692311793;
        bh=rIHX9Z5/J85miF4p/AYvLMNc6o8isoWh9x2Q3al4j7I=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Rkj09KBOa+ce/+CZFcr/dCzbkm4OQz2bV/8X/ItKrANDa9txkJnkY5LbiQJDMDHrH
         xZiuTDcIe9MhVaO2GHkyomFe//nwcrJ8iiIrs0MneBIGEE644ZISiNMMNaKF2fHzvz
         evyNV/+TpO5MtyRX0WLiqKKQf+ZGZjtQanS7lzcIuwLJqtMmfqXr10RJnyd/tCP6yx
         Eya06wyUieVxJHBQwueHXVVCL51AZUUvsUKBi4Xwi4sHRleCTsCMh6c1SgSgkLpjxc
         mIVLvQWnb0YWanoytMuKdhU915C5rKzYTi93GIyEaYwusFA8BFelcE0mAGXGFrVN2r
         Fvk+snX9TVXjg==
From:   Mark Brown <broonie@kernel.org>
To:     robh+dt@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        pierre-louis.bossart@linux.intel.com,
        Shenghao Ding <shenghao-ding@ti.com>
Cc:     kevin-lu@ti.com, 13916275206@139.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, liam.r.girdwood@intel.com,
        mengdong.lin@intel.com, baojun.xu@ti.com,
        thomas.gfeller@q-drop.com, peeyush@ti.com, navada@ti.com,
        tiwai@suse.de, gentuser@gmail.com
In-Reply-To: <20230817093257.951-1-shenghao-ding@ti.com>
References: <20230817093257.951-1-shenghao-ding@ti.com>
Subject: Re: [PATCH v1] ASoC: tas2781: fixed register access error when
 switching to other chips
Message-Id: <169231178941.153247.7234904514917786817.b4-ty@kernel.org>
Date:   Thu, 17 Aug 2023 23:36:29 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Aug 2023 17:32:56 +0800, Shenghao Ding wrote:
> fixed register access error when switching to other tas2781 -- refresh the page
> inside regmap on the switched tas2781
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: tas2781: fixed register access error when switching to other chips
      commit: 3d521f9f3663ba7a22e56d339c6632f0ca787371

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

