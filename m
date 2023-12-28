Return-Path: <linux-kernel+bounces-12781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D7081FA01
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 17:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFC4F1F229CE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 16:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E652FF519;
	Thu, 28 Dec 2023 16:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQBU18W3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D161C101C2;
	Thu, 28 Dec 2023 16:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40d5bc68bb7so20759005e9.3;
        Thu, 28 Dec 2023 08:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703781844; x=1704386644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cQvuZ3pxxVDvSCSqVoOdI+ZpejXE1rFk/CfCxYLqdrc=;
        b=VQBU18W3fwL9oP/jx/O/jBx752C0Wuibd2HEqBt/7piScLjORMIXvXdIstQNTt5Gpd
         PHmShx4YDW1bZ0XOzk2MI9oy5EbWVTu+i1jKkKBbQfBgFLWX/6MwugPTgBFsCZa4+JSa
         XQJAolCC140O1d0FsH6NDwaiColtKksnJZv8/rUCcARfFRHzbjQHMIK7fzVgNn83Bmhp
         eASj2f5RaUEDrI0KEVyqRs7bbPl1Ebl4WFWvJVbElYlGDqyri33DBax6z06zMSaAvdmS
         t/VFKZ6lez8ZQvzKpNLWshlSqbSPrPdNtEdQwS9I+DQePtbzSCmAzdA+13FXObxKVlIM
         MCzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703781844; x=1704386644;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cQvuZ3pxxVDvSCSqVoOdI+ZpejXE1rFk/CfCxYLqdrc=;
        b=gNr8RngUXV/c1AvZpNuUNa4VfsataIlHJKpaakGcgSsAzGjmzkq85pS0Qyl9MuFUAJ
         +GGWW3GhoAp6xmvDgFBmmGxOw6QWsvL0EHG2MUwEszXb4Uh5dHjNKp2PstgBlI3Qd3rO
         fa+JePCzPhCPTf0c6AvADpSHF7twTr/t5IZOGKjbI022rzvhvZshpeY2bIfpH+BMdMNy
         MsUH30fRO08l7C2Kgv/4E+ZEKutftJpudtp33FBo6OhbdHwvT5EOj5QZ++84vJdEbCPh
         zlUWR3DopYTwzJQtvWRfPv/WllEUkhSK070+15nFhzvJh+hlThQjSW7i5k8xAko/05yL
         vzwA==
X-Gm-Message-State: AOJu0Yw39UcyXoxcEUas96fYNTVIW49i2JULy9tgNMDANEh9te3jqlMr
	op2MZu4oF5+zZMqwGUsDSmnpTPixTG6vxw==
X-Google-Smtp-Source: AGHT+IH6lkChSESFaJFgZvFEeQWJ+DqMdxzi3yk2fykL16SYgV0IoZws3CgXuJgOx9cSEN7UvkLGBQ==
X-Received: by 2002:a05:600c:3d16:b0:40d:5c9c:187a with SMTP id bh22-20020a05600c3d1600b0040d5c9c187amr1841166wmb.108.1703781843711;
        Thu, 28 Dec 2023 08:44:03 -0800 (PST)
Received: from localhost.localdomain (bl17-216-113.dsl.telepac.pt. [188.82.216.113])
        by smtp.googlemail.com with ESMTPSA id a5-20020a05600c348500b0040d597abf05sm10409936wmq.42.2023.12.28.08.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 08:44:03 -0800 (PST)
From: Malkoot Khan <engr.mkhan1990@gmail.com>
To: edumazet@google.com
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Malkoot Khan <engr.mkhan1990@gmail.com>
Subject: [PATCH] tcp: fixed whitespace trailing error
Date: Thu, 28 Dec 2023 16:42:50 +0000
Message-Id: <20231228164250.106433-1-engr.mkhan1990@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Corrected whitespaces trailing error

Signed-off-by: Malkoot Khan <engr.mkhan1990@gmail.com>
---
 net/ipv4/tcp_timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index 1f9f6c1c196b..b7d0f8aee7ff 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -542,7 +542,7 @@ void tcp_retransmit_timer(struct sock *sk)
 		struct inet_sock *inet = inet_sk(sk);
 		u32 rtx_delta;
 
-		rtx_delta = tcp_time_stamp_ts(tp) - (tp->retrans_stamp ?: 
+		rtx_delta = tcp_time_stamp_ts(tp) - (tp->retrans_stamp ? :
 				tcp_skb_timestamp_ts(tp->tcp_usec_ts, skb));
 		if (tp->tcp_usec_ts)
 			rtx_delta /= USEC_PER_MSEC;
-- 
2.34.1


