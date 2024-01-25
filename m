Return-Path: <linux-kernel+bounces-39207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 736C683CC96
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 20:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 700F61C2372D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B3513EFEA;
	Thu, 25 Jan 2024 19:35:23 +0000 (UTC)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6F613E23D;
	Thu, 25 Jan 2024 19:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706211322; cv=none; b=upVdF5cHZSGgDlzEg71VEra6dqriHniiHZnddHA65y4zgDA6Y2FPq4UdumyO117X2kPkgk9nZAsxn4CnqSLTQ4TNM/923X1UC0aok97L6ddy433e2Gi7cPAVEuFy/AZAlT9LU80Vku5d7+WRIoFLVWnDROpfIlPvCgL4AoMTkJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706211322; c=relaxed/simple;
	bh=XixT/EeMt1VQDS/UYuewQ732sIL2ZBkXmKEbtFoZgtQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N9Ng1UOk2uQENbtpki+Tkpb0BaN+luPDbcF4a+obeOZaafevk8HYfgQwIImx14DZdz+2gCT1YR4jdlUqBTFxGU8j7M8bRUmRbjy1OElQ+tq9uvGvU7izenqi5xYWBc/x6X3MDrezjgVpiRPXCP0zwv7CH20ClBt/JU4IPKqccNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a33735d22fcso60174766b.2;
        Thu, 25 Jan 2024 11:35:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706211319; x=1706816119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rh6KXnjYgc+1gbet7ap0t7DO3UQ1gK+zr3y4G8Q78qA=;
        b=DIjovK1NTw2z2/zFOCHil7M8sj5yoorytk12QBxdaR2O5TfVt25cMhf7f/TyTmNiqC
         FJCXb22Wt1W3FOmSSJFABAPqQMg/D1EdX/jKmP+f/bipQJQ0j7lE2/heiQNMH4eqap0/
         Yi9dA9sUwDBtbZGy5AaHYonMN7rKGscv93WnhFeqkK+POOGhU3frMp7H+Hl8LIvE8Ca/
         hZ+b41oXZBX2BX0klD7vIDibtbkjahJuz5qPS9HlUcgz3pd/O0bjah3G0+Uno0N5/6Py
         9W/JcgC+MDJBM2nyVHnQs5M2BkQzzFTUy6S7l0tiCt+KwiDBCDwqGMDFtHG/k2r/pUI4
         jVKA==
X-Gm-Message-State: AOJu0YyJCrIEAMqv2n2NCOrE13tUUMI65GBXms/mYhaRqZlQvZuL0Wc8
	Put9nRSYIwB3nW5dw4N8aP67bRJCsqc858wbDY9jPzHNddX94H7f
X-Google-Smtp-Source: AGHT+IFy2MngrrMeMHNBpvEhENufa0ktPIXPrgm36Uv17pcnuYA720ma1pn9VbdyvPgHZMTooirMNg==
X-Received: by 2002:a17:906:a9b:b0:a31:68e2:1438 with SMTP id y27-20020a1709060a9b00b00a3168e21438mr27176ejf.310.1706211319178;
        Thu, 25 Jan 2024 11:35:19 -0800 (PST)
Received: from localhost (fwdproxy-lla-120.fbsv.net. [2a03:2880:30ff:78::face:b00c])
        by smtp.gmail.com with ESMTPSA id gh10-20020a170906e08a00b00a311a360433sm1356580ejb.143.2024.01.25.11.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 11:35:18 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Cc: dsahern@kernel.org,
	weiwan@google.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wpan@vger.kernel.org (open list:IEEE 802.15.4 SUBSYSTEM)
Subject: [PATCH net 09/10] net: fill in MODULE_DESCRIPTION()s for ieee802154
Date: Thu, 25 Jan 2024 11:34:19 -0800
Message-Id: <20240125193420.533604-10-leitao@debian.org>
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
Add descriptions to ieee802154 modules.

Signed-off-by: Breno Leitao <leitao@debian.org>
Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
Acked-by: Stefan Schmidt <stefan@datenfreihafen.org>
---
 net/ieee802154/6lowpan/core.c | 1 +
 net/ieee802154/socket.c       | 1 +
 2 files changed, 2 insertions(+)

diff --git a/net/ieee802154/6lowpan/core.c b/net/ieee802154/6lowpan/core.c
index 2c087b7f17c5..e643f52663f9 100644
--- a/net/ieee802154/6lowpan/core.c
+++ b/net/ieee802154/6lowpan/core.c
@@ -280,5 +280,6 @@ static void __exit lowpan_cleanup_module(void)
 
 module_init(lowpan_init_module);
 module_exit(lowpan_cleanup_module);
+MODULE_DESCRIPTION("IPv6 over Low power Wireless Personal Area Network IEEE 802.15.4 core");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_RTNL_LINK("lowpan");
diff --git a/net/ieee802154/socket.c b/net/ieee802154/socket.c
index 00302e8b9615..990a83455dcf 100644
--- a/net/ieee802154/socket.c
+++ b/net/ieee802154/socket.c
@@ -1137,4 +1137,5 @@ module_init(af_ieee802154_init);
 module_exit(af_ieee802154_remove);
 
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("IEEE 802.15.4 socket interface");
 MODULE_ALIAS_NETPROTO(PF_IEEE802154);
-- 
2.39.3


