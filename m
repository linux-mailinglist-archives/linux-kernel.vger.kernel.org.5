Return-Path: <linux-kernel+bounces-18875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C71826457
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 15:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E0291F21973
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 14:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2AAA134BA;
	Sun,  7 Jan 2024 14:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="VlqDGmtv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6E1134AF;
	Sun,  7 Jan 2024 14:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 406MgEoX011973;
	Sun, 7 Jan 2024 13:29:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pps0720;
 bh=zqiJ0Y28ldPU2T0izIyr/oSqprYD9uf+d2v7zsTR3GU=;
 b=VlqDGmtvZqjHT6cfQ4rJt6QBnG+oltgxOBG1c9G0zzL7hVp7IkSopfr8Apa+8tQPsJiE
 SFxyZT/xj4HXclBo786hTVYWH5gX4IlQYwDAtPBCjrKqIIAx4KM5nWTvQHwg2ng9RRHl
 /qxXB5PcaAM4lZ9iBH99xtWdx1DDHLNjwdiKxtZ1du4hqco1Nsegpj4G3JRSsIRQdmug
 WY+yxGt8pdeV1+HMWS6RJevMkTrGsIIrz2qo1nFqmaaekghVDI524+omYY9wwZBDaCXU
 RuKkXxF1rocm7PU1osZlVYZrrJ0HlbrYXYKRqIDp41ZZXovtclJyiXsmZY1/YEuKElKZ 9Q== 
Received: from p1lg14880.it.hpe.com ([16.230.97.201])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3vf2679009-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Jan 2024 13:29:15 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 52755800390;
	Sun,  7 Jan 2024 13:29:14 +0000 (UTC)
Received: from openbmc-builder-cc.amslabs.hpecorp.net (unknown [16.231.227.36])
	by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 296F080ADA9;
	Sun,  7 Jan 2024 13:29:13 +0000 (UTC)
From: clayc@hpe.com
To: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: dhowells@redhat.com, herbert@gondor.apana.org.au, davem@davemloft.net,
        Clay Chang <clayc@hpe.com>
Subject: [PATCH] KEYS: include header for EINVAL definition
Date: Sun,  7 Jan 2024 21:28:42 +0800
Message-Id: <20240107132842.4024084-1-clayc@hpe.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: HnJDMSS5RTifhufW5WfN3tWDjIt4kn5u
X-Proofpoint-ORIG-GUID: HnJDMSS5RTifhufW5WfN3tWDjIt4kn5u
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-07_08,2024-01-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 clxscore=1011 lowpriorityscore=0 adultscore=0 mlxlogscore=519
 impostorscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401070065

From: Clay Chang <clayc@hpe.com>

This patch includes linux/errno.h to address the issue of 'EINVAL' being
undeclared.

Signed-off-by: Clay Chang <clayc@hpe.com>
---
 include/crypto/public_key.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/crypto/public_key.h b/include/crypto/public_key.h
index 462f8a34cdf8..b7f308977c84 100644
--- a/include/crypto/public_key.h
+++ b/include/crypto/public_key.h
@@ -10,6 +10,7 @@
 #ifndef _LINUX_PUBLIC_KEY_H
 #define _LINUX_PUBLIC_KEY_H
 
+#include <linux/errno.h>
 #include <linux/keyctl.h>
 #include <linux/oid_registry.h>
 
-- 
2.34.1


