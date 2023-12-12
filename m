Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4607180E84A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 10:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbjLLJzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 04:55:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346090AbjLLJzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 04:55:13 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69EA8A6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 01:55:19 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 248EEFF80E;
        Tue, 12 Dec 2023 09:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1702374917;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=7Tn5wI5gn7nTh88+WLO90/5fJEgKDZovksmyxdBex+M=;
        b=lNPBgXlEBBxvyLStrOohMkAtT29dJrMtq+lZMOqrhvg69uOtsqRerGTnZNDwynbjT4b9yh
        ZPr+DBtF6O4T85TehwSsXqqaWJH17me2lz3Wp8dcCNvbStqBu43oWeQhKxuCMtCXaSUzUH
        nm7oMFhY2IL9PD8ZIL/nUQUifxsplmO7RIRiJITyIBJ0832xor2ad1tjrXAmE/8b7i1Z61
        62Rx1nzwdxeqEulH5l8FtALNNI7PyO+sMng0RZzMAw5OKUu8JrDgMbnjbeWkB0WZkPB0U3
        FPXf2t34U7+HSVuEZjjGQp/nQM0Zek7+jsTyf7hhmKGGfx9n/ND3bYCCSvdGdg==
Date:   Tue, 12 Dec 2023 10:55:14 +0100
From:   Herve Codina <herve.codina@bootlin.com>
To:     soc <soc@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Qiang Zhao <qiang.zhao@nxp.com>,
        Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] PowerQUICC QMC and TSA drivers updates for v6.8
Message-ID: <20231212105514.273e8ab0@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 2cc14f52aeb78ce3f29677c2de1f06c0e91471ab:

  Linux 6.7-rc3 (2023-11-26 19:59:33 -0800)

are available in the Git repository at:

  git@github.com:hcodina/linux.git tags/fsl_qmc_tsa_v6.8

for you to fetch changes up to 7a2ee1576dcc6bbe017a8283fba237b05b13fd15:

  soc: fsl: cpm1: qmc: Introduce functions to change timeslots at runtime (2023-12-12 10:29:20 +0100)

----------------------------------------------------------------
PowerQUICC QMC and TSA drivers updates for v6.8

This pull request contains updates to prepare the support for the QMC
HDLC driver.
        - Perform some fixes
        - Add support for child devices
        - Add QMC dynamic timeslot support

Signed-off-by: Herve Codina <herve.codina@bootlin.com>

----------------------------------------------------------------
Herve Codina (17):
      soc: fsl: cpm1: tsa: Fix __iomem addresses declaration
      soc: fsl: cpm1: qmc: Fix __iomem addresses declaration
      soc: fsl: cpm1: qmc: Fix rx channel reset
      soc: fsl: cpm1: qmc: Extend the API to provide Rx status
      soc: fsl: cpm1: qmc: Remove inline function specifiers
      soc: fsl: cpm1: qmc: Add support for child devices
      soc: fsl: cpm1: qmc: Introduce available timeslots masks
      soc: fsl: cpm1: qmc: Rename qmc_setup_tsa* to qmc_init_tsa*
      soc: fsl: cpm1: qmc: Introduce qmc_chan_setup_tsa*
      soc: fsl: cpm1: qmc: Remove no more needed checks from qmc_check_chans()
      soc: fsl: cpm1: qmc: Check available timeslots in qmc_check_chans()
      soc: fsl: cpm1: qmc: Add support for disabling channel TSA entries
      soc: fsl: cpm1: qmc: Split Tx and Rx TSA entries setup
      soc: fsl: cpm1: qmc: Introduce is_tsa_64rxtx flag
      soc: fsl: cpm1: qmc: Handle timeslot entries at channel start() and stop()
      soc: fsl: cpm1: qmc: Remove timeslots handling from setup_chan()
      soc: fsl: cpm1: qmc: Introduce functions to change timeslots at runtime

 drivers/soc/fsl/qe/qmc.c      | 658 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------------------
 drivers/soc/fsl/qe/tsa.c      |  22 ++--
 include/soc/fsl/qe/qmc.h      |  27 ++++-
 sound/soc/fsl/fsl_qmc_audio.c |   2 +-
 4 files changed, 538 insertions(+), 171 deletions(-)
