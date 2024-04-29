Return-Path: <linux-kernel+bounces-163142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E0A8B664C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 01:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C9D61F229B1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 23:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60D6194C9F;
	Mon, 29 Apr 2024 23:33:46 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D82194C96
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 23:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714433626; cv=none; b=n6OtN0Sb2jljF9PyzObnVhn03IrmuXXUjmBZiRK3U+wejdrsZ97JofNCzDXW4L18oDlrk81SdgDk/mBDKSMjsIWcvHHXezDn4iUVr7D9vgDiRSqPlU9lavUPcA0fD2Xb9g9yLQTLyUluXk/uds9Vjxvw1Oe+PxWQlGJHx+qppgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714433626; c=relaxed/simple;
	bh=deg1vsmx/0Dnk8pti1zjkrITJ/nEeyTduEyYaMoA3fA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=t8/6y6yh0yjP/awKniK0mSSDB2VGgzTwGymq29dpWLuTHsvT1mCPx5l2k5PoVXTJDlhwQ/N4Pw9lPjczoEl+0Da6NIkyQof8duHLwT5jqjeZ12Voeb4vv+s5hoz+pmV1JpBLbuU3P83H78Mgqs45VWS8l+U9GfzFXkVKUdBlmM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1s1aV3-0000Es-9F; Tue, 30 Apr 2024 01:33:33 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1s1aUy-00F42h-St; Tue, 30 Apr 2024 01:33:28 +0200
Received: from localhost ([::1] helo=dude04.red.stw.pengutronix.de)
	by dude04.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1s1aUy-004m1K-18;
	Tue, 30 Apr 2024 01:33:28 +0200
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Subject: [PATCH v4 0/3] usb: gadget: 9pfs transport
Date: Tue, 30 Apr 2024 01:33:25 +0200
Message-Id: <20240116-ml-topic-u9p-v4-0-722ed28b0ade@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEYuMGYC/33Nyw6DIBAF0F8xrEvlJZWu+h9NF4BjJVE0oMbG+
 O9Ft30s7+TOuSuKEBxEdM1WFGB20fU+BXHKkG20fwJ2VcqIESYIpRJ3LR77wVk8qQGXqmAXUXA
 ChqL0YnQEbIL2ttmfurZr86Odp/ZeGALUbjn27o+UGxfHPryO+Znu1x9LM8UE66q0nMhaaQG3A
 fxzGkPv3XKuAO3azP4JLAlGSGvqQjEl2VeB/xN4EqxkmkuwttL0Q9i27Q1Jb2NJUgEAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4465;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=deg1vsmx/0Dnk8pti1zjkrITJ/nEeyTduEyYaMoA3fA=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBmMC5H5b1P7GLLyW8Db8nX/YjeYuNoxPw+L34f2
 jW0vpKps2WJAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCZjAuRwAKCRC/aVhE+XH0
 q1zND/9ks9YJMXY3/RWifVdze35extSnh23Vhm+HdPMbJsHuyQZd/v2rEOOReyD4iPXvlhY5VDL
 D3WtTIGrVHycRrAnXwX52LjxvzDo+FL+LS0XaBR3jV5x1HaUWCDb1Tzm5JRIIfP5/xhe8Z1Rhcs
 Bh0J44NyREbpTtbStQQWVJonMlxY0I9f5iqkP2+naoIM0PHhUHPrB75kiyXykS+cUiorJQ3lDJd
 geaKgmd+WTXSlRg4lINnxTEwFj1s/sOCsNgr+Yfu6N96fyqUWUPjHXUkxfunbZvFFIqeQfelpQx
 O3dT+k5IsP8SvaZdmU5jVGfA5EvR2TJE1h/KydTu/sguaPnpHOb5Zn5exL4ovy+HkDs4LOjIQTe
 ikw4sq/zEp2EPTmLx6u75wpC40v0lCaT1BWoH8PX+fn5PqNLXjpIv17tUTImPtFGtExJ09I43Ad
 6wmGlNbi3kBQ/NbmjZ6l4XxGYIJnYecJ0c/RGufDoxOJB/RnCmlPT6g4h2dNKuzDROmHWLI6pZK
 eR9V3lOOHtryf3+QL/kLjuD7Ks2HQHwGYMRTGFJ33LoOeRayBY/QNZiC4ttvhp1Svezxb+X1iC0
 7bM1snc/wp0X5k9emLz68OPnxQ0ux7Hc0VZ0//giUiFYSi1xBah5pcVhdF8F3omJDYXcaEToJqX
 vlmowyy5zrowdAA==
