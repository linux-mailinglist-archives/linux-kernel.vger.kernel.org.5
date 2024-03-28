Return-Path: <linux-kernel+bounces-122991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 924A88900C1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C21F2945D9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D64C80BEC;
	Thu, 28 Mar 2024 13:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="Fzrq1x3N"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1012D56B77
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 13:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711633661; cv=none; b=pdfzI06WTy9CbTk3axlVmLO6EcUHldxUDaF79hO1npDMwRnHDSSOdDlfXX4anMYq2UpdUQE6oCLi0ZZf+VFDElr1tACxZxHD36R19c0fVzQrzERPwHD8UsxJciVaqus6acizxKR6t5xoR7V+0OAX22vHbrynh9PJ9t0JDohNGQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711633661; c=relaxed/simple;
	bh=urpF+uhnagsRIlmCvAoqVf0cSl1JhJfWoktomJ+ip1k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lDEQQB33Osc83bvJ1SxEYOHBrGng1/vwFTXjkKjo3ByuJ2HSL5EWvQ6YSMHmF6ZE7rK3PywHIZ88LVXYxsJU2zTTny6fdVnP+o+Po/iERDCQsNjOVb1UBhmbD7WcEXPb9lhiLWM2mFvUSw7cA2y5kRvq0mjKinfijHk+h299IYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=Fzrq1x3N; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a466fc8fcccso128249366b.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 06:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1711633657; x=1712238457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GxzVOZoRlwbh3BCja72w8JfT19aYOorMwhFDDTCvDh0=;
        b=Fzrq1x3N2q/eu7jyvo5orUU6iNcfIjp9NlWREakYVLy1qIQOdQ1KOLUwAlLTw8iUSS
         Qqv2VzYmgTupchTiG0nfFPsvDTMMrdg6xEpqL0ZgnC8JVZGl559X/+PyleRlP45XdZZ9
         CkraUi8hNO5np1RAJVXfRQuNkUwZt/9FxGro3qOepFQ4YOFlFACF2PdBLifj48lqi2cT
         h9e9sTMeweB+AabLRGi+tRFT+yAqTBuC1vfIhA982l1xnb1hOSHCnNd1/ma2lGoRnixc
         nihDBWPU+nOCeT1ewZGwuHTC61cZ2YJE98LscYtlzLdc1w+4u9YER62Gi+uupXuFLbo2
         NeIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711633657; x=1712238457;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GxzVOZoRlwbh3BCja72w8JfT19aYOorMwhFDDTCvDh0=;
        b=mAxyUkct13Hp4iJr3LPIFmB+YYI0p1NwDD99WV3dNLS1HwhvR+6RVZ94saibLc5xEb
         5SLHuWLNSJU/hJTUGSkYpNhmM5UsqZnIlGGk013W8YKxJrmfF+bhiOF3goWp0CT6W+9g
         VtyjLXRVmsXzH7i/47Q1YA4y+S6FivampDCCJzHPGNVRcjWFXTYL5pRHnygYxacPA+2m
         rjrpEHg7IQWpcyfywnIfotBwqdea/QAJ2AitCWnMuG66Mo/ORf1s6QdIcYF+kzqaeJyF
         bCnIyW+6HjDFdFsiYnk1IG++irrNjiKrq+GWcYW9S+DFxOwTDfhlUq6T0T+bRZRHtHI0
         J/xg==
X-Forwarded-Encrypted: i=1; AJvYcCXRp50WR+fXr0T439qJX6yYoyRTQCmub7kTDEBboJQRA5Jt0bdVALySSVqeKh2B/sfihjdhSa81rmZhHA0ubVHuqSlkmYQ4A2yW5JLA
X-Gm-Message-State: AOJu0Yyb1/6CTGs1ibXpXibAxgDdtErlzw/h1mKKrbTIl6kDJ2jCpWpV
	zBixFDfKYzVZxh20ZYyBWiwWMwGf6CrZ+CoK7i7ukvsbmi3pMt3UXa50Ndj7CJ6IiZcHd+KGR+P
	0k+g=
X-Google-Smtp-Source: AGHT+IGpawLg28p3E5615Qyo+gXkEKgAfaMlSgEerS9cHHYKKRGks+Jt2ipv8BUlRar8DJhPLu6AUg==
X-Received: by 2002:a17:906:c14c:b0:a4e:19f4:8452 with SMTP id dp12-20020a170906c14c00b00a4e19f48452mr1831832ejc.11.1711633657415;
        Thu, 28 Mar 2024 06:47:37 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-212.dynamic.mnet-online.de. [82.135.80.212])
        by smtp.gmail.com with ESMTPSA id gy16-20020a170906f25000b00a45f2dc6795sm765908ejb.137.2024.03.28.06.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 06:47:37 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: Dan Williams <dan.j.williams@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] raid6test: Use str_plural() to fix Coccinelle warning
Date: Thu, 28 Mar 2024 14:15:22 +0100
Message-ID: <20240328131519.372381-4-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes the following Coccinelle/coccicheck warning reported by
string_choices.cocci:

	opportunity for str_plural(err)

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 crypto/async_tx/raid6test.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/crypto/async_tx/raid6test.c b/crypto/async_tx/raid6test.c
index d3fbee1e03e5..3826ccf0b9cc 100644
--- a/crypto/async_tx/raid6test.c
+++ b/crypto/async_tx/raid6test.c
@@ -11,6 +11,7 @@
 #include <linux/mm.h>
 #include <linux/random.h>
 #include <linux/module.h>
+#include <linux/string_choices.h>
 
 #undef pr
 #define pr(fmt, args...) pr_info("raid6test: " fmt, ##args)
@@ -228,7 +229,7 @@ static int __init raid6_test(void)
 
 	pr("\n");
 	pr("complete (%d tests, %d failure%s)\n",
-	   tests, err, err == 1 ? "" : "s");
+	   tests, err, str_plural(err));
 
 	for (i = 0; i < NDISKS+3; i++)
 		put_page(data[i]);
-- 
2.44.0


