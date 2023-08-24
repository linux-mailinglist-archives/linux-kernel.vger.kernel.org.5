Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53E2E787BA0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 00:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243955AbjHXWoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 18:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243935AbjHXWnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 18:43:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A86E1BF1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 15:43:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4319961E39
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 22:43:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE4AEC433C8;
        Thu, 24 Aug 2023 22:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692917023;
        bh=KsiGNwnZjt+57v2KBl5twmmjR8LxO52hDupumTF4shc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=I99F4m36BXLEyRF8lRK13wNRMfNsz+unoXmzYv+ed0i1hRTHN/3XF0+4fU1TDuO6Y
         Qjaa605pJerqJsImIBMnjNEbWXr9hK3Ag9d13NBPgILamCo3jCoMLvhE+E5dR0i8sg
         zb7CVsv+grTk4zZF4PaENhV3W/esKielCirOM1ILXKQUH9jRoGGID/Bxh3tkrjsaG1
         f77riHWePtp8egVdkXi3xXqTDSut1tJEtzfEPWqmuPq9WGKQ6wIQ8rvZbHI6UQAFzv
         OvNUUfk7UTd/nadfpy08F0HW5vWoKNL+IIJXjpzk2STvQaq/BxxPGCSKY+27sSQcMD
         +K7gMq+xw31Yg==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, Alec Li <like@awinic.com>,
        kernel@pengutronix.de
In-Reply-To: <20230824195617.8888-1-u.kleine-koenig@pengutronix.de>
References: <20230824195617.8888-1-u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] regulator: aw37503: Switch back to use struct
 i2c_driver's .probe()
Message-Id: <169291702160.2997334.8682327677563127679.b4-ty@kernel.org>
Date:   Thu, 24 Aug 2023 23:43:41 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Thu, 24 Aug 2023 21:56:17 +0200, Uwe Kleine-König wrote:
> struct i2c_driver::probe_new is about to go away. Switch the driver to
> use the probe callback with the same prototype.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: aw37503: Switch back to use struct i2c_driver's .probe()
      commit: 21cc7f816c670423a9dae06ad7de5fbc40da97c7

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

