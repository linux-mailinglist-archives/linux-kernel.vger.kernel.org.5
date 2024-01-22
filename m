Return-Path: <linux-kernel+bounces-34000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 871908371C7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36E7929647F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4415C5E5;
	Mon, 22 Jan 2024 18:46:14 +0000 (UTC)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBB15BAF4;
	Mon, 22 Jan 2024 18:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705949173; cv=none; b=F2LnxvVOucF7ANThIGuAy31Q7tOBbcAVnQag6oKeLtCojLWS0gyMhNaaIZiyTRMAY8MF2Dkb9H1QY2gOsUFu5T0Ele2ZHmyg5e6TQ+d5m1a4g25+asgkSUgmZqt7M1LYFGl+LXElb4xMk1cyYyAIWYRLI7tAkAdgnKSRpLmqMe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705949173; c=relaxed/simple;
	bh=kf6bmK/5lk9stkBN4Rpip7baFHcgUQQrvt2ce0mTj0A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T45xNXk7ikpQEMWI/IErebV5Mx/udVn1iV++QQX52aWwTal0tAhetRG1DPwY5Bvauyd9yqkAqvIgVgZuravkvbBRukFRlJV2dtYRReBb/61Yf9LgwKvNOYJT6XFFGGm6kXLQhhXf/uy6/y4K1+oqAKSrrMtmpWeMSRPsMefS4fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-50eac018059so4731035e87.0;
        Mon, 22 Jan 2024 10:46:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705949170; x=1706553970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gE9feN88FqRXaolmPa4tAqvmCByBo2Odu5gsqKyhyy4=;
        b=jZlsyW6DNcvgX411KZ3o+Usl4k0/rzDjyDK9kRQpBSoabodQbcVGhEUnLALiUnexwZ
         QrEl1/Z8psdDA79xU115lyA5qOfjj88JnziKAjfaODRUjdUEMOmf+My5p9+jCBWClgwf
         WD/Yonhh9I0xNPeHLulYOzFIMpID6TQSRlho5jWCbX8dGNABIzSeMfbuXx3aQ0BNJeOr
         hB/Go/3dKupBlPcfeSlo2p9LhufbM4C8LO5+urU40UVSJTUWdywbSxnJJuelhOnaRE25
         9rIYZop4eH8umxE6HxOHbdr7z0aeco98K/MsyNoAZ1SQox1gZ6biY0gnPg+k11wXWauI
         F1XA==
X-Gm-Message-State: AOJu0YwmXs+EwJ4nUMmHvvoZNFwgWQGr1d1pqOa8eWVlBTh/bU05mwth
	/b1WWpyuU+V53dp7K3w0iMPtpPklg+gjWcHLPrSz00TjjeYcap+b
X-Google-Smtp-Source: AGHT+IFB2B+Hq2ok+823r8fiTTqB1mjG3L7ABIBpjIfvIoVlOZ5/UWi090tl3GheYU1piJ2Aft2FaA==
X-Received: by 2002:ac2:5f72:0:b0:50e:bb4d:e502 with SMTP id c18-20020ac25f72000000b0050ebb4de502mr1872429lfc.122.1705949169857;
        Mon, 22 Jan 2024 10:46:09 -0800 (PST)
Received: from localhost (fwdproxy-lla-119.fbsv.net. [2a03:2880:30ff:77::face:b00c])
        by smtp.gmail.com with ESMTPSA id a13-20020a170906274d00b00a2b608ad048sm13593462ejd.28.2024.01.22.10.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 10:46:09 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	abeni@redhat.com,
	edumazet@google.com,
	Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: dsahern@kernel.org,
	weiwan@google.com,
	linux-wpan@vger.kernel.org (open list:IEEE 802.15.4 SUBSYSTEM),
	netdev@vger.kernel.org (open list:NETWORKING [GENERAL]),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 02/22] net: fill in MODULE_DESCRIPTION()s for ieee802154
Date: Mon, 22 Jan 2024 10:45:23 -0800
Message-Id: <20240122184543.2501493-3-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240122184543.2501493-1-leitao@debian.org>
References: <20240122184543.2501493-1-leitao@debian.org>
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


