Return-Path: <linux-kernel+bounces-141527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8EE8A1F7D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 21:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F0FDB28949
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703E61EF01;
	Thu, 11 Apr 2024 19:23:28 +0000 (UTC)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C285134B0;
	Thu, 11 Apr 2024 19:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712863408; cv=none; b=iN5uGrcuXIyVqX33gU3txCH68hcTg8B/RQYJBDNp8HAaM2Jw+x7fZtKTHQiVR7/+WIFbBQKbnll44E9CdQ3MK7IcO+Pi1L5eMdYI/CL0IojWrJYeI5MRIwkkTSMRMEkyM/zjmgzhDpyIeN+AAP/NZX9Mig1gy/3JLEJNvyJeDz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712863408; c=relaxed/simple;
	bh=36sh5N/jvpjq6jwl9uDLoGCYQeODe9Y4/Xxq15VmGxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WreY4DlL/JJObYcBt/xqLUKC6nvvM6Cb76lDO4ZnzIp/VTy/2yIXJLptE0irR4bnjIwbS6+mPk7NvvXwHVaurKH1ViFD1T7eQDOA+w+W/epn9rEZL+PVI3SZEglVJprVL44mCssdlApqQRxQ8yR5NjXte7rooYm1Fip1Q+mkI9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56fead80bacso198820a12.0;
        Thu, 11 Apr 2024 12:23:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712863404; x=1713468204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xFdhNk5nsJDp0fP+o1jjxdXhOlujveYc4TGfWkAd6Tw=;
        b=hAjIAuJxRcDBNV/E8KW9Gy5TEcDDKFP8k1vaGWkC3FSImDNZQLL9vrv51Hd3ubZovX
         SJf0yDfPLsG0RWqnZaGtF1bra+UBB4opMjXARsE7IdP+FlRvmKQ0EqijdvxlB197r6jR
         IurG690u3XyS71/mAhHIVesK5X/9zf80JiVmtV2ygIHGwAj7dfqMAHFfJvHaOmyTbkPg
         ys9DR1VenvLj9ghRmPvwDUa7GnJuqW4CbVFsh5QniEv/1I1fsmO0vJ3tgZXQZdTjWwia
         6eAFzLKjHYvpu9bs5ufpqrNoiL5OrL4zJ/Z6upRa2KCPjbp8GIhQXyn3FNkbU5XyW9zW
         WjLA==
X-Forwarded-Encrypted: i=1; AJvYcCUObvQ140bN6YRmPJgC3y1m/qGfgK74bJeP5b9sp6T2Z3sT7NU+XGVVheDQCvQFxCLUm27JNQwRFjPThuSabR4VeBPn4NLZ
X-Gm-Message-State: AOJu0YwaA0p7jJLR+HbLXVh241x5fJehi8szfVvliCYGzN3RMJMqkRwQ
	WY/rx2aHsERnEd8PwYKD/RAi3RNZXHS+ae1FwE2tPedNvU8iW4CZO3tYaQ==
X-Google-Smtp-Source: AGHT+IFTxVaPDiV/0E34xLIuAe7BAWfYY2dx9Viq/9AT+41JHibEdwYee3rPh8Kzbt0Dkaydg5a/DA==
X-Received: by 2002:a17:906:3292:b0:a51:c720:5107 with SMTP id 18-20020a170906329200b00a51c7205107mr491692ejw.22.1712863403759;
        Thu, 11 Apr 2024 12:23:23 -0700 (PDT)
Received: from localhost (fwdproxy-lla-004.fbsv.net. [2a03:2880:30ff:4::face:b00c])
        by smtp.gmail.com with ESMTPSA id rs6-20020a170907036600b00a4e6626ae21sm1027945ejb.0.2024.04.11.12.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 12:23:23 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v3 3/4] net: dql: Optimize stall information population
Date: Thu, 11 Apr 2024 12:22:31 -0700
Message-ID: <20240411192241.2498631-4-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240411192241.2498631-1-leitao@debian.org>
References: <20240411192241.2498631-1-leitao@debian.org>
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


