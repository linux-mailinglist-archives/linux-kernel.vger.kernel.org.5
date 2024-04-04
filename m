Return-Path: <linux-kernel+bounces-131078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA52C8982C9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EF5528C8E6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 08:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CA96D1A9;
	Thu,  4 Apr 2024 08:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="f+4SlmbB"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C867064A9F;
	Thu,  4 Apr 2024 08:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712217890; cv=none; b=sw8uY+JiE29jOhCKYHMlDhGnVJ/gLg7WootJ1mBwexbzz1RR3IWrC+PtdfBgGqYN585GzZRHqUncEICN6xx2Kv1oUK2Qra0Tox222TunnM2PxrpLbIYwF61aQ8gIqFLu+Cp9UiqEOe1wpaMpYDn8P+z9kZsz7CNS9Elzz+1zlx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712217890; c=relaxed/simple;
	bh=YDTaPTC6tXQ0HPuxlEjpJRmjI9ji+sQqO0TRqUqEqvY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ub6S8iYX93cwh3fK+W6BCNwj5SJ8Or0P7yY+3lBHg+muKD1MYKrMtdXoWZJOxFfiG7SzUvl6x+mBt2kmero/gI6wrQisA3+NbwEd9/VOFoSc2eds8N/O/C1EmExmyEgGSqQ97p4Rx4ykgeBXF4TtfDXukDhA8NIbTY7yosnb9s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=f+4SlmbB; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712217886; x=1743753886;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YDTaPTC6tXQ0HPuxlEjpJRmjI9ji+sQqO0TRqUqEqvY=;
  b=f+4SlmbBOpu/FPs9uN8Dj5jFRUrbfNWYsXLq/1uBVW93chnYHvUb6ro4
   lG+Bj+oFy9fhgrie0MAoVu8LEr8eK7t1x6Zt3+QGMRiFDvJ+fB457gzCW
   yFp3lUP2MXRtZJTF3lC/Mt88G0loAyVyMsaKuJBCZuraV6vuTHL0dexT+
   n1py9KrOjYkZ1Kh3VZZsWvtAkFyJ2v6gf/I7brkPr+XxBuoSCQNomv9Gl
   uqz85Z8JZATiyl2U5Qno72PvGc5TVQ9ta3Qto8WC+01a/rGna+SX1R9nd
   TwZOiDhg6ekxUJsYB+azeKbFntBM4oCL04wd/suy8wwZQCf9kvWXEAEIZ
   A==;
X-CSE-ConnectionGUID: dlpw0rggR4WYgOJDui2PAg==
X-CSE-MsgGUID: PYtbG4m9RT60JrtX8SaH0Q==
X-IronPort-AV: E=Sophos;i="6.07,178,1708412400"; 
   d="scan'208";a="186710222"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Apr 2024 01:04:43 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Apr 2024 01:04:37 -0700
Received: from DEN-DL-M31836.microsemi.net (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 4 Apr 2024 01:04:35 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>, Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH net-next 2/2] net: phy: micrel: lan8814: Add support for PTP_PF_PEROUT
Date: Thu, 4 Apr 2024 10:01:15 +0200
Message-ID: <20240404080115.450929-3-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240404080115.450929-1-horatiu.vultur@microchip.com>
References: <20240404080115.450929-1-horatiu.vultur@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Lan8814 has 24 GPIOs but only 2 GPIOs (GPIO 0 and GPIO 1) can be
configured to generate period signals. And there are 2 events (EVENT_A
and EVENT_B) but these events are hardcoded to the GPIO 0 and GPIO 1.
These events are used to generate period signals. It is possible to
configure the length, the start time and the period of the signal by
configuring the event.

These events are generated by comparing the target time with the PHC
time. In case the PHC time is changed to a value bigger than the target
time + reload time, then it would generate only 1 event and then it
would stop because target time + reload time is smaller than PHC time.
Therefore it is required to change also the target time every time when
the PHC is changed. The same will apply also when the PHC time is
changed to a smaller value.

