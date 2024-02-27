Return-Path: <linux-kernel+bounces-83837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7226C869F0E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B7DA28F2AD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4479D14830F;
	Tue, 27 Feb 2024 18:27:24 +0000 (UTC)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DA425757;
	Tue, 27 Feb 2024 18:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709058443; cv=none; b=cMYdCF/Au+9cpYY4QOdF2P5xPwyrpduYiChiuAVocXzQpOKTZxVIM1/HF9au+c97vPYpyBDR+D7v+4n1w0Z9fzqgdUn1OEoCC8WnWY2gg60jYSfByw2orr97mZk48y8tItcZFxxpGwps9/ZqLqX+0qFO5jVJ369Yc7CSkRo9zfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709058443; c=relaxed/simple;
	bh=uO+QAb9CNhOXbeAPWDtH2HJL7jsZQvvk4tKvYfP5lKI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G1HQQuJdeI+peXDF8mxyLG3O4tOPS/QeM17acjbyFSKLFOi8TcFv9H65/Wn9GzzGxRiYrdqZam/WFNrIry8dEcuaeQoTVtJND17vKosRqLpvKVJujSBJbA1Ypu8bOdiygHnllrdv6S93pxEZ7E0MvS8zOLBJdTTQmI85N2fmgUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d24a727f78so64487591fa.0;
        Tue, 27 Feb 2024 10:27:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709058440; x=1709663240;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BYvzYko0Is+SAP/w3hqBwCLet2Nqsl8SFgKdmiGU1T4=;
        b=QomaE3IKCt2eKFkSlknGy+xuk8My/4R33j4SmsSrVDj13cMjuo/g8s3jsLNWHqC4nc
         jj2Gx5Evn7+ubTqNJXkEMG+il44WYHL4owS/KgNxylIsela2kaY29pyPjC6EPATsgFB+
         VBKjbcvLrkLzNMcmRJNB8adfMfZEPvwtWIde3AgAHMqHo8AlT0Yewhrc1yGv9/25MKww
         saR+0MZvKIpgvrXBvfnylDGVgDLLphbTmRAzD4XPyJemgnXirbSZOUT2nV+H1E+ozsBw
         aMCK2U4tYKv4b2A3pIXDRee3FA1TT4DH7by9ABubKGY1Ex32pEmDoUDbH6kBhUKE5v4C
         G44g==
X-Forwarded-Encrypted: i=1; AJvYcCVts9PgUJrBykEfUEQu/W8iTG3/kNHKQOsvUlon7lddiVusdyHL99TX8nJoC+NMovB/1juZfixp5zZoi2E057nbHhgEN0VHBFdoWYid
X-Gm-Message-State: AOJu0YyFTZPx9KWFEHOa7Uh7vKrZjMnMjIxtZdIOHPrgm2s2VnffORSX
	2BX6DiguHfFBGTi31zMEpR/brYWVzMCSrjlFKVdUEIFuWF6PFmU9pgUgu/Sp
X-Google-Smtp-Source: AGHT+IEUwtTbXJECoVbN5asUL5J5WG/LHgYO68BFG1pCrUGnFaCZjVTJp4FqoJhJXBMYuqLO4LYYaA==
X-Received: by 2002:a05:6512:33d5:b0:512:fe39:5d0e with SMTP id d21-20020a05651233d500b00512fe395d0emr5433262lfg.9.1709058439803;
        Tue, 27 Feb 2024 10:27:19 -0800 (PST)
Received: from localhost (fwdproxy-lla-000.fbsv.net. [2a03:2880:30ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id u11-20020aa7db8b000000b005653f390f77sm1001546edt.10.2024.02.27.10.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 10:27:19 -0800 (PST)
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
Subject: [PATCH net-next 1/2] net: bridge: Do not allocate stats in the driver
Date: Tue, 27 Feb 2024 10:23:36 -0800
Message-ID: <20240227182338.2739884-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With commit 34d21de99cea9 ("net: Move {l,t,d}stats allocation to core and
convert veth & vrf"), stats allocation could be done on net core
instead of this driver.

With this new approach, the driver doesn't have to bother with error
handling (allocation failure checking, making sure free happens in the
right spot, etc). This is core responsibility now.

Remove the allocation in the bridge driver and leverage the network
core allocation.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/bridge/br_device.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index 874cec75a818..4f636f7b0555 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -113,26 +113,18 @@ static int br_dev_init(struct net_device *dev)
 	struct net_bridge *br = netdev_priv(dev);
 	int err;
 
-	dev->tstats = netdev_alloc_pcpu_stats(struct pcpu_sw_netstats);
-	if (!dev->tstats)
-		return -ENOMEM;
-
 	err = br_fdb_hash_init(br);
-	if (err) {
-		free_percpu(dev->tstats);
+	if (err)
 		return err;
-	}
 
 	err = br_mdb_hash_init(br);
 	if (err) {
-		free_percpu(dev->tstats);
 		br_fdb_hash_fini(br);
 		return err;
 	}
 
 	err = br_vlan_init(br);
 	if (err) {
-		free_percpu(dev->tstats);
 		br_mdb_hash_fini(br);
 		br_fdb_hash_fini(br);
 		return err;
@@ -140,7 +132,6 @@ static int br_dev_init(struct net_device *dev)
 
 	err = br_multicast_init_stats(br);
 	if (err) {
-		free_percpu(dev->tstats);
 		br_vlan_flush(br);
 		br_mdb_hash_fini(br);
 		br_fdb_hash_fini(br);
@@ -159,7 +150,6 @@ static void br_dev_uninit(struct net_device *dev)
 	br_vlan_flush(br);
 	br_mdb_hash_fini(br);
 	br_fdb_hash_fini(br);
-	free_percpu(dev->tstats);
 }
 
 static int br_dev_open(struct net_device *dev)
@@ -496,6 +486,7 @@ void br_dev_setup(struct net_device *dev)
 	dev->hw_features = COMMON_FEATURES | NETIF_F_HW_VLAN_CTAG_TX |
 			   NETIF_F_HW_VLAN_STAG_TX;
 	dev->vlan_features = COMMON_FEATURES;
+	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
 
 	br->dev = dev;
 	spin_lock_init(&br->lock);
-- 
2.43.0