X-Developer-Key: i=m.grzeschik@pengutronix.de; a=openpgp;
 fpr=957BC452CE953D7EA60CF4FC0BE9E3157A1E2C64
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: m.grzeschik@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

This series is adding support to mount usb hostside exported 9pfs
filesystems via the usb gadget interface. It also includes a simple tool
(p9_fwd.py) to translate an tcp 9pfs transport and reuse it via the usb
interface.

    +--------------------------+    |    +--------------------------+
    |  9PFS mounting client    |    |    |  9PFS exporting server   |
 SW |                          |    |    |                          |
    |   (this:trans_usbg)      |    |    |(e.g. diod or nfs-ganesha)|
    +-------------^------------+    |    +-------------^------------+
                  |                 |                  |
                  |                 |           +------v------+
                  |                 |           |  p9_fwd.py  |
                  |                 |           +------^------+
                  |                 |                  |
------------------|------------------------------------|-------------
                  |                 |                  |
    +-------------v------------+    |    +-------------v------------+
    |                          |    |    |                          |
 HW |   USB Device Controller  <--------->   USB Host Controller    |
    |                          |    |    |                          |
    +--------------------------+    |    +--------------------------+

The USB host exports a filesystem, while the gadget on the USB device
side makes it mountable.

Diod (9pfs server) and the forwarder are on the development host, where
the root filesystem is actually stored. The gadget is initialized during
boot (or later) on the embedded board. Then the forwarder will find it
on the USB bus and start forwarding requests.

In this case the 9p requests come from the device and are handled by the
host. The reason is that USB device ports are normally not available on
PCs, so a connection in the other direction would not work.

One use-case is to use it as an alternative to NFS root booting during
the development of embedded Linux devices.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
Changes in v4:
- reworked the naming scheme to be set by the configfs instance
- added conn_cancel function to properly stop the transfers
- ensured that umount -f will work even when the host side has crahed
- added all the review feedback from Andrzej Pietrasiewicz
- Link to v3: https://lore.kernel.org/r/20240116-ml-topic-u9p-v3-0-c62a36eccda1@pengutronix.de

Changes in v3:
- dropped patch "usb: gadget: legacy: add 9pfs multi gadget" as discussed with gregkh
- Link to v2: https://lore.kernel.org/r/20240116-ml-topic-u9p-v2-0-b46cbf592962@pengutronix.de

Changes in v2:
- improved the commit messages
- introduced an patch to move the header u_f.h to include/linux/usb to compile usb gadget functions treewide
- moved usbg gadget function to net/9p/
- adderessed several comments in function driver, like the cleanup path and kbuild errors
- improved the documentation in Documentation/filesystems/9p.rst
- Link to v1: https://lore.kernel.org/r/20240116-ml-topic-u9p-v1-0-ad8c306f9a4e@pengutronix.de

---
Michael Grzeschik (3):
      usb: gadget: function: move u_f.h to include/linux/usb/
      net/9p/usbg: Add new usb gadget function transport
      tools: usb: p9_fwd: add usb gadget packet forwarder script

 Documentation/filesystems/9p.rst                |  49 +-
 drivers/usb/gadget/configfs.c                   |   2 +-
 drivers/usb/gadget/function/f_fs.c              |   2 +-
 drivers/usb/gadget/function/f_hid.c             |   2 +-
 drivers/usb/gadget/function/f_loopback.c        |   2 +-
 drivers/usb/gadget/function/f_midi.c            |   2 +-
 drivers/usb/gadget/function/f_midi2.c           |   2 +-
 drivers/usb/gadget/function/f_sourcesink.c      |   2 +-
 drivers/usb/gadget/u_f.c                        |   2 +-
 {drivers/usb/gadget => include/linux/usb}/u_f.h |   0
 net/9p/Kconfig                                  |   6 +
 net/9p/Makefile                                 |   4 +
 net/9p/trans_usbg.c                             | 983 ++++++++++++++++++++++++
 tools/usb/p9_fwd.py                             | 194 +++++
 14 files changed, 1243 insertions(+), 9 deletions(-)
---
base-commit: d03d4188908883e1705987795a09aeed31424f66
change-id: 20240116-ml-topic-u9p-895274530eb1

Best regards,
-- 
Michael Grzeschik <m.grzeschik@pengutronix.de>


