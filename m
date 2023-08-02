Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D24E076D566
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 19:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232720AbjHBRdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 13:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234015AbjHBRdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:33:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 093B646B7
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 10:31:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A468961A7E
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 17:30:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E65E9C433C7;
        Wed,  2 Aug 2023 17:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690997403;
        bh=lMe/DIyQCl/IwT6SoQDaroFkWtR5k0frE1KQOMf5qgY=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=W/pqFquuR8uAEpllrJL/SRzWb/wDWLvGIg07eB/VoDNZwQLyHMBOkFecjwRXnxPEh
         Ew1bIcw82QYg23XE5WxeXZR0+usfhTH53L7MKRAYSE1fn3UolMGp0ZGDquK+P9ltil
         tQkXYOPzgU/Da+NjK8QrhKDINpoStsWi4sa1fpKhatNf5hAUIbLXnLk/3l3OqeVbl+
         01SNKtdhTalz61URTZzwtBa1e4L+y+0kciSAsZot94jksU/vts4NBRN+InsEYANXlP
         +YUBx/hUQfYM5qZEg2IHDlFqP1Ia9GfQkS1BVQPSpbYAHi//Z8llG1kZ5VLKhBk3ee
         L5hlspnV2Im/g==
From:   Mark Brown <broonie@kernel.org>
To:     shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Chancel Liu <chancel.liu@nxp.com>
In-Reply-To: <20230802052117.1293029-1-chancel.liu@nxp.com>
References: <20230802052117.1293029-1-chancel.liu@nxp.com>
Subject: Re: [PATCH v2 0/3] Update the register list of MICFIL
Message-Id: <169099740066.237245.1120990059871983197.b4-ty@kernel.org>
Date:   Wed, 02 Aug 2023 18:30:00 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Aug 2023 13:21:14 +0800, Chancel Liu wrote:
> MICFIL IP is upgraded on i.MX93 platform. Add new registers and new bit
> definition.
> 
> changes in v2:
> - rename check_version to use_verid to make it more explicit
> - rename fsl_micfil_check_version to fsl_micfil_use_verid
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: fsl_micfil: Add new registers and new bit definition
      commit: 51d765f79c8d8016df906afd05410f8bc14167ac
[2/3] ASoC: fsl_micfil: Add fsl_micfil_use_verid function
      commit: 367365051b06e172c91172e3273eea72988ce8f6
[3/3] ASoC: fsl_micfil: Use SET_SYSTEM_SLEEP_PM_OPS to simplify PM
      commit: a38a4090e2c400c6c49c584cda6f28c73c08f5f1

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

