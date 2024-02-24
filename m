Return-Path: <linux-kernel+bounces-79901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A36862873
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 00:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78F40B212C8
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 23:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD214EB20;
	Sat, 24 Feb 2024 23:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gr4Dx+q3"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D691B59A;
	Sat, 24 Feb 2024 23:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708816817; cv=none; b=ZWK2BAO0Tw+yFUNS5Pi7ZP7Qq1c2WGe/t2Q4FrzVYKlSoammQLLo3NxdeLBmeBdBOG8mJYJUc6v6hVOw2S/C7tbRco5x6yoX2h/ZW+NNEyEYXo+ANqmn0yzjHbER2IoHrCHLg/KLudu8u+iZRKHxmY9I5RiraqYbHaG6MZ/2t9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708816817; c=relaxed/simple;
	bh=ddpbApfXPnRAvt72tIRg9a0nGvs0psYM9aIpXQBkLgY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=uicnWJpbdTiGb8txOMUuOA7GuJpR72ksIiXajfMwjr3YhU7yUoq5i0VWqzTxNSAP2uKdrzhCzfgzG0eB8vim0k9bO+uupxEJJc4MQT/kBcwMXXw6jY7Rsvh8DW/RrNC/rN9+b8xho7/grHt+9Cfyes40M2izhBLMCvxDXGw/Xc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gr4Dx+q3; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-512a65cd2c7so2797387e87.0;
        Sat, 24 Feb 2024 15:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708816814; x=1709421614; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ewC5em/L4cp2/EK3EgWgLTwF3e1USIQQRxwh9lx3yRY=;
        b=Gr4Dx+q3AHyF/zawHHmeTctgVUQTrk8BYWmbxihnweavCClSAmaIUafRBAIFrzh7f1
         ifRmPL/VVpMLz2AKX/H0Mpp9Sp9IR5GOyeZHk7xsuVKZgZ+09w3ihEDPE4bwpc2ffdbQ
         q3A2jrHVDF7BtJx4PGWII4SQ9j6c6iHqSLfuHxEeRaTjrTohs9lVKD0yuoNzrBotIS12
         UGl1v3ZnWzlIK6/HZltGedFpI9UFUuqLsF6VuXVbt47vNIcf1eOjwpiUYttHZxDOUuZc
         OmmLWRMfXeNjBN8IdEo1jB/gvq2bzHYaMqizro37BPDxBXDW+axujjMwyFwKA7wKoSg+
         JjLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708816814; x=1709421614;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ewC5em/L4cp2/EK3EgWgLTwF3e1USIQQRxwh9lx3yRY=;
        b=MFB4jJnbPAFr7e37oYdcT5hbEQXjXw0FVS9D/NKVmx8ubIE3RVZyb3wCgyidBYW84A
         e9uq2YLfEVD8MVijHYIDtMuVUx/m8bBWCfD3twfGQMNRTROHEqm/yIS6WsuWdqamh1yY
         wiXsfFKIlkBxSrY+qyZqggOPo15HRcRDPg1mg/fmrr54uad0drx6ih67p2vGYESaTSby
         /8pEjZg4ccDqHtdbucvQgE+gKnuex5SFHlurlai8A7dHgLfh3yEltuIX2XlBuawWATXG
         v8Y4DrjSjfEqusRqTrJ0BqB2tr30LBpvUR50UB82sdJTmQRr3NVfRWHrpvidGgxujlkv
         SIVg==
X-Forwarded-Encrypted: i=1; AJvYcCUBnivK1dfv3vlccC2MqLBfiZ4D+VnG3hNzKAm0L3PVIX999SQbJXvJUE+ieI6kMR9Hznf6flFllybLgz0P2RY7rQmzPG0kYAiamAGSxCPjNdjm/ZwGvFX7/rWYhNCPJCVSPJUXQGk5
X-Gm-Message-State: AOJu0Ywxk46lcchqEqnW2EKuGSDxALLF8jtAStqQ+c6Qpd/Hu7uXh2sV
	c4jWlCDFHd7zeg/SvQrS82B/Dru/E30kkty4LdVjXk0qNBCzT8wQ
X-Google-Smtp-Source: AGHT+IFZ3ISb+iAdCSF6RROWczKAp5Me66N/c0/Abte9/kVtdGpQs7KuFb8Ryxa+5C3vL+a+Xlxvyw==
X-Received: by 2002:ac2:4c36:0:b0:512:ae9b:559 with SMTP id u22-20020ac24c36000000b00512ae9b0559mr1705374lfq.34.1708816814128;
        Sat, 24 Feb 2024 15:20:14 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-75bf-ebcd-fec9-7873.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:75bf:ebcd:fec9:7873])
        by smtp.gmail.com with ESMTPSA id vh9-20020a170907d38900b00a4323d1b18fsm75344ejc.34.2024.02.24.15.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 15:20:13 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Sun, 25 Feb 2024 00:20:06 +0100
Subject: [PATCH] net: usb: dm9601: fix wrong return value in
 dm9601_mdio_read
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240225-dm9601_ret_err-v1-1-02c1d959ea59@gmail.com>
X-B4-Tracking: v=1; b=H4sIAKV52mUC/x3MSwqAMAwA0atI1hbSoEK9ikiRNmoWfkhFBOndL
 S7fYuaFxCqcoK9eUL4lybEX2LqCsE77wkZiMRBSg0SNiZvr0Hrly7OqwckFF10bokUo0ak8y/M
 PhzHnD/syCglgAAAA
To: Peter Korsgaard <peter@korsgaard.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708816813; l=1563;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=ddpbApfXPnRAvt72tIRg9a0nGvs0psYM9aIpXQBkLgY=;
 b=LQY/Y23hWUYaQe2RKybVLCRW+6QDIdyppqxDWZ0SdXIX5gWkG7IdeMab+0+8M5Cm2Up+roC8c
 4KcWpnmHFr+CusG+Qvae0a1tmKeSIdMyytGYCZpMAv9MZlsav6wiDUn
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=

The MII code does not check the return value of mdio_read (among
others), and therefore no error code should be sent. A previous fix to
the use of an uninitialized variable propagates negative error codes,
that might lead to wrong operations by the MII library.

An example of such issues is the use of mii_nway_restart by the dm9601
driver. The mii_nway_restart function does not check the value returned
by mdio_read, which in this case might be a negative number which could
contain the exact bit the function checks (BMCR_ANENABLE = 0x1000).

Return zero in case of error, as it is common practice in users of
mdio_read to avoid wrong uses of the return value.

Fixes: 8f8abb863fa5 ("net: usb: dm9601: fix uninitialized variable use in dm9601_mdio_read")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/net/usb/dm9601.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/usb/dm9601.c b/drivers/net/usb/dm9601.c
index 99ec1d4a972d..8b6d6a1b3c2e 100644
--- a/drivers/net/usb/dm9601.c
+++ b/drivers/net/usb/dm9601.c
@@ -232,7 +232,7 @@ static int dm9601_mdio_read(struct net_device *netdev, int phy_id, int loc)
 	err = dm_read_shared_word(dev, 1, loc, &res);
 	if (err < 0) {
 		netdev_err(dev->net, "MDIO read error: %d\n", err);
-		return err;
+		return 0;
 	}
 
 	netdev_dbg(dev->net,

---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20240224-dm9601_ret_err-0a9c9d95cd10

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


