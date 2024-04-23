Return-Path: <linux-kernel+bounces-155829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 072618AF7AE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 21:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82A1C28B1EA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 19:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E2D1422D8;
	Tue, 23 Apr 2024 19:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="GBNGlUMO"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A05C1411F4;
	Tue, 23 Apr 2024 19:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713902296; cv=none; b=qT4rQskq7ZcM3jo41KeIqOEc/16Z9RWWc161Cwf3tPxv5w0wDhjlkcb62MtgAGZrea2OdlEzKwbEe0aObm/GsL28eh5HjrNhk88zF/lL21BKqe95ZJoNNvwGCdrm+GAt8RIlP7pZfHpLBBIxQAdsjUVzCV6v6olQuzcq86OONwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713902296; c=relaxed/simple;
	bh=jzSbqsy+gSaNWK/h2jOXWvQnb4ux/bndnUaOM908xqU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kidkDSnk9uxTTISzSgWiau/ukuNcfL++HgIriMRs/iH2ukiQmKavv6Zvc3j2WWqgmJTxdnYPPxrmbzDl2T73I+B4T1+hn2DaTnnvFJCnOV0mEbcONbkSGxWlypQ0XfCz8BpmFHPO3BIHae+V0Ik1j8ZyXZHpKCoVd1pq5rWxWmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=GBNGlUMO; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1713902294; x=1745438294;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jzSbqsy+gSaNWK/h2jOXWvQnb4ux/bndnUaOM908xqU=;
  b=GBNGlUMOKOW2av6WrZq9LtXId5mlWCkttHSgjFXUTDV734rMldyo228R
   cElYXYKeym7VGjDYMn/mT0w0w+ARSV5RWmY6ibdRl2Da7fHhpAbeUxHQK
   A39NFz7rhiFZOj+nKFVxwRBATE8IJf4UUKM59OIYnxpHSWLiJG6wEpmN6
   PX1dehFUVEvraBvd0khbpKUodbhr287OpSM/1sIHISNmDnuRWsPjif+vH
   xWR6bJesPQXb8jBmkhw7tiqhVSxQwKRiaEeqV+Ky1SAk/B/qjRCWwRstr
   lZCHyzQEYg2Ziv8IyYyn0zyR+HvrAWys7xzW+/JOuxp2KyjbMdQjuV6W6
   Q==;
X-CSE-ConnectionGUID: 5xSWtGnMQTuHpwnp037lyA==
X-CSE-MsgGUID: 6XUchRz+RfWYJfofscGSPQ==
X-IronPort-AV: E=Sophos;i="6.07,222,1708412400"; 
   d="scan'208";a="22310508"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Apr 2024 12:58:13 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Apr 2024 12:57:43 -0700
