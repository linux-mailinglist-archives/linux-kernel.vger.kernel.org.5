Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A15F7BA08D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237210AbjJEOip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235525AbjJEOfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:35:41 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4973893D5;
        Thu,  5 Oct 2023 01:52:22 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c77449a6daso5734525ad.0;
        Thu, 05 Oct 2023 01:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696495941; x=1697100741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f3fQjf5cs2rm/iEMimmENJo42F+TkJd9co+ck/259yc=;
        b=l0iQp7tqbnpBI8GxOi6T38BAW6/9qZTQE8T9ihP6wdI1PrdMDC/xjoDuH0XyAkJu9B
         Wzrgq5rM6cPm+Npd3VEiwCVKF5l3GZdmHhawLe/1M/q+fYwMSd4aYEbumDCrBJ6/vYqb
         PUyZt6m7w648NjBrBsHFD4TcsMtuFF/UaACuZytxiGDfdlTYBNKink6a/y0HBoRnhWfZ
         SDHcdjFsViOVI9i5nEGe8JTRRLzhBWC63VLm4RJhBkZyjeOv1ZUrjQ9WXX6ckl4tqdwJ
         4ENBNiNMtitRluQuKqnf96ui8x4B4ufDcOvKiLCeKVe0p+GpSpSbzp6/34lGh4CN62Ik
         yQFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696495941; x=1697100741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f3fQjf5cs2rm/iEMimmENJo42F+TkJd9co+ck/259yc=;
        b=gFdlpDIzmSuc2cUyuZQ1qtmzTWvbpx0XVeufwzA7o2z4bstmqzR6vQ0cHf4NfDrxiz
         O2VqCu16HiBpF/RwErPj3Lbbi7upiVksIRRiOA2KitIvPN8A3llFQVkIbmLPxyXVhQaJ
         1fW1LwMQl+Qfb2dTI3slfPVSK+WPFFGPYj21tAXKW5Luw8f3qRgq5Iyhl9rFVgvruDFE
         nxrWWq63VRyslKxHc09Z6TBcekJUKF4zq8kNODhnzYTX2bkRaMEobJcycpVb1Io7OHyj
         c+zVXIRtyfiYs1hvpL6LSmejQyZ0sUK8YvJTMECOBuIGaJElhTXxHYmzz1JP9LeypGMZ
         rRgA==
X-Gm-Message-State: AOJu0YxmNKoNnysy3Ca1dRMtnyA7fg6DR9v/GtTKBNhOXZcnKHQKqpCm
        sjWbUlgGHjTWvA5ePYKVBwPNTBbXx4oPXw==
X-Google-Smtp-Source: AGHT+IF6mb+ioo521ahBySgh3snge5CKgwce3ikjlRRjW6R24u0p1GE3GquI8TVEVB2YPT8rqQD9sg==
X-Received: by 2002:a17:902:9f8e:b0:1c5:b808:7fc8 with SMTP id g14-20020a1709029f8e00b001c5b8087fc8mr4406122plq.33.1696495941229;
        Thu, 05 Oct 2023 01:52:21 -0700 (PDT)
Received: from wenkaidev (118-163-147-182.hinet-ip.hinet.net. [118.163.147.182])
        by smtp.gmail.com with ESMTPSA id h9-20020a170902f54900b001c47541ecd7sm1059937plf.250.2023.10.05.01.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 01:52:20 -0700 (PDT)
From:   advantech.susiteam@gmail.com
To:     advantech.susiteam@gmail.com
Cc:     wenkai.chung@advantech.com.tw, Susi.Driver@advantech.com,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: [PATCH 4/5] watchdog: eiois200_wdt: Enhanced watchdog functionality and pretimeout
Date:   Thu,  5 Oct 2023 16:51:22 +0800
Message-Id: <9dc5114ec819588c5ba957bd9e365329533ac191.1696495372.git.advantech.susiteam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1696495372.git.advantech.susiteam@gmail.com>
References: <cover.1696495372.git.advantech.susiteam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wenkai <advantech.susiteam@gmail.com>

This patch extends the Advantech EIO-IS200 Watchdog Driver to provide
advanced watchdog functionality, including pretimeout support. It allows
the user to specify a timeout or pre-timeout trigger event, let the
event pin output level switches from high to low. The event pin which
can be one of the following:
- PWRBTN (Power button)
- SCI (ACPI System Control Interrupt)
- IRQ
- GPIO

If the pretimeout is specified, when the pretimeout time expires, it
triggers the associated pin. If the timeout expires, it triggers a reset.

If the pretimeout is not specified, the timeout expiration triggers the
associated pin or the reset pin.

