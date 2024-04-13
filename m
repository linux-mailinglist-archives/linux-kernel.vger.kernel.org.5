Return-Path: <linux-kernel+bounces-143738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B6A8A3CD8
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 15:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70F60B216B3
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 13:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C535144366;
	Sat, 13 Apr 2024 13:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FNVDmxCE"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D7910957;
	Sat, 13 Apr 2024 13:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713015590; cv=none; b=bEFQMHmVLY2SqbUzRlZoY6305Hj0lolFvkqePEdOzeeQvmAOwShhGOARrXNNie8U2QkpVYLNHS+o82j6wwWOMNo+U5NEguajO7zrsVoVOs9xnmhc3FWVHQ7ML7eski6VXWc9zg3prEjHDsOwG8jaOUZkpZprBjhsi5T50odvxPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713015590; c=relaxed/simple;
	bh=xBwPaVtN4Kt2Hxe9G0mcRgIyIp1h+0K6zQnysAc5XWM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SHpAYlcSII/TYvQKqaYJ23uu0P5UJedHJ+aSAnbz+S+T32jXWwjivEO2mW7CNjAllywP1NFMi01XJNs7HXkp0j75nuAhy30Sv8iUExbjAluUZln1qvKO2nl+ndgY8C582osy4cZxvpArB9nYW8nV9h9DadcHrerOlmdFNhwKE6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FNVDmxCE; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e40042c13eso12980855ad.2;
        Sat, 13 Apr 2024 06:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713015588; x=1713620388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oxBwVg43TfsZFeeOa+VyNS843+SiuR8TvdZOv/EH6Ys=;
        b=FNVDmxCEilxE37yx9v479Tw+hpzbwKAmahezOcO5itPynw5TlhyV3R/6Q3Ii9pHBkm
         t8OovAcS9xNcpBnNd09TNsc9fMSPBClColoEukyNHjM/bRM+quXYsdGAiw5m603aMWp4
         NFor8xxXyMFfd5Tkad9+lmbBbHfK/5K9rqzRKqqNKAF5zw1xByuL8l8xJ0QRNe9AJZ3C
         ogAe/7sdifXS/my/nAmmrH5kamBm2ZHNOVoV9qEpqCBzIxCtBtOlWeqnZzIkbM7bYxMx
         teto6W7YOJgk5inbovLwlaZLV9/Utn27lGOlElIDtGqvwDF2dfpGtF8YrgzOrPOhNKT3
         5TQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713015588; x=1713620388;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oxBwVg43TfsZFeeOa+VyNS843+SiuR8TvdZOv/EH6Ys=;
        b=eGsE+tVZ1fOhPPEduJmDqfvSwnhQwaYINO0l2Xr49WxAfrN9IBkYm5+65fSSvfkVW7
         tojNWaFFCqcnqwAgt6KkxUQqOeAJisXqsgoSilwezQ+cvCJ1ZD3sHDaieouJgVVwDAWd
         oP30gVUKKFnhEbZNZdEOmTkZ84eUccJsWQQxSZLxjfYReTbIIKG4Aemgj1mFLHu4uFHV
         7LBr0sdkcObeaeJ7BnqWA38HacEChw4L6n1Dhy+8fBIYuOeOCwZSSnbTAVZ7sDd/0HrV
         9J8U+j+HdCQW2akHZG52KmmtIPtVrRdS5gCnDUujCOqmrwMLhl1211SVbej0JtXMWAip
         K06w==
X-Forwarded-Encrypted: i=1; AJvYcCUO34drOsr9jcP/O+0adZ/WlgmGTq5Xzk0Cs0OpevLNrO1vBh1oAQursJAHbWEf97/kjrSlUbMaPAoUuKs1PagCb0+iknDz/ILIjU09
X-Gm-Message-State: AOJu0YwWm84l2QZFc6Z/abFS+x4RJPy1Z0hDwng77yzniGlaHYnd8yuV
	eTWjGVRe139hyHQTDzs2wGLX+9u3IFC2BlL8DjxqSk1NU9dJMDbsJN4Yfg==
