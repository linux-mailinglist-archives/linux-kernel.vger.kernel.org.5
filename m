Return-Path: <linux-kernel+bounces-142935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBFD8A3241
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6BA91F26435
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFCA7149C44;
	Fri, 12 Apr 2024 15:19:47 +0000 (UTC)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CC2148FF9;
	Fri, 12 Apr 2024 15:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712935187; cv=none; b=ETuhd2T67qHHiX2nlMlE8tp7uBqQI+pryZNg2qU1vdS44yzLrlpLNIihkfimDsoxiYv7K+Tw6Pluegzf457J7onA0if/ynbVteWcURsEBkcwXTdsZtZr36iKxkXiKmh221H6j64mMqslC9bdyD0oDSNXTv+bwKZVVQrS3zVMcrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712935187; c=relaxed/simple;
	bh=1I9KctD9v8HDw1TZ54buI8FQkI+tMCN3Y5eq63v1xj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ke45mNOr5T3Ab5XYVxC92qLd+WN8Pr29kRwGtxI/FdJ2d2bXqZwUPZZfebm5p1k+bs/gBZhPpnrz1oIfA9eA1X75ksNXdfm96CaaYsxTAsaXYlW9GbGqOUtYALl4dbw0oLpeFncNpJaVCaKnCoDGio4wg54s8aYsOuQJOqM0m4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-563cb3ba9daso1031960a12.3;
        Fri, 12 Apr 2024 08:19:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712935184; x=1713539984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IsgwtMpEymBii2Q07PG7fDKinM7HRQw2ddeFPhLPyuo=;
        b=pgKPMxLIg13rIrNKEIzv+ESrGHLRaGJV/Cu8x7IYmhomlwFPRpe1b+0Cu9//2DrX3b
         DoGWmeyee5Nowj3xa+VnBnYH218qkUi0KDiKYLeMUILPPWBwpt2tjjfAGJ7KbEk5lvob
         IyGI6nZEZt/j5rTITuNo5VFOTNqGj80OxGqoY4QYi04swrmxoWdRBMNC5U9b9NzWJzTp
         eGEmbo17mrrhk7bjBUANmp3CkgyojERj7dvC2cvP1s1pNdxIE6GBHSEX5myaUEtPqxEX
         18m816OIlcN1zKaGWdc196PtuEwtPL/McitBaLgbI8MHvYS5rWIgsxXd0xMDQKfnNMuF
         YVlA==
X-Forwarded-Encrypted: i=1; AJvYcCXANeTrWaztdVrlvxKONGd6RB0r29uLg+dx0bC+YN5/Ae6uInFiEcKL1HNtxwUbX7JaGV7bMI1rGCKYRvoPyThWdw95DVyxj4adE5Nd
X-Gm-Message-State: AOJu0YzO7L+wP3JH5lBiN10TSzIgO4rMtMvR2diRkZqZ6DG6+U2K9kH3
	tm6BCRw+1+8V//mm7Psfqt09xU4x/eBrkLAQsoiwt942KI6Ns8JN
X-Google-Smtp-Source: AGHT+IHcKXe2KUB58A9HTpVzlHxQLHgjlX1xlkgMV5RezWAayQTuhjhD97HaygRb+Uiurq7avvTuTQ==
X-Received: by 2002:a17:906:f0ce:b0:a52:4363:b028 with SMTP id dk14-20020a170906f0ce00b00a524363b028mr25080ejb.29.1712935183722;
        Fri, 12 Apr 2024 08:19:43 -0700 (PDT)
Received: from localhost (fwdproxy-lla-006.fbsv.net. [2a03:2880:30ff:6::face:b00c])
        by smtp.gmail.com with ESMTPSA id og50-20020a1709071df200b00a51ba0be887sm1942278ejc.192.2024.04.12.08.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 08:19:43 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org
Subject: [PATCH net-next 2/2] net: ip6_gre: Remove generic .ndo_get_stats64
Date: Fri, 12 Apr 2024 08:19:26 -0700
Message-ID: <20240412151928.2895993-2-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240412151928.2895993-1-leitao@debian.org>
References: <20240412151928.2895993-1-leitao@debian.org>
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
 net/ipv6/ip6_gre.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index b5b417902c0a..3942bd2ade78 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -1434,7 +1434,6 @@ static const struct net_device_ops ip6gre_netdev_ops = {
 	.ndo_start_xmit		= ip6gre_tunnel_xmit,
 	.ndo_siocdevprivate	= ip6gre_tunnel_siocdevprivate,
 	.ndo_change_mtu		= ip6_tnl_change_mtu,
-	.ndo_get_stats64	= dev_get_tstats64,
 	.ndo_get_iflink		= ip6_tnl_get_iflink,
 };
 
@@ -1857,7 +1856,6 @@ static const struct net_device_ops ip6gre_tap_netdev_ops = {
 	.ndo_set_mac_address = eth_mac_addr,
 	.ndo_validate_addr = eth_validate_addr,
 	.ndo_change_mtu = ip6_tnl_change_mtu,
-	.ndo_get_stats64 = dev_get_tstats64,
 	.ndo_get_iflink = ip6_tnl_get_iflink,
 };
 
@@ -1920,7 +1918,6 @@ static const struct net_device_ops ip6erspan_netdev_ops = {
 	.ndo_set_mac_address =	eth_mac_addr,
 	.ndo_validate_addr =	eth_validate_addr,
 	.ndo_change_mtu =	ip6_tnl_change_mtu,
-	.ndo_get_stats64 =	dev_get_tstats64,
 	.ndo_get_iflink =	ip6_tnl_get_iflink,
 };
 
-- 
2.43.0


