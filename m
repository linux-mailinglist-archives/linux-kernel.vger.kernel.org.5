Return-Path: <linux-kernel+bounces-33971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB08837117
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54B841F2FEC7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6290948CE5;
	Mon, 22 Jan 2024 18:20:18 +0000 (UTC)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAED48CC1;
	Mon, 22 Jan 2024 18:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705947618; cv=none; b=MSxlperlKeMrdG3hhkyseGc+3IeKxm16JKFJporTthnjZ/CGVsBhm7pbwuc6yWJTzsO4/4Zn99YakJYy1VyxwLiztw/nn1AkUZWLZKndPLjkx7jIhJFn5UkfB9cMEMp2jpyw2+fJ4fnyhuy+EkM++8aikBg4ubHCCBu9uVdIPXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705947618; c=relaxed/simple;
	bh=fO8d9tnM/b00ZzSrlRFa+u3y4+RuOcJHLfEK8HLZOmE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gKUzSlkNQea0klDt1FPvcaFdYYF52Wua+yzRYT0emch16UBJJ8jqO2Bl50FQ2R8AmRLx3erLoefvRr9JZY/6CG3mANt60naqimYtugHrcNnDUt3WHjeDI9mamyGvue7I1yLute01gmlDgLfnsK/8WC2B3am4yA+iX/tnyOk8Vp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a30a99c4609so5007866b.3;
        Mon, 22 Jan 2024 10:20:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705947614; x=1706552414;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oHQiJArxhEDiYF9vfsCM7KOtyVpo0yUi/Ps8Ebj0XGA=;
        b=sVdY+/2gb2SxaP6TiFnDr4TOUwJ6vJDwHLq9+SFyvQSox0MOwdkcjBuaYz6z2b7HTC
         EqNWtN03IbJno6/HELdVwE+upbQNZftHQnokjzg7L9Ndey5uE4UbnQJ/Go+Zv3tvrHwo
         5tOmsNAKw0/T5i8cA5ZRpZwtjdVDddpRwMpcxIn01DiMLq3ntDVhyaSxLbHhkw2p39N2
         uUy81R6aMqHnGI38n1Dil/hWmDmWycEBpjgw3sTLP8dncIySGsPgU5R0lFr71/62VOlu
         5ZTltmEpfwXZO4MPrEJQVMy2A6yolxpNxVPSPCMo5euGYBpKSrBAXNVPSVpUrQ28Ec6c
         OwSw==
X-Gm-Message-State: AOJu0YzTSeVZ/iVe4/+hO442LrpFj6xLRsINXXMd2/LAPaQ1rj10E9A6
	hUeLCN7FS6N0OBwS8oBqzRFWuNORCI40rDUn9xNZOJWWnYuy/HoI
X-Google-Smtp-Source: AGHT+IG23DhgS9N9orl4p3jFIea+uwHnNNgHNMuVYWosRKCJ+3ptL9E+ayEqsFhJHllDaCv18M2fuQ==
X-Received: by 2002:a17:907:160d:b0:a2f:b9be:66b7 with SMTP id cw13-20020a170907160d00b00a2fb9be66b7mr2919805ejd.34.1705947614283;
        Mon, 22 Jan 2024 10:20:14 -0800 (PST)
Received: from localhost (fwdproxy-lla-006.fbsv.net. [2a03:2880:30ff:6::face:b00c])
        by smtp.gmail.com with ESMTPSA id wr8-20020a170907700800b00a2e08b24ea3sm8961483ejb.174.2024.01.22.10.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 10:20:14 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: dsahern@kernel.org,
	weiwan@google.com,
	kuba@kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: leit@meta.com,
	netdev@vger.kernel.org (open list:NETWORKING [IPv4/IPv6]),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH RESEND net-next 1/2] net/ipv6: Remove unnecessary pr_debug() logs
Date: Mon, 22 Jan 2024 10:19:54 -0800
Message-Id: <20240122181955.2391676-1-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the ipv6 system, we have some logs basically dumping the name of the
function that is being called. This is not ideal, since ftrace give us
"for free". Moreover, checkpatch is not happy when touching that code:

	WARNING: Unnecessary ftrace-like logging - prefer using ftrace

Remove debug functions that only print the current function name.

Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: David Ahern <dsahern@kernel.org>
---
 net/ipv6/ip6_fib.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index 4fc2cae0d116..fb41bec6b4b5 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -751,8 +751,6 @@ static struct fib6_node *fib6_add_1(struct net *net,
 	int	bit;
 	__be32	dir = 0;
 
-	RT6_TRACE("fib6_add_1\n");
-
 	/* insert node in tree */
 
 	fn = root;
@@ -1905,8 +1903,6 @@ static void fib6_del_route(struct fib6_table *table, struct fib6_node *fn,
 	struct net *net = info->nl_net;
 	bool notify_del = false;
 
-	RT6_TRACE("fib6_del_route\n");
-
 	/* If the deleted route is the first in the node and it is not part of
 	 * a multipath route, then we need to replace it with the next route
 	 * in the node, if exists.
-- 
2.39.3


