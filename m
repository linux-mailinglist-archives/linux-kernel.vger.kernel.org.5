Return-Path: <linux-kernel+bounces-131665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCAB5898A92
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 090591C2117B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C6612CDA8;
	Thu,  4 Apr 2024 15:00:28 +0000 (UTC)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D0D1C698;
	Thu,  4 Apr 2024 15:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712242828; cv=none; b=QhnPNXCMOdcUAMyf3QWh+jqUGLgk3+Qalq6IfcMNf+OaVafKuCVMmBwKvzFOAYnOF6yVWGwZiXex8Yu15HiJk3VcW4kWm3B1pcL3NwDAbkEuhGDqsEFxVhx1PZM3SxJuoFQ3AF12/ewTL24VcqQx8GD5YGh70dlQizEeJTIjd58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712242828; c=relaxed/simple;
	bh=36sh5N/jvpjq6jwl9uDLoGCYQeODe9Y4/Xxq15VmGxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dy59jXNMz9JhiuMWrE135PJSW/TU6xCIjHdyUEqLAauhTBNnagdRuEOSOfhExGonh/0RD3yK5FFCm14Uo2jv9FBhT8KPvi6sgcVISjA1QAUrOBQ/iwvPWXflkY07Ph5VSbvKtvL4tCTEtELZOPtqLmv4ZbPayXbI3eSxXMvxC0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56b0af675deso1246728a12.1;
        Thu, 04 Apr 2024 08:00:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712242825; x=1712847625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xFdhNk5nsJDp0fP+o1jjxdXhOlujveYc4TGfWkAd6Tw=;
        b=uEVuq165XJwzhECe733ybaBBv/yHZXeOxdezMghUt643+sfEjxa09Qv23obL4Sc5DV
         PbmOVL4V/SgP/ddfASOrlYLgWe9zwAzaQ+0lztWgnIWFId/tylVIBimpN5hiIlZQPKvs
         aHafTaAXBb3GjoKjy3HLfRubBsHbGASvlMQBFgrsTrNAYZrRcJ/Y7WaOFWKEaCSrAqIw
         vykUypDxrw6T5LYNkZxr41L+sFuVHAC8caMBibKyBdKOmosisuxp5S+pAQJOd171wtGR
         056iPoLRfh3BuerDRUbdjcqlxwP5dP5ksi8RfiWY/7A0hgXhBqJKOckcibAPgOZt8GXB
         vqmA==
X-Forwarded-Encrypted: i=1; AJvYcCVlFhQuz3nKjTjko/rYnm+kLcgQdmVd1ViIXB7gX+KTbZ4KFCApbtlpI6Vj7UWSTkC/GW9Vf5bdAll3q6B/PDtmfUupXy8p
X-Gm-Message-State: AOJu0Yz02GGbupYWJdZKpgdvf/nIfoaEYl3+Tly+ztNUOsWfrLh43n93
	R5xVxvq2O85C4ETkLCgxJIvBEoMSc/iJaDvm3XAoCBTsn9lwxKF64LuexYdk
X-Google-Smtp-Source: AGHT+IEDoWBCdzLzbTOd4u5qjKtS5pCSs5obUD272vBgv9E+Eua7zaoJAOzGHG7jCtPFrcFlOwfRVw==
X-Received: by 2002:a50:d7c2:0:b0:56b:cfef:b2de with SMTP id m2-20020a50d7c2000000b0056bcfefb2demr6344edj.26.1712242824689;
        Thu, 04 Apr 2024 08:00:24 -0700 (PDT)
Received: from localhost (fwdproxy-lla-120.fbsv.net. [2a03:2880:30ff:78::face:b00c])
        by smtp.gmail.com with ESMTPSA id dh26-20020a0564021d3a00b0056e0b358e86sm1816264edb.97.2024.04.04.08.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 08:00:24 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next 3/3] net: dql: Optimize stall information population
Date: Thu,  4 Apr 2024 07:59:32 -0700
Message-ID: <20240404145939.3601097-4-leitao@debian.org>
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


