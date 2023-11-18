Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 353B77EFC94
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 01:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346406AbjKRAc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 19:32:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346405AbjKRAc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 19:32:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E361727;
        Fri, 17 Nov 2023 16:32:53 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BCAEC433C7;
        Sat, 18 Nov 2023 00:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700267573;
        bh=J/goLqTyDEI22Ut/pwCL/UNJNymwPHdELhT+G8VnytQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=GPiqFDYAW0CqmUbyqiFkERP5VRvZBQF7q5NignjIU5v0FN4+iof5qOgc05JmE+cl9
         +b0/ebkAsyeEP+mG//lbtrLx1ima9e8uvV4JTCjJPaWRMBcr9Ma40PfulYWWzmOn+F
         ypf1cE3rHxNFxJ2Cx4aMTtFDLe6c6ERUFrYUtRVmiea/+XXP4HcpqRGQsKTOifPsR6
         yVkyTaj4MHY/qQbsa5PdDmjn0657lzyp+mb4prD7g7oDxcTL2xLtkg+IpFlxDiE5ve
         sjOG1kW9oMOcbwqgNeiTEuCEUPuokojpuug6rlHiLA6TFoRZWiFydSc+voUB14Z5nN
         THDZFWY+NWsyw==
From:   Mark Brown <broonie@kernel.org>
To:     Maciej Strozek <mstrozek@opensource.cirrus.com>
Cc:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231117141344.64320-1-mstrozek@opensource.cirrus.com>
References: <20231117141344.64320-1-mstrozek@opensource.cirrus.com>
Subject: Re: (subset) [PATCH 0/7] ASoC: cs43130: Fixes and improvements
Message-Id: <170026757145.1646674.10200174783594509637.b4-ty@kernel.org>
Date:   Sat, 18 Nov 2023 00:32:51 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Nov 2023 14:13:37 +0000, Maciej Strozek wrote:
> This patchset aims to add minor fixes (first two patches) and
> introduce general improvements to the driver (rest of the patches)
> 
> Maciej Strozek (7):
>   ASoC: cs43130: Fix the position of const qualifier
>   ASoC: cs43130: Fix incorrect frame delay configuration
>   ASoC: cs43130: Allow configuration of bit clock and frame inversion
>   ASoC: cs43130: Store device in private struct and use it more
>     consistently
>   ASoC: cs43130: Add handling of ACPI
>   ASoC: cs43130: Allow driver to work without IRQ thread
>   ASoC:cs43130: Add switch to control normal and alt hp inputs
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/7] ASoC: cs43130: Fix the position of const qualifier
      commit: e7f289a59e76a5890a57bc27b198f69f175f75d9
[2/7] ASoC: cs43130: Fix incorrect frame delay configuration
      commit: aa7e8e5e4011571022dc06e4d7a2f108feb53d1a
[3/7] ASoC: cs43130: Allow configuration of bit clock and frame inversion
      (no commit info)
[4/7] ASoC: cs43130: Store device in private struct and use it more consistently
      commit: 552206add94dd7977bad32c37eba16e23756a0f9
[5/7] ASoC: cs43130: Add handling of ACPI
      commit: ce7944b73e7729dc702b6741cff2b26886bb723c
[7/7] ASoC:cs43130: Add switch to control normal and alt hp inputs
      commit: 9158221bf2aa5f7bfb916452c079b2fe63ca76e8

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

