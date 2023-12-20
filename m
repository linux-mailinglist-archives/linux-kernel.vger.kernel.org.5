Return-Path: <linux-kernel+bounces-6578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B20819A8D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACBA51F26898
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98251BDFD;
	Wed, 20 Dec 2023 08:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d8YXe6tG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D647F1C6A8
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 08:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5906cf5bfdfso921377eaf.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 00:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703061154; x=1703665954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B3J2rPBx+FXZQsZaRG05CEADXc2G390BDJ/COAaYzZA=;
        b=d8YXe6tGR8YPjOMOZM1wnngqXP3hf3cwpNXHO+my69pneXLGmtRo2f+sXYcWYcHRu1
         SR/zufXYTcJJNrt5DKAVsedByBFX/a+CDjQe5BXc20IPexMMCLACrU7V1PjCuvd3Wdx1
         SzIh76bBi/8OAByzCMFfTYUj/iUbIiBPG1lsCIZ6z6UHWIYNZjcUEZzoPKxmXnHt/+gi
         Bl/lS2UNrwC5/+iV3l4Wq9q2Cyza5N9hAqCpnaEUW6FMNzCgW0Iq98IArhDB8nZODSXr
         1hKCiAthVkvcw3fcdRLZyBcxAx8gLmwC5AVtipGybKvgKY6JlveKo8MhXtYeldZiMtHY
         9WZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703061154; x=1703665954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B3J2rPBx+FXZQsZaRG05CEADXc2G390BDJ/COAaYzZA=;
        b=eYcMtIMHX1fEvJiNJUGtvGd6KAZqI7zTHMqJx4P+CHGJ4dev2fsv6KScpWyTLO633g
         q5cughbOI6VGy4hvh1UmbkSos7D6liDvj2bjo64VvxPfbNWdzlBd+bkfrKMW7Ap5W65H
         Gp/QD5UTlloCwvmy9Trfl8uD9NK9oRc9W/QuUIoQGJMx16iGM0v5iPkTaVOXxrv36+jE
         4Noqn1ocH1Dh0m5cSvzAqD1sGznLykDaM6jh5uWmpYyFGK9d0qG2n4BaiZIWCwmxwbPh
         Mlj5e42HZIN573NBCFAM4Inj20r7A2CFKvpJd8iBhM8G003qNeaYJ6UO+LnZ2JGYfkaK
         cvaA==
X-Gm-Message-State: AOJu0Yyf0J2VGW9HWcfXNgZR8SlCRXvGsmA8iCnV/ga/cSWXo2vVmhq7
	7M0ApliQBLDg3nVezuVTlN8=
X-Google-Smtp-Source: AGHT+IHrPNPRKcTD/OU/y/PU9GrvBikRh6uK8FFag5EJAkibRevkz/2bwkns6Gd9QqpaFD0rbzw+lg==
X-Received: by 2002:a05:6359:4595:b0:173:e288:2808 with SMTP id no21-20020a056359459500b00173e2882808mr32975rwb.3.1703061153718;
        Wed, 20 Dec 2023 00:32:33 -0800 (PST)
Received: from localhost.localdomain ([140.116.154.65])
        by smtp.gmail.com with ESMTPSA id r13-20020aa79ecd000000b006d49ed3eff2sm6583815pfq.75.2023.12.20.00.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 00:32:33 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: akpm@linux-foundation.org
Cc: irogers@google.com,
	linux-kernel@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH 1/2] min_heap: Optimize number of calls to min_heapify()
Date: Wed, 20 Dec 2023 16:32:23 +0800
Message-Id: <20231220083224.3712113-2-visitorckw@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231220083224.3712113-1-visitorckw@gmail.com>
References: <20231220083224.3712113-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch improves the heap construction process by reducing
unnecessary heapify operations. Specifically, it adjusts the starting
condition from n / 2 to n / 2 - 1 in the loop that iterates over all
non-leaf elements.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 include/linux/min_heap.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/min_heap.h b/include/linux/min_heap.h
index 44077837385f..18a581310eb3 100644
--- a/include/linux/min_heap.h
+++ b/include/linux/min_heap.h
@@ -70,7 +70,7 @@ void min_heapify_all(struct min_heap *heap,
 {
 	int i;
 
-	for (i = heap->nr / 2; i >= 0; i--)
+	for (i = heap->nr / 2 - 1; i >= 0; i--)
 		min_heapify(heap, i, func);
 }
 
-- 
2.25.1


