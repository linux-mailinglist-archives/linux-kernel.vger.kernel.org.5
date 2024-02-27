Return-Path: <linux-kernel+bounces-83838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4F3869F11
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CB561C260EC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91140149DF2;
	Tue, 27 Feb 2024 18:27:25 +0000 (UTC)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9463F249EB;
	Tue, 27 Feb 2024 18:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709058445; cv=none; b=AoGT6rmVruQsqlI1EowgZRaZrm2ZwfxGAVwWBakYquwH+HisIx4/xgq4fXMU4qjyVEvm7ooQTr1UpuZq7gPocaHoS79vnmOkS606FZ9yTg/FPpSNbDJp81PjCgzxFnaQkBPQvkIADfYQRtV0pz+z7nIE0V4YIDqhmtkqE6dx6gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709058445; c=relaxed/simple;
	bh=zVMdHabuMFecxpBMg1WrZBM+FcSm73K54oXaYAI4aUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i9p84Q2LdMqcf7g/JaqN5iXXJN7BITr+twFPRWa2NKxiHDHljPg8G1epxDyYlMvYmCOu/ygKayV8We6QF2W9Fo8JWgOPajWXUxb23HCvCLQCYGgyhcCzeeA/IgQgvyduVDO1uOaA3CtPyy6o2RDbimQIes5sJl87w71swZxBTKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-563c595f968so6101253a12.0;
        Tue, 27 Feb 2024 10:27:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709058442; x=1709663242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+GeLmogx+cToEPykC0a7rvtGD8mgVekw3O/wzWzAUb0=;
        b=Qxzr4KwBGzXfJGAVPskE5Wh1Btc+fqH6aR7ZAWm8Pkex0PJwbWT4rsVE0OckFABoV6
         UlpLNoSvDRm1NXopdl+/zVPE3OeJDIZMM6bnq89R6cioGcidEA4deQbFimTs1QF2srfI
         t6euAIu1sb6bWAmdqxTCNK0zejCKrw/AEMwHSosHJgmMWoDeMM4TnKBplfr4oJTJLmvi
         oxl4v+Tiq8e44hNwljNfVXKxzKXe/68X91x8c+mNcUw3BthtBusvl1ShWFwY1FyHAkN5
         r0tBmQq0O/R+Hybebgzxs8lz7l7InZEi9xTjsrLOhLuu2l+qxNBQl1TsMfSjJJJ8l+NC
         IoyA==
X-Forwarded-Encrypted: i=1; AJvYcCUeJE8uinKUp7l00A1+5gYSRblUJiYqjc/kPirFUZ5H0ckOv3B3MrNQzjGAlAIe8fOeFkO+FPZb12B9GJnBs4DFXakt3TNY3yfjIayr
X-Gm-Message-State: AOJu0YxJEmnl93oNGl3BdLXYnDUXadghzCA+qlLCmSDS/NHH+UyXScRJ
	V3N+0LrEUIZri6035duhCa2bbkS7WIduE/J+lbE+Io9/Knl6wHIx
X-Google-Smtp-Source: AGHT+IG3+cBjRu18zHsitK0GU/ViOUBaX9yMmK4uLAz6mXML3LdPK2HpZLRz1e1fjky/bOVn+rBBfw==
X-Received: by 2002:a17:906:fcc1:b0:a41:682:c3b9 with SMTP id qx1-20020a170906fcc100b00a410682c3b9mr6849976ejb.65.1709058441885;
        Tue, 27 Feb 2024 10:27:21 -0800 (PST)
Received: from localhost (fwdproxy-lla-119.fbsv.net. [2a03:2880:30ff:77::face:b00c])
        by smtp.gmail.com with ESMTPSA id ef3-20020a17090697c300b00a4396ea6628sm1000810ejb.210.2024.02.27.10.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 10:27:21 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	bridge@lists.linux.dev (open list:ETHERNET BRIDGE)
Subject: [PATCH net-next 2/2] net: bridge: Exit if multicast_init_stats fails
Date: Tue, 27 Feb 2024 10:23:37 -0800
Message-ID: <20240227182338.2739884-2-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240227182338.2739884-1-leitao@debian.org>
References: <20240227182338.2739884-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If br_multicast_init_stats() fails, there is no need to set lockdep
classes. Just return from the error path.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/bridge/br_device.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index 4f636f7b0555..c366ccc8b3db 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -135,10 +135,11 @@ static int br_dev_init(struct net_device *dev)
 		br_vlan_flush(br);
 		br_mdb_hash_fini(br);
 		br_fdb_hash_fini(br);
+		return err;
 	}
 
 	netdev_lockdep_set_classes(dev);
-	return err;
+	return 0;
 }
 
 static void br_dev_uninit(struct net_device *dev)
-- 
2.43.0


