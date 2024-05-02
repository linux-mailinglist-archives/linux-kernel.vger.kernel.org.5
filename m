Return-Path: <linux-kernel+bounces-166663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 939D58B9DC1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 17:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 345FC1F226AB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 15:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EFAC15B96A;
	Thu,  2 May 2024 15:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DaWTB9xc"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A372B9AC;
	Thu,  2 May 2024 15:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714664891; cv=none; b=tNtHmU+4PnOrF756zJQLhV+V8VSOKTXaJ973aAAXTR4rkZNOnpNZOwx2QDddtGNursPRp6SCMjMk+0bybghBUPouJKo9Z6+1HozyFMLIcU6sMFv9dV2q1q5icU6GqYIvYcD3j2E+ecBNzCa1ryXR3ERRCmvlVwAz7sdCt1WS/0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714664891; c=relaxed/simple;
	bh=qbKd3LLCI57a+tE0ERwDo29E4IaS4mh82bdDEQ7k2N8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TwiyC+PoOcplLed8eZmrLosHfSGE2uUvHE3hbSU63pgu28MAlUDcHlRhA5MhIx3Ie1yZKOgGVT7SDrPcpKyrzS30iEbm4a15x75NgNqjUna6GMUI9V57fCgrVOAzGs2q7pa1B+liN6oi9FqWz+/bpAdZVUAmLh4KvRpnUV1KThU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DaWTB9xc; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1eab16c8d83so66498265ad.3;
        Thu, 02 May 2024 08:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714664888; x=1715269688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aTAQjbijSTWQEIaV5ybn91TeLBRSNY5y14qQhGJREA4=;
        b=DaWTB9xcMnxlwKwvdCUk952Ugr6rbPu95alzA/vT2ifYRHZ1uqk32eZxb9zRRg3TE0
         i/sv2cVgT5pDHKU0k98n9isADdTpBGq/UHZOL6Nbtp1fT8qQK8jgIoW8LWkr3WBVWP0a
         50M3hWSDNcBfMJSzG3AIp7WZztY/raBKqezr5B9MwhMr/ZQzikIb8G5y72FDDc6XoTzx
         6zOOOmNX6ASJAtU0WKQiqtc8xv3q/C6hVIgHe7c6pSsYTYlzsnCxxEq3AlFi0t1KXJdJ
         0zZCaRUqZrWxw1QVZf22eoyZLuL3B9M8qEta11IbSA1AtPlrOuE7HnMObnGIqqbJYljU
         wjfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714664888; x=1715269688;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aTAQjbijSTWQEIaV5ybn91TeLBRSNY5y14qQhGJREA4=;
        b=nSuTtFTAE16/E+hmdol21fDsHHWTS9XRL0odZNXraKsSUKtiIbC+dVxGfR7Oi/miPh
         80NQ84SvMVzDi/KN9mo56V99PzMQb8kAdP3Hz9xYGMOFn8DC7vwXObKJk3rx0RTUpaKE
         pFSczpGABgwz6UAayOdB6q9f/N/S7jwtaxqdVyy9SZEwbvSvU5a1zSiqGhU8A8vni/j+
         /3MvWoX0c7bytpML2P2zO+O1jZfDlwI5M7+vgETytPHuhPojpHneHo+rZACADgkiZcJi
         pbshm1L/TaHzwn9LzrhDbzFmgdAlvtraRYKUwpWG4NbcChNH09laKY1fiyjJbujK8w3m
         zCFA==
X-Forwarded-Encrypted: i=1; AJvYcCWDAXfGBUnl/sG4+M1iRKhM1YoXXaFeWXWUokeZ8x/deLUQIoHhg0oNGzTOzo1pj6imcj5Re2GOWRCHd2eowEDUWGCOFIcihfU3FZ0XDxyZGMEvnzDqZ80GITJWVyuyGSCTdBH/
X-Gm-Message-State: AOJu0Yyjz9T7nfzLEdlGFacqu4aqWl47hTARhzPGcRRjbDKvHhek4qOI
	JIiw5ZK0GgzOLwA1HR/wRnbAy8tsj+wJptLb3ODc8mU05AafhicjrEU5gUaP
X-Google-Smtp-Source: AGHT+IHFKR+2377FgewQ5mX0wr3nAgIqcgoXRyZhHHK8o9Fxa/Hv0+zZZzctwgGBp5i17PRvQ2SUVQ==
X-Received: by 2002:a17:902:b706:b0:1e4:346e:74d8 with SMTP id d6-20020a170902b70600b001e4346e74d8mr19930pls.61.1714664888380;
        Thu, 02 May 2024 08:48:08 -0700 (PDT)
Received: from fourcolor-Home.. ([203.121.254.74])
        by smtp.gmail.com with ESMTPSA id jv13-20020a170903058d00b001eb5a81f688sm1456502plb.221.2024.05.02.08.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 08:48:08 -0700 (PDT)
From: Shi-Sheng Yang <fourcolor4c@gmail.com>
To: matttbe@kernel.org,
	martineau@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: geliang@kernel.org,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Shi-Sheng Yang <fourcolor4c@gmail.com>
Subject: [PATCH] [PATCH v2 net-next] mptcp: fix typos in comments
Date: Thu,  2 May 2024 23:47:40 +0800
Message-Id: <20240502154740.249839-1-fourcolor4c@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes the spelling mistakes in comments.
The changes were generated using codespell and reviewed manually.

eariler -> earlier
greceful -> graceful

Signed-off-by: Shi-Sheng Yang <fourcolor4c@gmail.com>
---
 net/mptcp/subflow.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 97ec44d1df30..0ac8d4850751 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -911,7 +911,7 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 	}
 
 	/* check for expected invariant - should never trigger, just help
-	 * catching eariler subtle bugs
+	 * catching earlier subtle bugs
 	 */
 	WARN_ON_ONCE(child && *own_req && tcp_sk(child)->is_mptcp &&
 		     (!mptcp_subflow_ctx(child) ||
@@ -1259,7 +1259,7 @@ static void mptcp_subflow_fail(struct mptcp_sock *msk, struct sock *ssk)
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
 	unsigned long fail_tout;
 
-	/* greceful failure can happen only on the MPC subflow */
+	/* graceful failure can happen only on the MPC subflow */
 	if (WARN_ON_ONCE(ssk != READ_ONCE(msk->first)))
 		return;
 
-- 
2.34.1


