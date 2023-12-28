Return-Path: <linux-kernel+bounces-12458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 171D281F50E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 07:28:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9A25282D34
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 06:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9CD63D3;
	Thu, 28 Dec 2023 06:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="RkYOYQ/X"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579895393
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 06:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5c6839373f8so3614674a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 22:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1703744862; x=1704349662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Sxksy5E1CXPNQaU5KEcULgXjRO+AwfRR0MftjysBlZ4=;
        b=RkYOYQ/XFuJZzzuSorZBnV3UITFneEd0OlCsW/GA7Ht1u+xgqjaXMIHafH9NPxpAZ0
         0mlO5dNftx/gBfkJQ3Qh+ej1MBhGAv5GPPYGFBucPEHvFMSFmM5NS6wvuVFlTABUw+L5
         Kkqo7bwhNP2fAb25ZgigjaOybZEoN6+DiE4b7TX56NbXtUtTr2SgsWZpfwq8dyBxqP1x
         5Dtxri5bLQcvvNo15YVOC7lsbeg1iV0j8f6T8BfiJY4BYeiVlVgl4fWiNSMjwMfnGLFs
         sOfjaLbAgTaMZ11dEaiNdBeex8ZYAr1+ZbuJsgZVYCFGfVTv23PU+e0CzL1MG0s10HKV
         M5KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703744862; x=1704349662;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sxksy5E1CXPNQaU5KEcULgXjRO+AwfRR0MftjysBlZ4=;
        b=CnIXJlDgtkM1saI71fvOiA9rN10J1f1BuipgUm/SNkNlSZv/HqrfsIaCW/zsVPXT+P
         NjQoCcExvj/20mjcT0M/ll8yfvWCS8a/6SemZyfkFpLfLAQ4NAyKCyPn9sqOGUIJLUqc
         t1v/zu8wttLDDh/YX8AWHTJ9zpNNNjHhKLW8GiA5qnd9HBsirWbTuFH9zw/U3obSRsKN
         pzp0A3wUaAVOtkrG5ZiQs9t+o8sbPHGIub6efmksBjISJUM4cvxNTzVwwGZdYeyDwAwT
         A01ArijhfynxS6y+prpLPN9EBV4SBPShJTFO1Z3tYJz5d5gRPVBkYgIHTRaKyzOTAnVy
         nELA==
X-Gm-Message-State: AOJu0YwhKUHXXJXEPqSyb8KeTCqq009Um7ESR5y4tZIQwwlRMvXq7sGA
	ZMQmVnn398wtMW112lCuFQRJiBkh++EfNQ==
X-Google-Smtp-Source: AGHT+IExoqG6TYQqLn0OnAq6VLiclfq02Y56Zw1IOvsAWdRwAxq+zPudXZrPXlHZ4GlBVGHKi/7U7w==
X-Received: by 2002:a05:6a20:7346:b0:196:2c18:fe7 with SMTP id v6-20020a056a20734600b001962c180fe7mr1993962pzc.14.1703744862596;
        Wed, 27 Dec 2023 22:27:42 -0800 (PST)
Received: from ubuntu-haifeng.default.svc.cluster.local ([101.127.248.173])
        by smtp.gmail.com with ESMTPSA id g5-20020aa78745000000b006d9af8c25easm7681381pfo.84.2023.12.27.22.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 22:27:42 -0800 (PST)
From: Haifeng Xu <haifeng.xu@shopee.com>
To: roman.gushchin@linux.dev
Cc: akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	shakeelb@google.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Haifeng Xu <haifeng.xu@shopee.com>
Subject: [PATCH 2/2] mm: list_lru: remove unused macro list_lru_init_key()
Date: Thu, 28 Dec 2023 06:27:15 +0000
Message-Id: <20231228062715.338672-2-haifeng.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

list_lru_init_key() isn't used by anyone, remove it to clean up.

Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
---
 include/linux/list_lru.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/list_lru.h b/include/linux/list_lru.h
index b35968ee9fb5..57a445a5001f 100644
--- a/include/linux/list_lru.h
+++ b/include/linux/list_lru.h
@@ -62,8 +62,6 @@ int __list_lru_init(struct list_lru *lru, bool memcg_aware,
 
 #define list_lru_init(lru)				\
 	__list_lru_init((lru), false, NULL, NULL)
-#define list_lru_init_key(lru, key)			\
-	__list_lru_init((lru), false, (key), NULL)
 #define list_lru_init_memcg(lru, shrinker)		\
 	__list_lru_init((lru), true, NULL, shrinker)
 
-- 
2.25.1


