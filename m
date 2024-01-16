Return-Path: <linux-kernel+bounces-27287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 506EB82ED53
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 12:02:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B94D91F2427D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 11:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87BF1A5A5;
	Tue, 16 Jan 2024 11:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OrAkO70f"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED811AAA6;
	Tue, 16 Jan 2024 11:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7bed9c7d33fso251668639f.1;
        Tue, 16 Jan 2024 03:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705402956; x=1706007756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iqOqjkfvNIfCwRpg7jTDgB80yQS5ORpkHz9Fa7X1S9c=;
        b=OrAkO70fjv5QRopgqk90QncS6gRcLWY3IV2qv4EVOd0sUgl4Y9zfy6I3nLwefTGuP7
         6Rks5+5OJuItVqkEI68+DLiI4moZ7XvFmO2tahtaQf9ba2HbX03dxhG7MR5G9cBEaFti
         sq3FzaEI1ch4fZtJCLnajAoN8I4T/jv0E26Bb9XzG+KwuPnO3UH1jNcoXotIRS5GUyoQ
         puzK2uPtHIzn+YZFndXKduGriZcO4VFSLnRvMoyV6P+7Bcw5QGgC/tO7xToOKZXx8Y01
         4qnYavnoGiRq4hzXEYJWCUAPX2PS4/3FkSF46p//BB1F68az7ETyoyqmdUG096obxHph
         AQaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705402956; x=1706007756;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iqOqjkfvNIfCwRpg7jTDgB80yQS5ORpkHz9Fa7X1S9c=;
        b=qK7kaTI0Zu5p8a+hxoaCQUhmQwfz2rfBSreO8v2dXqJ2lu7d34SozZGaFjBOExOO98
         dt7Us9jyCdfmZpX43BTN6A1crM1CtVseiMILXrrOEiifIeHBqJx4mA3qNcA71J5R+osx
         qehD764ZVKmR7PWWSxZ1iZD3fhoKn2vf2j4SUGfyAI19cjp49wLExzrCI9sEwZwBz5aw
         0QCKTPW7v5NkhX8yRaKvOgXmVfo27PPLsUMY/XKZlX+Lw/ODFuvhjRJNAp2J04GdW2n+
         9lmUJIay6OZf3cLONlMy6cR5bvgjsG+l50gdRDIO/TkcL1Qa8D9wxn25ZpmYf6zqYbeW
         8N/A==
X-Gm-Message-State: AOJu0YzEYwZxVq/8RLHHXptEsP9MQRT/6QI68I9T7BMYYANzVFVEAFaU
	O62qPy4fwl31vHxnPlxP4Tw=
X-Google-Smtp-Source: AGHT+IF38h5TsIuDvf7jRRrOoP3knyuGMZBka8shy/jppv+UyVYarH52O8H/Y20aE9ADQLOtd8MhTQ==
X-Received: by 2002:a5d:8d16:0:b0:7bb:5d51:46c8 with SMTP id p22-20020a5d8d16000000b007bb5d5146c8mr7181165ioj.18.1705402955921;
        Tue, 16 Jan 2024 03:02:35 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id i13-20020a6bf40d000000b007bf32234124sm1689273iog.32.2024.01.16.03.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 03:02:35 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Matt Porter <mporter@kernel.crashing.org>,
	Alexandre Bounine <alex.bou9@gmail.com>
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rapidio: remove redundant variable tmp
Date: Tue, 16 Jan 2024 11:02:33 +0000
Message-Id: <20240116110233.2247061-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The variable tmp is redundant, it is not being read after the
assignment and hence it can be removed.

Cleans up clang scan build warning:
warning: Although the value stored to 'tmp' is used in the
enclosing expression, the value is never actually read
from 'tmp' [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/rapidio/rio-scan.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/rapidio/rio-scan.c b/drivers/rapidio/rio-scan.c
index fdcf742b2adb..8f1bc69f7153 100644
--- a/drivers/rapidio/rio-scan.c
+++ b/drivers/rapidio/rio-scan.c
@@ -528,7 +528,6 @@ static int rio_enum_peer(struct rio_net *net, struct rio_mport *port,
 {
 	struct rio_dev *rdev;
 	u32 regval;
-	int tmp;
 
 	if (rio_mport_chk_dev_access(port,
 			RIO_ANY_DESTID(port->sys_size), hopcount)) {
@@ -562,8 +561,7 @@ static int rio_enum_peer(struct rio_net *net, struct rio_mport *port,
 	rio_mport_write_config_32(port, RIO_ANY_DESTID(port->sys_size),
 				  hopcount,
 				  RIO_HOST_DID_LOCK_CSR, port->host_deviceid);
-	while ((tmp = rio_get_host_deviceid_lock(port, hopcount))
-	       < port->host_deviceid) {
+	while (rio_get_host_deviceid_lock(port, hopcount) < port->host_deviceid) {
 		/* Delay a bit */
 		mdelay(1);
 		/* Attempt to acquire device lock again */
-- 
2.39.2


