Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3D827E819D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346462AbjKJSbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:31:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235714AbjKJS2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:28:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A413823C;
        Fri, 10 Nov 2023 06:00:07 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED02BC433C9;
        Fri, 10 Nov 2023 14:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699624807;
        bh=oMeh6qi9NkIYEX9Oc5xp0KImOwQTN6cJNVNjnXiHJBw=;
        h=From:To:Cc:Subject:Date:From;
        b=HTBG+oLN9zVThQFLQVxwNufPbYEkxZtFEjpTPtBS9/tkhjnc1/sMO8H33q3gEZc2z
         ciQFJIWnHp3XSsgcL4/7N2z8X183ROHixIJHfdNXVuuuGZNBFmxR/cKPqYhHKYIj0t
         anz0aDtgcZRPN0aMRIhmuPl3OI9JELZOL3kRe8X3x1jh67GaJRfs0cb+380NNfDOF9
         ltdUjQ5z57A9tEhhK6h5sfpyqC1yD+gqWmM2+lDTnzcs/HG6e0O0iQsWiBW+6zA+N2
         Aye8NMeHByh+LQpKhm6DJhd7Uy/z7lHsZOqIlx4yBojflvgnoAVADwxZ4Xu4CviB49
         nj8sKFmqSuycQ==
Message-ID: <37bfc2b52cdf44300d906fc69084bc29.broonie@kernel.org>
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v6.7-merge-window
Date:   Fri, 10 Nov 2023 13:59:58 +0000
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 75223bbea840e125359fc63942b5f93462b474c6:

  spi: omap2-mcspi: Add FIFO support without DMA (2023-10-23 13:30:05 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.7-merge-window

for you to fetch changes up to bef4a48f4ef798c4feddf045d49e53c8a97d5e37:

  spi: Fix null dereference on suspend (2023-11-10 13:54:58 +0000)

----------------------------------------------------------------
spi: Fixes for v6.7

A couple of fixes that came in during the merge window, one Kconfig
dependency fix and another fix for a long standing issue where in the
case where a sync transfer races with system suspend.

----------------------------------------------------------------
Amit Kumar Mahapatra (1):
      spi: spi-zynq-qspi: add spi-mem to driver kconfig dependencies

Mark Hasemeyer (1):
      spi: Fix null dereference on suspend

 drivers/spi/Kconfig     |  1 +
 drivers/spi/spi.c       | 56 ++++++++++++++++++++++++++++++++++---------------
 include/linux/spi/spi.h |  1 +
 3 files changed, 41 insertions(+), 17 deletions(-)
