Return-Path: <linux-kernel+bounces-10356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D8881D34D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 10:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37A0D285426
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 09:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA53944F;
	Sat, 23 Dec 2023 09:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0bj6ZPo"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FA28F4E;
	Sat, 23 Dec 2023 09:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-35d725ac060so10989715ab.2;
        Sat, 23 Dec 2023 01:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703322930; x=1703927730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EqU4At89cLX9pipG5dJk4yhFSAyDFeGlPgFtPpbBGJM=;
        b=Y0bj6ZPobw6Sv+o314yHtin9qHCNfNSac2Ertv0kjwwQGuFBJeV7e6rVq8FGF687O3
         CakBfwd6gIpz4HmZzuPkmPh1XqM5m3LQvtkc0Nb9a2WEbPzbEOjqwqDFUSVb4d6mf7FP
         wwTqyLPCBlqatXnrrQtd+HIPXIyhu/6dlJ6ol32BLUOqO8S2OzZj45fppPeEXQikxsLI
         vYmVCS2tb6fYc3UGLfXDk8Dt1mctdD0xNFnf2NhfW2Spiv6B2r77QA+KAOXM+gANqEQ3
         ASd5H0IUJrh0dSli78iQJu6B/leIOuRihBl2kKhckkbX1RRwL+63F6rc+m+Dfw7+ZNQl
         Uy1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703322930; x=1703927730;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EqU4At89cLX9pipG5dJk4yhFSAyDFeGlPgFtPpbBGJM=;
        b=MnKX2UcHXdY3Ns3qg1d01Z67MDkgsY5ECrVLnLvRvdRT4CM2KJQRgcyBkuAdabFS7R
         HzfZlHXOa9aoDucviLoucf/+FC9nIQStCJEzH13ejvYJulAO9sOtjgR3qCWqWivfzODb
         N387UaukRgjvr2bGh7z/hpGmEytksuaoNOIiPL2ZNxAlT00GZ56y/CHzbcy0Im76nlvw
         ++/8a5pEsDfXeUcj2vdcQJQrTnqRBiT288+JKuKjMqexQq49DaTQpXFfcYNzpNY4WOaJ
         cyELk1MjheXb2OGx7afzF47mrW2A5JPM1W4vf7Skw944o91S6ErsQlMHKO51agt13I2S
         kUIg==
X-Gm-Message-State: AOJu0Yy9dqSrTYdB3kMSxk1QDs2k1g8aDq2OsAYTWgCZAHk/aPf9g6yQ
	xfWBr80fsOp3W9rfghaBl04=
X-Google-Smtp-Source: AGHT+IGYqnq6An6iJM9CoXnlhddaGq6k5UXUB0u+ZIzGyEqqwpf89ybQ9Sp/R+KHDStSKxfSMQIumQ==
X-Received: by 2002:a05:6e02:1be5:b0:35d:59a2:1281 with SMTP id y5-20020a056e021be500b0035d59a21281mr3730843ilv.45.1703322930322;
        Sat, 23 Dec 2023 01:15:30 -0800 (PST)
Received: from localhost.localdomain ([2400:1a00:b060:2b26:f462:e3d9:c28:4c99])
        by smtp.gmail.com with ESMTPSA id p6-20020a170902eac600b001d365153d09sm4711179pld.184.2023.12.23.01.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Dec 2023 01:15:29 -0800 (PST)
From: Dipendra Khadka <kdipendra88@gmail.com>
To: hdegoede@redhat.com,
	mchehab@kernel.org,
	sakari.ailus@linux.intel.com,
	gregkh@linuxfoundation.org,
	hpa@redhat.com
Cc: Dipendra Khadka <kdipendra88@gmail.com>,
	linux-media@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] staging: media/atomisp/pci/runtime/binary/src: Fix spelling mistake in binary.c
Date: Sat, 23 Dec 2023 15:00:21 +0545
Message-Id: <20231223091521.85467-1-kdipendra88@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

codespell reported following spelling mistake
in runtime/binary/src as below:

'''
./runtime/binary/src/binary.c:537: spcification ==> specification
'''
This patch fixes thisspelling mistake.

Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
---
 drivers/staging/media/atomisp/pci/runtime/binary/src/binary.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/atomisp/pci/runtime/binary/src/binary.c b/drivers/staging/media/atomisp/pci/runtime/binary/src/binary.c
index 0f3729e55e14..130662f8e768 100644
--- a/drivers/staging/media/atomisp/pci/runtime/binary/src/binary.c
+++ b/drivers/staging/media/atomisp/pci/runtime/binary/src/binary.c
@@ -534,7 +534,7 @@ ia_css_binary_uninit(void) {
 static int
 binary_grid_deci_factor_log2(int width, int height)
 {
-	/* 3A/Shading decimation factor spcification (at August 2008)
+	/* 3A/Shading decimation factor specification (at August 2008)
 	 * ------------------------------------------------------------------
 	 * [Image Width (BQ)] [Decimation Factor (BQ)] [Resulting grid cells]
 	 * 1280 ?c             32                       40 ?c
-- 
2.39.2 (Apple Git-143)


