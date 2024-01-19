Return-Path: <linux-kernel+bounces-31508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E041832F47
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 20:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DB0E2846F7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 19:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D4256451;
	Fri, 19 Jan 2024 19:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="exLbPq0g"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50D22FE1D;
	Fri, 19 Jan 2024 19:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705691374; cv=none; b=uAClYdx9rx67dRkI6fdjwj30n6crKJhR6RPtBtJnuhE5L2kUIfs1eB4bep+ojuh/qXLsJfEZqW0d577xvkHKR6LIH3SSNKsubDFpyMVDG5PhAwhHYYY+HbwtAjLEQnGqyr3qvCamsMxo/50TWpqVQLNa71X7RkrAlGYl5Yq42Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705691374; c=relaxed/simple;
	bh=vwEdk/w7GtA67dnByJO3IYgwwSG6lpQcGUrrPPj2qXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nQdli9s5HsdRRJcUGP2cIzTJ04T4jqua9jcjcU3x0yzeef62mz5aDOf5ftGFKhjg9QDIJrIFsDih6ywLwY68dSbDcRcxqBjMAuhbMWko7U/wGFi3vAp3Ym0ih1lrH+/sjeQ67tm7zCECN3PZDQyJoLYxjtvlPt+90JezmoU9DjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=exLbPq0g; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40JGwLjl002726;
	Fri, 19 Jan 2024 19:08:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=ZWLd4ama37Cyr6lzfrcDFFP9xjU4nJJ8S5Ng2lHItfs=;
 b=exLbPq0gNzGf+z1XrhrHSyOBv+DXeCnOmGi1nSnHsPMxHwOrBJAz5FPwCkWssS0THhhy
 rXsiBeL0d2a918qnot+bi5vq/h1EQuucaxjz1skEgtGt3Rjjqb3a0QYTzUsvNMCCahht
 EXCsWtdvSpZON1IYTv9v9cqg2rOB6KXyLJ1eH2XXwadKnjJjCTpstcSA3E/kFcjE48di
 8d25VonlzNtYNlmyciWj8KPn04d9sNpBztKYyq1HfUO0YoEx5i2GxQsBoBcHelejRDHq
 nTsJBJCtplWAP1ySXZCzp1gb0iCfMMhXC6LttWugpvcjLu1AvqIopSbCbaXwUeg22bcO vA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vkk2ufd3s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jan 2024 19:08:48 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40JIiXHn020046;
	Fri, 19 Jan 2024 19:08:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vkgyfunru-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jan 2024 19:08:47 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40JJ8lNR032671;
	Fri, 19 Jan 2024 19:08:47 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3vkgyfunr8-1;
	Fri, 19 Jan 2024 19:08:46 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        Andy Yan <andy.yan@rock-chips.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Sascha Hauer <s.hauer@pengutronix.de>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
        error27@gmail.com, harshit.m.mogalapalli@oracle.com
Subject: [PATCH] drm/rockchip: vop2: add a missing unlock in vop2_crtc_atomic_enable()
Date: Fri, 19 Jan 2024 11:08:40 -0800
Message-ID: <20240119190841.1619443-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-19_12,2024-01-19_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401190113
X-Proofpoint-ORIG-GUID: YhbWzf0BGgzwKT-zZSFVivNqHgWwTUMY
X-Proofpoint-GUID: YhbWzf0BGgzwKT-zZSFVivNqHgWwTUMY

Unlock before returning on the error path.

Fixes: 5a028e8f062f ("drm/rockchip: vop2: Add support for rk3588")
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
This is based on static analysis. Only compile tested.
Note: Smatch found this.
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index 85b3b4871a1d..fdd768bbd487 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -1985,8 +1985,10 @@ static void vop2_crtc_atomic_enable(struct drm_crtc *crtc,
 		clock = vop2_set_intf_mux(vp, rkencoder->crtc_endpoint_id, polflags);
 	}
 
-	if (!clock)
+	if (!clock) {
+		vop2_unlock(vop2);
 		return;
+	}
 
 	if (vcstate->output_mode == ROCKCHIP_OUT_MODE_AAAA &&
 	    !(vp_data->feature & VOP2_VP_FEATURE_OUTPUT_10BIT))
-- 
2.39.3


