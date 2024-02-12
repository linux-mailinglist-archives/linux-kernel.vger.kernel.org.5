Return-Path: <linux-kernel+bounces-61304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 997798510C7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37CF71F214AC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 10:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E371A5A2;
	Mon, 12 Feb 2024 10:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JPcGijL7"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04490182CC;
	Mon, 12 Feb 2024 10:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707733574; cv=none; b=eOo4VeYvSXYcPVGDTsJguhf+MxSS37cv1RZyWN1wOS1TAGrC2y1CJEYvEM1CSDOYq9ma8NQKpGQ+xm+oZyI2m6AqbHJCj2R+zizv5eUvCnXz4YrIGXfZORcj/vR6I1zQ/uY01CSDMnOq6PHetk7t1m9oQT27PAbaeaWa+wRMo4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707733574; c=relaxed/simple;
	bh=wPz7I9EEkUc5fKP9bsiCYupJWPbvf0lXrTLFGybWee4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d7ETMyw0ppkO4ukH0iHE+N0/z+HNzn0tP1ycy03RgsZLjy9CAFXSE11Av2grGXm59tpHKIc0c+xA098R58kv7ihaxXC4V0zbYnvFr71Vg9dTgBeaULRouT5JXV7Qb8T9pwWmnMLW1x5MAElOMbfAckWttpgeuvKLJLa97iXbtbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JPcGijL7; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41CAGM8b003166;
	Mon, 12 Feb 2024 10:25:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=p6by8SZSlB+9keTcKyTEe2dWYIlbw1q4NM5nRi65N0U=;
 b=JPcGijL7zYvgy5BFpohT+OA1Woe/Yz4IPnM1pxdOD0Yz75PEAZhWAZ0qZHcaIUPYhRw0
 ozznztn4nWqtsqs9oXUBnQc9w9N5aKdecCdp72HKoPUZjdx/z4DFYRy2F5codMCRU0fH
 h98e+k2B13dTUrH5IskkIGch0y2RQ13TmqQRdYNAEaaAWIFp83fvTBcLZGp6NrbDZ+T5
 kg19vug6aOhAov+B6qJOZX3lzX6x8oVJ87xiZyCYJwmwmsVUYI/bzn+HDMfsjwjpkOK7
 TGCkdxQXJo7gKlqWJB5AlTPffBr9Cgq1wNB7T7QHrPzC9wkdeE9tLnqRHV4k7HDadD8l Gw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w7gycr2xf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Feb 2024 10:25:42 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41CA0nQc031341;
	Mon, 12 Feb 2024 10:25:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk5jdax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Feb 2024 10:25:41 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41CAPeGd030805;
	Mon, 12 Feb 2024 10:25:40 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3w5yk5jd9x-1;
	Mon, 12 Feb 2024 10:25:40 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: Matthew Sakai <msakai@redhat.com>, dm-devel@lists.linux.dev,
        Mike Snitzer <snitzer@kernel.org>, Ken Raeburn <raeburn@redhat.com>,
        "J. corwin Coburn" <corwin@hurlbutnet.net>,
        Thomas Jaskiewicz <tom@jaskiewicz.us>, linux-kernel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, dan.carpenter@linaro.org,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH] dm vdo: fix an assert statement in start_restoring_volume_sub_index()
Date: Mon, 12 Feb 2024 02:25:04 -0800
Message-ID: <20240212102526.1854044-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_07,2024-02-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402120078
X-Proofpoint-ORIG-GUID: AMPGMmCUZlszruSd29k-FOn_hem7cF85
X-Proofpoint-GUID: AMPGMmCUZlszruSd29k-FOn_hem7cF85

Use "==" instead of "=" in ASSERT() statement.

Fixes: ef074a31e88e ("dm vdo: implement the volume index")
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
This is based on static analysis with Smatch and only compile tested.
---
 drivers/md/dm-vdo/indexer/volume-index.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-vdo/indexer/volume-index.c b/drivers/md/dm-vdo/indexer/volume-index.c
index 5fe34e6c1d9b..d6526fe9bbfc 100644
--- a/drivers/md/dm-vdo/indexer/volume-index.c
+++ b/drivers/md/dm-vdo/indexer/volume-index.c
@@ -830,7 +830,7 @@ static int start_restoring_volume_sub_index(struct volume_sub_index *sub_index,
 		decode_u32_le(buffer, &offset, &header.first_list);
 		decode_u32_le(buffer, &offset, &header.list_count);
 
-		result = ASSERT(offset = sizeof(buffer),
+		result = ASSERT(offset == sizeof(buffer),
 				"%zu bytes decoded of %zu expected", offset,
 				sizeof(buffer));
 		if (result != UDS_SUCCESS)
-- 
2.39.3


