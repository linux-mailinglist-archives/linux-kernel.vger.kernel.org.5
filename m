Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB1D4769FD6
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 19:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbjGaRz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 13:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbjGaRzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 13:55:53 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B21EFDC
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 10:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1690826151;
        bh=N7oBQVHbk+LRqZMrHwW0uk572QClT1ILQBXJJgXIkGY=;
        h=Message-ID:Subject:From:To:Date:From;
        b=J8MMaWTPc2uqIFlv5RPreDzcJNied2wwLeV7Lz8u/0LLc0acy81mEySvNle/DSomQ
         o74dy/ICRsiUy0w0QNh9XZUTkoA0wePKB9C+oblcTV/rLKixn33/oox0DBJ98mxJoJ
         LUS4WaBQtma2weDle2bUdoSqaF5Fg10bWYM850nU=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 348701281269;
        Mon, 31 Jul 2023 13:55:51 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id JXCMhSUnutKp; Mon, 31 Jul 2023 13:55:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1690826150;
        bh=N7oBQVHbk+LRqZMrHwW0uk572QClT1ILQBXJJgXIkGY=;
        h=Message-ID:Subject:From:To:Date:From;
        b=i+6d9uzn9T+PmCf+kzjuHr4kde4o5dLfyN8zeA99FD0fz0yBxh8dUhGlwkvYkt48o
         mRamV8vcb29I3BpFbbQPepM/TgZDV6/bt5OOeLPtLETWQq5oCPx16MuMnladixnbS6
         PSc1tgoe3MrhR8X/GYolDVXXTh85E4S+RtmZp4Gs=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 8284312811B4;
        Mon, 31 Jul 2023 13:55:50 -0400 (EDT)
Message-ID: <1c724252a3ed052637853107dbe13b898f237c3f.camel@HansenPartnership.com>
Subject: [GIT PULL] SCSI fixes for 6.5-rc4
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Mon, 31 Jul 2023 13:55:48 -0400
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Three small fixes, all in drivers.

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

The short changelog is:

Michael Kelley (1):
      scsi: storvsc: Limit max_sectors for virtual Fibre Channel devices

Steffen Maier (1):
      scsi: zfcp: Defer fc_rport blocking until after ADISC response

Yang Yingliang (1):
      scsi: pm80xx: Fix error return code in pm8001_pci_probe()


And the diffstat:

 drivers/s390/scsi/zfcp_fc.c       | 6 +-----
 drivers/scsi/pm8001/pm8001_init.c | 3 ++-
 drivers/scsi/storvsc_drv.c        | 4 ++++
 3 files changed, 7 insertions(+), 6 deletions(-)

With full diff below.

James

---

diff --git a/drivers/s390/scsi/zfcp_fc.c b/drivers/s390/scsi/zfcp_fc.c
index f21307537829..4f0d0e55f0d4 100644
--- a/drivers/s390/scsi/zfcp_fc.c
+++ b/drivers/s390/scsi/zfcp_fc.c
@@ -534,8 +534,7 @@ static void zfcp_fc_adisc_handler(void *data)
 
 	/* re-init to undo drop from zfcp_fc_adisc() */
 	port->d_id = ntoh24(adisc_resp->adisc_port_id);
-	/* port is good, unblock rport without going through erp */
-	zfcp_scsi_schedule_rport_register(port);
+	/* port is still good, nothing to do */
  out:
 	atomic_andnot(ZFCP_STATUS_PORT_LINK_TEST, &port->status);
 	put_device(&port->dev);
@@ -595,9 +594,6 @@ void zfcp_fc_link_test_work(struct work_struct *work)
 	int retval;
 
 	set_worker_desc("zadisc%16llx", port->wwpn); /* < WORKER_DESC_LEN=24 */
-	get_device(&port->dev);
-	port->rport_task = RPORT_DEL;
-	zfcp_scsi_rport_work(&port->rport_work);
 
 	/* only issue one test command at one time per port */
 	if (atomic_read(&port->status) & ZFCP_STATUS_PORT_LINK_TEST)
diff --git a/drivers/scsi/pm8001/pm8001_init.c b/drivers/scsi/pm8001/pm8001_init.c
index 2e886c1d867d..4995e1ef4e0e 100644
--- a/drivers/scsi/pm8001/pm8001_init.c
+++ b/drivers/scsi/pm8001/pm8001_init.c
@@ -1181,7 +1181,8 @@ static int pm8001_pci_probe(struct pci_dev *pdev,
 		pm80xx_set_thermal_config(pm8001_ha);
 	}
 
-	if (pm8001_init_sas_add(pm8001_ha))
+	rc = pm8001_init_sas_add(pm8001_ha);
+	if (rc)
 		goto err_out_shost;
 	/* phy setting support for motherboard controller */
 	rc = pm8001_configure_phy_settings(pm8001_ha);
diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index 7f12d931fe7c..f2823218670a 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -366,6 +366,7 @@ static void storvsc_on_channel_callback(void *context);
 #define STORVSC_FC_MAX_LUNS_PER_TARGET			255
 #define STORVSC_FC_MAX_TARGETS				128
 #define STORVSC_FC_MAX_CHANNELS				8
+#define STORVSC_FC_MAX_XFER_SIZE			((u32)(512 * 1024))
 
 #define STORVSC_IDE_MAX_LUNS_PER_TARGET			64
 #define STORVSC_IDE_MAX_TARGETS				1
@@ -2006,6 +2007,9 @@ static int storvsc_probe(struct hv_device *device,
 	 * protecting it from any weird value.
 	 */
 	max_xfer_bytes = round_down(stor_device->max_transfer_bytes, HV_HYP_PAGE_SIZE);
+	if (is_fc)
+		max_xfer_bytes = min(max_xfer_bytes, STORVSC_FC_MAX_XFER_SIZE);
+
 	/* max_hw_sectors_kb */
 	host->max_sectors = max_xfer_bytes >> 9;
 	/*

