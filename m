Return-Path: <linux-kernel+bounces-89242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5674B86ED29
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 01:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C8381F23FB0
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 00:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364CD8BFD;
	Sat,  2 Mar 2024 00:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kdA8FGru"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47EA12E40;
	Sat,  2 Mar 2024 00:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709337713; cv=none; b=ZdPEnFuCKMZmLNO1RXPPnwP1ac+h0hSHWK2QplJQGQk80ZEQSX0woAm9assIw3S0q1kOBPh9bS8d0qb+YTY7AA07vuI3yirOUzYfRG9jcm73i1U0NqmSHcAqnZ+2+8mTc0fpowvyD0txdnGfnSu4QnKyqIEhHSpVvDYWLPiwSwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709337713; c=relaxed/simple;
	bh=arBEGhBteVO4RjPz9tkU04LZ/Jgo6OcNUGZs76IOUR4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jlLoteLvgJBMqIjlx4BxAmPhbhUZOzhpSBUJaYGEQj01WTpAy0UGp9MTJJ2ExE9VJ37Y4dId+Xjqj2pRtNVH4BpHFV/9mKGjlMyO6aus/dGN+XrnHV7LpGsw3AkMZ+mDOJWdcnQ9cVr7y538RTeIII46AGJ9X3Cw/OvFaXEWjwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kdA8FGru; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 421Lhnt8026634;
	Sat, 2 Mar 2024 00:01:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=vKDPVMXw44ehTbUTyV9p12c9dr4eCzluThD8Tq6MyeU=;
 b=kdA8FGruOG9ZjTI7oQ2CYF9M2Gf1ziYDgoa/3325BIrQ396s1qxs8v40B6/1+t6ZKqml
 hbNE9lVrV6RgwIx6tZuRUOyKuMaHMixlGtB734LBqo6EW6CP8iUxUKbJAnmU0kPNoUQb
 hshaljT6Zwkr+A8VpZ//L0023zqeeoCOf87HYbFJnbZZZiCKVOsy9lWuj1aikEjcLicz
 C/kU8fHItDHTo5JbKRE3ND3YT+LSjAg1nJjGPdYFHAhYIvCr01oKiV0HyN/anNpRsJP0
 BlJk+q02iw+dqopsww5VMF9jWLWn7FtbU1KZxlwLt+B1kC/wHQFgmMjjY6UfGDcoeL0y vg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf722t5av-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 02 Mar 2024 00:01:36 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 421M2Rdi005715;
	Sat, 2 Mar 2024 00:01:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wjrrct3pc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 02 Mar 2024 00:01:35 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42201YFC037587;
	Sat, 2 Mar 2024 00:01:34 GMT
Received: from ca-dev110.us.oracle.com (ca-dev110.us.oracle.com [10.129.136.45])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3wjrrct3ne-1;
	Sat, 02 Mar 2024 00:01:34 +0000
From: Yifei Liu <yifei.l.liu@oracle.com>
To: jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc: yifei.l.liu@oracle.com, harshit.m.mogalapalli@oracle.com,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, jack.vogel@oracle.com,
        lihong.yang@intel.com, ramanan.govindarajan@oracle.com
Subject: [PATCH Linux-6.8-rc5 1/1] ixgbevf: start negotiate with api version 1.4
Date: Fri,  1 Mar 2024 15:58:37 -0800
Message-ID: <20240301235837.3741422-1-yifei.l.liu@oracle.com>
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
 definitions=2024-03-01_23,2024-03-01_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403010197
X-Proofpoint-ORIG-GUID: sROpH13LIyOES2ZB_47V_jY2iDavSJKo
X-Proofpoint-GUID: sROpH13LIyOES2ZB_47V_jY2iDavSJKo

ixgbevf updates to api version to 1.5 via
	commit 339f28964147d ("ixgbevf: Add support for new mailbox
	communication between PF and VF")
while the pf side is not updated to 1.5 properly. It will lead to a
failure of negotiation of api version 1.5 This commit will enforce
the negotiation to start with 1.4 which is working fine.

Normally the pf and vf side should be updated together. Example:
	commit adef9a26d6c39 ("ixgbevf: add defines for IPsec offload request")
	commit 7269824046376 ("ixgbe: add VF IPsec offload request message handling")


Reported-by: Manjunatha Gowda <manjunatha.gowda@oracle.com>
Signed-off-by: Yifei Liu <yifei.l.liu@oracle.com>
Reviewed-by: Jack Vogel <jack.vogel@oracle.com>
---
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index a44e4bd56142..a1b9b789d1d4 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -2286,6 +2286,12 @@ static void ixgbevf_negotiate_api(struct ixgbevf_adapter *adapter)
 
 	spin_lock_bh(&adapter->mbx_lock);
 
+	/* There is no corresponding drivers in pf for
+	 * api version 1.5. Try to negociate with version
+	 * 1.5 will always fail. Start to negociate with
+	 * version 1.4.
+	 */
+	idx = 1;
 	while (api[idx] != ixgbe_mbox_api_unknown) {
 		err = hw->mac.ops.negotiate_api_version(hw, api[idx]);
 		if (!err)
-- 
2.42.0


