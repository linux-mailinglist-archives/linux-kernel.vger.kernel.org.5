Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02D8F761E34
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 18:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbjGYQPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 12:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbjGYQOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 12:14:34 -0400
Received: from rs227.mailgun.us (rs227.mailgun.us [209.61.151.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A6997
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 09:14:22 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=equiv.tech; q=dns/txt;
 s=mx; t=1690301661; x=1690308861; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Subject: Cc: To: To:
 From: From: Sender: Sender; bh=nqwyCOQOYr575hex+eybSMgo8/QkMTm6ArKAwAgxkb4=;
 b=YVTlzvI7Sy5u120hcyobHmvR2lpJ8Uu5N6bTSWnwyVVTolj1a5EfJsQQkX9dSeTvgRa6ygaoN1Zn+NXeTJXckEY2lpMtSfNvbDXdR23D3UVrYJfhfJC6rY5GQVB5oy1qr1wtCWZn0A3YF+3BpIo/knGzFHbL9PNzeAOsC0Wur+fmeKCEmmki8U59sOB3rXtLSg2Mfm8LAroiaKK4Ram8bqJ18XfZ5fa3xVoarnjK+N+aqR3mO8e8ubU7mi7gaO/CG8LkwiVOb8XXj0rO7c0gDRO0tGY//U3LK5OIrKtwuw4YZy64H72vj6kFF4te9VGdqJcPSaHgZTE+V+lqbZe2fQ==
X-Mailgun-Sending-Ip: 209.61.151.227
X-Mailgun-Sid: WyI4ZWI3MiIsImxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmciLCI5M2Q1YWIiXQ==
Received: from mail.equiv.tech (equiv.tech [142.93.28.83]) by 54514c3285a0 with SMTP id
 64bff4dd6f49ebc4e506d624 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 25 Jul 2023 16:14:21 GMT
Sender: james@equiv.tech
From:   James Seo <james@equiv.tech>
To:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>
Cc:     James Seo <james@equiv.tech>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] scsi: mpt3sas: Fix typo of "TRIGGER"
Date:   Tue, 25 Jul 2023 09:13:30 -0700
Message-Id: <20230725161331.27481-6-james@equiv.tech>
In-Reply-To: <20230725161331.27481-1-james@equiv.tech>
References: <20230725161331.27481-1-james@equiv.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change "TIGGER" to "TRIGGER" in struct names and typedefs.

Signed-off-by: James Seo <james@equiv.tech>
---
 drivers/scsi/mpt3sas/mpt3sas_base.c          |  6 +--
 drivers/scsi/mpt3sas/mpt3sas_config.c        |  6 +--
 drivers/scsi/mpt3sas/mpt3sas_trigger_pages.h | 44 ++++++++++----------
 3 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index 2ae0185938f3..cd6f36094159 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -5026,7 +5026,7 @@ _base_get_event_diag_triggers(struct MPT3SAS_ADAPTER *ioc)
 {
 	Mpi26DriverTriggerPage2_t trigger_pg2;
 	struct SL_WH_EVENT_TRIGGER_T *event_tg;
-	MPI26_DRIVER_MPI_EVENT_TIGGER_ENTRY *mpi_event_tg;
+	MPI26_DRIVER_MPI_EVENT_TRIGGER_ENTRY *mpi_event_tg;
 	Mpi2ConfigReply_t mpi_reply;
 	int r = 0, i = 0;
 	u16 count = 0;
@@ -5078,7 +5078,7 @@ _base_get_scsi_diag_triggers(struct MPT3SAS_ADAPTER *ioc)
 {
 	Mpi26DriverTriggerPage3_t trigger_pg3;
 	struct SL_WH_SCSI_TRIGGER_T *scsi_tg;
-	MPI26_DRIVER_SCSI_SENSE_TIGGER_ENTRY *mpi_scsi_tg;
+	MPI26_DRIVER_SCSI_SENSE_TRIGGER_ENTRY *mpi_scsi_tg;
 	Mpi2ConfigReply_t mpi_reply;
 	int r = 0, i = 0;
 	u16 count = 0;
@@ -5130,7 +5130,7 @@ _base_get_mpi_diag_triggers(struct MPT3SAS_ADAPTER *ioc)
 {
 	Mpi26DriverTriggerPage4_t trigger_pg4;
 	struct SL_WH_MPI_TRIGGER_T *status_tg;
-	MPI26_DRIVER_IOCSTATUS_LOGINFO_TIGGER_ENTRY *mpi_status_tg;
+	MPI26_DRIVER_IOCSTATUS_LOGINFO_TRIGGER_ENTRY *mpi_status_tg;
 	Mpi2ConfigReply_t mpi_reply;
 	int r = 0, i = 0;
 	u16 count = 0;
diff --git a/drivers/scsi/mpt3sas/mpt3sas_config.c b/drivers/scsi/mpt3sas/mpt3sas_config.c
index d114ef381c44..2e88f456fc34 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_config.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_config.c
@@ -2334,7 +2334,7 @@ mpt3sas_config_update_driver_trigger_pg2(struct MPT3SAS_ADAPTER *ioc,
 		tg_pg2.NumMPIEventTrigger = 0;
 		memset(&tg_pg2.MPIEventTriggers[0], 0,
 		    NUM_VALID_ENTRIES * sizeof(
-		    MPI26_DRIVER_MPI_EVENT_TIGGER_ENTRY));
+		    MPI26_DRIVER_MPI_EVENT_TRIGGER_ENTRY));
 	}
 
 	rc = _config_set_driver_trigger_pg2(ioc, &mpi_reply, &tg_pg2);
@@ -2493,7 +2493,7 @@ mpt3sas_config_update_driver_trigger_pg3(struct MPT3SAS_ADAPTER *ioc,
 		tg_pg3.NumSCSISenseTrigger = 0;
 		memset(&tg_pg3.SCSISenseTriggers[0], 0,
 		    NUM_VALID_ENTRIES * sizeof(
-		    MPI26_DRIVER_SCSI_SENSE_TIGGER_ENTRY));
+		    MPI26_DRIVER_SCSI_SENSE_TRIGGER_ENTRY));
 	}
 
 	rc = _config_set_driver_trigger_pg3(ioc, &mpi_reply, &tg_pg3);
