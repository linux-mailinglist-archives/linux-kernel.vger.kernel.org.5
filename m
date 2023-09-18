Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95CD47A474F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 12:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240883AbjIRKjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 06:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241226AbjIRKjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 06:39:04 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F5BDB
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 03:38:13 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-68fb79ef55eso3977835b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 03:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=areca-com-tw.20230601.gappssmtp.com; s=20230601; t=1695033492; x=1695638292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:to:from:subject
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VuLnXPAk5N9RW9fw9vLO0mYniWn+dtC0GhU2KZWJaK0=;
        b=Es/DB/lQ9CTrsf8hAMI2sLCbl5VFyQCdfcNTXK2xmrTxOCLoxfTXdXnSpr2PNOenl9
         VxA7zQ/9PETSJ8E7AorYYIW40UbzyD543I+3WemePc2MJrvWaIJ6XAuE6sDLO/KjLMg5
         E/E+DinPdsP0yj2DoYX0Bf1pbFt2BL2GrThXX/g5+/bVgeePjq0K1Injv4tqUffASeQU
         enxRXSwM1gmNLOlT7WFQJGt9b9AgN6KqYYs4tHJe/qZwQ0BuyyV7nzubTclaXx37jcG7
         Ii4JAXvswsvzZvUgxqEhGDjSkz5qcBpVq9WuVfZiidkit1h7ATAyxwi1186u39yv3MEg
         AgcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695033492; x=1695638292;
        h=content-transfer-encoding:mime-version:date:to:from:subject
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VuLnXPAk5N9RW9fw9vLO0mYniWn+dtC0GhU2KZWJaK0=;
        b=Cv9nKq6OL8BwYaFlEvUKexEIBVXOfPPQd9CWRid2g2r4op3Ue+xohGSUHxZaTvh5Ir
         Ol42iKqshgbCr8wR0xLULp03EyDJWcQhz//vimuV8NYEpJUQ5W4h+jkusNpaOOuu6rEC
         1Va2ii1tM0+K1BtnBLCT8x8yIo4MHpg1w/duOsOx8TUBv/cKDs+F1oTRjBa9e4jf1FMT
         Qc+bSnPUr8FX0BAezZ1PkOR93JpPu7DH4xCLCDroZjZviiA87omHBForOuSngsq99fc5
         RVCIsuXdUkBe07letvx89yUzk046LkmREwFb7tZQRWM+rpRw3BfoaL0hZKZpE78SPIBq
         QYvA==
X-Gm-Message-State: AOJu0YzeUNcBvpWzhZRl0f2LJhYHRzpezhl6omhgWRaA2m/u7ZjN6fgZ
        Q1gWFZwZf5VJLpMKfTnMdxHaqg==
X-Google-Smtp-Source: AGHT+IHPZqpA509qDt1eJcHG1L0WhRkBa5OluaRpISp+rd60WgADVdJbyr/a/K/zbioN0sufapAT+g==
X-Received: by 2002:a05:6a20:3d83:b0:153:5366:dec1 with SMTP id s3-20020a056a203d8300b001535366dec1mr12900006pzi.15.1695033492563;
        Mon, 18 Sep 2023 03:38:12 -0700 (PDT)
Received: from centos78 (60-248-88-209.hinet-ip.hinet.net. [60.248.88.209])
        by smtp.googlemail.com with ESMTPSA id q23-20020a62e117000000b00688435a9915sm6849563pfh.189.2023.09.18.03.38.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Sep 2023 03:38:12 -0700 (PDT)
Message-ID: <8f8a803019e607bafc101d1aaecd25f4e0c9c1c3.camel@areca.com.tw>
Subject: [PATCH 2/3] scsi: arcmsr: support new PCI device ID 1883 and 1886
 Raid controllers
From:   ching Huang <ching2048@areca.com.tw>
To:     martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
        linux-scsi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Mon, 18 Sep 2023 18:38:13 +0800
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

This patch supports Areca new PCI device ID 1883 and 1886 Raid
controllers

Signed-off-by: ching Huang <ching2048@areca.com.tw>
---

diff --git a/drivers/scsi/arcmsr/arcmsr.h
b/drivers/scsi/arcmsr/arcmsr.h
index 8c0db11..ef96b32 100644
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
diff --git a/drivers/scsi/arcmsr/arcmsr_hba.c
b/drivers/scsi/arcmsr/arcmsr_hba.c
index 39d3b10..90cbcba 100644
--- a/drivers/scsi/arcmsr/arcmsr_hba.c
+++ b/drivers/scsi/arcmsr/arcmsr_hba.c
@@ -214,8 +214,12 @@ static struct pci_device_id
arcmsr_device_id_table[] = {
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
@@ -4785,9 +4789,11 @@ static const char *arcmsr_info(struct Scsi_Host
*host)
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

