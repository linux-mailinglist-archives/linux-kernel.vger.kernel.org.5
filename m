Return-Path: <linux-kernel+bounces-74337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD8185D2F5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DB8EB238A6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A758F3D0D1;
	Wed, 21 Feb 2024 08:59:49 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA53D3D0C6;
	Wed, 21 Feb 2024 08:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708505989; cv=none; b=l/ogs95GKLgVI8JmVzyQLbsbFR1NpJ0ScrGEzmv7MRaN+dv1JUg13me3VJDufRHIZaN+KRSjD3gMsR8JNz3p7TxtRDQievM0xx1Df5eZh2TALtLG9OJVQpgFPbp6bsAVbY3+2oi9KX77aDZ1C1+ur42fDwaP64kwGcW+wzlQ36U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708505989; c=relaxed/simple;
	bh=bpSDrbg1x+ADfRkSuv6gR85kGx7h4cdgDMDUKWHwcaY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ldD1mXjYaaD+CX6xs+YnHkDECo/OlXc9TdKBeBolQnNU8JS2E574ODTpwpbkM4pdTCwZo4KYr+1woKqEC/wJLIXmf96bxQqWwsvsMG1KjeFymzJicFhymA5tfBAaz+GjYh2joQr/gfthjbTs+j4amYqOKa61XzWFj6X1dfi1hGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 229ba8d755af451e99cec9e56b9074ff-20240221
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:fd401693-8bb0-4312-b356-3816213a343c,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.35,REQID:fd401693-8bb0-4312-b356-3816213a343c,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:5d391d7,CLOUDID:4c458b8f-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:240221165940WOC6CRID,BulkQuantity:0,Recheck:0,SF:66|24|17|19|44|102,
	TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
	,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS
X-UUID: 229ba8d755af451e99cec9e56b9074ff-20240221
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 584099357; Wed, 21 Feb 2024 16:59:40 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 01462E000EBC;
	Wed, 21 Feb 2024 16:59:40 +0800 (CST)
X-ns-mid: postfix-65D5BB7B-805504581
Received: from kernel.. (unknown [172.20.15.254])
	by mail.kylinos.cn (NSMail) with ESMTPA id D5B81E000EBC;
	Wed, 21 Feb 2024 16:59:38 +0800 (CST)
From: Kunwu Chan <chentao@kylinos.cn>
To: manivannan.sadhasivam@linaro.org
Cc: mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH] bus: mhi: ep: Simplify the allocation of slab caches in mhi_ep_register_controller
Date: Wed, 21 Feb 2024 16:59:37 +0800
Message-Id: <20240221085937.167200-1-chentao@kylinos.cn>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
to simplify the creation of SLAB caches.

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 drivers/bus/mhi/ep/main.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
index 65fc1d738bec..7b61d384b2b6 100644
--- a/drivers/bus/mhi/ep/main.c
+++ b/drivers/bus/mhi/ep/main.c
@@ -1493,9 +1493,7 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl =
*mhi_cntrl,
 		goto err_destroy_ev_ring_el_cache;
 	}
=20
-	mhi_cntrl->ring_item_cache =3D kmem_cache_create("mhi_ep_ring_item",
-							sizeof(struct mhi_ep_ring_item), 0,
-							0, NULL);
+	mhi_cntrl->ring_item_cache =3D KMEM_CACHE(mhi_ep_ring_item, 0);
 	if (!mhi_cntrl->ev_ring_el_cache) {
 		ret =3D -ENOMEM;
 		goto err_destroy_tre_buf_cache;
--=20
2.39.2


