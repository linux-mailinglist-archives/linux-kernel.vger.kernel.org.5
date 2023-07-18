Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB78A757B7E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 14:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbjGRMKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 08:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbjGRMKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 08:10:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD7719AB
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 05:10:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A9BCA612E8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 12:10:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6476AC433CA;
        Tue, 18 Jul 2023 12:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689682203;
        bh=Bwi6+hxv+njlD1feI8RZMPqKlUapw7YCTAxkf6ATuhw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=SQVguFhEExz6ZaiyvqImE9Y5tzDDd9cS8Oqp3xWI+3BHvcZ1S/fWg0cp/zisODT8s
         SUUXsPv2BtkZDB+sYjPd9PjuhZYBvsQwOxpbG15GgIklVR14n587oAkPMAuHW8VZQ+
         PmlXbPoRw8M6On/lXN+aHXBsgJisTiaRkKrosKzxrQJPa1N+LqwvJVza33HOLxq8kU
         IRhVJMecozYtWQG7uCc1Gehj+OPcIWCnMcWUuTcXBBH+ZgQoPWOaSVkXPat17eME5N
         Exy1txTw1eU/j6dd+iiDtXvBYZHJUcGssUiePQlKIiq/y4Zj+kVgVrgxH8EJCMUCNX
         XWyLvgN5p9Hcg==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        =?utf-8?q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>,
        Wolfram Sang <wsa@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
Cc:     imx@lists.linux.dev, shengjiu.wang@nxp.com
In-Reply-To: <20230713222513.1636591-1-Frank.Li@nxp.com>
References: <20230713222513.1636591-1-Frank.Li@nxp.com>
Subject: Re: [PATCH 1/1] ASoC: codec: wm8960: add additional probe check
 for codec identification
Message-Id: <168968220008.40723.6109543633673896312.b4-ty@kernel.org>
Date:   Tue, 18 Jul 2023 13:10:00 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jul 2023 18:25:12 -0400, Frank Li wrote:
> The wm8960 codec is not readable, resulting in a NACK for address 0x3d (8-bit).
> This can partially indicate it. For example: wm8962 codec use the same address
> but is readable. This additional probe check will help prevent loading the wm8960
> module incorrectly on wm8962 hardware.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codec: wm8960: add additional probe check for codec identification
      commit: 8b30cdbe0b911562fc1496078162dc9547b69be5

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

