Return-Path: <linux-kernel+bounces-159789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE9F8B340C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 11:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 157CA1C2239C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2518613F422;
	Fri, 26 Apr 2024 09:32:07 +0000 (UTC)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8471C02;
	Fri, 26 Apr 2024 09:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714123926; cv=none; b=GQ7DSHDZQGXpHk5kwZyuuOvVEUpXFIqf/boL2kS7RjKEnfyVs8lu9ZVyIqudCIbUA5ruPZcsN0PwUsSOBo6D6Rcg4Gf7KX+9cckuvP+BtJz6iQti5ikXY7TLswPP9RscQlxTK8EDGO9nR9KsR0edC+wriOPiNuoFaRRN4cnJRSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714123926; c=relaxed/simple;
	bh=rWF4T1ptwSPqA7KfHBNu5E0FUQmnrOyU/QxzFxfeU0E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rgh1OQXlJaWmBKrc3RL60algPvEtfnDCLhj9TVWV0MrJZ3cxHxtsVaP/37hlTvH5tm9qpdS9+zRPch4DvRouNtF2DA9uYh+N5OzK4fVYnrhH/dbxICw5MMYeAnBcTFTLoqFZssvYjRhjl/hUe4rDtC99qjLaHjuUgcwGqnGx6Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-572229f196cso2268297a12.2;
        Fri, 26 Apr 2024 02:32:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714123923; x=1714728723;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8gBPNnUV2Yn9Is2h8W1Y2Sei5FTqscCR/HpPNQnVetk=;
        b=Y02dI7QcjHStm87Ep2hhhx9VrV+rf6qAPitzHCNTBmt+WuXTPOQxAUDb//sdgyzTEF
         UnsDERmnQa+ZJRaqiC3wLIvvtA2OvAWLsYwitYjO9wAWTbnqC49pzxb71d0ooLEqreJc
         IfmwmIOMzbr4nQrwJ92eiGtoOWKWrEqU36ZXmr/sMDyK5zVOC41B/bOZv3O+EEET70Ck
         JB9OcAwTWVMHEb+Egtf1Tbp4C+6LQqWwz5UMofkw5yL0X+JMrhwRwKnBg/xNPwsFj/w3
         i/TNS8VrYLWgx7bwabdqiNfDC+/y//+Vr8AhE+H0dfch3Sd+WkrJs82rUf5u6fjb8Cbz
         VpPw==
X-Forwarded-Encrypted: i=1; AJvYcCVFHKA4jMDKmeLcKDN/c0UVSYc5BTGgwPULNbiTljYtt5+GzMzxeU88Mb6SEz9tzadRdvfgqQN3em/4iKuySZCZz3PVSzie1hOfAVhV
X-Gm-Message-State: AOJu0YzrYCJPLoXtwWB5FSfJoZgPNA9M2nUh9aAONXm3fEpYmzke8iFh
	Mt8RfY/4gsdy6zc16VB1t20xZvRylMdPwCKvHwP7eKA3VQfcJ+fK
X-Google-Smtp-Source: AGHT+IGjErk/3ApxpRPSTqyt/IYR+02NI5iRozuFmjFtbV2BdHu34uBHIEzirvS3Cd+uFy76rSRa8w==
X-Received: by 2002:a05:6402:229a:b0:572:5f53:816f with SMTP id cw26-20020a056402229a00b005725f53816fmr18669edb.37.1714123923193;
        Fri, 26 Apr 2024 02:32:03 -0700 (PDT)
Received: from localhost (fwdproxy-lla-008.fbsv.net. [2a03:2880:30ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id cn18-20020a0564020cb200b00571bfc97b79sm9535631edb.55.2024.04.26.02.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 02:32:02 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: kvalo@kernel.org,
	Igor Mitsyanko <imitsyanko@quantenna.com>,
	Sergey Matyukevich <geomatsi@gmail.com>
Cc: linux-wireless@vger.kernel.org,
	kuba@kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH wireless 1/2] wifi: qtnfmac: Move stats allocation to core
Date: Fri, 26 Apr 2024 02:31:48 -0700
Message-ID: <20240426093156.2002258-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With commit 34d21de99cea9 ("net: Move {l,t,d}stats allocation to core and
convert veth & vrf"), stats allocation could be done on net core instead
of this driver.

With this new approach, the driver doesn't have to bother with error
handling (allocation failure checking, making sure free happens in the
right spot, etc). This is core responsibility now.

Move qtnfmac driver to leverage the core allocation.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/wireless/quantenna/qtnfmac/core.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

PS: This is compile-tested only due to lack of hardware.

diff --git a/drivers/net/wireless/quantenna/qtnfmac/core.c b/drivers/net/wireless/quantenna/qtnfmac/core.c
index 677bac835330..0aa4b1d14809 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/core.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/core.c
@@ -196,22 +196,8 @@ static int qtnf_netdev_port_parent_id(struct net_device *ndev,
 	return 0;
 }
 
-static int qtnf_netdev_alloc_pcpu_stats(struct net_device *dev)
-{
-	dev->tstats = netdev_alloc_pcpu_stats(struct pcpu_sw_netstats);
-
-	return dev->tstats ? 0 : -ENOMEM;
-}
-
-static void qtnf_netdev_free_pcpu_stats(struct net_device *dev)
-{
-	free_percpu(dev->tstats);
-}
-
 /* Network device ops handlers */
 const struct net_device_ops qtnf_netdev_ops = {
-	.ndo_init = qtnf_netdev_alloc_pcpu_stats,
-	.ndo_uninit = qtnf_netdev_free_pcpu_stats,
 	.ndo_open = qtnf_netdev_open,
 	.ndo_stop = qtnf_netdev_close,
 	.ndo_start_xmit = qtnf_netdev_hard_start_xmit,
@@ -483,6 +469,7 @@ int qtnf_core_net_attach(struct qtnf_wmac *mac, struct qtnf_vif *vif,
 	dev->watchdog_timeo = QTNF_DEF_WDOG_TIMEOUT;
 	dev->tx_queue_len = 100;
 	dev->ethtool_ops = &qtnf_ethtool_ops;
+	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
 
 	if (qtnf_hwcap_is_set(&mac->bus->hw_info, QLINK_HW_CAPAB_HW_BRIDGE))
 		dev->needed_tailroom = sizeof(struct qtnf_frame_meta_info);
-- 
2.43.0


