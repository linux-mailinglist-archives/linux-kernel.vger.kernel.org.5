Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D377AAD1F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 10:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232452AbjIVIvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 04:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbjIVIvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 04:51:04 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1107A9E
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 01:50:58 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6c0c675cb03so1202206a34.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 01:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=areca-com-tw.20230601.gappssmtp.com; s=20230601; t=1695372657; x=1695977457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:to:from:subject
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4PHuq9az2BT1J4pWkEun/rtdrnMbw7XWd/k1yzA5bKs=;
        b=eHwJ2MBXQIBf2KrzQ/K5Ra8l2VfkTb2t066zVHkVOiYb06r6CaiBMJrHJ2tcCAIHJN
         0iYeiL7UDA/khPsHH8PtayKi/vIj+E0gz+HUHaA8TIpEoMqSES3QTgjjKYxX0gX3qQg5
         tJTaMGdquSo1rIaibYG5cMg/udSFbNkBnzVzxCmg3ZeE2WhDHoKXTWfo9SigSSTwI4T7
         CqE/t7AHAN6vvYIcL9I6z5fU1gvvh83Q2NaSUJ/mhwqQzhBpNN9/83brGatmqnyt0JUj
         AJtYs/nNPKnAD9i/tJ+3GNsevCRuF+NBeZsF6P5TtxGG1dHgktIE36Q5yP4mUDRP284e
         C9LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695372657; x=1695977457;
        h=content-transfer-encoding:mime-version:date:to:from:subject
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4PHuq9az2BT1J4pWkEun/rtdrnMbw7XWd/k1yzA5bKs=;
        b=PQQQRyH+6BwZKrc5m1STjO0OlJOasYFrCNEeZH4M+PVyFNe15PLha+OvlAMl9T26+O
         rHf6vVrv+hgY9UEYNCQVaB2QUNO+K/tcNddGKiCfdQVYO00HX5FckL4RROaipfTmwQOp
         OYvgFV4vrffWVdDY1+lje4qEBmNfdMSazSNN4zQ0Fx9KUfNMdZgmCQfW6dq+7IdzTOKE
         d0SsJe7aXAUrlVk49xtAUWOtfvBH/9xOssMmpJlnlc5cEKyDJyBIOC1QK4tqK1r/R3jm
         H6nSPPSSIyd1XlUFa14k1VReEazln75SYt6LyGxtHDDFjmt33BPHNLWWMyNSBa8tONVl
         MidQ==
X-Gm-Message-State: AOJu0Ywg7Yqb97r5eMfOBat9elkDK7CjM8fjhebsuPiL9U4yFTdPl/tL
        NG3Zt4Hg0ekB04ZI+XXgGL6m1g==
X-Google-Smtp-Source: AGHT+IHwIvv+JTwBRRW71Qa7xbgvdkU1c1eKrLfp2+xgZ7FYuatIo23pLIvxx+ja3FpUlneLYyfkBQ==
X-Received: by 2002:a05:6830:45a5:b0:6c4:cf2e:59a3 with SMTP id az37-20020a05683045a500b006c4cf2e59a3mr134786otb.8.1695372657347;
        Fri, 22 Sep 2023 01:50:57 -0700 (PDT)
Received: from centos78 (60-248-88-209.hinet-ip.hinet.net. [60.248.88.209])
        by smtp.googlemail.com with ESMTPSA id x2-20020aa784c2000000b006884844dfcdsm2715784pfn.55.2023.09.22.01.50.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Sep 2023 01:50:56 -0700 (PDT)
Message-ID: <bc855b702c8a2fbb7d3ffff69f65b6ce89c9042c.camel@areca.com.tw>
Subject: [PATCH V2 1/3] scsi: arcmsr: support Areca ARC-1688 Raid controller
From:   ching Huang <ching2048@areca.com.tw>
To:     martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
        linux-scsi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Fri, 22 Sep 2023 16:50:56 +0800
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ching Huang <ching2048@areca.com.tw>

This patch supports Areca new Raid controller ARC-1688

Signed-off-by: ching Huang <ching2048@areca.com.tw>
---

diff --git a/drivers/scsi/arcmsr/arcmsr.h b/drivers/scsi/arcmsr/arcmsr.h
index ed8d931..8f20d9c 100644
--- a/drivers/scsi/arcmsr/arcmsr.h
+++ b/drivers/scsi/arcmsr/arcmsr.h
@@ -818,6 +818,23 @@ typedef struct deliver_completeQ {
 	uint16_t	cmdLMID;        // reserved (0)
 	uint16_t	cmdFlag2;       // reserved (0)
 } DeliverQ, CompletionQ, *pDeliver_Q, *pCompletion_Q;
