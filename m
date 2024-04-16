Return-Path: <linux-kernel+bounces-147447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 110CD8A7458
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA1CC1F21272
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 19:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E0D137C23;
	Tue, 16 Apr 2024 19:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sr2rMEkY"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83084137748;
	Tue, 16 Apr 2024 19:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713294427; cv=none; b=mN+xIeaXlMDXFNXKlFIu5G0jU9eDdK5bd5g+9X3onMfgSc1PhXhzv3oeTbYs7nK5oef2aNqjzbi6fKMp4iZMhDCU8V1Ps0GR8FIjHpQt73rJlKEKSqNS7I3M358mmVJkYTx662CBJTZ72Ue5V75tKDtjAXSFOPQH7xbAzw9nm5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713294427; c=relaxed/simple;
	bh=DAngsWtX5i5JPK0TVotIyyLHrT3kU1QwvuimQUMuUwg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=URqR5vnnprpmwX3lxHrPRHqsFUYRP+OToCIEji9wV/pzLTjGfDfSMTIHVU27Jez9Ehw8RW5+yc4PWdwuprp8GVrMWsN7c7v77TOi50ip2YyAZbI4izmHNXmhlUFyh6NLNkHS9cWZiahT5lS/GTps8KDWVKtkmxqKvyLh4gj2bfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sr2rMEkY; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6ed04c91c46so4911461b3a.0;
        Tue, 16 Apr 2024 12:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713294426; x=1713899226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ymh6/7DVgNq/BVrdLDL6ajyFa00O1IrR2fX6zfmoZZQ=;
        b=Sr2rMEkYhxxq9Vo8Dc+elN0e+8QHloyvN5HCHDRgr7FuuKC/4/j0heZH7rE1TZyviq
         T8Bl2uruwY68YgloLPAJhHOwrMuMxekykKOYxtrUi3xBvG9RS1loTc7bAfC5wdnZkoeX
         zCsO9v3W61yPtNlpHb9SnKobAwbRDWmiFQ1zCvd77YTQk8emxlOLhwTh7YXDIWxrZxY9
         9bDuu7x+Q4yI7PbZgpsa4EsKvoU2F7kvg1nqVM9JF2egf15O2f1aZIdbhFfx9zOeVdHi
         2/48unguQgueg3mlIIi+aVYelCgu0lbJTiPsJ4uEoakzAVuIhMjoi+TwxsINLMbft+US
         ItZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713294426; x=1713899226;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ymh6/7DVgNq/BVrdLDL6ajyFa00O1IrR2fX6zfmoZZQ=;
        b=c67fqQ2hmth2gVWhDrIgjk2l74Org+Vv6blRP6cSPlrIK4LHtehTNhU2oj0iIeQGHB
         gOBmPHmZsRf4ESPk7gMBTCVxVeGxa+U+h7CKaVR4Bhz3AHACtTFFyEqXt6CgKEHHMnxH
         pHUD9Zs87gTu6p5tJHPCMy0VdYxFHz/Ue8nuBUjGHO6FmIcVDIm4sDJiNO9hmuSSprck
         DLH5sa8qZYUrfp65niUJfw3GRxY0MRr4oYtvT6yUGypdYS0DV8v8WpvB0LfvNGEB1Z+7
         fx4nbkTeeVGTaT0ZCqjDFAebIb1t15umsI/tayprhV5iAQhHsxnEEfuyLQreFYW22JVq
         MUdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUSAf7Fe62oy4N6iC9uCcxoNGd3akU5reqY2K0Xb2ZiNBLpthTB0OEMKlwpucx6yZteRr2ij+Zwt3HWun2nIEI52jY8xO+nKBU1zHYjzGc3H8/m14hhlYJBOqKwrLbiPVHlTFK
X-Gm-Message-State: AOJu0YzVOM6hOaP0lsi7NTBSz16wN6VcafCZA2Eqian4Q+26D/imdD75
	2zNBMM5FtaEL618hk++8dKrMW2TJBPpITlmUPTFscg7AaKVNn1IyNgBtffl36viFvw==
X-Google-Smtp-Source: AGHT+IGoEfX05qonJWd6vzzxV0e1rBcqS8DZ97ASOVz0k0L6okXuaCutvnvql2+UOdD0V4O9OW7O7A==
X-Received: by 2002:a05:6a21:6d87:b0:1a7:c67:82ff with SMTP id wl7-20020a056a216d8700b001a70c6782ffmr17824895pzb.13.1713294425646;
        Tue, 16 Apr 2024 12:07:05 -0700 (PDT)
Received: from localhost.localdomain ([67.198.131.126])
        by smtp.gmail.com with ESMTPSA id n21-20020a056a000d5500b006ed066ebed4sm9716764pfv.93.2024.04.16.12.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 12:07:05 -0700 (PDT)
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
Subject: [PATCH net v2] udp: don't be set unconnected if only UDP cmsg
Date: Wed, 17 Apr 2024 03:03:30 +0800
Message-Id: <20240416190330.492972-1-yick.xie@gmail.com>
X-Mailer: git-send-email 2.34.1
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
v2: Add Fixes tag
v1: https://lore.kernel.org/netdev/20240414195213.106209-1-yick.xie@gmail.com/
---
 net/ipv4/udp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

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
-- 
2.34.1


