Return-Path: <linux-kernel+bounces-27346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CA182EE63
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 12:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 447121F23B9B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 11:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318051B95D;
	Tue, 16 Jan 2024 11:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T35WWzSU"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2B71B940;
	Tue, 16 Jan 2024 11:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40e760e5b49so21377245e9.1;
        Tue, 16 Jan 2024 03:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705405803; x=1706010603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4z6djVw+xP/VmS26amoFgiFK0lAVInxd9fafDSCJQBE=;
        b=T35WWzSU60wavteiCeLTMI6jixFkH/lL5jg64M29B2UIaKUq428bpNoPSHZU6nWxEX
         z6cNhBnZnJVrFsqMVS4pHsvB+aESNomgiaR27aEbGyYDPfU1j44alVhg8NUNa0mDZfoN
         k7O4X0R+o/1VfGvACOrDq+aHEOwhQoeI2bFa/3QElCbOPfOBN/B9UvN4NnM+tRTNqL1P
         53RfirbdwYIfjPZRuk3c4vwqj+2RdxHq64S8xlPXz+sXuz7xb39Z39Yaw1iuVZTBh9p0
         EMEdaZJoYWSiwhtc7yJmUegGv68w+ntyt8IQKIS+HghGYpsU0l9A1Gfc6aNOWf7dqxZn
         FLRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705405803; x=1706010603;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4z6djVw+xP/VmS26amoFgiFK0lAVInxd9fafDSCJQBE=;
        b=GKMaSLINNUVMHcHvpaCI8H39T2RJapYwAJ67RuE6+TPb0xeZeva5OeTaVsozTny/n9
         fRc/iJb+VODQ9IWzQVuaLUDXpMQfoeb0XS8s4V7J9fapJfM6PqwMFucWQO5vbfuSf2By
         FAu0LfKlJuG/9jpInw3YcSsQILelBg31MrywgzpVHPO2e/uZqJncbIWBoYbrU1ri7UDF
         ftI3V4Ib37OBnqaFGAUDl2AnNmScdkOaKu7svJhT5DfpzXiCzS7fNV83WgT3y/nQAdp6
         KrcgDe7zAXhuDmsRn9OCbsI7yoOr/xaqPQIF8+vufSdaIO+8qg91Y6YyLuiH5HxaDPy5
         J/tA==
X-Gm-Message-State: AOJu0YymeigpJjtN9o6f2fZ0EBNMihL7pYVPCy1/ysh7oFYVVpR8LioC
	xoBUj15uyBzfxuuKVWloQznifnoyZxfFcQ==
X-Google-Smtp-Source: AGHT+IGoeyj5EJkOxRzaCrYjh/CocCEnSAHMnbd9omVCbeNrRont0wm1c2x3yQ+L8993tvqVcc6bjw==
X-Received: by 2002:a05:600c:470f:b0:40e:6803:bcbe with SMTP id v15-20020a05600c470f00b0040e6803bcbemr2081700wmo.266.1705405803163;
        Tue, 16 Jan 2024 03:50:03 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id w4-20020a05600c474400b0040d5ae2906esm23056822wmo.30.2024.01.16.03.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 03:50:02 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	linux-media@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] media: dvb: remove redundant assignment to variable ret
Date: Tue, 16 Jan 2024 11:50:02 +0000
Message-Id: <20240116115002.2265367-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The variable ret is being assigned a value but it isn't being
read afterwards. The assignment is redundant and so ret can be
removed. Also add spaces after , to clean up checkpatch warnings.

Cleans up clang scan build warning:
warning: Although the value stored to 'ret' is used in the
enclosing expression, the value is never actually read from
'ret' [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/media/dvb-frontends/bcm3510.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/media/dvb-frontends/bcm3510.c b/drivers/media/dvb-frontends/bcm3510.c
index b3f5c49accaf..da201871a93c 100644
--- a/drivers/media/dvb-frontends/bcm3510.c
+++ b/drivers/media/dvb-frontends/bcm3510.c
@@ -797,7 +797,6 @@ struct dvb_frontend* bcm3510_attach(const struct bcm3510_config *config,
 				   struct i2c_adapter *i2c)
 {
 	struct bcm3510_state* state = NULL;
-	int ret;
 	bcm3510_register_value v;
 
 	/* allocate memory for the internal state */
@@ -816,7 +815,7 @@ struct dvb_frontend* bcm3510_attach(const struct bcm3510_config *config,
 
 	mutex_init(&state->hab_mutex);
 
-	if ((ret = bcm3510_readB(state,0xe0,&v)) < 0)
+	if (bcm3510_readB(state, 0xe0, &v) < 0)
 		goto error;
 
 	deb_info("Revision: 0x%1x, Layer: 0x%1x.\n",v.REVID_e0.REV,v.REVID_e0.LAYER);
-- 
2.39.2


