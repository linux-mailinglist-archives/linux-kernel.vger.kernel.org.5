Return-Path: <linux-kernel+bounces-158351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C0028B1EB6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC76D284138
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 10:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0301186AFB;
	Thu, 25 Apr 2024 10:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="QlStIszc"
Received: from smtp.smtpout.orange.fr (smtp-14.smtpout.orange.fr [80.12.242.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4654684FA9;
	Thu, 25 Apr 2024 10:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714039435; cv=none; b=pN/kjsZ9PrBRh1+D05nvR5VYUlocbQ3gN24sPrdc7Cm4VZCg15HWev19Fd4jY6SnjvF091BEJQ2OR3llAXt6Vldc0ry+2+0aTy/UMe/oa9vfKbV/hUtFl/CJZRTTj0cjGOohNtforxCJditFSLdg7EtTT7Y6yCI+lRqd6s1M/WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714039435; c=relaxed/simple;
	bh=7GYrDHi2wc98+LxSD11rnonpx3B7ff5rAPOELGHgubk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FCaTz8+Kfxc3h5qa7LrxzCSng1ZD7EsDQbCrrzyGbkorTVFVgflZPSprfDONwRkUqaGvwrMQQdWc3LvlszRNIRkRJuAlxvqwh2lHz2yVXS1EpAt/qApTtpAV6wsZWMH5yze7Fw/jc0zBKkzVlIOVqk2K0u94sPaxnOYJAjEAm+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=QlStIszc; arc=none smtp.client-ip=80.12.242.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id zvxAr3Z51CEcGzvxAryaUS; Thu, 25 Apr 2024 12:03:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1714039425;
	bh=4dV+3BwCxRrU83DUCeOBwVJF38fNi8MvgvnSmXXVELI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=QlStIszc4Xr3fHlScsb3ATG/XjVV5B9xVmfLF6iB1o7JoWR0q8XYFM7FE3eMFe0Op
	 xPGV5wq9+VY0SF/Fm2CO/kLK+VE6dqkVKW2jNJOrzni20viGhc0ORVD7gr/Z12D4WX
	 s1JxBsRX0vkLfI3eXcbeiEPO6yhw1f3mY9EjjZ0/rdf/jjIGnfPo19KutPamSsRije
	 I6UiAXYy6S6ZxVr1U4A+NTmMsckpci6Y2Ne002NU+AHp/MGRy1Hqg9eq9UULY3paRi
	 6/RIuzaisV0Oc+csj4vopJNZU9TcB8g/84a+udD5r8FMtOfW/tjbUXNSL3aE+YOO2q
	 vPoe4D0iZepPw==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 25 Apr 2024 12:03:45 +0200
X-ME-IP: 86.243.17.157
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Arend van Spriel <arend.vanspriel@broadcom.com>,
	Kalle Valo <kvalo@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com
Subject: [PATCH] wifi: brcmfmac: remove unused brcmf_usb_image struct
Date: Thu, 25 Apr 2024 12:03:18 +0200
Message-ID: <23afd8c1733ad087ce2399a07a30d689aef861d5.1714039373.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct brcmf_usb_image was added in the initial commit 71bb244ba2fd5
("brcm80211: fmac: add USB support for bcm43235/6/8 chipsets") and updated
in commit 803599d40418 ("brcmfmac: store usb fw images in local linked
list.")

Its only usage was removed in commit 52f98a57d8c1 ("brcmfmac: remove
firmware list from USB driver").

Remove the structure definition now. This saves a few lines of code.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
index 0ccf735316c2..9a105e6debe1 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
@@ -117,13 +117,6 @@ struct bootrom_id_le {
 	__le32 boardrev;	/* Board revision */
 };
 
-struct brcmf_usb_image {
-	struct list_head list;
-	s8 *fwname;
-	u8 *image;
-	int image_len;
-};
-
 struct brcmf_usbdev_info {
 	struct brcmf_usbdev bus_pub; /* MUST BE FIRST */
 	spinlock_t qlock;
-- 
2.44.0


