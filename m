Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9A887F379F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 21:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233881AbjKUUjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 15:39:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbjKUUi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 15:38:58 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F061A1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 12:38:54 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5cb92becbf6so15210007b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 12:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700599134; x=1701203934; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KTDH53gNPxt291RajHzvpKvqzTC7KmzGzR+np8Bf7dA=;
        b=Z7K7PDANHV6Bf+bXmSWanOr4PmWVB/0AUObrlFVN7X7zTPnpOj0zr1fDpz+ah9yytr
         5yC36krdqXxvQ8Ajuc4HmJqNv8sDPu+dcs4vKAIL98d4u3TfCEuydFT4dqoLnChQ8iJb
         W5OZWAGySSTTz3E9lYXbeLfRMv0bx86O7offf/98PYuMbHS43qCR/86lirnbGJSv0wqW
         sSDbtUUN4ZvHAgL9mQNBMT4pRisKTfEafrcj5lrRJSAWF7vjBZLylpiX6aPyBckLBcoP
         tlSXRIDwnFHhiSbypgn6dNuk7DSPtgyaJhj2D4mVnvJ9lPIWN/BU0/DKJjCaWaF0il0a
         FjNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700599134; x=1701203934;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KTDH53gNPxt291RajHzvpKvqzTC7KmzGzR+np8Bf7dA=;
        b=if0/VWIvxWgWVA2uPwdivSCe9RTp65IjajvS59pUto668J/bsY3MbvJ8MwKP/0tblr
         S2bc+qL8ZoeY3+3mXUdxYhyKOhpMp/8NEv9FwLwfoD2qIQhD9XFCodGVLwx9h96G5bHM
         J7pJFz8vOdWq5E5TS3lzO7b1OmKaQ4PSY+K9yDWr4zQZWUUGewsnv+81jtF+rBbblWBP
         +DDgkPm3D2qUHs1BRmeoJRGV1EHoj8sOkRZQTZD9Ojd+jMYFmjbBQzjXeAuU85Wo4CPB
         kkor1IEUWpJBMAtq/lok+KHN88UF1ORSz7a0oJM7CmQuO8vECu1zn3MWnlG3foFA6vlj
         QfVg==
X-Gm-Message-State: AOJu0Yz7XMOXoLnvMz94XMvhR27r1kyiIf+6/cDTKpjPxnUViW7FkV6z
        M5ReUUlCBvlGRe+X5qf125cCVr3d4TVA6Io=
X-Google-Smtp-Source: AGHT+IEuYXxq5fTtblMTOGg6wqwt7Qleq9KC2mq1Yx89nISOxEToDfF76cL1rRm7YiLf6M1UU3OjdRy25uvmwp8=
X-Received: from rdbabiera.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:18a8])
 (user=rdbabiera job=sendgmr) by 2002:a81:4f17:0:b0:5cb:6eaf:9ece with SMTP id
 d23-20020a814f17000000b005cb6eaf9ecemr4057ywb.1.1700599134145; Tue, 21 Nov
 2023 12:38:54 -0800 (PST)
Date:   Tue, 21 Nov 2023 20:38:48 +0000
In-Reply-To: <20231121203845.170234-4-rdbabiera@google.com>
Mime-Version: 1.0
References: <20231121203845.170234-4-rdbabiera@google.com>
X-Developer-Key: i=rdbabiera@google.com; a=openpgp; fpr=639A331F1A21D691815CE090416E17CA2BBBD5C8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2847; i=rdbabiera@google.com;
 h=from:subject; bh=IjJhNlLnaEWlwoSGO/qly2CIqtjZgjikrPRbqBaNOy0=;
 b=owGbwMvMwCFW0bfok0KS4TbG02pJDKmxomFHbqyTqV5TLa0YPDcpapbecrb/xzWVLabPXCNYJ
 OAlK1bTUcrCIMbBICumyKLrn2dw40rqljmcNcYwc1iZQIYwcHEKwETcZzMyzJHo6XF461b8/Wyy
 w/3wkD9BGVOUbtzMXHFxvWLAbhW1RQy/mJY9PxvIc+z89gDmI0n1c/ybm5tuZUWVzFXp/y7tNce PGQA=
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <20231121203845.170234-6-rdbabiera@google.com>
Subject: [PATCH v1 2/2] usb: typec: tcpci: add vconn over current fault
 handling to maxim_core
