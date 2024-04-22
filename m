Return-Path: <linux-kernel+bounces-152675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB0C8AC2AD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 04:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8788B2813E8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 02:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078634A33;
	Mon, 22 Apr 2024 02:02:53 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1553C17
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 02:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713751372; cv=none; b=RVlD3tYGgZtyXs+khIt/6jCy8h8ru/eWbHDb9RcM+fCAU6MTdn9S4Mf7Pbr+QQ7kj237mUIlh3UcO/gajLKhrtXP5psDN2WaH+QmKpESrrGOf8rWpeBFOe/LzaOyejTDi12J73so6EP/1EoGtWuBFiv/lt5Okm6QSD+Yxpf+EVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713751372; c=relaxed/simple;
	bh=pAU0e56iFIcZ9m3s3dM2+RRsLauNsGAGOhbFULatoeE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Hw0aU+qKFCmuYMatPv/UhDsAJnkJpsDfYFZPyZlWu/aHKJEqt1cK+XZlWeJKapnrnl3GjUdq0vUUhu+awSRWdKYzMeW1hC7zkhWSIAodzLGmUVlbUb51LOneWALC4BDd6cRv4FybQVWJjtOsdE1LvvDcgbhq7P7+wLwn3upULA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: b0937d3e004b11ef9305a59a3cc225df-20240422
X-CID-UNFAMILIAR: 1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:89f8899f-687c-4097-b7d5-8943da8da9d1,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:14,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:24
X-CID-INFO: VERSION:1.1.37,REQID:89f8899f-687c-4097-b7d5-8943da8da9d1,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:14,FILE:0,BULK:0,RULE:Release_HamU,ACTION
	:release,TS:24
X-CID-META: VersionHash:6f543d0,CLOUDID:1aa4d53c25ac21e2b90b5dbb5d3618b1,BulkI
	D:240422095737PHXHSOWH,BulkQuantity:0,Recheck:0,SF:16|19|43|74|66|38|24|10
	2,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:
	nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_USA,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: b0937d3e004b11ef9305a59a3cc225df-20240422
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw.kylinos.cn
	(envelope-from <xieming@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 850259233; Mon, 22 Apr 2024 09:57:35 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 6AF33E000EB9;
	Mon, 22 Apr 2024 09:57:35 +0800 (CST)
X-ns-mid: postfix-6625C40F-201169431
Received: from localhost.localdomain (unknown [10.42.12.232])
	by mail.kylinos.cn (NSMail) with ESMTPA id DD957E000EB9;
	Mon, 22 Apr 2024 09:57:34 +0800 (CST)
From: xieming <xieming@kylinos.cn>
To: catalin.marinas@arm.com,
	will@kernel.org,
	shuah@kernel.org
Cc: linux-kernel@vger.kernel.org,
	xieming <xieming@kylinos.cn>
Subject: [PATCH] kselftest/arm64: Remove unused parameters in abi test
Date: Mon, 22 Apr 2024 09:57:30 +0800
Message-Id: <20240422015730.89805-1-xieming@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Remove unused parameter i in tpidr2.c main function.

Signed-off-by: xieming <xieming@kylinos.cn>
---
 tools/testing/selftests/arm64/abi/tpidr2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/abi/tpidr2.c b/tools/testing/s=
elftests/arm64/abi/tpidr2.c
index 02ee3a91b780..285c47dd42f6 100644
--- a/tools/testing/selftests/arm64/abi/tpidr2.c
+++ b/tools/testing/selftests/arm64/abi/tpidr2.c
@@ -262,7 +262,7 @@ static int write_clone_read(void)
=20
 int main(int argc, char **argv)
 {
-	int ret, i;
+	int ret;
=20
 	putstr("TAP version 13\n");
 	putstr("1..");
--=20
2.25.1


