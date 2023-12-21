Return-Path: <linux-kernel+bounces-7888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5060581AEBA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 07:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C668DB2395F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 06:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27ABDB669;
	Thu, 21 Dec 2023 06:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R9arYC3M"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D2AB647
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 06:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5e7c1012a42so4890217b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 22:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703139877; x=1703744677; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ux7YJblT1o8powK/wjkuBKhpWvZytW7tRyNBPemyUJo=;
        b=R9arYC3MCyNQZOs4t3pssNXItrTvF1teV+ZvfddKPl8O243IOd6XfoYSQnf+Jt43y3
         w0f8r7p9+dyp894hBppWdaOhNA+yb3Qpn3PAx8lFFSp0shpFvt3r+ymmEMpqgll5PEfx
         9frcJxtzvdXx+CsPAVzyPawsBCrBWu74XM0YrGEY0lOP1OEa3whyAPZ4rRTqsNYCYnTu
         5EXDm7vOCHtoVV/xisG+jRXXY77VYfXRnXRrXWavUHwWlF7qX9IEiJTiqvS7I0nXZ5nO
         Iqu0H4VN6VV2M3BOWRDSBN/0UG3Je8QfPUJCpBNVGMDak2mLSNhJsAv0XEho5Bl9Kah2
         WPJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703139877; x=1703744677;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ux7YJblT1o8powK/wjkuBKhpWvZytW7tRyNBPemyUJo=;
        b=NrivtSw2QK5kS7k/8/N+xOBP16Lf2WXh2mKb2jvVNVVt09wNag3rnHoXnSgwEI0A/P
         jE2ch13MLsrXa1/L25DKZXcm7tWY0mUge8IBD/LWDFW8wC70O0Ah4xed8meiebizDG1R
         BIrdvyuzgOtBfbmaj2mAZ68nJj0A+XBx94bMCDxGFJjR7SVeJSNCYLN/nCZ0bCcBN7CF
         opDWUY9WPyF1orVb/GnRPN9QiIZwE3LoptCMNslR4CvhvAM7w9ov3cSFGUaS7AStLPkv
         EnpKUVTC124txcvUnN0dlcXns5G5JOwBOmKrHhimvW332QBY1PXCwE24zWeW3yErLIk9
         1Ixw==
X-Gm-Message-State: AOJu0YzYtRlR4E7Dx1gu7qFO9rCOkmNzMsyZZuDROzxDWLnMFrN89SRQ
	oZNoDKNFvYZtqQcaM5M13cT8cicgUkA=
X-Google-Smtp-Source: AGHT+IFuAJjblgc/7Ui3sbx2gsEil3Z1ZjY6JjDD+m5xtP/zxyNAwsucb+9lei1yW3DRSsCdJC4EvQ==
X-Received: by 2002:a0d:d990:0:b0:5e7:df55:3b1e with SMTP id b138-20020a0dd990000000b005e7df553b1emr937076ywe.12.1703139877000;
        Wed, 20 Dec 2023 22:24:37 -0800 (PST)
Received: from localhost.localdomain ([156.236.96.164])
        by smtp.gmail.com with ESMTPSA id k1-20020a170902ba8100b001d2ed17751asm756765pls.261.2023.12.20.22.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 22:24:36 -0800 (PST)
From: Yue Hu <zbestahu@gmail.com>
To: xiang@kernel.org,
	chao@kernel.org,
	linux-erofs@lists.ozlabs.org
Cc: jefflexu@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	Yue Hu <huyue2@coolpad.com>
Subject: [PATCH] erofs: allow partially filled compressed bvecs
Date: Thu, 21 Dec 2023 14:23:41 +0800
Message-Id: <20231221062341.23901-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: Yue Hu <huyue2@coolpad.com>

In order to reduce memory footprints even further, let's allow
partially filled compressed bvecs for readahead to bail out later.

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 fs/erofs/zdata.c | 36 +++++++++++++-----------------------
 1 file changed, 13 insertions(+), 23 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index a2c3e87d2f81..20a0cd415cf7 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1202,34 +1202,27 @@ static int z_erofs_parse_in_bvecs(struct z_erofs_decompress_backend *be,
 		struct z_erofs_bvec *bvec = &pcl->compressed_bvecs[i];
 		struct page *page = bvec->page;
 
-		/* compressed pages ought to be present before decompressing */
+		/* compressed data ought to be valid before decompressing */
 		if (!page) {
-			DBG_BUGON(1);
+			err = -EIO;
 			continue;
 		}
 		be->compressed_pages[i] = page;
 
-		if (z_erofs_is_inline_pcluster(pcl)) {
+		if (z_erofs_is_inline_pcluster(pcl) ||
+		    erofs_page_is_managed(EROFS_SB(be->sb), page)) {
 			if (!PageUptodate(page))
 				err = -EIO;
 			continue;
 		}
 
 		DBG_BUGON(z_erofs_page_is_invalidated(page));
-		if (!z_erofs_is_shortlived_page(page)) {
-			if (erofs_page_is_managed(EROFS_SB(be->sb), page)) {
-				if (!PageUptodate(page))
-					err = -EIO;
-				continue;
-			}
-			z_erofs_do_decompressed_bvec(be, bvec);
-			*overlapped = true;
-		}
+		if (z_erofs_is_shortlived_page(page))
+			continue;
+		z_erofs_do_decompressed_bvec(be, bvec);
+		*overlapped = true;
 	}
-
-	if (err)
-		return err;
-	return 0;
+	return err;
 }
 
 static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
@@ -1238,7 +1231,7 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 	struct erofs_sb_info *const sbi = EROFS_SB(be->sb);
 	struct z_erofs_pcluster *pcl = be->pcl;
 	unsigned int pclusterpages = z_erofs_pclusterpages(pcl);
-	const struct z_erofs_decompressor *decompressor =
+	const struct z_erofs_decompressor *decomp =
 				&erofs_decompressors[pcl->algorithmformat];
 	int i, err2;
 	struct page *page;
@@ -1274,10 +1267,8 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 	err2 = z_erofs_parse_in_bvecs(be, &overlapped);
 	if (err2)
 		err = err2;
-	if (err)
-		goto out;
-
-	err = decompressor->decompress(&(struct z_erofs_decompress_req) {
+	if (!err)
+		err = decomp->decompress(&(struct z_erofs_decompress_req) {
 					.sb = be->sb,
 					.in = be->compressed_pages,
 					.out = be->decompressed_pages,
@@ -1291,7 +1282,6 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 					.fillgaps = pcl->multibases,
 				 }, be->pagepool);
 
-out:
 	/* must handle all compressed pages before actual file pages */
 	if (z_erofs_is_inline_pcluster(pcl)) {
 		page = pcl->compressed_bvecs[0].page;
@@ -1302,7 +1292,7 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 			/* consider shortlived pages added when decompressing */
 			page = be->compressed_pages[i];
 
-			if (erofs_page_is_managed(sbi, page))
+			if (!page || erofs_page_is_managed(sbi, page))
 				continue;
 			(void)z_erofs_put_shortlivedpage(be->pagepool, page);
 			WRITE_ONCE(pcl->compressed_bvecs[i].page, NULL);
-- 
2.17.1