X-Google-Smtp-Source: AGHT+IGKxABzGyb/NK7tQ8l453jNGksxymu4yv+cxeFkTh/8o6M9V8UBqHq4Rv66BRhC2orsazzPzw==
X-Received: by 2002:a17:903:2b0c:b0:1e4:196b:bb77 with SMTP id mc12-20020a1709032b0c00b001e4196bbb77mr5466182plb.69.1713015587861;
        Sat, 13 Apr 2024 06:39:47 -0700 (PDT)
Received: from galileo.. ([133.106.194.83])
        by smtp.googlemail.com with ESMTPSA id j16-20020a170902da9000b001e0ea5c910dsm4640177plx.18.2024.04.13.06.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 06:39:47 -0700 (PDT)
From: tskd08@gmail.com
To: linux-media@vger.kernel.org
Cc: mchehab@kernel.org,
	linux-kernel@vger.kernel.org,
	Akihiro Tsukada <tskd08@gmail.com>
Subject: [PATCH] v4l-utils/contrib/gconv: translation table fix for ARIB-STD-B24
Date: Sat, 13 Apr 2024 22:39:33 +0900
Message-ID: <20240413133933.66766-1-tskd08@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Akihiro Tsukada <tskd08@gmail.com>

Change/Add entries according to the ARIB STD B24 table 6.19.

Signed-off-by: Akihiro Tsukada <tskd08@gmail.com>
---
 contrib/gconv/arib-std-b24.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/contrib/gconv/arib-std-b24.c b/contrib/gconv/arib-std-b24.c
