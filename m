Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA427741AE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234508AbjHHRZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234417AbjHHRZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:25:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5934220270
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:10:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD31962577
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 13:41:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81A8BC433C8;
        Tue,  8 Aug 2023 13:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691502082;
        bh=hwWwIFOKy4UXJwpOTDB59h5Fiq2GMxp0VRzPBzBvVKc=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=B/hsdE4x3isQatcGEmZzVRLyMDcHXqL9Tj1zZJmvXFWfiInx3TmpxytEILOBWqdTb
         w93Z8PKOHgQZgRrh8n7g2kEPdP4uKXW6UmKWjG/HR4oW8ISgJBaxt8dMSp1j6pM3Pn
         y5MiVdtlHRXDd5YsYPCCc8LEY5Y5ZxX4aS/1p+XkHNjVIbt/RHt3icex4cNVzFfz28
         2+nCJllCygIKpVmVkOsS4WpvguEXllfRhcsZT+PF3OhXVoyAuRIE5DSeCcvO6pVqqX
         uhhp0PfA18ZelOlXID/56DK1uOtLa2xcsT1rkw9wsnVUf/yvTGLnAnlEagaCMz4efI
         XI8+Sw8mBPmCA==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Ruan Jinjie <ruanjinjie@huawei.com>
In-Reply-To: <20230807134127.2380390-1-ruanjinjie@huawei.com>
References: <20230807134127.2380390-1-ruanjinjie@huawei.com>
Subject: Re: [PATCH -next] regulator: rpi-panel-attiny-regulator: Remove
 redundant of_match_ptr()
Message-Id: <169150208122.40651.11560815070971961815.b4-ty@kernel.org>
Date:   Tue, 08 Aug 2023 14:41:21 +0100
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

On Mon, 07 Aug 2023 21:41:27 +0800, Ruan Jinjie wrote:
> The driver depends on CONFIG_OF, so it is not necessary to use
> of_match_ptr() here, and __maybe_unused can also be removed.
> 
> Even for drivers that do not depend on CONFIG_OF, it's almost always
> better to leave out the of_match_ptr(), since the only thing it can
> possibly do is to save a few bytes of .text if a driver can be used both
> with and without it.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: rpi-panel-attiny-regulator: Remove redundant of_match_ptr()
      commit: 200ee464f7a9a4e8d7a51a2083b28cf240e7cb91

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

