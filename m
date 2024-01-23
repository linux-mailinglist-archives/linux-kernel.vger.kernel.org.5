Return-Path: <linux-kernel+bounces-34638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE580838581
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 03:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95DE81F29303
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9581E4EB55;
	Tue, 23 Jan 2024 02:29:10 +0000 (UTC)
Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E384E1BC
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 02:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.0.225.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705976950; cv=none; b=pM7DQTOuUQXF4Nt7ZFIvVkIIjfn2WlUzYydJibagwf4SRLBRE1IVQDc1iD08Lx/lMjEgcFHAGetWrstju0XbcvBki3oMo9+4lVinqyRbbSikkxWLePANT8Ypwym/5/U1VzURoirNlShYBhEjJAGKW1gJ8xs9cXT8QV2iW+ga2t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705976950; c=relaxed/simple;
	bh=8jR/wyg20Cbwp1wNyTE4dL3FSTw1OLFz7/S0CpcZm/0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qYlW4aUHZTUhz0vDoro+0itgXKTeN37Ykg9yrz3fHFOF3Y6MD+bEJbjGPaq4b3551dO/nDO5XMQhvOfZKr0fOecfmM8ZSfpvm3SwlZ3SbD/VMwIfut68Ez8GnHsme1wZn1NkNye3h6XerMxnbYJOirKJh9mwizeQRqQoTVyZrV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=210.0.225.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1705976937-086e230f27288d0001-xx1T2L
Received: from ZXSHMBX1.zhaoxin.com (ZXSHMBX1.zhaoxin.com [10.28.252.163]) by mx1.zhaoxin.com with ESMTP id qsqivOYb0MXRPciq (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Tue, 23 Jan 2024 10:28:57 +0800 (CST)
X-Barracuda-Envelope-From: TonyWWang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHMBX1.zhaoxin.com
 (10.28.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 23 Jan
 2024 10:28:56 +0800
Received: from localhost.localdomain (10.32.65.162) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 23 Jan
 2024 10:28:54 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
From: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.29.252.163
To: <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
	<linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<seanjc@google.com>, <kim.phillips@amd.com>,
	<kirill.shutemov@linux.intel.com>, <jmattson@google.com>,
	<babu.moger@amd.com>, <kai.huang@intel.com>, <TonyWWang-oc@zhaoxin.com>,
	<acme@redhat.com>, <aik@amd.com>, <namhyung@kernel.org>
CC: <CobeChen@zhaoxin.com>, <TimGuo@zhaoxin.com>, <LeoLiu-oc@zhaoxin.com>,
	<GeorgeXue@zhaoxin.com>
Subject: [PATCH v2 1/3] crypto: padlock-sha: Matches CPU with Family with 6 explicitly
Date: Tue, 23 Jan 2024 10:28:50 +0800
X-ASG-Orig-Subj: [PATCH v2 1/3] crypto: padlock-sha: Matches CPU with Family with 6 explicitly
Message-ID: <20240123022852.2475-2-TonyWWang-oc@zhaoxin.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240123022852.2475-1-TonyWWang-oc@zhaoxin.com>
References: <20240123022852.2475-1-TonyWWang-oc@zhaoxin.com>
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
X-Barracuda-Connect: ZXSHMBX1.zhaoxin.com[10.28.252.163]
X-Barracuda-Start-Time: 1705976937
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 786
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.119808
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


