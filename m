Return-Path: <linux-kernel+bounces-39200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D6A83CC66
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 20:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BB2D1F282DB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE28813A255;
	Thu, 25 Jan 2024 19:35:04 +0000 (UTC)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E534E1386C4;
	Thu, 25 Jan 2024 19:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706211304; cv=none; b=TVoKr+dkLLqkQpZCIj8//tb3I2wET0CpiIg1JKwwxvH5bp5j969VoA+jdVOh1/xiLREYkSsvRBVD+/u9UnAuxayulDEdP5ez0BuVPT2ItJHyDIilfy1gz5XeQGDOC+CcBPkJEOXVnysuvh3X/qhQ+lu5NSnDPjH32GeQi2vbFdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706211304; c=relaxed/simple;
	bh=cE7HJqGgNEsQGZ0DlNUxITPNbupbdw9iSfZCn/riuOo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Kf4PCTuEYIUEn4VMrJ0FKkRz0ekYcYm67W7oy8bPRBCY3rY1WuZakkT3556vBed14ZPQMEq6iXVMnjcz31UyjOPGWgwvmzFC9usWsg+8crmuXSIXNH2N137qpYSf7XYmaWFDY0mkPQDHrMaS1ePKXSVrLRrvPTK3xKM8aA2ZPvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-557dcb0f870so8842842a12.2;
        Thu, 25 Jan 2024 11:35:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706211301; x=1706816101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2hl/WORKgkHTT3mUr48M3qDyKOKsifQuuvFDp3xxBWY=;
        b=LCXwDvObAcniddV7iJa0ZC5iHtXC7ZoQCcclHfjAcdOZ4V4T8JkgYKXL7PIya6yFX3
         bScaiNLCslTjnVCrrtLI76A7+/RgX500V9srA14mxF4LqG7kTSHjRb/7vtgSdv1rIPmv
         xV7F403mE8HB8D8vJgUY9dPn2F9b5NMQQkE09dU32tNPYGNmUDtHtqfsyA4tYDR40+4q
         21U7dKJiUZBwxwZ6SmFCyyN2mI+gbQF6kM3V6NP2l2kbYf/OdPyNOsKmaLSlu46izhiP
         Sx916IZZN51lp1W9X8Z7/ps4vk7NrJZltkfge4GCarOQ5k8CYlAwDwq+1uXzbuHbwm5d
         odAg==
X-Gm-Message-State: AOJu0Yy0jA1IeKELLzjrq24GYx3eJlzs1kT89dbxieHLadCj5+1JtJH9
	Z78DKuOsJPX/Eo2Pe/nq9SakM6iXQlg8LEzO5fNcUCjGKfybeLcD
X-Google-Smtp-Source: AGHT+IFn5/6GkRTnDgR/cQLP3cRWRM1Mc68gLba1yVdowJfS8iR5/XZc+JyA3+7oqly9CHZZGEURLA==
X-Received: by 2002:a05:6402:2689:b0:55d:1707:732e with SMTP id w9-20020a056402268900b0055d1707732emr113572edd.5.1706211300843;
        Thu, 25 Jan 2024 11:35:00 -0800 (PST)
Received: from localhost (fwdproxy-lla-003.fbsv.net. [2a03:2880:30ff:3::face:b00c])
        by smtp.gmail.com with ESMTPSA id el3-20020a056402360300b0055c82e27412sm3025061edb.75.2024.01.25.11.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 11:35:00 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com
Cc: dsahern@kernel.org,
	weiwan@google.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH net 02/10] net: fill in MODULE_DESCRIPTION()s for ocelot
Date: Thu, 25 Jan 2024 11:34:12 -0800
Message-Id: <20240125193420.533604-3-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240125193420.533604-1-leitao@debian.org>
References: <20240125193420.533604-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
Add descriptions to the Ocelot SoCs (VSC7514) helpers driver.

Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 drivers/net/ethernet/mscc/ocelot.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mscc/ocelot.c b/drivers/net/ethernet/mscc/ocelot.c
index 56ccbd4c37fe..2194f2a7ab27 100644
--- a/drivers/net/ethernet/mscc/ocelot.c
+++ b/drivers/net/ethernet/mscc/ocelot.c
@@ -3078,4 +3078,5 @@ void ocelot_deinit_port(struct ocelot *ocelot, int port)
 }
 EXPORT_SYMBOL(ocelot_deinit_port);
 
+MODULE_DESCRIPTION("Microsemi Ocelot (VSC7514) Switch driver");
 MODULE_LICENSE("Dual MIT/GPL");
-- 
2.39.3


