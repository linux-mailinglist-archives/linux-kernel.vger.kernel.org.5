Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11059772FF1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 21:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjHGTyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 15:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbjHGTy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 15:54:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19FEB10DB;
        Mon,  7 Aug 2023 12:54:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7390262186;
        Mon,  7 Aug 2023 19:54:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70B35C433CA;
        Mon,  7 Aug 2023 19:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691438064;
        bh=goD4ByHBwqYYj95qYjcyojZaR3O2ZOeLLA0qA84L1/g=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=gKDmeHJLYLRWhrUN+ij6zHFu8nms8fGCHuVCCQfBknWtTUEZilPDyTd2R4FCFC6tb
         hdY4A9xchWr7URRVpyq1Ro2ScGT4uV2QLvhzGIL3kcSvpBKJrX/LxjyaRMz0GjIAOp
         Gsd3MK7clyj1+mr1BDXfLI3k/V1ZLanIs/qakqSciL2is7KMBrenBzkHYrGAWXRFZX
         m1HtKBcclCTKKBZp5hK2M0VLTlBcWAWNuZd90HXNVdTU4wxQCUaKsEHcTIiMKNsArN
         tFrFXBE1YLIiQeOqVmuWlxJCBB6naofyFzZA7fZpOcMud7Imv1LnkLowi6j7fNpMJ2
         /0kmGMgK9tkNQ==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        perex@perex.cz, tiwai@suse.com, rf@opensource.cirrus.com,
        shumingf@realtek.com, herve.codina@bootlin.com,
        13916275206@139.com, ryans.lee@analog.com,
        ckeepax@opensource.cirrus.com, sebastian.reichel@collabora.com,
        ajye_huang@compal.corp-partner.google.com, povik+lin@cutebit.org,
        yijiangtao@awinic.com, trix@redhat.com, colin.i.king@gmail.com,
        liweilei@awinic.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangweidong.a@awinic.com
Cc:     zhangjianming@awinic.com
In-Reply-To: <20230804114749.215460-1-wangweidong.a@awinic.com>
References: <20230804114749.215460-1-wangweidong.a@awinic.com>
Subject: Re: [PATCH V4 0/3] ASoC: codecs: Add awinic AW88261 audio
 amplifier driver
Message-Id: <169143806017.302632.37564599708375249.b4-ty@kernel.org>
Date:   Mon, 07 Aug 2023 20:54:20 +0100
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

On Fri, 04 Aug 2023 19:47:46 +0800, wangweidong.a@awinic.com wrote:
> The awinic AW88261 is an I2S/TDM input, high efficiency
> digital Smart K audio amplifier
> 
> v3 -> v4: Modify the dev_err_probe usage
>           Changed the use of sizeof in kzalloc
>           Changed the function name
>           Merge aw88261_device.c into aw88261.c
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: dt-bindings: Add schema for "awinic,aw88261"
      commit: 517d52ae5cf75d55970345ece4f6743abdf4620f
[2/3] ASoC: codecs: Add code for bin parsing compatible with aw88261
      commit: 7f4ec77802aa17518990ed954bf536fd3bcf25cb
[3/3] ASoC: codecs: Add aw88261 amplifier driver
      commit: 028a2ae256916eeae1040049d2d0129535ace60e

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

