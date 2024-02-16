Return-Path: <linux-kernel+bounces-68104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A081857606
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 07:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAFBA284DFA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 06:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76731427E;
	Fri, 16 Feb 2024 06:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T2N8PVS8"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B755213ADC;
	Fri, 16 Feb 2024 06:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708064933; cv=none; b=N7CvBfGQwBlrou6wEJlWjrl3vw5jfvhmOWLk2tAIIJ7rAdoDiDh6Zp/kixklatq9nb0b2o/uStkVoMEaYd7I+IFQsfOgrhYdkDdSTt7454WzSKr0DcXD8hog9MxlCfP9y4zaiir55fNr2nPnbqLcn2r+bbRANHDVpbqcuMvED3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708064933; c=relaxed/simple;
	bh=mo8ee+GHz6jPEyUXXrNLlFXpXh64sJy2csTQ8HmKw7o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AHO6fTy5pHZMski1Qh0B3hwXKeM+HM9L9dxZamOwhes/K6lO2txxDr1/aAHS/DRuSkFIlMKlkzOTJsNguXX5dIH2/YGm3Ks5CoLutavsJqkhjV/xM/rHfhHmisG7PE/09tnuNM210mD6mb3twLBDEtz/6rfupPV4uHi5abh3uVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=T2N8PVS8; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41G4xZru032307;
	Fri, 16 Feb 2024 06:28:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=11lhowEku9JauzXkE/wObrLIf2iNOyLR/O51AA5UCuY=;
 b=T2N8PVS86lByXQAks6rnchO2FxtwcI5Br/7b/QZMXkzC3UZT7wiOFORaIb/K3rsrLWRk
 zx6lHb4LDyFvLTSiPt9XBtlDpH80p4VGbHNC2wa7YX7mpnOUdWtupzrERO47lICHydus
 JgYCYpJ6tSPtYEzuYDOSEqp8bf91a3YWV1H1Ra3+h300GS40H8Pdsv3v57Z/Og2KlMHL
 EPymbvpIgpxDybp6yVOq4WhwD4zpVttTxVQwJ/aOsa/92dDmr0m9Ma+KAJdcfKXAOCXD
 MtGXSVdc2uGK7G+0HDUgKsxnny/hatnPFri7xe79TIeQXhkEaBNWoktZ3Zmcmc/wlLyy Dw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w91w6vduw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Feb 2024 06:28:33 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41G5P48i024566;
	Fri, 16 Feb 2024 06:28:32 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5ykj07sn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Feb 2024 06:28:32 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41G6P0w5021393;
	Fri, 16 Feb 2024 06:28:31 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3w5ykj07qv-1;
	Fri, 16 Feb 2024 06:28:31 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Alvin Lee <alvin.lee2@amd.com>, Qingqing Zhuo <Qingqing.Zhuo@amd.com>,
        Wayne Lin <wayne.lin@amd.com>, Duncan Ma <duncan.ma@amd.com>,
        Samson Tam <samson.tam@amd.com>, "JinZe.Xu" <jinze.xu@amd.com>,
        Josip Pavic <Josip.Pavic@amd.com>, Cruise Hung <cruise.hung@amd.com>,
        Hersen Wu <hersenxs.wu@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, dan.carpenter@linaro.org,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        kernel test robot <lkp@intel.com>, Dan Carpenter <error27@gmail.com>
Subject: [PATCH] drm/amd/display: fix a possible NULL dereference bug
Date: Thu, 15 Feb 2024 22:28:22 -0800
Message-ID: <20240216062825.165627-1-harshit.m.mogalapalli@oracle.com>
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
 definitions=2024-02-16_05,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402160051
X-Proofpoint-ORIG-GUID: kc0_sxQHa_Md3hCzniJTwJnbPLO9kRu6
X-Proofpoint-GUID: kc0_sxQHa_Md3hCzniJTwJnbPLO9kRu6

Smatch warns:
	drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:136
	dc_dmub_srv_cmd_list_queue_execute() warn: variable dereferenced
	before check 'dc_dmub_srv' (see line 131)

Fix this by moving the dereference "dc_dmub_srv->ctx" after the NULL check.

Fixes: 028bac583449 ("drm/amd/display: decouple dmcub execution to reduce lock granularity")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Closes: https://lore.kernel.org/r/202311141141.GoLAPxD5-lkp@intel.com/
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
Only compile tested
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 0bc32537e2eb..a4bd46ec6da4 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -128,7 +128,7 @@ bool dc_dmub_srv_cmd_list_queue_execute(struct dc_dmub_srv *dc_dmub_srv,
 		unsigned int count,
 		union dmub_rb_cmd *cmd_list)
 {
-	struct dc_context *dc_ctx = dc_dmub_srv->ctx;
+	struct dc_context *dc_ctx;
 	struct dmub_srv *dmub;
 	enum dmub_status status;
 	int i;
@@ -136,6 +136,7 @@ bool dc_dmub_srv_cmd_list_queue_execute(struct dc_dmub_srv *dc_dmub_srv,
 	if (!dc_dmub_srv || !dc_dmub_srv->dmub)
 		return false;
 
+	dc_ctx = dc_dmub_srv->ctx;
 	dmub = dc_dmub_srv->dmub;
 
 	for (i = 0 ; i < count; i++) {
-- 
2.39.3


