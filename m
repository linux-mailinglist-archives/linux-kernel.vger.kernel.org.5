Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFDFD75AB5D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 11:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbjGTJsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 05:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbjGTJsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 05:48:03 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF1935A0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 02:46:16 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R679d3hSJzBRDsT
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 17:46:13 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689846373; x=1692438374; bh=o9JOFlbGVJvu3Fw63HuzTzQdpgV
        xk3SPDUv4pVrDud4=; b=JlvLy+pWgQ5Gr9vKbQDlNZRn/hB5VaS+RHv37e1AXLJ
        xNkgC+E/D0I10GVWRCOGIH5vt5vxZYU3j9aZqlrDwcNNtYfBJ2ZMGt0aBuP0tyba
        5WhQcj6ALdjV1gZjFuBuctkG8TQCb12jmyceBuPOlMTEcs47X5FtDpWsGqf5Fg4D
        T+H7cVxOqafI9lV6rnkXx2pzz83amYnaFwSFehzLA8sAQpylV3tU1sxZksKZyhS7
        SLv76x9Ncbce1m7VEL2hTs++xZWMcfWboMYhOgpk4dmRuuwPYmsoiYVDDA+fiaeY
        SQB9VS9CaHYfue5TBNB9mV9OapXMI4m5NH+fsft82ng==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id yRyOVIrC-sIC for <linux-kernel@vger.kernel.org>;
        Thu, 20 Jul 2023 17:46:13 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R679d1YldzBRDrZ;
        Thu, 20 Jul 2023 17:46:13 +0800 (CST)
MIME-Version: 1.0
Date:   Thu, 20 Jul 2023 17:46:13 +0800
From:   sunran001@208suo.com
To:     hare@suse.com, jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: aic7xxx: fix the following errors
In-Reply-To: <20230720094503.3863-1-xujianghui@cdjrlc.com>
References: <20230720094503.3863-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <24ac6e965ee9dc4be3fd2f1932ba33f7@208suo.com>
X-Sender: sunran001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ERROR: "foo * bar" should be "foo *bar"
ERROR: return is not a function, parentheses are not required
ERROR: open brace '{' following function definitions go on the next line

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
  drivers/scsi/aic7xxx/aic7xxx_osm.h | 47 +++++++++++++++---------------
  1 file changed, 23 insertions(+), 24 deletions(-)

diff --git a/drivers/scsi/aic7xxx/aic7xxx_osm.h 
b/drivers/scsi/aic7xxx/aic7xxx_osm.h
index 51d9f4de0734..ad63b6cda3b7 100644
--- a/drivers/scsi/aic7xxx/aic7xxx_osm.h
+++ b/drivers/scsi/aic7xxx/aic7xxx_osm.h
@@ -140,19 +140,17 @@ typedef union {
  	volatile uint8_t __iomem *maddr;
  } bus_space_handle_t;

