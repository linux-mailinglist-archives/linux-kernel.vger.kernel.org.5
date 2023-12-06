Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE6D3807608
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 18:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442685AbjLFREa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 12:04:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442647AbjLFRE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 12:04:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF25B90
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 09:04:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8925C433C9;
        Wed,  6 Dec 2023 17:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701882275;
        bh=9vmAQUJxFAYDIKai4fvfCvX+sqvXOJ79oJiNPyZR8rA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=QgNLJ7nH39Dhy1D95QfMuU7BXPxMRazYJPtmFPGHXJppRtu4sNRx6CtKVwaFUufzE
         YV/nq9oji70MihLOoIq317QlsUr5QGr/IMcTJ6dnTvktfF5N5mgWZ9TFw9Cg+kBN/P
         ZAeJuwMbE1a3eDflS4VZ8Jn15GLwXwA/Oop8vZOO5KimjKQ3qzvndaldny7d2+nsrQ
         gbNjvJbr/xPSWMsN57UInkWZ/gSdgMJWcSjbUYUUc2OzX44MEC2026VsFiYCNJx4jd
         SvB4ATYw/zn1AtwjMQmhlNJaExkvxiInKWl3yNUfgZNhZZeeqXbDGf2AQ/xEcBE0BE
         QgxpTOgRP9foQ==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Naresh Solanki <naresh.solanki@9elements.com>
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <20231205105207.1262928-1-naresh.solanki@9elements.com>
References: <20231205105207.1262928-1-naresh.solanki@9elements.com>
Subject: Re: [PATCH v4] regulator: event: Add regulator netlink event
 support
Message-Id: <170188227447.41735.13582481382883137622.b4-ty@kernel.org>
Date:   Wed, 06 Dec 2023 17:04:34 +0000
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

On Tue, 05 Dec 2023 16:22:04 +0530, Naresh Solanki wrote:
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

