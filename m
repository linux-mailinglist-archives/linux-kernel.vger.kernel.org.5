Return-Path: <linux-kernel+bounces-140153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D328A0C1E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 530AA1C2382E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AAC214431D;
	Thu, 11 Apr 2024 09:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jWkNwXT1"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B8A143C51;
	Thu, 11 Apr 2024 09:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712827029; cv=none; b=MhbBQ2RFfywttCpCL0h/3+JtxcH8OxbE3TvrmmxpzlQNE9B5HTeHWIkb5Rii97QxzjC/jpPB+6XG64co554c+n6nVSSkWFBnC5eUoTnmCPjHZePCfGa2Q/bwhSkIr5nl3sWw42EpxHi26O54HKem2q050XWMzKjLUXeaDk7GoJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712827029; c=relaxed/simple;
	bh=2syYPClYSp9LRVX4/oUCM4ZbsrvXWU1ybAOzeY9Qd2E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=VbzfSiThQmMkl4x4VP0tPjH3TCY/n7qsdlxVAxH+u3nVOZMV8ql6e6S1k4E5+4DXHMv6GEoGSh8GspJTlki56iWzYKWUE7JMPREzpWxsZZaOy63DzAp4YDX65CDZavifdsLsH5MqZtEfJbNGR5ybUe8eXiMLQIWvuseNWnqmrJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jWkNwXT1; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-516d727074eso7414064e87.0;
        Thu, 11 Apr 2024 02:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712827026; x=1713431826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FzBEVk0HW76GLGB3lVYaqyPSlW2zjUkEkvFNmqFhr9w=;
        b=jWkNwXT1vnYE37l0WVNMwK82XLpuHZ/vzpG5+D3W22+/miO7uPEciT8x+g5VMe7lkv
         o2FOCcVeWvh9D5Exto5aZKr625rHz3M5ysqbHpiXDQlr1Fz/KDV/0I/MrMdMckQN3DSo
         QeXbzj51TP6vXQWzAAX94fSmx3jvY9/fbgsnYBilOgaZbpwFmr2ECbVIRRX0ENW/wToz
         1+Y0O6QJuXSvjwRygE14A/6NE6MkmgFPFfL39ZlKmJuonw72OQ3vh23yMJoNjTKc3ui8
         PTTkpFTTlPVg6YZpCWewIKcXboB/laDto0Nt5dpNcL07AoTWT6CK1IPoOvEpxd/xL41I
         BIxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712827026; x=1713431826;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FzBEVk0HW76GLGB3lVYaqyPSlW2zjUkEkvFNmqFhr9w=;
        b=wTiIQZ6Zrr8SJUs9AGZTQSPWqMz3OIkgINAq59uCpHlIUMvhO24kqn9kPh6gQdBL9n
         CsGeQV2ikGPEks4TArpVg8s0VmYq9XYyJrNllmi3pHkExlo6tgm7xEnCiZ12seih6Ef/
         3Ggti2EvCcOvtr7u4sNUD/hIlyu4psA3g2a7ALLhI0ART2BsU66anKlUFtuaBFGOEWgn
         udQbhAsZrxJs1pNTG6u5akLGLPLgTFrG+bN16aJV1XzWBt5c+D6A4BkPHHRdlNh5XwCS
         V9ww13BN/HimAof418e/S2CVZK9xeDuHAD4Qv772XPrrjgQ9aZuY2yJz8fFtvzHZmmSs
         T8rg==
X-Forwarded-Encrypted: i=1; AJvYcCVDwoxvcXMtWpDYAB5CpaCPT4yrSN+1G2LcsKvAIoGgLcsEQonFTBb7/IRi/wH1I2VKuoUuvHPlSHvZkD4496KdevHS+2zJmYwAi2LR+ldgyI/YKEJLluviTe8EcRyz1J8X3ZpA
X-Gm-Message-State: AOJu0YwLv9MvPrTvrEAIQxQbmy5HpMKAlsRbAV5eysFGu1U4qaIn+4ga
	aXkTE21RAwIjejMfLIQX7afiRo94GiINKL5BndmASpyxxIf8mZvYi0jRnF8b
X-Google-Smtp-Source: AGHT+IFquHk0icIe7gA89smDZQv78rcQ3Av1zWeYeS+HxuiU9dGbqT1wEiIRM8hbwuVmU+uAto584g==
X-Received: by 2002:a05:6512:3c89:b0:518:6ea2:a2a3 with SMTP id h9-20020a0565123c8900b005186ea2a2a3mr16840lfv.54.1712827025767;
        Thu, 11 Apr 2024 02:17:05 -0700 (PDT)
Received: from localhost (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.gmail.com with ESMTPSA id p5-20020a05600c1d8500b00417e227f40bsm596853wms.3.2024.04.11.02.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 02:17:05 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Jon Maloy <jmaloy@redhat.com>,
	Ying Xue <ying.xue@windriver.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] tipc: remove redundant assignment to ret, simplify code
Date: Thu, 11 Apr 2024 10:17:04 +0100
Message-Id: <20240411091704.306752-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Variable err is being assigned a zero value and it is never read
afterwards in either the break path or continue path, the assignment
is redundant and can be removed. With it removed, the if statement
can also be simplified.

Cleans up clang scan warning:
net/tipc/socket.c:3570:5: warning: Value stored to 'err' is never
read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 net/tipc/socket.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/tipc/socket.c b/net/tipc/socket.c
index 7e4135db5816..798397b6811e 100644
--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -3565,11 +3565,8 @@ int tipc_nl_sk_walk(struct sk_buff *skb, struct netlink_callback *cb,
 	rhashtable_walk_start(iter);
 	while ((tsk = rhashtable_walk_next(iter)) != NULL) {
 		if (IS_ERR(tsk)) {
-			err = PTR_ERR(tsk);
-			if (err == -EAGAIN) {
-				err = 0;
+			if (PTR_ERR(tsk) == -EAGAIN)
 				continue;
-			}
 			break;
 		}
 
-- 
2.39.2


