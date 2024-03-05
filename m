Return-Path: <linux-kernel+bounces-91704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C569871570
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 06:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3110C1C22141
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 05:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024EA78B47;
	Tue,  5 Mar 2024 05:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZzL3XOL"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CDF4CB23;
	Tue,  5 Mar 2024 05:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709617979; cv=none; b=eZvuU3lmVrnbMXqBBJ/s3nYXWEDoZaIlS3OOZRvVJBshJ7fZXY/svKV9WH7YdrlCuljja/zUz5amyGactl2PX1IASG1vNrtq0Oe3wnh20ak14dAgVrhaJ3/+cc+x8C1H51mP82ii1TLV2AUrLnWwDiu6kqseH+WS+HUVhMIe4GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709617979; c=relaxed/simple;
	bh=AYLW1//dy5xf/Pa6/bMw0sJZYBaMmhOjIUuu7n6/e20=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=tSfOaq1U/jS2XLdwxPd2bbBMZwypQ7btPV+ZXJtQj3RVg6sGXFjKUsZE2Q5Qvd9bWobaeu1Y5QKaKyzhMTRetd+tA4/QmBAI4nLoi0ef01lIb/8IYQPBGtVFoC8D5gbHbP9Mn7q22mWzluDQwexB9ututo4R6Wb/iYvgkr27JVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QZzL3XOL; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a44ad785a44so421714766b.3;
        Mon, 04 Mar 2024 21:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709617976; x=1710222776; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iNfYyJIcPqgZYHnSjE0qasYntQo5CxIhhJdeJyjsmfw=;
        b=QZzL3XOL1xc672TYpD8ukwE02VzHdss8nj1V4KsoThzvtccgcf4K+xXKfBFv0RBYtB
         4FfWOSmpLSCqUjhEUFe8gJLm/SRGO8F27WBTyTxUNbulxSt8EQZVpdB7F4spCL3rrtCd
         h6E/iln/1nxgoXhr/DpAWzzHxSn5Rk4xbLmD7IYrj4eGvjg7XyjVoV5DoJjSY+6EnIAZ
         rJ0TIrYbcSIOXu9VlT/huDdoVGtLHPIgK2j1k1o9nJMeZRw2jzWwZH5wp9cct4BaWIdp
         QqFGTdzFL/8XBAYuSTC9+SW+zRVh9i+pubdK8rSQB1S2rybU9si7qCyMO4QUMYRRtrwn
         Ir7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709617976; x=1710222776;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iNfYyJIcPqgZYHnSjE0qasYntQo5CxIhhJdeJyjsmfw=;
        b=dAuT1Vr73EuyfM8Udfp3+R8mvIaTjqBAs/FmTe7OqhVieN2dX7T76/J/LxqKrB8959
         a5m7bDHGGGeDQhW3yIC7odzOeB4b8qPVilzKOqVFqn9qUEvZeM0PgoIGqgEVYq+GXWAd
         cf9BnhjR5ur/xRZaf3LsBbXP/3XggLmCVYjdN7FR9jKjhK2ThxEHJayh5nEGFnDRkSVb
         mt/fZXEE0Z9U6CH1cyJXMmoDhw/4Fu9tukvYpG3vDjYd+aAO8U2HDdf7nlMyoeVAMsnn
         ZMo2s5kAgMkI5febF0ZWAVMsRTgpfZqBBCOHQb0T4pOAuJK8onxSBIVBWw8e+AbFOTyM
         TfCg==
X-Forwarded-Encrypted: i=1; AJvYcCVL5f5dlHh79QUJZB1B9mDaC3I1s8fT1qH2Ym478SgXYJpQo0tpu4P8tRkAE+/mRsXNc+noaoDxygXiQu1onvRUvBAV0Jn8LY/QjKjp
X-Gm-Message-State: AOJu0Yw+MNgxmT20ViSOBB9OhgDaNQKhZRo0c/HIKxH7vXDilVq2OAWV
	WsRC4RNMHW4bmrS8TR3ik7sBVGiYm+RwlOxeZux5314UpRcjNw4h
X-Google-Smtp-Source: AGHT+IGvy4VyIAdGOPrnkE7IhGVpRILLK08YsbaHw7JmOvxFg/w40x+sca9mmrhsXAZ8uYYraF94mw==
X-Received: by 2002:a17:906:c7c3:b0:a3e:34e8:626f with SMTP id dc3-20020a170906c7c300b00a3e34e8626fmr7917401ejb.66.1709617975573;
        Mon, 04 Mar 2024 21:52:55 -0800 (PST)
