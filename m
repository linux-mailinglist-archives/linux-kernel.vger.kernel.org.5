Return-Path: <linux-kernel+bounces-151684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8BB8AB204
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 17:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1BF0284058
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09231304B5;
	Fri, 19 Apr 2024 15:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bDUTCdso"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987A312FF6A;
	Fri, 19 Apr 2024 15:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713540977; cv=none; b=SN2DRmYR5KQxgvkna+/rbEY8diJ6DTLr/PPtIx6f3M0CAmQDkB3B2QdGwmfv8e7HbLGgR2pzWd8OgJ/pHzYxDUTC4ub/9h6qTRAaQmmJ47pgoKzZl4YntbHpTvkMrLUa6h0Fgo0hv43eNhv63i7pOzDZ8z+lCGi7McnUtwwptKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713540977; c=relaxed/simple;
	bh=AnVpRpILY5Vd9N8iFqR8H3efTBFYjgWKXJUjsusHOgY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XjNohiU+95YJMSvaa1yaYlCnATB/vlbELpdgiJkaJHQz7U5mHxxWsSbSlLvn+rcLr3fj6Zlkx49Y+ysOa538bcGvV9HxUprqZw3hLx+x3i+2bnQnTXjHkpi/aEVWUpNbE0m7RmnmyBve6FwTicf44bQchiyAdxJoORtQELvPlao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bDUTCdso; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-419c82338abso2909465e9.0;
        Fri, 19 Apr 2024 08:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713540974; x=1714145774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ogeEX//bHF2HsqLQah7I8pSI5VIDZwGvgsrUulvUgJ8=;
        b=bDUTCdso4Ndo2faWzi8qemJ6aNywKGeAwtOqh+HfMXmNS0Sl3ShflCgoVFPhE4Eam7
         +WSHt2ExadNpaVfczOa+iPseg69aeE9ak6KenlO3oMzwd/BqmuWKRlH33hpHHoxEtcIb
         8RAMNElyWwT3udm17xbfw/PEsMQLxUF3Pyzs0RqbB5rqJhaN4d7JXqnDB5jcVRe2Wklv
         LuwiAoyzV0gM4adgmIjtJT1N0MidYdgkAc5OX2IBWVLP7II3eU6/slkigm6J8HnTockY
         VK71UZhUHxqYtRcU+S1GAdLhacCb3Esv4zQ8//PYwiN+hewS9YO3TfMms0rbhSh36s4t
         0lYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713540974; x=1714145774;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ogeEX//bHF2HsqLQah7I8pSI5VIDZwGvgsrUulvUgJ8=;
        b=kMvoKk9Cm4Uydn8mZr2jSpB8TQYa5SFCYg6skOzqnCYsxsJ6ZlCnu/W1ExLdK1aKJj
         wbWDcGJTOcoW5u/TppJ+t0+JqGF0+fhCzT+I6CFFxtzhI1z+UxdfymcOec1gDqpVu/zI
         pXnjoDMl/9wJ6xksU9RyfaUAi1hNc6ammQkoTTJSgQgNg8vWhmjrxgpBUEt3Ke2v7SAD
         yqffjbHcFjZ5k2GvIMIEb8Ugc8S13YA0oplvlfR1COxH7h97cDhliUTq0lRsk421yzf2
         WB6XzypwDRVfgpoVWYS93DnHSMVLUBJB/zTE7o1hH1bmUF/82yVryATGUG4EMOdiF9ee
         M9dg==
X-Forwarded-Encrypted: i=1; AJvYcCXLW7CFlkSDbKq8Idl8XHrDXgHgXcpoY9irAdwLyX2k4GCQq1hJej6by/s/aW+N5ANtHh03XQPst8NoMk71wr8CYnCLxPJdjl7stz3YWnM0yLNTWUqMGB48GiPaydjWJMHTbkQ4
X-Gm-Message-State: AOJu0YyvUF6mmoqGpAzZTbplg823CSPnUfTkbXb8ug5rrR6IMzD+YiOA
	Bs/UQ5NAxnjECj0CfCE05RjMyjkfdNtx7DDDtwnLdosQ2gu3Z5WM
X-Google-Smtp-Source: AGHT+IE3HKHiW9UOjFRTmHykV1efO9/FK/dMkjclqhsPuh4hbDq7CJiPMrZLolaE2xHlwmDk3PYWWQ==
X-Received: by 2002:a05:600c:138c:b0:418:829e:efa5 with SMTP id u12-20020a05600c138c00b00418829eefa5mr2232752wmf.20.1713540973786;
        Fri, 19 Apr 2024 08:36:13 -0700 (PDT)
Received: from localhost ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id v15-20020adfa1cf000000b0034a81bc5675sm451033wrv.96.2024.04.19.08.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 08:36:13 -0700 (PDT)
From: Richard Gobert <richardbgobert@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	willemdebruijn.kernel@gmail.com,
	alexander.duyck@gmail.com,
	aleksander.lobakin@intel.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Richard Gobert <richardbgobert@gmail.com>
Subject: [PATCH net v2 0/3] net: gro: add flush/flush_id checks and fix wrong offset in udp
Date: Fri, 19 Apr 2024 17:35:39 +0200
Message-Id: <20240419153542.121087-1-richardbgobert@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes a bug in the complete phase of UDP in GRO, in which
socket lookup fails due to using network_header when parsing encapsulated
packets. The fix is to add network_offset and inner_network_offset to
napi_gro_cb and use these offsets for socket lookup.

In addition p->flush/flush_id should be checked in all UDP flows. The
same logic from tcp_gro_receive is applied for all the flows in
udp_gro_receive_segment. This prevents packets with mismatching network
headers (flush/flush_id turned on) from merging in UDP GRO.

The original series includes a change to vxlan test which adds the local
parameter to prevent similar future bugs. I plan to submit it separately to
net-next.

This series is part of a previously submitted series to net-next:
https://lore.kernel.org/all/20240408141720.98832-1-richardbgobert@gmail.com/

v1 -> v2:
 - Use network_offsets instead of p_poff param as suggested by Willem
 - Check flush before postpull, and for all UDP GRO flows (previously
   reviewed by Willem, and was changed since)
 - v1:
 https://lore.kernel.org/netdev/20240412152120.115067-1-richardbgobert@gmail.com/

Richard Gobert (3):
  net: gro: add {inner_}network_offset to napi_gro_cb
  net: gro: fix udp bad offset in socket lookup
  net: gro: add flush check in udp_gro_receive_segment

 drivers/net/geneve.c           |  1 +
 drivers/net/vxlan/vxlan_core.c |  1 +
 include/net/gro.h              | 18 ++++++++++++++++--
 net/8021q/vlan_core.c          |  2 ++
 net/core/gro.c                 |  1 +
 net/ethernet/eth.c             |  1 +
 net/ipv4/af_inet.c             |  5 +----
 net/ipv4/gre_offload.c         |  1 +
 net/ipv4/udp.c                 |  3 ++-
 net/ipv4/udp_offload.c         | 15 +++++++++++++--
 net/ipv6/ip6_offload.c         |  8 ++++----
 net/ipv6/udp.c                 |  3 ++-
 net/ipv6/udp_offload.c         |  3 ++-
 13 files changed, 47 insertions(+), 15 deletions(-)

-- 
2.36.1


