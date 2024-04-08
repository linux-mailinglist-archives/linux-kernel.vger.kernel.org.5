Return-Path: <linux-kernel+bounces-135749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B067589CAC2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 19:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D46491C2399C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B77146007;
	Mon,  8 Apr 2024 17:26:29 +0000 (UTC)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88921448E6;
	Mon,  8 Apr 2024 17:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712597189; cv=none; b=qURnUt6rqfVpzNCe06VLjdWtVeHlRISXbK9oyedjxsuaSp5fh7KGVYeAmbxCtRvoR72TtZP5a4ZKPTPkg5G/LlGbSSqOKqeICQ5Bun1WQQK0yCUeh5P9tV6ue26KPvHsgbKkYNgz5xuB4i49/zvI9DXex6UGSDMOBJ2Lnyrbp0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712597189; c=relaxed/simple;
	bh=BB6xdcqBBRM0M9Ry0QYPtGpccU8xNKpU0XluHoHcNZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YL7Rcz+5CN2y3BYcnKcHJ7uqk0UDJHymuB9Y+smsR0+moKWXX+/D+xuChAu8b2mWacGP7WMrwzKRixlcGZ85c2i5mErhN9qEE4c/JfZjj35SOvdHzA39El/0frLu7xhVa32fWI74M7b2UL3+lcs4rz7hs0HpfQnEVTfcB8YY870=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-56e346224bdso2829746a12.1;
        Mon, 08 Apr 2024 10:26:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712597186; x=1713201986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3GvozmrLkyQGC20P7bfv/jYd6/SqOcwnOpAWpJop5SM=;
        b=hR7YCcRgO5Daa4QdxJ788HQOrma8neTHfgybb/5ReWl0DtAkusRSm2P6ugAxy3cXkZ
         9+V7dwgupJSMjxCw7zi1tlmkf5TlFofSit6O8IKkhGDZkPCSGWxhlYUsGet82e71xZj2
         wrt3ZGp+3AFp8ZAV1znLwg3zJ88AW9hmsI/bvb2VSj1oNI8OK/r6I98+cpkF5mf+Ajj/
         O5VfZOCbOGRFYMrGUaIlM3C4wZEbskJpgXFgWiqbLT8y/ycGc8MQgCtM3dEYmJnhLbe7
         pw7cjBp8etPOtM17u8VlCcPSvXMTIWigJCz+U4M+fqAeBz4nb5V4GF0VapLrv3ReOMRQ
         a5eQ==
X-Forwarded-Encrypted: i=1; AJvYcCXC1CrHOn4jPTj6hpyFqUjr6XnUqc9y1xJhrlVD10pebz1KzXX5eMUOlwpjJWrtdQZCVuV3XnrJTwgmAOwN0PgdvqRY2wc7
X-Gm-Message-State: AOJu0YzqTdtQ/Zd9euBL9DL3DkZ/mmHrp0DbYHNpu/aLv1ShF8+Nv7Y2
	h/iDRUd5h1UMpQ4UP7thl3R893+24CTvnZnvtGwDLo+hZJN2Iy0K
X-Google-Smtp-Source: AGHT+IFYUbY4WZ/0ZBQpTqBC7RgrqLxqyOCgqu18pEEv4vjQdy70C9zgi5iIe95NEx65Yrgy3HJQzw==
X-Received: by 2002:a50:ccd6:0:b0:56c:5a49:730 with SMTP id b22-20020a50ccd6000000b0056c5a490730mr6862966edj.19.1712597185851;
        Mon, 08 Apr 2024 10:26:25 -0700 (PDT)
Received: from localhost (fwdproxy-lla-120.fbsv.net. [2a03:2880:30ff:78::face:b00c])
        by smtp.gmail.com with ESMTPSA id q18-20020aa7d452000000b0056e247de8e3sm4311465edr.1.2024.04.08.10.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 10:26:25 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v2 4/4] net: dqs: make struct dql more cache efficient
Date: Mon,  8 Apr 2024 10:25:56 -0700
Message-ID: <20240408172605.635508-5-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240408172605.635508-1-leitao@debian.org>
References: <20240408172605.635508-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the previous change, struct dqs->stall_thrs will be in the hot path
(at queue side), even if DQS is disabled.

The other fields accessed in this function (last_obj_cnt and num_queued)
are in the first cache line, let's move this field  (stall_thrs) to the
very first cache line, since there is a hole there.

This does not change the structure size, since it moves an short (2
bytes) to 4-bytes whole in the first cache line.

This is the new structure format now:

struct dql {
	unsigned int    num_queued;     /* Total ever queued */
	unsigned int    last_obj_cnt;       /* Count at last queuing */
..
	short unsigned int         stall_thrs;           /*    12     2 */
	/* XXX 2 bytes hole, try to pack */
..
	/* --- cacheline 1 boundary (64 bytes) --- */
..
 	/* Longest stall detected, reported to user */
	short unsigned int         stall_max;            /*   100     2 */
	/* XXX 2 bytes hole, try to pack */
};

Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 include/linux/dynamic_queue_limits.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/dynamic_queue_limits.h b/include/linux/dynamic_queue_limits.h
index 869afb800ea1..281298e77a15 100644
--- a/include/linux/dynamic_queue_limits.h
+++ b/include/linux/dynamic_queue_limits.h
@@ -50,6 +50,9 @@ struct dql {
 	unsigned int	adj_limit;		/* limit + num_completed */
 	unsigned int	last_obj_cnt;		/* Count at last queuing */
 
+	/* Stall threshold (in jiffies), defined by user */
+	unsigned short	stall_thrs;
+
 	unsigned long	history_head;		/* top 58 bits of jiffies */
 	/* stall entries, a bit per entry */
 	unsigned long	history[DQL_HIST_LEN];
@@ -71,8 +74,6 @@ struct dql {
 	unsigned int	min_limit;		/* Minimum limit */
 	unsigned int	slack_hold_time;	/* Time to measure slack */
 
-	/* Stall threshold (in jiffies), defined by user */
-	unsigned short	stall_thrs;
 	/* Longest stall detected, reported to user */
 	unsigned short	stall_max;
 	unsigned long	last_reap;		/* Last reap (in jiffies) */
-- 
2.43.0


