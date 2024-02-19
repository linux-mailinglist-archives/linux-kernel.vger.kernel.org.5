Return-Path: <linux-kernel+bounces-71425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D2685A50B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41637287E4D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454B9364C0;
	Mon, 19 Feb 2024 13:43:40 +0000 (UTC)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286803612C;
	Mon, 19 Feb 2024 13:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708350219; cv=none; b=Ji72jy0QxPKmVSK86SYjZfMLZkw0r+KTKfzU4P5IWIUAwi2zbAzXY8I+/Pw0pjZcBB2mJcXh9XXaSX9HYuYTVH+8i1cKlR8+AGDSiA1GuFD2ZYT7IvHl1RmLIc7m2K73HWXQpr9ORNpMYRvxqP9/RUcqiivDEnr96qVT/ITNwSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708350219; c=relaxed/simple;
	bh=Gt5OwY2whQVuVaWFJk6JeoMSVY3zk5FlZi+HF/R3eks=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OGFrYFFB/83kxVcATA0Ll7dvf5c5YLdvgNktVH+C5Tos9KnoPUCXy92Wj1iXG4u9xo0i1AaEp2Bpg1taOd6C8onkAg0RhCqJP3NVKeXRX8bR686FR4RzgnKl46Csn6t2IPy+Ti9Y7Ogp5HtBX7idvQIKF2QQjqoCcKfV+oisaWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-512bc0e8ce1so687217e87.0;
        Mon, 19 Feb 2024 05:43:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708350216; x=1708955016;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oOR3y9Zmm8Tuo993+z9hIy+5r2d0Ko/vjpAMAXO6LDc=;
        b=LRskpWjfriq+CsbFhTZ0HnZqbNN+0YI7GbpqJxBVHuGhhxSOLD8YRpyKXtrJnWNn0k
         hJ6Ad1y+MnsoGuPyIK3Z5Xe1y9esono2r+j6OawudMYD/AdUX/SpAY51Zyc1ffB54NWo
         rsIb66IG8BzZNemONVRAV+ES31wmgu0WZOve8sXEDCukkQFtnG4QmSCHp77iChU5i4Of
         T6FRrUGzZ1fdaF0bLM2QtfUoJuOz8ILaAGlht7+iCEpsyD1tYqvnkuyOcP4PYgbbxguM
         nrxuTJQDkt3BiMxryWFoKj79Sm1MsOSTBuv27ilYgaq0rqeFD0h06/+ohzfKJxUPeAPu
         lZdA==
X-Forwarded-Encrypted: i=1; AJvYcCXO0u5MR6RXR4Jtqh7NmoL/I22rlWRSM7MrLgzEVh6jjGl+6mH9d9gTbxH+9kLKm8gafqa15OLeuH9p8eejplnU+rOdYj34OPWzC0XT
X-Gm-Message-State: AOJu0Ywfdln/m0XDhx+bopYwkF7pC6Q4l9HO40+2rNiR3d+R6Z4JoWnx
	hL0ljpee0wTIMEhAV9L3ST0C3ft4YEY8NAe94ci1M+qS4uQRvPhi
X-Google-Smtp-Source: AGHT+IG4Qg+NiQ+VzOOvLUyWATKeMMc95bMZxRhsjHKR5ytsTIZRLJlfsTHQp3wZyOE+qYddMrUlvA==
X-Received: by 2002:ac2:58ea:0:b0:512:b965:f61b with SMTP id v10-20020ac258ea000000b00512b965f61bmr1116788lfo.33.1708350216021;
        Mon, 19 Feb 2024 05:43:36 -0800 (PST)
Received: from localhost (fwdproxy-lla-003.fbsv.net. [2a03:2880:30ff:3::face:b00c])
        by smtp.gmail.com with ESMTPSA id u14-20020a17090626ce00b00a3d1580d702sm2973215ejc.185.2024.02.19.05.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 05:43:35 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org
Subject: [PATCH net-next] net/dummy: Move stats allocation to core
Date: Mon, 19 Feb 2024 05:43:28 -0800
Message-Id: <20240219134328.1066787-1-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
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

Move dummy driver to leverage the core allocation.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/dummy.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/net/dummy.c b/drivers/net/dummy.c
index 946bba0701a4..d29b5d7af0d7 100644
--- a/drivers/net/dummy.c
+++ b/drivers/net/dummy.c
@@ -67,19 +67,12 @@ static netdev_tx_t dummy_xmit(struct sk_buff *skb, struct net_device *dev)
 
 static int dummy_dev_init(struct net_device *dev)
 {
-	dev->lstats = netdev_alloc_pcpu_stats(struct pcpu_lstats);
-	if (!dev->lstats)
-		return -ENOMEM;
+	dev->pcpu_stat_type = NETDEV_PCPU_STAT_LSTATS;
 
 	netdev_lockdep_set_classes(dev);
 	return 0;
 }
 
-static void dummy_dev_uninit(struct net_device *dev)
-{
-	free_percpu(dev->lstats);
-}
-
 static int dummy_change_carrier(struct net_device *dev, bool new_carrier)
 {
 	if (new_carrier)
@@ -91,7 +84,6 @@ static int dummy_change_carrier(struct net_device *dev, bool new_carrier)
 
 static const struct net_device_ops dummy_netdev_ops = {
 	.ndo_init		= dummy_dev_init,
-	.ndo_uninit		= dummy_dev_uninit,
 	.ndo_start_xmit		= dummy_xmit,
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_set_rx_mode	= set_multicast_list,
-- 
2.39.3


