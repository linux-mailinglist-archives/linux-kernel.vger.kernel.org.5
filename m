Return-Path: <linux-kernel+bounces-156003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACDFE8AFC8D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 01:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85E95B2230C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 23:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC744502B;
	Tue, 23 Apr 2024 23:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KBYjzMWN"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16843405FB
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 23:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713914865; cv=none; b=f0CheKgoeUJDSJRpBooaSWzoegqwy7vGXCyMYNDU3021PPP/x7tm7dHUvr921Ar4eKBwaD+ZS6WfDoYaPno44080jxvPner+eyTIKhT4KYlh8S90Gt6TwXLFaBhaPKGc88wmiNJykJneR0n6qBgWH7vm9qNzULuTNppajUQ1wko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713914865; c=relaxed/simple;
	bh=l6oDZivJcyQTCOy+gknzagGu6pD9fjWdRZ/T8AH6uxk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I3XW5ZKoFqVwzrmWLVZJ5o6pAL4qfKdW9K5U12GQgYnw12DVrN5iVyrSluQaOeEjpyqUMT3f8BW9qxidAMpEh6VaIe/+2yaS5EvXbDG1iMn27qLr6JQgY0EsylXSaXXeMibOYG7Nu+fFn19k9mkEil29W77F/bv8B6mf/U7z6CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KBYjzMWN; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-417bf71efb4so1442155e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 16:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713914862; x=1714519662; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RPOnWL9RPpAUuW6zSj0DHbUYz85VJ46LckD0gpweWUA=;
        b=KBYjzMWN/Vb1FaJMmcGldTfjlsH1Uz11TC8lW6+1dmV/Zl9R7qbUL3ZFAuCOFbjgKY
         V5yJI94I4T5guHJUx8Tv7V/1RGqD0wi66Fz6MJqeEbO6zIIHMRJPMMrcByoB/LQUMxtl
         IAVcn2z3P59gwGPqAeDjFfGjkF5nYjuKnUfxivurUdS2O3uLfZ4t5e6/V7ISTw0N1sJH
         tzbbnyORVz4c2vKMOd8slpkel1RwNtTkPYbomtfOV/tf5ur+Dnl26dEemQxlwDOerQPk
         TCloioMR20kwRcf3hIiEPADWoBtnoYdM4QkkG2DZA7wBAfQvbGrOBj9kYMl/73owkJ2N
         g83w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713914862; x=1714519662;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RPOnWL9RPpAUuW6zSj0DHbUYz85VJ46LckD0gpweWUA=;
        b=cShRS3GhBQNMFqPky781BWYsYSAjY7qKOjv6HN5Wvz792M3VohtQuvj6T0IsH3pBgj
         t0JKWyxM8P/m2W2sz3cSjsQrcV4C8JrvbQwIDf1SiJCNLiLSQJchBjX7cqrBl/jCWh5X
         o3jY+KRcQPh8RkhVAo5ITZo+QshBKE4fNhGHfbMAoU7T7LFjyjwoOCk8gQAj0HmoB1RJ
         4/E/35/miZ20HacLNbxMFlzUrWtL+444fkiZkriG26vE/enbMqm3YV2NT6cVI3tztDza
         KPUXXkncY6wWFY8sc2DQiZvgWNLbfrmhzVc/D7gLevu5WrIzVw5xsOyAsus5/iLJM8ME
         p5gg==
X-Forwarded-Encrypted: i=1; AJvYcCXSMX4mztRfM+qaSggquNHyEXBMhQb+DPBZi5ibEAlqmibjNQwmaSVrMl1Aqjt2tTwvfOpQQhMPJSMvg+DYRDkTLU3vZyOqfZu5ZJf1
X-Gm-Message-State: AOJu0YxEQIuCP2px/OgJ+EsZRzhbwkbc7F/cPYPKhbmTZviNEGWtx0P4
	M3WtqKce/jJYeWstEBrZ6Q3rVpXS/4Sh/6H3JLjdnTsAeGEDe21OQyCbIPkJPG++0HqTesL/2Uf
	v0SBtENo0kf4fSuvs7Q==
X-Google-Smtp-Source: AGHT+IGcdysYgUX4limEoSe99eX1kVHNgFXvvBzAevVZIP8Mf4AJfQvspS4UgnqLHo17qIW313pU+cLeRpPTxzU0
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a7b:cc16:0:b0:419:e61c:f388 with SMTP
 id f22-20020a7bcc16000000b00419e61cf388mr17264wmh.4.1713914862375; Tue, 23
 Apr 2024 16:27:42 -0700 (PDT)
Date: Wed, 24 Apr 2024 00:27:24 +0100
In-Reply-To: <20240423232728.1492340-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240423232728.1492340-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240423232728.1492340-2-vdonnefort@google.com>
Subject: [PATCH v21 1/5] ring-buffer: Allocate sub-buffers with __GFP_COMP
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	rdunlap@infradead.org, rppt@kernel.org, david@redhat.com, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

In preparation for the ring-buffer memory mapping, allocate compound
pages for the ring-buffer sub-buffers to enable us to map them to
user-space with vm_insert_pages().

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 25476ead681b..cc9ebe593571 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1524,7 +1524,7 @@ static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
 		list_add(&bpage->list, pages);
 
 		page = alloc_pages_node(cpu_to_node(cpu_buffer->cpu),
-					mflags | __GFP_ZERO,
+					mflags | __GFP_COMP | __GFP_ZERO,
 					cpu_buffer->buffer->subbuf_order);
 		if (!page)
 			goto free_pages;
@@ -1609,7 +1609,7 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
 
 	cpu_buffer->reader_page = bpage;
 
-	page = alloc_pages_node(cpu_to_node(cpu), GFP_KERNEL | __GFP_ZERO,
+	page = alloc_pages_node(cpu_to_node(cpu), GFP_KERNEL | __GFP_COMP | __GFP_ZERO,
 				cpu_buffer->buffer->subbuf_order);
 	if (!page)
 		goto fail_free_reader;
@@ -5579,7 +5579,7 @@ ring_buffer_alloc_read_page(struct trace_buffer *buffer, int cpu)
 		goto out;
 
 	page = alloc_pages_node(cpu_to_node(cpu),
-				GFP_KERNEL | __GFP_NORETRY | __GFP_ZERO,
+				GFP_KERNEL | __GFP_NORETRY | __GFP_COMP | __GFP_ZERO,
 				cpu_buffer->buffer->subbuf_order);
 	if (!page) {
 		kfree(bpage);
-- 
2.44.0.769.g3c40516874-goog


