Return-Path: <linux-kernel+bounces-31611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E89018330D3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 23:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22D8D1F21788
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 22:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA4856B90;
	Fri, 19 Jan 2024 22:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="v7hoBNwf"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7682E5674D
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 22:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705704356; cv=none; b=IDWBL9wvkH9wOTfbuqMgOeRw39ETu2XdPOrHNeatllcTlf2ygxrIp6v/+y9KDvsa6JUi6He+GKK71dOe82f7iByAP4vjcLWDp2V+W2H0kDgTuM6dSzmOBnJmvngTLw/WYIKIWJ271jwNoEdd25OqELTv7OCr9hNNcAn9BwW9wv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705704356; c=relaxed/simple;
	bh=uA4FdWifBIyvvaSzLAe1j5JokAg2Yd8ZAqmFqenknLs=;
	h=Subject:Date:Message-ID:MIME-Version:Cc:From:To; b=K1h4j+xhk1khz+/7kmjEIUdqcNf5qtEhuYk47HNUJfarx6rCu8kx6bLORQnp4gC7MHKUnSXmfbdC18SXIeCMp2bvREgGgvM+mH+fWT2P8dcfH2RrCiEIBLv4U8xMQU7fQ4ROUOjSB9DB2moV5pGI/T6RKqWCq8X28odVaVkjDd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=v7hoBNwf; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d70a98c189so9991015ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 14:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1705704354; x=1706309154; darn=vger.kernel.org;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=2m1XhtygbnQtWGP2mbVBYdagXNcPKgbqxOJjRe6fvag=;
        b=v7hoBNwfzatVyTIrzBUh27gG6hOIeg/qxyPjdrIrVIyLzgJ1iOWjNlUAgCWIN2xWrg
         pfP1fnfOvio8jMiu0apESO3EKDCOpi7dj12x905G/0p+yNFlzhzSYZwOKfWzn7osYx5g
         nlntyGT22bW1Yj/4vjxClsgHLNb5uM4nt85wI0NeKuZsFxRJfX+V+ERhBJFIvlnQfjLl
         ohKh3gzbOnkbYZC1cwpgn0jPiMZRLvGBu1pdsBq7mUxn9UdUgqGboYgniTQshwVUq1JP
         gJjgu0ROlvDpyUCOhjj3fx67JgL/vlejmDgzln8UqTIsSTmh28H1KkG7N9QVtykz6NlE
         2grw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705704354; x=1706309154;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2m1XhtygbnQtWGP2mbVBYdagXNcPKgbqxOJjRe6fvag=;
        b=hlHB6YJ5WT2PNC6xP1G8zUgTVXDlT8r6waBxjymSVNAr/0eslB4jOZt5ocPkGxA+lF
         4xV5wo0yR+04iXtv4pFW5Y6WwBwif0hpD9Z+RR6PUu/Z7u5CFNT2OIOqg4lebuDbxm1g
         vk5f60WIBBKksdCWJsDVISudE3kz47SeBgpMvzElVTKLWFhYGLUk8sDp/fBf/fA7VT5n
         iZgv06LqmGPl9DiRVTuGr5w/t87k6M5Mf6Tnqhywir4Nn1YjPpZv6OhfzUJyZMYAN97B
         nBGKAGIBoBQPmOfRw2R9+W6MvkokFriiFm5lXt1YHe3G3bT5R4MxOqnuScIWdcCfKizb
         TDEQ==
X-Gm-Message-State: AOJu0YzZYMn2HLgfE73mJw3ZlJnFw0ypjmLQPKqsYzecnGD/6KgDfjs9
	Y6T60D+5TJBka9KzzYOaZWx8HnJxHGjVTbY+y7W/Wj1JVVqEnGHEpJa/0XQxgwc=
X-Google-Smtp-Source: AGHT+IGDYcz91ZsFkrsdeetEFLWkVDikcqnEMGNi7rrUqJxNwbVFtPK97ae9vNTPyqHIMS90uGoxFA==
X-Received: by 2002:a17:902:6b02:b0:1d4:e2bc:88f1 with SMTP id o2-20020a1709026b0200b001d4e2bc88f1mr582016plk.110.1705704353758;
        Fri, 19 Jan 2024 14:45:53 -0800 (PST)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id p20-20020a170902c71400b001d5e2127632sm3525800plp.9.2024.01.19.14.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 14:45:53 -0800 (PST)
