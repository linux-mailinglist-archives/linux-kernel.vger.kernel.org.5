Return-Path: <linux-kernel+bounces-150543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E71D38AA0C6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 19:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48887B21277
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B5D172BC6;
	Thu, 18 Apr 2024 17:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YgKZmvCL"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CD7171E77;
	Thu, 18 Apr 2024 17:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713460091; cv=none; b=tyE+BxEckIaW2Oz9qEHmTCwRefdDmzGoTFgOzcv19tsTwYahBAZe6o/Ttv8aNhoYjpqHnvGkrnaKCCiAkOR4Vjz+PJpRXdQi3CpGn6Rm+ZMHo+p0Dv+lyAX1uNc/Ojgf7dRpH6CD7taE2nNhqt1QSdzea2lJnzy1ZRa6EJohttg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713460091; c=relaxed/simple;
	bh=eCtKOdVAQNp2A4st0BhHo8jBLBWUqc2tUDSRWCS566Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YrB7EU8ymJ2ZVG31vjTHtMBiQPpHasP9BrJ+/GA5G0ajMwkJOKIa044Q2nXcIe5wCSlnpa0Uf2gP9TxqYZnb/yFVL5BtsmPsoBSxA5WLU/+jYicmeXXmt2F3gSfgv1XMyWnho5tW/VLtPlle5tf3SclRrDNzch49hFGMpBVob/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YgKZmvCL; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1e857e571f3so9499015ad.0;
        Thu, 18 Apr 2024 10:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713460089; x=1714064889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XW7920DVCiComrNM1OgXootScUMXHBonTRbYMTBe4yg=;
        b=YgKZmvCLUpCYzVoJMGPf0sL2Y+S9VAvIK/O4yRWZN1BfRcbh+L6pf5Fd+iNzJN+BPC
         B2MOYPNnIzkOxVE8O6BQVR8qPVgr7FUV0t/29D4jtsTTLuw6jeEPWFU7Ey1jyFDYQ2pP
         wu/t3T8iQmsMXOcss1cjOWSvXMaGiWlnpycaIZsXYX5mNRTpBe2Hk+B5K9xs8qdchnrg
         7gOWJFzlvUynSwOofYfRs1P7q2/aGZGslxm1q5ekPdhDjJ+w5qqEdOjQbC+3ajw5Ydcu
         zwf/pz1N1lqgXtQ1DeqG4S0Fi6TM88QC16dlOJO6IqREk5kRqU2k8YDrH9BofLAliLBc
         C+bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713460089; x=1714064889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XW7920DVCiComrNM1OgXootScUMXHBonTRbYMTBe4yg=;
        b=D38BfC+U5+avOHGuzTyBNtWqtPl2HoPRJyhig5HpaR41165wop1DeNgUCMJFgL2QgZ
         wSitPL/vkWkDcGPsEdR6MRsd1GWej6P3/4WN58wQi/89GgaRWL63rBnZyepxgF5PQIOD
         bFr2TUj2iSHj+7nynrmCq4M6kKaIy980vu+NT5PbGyqmZIY1FJbSCsfJo/ti9HAN3Tbp
         ujys4DFY0atmhnYiHZ1sT65LHoqYItetleH86fFVtflKyU6cT5WeTHTof7sxZAzYy/HG
         LqSwDeFYrjPvX0w8jo2T917buM/PCztBv+WJACuktxUxKz4WxqEWJpHCe7tovEvKoA1Y
         crWg==
X-Forwarded-Encrypted: i=1; AJvYcCVu88L9ff9nVZSI01FNuyJvNyCdl0rQfMwukD/DGiLAMLDzypuPmT3co9kRbb+Jb2v6ZoCwdKI6vZtn/mw2UgdBjrHJpdzvzlXvTtj3/u5CdXzwfL33sb7V3JelxoaLeJtaqK64
X-Gm-Message-State: AOJu0YwLr4GfeNzT+EPIVKIPZ0jcPkzfYj2boTF5p5xGQAt4FZB57q1C
	ajHZw8imEOJjOnKQWKAZcZPiYg3GEylK8OY29G4tVECra6+2phP7
X-Google-Smtp-Source: AGHT+IEgHtnZeEa6Rp4iVj/4BdN3MtRwG1GFyaoa1NlmerqjZSjhv0ADYR/1SGH1QNvq3sx8qa32Sg==
X-Received: by 2002:a17:902:cecc:b0:1e2:9c3b:df8d with SMTP id d12-20020a170902cecc00b001e29c3bdf8dmr4846362plg.20.1713460088935;
        Thu, 18 Apr 2024 10:08:08 -0700 (PDT)
Received: from localhost.localdomain ([67.198.131.126])
        by smtp.gmail.com with ESMTPSA id m10-20020a170902f20a00b001e8a90b8ac7sm616677plc.303.2024.04.18.10.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 10:08:08 -0700 (PDT)
From: Yick Xie <yick.xie@gmail.com>
To: willemdebruijn.kernel@gmail.com,
	willemb@google.com
Cc: netdev@vger.kernel.org,
	davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v3] udp: preserve the connected status if only UDP cmsg
Date: Fri, 19 Apr 2024 01:06:10 +0800
Message-Id: <20240418170610.867084-1-yick.xie@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <6621259d66d0f_ec9b929478@willemb.c.googlers.com.notmuch>
References: <6621259d66d0f_ec9b929478@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

If "udp_cmsg_send()" returned 0 (i.e. only UDP cmsg),
"connected" should not be set to 0. Otherwise it stops
the connected socket from using the cached route.

Fixes: 2e8de8576343 ("udp: add gso segment cmsg")
Signed-off-by: Yick Xie <yick.xie@gmail.com>
Cc: stable@vger.kernel.org
---
v3: Fix the IPV6 counterpart and revise the subject
v2: Add Fixes tag
v1: https://lore.kernel.org/netdev/20240414195213.106209-1-yick.xie@gmail.com/
---
 net/ipv4/udp.c | 5 +++--
 net/ipv6/udp.c | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index c02bf011d4a6..420905be5f30 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1123,16 +1123,17 @@ int udp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
 	if (msg->msg_controllen) {
 		err = udp_cmsg_send(sk, msg, &ipc.gso_size);
-		if (err > 0)
+		if (err > 0) {
 			err = ip_cmsg_send(sk, msg, &ipc,
 					   sk->sk_family == AF_INET6);
+			connected = 0;
+		}
 		if (unlikely(err < 0)) {
 			kfree(ipc.opt);
 			return err;
 		}
 		if (ipc.opt)
 			free = 1;
-		connected = 0;
 	}
 	if (!ipc.opt) {
 		struct ip_options_rcu *inet_opt;
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 8b1dd7f51249..1a4cccdd40c9 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -1474,9 +1474,11 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		ipc6.opt = opt;
 
 		err = udp_cmsg_send(sk, msg, &ipc6.gso_size);
-		if (err > 0)
+		if (err > 0) {
 			err = ip6_datagram_send_ctl(sock_net(sk), sk, msg, fl6,
 						    &ipc6);
+			connected = false;
+		}
 		if (err < 0) {
 			fl6_sock_release(flowlabel);
 			return err;
@@ -1488,7 +1490,6 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		}
 		if (!(opt->opt_nflen|opt->opt_flen))
 			opt = NULL;
-		connected = false;
 	}
 	if (!opt) {
 		opt = txopt_get(np);
-- 
2.34.1


