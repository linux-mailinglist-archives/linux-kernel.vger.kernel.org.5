Return-Path: <linux-kernel+bounces-39357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F2483CF54
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 23:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E31BB26EC5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 22:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3360D13BEB9;
	Thu, 25 Jan 2024 22:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="PHxPYs25"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275CF13BEA9;
	Thu, 25 Jan 2024 22:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706221708; cv=none; b=kbj7MLpnFs3j3XzvFKSKJTDet7tv6QiLGfcPFXFqprHZcUDoaxvm0tCzEZnQUFQ2yA5P00lY/7jhNJRxSj82wLI8Zk3ye8ujXmVhj7oGEDZEsZAdKRVQW3fMkyS9olpJW+PIVMSEhtqtGE4XFf+joyvU19p8UX44VPFfGSFTIZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706221708; c=relaxed/simple;
	bh=/btpYBoKltilJcMDCCj8DktuiKGbFPJxfILScVQXwpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q2e3wdg9+nMvtJrQVANfRAMi36P5HOeAap/9iEgLRUIKmSb8XSQrnDRXc4GKkBoSvMi/NNSrzwvdCegDeUlDSaCuBnqEOepcjTCqMD8RUBWyBIRBUc/0xVMe9yrg7p2f0WrCi9Dpu2VyLRVMIlbWCq+RQ581L6nCsdF5yTDixHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=PHxPYs25 reason="key not found in DNS"; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d74045c463so38808175ad.3;
        Thu, 25 Jan 2024 14:28:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706221706; x=1706826506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:dkim-signature:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w0VO8GupOllM8NGeaQ3SXOm5cCjSBeKcpIn0k9PNzAU=;
        b=s87xSAtj5alVl0U40m7C5r+nEwWA1Gk+hTaveXR3M9XHD1gTGe0IRTJfZ7lAMWXarj
         BBqhiLFY6IRp+dW9YwPcbGxRuD8o6U5TDoCNeXc/cZfa1G4WZvAGpY/B4u0HRujqxjDT
         dUi9ZCxDDJW+PsM+7jJQu6BLlpaxoJ/YwoZunu64orIu98y7zwsCDSiHTS2CgY5w2gI5
         Tqc6fJ8ZLke9ibPw7uhfvjwep+0dkcjGv5Zj46kBdyglglG0ejnGap8n3AtxzL5fxq28
         QerL+QJLE/lbKYkiWgj7y54XZ1ktHT9VnXtWzGDedwGZv9qojO/pkpxceBqnsvfhRx5f
         DjTg==
X-Gm-Message-State: AOJu0YwSMgR/aeGtl5+ZZI1Clf3tWN1XLM/PCMLJept7LLo8YCaHsd05
	SIBMxTtnvd7ekfS3MAcz8cLATz1ylqv2T3BUSOeAkTLP/GfM1oSE
X-Google-Smtp-Source: AGHT+IFNOXfnnvhHGC8+oB5mPATdahjM+3HbqL4zKH68OivYtDySAlGqXK5aO5Do5NcyOuo2bzXbhA==
X-Received: by 2002:a17:903:3284:b0:1d7:c16:338a with SMTP id jh4-20020a170903328400b001d70c16338amr315873plb.104.1706221706354;
        Thu, 25 Jan 2024 14:28:26 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id q23-20020a170902789700b001d3a371cd24sm12359167pll.53.2024.01.25.14.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 14:28:25 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1706221704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w0VO8GupOllM8NGeaQ3SXOm5cCjSBeKcpIn0k9PNzAU=;
	b=PHxPYs25pYGlDrgOuO+bliSKAY8BF+njzgSrr/lF9ZohInEGlcWMK2W1tJL98GfjmpwBNG
	NfmStxhT71YD+mxW48nIzYf9HLLNgIErhBAk8Su5aAuwtYjOYzgnnw8HEzZxJMOYQc5PDt
	CJXwU6Dvmiod++Gnw/mqdZ1/jbDQ/bt7PqRWZ2DStUu61fRrzn4OuaRIGtx5v7Su09ijWm
	HQXHg8gZ1MDhmEoXv9QzllfaYiKpPhwCwcxXIQj603wJf7YLrQ7NLOxGuTmYZiksJB5dtp
	s0ZXpq9U+t/TAtzHGc6YdPywEOeJMCxQfyjpsPd8GQfcW45Z39WRqAY9/2whFg==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Ricardo B. Marliere" <ricardo@marliere.net>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] tracing: convert __trace_seq_init to use WARN_ON_ONCE
Date: Thu, 25 Jan 2024 19:28:18 -0300
Message-ID: <20240125222818.7425-4-ricardo@marliere.net>
In-Reply-To: <20240125222818.7425-1-ricardo@marliere.net>
References: <20240125222818.7425-1-ricardo@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The initialization of trace_seq buffers is done elsewhere and therefore
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


