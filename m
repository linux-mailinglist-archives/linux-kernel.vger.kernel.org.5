Return-Path: <linux-kernel+bounces-127845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 431C18951A4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 749A11C22698
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C84629E4;
	Tue,  2 Apr 2024 11:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="I0imACyH"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB0460DFB;
	Tue,  2 Apr 2024 11:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712056682; cv=none; b=g5WA2Yf0eeMLrvxrwogiXHu3N5Hg8rkoZS2X6dIbyNYkQdDIEXrdw3sKePkE1OSpwKdtC6YKj/2g8jE1RakiKsB+8HTtvlLcZR9HhVlp9ZouBaVqM5ivovvLs8dn33Dx5THpCPfD9CVmJoNepDkUSH+THeS65kTS8jLgUZDNgJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712056682; c=relaxed/simple;
	bh=0bhLmQsAUJaL5x/OICWEgSfO1n8lrNeGgWIGNPGZEfA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qCihFnwV7OjU1ODqSpvzhCn7VUF909PREdjOu3t06AplbwzRaoOYHOZaSXHwB3J4CohZU3/WranXcdGcETcG+vEp8XdjawPnlvG752f3tlQigmSWWweOoBaVynDjWRFfKKPAdiK73ybDaqTR+a3ACvWI3SBJ79kDwVVXts6FkUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=I0imACyH; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4327hsVV021280;
	Tue, 2 Apr 2024 11:17:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=x4uFkHBfZr5gLzCiwxnD9ABQcDyNK3J+4CO6ymkzwmk=;
 b=I0imACyH07tBnNSWHApVFNcWSCa5FlTjuNaP6Jel9macdAtJorLsNMH44gfqRY35dVWl
 KDG7wWoqJmPAeGg43yKTHU/H3l9aD6RcwhpP7SM4m1rMjxF66XhDMdVfbyAKs0VYulgU
 67MJnA5bMttghCGrli4t750Z3/D7XWLuWFYn4jhoji4rl+EuVBIZZMpKSwfnN7TjncyX
 xVCI1G4F9rmr4ZN5f6vpgwvQf818qQkukmzXiwe9BgN4JQ32fM0fROxQJrWgFafVdD2Y
 zjexxtuae8NIE8fut3fK4GNqsLbjMVMKvE5xI4wQcorPd3MiZWmuskqwmYYbAoSQhxUT Mg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x6abucbyt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Apr 2024 11:17:45 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 432B2aZ6006608;
	Tue, 2 Apr 2024 11:17:44 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3x6966wbc5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Apr 2024 11:17:44 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 432BHi91004477;
	Tue, 2 Apr 2024 11:17:44 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3x6966wbb2-1;
	Tue, 02 Apr 2024 11:17:44 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
        Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Heiko Stuebner <heiko@sntech.de>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc: dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
        error27@gmail.com, harshit.m.mogalapalli@oracle.com
Subject: [PATCH] drm/panthor: Fix IS_ERR() vs NULL bug in group_process_tiler_oom()
Date: Tue,  2 Apr 2024 04:17:39 -0700
Message-ID: <20240402111740.1700310-1-harshit.m.mogalapalli@oracle.com>
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
 definitions=2024-04-02_04,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 spamscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2404020081
X-Proofpoint-ORIG-GUID: fJ6_IRjHkqbCPM448T_3oltVdsYI62xz
X-Proofpoint-GUID: fJ6_IRjHkqbCPM448T_3oltVdsYI62xz

panthor_vm_get_heap_pool() returns ERR_PTR on failure, update the check
accordingly.

Fixes: de8548813824 ("drm/panthor: Add the scheduler logical block")
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
This is based on static analysis with smatch, only compile tested.
---
 drivers/gpu/drm/panthor/panthor_sched.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index 5f7803b6fc48..d34f213795a3 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -1343,7 +1343,10 @@ static int group_process_tiler_oom(struct panthor_group *group, u32 cs_id)
 	if (unlikely(csg_id < 0))
 		return 0;
 
-	if (!heaps || frag_end > vt_end || vt_end >= vt_start) {
+	if (IS_ERR(heaps))
+		return PTR_ERR(heaps);
+
+	if (frag_end > vt_end || vt_end >= vt_start) {
 		ret = -EINVAL;
 	} else {
 		/* We do the allocation without holding the scheduler lock to avoid
-- 
2.39.3


