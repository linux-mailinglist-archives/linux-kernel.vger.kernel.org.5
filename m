Return-Path: <linux-kernel+bounces-135748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A4C89CAC0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 19:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 107301C24A2A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B248145348;
	Mon,  8 Apr 2024 17:26:26 +0000 (UTC)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B40144D25;
	Mon,  8 Apr 2024 17:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712597185; cv=none; b=bvhP6m1+1x8ysgDEOWg6uzXC33yahYlre2uXDnMLQBvNePMYuymtttb2CiwVH6Qw+YJp+xTFF3Jv+tdgEVHdU7WYjH6nIKmSmd7DMhK3wLt6M2D0/M//O1FBegIwH3QjqppyDhJRFwGc+E1Zp+AxZnZKXzWW6UitRs/H/7lRsHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712597185; c=relaxed/simple;
	bh=36sh5N/jvpjq6jwl9uDLoGCYQeODe9Y4/Xxq15VmGxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m2GRsqddBPi4f3Rdx+AeZ3SSuSFtNkPxWZbRS8D74txJXCdj8cgq24MzaIevbjn9kskR+/4UDglJBCKt5CeD9IXxop5C00/qVJYOh9jO9ht1OKNWDOD5lFRssGyukiEnS1lqwgHhNUczMNSQrYueYBrNyGqECuCj3hwFebgsmNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-56e1f3462caso4842659a12.3;
        Mon, 08 Apr 2024 10:26:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712597182; x=1713201982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xFdhNk5nsJDp0fP+o1jjxdXhOlujveYc4TGfWkAd6Tw=;
        b=NOQvsuMKInzZPBggOCNCNiRbhEAhM20w39RKeFYahie66OHMFUezMEDThYIEVNMfyS
         YcmYnpg3MIMh0UuI2reYvUfSKQ2/uDjIYeBbAxea6UERexeAeBt0X2VxYhx35IqDvK8o
         DhUza0mft4CpMR+an2MGu+BsknLvTuMpyq9EDw5AwDODYI1l/yD1AZmPiQk3oUaaks1k
         tpFQgMbtRrJieIJ6kHPgxHTM4HHSJ+3u1VLaLssmQskhWE0X+RNs9piS9ejammLMneAq
         UQdt8wYtr7NX50E4R1BXaizvpxrpcanUs7qPQYtzVThptMwOyQDIVzEBKYlH8xh4BPtr
         MdfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWh6YW9Ol+f5mMl7FC0YOeGMb0NrX/SZyzNslZVqtnvZn6DBIvPHwuxVncPfn8foDPuCg00bwqfSwrea4bkxipKYibbxqCP
X-Gm-Message-State: AOJu0Yx7poLWq/xQGU5rfO1XIO8uWNzfv8CYf/BGV6FM2carAbliQIyw
	hNRED6xOnLohzUCiG996AkCRDXftmWjAqYu4PX+rcBlRS1DUtFAs
X-Google-Smtp-Source: AGHT+IGWKqS0JTk/6lc5U817a4zP7AwTzEeUUquDYyq4dn2ZcNXJZoucuBugalkmndxMZJkGgavR4A==
X-Received: by 2002:a17:907:7ea2:b0:a47:16d1:113f with SMTP id qb34-20020a1709077ea200b00a4716d1113fmr8250630ejc.47.1712597182466;
        Mon, 08 Apr 2024 10:26:22 -0700 (PDT)
Received: from localhost (fwdproxy-lla-006.fbsv.net. [2a03:2880:30ff:6::face:b00c])
        by smtp.gmail.com with ESMTPSA id gx26-20020a1709068a5a00b00a46b4c09670sm4695689ejc.131.2024.04.08.10.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 10:26:22 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v2 3/4] net: dql: Optimize stall information population
Date: Mon,  8 Apr 2024 10:25:55 -0700
Message-ID: <20240408172605.635508-4-leitao@debian.org>
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

When Dynamic Queue Limit (DQL) is set, it always populate stall
information through dql_queue_stall().  However, this information is
only necessary if a stall threshold is set, stored in struct
dql->stall_thrs.

dql_queue_stall() is cheap, but not free, since it does have memory
barriers and so forth.

Do not call dql_queue_stall() if there is no stall threshold set, and
save some CPU cycles.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 include/linux/dynamic_queue_limits.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/dynamic_queue_limits.h b/include/linux/dynamic_queue_limits.h
index 9980df0b7247..869afb800ea1 100644
--- a/include/linux/dynamic_queue_limits.h
+++ b/include/linux/dynamic_queue_limits.h
@@ -137,7 +137,9 @@ static inline void dql_queued(struct dql *dql, unsigned int count)
 
 	dql->num_queued += count;
 
-	dql_queue_stall(dql);
+	/* Only populate stall information if the threshold is set */
+	if (READ_ONCE(dql->stall_thrs))
+		dql_queue_stall(dql);
 }
 
 /* Returns how many objects can be queued, < 0 indicates over limit. */
-- 
2.43.0


