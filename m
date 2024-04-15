Return-Path: <linux-kernel+bounces-144962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF6C8A4D32
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CFC01C21A3B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 11:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872615D74C;
	Mon, 15 Apr 2024 11:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RFfs+TgB"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751555CDF0;
	Mon, 15 Apr 2024 11:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713178932; cv=none; b=G5iEio7BEQE4seF5eRbWhPd0xeH4bXlP+9BH3FrkkRe2BQBJBMFzgcqh6KtVtWQk2/m5jZ2kKFMBb/NyuprzwyPgKxBVzaeBeFXbdCXWu9HsC8jkK5745+JmgSKnUuLxYghUtmSH4pSXrJXWZgVLLNi0NNEIohSeQZKgKIba/3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713178932; c=relaxed/simple;
	bh=8ZMNEysAxsax6oWuJx1vTmL34sekBHXDFfot8R/x5v8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Bu0CrzYl70Go3500Sr5Y9WSb98NtggQ5v8MoFx0QfEXINCPspLxBiiZe3KhjSEyXPLtZrvcSZoYdK5Q1q8X5hCSNf6aEZ9lNTLdFWo6iEMEWc3SDqmDrKMhsp3dAJijTLFyoj08P635eWIOIB3Z9zWXGicS5CIL3geoe5wXBe5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RFfs+TgB; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e5aa82d1f6so15564435ad.0;
        Mon, 15 Apr 2024 04:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713178931; x=1713783731; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CcN4AKapHK/Bm+Gc5NAgLadHVBnCwLZdg+FYzIUXJdg=;
        b=RFfs+TgBEn/E2rg9gOs7KKX0Vv9hb5dIVV/zMZXSKr1uPAkYhjJYnUwe0gf75obS6U
         b+6VKNiQAadGtk3yre7s2RhzFJ3MCtRnBTk5OEiu4/3+Un2v4s8zjaZEfxr8aD48xDff
         AQ3X2rc4frD5yCjy88wNRzANpVb5scdrOcK47v/73EolrafsRgjWUBVpWy+8vL9zbb3A
         vK9MrW7astZVRHmuLM41rNyfJR+6wrJpmNfeogL7lND1VVe8adHSKhnB7hWVxONEQm1h
         ZQn4L7BZFbEw9n6Anr/B1emVStrQziFDSJ+68eacD9yPBBUqzhLivF0IbkeYCI97zG62
         LuyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713178931; x=1713783731;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CcN4AKapHK/Bm+Gc5NAgLadHVBnCwLZdg+FYzIUXJdg=;
        b=oD2w+yBcH4TszH748yFtqWwMIZkd1Y3l43tqokuCVXuPzHVPx/a+vJEcPImP0dsFx1
         I90JvXNBPBUeO4CiFSTwQPSQni6dBK/CR2v6ov9PpmgRp30Ef35DWNaXDkP80V9fEoiE
         NG61OappPeM4iRWy3Q3fGhqgcoXvXIIZh6rashwfG/b6zV/gWBZ+xC5VMjunYN4XItox
         8erCHcfxLy/RUX8ioRtKPh8CS5YROnEGcCYQVnoTP5Aqx8DuHyqlqdtL04tPvRbgDj8A
         aN2NkyYB+dFVt5fr/S775jaWxQDQePwADvfdlAR2YWaDLqUPGYWLnSF3CStv/kG+R/3X
         T46A==
X-Forwarded-Encrypted: i=1; AJvYcCW/vbh7h4VlGTceMPHdZWrR/OQeE0hWDDYwtpXve2IodNVP0mhYBm6+wXkJZFjAOxNRV8iW8QZ1rh6cMR/hDL+SmfnRlrLh/z872jG9z/rySdrGedQBJKZ13bs2yDa6o8PqYeQL2lMysL9NTlNTE+Qewd003rtCLvmN8KWAvE2Pbw==
X-Gm-Message-State: AOJu0Yw7zJ/vFQGbXVG1p8fEMgh2jSA67hvPCg4IpsZZAjo7V+C3ntBU
	FO4VGmX4QYCHUyk16NQ/E9tMU6Rxw1Ft7k734efcAXbxi8ahbAm3
