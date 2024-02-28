Return-Path: <linux-kernel+bounces-84924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8324D86ADC2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BB0DB23A51
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB12C155314;
	Wed, 28 Feb 2024 11:32:10 +0000 (UTC)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FBE14F998;
	Wed, 28 Feb 2024 11:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709119930; cv=none; b=L/bzBZM+CDZv12X1oAIigzWKNPDqV3HYEjlJxW/qAhthQD1haxLmq/9izVO6SXbtI7nEnyudbAirS17olu1D/1N5ejp1YM9DcfYCLTpdqF5/YGTrhK9afgg4j+noxtzG+f9jUNsqt8X98H6rbZCaCvM+0vir0gR/05RZjSPAyGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709119930; c=relaxed/simple;
	bh=osYfHf0zdit3Caig568VNoIMqJacx7kM2FhaGegFpUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L/gElqENF/qwcRCveQ4V6JvUhAqrmscgfauvKXlwD1rvvzNUtQ6i3x2ps4GgAJoOR4v72z9R94BnLOpWtUzXh4BkctFo1toatKrbki56qXhhjN4Ls1Ibysg8ysMW1+XgjEFIh9nq0jO3qnZhkVk8b/INc88oaWfpRtyWJeCIhs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a3ed9cae56fso139920866b.1;
        Wed, 28 Feb 2024 03:32:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709119927; x=1709724727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CZMdscvMnTBrNFqpRdeZHYyP0ag1D/LQclkgNCHYzYs=;
        b=awjvSt45rk0Lc+3xbUMR9awugwR4Ju0tMaUmTHfjcxmdiXlIVsr+SWdwJlI1RLJddd
         dGChTx9zHgl3gfQ8x0jBTj4Rr+C6L2v9hEZVg6HjnB9ARg17FYkzUsh1ipcUPNjeyX5U
         XKt3PpzAlB9Eu2v9NxkIH2x5ER3RaemYgu4o2t2OXEE5noMK1BcyZ4G9c0LAktQ+oh03
         zLBNamRblWfytigPsP4CuO1uvTcbkQUytI7xnpn5Hs9rKedw5xJmEjVGMJScTU8I1e8J
         ouTjWILWV88ixGZGep+KW96W09N6g3xUSr0PtkWHWwOxOHVe8aNfskCjZs3DM/6BcS/F
         l+6g==
X-Forwarded-Encrypted: i=1; AJvYcCW2HHlMYEAePQhUvvCqylTVR5elFJOqdyqWQCgbesJw51vuZYHFHwRPFzovqfuQV9fEB0zXLAn+5luf3+G7d43l0DjzVhywTRImvmmJ
X-Gm-Message-State: AOJu0YyW7KI8YuSU3SU6bAfdGREe2cFT8HF9JtXgTpt4V/VdD78QQiw1
	yTPmQFT7jaAiDdp5PvyFDIVv4vnplH1wlfFmAl1ClGVMEWraWSS0
X-Google-Smtp-Source: AGHT+IFLp9ie3+/1hqnj68QzfyOsdEqFZgLoyTa22wNJESInVZCR90DilUp+wSkt/U38LJ/Sp0aVsg==
X-Received: by 2002:a17:907:7651:b0:a3c:5e17:1635 with SMTP id kj17-20020a170907765100b00a3c5e171635mr1797915ejc.30.1709119927035;
        Wed, 28 Feb 2024 03:32:07 -0800 (PST)
Received: from localhost (fwdproxy-lla-001.fbsv.net. [2a03:2880:30ff:1::face:b00c])
        by smtp.gmail.com with ESMTPSA id hw18-20020a170907a0d200b00a3d5efc65e0sm1761437ejc.91.2024.02.28.03.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 03:32:06 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org
Subject: [PATCH net-next 2/2] net: sit: Do not set .ndo_get_stats64
Date: Wed, 28 Feb 2024 03:31:22 -0800
Message-ID: <20240228113125.3473685-3-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240228113125.3473685-1-leitao@debian.org>
References: <20240228113125.3473685-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the driver is using the network core allocation mechanism, by setting
NETDEV_PCPU_STAT_TSTATS, as this driver is, then, it doesn't need to set
the dev_get_tstats64() generic .ndo_get_stats64 function pointer. Since
the network core calls it automatically, and .ndo_get_stats64 should
only be set if the driver needs special treatment.

This simplifies the driver, since all the generic statistics is now
handled by core.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/ipv6/sit.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
index 5ad01480854d..655c9b1a19b8 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -1398,7 +1398,6 @@ static const struct net_device_ops ipip6_netdev_ops = {
 	.ndo_uninit	= ipip6_tunnel_uninit,
 	.ndo_start_xmit	= sit_tunnel_xmit,
 	.ndo_siocdevprivate = ipip6_tunnel_siocdevprivate,
-	.ndo_get_stats64 = dev_get_tstats64,
 	.ndo_get_iflink = ip_tunnel_get_iflink,
 	.ndo_tunnel_ctl = ipip6_tunnel_ctl,
 };
-- 
2.43.0


