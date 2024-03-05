Return-Path: <linux-kernel+bounces-91900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 553E187181E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01DCBB21CC7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B057F496;
	Tue,  5 Mar 2024 08:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hzNZC/Qi"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5847A7F482;
	Tue,  5 Mar 2024 08:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709626855; cv=none; b=Oj9zI+luyOIeU5pJHWWdAYT7Z+K8/kqN5YUpibktCSgYUWHx7oTj8ngfLeEhI7mncfA5kZG4dxgoN0V6yWEMuXRBNiN+XfdLC5T44ZnCneTZEq6953eNdlYxFVP/C9J2NmOQWRVPgFI4TLxmPfyTnsge695SR/ZZSTTo9+yDkbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709626855; c=relaxed/simple;
	bh=hZo+4VkfzgWJKPhG/ii63dRyDDI+/MxjXieNWDVvQMU=;
	h=From:To:Cc:Subject:Date:Message-Id; b=sQV9cXkBmkudgVIexQpOMt8/u7Wt/FkGvTRIbzf4feAyRe8FD7fcbYZhjgpZRYepMvNnfXx9ST8z0m9fvOhAKPNUMYPzHJpLgvDwNSd9977qSk0QFSTAvz+1XYY2bgy7ztkUWE7TI0lKs1Ii/W1dvzLwNUN3QYrAV2sklp4u38o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hzNZC/Qi; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1dca160163dso51964535ad.3;
        Tue, 05 Mar 2024 00:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709626853; x=1710231653; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ENVdbWViMNbdMsk2tYBUD+u8dUrBMYPUAx5W7hzKOFo=;
        b=hzNZC/Qi8H/SscKrlapDWqj+mELUkXZz3MC4rkG8Pmm/xtiHz843DSJT/cDIL2o95B
         XKA9hb3W+oP9/sPamtzhaFPCm6otIKNNUpY1Gbw8iDCVaAW5gRLFAC9uT3g20dMmwlsl
         RSL/F6+TQ+kuyhdwO0AxccLsC3kCl0bPNBz6WWwJ+ETkBQ+WEMgIDQ0VaYt8qFokOuzU
         l5fEy9F0G5nJUDdKaoqS8UvVpK8PfCmP6EYiDHbD9i0VFLIyNuzmk+SDUmcQf+NQsGZD
         AjlADDeQXiAoKrfoUSurPuddBd14vfM+DZsqh+h9+dzNRlWLNF9TqEH9DUqlJ9BlNfBC
         0V0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709626853; x=1710231653;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ENVdbWViMNbdMsk2tYBUD+u8dUrBMYPUAx5W7hzKOFo=;
        b=gdUOowWt220pbCoDyAfGkAV2nwtz+1a1qzGQevh6UblcJFlNRSjntfe3kt9ZXcVrX4
         tVO5F+IkhoIfbmTBPlkjxdd1whhD7iwvQklmHD0VUVh1ZpDnV1ugtf2ThPWDoFUNjsH/
         pM4v/OPsA7zGHrguLkOLkux8UK6Y7B430IzQr0Zo5+Vy2amYO7EC/Ipv7zJvEf+NjN+S
         StKNjkQfeYZOFzeKHa2Fkxpf6T0jOXZW/hpa7YKbSpEJFLhjnfUGPs3M2m4WvT0R1Vt6
         ygsEhiL9mBmLif/jMOxCbPcSurOaPTR4UveVUnHMgAvDfT/tzvC380V63IT4QFimCgLQ
         +OYw==
X-Forwarded-Encrypted: i=1; AJvYcCWk2/ObfjFr8v0Dny/SnAJz5oLLrQYQfcf2NE9/pCjoUgOZKEpjvcN7XCMY5zBvNNbJUgD4LQNnQ/KYgyPtHyADeMy7qTg2z4+nIYaAkky/lQul11+uziW5i/OPDj1TiJ/j0bwxUelqQpk=
X-Gm-Message-State: AOJu0YxTA9k9RAg+AYv8eiXQuuIUZLaof2Hzx/DBDkBvBgVElT6l4Wk5
	Wi6l/3V6CwdCwO9jwh2ZfVyo7N1oP3Vba+YL3qZ1SdvCYyxtIrmW
X-Google-Smtp-Source: AGHT+IGRIXT23C4Loa9kbMHMWmSzvg6b+GSBp7ilkDEE0aeiD2V7Hmv5vccuK/1kB+/XZYehRpgWHQ==
X-Received: by 2002:a17:90a:c01:b0:299:39e0:98cb with SMTP id 1-20020a17090a0c0100b0029939e098cbmr9160055pjs.15.1709626853359;
        Tue, 05 Mar 2024 00:20:53 -0800 (PST)
