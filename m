Return-Path: <linux-kernel+bounces-66383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 063D8855BF4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F5901F2C19D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 08:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66EE111CB7;
	Thu, 15 Feb 2024 08:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PWbaX00c"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31315CA4A;
	Thu, 15 Feb 2024 08:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707984309; cv=none; b=tOV7z51GpvaZemATWN4Bqc6Omn6KDem9Jp0iJtd6E7xq1tI/J7Mx4mrAX1YRaL65G07PKDLC/AHiEr5xMDT0dTOKVAdvSqEGum1IfWKrVAlfjK9oKsUjSLssfZ80vyCzBFxgtRJuIpxqplzhZGn2sk2Pcv+7gMWdGm127HLFRsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707984309; c=relaxed/simple;
	bh=l1Z8oWLThZJKygJhLa3Xd+Gr0+ms3JEvYXe26gCIuDw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Xzj1w/gzpINbt4EFT/EoQgLyE7t+KM6jPA2nB65f9yr70nebhj5gvyW5O80zIhVcI6FVsGhwu6Ez8SQvl3JA7Y2Ed5eAseOl2ZlE5kEYl1F8U0E0YpiKjIQMEw8Mv9ulPIoq8DtC8lO0ZfpHkZ2GsiiAZPmDDDCI3AHhw/sl8hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PWbaX00c; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41F82Gl7001373;
	Thu, 15 Feb 2024 08:05:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=KCjhOHGwNt9wNKq0wSWCTZL+6EUwj6/S4Iiqw8b7DVA=;
 b=PWbaX00cn+CHhxHd9iGkpsb6zhOxmrpjsdKD+qzXGVmOcxcXJerN20ztmeKgxAmpQ8oo
 v+ynnfp4GS8WsWMSS/NlKgLAUUjUdsCoAyp+TLtudFs3hcg6CB8enYVVgXPKydwuXQrF
 Gm5ZTSkjyWVIJltadVsfo1d/bEEItS/m2LXghxa+KAUv1GF2d3X+sjIcsjbDedRygFd5
 S+8Bv1wVMIcR30p/KYj2EtFV+Q26EDv9OyfzCSS1Iqd1zCzdIglHBz/kbcEWVJffnCY3
 bB7rtKUzRCPcTFH5Z8XfcGZb/CzVUrYlqBCjfPp3ciB9S6+7SGo90ZlFlI3a5AYgIEeU xA== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w9er9040b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 08:05:06 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41F6OuBe010083;
	Thu, 15 Feb 2024 08:05:06 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w6npm30w5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 08:05:05 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41F850co20185844
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 08:05:02 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 945CC2004B;
	Thu, 15 Feb 2024 08:05:00 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8484820043;
	Thu, 15 Feb 2024 08:05:00 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 15 Feb 2024 08:05:00 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id 4B9D6E034A; Thu, 15 Feb 2024 09:05:00 +0100 (CET)
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Alexandra Winter <wintera@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net/af_iucv: fix virtual vs physical address confusion
Date: Thu, 15 Feb 2024 09:05:00 +0100
Message-Id: <20240215080500.2616848-1-agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 33DXnE6CYlwWVxnRHpHKWMhHELnQjumZ
X-Proofpoint-ORIG-GUID: 33DXnE6CYlwWVxnRHpHKWMhHELnQjumZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_08,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 mlxscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 adultscore=0
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402150062

Fix virtual vs physical address confusion. This does not fix a bug
since virtual and physical address spaces are currently the same.

Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 net/iucv/af_iucv.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
index 498a0c35b7bb..4aa1c72e6c49 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -1060,13 +1060,12 @@ static int iucv_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 			int i;
 
 			/* skip iucv_array lying in the headroom */
-			iba[0].address = (u32)(addr_t)skb->data;
+			iba[0].address = (u32)virt_to_phys(skb->data);
 			iba[0].length = (u32)skb_headlen(skb);
 			for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
 				skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
 
-				iba[i + 1].address =
-					(u32)(addr_t)skb_frag_address(frag);
+				iba[i + 1].address = (u32)virt_to_phys(skb_frag_address(frag));
 				iba[i + 1].length = (u32)skb_frag_size(frag);
 			}
 			err = pr_iucv->message_send(iucv->path, &txmsg,
@@ -1162,13 +1161,12 @@ static void iucv_process_message(struct sock *sk, struct sk_buff *skb,
 			struct iucv_array *iba = (struct iucv_array *)skb->head;
 			int i;
 
-			iba[0].address = (u32)(addr_t)skb->data;
+			iba[0].address = (u32)virt_to_phys(skb->data);
 			iba[0].length = (u32)skb_headlen(skb);
 			for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
 				skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
 
-				iba[i + 1].address =
-					(u32)(addr_t)skb_frag_address(frag);
+				iba[i + 1].address = (u32)virt_to_phys(skb_frag_address(frag));
 				iba[i + 1].length = (u32)skb_frag_size(frag);
 			}
 			rc = pr_iucv->message_receive(path, msg,
-- 
2.40.1


