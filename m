Return-Path: <linux-kernel+bounces-13890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44215821447
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 16:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90B2A2817F5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 15:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B8C8F62;
	Mon,  1 Jan 2024 15:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="N2nn/xXi"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCE38F4E
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jan 2024 15:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 401Dm8FW032618;
	Mon, 1 Jan 2024 15:46:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=+JLcux4kNqDhiimWCoXU1WWfk27Lmdnex7wO8oAkczA=;
 b=N2nn/xXiMXCH7oipdbacpKqTl2c+TGNE6/GTjlCQFZr2u9qCfJrS5UdCUrVjUNlPopTg
 6581YNbRldZHNaJQw3BOZR4u3SUCg2+pKxmTxTrU3EYqfOPHOGDLaVMbRDvNPGSLqy+1
 cM2qcjoAU0KPoSvxQF3+fQ+b9bhGSzUSS03YDahzUIqxgZF7ZcibIx/AMpeplAept49U
 KlvBfuxlET8wCNn3MWEgisXKcOzPYSSTTSSg22aMicH234i6NZcFMrT6WRx4upXoGH5q
 NAmI/77wAqtxbb97I7YzSyYFcjUkEtkGpvOaY9q1qxoIHgV7qvY5G4J44TtPiM2aZRaD WQ== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vbxkbhfs9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jan 2024 15:46:49 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 401DxgrK017857;
	Mon, 1 Jan 2024 15:46:47 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vawwyg9mt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jan 2024 15:46:47 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 401Fkj2x13042390
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Jan 2024 15:46:46 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D618420043;
	Mon,  1 Jan 2024 15:46:45 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7777320040;
	Mon,  1 Jan 2024 15:46:43 +0000 (GMT)
Received: from li-c1fdab4c-355a-11b2-a85c-ef242fe9efb4.ibm.com.com (unknown [9.171.34.133])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  1 Jan 2024 15:46:43 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
To: mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org
Cc: sshegde@linux.vnet.ibm.com, dietmar.eggemann@arm.com,
        linux-kernel@vger.kernel.org, srikar@linux.vnet.ibm.com,
        yu.c.chen@intel.com, tim.c.chen@linux.intel.com
Subject: [PATCH v2 0/2] sched: use existing helper function for accessing avg_rt, avg_dl and avg_irq
Date: Mon,  1 Jan 2024 21:16:22 +0530
Message-Id: <20240101154624.100981-1-sshegde@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.39.3
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JnysdmyiTE3Tt5_uXovSEFakbrnhnnzB
X-Proofpoint-GUID: JnysdmyiTE3Tt5_uXovSEFakbrnhnnzB
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-01_08,2024-01-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 mlxlogscore=466 phishscore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401010128

Split the patches into two since there is subtle change with avg_irq.
There is no functionality change expected due to first patch, while
second patch may have. In case of any future regressions it would be
easy to bisect.

This is minor code simplification. Using existing helper function would
be simpler and easier to maintain.

v2->v1:
Vincent pointed out the READ_ONCE change for avg_irq. It would be
correct to use READ_ONCE for accessing avg_irq. Changed the current
helper function to do so.

v1: https://lore.kernel.org/lkml/20231220065522.351915-1-sshegde@linux.vnet.ibm.com/

Shrikanth Hegde (2):
  sched: use existing helper functions to access ->avg_rt and ->avg_dl
  sched: add READ_ONCE and use existing helper function to access ->avg_irq

 kernel/sched/fair.c  | 12 +++++-------
 kernel/sched/sched.h |  2 +-
 2 files changed, 6 insertions(+), 8 deletions(-)

--
2.39.3


