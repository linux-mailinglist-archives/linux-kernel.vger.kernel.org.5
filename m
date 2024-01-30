Return-Path: <linux-kernel+bounces-43680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2065841798
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 01:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5FFA1C229EC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 00:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AEB836117;
	Tue, 30 Jan 2024 00:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="RRpvLjEp"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9382030A
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 00:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706575026; cv=none; b=JJ1uCjcRtH44uRDcQHUzzNgmYyz3yEolIbE4H5keoPlUP2RgQy7gn8ktQXAAtT6pmZFjoATiKPVmBF7YRw8kUUCib3OmjhEX5w6V++0fpILGGn4IU7vepZ+I9VJ49Yvu9REODPItbHh4cMrIgO5bTW4b4ClxS05qSvldpGIdL94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706575026; c=relaxed/simple;
	bh=V7pluBm2W1PoZ2bBLrm+qZq65mTPWf8JJaZyD0Mij4k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DpAIEfU9KUAuEmAhF9vrxMdQrWHOKMdWozi0JryAjIN3Al0v+1pUEV4GeR2tpq1vWFKJ8tWdpImo0cFKSNg/Au0qoTvRSV1zVyDikZzJ68o7E3LdBYdDB/JA+73TrWX0qPCjoV70ka0rlaDW5tCwdLDMcVBQnzXC5OXuYKBG1lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=RRpvLjEp; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d8aadc624dso14620915ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 16:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706575024; x=1707179824; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fBdnavPhPLG4hLHe/lbowMi09bgXqSC/rhZZs2QP0QQ=;
        b=RRpvLjEptK8zaBoSTwxNrwOJw0rckFpO9NnGxTv/V+Z789HbnSV1cA29ScFRZlqHjT
         WOGjbaem1pO8ipYyuI4hyZTDzLovGeM7oIEQhexGbj6CwPS6r7fZgRuDKOiFv2LednQs
         I+Sz0HyK5ycdbZYqKT4Z396iokw6StEfHlaY0e81gMooh3nuH9xgiizCDxpSpKcMTahZ
         WTbYy34Ny9E2m7/TIlVmZMll0BpNNEJf4S6sJnYrTX1Gjs/V5jwg/1n97/sGkLOA7q5F
         nBU5J9ZukJU7UjNoFItmpT49JMxHv7uaAPh7TIhxhtCS7sFHlM24F8fIOfPJW4T5jdH/
         NH6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706575024; x=1707179824;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fBdnavPhPLG4hLHe/lbowMi09bgXqSC/rhZZs2QP0QQ=;
        b=TEzxOW8ZS3emUxwxEJCbo8cWQzyD13iCN9vFoHfz8AmbxyqoVY7zrgq75hljt5/1h8
         4Wi47JGB5mUcFubWiidqQGxpAqu8CKUMgjXPGB/IW/rjdt8N9/JDB+gXokBc7W1MKadn
         fzzowbY8p/v675MYb+NM3QO/LlOQ/yIKBP4oTQpsVgbrtDFo6DUAvFbRlgQJhUuhgvcD
         PR3xWuhFuuDRtXzSbGaVzsJhm4qz4TgFk+dSSQGZaXze3PvHy6AR5e7ySWFH5uk0R7C2
         l+swdt9Yu29H50mumC49vUShW5OmRwxiR9k4DN4/6IqDv6Kc21/N8dtcD3NZOfQNRoSe
         cH8g==
X-Gm-Message-State: AOJu0YwKLx8jK8G5ts77MoqnjU69GQjK78EJZbN76MG98H5wKncIKwnN
	8x+cWR/wJMDJbZdOsb2s5fSd6Wm7ItKC8zGmfNxTBwidasAPkYI29gqp4Sjpc2Y=
X-Google-Smtp-Source: AGHT+IGUsknhl2CDcef7BUE1BsiJx3EyQBp1F7tMWLKnMckNrmrOa3LA4FFwrTaqlOeS/OBEkFdUbA==
X-Received: by 2002:a17:902:f551:b0:1d8:f21b:809c with SMTP id h17-20020a170902f55100b001d8f21b809cmr2649429plf.60.1706575024448;
        Mon, 29 Jan 2024 16:37:04 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id jb9-20020a170903258900b001d8ca3f5e3fsm3406375plb.295.2024.01.29.16.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 16:37:04 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Mon, 29 Jan 2024 16:37:00 -0800
