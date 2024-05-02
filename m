Return-Path: <linux-kernel+bounces-166217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B40E88B97A5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B0861F26C21
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6CC759B71;
	Thu,  2 May 2024 09:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XX8keK1D"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AEB5915A
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 09:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714641898; cv=none; b=hQ4wcXrs7EL5B+TxrId65/ib0sorGZ2v5GcvQ1GWdOThSwmvvs79kyoc9FGODpTW687fW7K8AtYLbdoskx8fyel8iPfCKM2tKx3RCfRVBU3V4OxaG2XNpykKqnLnSEY6a+PlBh2OUnjDvQ1on5gCo5cNqpKAaj4v1x4BsWphqXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714641898; c=relaxed/simple;
	bh=IWMavLt3kFulGzQxZIoWZWxUM2RWdm2WOTlumZ3O1yY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PrzUbaKpnUEv7h6DW4i6mF0LNx2rfwFrXFZNmu7a22bhGPdgVcJ5z9Wug9/0Zaa7KrjQfn/pQXSRTmUu5JbEiL3wh1mr2E9b3KGPOSgNl/FTt6L1DYOGBBsx87OjoTTTiOIwPGYOLaYCNJte7RSjWFzimY37F8oWERuKAlAsA9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XX8keK1D; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ab48c1c007so1967083a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 02:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714641896; x=1715246696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Vtuu8T9epphwTtTuu3lp/GQ6ElIGl8lBIMHX4TrsJc=;
        b=XX8keK1DzMtknkUI07aQY63yogE6jBIurP9xTWVm9DS7/IbyjzBAVLwY6n5gGj8lgR
         l02gjwMT380wUxOJPTLoVwAEmwMZGgANXDk/JvYU0svz19Lb/0ybzjtCURCWXcb451rc
         6AskaOvu9Mpq/kAcJlgIwwpPRMEuVlAFxTQd7Au4HVRyocJZorld0Ky4YPN5WKCMelFo
         xl9lsHg9zZNwEJp5lyDbGH0BrtggJU8UZIPzd86VjhSw3R40zl6txD+L0UK2JzaM/S5I
         W/TnLDVkXuspONzCkkCc7IoDS3VnfB+Xr3wVfBPfbuwgcXp1QN5eiPUy6EVENiTNItkw
         MmpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714641896; x=1715246696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Vtuu8T9epphwTtTuu3lp/GQ6ElIGl8lBIMHX4TrsJc=;
        b=R8QIbOMDtj/g+X1IHB0t6g/3vTOzrohcd1Cw/j6HPsEgQfVOzreHdTVkZhqjPfLTfI
         ZtCVMvcscDgyHHtZnPPxX+4fSNSx8x02p0b6OL8UpIRHFVwDAcHoMJzT4MyIEBM+aRXc
         XKjeh1n6LgenqFEfOglAsGKSiP5aTOdblu0x58YAQRIPqnSAUW7RBCL9B9Wax/AW9/uv
         aS6eG/b6kQlSmTiat+TrjUOkk7n+D3T1KbBvlU3A0QAVMle8Xq3JqNGkdO5x2g/sccGC
         mb4V6ExsBvOtUwUuSuNabZmaorTY4CpiZWyCONn4SVOMOa8jqVnGmF7YWljP9njp11iA
         ruZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkZcYQDotkDl6lEoyE0jqmlr6yDeJjMh4V6HtQ4gHsDt1HmM6ydHhxopxpHMYx0bdt58a9nlNnmJ3MUrJM1XmryQbzwOjVsJ0ljdJD
X-Gm-Message-State: AOJu0YzeSbR+PNgfZmmr80lDsxkY9TgZpXk7I2DI3qoz5fqdHyttQWJv
	cWETxwxBoJuJKyds5hUNARfZf15SZnpX6wH6+p6L+4IKhcQpfYvbsfIWQJTz
X-Google-Smtp-Source: AGHT+IHKNU0etU7+knP43TQ0jsaxdSCdUU2aisVlh1h0CtI+thkwDQ6wADoLeaIEi+DFGWe4rwH/fA==
X-Received: by 2002:a05:6a20:f388:b0:1ae:42c8:4f69 with SMTP id qr8-20020a056a20f38800b001ae42c84f69mr5799654pzb.0.1714641895964;
        Thu, 02 May 2024 02:24:55 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id bk15-20020a17090b080f00b002a51dcecc49sm746836pjb.38.2024.05.02.02.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 02:24:55 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: akpm@linux-foundation.org,
	yury.norov@gmail.com
Cc: linux@rasmusvillemoes.dk,
	n26122115@gs.ncku.edu.tw,
	jserv@ccns.ncku.edu.tw,
	linux-kernel@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v5 2/2] bitops: Optimize fns() for improved performance
Date: Thu,  2 May 2024 17:24:43 +0800
Message-Id: <20240502092443.6845-3-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240502092443.6845-1-visitorckw@gmail.com>
References: <20240502092443.6845-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current fns() repeatedly uses __ffs() to find the index of the
least significant bit and then clears the corresponding bit using
__clear_bit(). The method for clearing the least significant bit can be
optimized by using word &= word - 1 instead.

Typically, the execution time of one __ffs() plus one __clear_bit() is
longer than that of a bitwise AND operation and a subtraction. To
improve performance, the loop for clearing the least significant bit
has been replaced with word &= word - 1, followed by a single __ffs()
operation to obtain the answer. This change reduces the number of
__ffs() iterations from n to just one, enhancing overall performance.

This modification significantly accelerates the fns() function in the
test_bitops benchmark, improving its speed by approximately 7.6 times.
Additionally, it enhances the performance of find_nth_bit() in the
find_bit benchmark by approximately 26%.

Before:
test_bitops: fns:            58033164 ns
find_nth_bit:                  4254313 ns,  16525 iterations

After:
test_bitops: fns:             7637268 ns
find_nth_bit:                  3362863 ns,  16501 iterations

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---

Changes in v5:
- Update benchmark results in the commit message.

 include/linux/bitops.h | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index 2ba557e067fe..57ecef354f47 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -254,16 +254,10 @@ static inline unsigned long __ffs64(u64 word)
  */
 static inline unsigned long fns(unsigned long word, unsigned int n)
 {
-	unsigned int bit;
+	while (word && n--)
+		word &= word - 1;
 
-	while (word) {
-		bit = __ffs(word);
-		if (n-- == 0)
-			return bit;
-		__clear_bit(bit, &word);
-	}
-
-	return BITS_PER_LONG;
+	return word ? __ffs(word) : BITS_PER_LONG;
 }
 
 /**
-- 
2.34.1