@@ -2649,7 +2649,7 @@ mpt3sas_config_update_driver_trigger_pg4(struct MPT3SAS_ADAPTER *ioc,
 		tg_pg4.NumIOCStatusLogInfoTrigger = 0;
 		memset(&tg_pg4.IOCStatusLoginfoTriggers[0], 0,
 		    NUM_VALID_ENTRIES * sizeof(
-		    MPI26_DRIVER_IOCSTATUS_LOGINFO_TIGGER_ENTRY));
+		    MPI26_DRIVER_IOCSTATUS_LOGINFO_TRIGGER_ENTRY));
 	}
 
 	rc = _config_set_driver_trigger_pg4(ioc, &mpi_reply, &tg_pg4);
diff --git a/drivers/scsi/mpt3sas/mpt3sas_trigger_pages.h b/drivers/scsi/mpt3sas/mpt3sas_trigger_pages.h
index 5f3328f011a2..edb8fe709089 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_trigger_pages.h
+++ b/drivers/scsi/mpt3sas/mpt3sas_trigger_pages.h
@@ -20,12 +20,12 @@
 
 #define MPI2_CONFIG_EXTPAGETYPE_DRIVER_PERSISTENT_TRIGGER    (0xE0)
 #define MPI26_DRIVER_TRIGGER_PAGE0_PAGEVERSION               (0x01)
