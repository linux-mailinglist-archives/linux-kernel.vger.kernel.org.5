Return-Path: <linux-kernel+bounces-84629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39ECD86A931
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 08:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3D331F2709E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 07:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68A625605;
	Wed, 28 Feb 2024 07:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KcSaCMv/"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D3D250EC;
	Wed, 28 Feb 2024 07:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709106369; cv=none; b=edV8lR901V5s7S9RK6C1wvmvCIev+OFvzNm7DFUOBF8xQFAJA8Nk/YZD8qYmYHMyXpgNmGagoVqHbL22iAMmmMTRoXJPN4B1DwOzCdZMxDf6E0TzXG2MGX7mhEv0N2yQDVLy5fsc69YH2iTwP1kFAcav/IjC2mdgwJagahR2PQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709106369; c=relaxed/simple;
	bh=5Z/6CMtSbIx3yZOx74skMF+HWYenssxnSGRfDluEpz4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mc+hRLl+bdhfHT2+4uxu4rw4VGXO/Q1dGhD0ey3YKUtSurmJG3W+fqWF6MfQxN29jFGe17VSePw8xnrPohzWG/ENXo8L7RKyMuj/bKVEw097jmUgIHK63oawH7VMUweEYD52DLYN0VfCxSFliFNRc4CA7HQk11agAktRn4jEd74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KcSaCMv/; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e54b22229cso1199706b3a.3;
        Tue, 27 Feb 2024 23:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709106367; x=1709711167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cvJd7UIv9U3gWMDc5jMBed540xPjJg8OzKp2FL2VB40=;
        b=KcSaCMv/FLHMf3ENvztGmSHQQOpENrDWWsWh0nAzorXqIfIrFJK9FRiszOGz4Dt4YB
         g+gbzPVt7xL95rdVkJRdlg7/BuWx1lYyY9dAvEk3f+tiM1AnjbhFZ1C96pC2InhHywKz
         Xo8y656vMub1YAWoWQcf8yiiVLfMP16c4yH6oaR1o8GpLJk3rYovLF3KfbhQCI4Cscds
         awXwc2g9Ai9qKdsm5BODnZozYiYWfeKvS2kQSriyhpLztekYZ8OYiEVEscX+LGH7f66l
         iofgI9KWdEKgTJO3AozpaTmCLcH+nCqWqUDkbEn510qpQ0Ls+nmisFLrdkrssq2e4ts3
         f3sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709106367; x=1709711167;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cvJd7UIv9U3gWMDc5jMBed540xPjJg8OzKp2FL2VB40=;
        b=JhJsyWJuYsKYKVbxU0tCrLggmhnnvb7FRY13HOHqEPdXFEtdiYJr6UoJTr0uFpFxW5
         rZ4qugbxcPVhS4y3GtsuCg78j+RRQRjTTzEV1esMGRdiMUBfZdfJblhzQYOoVpq58dpU
         OKl57YdPcHeWTRW0J9NFkGxNzPtpUvbaLaQw2JAkHnWY4GfF0fMyW7DbMgQk9FK/Op7f
         8wNpIH8Vih+UPxuNMar5n8+8xC+4RnN5fPa83CksELT9FapUQMwcdv3foMTu38E7cPb2
         /ngrJ3rE6sLwunxAT85Oca03s3Wi2V126UJg9N2q4H9iV/lyMAyhTA1kwoEUaN81pSem
         VtCw==
X-Forwarded-Encrypted: i=1; AJvYcCX079VWFHMgddQOypNNJk07J5cHUeDVNCeFZMPJbnKwJD6ly7TyQ/EF2e9A5EHpt4cAe/KRZEK08NJIxWD1a48HlfM3pGn/
X-Gm-Message-State: AOJu0YxszUXyIkEIHXymVYqKZw3bj9V0bIpW0MALUGDHIDk4CTxbf6dX
	3s/XM05AMJHL4VxIqEZqNi3Gcsj88tHa5MD/K0xnuHUPs689oaV5AVBCtI7DSqXxjg==
X-Google-Smtp-Source: AGHT+IFPXWp9f0vAoe8ti5FiiDra7a5x+YmuQXDVr7DTvtcjuW98NxgE9t3zciafcyEQmQDWUZFgSg==
X-Received: by 2002:a05:6a00:8c7:b0:6e4:dfec:1b0e with SMTP id s7-20020a056a0008c700b006e4dfec1b0emr12339990pfu.19.1709106366945;
        Tue, 27 Feb 2024 23:46:06 -0800 (PST)
Received: from localhost.localdomain ([203.205.141.15])
        by smtp.googlemail.com with ESMTPSA id d12-20020aa7868c000000b006e0901b71e4sm7100769pfo.48.2024.02.27.23.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 23:46:06 -0800 (PST)
From: Ze Gao <zegao2021@gmail.com>
X-Google-Original-From: Ze Gao <zegao@tencent.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Ze Gao <zegao@tencent.com>,
	Honglin Li <honglinli@tencent.com>
Subject: [RFC PATCH] net, sock.h: Make sure accesses to a fullsock when it is indeed one
Date: Wed, 28 Feb 2024 02:43:09 -0500
Message-ID: <20240228074308.3623984-2-zegao@tencent.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We know a pointer that has type struct sock* can actually points to
one of some different sock types which have different memory layouts,
take req_to_sk() for example, and whether a sock is full or not
depends upon ->sk_state which is a shared field among them so that we
see some repeated code pattern similar to this:

	if (sk && sk fullsock(sk) && sk->field_not_shared)

which seems to have no problem at the first glance, but it is actually
unsound in a way that ->field_not_shared is likely uninitialized (or
unmapped) when it's not a full sock, and a compiler is free to reorder
accesses to fields of a struct sock when it can, that is, it could
reorder accesses to ->field_not_shared across ->sk_state or load them
all before the branch test, which leads to unexpected behavior, although
most of them won't do this.

So leave a barrier() in between and force the compiler to keep the
obvious program order.

Cc: Honglin Li <honglinli@tencent.com>
Signed-off-by: Ze Gao <zegao@tencent.com>
---

IIUC, casting a pointer to refer to a bigger object in size is
technically UB, which may lead to unsound code. From the POV of
a compiler, when it is allowed to assume that one struct member
is valid, they all are through a pointer, and thus it's likely
for the compiler to do such optimizations and reorder what we
want to keep in order.

Note this is not a typical way to use barrier(), which only
acts an ok fix to what's already unsound, at least IMO.

Comments are welcome, since I'm not an expert in C and I know
most of compilers won't do this reorder, but I'm being pessimistic
here.

Happy to learn from your sage insights and better solutions (or
no solutions at all if this is indeed not a problem in the first
place)

Regards,
        -- Ze

 include/net/sock.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 92f7ea62a915..f7e3960cb5fc 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2815,7 +2815,14 @@ skb_sk_is_prefetched(struct sk_buff *skb)
  */
 static inline bool sk_fullsock(const struct sock *sk)
 {
-	return (1 << sk->sk_state) & ~(TCPF_TIME_WAIT | TCPF_NEW_SYN_RECV);
+	bool ret = (1 << sk->sk_state) & ~(TCPF_TIME_WAIT | TCPF_NEW_SYN_RECV);
+
+	/*
+	 * Make sure all accesses to a full sock happens right
+	 * after ->sk_state.
+	 */
+	barrier();
+	return ret;
 }
 
 static inline bool
-- 
2.41.0


