Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E694477CCB9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 14:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237188AbjHOMdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 08:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237209AbjHOMcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 08:32:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CBE819AD
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 05:32:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0ED4F6423E
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 12:32:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60D74C433C7;
        Tue, 15 Aug 2023 12:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692102739;
        bh=Rev5nMRCDWjKRchsKzi2catE+rEXwLPvJz57/XZ8mkk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=CwGZAwTUDjvMBw4DDKYF9O/Nvo1XD2Ua/ufa+ViN5nfAOLaVfCQ7ZxbErAQ+oKRr3
         rXyZs0evnQzV96P6Fzf7c88QIBfZxfoeXKig/i011Penz4h+uXrZulc5JrCbE1n4ox
         F/FL1pZhhi1sd+ZsinCf8peo6xAX+Elhuv03Ch/TRutXPeFYfVUe4NWhIQpfcxTAtl
         tj9Z0dSrlnPtvwW2M5Z+X8njNH1J2XuvDpa6lTpL/yXxGK/PoieBFfPBUDTArgOcaH
         iTeqHIgqd4Shu9ov1e2cg/bwF5Zkaie0URedBJuy0oc5AkTcLT+Ukn8cDSBYHP9HlX
         a2wCQSLJQJPOQ==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        Alina Yu <alina_yu@richtek.com>
In-Reply-To: <20230814210759.26395-1-u.kleine-koenig@pengutronix.de>
References: <20230814210759.26395-1-u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] regulator: rtq2208: Switch back to use struct
 i2c_driver's .probe()
Message-Id: <169210273811.30574.14128936029712562753.b4-ty@kernel.org>
Date:   Tue, 15 Aug 2023 13:32:18 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Mon, 14 Aug 2023 23:07:59 +0200, Uwe Kleine-König wrote:
> struct i2c_driver::probe_new is about to go away. Switch the driver to
> use the probe callback with the same prototype.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: rtq2208: Switch back to use struct i2c_driver's .probe()
      commit: edff54ac96eb25f01d26cc68923a6dbbb5b2f440

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

