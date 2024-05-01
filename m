Return-Path: <linux-kernel+bounces-165870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C29CC8B92B2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 02:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDB8BB215BF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 00:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52F328FA;
	Thu,  2 May 2024 00:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SDitN78R"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696B57E9
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 00:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714608745; cv=none; b=GmhmhHDSis0whtDKqE82dJ1V+Ns6TkdPxNxyPMzJPZMbOI2ZecS1gUJd97kODAAj/RRDjTghIf3dHT+bhoZq2zJts8e9E1WEFrGRnNDJdiLT9+2dsbK7OAWMnBwjtid4YQEtmzV26aVlxBfg6YOoCxlrZ+XScLGDjqJX4aMZ0gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714608745; c=relaxed/simple;
	bh=K+Gy9CML3PFAZCtOCTwpWFdOpIQZF3doQsnDOX3rzXE=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=gtx7z+Wz9qRufj9HMKKVpsJ7P+6b9LCmMRZVYonIvotP0FL/MxcHRI71GNjJVgg31N9KGZz9jkQZEqPPD0nDCocco+1X0MMUEly1goKzJRJzrdbZa9krgKFpcaJFCNCh10HffxG2HIbd2eSPhetVD0YQhtv33Fs+b6qxXJb789g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SDitN78R; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 441NjsV4014441;
	Thu, 2 May 2024 00:12:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=aEUEHsNlLAlsnV2vJAFJDY90+EpOgRLfIOlxyC3dbF4=;
 b=SDitN78RSknRDefTHBo4sECWySpql1/JJVmQSM7P3bKiFkvjeYtkrJkAl3v7yfC2f9xK
 PuVcDM7XwCMmuMWkTm381wGD4QtXiddyAmz2w2UUBq1i7cp1+Um206kEzsHtCmR5VS4s
 bqw51NwOExLNBfboZ089x2yqT2RpHikrUqetPi2tP9cCgJzv2c8dwCDYjZXLll+Gv92r
 AtrcwN0/h3NO5a0q1g4wq5omDQDVwBnP4W2wP+Lf1OcFqZVkh0locDJJs/+BhillaHXN
 Uga2zgRGmL1y4/Nv/SLKK5KYy5VxCOR88mvPeZByXOFFL9cNdLHVxjNMiT3U/IG2mWho 4g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrqsf24uf-42
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 May 2024 00:12:11 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 441MBS49033172;
	Wed, 1 May 2024 23:25:04 GMT
Received: from brm-x62-16.us.oracle.com (brm-x62-16.us.oracle.com [10.80.150.37])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3xrqt9vbuq-1;
	Wed, 01 May 2024 23:25:04 +0000
From: Jane Chu <jane.chu@oracle.com>
To: linmiaohe@huawei.com, nao.horiguchi@gmail.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Enhance soft hwpoison handling and injection 
Date: Wed,  1 May 2024 17:24:55 -0600
Message-Id: <20240501232458.3919593-1-jane.chu@oracle.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-01_16,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2405010165
X-Proofpoint-ORIG-GUID: E68nnOLL_89lpTxpowlOR5c3ZX5VPC5W
X-Proofpoint-GUID: E68nnOLL_89lpTxpowlOR5c3ZX5VPC5W

This series aim at the following enhancement -
1. Let one hwpoison injector, that is, madvise(MADV_HWPOISON) to behave
   more like as if a real UE occurred. Because the other two injectors
   such as hwpoison-inject and the 'einj' on x86 can't, and it seems to
   me we need a better simulation to real UE scenario.
2. For years, if the kernel is unable to unmap a hwpoisoned page, it send
   a SIGKILL instead of SIGBUS to prevent user process from potentially
   accessing the page again. But in doing so, the user process also lose
   important information: vaddr, for recovery.  Fortunately, the kernel
   already has code to kill process re-accessing a hwpoisoned page, so
   remove the '!unmap_success' check.
3. Right now, if a thp page under GUP longterm pin is hwpoisoned, and
   kernel cannot split the thp page, memory-failure simply ignores
   the UE and returns.  That's not ideal, it could deliver a SIGBUS with
   useful information for userspace recovery.


Jane Chu (3):
  mm/memory-failure: try to send SIGBUS even if unmap failed
  mm/madvise: Add MF_ACTION_REQUIRED to madvise(MADV_HWPOISON)
  mm/memory-failure: send SIGBUS in the event of thp split fail

 mm/madvise.c        |  2 +-
 mm/memory-failure.c | 49 ++++++++++++++++++++++++++++++++++++---------
 2 files changed, 41 insertions(+), 10 deletions(-)

-- 
2.39.3