Received: from DEN-DL-M31836.microsemi.net (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 23 Apr 2024 12:57:41 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Horatiu Vultur
	<horatiu.vultur@microchip.com>
Subject: [PATCH net-next] net: phy: micrel: Add support for PTP_PF_EXTTS for lan8814
Date: Tue, 23 Apr 2024 21:57:32 +0200
Message-ID: <20240423195732.3353522-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Extend the PTP programmable gpios to implement also PTP_PF_EXTTS
function. The pins can be configured to capture both of rising
and falling edge. Once the event is seen, then an interrupt is
generated and the LTC is saved in the registers.
On lan8814 only GPIO 3 can be configured for this.

This was tested using:
ts2phc -m -l 7 -s generic -f ts2phc.cfg

Where the configuration was the following:
---
[global]
ts2phc.pin_index  3

[eth0]
---

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 drivers/net/phy/micrel.c | 182 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 181 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 0e310a5e2bff0..2d11f38cbc243 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -167,6 +167,9 @@
 #define PTP_CMD_CTL_PTP_LTC_STEP_SEC_		BIT(5)
 #define PTP_CMD_CTL_PTP_LTC_STEP_NSEC_		BIT(6)
 
+#define PTP_COMMON_INT_ENA			0x0204
+#define PTP_COMMON_INT_ENA_GPIO_CAP_EN		BIT(2)
+
 #define PTP_CLOCK_SET_SEC_HI			0x0205
 #define PTP_CLOCK_SET_SEC_MID			0x0206
 #define PTP_CLOCK_SET_SEC_LO			0x0207
@@ -179,6 +182,27 @@
 #define PTP_CLOCK_READ_NS_HI			0x022C
 #define PTP_CLOCK_READ_NS_LO			0x022D
 
+#define PTP_GPIO_SEL				0x0230
+#define PTP_GPIO_SEL_GPIO_SEL(pin)		((pin) << 8)
+#define PTP_GPIO_CAP_MAP_LO			0x0232
+
+#define PTP_GPIO_CAP_EN				0x0233
+#define PTP_GPIO_CAP_EN_GPIO_RE_CAPTURE_ENABLE(gpio)	BIT(gpio)
+#define PTP_GPIO_CAP_EN_GPIO_FE_CAPTURE_ENABLE(gpio)	(BIT(gpio) << 8)
+
+#define PTP_GPIO_RE_LTC_SEC_HI_CAP		0x0235
+#define PTP_GPIO_RE_LTC_SEC_LO_CAP		0x0236
+#define PTP_GPIO_RE_LTC_NS_HI_CAP		0x0237
+#define PTP_GPIO_RE_LTC_NS_LO_CAP		0x0238
+#define PTP_GPIO_FE_LTC_SEC_HI_CAP		0x0239
+#define PTP_GPIO_FE_LTC_SEC_LO_CAP		0x023A
+#define PTP_GPIO_FE_LTC_NS_HI_CAP		0x023B
+#define PTP_GPIO_FE_LTC_NS_LO_CAP		0x023C
+
+#define PTP_GPIO_CAP_STS			0x023D
+#define PTP_GPIO_CAP_STS_PTP_GPIO_RE_STS(gpio)	BIT(gpio)
+#define PTP_GPIO_CAP_STS_PTP_GPIO_FE_STS(gpio)	(BIT(gpio) << 8)
+
 #define PTP_OPERATING_MODE			0x0241
 #define PTP_OPERATING_MODE_STANDALONE_		BIT(0)
 
@@ -274,6 +298,7 @@
 
 #define LAN8814_PTP_GPIO_NUM			24
 #define LAN8814_PTP_PEROUT_NUM			2
+#define LAN8814_PTP_EXTTS_NUM			3
 
 #define LAN8814_BUFFER_TIME			2
 
@@ -3124,12 +3149,102 @@ static int lan8814_ptp_perout(struct ptp_clock_info *ptpci,
 	return 0;
 }
 
+static void lan8814_ptp_extts_on(struct phy_device *phydev, int pin, u32 flags)
+{
+	u16 tmp;
+
+	/* Set as gpio input */
+	tmp = lanphy_read_page_reg(phydev, 4, LAN8814_GPIO_DIR_ADDR(pin));
+	tmp &= ~LAN8814_GPIO_DIR_BIT(pin);
+	lanphy_write_page_reg(phydev, 4, LAN8814_GPIO_DIR_ADDR(pin), tmp);
+
+	/* Map the pin to ltc pin 0 of the capture map registers */
+	tmp = lanphy_read_page_reg(phydev, 4, PTP_GPIO_CAP_MAP_LO);
+	tmp |= pin;
+	lanphy_write_page_reg(phydev, 4, PTP_GPIO_CAP_MAP_LO, tmp);
+
+	/* Enable capture on the edges of the ltc pin */
+	tmp = lanphy_read_page_reg(phydev, 4, PTP_GPIO_CAP_EN);
+	if (flags & PTP_RISING_EDGE)
+		tmp |= PTP_GPIO_CAP_EN_GPIO_RE_CAPTURE_ENABLE(0);
+	if (flags & PTP_FALLING_EDGE)
+		tmp |= PTP_GPIO_CAP_EN_GPIO_FE_CAPTURE_ENABLE(0);
+	lanphy_write_page_reg(phydev, 4, PTP_GPIO_CAP_EN, tmp);
+
+	/* Enable interrupt top interrupt */
+	tmp = lanphy_read_page_reg(phydev, 4, PTP_COMMON_INT_ENA);
+	tmp |= PTP_COMMON_INT_ENA_GPIO_CAP_EN;
+	lanphy_write_page_reg(phydev, 4, PTP_COMMON_INT_ENA, tmp);
+}
+
+static void lan8814_ptp_extts_off(struct phy_device *phydev, int pin)
+{
+	u16 tmp;
+
+	/* Set as gpio out */
+	tmp = lanphy_read_page_reg(phydev, 4, LAN8814_GPIO_DIR_ADDR(pin));
+	tmp |= LAN8814_GPIO_DIR_BIT(pin);
+	lanphy_write_page_reg(phydev, 4, LAN8814_GPIO_DIR_ADDR(pin), tmp);
+
+	/* Enable alternate, 0:for alternate function, 1:gpio */
+	tmp = lanphy_read_page_reg(phydev, 4, LAN8814_GPIO_EN_ADDR(pin));
+	tmp &= ~LAN8814_GPIO_EN_BIT(pin);
+	lanphy_write_page_reg(phydev, 4, LAN8814_GPIO_EN_ADDR(pin), tmp);
+
+	/* Clear the mapping of pin to registers 0 of the capture registers */
+	tmp = lanphy_read_page_reg(phydev, 4, PTP_GPIO_CAP_MAP_LO);
+	tmp &= ~GENMASK(3, 0);
+	lanphy_write_page_reg(phydev, 4, PTP_GPIO_CAP_MAP_LO, tmp);
+
+	/* Disable capture on both of the edges */
+	tmp = lanphy_read_page_reg(phydev, 4, PTP_GPIO_CAP_EN);
+	tmp &= ~PTP_GPIO_CAP_EN_GPIO_RE_CAPTURE_ENABLE(pin);
+	tmp &= ~PTP_GPIO_CAP_EN_GPIO_FE_CAPTURE_ENABLE(pin);
+	lanphy_write_page_reg(phydev, 4, PTP_GPIO_CAP_EN, tmp);
+
+	/* Disable interrupt top interrupt */
+	tmp = lanphy_read_page_reg(phydev, 4, PTP_COMMON_INT_ENA);
+	tmp &= ~PTP_COMMON_INT_ENA_GPIO_CAP_EN;
+	lanphy_write_page_reg(phydev, 4, PTP_COMMON_INT_ENA, tmp);
+}
+
+static int lan8814_ptp_extts(struct ptp_clock_info *ptpci,
+			     struct ptp_clock_request *rq, int on)
+{
+	struct lan8814_shared_priv *shared = container_of(ptpci, struct lan8814_shared_priv,
+							  ptp_clock_info);
+	struct phy_device *phydev = shared->phydev;
+	int pin;
+
+	if (rq->extts.flags & ~(PTP_ENABLE_FEATURE |
+				PTP_EXTTS_EDGES |
+				PTP_STRICT_FLAGS))
+		return -EOPNOTSUPP;
+
+	pin = ptp_find_pin(shared->ptp_clock, PTP_PF_EXTTS,
+			   rq->extts.index);
+	if (pin == -1 || pin != LAN8814_PTP_EXTTS_NUM)
+		return -EINVAL;
+
+	mutex_lock(&shared->shared_lock);
+	if (on)
+		lan8814_ptp_extts_on(phydev, pin, rq->extts.flags);
+	else
+		lan8814_ptp_extts_off(phydev, pin);
+
+	mutex_unlock(&shared->shared_lock);
+
+	return 0;
+}
+
 static int lan8814_ptpci_enable(struct ptp_clock_info *ptpci,
 				struct ptp_clock_request *rq, int on)
 {
 	switch (rq->type) {
 	case PTP_CLK_REQ_PEROUT:
 		return lan8814_ptp_perout(ptpci, rq, on);
+	case PTP_CLK_REQ_EXTTS:
+		return lan8814_ptp_extts(ptpci, rq, on);
 	default:
 		return -EINVAL;
 	}
@@ -3148,6 +3263,10 @@ static int lan8814_ptpci_verify(struct ptp_clock_info *ptp, unsigned int pin,
 		if (pin >= LAN8814_PTP_PEROUT_NUM || pin != chan)
 			return -1;
 		break;
+	case PTP_PF_EXTTS:
+		if (pin != LAN8814_PTP_EXTTS_NUM)
+			return -1;
+		break;
 	default:
 		return -1;
 	}
@@ -3320,6 +3439,64 @@ static void lan8814_handle_ptp_interrupt(struct phy_device *phydev, u16 status)
 	}
 }
 
