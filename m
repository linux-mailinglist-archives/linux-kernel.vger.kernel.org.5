Return-Path: <linux-kernel+bounces-134065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0BD89ACBC
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 21:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC8601C21282
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 19:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3394CE09;
	Sat,  6 Apr 2024 19:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ze50Uijj"
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75644D9EA;
	Sat,  6 Apr 2024 19:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712431064; cv=none; b=D18Z5hzcomgCIUgUv9VaHp4zDm74bI5lQbxb5w6dHhmSY8B+TDKmF8iKKFh/T2/tD9I7ibQJ2ADA/X/r1n9tx3SdLKLd9jHzK0nH673K4y0qFMzPlPUBSJwY+kTps5UWY0cveTw6kzqQvAMz7b9qXWW+MIRPqhNAJmLsoXTi1JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712431064; c=relaxed/simple;
	bh=hxjHXQSirYnMZcw6VLQSEFFq2ZmH/RXdVjyUtQzyBPE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eSKx0FbzrJI0BGqvF+Cprhw9Bkqt/gKNcNK7a1/wVPLhjGDePDWzjThoocJ+VlEe5KaHKHwCk3jIo5pyplQP8Cnmm8oOH1jiUnMMGDLJCwV4iBVBDEnlLwxPK31yjb1Lu3sv4iosYoehoGN/PEzIzQvFDa1m+/rNxh2b0grnYqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ze50Uijj; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3bbd6ea06f5so1466855b6e.1;
        Sat, 06 Apr 2024 12:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712431062; x=1713035862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=74L3Kh0F38La798159Il7YMYXwftdxT955aZ6Xjyni4=;
        b=Ze50Uijjz+hlJT9+9LI8uT/obKxcBERsRy8pSnME2So5FNnA+pv5i0OVGTeCFKadxa
         ARz4uBr48orhE1w7e35IC8ysgueyG6gunW81cBPi11HU6x27lGv+JpOBt1Ys2Hfgn4E8
         cSBD6V14f8tfefsDDocoZ1bZURV6iAyJ4gWQQqw4WkmsJPYhndcCxth/XZa6MDkhilli
         i1jP2FoFjEwJMqoCLhBAiQ8D00Y24TEjRZWZye51EC9mWarMoLU6dd44L2Jvu6vHyp+X
         0/DB+s0wzfu//iFdEFMcTBG2lpGZCqKuGuqSIp2q0KO06VyQVf0bdHPtH0ehEa1iYX0O
         9+gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712431062; x=1713035862;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=74L3Kh0F38La798159Il7YMYXwftdxT955aZ6Xjyni4=;
        b=NamRxDvMnLRc02RvuJbnOO0oRbs6DXDUhfgi5PvCeMj37QyjF9OHbHCrrG34tqNwAW
         FUxJqVAoI6EZ2GCyOogwd2oVJ1V8CMBnhkJTG7o/7lBh0njHLHHuYlG/eNnR/SHMVpgL
         oFgLVl+emEeVX58Ng9CC4a1zTnl/P05WphJrGd+9/3xD+glxEWueLSPldjl321A4218u
         8Jso/foXtetM10ROaHreyXCpuZoGUekPLteC1KrMJNFSO7f5OhKzG1IEwY0Akk45gL/A
         /OkwjbWzD88ajNCqSIeSOlOu32KGS8gTXdEUzooPqlL5KJzQ17BAoT/ojV6IdzC6EX2k
         xIEA==
X-Forwarded-Encrypted: i=1; AJvYcCVWKOLM0MFD/F24TWcZmx7DQVAJI5qO3+xh/9hG/C0hmbdi84Fp58UAqX/bfgzetCMO4XQKZyXN4XZftHpbsZf5mOorDQNysPI0UQgmlTcr5LkWS6rxrBHLqZ1NnIfPqDaLEVnheEM=
X-Gm-Message-State: AOJu0YzpvhJdpt0xtcvOGxHLmr7maCaTb7l72cV7db9IfnXRhMEQV+kR
	ThYFwB9DV+DKY9jYB4RzXJ12IuikMImMHWWuSmL8UIB9ts8DuBKM
X-Google-Smtp-Source: AGHT+IGG+WwFL2S7fm6wtnkR5YXyHqvB4Vy36JpCHCzAbmBZXdr883PCOo+EVr6ms9A8AgtJrDwxbw==
X-Received: by 2002:a05:6808:1b28:b0:3c5:ef95:16b2 with SMTP id bx40-20020a0568081b2800b003c5ef9516b2mr35052oib.19.1712431061661;
        Sat, 06 Apr 2024 12:17:41 -0700 (PDT)
Received: from fedora.work ([2600:1700:70:f701:902c:1d74:b5f5:5fae])
        by smtp.gmail.com with ESMTPSA id 124-20020a4a1582000000b005a46d5bd558sm892318oon.45.2024.04.06.12.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Apr 2024 12:17:41 -0700 (PDT)
From: Mario Limonciello <superm1@gmail.com>
To: Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>
Cc: Sebastian Reichel <sre@kernel.org>,
	chrome-platform@lists.linux.dev (open list:CHROMEOS EC SUBDRIVERS),
	linux-pm@vger.kernel.org (open list:POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS),
	linux-kernel@vger.kernel.org (open list),
	"Dustin L . Howett" <dustin@howett.net>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH] power: supply: cros_usbpd: Don't show messages for no charging ports found
Date: Sat,  6 Apr 2024 14:17:34 -0500
Message-ID: <20240406191734.137797-1-superm1@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

Framework 13 and 16 don't use cros_usbpd but do use cros_ec. The following
sequence of messages is totally unnecessary.

[    5.545352] cros-usbpd-charger cros-usbpd-charger.4.auto: No USB PD
charging ports found
[    5.546722] cros-usbpd-charger cros-usbpd-charger.4.auto: Unexpected
number of charge port count
[    5.546730] cros-usbpd-charger cros-usbpd-charger.4.auto: Failing
probe (err:0xffffffb9)
[    5.546735] cros-usbpd-charger cros-usbpd-charger.4.auto: probe with
driver cros-usbpd-charger failed with error -71

Link: https://lore.kernel.org/chrome-platform/20240403004713.130365-1-dustin@howett.net/
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/power/supply/cros_usbpd-charger.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/cros_usbpd-charger.c b/drivers/power/supply/cros_usbpd-charger.c
index b6c96376776a..4e69da2cce7b 100644
--- a/drivers/power/supply/cros_usbpd-charger.c
+++ b/drivers/power/supply/cros_usbpd-charger.c
@@ -570,7 +570,8 @@ static int cros_usbpd_charger_probe(struct platform_device *pd)
 		 * This can happen on a system that doesn't support USB PD.
 		 * Log a message, but no need to warn.
 		 */
-		dev_info(dev, "No USB PD charging ports found\n");
+		dev_dbg(dev, "No USB PD charging ports found\n");
+		return -ENODEV;
 	}
 
 	charger->num_charger_ports = cros_usbpd_charger_get_num_ports(charger);
-- 
2.34.1


