Return-Path: <linux-kernel+bounces-155309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C5E8AE89D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC793B25482
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91E61369A9;
	Tue, 23 Apr 2024 13:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EVFwk1uP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF4C135414;
	Tue, 23 Apr 2024 13:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713880188; cv=none; b=uaQmvceCJxzWx+rZVugaD+Z91UWrvIeG1cJgNXd0qRgCgQqtt/n21j7adU6AmknQuypjeSlxb4yNvZrznrGRtwBG2zwGx6wGER4k7TRI9u01NnWOgA1xrIJTa4auU3KbJ9bvJu4ZsiLyhRmCQ93Jpmp81XTwjghw8eM7wFZa7oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713880188; c=relaxed/simple;
	bh=y+FZeyag9s8pm1Ma8OkWI5S3u24aLPE9Q9mxzb0cHBk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=I7OK83xNxzUwD+4sud0nfMX/OR6SF0OVoqSaZP9sV5z432mYTOOTOqVcwQPrIjohUjARXPQd2zyXuY/I/HinRr3/y528ZzqFHpeD5+Z/N3GT/xcihy91EK5HbI2eX34LwM02qhmvS8SRQvwWKaEhiACJ0eJGeI2ikd2hL//ZQ54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EVFwk1uP; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713880187; x=1745416187;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=y+FZeyag9s8pm1Ma8OkWI5S3u24aLPE9Q9mxzb0cHBk=;
  b=EVFwk1uPchbDPOadAHSPHVfXeAuNnzgLdKEv+s14a/4Eo+f+6aJbG+1h
   8QgM+SdjZhLYqE84kvMqyCHSNpQ0Y25fmZ0IiTdjDHP1BmzAGn0jSZYLr
   N2kIPyknRSeHjatByocR6NnEwn00Kchl4/+kd4iR/8pitUbFg5F9j/rwO
   hbemT5TTr4kqJPYhCYEHlgtRqfpeP5GwQfnfcoQIPuTNiHdoap1HjybcX
   XtoUGqK7Bjg1xagH3R/a96ZmkJ6OiCKUI5MJ3ixG70mlqdkWTThnGMAKu
   aD2Wfn7Vox4G5XjSglhhlzCuY/W06lDKgHOL3dFLFBol7VWV/hNXjRvtE
   Q==;
X-CSE-ConnectionGUID: fFmRgJ0TSVaXm/XpuXUpgQ==
X-CSE-MsgGUID: +Rsi5yraTfuW147DeB8ebA==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="9328669"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="9328669"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 06:49:46 -0700
X-CSE-ConnectionGUID: oXwvmcs+SEiePFvZ/6u8nw==
X-CSE-MsgGUID: tY/hyZlaQP+/EYsyk3kyyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="61835291"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.40])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 06:49:43 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/1] serial: 8250_pnp: Simplify "line" related code
Date: Tue, 23 Apr 2024 16:49:30 +0300
Message-Id: <20240423134930.67033-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

8250_pnp sets drvdata to line + 1 if the probe is successful. The users
of drvdata are in remove, suspend and resume callbacks, none of which
will be called if probe failed. The line acquired from drvdata can
never be zero in those functions and the checks for that can be
removed.

Eliminate also +/-1 step because all users of line subtract 1 from the
value.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/8250/8250_pnp.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pnp.c b/drivers/tty/serial/8250/8250_pnp.c
index 8f72a7de1d1d..fc206afaf671 100644
--- a/drivers/tty/serial/8250/8250_pnp.c
+++ b/drivers/tty/serial/8250/8250_pnp.c
@@ -434,8 +434,9 @@ static int
 serial_pnp_probe(struct pnp_dev *dev, const struct pnp_device_id *dev_id)
 {
 	struct uart_8250_port uart, *port;
-	int ret, line, flags = dev_id->driver_data;
+	int ret, flags = dev_id->driver_data;
 	unsigned char iotype;
+	long line;
 
 	if (flags & UNKNOWN_DEV) {
 		ret = serial_pnp_guess_board(dev);
@@ -493,7 +494,7 @@ serial_pnp_probe(struct pnp_dev *dev, const struct pnp_device_id *dev_id)
 	if (uart_console(&port->port))
 		dev->capabilities |= PNP_CONSOLE;
 
-	pnp_set_drvdata(dev, (void *)((long)line + 1));
+	pnp_set_drvdata(dev, (void *)line);
 	return 0;
 }
 
@@ -502,17 +503,14 @@ static void serial_pnp_remove(struct pnp_dev *dev)
 	long line = (long)pnp_get_drvdata(dev);
 
 	dev->capabilities &= ~PNP_CONSOLE;
-	if (line)
-		serial8250_unregister_port(line - 1);
+	serial8250_unregister_port(line);
 }
 
 static int __maybe_unused serial_pnp_suspend(struct device *dev)
 {
 	long line = (long)dev_get_drvdata(dev);
 
-	if (!line)
-		return -ENODEV;
-	serial8250_suspend_port(line - 1);
+	serial8250_suspend_port(line);
 	return 0;
 }
 
@@ -520,9 +518,7 @@ static int __maybe_unused serial_pnp_resume(struct device *dev)
 {
 	long line = (long)dev_get_drvdata(dev);
 
-	if (!line)
-		return -ENODEV;
-	serial8250_resume_port(line - 1);
+	serial8250_resume_port(line);
 	return 0;
 }
 
-- 
2.39.2


