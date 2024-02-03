Return-Path: <linux-kernel+bounces-51324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC488489CF
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 00:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDED11C22269
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 23:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5F2168C4;
	Sat,  3 Feb 2024 23:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="baKu5Kak"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6251016436;
	Sat,  3 Feb 2024 23:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707004494; cv=none; b=Cri4WsqxcBQciDynv/+ZVj+ewvvvROG//5rd7NzW1c/+BtCrD/zXYJbeEXd57mONyV80aPFjMBgB8lCctK8Ml7L77slFoO6HE/W5YjbBEKyj+Aumqkn0d9Azr3or/SYyFJ4Jkv+Jjhz1H/7Ir5a4E6DTusrYWPCmi4wTy6gy8HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707004494; c=relaxed/simple;
	bh=eQyjHYQAZ/iU45xmzwCXi10gQml0ia8HLSDyflfKzIc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MeERyoloxTYmtvWDBtwWvAEEH1pk6ON1DhGEo13MwaJ+H4okd05dEA4se3jEwI2qikFcvgRAbYcDbfGlmysYHjeOWTJZaiQk4MWEwfEIn9GgmV4WA4vTtc+MTXkBklayiyd5R7dDUgfaK0TMDYbDwWsTY4bXSclhzxifEeykrzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=baKu5Kak; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40ef64d8955so29803945e9.3;
        Sat, 03 Feb 2024 15:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707004490; x=1707609290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m2UMKoFcK4wh3ZcVjxqCTfGH8GhWg4G2rR6ZKhHXo4Y=;
        b=baKu5Kakmq4JnhMTTAkA9xFwsIYUimmuDAVgincQCg4i7tNfnyKNX0BHYUsRq94K7H
         eNVRmxVpdcdddjNu+mr2+OLCFkva71MzElmyGGSTQGKnudwlFmpJFQwX7LQYQ+e6WGPR
         iRCsLOP+b/q9TbTYXieW6u1/BDWKG+adw6eU8pBnMlqOLMjijbCW5LbfjzlfZgCSlJYv
         PNpIi53QLw3sPwXd+TBNp0OI/PF/Ci8QfojlvqgeVlx9Xd4vmTkKoF9saHM0aeXH2YVl
         3dLUKtZcUSVkSKAJF8FRmqMl1mua6bWJ05uP4XVk5cakddeyP7U32a8UYVlE0jW5VmYJ
         Q7Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707004490; x=1707609290;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m2UMKoFcK4wh3ZcVjxqCTfGH8GhWg4G2rR6ZKhHXo4Y=;
        b=LvfOfElCRYzHqfHRAa/AS57sBvtIIdBPeVDmup12NMsCZsbrQJ8ydTt+xqbSZSSst7
         qWdk3UPa1HaRJN7yw8bOB3ZuLhGal7GZ8lRXtryLE6itHsDZvve44qI7PRqLJyKP5gl0
         fg/pXPqlP53xRE/XLDAiv7gGiGUJsauvjsugtr558HxtEOd9jaQUT7fnSOrXk/fDDEzc
         nts1Xvc2rY+RgKJv/J0ODqzoxOkDMRMp/8lRvKmuIdgdng3xTQbr+A+AGKkuYPrCSrr7
         B2JPxDZK/N1Uh0fJkv2XC+YK7Ukj5HQi3B2Tqo8ygqOR77EyLnnZ63ylp0wg141YVGsk
         /78A==
X-Gm-Message-State: AOJu0YxSShZNWuj0gIX10sy7Ggas+SC7w8+fprEgPdpk4K9YYD5EL+/s
	JDJgzt4pWtv93Mt9V0p9SLxge8Mgw1IXRlxCSZj0fKknFisNYQYK
X-Google-Smtp-Source: AGHT+IH8/8dQl8i3DvDOzAG1waxr9XwcgMTXpdlgsWwHdPY1U+MI5TwUQoQfMXx6OSI3ox9XNpr/gA==
X-Received: by 2002:a05:600c:3594:b0:40e:a569:3555 with SMTP id p20-20020a05600c359400b0040ea5693555mr1815554wmq.35.1707004490421;
        Sat, 03 Feb 2024 15:54:50 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWcLM6iuqsM7llfMG+jxZIMr/2tcxT71Wz2lUQgOSa8U7u3KjBDSxmX3m5oXtQc1a3lQgsNI1svoI9DQk1nAFXfANn5J7VcT9fm5tjliM5RLrKKQxkufl8k6971XOO/i83HKTgzcWa4BowQrXPscY1KoIjUuWvyzGpB9osHKog3TtFlDSR5ymax2WfECZnGstk9IJCwS1gqXwVMr4VUsrXdswY0/FlBdj49+Ax1y9wDly7h7Ty+bFCbmCd6g7o++sL7PA2UUtxR3pI3coXZoV5m0BHhHXGFlRtKxPUsm7pIiR6LaWJW013V7peQos+8E45W1zc2EBILQR5pDkRF88hunVnm6v/g
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id g6-20020a05600c310600b0040fd1e2a773sm2659512wmo.47.2024.02.03.15.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 15:54:49 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Christian Marangi <ansuelsmth@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Li Zetao <lizetao1@huawei.com>,
	linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] leds: trigger: netdev: Fix kernel panic on interface rename trig notify
Date: Sun,  4 Feb 2024 00:54:01 +0100
Message-ID: <20240203235413.1146-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit d5e01266e7f5 ("leds: trigger: netdev: add additional specific link
speed mode") in the various changes, reworked the way to set the LINKUP
mode in commit cee4bd16c319 ("leds: trigger: netdev: Recheck
NETDEV_LED_MODE_LINKUP on dev rename") and moved it to a generic function.

This changed the logic where, in the previous implementation the dev
from the trigger event was used to check if the carrier was ok, but in
the new implementation with the generic function, the dev in
trigger_data is used instead.

This is problematic and cause a possible kernel panic due to the fact
that the dev in the trigger_data still reference the old one as the
new one (passed from the trigger event) still has to be hold and saved
in the trigger_data struct (done in the NETDEV_REGISTER case).

On calling of get_device_state(), an invalid net_dev is used and this
cause a kernel panic.

To handle this correctly, move the call to get_device_state() after the
new net_dev is correctly set in trigger_data (in the NETDEV_REGISTER
case) and correctly parse the new dev.

Fixes: d5e01266e7f5 ("leds: trigger: netdev: add additional specific link speed mode")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/leds/trigger/ledtrig-netdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/leds/trigger/ledtrig-netdev.c b/drivers/leds/trigger/ledtrig-netdev.c
index 8e5475819590..df1b1d8468e6 100644
--- a/drivers/leds/trigger/ledtrig-netdev.c
+++ b/drivers/leds/trigger/ledtrig-netdev.c
@@ -504,12 +504,12 @@ static int netdev_trig_notify(struct notifier_block *nb,
 	trigger_data->duplex = DUPLEX_UNKNOWN;
 	switch (evt) {
 	case NETDEV_CHANGENAME:
-		get_device_state(trigger_data);
-		fallthrough;
 	case NETDEV_REGISTER:
 		dev_put(trigger_data->net_dev);
 		dev_hold(dev);
 		trigger_data->net_dev = dev;
+		if (evt == NETDEV_CHANGENAME)
+			get_device_state(trigger_data);
 		break;
 	case NETDEV_UNREGISTER:
 		dev_put(trigger_data->net_dev);
-- 
2.43.0


