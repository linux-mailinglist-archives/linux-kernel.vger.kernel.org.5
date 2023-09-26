Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40647AE526
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 07:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233669AbjIZFkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 01:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjIZFkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 01:40:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D11DD7;
        Mon, 25 Sep 2023 22:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=yJdqhIQUoxN3D+nrxuHC+beu2HfHdtlmGmJ8QrD3jjA=; b=3C72IN311QgUJmOTBwHef3jvHz
        D/6BWxPdut/DNXGkeSlXZ5ZFTHHaghz591pozsAi89KC69RMYc7+wQXZU91pjgzzaBq9R6v93Q8og
        8Lv5oamM4/cnxE7dg9deHjEazP0epHw3nQU2fYD12B0jaKPR1AT33Y7BiEqtERsNluYAteFHPkERK
        PggJVW3Ok6D6beS2/uN+UKelEhbYBlZWvTVMKJi7BiDavEObfvWSvlamr+SpfjSXV9ykd/w6XXEmJ
        OdQ0JrKMnY2DotAehJVemHy37Fb3eiPPD1uzq9KZKaID2gP+tQ/AgB5yOLpRyJ9/FM0Hp/Q38N45M
        oIrtqaKQ==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1ql0nu-00FdT0-0M;
        Tue, 26 Sep 2023 05:40:14 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Liming Sun <lsun@mellanox.com>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        Vadim Pasternak <vadimp@nvidia.com>,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH] platform/mellanox: tmfifo: fix kernel-doc warnings
Date:   Mon, 25 Sep 2023 22:40:11 -0700
Message-ID: <20230926054013.11450-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix kernel-doc notation for structs and struct members to prevent
these warnings:

mlxbf-tmfifo.c:73: warning: cannot understand function prototype: 'struct mlxbf_tmfifo_vring '
mlxbf-tmfifo.c:128: warning: cannot understand function prototype: 'struct mlxbf_tmfifo_vdev '
mlxbf-tmfifo.c:146: warning: cannot understand function prototype: 'struct mlxbf_tmfifo_irq_info '
mlxbf-tmfifo.c:158: warning: cannot understand function prototype: 'struct mlxbf_tmfifo_io '
mlxbf-tmfifo.c:182: warning: cannot understand function prototype: 'struct mlxbf_tmfifo '
mlxbf-tmfifo.c:208: warning: cannot understand function prototype: 'struct mlxbf_tmfifo_msg_hdr '
mlxbf-tmfifo.c:138: warning: Function parameter or member 'config' not described in 'mlxbf_tmfifo_vdev'
mlxbf-tmfifo.c:212: warning: Function parameter or member 'unused' not described in 'mlxbf_tmfifo_msg_hdr'

Fixes: 1357dfd7261f ("platform/mellanox: Add TmFifo driver for Mellanox BlueField Soc")
Fixes: bc05ea63b394 ("platform/mellanox: Add BlueField-3 support in the tmfifo driver")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Closes: lore.kernel.org/r/202309252330.saRU491h-lkp@intel.com
Cc: Liming Sun <lsun@mellanox.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Cc: Mark Gross <markgross@kernel.org>
Cc: Vadim Pasternak <vadimp@nvidia.com>
Cc: platform-driver-x86@vger.kernel.org
---
 drivers/platform/mellanox/mlxbf-tmfifo.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff -- a/drivers/platform/mellanox/mlxbf-tmfifo.c b/drivers/platform/mellanox/mlxbf-tmfifo.c
--- a/drivers/platform/mellanox/mlxbf-tmfifo.c
+++ b/drivers/platform/mellanox/mlxbf-tmfifo.c
@@ -53,7 +53,7 @@
 struct mlxbf_tmfifo;
 
 /**
- * mlxbf_tmfifo_vring - Structure of the TmFifo virtual ring
+ * struct mlxbf_tmfifo_vring - Structure of the TmFifo virtual ring
  * @va: virtual address of the ring
  * @dma: dma address of the ring
  * @vq: pointer to the virtio virtqueue
@@ -113,12 +113,13 @@ enum {
 };
 
 /**
- * mlxbf_tmfifo_vdev - Structure of the TmFifo virtual device
+ * struct mlxbf_tmfifo_vdev - Structure of the TmFifo virtual device
  * @vdev: virtio device, in which the vdev.id.device field has the
  *        VIRTIO_ID_xxx id to distinguish the virtual device.
  * @status: status of the device
  * @features: supported features of the device
  * @vrings: array of tmfifo vrings of this device
+ * @config: non-anonymous union for cons and net
  * @config.cons: virtual console config -
  *               select if vdev.id.device is VIRTIO_ID_CONSOLE
  * @config.net: virtual network config -
@@ -138,7 +139,7 @@ struct mlxbf_tmfifo_vdev {
 };
 
 /**
- * mlxbf_tmfifo_irq_info - Structure of the interrupt information
+ * struct mlxbf_tmfifo_irq_info - Structure of the interrupt information
  * @fifo: pointer to the tmfifo structure
  * @irq: interrupt number
  * @index: index into the interrupt array
@@ -150,7 +151,7 @@ struct mlxbf_tmfifo_irq_info {
 };
 
 /**
- * mlxbf_tmfifo_io - Structure of the TmFifo IO resource (for both rx & tx)
+ * struct mlxbf_tmfifo_io - Structure of the TmFifo IO resource (for both rx & tx)
  * @ctl: control register offset (TMFIFO_RX_CTL / TMFIFO_TX_CTL)
  * @sts: status register offset (TMFIFO_RX_STS / TMFIFO_TX_STS)
  * @data: data register offset (TMFIFO_RX_DATA / TMFIFO_TX_DATA)
@@ -162,7 +163,7 @@ struct mlxbf_tmfifo_io {
 };
 
 /**
- * mlxbf_tmfifo - Structure of the TmFifo
+ * struct mlxbf_tmfifo - Structure of the TmFifo
  * @vdev: array of the virtual devices running over the TmFifo
  * @lock: lock to protect the TmFifo access
  * @res0: mapped resource block 0
@@ -198,7 +199,7 @@ struct mlxbf_tmfifo {
 };
 
 /**
- * mlxbf_tmfifo_msg_hdr - Structure of the TmFifo message header
+ * struct mlxbf_tmfifo_msg_hdr - Structure of the TmFifo message header
  * @type: message type
  * @len: payload length in network byte order. Messages sent into the FIFO
  *       will be read by the other side as data stream in the same byte order.
@@ -208,6 +209,7 @@ struct mlxbf_tmfifo {
 struct mlxbf_tmfifo_msg_hdr {
 	u8 type;
 	__be16 len;
+	/* private: */
 	u8 unused[5];
 } __packed __aligned(sizeof(u64));
 
