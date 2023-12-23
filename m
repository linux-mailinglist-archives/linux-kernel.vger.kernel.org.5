Return-Path: <linux-kernel+bounces-10196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F1981D122
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 03:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E45431C21D8E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 02:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD70134DD;
	Sat, 23 Dec 2023 01:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="NfN20RaS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C970BEAD7
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 01:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3ba14203a34so2095220b6e.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 17:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1703296797; x=1703901597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Q6BFufqSpTpRSxFtBVFPQlLfAKF4PgzdI1kKWoUxZw=;
        b=NfN20RaSECVtQSiK8iuA1QIoq1Pm7j+0YTwq7+QqGcCnecGWHg08ZIF0lYKu4ersSY
         o76P1g2mdNIYtxsLaa1MNvUt5oGZFQSd+qiSx+KmXlpVok3dq9NuNZHRm42vBlW9hTf1
         gz8lA6XL9EI3PUpzYDmbIwVDnBKl5A5y+r3+jkI5QpiIC8nifzOL5do2CemCc1Q3TrZS
         Q5Uzd09vpEtzYejfal2QYv/Lm71je/bJIxE8/djXIw33THBrCOd3x0KSNgqre7kWNTXY
         a0SWjt9mtX4EWcfXKm86Z9nORT3Ei+F/erWEC/+jdHcJy8E/lqG+P+0Vjvbg6H1nayiY
         HXYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703296797; x=1703901597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Q6BFufqSpTpRSxFtBVFPQlLfAKF4PgzdI1kKWoUxZw=;
        b=h2I0+gtvj0nF8FT+ZH36JEiNX1T8L91vcmdxRcLabPRTmy/23+tBdCu/AxqOsZ5zuf
         HWhOAillbplkf32ARGsCePyc/qMMWeu103mXeD3CqKQXslVxd61k/tFo2VUjXvxxMT3p
         XWyEUOEsP5xklkoqNERSq0Tv76QcOCuUoSOotaLpOx8uOH1rkncvAQGlw3K/2EA8MQhV
         nOtPMAe62fUdvhVvgrn4WTC8vtqZc0KPplcoea+kbiOvnE+0HZzJhtY3hQFELzHb6TAS
         0QF7s/iLQs2heVfwMqtxlY3Yc2YHsMXdk4KIWVWsiKJJINwB9Hd3Nl1AeEI5qzvoz40d
         SH6A==
X-Gm-Message-State: AOJu0Ywx7ebAVHuVv5K3+Wmsu7Vw1gxUe/suT6pvu0IX9x1BJmrqB+rm
	1hoble1nlB9B1QE84HWVJZfZThb6uq9oQg==
X-Google-Smtp-Source: AGHT+IHuYu3aAWfG2k9qEnBgkaSHvXSnI4Cht8YZVKjPJH0bZPRvV/eCVvVXuWa8ks7/FNZUX0fEQw==
X-Received: by 2002:a05:6808:1708:b0:3b9:e2bf:c24e with SMTP id bc8-20020a056808170800b003b9e2bfc24emr2920662oib.15.1703296796891;
        Fri, 22 Dec 2023 17:59:56 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id kg15-20020a170903060f00b001d3edef115dsm4106546plb.20.2023.12.22.17.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 17:59:56 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 13/20] Staging: rtl8192e: Rename function rtllib_MFIE_Grate()
Date: Fri, 22 Dec 2023 17:59:35 -0800
Message-Id: <20231223015942.418263-14-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231223015942.418263-1-tdavies@darkphysics.net>
References: <20231223015942.418263-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename function rtllib_MFIE_Grate to rtllib_mfie_grate to fix checkpatch
warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib_softmac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 6a3a8e0bb036..f3de04b98803 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -61,7 +61,7 @@ static void rtllib_mfie_brate(struct rtllib_device *ieee, u8 **tag_p)
 	*tag_p = tag;
 }
 
-static void rtllib_MFIE_Grate(struct rtllib_device *ieee, u8 **tag_p)
+static void rtllib_mfie_grate(struct rtllib_device *ieee, u8 **tag_p)
 {
 	u8 *tag = *tag_p;
 
@@ -342,7 +342,7 @@ static inline struct sk_buff *rtllib_probe_req(struct rtllib_device *ieee)
 	tag += len;
 
 	rtllib_mfie_brate(ieee, &tag);
-	rtllib_MFIE_Grate(ieee, &tag);
+	rtllib_mfie_grate(ieee, &tag);
 
 	return skb;
 }
-- 
2.39.2


