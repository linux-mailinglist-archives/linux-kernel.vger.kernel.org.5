Return-Path: <linux-kernel+bounces-9397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5FA881C4FF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 07:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D96331C23D04
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 06:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E87F8C14;
	Fri, 22 Dec 2023 06:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SgSmDTZc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2192DDAB;
	Fri, 22 Dec 2023 06:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=vcXjkACtt3w1L/iqeM+O5LdUiTqdAb5DknSdUDcSKoc=; b=SgSmDTZcnoh8EPslL2Q+3FamC+
	YeOAMA8kz00VkR8vEe+udxLOtP6sTjlBj0aY38cKjVeeg06v18ldqz4ehKCXoqLWG0emXRs5/2KCE
	tKb2QURK3ygLRQoNHs08YlNrHxl1rgIE8Iksc6eJyaUSz++xS7Mp0wejEW1wrddbFK+dmsIPraB0P
	ba5wl6wOyPSz3bdRO6CAJxeGZX6trtDLxKSQ3LOy/mvLb+TTq9LqadG+Y2cvjRq+XEJt21QErwk1i
	aEKIDHHv7IpNzCtwZzl8iY6FYhs3bkSdTV+ZIN1IhW+av48U/TzCLsDs+B3yAOn0LJ03r4m2xkNYx
	a+sNasaw==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rGYsd-0053gU-31;
	Fri, 22 Dec 2023 06:19:31 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org
Subject: [PATCH] thermal: max7620: fix all kernel-doc warnings
Date: Thu, 21 Dec 2023 22:19:31 -0800
Message-ID: <20231222061931.10807-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct all kernel-doc notation to prevent warnings from
scripts/kernel-doc:

max77620_thermal.c:48: warning: Function parameter or member 'tz' not described in 'max77620_thermal_read_temp'
max77620_thermal.c:48: warning: Excess function parameter 'data' description in 'max77620_thermal_read_temp'
max77620_thermal.c:48: warning: No description found for return value of 'max77620_thermal_read_temp'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-pm@vger.kernel.org
---
 drivers/thermal/max77620_thermal.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -- a/drivers/thermal/max77620_thermal.c b/drivers/thermal/max77620_thermal.c
--- a/drivers/thermal/max77620_thermal.c
+++ b/drivers/thermal/max77620_thermal.c
@@ -32,7 +32,7 @@ struct max77620_therm_info {
 
 /**
  * max77620_thermal_read_temp: Read PMIC die temperatue.
- * @data:	Device specific data.
+ * @tz:		pointer to &thermal_zone_device
  * @temp:	Temperature in millidegrees Celsius
  *
  * The actual temperature of PMIC die is not available from PMIC.
@@ -41,7 +41,7 @@ struct max77620_therm_info {
  * If threshold has not been crossed then assume die temperature as 100degC
  * else 120degC or 140deG based on the PMIC die temp threshold status.
  *
- * Return 0 on success otherwise error number to show reason of failure.
+ * Return: %0 on success otherwise error number to show reason of failure.
  */
 
 static int max77620_thermal_read_temp(struct thermal_zone_device *tz, int *temp)

