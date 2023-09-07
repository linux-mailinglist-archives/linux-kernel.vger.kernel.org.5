Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4937977BA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233903AbjIGQbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238525AbjIGQbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:31:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7459530C7;
        Thu,  7 Sep 2023 09:20:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41D27C32788;
        Thu,  7 Sep 2023 12:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694089695;
        bh=nnCShZmEg2H6XKCS/jm/kK0JCoqhVXZ8eK6f5gMQYzs=;
        h=From:To:Cc:Subject:Date:From;
        b=GdNLNKWh3AZF+BaP01q+0HjWG0A4kKNqpe/QxkY0iyVINLqUCu/wl5b0Gzf346Ixt
         L/8kJ8dRS2shBYHw4zyj8A8dnrkHUGMtYq6zF6XHWmPOpbCtewWsNmyUrKJ0VfHrRO
         GGjH6SyNapXrbC+ytm+yh408o69yCPbEfQAMpLuJwLtaT5YPp8r0gtdJPGDQw+Y6aG
         rEkYycxc1Qhoa5eCBoXDYZg4vweCzG63TQgPSrmh1TIzTZHJDhdh4kNsy0Jn7uSH8n
         Z0WM1fjj2C9ibxfIaI2bQzCb5+1iQK5/zbIIK09RtfpQOU/M0TjXa9/ceFz7axBOV/
         ctLTanpsta4yQ==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v6.6-merge-window
Date:   Thu, 07 Sep 2023 13:28:02 +0100
Message-Id: <20230907122815.41D27C32788@smtp.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 2dde18cd1d8fac735875f2e4987f11817cc0bc2c:

  Linux 6.5 (2023-08-27 14:49:51 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.6-merge-window

for you to fetch changes up to 1f11f4202caf5710204d334fe63392052783876d:

  spi: sun6i: fix race between DMA RX transfer completion and RX FIFO drain (2023-09-04 13:55:29 +0100)

----------------------------------------------------------------
spi: Fixes for v6.6

A couple of fixes for the sun6i driver, the patch to reduce DMA RX to
single byte width all the time is *hopefully* excessively cautious but
it's unclear which SoCs are affected so the fix just covers everything
for safety.

----------------------------------------------------------------
Tobias Schramm (2):
      spi: sun6i: reduce DMA RX transfer width to single byte
      spi: sun6i: fix race between DMA RX transfer completion and RX FIFO drain

 drivers/spi/spi-sun6i.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)
