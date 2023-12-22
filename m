Return-Path: <linux-kernel+bounces-10046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E34981CF1C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 21:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 407611C22E81
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 20:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6B52E83E;
	Fri, 22 Dec 2023 20:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ln4cAeBU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686C72E821;
	Fri, 22 Dec 2023 20:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6dbb2403fa2so1593036a34.2;
        Fri, 22 Dec 2023 12:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703275446; x=1703880246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z5DKwbg4XD2gV+sjQTXut6IiDwsF80T3W1JqgBXYfc8=;
        b=Ln4cAeBU6D0cde+UgWC3S40O4SJExSGaVLPJiZZ/N33ZR/R8U5yXEr/e5a/j66Faak
         siXl8e6vq/9Tg/+42sDZd/l0LEcdJJppZO0rdE8DzVEo9TOWArCB96zs2/cyJspTKzKj
         WDLU8Re0t93xV8xJjmis9VAXnj3WnT+peM6eiP6oTHp8abgu25KTKYCv3jVZXrxXJbzz
         ZTTCQCj6htM2laJQ6e/uakuljpEfEPGMPqkOP78lRKfZiL2jxNYcpr9/Auvic+G0AIQD
         WLCd3WuuziXo9WjRWXleOZHeYEGPc2tRhfVkg8ARrs+yx3kS+E9SBt9OwS+DntOfSTuR
         7jfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703275446; x=1703880246;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z5DKwbg4XD2gV+sjQTXut6IiDwsF80T3W1JqgBXYfc8=;
        b=jG4rYyPHfnQC0o4LQlF8t4FpL6TxV4VT7O4kKlO5k274CfVmLtfN8Tg2t2QXf6pIP7
         KJCWKfcc2rXJM7pgNXYDC1Tjbth/1ly0HlvZ/95l4F5QPi1t1MJx1Y2N0jcENFLal/YX
         nIN0fyJbE6Nt/dqp3GVkWrjjtEsMsXdQPr9MHLyU7/aaRPtYT0ykEVT+dk7uF11FVwfO
         s+L2Q9VQ3IVTVFlsuTKo1Ya7LPiUEPYeOuFYLo67W9OazItpWA/yleeJO6oKqx/ORrtz
         3sordDJSB7ev89RDiyj7vqeYffvP/jxu8fz3h3BYHLj4TSKthJ7obVDXmn22xUQhOCyp
         yhzg==
X-Gm-Message-State: AOJu0YwgK6nM82iSRaQyWS/v1uE2hsbsNp+bxfXdFQRW27pKP+E6VfzI
	upiDWU4GgWewniYHa8lXbSY=
X-Google-Smtp-Source: AGHT+IGI+TxAGisu6bOpbKbHegQHk0kyWT7zWdfFSEsiGmXu5WjJvdAC+X2rqKb9XwCMmp7IWwGZSQ==
X-Received: by 2002:a05:6358:2799:b0:174:d909:c8da with SMTP id l25-20020a056358279900b00174d909c8damr794152rwb.39.1703275446271;
        Fri, 22 Dec 2023 12:04:06 -0800 (PST)
Received: from ubuntu.. ([202.166.220.102])
        by smtp.gmail.com with ESMTPSA id fw2-20020a17090b128200b0028c2844d285sm160945pjb.49.2023.12.22.12.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 12:04:05 -0800 (PST)
From: Dipendra Khadka <kdipendra88@gmail.com>
To: hdegoede@redhat.com,
	mchehab@kernel.org,
	sakari.ailus@linux.intel.com,
	gregkh@linuxfoundation.org,
	hpa@redhat.com
Cc: Dipendra Khadka <kdipendra88@gmail.com>,
	linux-media@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: media: atomisp: pci: Fix spelling mistake in ia_css_acc_types.h
Date: Fri, 22 Dec 2023 20:03:50 +0000
Message-Id: <20231222200350.2024-1-kdipendra88@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The script checkpatch.pl reported a spelling error
in ia_css_acc_types.h as below:

'''
WARNING: 'cummulative' may be misspelled - perhaps 'cumulative'?
        u32 padding_size;       /** total cummulative of bytes added due to section alignment */
                                          ^^^^^^^^^^^
'''

This patch corrects a spelling error,
changing "cummulative" to "cumulative".

Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
---
 drivers/staging/media/atomisp/pci/ia_css_acc_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/atomisp/pci/ia_css_acc_types.h b/drivers/staging/media/atomisp/pci/ia_css_acc_types.h
index d6e52b4971d6..ac6fb0eb990a 100644
--- a/drivers/staging/media/atomisp/pci/ia_css_acc_types.h
+++ b/drivers/staging/media/atomisp/pci/ia_css_acc_types.h
@@ -84,7 +84,7 @@ struct ia_css_blob_info {
 		memory_offsets;  /** offset wrt hdr in bytes */
 	u32 prog_name_offset;  /** offset wrt hdr in bytes */
 	u32 size;			/** Size of blob */
-	u32 padding_size;	/** total cummulative of bytes added due to section alignment */
+	u32 padding_size;	/** total cumulative of bytes added due to section alignment */
 	u32 icache_source;	/** Position of icache in blob */
 	u32 icache_size;	/** Size of icache section */
 	u32 icache_padding;/** bytes added due to icache section alignment */
-- 
2.34.1


