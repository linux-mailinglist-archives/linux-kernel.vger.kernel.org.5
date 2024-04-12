Return-Path: <linux-kernel+bounces-142937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 531F88A3246
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D344BB269EE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43511148310;
	Fri, 12 Apr 2024 15:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fo3/czKE"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0928484A37;
	Fri, 12 Apr 2024 15:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712935327; cv=none; b=YFJQUbu9cwu8Xef2MXa7MW9WePmWz+VSArhzTRIn9LWT/zX2w9b19h1prb7MJoDs1LWBxu6tEwWyC0Js8NBctIPer1sBeAN4gbR4Veyil+pZphc9RWYTkXU4BNkmVApbemsr5ytOIvnqdGFLorl70/l6vyvMAAO8Cjwp+N0Bri0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712935327; c=relaxed/simple;
	bh=mLJgP3qYygteSDbYdScbwbMfDV+pZa7zvSt+jGFVBxs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RpdYsE+9sTKjvzsDf80J75w375fzNwQim+CcdOliPXpUFzqF1CjkWe72GnvBurymd/o7D+SdDDuhenMVuiPHCYHo0XxU601TfBiOM/w3rvA4hQs1+H531sN8G8tic3nvk1tcK6HKl7c1m/eqPWzRSMWzTKcJzFD2u+DiYEx3IvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fo3/czKE; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-34665dd7610so432420f8f.3;
        Fri, 12 Apr 2024 08:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712935324; x=1713540124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BKUpk57F2e+NylpttQMpo0uer78NWTYRijCbu0kAq8A=;
        b=Fo3/czKE1i6bpEwszhMDZwNOLWAENGQ3PEzpxT7A6CYK04FElDpqgFRlq3Axy1B2wy
         DQP+Rik3Shu5wvRXsx2nxwl20rn7IEZ1nyvUlTMW9tRLSAq8jVhXzp0rnLOEqCibj+A1
         1L5mN3dVN2ziw40qx9uVICY0PYJrf+VROJgfcAjbzP0e2A2k18S2wIVLDqmt0ScSYkP0
         ywghq1UoigGMo39xorOs/X+YtZlzVI5a9ZdsH38T/Ap/gW1s3tlii+bkaTdoir1ZGe1H
         TglTR0ZLzSQ/GY4E14eRNSrZHXRvbEZ05YVz1snrstdAu8x0wrd9yd1HMjtof1r2spaE
         nM1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712935324; x=1713540124;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BKUpk57F2e+NylpttQMpo0uer78NWTYRijCbu0kAq8A=;
        b=kjji3JScNMtm9MUJh7D1qHluHSP17UKjuTJ6dBudGPz3Xi2Bqz3a6qF9WEkA8+aAx3
         NryFtkNP1VnoWoEGDBF2o7jL2k5U7WB6nr1W3sDNdOnYAgTLAJQsRxWQzQtNmTlpGfhz
         WM862QNulBNWSZtOUPMFaKRyKz3NyeKWwhbdfE3DJI4zIpfosnl7WcYPVcdES90bYucH
         biWEPoRntPcEjYwHc0R0yRfN3dsYapdGev2qYVdDzsoLf37busPVyh7hjnOgRpA+MGj+
         CXO1M96Q3lRvUDnVLkc0/BniT+DfgDPt7uEXfn4bItXumQN6aFGiwScjXd+3CqidIbZz
         UWVw==
X-Forwarded-Encrypted: i=1; AJvYcCWRlkzSw8hjLvyzsofwZqZG0tL3pxTwBaVM/gj3C1BDQQdk7B9EtQINk48V1OJiGpAfEl1nDQ0QexzMKwfrmRMTbgKC+z2asiQq0+U7gqSBYRa4GcQF65zDKefmHrpLWN9BEldR
X-Gm-Message-State: AOJu0YwcIlpPxTl4OCwoaRXhuTWPVALd4uyfzhKLJEpCqhd8M0visWl2
	0XMlOpNLlfL5NYZsVFDWyf5algckkbBrNddLUNbaNUEzN5NYWuTV
X-Google-Smtp-Source: AGHT+IGQImkLmCY7VdyKoOUu0Hnb7lsqT99IXd21vmwG4wcHO9BKu5oHk5B4dbcecaH8k8TajcpQxA==
X-Received: by 2002:adf:fa8b:0:b0:343:b686:89a0 with SMTP id h11-20020adffa8b000000b00343b68689a0mr1939576wrr.13.1712935324028;
        Fri, 12 Apr 2024 08:22:04 -0700 (PDT)
Received: from localhost ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id h5-20020adff4c5000000b003437a76565asm4486798wrp.25.2024.04.12.08.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 08:22:03 -0700 (PDT)
From: Richard Gobert <richardbgobert@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	willemdebruijn.kernel@gmail.com,
	dsahern@kernel.org,
	aleksander.lobakin@intel.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Richard Gobert <richardbgobert@gmail.com>
Subject: [PATCH net v1 0/2] net: gro: add flush/flush_id checks and fix wrong offset in udp
Date: Fri, 12 Apr 2024 17:21:18 +0200
Message-Id: <20240412152120.115067-1-richardbgobert@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes a bug in the complete phase of UDP in GRO, in which
socket lookup fails due to using network_header when parsing encapsulated
packets. The fix is to pass p_off (previous offset, offset to the start of
the previous layer) parameter in *_gro_complete.

The original series includes a change to a vxlan test which adds the local
parameter to prevent similar future bugs. I plan to submit it separately
to net-next.

In addition p->flush/flush_id should be checked in relevant UDP flows. Same
logic from tcp_gro_receive is applied for the relevant flows in
udp_gro_receive_segment.

This series is part of a previously submitted series to net-next:
https://lore.kernel.org/all/20240410153423.107381-1-richardbgobert@gmail.com/

Richard Gobert (2):
  net: gro: add flush check in udp_gro_receive_segment
  net: gro: add p_off param in *_gro_complete

 drivers/net/geneve.c           |  7 +++---
 drivers/net/vxlan/vxlan_core.c | 11 ++++++----
 include/linux/etherdevice.h    |  2 +-
 include/linux/netdevice.h      |  3 ++-
 include/linux/udp.h            |  2 +-
 include/net/gro.h              | 11 +++++-----
 include/net/inet_common.h      |  2 +-
 include/net/tcp.h              |  6 ++++--
 include/net/udp.h              |  8 +++----
 include/net/udp_tunnel.h       |  2 +-
 net/8021q/vlan_core.c          |  4 ++--
 net/core/gro.c                 |  2 +-
 net/ethernet/eth.c             |  4 ++--
 net/ipv4/af_inet.c             |  8 +++----
 net/ipv4/fou_core.c            |  9 ++++----
 net/ipv4/gre_offload.c         |  5 +++--
 net/ipv4/tcp_offload.c         |  7 +++---
 net/ipv4/udp.c                 |  3 ++-
 net/ipv4/udp_offload.c         | 39 ++++++++++++++++++++++------------
 net/ipv6/ip6_offload.c         | 22 ++++++++++---------
 net/ipv6/tcpv6_offload.c       |  7 +++---
 net/ipv6/udp.c                 |  3 ++-
 net/ipv6/udp_offload.c         | 13 ++++++------
 23 files changed, 105 insertions(+), 75 deletions(-)

-- 
2.36.1


