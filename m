Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED24B77D33F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 21:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234493AbjHOTTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 15:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240030AbjHOTTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 15:19:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663C31FF9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 12:18:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 094C56610B
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 19:17:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9538AC433C9;
        Tue, 15 Aug 2023 19:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692127073;
        bh=XyQKCBCEqFhZRGQy+OURocnnnDKkB2ubMUqg+Nmjvtg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=o34kBNVvtjaVyC+NfENPtdbsaXhdRTI8y9dH8SN17cpZ1VU65nyiRMvNo2T9vQ7Bl
         SyIwchTMY4n7/9kqeybiirj0Oh1XLUzIr4K0kEOCo5IQBnxKa1YHGK106AvKlqe7qw
         a6U7FbSfImQPpvL68XV/jl5Pt6zFylQWBdUBYr3YdVI0eqOrACKRbjkYZTQ7ImqsKW
         xYon4K8JtrFHdWrXSyoFRMzmuZ6mfEKUlrSRD05v1vHA6R6knrwR4NxdT+fGFHZxXh
         IwApc5MJHDyju8VoGwxNw4Y/lL+SWwlt2xt4cPGKArg1oDw7rl5C6T13pti1EJb2xx
         RN9lfDwB/B4yw==
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
In-Reply-To: <20230815124826.5447-1-rf@opensource.cirrus.com>
References: <20230815124826.5447-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH 0/2] ASoC: cs35l56: Don't patch firmware that is
 already patched
Message-Id: <169212707233.68178.18277945930655781707.b4-ty@kernel.org>
Date:   Tue, 15 Aug 2023 20:17:52 +0100
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

On Tue, 15 Aug 2023 13:48:24 +0100, Richard Fitzgerald wrote:
> Use the FIRMWARE_MISSING flag in the CS35L56 to determine whether it is
> safe to download a firmware patch.
> 
> Richard Fitzgerald (2):
>   ASoC: wm_adsp: Support powering-up DSP without trying to load firmware
>   ASoC: cs35l56: Don't overwrite a patched firmware
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: wm_adsp: Support powering-up DSP without trying to load firmware
      commit: 62ddad4238a0250aa9cedade127c39aac9d26d45
[2/2] ASoC: cs35l56: Don't overwrite a patched firmware
      commit: 67bd793ba5e0984ecb7ee4407c2f79d159e305ff

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

