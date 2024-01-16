Return-Path: <linux-kernel+bounces-26911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD20482E7C0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 02:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4987EB21B75
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 01:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC7811CB9;
	Tue, 16 Jan 2024 01:49:55 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7F811738
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 01:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1rPYaJ-0000ky-8h; Tue, 16 Jan 2024 02:49:47 +0100
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1rPYaI-0008V6-1W; Tue, 16 Jan 2024 02:49:46 +0100
Received: from localhost ([::1] helo=dude04.red.stw.pengutronix.de)
	by dude04.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1rPYaI-001Ipo-2l;
	Tue, 16 Jan 2024 02:49:45 +0100
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Subject: [PATCH 0/3] usb: gadget: 9pfs transport
Date: Tue, 16 Jan 2024 02:49:40 +0100
Message-Id: <20240116-ml-topic-u9p-v1-0-ad8c306f9a4e@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALTgpWUC/x2NQQ6DIBAAv2L27Eag2mq/0ngAuuomgARa08T49
 6LHSWYyO2RKTBme1Q6JNs68hgKyrsAuOsyE/C4MSqhWSHlH7/CzRrb4HSL2Q6cebXcTZCSUxOh
 MaJIOdjkj77xrLrsp9inERBP/rt9rPI4/3O10p38AAAA=
To: Eric Van Hensbergen <ericvh@kernel.org>, 
 Latchesar Ionkov <lucho@ionkov.net>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: v9fs@lists.linux.dev, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
 kernel@pengutronix.de, Michael Grzeschik <m.grzeschik@pengutronix.de>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1093;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=yz02KOmKzCnyEnnJvy2TSYDyudqgNT9HDEHjky0bkZg=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBlpeC4eGnIeVv6q2r2za78NnD4LRJcDemS2iPCo
 ZjmU2vhwsCJAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCZaXguAAKCRC/aVhE+XH0
 q63ZEACXBcFZ+eKSrlX1JwFTf2fPMxfzw6hTh/SKjMP4mmR6xEiCgpOBas6tL1IJKNEB389Hw6S
 bV0Xl5VoTBmf2EtCfMkJWsbnpfcgCXQAmAIys7gDqXY+jIzElxosH5sZnljJJv/qgQkz96Afxof
 gGkHkU4He560W1YWA4FCb7xTt4uFjGxhBg9zK+6wNGY+tf8scpkztkwvWhSf+HPBuxK1OotOgur
 B3qes3ZJUIraZnC1gj49LAQc3+DnnJWcpq0vgGblRZQTM/MW4m3WWGO2rHnmhGaHScaxVDRQ3kH
 m4DnRksRDY4eaYWeJ0YSM8LzaubZwzur/3QhBr6s/lkaO6VSSAQO6PbnotIlh2Hm937nFXE0G5v
 NGl1V4qIlaq/9txAwVJBzKOemP/TRcqxdcjHm8UVLj6hc5RmyKxw842CoEIqOr8kOqHBFEC8ygv
 NNbnkS9VfNPfwYP0tApK8F6U2FdJ+l/nYIbYOUBWB3I/plYZq/DPja4JBqmzCmkcvWRFkToGcLm
 h1pqCZZasDgADhBIjl0C1BFx0MYeGZS/rVhJhucGBCbrIpJE47VzDCj/nQwbgTaNP6jngP9WYgu
 XtLs6LVyt+Lkqo5Sz0ECwt50uACWgKgswFcLRsNZeyufO8qt5viZcD3/i8T5Uq0WOavfjMM7Gw2
 mKRita8UMrLLqMA==
X-Developer-Key: i=m.grzeschik@pengutronix.de; a=openpgp;
 fpr=957BC452CE953D7EA60CF4FC0BE9E3157A1E2C64
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: m.grzeschik@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

This series is adding support to mount 9pfs exported filesystems via the
usb gadget interface. It also includes tools and descriptions on how to
translate an tcp 9pfs and use it via the usb interface.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
Michael Grzeschik (3):
      usb: gadget: function: 9pfs
      usb: gadget: legacy: add 9pfs multi gadget
      tools: usb: p9_fwd: add usb gadget packet forwarder script

 Documentation/filesystems/9p.rst     |  12 +
 drivers/usb/gadget/Kconfig           |  11 +
 drivers/usb/gadget/function/Makefile |   2 +
 drivers/usb/gadget/function/f_9pfs.c | 849 +++++++++++++++++++++++++++++++++++
 drivers/usb/gadget/legacy/9pfs.c     | 260 +++++++++++
 drivers/usb/gadget/legacy/Kconfig    |  15 +
 drivers/usb/gadget/legacy/Makefile   |   2 +
 tools/usb/p9_fwd.py                  | 194 ++++++++
 8 files changed, 1345 insertions(+)
---
base-commit: 052d534373b7ed33712a63d5e17b2b6cdbce84fd
change-id: 20240116-ml-topic-u9p-895274530eb1

Best regards,
-- 
Michael Grzeschik <m.grzeschik@pengutronix.de>


