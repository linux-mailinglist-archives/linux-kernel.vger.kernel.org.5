Return-Path: <linux-kernel+bounces-80524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E128986691F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 05:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68B9CB2213F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 04:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68DA81B593;
	Mon, 26 Feb 2024 04:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="DibklIX8"
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AFD1B27D
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 04:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708920146; cv=none; b=uNTNkyd7sO9iaoexR/TBe+x5zvuJJ/2ttwRvswFRoLpxe83/CDsGtWKzlurPUZ4eGGtccctaPGHZ2M5tiAgyIJZHuU3uF8xOduI7Cez86ZHr4BrlrOvEf2a8Y076N2k08Lg9udDLSTqTOXoeGmJ4BY7zpoJ9CnCMcZ/KzVVUucM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708920146; c=relaxed/simple;
	bh=LOABVSf79geybJN4DQhM9YJDQ+2x4J0sTuqeGEDlZus=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jfk55ISHF6VO6yNufrMrqzbobLdopUDq0ZhwC2x9GB17PrtOQhdnNbVqzpsC96tpopQ/prvH9R4m1sa3tqvc5QNM33OnhdM5kj8xXxlQdYqW5gGMhPGLzmv3i53gFyG/h7c5XqO++EWIa4F1Z331ZRODByVrGnyPiouhERPxUek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=DibklIX8; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41Q3gmHI012557;
	Mon, 26 Feb 2024 04:02:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PPS06212021; bh=hxZfxLuN5IBbtVCVA9Sdm69q2IlqTKCbXSZFXp0KSOA=; b=
	DibklIX86Q8iwRg8q5YOCEB3/euk9g605HYCI0ezC5EEKrrkMhV0rG6jHMTGagm8
	BLks+K7d3mHlVABm3ccgNu73VZzFsZzYF1z+4m8uzo7Yt668ZZNBDHQ6GOHoa5r3
	N1oVxIzSNRJ0/ReabdEcJGuk7oNuHrN2jIttJpDgt3zuPYGPtIOw6pRQbCOecHEY
	ThOa8AIALSG4FoUrsR4BayxZFU28MY0M8FG12iDMN7J5+GkXCc4yiV3KQGu3hAlJ
	FHKmKWcJof0FWenfVEYkJ2e6Y1pGLd4GyVohZL2hDHeVtNGNlzHoWC9EPxNWbOW3
	7p7DPm92G6Flqqx32lN4Nw==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3wf5nx1h3d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 26 Feb 2024 04:02:16 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 25 Feb 2024 20:02:14 -0800
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Sun, 25 Feb 2024 20:02:13 -0800
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <syzbot+93bd128a383695391534@syzkaller.appspotmail.com>
CC: <syzkaller-bugs@googlegroups.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [syzbot] [dri?] WARNING in vkms_get_vblank_timestamp (2)
Date: Mon, 26 Feb 2024 12:02:13 +0800
Message-ID: <20240226040213.1200539-1-lizhi.xu@windriver.com>
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
X-Proofpoint-GUID: HuD90L6zHc2OIM5EfZRtIWHF9bGZqXVn
X-Proofpoint-ORIG-GUID: HuD90L6zHc2OIM5EfZRtIWHF9bGZqXVn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_01,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=810
 malwarescore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402260029

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

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
 

