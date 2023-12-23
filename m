Return-Path: <linux-kernel+bounces-10441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 622A681D471
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 15:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2AD6B2199A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 14:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45957DDD9;
	Sat, 23 Dec 2023 14:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PCQPoNXZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1C7DDA1;
	Sat, 23 Dec 2023 14:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6d92e736787so1450002b3a.2;
        Sat, 23 Dec 2023 06:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703340727; x=1703945527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RcWAiO/J2RUT1lMSrBsyv6HQ++CXdRmemGMqnXk/qZ0=;
        b=PCQPoNXZfe62xgc6QxDjlbaFCqdmxFKqpjhsbZj0mdoH85rFRgEQBkxSUexWXEC9jx
         BT9ru/v7yvp0i5P7MII4TMCN0KCSC1eQQetT8rfq8rU7P2cUXg/2jF2TvYl1AjqGjpq+
         ZU1Uxy0DKaX5uIPU7x3/ikZMFSW15TJj3j0kur+T7wFvGO6rNtBL2KENS9lxlwBs+T1g
         Dg96SrX8bQM7YMN3nJ+ST6NNIPyWYt6VskpdAaVbICFh/24CYfPJlfIuX2RhREWXfaz/
         RnvOvPY24KaCUP98P9YufcfIRWVbr7Kr7vWAxHSQYy4y4Ge4Fb8NkNDGjPJcn8/7pBqG
         bRnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703340727; x=1703945527;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RcWAiO/J2RUT1lMSrBsyv6HQ++CXdRmemGMqnXk/qZ0=;
        b=A2hMo1/K2BQmIyZpaHVzfwlhs61UzrvbO/XishGeohLtKSwv8nWNndVc8p1s8ryI+U
         Oyee+OFu0hb5NIHQhuremYEpLVKuJPt8SRPsvzMdKyDCsNN2G3ZRw2F7QUg8SldyQaQ5
         8p61Guj2HARzGHy3iliNklxzSFZki3gNzRSPhQvZWPZXcP+NKa3wnYcde4jSo+UtJQ3v
         54G21+T6l6y6p8voiFFd94vQytezUVoBP8pCjSvgu+hAv5x3uRjGVx5BGWqm4giQof/m
         tHu0YF0GFvkypZU5te8AIfTouQB0qbw73E5ZpbVwkO/LgVe7AvulRzF+DWXne2uTB+RB
         AukA==
X-Gm-Message-State: AOJu0Yxi1T1dyeolL02qWTSTQXhH1GufFHYmE2+JHJGaSNqLrZDlrry+
	4AwqqfuGa9xcWJgYR5JHgBK5lbAkUAPglA==
X-Google-Smtp-Source: AGHT+IFYeAJzjCtGqN8pOQ6BiQqvnuF6hC6mBzUQbrAwNGmTM/JKG4w2VvmT8t710VhK8KX2XEIbCg==
X-Received: by 2002:a05:6a20:4c92:b0:18f:cc29:3d9e with SMTP id fq18-20020a056a204c9200b0018fcc293d9emr1513778pzb.119.1703340727582;
        Sat, 23 Dec 2023 06:12:07 -0800 (PST)
Received: from localhost.localdomain ([2400:1a00:b060:2b26:f462:e3d9:c28:4c99])
        by smtp.gmail.com with ESMTPSA id f17-20020aa79d91000000b006d9accac5c4sm260594pfq.35.2023.12.23.06.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Dec 2023 06:12:07 -0800 (PST)
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
Subject: [PATCH v3] staging: media: atomisp: pci: Fix spelling mistake in ia_css_acc_types.h
Date: Sat, 23 Dec 2023 19:56:57 +0545
Message-Id: <20231223141157.95501-1-kdipendra88@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

codespell reported spelling mistakes in
ia_css_acc_types.h as below:

'''
ia_css_acc_types.h:87: cummulative ==> cumulative
ia_css_acc_types.h:411: descibes ==> describes
'''

This patch fixes these spelling mistakes.
Word "cummulative" is changed to "accumulation"
and "descibes" to "describes".

Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
---
v3:
 - Changed "cummulative" to "accumulation" as suggested by Randy.
v2: https://lore.kernel.org/lkml/20231223051108.74711-1-kdipendra88@gmail.com/
 - Previously only corrected spelling  mistake reported by checkpatch.pl.
 - All spelling mistakes reported by codespell are fixed.
v1: https://lore.kernel.org/lkml/20231222200350.2024-1-kdipendra88@gmail.com/

 drivers/staging/media/atomisp/pci/ia_css_acc_types.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/ia_css_acc_types.h b/drivers/staging/media/atomisp/pci/ia_css_acc_types.h
index d6e52b4971d6..f6838a8fc9d5 100644
--- a/drivers/staging/media/atomisp/pci/ia_css_acc_types.h
+++ b/drivers/staging/media/atomisp/pci/ia_css_acc_types.h
@@ -84,7 +84,7 @@ struct ia_css_blob_info {
 		memory_offsets;  /** offset wrt hdr in bytes */
 	u32 prog_name_offset;  /** offset wrt hdr in bytes */
 	u32 size;			/** Size of blob */
-	u32 padding_size;	/** total cummulative of bytes added due to section alignment */
+	u32 padding_size;	/** total accumulation of bytes added due to section alignment */
 	u32 icache_source;	/** Position of icache in blob */
 	u32 icache_size;	/** Size of icache section */
 	u32 icache_padding;/** bytes added due to icache section alignment */
@@ -408,7 +408,7 @@ struct ia_css_acc_sp {
 };
 
 /* Acceleration firmware descriptor.
-  * This descriptor descibes either SP code (stand-alone), or
+  * This descriptor describes either SP code (stand-alone), or
   * ISP code (a separate pipeline stage).
   */
 struct ia_css_acc_fw_hdr {
-- 
2.39.2 (Apple Git-143)


