Return-Path: <linux-kernel+bounces-18977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3AC8265E6
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 21:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F580B21233
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 20:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6ED81170B;
	Sun,  7 Jan 2024 20:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nHHnLlO/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CCA11706
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jan 2024 20:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6dbca115636so882300a34.2
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jan 2024 12:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704658296; x=1705263096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=1b8e21clHAmMPOYbZiWTXEyiEfMJUEfeitTlfuueab4=;
        b=nHHnLlO/DnUy6ZIzxiOrF+MWupzMi+h/k4/qHDDAiQCEsZl1Dta7r0InGNnEY3p4I0
         MB4nrvZF2/CO0f458Y6zKmZ/e2SgpN48+DBWHW/ghsCqKzSzVwMHp9lT53PqsiyT9R+7
         eAO5K9ATJl0EetOfiskwLt09xz6mJDL1yXDjmBvQe1W7eHSdImKZbmOmxRnVB5h5ZQFd
         51wfTM5nvnFE9axk0ZUumAA0LukRwk57CG7zAE8Jj7x7357hwnhKe5ILv/1y3v7y3PYI
         NT/D8vPJmh3pPOIK8nblFNI2sjwA3gpm/yFlXrDXAmImZrgOYb1m7jY+rfGaTFEuQNtv
         lVmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704658296; x=1705263096;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1b8e21clHAmMPOYbZiWTXEyiEfMJUEfeitTlfuueab4=;
        b=EKWclQb+kWIyw2l24WQBe4PqNX7vZ3dg7XdC680R6/kHzq98W6+8uaKnXljR3zLB5I
         zHjXhhbTlKzvcf+0pkfp3emQtZ5DhrhJYTyEAmK6O3L7mHs9cD2Ci9iTC3pB1FS5ncxZ
         iy3vg4SDeFoquAh0hmBbkXcBjaTXJVr5BgOsWaybXFQL5jLO+QCMNHM3cTV3xoHqEhlx
         UgZWcLeS/CDleJqJdK7UpgfthJY+Qg3GbwlHRvoSmwWsuyic1yD8+RfNLX/nTNpl85kj
         DRIz9s0I0GHRZ4IL+LZhuOGxRXQ8j0RDjvIwevohJGrkg+HYhavXSEyPB2vSp31EYiyk
         4Usg==
X-Gm-Message-State: AOJu0Yx9mqoYbRl6IQYeLFOqcBD3slw46pswxWJKjIpigINN1FAaRIFj
	yLV9VYMIfO/wQYuQTfMSJcI=
X-Google-Smtp-Source: AGHT+IHmYNA0IwD69EHrBAZyJIWda5C9oCZOg0K9/FBWdnnlummg/WyzHwqVuezfwmBEgd8Mxql4Yw==
X-Received: by 2002:a9d:7d97:0:b0:6dc:214:62cf with SMTP id j23-20020a9d7d97000000b006dc021462cfmr1970922otn.49.1704658295957;
        Sun, 07 Jan 2024 12:11:35 -0800 (PST)
Received: from tw-mattjan.client.tw.trendnet.org (223-139-146-146.emome-ip.hinet.net. [223.139.146.146])
        by smtp.gmail.com with ESMTPSA id h20-20020a056a00231400b006dabdfabe12sm4629824pfh.193.2024.01.07.12.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jan 2024 12:11:35 -0800 (PST)
From: Matt Jan <zoo868e@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Laight <David.Laight@ACULAB.COM>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Mark Brown <broonie@kernel.org>,
	Matt Jan <zoo868e@gmail.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] minmax: allow comparisons of 'long long int' against 'unsigned char/short/int'
Date: Mon,  8 Jan 2024 04:11:29 +0800
Message-Id: <20240107201129.6106-1-zoo868e@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since 'unsigned int' get promoted to 'signed long long int' it is safe
to compare them against an 'long long int' value.

Signed-off-by: Matt Jan <zoo868e@gmail.com>
---
 include/linux/minmax.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/minmax.h b/include/linux/minmax.h
index 2ec559284a9f..61171286b468 100644
--- a/include/linux/minmax.h
+++ b/include/linux/minmax.h
@@ -37,7 +37,7 @@
 
 #define __types_ok(x, y) 					\
 	(__is_signed(x) == __is_signed(y) ||			\
-		__is_signed((x) + 0) == __is_signed((y) + 0) ||	\
+		__is_signed((x) + 0ll) == __is_signed((y) + 0ll) ||	\
 		__is_noneg_int(x) || __is_noneg_int(y))
 
 #define __cmp_op_min <
-- 
2.34.1


