Return-Path: <linux-kernel+bounces-52391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80388849778
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:14:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A47A71C220B7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB9B168C4;
	Mon,  5 Feb 2024 10:14:13 +0000 (UTC)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335B514AA7;
	Mon,  5 Feb 2024 10:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707128053; cv=none; b=cHgm7BYeGEEEoU8tjVDx78vnDHJdSZy1226q4a2UMagRFo+UsFxYvP/owrYgUkB4/5acXU0RPkyoTARFM50JmT04pwv2lZ42Re+JWC0ecSdZlQCaY8fWsHJnb9Q+3k7hz/dWIpbRyuIGM/gxKlfEbj54CjBeHsAwFq4RfV9HTHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707128053; c=relaxed/simple;
	bh=1l3siLpuXMK44oa6b0El8BgF81vRCEyF7f8WDN3RqJw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FiVuAqZU2C0yFPcYu85/9qoR8AKL7cQznMvIYtqw2cL9G1Tc7+QgLWPVpopOwPbkfSmqJpSkWvgBu4QltomlDeww05fMC6rfVViGCmNGalfSeaebr63/EYEVC27d+2OQRCZT6UI1DelL6A9lt9C4B/ItSCu6SwxKZJ9LLvBoHPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-557dcb0f870so5472941a12.2;
        Mon, 05 Feb 2024 02:14:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707128049; x=1707732849;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ddHst/s1WypGQf10KbRP7GLFjlfX7i+laa1nshvJf0I=;
        b=aTE5ArSw/8ksMVp+gbSAIVV2JpFIa1wgeQIPDto+uyIft0UaL0FH9oyG3G3NM6IenM
         xlJ8Pi2iqD7MigfS6iALRpsuiv4aN2BEblRAXJmnuEm/EA9ePM0doYj1dcxAOEEUhpWY
         BJK3vcE0B8UcAC0Gcjvo1FqLmfVyWM6E90znoJ4CPiQFh0G5VzLlofIyBCjRu7McZUHe
         HlJg3FGvGoFZozuZgR9Jomihw/HPv8rNVeiFv2F0M/wmCQMtR885bCNaIjt0Ftvr1nPn
         +BH+BjCC/aeq1TRnBk76QBIgHl+eUUSObE2oMMupbzKTYRbjdi2/9h4poRG0D1Q7WGo4
         vFaA==
X-Gm-Message-State: AOJu0YxjTd86WYY5fM9B0tDBI0DbF2e6P1nP2JKd4GPialyPgit27fMc
	2yR2mcc14xYW2M2/xbiqoBb2YIR0FY8qpKbKeMbLJOkzyxn8bq93
X-Google-Smtp-Source: AGHT+IEu/jxcISKhppzrFILb6XHoChlGGlwzeVhILTawdEO0iXqNIRKHdUNGGuClDMggNs1oubMdJw==
X-Received: by 2002:a17:906:19b:b0:a36:fd11:8ded with SMTP id 27-20020a170906019b00b00a36fd118dedmr7049567ejb.56.1707128048983;
        Mon, 05 Feb 2024 02:14:08 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU80mMmeas1Ial7BRLgeBTcA2jAjlsX5HtVnWQ/atx2w0UNwP2bc2o19C1fj5HAXAUVpXKWtirFP58FDBGsLLjUYSb1/kk6Zc/EVMcDyhOuVGn0KT4QZulr3xqBfyOlkI7TfHbxRiz+4lxBAbogoKch7+Q8F7xwIl5wdDCnNvr3HNJMlzO8V8JcLPL1qGvyjvJnA7EsWUN9mKqYEk2LHrNyAHRJZRXFjwWSDnU=
