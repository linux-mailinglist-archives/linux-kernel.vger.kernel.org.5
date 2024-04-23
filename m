Return-Path: <linux-kernel+bounces-154431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E65D68ADBFF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 04:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B102283D79
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 02:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7501217C73;
	Tue, 23 Apr 2024 02:41:47 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE015E574
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 02:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713840107; cv=none; b=abre2z8novOCmRd1OuDySsiR1ocVjwCo400r3TcOmRtwZ8U35nrexFEGaHnaW7tAQGAGoFZMktJmkBGEsmnameX/hUTbTzp3MBXw7Cl79lKeZpaUMVhoZlCHuQcj8fMB6zB0DEpYece/Gj4bAL6Nb9VJ1FIa7to2t8BmhV4N58I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713840107; c=relaxed/simple;
	bh=fKs0jIXa3gnFBSsBMylG2iyXyslYb90wPx+biLJKdZU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NYPCtvZFNrSZupIPK+YmUo4wCSWet0M2ito4eg1HajsU4qOWlTbaMe6vRyH4SouciVZsLWfedfQjro5x79xn/SIPfj5nwbLlCQ1CXHXabIkhWWR4QXaILXLa02pykwMNCGhwSnxDcDjm6cVh9oCPp/SjuXT6G219MmAzh4gmNT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 014bff9c011b11ef9305a59a3cc225df-20240423
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:3a5cc699-663c-4e05-b581-0cc67a517d84,IP:20,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:1,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:16
X-CID-INFO: VERSION:1.1.37,REQID:3a5cc699-663c-4e05-b581-0cc67a517d84,IP:20,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:1,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:16
X-CID-META: VersionHash:6f543d0,CLOUDID:a9e36e9d920fcd1a80fba757d9883cc3,BulkI
	D:240423104139GMGK0LEM,BulkQuantity:0,Recheck:0,SF:19|43|74|66|38|24|72|10
	2,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:
	nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 014bff9c011b11ef9305a59a3cc225df-20240423
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw.kylinos.cn
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1491849440; Tue, 23 Apr 2024 10:41:36 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id A770EE000EB9;
	Tue, 23 Apr 2024 10:41:36 +0800 (CST)
X-ns-mid: postfix-66271FE0-474456508
Received: from kernel.. (unknown [10.42.12.206])
	by mail.kylinos.cn (NSMail) with ESMTPA id E1444E000EB9;
	Tue, 23 Apr 2024 10:41:34 +0800 (CST)
From: Kunwu Chan <chentao@kylinos.cn>
To: tomas.winkler@intel.com,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	kunwu.chan@hotmail.com
Cc: linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH] mei: bus: constify the struct mei_cl_bus_type usage
Date: Tue, 23 Apr 2024 10:41:33 +0800
Message-Id: <20240423024133.1890455-1-chentao@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Now that the driver core can properly handle constant struct bus_type,
move the mei_cl_bus_type variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 drivers/misc/mei/bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/mei/bus.c b/drivers/misc/mei/bus.c
index f9bcff197615..99393f610cdf 100644
--- a/drivers/misc/mei/bus.c
+++ b/drivers/misc/mei/bus.c
@@ -1327,7 +1327,7 @@ static int mei_cl_device_uevent(const struct device=
 *dev, struct kobj_uevent_env
 	return 0;
 }
=20
-static struct bus_type mei_cl_bus_type =3D {
+static const struct bus_type mei_cl_bus_type =3D {
 	.name		=3D "mei",
 	.dev_groups	=3D mei_cldev_groups,
 	.match		=3D mei_cl_device_match,
--=20
2.40.1


