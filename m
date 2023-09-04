Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91626791AE1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 17:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235951AbjIDPw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 11:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbjIDPw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 11:52:57 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7521AD;
        Mon,  4 Sep 2023 08:52:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id BD8F9CE0E0E;
        Mon,  4 Sep 2023 15:52:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C131C433C9;
        Mon,  4 Sep 2023 15:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693842771;
        bh=JVRNwKbFCeOWyBqO1LRF0ojfF/loYJpcFFsme3qrtr8=;
        h=From:To:Cc:Subject:Date:From;
        b=OQlU4y/mBaCwrqrD2n/6o1UC0KeD6Q94Ldv3G54RVUHi+jOav4jolRbXNX7hoTxII
         MUgcw9NC6Qdftcn7/J7oDUhANMLqyp2929NqAlZcQTlUq4CIKHjIfGO4xuGzNfI7fX
         RmQ6foOh4jAU9WjAOWX/X45tWmfVT4I2BxJbStRg1DFM8oiG9fCEqNwiJf7dE/efYg
         8zn4PmVBlaEYXxakiEyHHxUUBK3PDHn2fGqhFAkOFA6kf39vsrODe+N/MPYUqG7rMl
         lF/1xDNKa/PzOHkdj2SWsIAxZfF8gCFTf8h1YaFSyircV+KxTOhhFxaIqnKuGkkMCm
         Dfz7EdMHu3M8g==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Kang Chen <void0red@gmail.com>
Subject: [GIT PULL] hwspinlock updates for v6.6
Date:   Mon,  4 Sep 2023 08:55:06 -0700
Message-ID: <20230904155508.2950832-1-andersson@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git tags/hwlock-v6.6

for you to fetch changes up to 23316be8a9d450f33a21f1efe7d89570becbec58:

  hwspinlock: qcom: add missing regmap config for SFPB MMIO implementation (2023-07-17 11:49:18 -0700)

----------------------------------------------------------------
hwspinlock updates for v6.6

Convert u8500 and omap drivers to void-returning remove.

Complete the support for representing the Qualcomm TCSR mutex as a mmio
device, and check the return value of devm_regmap_field_alloc() in the
same.

----------------------------------------------------------------
Christian Marangi (1):
      hwspinlock: qcom: add missing regmap config for SFPB MMIO implementation

Kang Chen (1):
      hwspinlock: add a check of devm_regmap_field_alloc in qcom_hwspinlock_probe

Uwe Kleine-König (3):
      hwspinlock: omap: Emit only one error message for errors in .remove()
      hwspinlock: omap: Convert to platform remove callback returning void
      hwspinlock: u8500: Convert to platform remove callback returning void

 drivers/hwspinlock/omap_hwspinlock.c |  8 +++-----
 drivers/hwspinlock/qcom_hwspinlock.c | 11 +++++++++++
 drivers/hwspinlock/u8500_hsem.c      |  6 ++----
 3 files changed, 16 insertions(+), 9 deletions(-)
