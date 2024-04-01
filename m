Return-Path: <linux-kernel+bounces-126496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD1A8938A7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 09:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48C631F212DB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 07:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC07D30B;
	Mon,  1 Apr 2024 07:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="foImCwLv"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3A8BA39
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 07:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711956744; cv=none; b=lpPvha3m5qq5VYN6NiRhfvTKWSDBhxZOqWRy58WJorFMuIe4PpiHOeqy4nZbkvSrCWIKmGvStDSswbTQaSoCGGYB65mik6FbCZa5f1x+nYs4W1EajN4zfrgbqx96KByoCnHKcbsYipw/oNvowtyr7vdxE61126u3qzbxA7t5GxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711956744; c=relaxed/simple;
	bh=E2OvbR8Y9EfGSS+5Sv3FbD9q2hZ3fz6/lXWfMYaBCYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M7gfONYX7OuRAdAZz9Z27fzCDXv3UCcM9XfNWZMScd1TNtc6XzWUTz9zIqAfYmmQLzxI6+xkFedZftuHTtr0+637DpJKivOYHC3a2JWW8zwpnGGyiL5LNrcCADa5x8XdReRvzWfLsXuiOqiryTOojB/XavbTV9suy368IM9JNd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=foImCwLv; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E06CA40013
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 07:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1711956734;
	bh=+ydULlYumW86H0k1QJy3F+4RQ7Ta2EUdgWzksXidHow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=foImCwLvKyH4/d3o8XIQ2u7r0sBJS9oKTjqNb+q2VLO+oWZiQO8ATH95YilTlG8ov
	 2UoeAXeUDmpS8kyOrbeJkRCt+WnJfwrFJ+c94zlyku+tRc5HsZZ68tMccNgpMZb34w
	 vHs99Csw92PNe2dS13Rl2zVYbyzedgPwPUDbTGwHrQBsV5j4Uy3BiVPp6hNz0P3SE3
	 +5g9VwSBp9vypWqASv4YzE2sQeVtA9MRBlGm3n8TzxMuC4flkdZgOxJBWZJlJLApiz
	 RF4HiEtM+2YUM6bZpnNPfbVFf9730nCGsbSDdHIHxwuhjc/k4kOOWhl69GkvJ1lbmV
	 Ml8uy8q+rZnOw==
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-56bf8c6d3e8so1032126a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 00:32:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711956731; x=1712561531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ydULlYumW86H0k1QJy3F+4RQ7Ta2EUdgWzksXidHow=;
        b=JiTthLMN4tk0R0h3xifxLg65y6BL0fEsF5diGHhawkakOr/RiaS4DuMvlfITFxNv/7
         eTK92L/ssvQX9Dd+x8movG159XbBJLxvrKmgxUxgkb2977qDsfMlgFd3GjF/c16TeXma
         VvwOscGxatLQh3RianjI596io0GMBVSOUMIXmP0y/u63a4Feln4nPYNQ7l74+W2/7ntW
         IboOZFmfhTnYwvQp7oKdgdKl2650J87X5evFEdT8l2JwP+c3glxusuwIbTguZOI/q7Ct
         UyK/FgUPTKirLQYRqzyePlpM4LNdqIUkmdAqrQ4de/m1W7Gmr+iT534JBh6LyQNdxJJ6
         LELw==
X-Forwarded-Encrypted: i=1; AJvYcCXLbGEV3Srf/w2yHY3Pf5Hl+jvQ7Ot3BQqXi/O+BrirmgBiEv+S0o4sYm1ZC78YlXjiKdnT5rVtEbjLNmCOR/Ez01pqKDUkVNYIt5OY
X-Gm-Message-State: AOJu0YzM8ttKcZQIG7C4I0+wIkRX8CQbTo/76MDtj7xGs2IBuA4Xrz9J
	L3LAC1LGZCwmOjrqL1wKy4rZyKUNgCdy2cl4Qo6SRISnIpHBEWCgk6Ta9/VRnoNa4cCO+z7NNQI
	9JTeOA6hYI05Pk7svSUR9nOcnwcpOlAGEM+TOCHd/mCZYjaUym7o8zg/Zgg/5r5xMRBqpAgeMhS
	wU0w==
X-Received: by 2002:a50:8a99:0:b0:56c:5a49:733 with SMTP id j25-20020a508a99000000b0056c5a490733mr4894158edj.10.1711956730684;
        Mon, 01 Apr 2024 00:32:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/s48cbhw5kWGmUnFjm93DIbZ7N9w0ByK1ybfJnUyLWeOpcJdNno7LzBS/t0R7Nxtdny/Jkw==
X-Received: by 2002:a50:8a99:0:b0:56c:5a49:733 with SMTP id j25-20020a508a99000000b0056c5a490733mr4894128edj.10.1711956730256;
        Mon, 01 Apr 2024 00:32:10 -0700 (PDT)
