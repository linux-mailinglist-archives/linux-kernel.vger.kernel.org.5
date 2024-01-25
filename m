Return-Path: <linux-kernel+bounces-39240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 767A883CD41
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 21:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83EAC1C2443F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 20:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206D6137C23;
	Thu, 25 Jan 2024 20:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="neuDlV4q"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045DF136678;
	Thu, 25 Jan 2024 20:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706213823; cv=none; b=n0L45ZjGACfNAi+NJKhzjP6XnKwFPBBzYP7O4xr2b6M++hQRRPNCpRYQj/y2cFytdymu0YvfjCohmIiu9tvMvh315B3KPyjHMPB2jFDMVfU9DXlsq1iRorkEVNTWD57IHyXx8Y9WU47lszJvYocepoWTdHE2uMncBOebkmJVcqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706213823; c=relaxed/simple;
	bh=pZG/NmciLFvh2pEfMgXU9dRYMsDzwNU1T8h5FuZA04Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TgWuGDePcfm2g0pZal+kJGuZa2/SCj7idsuRVTBpLMQdZS24fvftehWicimIg7KMpaIdOaWZjwUU8pA3jdZE2oUr+VszG1IB+0BYJfRO3ECaccvmPxdZxeWrnKdFd7+fZPHBjw3XmfDV3latHO13vxvkh1m/594qo8ZQw2oHoHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=neuDlV4q reason="key not found in DNS"; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d89518d3b1so4480795ad.0;
        Thu, 25 Jan 2024 12:17:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706213821; x=1706818621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:dkim-signature:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QSIlTHL+Q/oYMZeLntckVZudLDzYKGhiQvMbHnxJsCQ=;
        b=XOC+JzpejlApgCNcfRsmBKSCkHjtEsC1n64xhGmEABMA9cN17AZulC4Mw3MrEliTrG
         p56OTt2s205Spx/Ce//BhbgDl2/gUGiiv6drKc0ts/Cus5V3tSOFulcmJBecN1I56mnC
         omJZf+FITqm500uDYNp282nn/W2mYOIrgc6JR7uWNSvTk6XFU84ZwJcKZdIQQGqw03h+
         1bklHhWNF3pbgaKqcTcEbPKFJZpbGLdoiG5MGw6ciic5xA/7wxujU9zkw44vruSZt+iK
         bNmBUjeAvL9/lqs2ue2/ymAbiQCuXAAaZAsuzBKG1xb23tJEPvK4S5HhHPv88ONDYDE5
         WY0g==
X-Gm-Message-State: AOJu0Yz360TH6EXHFIVQ3I4lInYc7QvtvTOTwBxCGMedYfgIUj396vJn
	+7ZtkBWQvTEksolbzL266ZLVGgKbpx1eQo0sfox8QSu0mBMatBJl49QJFLwST68MwQ==
X-Google-Smtp-Source: AGHT+IFYmhYcZHYIbnJnRbgo+R0zRc5xVyWzypUYEYOu3U9FL1Y4iVCHVZ/+EhIBq6eLXL00CbdWeg==
X-Received: by 2002:a17:902:d4cf:b0:1d7:1f2d:8536 with SMTP id o15-20020a170902d4cf00b001d71f2d8536mr154424plg.21.1706213821173;
        Thu, 25 Jan 2024 12:17:01 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id d4-20020a170902c18400b001d71649bf9asm11117952pld.252.2024.01.25.12.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 12:17:00 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1706213819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QSIlTHL+Q/oYMZeLntckVZudLDzYKGhiQvMbHnxJsCQ=;
	b=neuDlV4qgsWMT5b8ZHLOjBGdVFKfFUm3hI3aAjxlPj+eQOcYSJf+zNrCoD1KM3Yn9jWvXA
	+pGQdrsAm8NxQ8qfqFTglg41ALxVJKrPkTZyFuKWTekeOohKE9SEiwd+ON7/7lraB/ZKR+
	2sF/Q3YMyxWqUISxY0OQBuN3r+uyDUD2Kl9f6jkaZ6EGCl0ccW9jO9hibyuM1i/m9VsoE1
	cmpfLtQWpcFgAcqlImgzgMK5YTFWidUm8XZjs/j92uuUq3BgDT4KAZxLsrASe3Zlm/RexI
	AhVewUIYdHw04HHanpr/uqG0iP8nIlU8VnJr6DlmYcoInrgchTztErjSRxBRPQ==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Ricardo B. Marliere" <ricardo@marliere.net>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] tracing: convert __trace_seq_init to use WARN_ON_ONCE
Date: Thu, 25 Jan 2024 17:16:22 -0300
Message-ID: <20240125201621.143968-5-ricardo@marliere.net>
In-Reply-To: <20240125201621.143968-1-ricardo@marliere.net>
References: <20240125201621.143968-1-ricardo@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The initialization of trace_seq buffers are done elsewhere and therefore
__trace_seq_init should yield a warning if it has to actually initialize
the buffer.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 kernel/trace/trace_seq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_seq.c b/kernel/trace/trace_seq.c
index 741b2f3d76c0..3c7a7d903b54 100644
--- a/kernel/trace/trace_seq.c
+++ b/kernel/trace/trace_seq.c
@@ -32,7 +32,7 @@
  */
 static inline void __trace_seq_init(struct trace_seq *s)
 {
-	if (unlikely(!s->seq.size))
+	if (WARN_ON_ONCE(!s->seq.size))
 		trace_seq_init(s);
 }
 
-- 
2.43.0


