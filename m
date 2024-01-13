Return-Path: <linux-kernel+bounces-25183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C90282C934
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 04:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F7681C22958
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 03:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D44612E6C;
	Sat, 13 Jan 2024 03:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IAUOSmEG"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A7BFC19
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 03:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d48a8ed85bso16563995ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 19:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705115657; x=1705720457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JLymtwc9H5yinl0KgXVhcfE0CrkBjQrFclqsS4J1/G8=;
        b=IAUOSmEGwZd0bCq/GfJo26LS+sqAGPI428epKv7lh1BCLfLNNNsfnpDJfqz3sSabNc
         twZP3ih2yuuhekhloQ4tBipgz6zp7mk5Szg4fnH7tjmdwT2KVoA30kNPE1Q9pszn92Je
         KZ9gRx7Tk+lYLv474th1+ZmA1ueGfOc4JNYfYBnkAz6KsYZmuSPQBcvgCUR3P+yzP3oL
         S67Mvpm+1JX/L0cKQbn+mnudjeIbhXcPogdKlaqkM2Hb9rfEZi8CoAFHx3eqFWZs67gN
         rsJGguZR+dkhhyFuFBxGCEYQY+i6SI7nyKf3cdrnb6HsLouKPFOYJ3k20bnHieEykzqL
         m3DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705115657; x=1705720457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JLymtwc9H5yinl0KgXVhcfE0CrkBjQrFclqsS4J1/G8=;
        b=CR/ddJXReF7Br63+4t9dAmOsv/JiYIpDbfTESnOSjbLA60cLMx2m/vGazXRL7+p/m0
         nw94TZon9S06esrRJT/coEvg7u/k0Ew5ajwq/wQfff0u4tbk0k6rirQFau7M/lyfya8m
         yAaLXJR9YE2fBuxbbhQKHM6T7WYHsLmiJaY66quPCX6Kv6ZYrYVmPsV83txQK6Wj0h+2
         P0571oa5CQJaYFbyXr/K8lUh9eDjGMgV2EIruRqn+WJFQ49/O1lo8Oj4ZTQdAIAi51Zg
         iA/V/FNJgRIoROyyAtUavCdmejxXG5Jk7/6Ay13YwyNDQbp10tfIOqmScfpf5GBvC9LH
         OWkA==
X-Gm-Message-State: AOJu0YyoPPY4DkOQZCjm3/XGqQzc18zaYLouUoITGtDTvH075prCUC78
	DNaeICiMe+MqdhE1LGI5rQxLQPZcUI8=
X-Google-Smtp-Source: AGHT+IFPg72wcirR0Y8jLSTri8j94yjlsKKkNkkehTPocv2Lf+Jh/Ght75ZG+1mZvCI5tF/rGWCcOw==
X-Received: by 2002:a17:902:c194:b0:1d4:be1e:f197 with SMTP id d20-20020a170902c19400b001d4be1ef197mr3958543pld.1.1705115657246;
        Fri, 12 Jan 2024 19:14:17 -0800 (PST)
Received: from localhost.localdomain ([140.116.154.65])
        by smtp.gmail.com with ESMTPSA id e2-20020a170902f1c200b001d3c3d486bfsm3912551plc.163.2024.01.12.19.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 19:14:16 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: akpm@linux-foundation.org
Cc: lkml@sdf.org,
	jserv@ccns.ncku.edu.tw,
	linux-kernel@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH 1/2] lib/sort: Optimize heapsort for equal elements in sift-down path
Date: Sat, 13 Jan 2024 11:13:51 +0800
Message-Id: <20240113031352.2395118-2-visitorckw@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240113031352.2395118-1-visitorckw@gmail.com>
References: <20240113031352.2395118-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, when searching for the sift-down path and encountering equal
elements, the algorithm chooses the left child. However, considering
that the height of the right subtree may be one less than that of the
left subtree, selecting the right child in such cases can potentially
reduce the number of comparisons and swaps.

For instance, when sorting an array of 10,000 identical elements, the
current implementation requires 247,209 comparisons. With this patch,
the number of comparisons can be reduced to 227,241.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 lib/sort.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/sort.c b/lib/sort.c
index b399bf10d675..fe4efd4a1410 100644
--- a/lib/sort.c
+++ b/lib/sort.c
@@ -262,7 +262,7 @@ void sort_r(void *base, size_t num, size_t size,
 		 * average, 3/4 worst-case.)
 		 */
 		for (b = a; c = 2*b + size, (d = c + size) < n;)
-			b = do_cmp(base + c, base + d, cmp_func, priv) >= 0 ? c : d;
+			b = do_cmp(base + c, base + d, cmp_func, priv) > 0 ? c : d;
 		if (d == n)	/* Special case last leaf with no sibling */
 			b = c;
 
-- 
2.25.1