index 18f06283..56e46612 100644
--- a/contrib/gconv/arib-std-b24.c
+++ b/contrib/gconv/arib-std-b24.c
@@ -246,7 +246,7 @@ static const uint32_t extra_kanji[] = {
   0, 0x9fc5, 0x79da, 0x7a1e, 0x7b7f, 0x7c31, 0x4264, 0x7d8b,
   0x7fa1, 0x8118, 0x813a, 0xfa6d, 0x82ae, 0x845b, 0x84dc, 0x84ec,
   /* col. 16..31 */
-  0x8559, 0x85ce, 0x8755, 0x87ec, 0x880b, 0x88f5, 0x89d2, 0x8af6,
+  0x8559, 0x85ce, 0x8755, 0x87ec, 0x880b, 0x88f5, 0x2ec6, 0x8af6,
   0x8dce, 0x8fbb, 0x8ff6, 0x90dd, 0x9127, 0x912d, 0x91b2, 0x9233,
   /* col. 32..43 */
   0x9288, 0x9321, 0x9348, 0x9592, 0x96de, 0x9903, 0x9940, 0x9ad9,
@@ -257,7 +257,7 @@ static const uint32_t extra_symbols[5][96] = {
   /* row 90 */
   {
     /* col 0..15 */
-    0, 0x26cc, 0x26cd, 0x2762, 0x26cf, 0x26d0, 0x26d1, 0,
+    0, 0x26cc, 0x26cd, 0x2757, 0x26cf, 0x26d0, 0x26d1, 0,
     0x26d2, 0x26d5, 0x26d3, 0x26d4, 0, 0, 0, 0,
     /* col 16..31 */
     0x1f17f, 0x1f18a, 0, 0, 0x26d6, 0x26d7, 0x26d8, 0x26d9,
@@ -281,7 +281,7 @@ static const uint32_t extra_symbols[5][96] = {
     0, 0x26e3, 0x2b56, 0x2b57, 0x2b58, 0x2b59, 0x2613, 0x328b,
     0x3012, 0x26e8, 0x3246, 0x3245, 0x26e9, 0x0fd6, 0x26ea, 0x26eb,
     /* col 16..31 */
-    0x26ec, 0x2668, 0x26ed, 0x26ee, 0x26ef, 0x2693, 0x1f6e7, 0x26f0,
+    0x26ec, 0x2668, 0x26ed, 0x26ee, 0x26ef, 0x2693, 0x2708, 0x26f0,
     0x26f1, 0x26f2, 0x26f3, 0x26f4, 0x26f5, 0x1f157, 0x24b9, 0x24c8,
     /* col 32..47 */
     0x26f6, 0x1f15f, 0x1f18b, 0x1f18d, 0x1f18c, 0x1f179, 0x26f7, 0x26f8,
@@ -296,18 +296,18 @@ static const uint32_t extra_symbols[5][96] = {
     0x6708, 0x65e5, 0x5186, 0x33a1, 0x33a5, 0x339d, 0x33a0, 0x33a4,
     /* col 16..31 */
     0x1f100, 0x2488, 0x2489, 0x248a, 0x248b, 0x248c, 0x248d, 0x248e,
-    0x248f, 0x2490, 0, 0, 0, 0, 0, 0,
+    0x248f, 0x2490, 0xe290, 0xe291, 0xe292, 0xe293, 0xe294, 0xe295,
     /* col 32..47 */
     0x1f101, 0x1f102, 0x1f103, 0x1f104, 0x1f105, 0x1f106, 0x1f107, 0x1f108,
     0x1f109, 0x1f10a, 0x3233, 0x3236, 0x3232, 0x3231, 0x3239, 0x3244,
     /* col 48..63 */
     0x25b6, 0x25c0, 0x3016, 0x3017, 0x27d0, 0x00b2, 0x00b3, 0x1f12d,
-    0, 0, 0, 0, 0, 0, 0, 0,
+    0xe2a5, 0xe2a6, 0xe2a7, 0xe2a8, 0xe2a9, 0xe2aa, 0xe2ab, 0xe2ac,
     /* col 64..79 */
-    0, 0, 0, 0, 0, 0, 0, 0,
-    0, 0, 0, 0, 0, 0, 0, 0,
+    0xe2ad, 0xe2ae, 0xe2af, 0xe2b0, 0xe2b1, 0xe2b2, 0xe2b3, 0xe2b4,
+    0xe2b5, 0xe2b6, 0xe2b7, 0xe2b8, 0xe2b9, 0xe2ba, 0xe2bb, 0xe2bc,
     /* col 80..95 */
-    0, 0, 0, 0, 0, 0, 0x1f12c, 0x1f12b,
+    0xe2bd, 0xe2be, 0xe2bf, 0xe2c0, 0xe2c1, 0xe2c2, 0x1f12c, 0x1f12b,
     0x3247, 0x1f190, 0x1f226, 0x213b, 0, 0, 0, 0
   },
   /* row 93 */
@@ -325,10 +325,10 @@ static const uint32_t extra_symbols[5][96] = {
     0x00bd, 0x2189, 0x2153, 0x2154, 0x00bc, 0x00be, 0x2155, 0x2156,
     0x2157, 0x2158, 0x2159, 0x215a, 0x2150, 0x215b, 0x2151, 0x2152,
     /* col 64..79 */
-    0x2600, 0x2601, 0x2602, 0x26c4, 0x2616, 0x2617, 0x26c9, 0x26ca,
+    0x2600, 0x2601, 0x2602, 0x2603, 0x2616, 0x2617, 0x26c9, 0x26ca,
     0x2666, 0x2665, 0x2663, 0x2660, 0x26cb, 0x2a00, 0x203c, 0x2049,
     /* col 80..95 */
-    0x26c5, 0x2614, 0x26c6, 0x2603, 0x26c7, 0x26a1, 0x26c8, 0,
+    0x26c5, 0x2614, 0x26c6, 0x26c4, 0x26c7, 0x26a1, 0x26c8, 0,
     0x269e, 0x269f, 0x266c, 0x260e, 0, 0, 0, 0
   },
   /* row 94 */
-- 
2.44.0


