Return-Path: <linux-kernel+bounces-56816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E112384CF99
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 18:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D90B1C271FC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 17:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE2C82886;
	Wed,  7 Feb 2024 17:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UFhfktRM"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5CD811EC;
	Wed,  7 Feb 2024 17:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707326129; cv=none; b=rZQNtP1UJUUU4VbUpyAQDI5nWCwSIy6LZKz2vXN2WuobPEzyl+hUOwCPjpsnQn+BMY0eh9SnuJi0JmOsWHaG6l6W2TZf7xH38TEp6e3i1s4pHMjotyjYFrhQYg8Vu3FWnpEd45mDWoBfl5EUS0hOA8AghC7au3vk+myOw8mmHOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707326129; c=relaxed/simple;
	bh=Wt0BEC4Lf7W05Q2Hskrgv1/2DCkqYDJbPFVmp+5b/HQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=RRNJkCUlV3sO9GauAnhi4sDMdJaNypJH60ihc92r9YXLmah9uO1kGc7/1R+gN2U/E0DeM03zrMHZ/2/nG7BEADRdnuvhvkgbjIPOTE1lRCrwmV7CEwYHINJzYlN8ajkGEH4m1cC1IBOKwYbhGtkc4Cg2h5Z+CLJ+4G03enFkwrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UFhfktRM; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40fdc63f4feso8322895e9.3;
        Wed, 07 Feb 2024 09:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707326126; x=1707930926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WWZvquA1Dk+Z7JW5jATMhqgqy/TPTZMHBlvj344RDlk=;
        b=UFhfktRMSWJ+2VmLCQeo2S0oAg1PSFmgMZP2E6/f3JdNgLf5/uzGuarm9aohbjlsLX
         XMpuNkly554jeJ7NJ8ZfKfiyjPLZp0RwWKR+xI7tVxiLBVh6fsqCW9CHxyIOlFZCjLb3
         X0l75KeRxqi4F+nkPwfxLR2Aw2O9I7jRDe5Bjb8lG7g9WxEycAH01Rbw6gFpFYUeoVKj
         KL39R5XQCcxiMXTA2ssTqBnUyCa/1rVYQkTIU9AWBzeSJZeB+eHmvnGMezE+sj95DPIZ
         GMdPY9zmDZaAAxduW/s5Y6zSvkQYEjcoDdijVeCbbQT5Ba5mLmiitMP0YepoLaYunAxI
         YLWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707326126; x=1707930926;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WWZvquA1Dk+Z7JW5jATMhqgqy/TPTZMHBlvj344RDlk=;
        b=HPNzlfUg921PmBjaYGkFRAW/rSfGqPqLOFkP7uvnlfr9ND+jYrRxAxMDnM0aPYwVpu
         3SO5SQril1QIbDcFDvOsYwB6h3YqJqHHaw0sSA4ZvLxjQHaGG1Pzo0ibYCv640cXhKCv
         b9E+UYEOEpFv0YWWHX3wtYq8Wyz3+0zpUBThoQVvlwbKOoP8MA5yDpTBEJogb6a6KHTL
         UFl3shU3DJO+RqQuGVfHTI3oc7y/gT1lW5VBbxnpuzYJhqk1Cj6txP0sKRHw+H/YvrUY
         RDoKT/GchuRwdYkGhGa+wKUmgRblZEhV7ZdBA39zEJlsHuFeFNMt8tbHfzMunelGAC1P
         Sxvw==
X-Gm-Message-State: AOJu0Yx4FypbMNWPdbakOYyKoC7M5JWWXXCycQxXPfLMCtaucao4JLf1
	ZCnWbfpViSlonF0GL/M0iRvcCQ8FqvdZrgiDBceZ+4Ylpi2PuWHR
X-Google-Smtp-Source: AGHT+IE+kUIpbAfVVtH6EgLXV3kU7Acc8yLEjA78d2N536/9raVQGzXfLvBmgViqaP/IJ89bNqG+hg==
X-Received: by 2002:a5d:408a:0:b0:33a:ee47:8a3e with SMTP id o10-20020a5d408a000000b0033aee478a3emr3462913wrp.58.1707326125939;
        Wed, 07 Feb 2024 09:15:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVx/qubPCNciJqS0VfdvWt3yL8Qtc5D3GPqAaUHOfAxxDO9ddoTXqoP6C7aqAfRTlR6j69zlETWQiCbvejXkGM7SriaoqhPrmR38HxemX6LIdgkURNvtxmWx3OBPnjaZNKL8BlJSIzfLlLeI88ar1szU6G+3t965ex0LpXjWIbXDDOu1XcLYpWHjeimPDpwl1mGZbR0zRM=
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id x7-20020a5d54c7000000b0033b444a39a9sm1915060wrv.54.2024.02.07.09.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 09:15:25 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Christian Lamparter <chunkeey@googlemail.com>,
	Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] carl9170: Remove redundant assignment to pointer super
Date: Wed,  7 Feb 2024 17:15:24 +0000
Message-Id: <20240207171524.2458418-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The pointer super is being assigned a value that is not being read, it
is being re-assigned later. The assignment is redundant and can be
removed.

Cleans up clang scan warning:
drivers/net/wireless/ath/carl9170/tx.c:192:34: warning: Value stored to
'super' during its initialization is never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/net/wireless/ath/carl9170/tx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/carl9170/tx.c b/drivers/net/wireless/ath/carl9170/tx.c
index 6bb9aa2bfe65..e902ca80eba7 100644
--- a/drivers/net/wireless/ath/carl9170/tx.c
+++ b/drivers/net/wireless/ath/carl9170/tx.c
@@ -189,7 +189,7 @@ static void carl9170_tx_accounting_free(struct ar9170 *ar, struct sk_buff *skb)
 
 static int carl9170_alloc_dev_space(struct ar9170 *ar, struct sk_buff *skb)
 {
-	struct _carl9170_tx_superframe *super = (void *) skb->data;
+	struct _carl9170_tx_superframe *super;
 	unsigned int chunks;
 	int cookie = -1;
 
-- 
2.39.2


