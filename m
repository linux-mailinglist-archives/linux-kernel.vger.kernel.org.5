Return-Path: <linux-kernel+bounces-18504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21765825E68
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 06:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A4A2B236BF
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 05:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24BD3107AB;
	Sat,  6 Jan 2024 05:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="KqdgBc3H"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC76F9C1
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 05:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6dbbc637df7so216209a34.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 21:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1704520580; x=1705125380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uKJQFXd3zRjGrXlevR2KqTB8Zpv5dll5vctsB1WQiTE=;
        b=KqdgBc3HbEPsGj9utn7KCOjPgNpD2NOjyk2iOznSsAO8DwjTjwxkK6h1ML86Lhubfs
         qvVXv1wkyM6z2U805Tp7ipXDOzxPkBINuJfygCCo9V5CrU+8arMdtR5m0Q8aQ0/xmwkh
         lIhbr20jg5cjT7SCT175YLLK8QjdWp0u1lctphW1ctH0Sgi5QEKBewR828U4MmOzdCEo
         2y5KykvzB1ikM1B4jXtmY3OV5YBa8vJKygyRPcdMuW321Dcc4ZqjQuAIfMKBjJ2Dt5DW
         iAbhJDT81BeBTct3MR8TMYWXlrotQN5sWfYb7UOZ63plbsdR3rEDtyjuOBuCMwZNtDY9
         ggKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704520580; x=1705125380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uKJQFXd3zRjGrXlevR2KqTB8Zpv5dll5vctsB1WQiTE=;
        b=hoqeAZRXMbMnCXmQFvxL9YyjnpCsRqrbeRe4eEhOxceG4AXOiwPGCe974YWyn8c4nH
         1mXbHq06dg1d5T0nkhRKs+mdf65vg6m9XaBWevpK1KHiM2pQpkBaLtZgtySrjcThZMHj
         oLZdeZlf4NXhGvRV6ykgDnsruDi2I53i8CZkSm9q7eUx/P3uV0mc9OGdpuHdxJIJAD+t
         UX7UQUQhZo2TBuqcHec5U6MLQUlxaDGH0XFpJ6DhEBG444LTbgC0fegN9AN1GcAblZ/T
         XNhf4RwUK6Og/5zWBvpuYO6pScBuxghv10JHwo8QeO3MB4FJfYvzl418E8yFD90nVLQX
         HZ5Q==
X-Gm-Message-State: AOJu0YzNXncb+VjNHDCp7axHXA6Qfrt6hFhnX4D66b1VSdnvgcekG6QS
	oxQ+ous/FwnTIu8dsGYkkpA7KDzDuQ6B2w==
X-Google-Smtp-Source: AGHT+IGG3k4pihsX+GgVGhkDXFcsF0YQU6PLWBkcS8Powtc1Yp3V5H5QTRquYYVlG/szEy/UutV67w==
X-Received: by 2002:a05:6830:1e0e:b0:6dc:aff:196a with SMTP id s14-20020a0568301e0e00b006dc0aff196amr517791otr.60.1704520580422;
        Fri, 05 Jan 2024 21:56:20 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id y29-20020a056a00181d00b006d99d986624sm2280873pfa.151.2024.01.05.21.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 21:56:19 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 14/21] Staging: rtl8192e: Rename variable RemoveAllTS
Date: Fri,  5 Jan 2024 21:55:49 -0800
Message-Id: <20240106055556.430948-15-tdavies@darkphysics.net>
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

Rename variable RemoveAllTS to remove_all_ts to fix checkpatch warning Avoid
CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_TSProc.c | 2 +-
 drivers/staging/rtl8192e/rtllib.h         | 2 +-
 drivers/staging/rtl8192e/rtllib_softmac.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_TSProc.c b/drivers/staging/rtl8192e/rtl819x_TSProc.c
index 7e73d31dcccf..48374cae816d 100644
--- a/drivers/staging/rtl8192e/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_TSProc.c
@@ -402,7 +402,7 @@ void RemovePeerTS(struct rtllib_device *ieee, u8 *addr)
 }
 EXPORT_SYMBOL(RemovePeerTS);
 
-void RemoveAllTS(struct rtllib_device *ieee)
+void remove_all_ts(struct rtllib_device *ieee)
 {
 	struct ts_common_info *ts, *pTmpTS;
 
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 26ceb579afeb..ed9ca77fbcb9 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1789,7 +1789,7 @@ void rtllib_ts_init(struct rtllib_device *ieee);
 void TsStartAddBaProcess(struct rtllib_device *ieee,
 			 struct tx_ts_record *pTxTS);
 void RemovePeerTS(struct rtllib_device *ieee, u8 *addr);
-void RemoveAllTS(struct rtllib_device *ieee);
+void remove_all_ts(struct rtllib_device *ieee);
 
 static inline const char *escape_essid(const char *essid, u8 essid_len)
 {
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index d7edfa1dca65..b9750c9b3952 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -2002,7 +2002,7 @@ void rtllib_stop_protocol(struct rtllib_device *ieee)
 		rtllib_disassociate(ieee);
 	}
 
-	RemoveAllTS(ieee);
+	remove_all_ts(ieee);
 	ieee->proto_stoppping = 0;
 
 	kfree(ieee->assocreq_ies);
-- 
2.39.2