+static int lan8814_gpio_process_cap(struct lan8814_shared_priv *shared)
+{
+	struct phy_device *phydev = shared->phydev;
+	struct ptp_clock_event ptp_event = {0};
+	unsigned long nsec;
+	s64 sec;
+	u16 tmp;
+
+	/* This is 0 because whatever was the input pin it was mapped it to
+	 * ltc gpio pin 0
+	 */
+	tmp = lanphy_read_page_reg(phydev, 4, PTP_GPIO_SEL);
+	tmp |= PTP_GPIO_SEL_GPIO_SEL(0);
+	lanphy_write_page_reg(phydev, 4, PTP_GPIO_SEL, tmp);
+
+	tmp = lanphy_read_page_reg(phydev, 4, PTP_GPIO_CAP_STS);
+	if (!(tmp & PTP_GPIO_CAP_STS_PTP_GPIO_RE_STS(0)) &&
+	    !(tmp & PTP_GPIO_CAP_STS_PTP_GPIO_FE_STS(0)))
+		return -1;
+
+	if (tmp & BIT(0)) {
+		sec = lanphy_read_page_reg(phydev, 4, PTP_GPIO_RE_LTC_SEC_HI_CAP);
+		sec <<= 16;
+		sec |= lanphy_read_page_reg(phydev, 4, PTP_GPIO_RE_LTC_SEC_LO_CAP);
+
+		nsec = lanphy_read_page_reg(phydev, 4, PTP_GPIO_RE_LTC_NS_HI_CAP) & 0x3fff;
+		nsec <<= 16;
+		nsec |= lanphy_read_page_reg(phydev, 4, PTP_GPIO_RE_LTC_NS_LO_CAP);
+	} else {
+		sec = lanphy_read_page_reg(phydev, 4, PTP_GPIO_FE_LTC_SEC_HI_CAP);
+		sec <<= 16;
+		sec |= lanphy_read_page_reg(phydev, 4, PTP_GPIO_FE_LTC_SEC_LO_CAP);
+
+		nsec = lanphy_read_page_reg(phydev, 4, PTP_GPIO_FE_LTC_NS_HI_CAP) & 0x3fff;
+		nsec <<= 16;
+		nsec |= lanphy_read_page_reg(phydev, 4, PTP_GPIO_RE_LTC_NS_LO_CAP);
+	}
+
+	ptp_event.index = 0;
+	ptp_event.timestamp = ktime_set(sec, nsec);
+	ptp_event.type = PTP_CLOCK_EXTTS;
+	ptp_clock_event(shared->ptp_clock, &ptp_event);
+
+	return 0;
+}
+
+static int lan8814_handle_gpio_interrupt(struct phy_device *phydev, u16 status)
+{
+	struct lan8814_shared_priv *shared = phydev->shared->priv;
+	int ret;
+
+	mutex_lock(&shared->shared_lock);
+	ret = lan8814_gpio_process_cap(shared);
+	mutex_unlock(&shared->shared_lock);
+
+	return ret;
+}
+
 static int lan8804_config_init(struct phy_device *phydev)
 {
 	int val;
@@ -3424,6 +3601,9 @@ static irqreturn_t lan8814_handle_interrupt(struct phy_device *phydev)
 		ret = IRQ_HANDLED;
 	}
 
+	if (!lan8814_handle_gpio_interrupt(phydev, irq_status))
+		ret = IRQ_HANDLED;
+
 	return ret;
 }
 
@@ -3541,7 +3721,7 @@ static int lan8814_ptp_probe_once(struct phy_device *phydev)
 	snprintf(shared->ptp_clock_info.name, 30, "%s", phydev->drv->name);
 	shared->ptp_clock_info.max_adj = 31249999;
 	shared->ptp_clock_info.n_alarm = 0;
-	shared->ptp_clock_info.n_ext_ts = 0;
+	shared->ptp_clock_info.n_ext_ts = LAN8814_PTP_EXTTS_NUM;
 	shared->ptp_clock_info.n_pins = LAN8814_PTP_GPIO_NUM;
 	shared->ptp_clock_info.pps = 0;
 	shared->ptp_clock_info.pin_config = shared->pin_config;
-- 
2.34.1


