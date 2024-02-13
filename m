Return-Path: <linux-kernel+bounces-64213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CAC853C06
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24E861C26C04
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 20:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADD860BAA;
	Tue, 13 Feb 2024 20:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XDKii9tN"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40000F9CE;
	Tue, 13 Feb 2024 20:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707854989; cv=none; b=WIw9yrB4rPOM7WnO3dFmiTNgOaUKgdiUuQCKvoKzdKaluxOJDSE/qpiDDUO0V5WuLRyfetlJWL9E7CFcsJqgjR/mgNqkfSKVssW3ZcaRr4n14j55ZbylCsVQYNZyaRj1E/P8cUMwf0ti4bw4kAen4lgxnsUyR1N0hUiGWJQkqV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707854989; c=relaxed/simple;
	bh=1vDtFki52qEen6PK4vYWTfsQMcN7WeuDJO4xHWYq9W0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RM3TPXzW3FJ4YfFfWaki/hZpCPU1A/J1k+furU1+OAW64Lk456JvOKqBuxjX/hcDhI3KlxUeO1bLzqOzO+V0RurB0q2wUeBr/YkoJdZ4m7uVo48IylVuiZFxcTsEFBHsEXPINpjJXkq8xMFX4qL7BUaiDzQUjtetQl1J2J1irMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XDKii9tN; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-51183b02564so1713902e87.0;
        Tue, 13 Feb 2024 12:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707854985; x=1708459785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0hzGyP5BmfLNynoufuCIYu0jlOUetivxBifIAcLDK5I=;
        b=XDKii9tN+psP5igh43Ud+aNkOR4mxnvSetnp6G71hNHf3zMgiUeaKmRbhZXUUkfp1y
         3oJdz4eDpmpSwVhYHbeVhH4LBJjtoVDQbQY8DqVnol6Lfx6eoZKBKUKu/GhywrO+1Oyg
         GLYJva9N3lt7Y5BUrZK9uRlCpdQLM4qoQBgqck5n1VIG8iRkK0q6WqBXqpPvyTR5ia15
         5Dbv/gkb234HjptvVvVKJN+UInr49lJIfkYBfiCY0W6hZELxThxG1z0iX+NWLMEQb15S
         pvaHcf0Jpnsfo/7ar9BMT628xDC4KQ5q/Qx9dZd4TdgbkSMg9qwkpsJNo7QbffYShiAS
         AO9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707854985; x=1708459785;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0hzGyP5BmfLNynoufuCIYu0jlOUetivxBifIAcLDK5I=;
        b=wC9urH05/rlthl63lviRccqGiBiM+jvit44gf1vPANisS1Vr0JDIYCKz9kkbnOiKQc
         NNElWPhen5R3bRlNqf4duwhm4u1DkcK6oEPxhiRtle/2O+14GaSpFF7A8tmZgPy94Z2C
         OlyHc6bkEwfCSqp90YmwYKPCR5teuUstEvtwWSey8gggdjAeYR5kdb0VBWOXIl/oq3Mt
         yrBgZfYBQB7li4VE8U19eMzkbUZ48Q9HTicfeksddouqRSeSFlESnySqXsgL9aPgChir
         0m+haSWYNUDuEhbTU4SqDiFQdvIzJYQqy8swiDfBWV2FCEmjwKbXj3xKG3itNYjrMP9J
         /bag==
X-Forwarded-Encrypted: i=1; AJvYcCU1GqpuCGFwf9JwYDwQYkjruIzixGqVDjh57HfppUWvcxpLWloPXs3krT0N6r7rZ3PuESbMUFU7DxZ9Q4yA7R1cTnTbQ8d135tAX8SQ3KQnoVwG+QVske9HxjdigGdthpPB0iWA
X-Gm-Message-State: AOJu0Yz8kmbgrCYVeG8A8SFFrkYqSL6EF3IftGLrSbFB2FWUMXtuw286
	VBZ/azJhjzQc5kZ5n1IgpZyvRJtAfYwdich2ewao73F/ZCiGdv59uIxNTuJmvTxVkA==
X-Google-Smtp-Source: AGHT+IGYJ6GKh7lyRWxs6rBJ04NbHLdGNlmeoEJZb0Cc3iso88olm2DBLoE9zEhUoOn3i08yKuqraA==
X-Received: by 2002:a05:6512:3144:b0:511:7612:55b with SMTP id s4-20020a056512314400b005117612055bmr338390lfi.64.1707854984959;
        Tue, 13 Feb 2024 12:09:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU55p4RqCy8H9tvg7jRxRLXypdtUiZhxXcNtt2f0NuA5s2M2WbY/Mrl7e4nxJoCvJk17OfBHjxos1q83A6/4XKSla0DICJBFcf8MemG8hpuBaKILHjVGJoXly/HD+ppxyzTLud1zqkZNnX/VkP0mcKwI9th+YiSHhCCiUOfdgQjVBrzsW38YMFzT2oxErAi8Oj6w4SlG7ddLf69A9WuHxGmYE5BZ/M43YOTsHTWqHEoLgLEA09If3eYb+jLHl0rKCrWjtWzxv18a5LeI46iKQ==
Received: from rand-ubuntu-development.dl.local (mail.confident.ru. [85.114.29.218])
        by smtp.gmail.com with ESMTPSA id l4-20020ac25544000000b00511936e2d61sm664485lfk.56.2024.02.13.12.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 12:09:44 -0800 (PST)
From: Rand Deeb <rand.sec96@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: deeb.rand@confident.ru,
	lvc-project@linuxtesting.org,
	voskresenski.stanislav@confident.ru,
	Rand Deeb <rand.sec96@gmail.com>
Subject: [PATCH] dl2k: Fix potential NULL pointer dereference in receive_packet()
Date: Tue, 13 Feb 2024 23:09:00 +0300
Message-Id: <20240213200900.41722-1-rand.sec96@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch addresses a potential NULL pointer dereference issue in the
receive_packet() function of the dl2k network driver. Previously, there was
a possibility of dereferencing a NULL pointer when the pointer 'skb'
returned from the function 'netdev_alloc_skb_ip_align()' was not checked
before being used. To resolve this issue, the patch introduces a check to
ensure that 'skb' is not NULL before dereferencing it.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Rand Deeb <rand.sec96@gmail.com>
---
 drivers/net/ethernet/dlink/dl2k.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/dlink/dl2k.c b/drivers/net/ethernet/dlink/dl2k.c
index 734acb834c98..9cee510247e1 100644
--- a/drivers/net/ethernet/dlink/dl2k.c
+++ b/drivers/net/ethernet/dlink/dl2k.c
@@ -972,6 +972,14 @@ receive_packet (struct net_device *dev)
 							   np->rx_buf_sz,
 							   DMA_FROM_DEVICE);
 			}
+			if (skb == NULL) {
+				np->rx_ring[entry].fraginfo = 0;
+				printk (KERN_INFO
+				       "%s: receive_packet: "
+				       "Unable to re-allocate Rx skbuff.#%d\n",
+				       dev->name, entry);
+				break;
+			}
 			skb->protocol = eth_type_trans (skb, dev);
 #if 0
 			/* Checksum done by hw, but csum value unavailable. */
-- 
2.34.1


