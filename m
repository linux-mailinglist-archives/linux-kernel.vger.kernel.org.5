Return-Path: <linux-kernel+bounces-18495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBF5825E5F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 06:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFBF3284F20
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 05:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2690679C3;
	Sat,  6 Jan 2024 05:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="SUYY73L3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB5C6ADF
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 05:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6dc076e9e59so169294a34.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 21:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1704520572; x=1705125372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AZypATw8H35ihqG9rrXc0EK6Jgq23KE6lbLiv2k1vYQ=;
        b=SUYY73L3qmEfeUzIKMhQToEwwgNmsQQaIo02j6WGCZrPYYtk6kO7JLroDtF2r0F/Zx
         VgiANszzcuX+vuOE9G59QA2iaRMYtz3EFXj5sziprhZ0Fd0qkOUGUE6hshGJ4n43OXcM
         9ItOIk8ZLZGQXxKtAL4t3qthNyIQE1ez+8ims+aLetJ9nj5zaOf49nW7mkrGPfO6dqKw
         Ep0bCSw7dwMiAxuUZuurnvITqR9h5x+GEmMTqlMXL3m+F/MYi8hpMul/MN9DsOW054dJ
         +rJAxPj7PLwZMPap+QQ0Ug7UhWfqjBMSwTTGd1Os3Y175T1k3rfCDve/y05DxUk8wRoR
         P4zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704520572; x=1705125372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AZypATw8H35ihqG9rrXc0EK6Jgq23KE6lbLiv2k1vYQ=;
        b=eX6pH3gEY4cqI+12i14PQeLWDgfqZA4OFuAs/VlvUUYyPBQSJgkJhFIgddXWuPAbCZ
         X/OLVQhwCH9GaLUTHM8WJSGOvlw2Mt02f8SHdw0kcnff7QrDlnCtEW/ZEP/9iSvwKYlC
         eAU4yywv6bAcfE94nUi64qPuQEykv9DbeLAMQ8waJezBvwsoKqw/1W3zTvRbzfOU9To9
         03nuXB9pqNSzDicgfenWpShou5c2Xn5ANiDEf9stlkdc5goq2ZB2rSKOkXrd4Mv81mzi
         1xKjOQkRkr1e6ZSnlROS3x7FXPP+Xr3MPLCiXYDZaEklpkrjeVhJZ7qUPX22dLz9Xz3L
         mVyw==
X-Gm-Message-State: AOJu0Yycmc0dXRbzGN+/bKWOapn3uRZy21noAeXWYGnNux+do+okvdnk
	kYDQetkj4Zftm8p2NG6Qa29eV4rmlqa4zExxmQhrIXrySsA=
X-Google-Smtp-Source: AGHT+IHw5dbqkWTzXcnD1+Uloj10USwtpp3x6uvXsevFn/L49TQeKGvCaip18M90KM0O5EDyfMM4Rw==
X-Received: by 2002:a05:6808:bca:b0:3bc:2fe8:8a48 with SMTP id o10-20020a0568080bca00b003bc2fe88a48mr643469oik.56.1704520572375;
        Fri, 05 Jan 2024 21:56:12 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id y29-20020a056a00181d00b006d99d986624sm2280873pfa.151.2024.01.05.21.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 21:56:11 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 05/21] Staging: rtl8192e: Rename variable MaxPeriod
Date: Fri,  5 Jan 2024 21:55:40 -0800
Message-Id: <20240106055556.430948-6-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240106055556.430948-1-tdavies@darkphysics.net>
References: <20240106055556.430948-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable MaxPeriod to max_period to fix checkpatch
warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib_softmac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 9db834f5d637..0d53e0a92a4c 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -1381,12 +1381,12 @@ static short rtllib_sta_ps_sleep(struct rtllib_device *ieee, u64 *time)
 		if (ieee->bAwakePktSent) {
 			psc->LPSAwakeIntvl = 1;
 		} else {
-			u8 MaxPeriod = 5;
+			u8 max_period = 5;
 
 			if (psc->LPSAwakeIntvl == 0)
 				psc->LPSAwakeIntvl = 1;
 			psc->LPSAwakeIntvl = (psc->LPSAwakeIntvl >=
-					       MaxPeriod) ? MaxPeriod :
+					       max_period) ? max_period :
 					       (psc->LPSAwakeIntvl + 1);
 		}
 		{
-- 
2.39.2