Received: from linux-l9pv.suse ([124.11.22.254])
        by smtp.gmail.com with ESMTPSA id mf12-20020a17090b184c00b002904cba0ffbsm11239864pjb.32.2024.03.05.00.20.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2024 00:20:53 -0800 (PST)
From: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
X-Google-Original-From: "Lee, Chun-Yi" <jlee@suse.com>
To: Justin Sanders <justin@coraid.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	Pavel Emelianov <xemul@openvz.org>,
	Kirill Korotaev <dev@openvz.org>,
	"David S . Miller" <davem@davemloft.net>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chun-Yi Lee <jlee@suse.com>
Subject: [PATCH] aoe: fix the potential use-after-free problem in aoecmd_cfg_pkts
Date: Tue,  5 Mar 2024 16:20:48 +0800
Message-Id: <20240305082048.25526-1-jlee@suse.com>
X-Mailer: git-send-email 2.12.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: Chun-Yi Lee <jlee@suse.com>

This patch is against CVE-2023-6270. The description of cve is:

  A flaw was found in the ATA over Ethernet (AoE) driver in the Linux
  kernel. The aoecmd_cfg_pkts() function improperly updates the refcnt on
  `struct net_device`, and a use-after-free can be triggered by racing
  between the free on the struct and the access through the `skbtxq`
  global queue. This could lead to a denial of service condition or
  potential code execution.

In aoecmd_cfg_pkts(), it always calls dev_put(ifp) when skb initial
code is finished. But the net_device ifp will still be used in
later tx()->dev_queue_xmit() in kthread. Which means that the
dev_put(ifp) should NOT be called in the success path of skb
initial code in aoecmd_cfg_pkts(). Otherwise tx() may run into
use-after-free because the net_device is freed.

This patch removed the dev_put(ifp) in the success path in
aoecmd_cfg_pkts(), and added dev_put() after skb xmit in tx().

Link: https://nvd.nist.gov/vuln/detail/CVE-2023-6270
Fixes: 7562f876cd93 ("[NET]: Rework dev_base via list_head (v3)")
Signed-off-by: Chun-Yi Lee <jlee@suse.com>
---
 drivers/block/aoe/aoecmd.c | 12 ++++++------
 drivers/block/aoe/aoenet.c |  1 +
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/block/aoe/aoecmd.c b/drivers/block/aoe/aoecmd.c
index d7317425be51..cc9077b588d7 100644
--- a/drivers/block/aoe/aoecmd.c
+++ b/drivers/block/aoe/aoecmd.c
@@ -419,13 +419,16 @@ aoecmd_cfg_pkts(ushort aoemajor, unsigned char aoeminor, struct sk_buff_head *qu
 	rcu_read_lock();
 	for_each_netdev_rcu(&init_net, ifp) {
 		dev_hold(ifp);
-		if (!is_aoe_netif(ifp))
-			goto cont;
+		if (!is_aoe_netif(ifp)) {
+			dev_put(ifp);
+			continue;
+		}
 
 		skb = new_skb(sizeof *h + sizeof *ch);
 		if (skb == NULL) {
 			printk(KERN_INFO "aoe: skb alloc failure\n");
-			goto cont;
+			dev_put(ifp);
+			continue;
 		}
 		skb_put(skb, sizeof *h + sizeof *ch);
 		skb->dev = ifp;
@@ -440,9 +443,6 @@ aoecmd_cfg_pkts(ushort aoemajor, unsigned char aoeminor, struct sk_buff_head *qu
 		h->major = cpu_to_be16(aoemajor);
 		h->minor = aoeminor;
 		h->cmd = AOECMD_CFG;
-
-cont:
-		dev_put(ifp);
 	}
 	rcu_read_unlock();
 }
diff --git a/drivers/block/aoe/aoenet.c b/drivers/block/aoe/aoenet.c
index c51ea95bc2ce..923a134fd766 100644
--- a/drivers/block/aoe/aoenet.c
+++ b/drivers/block/aoe/aoenet.c
@@ -63,6 +63,7 @@ tx(int id) __must_hold(&txlock)
 			pr_warn("aoe: packet could not be sent on %s.  %s\n",
 				ifp ? ifp->name : "netif",
 				"consider increasing tx_queue_len");
+		dev_put(ifp);
 		spin_lock_irq(&txlock);
 	}
 	return 0;
-- 
2.35.3


