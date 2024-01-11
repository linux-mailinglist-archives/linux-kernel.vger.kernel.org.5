Return-Path: <linux-kernel+bounces-23066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 558DC82A723
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 06:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7833C1C21BA9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 05:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341A520F9;
	Thu, 11 Jan 2024 05:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zSAiE6Oh"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239371FB0;
	Thu, 11 Jan 2024 05:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=VakOmylgNyNEDmz+1fBRiYUX60G7ppszezsqE84sRDM=; b=zSAiE6OhqLD5/745wEPqbFBvgW
	iAEPQfeG1ZrrsVlLkbKTfMhNXUT8yu3fmGg3pHcQ052/mk878Fl+Q9R6uhHOkcfC0vsMTx+QTYL1S
	k1kkqA5HT/swghMnhNvMTzDRksPlWNzw8afOtg8SPYHP6zBMhEtHL4VWXLHv5DNK7dYyx4K0E/R7I
	V4/5NYRkGlsVKOepvvkfTmfvW4U2s4PIhsTZ+hee28utrOJrVJjbur9DwN7VPsai6hLWkPV4m3xAm
	XFOZUR5+kGVd/5s4TnM0GanR+K3owrrrCGSWr5PZ+Do4fnWivgF29HmP69BbX2Xtrgrt3HdB99/Mk
	xuxwHoMA==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rNnCf-00Fssh-2E;
	Thu, 11 Jan 2024 05:02:05 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Eduardo Valentin <edubezval@gmail.com>,
	Keerthy <j-keerthy@ti.com>,
	linux-omap@vger.kernel.org,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-pm@vger.kernel.org
Subject: [PATCH] thermal/ti-soc-thermal: fix spelling and kernel-doc
Date: Wed, 10 Jan 2024 21:02:05 -0800
Message-ID: <20240111050205.2941-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix spelling mistakes as reported by codespell.
Fix all kernel-doc warnings.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Keerthy <j-keerthy@ti.com>
Cc: linux-omap@vger.kernel.org
Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org
---
 drivers/thermal/ti-soc-thermal/ti-bandgap.c |   14 +++++++-------
 drivers/thermal/ti-soc-thermal/ti-bandgap.h |    6 ++++--
 2 files changed, 11 insertions(+), 9 deletions(-)

diff -- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
--- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
+++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
@@ -332,7 +332,7 @@ static inline int ti_bandgap_validate(st
  * ti_bandgap_read_counter() - read the sensor counter
  * @bgp: pointer to bandgap instance
  * @id: sensor id
- * @interval: resulting update interval in miliseconds
+ * @interval: resulting update interval in milliseconds
  */
 static void ti_bandgap_read_counter(struct ti_bandgap *bgp, int id,
 				    int *interval)
@@ -352,7 +352,7 @@ static void ti_bandgap_read_counter(stru
  * ti_bandgap_read_counter_delay() - read the sensor counter delay
  * @bgp: pointer to bandgap instance
  * @id: sensor id
- * @interval: resulting update interval in miliseconds
+ * @interval: resulting update interval in milliseconds
  */
 static void ti_bandgap_read_counter_delay(struct ti_bandgap *bgp, int id,
 					  int *interval)
@@ -394,7 +394,7 @@ static void ti_bandgap_read_counter_dela
  * ti_bandgap_read_update_interval() - read the sensor update interval
  * @bgp: pointer to bandgap instance
  * @id: sensor id
- * @interval: resulting update interval in miliseconds
+ * @interval: resulting update interval in milliseconds
  *
  * Return: 0 on success or the proper error code
  */
@@ -427,7 +427,7 @@ exit:
  * ti_bandgap_write_counter_delay() - set the counter_delay
  * @bgp: pointer to bandgap instance
  * @id: sensor id
- * @interval: desired update interval in miliseconds
+ * @interval: desired update interval in milliseconds
  *
  * Return: 0 on success or the proper error code
  */
@@ -471,7 +471,7 @@ static int ti_bandgap_write_counter_dela
  * ti_bandgap_write_counter() - set the bandgap sensor counter
  * @bgp: pointer to bandgap instance
  * @id: sensor id
- * @interval: desired update interval in miliseconds
+ * @interval: desired update interval in milliseconds
  */
 static void ti_bandgap_write_counter(struct ti_bandgap *bgp, int id,
 				     u32 interval)
@@ -486,7 +486,7 @@ static void ti_bandgap_write_counter(str
  * ti_bandgap_write_update_interval() - set the update interval
  * @bgp: pointer to bandgap instance
  * @id: sensor id
- * @interval: desired update interval in miliseconds
+ * @interval: desired update interval in milliseconds
  *
  * Return: 0 on success or the proper error code
  */
@@ -871,7 +871,7 @@ static struct ti_bandgap *ti_bandgap_bui
 }
 
 /*
- * List of SoCs on which the CPU PM notifier can cause erros on the DTEMP
+ * List of SoCs on which the CPU PM notifier can cause errors on the DTEMP
  * readout.
  * Enabled notifier on these machines results in erroneous, random values which
  * could trigger unexpected thermal shutdown.
diff -- a/drivers/thermal/ti-soc-thermal/ti-bandgap.h b/drivers/thermal/ti-soc-thermal/ti-bandgap.h
--- a/drivers/thermal/ti-soc-thermal/ti-bandgap.h
+++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.h
@@ -189,8 +189,10 @@ struct temp_sensor_regval {
  * @div_clk: pointer to divider clock of temperature sensor fclk
  * @lock: spinlock for ti_bandgap structure
  * @irq: MPU IRQ number for thermal alert
- * @tshut_gpio: GPIO where Tshut signal is routed
+ * @tshut_gpiod: GPIO where Tshut signal is routed
  * @clk_rate: Holds current clock rate
+ * @nb: notifier block
+ * @is_suspended: set if the bandgap device is suspended
  *
  * The bandgap device structure representing the bandgap device instance.
  * It holds most of the dynamic stuff. Configurations and sensor specific
@@ -276,7 +278,7 @@ struct ti_temp_sensor {
  * TI_BANDGAP_FEATURE_HISTORY_BUFFER - used when the bandgap device features
  *	a history buffer of temperatures.
  *
- * TI_BANDGAP_FEATURE_ERRATA_814 - used to workaorund when the bandgap device
+ * TI_BANDGAP_FEATURE_ERRATA_814 - used to workaround when the bandgap device
  *	has Errata 814
  * TI_BANDGAP_FEATURE_UNRELIABLE - used when the sensor readings are too
  *	inaccurate.