Subject: [PATCH 1/3] riscv: mm: Use hint address in mmap if available
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240129-use_mmap_hint_address-v1-1-4c74da813ba1@rivosinc.com>
References: <20240129-use_mmap_hint_address-v1-0-4c74da813ba1@rivosinc.com>
In-Reply-To: <20240129-use_mmap_hint_address-v1-0-4c74da813ba1@rivosinc.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Yangyu Chen <cyy@cyyself.name>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706575021; l=2676;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=V7pluBm2W1PoZ2bBLrm+qZq65mTPWf8JJaZyD0Mij4k=;
 b=xLofBRKvo5qnvg1/QxrS9M++r6DfPgaAnZCvKPa1IRqMAJzNlfAUw3QxPPg3xgb0XIbJE85Ak
 oCl/l13iT1iCv7LIAifwyK+c286DNL3c3U9kefDRkWMehYKkGUTw++4
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

On riscv it is guaranteed that the address returned by mmap is less than
the hint address. Allow mmap to return an address all the way up to
addr, if provided, rather than just up to the lower address space.

This provides a performance benefit as well, allowing mmap to exit after
checking that the address is in range rather than searching for a valid
address.

It is possible to provide an address that uses at most the same number
of bits, however it is significantly more computationally expensive to
provide that number rather than setting the max to be the hint address.
There is the instruction clz/clzw in Zbb that returns the highest set bit
which could be used to performantly implement this, but it would still
be slower than the current implementation. At worst case, half of the
address would not be able to be allocated when a hint address is
provided.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/include/asm/processor.h | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index f19f861cda54..f3ea5166e3b2 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -22,14 +22,11 @@
 ({								\
 	unsigned long mmap_end;					\
 	typeof(addr) _addr = (addr);				\
-	if ((_addr) == 0 || (IS_ENABLED(CONFIG_COMPAT) && is_compat_task())) \
-		mmap_end = STACK_TOP_MAX;			\
-	else if ((_addr) >= VA_USER_SV57)			\
-		mmap_end = STACK_TOP_MAX;			\
-	else if ((((_addr) >= VA_USER_SV48)) && (VA_BITS >= VA_BITS_SV48)) \
-		mmap_end = VA_USER_SV48;			\
+	if ((_addr) == 0 ||					\
+		(IS_ENABLED(CONFIG_COMPAT) && is_compat_task()) ||	\
+		((_addr + len) > BIT(VA_BITS - 1)))		\
 	else							\
-		mmap_end = VA_USER_SV39;			\
+		mmap_end = (_addr + len);			\
 	mmap_end;						\
 })
 
@@ -39,14 +36,12 @@
 	typeof(addr) _addr = (addr);				\
 	typeof(base) _base = (base);				\
 	unsigned long rnd_gap = DEFAULT_MAP_WINDOW - (_base);	\
-	if ((_addr) == 0 || (IS_ENABLED(CONFIG_COMPAT) && is_compat_task())) \
+	if ((_addr) == 0 ||					\
+	    (IS_ENABLED(CONFIG_COMPAT) && is_compat_task()) ||	\
+	    ((_addr + len) > BIT(VA_BITS - 1)))			\
 		mmap_base = (_base);				\
-	else if (((_addr) >= VA_USER_SV57) && (VA_BITS >= VA_BITS_SV57)) \
-		mmap_base = VA_USER_SV57 - rnd_gap;		\
-	else if ((((_addr) >= VA_USER_SV48)) && (VA_BITS >= VA_BITS_SV48)) \
-		mmap_base = VA_USER_SV48 - rnd_gap;		\
 	else							\
-		mmap_base = VA_USER_SV39 - rnd_gap;		\
+		mmap_base = (_addr + len) - rnd_gap;		\
 	mmap_base;						\
 })
 

-- 
2.43.0


