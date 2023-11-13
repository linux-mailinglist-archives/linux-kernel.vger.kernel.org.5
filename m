Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D61FE7E9E15
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 15:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbjKMOFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 09:05:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbjKMOFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 09:05:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F1B173D;
        Mon, 13 Nov 2023 06:05:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B25FC433C7;
        Mon, 13 Nov 2023 14:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699884338;
        bh=smbWAQ3GRcJ1HxgFgH6ijdLPIgWeWjNDbJAzqJb/kjY=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=nlnbos5xmyFFvD7eTr3cc1H/fJlK9xNQODaxqosu1DvXoGgO21x+6O705K3M8YApk
         RfAqxnF5OeNw0Cv3CXL1vktvYo1lNvHn6eg8QUAKwxEtEtIZ1BzJBuAjvbYEVSQiGl
         nsf54oVMGS0TKiCnC+RVKmVPpHu1593z7hTJ2sVaob4Gs2UdyjM3XncIAUz2dgJ+aQ
         vIGIcbGrPcK7CcWDT1R+S6DsIX1PNKFO0QV5ZkzO3SR9o5q0/kk11oHMhpgGrTBRiW
         lEtMsb1j+4klphDgue1AHiZaAIa44eUbi3ySkfzSs3IBMS+zVhc1y+32P7XYg8AQDa
         7QFo5VcKiSTYA==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        liweilei@awinic.com, yijiangtao@awinic.com, trix@redhat.com,
        dan.carpenter@linaro.org, colin.i.king@gmail.com,
        herve.codina@bootlin.com, nathan@kernel.org,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangweidong.a@awinic.com
In-Reply-To: <20231109093708.13155-1-wangweidong.a@awinic.com>
References: <20231109093708.13155-1-wangweidong.a@awinic.com>
Subject: Re: [PATCH] ASoC: codecs: Modify the bin file parsing method
Message-Id: <169988433475.3280890.6431768329803223556.b4-ty@kernel.org>
Date:   Mon, 13 Nov 2023 14:05:34 +0000
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

On Thu, 09 Nov 2023 17:37:07 +0800, wangweidong.a@awinic.com wrote:
> Modify the aw88395_lib file so that the bin file
> parsing is no longer related to the chip id of the chip.
> Adopt the bin file data type "prof_data_type" as the
> differentiation between different chip bin file
> parsing methods.
> 
> Since the chip id macro for the aw88399 is no longer
> defined in aw88395_reg.h, define the chip id
> for the aw88399 in aw88399.h
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: Modify the bin file parsing method
      commit: fc213b8d4466d1fcf39ab760979be4eac2a67635

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

