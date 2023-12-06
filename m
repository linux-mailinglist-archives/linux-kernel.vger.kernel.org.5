Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC8A807607
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 18:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378600AbjLFRE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 12:04:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjLFRE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 12:04:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74A990
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 09:04:34 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93DA3C433C7;
        Wed,  6 Dec 2023 17:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701882274;
        bh=qrCR5RI5BDyTomV7iYlSz6O36EB1dz6eGflZqJgyZLA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=aP9qXk1LqOilm/mvyBQTSQDG6U7vR3QYZ9y8DRu+rUlaq+En1K+n+y/nbIXX40X7a
         /SnFzn1dP7s9MiOA6iZ2NJ73av+JIJFfFYCcmj5ILZOoXyU1jxulKli1o1KCKadZej
         CuSHsaBx6whdKfWoTgCfDxD/fsnNYO6rG1zdWxMYOyh6QNO5MoH0pxD+4Fv/r6Ybp1
         9LD0T52C9vE0lpKQlCIQRWJqyRfjrlblm/ZffSUvV4sa/xtS87wcUMf7mWA+viWLOZ
         j//A/cgtczZyyiXVebePgOLmUmvA8tuY0szfWrVz+Aqzr+4d+PN7+m3IH/GsqskUlz
         D8cpVa9NMIucw==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Naresh Solanki <naresh.solanki@9elements.com>
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <20231128140718.3866978-1-naresh.solanki@9elements.com>
References: <20231128140718.3866978-1-naresh.solanki@9elements.com>
Subject: Re: [PATCH v3] regulator: event: Add regulator netlink event
 support
Message-Id: <170188227331.41735.13994951826943179879.b4-ty@kernel.org>
Date:   Wed, 06 Dec 2023 17:04:33 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Nov 2023 14:07:16 +0000, Naresh Solanki wrote:
> This commit introduces netlink event support to the regulator subsystem.
> 
> Changes:
> - Introduce event.c and regnl.h for netlink event handling.
> - Implement reg_generate_netlink_event to broadcast regulator events.
> - Update Makefile to include the new event.c file.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: event: Add regulator netlink event support
      commit: 16e5ac127d8d18adf85fe5ba847d77b58d1ed418

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