+
+#define ARCMSR_XOR_SEG_SIZE	(1024 * 1024)
+struct HostRamBuf {
+	uint32_t	hrbSignature;	// must be "HRBS"
+	uint32_t	hrbSize;	// total sg size, be multiples of MB
+	uint32_t	hrbRes[2];	// reserved, must be set to 0
+};
+struct	Xor_sg {
+	dma_addr_t	xorPhys;
+	uint64_t	xorBufLen;
+};
+struct	XorHandle {
+	dma_addr_t	xorPhys;
+	uint64_t	xorBufLen;
+	void		*xorVirt;
+};
+
 /*
 *******************************************************************************
 **                 Adapter Control Block
@@ -929,6 +946,7 @@ struct AdapterControlBlock
 	char			firm_model[12];
 	char			firm_version[20];
 	char			device_map[20];			/*21,84-99*/
+	uint32_t		firm_PicStatus;
 	struct work_struct 	arcmsr_do_message_isr_bh;
 	struct timer_list	eternal_timer;
 	unsigned short		fw_flag;
@@ -937,6 +955,7 @@ struct AdapterControlBlock
 #define	FW_DEADLOCK			0x0010
 	uint32_t		maxOutstanding;
 	int			vector_count;
+	int			xor_mega;
 	uint32_t		maxFreeCCB;
 	struct timer_list	refresh_timer;
 	uint32_t		doneq_index;
@@ -946,6 +965,10 @@ struct AdapterControlBlock
 	uint32_t		completionQ_entry;
 	pCompletion_Q		pCompletionQ;
 	uint32_t		completeQ_size;