Received: from [127.0.1.1] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id lb24-20020a170906add800b00a4131367204sm5633692ejb.80.2024.03.04.21.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 21:52:54 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Tue, 05 Mar 2024 06:52:43 +0100
Subject: [PATCH] Revert "Input: bcm5974 - check endpoint type before
 starting traffic"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-revert_bcm5974_ep_check-v1-1-db4f0422588f@gmail.com>
X-B4-Tracking: v=1; b=H4sIACqz5mUC/x2MWwqAIBAArxL7nWA+krpKhJittUQPNCKI7p70O
 TAzDySMhAna4oGIFyXatwxVWYCf3TYhozEzCC4Ul1yzLGE87eBX3Rhl8bB+Rr8waYJwtRuEqRT
 k+ogY6P7PXf++H3gbtSlpAAAA
To: Henrik Rydberg <rydberg@bitmath.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 regressions@lists.linux.dev, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709617973; l=3264;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=AYLW1//dy5xf/Pa6/bMw0sJZYBaMmhOjIUuu7n6/e20=;
 b=UMHi2tDKeW5/xZXMWhszo8IKwIEF/XFtfTC1wu/2uAqsqt23o93AXZH5YXy07BHLyF95heJKC
 CCY2je1DrW5AQw/LSqjiWqQ/UfXIwthZbU1UVxsSQma86cFcpidBO5V
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=

This patch intended to fix an well-knonw issue in old drivers where the
endpoint type is taken for granted, which is often triggered by fuzzers.

That was the case for this driver [1], and although the fix seems to be
correct, it uncovered another issue that leads to a regression [2] if
the endpoints of the current interface are checked. The driver makes use
of endpoints that belong to a different interface rather than the one it
binds (it binds to the third interface, but also accesses an endpoint
from a different one). The driver should claim the interfaces it
requires, but that is still not the case.

Given that the regression is more severe than the issue found by
syzkaller, the best approach is reverting the patch that causes the
regression, and trying to fix the underlying problem before checking
the endpoint types again.

Note that reverting this patch will probably trigger the syzkaller bug
at some point.

[1] https://syzkaller.appspot.com/bug?extid=348331f63b034f89b622
[2] https://lore.kernel.org/linux-input/ab9d758c-3ce9-42f6-99af-877055a589e6@leemhuis.info/T/#t

This reverts commit 2b9c3eb32a699acdd4784d6b93743271b4970899.

Fixes: b516b1b0dfcc ("Revert "Input: bcm5974 - check endpoint type before starting traffic"")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/input/mouse/bcm5974.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/input/mouse/bcm5974.c b/drivers/input/mouse/bcm5974.c
index 953992b458e9..ca150618d32f 100644
--- a/drivers/input/mouse/bcm5974.c
+++ b/drivers/input/mouse/bcm5974.c
@@ -19,7 +19,6 @@
  * Copyright (C) 2006	   Nicolas Boichat (nicolas@boichat.ch)
  */
 
-#include "linux/usb.h"
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/slab.h>
@@ -194,8 +193,6 @@ enum tp_type {
 
 /* list of device capability bits */
 #define HAS_INTEGRATED_BUTTON	1
-/* maximum number of supported endpoints (currently trackpad and button) */
-#define MAX_ENDPOINTS	2
 
 /* trackpad finger data block size */
 #define FSIZE_TYPE1		(14 * sizeof(__le16))
@@ -894,18 +891,6 @@ static int bcm5974_resume(struct usb_interface *iface)
 	return error;
 }
 
-static bool bcm5974_check_endpoints(struct usb_interface *iface,
-				    const struct bcm5974_config *cfg)
-{
-	u8 ep_addr[MAX_ENDPOINTS + 1] = {0};
-
-	ep_addr[0] = cfg->tp_ep;
-	if (cfg->tp_type == TYPE1)
-		ep_addr[1] = cfg->bt_ep;
-
-	return usb_check_int_endpoints(iface, ep_addr);
-}
-
 static int bcm5974_probe(struct usb_interface *iface,
 			 const struct usb_device_id *id)
 {
@@ -918,11 +903,6 @@ static int bcm5974_probe(struct usb_interface *iface,
 	/* find the product index */
 	cfg = bcm5974_get_config(udev);
 
-	if (!bcm5974_check_endpoints(iface, cfg)) {
-		dev_err(&iface->dev, "Unexpected non-int endpoint\n");
-		return -ENODEV;
-	}
-
 	/* allocate memory for our device state and initialize it */
 	dev = kzalloc(sizeof(struct bcm5974), GFP_KERNEL);
 	input_dev = input_allocate_device();

---
base-commit: 90d35da658da8cff0d4ecbb5113f5fac9d00eb72
change-id: 20240305-revert_bcm5974_ep_check-37f2a6ab2714

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


