Return-Path: <linux-kernel+bounces-5343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E43D58189A0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98CEE1F21B00
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8881B291;
	Tue, 19 Dec 2023 14:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iR/6xhRd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E38B1A73C;
	Tue, 19 Dec 2023 14:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40c69403b3eso45848275e9.3;
        Tue, 19 Dec 2023 06:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702995572; x=1703600372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pejp2iczdWxF7uQVAlzk9w8bQVEry9Ccx9GLBVSdAiw=;
        b=iR/6xhRdBtJBDtOFrxiMgyHAs2LZOvM0KAdjOXTDWd70Hlzgn6cLvNoUoWNejdXAlr
         vRHoyZo6skqm1pjTcbIEGzlSUpP0U6PyFO05xmirRnA6FEvf3BPPuitrt/4Qsr2UeNJR
         uvmGtr6fkXvrvnDaOqydAbatb+eIiecT5y/52dPaGVQwXj7MDG6KplV97Gu1J+DRcy5f
         zVI6D8jelr2dsco/RzatIBkx5mk3bH8qJl3VqqpReY5Txv+90zG81VNjyBsakafH+d5G
         wAPIO5jNZAtdoRYYO5F5BfsYjFzwYjdukTkYn38ZZCe1cE3MN2I9jokG8RV6Y0bdfACd
         dHzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702995572; x=1703600372;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pejp2iczdWxF7uQVAlzk9w8bQVEry9Ccx9GLBVSdAiw=;
        b=djQN5amlYBsB2IGJYUr2Rfjyk5lvooT2/BCxkEWpZDWPNL+ljc8lgV//QOD9HcZYAA
         BUVYWSJsCvkKM2EcMghKWWzy4tEq3M8yosmfBBQUogezWquskoradS477Z72fgagTZyI
         ZREB7LJBJXrGeIo65jcs8qnTJHnJrgOxy4dlU8oE+PBZTgGmodeTW2Z5DER/5xCF+tzE
         PGRUTgMRZssmPIaUBlohZbqaRd3ICK9TaLI2TaiZMX1ZHxBxSzoGJSCFaHEoYW91f708
         Cpo7H62fb1xNP5NRxdzLl0OD0c/5WIhySRglQyqseVQv707M8xPFl15iytd3QuXWnjPH
         0JeA==
X-Gm-Message-State: AOJu0YzJ4KNDs18xpNL+IEFuyy3pDe5yu9zm7MRUxmUZKa8z++/A8Mza
	2RE8pGOyAA6OyFFQtZ3FT/c=
X-Google-Smtp-Source: AGHT+IF1aG81n3QckfqzCx5kXe1hHH5po9wN30gDtf7kGI9NGXY6aka+rEQuePN7k7d7rWgIRVEHuA==
X-Received: by 2002:a05:600c:2043:b0:40c:6204:d597 with SMTP id p3-20020a05600c204300b0040c6204d597mr4952779wmg.65.1702995571614;
        Tue, 19 Dec 2023 06:19:31 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id d1-20020adfe841000000b00333404e9935sm8390805wrn.54.2023.12.19.06.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 06:19:31 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Xinhui.Pan@amd.com,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/display: remove redundant initialization of variable remainder
Date: Tue, 19 Dec 2023 14:19:30 +0000
Message-Id: <20231219141930.367426-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Variable remainder is being initialized with a value that is never read,
the assignment is redundant and can be removed. Also add a newline
after the declaration to clean up the coding style.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/basics/conversion.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/basics/conversion.c b/drivers/gpu/drm/amd/display/dc/basics/conversion.c
index e295a839ab47..1090d235086a 100644
--- a/drivers/gpu/drm/amd/display/dc/basics/conversion.c
+++ b/drivers/gpu/drm/amd/display/dc/basics/conversion.c
@@ -103,7 +103,8 @@ void convert_float_matrix(
 
 static uint32_t find_gcd(uint32_t a, uint32_t b)
 {
-	uint32_t remainder = 0;
+	uint32_t remainder;
+
 	while (b != 0) {
 		remainder = a % b;
 		a = b;
-- 
2.39.2


