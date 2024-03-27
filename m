Return-Path: <linux-kernel+bounces-122094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF9388F1D8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 23:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A05761C278DF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 22:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76FB155397;
	Wed, 27 Mar 2024 22:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="0/rHPNp2"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98ADA153BCA
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 22:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711578380; cv=none; b=synzM0LTLeD9O3RMEYxvWm3JROAR7N5fGANqwbXGH0OC4wlahXn5F2zDzJglzJVrIU0n6LO9T1UGNV/UTsra1SReYgSAeZa+HwzH1+iKhNt8YRL9+RLyaSAKAOwoTgGt6MDkIJEbqpHj87SOeIkldGkag94o6S7mNs25MJ4O10g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711578380; c=relaxed/simple;
	bh=IpFdxipUZyLZ1WGndAkgbYxrgUnIpmiqCPmPgoQjeak=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=APd8m6/QkOQhuGli0+ZhE3Akt+z2YgWxOTGB00FOeHFo+hnaXdyYMRwjBvR8JjabbArBi7m5KSs/JF8DvTFxMJbTs73RAVvBJ1ScbOAj04jHAp9sRIxLbkIgOv1aU/Pi7bkugYi4DWw5QI+OdxN0G5/FeQr5WmnmQbuuiXg7Nqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=0/rHPNp2; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-41497adae1eso2168005e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 15:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1711578376; x=1712183176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jc/kebwJfSc9In02r4D75fEwv6vQMObeE/5ZkpkXrTQ=;
        b=0/rHPNp2PG3YSSyg3i/Z7nSAkPEyb0wtVIr1Bd64nIBXoswvKUu60vXe8pZGTDEf0L
         /qoZkQhmGC0YTlwWhPLh6I0FSTnK/4THPJbhgyIZmAqVotF+4tmxBsROSAaislUr7WTO
         ls/1PVKhlQuh77EumOXhDE4Np/cLSiVg+YlqF8CPpZHYTzXQFc1UpMuYkIpGNpmEHskB
         vOhWQJ77qxUvlwTfIcEcPIVQApQNYmrk0LKwzDqdmU0agYXVwKFKY6clRK1iUOREXcXE
         PgVy2eq988AkC5xClpoanmj6YGawXV7/uFE3roXPBQRh3CKpeVbgi8ynSX8FHGs4qg5S
         TjVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711578376; x=1712183176;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jc/kebwJfSc9In02r4D75fEwv6vQMObeE/5ZkpkXrTQ=;
        b=uDlZVW2xNbzQ2O/h77CY5q82jrawL+ivdXlPO58Zbu+lFyPMvlXtB+QnkjHRGpXvMB
         rr/6LZlaNUFKPtyOnrbLBmynwNth1ANzWPrJZHyQNtjTAC60LfZxnOU1YiDgyflDF9Tv
         F1qqcANY/1x9fWSrprrcicZOV9jDMDhbfeskiq73GLdLUdTnf5H0jdqEgQoUsBmLNWfN
         4vXzV4kwBolbKXNm6+mmyH6/gF1oin2utYzY9I9Mg3kiztzKLeUJctK6ybw+RFlTuAg8
         R0K4V/8x2D6HSDK/aIXDUdvUa7huyD9v+7ev/15COKBDNviB8GfS0jLndkZ4E9SpaQnI
         bkOA==
X-Forwarded-Encrypted: i=1; AJvYcCUS64wQ4bFoXLdMGsrcr6u3U2pir6jrtJJDbNdlxyTePiJe54Xe58ZGp3R4jwz2Ax0jYPTI+CFybCJnsLmW9ylhGaI+HLA162jjBU7C
X-Gm-Message-State: AOJu0YzKu3SGQBsmedg/nUNi0uhnU4nWqmZjWVBt1ycgNghb8paqJzst
	pTPIw6ta6Vlibrw7msf5agatpLXR4XPqh/m/cNdp7UVi4W7U5bbO3zTYK3CaQo0=
X-Google-Smtp-Source: AGHT+IFwNhiusV4dv7iZPuOpk/UITq2tStkbzgluwVYTIG7ZthGgEhWlZHDMpFJQMLFh/fxwUE2peg==
X-Received: by 2002:a05:600c:22d7:b0:414:8889:5a65 with SMTP id 23-20020a05600c22d700b0041488895a65mr1177566wmg.30.1711578375898;
        Wed, 27 Mar 2024 15:26:15 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-212.dynamic.mnet-online.de. [82.135.80.212])
        by smtp.gmail.com with ESMTPSA id l20-20020a05600c1d1400b004146a304863sm3390089wms.34.2024.03.27.15.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 15:26:15 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] crypto: jitter - Use kvfree_sensitive() to fix Coccinelle warning
Date: Wed, 27 Mar 2024 23:25:09 +0100
Message-ID: <20240327222507.42731-3-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace memzero_explicit() and kvfree() with kvfree_sensitive() to fix
the following Coccinelle/coccicheck warning reported by
kfree_sensitive.cocci:

	WARNING opportunity for kfree_sensitive/kvfree_sensitive

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 crypto/jitterentropy-kcapi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/crypto/jitterentropy-kcapi.c b/crypto/jitterentropy-kcapi.c
index 76edbf8af0ac..c24d4ff2b4a8 100644
--- a/crypto/jitterentropy-kcapi.c
+++ b/crypto/jitterentropy-kcapi.c
@@ -61,8 +61,7 @@ void *jent_kvzalloc(unsigned int len)
 
 void jent_kvzfree(void *ptr, unsigned int len)
 {
-	memzero_explicit(ptr, len);
-	kvfree(ptr);
+	kvfree_sensitive(ptr, len);
 }
 
 void *jent_zalloc(unsigned int len)
-- 
2.44.0


