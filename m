Return-Path: <linux-kernel+bounces-27045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6259E82E9AA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 07:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 893271C22CAE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 06:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A6010A2B;
	Tue, 16 Jan 2024 06:47:26 +0000 (UTC)
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [203.110.167.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700FB10A05
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 06:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1705386951-1eb14e0c7f1eda0001-xx1T2L
Received: from ZXSHMBX3.zhaoxin.com (ZXSHMBX3.zhaoxin.com [10.28.252.165]) by mx2.zhaoxin.com with ESMTP id 6inuI1kU4kvmppjM (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Tue, 16 Jan 2024 14:35:51 +0800 (CST)
X-Barracuda-Envelope-From: TonyWWang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHMBX3.zhaoxin.com
 (10.28.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 16 Jan
 2024 14:35:51 +0800
Received: from localhost.localdomain (10.32.65.162) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 16 Jan
 2024 14:35:48 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
From: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.29.252.163
To: <675146817@qq.com>, <story_19872006@126.com>,
	<herbert@gondor.apana.org.au>, <davem@davemloft.net>,
	<linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<seanjc@google.com>, <kim.phillips@amd.com>,
	<kirill.shutemov@linux.intel.com>, <jmattson@google.com>,
	<babu.moger@amd.com>, <kai.huang@intel.com>, <TonyWWang-oc@zhaoxin.com>,
	<acme@redhat.com>, <aik@amd.com>, <namhyung@kernel.org>
CC: <CobeChen@zhaoxin.com>, <TimGuo@zhaoxin.com>, <LeoLiu-oc@zhaoxin.com>,
	<GeorgeXue@zhaoxin.com>
Subject: [PATCH 1/3] crypto: padlock-sha: Matches CPU with Family with 6 explicitly
Date: Tue, 16 Jan 2024 14:35:47 +0800
X-ASG-Orig-Subj: [PATCH 1/3] crypto: padlock-sha: Matches CPU with Family with 6 explicitly
Message-ID: <20240116063549.3016-2-TonyWWang-oc@zhaoxin.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240116063549.3016-1-TonyWWang-oc@zhaoxin.com>
References: <20240116063549.3016-1-TonyWWang-oc@zhaoxin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Barracuda-Connect: ZXSHMBX3.zhaoxin.com[10.28.252.165]
X-Barracuda-Start-Time: 1705386951
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 786
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.119492
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------

Updates the supporting qualification for packlock-sha driver, making
it support CPUs whose vendor ID is Centaur and Famliy is 6.

Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
---
 drivers/crypto/padlock-sha.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/padlock-sha.c b/drivers/crypto/padlock-sha.c
index 6865c7f1fc1a..2e82c5e77f7a 100644
--- a/drivers/crypto/padlock-sha.c
+++ b/drivers/crypto/padlock-sha.c
@@ -491,7 +491,7 @@ static struct shash_alg sha256_alg_nano = {
 };
 
 static const struct x86_cpu_id padlock_sha_ids[] = {
-	X86_MATCH_FEATURE(X86_FEATURE_PHE, NULL),
+	X86_MATCH_VENDOR_FAM_FEATURE(CENTAUR, 6, X86_FEATURE_PHE, NULL),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, padlock_sha_ids);
-- 
2.25.1