X-Google-Smtp-Source: AGHT+IE3ckbGCuSfsI22n5u5jCD5c6cDaW+CuTvB0Rk5Rj9oiOJHzw6o2s4rWgOWZmnBn2A5boGPOg==
X-Received: by 2002:a17:903:2303:b0:1e5:5c69:fcda with SMTP id d3-20020a170903230300b001e55c69fcdamr14875665plh.26.1713178930514;
        Mon, 15 Apr 2024 04:02:10 -0700 (PDT)
Received: from libra05 ([143.248.188.128])
        by smtp.gmail.com with ESMTPSA id e15-20020a17090301cf00b001e2a4499352sm7603916plh.262.2024.04.15.04.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 04:02:10 -0700 (PDT)
Date: Mon, 15 Apr 2024 20:02:05 +0900
From: Yewon Choi <woni9911@gmail.com>
To: Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-s390@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Dae R. Jeong" <threeearcat@gmail.com>
Subject: net/smc: Buggy reordering scenario in smc socket
Message-ID: <Zh0JLYHtd0i416XO@libra05>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,
we suspect some buggy scenario due to memory reordering in concurrent execution 
of setsockopt() and sendmmsg().

(CPU 1) setsockopt():
    case TCP_FASTOPEN_NO_COOKIE:
        ...
        smc_switch_to_fallback():
            clcsock->file = sk.sk_socket->file; // (1)
            clcsock->file->private_data = clcsock; // (2)

(CPU 2) __sys_sendmmsg():
    sockfd_lookup_light():
        sock_from_file():
            sock = file->private_data; // (3)
    ...
    fput_light(sock->file, fput_needed): // (4)
        fput():
            refcount_dec_and_test(sock->file->f_count) // null-ptr-deref

There is no memory barrier between (1) and (2), so (1) might be reordered after 
(2) is written to memory. Then, execution order can be (2)->(3)->(4)->(1) 
and (4) will read uninitialized value which may cause system crash.


This kind of reordering may happen in smc_ulp_init():

(CPU 1) smc_ulp_init():
    ...
    smcsock->file = tcp->file; // (5)
	smcsock->file->private_data = smcsock; // (6)

Execution order can be (6)->(3)->(4)->(5), showing same symptom as above.


One possible solution seems to be adding release semantic in (2) and (6).

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 4b52b3b159c0..37c23ef3e2d5 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -921,7 +921,7 @@ static int smc_switch_to_fallback(struct smc_sock *smc, int reason_code)
        trace_smc_switch_to_fallback(smc, reason_code);
        if (smc->sk.sk_socket && smc->sk.sk_socket->file) {
                smc->clcsock->file = smc->sk.sk_socket->file;
-               smc->clcsock->file->private_data = smc->clcsock;
+               smp_store_release(&smc->clcsock->file->private_data, smc->clcsock);
                smc->clcsock->wq.fasync_list =
                        smc->sk.sk_socket->wq.fasync_list;
                smc->sk.sk_socket->wq.fasync_list = NULL;
@@ -3410,7 +3410,7 @@ static int smc_ulp_init(struct sock *sk)
 
        /* replace tcp socket to smc */
        smcsock->file = tcp->file;
-       smcsock->file->private_data = smcsock;
+       smp_store_release(&smcsock->file->private_data, smcsock);
        smcsock->file->f_inode = SOCK_INODE(smcsock); /* replace inode when sock_close */
        smcsock->file->f_path.dentry->d_inode = SOCK_INODE(smcsock); /* dput() in __fput */
        tcp->file = NULL;

I think we don't need memory barrier between (3) and (4) because there are
critical section between (3) and (4), so lock(lock_sock/release_sock) will do this.


Could you check these? If confirmed to be a bug, we will send a patch.

Best Regards,
Yewon Choi

