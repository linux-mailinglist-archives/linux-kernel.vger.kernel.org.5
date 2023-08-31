Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6A3878F318
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 21:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347134AbjHaTIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 15:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234387AbjHaTIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 15:08:37 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F28E65
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 12:08:34 -0700 (PDT)
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D554241D3A
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 19:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1693508912;
        bh=Op7fxAIWtBLIvQXGgVokid+e/ObCoPcBqtedoiAumTs=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=KliNsCe7XfeFzQue1aKaIcls0zZKrk/G0KYkOHNagq1U9CcVY1tcy92oVTkwsTBUF
         ElIVQiNuWEs5tC8LjJJ08p319X4pkCZq3Z/5DCMlpExg7OeBR2vTJuz+PkCbL+pdWN
         h8wm7CaXyTcpiuJKBN2cy31YIRn3MryJKmLTs9N1Rv1Pw6HBY3K46MunkOlx8/IE7Z
         q8onU7n8J8lmzGSrohUMVd4dRZfh7f6rlJjtTWsoLK3UorS81lO+OwciMkz/5KZwEV
         KKP1lrqYe83EDgDfEmT5Vd/s+EYmvnPvQeIuhI4sIvzrkPJqCde6vq5o2NEXrnyIxR
         Sr1eBrjOD90DQ==
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1c08a6763b3so12781815ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 12:08:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693508911; x=1694113711;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Op7fxAIWtBLIvQXGgVokid+e/ObCoPcBqtedoiAumTs=;
        b=hd8RFDwS6DPZBsb0rzRaRJ1I8XmguoN/B/azaf+Sp5U8qJtq/utEAfKfsb3wkgl7Kn
         lN9mP2MLaTKDZl+Phg1mX33uoxx+esZbKn4J8FgKfoGtoNLJRUs31TwhdOyH0iH6PzM6
         r1VuZbz/LlMb9QjJl55bCzgfGD0fqECUamg4p6BTmqE21gyOj4cP/9SzcXA1tnTnh9qu
         z12b5itZrVfj9hG5vNuA03g80MkI/3P3jR6rRjXM6AnNtISYss91dmTnEoZWEBUP0fw5
         Mqp+SmmD3mrQt0R28yj5OE/sdJtcntSVlP+TeyZi+oP9XKstdqJb0Gq8KCJIsXq8M2JI
         QQDw==
X-Gm-Message-State: AOJu0YyGep+mclJnTG6hYBvcbVIzX+86vGuIQrWkGR7eD/TjtN/3KDl0
        +tUJcIsl6MdECMWnd8bDoRPddMP62AxrpkALTehuFcTQUQHR4KpBnULrPXlX0ria5kodrAUrRPc
        J7cNqUnIJr5RvPtCK5CslPjuacBuI8XD2b4GLieWy5Q==
X-Received: by 2002:a17:902:778f:b0:1bf:6a06:7b60 with SMTP id o15-20020a170902778f00b001bf6a067b60mr478254pll.66.1693508911188;
        Thu, 31 Aug 2023 12:08:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3o+mppazCZbvNYk+zhhvZDlmVRjKovq05ObDAQ/t5Hta6nnpC/bUvXEekEnU/yK//v/AC4A==
X-Received: by 2002:a17:902:778f:b0:1bf:6a06:7b60 with SMTP id o15-20020a170902778f00b001bf6a067b60mr478232pll.66.1693508910741;
        Thu, 31 Aug 2023 12:08:30 -0700 (PDT)
Received: from canonical.com (211-75-139-218.hinet-ip.hinet.net. [211.75.139.218])
        by smtp.gmail.com with ESMTPSA id e21-20020a170902d39500b001b51b3e84cesm1574527pld.166.2023.08.31.12.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 12:08:29 -0700 (PDT)
From:   Koba Ko <koba.ko@canonical.com>
To:     Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ata: libata: add workaround to flip LPM during suspend/resume
Date:   Fri,  1 Sep 2023 03:08:28 +0800
Message-Id: <20230831190828.1171119-1-koba.ko@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
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

Due to TigerLake/Adler Lake AHCI controller's LPM regression,
can't apply LPM on TigerLake/AdlerLake AHCI controller.

