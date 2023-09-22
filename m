Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C297AAD32
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 10:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbjIVIzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 04:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbjIVIzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 04:55:11 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD85EE8
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 01:55:05 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-27666e94ad7so1533634a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 01:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=areca-com-tw.20230601.gappssmtp.com; s=20230601; t=1695372905; x=1695977705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:to:from:subject
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=c0lvfh2z34kklQghRPHMgySN4X7ueSLfP71qd/q8Psw=;
        b=w+C+kntTlRV4SjhIRAiDw/IFA8Ua/rLpwYwF2wXCbpK9yY2IF6cAUffnZBOAazDAAy
         SJ/whFZEfZa0v46N9AmStPx8E70H0QADo99QjEryzBdykEkrW9WJ7GklOaB+gTUluihf
         VJatWxfO9d0PXtZF6zHwxV7mFpdr5EbLUG+LOb2evKaleIPxlwGpQkyRyDubO5qvHg95
         PHkZAoqTqeoKyo81Unn8yh/2N0sBfONP7F0LieXvSCWxM47jqdD6PwQ/jPxdVA26EEMy
         L+P8PaPM4JRulEIEw95z/WoTVho9KgxmAuYa2bTj6Caho05oSkLj/OAT5ey2AO/PJIre
         zr0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695372905; x=1695977705;
        h=content-transfer-encoding:mime-version:date:to:from:subject
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c0lvfh2z34kklQghRPHMgySN4X7ueSLfP71qd/q8Psw=;
        b=Rm4v6GGCYzJsN2PHzHWOK3U/OEx7ewXheKKKsog+0CcxY5zJVqRcbKY5le7CZg+7+I
         7peCcuGNY7l82K1W2dSDZsXeHu+UZN5hdP7BSGGAiXfhbsc5lobVoDsy0uQmKHtfZQQT
         ZYJ8Crn/pK7E4da0/8Duljdh5w9EC3Zolz5/N0DX29sA9CKEGTd20RC4IPdb5Y+R8JE6
         8pdjI+N+8GwhaOFlseL9cv6oD9WfKElNKSMvSfhbcllyBXKCMmMshWjC2L1j7VzeVZLE
         55/Nf5TperLk6oIYtkXrsc+SciXOjTryAYcW7uOqjSjrN7M1ODruE+3injResb+C8cqn
         EQSw==
X-Gm-Message-State: AOJu0Yz2CSqHR4b3K1WnewM4/WgSXD33UdUkZHLk6Gk+ygIu3MDy08zq
        s94D36DhQbexje3wEBI/PrPn6A==
X-Google-Smtp-Source: AGHT+IGVuCEWfM4GWuwLP0lEt6K5tzvKJGmMMe92XWJ9s/Bt6uPaeyTVva1kQ3Pbo+bF0/nDxRn+Pg==
X-Received: by 2002:a17:90a:db82:b0:26b:513a:30b0 with SMTP id h2-20020a17090adb8200b0026b513a30b0mr3137713pjv.10.1695372905217;
        Fri, 22 Sep 2023 01:55:05 -0700 (PDT)
Received: from centos78 (60-248-88-209.hinet-ip.hinet.net. [60.248.88.209])
        by smtp.googlemail.com with ESMTPSA id l6-20020a170902f68600b001c41e1e9ca7sm2911372plg.215.2023.09.22.01.55.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Sep 2023 01:55:04 -0700 (PDT)
Message-ID: <4d58c52bffc20b0668b17977c8e813abbd219bf0.camel@areca.com.tw>
Subject: [PATCH V2 2/3] scsi: arcmsr: support new PCI device ID 1883 and
 1886 Raid controllers
From:   ching Huang <ching2048@areca.com.tw>
To:     martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
        linux-scsi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Fri, 22 Sep 2023 16:55:05 +0800
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

This patch supports Areca new PCI device ID 1883 and 1886 Raid controllers

Signed-off-by: ching Huang <ching2048@areca.com.tw>
---

diff --git a/drivers/scsi/arcmsr/arcmsr.h b/drivers/scsi/arcmsr/arcmsr.h
index 8f20d9c..2f80a6a 100644
--- a/drivers/scsi/arcmsr/arcmsr.h
+++ b/drivers/scsi/arcmsr/arcmsr.h
@@ -78,9 +78,13 @@ struct device_attribute;
 #ifndef PCI_DEVICE_ID_ARECA_1203
 #define PCI_DEVICE_ID_ARECA_1203	0x1203
 #endif
+#ifndef PCI_DEVICE_ID_ARECA_1883
+#define PCI_DEVICE_ID_ARECA_1883	0x1883
+#endif
 #ifndef PCI_DEVICE_ID_ARECA_1884
 #define PCI_DEVICE_ID_ARECA_1884	0x1884
 #endif
+#define PCI_DEVICE_ID_ARECA_1886_0	0x1886
 #define PCI_DEVICE_ID_ARECA_1886	0x188A
 #define	ARCMSR_HOURS			(1000 * 60 * 60 * 4)
 #define	ARCMSR_MINUTES			(1000 * 60 * 60)
diff --git a/drivers/scsi/arcmsr/arcmsr_hba.c b/drivers/scsi/arcmsr/arcmsr_hba.c
index e2c71ab..22a204e 100644
--- a/drivers/scsi/arcmsr/arcmsr_hba.c
+++ b/drivers/scsi/arcmsr/arcmsr_hba.c
@@ -214,8 +214,12 @@ static struct pci_device_id arcmsr_device_id_table[] = {
 		.driver_data = ACB_ADAPTER_TYPE_A},
 	{PCI_DEVICE(PCI_VENDOR_ID_ARECA, PCI_DEVICE_ID_ARECA_1880),
 		.driver_data = ACB_ADAPTER_TYPE_C},
+	{PCI_DEVICE(PCI_VENDOR_ID_ARECA, PCI_DEVICE_ID_ARECA_1883),
+		.driver_data = ACB_ADAPTER_TYPE_C},
 	{PCI_DEVICE(PCI_VENDOR_ID_ARECA, PCI_DEVICE_ID_ARECA_1884),
 		.driver_data = ACB_ADAPTER_TYPE_E},
+	{PCI_DEVICE(PCI_VENDOR_ID_ARECA, PCI_DEVICE_ID_ARECA_1886_0),
+		.driver_data = ACB_ADAPTER_TYPE_F},
 	{PCI_DEVICE(PCI_VENDOR_ID_ARECA, PCI_DEVICE_ID_ARECA_1886),
 		.driver_data = ACB_ADAPTER_TYPE_F},
 	{0, 0}, /* Terminating entry */
@@ -4794,9 +4798,11 @@ static const char *arcmsr_info(struct Scsi_Host *host)
 	case PCI_DEVICE_ID_ARECA_1680:
 	case PCI_DEVICE_ID_ARECA_1681:
 	case PCI_DEVICE_ID_ARECA_1880:
+	case PCI_DEVICE_ID_ARECA_1883:
 	case PCI_DEVICE_ID_ARECA_1884:
 		type = "SAS/SATA";
 		break;
+	case PCI_DEVICE_ID_ARECA_1886_0:
 	case PCI_DEVICE_ID_ARECA_1886:
 		type = "NVMe/SAS/SATA";
 		break;

