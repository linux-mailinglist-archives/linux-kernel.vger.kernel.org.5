Return-Path: <linux-kernel+bounces-142939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9125D8A324E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20706B245DC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA788446BD;
	Fri, 12 Apr 2024 15:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bk1bW2Vl"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A5A148FEE;
	Fri, 12 Apr 2024 15:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712935336; cv=none; b=diuax6p3YasavAsQ17s3vPSrYViqCo8hV1Tui+Z/pmexuTpwx9lWFNntpw835kjznlLiRWDG+PzDiVW334sQkT8ND0/hjkIdEFIr0LjTyDGeb+xCBA+HRB89Vh8IwixOqVt//zpSdxF2NgpDYl+ANunFXt67zErgbTRezxJQvUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712935336; c=relaxed/simple;
	bh=vWx8hjmgbGaYijZPOHAFQF3Diarftvn5nTcDZWxUfWQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l+pzAjOZoTv16nCqicd22IbaLOnmi1EcughVFTUi8LwjSMHesYh3oIHTmV3s5P5WGiwqg2LdSv0Q2/oOt4pwMX0e+qXZ4duh7oMdn7WlIn9caiPXHN3K/y34A6CBOn7KlHysnDyqa9O5K6gJ3vhlE7gbW0p0xKUEJYc6J8M3MxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bk1bW2Vl; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-417f5268b12so9539265e9.1;
        Fri, 12 Apr 2024 08:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712935333; x=1713540133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=68baX53kYRdqiSV3OuL3sThzmNqdOFLBEOv/P9LxiMo=;
        b=bk1bW2Vl0rAKZh3WwPhZlovjXbexko1sJNYuqP7OmCoktMa5e4eyj5KOzyY/4myE4Q
         5xhfRslGXb/R8aoq+Sl7Q1YGKf7jJLDbO9ROujuqUGC48l0xUGWFg1ztNarzUntp08Vp
         jN3Q0TGlKqR+4DciDAcPvwFLalMJ/TN9Mie+m9PAuh1C68tgXS6DMct6use87Bip7GB8
         f0BopJTotNGcsxQxfVhcj5U/L+4gWKcdFK/eVhPB7GOQ1rsgQ7WawtdBX2h5N0MUELQ8
         xF4BvbAsM+8ykr9acs4KK8zKSrQMumr/0ipTUSw3QaRCDxojIjA5+LWjMECMBHE/6vr4
         gQkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712935333; x=1713540133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=68baX53kYRdqiSV3OuL3sThzmNqdOFLBEOv/P9LxiMo=;
        b=CkJJtzdrbqegLDqQjK1fxgmJoRbcrlvSVfbDptNVSY0FSRSaTsztHYBlJ0irvTyFPe
         KzcvNEuUWIyneygjyC9aTBUi2+qXPqwD+x4u3m7N1NH4a3KPDFKIGsQCkUsPwCxu3Osd
         vfZr/nODqJIk5fwEiQHyWy4znZo2JdNJo/8bTEfVn4SZxmo97JmCzG5cBEpP4DkxF8Kb
         xxZlwtxJyYw+MG/YNR2xEMusWk25eleI3F3CuWFrpT6QCjZ1qc/wmRGwg4z2boTzkXPs
         pDt/XJY4dTF7BVCtL8MiUAmMTul7o12CFK3TsToARiLrzVrzgE1v7mpl+q3bntvHLf3T
         dhEg==
X-Forwarded-Encrypted: i=1; AJvYcCX8ZAhvVV/WWTmn6uB1z2Zyoe9jHDvtye1lIHYLPJiAq8fPEBQsurMDFr+eQC8l9g5AVsQdoSShSnSVbSc1kJwBP3fPyNGbY5NExU9riDc39KnBdN4CkswRoN8XXBzrrAqZNG4u
X-Gm-Message-State: AOJu0YwqXcLNEJNCvaB5AyyWexAHIQeG+DMDOuaY6ShzT+6mc6N4mR4D
	LMI5JIQriYHxDba9Cv0RBNQoejNsmBZHkpT0VzA38gbJqgwMCsIx
X-Google-Smtp-Source: AGHT+IHJyw+CGlklDUs7/JfZQA6jFaqmzKSrHFQcXrVE9ebzzfRJacwFjzdAXVcDcos/3UyuhpFQnA==
X-Received: by 2002:a05:600c:1e0b:b0:418:1447:711d with SMTP id ay11-20020a05600c1e0b00b004181447711dmr453539wmb.24.1712935332801;
        Fri, 12 Apr 2024 08:22:12 -0700 (PDT)
Received: from localhost ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id n21-20020a05600c3b9500b00416928e239csm6005029wms.35.2024.04.12.08.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 08:22:12 -0700 (PDT)
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
Subject: [PATCH net v1 1/2] net: gro: add flush check in udp_gro_receive_segment
Date: Fri, 12 Apr 2024 17:21:19 +0200
Message-Id: <20240412152120.115067-2-richardbgobert@gmail.com>
In-Reply-To: <20240412152120.115067-1-richardbgobert@gmail.com>
References: <20240412152120.115067-1-richardbgobert@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GRO-GSO path is supposed to be transparent and as such L3 flush checks are
relevant to all flows which call skb_gro_receive. This patch uses the same
logic and code from tcp_gro_receive but in the relevant flow path in
udp_gro_receive_segment.

Fixes: 36707061d6ba ("udp: allow forwarding of plain (non-fraglisted) UDP GRO packets")
Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
---
 net/ipv4/udp_offload.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index 3498dd1d0694..1f4e08f43c4b 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -471,6 +471,7 @@ static struct sk_buff *udp_gro_receive_segment(struct list_head *head,
 	struct sk_buff *p;
 	unsigned int ulen;
 	int ret = 0;
+	int flush;
 
 	/* requires non zero csum, for symmetry with GSO */
 	if (!uh->check) {
@@ -528,7 +529,17 @@ static struct sk_buff *udp_gro_receive_segment(struct list_head *head,
 				skb_gro_postpull_rcsum(skb, uh,
 						       sizeof(struct udphdr));
 
-				ret = skb_gro_receive(p, skb);
+				flush = NAPI_GRO_CB(p)->flush;
+
+				if (NAPI_GRO_CB(p)->flush_id != 1 ||
+				    NAPI_GRO_CB(p)->count != 1 ||
+				    !NAPI_GRO_CB(p)->is_atomic)
+					flush |= NAPI_GRO_CB(p)->flush_id;
+				else
+					NAPI_GRO_CB(p)->is_atomic = false;
+
+				if (flush || skb_gro_receive(p, skb))
+					ret = 1;
 			}
 		}
 
-- 
2.36.1


