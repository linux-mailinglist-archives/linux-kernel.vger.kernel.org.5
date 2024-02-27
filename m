Return-Path: <linux-kernel+bounces-83863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9223D869F91
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EEDA2862E7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7078750A73;
	Tue, 27 Feb 2024 18:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iLQq/bjY"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7301EB20;
	Tue, 27 Feb 2024 18:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709060020; cv=none; b=HaQCjulwR0xi/uoxIP8atj7Iz6mVYOgzrNYiIIBFEr3cNiwrit2LXgH9qYUsNcy6rWxxTi1QK1+iR8VXl6WxMO/SDAYGYhTPEmSRCTzwCNwc5JfxsQqztplRqC2PfdjXYl7Z+MhzgcoS0CegSG+xO0crDKI2/mL/HvRyADJ8N6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709060020; c=relaxed/simple;
	bh=XWdSQTiJ5UeZ7Y9pEB7wgt+hK9Ql9hUqNK43darvBNA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mm/WttfI3Gc1GzqezoUOQAdQ/GTx/8N5y3q+UOaRZtKRJcScsdN9ImWQxdoht0rdHVZ4Ovrdpz2ESorH2enP1O/o+o5vgvgryQQBYqM3Ifma1aWuIilzEZlvjZt53O0T4KoU2mnvcrah3HtjhR47Qz8RyEzJ69PXusNTyCUoOH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iLQq/bjY; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e558a67f70so286755b3a.0;
        Tue, 27 Feb 2024 10:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709060018; x=1709664818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=cpCYkRMcyEqaONCfb5aChB5RBA9px7XTtxAnjvNYuKY=;
        b=iLQq/bjYXCiG/1mRl3JsAGnABluiXGRdUvO08sEkU2kpKk2JTlwSs3R4nJ+86cYzYG
         UuIhDpEGanOD7feoSdj1W2YLamh4IKnrTdUss5Dnlg18v910HiUJJjEEE1MHkb8raJEv
         YWJnfMdhJEDh/SGtsa7COUpNjH7YbhiXEUzNUqZ5/t88aUsPBbxiMQHtCttyIfVRwe98
         NDsj88wfRbAy5X3EO9WAiH5LfB/9FlyTaKKp2RThD5+4xfBB7XROUHFoq067JFeI6Ws0
         mgqSkGUVbO0Er3G991uhR2uGy4cMewAZBQh0kXaIhwvSo0KrH52DN5QehPws+ugtT9pF
         PGKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709060018; x=1709664818;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cpCYkRMcyEqaONCfb5aChB5RBA9px7XTtxAnjvNYuKY=;
        b=iTvEPNkVQygFxUmVzmRN6TJXdi3hHQoKoMQcfD0on798PZqH6+RRyWw5JuJ5rhCN9/
         lfJeMb1keSEVumW3SnBGNl7EK/Z2zrPLw4C3AUk4IYTJz3sPIFwxdJ48CcQxJIlzOFIC
         MNCbFaaecUjyw1//qTlRBRdD5LJRci2Xeh1fYKSrpJc2wUIF5l/kNQlrynnO5m8At6+J
         PfS2t0LqD1bcoEXKIv/sVYDBGShRqJa942UDQw9auA7LFiFJCyvLBgDQ8BGGqsDFeLrX
         a/aaMQQ4+FrXxLF1H7iiIek3jkFuuxCdu7aSxVqEngbN/oH2I7sxN+yP1FiS7Ppz4rFr
         dDWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUP9RS+tbwKfcCoXW/CYtYwUXrGTL3SQ7awAVKdmkGB6awB2Yt9qJGXwqVRYfnJyxMHb2uPlf1FJkEk/zWEF6I1DxxN7GaokmYfvgmzhbIBpeg+pzMwnn3RlsEkabiSrGPAfZSsi6OiEU4H
X-Gm-Message-State: AOJu0Yy4Yrp35xftnPiS1AUMmRyB9EhM93LCCToL9Fhvuc3MnjbfR1RF
	+vL3gB61yfcgnvedxUNpuro/K7aMCnTYOo8CsS8xx/GoOs5a4dcbIcwz0e32
X-Google-Smtp-Source: AGHT+IF5i+yHNT6z98nh3j/oLQ7u7sfJBFub5M/8RYI9EMsYDYaku+qafJQFCyIALuP0c6IGNqUNgQ==
X-Received: by 2002:aa7:88cd:0:b0:6df:c3b1:1c2e with SMTP id k13-20020aa788cd000000b006dfc3b11c2emr11949486pff.30.1709060018244;
        Tue, 27 Feb 2024 10:53:38 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y5-20020a62b505000000b006e4cb18123fsm6198444pfe.84.2024.02.27.10.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 10:53:37 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Helge Deller <deller@gmx.de>
Cc: "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	linux-parisc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] parisc: More csum_ipv6_magic fixes
Date: Tue, 27 Feb 2024 10:53:34 -0800
Message-Id: <20240227185334.2697324-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IPv6 checksum tests with unaligned addresses resulted in unexpected
failures.

Expected expected == csum_result, but
    expected == 46591 (0xb5ff)
    csum_result == 46381 (0xb52d)
with alignment offset 1

Oddly enough, the problem disappeared after adding test code into
the beginning of csum_ipv6_magic().

As it turns out, the 'sum' parameter of csum_ipv6_magic() is declared as
__wsum, which is a 32-bit variable type. However, it is treated as 64-bit
variable in the assembler code. Tests showed that the upper 32 bit of
the register used to pass the variable are _not_ cleared when entering
the function. This can result in checksum calculation errors.

Clearing the upper 32 bit of 'sum' as first operation in the assembler
code fixes the problem.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
Maybe there is a way to do this without additional instruction, but if so
I have not been able to find it.

 arch/parisc/include/asm/checksum.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/parisc/include/asm/checksum.h b/arch/parisc/include/asm/checksum.h
index c949aa20fa16..2aceebcd695c 100644
--- a/arch/parisc/include/asm/checksum.h
+++ b/arch/parisc/include/asm/checksum.h
@@ -126,6 +126,7 @@ static __inline__ __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
 	** Try to keep 4 registers with "live" values ahead of the ALU.
 	*/
 
+"	depdi		0, 31, 32, %0\n"/* clear upper half of incoming checksum */
 "	ldd,ma		8(%1), %4\n"	/* get 1st saddr word */
 "	ldd,ma		8(%2), %5\n"	/* get 1st daddr word */
 "	add		%4, %0, %0\n"
-- 
2.39.2


