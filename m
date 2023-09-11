Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B427179B0B1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349518AbjIKVdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243855AbjIKSD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 14:03:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 555FC10D
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 11:03:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B95CC433C7;
        Mon, 11 Sep 2023 18:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694455402;
        bh=obko3RK2pNWZtJGeiHsu1z2FMgxl/RmgVcxZGodti54=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=QXim35P0YL7ocQ9J/b8ORZyToPUGDVe9q7tHlBTMBJEUG1EzApjbrGm5UmyvfdOTy
         VULrasIlLBKepgJQbvAC5dPpw8hgFk8mfjEo30tkinLHoUFBIh2OTXdQAg01YBZ2Vc
         NExfJfx7k2Tx8WFAlFTTeFZA1s8+RsUszLcMufEplmMNmjpVBL96878z2sr52cfrzX
         lyMC7hhmadOYDnyjZTO9nxWecLAlCTwcEVFZHdBUClg4OOvDtNHEVF/hmK/7DqAeuY
         /iFPNfu7yGcXzPblRTWRPfMcUT7ibt8D7pQuZlZiQIJyYRx5m4FDPg7ogOzI5Pp1tq
         VSgArRe0wF0Aw==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     linux-kernel@vger.kernel.org, kernel@axis.com
In-Reply-To: <20230911-regulator-voltage-sel-v1-1-886eb1ade8d8@axis.com>
References: <20230911-regulator-voltage-sel-v1-1-886eb1ade8d8@axis.com>
Subject: Re: [PATCH] regulator: Fix voltage range selection
Message-Id: <169445540117.1864831.9357705995059238974.b4-ty@kernel.org>
Date:   Mon, 11 Sep 2023 19:03:21 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Sep 2023 14:42:47 +0200, Vincent Whitchurch wrote:
> Use the correct field to fix wrong voltage range selection on regulators
> such as tps6287x since the blamed commit.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: Fix voltage range selection
      commit: 6223e073db78458f8846c380ccd224a7a73a3867

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