Received: from localhost.localdomain (host-95-248-169-71.retail.telecomitalia.it. [95.248.169.71])
        by smtp.gmail.com with ESMTPSA id b23-20020aa7df97000000b0056b2c5c58d2sm5096511edy.21.2024.04.01.00.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 00:32:09 -0700 (PDT)
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
Subject: [PATCH 2/2] libbpf: Add ring__consume_max / ring_buffer__consume_max
Date: Mon,  1 Apr 2024 09:19:02 +0200
Message-ID: <20240401073159.16668-3-andrea.righi@canonical.com>
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

Introduce a new API to consume items from a ring buffer, limited to a
specified amount, and return to the caller the actual number of items
consumed.

Link: https://lore.kernel.org/lkml/20240310154726.734289-1-andrea.righi@canonical.com/T
Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
---
 tools/lib/bpf/libbpf.h   | 13 +++++++++++++
 tools/lib/bpf/libbpf.map |  2 ++
 tools/lib/bpf/ringbuf.c  | 35 +++++++++++++++++++++++++++++++++--
 3 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index f88ab50c0229..85161889efd4 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1293,6 +1293,8 @@ LIBBPF_API int ring_buffer__add(struct ring_buffer *rb, int map_fd,
 				ring_buffer_sample_fn sample_cb, void *ctx);
 LIBBPF_API int ring_buffer__poll(struct ring_buffer *rb, int timeout_ms);
 LIBBPF_API int ring_buffer__consume(struct ring_buffer *rb);
+LIBBPF_API int ring_buffer__consume_max(struct ring_buffer *rb,
+					size_t max_items);
 LIBBPF_API int ring_buffer__epoll_fd(const struct ring_buffer *rb);
 
 /**
@@ -1367,6 +1369,17 @@ LIBBPF_API int ring__map_fd(const struct ring *r);
  */
 LIBBPF_API int ring__consume(struct ring *r);
 
+/**
+ * @brief **ring__consume_max()** consumes up to a certain amount of items from
+ * a ringbuffer without event polling.
+ *
+ * @param r A ringbuffer object.
+ * @param max_items Maximum amount of items to consume.
+ * @return The number of items consumed (or max_items, whichever is less), or a
+ * negative number if any of the callbacks return an error.
+ */
+LIBBPF_API int ring__consume_max(struct ring *r, size_t max_items);
+
 struct user_ring_buffer_opts {
 	size_t sz; /* size of this struct, for forward/backward compatibility */
 };
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 51732ecb1385..bb3ed905119d 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -415,4 +415,6 @@ LIBBPF_1.4.0 {
 		bpf_token_create;
 		btf__new_split;
 		btf_ext__raw_data;
+		ring__consume_max;
+		ring_buffer__consume_max;
 } LIBBPF_1.3.0;
diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
index 81df535040d1..c8123e326b1a 100644
--- a/tools/lib/bpf/ringbuf.c
+++ b/tools/lib/bpf/ringbuf.c
@@ -281,6 +281,32 @@ static int64_t ringbuf_process_ring(struct ring *r, int64_t max_items)
 	return cnt;
 }
 
+/* Consume available ring buffer(s) data without event polling up to max_items.
+ *
+ * Returns number of records consumed across all registered ring buffers (or
+ * max_items, whichever is less), or negative number if any of the callbacks
+ * return error.
+ */
+int ring_buffer__consume_max(struct ring_buffer *rb, size_t max_items)
+{
+	int64_t err, res = 0;
+	int i;
+
+	for (i = 0; i < rb->ring_cnt; i++) {
+		struct ring *ring = rb->rings[i];
+
+		err = ringbuf_process_ring(ring, max_items);
+		if (err < 0)
+			return libbpf_err(err);
+		res += err;
+		max_items -= err;
+
+		if (!max_items)
+			break;
+	}
+	return res;
+}
+
 /* Consume available ring buffer(s) data without event polling.
  * Returns number of records consumed across all registered ring buffers (or
  * INT_MAX, whichever is less), or negative number if any of the callbacks
@@ -376,17 +402,22 @@ int ring__map_fd(const struct ring *r)
 	return r->map_fd;
 }
 
-int ring__consume(struct ring *r)
+int ring__consume_max(struct ring *r, size_t max_items)
 {
 	int64_t res;
 
-	res = ringbuf_process_ring(r, INT_MAX);
+	res = ringbuf_process_ring(r, max_items);
 	if (res < 0)
 		return libbpf_err(res);
 
 	return res;
 }
 
+int ring__consume(struct ring *r)
+{
+	return ring__consume_max(r, INT_MAX);
+}
+
 static void user_ringbuf_unmap_ring(struct user_ring_buffer *rb)
 {
 	if (rb->consumer_pos) {
-- 
2.43.0


