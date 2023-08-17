Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3761C78011D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 00:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355815AbjHQWgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 18:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355790AbjHQWg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 18:36:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74E12D65
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 15:36:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 588B963B77
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 22:36:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E095CC433C7;
        Thu, 17 Aug 2023 22:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692311787;
        bh=Emr7HE/JJbf3uc9L6KhxZLueQQI7VvbDfxqJ6cAiJFY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=G+fbN1EY0/iMCPsGOttzs4U39JH0sqe2BtumutREtOKoxLHhein7/EMYBoIlQ1pAx
         irEK4okwrsKzYGG5L/cBXEbFeeFE79vVvVN62kgfpDjmktHvw9ZAsLEfUWxfvQEzvV
         BQPCIYZcBwDkXrxQFs6Et0dVNvz3hqnYItntAKn/o1Xw9FjHjqLlSD6aiDBTeDSsmu
         0ZEZ6amFdSdP4kXYeBpeYh6Py+JqgSf6ZL/3OZltvTqASeIZQirmjgounTukeoHvFY
         e2qDdz5Vuyny/Fsn/9q0nZnzMqbEYPqz2FWXUhGYAywX+R9pmjwsF139djL+itWpJj
         UmEBKm7mHP6eA==
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
In-Reply-To: <20230816164906.42-1-rf@opensource.cirrus.com>
References: <20230816164906.42-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH 0/2] ASoC: cs35l56: Update ACPI HID and property
Message-Id: <169231178663.153247.13799745756303310449.b4-ty@kernel.org>
Date:   Thu, 17 Aug 2023 23:36:26 +0100
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

On Wed, 16 Aug 2023 17:49:04 +0100, Richard Fitzgerald wrote:
> These two patches add an ACPI HID and update the way the platform-
> specific firmware identifier is extracted from the ACPI.
> 
> Maciej Strozek (1):
>   ASoC: cs35l56: Read firmware uuid from a device property instead of
>     _SUB
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: cs35l56: Add an ACPI match table
      commit: e8500a70270334b9abad72fea504ef38a2952274
[2/2] ASoC: cs35l56: Read firmware uuid from a device property instead of _SUB
      commit: 897a6b5a030e62c21566551c870d81740f82ca13

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

