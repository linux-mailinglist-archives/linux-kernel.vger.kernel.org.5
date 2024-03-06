Return-Path: <linux-kernel+bounces-93201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B85872C4C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 02:41:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECDF31C225FF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 01:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B969F7499;
	Wed,  6 Mar 2024 01:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="friY4roL"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE6D2CA7;
	Wed,  6 Mar 2024 01:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709689298; cv=none; b=cln8Uqu1qNi5ho72ozk4JjI1aHOiMxn9kgb6C1iGaTttDVf9RgrTemTRYr0qrV8Q8ALMifaWU0pPLUJi+64IApRZpaFb4zNqIr3P+jfwNNWlAiDMyYPaWxqOR5/Y8LLPhqtgye6nekBE2re4v99JxhAMxA3TfjT6huouc3f2MuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709689298; c=relaxed/simple;
	bh=hUZhXekL3czb/m0SA5YEhBv9lBYNkRRC/zAjd6jzNaI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mHXddueyI07Lr3vD0fcMiCRnVvEhZiVOklxQKF0yliinn96KHcJG8qmEy9sjaGPwUx95XgIxXVwJxsYEhNUiSgkm4DtMZyhycIor1gmwIu02B/qYTr9RVYOMILrkJ0kp+LXS5gNjYcCU6GLme580edFL3D9Cl/szthVxOuYlJp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=friY4roL; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 425KrIRj008049;
	Wed, 6 Mar 2024 00:19:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=egK10wqwXb2fu+g1i/MZi3vjpY9NQX6hwN6M7fWN5jE=;
 b=friY4roL0pv2sKy7l3IPJco9M3jBCHV5aCL9c1I8XBZDzepoyoSoW69o1Z8cz4G0Vva6
 1ddxuiXBdPJWm+3gynugKUcxgAOsn5rSZrmQikiyGftJ3WXMGDYHACKh3KNXEsx6tOnj
 AaXgrR/iPoKqJ/eUO3voG56AVWmnc+OqvLRkbTa1BxJFE2K2T7Jf8eiVdPYHosVQaxgu
 aITNxtU4gV1YgvMv4MsDkFpt89t9kxWO5ZOUnsiSS3G4v6vP5BWIGbfqqGtPa+b5Kyta
 4eKptBIhHrz3qF41tcdil9fOig2LpA4r5Dr3T69IFSjFRO1QkVRTZxHzeH5yZAeTUFEA 2w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wkuqvfgtr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Mar 2024 00:19:07 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 425NSNgu013814;
	Wed, 6 Mar 2024 00:18:58 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wktj8f5w2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Mar 2024 00:18:58 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4260Iv2A021727;
	Wed, 6 Mar 2024 00:18:57 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3wktj8f5v6-1;
	Wed, 06 Mar 2024 00:18:57 +0000
From: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        namhyung@kernel.org
Cc: samasth.norway.ananda@oracle.com, jolsa@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH ] perf test pmu: Fix file Leak in test_format_dir_get
Date: Tue,  5 Mar 2024 16:18:55 -0800
Message-ID: <20240306001855.4070582-1-samasth.norway.ananda@oracle.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-05_19,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403060001
X-Proofpoint-GUID: JVqj9h-YQouvnBbo0wV38Xr9sL4foS_D
X-Proofpoint-ORIG-GUID: JVqj9h-YQouvnBbo0wV38Xr9sL4foS_D

File is opened inside the for loop. But if the 'if' condition is
successful then 'break' statement will be reached, exiting the
'for' loop prior to reaching 'fclose'.

Signed-off-by: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
---
Found this error through static analysis. This has only been compile
tested.
---
 tools/perf/tests/pmu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/pmu.c b/tools/perf/tests/pmu.c
index 8f18127d876a..f751e6cb6ac0 100644
--- a/tools/perf/tests/pmu.c
+++ b/tools/perf/tests/pmu.c
@@ -106,8 +106,10 @@ static char *test_format_dir_get(char *dir, size_t sz)
 		if (!file)
 			return NULL;
 
-		if (1 != fwrite(format->value, strlen(format->value), 1, file))
+		if (1 != fwrite(format->value, strlen(format->value), 1, file)) {
+			fclose(file);
 			break;
+		}
 
 		fclose(file);
 	}
-- 
2.43.0


