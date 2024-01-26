Return-Path: <linux-kernel+bounces-40808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8056A83E656
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 00:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E0621F21B89
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19FE65821F;
	Fri, 26 Jan 2024 23:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UqPlynPs"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB04F57331;
	Fri, 26 Jan 2024 23:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706310835; cv=none; b=LX+00XuisPmlq50wAcauOfoSye3EbaRuWdwo8l9uC2/JnCIB5De5BUHPKx/AjSzTNGedy4ph3nDWYLfxhfrHJLANdAr20FT1utyAljO/oEj1PJAzwHKl7PZe+fWXl5lfN3q5HfbMgSKL9sCpiw3WXZ4K2Txr7tTWGGlT4dHYyD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706310835; c=relaxed/simple;
	bh=s3tKx9YDYT51+QXp1CdeWhCE59bgmZCtnv1eFlCrWyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L5r9cL9N4i50UR+L2Ilg9J6yeWZ93NZflHqOUw74VkbgH5ykWr3/ekQ1XQEUx8pi2nQcVpN7vdpxM0gurYR5/3cLRskohDHcWziCUaOFWq4HjrNlixyrkDDmf0oUdSW1ARjSDASE1cbXDWavpOtuzFlC41jajMd/Mrt9zVgV/P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UqPlynPs; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d70a986c4aso5642135ad.2;
        Fri, 26 Jan 2024 15:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706310833; x=1706915633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5a7ZVpYjt4glIMRdLh4WlPExoPNat5beHZOUQY5BsC8=;
        b=UqPlynPsztqLdGXnaltynKfnV501dth5XU+umP7NH6EvticoVwN+8l3A9oWXGzOhLv
         wP0GY3tr9DEvogmcO5o2cpzUuMzIGbSmmNa6jSr0f+r74gy2azTL4Z5DJKINFN5v9Y5h
         5WyEKBqSez61m4w1Zk9CQcQzMHP797Eq3IBxPHzAyLb1PRK04VrUke9MosItdLEOPSR5
         vAoKFzG/Xti/NPdDnspv/NkEBR6oLC4FpmxNybEFznJI01V0Nmz2B83vbqLQsctDqZue
         07CWx4iaUGLDBw/R8qeVDL1atO62spvx+F0igmrWbUidD+HnWuvMb8x35LzwkNPoM4f2
         fPQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706310833; x=1706915633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5a7ZVpYjt4glIMRdLh4WlPExoPNat5beHZOUQY5BsC8=;
        b=okHBXUfbGAVy4e/8xAzHSwEqI90mr845vBYaNfF/+RS6v9Ptk+2JclKStXglXeEXUg
         4/GRRrPPbzLicGSMRz/Fu32v77txkw2FPsNTeu5KilAGxodQvV4gTDL/myB/VkvULis8
         eux2ODz1k9fyyXqXMq/xguGPrIc+pku3Xw6iqDwKF+O2QuoAJYqtZXRSKEHxhXIuVl8N
         KhH9LdS6OBRLvZhwfI4C2WjF4XvBTDWCXLdtkV4vWLQ9Del/gvEltqYRtColb2xSFQ8j
         DFIgLZikBj3BFsLHqnhr3BarEt4Oh1uNqPU0jLcm5t2tGGkL5kB8yU+okiPADlUUng+l
         /c2g==
X-Gm-Message-State: AOJu0Yxjarb/NMfSOl79xgN6i1LVt+rUaMG5Tn6DCQ7yMtsMql7UlKmS
	p8mClzmtwGZwibDzW2gyU1R/NjP9L7NrKxU0olcMzLKCC/tqCrMZ
X-Google-Smtp-Source: AGHT+IGm8ftLckKRhNCpqB/Sy2E526iG/YQV1te0xGevvgtiE5N9U0X0TtpC38erBINEyz2AwoJrzQ==
X-Received: by 2002:a17:902:7402:b0:1d7:52b6:d178 with SMTP id g2-20020a170902740200b001d752b6d178mr701957pll.42.1706310833146;
        Fri, 26 Jan 2024 15:13:53 -0800 (PST)
Received: from localhost ([2601:644:9380:8cd0::7fb4])
        by smtp.gmail.com with ESMTPSA id jy15-20020a17090342cf00b001d71eac34a6sm1426298plb.294.2024.01.26.15.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 15:13:52 -0800 (PST)
From: Matthew Wood <thepacketgeek@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: leitao@debian.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 1/8] net: netconsole: cleanup formatting lints
Date: Fri, 26 Jan 2024 15:13:36 -0800
Message-ID: <20240126231348.281600-2-thepacketgeek@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240126231348.281600-1-thepacketgeek@gmail.com>
References: <20240126231348.281600-1-thepacketgeek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Address checkpatch lint suggestions in preparation for later changes

Signed-off-by: Matthew Wood <thepacketgeek@gmail.com>
---
 drivers/net/netconsole.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 6e14ba5e06c8..93fc3b509706 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -49,7 +49,7 @@ static char config[MAX_PARAM_LENGTH];
 module_param_string(netconsole, config, MAX_PARAM_LENGTH, 0);
 MODULE_PARM_DESC(netconsole, " netconsole=[src-port]@[src-ip]/[dev],[tgt-port]@<tgt-ip>/[tgt-macaddr]");
 
-static bool oops_only = false;
+static bool oops_only;
 module_param(oops_only, bool, 0600);
 MODULE_PARM_DESC(oops_only, "Only log oops messages");
 
@@ -501,6 +501,7 @@ static ssize_t local_ip_store(struct config_item *item, const char *buf,
 
 	if (strnchr(buf, count, ':')) {
 		const char *end;
+
 		if (in6_pton(buf, count, nt->np.local_ip.in6.s6_addr, -1, &end) > 0) {
 			if (*end && *end != '\n') {
 				pr_err("invalid IPv6 address at: <%c>\n", *end);
@@ -510,9 +511,9 @@ static ssize_t local_ip_store(struct config_item *item, const char *buf,
 		} else
 			goto out_unlock;
 	} else {
-		if (!nt->np.ipv6) {
+		if (!nt->np.ipv6)
 			nt->np.local_ip.ip = in_aton(buf);
-		} else
+		else
 			goto out_unlock;
 	}
 
@@ -537,6 +538,7 @@ static ssize_t remote_ip_store(struct config_item *item, const char *buf,
 
 	if (strnchr(buf, count, ':')) {
 		const char *end;
+
 		if (in6_pton(buf, count, nt->np.remote_ip.in6.s6_addr, -1, &end) > 0) {
 			if (*end && *end != '\n') {
 				pr_err("invalid IPv6 address at: <%c>\n", *end);
@@ -546,9 +548,9 @@ static ssize_t remote_ip_store(struct config_item *item, const char *buf,
 		} else
 			goto out_unlock;
 	} else {
-		if (!nt->np.ipv6) {
+		if (!nt->np.ipv6)
 			nt->np.remote_ip.ip = in_aton(buf);
-		} else
+		else
 			goto out_unlock;
 	}
 
@@ -781,6 +783,7 @@ static int netconsole_netdev_event(struct notifier_block *this,
 	spin_unlock_irqrestore(&target_list_lock, flags);
 	if (stopped) {
 		const char *msg = "had an event";
+
 		switch (event) {
 		case NETDEV_UNREGISTER:
 			msg = "unregistered";
-- 
2.43.0


