Return-Path: <linux-kernel+bounces-14820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F29F8222D2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 22:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E0221F22DAA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 21:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A6A168DB;
	Tue,  2 Jan 2024 21:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yukWixft"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7175D168C8
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 21:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5e6fe91c706so163150627b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 13:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704229202; x=1704834002; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ec50JyuVMq7UkJG1GcqjOw+1KiCHQWv6ykAZlZLXjLE=;
        b=yukWixft/gkFujUNF0xmBp23Th7d4rlqFaWCkVP8nBPNm1Md/GHTkIWieRI/7752f3
         KtT31mGgq27D7TPIRK4h3ZpY6UZD91uoOUAzaAKMr8b26IclephxMGo7B9pC3lFpYofO
         jfzENcP2K9zkFB73+6eBhsnmsXOcv0xX4BqJ1G1qzUspbD5i7jOSL5Kr2qy/rGaKeG6x
         PpV1UHKJS3yIQY6VHwiiO+3R61E+nD1+xdXX5cjfUL+zc4Hv7XQbS+Qc7PkDQhVfZthr
         PA/4YXL+kjyIcoFZ1Cftx51p92naNoKHKyoh1peHTH5SxIaTc8416f0Pkyr0QyShromI
         SkKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704229202; x=1704834002;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ec50JyuVMq7UkJG1GcqjOw+1KiCHQWv6ykAZlZLXjLE=;
        b=DCmk+MXOnSvgsXi4PM4ggIhb+aD/frUstbRz46QPFNHXBAY2d/oLJGpXxqruDsNeix
         YCVAC/YccPVufsE6imqyNCJDeeOD090EZFHG+ZSDRG3245TNnD7ypgw/goV9K85RFAOO
         clYScs4+TZbl2gtN4hpxVdFmb4Woydv4oBJvvIJSWEuMtJMzhi8WCEjZA592crxU62Zh
         ITkbNkOckUHEfCrLl02sMDy9rabJr0GTNfanxquYbTn3pBqxLQhnbiLpT+f0nSHTjo1A
         QTaPLgbyaqvdA3uuGZ7NfuLLbTd2idYgOvQMTYgHH5WjTF+nBeNVIdvu+uFlIvfj/gke
         dhCg==
X-Gm-Message-State: AOJu0Yw6XI4g9HApv7G5ONsgD7X+saqQsG/nIh4gXuNlEnDbwBY5hS5X
	Vl9SV5OvX24NoTKyo16XageYcvcb9/UZGnjM+ul3qi/X
X-Google-Smtp-Source: AGHT+IHBlhrofrQJisx1jxu8EwoQTqKIT5C+y3q1aZb6bA92wFYfdZR+lW7AK2SK//4wwJbMdrPl4u+9rD2ENwZkyg==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:9a04:c262:c978:d762])
 (user=almasrymina job=sendgmr) by 2002:a05:6902:1369:b0:db5:4692:3ab7 with
 SMTP id bt9-20020a056902136900b00db546923ab7mr7174078ybb.8.1704229202435;
 Tue, 02 Jan 2024 13:00:02 -0800 (PST)
Date: Tue,  2 Jan 2024 12:59:58 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20240102205959.794513-1-almasrymina@google.com>
Subject: [PATCH net-next v3] net: kcm: fix direct access to bv_len
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Minor fix for kcm: code wanting to access the fields inside an skb
frag should use the skb_frag_*() helpers, instead of accessing the
fields directly.

Signed-off-by: Mina Almasry <almasrymina@google.com>

---
 net/kcm/kcmsock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
index 65d1f6755f98..1184d40167b8 100644
--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -634,7 +634,7 @@ static int kcm_write_msgs(struct kcm_sock *kcm)
 
 		msize = 0;
 		for (i = 0; i < skb_shinfo(skb)->nr_frags; i++)
-			msize += skb_shinfo(skb)->frags[i].bv_len;
+			msize += skb_frag_size(&skb_shinfo(skb)->frags[i]);
 
 		iov_iter_bvec(&msg.msg_iter, ITER_SOURCE,
 			      skb_shinfo(skb)->frags, skb_shinfo(skb)->nr_frags,
-- 
2.43.0.472.g3155946c3a-goog


