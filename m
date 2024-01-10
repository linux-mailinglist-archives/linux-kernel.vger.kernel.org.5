Return-Path: <linux-kernel+bounces-22629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE61D82A0A3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 20:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94AD31F225E9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 19:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656344D5B7;
	Wed, 10 Jan 2024 19:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SXFMXL2t"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C62B4D599;
	Wed, 10 Jan 2024 19:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d3e6c86868so38741845ad.1;
        Wed, 10 Jan 2024 11:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704913338; x=1705518138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LDh1aB+UHwW4H+s9+zktm3TXhncAsGceGXjkcALz3Vw=;
        b=SXFMXL2tatK0mTpch4ViS7WMnxXDKpgipRtMfJUG76xwD9xUcqryzSxaSYe0PMCgdo
         li4IabjBm3QbxqHXI+ikV3sPVVWXLkfKAAsZmXLgU05FghD8xGnB3GEiTKs2q3yVrDk9
         Eifmd2/ZKKwuYCv1/eys4S4SHtEHXm79M9vKg2m3fk62loojeIlXuMKoEtu+9hZMl8Qt
         i5AhjauwPSCYoMmtQoUkMdupkjWyzCi+T+2Tm92pwF5LqG68S4am4lpjCBpKavxFDV4h
         SmOzlydeVbnBylXvSRDwAtyhqEYk5lr7dvnUwk9VKUNbcJtlNRT7aug8wtSXrMlNIv7d
         Z1Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704913338; x=1705518138;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LDh1aB+UHwW4H+s9+zktm3TXhncAsGceGXjkcALz3Vw=;
        b=QweZWZegYq7WRpW8PCwQFbPtvROZxPrVmVPCHFHhu8AV5SSsyiUoduo+pXCjku1ItT
         i2gNKUyBE/aLbcyiqXtah4wLRmsM0u+c/+XDj4UlFadgikTuUrvKKEiJXuN/ZBPbA+P6
         OGP6RYgoRxUhoy+6uCJ3HDYzSNNygVHFlharQbEvsA2tbtuw3Uhg2/inq6CU7aIWoQuV
         VoVFL/y7z0ruIAgOGerSUhM6HoBYHxl0hBjepPr1163K+hSaC10Crd5T+52B09kmhg+n
         h4S4SamMKqJJfRW9dItw5YNUCUmhOZOFg9mpAJRtBi/PVyetnizMFcWBAzC5WXYfaMKC
         OwBw==
X-Gm-Message-State: AOJu0Yzij+01IOiL7MSSGCeoBoBzbsXC7Kz+rXsQag8d+2jnyG0QvAin
	S4A0sgHQUgyVb6No9K1QKMJBocFENML0rQ==
X-Google-Smtp-Source: AGHT+IGuRalagriDoSGPZRcq3UiIV0VPioi2Fb6aJ2yvDOwd4E9jL2vE0mYtGDkJNLKL/rRWMyuITA==
X-Received: by 2002:a17:902:a385:b0:1d4:e234:2a20 with SMTP id x5-20020a170902a38500b001d4e2342a20mr1405017pla.67.1704913338478;
        Wed, 10 Jan 2024 11:02:18 -0800 (PST)
Received: from attreyee-HP-Pavilion-Laptop-14-ec0xxx.. ([2405:201:1f:60c9:2c28:b5eb:7eb8:74da])
        by smtp.gmail.com with ESMTPSA id s18-20020a170902989200b001d508715f5csm3954368plp.197.2024.01.10.11.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 11:02:18 -0800 (PST)
From: attreyee-muk <tintinm2017@gmail.com>
To: tj@kernel.org,
	jiangshanlai@gmail.com,
	corbet@lwn.net
Cc: attreyee-muk <tintinm2017@gmail.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation/core-api: fix spelling mistake in workqueue
Date: Thu, 11 Jan 2024 00:27:47 +0530
Message-Id: <20240110185746.24974-1-tintinm2017@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct to "following" from "followings" in the sentence "The followings
are the read bandwidths and CPU utilizations depending on different affinity
scope settings on ``kcryptd`` measured over five runs."

Signed-off-by: Attreyee Mukherjee <tintinm2017@gmail.com>
---
 Documentation/core-api/workqueue.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/core-api/workqueue.rst b/Documentation/core-api/workqueue.rst
index 0046af06531a..8c325a640862 100644
--- a/Documentation/core-api/workqueue.rst
+++ b/Documentation/core-api/workqueue.rst
@@ -446,7 +446,7 @@ The command used: ::
 
 There are 24 issuers, each issuing 64 IOs concurrently. ``--verify=sha512``
 makes ``fio`` generate and read back the content each time which makes
-execution locality matter between the issuer and ``kcryptd``. The followings
+execution locality matter between the issuer and ``kcryptd``. The following
 are the read bandwidths and CPU utilizations depending on different affinity
 scope settings on ``kcryptd`` measured over five runs. Bandwidths are in
 MiBps, and CPU util in percents.
-- 
2.34.1


