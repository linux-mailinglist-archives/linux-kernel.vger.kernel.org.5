Return-Path: <linux-kernel+bounces-126497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A87A08938A8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 09:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCB7A1C20E29
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 07:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2A9D51A;
	Mon,  1 Apr 2024 07:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="KvZu+P9A"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC27BA50
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 07:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711956744; cv=none; b=ZqDf0Vn30hLw7hbeG4E2s7rMreVdgglmCMg4slPLhKkmmupRdFESRDHkDnXURURb1BpDhnOBLKx2NpSlU3npHC3945STDgR/fMMga/F6S6ry5e+2y3LrdPp/tXfBYiYF8JHkt8ldhNfLx26yITYRv0wtSp5mqc1WLo2k3+Qpua0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711956744; c=relaxed/simple;
	bh=gIfeuyMiLA+qG3mIP+HMYnQdK7NPvoQUwTsiRfQxpFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nk5v0QjuiAkxlggH/e3nDBs8fhOWrJEQSSYxDMXct2E0SUNXoahkJzl7j4bN7SkUFBRRtGLS07rbNz2ooECqaNT8LY4csdvX+ynIaq7EsBwX3guiwwRqzwIK/5pWgEbXstdT3oW+iuN1nu097l2fezqUztO0zVOboEc/buBkm1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=KvZu+P9A; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 494AE3FE21
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 07:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1711956731;
	bh=AHzGweR9mhy06+J1pxtJBnh5aZr93umUBtlWOhz9jgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=KvZu+P9ACUMECUQaKNwm36WIk5sylV706Zt6HplQ1tKrHXST4JN9w1QlVsBxFteNZ
	 DJA9Ez75eCvjF2jvednbRJmUwSqlOq9N9dzK/5Ra2tsSTTa3SUfcGkRzrzJtnCue6i
	 SKDNF/jwmv8hkgIkETQB8EaC2XtmQig9Pw++QF4mP4dW7uoxlbythEi2MznAHZken8
	 W3Y05xwNXNQtNWMKO2ffZUDxNDiX0GhHHEPuhaKIPPk9oNL7RYI5XGeAJhI8Vc0OXe
	 Z+Hb4Mslg/yYkVSCBZ0zMpxqELh0umpVNXIEpmtaJwlgU1esFUQ8vc4qXmkJUwAqhk
	 t8f4GBWd2qgPA==
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5684bf1440dso1752750a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 00:32:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711956729; x=1712561529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AHzGweR9mhy06+J1pxtJBnh5aZr93umUBtlWOhz9jgY=;
        b=ZxyslIzk8WcvUFQZZ+Di0+S9KtcJnptoitT8EHiHHjzU7FTvDXquOeN6RNkJ3xN77h
         nnDiyJXbz9l+WZHqynUtANMvJIZycrQ6VZaSg9207BFRyps/JVtGfIfdhxrfMgoMzM2P
         9obZ2Pm+ioyHq6VOPN2YN0lRewJXdY32NHF2oHwZO96BXdWLE/7y5YkNN6lqU1rsPAgN
         tCP3zTfUuXfiHOfYXxxTZdJ8sCRHJz68BnCrIThWdGl4OrepZ+3NH8x7aCv7ZDnnZgub
         17+wTIsEI99VEFNe85H7S3gc6CG8lhyCcw1N6t4y5DXayMoF8ZDacgO0/KyPBwEALRyM
         eFmA==
X-Forwarded-Encrypted: i=1; AJvYcCXfkOnGKVUODyFW0FXRorWrrDeFNrrjzTQHOIG3+Evw97jYj2/8QhURrHJ4JUeU203EbDN52cNcv03sxlycCgyR0X/eeejOFLLm6dv2
X-Gm-Message-State: AOJu0YxBTVle/iA5YQC2F40cv78euq+J/w1BHVhxBt6ZMKBbZxlpDvZc
	/YW3BDWqAxBg/QQR2JxeLBWVV6kdHeh+JFYzvKJXRZyYGkyd+JYqzp7FrIGhUM+aSnyUQ+zZCMk
	iiKyqWKQ6qN14lZNmiBIY8ZT4Eb206JQ8fjhWEU7Sj55f/xErmCBzPCJe1RAK1qmMtslQct8MDU
	PluQ==
X-Received: by 2002:a50:d698:0:b0:56b:cf40:f712 with SMTP id r24-20020a50d698000000b0056bcf40f712mr4806235edi.19.1711956729432;
        Mon, 01 Apr 2024 00:32:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0WRJkDIMWT00K5pp21gpKN/ARz9FyR5f64Ct8AmND3JMwZyQQQXkDBg+wYzzg5NAPBCigcQ==
