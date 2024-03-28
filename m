Return-Path: <linux-kernel+bounces-122881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12AC888FEDB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7EF91F2422B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 12:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABCD7EF02;
	Thu, 28 Mar 2024 12:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D0wtH3fm"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D405854BDA;
	Thu, 28 Mar 2024 12:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711628538; cv=none; b=Hrp1MiHp/SNIeOszFa/67sPy6RvK2NlNjTLN6QUc/MrSx2LBV2zxoblxfCiQs60ksrZifkSg8gRRhwcdsJINh3sRUVLlN45KFdIDBC7ytPkmFbTL+wF79cC9Ayfv8q8AWAcsryFjm3iiV3goTqhpHxpF7uIo52xQ8N0HajbjVnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711628538; c=relaxed/simple;
	bh=2fe0n8LweizaCOPGU4EyERZ9VYXN1XEcuUzuN0FtvQA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=KPVmX/474QH/RnVz/yS0aeXOsqzWfOrdQbtxoW93WmiRrGrVPGPHqH53gUtV6ipAQNuj+8pMn+RE7zPCEDXanWSr7sK9wETtO0lZF2tm2uRqMWQdukRAUmmz+yc+Y48f5plBzHO2xt9hEgnEJWDspAZkpQSNNYKLQvS464+EsOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D0wtH3fm; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-341cce3e5f0so783995f8f.1;
        Thu, 28 Mar 2024 05:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711628535; x=1712233335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ayHPtSs90OswBRl/sKzno/7Sgnyo8R4+Sjb5HQX47gY=;
        b=D0wtH3fm3bP5kNdXwqnnuaW0Mu6MfiA8nKpcWFKxeWBqZ6zIDMj2Yv43ZCCe9rsR4q
         dR8a0T3CWMIF2NAM2kaMtTB3YiV586EetqiPnMKbq/2+GCmilLAbJ+aAWtRoTcZTWnMt
         kw7m9yr+7DfLAaxeKDa2d1kvWAta098piZm84ptIvG1WxIIkDDsjiLX8EciBAHpKLYR4
         9fjE0ltW9+L9D1OpfsK/fzFiSG4+GCsF2zSRkdiSP2fNZ1eKZ/3aQ8obABiAWJeMZ063
         gzRBNDeQwSTXOBoq2DsHuKbb82ULs0YBUaHXuvQDJMT0Ugnu9h3SoC8XZCDxv7FK1ONJ
         /15A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711628535; x=1712233335;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ayHPtSs90OswBRl/sKzno/7Sgnyo8R4+Sjb5HQX47gY=;
        b=o0JdnudbCfl6joh4ShEtLfKgEjLFbB6GcYUHlZFYM4GqOewyIKu07ja9UpeHOTjLBB
         kQyEqiSM6UMSrSSmDCPO9wNxJNAZ1TUBOSoYXLbVOZSC+/PTtAw//A8O5+4JfPvBA/uJ
         ocG5VCfycQIQEApjITkdEW/mApZwaFoJK7pN+GGGQCLlauWmpDVHzbbhRjpCIJcHpnVe
         v4eyLo1tkLdxsx2e8VKYQA8bSpqOu5ME3q+47bPvy0hlZj/AmaFiqugRPuOCjKbqYmNG
         Z6NSi5ZR6OQ8DBN2zXHPqOZmL01GaMGG9AXElRmYjtcEm6frQFEhomjYUxSSKSxVq48V
         w5Sw==
X-Forwarded-Encrypted: i=1; AJvYcCWur7AZJ15TDHuHkCNEYxadYruOZCZV7FZ9s+xT9BRoJDA01xPGqcaTh1vvzbG78rYsmZcxvwxfKsGAbDXSsbBvOG0oGryT7UIKsnunm6/tYuk35WuhG1jeahTdWfI+czUjsHF82uWYhWQ=
X-Gm-Message-State: AOJu0Yy/deRRzVI9Mc5BTnO9IUBg2enuljA21llgQ29S1cdxjBHIdBED
	vLWs7KPYeEMYIvqC5bN7dVFTBtWz/ASqk1KQuCdgQpQd8oaStUJ6
X-Google-Smtp-Source: AGHT+IHzqvUZ2ksUlygpI0QeJuF7vcP1wfbXiUmzh4ylbdpcwnBTVKDqLeJGESOkUEI0TxiC+UVLvw==
X-Received: by 2002:a5d:560f:0:b0:33d:2180:30e8 with SMTP id l15-20020a5d560f000000b0033d218030e8mr2680359wrv.25.1711628535038;
        Thu, 28 Mar 2024 05:22:15 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id bl37-20020adfe265000000b0033b87c2725csm1625229wrb.104.2024.03.28.05.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 05:22:14 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] HID: sony: remove redundant assignment to variable ret
Date: Thu, 28 Mar 2024 12:22:13 +0000
Message-Id: <20240328122213.762889-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The variable ret is being assigned a value that is never read
afterwards. The assignment is redundant and can be removed.

Cleans up clang scan build warning:
drivers/hid/hid-sony.c:2020:3: warning: Value stored to 'ret'
is never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/hid/hid-sony.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index ebc0aa4e4345..1d37b39e1171 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -2016,8 +2016,6 @@ static int sony_input_configured(struct hid_device *hdev,
 
 	} else if (sc->quirks & MOTION_CONTROLLER) {
 		sony_init_output_report(sc, motion_send_output_report);
-	} else {
-		ret = 0;
 	}
 
 	if (sc->quirks & SONY_LED_SUPPORT) {
-- 
2.39.2


