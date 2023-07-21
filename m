Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09CC475D0C5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 19:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjGURl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 13:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjGURlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 13:41:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56AF930E6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 10:41:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E074961D71
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 17:41:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 774DBC433CA;
        Fri, 21 Jul 2023 17:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689961277;
        bh=WTcTy8AJD0zXumvTXWX9217N+lKUWJJmB3HWKkNtguI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=N8vYaVng7cWIUHSWYmfk1R9jDrDq4HpyAjY/X0aszNq7kPB7t1IFTPQm2TGZxx9oJ
         qm1zsTkPphi8aGKIC2rU1tAbq4chzx9sRXHz90hQafaJAC2Wkm+WoVBE2JJQ071m8X
         kOJ+FOEuvs9c7IxxIp7hkj/v6FY6m69YppCZwjL75coXRTP7J4+WFX56Gf0sBtPCbH
         ut2BqKDHibJI+dO2Rk+buqHMlGr/ko0lBwdalNJ7ZPYJNouAqbQEONpF6rYXBI8c3F
         mtkt01NOTE9NQ4r0BZK2iOefD1qbsr2G4O+J9EORwetl8w0yeHZzOykhvW1uk3ZisS
         PQLRmc6+CK05w==
From:   Mark Brown <broonie@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230720032848.1306349-1-linux@roeck-us.net>
References: <20230720032848.1306349-1-linux@roeck-us.net>
Subject: Re: (subset) [PATCH 1/2] regmap: Disable locking for RBTREE and
 MAPLE unit tests
Message-Id: <168996127620.147835.8944334131436750978.b4-ty@kernel.org>
Date:   Fri, 21 Jul 2023 18:41:16 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jul 2023 20:28:47 -0700, Guenter Roeck wrote:
> REGCACHE_RBTREE and REGCACHE_MAPLE dynamically allocate memory
> for regmap operations. This is incompatible with spinlock based locking
> which is used for fast_io operations. Disable locking for the associated
> unit tests to avoid lockdep splashes.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/2] regmap: Disable locking for RBTREE and MAPLE unit tests
      commit: a9e26169cfda651802f88262a315146fbe4bc74c

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