Subject: [PATCH v2] tty: hvc: Fix the RISC-V SBI driver for a refactoring
Date: Fri, 19 Jan 2024 14:44:05 -0800
Message-ID: <20240119224404.26695-2-palmer@rivosinc.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Greg KH <gregkh@linuxfoundation.org>, jirislaby@kernel.org,
  Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
  ajones@ventanamicro.com, apatel@ventanamicro.com, Atish Patra <atishp@rivosinc.com>,
  linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
  linux-riscv@lists.infradead.org, Palmer Dabbelt <palmer@rivosinc.com>
From: Palmer Dabbelt <palmer@rivosinc.com>
To:         linux-riscv@lists.infradead.org

From: Palmer Dabbelt <palmer@rivosinc.com>

I missed the int->size_t refactoring in f32fcbedbe92 ("tty: hvc: convert
to u8 and size_t"), which causes the newly used ops in 88ead68e764c
("tty: Add SBI debug console support to HVC SBI driver") to fail to
build due to a

linux/drivers/tty/hvc/hvc_riscv_sbi.c:59:15: error: incompatible function pointer types initializing 'ssize_t (*)(uint32_t, const u8 *, size_t)' (aka 'long (*)(unsigned int, const unsigned char *, unsigned long)') with an expression of type 'int (uint32_t, const char *, int)' (aka 'int (unsigned int, const char *, int)') [-Wincompatible-function-pointer-types]
        .put_chars = hvc_sbi_dbcn_tty_put,

Fixes: f32fcbedbe92 ("tty: hvc: convert to u8 and size_t")
Fixes: 88ead68e764c ("tty: Add SBI debug console support to HVC SBI driver")
Link: https://lore.kernel.org/r/20240119215612.20529-2-palmer@rivosinc.com
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
Changes since v1 <20240119215612.20529-2-palmer@rivosinc.com>:
* Fix the return and arguments correctly.
* Also fix the hvc_sbi_dbcn_tty_{get,put}().
---
 drivers/tty/hvc/hvc_riscv_sbi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/hvc/hvc_riscv_sbi.c b/drivers/tty/hvc/hvc_riscv_sbi.c
index 2f3571f17ecd..f8cd3310ef35 100644
--- a/drivers/tty/hvc/hvc_riscv_sbi.c
+++ b/drivers/tty/hvc/hvc_riscv_sbi.c
@@ -15,7 +15,7 @@
 
 #include "hvc_console.h"
 
-static int hvc_sbi_tty_put(uint32_t vtermno, const char *buf, int count)
+static ssize_t hvc_sbi_tty_put(uint32_t vtermno, const u8 *buf, size_t count)
 {
 	int i;
 
@@ -25,7 +25,7 @@ static int hvc_sbi_tty_put(uint32_t vtermno, const char *buf, int count)
 	return i;
 }
 
-static int hvc_sbi_tty_get(uint32_t vtermno, char *buf, int count)
+static ssize_t hvc_sbi_tty_get(uint32_t vtermno, u8 *buf, size_t count)
 {
 	int i, c;
 
@@ -44,12 +44,12 @@ static const struct hv_ops hvc_sbi_v01_ops = {
 	.put_chars = hvc_sbi_tty_put,
 };
 
-static int hvc_sbi_dbcn_tty_put(uint32_t vtermno, const char *buf, int count)
+static ssize_t hvc_sbi_dbcn_tty_put(uint32_t vtermno, const u8 *buf, size_t count)
 {
 	return sbi_debug_console_write(buf, count);
 }
 
-static int hvc_sbi_dbcn_tty_get(uint32_t vtermno, char *buf, int count)
+static ssize_t hvc_sbi_dbcn_tty_get(uint32_t vtermno, u8 *buf, size_t count)
 {
 	return sbi_debug_console_read(buf, count);
 }
-- 
2.43.0