Add a workaround to flip LPM during suspend/resume.
When suspneding, apply LPM on TigerLake/AdlerLake AHCI.
Restore it to target_lpm_policy after resuming.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=217775
Signed-off-by: Koba Ko <koba.ko@canonical.com>
---
 drivers/ata/ahci.c      | 29 +++++++++++++++++++++++++++++
 drivers/ata/libata-eh.c |  8 ++++++++
 include/linux/libata.h  |  1 +
 3 files changed, 38 insertions(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 02503e903e4a8..5c9196cd2c738 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -95,6 +95,8 @@ static int ahci_p5wdh_hardreset(struct ata_link *link, unsigned int *class,
 #ifdef CONFIG_PM
 static int ahci_pci_device_runtime_suspend(struct device *dev);
 static int ahci_pci_device_runtime_resume(struct device *dev);
+static int ahci_intel_port_suspend(struct ata_port *ap, pm_message_t mesg);
+static int ahci_intel_port_resume(struct ata_port *ap);
 #ifdef CONFIG_PM_SLEEP
 static int ahci_pci_device_suspend(struct device *dev);
 static int ahci_pci_device_resume(struct device *dev);
@@ -1025,6 +1027,30 @@ static void ahci_p5wdh_workaround(struct ata_host *host)
 		ap->link.flags |= ATA_LFLAG_NO_SRST | ATA_LFLAG_ASSUME_ATA;
 	}
 }
+/*
+ * Intel TGL/ADL workaround, when suspending, put port into LPM,
+ * recover to max power after resuming.
+ */
+static void ahci_intel_ahci_workaround(struct ata_host *host)
+{
+	struct pci_dev *pdev = to_pci_dev(host->dev);
+	int i;
+	static const struct pci_device_id ids[] = {
+		{ PCI_VDEVICE(INTEL, 0xa0d3)}, /* Tiger Lake UP{3,4} AHCI */
+		{ PCI_VDEVICE(INTEL, 0x7ae2)}, /* Alder Lake AHCI*/
+		{}
+	};
+
+	dev_info(&pdev->dev, "enabling Intel AHCI workaround\n");
+
+	if (pci_match_id(ids, pdev)) {
+		for (i = 0; i < host->n_ports; i++) {
+			struct ata_port *ap = host->ports[i];
+
+			ap->flags |= ATA_LFLAG_NO_LPM_RECOVER;
+		}
+	}
+}
 
 /*
  * Macbook7,1 firmware forcibly disables MCP89 AHCI and changes PCI ID when
@@ -1905,6 +1931,9 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	/* apply workaround for ASUS P5W DH Deluxe mainboard */
 	ahci_p5wdh_workaround(host);
 
+	/* apply workaround for Intel AHCI */
+	ahci_intel_ahci_workaround(host);
+
 	/* apply gtf filter quirk */
 	ahci_gtf_filter_workaround(host);
 
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 159ba6ba19ebb..de29e50843f99 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -4000,6 +4000,11 @@ static void ata_eh_handle_port_suspend(struct ata_port *ap)
 	int rc = 0;
 	struct ata_device *dev;
 
+	ata_for_each_dev(dev, &ap->link, ENABLED) {
+		ata_eh_set_lpm(&ap->link, ATA_LPM_MED_POWER_WITH_DIPM, &dev);
+	}
+
+
 	/* are we suspending? */
 	spin_lock_irqsave(ap->lock, flags);
 	if (!(ap->pflags & ATA_PFLAG_PM_PENDING) ||
@@ -4087,6 +4092,9 @@ static void ata_eh_handle_port_resume(struct ata_port *ap)
 	if (ap->ops->port_resume)
 		ap->ops->port_resume(ap);
 
+	ata_for_each_dev(dev, &ap->link, ENABLED) {
+		ata_eh_set_lpm(&ap->link, ap->target_lpm_policy, &dev);
+	}
 	/* tell ACPI that we're resuming */
 	ata_acpi_on_resume(ap);
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 52d58b13e5eee..e720fed6dbd7f 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -147,6 +147,7 @@ enum {
 	ATA_LFLAG_RST_ONCE	= (1 << 9), /* limit recovery to one reset */
 	ATA_LFLAG_CHANGED	= (1 << 10), /* LPM state changed on this link */
 	ATA_LFLAG_NO_DEBOUNCE_DELAY = (1 << 11), /* no debounce delay on link resume */
+	ATA_LFLAG_NO_LPM_RECOVER = (1 << 12), /* disable LPM on this link */
 
 	/* struct ata_port flags */
 	ATA_FLAG_SLAVE_POSS	= (1 << 0), /* host supports slave dev */
-- 
2.34.1