This addition to basic watchdog functionality. It ensures proper
integration with the watchdog framework and provides a flexible watchdog
solution for Advantech EIO-IS200-based systems.

Signed-off-by: Wenkai <advantech.susiteam@gmail.com>
---
 drivers/watchdog/eiois200_wdt.c | 159 ++++++++++++++++++++++++++++++--
 1 file changed, 152 insertions(+), 7 deletions(-)

diff --git a/drivers/watchdog/eiois200_wdt.c b/drivers/watchdog/eiois200_wdt.c
index 569e619448e5..85179806ab7e 100644
--- a/drivers/watchdog/eiois200_wdt.c
+++ b/drivers/watchdog/eiois200_wdt.c
@@ -18,13 +18,21 @@
 
 /* Support Flags */
 #define SUPPORT_AVAILABLE	BIT(0)
+#define SUPPORT_PWRBTN		BIT(3)
+#define SUPPORT_IRQ		BIT(4)
+#define SUPPORT_SCI		BIT(5)
+#define SUPPORT_PIN		BIT(6)
 #define SUPPORT_RESET		BIT(7)
 
 /* PMC registers */
 #define REG_STATUS		0x00
 #define REG_CONTROL		0x02
 #define REG_EVENT		0x10
+#define REG_PWR_EVENT_TIME	0x12
+#define REG_IRQ_EVENT_TIME	0x13
 #define REG_RESET_EVENT_TIME	0x14
+#define REG_PIN_EVENT_TIME	0x15
+#define REG_SCI_EVENT_TIME	0x16
 #define REG_IRQ_NUMBER		0x17
 
 /* PMC command and control */
@@ -50,20 +58,53 @@
 #define PMC_WRITE(cmd, data)	pmc(CMD_WDT_WRITE, cmd, data)
 #define PMC_READ(cmd, data)	pmc(CMD_WDT_READ, cmd, data)
 
+/* Mapping event type to supported bit */
+#define EVENT_BIT(type)   	BIT(type + 2)
+
+enum event_type {
+	EVENT_NONE,
+	EVENT_PWRBTN,
+	EVENT_IRQ,
+	EVENT_SCI,
+	EVENT_PIN
+};
+
 static struct _wdt {
+	u32	event_type;
 	u32	support;
 	long	last_time;
 	struct	regmap  *iomap;
 	struct	device *dev;
 } wdt;
 
+static char * const type_strs[] = {
+	"NONE",
+	"PWRBTN",
+	"IRQ",
+	"SCI",
+	"PIN",
+};
+
+static u32 type_regs[] = {
+	REG_RESET_EVENT_TIME,
+	REG_PWR_EVENT_TIME,
+	REG_IRQ_EVENT_TIME,
+	REG_SCI_EVENT_TIME,
+	REG_PIN_EVENT_TIME,
+};
+
 /* Pointer to the eiois200_core device structure */
 static struct eiois200_dev *eiois200_dev;
 
