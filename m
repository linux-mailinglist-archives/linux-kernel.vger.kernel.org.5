Return-Path: <linux-kernel+bounces-80426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D69686685A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 03:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EC0F1C2166B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 02:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633D2101C4;
	Mon, 26 Feb 2024 02:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="Yyk92skZ"
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E244AEEDE
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 02:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708915958; cv=none; b=Z9IXU8nUdT2F87KZpHHCXjs61vdsoEslXQLAzsekTeFgncrvhCf9BtUiqjxT+gqeZx+6iTjJQ8UCH1cvQUriljxewKuaY+zowI9roWWNlu+atynFHPGq/tiZeSYJgAnmyQI/7FCbjYzSPiKnbNb4HPL/U6+UikqgWQsGzmz049Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708915958; c=relaxed/simple;
	bh=P/ZpeNgQBSJcOCzs+dxujGtKK8ts3PDFulgbuwMDNd0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R9/Uelj4sIfLhP2NoQQRj82X4fvCnoh5YHlzRlzkdQ+JO+1R0Y/KFiNY34UAKw0ZYhTCS8G4XQ1rvYrGXm4Y4un03Wj0LYThoo0B3UYxLTIKCtMtib7yJd6PDWlentoCLTLv0X8JzOW8ruRRAQH2PjknCjgYqwchb4UZHGMlqYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=Yyk92skZ; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41Q2pUUM030758;
	Sun, 25 Feb 2024 18:52:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PPS06212021; bh=9wS8w8E+DFTNtlQHWw80uBF588uusaQcdd25aQv68Xs=; b=
	Yyk92skZtzmYTFUq+K47W3DJZwQ+fq37fDzC3heWLBEAEqk80caVCD+RBMd9QLu0
	mi3tSqZ9p3b4p2m6T0pOKM3Kdeq4A1hUVLxBXIkBsfyCZR32nugcn/H+ZuySGw7v
	QotztpV6MRx2xRpcWdLTL06bUUxj/QtyPUDdvXbxOU4ZVRZePTKY4JyIKAdq3nY6
	QdqrxA62AgDq9id5L7V+IlNHlhuWspLOTCQoQhXwzLqdidRV+9xJib8Bx+CMx8cr
	4kPU6bqe6ctvZ7zmvMGfcTDbErn+c+KDAsqDUikHoScDDn2ofR/w+tB3ywTOnzrH
	yzzewff3faxj9Q0CwZSVaQ==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3wfcm4181j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Sun, 25 Feb 2024 18:52:31 -0800 (PST)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 25 Feb 2024 18:52:30 -0800
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Sun, 25 Feb 2024 18:52:29 -0800
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <syzbot+93bd128a383695391534@syzkaller.appspotmail.com>
CC: <syzkaller-bugs@googlegroups.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [syzbot] [dri?] WARNING in vkms_get_vblank_timestamp (2)
Date: Mon, 26 Feb 2024 10:52:28 +0800
Message-ID: <20240226025229.355810-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000edf6a306105afb50@google.com>
References: <000000000000edf6a306105afb50@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ezFBjSYxaxkIaP5_1P8y0Rrr8IuNoMSi
X-Proofpoint-GUID: ezFBjSYxaxkIaP5_1P8y0Rrr8IuNoMSi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_01,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 spamscore=0 bulkscore=0 mlxlogscore=856 mlxscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 suspectscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402260020

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git v6.8

diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
index 61e500b8c9da..8994cbd88482 100644
--- a/drivers/gpu/drm/vkms/vkms_crtc.c
+++ b/drivers/gpu/drm/vkms/vkms_crtc.c
@@ -100,6 +100,9 @@ static bool vkms_get_vblank_timestamp(struct drm_crtc *crtc,
 
 	*vblank_time = READ_ONCE(output->vblank_hrtimer.node.expires);
 
+	if (!in_vblank_irq && *vblank_time == vblank->time)
+		return true;
+
 	if (WARN_ON(*vblank_time == vblank->time))
 		return true;
 