-typedef struct bus_dma_segment
-{
+typedef struct bus_dma_segment {
  	dma_addr_t	ds_addr;
  	bus_size_t	ds_len;
  } bus_dma_segment_t;

-struct ahc_linux_dma_tag
-{
+struct ahc_linux_dma_tag {
  	bus_size_t	alignment;
  	bus_size_t	boundary;
  	bus_size_t	maxsize;
  };
-typedef struct ahc_linux_dma_tag* bus_dma_tag_t;
+typedef struct ahc_linux_dma_tag *bus_dma_tag_t;

  typedef dma_addr_t bus_dmamap_t;

@@ -367,11 +365,11 @@ void ahc_delay(long);


  /***************************** Low Level I/O 
**********************************/
-uint8_t ahc_inb(struct ahc_softc * ahc, long port);
-void ahc_outb(struct ahc_softc * ahc, long port, uint8_t val);
-void ahc_outsb(struct ahc_softc * ahc, long port,
+uint8_t ahc_inb(struct ahc_softc *ahc, long port);
+void ahc_outb(struct ahc_softc *ahc, long port, uint8_t val);
+void ahc_outsb(struct ahc_softc *ahc, long port,
  	       uint8_t *, int count);
-void ahc_insb(struct ahc_softc * ahc, long port,
+void ahc_insb(struct ahc_softc *ahc, long port,
  	       uint8_t *, int count);

  /**************************** Initialization 
**********************************/
@@ -434,8 +432,7 @@ ahc_unlock(struct ahc_softc *ahc, unsigned long 
*flags)
  /* config registers for header type 0 devices */
  #define PCIR_MAPS	0x10

-typedef enum
-{
+typedef enum {
  	AHC_POWER_STATE_D0,
  	AHC_POWER_STATE_D1,
  	AHC_POWER_STATE_D2,
@@ -450,10 +447,12 @@ int			 aic7770_map_registers(struct ahc_softc 
*ahc,
  					       u_int port);
  int			 aic7770_map_int(struct ahc_softc *ahc, u_int irq);
  #else
-static inline int	ahc_linux_eisa_init(void) {
+static inline int	ahc_linux_eisa_init(void)
+{
  	return -ENODEV;
  }
-static inline void	ahc_linux_eisa_exit(void) {
+static inline void	ahc_linux_eisa_exit(void)
+{
  }
  #endif

@@ -475,21 +474,21 @@ static inline int 
ahc_get_pci_function(ahc_dev_softc_t);
  static inline int
  ahc_get_pci_function(ahc_dev_softc_t pci)
  {
-	return (PCI_FUNC(pci->devfn));
+	return PCI_FUNC(pci->devfn);
  }

  static inline int ahc_get_pci_slot(ahc_dev_softc_t);
  static inline int
  ahc_get_pci_slot(ahc_dev_softc_t pci)
  {
-	return (PCI_SLOT(pci->devfn));
+	return PCI_SLOT(pci->devfn);
  }

  static inline int ahc_get_pci_bus(ahc_dev_softc_t);
  static inline int
  ahc_get_pci_bus(ahc_dev_softc_t pci)
  {
-	return (pci->bus->number);
+	return pci->bus->number;
  }
  #else
  static inline int ahc_linux_pci_init(void) {
@@ -524,7 +523,7 @@ void ahc_cmd_set_transaction_status(struct scsi_cmnd 
*cmd, uint32_t status)
  static inline
  void ahc_set_transaction_status(struct scb *scb, uint32_t status)
  {
-	ahc_cmd_set_transaction_status(scb->io_ctx,status);
+	ahc_cmd_set_transaction_status(scb->io_ctx, status);
  }

  static inline
@@ -549,7 +548,7 @@ uint32_t ahc_cmd_get_transaction_status(struct 
scsi_cmnd *cmd)
  static inline
  uint32_t ahc_get_transaction_status(struct scb *scb)
  {
-	return (ahc_cmd_get_transaction_status(scb->io_ctx));
+	return ahc_cmd_get_transaction_status(scb->io_ctx);
  }

  static inline
@@ -561,7 +560,7 @@ uint32_t ahc_cmd_get_scsi_status(struct scsi_cmnd 
*cmd)
  static inline
  uint32_t ahc_get_scsi_status(struct scb *scb)
  {
-	return (ahc_cmd_get_scsi_status(scb->io_ctx));
+	return ahc_cmd_get_scsi_status(scb->io_ctx);
  }

  static inline
@@ -576,13 +575,13 @@ void ahc_set_transaction_tag(struct scb *scb, int 
enabled, u_int type)
  static inline
  u_long ahc_get_transfer_length(struct scb *scb)
  {
-	return (scb->platform_data->xfer_len);
+	return scb->platform_data->xfer_len;
  }

  static inline
  int ahc_get_transfer_dir(struct scb *scb)
  {
-	return (scb->io_ctx->sc_data_direction);
+	return scb->io_ctx->sc_data_direction;
  }

  static inline
@@ -606,7 +605,7 @@ u_long ahc_get_residual(struct scb *scb)
  static inline
  u_long ahc_get_sense_residual(struct scb *scb)
  {
-	return (scb->platform_data->sense_resid);
+	return scb->platform_data->sense_resid;
  }

  static inline
@@ -617,13 +616,13 @@ int ahc_perform_autosense(struct scb *scb)
  	 * On other platforms this is set on a
  	 * per-transaction basis.
  	 */
-	return (1);
+	return 1;
  }

  static inline uint32_t
  ahc_get_sense_bufsize(struct ahc_softc *ahc, struct scb *scb)
  {
-	return (sizeof(struct scsi_sense_data));
+	return sizeof(struct scsi_sense_data);
  }

  static inline void