X-Received: by 2002:a50:d698:0:b0:56b:cf40:f712 with SMTP id r24-20020a50d698000000b0056bcf40f712mr4806215edi.19.1711956728926;
        Mon, 01 Apr 2024 00:32:08 -0700 (PDT)
Received: from localhost.localdomain (host-95-248-169-71.retail.telecomitalia.it. [95.248.169.71])
        by smtp.gmail.com with ESMTPSA id b23-20020aa7df97000000b0056b2c5c58d2sm5096511edy.21.2024.04.01.00.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 00:32:08 -0700 (PDT)
From: Andrea Righi <andrea.righi@canonical.com>
To: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	David Vernet <void@manifault.com>,
	Tejun Heo <tj@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] libbpf: ringbuf: allow to consume up to a certain amount of items
Date: Mon,  1 Apr 2024 09:19:01 +0200
Message-ID: <20240401073159.16668-2-andrea.righi@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240401073159.16668-1-andrea.righi@canonical.com>
References: <20240401073159.16668-1-andrea.righi@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In some cases, instead of always consuming all items from ring buffers
in a greedy way, we may want to consume up to a certain amount of items,
for example when we need to copy items from the BPF ring buffer to a
limited user buffer.

This change allows to set an upper limit to the amount of items consumed
from one or more ring buffers.

Link: https://lore.kernel.org/lkml/20240310154726.734289-1-andrea.righi@canonical.com/T
Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
---
 tools/lib/bpf/ringbuf.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
index aacb64278a01..81df535040d1 100644
--- a/tools/lib/bpf/ringbuf.c
+++ b/tools/lib/bpf/ringbuf.c
@@ -231,7 +231,7 @@ static inline int roundup_len(__u32 len)
 	return (len + 7) / 8 * 8;
 }
 
-static int64_t ringbuf_process_ring(struct ring *r)
+static int64_t ringbuf_process_ring(struct ring *r, int64_t max_items)
 {
 	int *len_ptr, len, err;
 	/* 64-bit to avoid overflow in case of extreme application behavior */
@@ -264,7 +264,14 @@ static int64_t ringbuf_process_ring(struct ring *r)
 							  cons_pos);
 					return err;
 				}
-				cnt++;
+				if (++cnt >= max_items) {
+					/* update consumer pos and return the
+					 * total amount of items consumed.
+					 */
+					smp_store_release(r->consumer_pos,
+							  cons_pos);
+					goto done;
+				}
 			}
 
 			smp_store_release(r->consumer_pos, cons_pos);
@@ -281,19 +288,18 @@ static int64_t ringbuf_process_ring(struct ring *r)
  */
 int ring_buffer__consume(struct ring_buffer *rb)
 {
-	int64_t err, res = 0;
+	int64_t err, res = 0, max_items = INT_MAX;
 	int i;
 
 	for (i = 0; i < rb->ring_cnt; i++) {
 		struct ring *ring = rb->rings[i];
 
-		err = ringbuf_process_ring(ring);
+		err = ringbuf_process_ring(ring, max_items);
 		if (err < 0)
 			return libbpf_err(err);
 		res += err;
+		max_items -= err;
 	}
-	if (res > INT_MAX)
-		return INT_MAX;
 	return res;
 }
 
@@ -304,7 +310,7 @@ int ring_buffer__consume(struct ring_buffer *rb)
 int ring_buffer__poll(struct ring_buffer *rb, int timeout_ms)
 {
 	int i, cnt;
-	int64_t err, res = 0;
+	int64_t err, res = 0, max_items = INT_MAX;
 
 	cnt = epoll_wait(rb->epoll_fd, rb->events, rb->ring_cnt, timeout_ms);
 	if (cnt < 0)
@@ -314,13 +320,12 @@ int ring_buffer__poll(struct ring_buffer *rb, int timeout_ms)
 		__u32 ring_id = rb->events[i].data.fd;
 		struct ring *ring = rb->rings[ring_id];
 
-		err = ringbuf_process_ring(ring);
+		err = ringbuf_process_ring(ring, max_items);
 		if (err < 0)
 			return libbpf_err(err);
 		res += err;
+		max_items -= err;
 	}
-	if (res > INT_MAX)
-		return INT_MAX;
 	return res;
 }
 
@@ -375,11 +380,11 @@ int ring__consume(struct ring *r)
 {
 	int64_t res;
 
-	res = ringbuf_process_ring(r);
+	res = ringbuf_process_ring(r, INT_MAX);
 	if (res < 0)
 		return libbpf_err(res);
 
-	return res > INT_MAX ? INT_MAX : res;
+	return res;
 }
 
 static void user_ringbuf_unmap_ring(struct user_ring_buffer *rb)
-- 
2.43.0


