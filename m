Return-Path: <linux-kernel+bounces-15975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC3782367C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 21:22:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EB441F23BC2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 20:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C581DA43;
	Wed,  3 Jan 2024 20:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="FvoiyVz8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E2D1D544
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 20:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d3ef33e68dso6104365ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 12:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1704313326; x=1704918126; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zwpW8R3xYRcFeijiUFHaM884VPc1V+tX+SXLWnbPyzE=;
        b=FvoiyVz8QnxDL5wEGzQ3TCOKVI9NfYSTikBJGbzZmBwfKlR3gI6A39PqTm0JX9wGjZ
         M+X7YUXZBjN7XH0xdTvfNJJpRnHauLCSlsZ0z/RFWRshinvQ6CTD0Fw3IIxNWFdedomM
         cdg9QUVo+tkA9H618VV/1t8zA1dowPiSay+HRmzF8Svxp0YNEK8Tkk9kH3ZNL/HAe8Hm
         Yp6wFznUv1hPEDkqzmuhDwnE/vNORsJNU0r6AT1HYiDYrTUkFgptCvVZHKZ7L+ejqhNX
         8YqxiJTvTXtlxpVBVSWGtYXTeZJgygwkTWo968opX5baKExExtJnxCj86nPi2ZDpN1rd
         j/mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704313326; x=1704918126;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zwpW8R3xYRcFeijiUFHaM884VPc1V+tX+SXLWnbPyzE=;
        b=IZ8XwrleDN0r81+T9e4UnDiw8zrb2naROT/dD+2eoxkhsLfpAQVRrCS0QQnk5rQoez
         BbfBWzqsa7ZDvnCZghDue3RJ8qyKwX3fbUCsLUDjtB1mfHyb33v8EXTZjpdSXLFQfw55
         U8IH1cxTXrL23s0n1lqZQPnjMxTVtMfsUwktF9W4uN42NVCyuvqoVI8lYheGXs/9eH0h
         DWYMO1oHaa8ezXgEYGb325C8eJ7vLzYotV3t/54gBlc/kz1lgIQ/w6oOocIdybscL3Uh
         xZHAqtyMemwfhimKs+YhDrnJVRHhfccavHMebPmD3Sz/BluoY+YufzLTAI4qfwxaTeq+
         btIg==
X-Gm-Message-State: AOJu0YxrYr11zkC7CwQPyseu7WrQTSAWfdmNQqkjNGZoVExfkuLFtZHb
	0+0oNJq/ma0nrdBL1s+AtsNNhY9ONjMDxA==
X-Google-Smtp-Source: AGHT+IEGKKEZm+PrXKULnqsmwhajVZq7IxX/xIJuHJ6YD4deMqXOED2G1ZGcg6ONgzGmqEbcfIT/jg==
X-Received: by 2002:a17:902:748c:b0:1d3:edd9:1f13 with SMTP id h12-20020a170902748c00b001d3edd91f13mr1728858pll.67.1704313326148;
        Wed, 03 Jan 2024 12:22:06 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d13-20020a170903230d00b001d3fa5acf71sm24278739plh.12.2024.01.03.12.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 12:22:05 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 03 Jan 2024 12:22:02 -0800
Subject: [PATCH v2 3/4] riscv: Fix relocation_hashtable size
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240103-module_loading_fix-v2-3-292b160552c9@rivosinc.com>
References: <20240103-module_loading_fix-v2-0-292b160552c9@rivosinc.com>
In-Reply-To: <20240103-module_loading_fix-v2-0-292b160552c9@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: Palmer Dabbelt <palmer@rivosinc.com>, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>, 
 kernel test robot <lkp@intel.com>, Julia Lawall <julia.lawall@inria.fr>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704313322; l=1020;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=js9HmT4o7o8yl7lcSP3vcOE6sOgYhIQV9xZrhoMilzw=;
 b=SCb2uRI3tDQm0ffD82YNnM5V07YHtzrz/w1KT4oUaF3KND9VKC87pPJdypEGMgzkkPQF9fFHn
 3U5g8/i3hp1DCZbGzDsWDLQbXyWpmz3T+J+fT5KLQK7xulsUwWWSBLe
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

A second dereference is needed to get the accurate size of the
relocation_hashtable.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Fixes: d8792a5734b0 ("riscv: Safely remove entries from relocation list")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Julia Lawall <julia.lawall@inria.fr>
Closes: https://lore.kernel.org/r/202312120044.wTI1Uyaa-lkp@intel.com/
---
 arch/riscv/kernel/module.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/module.c b/arch/riscv/kernel/module.c
index 32743180e8ef..ceb0adb38715 100644
--- a/arch/riscv/kernel/module.c
+++ b/arch/riscv/kernel/module.c
@@ -764,7 +764,7 @@ initialize_relocation_hashtable(unsigned int num_relocations,
 	hashtable_size <<= should_double_size;
 
 	*relocation_hashtable = kmalloc_array(hashtable_size,
-					      sizeof(*relocation_hashtable),
+					      sizeof(**relocation_hashtable),
 					      GFP_KERNEL);
 	if (!*relocation_hashtable)
 		return 0;

-- 
2.43.0


