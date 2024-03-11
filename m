Return-Path: <linux-kernel+bounces-98760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ECBD877EFB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 12:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 097C61F21E90
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 11:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167433C064;
	Mon, 11 Mar 2024 11:25:00 +0000 (UTC)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4A43A8C0;
	Mon, 11 Mar 2024 11:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710156299; cv=none; b=EUFxOt2fvgimuuPX/7dz0MWr8EX/mDZq1Pced4a8lZDnz8RAvSwAhZ625owspJuUE7it8m4tIErHTYP160qXQR02zBUwQlboIoh8iyo+elMQGvLwDoOc00srDCw3i8yrbiH56MRrdVV3f/3Glt/n/yOfDzFgZai+6cDZ7JxuqHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710156299; c=relaxed/simple;
	bh=edscxhJ+ntq5cuIqMB4aCIAwEHOiuf4qwLeFkZGQS6k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IkcVIna5klLZ2KKIU9S+9utrDZ38n9i4mstAtetmZH3geGIIu6301R/lkeAB+JVAmDPA6/+DUso/Lp/9g0cVCLt3x5OGiGEdsJvwx9jTL/adW7LTQncqi87bpkLNUjujUjG7iQt7R1F12NQPlGKffNZrM8ChM4938CQnzu/GlfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a45f257b81fso327351066b.0;
        Mon, 11 Mar 2024 04:24:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710156296; x=1710761096;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2fwR9bgFz/hQ+RIWCBvp7Qx01qUpN78LiqG0Zncb2Gg=;
        b=Aom2ihYkW6PMYjL0QR0fAGHnrFETWSQJ2sOftVq9tK2zEtEz9Wgx+n1JZf+VmiTzzk
         776HGpsea4/ExOW0QpEDJcSavfQPXVyexjiSc7a1SQMcJGeVueAsCIV1ldniaIdPRzM3
         RiIEVGZizTMCcYyMPJLbu6t5M1BBl7HxXeDfr/tn9qay7hPPoq7+pEd/P2RvQJ8bcoL2
         tFvf7lS/mVTx6ol0uVAEbFPCMQ0LcRb+fCg1qJy3ONzVjl4DfDb49/23wjmgUC+fa2dD
         MTX08e1f3+K/owyrJkllP4tgtQLjAS/ohITYgR9jAFaksLp+tbbsvFJ0R0Xy0d4C4AUn
         jlWA==
X-Forwarded-Encrypted: i=1; AJvYcCW6ZJK7AeOTYAHrJJBZSlJNFmqugkWaIEkPn1+Xpk6ZKDSYLrzrH2DUoNlwcrnc1sUxbvg8x2yqFNZfV/ZzgnJUJi7K6ap52A0Q5F1i3ubxF28Til+6fLXvUQiQcW+VQxYkOkmR
X-Gm-Message-State: AOJu0YyGIvnfrH8Brw0haJlWY+raZ7Fgx8zeOpz8EmupJoWPCk3mDDMe
	/h+nPM85QaHIaAS0aB5ONhJQ4jApsqqESJlVjuElqhZW7Yfht/xp
X-Google-Smtp-Source: AGHT+IFxVLAfdf/vyE1mu/q3m3HsAChj0XG7vYC41Sd8p+N8tzM+AQzfNpmHPeFItPK77h3QlcTLNA==
X-Received: by 2002:a17:907:d510:b0:a45:b3f5:8229 with SMTP id wb16-20020a170907d51000b00a45b3f58229mr4045406ejc.40.1710156295693;
        Mon, 11 Mar 2024 04:24:55 -0700 (PDT)
Received: from localhost (fwdproxy-lla-006.fbsv.net. [2a03:2880:30ff:6::face:b00c])
        by smtp.gmail.com with ESMTPSA id oz2-20020a170906cd0200b00a449026672esm2755408ejb.81.2024.03.11.04.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 04:24:55 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: keescook@chromium.org,
	Ido Schimmel <idosch@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Amit Cohen <amcohen@nvidia.com>,
	Petr Machata <petrm@nvidia.com>,
	Jiri Benc <jbenc@redhat.com>,
	Beniamino Galvani <b.galvani@gmail.com>,
	Gavin Li <gavinl@nvidia.com>,
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 1/2] vxlan: Do not alloc tstats manually
Date: Mon, 11 Mar 2024 04:24:30 -0700
Message-ID: <20240311112437.3813987-1-leitao@debian.org>
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
instead of in this driver.

With this new approach, the driver doesn't have to bother with error
handling (allocation failure checking, making sure free happens in the
right spot, etc). This is core responsibility now.

Remove the allocation in the vxlan driver and leverage the network
core allocation instead.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/vxlan/vxlan_core.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 386cbe4d3327..6f26003a3064 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2841,15 +2841,9 @@ static int vxlan_init(struct net_device *dev)
 	if (vxlan->cfg.flags & VXLAN_F_VNIFILTER)
 		vxlan_vnigroup_init(vxlan);
 
-	dev->tstats = netdev_alloc_pcpu_stats(struct pcpu_sw_netstats);
-	if (!dev->tstats) {
-		err = -ENOMEM;
-		goto err_vnigroup_uninit;
-	}
-
 	err = gro_cells_init(&vxlan->gro_cells, dev);
 	if (err)
-		goto err_free_percpu;
+		goto err_vnigroup_uninit;
 
 	err = vxlan_mdb_init(vxlan);
 	if (err)
@@ -2860,8 +2854,6 @@ static int vxlan_init(struct net_device *dev)
 
 err_gro_cells_destroy:
 	gro_cells_destroy(&vxlan->gro_cells);
-err_free_percpu:
-	free_percpu(dev->tstats);
 err_vnigroup_uninit:
 	if (vxlan->cfg.flags & VXLAN_F_VNIFILTER)
 		vxlan_vnigroup_uninit(vxlan);
@@ -2892,8 +2884,6 @@ static void vxlan_uninit(struct net_device *dev)
 	gro_cells_destroy(&vxlan->gro_cells);
 
 	vxlan_fdb_delete_default(vxlan, vxlan->cfg.vni);
-
-	free_percpu(dev->tstats);
 }
 
 /* Start ageing timer and join group when device is brought up */
@@ -3316,6 +3306,7 @@ static void vxlan_setup(struct net_device *dev)
 	dev->min_mtu = ETH_MIN_MTU;
 	dev->max_mtu = ETH_MAX_MTU;
 
+	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
 	INIT_LIST_HEAD(&vxlan->next);
 
 	timer_setup(&vxlan->age_timer, vxlan_cleanup, TIMER_DEFERRABLE);
-- 
2.43.0


