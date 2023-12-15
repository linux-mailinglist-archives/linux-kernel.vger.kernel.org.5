Return-Path: <linux-kernel+bounces-629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E198143D5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 09:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C36F1C22576
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 08:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5592A182C3;
	Fri, 15 Dec 2023 08:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SukheDzC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD4A18029;
	Fri, 15 Dec 2023 08:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6da41cd19d3so426394a34.2;
        Fri, 15 Dec 2023 00:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702629596; x=1703234396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2AO3yjiUYIdHC+VFwE6rSiRrMUR/zgHnkv0+F2jQjLg=;
        b=SukheDzCyOEUDlZzOw4TEcg2SGPFVLf4Vin/70PqCOBAO9RTKMmr979kES4hmn+JJU
         4UkCFK7bNOJluuCyy26w2LiFZJIZ/l0vLmtvmWvOWcK/q9F5EIbxMcj9db+l6nF50Mpy
         FfgKQvUpEhUVOVJCoBdmtkelf2KbjmJ7kdkk3Q+o6qF48E9vsFoLb6gQ1G9oVpd1cwkA
         aTRstNQyFgra8ouANrLPbUF2z7GxxOijTCseOm/ycvKWN+/29ZIKbsd30kWu7IwzLPYs
         0+IhsxJn03BkV4mbvxlQXqfjz0paSUvYgfMAxakfEpawU8P9qxqvokAFebJQGKcTvd3z
         4UdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702629596; x=1703234396;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2AO3yjiUYIdHC+VFwE6rSiRrMUR/zgHnkv0+F2jQjLg=;
        b=pm/NtK70WUYHW0Klv2SknXbjX2dBLY7kvkyas2SkA5+vQQ2AvmmYltuirgMKLzcnUV
         +quA3tyHYbzTFZxSm9HdNqi9Y8mhjY6BL1ZD3jbqrWsWvKM9X4QLcBrW7GVLN958+QOn
         6jB8VGFmR/VI7bgUV8rmL/HS/JYzl9DBiecSEbqqGJQG3dK7Lb7uthdPO9DNBwKDwW1M
         ea/bPRBszAbmkIXCDp3s86aSYN7ZbjHcdAkvm/o0LhRUEFonSLX73vI77B9B/5CHh7Y7
         P0TxuhSVdaS7HryHIodrcUiV+8XNrQAJLWs0rkF2Ys6p1XiA4yvpbu1Z4b7tgAPU3Smz
         kijQ==
X-Gm-Message-State: AOJu0YyNPUqC031s8viHY10zBO4eEds3BN2Yqw5x3/jzj46zGUzGEohc
	2UNvM5ylrg133HNjS55RhcU=
X-Google-Smtp-Source: AGHT+IG7vwtay99+owRCx/pWv7x/yzgqEjICgRfABNiZpBSFGMk0Yr1EdWmBU9mbayDyQ6vVkO+51w==
X-Received: by 2002:a05:6808:14d5:b0:3b9:e3d7:1271 with SMTP id f21-20020a05680814d500b003b9e3d71271mr15011091oiw.9.1702629596419;
        Fri, 15 Dec 2023 00:39:56 -0800 (PST)
Received: from localhost.localdomain ([202.137.218.19])
        by smtp.gmail.com with ESMTPSA id fb6-20020a056a002d8600b006ce95e37a40sm12950545pfb.111.2023.12.15.00.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 00:39:56 -0800 (PST)
From: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
To: heikki.krogerus@linux.intel.com,
	gregkh@linuxfoundation.org
Cc: Ghanshyam Agrawal <ghanshyam1898@gmail.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] usb: typec: fixed a typo
Date: Fri, 15 Dec 2023 14:09:30 +0530
Message-Id: <20231215083930.566164-1-ghanshyam1898@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixed one typo.

Signed-off-by: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
---
 drivers/usb/typec/pd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/typec/pd.c b/drivers/usb/typec/pd.c
index 85d015cdbe1f..bc4a35f322df 100644
--- a/drivers/usb/typec/pd.c
+++ b/drivers/usb/typec/pd.c
@@ -468,7 +468,7 @@ static struct device_type pd_capabilities_type = {
 /**
  * usb_power_delivery_register_capabilities - Register a set of capabilities.
  * @pd: The USB PD instance that the capabilities belong to.
- * @desc: Description of the Capablities Message.
+ * @desc: Description of the Capabilities Message.
  *
  * This function registers a Capabilities Message described in @desc. The
  * capabilities will have their own sub-directory under @pd in sysfs.
-- 
2.25.1


