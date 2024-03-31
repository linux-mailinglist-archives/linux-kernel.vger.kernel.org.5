Return-Path: <linux-kernel+bounces-126072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 546778931BA
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 15:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F16F2820BD
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 13:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A78144D26;
	Sun, 31 Mar 2024 13:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="llXxBf08"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0687B286AC;
	Sun, 31 Mar 2024 13:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711892589; cv=none; b=PFa0IEZfh70ay22iLAePWbcuh+6q6PDwpPWypbMQyiFEGU6M3DfU5bht7bIGRN+w4OmfiB6zH14vCBMZFzjADe4+shmaHZdt/hRyp0PwZYwR2dkfS1eFPRvTQJNhsRjlUSsCJz7zH7Up6KGBE+/yd63Rr8GqZnU1FHYQt3KlN9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711892589; c=relaxed/simple;
	bh=5WAZo0YdO8tl/MrJZpa7MSmvaD8PDaPvNABs/C71lOA=;
	h=From:To:Cc:Subject:Date:Message-Id; b=aRvUJsRRuxjnsR20KcViJQePpin9HNYjmevU4YvAy1lLyntPyEgCUWbI0Or6pH7AB+ME9ALMjacPHceHWGIy41rClMUXRYRgGfoD7pnFPqcYouosv9dw/ZkLpZGrDBxkqTMNhWyI3TE3edEF524Nm1Y4pWKbsql3vCfm1DO3M48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=llXxBf08; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42V6tCV4026639;
	Sun, 31 Mar 2024 13:43:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2023-11-20;
 bh=SI1+6SSXH/ywVAxQnlKQBvhjdj8fDahRPDX7qgRXuBc=;
 b=llXxBf08i84mCXGGL1SgRiEu9sne49JNPwzcdyvgOiG8LdN1GmQlXhfpS5EB2Q/SVNqz
 4MZNHWndvBpFc688GPlG4Tp9bmhoVbxs0X3e/VRz5hjsjmBAh0wCQ+7hFdhLRSy/6ny0
 YQSauFnWQwPhLcXjhBWrh9qn9Vtzqlp9z4rzDyABupNJ2FNfeEz+pQcFO7v5eUbOhJ5c
 X/6wHiuzLjdbkn6kh3Ij13HuQ1rpQuzZn+OCRjPVTZ05zCAnXcQm/ylFWTkVz8yxLNyU
 K2q/4puxzqIwwWU6SQm/ja8Cgepl899Pm2i8rOeKXOhiGVWw6/pGOxDv+Nt2bwUlcFz4 3Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x695eh62y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 31 Mar 2024 13:43:01 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42VBVW70040452;
	Sun, 31 Mar 2024 13:43:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3x6964hgwk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 31 Mar 2024 13:43:00 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42VDgxX3015876;
	Sun, 31 Mar 2024 13:42:59 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3x6964hgud-1;
	Sun, 31 Mar 2024 13:42:59 +0000
From: Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>
To: davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        maheshb@google.com, edumazet@google.com
Cc: gia-khanh.nguyen@oracle.com
Subject: [PATCH net-next] Add handling of NETDEV_DOWN event
Date: Sun, 31 Mar 2024 06:41:28 -0700
Message-Id: <1711892489-27931-1-git-send-email-venkat.x.venkatsubra@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-31_10,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 phishscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403310104
X-Proofpoint-GUID: ogmosjuspuc58hl-5uxRx0Nw0uQii6ia
X-Proofpoint-ORIG-GUID: ogmosjuspuc58hl-5uxRx0Nw0uQii6ia
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

When ethP is the parent interface of ipvlan interface ethC,
and you do

# ip link set ethP down

ethC's link state is not brought down.

In the below example, ens5 is the host interface which is the 
parent of the ipvlan interface eth0 in the container.

Host:

[root@gkn-podman-x64 ~]# ip link set ens5 down
[root@gkn-podman-x64 ~]# ip -d link show dev ens5
3: ens5: <BROADCAST,MULTICAST> mtu 9000 qdisc mq state DOWN 
      ...
[root@gkn-podman-x64 ~]#

Container:

[root@testnode-ol8 /]# ip -d link show dev eth0
2: eth0@if3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 9000 state UNKNOWN 
        ...
    ipvlan mode l2 bridge 
[root@testnode-ol8 /]#

eth0 continues to remain UP.

macvlan already addresses this handling of NETDEV_DOWN event.
Adding the same functionality to ipvlan.

Venkat Venkatsubra (1):
  ipvlan: handle NETDEV_DOWN event

 drivers/net/ipvlan/ipvlan_main.c | 1 +
 1 file changed, 1 insertion(+)

-- 
1.8.3.1


