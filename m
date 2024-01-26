Return-Path: <linux-kernel+bounces-39946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DCE83D7B3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1315028315B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF226A32A;
	Fri, 26 Jan 2024 09:39:23 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7306BB46;
	Fri, 26 Jan 2024 09:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706261963; cv=none; b=BYm7kDeSHcvMiehIo9A6pKDVIF6xGMbfN5SjFUtZpod/sgMWz5Z8abPUcobOVo/byL5jrc3EUjSiUr8RJkhY3ELYHXnuSC+/MXdXJJslrpuWLnaLXxI2UQe154ZQss/v8urtQa7XYJWru+Hq5zMHqvZDvvZLl5Thz9sSsteTpaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706261963; c=relaxed/simple;
	bh=e+C36Q43Qeei6Lm9MboS30nhGPgx0zgzSY2HVCAP0Dk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JWT0r/qumf/0kuj92cXh8l9pdEQ7Yc0mSaJFLB0+kPl/5luzQxrTVwgtXOFypM47kKtkH8uS3w3+h170rlN+uuqO92zg7nxEJbdDKgOCicpGGyT41roRSzIaG5rQ3de8zGHBjbD5E87Z02qlcxib78a3/tr4Z9lFGQ3fVqLx1xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4TLt0c2ZKzz18Lvw;
	Fri, 26 Jan 2024 17:38:08 +0800 (CST)
Received: from dggpeml500001.china.huawei.com (unknown [7.185.36.227])
	by mail.maildlp.com (Postfix) with ESMTPS id 9597F18001C;
	Fri, 26 Jan 2024 17:39:13 +0800 (CST)
Received: from huawei.com (10.69.192.56) by dggpeml500001.china.huawei.com
 (7.185.36.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Jan
 2024 17:39:13 +0800
From: Qi Tao <taoqi10@huawei.com>
To: <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
	<liulongfang@huawei.com>
CC: <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>
Subject: [PATCH v2 1/4] crypto: hisilicon/sec2 - updates the sec DFX function register
Date: Fri, 26 Jan 2024 17:38:25 +0800
Message-ID: <20240126093828.14131-2-taoqi10@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240126093828.14131-1-taoqi10@huawei.com>
References: <20240126093828.14131-1-taoqi10@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500001.china.huawei.com (7.185.36.227)

As the sec DFX function is enhanced, some RAS registers are added
to the original DFX registers to enhance the DFX positioning function.

Signed-off-by: Qi Tao <taoqi10@huawei.com>
---
 drivers/crypto/hisilicon/sec2/sec_main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/crypto/hisilicon/sec2/sec_main.c b/drivers/crypto/hisilicon/sec2/sec_main.c
index 7bb99381bbdf..5fc4d56ee873 100644
--- a/drivers/crypto/hisilicon/sec2/sec_main.c
+++ b/drivers/crypto/hisilicon/sec2/sec_main.c
@@ -282,6 +282,11 @@ static const struct debugfs_reg32 sec_dfx_regs[] = {
 	{"SEC_BD_SAA6                   ",  0x301C38},
 	{"SEC_BD_SAA7                   ",  0x301C3C},
 	{"SEC_BD_SAA8                   ",  0x301C40},
+	{"SEC_RAS_CE_ENABLE             ",  0x301050},
+	{"SEC_RAS_FE_ENABLE             ",  0x301054},
+	{"SEC_RAS_NFE_ENABLE            ",  0x301058},
+	{"SEC_REQ_TRNG_TIME_TH          ",  0x30112C},
+	{"SEC_CHANNEL_RNG_REQ_THLD      ",  0x302110},
 };
 
 /* define the SEC's dfx regs region and region length */
-- 
2.33.0


