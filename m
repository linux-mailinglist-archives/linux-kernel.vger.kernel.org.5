Return-Path: <linux-kernel+bounces-96934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7876876357
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72FDF282AAC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3659D5647A;
	Fri,  8 Mar 2024 11:28:00 +0000 (UTC)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD9B55C3A;
	Fri,  8 Mar 2024 11:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709897279; cv=none; b=aCHbJKjCF3jyhu2pqqzFmfhckkn7FL98LZyILPk7PESYT8gXA3vx/XqFQKvr+Y2exMBAUBOGiLW3Upe385U0c775H3iir7UlfqMpH4BSwQ07pvZsPBakioc9q3n17JcF2umWE6PGddzzPkbTU9UXjn8VCpH8B/gSGDLOz93bF6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709897279; c=relaxed/simple;
	bh=/g/Mfdc4MOlaQh7mJ4NTTfyFqcqbzrjornoQPooxZu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D54RPeEn1sX6iD9+uG7uzlz51xFpqvy3OFD7NgdETjpSnsHW13e09fDkNXPbOP56klQ228K/bAOkw3hitRQqCpSXovwbT0XPGmRVrdBBk1Luet5idtfjxyQqiadn9rEL0gLGHvDHKkziX3STlrvtEwUbDTn9NRX5M1Ti1eg0Nyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a450bedffdfso266432266b.3;
        Fri, 08 Mar 2024 03:27:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709897276; x=1710502076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O2tYchlzzh0DWN5u11fzPiUQLbsNm+gor451RXEwI+Y=;
        b=PVPHjOT3MKt85aU2YWv0c+bPRzToW7/Qw+gC3pvqO3H4osC2vqj2E53YDr52LAqUUl
         jvlfFOdnn74ZarK3RGtoAZDzD/q8AK50oQOXrapccDXni/tJt3C0L+8fki10/Es32UoM
         DdONwlXi7ajjd7omvbEwqn87KY6lHq1neSSQRVuNY+dvaC6MtlbV1k3CTDh7l5ANgvRc
         lYDi1bTyDIOpc7u37PlAWOUA0zjZzelqHHce1S0hlBuProSFcanpr2SFrUqa+SSKJd3e
         hMK3TjqSKl7zrMLmGsiKGBHsvAQsbK43ncr2o3rh6fEqnt9dIhOtM5Y79VbM+bli6R+5
         IsMA==
X-Forwarded-Encrypted: i=1; AJvYcCVInzHgrEY0Md5n4sbeCr4o/3YPgRoAItvH9pCS2nh4cuvMRyCcfo5zenigbW2EDiX4Qg4/ECbWI52cyY92e6Fcmxwge25QnVnx0X10
X-Gm-Message-State: AOJu0YyyU68uX0RrLQMcqvzlF+VtXD+CxIsMgHgbsEcPzqdfGdfL7ZuI
	yO7W9ZWx/AovxG5mj2SKohFY7pYOH5UEYsUNuDDZsbATR2j0gRw1
X-Google-Smtp-Source: AGHT+IExIjq/3gTAAba1u39o8IWU9zZ2Oe9BqI1GRzXLIcpP/kx/b/AaCO9kcs8m3n31QLxpnNoezA==
X-Received: by 2002:a17:906:4888:b0:a45:b1cf:42f6 with SMTP id v8-20020a170906488800b00a45b1cf42f6mr6172173ejq.9.1709897276329;
        Fri, 08 Mar 2024 03:27:56 -0800 (PST)
Received: from localhost (fwdproxy-lla-118.fbsv.net. [2a03:2880:30ff:76::face:b00c])
        by smtp.gmail.com with ESMTPSA id p22-20020a17090635d600b00a45f2dc6795sm339290ejb.137.2024.03.08.03.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 03:27:56 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	dsahern@kernel.org,
	wireguard@lists.zx2c4.com (open list:WIREGUARD SECURE NETWORK TUNNEL)
Subject: [PATCH net-next v2 2/2] wireguard: Remove generic .ndo_get_stats64
Date: Fri,  8 Mar 2024 03:27:45 -0800
Message-ID: <20240308112746.2290505-2-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240308112746.2290505-1-leitao@debian.org>
References: <20240308112746.2290505-1-leitao@debian.org>
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
 drivers/net/wireguard/device.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireguard/device.c b/drivers/net/wireguard/device.c
index 6aa071469e1c..3feb36ee5bfb 100644
--- a/drivers/net/wireguard/device.c
+++ b/drivers/net/wireguard/device.c
@@ -237,7 +237,6 @@ static const struct net_device_ops netdev_ops = {
 	.ndo_open		= wg_open,
 	.ndo_stop		= wg_stop,
 	.ndo_start_xmit		= wg_xmit,
-	.ndo_get_stats64	= dev_get_tstats64
 };
 
 static void wg_destruct(struct net_device *dev)
-- 
2.43.0


