Return-Path: <linux-kernel+bounces-135746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C8789CABC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 19:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A08E128A84A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA77614431C;
	Mon,  8 Apr 2024 17:26:19 +0000 (UTC)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBA51442F7;
	Mon,  8 Apr 2024 17:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712597179; cv=none; b=cIm6vMBnbOLnuxzKtHpD4NNIyQjoqVC+Jcp1Hgds6uuxNzU/i/HAYrEKow/ITvXaGwi5E5bihN1Kov7WlDBbGAmJosuaEn9XVam3+MEMPqv1P51krBpSpnvCeHKEJK1LYYecYzfIXBshqO359q6DxBL4qahxw2lqgAZSeGJwIbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712597179; c=relaxed/simple;
	bh=Ymi8vcGeV5U25n5hHY6p/NSyc58XMyU2LXdmqZKED6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KA41IKr0k17UzdvF0EPl2ZwvMx9+iqtu9EjCJTZAjrk7Fb18FWBLe104Q3kda+3HUSMpZ++RwmuYEpwjPbS/0C+EwC21Vipnp1ttdTUEdLaz/4RQc0TVXNWc5aSvLrEXSD4mWFUO3/BvzQpiK/TZgW1/bSPsSHIOIQFVMVxzLJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56e448d6f9cso1021673a12.0;
        Mon, 08 Apr 2024 10:26:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712597176; x=1713201976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G8m6X0YutT7uWn1TO1PGQ+ufRs6DUh470J81GT16/S0=;
        b=cmIE5qQrQjWgxIzwphQ0tAidbQUzzAaTHintib9wLS9W0rDRIMW69c/1Q+cQc7IoCs
         QnXOPu/sbzMe5PJvTDNGCuZIo7Mb3p06EheGLpRbj10uxmplZ0gu4oCEB7sN2Y4NTyo0
         Bt/xvg4hW5ymMRPHWYZSBras+OhveL5wkcV50zFqwPAG6oQZMVqcAeLDbSwPgAcqShiw
         3ByjTjv+R7Z5pVeiucaFmtomAsbpvazqVT7Pq4cZHRBGb5ScKjdPIxD8poICBOsuiGJQ
         rkiLZAa4dQJe6HScl/S+iIafBReBPSKNr0ZSN17HOI7LUv6410wSKXMictspxKU9aUso
         zDhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGe+jq3gKI2OZCuPvwe6xxEH+9w4jl9zVzfF71DBvBKze7L4mx6UYE+D3gzQz2bvdgUs+TlByeu/jEiWKHnz+zwXY4ayAc
X-Gm-Message-State: AOJu0Yy4LkhLrCSQ3JDOrtOohzZ77bTQlP1DhXHUJ6RaUgCxW+qmdlcF
	WrL5SGdIO0ewShn+idsUzzLOwFPDtsGy+KA9Yu6CiRDhQwBOLGl2
X-Google-Smtp-Source: AGHT+IGVzn7W4dxxHSKD4W/Lzeimdl65qF2blvlokwb4FfjVnMdtNOBWixC3tZxzZdy3YL4UGchKKw==
X-Received: by 2002:a50:d658:0:b0:56e:2148:f517 with SMTP id c24-20020a50d658000000b0056e2148f517mr6133085edj.33.1712597175640;
        Mon, 08 Apr 2024 10:26:15 -0700 (PDT)
Received: from localhost (fwdproxy-lla-001.fbsv.net. [2a03:2880:30ff:1::face:b00c])
        by smtp.gmail.com with ESMTPSA id b26-20020aa7c6da000000b0056c24df7a78sm4327079eds.5.2024.04.08.10.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 10:26:15 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v2 1/4] net: dql: Avoid calling BUG() when WARN() is enough
Date: Mon,  8 Apr 2024 10:25:53 -0700
Message-ID: <20240408172605.635508-2-leitao@debian.org>
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