This was tested using:
testptp -i 1 -L 1,2
testptp -i 1 -p 1000000000 -w 200000000

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 drivers/net/phy/micrel.c | 353 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 351 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 51ca1b2b5d99a..521c6f7ab420c 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -272,6 +272,66 @@
 #define PS_TO_REG				200
 #define FIFO_SIZE				8
 
+#define LAN8814_PTP_GPIO_NUM			24
+#define LAN8814_PTP_PEROUT_NUM			2
+
+#define LAN8814_BUFFER_TIME			2
+
+#define LAN8841_PTP_GENERAL_CONFIG_LTC_EVENT_200MS	13
+#define LAN8841_PTP_GENERAL_CONFIG_LTC_EVENT_100MS	12
+#define LAN8841_PTP_GENERAL_CONFIG_LTC_EVENT_50MS	11
+#define LAN8841_PTP_GENERAL_CONFIG_LTC_EVENT_10MS	10
+#define LAN8841_PTP_GENERAL_CONFIG_LTC_EVENT_5MS	9
+#define LAN8841_PTP_GENERAL_CONFIG_LTC_EVENT_1MS	8
+#define LAN8841_PTP_GENERAL_CONFIG_LTC_EVENT_500US	7
+#define LAN8841_PTP_GENERAL_CONFIG_LTC_EVENT_100US	6
+#define LAN8841_PTP_GENERAL_CONFIG_LTC_EVENT_50US	5
+#define LAN8841_PTP_GENERAL_CONFIG_LTC_EVENT_10US	4
+#define LAN8841_PTP_GENERAL_CONFIG_LTC_EVENT_5US	3
+#define LAN8841_PTP_GENERAL_CONFIG_LTC_EVENT_1US	2
+#define LAN8841_PTP_GENERAL_CONFIG_LTC_EVENT_500NS	1
+#define LAN8841_PTP_GENERAL_CONFIG_LTC_EVENT_100NS	0
+
+#define LAN8814_GPIO_EN1			0x20
+#define LAN8814_GPIO_EN2			0x21
+#define LAN8814_GPIO_DIR1			0x22
+#define LAN8814_GPIO_DIR2			0x23
+#define LAN8814_GPIO_BUF1			0x24
+#define LAN8814_GPIO_BUF2			0x25
+
+#define LAN8814_GPIO_EN_ADDR(pin) \
+	((pin) > 15 ? LAN8814_GPIO_EN1 : LAN8814_GPIO_EN2)
+#define LAN8814_GPIO_EN_BIT(pin)		BIT(pin)
+#define LAN8814_GPIO_DIR_ADDR(pin) \
+	((pin) > 15 ? LAN8814_GPIO_DIR1 : LAN8814_GPIO_DIR2)
+#define LAN8814_GPIO_DIR_BIT(pin)		BIT(pin)
+#define LAN8814_GPIO_BUF_ADDR(pin) \
+	((pin) > 15 ? LAN8814_GPIO_BUF1 : LAN8814_GPIO_BUF2)
+#define LAN8814_GPIO_BUF_BIT(pin)		BIT(pin)
+
+#define LAN8814_EVENT_A				0
+#define LAN8814_EVENT_B				1
+
+#define LAN8814_PTP_GENERAL_CONFIG		0x0201
+#define LAN8814_PTP_GENERAL_CONFIG_LTC_EVENT_MASK(event) \
+	((event) ? GENMASK(11, 8) : GENMASK(7, 4))
+#define LAN8814_PTP_GENERAL_CONFIG_LTC_EVENT_SET(event, value) \
+	(((value) & GENMASK(3, 0)) << (4 + ((event) << 2)))
+#define LAN8814_PTP_GENERAL_CONFIG_RELOAD_ADD_X(event) \
+	((event) ? BIT(2) : BIT(0))
+#define LAN8814_PTP_GENERAL_CONFIG_POLARITY_X(event) \
+	((event) ? BIT(3) : BIT(1))
+
+#define LAN8814_PTP_CLOCK_TARGET_SEC_HI(event)	((event) ? 0x21F : 0x215)
+#define LAN8814_PTP_CLOCK_TARGET_SEC_LO(event)	((event) ? 0x220 : 0x216)
+#define LAN8814_PTP_CLOCK_TARGET_NS_HI(event)	((event) ? 0x221 : 0x217)
+#define LAN8814_PTP_CLOCK_TARGET_NS_LO(event)	((event) ? 0x222 : 0x218)
+
+#define LAN8814_PTP_CLOCK_TARGET_RELOAD_SEC_HI(event)	((event) ? 0x223 : 0x219)
+#define LAN8814_PTP_CLOCK_TARGET_RELOAD_SEC_LO(event)	((event) ? 0x224 : 0x21A)
+#define LAN8814_PTP_CLOCK_TARGET_RELOAD_NS_HI(event)	((event) ? 0x225 : 0x21B)
+#define LAN8814_PTP_CLOCK_TARGET_RELOAD_NS_LO(event)	((event) ? 0x226 : 0x21C)
+
 /* Delay used to get the second part from the LTC */
 #define LAN8841_GET_SEC_LTC_DELAY		(500 * NSEC_PER_MSEC)
 
