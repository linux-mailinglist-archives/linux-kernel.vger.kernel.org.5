Return-Path: <linux-kernel+bounces-2206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F493815956
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 14:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FD8A1C216BC
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 13:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA9F30676;
	Sat, 16 Dec 2023 13:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c7NxgO6j"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5E72D7A7;
	Sat, 16 Dec 2023 13:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-552d39ac3ccso2430496a12.0;
        Sat, 16 Dec 2023 05:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702733671; x=1703338471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nTmoBalM2UZzwSsqBtYN4pTcgAH6LuJG4x51tAzCQyI=;
        b=c7NxgO6jDFPu0MX3vH1RvG41gJy5KAPIp3RjeKaXd6kG82RcYsrh68GKJllWNkgwjJ
         hRaKDzdf6JfEn5zZbOOWVagVzchT/SfOaR8SMsjdEEbXWPRVv3NOHN2L4US9awNZZBQd
         31VxPToNoHMlEzJe28fRcyDLMdD7GSyiijggpy3yjJyuwE4YCaPtu8MIV0IYWk/i2MIy
         qJ1KbZ/rJEEpayF+J1NZ8EGfVAquvn2f2I3hlg1oO5+o1Nr9q5OsdpjYAlChr0r65+Ee
         vDGC+7Nyrqxi/dWkKTPO4Az9PJ/m4bArIgLiknfGxW7HENiQObCCSsCmDeu1Rxrjvmam
         03lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702733671; x=1703338471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nTmoBalM2UZzwSsqBtYN4pTcgAH6LuJG4x51tAzCQyI=;
        b=SJxpDwhL8BBazr6uRy+/rDTIU+/ULCj2OHm7que8WxahxEe46jL2N9lzU5VMuajGkB
         xgtVglYV6G3EuFotvxqOJNqj0Ytj7q2cC1oJUbVFd8ztm/hZ9ipOCExXhMKrewVQ1uAj
         PTCWDBRyqOnjCxAEnIXshA4iH7iuiOKtXHyUGrjlSV/6S8bJdoGkihn17gEgGW4Ecuv4
         NJXSSiK9IsYenmga6wN/TzXVukh1BjrGW5/eIF31kN/7lZi/KD6UZFIm04xa9TxYm/yx
         w9ZIN5Dd91gsvzhk5A1dRYekQO9OnHaYDBQ2j6C6QTvV7d4+mlpXvat8D1T3AJ8P0UVd
         w3fQ==
X-Gm-Message-State: AOJu0YwgTUvEMfCNiUYJRb1vzFrFOOytHPa5pBdyu3Apu5fFqfoJDEJm
	MrurZt8kY0UzSHJu9PdBvWQ=
X-Google-Smtp-Source: AGHT+IH3b10j+8jyAKAtdvCEywyWlISzpZTeWRwzu6lMvYyzMBeGp+kGNS8nahX92FU1+f2A18l15Q==
X-Received: by 2002:a17:906:6d4f:b0:a23:31e9:71e4 with SMTP id a15-20020a1709066d4f00b00a2331e971e4mr344349ejt.71.1702733670581;
        Sat, 16 Dec 2023 05:34:30 -0800 (PST)
Received: from localhost.localdomain (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id l16-20020a170906415000b00a232bf6045csm423629ejk.63.2023.12.16.05.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 05:34:30 -0800 (PST)
From: Jernej Skrabec <jernej.skrabec@gmail.com>
To: wens@csie.org,
	samuel@sholland.org
Cc: mchehab@kernel.org,
	hverkuil-cisco@xs4all.nl,
	linux-media@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 3/3] media: sun8i-di: Fix chroma difference threshold
Date: Sat, 16 Dec 2023 14:34:22 +0100
Message-ID: <20231216133422.2534674-4-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231216133422.2534674-1-jernej.skrabec@gmail.com>
References: <20231216133422.2534674-1-jernej.skrabec@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While there is no good explanation what this value does, vendor driver
uses value 31 for it. Align driver with it.

Fixes: a4260ea49547 ("media: sun4i: Add H3 deinterlace driver")
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/media/platform/sunxi/sun8i-di/sun8i-di.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/sunxi/sun8i-di/sun8i-di.c b/drivers/media/platform/sunxi/sun8i-di/sun8i-di.c
index f253a40cc04f..f7ff0937828c 100644
--- a/drivers/media/platform/sunxi/sun8i-di/sun8i-di.c
+++ b/drivers/media/platform/sunxi/sun8i-di/sun8i-di.c
@@ -304,7 +304,7 @@ static void deinterlace_init(struct deinterlace_dev *dev)
 
 	deinterlace_clr_set_bits(dev, DEINTERLACE_CHROMA_DIFF,
 				 DEINTERLACE_CHROMA_DIFF_TH_MSK,
-				 DEINTERLACE_CHROMA_DIFF_TH(5));
+				 DEINTERLACE_CHROMA_DIFF_TH(31));
 }
 
 static inline struct deinterlace_ctx *deinterlace_file2ctx(struct file *file)
-- 
2.43.0


