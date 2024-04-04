Return-Path: <linux-kernel+bounces-131662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4547E898A8C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBAD81F28E78
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90C8129E92;
	Thu,  4 Apr 2024 15:00:21 +0000 (UTC)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6B684FC8;
	Thu,  4 Apr 2024 15:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712242821; cv=none; b=KOtc4m0F8zT++UxjFkJ9IJlrz4ACDiWCZ98CGpMyN6ntfUqEuzi2rfafICO+xgwqOdD6oYhTsty90znt7ibKH87vW3CsHB9EYGPJxsjE/xGiBSy38YgyR9YEkrirKMpnESJbc2RmhlgvkLalWWmKOIdWoc1oF+42wqkt6cOwdNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712242821; c=relaxed/simple;
	bh=Ymi8vcGeV5U25n5hHY6p/NSyc58XMyU2LXdmqZKED6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RLawcU2A8v6b1Hv4vaW32Q4sbwBihdxWxmfCR2CBi3jF4TAVeTA1hwe6b9VRfmqU81Al1KMeVEiWIfWE/nJ1cR0YKwnV1TurPwSjglMTz+duMmZSxzZM3wiMKRKwQ/tGHVfzIqjfa15Xbn2II8Udga5ekZY4RP3FR0SA+3zCMHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56dc9955091so1217977a12.1;
        Thu, 04 Apr 2024 08:00:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712242818; x=1712847618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G8m6X0YutT7uWn1TO1PGQ+ufRs6DUh470J81GT16/S0=;
        b=wtDzYLEQYJH/LQEbm0HXSvz8SBAecrk6qp13NZoWLfLBLJxNHOZNA5uFVg7ug7WDMm
         ZKiZWjzuNN8Sz4gg11qD/H8tzR5z8+WzP/BsOHgyY3pRvP6x6DU/xLJrong8/7fYD2Cf
         lu6ky1CqbM5CjkEMPaWaKPUA0OB/t78t9siQtIU7qF8y8PaPmK28OdfkSocbAbR0lUpN
         1GbM34FS/ZWm5bfTqIgDI+QFuoZkhg8BIljsY1Je0VTwb9+c1LWLpIcZpg7xrcR+EhC/
         ddDlvBXS/3XYUHNF/t+T54ZChVGUpZqbwYf7JdZQZ1ne9Tg+/KHvhgr+rLa3oNQ1Gi6k
         IQLg==
X-Forwarded-Encrypted: i=1; AJvYcCUT4l2FY+6oQTKjxfcqublV+8f4CDKqDEWy9skxMxkXxQSu5hGOY+AIG+nUjzk5js3l79yaqGI6XAycfUaqVDFJ9QqdvYPK
X-Gm-Message-State: AOJu0YzSDOAK7jLz1SzvodKThnJ9n+KJTEAuAJfC9soqLJ8P6aTT/InU
	bIzjdOsS5APwVmdJ37nKSoLDpBHaay9ch6TYaDE4OkJavuoeVPiQ
X-Google-Smtp-Source: AGHT+IHgDrnndNGS/O8sTH9X+a/XG8RQw4LgcBa9WQKWpxnotxgmsHK9x5rs98HA40BLOsNiHRoIqg==
X-Received: by 2002:a50:d6da:0:b0:56c:4e2:5a4e with SMTP id l26-20020a50d6da000000b0056c04e25a4emr2050522edj.1.1712242817595;
        Thu, 04 Apr 2024 08:00:17 -0700 (PDT)
Received: from localhost (fwdproxy-lla-001.fbsv.net. [2a03:2880:30ff:1::face:b00c])
        by smtp.gmail.com with ESMTPSA id p12-20020a50c94c000000b005689bfe2688sm9311362edh.39.2024.04.04.08.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 08:00:17 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next 1/3] net: dql: Avoid calling BUG() when WARN() is enough
Date: Thu,  4 Apr 2024 07:59:30 -0700
Message-ID: <20240404145939.3601097-2-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240404145939.3601097-1-leitao@debian.org>
References: <20240404145939.3601097-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the dql_queued() function receives an invalid argument, WARN about it
and continue, instead of crashing the kernel.

This was raised by checkpatch, when I am refactoring this code (see
following patch/commit)

	WARNING: Do not crash the kernel unless it is absolutely unavoidable--use WARN_ON_ONCE() plus recovery code (if feasible) instead of BUG() or variants

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 include/linux/dynamic_queue_limits.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/dynamic_queue_limits.h b/include/linux/dynamic_queue_limits.h
index 5693a4be0d9a..ff9c65841ae8 100644
--- a/include/linux/dynamic_queue_limits.h
+++ b/include/linux/dynamic_queue_limits.h
@@ -91,7 +91,8 @@ static inline void dql_queued(struct dql *dql, unsigned int count)
 {
 	unsigned long map, now, now_hi, i;
 
-	BUG_ON(count > DQL_MAX_OBJECT);
+	if (WARN_ON_ONCE(count > DQL_MAX_OBJECT))
+		return;
 
 	dql->last_obj_cnt = count;
 
-- 
2.43.0