From:   RD Babiera <rdbabiera@google.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        badhri@google.com, RD Babiera <rdbabiera@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add TCPC_FAULT_STATUS_VCONN_OC constant and corresponding mask definition.
Maxim TCPC is capable of detecting VConn over current faults, so add
fault to alert mask. When a Vconn over current fault is triggered, put the
port in an error recovery state via tcpm_port_error_recovery.

Signed-off-by: RD Babiera <rdbabiera@google.com>
---
 drivers/usb/typec/tcpm/tcpci_maxim_core.c | 20 +++++++++++++++++++-
 include/linux/usb/tcpci.h                 |  5 ++++-
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpci_maxim_core.c b/drivers/usb/typec/tcpm/tcpci_maxim_core.c
index 9454b12a073c..7fb966fd639b 100644
--- a/drivers/usb/typec/tcpm/tcpci_maxim_core.c
+++ b/drivers/usb/typec/tcpm/tcpci_maxim_core.c
@@ -92,11 +92,16 @@ static void max_tcpci_init_regs(struct max_tcpci_chip *chip)
 		return;
 	}
 
+	/* Vconn Over Current Protection */
+	ret = max_tcpci_write8(chip, TCPC_FAULT_STATUS_MASK, TCPC_FAULT_STATUS_MASK_VCONN_OC);
+	if (ret < 0)
+		return;
+
 	alert_mask = TCPC_ALERT_TX_SUCCESS | TCPC_ALERT_TX_DISCARDED | TCPC_ALERT_TX_FAILED |
 		TCPC_ALERT_RX_HARD_RST | TCPC_ALERT_RX_STATUS | TCPC_ALERT_CC_STATUS |
 		TCPC_ALERT_VBUS_DISCNCT | TCPC_ALERT_RX_BUF_OVF | TCPC_ALERT_POWER_STATUS |
 		/* Enable Extended alert for detecting Fast Role Swap Signal */
-		TCPC_ALERT_EXTND | TCPC_ALERT_EXTENDED_STATUS;
+		TCPC_ALERT_EXTND | TCPC_ALERT_EXTENDED_STATUS | TCPC_ALERT_FAULT;
 
 	ret = max_tcpci_write16(chip, TCPC_ALERT_MASK, alert_mask);
 	if (ret < 0) {
@@ -295,6 +300,19 @@ static irqreturn_t _max_tcpci_irq(struct max_tcpci_chip *chip, u16 status)
 		}
 	}
 
+	if (status & TCPC_ALERT_FAULT) {
+		ret = max_tcpci_read8(chip, TCPC_FAULT_STATUS, &reg_status);
+		if (ret < 0)
+			return ret;
+
+		ret = max_tcpci_write8(chip, TCPC_FAULT_STATUS, reg_status);
+		if (ret < 0)
+			return ret;
+
+		if (reg_status & TCPC_FAULT_STATUS_VCONN_OC)
+			tcpm_port_error_recovery(chip->port);
+	}
+
 	if (status & TCPC_ALERT_EXTND) {
 		ret = max_tcpci_read8(chip, TCPC_ALERT_EXTENDED, &reg_status);
 		if (ret < 0)
diff --git a/include/linux/usb/tcpci.h b/include/linux/usb/tcpci.h
index 83376473ac76..467e8045e9f8 100644
--- a/include/linux/usb/tcpci.h
+++ b/include/linux/usb/tcpci.h
@@ -36,7 +36,9 @@
 
 #define TCPC_ALERT_MASK			0x12
 #define TCPC_POWER_STATUS_MASK		0x14
-#define TCPC_FAULT_STATUS_MASK		0x15
+
+#define TCPC_FAULT_STATUS_MASK			0x15
+#define TCPC_FAULT_STATUS_MASK_VCONN_OC		BIT(1)
 
 #define TCPC_EXTENDED_STATUS_MASK		0x16
 #define TCPC_EXTENDED_STATUS_MASK_VSAFE0V	BIT(0)
@@ -104,6 +106,7 @@
 
 #define TCPC_FAULT_STATUS		0x1f
 #define TCPC_FAULT_STATUS_ALL_REG_RST_TO_DEFAULT BIT(7)
+#define TCPC_FAULT_STATUS_VCONN_OC	BIT(1)
 
 #define TCPC_ALERT_EXTENDED		0x21
 
-- 
2.43.0.rc1.413.gea7ed67945-goog

