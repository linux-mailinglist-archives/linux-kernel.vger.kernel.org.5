Return-Path: <linux-kernel+bounces-53980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F8784A8B9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 23:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C5481F2E3D6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6EC58ADE;
	Mon,  5 Feb 2024 21:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RmXJx9Z0"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D942482DC;
	Mon,  5 Feb 2024 21:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707169008; cv=none; b=YwLb1PhZ1BZil2l6QyEse8y/KDNTsy/X5Ipfus9f/juxqJoIQAVlIedeAUI2CTLvfdub826bttYMCUYuYfGI8uURisdUbWbewup39z1WexD0dsaoWCwFdadKA53LnJpK+YbM488My9l1N9D3NyQUM4bm52qKPxrbWe2BeSTnLQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707169008; c=relaxed/simple;
	bh=t1Cd6TW+Agc8G9lESecqw5BVuRFyEei094Suxxq2CY0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=mfieNXh3z6JSdi/UV9Ji83iUDjMzm7nIcpiuivJHRJwmo2m6g752Mqv1zAFA6pL5mwMYpFr8lLEQMovlmDwsD2aEfy/rmogTpZHaXIvQNfIxOA5E8gZlzw5u+5h0EDi9AYHtetB+9UAZcQAR/LJLa1y6OKzvYrgj6KEKQHyGEyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RmXJx9Z0; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33adec41b55so3122355f8f.0;
        Mon, 05 Feb 2024 13:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707169005; x=1707773805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1ixOwHwlGr0QH0MfebG8nIcK05y76/V3geW0OCAmt5g=;
        b=RmXJx9Z04YN949q4IILLVIzwCYIdLA9/CJl89HUvwUF+ltg44uTx3mJbOEaAUz2eEk
         UvPAXqD2hzasO35/gA+ks8FjxOmJlsxBfS8/9PxxUnF0Vh5B98cAJyTChug9naFwqla0
         TfA2PC8VUoHO9YYQs1op5lMyaA5REtRkKj37UYqJLQu4mL+yePtLqzVhlgUzqhl3q+H0
         CGyJxD7/TJzYqtK5FzF1dwrkN727WH4XIUVFPvP+1p5VvQ3BBKlQ/fdVlTE48LRBuMlM
         trUZOZQcVUI4DX0oKTytkBC4uZu/gu7uTZVId1+05aNOUdBFt+VihchImMf3oDgpgZFJ
         yFjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707169005; x=1707773805;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1ixOwHwlGr0QH0MfebG8nIcK05y76/V3geW0OCAmt5g=;
        b=gPLUD1Nv8WWLr/A3Td8YmJDQDSmUiEVETZY8UkV4Tc4IuFB/4duv/jbpWQDUAIifKX
         zy+WRjGRorINNXlffBtDWaC3+/CtUAMD1XCUCPaP4hVSY+uYmq+nwqt9vIL70G8qef+P
         7gknhhgQHUhhtjsZO6BQ+ZDH5cCFTnPsU/kdh3V3NMrw+NJ8wrxH2ygPQsq4Wp+Kf/O0
         uDJ0Opa7OZ0zhA/F1eizBUOi7b9wx2k1Bu38YWfpAg0vMT1ceK07TxjMmpQjOVO5vi01
         W4p/75QiA1dP9OGRK7DV4/2UKrlz5ny5ypMxkBI7M/lXaKnJq+UxuwYsTjh/c1M2Qn3Q
         xiVw==
X-Gm-Message-State: AOJu0YznmSmUnpqQGHCiqmTMECNHTdxCTyjR/K+ctwm7mk+jPonhLG5R
	OgoAt1Zl1spUtuyR9PJrwpxIvktoDPTq/weTeOpjLRDmnRm0a9uh
X-Google-Smtp-Source: AGHT+IH/5rh+UD9PCC6QbLfEbwSMpAr7bSG2HGF67ZOyjt2y9aXGfq2FH33t0Ysw8/FVB1QPYUZuow==
X-Received: by 2002:adf:fe02:0:b0:33b:1822:4478 with SMTP id n2-20020adffe02000000b0033b18224478mr464497wrr.30.1707169005023;
        Mon, 05 Feb 2024 13:36:45 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV1xsFWjL/C1NJeg5+9Yg9z/PhjZ6gTHCFCXhf7Cnpmub1eVhUVtl+Itm8TaD5MUa+ZpCLLjPhwTORuqi1u+W9L8p0UqKcHgOI0QLQsEHQFabTNpM4jaWF27pgI7rxNgFrZtVHCLczZdw8OMiBMNmGq83XdmWpHsjSpkpOrDIEsPMwH+ieHHjFrqK9LjK2pJ/c444r+y4F3xqvpcoLhgjgIGfmPyLpMB8s5vj3H+vv42NzNRGyG
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id w9-20020a05600c474900b0040fde0ec31esm2466158wmo.31.2024.02.05.13.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 13:36:44 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] xirc2ps_cs: remove redundant assignment to variable okay, clean up freespace
Date: Mon,  5 Feb 2024 21:36:43 +0000
Message-Id: <20240205213643.1850420-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The variable okay is being initialized with a value that is never
read, it is being re-assigned later on. The initialization is
redundant and can be removed.  Also clean up assignment to
variable freespace using an assignment and mask operation.

Cleans up clang scan build warning:
drivers/net/ethernet/xircom/xirc2ps_cs.c:1244:5: warning: Value stored
to 'okay' is never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/net/ethernet/xircom/xirc2ps_cs.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/xircom/xirc2ps_cs.c b/drivers/net/ethernet/xircom/xirc2ps_cs.c
index 9f505cf02d96..e9bc38fd2025 100644
--- a/drivers/net/ethernet/xircom/xirc2ps_cs.c
+++ b/drivers/net/ethernet/xircom/xirc2ps_cs.c
@@ -1240,9 +1240,7 @@ do_start_xmit(struct sk_buff *skb, struct net_device *dev)
     netif_stop_queue(dev);
     SelectPage(0);
     PutWord(XIRCREG0_TRS, (u_short)pktlen+2);
-    freespace = GetWord(XIRCREG0_TSO);
-    okay = freespace & 0x8000;
-    freespace &= 0x7fff;
+    freespace = GetWord(XIRCREG0_TSO) & 0x7fff;
     /* TRS doesn't work - (indeed it is eliminated with sil-rev 1) */
     okay = pktlen +2 < freespace;
     pr_debug("%s: avail. tx space=%u%s\n",
-- 
2.39.2


