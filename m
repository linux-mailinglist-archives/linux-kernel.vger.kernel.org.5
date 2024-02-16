Return-Path: <linux-kernel+bounces-68599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB59857CFB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B5601F25E31
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 12:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12EB71292E2;
	Fri, 16 Feb 2024 12:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Be6SJ7T8"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6E9266D4;
	Fri, 16 Feb 2024 12:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708088088; cv=none; b=K82K/MTXgxaB8oL34cvzxoXVQyyU+MDvbZ4UQLAol1RDk6hrLXkLqeEBT1Z/TtIH6qkVmbS3Lb+Pm/pgIvqT1id99z6ZzjYqFGN6suAl7iF+NS5FysfkZ3jWVjAcufSFyXBOAjUMIFAFD/U5KoptFjstpmXBb2SObXIjsaRqVTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708088088; c=relaxed/simple;
	bh=tH0kdxyBWBGqfP/aVOfyxzUdVukg/+pepClSHy99W70=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=OXpJEZiGvnSLSzFbWLC7St+PM+CfK1+BfS9wQbl96cOLEBBGDhImYLgNaSqwUmv8Dl8Gau8KOiU/OLR58EjdhqmVa/+oZXg0/540VcHDPC3poLunhoww3QwVz5zpHRqecSemKgnC7Mlt3Z1msrJ39z8egW8pl124UtPi4M0F/Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Be6SJ7T8; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33d153254b7so498020f8f.0;
        Fri, 16 Feb 2024 04:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708088085; x=1708692885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bEcs0xF6NsN2yndITWHFP0bv87xKQqUwp6fc0rUr7Us=;
        b=Be6SJ7T8E4Yx1Hi+2yYWchugKtxI6BLx/k/jgvOYSC9guClOvyRN8qxcbzCxTOqF9y
         h+I/4EeRL04z/PNN4sbBp/XXaB/wMgSmNhrGkQWaWG1tqvw4965MJrnFABJO9ckRdmc1
         ufpFCvBBHH+gdmbUP06OwpjrO00lDSB8khLpcS4pvaTCNn2gXBoqeZJ1o/1v07ufzl4a
         3GSIPdM0NeXE8Z7bi4XNsURzItZAgNSe58h7TABp6vxWePl8JUKApMm66yY7vzgcAZ2U
         nD19qlXtkUdIPM8dNgtZ0QOOS9QfPwjvLPyvoHCxaY5j7p2ZXxDl1QVO845FnJxydR6C
         KAOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708088085; x=1708692885;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bEcs0xF6NsN2yndITWHFP0bv87xKQqUwp6fc0rUr7Us=;
        b=B/ovdmSOs+42MTwKyK+iSn/b0ZFlGjfT5LXa9rkOmVIbP6or8W6/ZDAh2/wRhvnH1u
         KmKpsIAgU97Iz1ILQmWN+0IHXBV5fE7vSIstQKfb59Ug5PpgAEk8bqqbx8hntbj5+/wd
         FdlJQ7txXw9n9XtZ2x7RJ+mrFjSJ8JH/MwtOF40ru9yOp1/BGUSwc6LqLL4fCaqFQyc8
         HFYu6DFKXIjkZSx7Y6V54yOBz+iaBUVkmw2A/P9ooVdmNy7HF/JTqrZE4YE8w8AnKusI
         5cPHo8yHjTze1uv0UnKfYmHKyK0arx3NHdYk5i2YLG6e79s1oh6iXLhlCWSgGxd6qUwY
         cDFA==
X-Forwarded-Encrypted: i=1; AJvYcCU9Q7x7CEczHCulHNXPD0URQGyvpg6jMtrlw16MwEA4spMEXBxMr8hYxsWPYO62wxLcLZT3vwPutjL8l/JxhFRn5UdUmkB+wWA2qvfb9ewMhXu3xpL45Q3otwBLDYLZWr3XYyE/
X-Gm-Message-State: AOJu0YxtbJiZL7VZBuHoln8vPlYXwHV/VW9kkDb3t8WA2wXndE+FoYAt
	H1p2DorssKACA4FGpQ3yPqDyfI0IVI/8fsmyYkMczUIFvtS7QGYS
X-Google-Smtp-Source: AGHT+IFMPn2oquqm21v74s6a/9ew+juZRTbUTboyoq4FEcC6Y4+blWJRB6s4tNG3V2L2lEiUt5u07g==
X-Received: by 2002:a5d:508c:0:b0:33d:1f9f:b01 with SMTP id a12-20020a5d508c000000b0033d1f9f0b01mr973514wrt.16.1708088084789;
        Fri, 16 Feb 2024 04:54:44 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id e14-20020a5d4e8e000000b0033cdf1f15e8sm2159531wru.16.2024.02.16.04.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 04:54:44 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] net: tcp: Remove redundant initialization of variable len
Date: Fri, 16 Feb 2024 12:54:43 +0000
Message-Id: <20240216125443.2107244-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The variable len being initialized with a value that is never read, an 
if statement is initializing it in both paths of the if statement.
The initialization is redundant and can be removed.

Cleans up clang scan build warning:
net/ipv4/tcp_ao.c:512:11: warning: Value stored to 'len' during its
initialization is never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 net/ipv4/tcp_ao.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
index 87db432c6bb4..3afeeb68e8a7 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -509,9 +509,9 @@ static int tcp_ao_hash_header(struct tcp_sigpool *hp,
 			      bool exclude_options, u8 *hash,
 			      int hash_offset, int hash_len)
 {
-	int err, len = th->doff << 2;
 	struct scatterlist sg;
 	u8 *hdr = hp->scratch;
+	int err, len;
 
 	/* We are not allowed to change tcphdr, make a local copy */
 	if (exclude_options) {
-- 
2.39.2


