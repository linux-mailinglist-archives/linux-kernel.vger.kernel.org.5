Return-Path: <linux-kernel+bounces-37456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F3483B056
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C92781F2B701
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E5C1292FF;
	Wed, 24 Jan 2024 17:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gGVqIQur"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8D68615D;
	Wed, 24 Jan 2024 17:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706118437; cv=none; b=HP5k+GwkqWqV3C8yYTzIqe4cXcECY1AUoL3Ce45IwjvlJeGQcRL9NChxF2buMYRfdFfaNznSr801RvqayDXivv+Y06WZWriN2iQzfJ3CWheiCHhfn4Dx+0SZ3tNLuFAnSUTy9Tc+MGdL7lRPW8YJkZlXxKicb8HJGwSavkps/8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706118437; c=relaxed/simple;
	bh=s3tKx9YDYT51+QXp1CdeWhCE59bgmZCtnv1eFlCrWyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UqcKer7nXnKJ2SQlY9uZHOj+4RRgganNot1FvqJZ5xTognlQ4XWOW7cidroklDEA3wqTnTWhdgIIIXTMsSlqWiCvbbexwqU2URTai68RqCc+2sd80v3lhkwkX36AeH/Y6Hj8a0fUBISXTzMsXDpPGJ5hKn03l7XXURr5jJwSYTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gGVqIQur; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6dd7b525cd6so1636913b3a.2;
        Wed, 24 Jan 2024 09:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706118435; x=1706723235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5a7ZVpYjt4glIMRdLh4WlPExoPNat5beHZOUQY5BsC8=;
        b=gGVqIQurEaMo3tLoJeZrqMMO0q7AatnxmBmqh+1djVTSm2bm60kLE/LMm5eDbb6ngw
         dPZ3ddh95LSC9YPDGZ+xFWDQb/7r5bTXtQRF+K+BpTivCl16EsBGyoGJvPHC69Dp/UJ+
         HoSb+7uwc8bI6ZBcdN/gf8aykBG/FK0WZXrRhqhhUdpPZXUtSjflU4S+7cZWtGcwB13n
         NM3Hi9ykeQoDAeE1DYKiDuQtwZaxyIBNb464xAkCqEUwHOQRlHUTPyNd7Vxh+0B46zzc
         7l0jHrNKncPfmIOpdt6AlpakRbwHp9LwUnTYPaOaZOPVUowgUXNHzMWYWOWAXb/2nDPD
         +Kqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706118435; x=1706723235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5a7ZVpYjt4glIMRdLh4WlPExoPNat5beHZOUQY5BsC8=;
        b=DLSJLD3n3ePYiKa8lrTDqgX9JJepVUvIDaXPwFT9d0xe7p8w5jdGUyuPLkV2mWXmXb
         ui9rECgyH2+2I7ojaon1+eY6IlndjlwI0Sge7huCguUjH7uJ/V6PUkNGzEuHnVKekmy4
         3SmjjXAHf+b9fPUt9iKXqMXM5dEs9KDOq46pkCO5Q8rBzdFqSgsDd56mErAUVfM2iczu
         CEXJrMjvpcVwMw6P/530XFhxaXKRTM+2XRLSR4P5ND4FaTExv4L6MBOuaBNkkf3vfF9e
         xyatO5XwrNyiMnda3aoD3lu/nEY0qG9sXGfgEFXlR2I8q1J56mHLz5sRwE/bZduowze4
         XlWg==
X-Gm-Message-State: AOJu0YzzBDE53WdJ7vl11GLskOUwYMmivrikYno7n3O33rYBgvsJC0Dw
	ojGxbS4Quck+49AXn7Oa8okm9HXVzyBxpimuIaUdwfNCaoZxhPo2xuucJF4x
X-Google-Smtp-Source: AGHT+IGs6/sPxiwsiqboKf3NTC/pRHlQL1NFRL2qILAmDDjPkZjjLa5FgIT+lNJQ07puwzt8L2e1ZQ==
X-Received: by 2002:a05:6a00:1d24:b0:6dd:c48c:4d8d with SMTP id a36-20020a056a001d2400b006ddc48c4d8dmr102079pfx.46.1706118435122;
        Wed, 24 Jan 2024 09:47:15 -0800 (PST)
Received: from localhost ([2601:644:9380:8cd0::7fb4])
        by smtp.gmail.com with ESMTPSA id y22-20020a62b516000000b006dbd2405882sm8401518pfe.148.2024.01.24.09.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 09:47:14 -0800 (PST)
From: Matthew Wood <thepacketgeek@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: leitao@debian.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v1 1/8] net: netconsole: cleanup formatting lints
Date: Wed, 24 Jan 2024 09:46:59 -0800
Message-ID: <20240124174711.1906102-2-thepacketgeek@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124174711.1906102-1-thepacketgeek@gmail.com>
References: <20240124174711.1906102-1-thepacketgeek@gmail.com>
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