@@ -304,6 +364,7 @@ struct lan8814_shared_priv {
 	struct phy_device *phydev;
 	struct ptp_clock *ptp_clock;
 	struct ptp_clock_info ptp_clock_info;
+	struct ptp_pin_desc *pin_config;
 
 	/* Lock for ptp_clock */
 	struct mutex shared_lock;
@@ -2651,6 +2712,29 @@ static int lan8814_ptpci_settime64(struct ptp_clock_info *ptpci,
 	return 0;
 }
 
+static void lan8814_ptp_set_target(struct phy_device *phydev, int event,
+				   s64 start_sec, u32 start_nsec)
+{
+	/* Set the start time */
+	lanphy_write_page_reg(phydev, 4, LAN8814_PTP_CLOCK_TARGET_SEC_LO(event),
+			      lower_16_bits(start_sec));
+	lanphy_write_page_reg(phydev, 4, LAN8814_PTP_CLOCK_TARGET_SEC_HI(event),
+			      upper_16_bits(start_sec));
+
+	lanphy_write_page_reg(phydev, 4, LAN8814_PTP_CLOCK_TARGET_NS_LO(event),
+			      lower_16_bits(start_nsec));
+	lanphy_write_page_reg(phydev, 4, LAN8814_PTP_CLOCK_TARGET_NS_HI(event),
+			      upper_16_bits(start_nsec) & 0x3fff);
+}
+
+static void lan8814_ptp_update_target(struct phy_device *phydev, time64_t sec)
+{
+	lan8814_ptp_set_target(phydev, LAN8814_EVENT_A,
+			       sec + LAN8814_BUFFER_TIME, 0);
+	lan8814_ptp_set_target(phydev, LAN8814_EVENT_B,
+			       sec + LAN8814_BUFFER_TIME, 0);
+}
+
 static void lan8814_ptp_clock_step(struct phy_device *phydev,
 				   s64 time_step_ns)
 {
@@ -2672,6 +2756,7 @@ static void lan8814_ptp_clock_step(struct phy_device *phydev,
 			nano_seconds -= 1000000000;
 		}
 		lan8814_ptp_clock_set(phydev, set_seconds, nano_seconds);
+		lan8814_ptp_update_target(phydev, set_seconds);
 		return;
 	} else if (time_step_ns < -15000000000LL) {
 		/* convert to clock set */
@@ -2687,6 +2772,7 @@ static void lan8814_ptp_clock_step(struct phy_device *phydev,
 		}
 		nano_seconds -= nano_seconds_step;
 		lan8814_ptp_clock_set(phydev, set_seconds, nano_seconds);
+		lan8814_ptp_update_target(phydev, set_seconds);
 		return;
 	}
 
@@ -2723,6 +2809,8 @@ static void lan8814_ptp_clock_step(struct phy_device *phydev,
 	}
 
 	while (seconds) {
+		u32 nsec;
+
 		if (seconds > 0) {
 			u32 adjustment_value = (u32)seconds;
 			u16 adjustment_value_lo, adjustment_value_hi;
@@ -2739,6 +2827,10 @@ static void lan8814_ptp_clock_step(struct phy_device *phydev,
 					      PTP_LTC_STEP_ADJ_DIR_ |
 					      adjustment_value_hi);
 			seconds -= ((s32)adjustment_value);
+
+			lan8814_ptp_clock_get(phydev, &set_seconds, &nsec);
+			set_seconds -= adjustment_value;
+			lan8814_ptp_update_target(phydev, set_seconds);
 		} else {
 			u32 adjustment_value = (u32)(-seconds);
 			u16 adjustment_value_lo, adjustment_value_hi;
@@ -2754,6 +2846,10 @@ static void lan8814_ptp_clock_step(struct phy_device *phydev,
 			lanphy_write_page_reg(phydev, 4, PTP_LTC_STEP_ADJ_HI,
 					      adjustment_value_hi);
 			seconds += ((s32)adjustment_value);
+
+			lan8814_ptp_clock_get(phydev, &set_seconds, &nsec);
+			set_seconds += adjustment_value;
+			lan8814_ptp_update_target(phydev, set_seconds);
 		}
 		lanphy_write_page_reg(phydev, 4, PTP_CMD_CTL,
 				      PTP_CMD_CTL_PTP_LTC_STEP_SEC_);
@@ -2819,6 +2915,239 @@ static int lan8814_ptpci_adjfine(struct ptp_clock_info *ptpci, long scaled_ppm)
 	return 0;
 }
 
+static void lan8814_ptp_set_reload(struct phy_device *phydev, int event,
+				   s64 period_sec, u32 period_nsec)
+{
+	lanphy_write_page_reg(phydev, 4,
+			      LAN8814_PTP_CLOCK_TARGET_RELOAD_SEC_LO(event),
+			      lower_16_bits(period_sec));
+	lanphy_write_page_reg(phydev, 4,
+			      LAN8814_PTP_CLOCK_TARGET_RELOAD_SEC_HI(event),
+			      upper_16_bits(period_sec));
+
+	lanphy_write_page_reg(phydev, 4,
+			      LAN8814_PTP_CLOCK_TARGET_RELOAD_NS_LO(event),
+			      lower_16_bits(period_nsec));
+	lanphy_write_page_reg(phydev, 4,
+			      LAN8814_PTP_CLOCK_TARGET_RELOAD_NS_HI(event),
+			      upper_16_bits(period_nsec) & 0x3fff);
+}
+
+static void lan8814_ptp_enable_event(struct phy_device *phydev, int event,
+				     int pulse_width)
+{
+	u16 val;
+
+	val = lanphy_read_page_reg(phydev, 4, LAN8814_PTP_GENERAL_CONFIG);
+	/* Set the pulse width of the event */
+	val &= ~(LAN8814_PTP_GENERAL_CONFIG_LTC_EVENT_MASK(event));
+	/* Make sure that the target clock will be incremented each time when
+	 * local time reaches or pass it
+	 */
+	val |= LAN8814_PTP_GENERAL_CONFIG_LTC_EVENT_SET(event, pulse_width);
+	val &= ~(LAN8814_PTP_GENERAL_CONFIG_RELOAD_ADD_X(event));
+	/* Set the polarity high */
+	val |= LAN8814_PTP_GENERAL_CONFIG_POLARITY_X(event);
+	lanphy_write_page_reg(phydev, 4, LAN8814_PTP_GENERAL_CONFIG, val);
+}
+
+static void lan8814_ptp_disable_event(struct phy_device *phydev, int event)
+{
+	u16 val;
+
+	/* Set target to too far in the future, effectively disabling it */
+	lan8814_ptp_set_target(phydev, event, 0xFFFFFFFF, 0);
+
+	/* And then reload once it recheas the target */
+	val = lanphy_read_page_reg(phydev, 4, LAN8814_PTP_GENERAL_CONFIG);
+	val |= LAN8814_PTP_GENERAL_CONFIG_RELOAD_ADD_X(event);
+	lanphy_write_page_reg(phydev, 4, LAN8814_PTP_GENERAL_CONFIG, val);
+}
+
+static void lan8814_ptp_perout_off(struct phy_device *phydev, int pin)
+{
+	u16 val;
+
+	/* Disable gpio alternate function,
+	 * 1: select as gpio,
+	 * 0: select alt func
+	 */
+	val = lanphy_read_page_reg(phydev, 4, LAN8814_GPIO_EN_ADDR(pin));
+	val |= LAN8814_GPIO_EN_BIT(pin);
+	lanphy_write_page_reg(phydev, 4, LAN8814_GPIO_EN_ADDR(pin), val);
+
+	val = lanphy_read_page_reg(phydev, 4, LAN8814_GPIO_DIR_ADDR(pin));
+	val &= ~LAN8814_GPIO_DIR_BIT(pin);
+	lanphy_write_page_reg(phydev, 4, LAN8814_GPIO_DIR_ADDR(pin), val);
+
+	val = lanphy_read_page_reg(phydev, 4, LAN8814_GPIO_BUF_ADDR(pin));
+	val &= ~LAN8814_GPIO_BUF_BIT(pin);
+	lanphy_write_page_reg(phydev, 4, LAN8814_GPIO_BUF_ADDR(pin), val);
+}
+
+static void lan8814_ptp_perout_on(struct phy_device *phydev, int pin)
+{
+	int val;
+
+	/* Set as gpio output */
+	val = lanphy_read_page_reg(phydev, 4, LAN8814_GPIO_DIR_ADDR(pin));
+	val |= LAN8814_GPIO_DIR_BIT(pin);
+	lanphy_write_page_reg(phydev, 4, LAN8814_GPIO_DIR_ADDR(pin), val);
+
+	/* Enable gpio 0:for alternate function, 1:gpio */
+	val = lanphy_read_page_reg(phydev, 4, LAN8814_GPIO_EN_ADDR(pin));
+	val &= ~LAN8814_GPIO_EN_BIT(pin);
+	lanphy_write_page_reg(phydev, 4, LAN8814_GPIO_EN_ADDR(pin), val);
+
+	/* Set buffer type to push pull */
+	val = lanphy_read_page_reg(phydev, 4, LAN8814_GPIO_BUF_ADDR(pin));
+	val |= LAN8814_GPIO_BUF_BIT(pin);
+	lanphy_write_page_reg(phydev, 4, LAN8814_GPIO_BUF_ADDR(pin), val);
+}
+
+static int lan8814_ptp_perout(struct ptp_clock_info *ptpci,
+			      struct ptp_clock_request *rq, int on)
+{
+	struct lan8814_shared_priv *shared = container_of(ptpci, struct lan8814_shared_priv,
+							  ptp_clock_info);
+	struct phy_device *phydev = shared->phydev;
+	struct timespec64 ts_on, ts_period;
+	s64 on_nsec, period_nsec;
+	int pulse_width;
+	int pin, event;
+
+	/* Reject requests with unsupported flags */
+	if (rq->perout.flags & ~PTP_PEROUT_DUTY_CYCLE)
+		return -EOPNOTSUPP;
+
+	mutex_lock(&shared->shared_lock);
+	event = rq->perout.index;
+	pin = ptp_find_pin(shared->ptp_clock, PTP_PF_PEROUT, event);
+	if (pin < 0 || pin >= LAN8814_PTP_PEROUT_NUM) {
+		mutex_unlock(&shared->shared_lock);
+		return -EBUSY;
+	}
+
+	if (!on) {
+		lan8814_ptp_perout_off(phydev, pin);
+		lan8814_ptp_disable_event(phydev, event);
+		mutex_unlock(&shared->shared_lock);
+		return 0;
+	}
+
+	ts_on.tv_sec = rq->perout.on.sec;
+	ts_on.tv_nsec = rq->perout.on.nsec;
+	on_nsec = timespec64_to_ns(&ts_on);
+
+	ts_period.tv_sec = rq->perout.period.sec;
+	ts_period.tv_nsec = rq->perout.period.nsec;
+	period_nsec = timespec64_to_ns(&ts_period);
+
+	if (period_nsec < 200) {
+		pr_warn_ratelimited("%s: perout period too small, minimum is 200 nsec\n",
+				    phydev_name(phydev));
+		return -EOPNOTSUPP;
+	}
+
+	if (on_nsec >= period_nsec) {
+		pr_warn_ratelimited("%s: pulse width must be smaller than period\n",
+				    phydev_name(phydev));
+		return -EINVAL;
+	}
+
+	switch (on_nsec) {
+	case 200000000:
+		pulse_width = LAN8841_PTP_GENERAL_CONFIG_LTC_EVENT_200MS;
+		break;
+	case 100000000:
+		pulse_width = LAN8841_PTP_GENERAL_CONFIG_LTC_EVENT_100MS;
+		break;
+	case 50000000:
+		pulse_width = LAN8841_PTP_GENERAL_CONFIG_LTC_EVENT_50MS;
+		break;
+	case 10000000:
+		pulse_width = LAN8841_PTP_GENERAL_CONFIG_LTC_EVENT_10MS;
+		break;
+	case 5000000:
+		pulse_width = LAN8841_PTP_GENERAL_CONFIG_LTC_EVENT_5MS;
+		break;
+	case 1000000:
+		pulse_width = LAN8841_PTP_GENERAL_CONFIG_LTC_EVENT_1MS;
+		break;
+	case 500000:
+		pulse_width = LAN8841_PTP_GENERAL_CONFIG_LTC_EVENT_500US;
+		break;
+	case 100000:
+		pulse_width = LAN8841_PTP_GENERAL_CONFIG_LTC_EVENT_100US;
+		break;
+	case 50000:
+		pulse_width = LAN8841_PTP_GENERAL_CONFIG_LTC_EVENT_50US;
+		break;
+	case 10000:
+		pulse_width = LAN8841_PTP_GENERAL_CONFIG_LTC_EVENT_10US;
+		break;
+	case 5000:
+		pulse_width = LAN8841_PTP_GENERAL_CONFIG_LTC_EVENT_5US;
+		break;
+	case 1000:
+		pulse_width = LAN8841_PTP_GENERAL_CONFIG_LTC_EVENT_1US;
+		break;
+	case 500:
+		pulse_width = LAN8841_PTP_GENERAL_CONFIG_LTC_EVENT_500NS;
+		break;
+	case 100:
+		pulse_width = LAN8841_PTP_GENERAL_CONFIG_LTC_EVENT_100NS;
+		break;
+	default:
+		pr_warn_ratelimited("%s: Use default duty cycle of 100ns\n",
+				    phydev_name(phydev));
+		pulse_width = LAN8841_PTP_GENERAL_CONFIG_LTC_EVENT_100NS;
+		break;
+	}
+
+	/* Configure to pulse every period */
+	lan8814_ptp_enable_event(phydev, event, pulse_width);
+	lan8814_ptp_set_target(phydev, event, rq->perout.start.sec,
+			       rq->perout.start.nsec);
+	lan8814_ptp_set_reload(phydev, event, rq->perout.period.sec,
+			       rq->perout.period.nsec);
+	lan8814_ptp_perout_on(phydev, pin);
+	mutex_unlock(&shared->shared_lock);
+
+	return 0;
+}
+
+static int lan8814_ptpci_enable(struct ptp_clock_info *ptpci,
+				struct ptp_clock_request *rq, int on)
+{
+	switch (rq->type) {
+	case PTP_CLK_REQ_PEROUT:
+		return lan8814_ptp_perout(ptpci, rq, on);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int lan8814_ptpci_verify(struct ptp_clock_info *ptp, unsigned int pin,
+				enum ptp_pin_function func, unsigned int chan)
+{
+	switch (func) {
+	case PTP_PF_NONE:
+	case PTP_PF_PEROUT:
+		/* Only pins 0 and 1 can generate perout signals. And for pin 0
+		 * there is only chan 0 (event A) and for pin 1 there is only
+		 * chan 1 (event B)
+		 */
+		if (pin >= LAN8814_PTP_PEROUT_NUM || pin != chan)
+			return -1;
+		break;
+	default:
+		return -1;
+	}
+
+	return 0;
+}
+
 static void lan8814_get_sig_tx(struct sk_buff *skb, u16 *sig)
 {
 	struct ptp_header *ptp_header;
@@ -3178,19 +3507,39 @@ static int lan8814_ptp_probe_once(struct phy_device *phydev)
 	/* Initialise shared lock for clock*/
 	mutex_init(&shared->shared_lock);
 
+	shared->pin_config = devm_kmalloc_array(&phydev->mdio.dev,
+						LAN8814_PTP_GPIO_NUM,
+						sizeof(*shared->pin_config),
+						GFP_KERNEL);
+	if (!shared->pin_config)
+		return -ENOMEM;
+
+	for (int i = 0; i < LAN8814_PTP_GPIO_NUM; i++) {
+		struct ptp_pin_desc *ptp_pin = &shared->pin_config[i];
+
+		memset(ptp_pin, 0, sizeof(*ptp_pin));
+		snprintf(ptp_pin->name,
+			 sizeof(ptp_pin->name), "lan8814_ptp_pin_%02d", i);
+		ptp_pin->index = i;
+		ptp_pin->func =  PTP_PF_NONE;
+	}
+
 	shared->ptp_clock_info.owner = THIS_MODULE;
 	snprintf(shared->ptp_clock_info.name, 30, "%s", phydev->drv->name);
 	shared->ptp_clock_info.max_adj = 31249999;
 	shared->ptp_clock_info.n_alarm = 0;
 	shared->ptp_clock_info.n_ext_ts = 0;
-	shared->ptp_clock_info.n_pins = 0;
+	shared->ptp_clock_info.n_pins = LAN8814_PTP_GPIO_NUM;
 	shared->ptp_clock_info.pps = 0;
-	shared->ptp_clock_info.pin_config = NULL;
+	shared->ptp_clock_info.pin_config = shared->pin_config;
+	shared->ptp_clock_info.n_per_out = LAN8814_PTP_PEROUT_NUM;
 	shared->ptp_clock_info.adjfine = lan8814_ptpci_adjfine;
 	shared->ptp_clock_info.adjtime = lan8814_ptpci_adjtime;
 	shared->ptp_clock_info.gettime64 = lan8814_ptpci_gettime64;
 	shared->ptp_clock_info.settime64 = lan8814_ptpci_settime64;
 	shared->ptp_clock_info.getcrosststamp = NULL;
+	shared->ptp_clock_info.enable = lan8814_ptpci_enable;
+	shared->ptp_clock_info.verify = lan8814_ptpci_verify;
 
 	shared->ptp_clock = ptp_clock_register(&shared->ptp_clock_info,
 					       &phydev->mdio.dev);
-- 
2.34.1


