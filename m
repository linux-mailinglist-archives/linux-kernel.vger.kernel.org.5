Return-Path: <linux-kernel+bounces-143382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 043B28A37DF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 23:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63D92B220CA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 21:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E264115217B;
	Fri, 12 Apr 2024 21:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="bI4v0Zah"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A36E152160
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 21:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712957434; cv=none; b=bDoodxTWliJxjB7Y8AABuVHuLaP4wQJy6X4Uvd5sab7p7qxEg9kPgUyKFZk2G8v9n8QfwcALl5JjjmNUPmYhQAjFJPOYG+YZ8Op4rnKKEdHFPeYz3lBfxt/wmNjzyRj/qC9nISEFC/Bbd0OQaA7dMMOv2GwTZx5L9pB4hVnTeTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712957434; c=relaxed/simple;
	bh=urpF+uhnagsRIlmCvAoqVf0cSl1JhJfWoktomJ+ip1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H6KjnO2rrQXT3Bhq6D7v8Y69t2Kx0gIfpi75vFn885YWu9l5r7c2YbgVWy3BGbsmdlzY2vtLDAeRrnKgYTO8cmt5xC3fBfp3MZvbpsLJgU0aWQ9DVRXE1FaNehEVHgLmeLJZQncyXqWz8yL/6/c9P4a5aXAsmTqoziy4lJcS/go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=bI4v0Zah; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4181e10b3b5so1321165e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 14:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1712957431; x=1713562231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GxzVOZoRlwbh3BCja72w8JfT19aYOorMwhFDDTCvDh0=;
        b=bI4v0Zah4boCHWG6A4aSzMr20nJi3Dsbj6+Dn6RKBVt7zAvkX6RF6MtSiobxe6Ug9q
         YB1vDiHSn7xKsWTCMRIXQNbAnrrse4jpfVRBVjmbSVBinutc0spid/vGTJc0Slads/da
         gFPG0Q6Tj5bAvc96uPCStpYP2WHnGh0h99dDxTk5IRqULMMzyb4P6ab+6hIyJX3Rp0b5
         p+UxDR107+WTXxEdqRohyL/mUPoNdUU4PtfElwzi2j4KimUDRry2bdlw6k7FB5Gaa8yx
         DoMhVScHuObGsshwjr0G5/nXookWTdwbe0d5gTzlg1fCS0eD2Ffqid15P6sxZjVrtmPf
         g8eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712957431; x=1713562231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GxzVOZoRlwbh3BCja72w8JfT19aYOorMwhFDDTCvDh0=;
        b=uHX9yw+cWe/wEzTk3yKukqF4uavq1xdj+da1NJrD9wPo476PZaQdJ9APoSNtDf6l1O
         eKg1zG7TH5KG8nqc0biQU5xJ9PAnV0qK8bsVnGURSKQKZgC8XSO4cYW8wReYJ1083QUO
         bsh4tXDqlIH1oiI+plnZvZNTb2DRJO0ilBhbYIXZDIDcNuM0bJSS/rGYdMyM7fugEIpE
         +qmTcFfgps8e5jIRZXAa3Ay2P2lHDwyTaSr09641O4v4MUgdvnOjJf9Lo2Ft6+riP37T
         Qlic9ssG5BrubQ/SSySHY4709/G1gS2886VfqsHQbSLats1ZdUF+Ud5v+pyGY3347qM8
         Er3g==
X-Forwarded-Encrypted: i=1; AJvYcCV5eF0XGkSrIvI9bPq4HOSvcSNQUbx1jYwEW0wzUkJtC+bqZDJBNDA4XlReQ/mFlJiwoHmCJVsOrPyis/toPB5m66xfxWmCKVMwpXkG
X-Gm-Message-State: AOJu0Yy7JUOMFG7GQNyAg9DAgl1lSC+dj0jkeLTeTFOdH/PaOjKijrgl
	oozFup1rUuhuwFudj5T4f1YJjnH5KyOZcdv8UM5ZZH12tfsy/njCB73YDWEnY6c=
X-Google-Smtp-Source: AGHT+IHUhdZJLdLX0HFsI9u9Pjbp9G8qIzufUAqtkGmv95NbpQTbtI+7HQ+bCAtx5aoCZH0BcgtDhw==
X-Received: by 2002:a05:6000:1952:b0:347:2b42:a397 with SMTP id e18-20020a056000195200b003472b42a397mr1533340wry.4.1712957430500;
        Fri, 12 Apr 2024 14:30:30 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-212.dynamic.mnet-online.de. [82.135.80.212])
        by smtp.gmail.com with ESMTPSA id di7-20020a0560000ac700b003439d2a5f99sm5046076wrb.55.2024.04.12.14.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 14:30:29 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: thorsten.blum@toblux.com
Cc: dan.j.williams@intel.com,
	davem@davemloft.net,
	herbert@gondor.apana.org.au,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] raid6test: Use str_plural() to fix Coccinelle warning
Date: Fri, 12 Apr 2024 23:29:45 +0200
Message-ID: <20240412212944.147286-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240328131519.372381-4-thorsten.blum@toblux.com>
References: <20240328131519.372381-4-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes the following Coccinelle/coccicheck warning reported by
string_choices.cocci:

	opportunity for str_plural(err)

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 crypto/async_tx/raid6test.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/crypto/async_tx/raid6test.c b/crypto/async_tx/raid6test.c
index d3fbee1e03e5..3826ccf0b9cc 100644
--- a/crypto/async_tx/raid6test.c
+++ b/crypto/async_tx/raid6test.c
@@ -11,6 +11,7 @@
 #include <linux/mm.h>
 #include <linux/random.h>
 #include <linux/module.h>
+#include <linux/string_choices.h>
 
 #undef pr
 #define pr(fmt, args...) pr_info("raid6test: " fmt, ##args)
@@ -228,7 +229,7 @@ static int __init raid6_test(void)
 
 	pr("\n");
 	pr("complete (%d tests, %d failure%s)\n",
-	   tests, err, err == 1 ? "" : "s");
+	   tests, err, str_plural(err));
 
 	for (i = 0; i < NDISKS+3; i++)
 		put_page(data[i]);
-- 
2.44.0


