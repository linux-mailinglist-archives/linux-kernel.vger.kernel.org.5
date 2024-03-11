Return-Path: <linux-kernel+bounces-98761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC362877EFD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 12:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 687D81F22724
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 11:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25AA33C484;
	Mon, 11 Mar 2024 11:25:03 +0000 (UTC)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048673C493;
	Mon, 11 Mar 2024 11:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710156302; cv=none; b=A1XTmy/Uxl98JXCCaRqKGo5tPeXWmjHCFnzu9mZUrMfb91FX7eP13e1L7MK64qYfOiMTnELQg0sYRpVo4DwrGHO30/BFEnuBeQYCHwEo8WROPGbIH01aaTSiRm4OqENZxtn5kcHMnR021wOhGEJjQdMXyu7TBxcoRpcUBb5/V7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710156302; c=relaxed/simple;
	bh=4pDVnZkHej3RuwF5nxZLKJSsv+DmPh3nKITPhTPBN/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mw2b03VdF7HrlyYNRPFN929QA9H6X9XRlu4vdhBcaUoKA7/BV0V3QQRmulyMrUhsodC6Hcrs4lPdxMsSuoyuZOKkqAs0GTHMeGRjIaRY+D29Ejb6giom501uEN5heESwNaiNtsgmFv23MOIlGlLHvHU5di5PfomXp9kNTtZje3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5683576ea18so3148915a12.3;
        Mon, 11 Mar 2024 04:25:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710156299; x=1710761099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tn6DoL4XiC/1sb436SFq4XKysqpuHz83glo8mzdMNKA=;
        b=webuKl6a8bMD5uI8zBfuXQ+7PCNltcSy1cUx71RtwhXnEQQ0NGOa7HpQc5daMURovV
         pDpuZQYu2wvvBToQqD+bwhTaOSD9PHV0ngNoCh5F8jSpU0rjzsjAj8cL0pGdegHxgcgc
         E3L5aSXaVlYGP5iqRSYTft6BIbhBQF1eJT1dGntPPrqxw4E2UtaV5btmd5d0Wgif0gmr
         XD9BkZLCSnwP+AfEBo3HJ1MjpaHGyw9FBDFabLww0JUrtvG/4eYKH08N8HfUR49R/l59
         d1S2zJWqndIHmd3x+J0OVJit6FAsVk39doywEEAc0GZOWnuljmYSej1Qma736tWOz3/p
         w6Kg==
X-Forwarded-Encrypted: i=1; AJvYcCX5cTJd2iv3JXqAJNhvModqmpIIZjVoSAWPxcBeL1B2oMgOBM7BY/LbgwSGQMKIV4SfaEFDnBYKm/dlnzG7lupuX4jkY2tI7dY5pQegC3Jenypnmefx0O3r10Cn/gpeVqHuB9/S
X-Gm-Message-State: AOJu0YxrTXNSfMfDu+13wr9FbrIte+KamM0X7A5q7LXmkzaR3HQqI2IS
	e5Vv1pyKSTBj2W1STS2Vne93zBJicYdVYp72Q9Yy/p4KDJP3Zcyw
X-Google-Smtp-Source: AGHT+IFpol4GKbefX4gxusREijrPiCVSvlLD2YwUl3LIMYtv+crpJlIwGpJ9CLa9SEwoEMWtDjfNBA==
X-Received: by 2002:a05:6402:907:b0:566:b91f:1980 with SMTP id g7-20020a056402090700b00566b91f1980mr4312961edz.31.1710156299225;
        Mon, 11 Mar 2024 04:24:59 -0700 (PDT)
Received: from localhost (fwdproxy-lla-005.fbsv.net. [2a03:2880:30ff:5::face:b00c])
        by smtp.gmail.com with ESMTPSA id ev19-20020a056402541300b0056742460f68sm2780020edb.66.2024.03.11.04.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 04:24:58 -0700 (PDT)
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
Subject: [PATCH net-next 2/2] vxlan: Remove generic .ndo_get_stats64
Date: Mon, 11 Mar 2024 04:24:31 -0700
Message-ID: <20240311112437.3813987-2-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311112437.3813987-1-leitao@debian.org>
References: <20240311112437.3813987-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 3e2f544dd8a33 ("net: get stats64 if device if driver is
configured") moved the callback to dev_get_tstats64() to net core, so,
unless the driver is doing some custom stats collection, it does not
need to set .ndo_get_stats64.

Since this driver is now relying in NETDEV_PCPU_STAT_TSTATS, then, it
doesn't need to set the dev_get_tstats64() generic .ndo_get_stats64
function pointer.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/vxlan/vxlan_core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 6f26003a3064..3495591a5c29 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -3214,7 +3214,6 @@ static const struct net_device_ops vxlan_netdev_ether_ops = {
 	.ndo_open		= vxlan_open,
 	.ndo_stop		= vxlan_stop,
 	.ndo_start_xmit		= vxlan_xmit,
-	.ndo_get_stats64	= dev_get_tstats64,
 	.ndo_set_rx_mode	= vxlan_set_multicast_list,
 	.ndo_change_mtu		= vxlan_change_mtu,
 	.ndo_validate_addr	= eth_validate_addr,
@@ -3238,7 +3237,6 @@ static const struct net_device_ops vxlan_netdev_raw_ops = {
 	.ndo_open		= vxlan_open,
 	.ndo_stop		= vxlan_stop,
 	.ndo_start_xmit		= vxlan_xmit,
-	.ndo_get_stats64	= dev_get_tstats64,
 	.ndo_change_mtu		= vxlan_change_mtu,
 	.ndo_fill_metadata_dst	= vxlan_fill_metadata_dst,
 };
-- 
2.43.0


