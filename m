Return-Path: <linux-kernel+bounces-99905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E3D878F01
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 08:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 976131F21CD6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 07:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430D36995D;
	Tue, 12 Mar 2024 07:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="JWzN6XxQ"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C89E69952;
	Tue, 12 Mar 2024 07:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710227243; cv=none; b=q3OhlMiOUubS2TpvSF7kp6gVORdbMHpfTUeBOPIHCelXIFdrxgZ9O3h4ItYNN1XLc8Fsd92iZty27NgIo42F2nBks8Ui6mzwd56x391lDlXcpTj1NrH3yjHMo6EvZUq8jlkCVfl9kTYw9mQQye9K6vJJmQL9gt5UwVi3E/u38bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710227243; c=relaxed/simple;
	bh=n2RgX7HyMPveyeZgRE5IAVfT1uoWlIc6v/bHzlqjU38=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Lz6e6sF/QvoFhTo3IcE+4taX6RFt7fN36Pz/oOGYvoSOloAwShQwgQHcypKC0N6o4UwI58XCCQnB/TIoHkQv1Kor/FwSjO43O0vRI5kNRMufKQggU+ofciofIhjQxDff2dd1GExRRuyTtLNzCamJVV/f2pDT8VUfDw56iWgbBBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=JWzN6XxQ; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42C604u0005068;
	Tue, 12 Mar 2024 00:07:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=pfpt0220; bh=KIP6bKka
	6cnvLSrf6jg/dLHWtt4DI3394v40vio2Uuo=; b=JWzN6XxQMwiUB/nfucdMhc97
	YD+h4aftKTclItdA8mcsNO3AClE7e93Rhi0bxAaLkVapJhx4oSf6VjDSyqbQNdZm
	dk7bCwuPFvpBuTCI+yqlasNlRoF8cLp8SPyBbOoshAqNOwMIKqnSABcsJgQcBRr3
	REcs47daboQifUZ4b/FVF7kckKoOwuwP/GquG8pft+aYEcjPKmEsalXjrMvuBPwC
	tnszkcfMWTqLqQkjWEgrkU5oLwRAht4lMOFXr7EIsRwYXCG0c/o397/FZ0wPY/4v
	A9qYheKrVbSwdzhPldIcOJNkaBs8MhwqKaSht2fAmv668TI/PDQgwv3oPrQDNg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3wswdcv65m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 00:07:03 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Tue, 12 Mar 2024 00:07:03 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Tue, 12 Mar 2024 00:07:03 -0700
Received: from virtx40.. (unknown [10.28.34.196])
	by maili.marvell.com (Postfix) with ESMTP id 99C073F7089;
	Tue, 12 Mar 2024 00:06:59 -0700 (PDT)
From: Linu Cherian <lcherian@marvell.com>
To: <davem@davemloft.net>, <sgoutham@marvell.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <gakula@marvell.com>, <hkelam@marvell.com>, <sbhatta@marvell.com>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        Linu Cherian
	<lcherian@marvell.com>
Subject: [net PATCH] octeontx2-af: Use matching wake_up API variant in CGX command interface
Date: Tue, 12 Mar 2024 12:36:22 +0530
Message-ID: <20240312070622.844546-1-lcherian@marvell.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: rTYhXp5McGDAPw4415WxCnRELmXXXG6b
X-Proofpoint-GUID: rTYhXp5McGDAPw4415WxCnRELmXXXG6b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_06,2024-03-11_01,2023-05-22_02

Use wake_up API instead of wake_up_interruptible, since
wait_event_timeout API is used for waiting on command completion.

Fixes: 1463f382f58d ("octeontx2-af: Add support for CGX link management")
Signed-off-by: Linu Cherian <lcherian@marvell.com>
Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
index 6c70c8498690..3c0f55b3e48e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
@@ -1338,7 +1338,7 @@ static irqreturn_t cgx_fwi_event_handler(int irq, void *data)
 
 		/* Release thread waiting for completion  */
 		lmac->cmd_pend = false;
-		wake_up_interruptible(&lmac->wq_cmd_cmplt);
+		wake_up(&lmac->wq_cmd_cmplt);
 		break;
 	case CGX_EVT_ASYNC:
 		if (cgx_event_is_linkevent(event))
-- 
2.34.1