-typedef struct _MPI26_CONFIG_PAGE_DRIVER_TIGGER_0 {
+typedef struct _MPI26_CONFIG_PAGE_DRIVER_TRIGGER_0 {
 	MPI2_CONFIG_EXTENDED_PAGE_HEADER	Header;	/* 0x00  */
 	U16	TriggerFlags;		/* 0x08  */
 	U16	Reserved0xA;		/* 0x0A */
 	U32	Reserved0xC[61];	/* 0x0C */
-} _MPI26_CONFIG_PAGE_DRIVER_TIGGER_0, Mpi26DriverTriggerPage0_t;
+} _MPI26_CONFIG_PAGE_DRIVER_TRIGGER_0, Mpi26DriverTriggerPage0_t;
 
 /* Trigger Flags */
 #define  MPI26_DRIVER_TRIGGER0_FLAG_MASTER_TRIGGER_VALID       (0x0001)
@@ -34,61 +34,61 @@ typedef struct _MPI26_CONFIG_PAGE_DRIVER_TIGGER_0 {
 #define  MPI26_DRIVER_TRIGGER0_FLAG_LOGINFO_TRIGGER_VALID      (0x0008)
 
 #define MPI26_DRIVER_TRIGGER_PAGE1_PAGEVERSION               (0x01)
-typedef struct _MPI26_DRIVER_MASTER_TIGGER_ENTRY {
+typedef struct _MPI26_DRIVER_MASTER_TRIGGER_ENTRY {
 	U32	MasterTriggerFlags;
-} MPI26_DRIVER_MASTER_TIGGER_ENTRY;
+} MPI26_DRIVER_MASTER_TRIGGER_ENTRY;
 
 #define MPI26_MAX_MASTER_TRIGGERS                                   (1)
-typedef struct _MPI26_CONFIG_PAGE_DRIVER_TIGGER_1 {
+typedef struct _MPI26_CONFIG_PAGE_DRIVER_TRIGGER_1 {
 	MPI2_CONFIG_EXTENDED_PAGE_HEADER	Header;	/* 0x00 */
 	U16	NumMasterTrigger;	/* 0x08 */
 	U16	Reserved0xA;		/* 0x0A */
-	MPI26_DRIVER_MASTER_TIGGER_ENTRY MasterTriggers[MPI26_MAX_MASTER_TRIGGERS];	/* 0x0C */
-} MPI26_CONFIG_PAGE_DRIVER_TIGGER_1, Mpi26DriverTriggerPage1_t;
+	MPI26_DRIVER_MASTER_TRIGGER_ENTRY MasterTriggers[MPI26_MAX_MASTER_TRIGGERS];	/* 0x0C */
+} MPI26_CONFIG_PAGE_DRIVER_TRIGGER_1, Mpi26DriverTriggerPage1_t;
 
 #define MPI26_DRIVER_TRIGGER_PAGE2_PAGEVERSION               (0x01)
-typedef struct _MPI26_DRIVER_MPI_EVENT_TIGGER_ENTRY {
+typedef struct _MPI26_DRIVER_MPI_EVENT_TRIGGER_ENTRY {
 	U16	MPIEventCode;		/* 0x00 */
 	U16	MPIEventCodeSpecific;	/* 0x02 */
-} MPI26_DRIVER_MPI_EVENT_TIGGER_ENTRY;
+} MPI26_DRIVER_MPI_EVENT_TRIGGER_ENTRY;
 
 #define MPI26_MAX_MPI_EVENT_TRIGGERS                            (20)
-typedef struct _MPI26_CONFIG_PAGE_DRIVER_TIGGER_2 {
+typedef struct _MPI26_CONFIG_PAGE_DRIVER_TRIGGER_2 {
 	MPI2_CONFIG_EXTENDED_PAGE_HEADER        Header;	/* 0x00  */
 	U16	NumMPIEventTrigger;     /* 0x08  */
 	U16	Reserved0xA;		/* 0x0A */
-	MPI26_DRIVER_MPI_EVENT_TIGGER_ENTRY MPIEventTriggers[MPI26_MAX_MPI_EVENT_TRIGGERS]; /* 0x0C */
-} MPI26_CONFIG_PAGE_DRIVER_TIGGER_2, Mpi26DriverTriggerPage2_t;
+	MPI26_DRIVER_MPI_EVENT_TRIGGER_ENTRY MPIEventTriggers[MPI26_MAX_MPI_EVENT_TRIGGERS]; /* 0x0C */
+} MPI26_CONFIG_PAGE_DRIVER_TRIGGER_2, Mpi26DriverTriggerPage2_t;
 
 #define MPI26_DRIVER_TRIGGER_PAGE3_PAGEVERSION               (0x01)
-typedef struct _MPI26_DRIVER_SCSI_SENSE_TIGGER_ENTRY {
+typedef struct _MPI26_DRIVER_SCSI_SENSE_TRIGGER_ENTRY {
 	U8     ASCQ;		/* 0x00 */
 	U8     ASC;		/* 0x01 */
 	U8     SenseKey;	/* 0x02 */
 	U8     Reserved;	/* 0x03 */
-} MPI26_DRIVER_SCSI_SENSE_TIGGER_ENTRY;
+} MPI26_DRIVER_SCSI_SENSE_TRIGGER_ENTRY;
 
 #define MPI26_MAX_SCSI_SENSE_TRIGGERS                            (20)
-typedef struct _MPI26_CONFIG_PAGE_DRIVER_TIGGER_3 {
+typedef struct _MPI26_CONFIG_PAGE_DRIVER_TRIGGER_3 {
 	MPI2_CONFIG_EXTENDED_PAGE_HEADER	Header;	/* 0x00  */
 	U16	NumSCSISenseTrigger;			/* 0x08  */
 	U16	Reserved0xA;				/* 0x0A */
-	MPI26_DRIVER_SCSI_SENSE_TIGGER_ENTRY SCSISenseTriggers[MPI26_MAX_SCSI_SENSE_TRIGGERS];	/* 0x0C */
-} MPI26_CONFIG_PAGE_DRIVER_TIGGER_3, Mpi26DriverTriggerPage3_t;
+	MPI26_DRIVER_SCSI_SENSE_TRIGGER_ENTRY SCSISenseTriggers[MPI26_MAX_SCSI_SENSE_TRIGGERS];	/* 0x0C */
+} MPI26_CONFIG_PAGE_DRIVER_TRIGGER_3, Mpi26DriverTriggerPage3_t;
 
 #define MPI26_DRIVER_TRIGGER_PAGE4_PAGEVERSION               (0x01)
-typedef struct _MPI26_DRIVER_IOCSTATUS_LOGINFO_TIGGER_ENTRY {
+typedef struct _MPI26_DRIVER_IOCSTATUS_LOGINFO_TRIGGER_ENTRY {
 	U16        IOCStatus;      /* 0x00 */
 	U16        Reserved;       /* 0x02 */
 	U32        LogInfo;        /* 0x04 */
-} MPI26_DRIVER_IOCSTATUS_LOGINFO_TIGGER_ENTRY;
+} MPI26_DRIVER_IOCSTATUS_LOGINFO_TRIGGER_ENTRY;
 
 #define MPI26_MAX_LOGINFO_TRIGGERS                            (20)
-typedef struct _MPI26_CONFIG_PAGE_DRIVER_TIGGER_4 {
+typedef struct _MPI26_CONFIG_PAGE_DRIVER_TRIGGER_4 {
 	MPI2_CONFIG_EXTENDED_PAGE_HEADER	Header;	/* 0x00  */
 	U16	NumIOCStatusLogInfoTrigger;		/* 0x08  */
 	U16	Reserved0xA;				/* 0x0A */
-	MPI26_DRIVER_IOCSTATUS_LOGINFO_TIGGER_ENTRY IOCStatusLoginfoTriggers[MPI26_MAX_LOGINFO_TRIGGERS];	/* 0x0C */
-} MPI26_CONFIG_PAGE_DRIVER_TIGGER_4, Mpi26DriverTriggerPage4_t;
+	MPI26_DRIVER_IOCSTATUS_LOGINFO_TRIGGER_ENTRY IOCStatusLoginfoTriggers[MPI26_MAX_LOGINFO_TRIGGERS];	/* 0x0C */
+} MPI26_CONFIG_PAGE_DRIVER_TRIGGER_4, Mpi26DriverTriggerPage4_t;
 
 #endif
-- 
2.39.2

