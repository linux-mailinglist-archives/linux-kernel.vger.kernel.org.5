Return-Path: <linux-kernel+bounces-157327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 790428B0FD4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3600628135D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C9E16D33A;
	Wed, 24 Apr 2024 16:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OGysd6zf"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04ED216C45D;
	Wed, 24 Apr 2024 16:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713976286; cv=none; b=M2TTjEkI1jMM05qmCHJpICzI2mt/MnSQpLvJX1eukt8gk8yw6mwsy7zEcXqpC6k4QWALPpi1ngoDczf6ahuog69xKXuGK3Phb7ZNVnd23tuPdYUkvJ9AR1nQJTmbq+ItPESC/U6XMUSQ7Zvdji7egxt7FPGY9wMXOleh8/EvwMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713976286; c=relaxed/simple;
	bh=bXd2cF1r5wGgGn8qjmQ3gV0VuKXhxZccccWQSzrZm9Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=htDVFsuk+9UCiYucXmunoVs7BqsMReuwHpfMRojhI9y5DvR9O0KbWA4HL/sKI2UAH4PVfO/Tgmcy5gfmzz7eUboNw0ajQdEARjf9smb28x6vUuCHbYY1J2PgYWe57uVod/SECVxKxqGCjv7YDpe1TR2QotgnIj9yplcCJOST4qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OGysd6zf; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-417f5268b12so237295e9.1;
        Wed, 24 Apr 2024 09:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713976283; x=1714581083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dBCxnbysmOgF/ewLoKlev2MPx9AEH27+l/wXXPvFzlE=;
        b=OGysd6zfJiU90goKbGnLpHpfvLVXweV8WwC6O4IeR3ywgUmF+9bLUk+Wf4tuqhjA/g
         +XayccX/exhcyopskadhgud4L1VfdoHDBOrHOLWMm2/2IYTyB8WgvSb+QGbr0sTTm8Lp
         aZHvXGZ8ve+opDYndAN9kVXQN1xnH2qKfkRMvDXK9w0+gjS0mo+2HL8/DxLHd92zgbw1
         518Cz4Wm/nUxP7eHJzEVF+DithRsiUsyAp/yY8WP7IVbCO7oCHmlFuUXGZU+ULVKhsl6
         vLprWoV8IYVB5iN/rr4OVtdC3Q8qJyr2X6No7uecwhNt7Gwg2Hbk1e/BrknZdu0+1BNL
         nj7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713976283; x=1714581083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dBCxnbysmOgF/ewLoKlev2MPx9AEH27+l/wXXPvFzlE=;
        b=grW/NIFQrec55pek6dvfDsd0mRCYINoOi35TWl0ORytegb+GL528AfghNlL8dpwIA6
         hp3rbTYZB3KEPqFw+3HBgSDNHlAH59KM7xknk/FbtQiN7LGEsU2ykxXNn/+51vo2rUpK
         RwsdsFtuPRzPZRrG9fBewKip9NvE6YK1jD+SXxUXnRZSR1X/Wm2p/+jqd8CXZtLyBv/G
         Ld8wbBT+K7cQck7+ed3dq9J/CAg0JbzBSBWeRCj1XMXNK32O/+iF0QMatiiEpPG1MeNH
         okcLfG6TiZ6d3Di0VZPsfacbJ5tw+YcJDvNY6xrC382cjRzRdFCi8jMBUxDLBjU7afXV
         GQ6Q==
X-Forwarded-Encrypted: i=1; AJvYcCV9zi6xXQfqztw50miVjQbyKYtVNkaZstgSMbCg5W7UM/M3i7G9F0ipUUJG2eGjCga8hUWMJmDZHd7snGED0M11kZaXB2Elrtc2SLdMJy9cven/mtaXFNyjOglHFPCVo9GNMlBv
X-Gm-Message-State: AOJu0Ywp3KilgXNnMGIxDGRJxo9J4RdNDs6W546R0BQolJ30TFWe9PYy
	SBLBnS0WMJmr8v89OXs23tCwHQQvJBxF5jVA52Qwjpbx5w9YLOKm
X-Google-Smtp-Source: AGHT+IFUpJsakHRh1kOPHZFFzKEcGsY6ZHbqpePB9VmTomOvAodhS1J0k3ZrVcbUbLik4u6Hr30rmA==
X-Received: by 2002:a05:600c:1c85:b0:416:4641:5947 with SMTP id k5-20020a05600c1c8500b0041646415947mr2786731wms.34.1713976283451;
        Wed, 24 Apr 2024 09:31:23 -0700 (PDT)
Received: from localhost ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id o14-20020a05600c510e00b00419f572671dsm15945929wms.20.2024.04.24.09.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 09:31:23 -0700 (PDT)
From: Richard Gobert <richardbgobert@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	willemdebruijn.kernel@gmail.com,
	alobakin@pm.me,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Richard Gobert <richardbgobert@gmail.com>
Subject: [PATCH net v3 2/2] net: gro: add flush check in udp_gro_receive_segment
Date: Wed, 24 Apr 2024 18:30:45 +0200
Message-Id: <20240424163045.123528-3-richardbgobert@gmail.com>
In-Reply-To: <20240424163045.123528-1-richardbgobert@gmail.com>
References: <20240424163045.123528-1-richardbgobert@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GRO-GSO path is supposed to be transparent and as such L3 flush checks are
relevant to all UDP flows merging in GRO. This patch uses the same logic
and code from tcp_gro_receive, terminating merge if flush is non zero.

Fixes: 36707061d6ba ("udp: allow forwarding of plain (non-fraglisted) UDP GRO packets")
Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
---
 net/ipv4/udp_offload.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index fd29d21d579c..8721fe5beca2 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -471,6 +471,7 @@ static struct sk_buff *udp_gro_receive_segment(struct list_head *head,
 	struct sk_buff *p;
 	unsigned int ulen;
 	int ret = 0;
+	int flush;
 
 	/* requires non zero csum, for symmetry with GSO */
 	if (!uh->check) {
@@ -504,13 +505,22 @@ static struct sk_buff *udp_gro_receive_segment(struct list_head *head,
 			return p;
 		}
 
+		flush = NAPI_GRO_CB(p)->flush;
+
+		if (NAPI_GRO_CB(p)->flush_id != 1 ||
+		    NAPI_GRO_CB(p)->count != 1 ||
+		    !NAPI_GRO_CB(p)->is_atomic)
+			flush |= NAPI_GRO_CB(p)->flush_id;
+		else
+			NAPI_GRO_CB(p)->is_atomic = false;
+
 		/* Terminate the flow on len mismatch or if it grow "too much".
 		 * Under small packet flood GRO count could elsewhere grow a lot
 		 * leading to excessive truesize values.
 		 * On len mismatch merge the first packet shorter than gso_size,
 		 * otherwise complete the GRO packet.
 		 */
-		if (ulen > ntohs(uh2->len)) {
+		if (ulen > ntohs(uh2->len) || flush) {
 			pp = p;
 		} else {
 			if (NAPI_GRO_CB(skb)->is_flist) {
-- 
2.36.1


