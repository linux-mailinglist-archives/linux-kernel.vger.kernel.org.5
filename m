Return-Path: <linux-kernel+bounces-90162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA5586FB43
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC5FEB218CD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB073168DF;
	Mon,  4 Mar 2024 08:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="a47X/CRM"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF9B134AD
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 08:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709539374; cv=none; b=fhHlUdEvBHlZlhL23Iu1PqXAnQwfE6HjDQ6p7XOC72wAJM+Pw3thzC/GqOrkMcSBUjUmGQfVpCpf4JqmFGxz7v6hA1mFphJNlwHmrXjfWCd2ZI828EggvUKQkQbhw1zmQTGTHuT9+g7ASi/f4Gf4cM9zUJ1F86bCBvmdtyJxEuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709539374; c=relaxed/simple;
	bh=dKwN8A7GUBExPlqO9KJL6ingVu5qBoz2pvjqaMOQanc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DZmTxx69nYczrf/Xryy1tcLX+vqWxvCdXMzS0T6qtzGom1OYpfZX05XhXjR1CbGx+zJJJc2Jj+w0Ci1XtnktimIX9zy9xR91H5AFnN7ugURVph5yhpPWzEexO5fKsyq8xs/54kEE+jDuLbtJbg79rg+e2PoCr9e62xEIMsFiSTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=a47X/CRM; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d220e39907so62142111fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 00:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709539369; x=1710144169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gtlvrgqpZklQkEKYnLjgHRVt/fow+xyugZpWWHGtqds=;
        b=a47X/CRMe1pwSH3l8D0X5us3ht9a0zWRkiQEQ2HaODeydmcTp7I4j4BTwFjMRYwWhp
         r2iurDox9mt+qv1v354sbpRjCZNMOJEF6uwPlx6grTouGduuCRwljFT5hUzQ/i2/5YiT
         QHNMkzkGKTG7ipn8zYcrQERiAzcapuFTqdHXXTVzcvfMin18CZLnyzmHvPDQ/d7ILDd/
         8fS6awIQDy/7cFbTS6UPA2xyeF0J2BR5viDoIbNB2JPvSJYEkr10G1rmqa0CxJDSe06W
         1Vv5YQFtI4kBuHFFn4zbbGr5XGXEkoY3JxMHda5C1ubi1DYmCf6ttAmeqRS/pbgsyyXb
         phyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709539369; x=1710144169;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gtlvrgqpZklQkEKYnLjgHRVt/fow+xyugZpWWHGtqds=;
        b=iVpMKTh5AHCZFbGaV9ZFFESGeGJQkEOf8oqNOt43ABrOV5BweyLuZVIMnNcL1wMUjj
         9ZBwBUKnJGqvRsCsS64ns7LEdShtS8FYt/oyKzOY7T5a7dxb7NiNY/avoF1sLAapBvdb
         DVKlhdHQ5wBZECr1I40hEmTTzwVnij7bAGyevFGJPHJoOmF97EKzgCpF7TZwEp45mSdP
         IVBcVHxfO+xTjOBcYyOdOOmOTsdEdiCqD2mvR0VSq8Danfx5efLEPEJFmYIVnXY8pDy5
         oZk/x/dOnYrP3UzyGFYHpYH1cwVX5ozlBaL38IShwdK1gty4uVtYPTpULcaRiQiFuhnL
         LyXw==
X-Forwarded-Encrypted: i=1; AJvYcCU5pKzGILnrrSjWKdFXoEDEtvySh7it+3cyNluDTRTlnViZvmXV4ceSLDv7YHmtap7ctznYvhSYaTnainO7oMzhnn6GKYEbf/rZtdRq
X-Gm-Message-State: AOJu0YxKaX32mXQjpS32IUmJkROojsTpBs5GUxB48ynYNwOe1uQWhE/u
	JWNH6hHPEHMYROksY0w5ENZiJQh5C/2R0hFjyZ//b5OBC+M7hJY/44l5oGf/IW0=
X-Google-Smtp-Source: AGHT+IFED/yYEBIF1j8I6CFBLLSnSkchoxI3Bvz64nJ6NMI0b0uSnfEaPsXBLlJrn8oZCubMvR0sfA==
X-Received: by 2002:a2e:958b:0:b0:2d2:7e19:f6 with SMTP id w11-20020a2e958b000000b002d27e1900f6mr6052452ljh.23.1709539369591;
        Mon, 04 Mar 2024 00:02:49 -0800 (PST)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id p3-20020a5d4583000000b0033b47ee01f1sm11442472wrq.49.2024.03.04.00.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 00:02:49 -0800 (PST)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Randy Dunlap <rdunlap@infradead.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH] riscv: Fix compilation error with FAST_GUP and rv32
Date: Mon,  4 Mar 2024 09:02:47 +0100
Message-Id: <20240304080247.387710-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

By surrounding the definition of pte_leaf_size() with a ifdef napot as
it should have been.

Fixes: e0fe5ab4192c ("riscv: Fix pte_leaf_size() for NAPOT")
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/include/asm/pgtable.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 25ca14f6942c..54d26a07fa63 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -439,9 +439,11 @@ static inline pte_t pte_mkhuge(pte_t pte)
 	return pte;
 }
 
+#ifdef CONFIG_RISCV_ISA_SVNAPOT
 #define pte_leaf_size(pte)	(pte_napot(pte) ?				\
 					napot_cont_size(napot_cont_order(pte)) :\
 					PAGE_SIZE)
+#endif
 
 #ifdef CONFIG_NUMA_BALANCING
 /*
-- 
2.39.2


