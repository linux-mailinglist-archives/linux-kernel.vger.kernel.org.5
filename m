Return-Path: <linux-kernel+bounces-56298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CAE84C870
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20C081C21AC1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4414925579;
	Wed,  7 Feb 2024 10:19:42 +0000 (UTC)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23E0A21;
	Wed,  7 Feb 2024 10:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707301181; cv=none; b=GRH80LZiIC9dRXPGhpLzeTBO7wg4SblSTo9YWRtBE4Domd/vteecIKvWzvOEgR1qrG8Y8vbAUcd2r/x59oVKi9/S2pqQmHQWiKNZfapwC1sQHjRco0kr6pfkwcdKPTmeeUHvMEOIpDqiLrn+jy7zJZWYCLQxdz95gF0dDKxURHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707301181; c=relaxed/simple;
	bh=UJddGSh7ieqyuMNDXtFQKskOPYVKDAwZVD9O/la4KEQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kvmfNDNtZbhX3y74hL+uM+uKC13zW1rGZTjyTWxDlSTHa/40nlGLFNMjdwOPeEVtS2op6CSXr9+KgXuzCHl/mfPGjqfp8Vc9E7LWy2aeEnhIAGhf7fesweh5EBALhOsTxpGTmWyUDqfD+XiobMc9bAC7xTBy7N2ozUdsNAZrcXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a38271c0bd5so63426466b.0;
        Wed, 07 Feb 2024 02:19:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707301178; x=1707905978;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v/mDSaTwVDca440uano94ccpG3KV0z1ZaeCER3eTF2M=;
        b=Yf3WOK0T6hVo3aJ19jLEuFYz5yfb9rF4xyxITzGRP5ZHldATtnwQryod3Tfrla3TBW
         NVDnFHv9wl50eleNpPOFmO+g+x/jM7mqIXGsvT/aBPuSv5id7jXzFAFeIBunPcEszfpC
         nkmTu75cTC7cauXjANwsAkhZzk6ySGlflmlK7M0oV6lZa8wE6pqwDfvgWAK7RFJ6tH2y
         /OEbow4fwK7Bf7FdfuATgxCvY7oQ882Z6w3WUA+FP8fS1kR8u0zcVEO3sR6OW+ncciet
         LbbnnO6YxPbNdfhs985NjShzM+IY3qSx9Y+DUZERuO3Lz/wgiymlWmpBQ3VrwD3kwUcM
         IrQw==
X-Forwarded-Encrypted: i=1; AJvYcCX/++TVF/9DpUeLUySlQ6Favs7tJFfhQrxhrS5IIIkOa94VyiXU58f6aXhiSEcNP1whXuGzscqqnczJF+evtUfnusN8LyjqLctyONAr
X-Gm-Message-State: AOJu0YxgQqFPxgfOd36Xq5ZA2C6Hozoq/cey4a6bUNtJjpnCpwKGfDp9
	J4NrgDZZUYibLvPSw5xnFRPOOGBQ382+EhJqfNThVwCCw+IaXv8b
X-Google-Smtp-Source: AGHT+IEmQJ9h4uUXoIME2V0kheL9SvtImmgqO008Kw7Mg3Ui480zHM8A5NFQ+6wvX2NpRyrq9t4TcQ==
X-Received: by 2002:a17:906:3559:b0:a37:b8fb:50e0 with SMTP id s25-20020a170906355900b00a37b8fb50e0mr811463eja.52.1707301177895;
        Wed, 07 Feb 2024 02:19:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVmHb1aYXhImur8+C9WXLMMZaDDXYTUOYNRwbn5hXuvGjvpq8eeeSzpTl6iznnFqUGEAm2kUvi7DQrr3a5pPHaEIGMgBSktplmqoO8n1OHnE9pHS2Evi1znEBdCNjzrBGjtVrzRw0a5W9HFt2MuIq8sKzLyEeodkqibgcSxUMhtZGInzG4hvCM7OINE3vIEKCUdcgB0aJUbxtJYLnbIAVu4pFspZYgrhgjpwGg=
Received: from localhost (fwdproxy-lla-000.fbsv.net. [2a03:2880:30ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id un9-20020a170907cb8900b00a36ed37683fsm575923ejc.215.2024.02.07.02.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 02:19:37 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	andrew@lunn.ch
Subject: [PATCH net v2 0/9] net: Fix MODULE_DESCRIPTION() for net (p5)
Date: Wed,  7 Feb 2024 02:19:19 -0800
Message-Id: <20240207101929.484681-1-leitao@debian.org>
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

Changelog:

v1:
 * https://lore.kernel.org/all/20240205101400.1480521-1-leitao@debian.org/

v2:
 * Remove the patch for the ieee802154 , since the fix is already in
   net-next. See discussion at:
   https://lore.kernel.org/all/ZcDs%2FGFkZ881bJR7@gmail.com/#t

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


Breno Leitao (9):
  net: fill in MODULE_DESCRIPTION()s for xfrm
  net: fill in MODULE_DESCRIPTION()s for mpoa
  net: fill in MODULE_DESCRIPTION()s for af_key
  net: fill in MODULE_DESCRIPTION()s for 6LoWPAN
  net: fill in MODULE_DESCRIPTION()s for ipv6 modules
  net: fill in MODULE_DESCRIPTION()s for ipv4 modules
  net: fill in MODULE_DESCRIPTION()s for net/sched
  net: fill in MODULE_DESCRIPTION()s for ipvtap
  net: fill in MODULE_DESCRIPTION()s for dsa_loop_bdinfo

 drivers/net/dsa/dsa_loop_bdinfo.c | 1 +
 drivers/net/ipvlan/ipvtap.c       | 1 +
 net/6lowpan/core.c                | 1 +
 net/atm/mpc.c                     | 1 +
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
 29 files changed, 29 insertions(+)

-- 
2.39.3


