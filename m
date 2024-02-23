Return-Path: <linux-kernel+bounces-78261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 868FF8610E3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 12:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 896801C21B90
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8827C6D4;
	Fri, 23 Feb 2024 11:58:54 +0000 (UTC)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0C77AE65;
	Fri, 23 Feb 2024 11:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708689534; cv=none; b=da/Zg0A6cYcAv3I9acyMLyqc90kyKoqbA+Nfm0V/JQXn3ZEvd5pLQawOktjzCvXj1NxZt2+yMyKYqhQOefRUqKSDi676UCAlgxeGiZBJQmOoXHAmJs30DXkfjsRAtlRG4GKWx0yrfxGu7AUZzINC/ExYU3+6L8GLh6yW5Z28l0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708689534; c=relaxed/simple;
	bh=o6BO7CXUm9dHSPMMyBG4qtuCBItocp2Cmsd3ImTlUsw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E2hOfBWTheZkxTzjVYp4EYhrW1gHV0irhG60BFeVvD4RQCzl0hPTxE+u0wt0NFhcwrPtigZ5e0a6jC6HaCHSCkoFPi75MsGRCUq/JCiOGItwo2vJtshZkXRMMQ94Bz/uxRdEryaKi73T9zcVBxzN7IQWjkIFwd4sXtgn5pr5SJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a3f829cde6dso87323666b.0;
        Fri, 23 Feb 2024 03:58:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708689531; x=1709294331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4PMOZ8U66vdID9xvLYzabHLRBd9NskjEvwGqh7mLj5M=;
        b=bMVBhEYjybVuY9A0dM2MjigEpeWGOU+LfRVtCStnkPeh98JrkG2/+uy0jw1vgJY393
         Stq0IeAGeHwUHQaZb6LC3bfHLlY4AslTGdyaY6P9b+8EkJNwoJLr7RFXE/yKFzDE0VRr
         tT9RbVuDe07vDD5XLLqKngYakKFeqq91AdHfrD80gE2oCKCqD9tFaIOdx+7m6wSQ7cmG
         8uCFxaLx6Bg4hnOD8GSfRzb7pbFW35u62szaebvK3rsvlzzWDaDAB2Bskd7KJ97PiXNn
         sxiMYPxNuiAZLPSvijrefSlpszn0T5RGyPCMllGGMDJqom8C7aCVtX+UhdUm8V0w/zO5
         wQRg==
X-Forwarded-Encrypted: i=1; AJvYcCVeqnIN8rmZdSbpNF8uqEqinkt6AL5UXIaTuLoWkzMagc+jOPJHT08OVy2klpDs/p4lyvEr5v+kd7LlhRvEI2WANF1eC/9oGOZyc2wN
X-Gm-Message-State: AOJu0YzwQfPG8TvmLQ9J/h6Pmm4S+AdrlQHB/dIYMajxRTzn4Lir32jO
	VWAXuycbrVZOocJN5BHE0yL5bVxhTQEpkfVKBp/2WjesdWqS+ExaI0zBC12g
X-Google-Smtp-Source: AGHT+IGM/TtqREPbVbQFZJLiM0YNydc7nsEwpb3EL+Pefz6h0WM1AlenO0PbKRHUhHPGQWqU9mI5Bw==
X-Received: by 2002:a17:906:f24e:b0:a3e:6036:3e45 with SMTP id gy14-20020a170906f24e00b00a3e60363e45mr1120758ejb.30.1708689530639;
        Fri, 23 Feb 2024 03:58:50 -0800 (PST)
Received: from localhost (fwdproxy-lla-004.fbsv.net. [2a03:2880:30ff:4::face:b00c])
        by smtp.gmail.com with ESMTPSA id pv14-20020a170907208e00b00a3f45b80559sm2346956ejb.139.2024.02.23.03.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 03:58:50 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	virtualization@lists.linux.dev (open list:VM SOCKETS (AF_VSOCK))
Subject: [PATCH net-next 2/2] net/vsockmon: Do not set zeroed statistics
Date: Fri, 23 Feb 2024 03:58:38 -0800
Message-Id: <20240223115839.3572852-2-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240223115839.3572852-1-leitao@debian.org>
References: <20240223115839.3572852-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Do not set rtnl_link_stats64 fields to zero, since they are zeroed
before ops->ndo_get_stats64 is called in core dev_get_stats() function.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/vsockmon.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/vsockmon.c b/drivers/net/vsockmon.c
index a0b4dca36baf..a1ba5169ed5d 100644
--- a/drivers/net/vsockmon.c
+++ b/drivers/net/vsockmon.c
@@ -46,9 +46,6 @@ static void
 vsockmon_get_stats64(struct net_device *dev, struct rtnl_link_stats64 *stats)
 {
 	dev_lstats_read(dev, &stats->rx_packets, &stats->rx_bytes);
-
-	stats->tx_packets = 0;
-	stats->tx_bytes = 0;
 }
 
 static int vsockmon_is_valid_mtu(int new_mtu)
-- 
2.39.3


