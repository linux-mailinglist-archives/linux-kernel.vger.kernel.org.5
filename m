Return-Path: <linux-kernel+bounces-128615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A17A895D17
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11B4AB237DC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E10015E5BB;
	Tue,  2 Apr 2024 19:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a/10wS2Y"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D09715DBB7;
	Tue,  2 Apr 2024 19:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712087600; cv=none; b=Q7LfTgSfuhgoZw+v7DKUgjRruQ0zV+6ZdAenBf93iswJgw7PsTvM+D/ROfXykJP6/DImwqvxZiEusFGaOoaDDU8XcnrlsGx6EL0qA1nrgjoXZH6+gHOCLDRSwi2f74te5jpTmLt8zvEtTOZonDA40Fhdh+YKpzobPbuSdxyYCjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712087600; c=relaxed/simple;
	bh=7uF+Ni2y2wMkDzn7LDrpsM+dIWXMZVCj7KGProB4/7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mfXpe6AGmAn6cdlYGvhK5IvHSUXaP6mOJP/lsOEAzWqMEOmm4EkR0rpl6Nqw49S+0dbZ5LTzKJGH3oRmt6gnuDF0uFEI/tUn+a2v7qoPZsb4Mfj9YucKCdCWVP1cqwCpTKDv7jwAK6w1FLAcaps7+jenPlc9yxg35sRURDq4Yo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a/10wS2Y; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712087599; x=1743623599;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7uF+Ni2y2wMkDzn7LDrpsM+dIWXMZVCj7KGProB4/7U=;
  b=a/10wS2Ysnn2QwnJzXKi7euUh9maBiUhRmfRmTynxG2gNOOB1lzrIet/
   KBBpS0pwkhcOVP8FwZIpXBkwwDS/rJrTFdeRRhJSZXKJ01aPOXVBDyz1L
   aNzuI0Ji5Nqt/SpZzXSs81MfXinczpJO7dItPYooVY2xXP9Bo18lphT/n
   FTtziBoIrr1vRzo08Nj0/UyZ0XcrDJOWbiGOwn+sdxVS4vFwaYgI93HMa
   6eH8K9pXS2hc0NZrTmRoN9S11nAfACGCvY8/2jjr3MJtcyTFFlMjUiC0+
   g2L+99hlpPUJtaNBI8VCDIy+76HuPJJJ7t6UZDqdaP7FSXAE3L8BaXsp+
   g==;
X-CSE-ConnectionGUID: ZWslMqamT4iYaWrjBCnzgg==
X-CSE-MsgGUID: /zNIbKQ4SIy6Fk52gcyUzA==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="7151013"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="7151013"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 12:53:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="937083792"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="937083792"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 02 Apr 2024 12:53:13 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 5159C16A1; Tue,  2 Apr 2024 22:53:10 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Hugo Villeneuve <hugo@hugovil.com>
Subject: [PATCH v2 14/16] serial: max3100: Remove unneeded forward declaration
Date: Tue,  2 Apr 2024 22:50:41 +0300
Message-ID: <20240402195306.269276-15-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240402195306.269276-1-andriy.shevchenko@linux.intel.com>
References: <20240402195306.269276-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no code using max3100_work() before the definition of it.
Remove unneeded forward declaration.

While at it, move max3100_dowork() and max3100_timeout() down in
the code to be after actual max3100_work() implementation.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/max3100.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
index b068175ef9c3..5a28df2564b2 100644
--- a/drivers/tty/serial/max3100.c
+++ b/drivers/tty/serial/max3100.c
@@ -150,22 +150,6 @@ static void max3100_calc_parity(struct max3100_port *s, u16 *c)
 		*c |= max3100_do_parity(s, *c) << 8;
 }
 
-static void max3100_work(struct work_struct *w);
-
-static void max3100_dowork(struct max3100_port *s)
-{
-	if (!s->force_end_work && !freezing(current) && !s->suspending)
-		queue_work(s->workqueue, &s->work);
-}
-
-static void max3100_timeout(struct timer_list *t)
-{
-	struct max3100_port *s = from_timer(s, t, timer);
-
-	max3100_dowork(s);
-	mod_timer(&s->timer, jiffies + uart_poll_timeout(&s->port));
-}
-
 static int max3100_sr(struct max3100_port *s, u16 tx, u16 *rx)
 {
 	struct spi_message message;
@@ -313,6 +297,20 @@ static void max3100_work(struct work_struct *w)
 		tty_flip_buffer_push(&s->port.state->port);
 }
 
+static void max3100_dowork(struct max3100_port *s)
+{
+	if (!s->force_end_work && !freezing(current) && !s->suspending)
+		queue_work(s->workqueue, &s->work);
+}
+
+static void max3100_timeout(struct timer_list *t)
+{
+	struct max3100_port *s = from_timer(s, t, timer);
+
+	max3100_dowork(s);
+	mod_timer(&s->timer, jiffies + uart_poll_timeout(&s->port));
+}
+
 static irqreturn_t max3100_irq(int irqno, void *dev_id)
 {
 	struct max3100_port *s = dev_id;
-- 
2.43.0.rc1.1.gbec44491f096