+/* Specify the pin triggered on pretimeout or timeout */
+static char *event_type = "NONE";
+module_param(event_type, charp, 0);
+MODULE_PARM_DESC(event_type,
+		 "Watchdog timeout event type (RESET, PWRBTN, SCI, IRQ, GPIO)");
 static struct watchdog_info wdinfo = {
 	.identity = KBUILD_MODNAME,
 	.options  = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING |
-		    WDIOF_MAGICCLOSE,
+		    WDIOF_PRETIMEOUT | WDIOF_MAGICCLOSE,
 };
 
 static struct watchdog_device wddev = {
@@ -76,8 +117,42 @@ static int wdt_set_timeout(struct watchdog_device *dev,
 			   unsigned int _timeout)
 {
 	dev->timeout = _timeout;
-	dev_dbg(wdt.dev, "Set timeout: %d\n", _timeout);
+	dev_info(wdt.dev, "Set timeout: %d\n", _timeout);
+
+	return 0;
+}
+
+static int wdt_set_pretimeout(struct watchdog_device *dev,
+			      unsigned int _pretimeout)
+{
+	dev->pretimeout = _pretimeout;
+
+	dev_info(wdt.dev, "Set pretimeout: %d\n", _pretimeout);
+
+	return 0;
+}
+
+static int wdt_get_type(void)
+{
+	int i;
+
+	for (i = 1; i < ARRAY_SIZE(type_strs); i++)
+		if (strcasecmp(event_type, type_strs[i]) == 0) {
+			if ((wdt.support & EVENT_BIT(i)) == 0) {
+				dev_err(wdt.dev,
+					"This board doesn't support %s trigger type\n",
+					event_type);
+				return -EINVAL;
+			}
+
+			dev_info(wdt.dev, "Trigger type is %d:%s\n", 
+					  i, type_strs[i]);
+			wdt.event_type = i;
+
+			return 0;
+		}
 
+	dev_info(wdt.dev, "Event type: %s\n", type_strs[wdt.event_type]);
 	return 0;
 }
 
@@ -116,33 +191,98 @@ static int set_time(u8 ctl, u32 time)
 
 static int wdt_set_config(void)
 {
-	int ret;
+	int ret, type;
+	u32 event_time = 0;
 	u32 reset_time = 0;
 
+	/* event_type should never out of range */
+	if (wdt.event_type > EVENT_PIN)
+		return -EFAULT;
+
+	/* Calculate event time and reset time */
+	if (wddev.pretimeout && wddev.timeout) {
+		if (wddev.timeout < wddev.pretimeout)
+			return -EINVAL;
+
 	reset_time = wddev.timeout;
+		event_time = wddev.timeout - wddev.pretimeout;
 
+	} else if (wddev.timeout) {
+		reset_time = wdt.event_type ? 0	: wddev.timeout;
+		event_time = wdt.event_type ? wddev.timeout : 0;
+	}
+
+	/* Set reset time */
 	ret = set_time(REG_RESET_EVENT_TIME, reset_time);
 	if (ret)
 		return ret;
 
-	dev_info(wdt.dev, "Config wdt reset time %d\n", reset_time);
+	/* Set every other times */
+	for (type = 1; type < ARRAY_SIZE(type_regs); type++) {
+		ret = set_time(type_regs[type],
+			       wdt.event_type == type ? event_time : 0);
+		if (ret)
+			return ret;
+	}
+
+	dev_dbg(wdt.dev, "Config wdt reset time %d\n", reset_time);
+	dev_dbg(wdt.dev, "Config wdt event time %d\n", event_time);
+	dev_dbg(wdt.dev, "Config wdt event type %s\n",
+			  type_strs[wdt.event_type]);
 
 	return ret;
 }
 
 static int wdt_get_config(void)
 {
-	int ret;
-	u32 reset_time;
+	int ret, type;
+	u32 event_time, reset_time;
 
 	/* Get Reset Time */
 	ret = get_time(REG_RESET_EVENT_TIME, &reset_time);
 	if (ret)
 		return ret;
 
-	dev_info(wdt.dev, "Timeout H/W default timeout: %d secs\n", reset_time);
+	dev_dbg(wdt.dev, "Timeout H/W default timeout: %d secs\n", reset_time);
+
+	/* Get every other times **/
+	for (type = 1; type < ARRAY_SIZE(type_regs); type++) {
+		if ((wdt.support & EVENT_BIT(type)) == 0)
+			continue;
+
+		ret = get_time(type_regs[type], &event_time);
+		if (ret)
+			return ret;
+
+		if (event_time == 0)
+			continue;
+
+		if (reset_time) {
+			if (reset_time < event_time)
+				continue;
+
 	wddev.timeout	 = reset_time;
+			wddev.pretimeout = reset_time - event_time;
+
+			dev_dbg(wdt.dev, "Pretimeout H/W enabled with event %s of %d secs\n",
+				 type_strs[type], wddev.pretimeout);
+		} else {
+			wddev.timeout = event_time;
+			wddev.pretimeout = 0;
+		}
+
+		wdt.event_type = type;
+
+		dev_dbg(wdt.dev, "Timeout H/W enabled of %d secs\n",
+				  wddev.timeout);
+		return 0;
+	}
+
+	wdt.event_type	 = EVENT_NONE;
+	wddev.pretimeout = reset_time ? 0	   : WATCHDOG_PRETIMEOUT;
+	wddev.timeout	 = reset_time ? reset_time : WATCHDOG_TIMEOUT;
 
+	dev_dbg(wdt.dev, "Pretimeout H/W disabled");
 	return 0;
 }
 
@@ -218,6 +358,7 @@ static int wdt_support(void)
 
 	return 0;
 }
+
 static int wdt_init(struct device *dev)
 {
 	int ret = 0;
@@ -230,6 +371,9 @@ static int wdt_init(struct device *dev)
 	if (ret)
 		return ret;
 
+	ret = wdt_get_type();
+	if (ret)
+		return ret;
 	return ret;
 }
 
@@ -240,6 +384,7 @@ static const struct watchdog_ops wdt_ops = {
 	.ping		= wdt_ping,
 	.set_timeout	= wdt_set_timeout,
 	.get_timeleft	= wdt_get_timeleft,
+	.set_pretimeout = wdt_set_pretimeout,
 };
 
 static int wdt_probe(struct platform_device *pdev)
-- 
2.34.1