Received: from localhost (fwdproxy-lla-116.fbsv.net. [2a03:2880:30ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id tb16-20020a1709078b9000b00a37579fa8f1sm2633440ejc.71.2024.02.05.02.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 02:14:08 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	andrew@lunn.ch
Subject: [PATCH net 00/10] net: Fix MODULE_DESCRIPTION() for net (p5)
Date: Mon,  5 Feb 2024 02:13:49 -0800
Message-Id: <20240205101400.1480521-1-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are hundreds of network modules that misses MODULE_DESCRIPTION(),
causing a warning when compiling with W=1. Example:

	WARNING: modpost: missing MODULE_DESCRIPTION() in net/sched/em_cmp.o
	WARNING: modpost: missing MODULE_DESCRIPTION() in net/sched/em_nbyte.o
	WARNING: modpost: missing MODULE_DESCRIPTION() in net/sched/em_u32.o
	WARNING: modpost: missing MODULE_DESCRIPTION() in net/sched/em_meta.o
	WARNING: modpost: missing MODULE_DESCRIPTION() in net/sched/em_text.o
	WARNING: modpost: missing MODULE_DESCRIPTION() in net/sched/em_canid.o
	WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv4/ip_tunnel.o
	WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv4/ipip.o
	WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv4/ip_gre.o
	WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv4/udp_tunnel.o
	WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv4/ip_vti.o
	WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv4/ah4.o
	WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv4/esp4.o
	WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv4/xfrm4_tunnel.o
	WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv4/tunnel4.o
	WARNING: modpost: missing MODULE_DESCRIPTION() in net/xfrm/xfrm_algo.o
	WARNING: modpost: missing MODULE_DESCRIPTION() in net/xfrm/xfrm_user.o
	WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv6/ah6.o
	WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv6/esp6.o
	WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv6/xfrm6_tunnel.o
	WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv6/tunnel6.o

This part5 of the patchset focus on the missing net/ module, which
are now warning free.

Here are all the MODULE_DESCRIPTION added:

 MODULE_DESCRIPTION("CAN Identifier comparison network helpers");
 MODULE_DESCRIPTION("DSA loopback fixed PHY library");
 MODULE_DESCRIPTION("IEEE 802.15.4 IPv6 over Low-Power Wireless Personal Area Network module");
 MODULE_DESCRIPTION("IEEE 802.15.4 socket interface");
 MODULE_DESCRIPTION("IP-in-IPv6 tunnel driver");
 MODULE_DESCRIPTION("IP/IP protocol decoder library");
 MODULE_DESCRIPTION("IPv4 AH transformation library");
 MODULE_DESCRIPTION("IPv4 ESP transformation library");
 MODULE_DESCRIPTION("IPv4 GRE tunnels over IP library");
 MODULE_DESCRIPTION("IPv4 tunnel implementation library");
 MODULE_DESCRIPTION("IPv4 UDP tunnel driver");
 MODULE_DESCRIPTION("IPv4 XFRM tunnel driver");
 MODULE_DESCRIPTION("IPv4 XFRM tunnel library");
 MODULE_DESCRIPTION("IPv6 AH transformation helpers");
 MODULE_DESCRIPTION("IPv6 ESP transformation helpers");
 MODULE_DESCRIPTION("IPv6-in-IPv4 tunnel SIT driver");
 MODULE_DESCRIPTION("IPv6 Mobility driver");
 MODULE_DESCRIPTION("IPv6 over Low-Power Wireless Personal Area Network core module");
 MODULE_DESCRIPTION("IPv6 UDP tunnel driver");
 MODULE_DESCRIPTION("IPv6 XFRM tunnel driver");
 MODULE_DESCRIPTION("IP-VLAN based tap driver");
 MODULE_DESCRIPTION("Metadata comparison network helpers");
 MODULE_DESCRIPTION("Multi byte comparison network helpers");
 MODULE_DESCRIPTION("Multi-Protocol Over ATM (MPOA) driver");
 MODULE_DESCRIPTION("PF_KEY socket helpers");
 MODULE_DESCRIPTION("Simple packet data comparison network helpers");
 MODULE_DESCRIPTION("Textsearch comparison network helpers");
 MODULE_DESCRIPTION("U32 Key comparison network helpers");
 MODULE_DESCRIPTION("Virtual (secure) IP tunneling library");
 MODULE_DESCRIPTION("XFRM Algorithm interface");
 MODULE_DESCRIPTION("XFRM User interface");

Breno Leitao (10):
  net: fill in MODULE_DESCRIPTION()s for xfrm
  net: fill in MODULE_DESCRIPTION()s for mpoa
  net: fill in MODULE_DESCRIPTION()s for af_key
  net: fill in MODULE_DESCRIPTION()s for 6LoWPAN
  net: fill in MODULE_DESCRIPTION()s for ipv6 modules
  net: fill in MODULE_DESCRIPTION()s for ipv4 modules
  net: fill in MODULE_DESCRIPTION()s for net/sched
  net: fill in MODULE_DESCRIPTION()s for ieee802154
  net: fill in MODULE_DESCRIPTION()s for ipvtap
  net: fill in MODULE_DESCRIPTION()s for dsa_loop_bdinfo

 drivers/net/dsa/dsa_loop_bdinfo.c | 1 +
 drivers/net/ipvlan/ipvtap.c       | 1 +
 net/6lowpan/core.c                | 1 +
 net/atm/mpc.c                     | 1 +
 net/ieee802154/6lowpan/core.c     | 1 +
 net/ieee802154/socket.c           | 1 +
 net/ipv4/ah4.c                    | 1 +
 net/ipv4/esp4.c                   | 1 +
 net/ipv4/ip_gre.c                 | 1 +
 net/ipv4/ip_tunnel.c              | 1 +
 net/ipv4/ip_vti.c                 | 1 +
 net/ipv4/ipip.c                   | 1 +
 net/ipv4/tunnel4.c                | 1 +
 net/ipv4/udp_tunnel_core.c        | 1 +
 net/ipv4/xfrm4_tunnel.c           | 1 +
 net/ipv6/ah6.c                    | 1 +
 net/ipv6/esp6.c                   | 1 +
 net/ipv6/ip6_udp_tunnel.c         | 1 +
 net/ipv6/mip6.c                   | 1 +
 net/ipv6/sit.c                    | 1 +
 net/ipv6/tunnel6.c                | 1 +
 net/ipv6/xfrm6_tunnel.c           | 1 +
 net/key/af_key.c                  | 1 +
 net/sched/em_canid.c              | 1 +
 net/sched/em_cmp.c                | 1 +
 net/sched/em_meta.c               | 1 +
 net/sched/em_nbyte.c              | 1 +
 net/sched/em_text.c               | 1 +
 net/sched/em_u32.c                | 1 +
 net/xfrm/xfrm_algo.c              | 1 +
 net/xfrm/xfrm_user.c              | 1 +
 31 files changed, 31 insertions(+)

-- 
2.39.3


