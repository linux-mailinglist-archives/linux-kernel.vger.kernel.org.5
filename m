Return-Path: <linux-kernel+bounces-141525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CFB8A1F68
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 21:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ED3328446B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE9017C67;
	Thu, 11 Apr 2024 19:23:20 +0000 (UTC)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9F617BA5;
	Thu, 11 Apr 2024 19:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712863400; cv=none; b=qb4+Cnfm2v3vknQ9CL2LgIMTSvklbsnwKsZssBSxreuqO2vT5ouSBe8MpdedKj7HeWZGOQ+tqM7Sfibn45+7GXwAi3YWf9TMOqJLWrgBw/QGprjyiyC4P3Q1MdEi4PP7BEdJCt4qWLhcSkyiplGXonN3mDhfgd3trivJ+Gca5Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712863400; c=relaxed/simple;
	bh=Ymi8vcGeV5U25n5hHY6p/NSyc58XMyU2LXdmqZKED6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eGS3MUspYOcdfRFGyBAV8G0fngv1TeecPgpdxNvgmZ68L4+zgEqKXEgCd5XFCENNb309AjHoKnJfllY1bkBLNN2OfpyB4saqZf4o9k0733to6qDZk3y1vIqviINUl3boe9D4bOMl+QTaX1ent3Up7FrFGY31IoFxwq924rP/UFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-516d536f6f2so193202e87.2;
        Thu, 11 Apr 2024 12:23:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712863397; x=1713468197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G8m6X0YutT7uWn1TO1PGQ+ufRs6DUh470J81GT16/S0=;
        b=HKL1P5zEn7W7xwIyAj7kDpV6dS84g8ifaeyj3/1J7KFlH1u83Q/JixQbXslOppjk/z
         BnGYwiMq6iIdSIrgL3Es8swzipGjJ2Zxt/Omgm8K1fDUgx86kdguQgn089ODfQOV8wV9
         Ccimp3Id1boD3v5L3nr30u4u2Bk7TQyD46GDCl7HyEycxNN8SXJz+2ryKTnmN0LA65Ws
         GMxlveDNKB5cL4JeQe6X7sYyCMGmWF4GPOsusxZ/HqDueSsROGgXdqH3YsALWpy9JQla
         F2G0/h7EbdfHPHFwwOQWnC5dcFEAv5eVrCwCVoGsFhYOSo49cFHJ8kTIPq86SAXYu0af
         BQnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlLiCBfMIUPyTjyUHF/zUj5GpcDUG2QXe0bxRsdfgYK9XHuS+oReAMMwmy4K5+WlgbwypdAVgG2L8PymCTH9DtqGT+uJNj
X-Gm-Message-State: AOJu0Yz4BLi3Xf4yikxFlu7DIp+70LaRrX97LalKwVXvdVNCCCSMM12R
	gvX2L6rIQUGNal2dxSP7iaXWvtqqKCKbDZ2rZzZUCOlCB4jfawF9
X-Google-Smtp-Source: AGHT+IFEK2Wfqx5XDgZrycIj/QUR1Ldag37mqz5FG4t4KvnVqFSYp/J133+dSXm9gJDoRtxEh/bxJQ==
X-Received: by 2002:a05:6512:3d02:b0:516:d444:b26b with SMTP id d2-20020a0565123d0200b00516d444b26bmr632560lfv.46.1712863396852;
        Thu, 11 Apr 2024 12:23:16 -0700 (PDT)
Received: from localhost (fwdproxy-lla-005.fbsv.net. [2a03:2880:30ff:5::face:b00c])
        by smtp.gmail.com with ESMTPSA id my48-20020a1709065a7000b00a518debfd49sm1021740ejc.116.2024.04.11.12.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 12:23:16 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v3 1/4] net: dql: Avoid calling BUG() when WARN() is enough
Date: Thu, 11 Apr 2024 12:22:29 -0700
Message-ID: <20240411192241.2498631-2-leitao@debian.org>
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


