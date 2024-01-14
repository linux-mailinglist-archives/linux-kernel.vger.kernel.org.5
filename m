Return-Path: <linux-kernel+bounces-25553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB9282D242
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 23:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6116D281768
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 22:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435C72C1BF;
	Sun, 14 Jan 2024 22:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cxMyM7oC"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CC4F4F3
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 22:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CA69440002;
	Sun, 14 Jan 2024 22:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1705272763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=E+pmWiFAk9xDSX3xHw8tyfQSE8GLes3W457god8mEvU=;
	b=cxMyM7oCZSziHqrnDSE/nfEKYLW0fXqfDBpGGENQQPEuhUNCwFwSAu0y+EMs7OhvVo0fKa
	DTYGi4nUcDKVXHasP2EWXiJ7F1EhVxuqquW8tpHDTis9+86a8C9spd83ty1qlKbAL2wccr
	VSOxNdzRdSKi7vMgSkB8FemMfOiQTZq9ZLZRY1xzIpYbNCXIvYaS5ZOSUftnJJKHYQzLT/
	2RnSR+f6VaYg8GafFi3eFNA9W3pCJmXAuckix2LHpTPN2BhSiqXuVwYRbksTwqnaj/C7uT
	ZqbZ9w3kqMFTXfKLwGdsAH604MvxAB+AjF8OXlq1/oXfGT6XJUb2sGIplZUlng==
From: alexandre.belloni@bootlin.com
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] i3c: document hotjoin sysfs entry
Date: Sun, 14 Jan 2024 23:52:25 +0100
Message-ID: <20240114225232.140860-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexandre.belloni@bootlin.com

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

The hotjoin syfs entry allows to enable or disable Hot-Join on the Current
Controller of the I3C Bus.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 Documentation/ABI/testing/sysfs-bus-i3c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-i3c b/Documentation/ABI/testing/sysfs-bus-i3c
index e5248fd67a56..c812ab180ff4 100644
--- a/Documentation/ABI/testing/sysfs-bus-i3c
+++ b/Documentation/ABI/testing/sysfs-bus-i3c
@@ -88,6 +88,21 @@ Description:
 		This entry describes the HDRCAP of the master controller
 		driving the bus.
 
+What:		/sys/bus/i3c/devices/i3c-<bus-id>/hotjoin
+KernelVersion:  6.8
+Contact:	linux-i3c@vger.kernel.org
+Description:
+		I3C’s Hot-Join mechanism allows an I3C Device to inform the
+		Active Controller that a newly-joined Target is present on the
+		I3C Bus and is ready to receive a Dynamic Address, in order to
+		become fully functional on the Bus. Hot-Join is used when the
+		Target is mounted on the same I3C bus and remains depowered
+		until needed or until the Target is physically inserted into the
+		I3C bus
+
+		This entry allows to enable or disable Hot-join of the Current
+		Controller driving the bus.
+
 What:		/sys/bus/i3c/devices/i3c-<bus-id>/<bus-id>-<device-pid>
 KernelVersion:  5.0
 Contact:	linux-i3c@vger.kernel.org
-- 
2.43.0


