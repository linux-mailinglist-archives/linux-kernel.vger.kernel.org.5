Return-Path: <linux-kernel+bounces-10198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D88F681D124
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 03:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 164291C248FB
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 02:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DBC171C9;
	Sat, 23 Dec 2023 02:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="VX5lbiDw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B3212E5B
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 01:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6d94308279dso1671421b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 17:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1703296798; x=1703901598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AQASuLJkfj6JGfN3KLOQcSo/x55SwyZt5DE4a4HIGbE=;
        b=VX5lbiDwCn4xPPwcOO33oN3rmPhdgDiapuiE0GIymh9rBVRHXWyQc7Zl1hY1v1Rpcd
         ufOdgy1gCs+cdt5Gs4rmhWjL9KJ/M42O5HcwFp4Wwewe4o1KeDSoyhDANTpBxQ/SY3L4
         Nz6eQpcs/AHgYvQvV7O4FeFHl0XctHVBzjjXv4a9ETZsy/Mb86JCeMIxKBbAXBvadO1X
         SsGcCmTyw/0uAcFtjmUeDDBukY8fslA6Jd307+auOuKp4O6+AWeB+yDwcZ0yG0aF2Vx7
         gH8jD4Z6/rL9BianB5pKmkFeQRAf+V25LxWT61uv4op1tMhdf0PMChpYU7FdwWW1r21c
         otOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703296798; x=1703901598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AQASuLJkfj6JGfN3KLOQcSo/x55SwyZt5DE4a4HIGbE=;
        b=i5N6jZwpCA2iN/HuhaJUMDf3acBptQjwkHUg1IBEdDkJGqApsqs0GFjQVD9KrRYkGx
         Mj2K0AgertwJXLI/gVSqgYNXBrq/lBoq2gJWmuIX/ZWWGLTx/3+XACnZByW8kaBGSFUX
         L1aMUWNGPOPsu7haGTwfpaCaS1wyAEhg+bNN95BWOAwJ1CGTPObI0wxPqpz9D0kS9f++
         CfuyKWJuOgsefSkKmCNDajkgATURUNX9PI61Pev7M+GsEeut4UkLl3OA0okvTHi47VY2
         +bx/hyjnwphgS+woetJHyBFuKh5y8IhsblN+vvgqYhOtt+s4q2zIh8Zho0ndx6SVZFHc
         45QA==
X-Gm-Message-State: AOJu0YzHXp4Q6kj2Oit5eDiB0ibUfM7VxE7mAZZHY5YxTsVUBCSbNerb
	zd73R7MsS8E8MErAtwszeKEGAs0jsBX7/D/Hp5iq8F0gdaQ=
X-Google-Smtp-Source: AGHT+IHVWLXExY/Z3oeZ+BjLqZMoRwHKa81HTztxySpXzFlRjWFeSo/VKxW4bboQ5cPLo1vjmAHzmQ==
X-Received: by 2002:a17:902:6b89:b0:1d0:6ffd:ceca with SMTP id p9-20020a1709026b8900b001d06ffdcecamr1413128plk.131.1703296798534;
        Fri, 22 Dec 2023 17:59:58 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id kg15-20020a170903060f00b001d3edef115dsm4106546plb.20.2023.12.22.17.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 17:59:58 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 15/20] Staging: rtl8192e: Rename function rtllib_TURBO_Info()
Date: Fri, 22 Dec 2023 17:59:37 -0800
Message-Id: <20231223015942.418263-16-tdavies@darkphysics.net>
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

Rename function rtllib_TURBO_Info to rtllib_turbo_info to fix checkpatch
warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib_softmac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 7cd7ffcda58e..0819efe36171 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -98,7 +98,7 @@ static void rtllib_wmm_info(struct rtllib_device *ieee, u8 **tag_p)
 	*tag_p = tag;
 }
 
-static void rtllib_TURBO_Info(struct rtllib_device *ieee, u8 **tag_p)
+static void rtllib_turbo_info(struct rtllib_device *ieee, u8 **tag_p)
 {
 	u8 *tag = *tag_p;
 
@@ -896,7 +896,7 @@ rtllib_association_req(struct rtllib_network *beacon,
 
 	if (turbo_info_len) {
 		tag = skb_put(skb, turbo_info_len);
-		rtllib_TURBO_Info(ieee, &tag);
+		rtllib_turbo_info(ieee, &tag);
 	}
 
 	if (ieee->ht_info->current_ht_support && ieee->ht_info->enable_ht) {
-- 
2.39.2


