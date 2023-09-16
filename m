Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE6F37A2CE4
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 03:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238660AbjIPBMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 21:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238626AbjIPBL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 21:11:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E2CE3;
        Fri, 15 Sep 2023 18:11:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D65F9C433C7;
        Sat, 16 Sep 2023 01:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694826711;
        bh=ZnjlEj98hFQQmsZsTmFla9uF/838RJCPiORahjtKy74=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=S1xHpqLC9Y6gq/hRVu7xdsKfo68I57/FOw56qL1IGwQSfvbdXnCWtUz+ehokB0+My
         jvKHh+pZn1aVBvYCTh83loYxt2qb03bZ1DXgPCX2ardp+4/O/NjMiC8Bc06+n5ipr2
         KF19K4TwWEoZ/7HcCoJNCI9MohDz3gQNwiQGrAHdJuTsrWH0sVBX5vkqrU+KhLgJnT
         Q3n9YYbVWkIH8zXsI2a/jlxc2R+m1DU+J6lpLSOjjYiXdSam9M5YhvRWqhQESZSloi
         2mNMMdcofFGlS1LGu45bcBc5T+tIKzeCpsEZm9348OO1umyO4m29VbAKhlFrq8ZUHn
         4oAHxCAufaElg==
From:   Mark Brown <broonie@kernel.org>
To:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com,
        Colin Ian King <colin.i.king@gmail.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230915092639.31074-1-colin.i.king@gmail.com>
References: <20230915092639.31074-1-colin.i.king@gmail.com>
Subject: Re: [PATCH][next] ASoC: cs42l43: make const array controls static
Message-Id: <169482670859.606223.14038286756818345691.b4-ty@kernel.org>
Date:   Sat, 16 Sep 2023 02:11:48 +0100
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

On Fri, 15 Sep 2023 10:26:39 +0100, Colin Ian King wrote:
> Don't populate the const array controls on the stack, instead make it
> static.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs42l43: make const array controls static
      commit: 9dc098e3d7297ec895436a799f5faf27d430674c

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

