Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 925FC77D481
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 22:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239273AbjHOUoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 16:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239175AbjHOUnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 16:43:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FDA7138
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 13:43:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 93E0C6551A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 20:41:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98129C433C9;
        Tue, 15 Aug 2023 20:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692132112;
        bh=T2szHddILlEWvuY7nP42GFOIJiTikof8i6XOhjiln4Q=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=E6JrJfvP4wLCyB+DCnASM6bIPrghcTOv+3tDGEN58EgHRrwcyte2EUi7dnq1yG5Yt
         F8FEnf/NM6wLK9qi5AnA4T16WiGvPKoDl1uPluCq0WGIWIInHVoM/tcxKpY8FGhVfE
         dUNS5RIBo5+mSC0yRYZ8H6V/CdxEslflJldayzSjlcjd9ekY5Q1Dx/hWdpKzWqBaU/
         QcnqDvgMiVxxoGbc60nMZM+eoo1mKjvYNawoZg0CGUw0nlRcIJNIbX9XRzPKnXDlyS
         5dqEUTIN2UENY3rwjzCrf/YbSjjXwhzUAsbFQyRLL1ksEyWrfIKXtA0nT0rKsghItg
         6OAN+xN8VqQuA==
From:   Mark Brown <broonie@kernel.org>
To:     Simon Trimmer <simont@opensource.cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Vlad Karpovich <vkarpovi@opensource.cirrus.com>
Cc:     patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        Ricardo Rivera-Matos <ricardo.rivera-matos@cirrus.com>
In-Reply-To: <20230815172908.3454056-1-vkarpovi@opensource.cirrus.com>
References: <20230804165212.236822-1-vkarpovi@opensource.cirrus.com>
 <20230815172908.3454056-1-vkarpovi@opensource.cirrus.com>
Subject: Re: [PATCH] firmware: cs_dsp: Fix new control name check
Message-Id: <169213211034.572973.3501945311233979660.b4-ty@kernel.org>
Date:   Tue, 15 Aug 2023 21:41:50 +0100
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

On Tue, 15 Aug 2023 12:29:08 -0500, Vlad Karpovich wrote:
> Before adding a new FW control, its name is checked against
> existing controls list. But the string length in strncmp used
> to compare controls names is taken from the list, so if beginnings
> of the controls are matching,  then the new control is not created.
> For example, if CAL_R control already exists, CAL_R_SELECTED
> is not created.
> The fix is to compare string lengths as well.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] firmware: cs_dsp: Fix new control name check
      commit: 7ac1102b227b36550452b663fd39ab1c09378a95

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

