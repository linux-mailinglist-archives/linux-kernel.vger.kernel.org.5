Return-Path: <linux-kernel+bounces-12958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70EF081FD55
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 07:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3A4C1C20DF8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 06:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8CA8C0B;
	Fri, 29 Dec 2023 06:45:03 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DEC567D;
	Fri, 29 Dec 2023 06:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4T1bS21kdyz1R71X;
	Fri, 29 Dec 2023 14:43:30 +0800 (CST)
Received: from dggpeml500001.china.huawei.com (unknown [7.185.36.227])
	by mail.maildlp.com (Postfix) with ESMTPS id D8C4F18001B;
	Fri, 29 Dec 2023 14:44:51 +0800 (CST)
Received: from huawei.com (10.69.192.56) by dggpeml500001.china.huawei.com
 (7.185.36.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 29 Dec
 2023 14:44:51 +0800
From: Qi Tao <taoqi10@huawei.com>
To: <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
	<liulongfang@huawei.com>
CC: <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>
Subject: [PATCH 1/4] crypto: hisilicon/sec2 - updates the sec DFX function register
Date: Fri, 29 Dec 2023 14:44:18 +0800
Message-ID: <20231229064421.16981-2-taoqi10@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20231229064421.16981-1-taoqi10@huawei.com>
References: <20231229064421.16981-1-taoqi10@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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


