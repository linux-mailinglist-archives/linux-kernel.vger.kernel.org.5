Return-Path: <linux-kernel+bounces-106021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7E187E7BB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1A62B22D4B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045AC31A83;
	Mon, 18 Mar 2024 10:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="vxCL4z8Z"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED5E38DF2
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 10:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710759225; cv=none; b=N0pOZVlfz6fVx+DhS2BCKj3VNDziL8pBFW18eEeG2Gqzna06NVl1Sg9UW1HMUw9UH6GDPn93z7aBSeyL7J91WzOH7g1AKvGVwTec8fAGO3Mrd4khSyJkicX7WcJ+S3H1LaUAAxrVjnwNhgkO9a5hcwkcF1nm+Gvbg1k0uCiHWzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710759225; c=relaxed/simple;
	bh=XhvyBK8RuxD5Aa0izhkt9Ci2OFjxet20Xsv0wYg085w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MWah7g4M06CFjvjfxLJYo5vo7ZPmH4YnSPGo8igGK6ZLScgUq4q5JeLMRaG2h2K6CT5Om9mRPHIo8d3hKNwg0axseORc8gLocG3+e4ShKNy2EQhMEvSPv/ZSkXjBAQ0rtGL34Sx3p58cRxasPpdOYftbdkt/b+5YS7jUpxehG0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=vxCL4z8Z; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-513e10a4083so1894183e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 03:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1710759222; x=1711364022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8XqG2x/M+BHVWmsybR9voBPoGJqnviYlltRdmFVnhHg=;
        b=vxCL4z8Zz+RPK08OJfwtsNI69yzftiLXolj3IgDqIZ2adfnMtyp+MRXKdHGcUthY4X
         pJIbOUULQVgQJKVnlGhZBcYueeCx0vrzto0OBZ8S/AWRUbP/q+fteE7IRXHbrR1iUiiS
         wQFVvEhbqrDRFIVD+SKex+MBUsrCxJCKI/iCjgbocz5X0fmslBgsIKetJbH7n2MkJT+q
         8YY3NNUrMmnj3I6mbbyYDytpnpLrDO3DdpemePM++azlnUYlzmWvfTX4kXy8uC+d4BVb
         p1wGpfV+QDlYg5TuMUos/Bf+GPM55g9xDGpFg4eygjOS5TyDECaUeXC7BMdAdyH7E3zA
         7ssA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710759222; x=1711364022;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8XqG2x/M+BHVWmsybR9voBPoGJqnviYlltRdmFVnhHg=;
        b=jMFYfdGJUluu6HSqVOk74mv2hsZWns1VE6HvXZxKK75+PMnSXDn1dPx/95tXySLURl
         d8kiopdYkvtaFnMPcY8MmgNDBwfxRuFtnhKwPNbF/QUEGJ4TiIf7MFbONgAsVUk1Jq2u
         o0KJlGN/uM56QCtAfakVCUGT9MSTX+UvduBP0NGYc1pDtfr491DYnEarBqn0xvprcnpK
         roXVbiv4uSxma2S2TW6rlTK0PBObC3nWXMWhE1wdVLML8U4vvBAp1LSAct0NN8SHO3Cu
         2Ij1AKiN0lhtW1f8lazp6Xb7s6DNjoQTwXTfZuteVSWygoC+vUotPSRt+QGBZhOSdWXM
         h3+A==
X-Forwarded-Encrypted: i=1; AJvYcCWmw0wF+fe1PnyhYMnctKxEiMlNbPCzuDWdBrumyvE3xNLwP4nlHVuuiuCZub8UEUmnyRQv0MnxzHAw2g9B6gUlkNs1VUZhOImLrNVS
X-Gm-Message-State: AOJu0Yy8pcCVgSxf3gwTOrM4L5yFHGsISWc3ihWdgsDg+dWY/GBIvAIU
	J51KVzXUgx/wPWHLDeQDZScwO5eawRTmPb8+HNkXMGQH/Q7qMDRKJEqe9KNIhDA=
X-Google-Smtp-Source: AGHT+IGHB5gHClxTzaPri9vHfioAkOsY7ktzCLS7y8Ff5PRJViyHNbO7xTE9ZiCC4tYmAwqZCG7Rgw==
X-Received: by 2002:a05:6512:28c:b0:513:cadf:ef0c with SMTP id j12-20020a056512028c00b00513cadfef0cmr7852924lfp.18.1710759221771;
        Mon, 18 Mar 2024 03:53:41 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-212.dynamic.mnet-online.de. [82.135.80.212])
        by smtp.gmail.com with ESMTPSA id h7-20020a05600c314700b004140c161e8dsm4871932wmo.43.2024.03.18.03.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 03:53:41 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] tracing: Explicitly cast divisor to fix Coccinelle warning
Date: Mon, 18 Mar 2024 11:52:44 +0100
Message-ID: <20240318105243.117911-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Explicitly cast the divisor to u32 to fix a Coccinelle/coccicheck warning
reported by do_div.cocci.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 kernel/trace/trace_benchmark.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_benchmark.c b/kernel/trace/trace_benchmark.c
index 54d5fa35c90a..218b40050629 100644
--- a/kernel/trace/trace_benchmark.c
+++ b/kernel/trace/trace_benchmark.c
@@ -105,7 +105,7 @@ static void trace_do_benchmark(void)
 		stddev = 0;
 
 	delta = bm_total;
-	do_div(delta, bm_cnt);
+	do_div(delta, (u32)bm_cnt);
 	avg = delta;
 
 	if (stddev > 0) {
-- 
2.44.0