+	void			*xorVirt;
+	dma_addr_t		xorPhys;
+	unsigned int		init2cfg_size;
+	unsigned int		xorVirtOffset;
 };/* HW_DEVICE_EXTENSION */
 /*
 *******************************************************************************
diff --git a/drivers/scsi/arcmsr/arcmsr_hba.c b/drivers/scsi/arcmsr/arcmsr_hba.c
index a66221c..e2c71ab 100644
--- a/drivers/scsi/arcmsr/arcmsr_hba.c
+++ b/drivers/scsi/arcmsr/arcmsr_hba.c
@@ -747,6 +747,57 @@ static bool arcmsr_alloc_io_queue(struct AdapterControlBlock *acb)
 	return rtn;
 }
 
+static int arcmsr_alloc_xor_buffer(struct AdapterControlBlock *acb)
+{
+	int rc = 0;
+	struct pci_dev *pdev = acb->pdev;
+	void *dma_coherent;
+	dma_addr_t dma_coherent_handle;
+	int i, xor_ram;
+	struct Xor_sg *pXorPhys;
+	void **pXorVirt;
+	struct HostRamBuf *pRamBuf;
+
+	// allocate 1 MB * N physically continuous memory for XOR engine.
+	xor_ram = (acb->firm_PicStatus >> 24) & 0x0f;
+	acb->xor_mega = (xor_ram - 1) * 32 + 128 + 3;
+	acb->init2cfg_size = sizeof(struct HostRamBuf) +
+		(sizeof(struct XorHandle) * acb->xor_mega);
+	dma_coherent = dma_alloc_coherent(&pdev->dev, acb->init2cfg_size,
+		&dma_coherent_handle, GFP_KERNEL);
+	acb->xorVirt = dma_coherent;
+	acb->xorPhys = dma_coherent_handle;
+	pXorPhys = (struct Xor_sg *)((unsigned long)dma_coherent +
+		sizeof(struct HostRamBuf));
+	acb->xorVirtOffset = sizeof(struct HostRamBuf) +
+		(sizeof(struct Xor_sg) * acb->xor_mega);
+	pXorVirt = (void **)((unsigned long)dma_coherent +
+		(unsigned long)acb->xorVirtOffset);
+	for (i = 0; i < acb->xor_mega; i++) {
+		dma_coherent = dma_alloc_coherent(&pdev->dev,
+			ARCMSR_XOR_SEG_SIZE,
+			&dma_coherent_handle, GFP_KERNEL);
+		if (dma_coherent) {
+			pXorPhys->xorPhys = dma_coherent_handle;
+			pXorPhys->xorBufLen = ARCMSR_XOR_SEG_SIZE;
+			*pXorVirt = dma_coherent;
+			pXorPhys++;
+			pXorVirt++;
+		} else {
+			printk("arcmsr%d: alloc max XOR buffer = 0x%x MB\n",
+				acb->host->host_no, i);
+			rc = -ENOMEM;
+			break;
+		}
+	}
+	pRamBuf = (struct HostRamBuf *)acb->xorVirt;
+	pRamBuf->hrbSignature = 0x53425248;	//HRBS
+	pRamBuf->hrbSize = i * ARCMSR_XOR_SEG_SIZE;
+	pRamBuf->hrbRes[0] = 0;
+	pRamBuf->hrbRes[1] = 0;
+	return rc;
+}
+
 static int arcmsr_alloc_ccb_pool(struct AdapterControlBlock *acb)
 {
 	struct pci_dev *pdev = acb->pdev;
@@ -836,7 +887,11 @@ static int arcmsr_alloc_ccb_pool(struct AdapterControlBlock *acb)
 		acb->completionQ_entry = acb->ioqueue_size / sizeof(struct deliver_completeQ);
 		acb->doneq_index = 0;
 		break;
-	}	
+	}
+	if ((acb->firm_PicStatus >> 24) & 0x0f) {
+		if (arcmsr_alloc_xor_buffer(acb))
+			return -ENOMEM;
+	}
 	return 0;
 }
 
@@ -2022,6 +2077,29 @@ static void arcmsr_stop_adapter_bgrb(struct AdapterControlBlock *acb)
 
 static void arcmsr_free_ccb_pool(struct AdapterControlBlock *acb)
 {
+	if (acb->xor_mega) {
+		struct Xor_sg *pXorPhys;
+		void **pXorVirt;
+		int i;
+
+		pXorPhys = (struct Xor_sg *)(acb->xorVirt +
+			sizeof(struct HostRamBuf));
+		pXorVirt = (void **)((unsigned long)acb->xorVirt +
+			(unsigned long)acb->xorVirtOffset);
+		for (i = 0; i < acb->xor_mega; i++) {
+			if (pXorPhys->xorPhys) {
+				dma_free_coherent(&acb->pdev->dev,
+					ARCMSR_XOR_SEG_SIZE,
+					*pXorVirt, pXorPhys->xorPhys);
+				pXorPhys->xorPhys = (dma_addr_t)NULL;
+				*pXorVirt = NULL;
+			}
+			pXorPhys++;
+			pXorVirt++;
+		}
+		dma_free_coherent(&acb->pdev->dev, acb->init2cfg_size,
+			acb->xorVirt, acb->xorPhys);
+	}
 	dma_free_coherent(&acb->pdev->dev, acb->uncache_size, acb->dma_coherent, acb->dma_coherent_handle);
 }
 
@@ -3309,6 +3387,10 @@ static void arcmsr_get_adapter_config(struct AdapterControlBlock *pACB, uint32_t
 	pACB->firm_sdram_size = readl(&rwbuffer[3]);
 	pACB->firm_hd_channels = readl(&rwbuffer[4]);
 	pACB->firm_cfg_version = readl(&rwbuffer[25]);
+	if (pACB->adapter_type == ACB_ADAPTER_TYPE_F)
+		pACB->firm_PicStatus = readl(&rwbuffer[30]);
+	else
+		pACB->firm_PicStatus = 0;
 	pr_notice("Areca RAID Controller%d: Model %s, F/W %s\n",
 		pACB->host->host_no,
 		pACB->firm_model,
@@ -4096,6 +4178,12 @@ static int arcmsr_iop_confirm(struct AdapterControlBlock *acb)
 		acb->msgcode_rwbuffer[5] = lower_32_bits(acb->dma_coherent_handle2);
 		acb->msgcode_rwbuffer[6] = upper_32_bits(acb->dma_coherent_handle2);
 		acb->msgcode_rwbuffer[7] = acb->completeQ_size;
+		if (acb->xor_mega) {
+			acb->msgcode_rwbuffer[8] = 0x455AA;	//Linux init 2
+			acb->msgcode_rwbuffer[9] = 0;
+			acb->msgcode_rwbuffer[10] = lower_32_bits(acb->xorPhys);
+			acb->msgcode_rwbuffer[11] = upper_32_bits(acb->xorPhys);
+		}
 		writel(ARCMSR_INBOUND_MESG0_SET_CONFIG, &reg->inbound_msgaddr0);
 		acb->out_doorbell ^= ARCMSR_HBEMU_DRV2IOP_MESSAGE_CMD_DONE;
 		writel(acb->out_doorbell, &reg->iobound_doorbell);

