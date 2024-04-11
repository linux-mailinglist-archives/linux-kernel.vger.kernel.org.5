Return-Path: <linux-kernel+bounces-139940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A93238A095D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E7BB1F224AB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321D313E8A1;
	Thu, 11 Apr 2024 07:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="HLXTbNFO"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A3A13E020
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 07:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712819450; cv=none; b=ZYFTgd3vEnOYTGuBYIBBROctpjabLADA71MxtDnKibECTGp3IGTNuMIv9e3loNkXD0tznAehkjicPpSZIusiKm44EWn3FSCn2VekuOAOEc089LRVOC/jysiPKxRkPhFP2tgVTS/SK+aQdGLma6rMRVdWtaU1yVEqWjNpPtxYgbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712819450; c=relaxed/simple;
	bh=EVrrGbITq6iY1+riebn7BmWva7odfM/dc+M8apZJsbk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=VMf4bZans+dgU1oEDWxpj3R+Ygvtm+489Jo7k6JG2KCe2RuULdCWPKPz3zuD7cfB2ykaiu3yBdf7dqeIp8TPG5DD1JrtM0SLCaUmKQZl/5cjK8bvssMd4qSOrEo+HXn57Z3YzLE4HnGhvl9GPwq/iNTggq7iq8UIk+otXdcke3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=HLXTbNFO; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240411071044epoutp03ca9d15593539dac641c9e71d804894ba~FKDWpQE4z2317223172epoutp03B
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 07:10:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240411071044epoutp03ca9d15593539dac641c9e71d804894ba~FKDWpQE4z2317223172epoutp03B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1712819444;
	bh=zVTnUQHv886FrPUVq7+WRcst/8IszsvzOiHELYTRM4Q=;
	h=From:To:Cc:Subject:Date:References:From;
	b=HLXTbNFO1TrH7dJM4cA5ghQdyg+scQATWASlRi0RrqKUGCSVcCX8EiTxE1ollqjBj
	 yi9MOeiek/6Xx2n6OSkF+cfH1lFLUWkdHFuE2cPOiXkuVbA2S9OEe9lFD4v1bqfy7p
	 q1zh8Hic8qq6b3SS06mZh9jGWoV9QlILBG66jHtE=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTP id
	20240411071043epcas2p4f4f3f01b427d0aa827a057608b6ea64b~FKDWBERXA0511405114epcas2p4m;
	Thu, 11 Apr 2024 07:10:43 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.99]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4VFW7Q60s7z4x9Q1; Thu, 11 Apr
	2024 07:10:42 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
	epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
	2A.99.09640.2FC87166; Thu, 11 Apr 2024 16:10:42 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
	20240411071042epcas2p4b2e6937a952e6dfa879db166983b1c54~FKDU5YhP40511405114epcas2p4j;
	Thu, 11 Apr 2024 07:10:42 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240411071042epsmtrp151f16100e8b264a1de75943ef94c66ce~FKDU4ULWa2252922529epsmtrp18;
	Thu, 11 Apr 2024 07:10:42 +0000 (GMT)
X-AuditID: b6c32a48-01f5ca80000025a8-88-66178cf24864
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	21.54.07541.2FC87166; Thu, 11 Apr 2024 16:10:42 +0900 (KST)
Received: from rack03.dsn.sec.samsung.com (unknown [10.229.95.126]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240411071042epsmtip1a0e5464db6a74fe1adfd6a7cc2e38d72~FKDUngiKF0441504415epsmtip1R;
	Thu, 11 Apr 2024 07:10:42 +0000 (GMT)
From: SEO HOYOUNG <hy50.seo@samsung.com>
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
	alim.akhtar@samsung.com, avri.altman@wdc.com, jejb@linux.ibm.com,
	martin.petersen@oracle.com, beanhuo@micron.com, bvanassche@acm.org,
	kwangwon.min@samsung.com, kwmad.kim@samsung.com, sh425.lee@samsung.com,
	quic_nguyenb@quicinc.com, cpgs@samsung.com, h10.kim@samsung.com
Cc: SEO HOYOUNG <hy50.seo@samsung.com>
Subject: [PATCH v3] scsi: ufs: core: changing the status to check inflight
Date: Thu, 11 Apr 2024 16:14:44 +0900
Message-Id: <20240411071444.51873-1-hy50.seo@samsung.com>
X-Mailer: git-send-email 2.26.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHJsWRmVeSWpSXmKPExsWy7bCmue6nHvE0g/3LDCwezNvGZvHy51U2
	i4MPO1kspn34yWzx8pCmxd/bF1ktVi9+wGKx6MY2JoutN3ayWNzccpTF4vKuOWwW3dd3sFks
	P/6PyWLqi+PsFkv/vWVx4Pe4fMXbY8KiA4we39d3sHl8fHqLxWPinjqPvi2rGD0+b5LzaD/Q
	zRTAEZVtk5GamJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQN0
	upJCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jEVim1ICWnwLxArzgxt7g0L10vL7XEytDAwMgU
	qDAhO+PGuRtMBSu4Kj4u3sbewHiBo4uRk0NCwESiZ+VVli5GLg4hgR2MEld23YVyPjFK3P43
	lRHC+cYo8W3PdEaYlt9H+6Gq9jJKvDx3gRnC+cEo0X24FayKTUBDYs2xQ0wgtojAZSaJP8vM
	QGxmATWJz3eXsYDYwgJeEkcbj7OC2CwCqhJL9u8Ai/MKWEr0bV7FDLFNXmJRw28miLigxMmZ
	T1gg5shLNG+dDbZYQmAmh8S369ehGlwkpsxvYoOwhSVeHd/CDmFLSbzsbwOyOYDsYolZC6sh
	ehsYJQ7NngVVYywx61k7I0gNs4CmxPpd+hDlyhJHbkGt5ZPoOPwXqppXomHjb6iJvBIdbUIQ
	YSWJM3NvQ4UlJA7OzoEIe0h0LHoDDhwhgViJ53e3sE5gVJiF5K9ZSP6ahXDCAkbmVYxiqQXF
	uempxUYFJvD4Tc7P3cQITshaHjsYZ7/9oHeIkYmD8RCjBAezkgivtJZomhBvSmJlVWpRfnxR
	aU5q8SFGU2BIT2SWEk3OB+aEvJJ4QxNLAxMzM0NzI1MDcyVx3nutc1OEBNITS1KzU1MLUotg
	+pg4OKUamKRS3pXxLp04o/7gK/Y/UhIWnzK+2lWabGacldfLGsurtnDzg2mysw+dmMV+pqu5
	/trEupe+a5/1HXfenHL2fHTF3iLr0Js6SizGnWJtsTENAjuzP0ZODS8JyGC5eD32lU28eLra
	8WfN0kE7zio7zlyrwmFgmf9ywuf4SRMLfcyDnqVeqz/P6cdR4dwVdXJ1XOOKhc9lItZ9KRfZ
	1Lrxh4fF1l/Ln7Rn9/7YZ7mk3cj8/VzJqRNiLuaeu5p1dOFn3t6Zfy4wTZSrCD3Barr30fUd
	a/T/+kQfPRnQs5HNjJ3xssc9U0G3GTW3F+kv/qCbW6NWHZ35QvWtzxLe3lm7cq7rHU2yXDuP
	b0cgq9dJeyWW4oxEQy3mouJEAAJDc2FRBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCLMWRmVeSWpSXmKPExsWy7bCSnO6nHvE0g/sbuCwezNvGZvHy51U2
	i4MPO1kspn34yWzx8pCmxd/bF1ktVi9+wGKx6MY2JoutN3ayWNzccpTF4vKuOWwW3dd3sFks
	P/6PyWLqi+PsFkv/vWVx4Pe4fMXbY8KiA4we39d3sHl8fHqLxWPinjqPvi2rGD0+b5LzaD/Q
	zRTAEcVlk5Kak1mWWqRvl8CVcePcDaaCFVwVHxdvY29gvMDRxcjJISFgIvH7aD9LFyMXh5DA
	bkaJaxc3sEMkJCT+L25igrCFJe63HGGFKPrGKPGpt4cZJMEmoCGx5tghJpCEiMBTJokTh7rA
	EswCahKf7y5jAbGFBbwkjjYeZwWxWQRUJZbs3wEW5xWwlOjbvIoZYoO8xKKG30wQcUGJkzOf
	sEDMkZdo3jqbeQIj3ywkqVlIUgsYmVYxSqYWFOem5yYbFhjmpZbrFSfmFpfmpesl5+duYgRH
	hJbGDsZ78//pHWJk4mA8xCjBwawkwiutJZomxJuSWFmVWpQfX1Sak1p8iFGag0VJnNdwxuwU
	IYH0xJLU7NTUgtQimCwTB6dUA9PKBatYHuQt2LRUXbYxK8fKXcS2Wl/RuaVdXEtxceAD991M
	alPCFXl5cx6+cpsutjZzZ7hm6I+UGVw3KoP05c2jT5ya7RF95YLoPtZti7j8Cnet7DgixRdw
	mefeyfIEa7ZvNZsXhFlzTn+xRLTmf8w2juyU1XPcVk1gfH4qZNcD6xvPlXbt6V/e2cN2Y9ax
	uzPOtH+zsdh5fbaWUETS3EtNekHvWD+v9t/at+oht8K9TN79e8UERAJjb9m/K+E9tiUl8sbl
	SNZFLd5TFzBYLQlgzHCe+ST9X/V8jxhjvr2utg9/zrS7dl/gm0pBKh+LQHv7Kb7i//d/l81Q
	4NCzC3/F3Sc9zVPozUzbgAsl85RYijMSDbWYi4oTAUrSb9r3AgAA
X-CMS-MailID: 20240411071042epcas2p4b2e6937a952e6dfa879db166983b1c54
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240411071042epcas2p4b2e6937a952e6dfa879db166983b1c54
References: <CGME20240411071042epcas2p4b2e6937a952e6dfa879db166983b1c54@epcas2p4.samsung.com>

ufshcd_cmd_inflight() is used to check whether or not a command is
in progress.
Make it skip commands that have already completed by changing the
!blk_mq_request_started(rq) check into blk_mq_rq_state(rq)
!= MQ_RQ_IN_FLIGHT.
We cannot rely on lrbp->cmd since lrbp->cmd is not cleared
when a command completes.

v1 -> v2: convert the two return statements into a single return statement
And modified comment of commit

v2 -> v3: remove superfluous parentheses in the above return statement

Link: https://lore.kernel.org/linux-scsi/20230517223157.1068210-3-bvanassche@acm.org/
Signed-off-by: SEO HOYOUNG <hy50.seo@samsung.com>
---
 drivers/ufs/core/ufshcd.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 21429eec1b82..a99f7ab85f12 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -3082,16 +3082,7 @@ static int ufshcd_compose_dev_cmd(struct ufs_hba *hba,
  */
 bool ufshcd_cmd_inflight(struct scsi_cmnd *cmd)
 {
-	struct request *rq;
-
-	if (!cmd)
-		return false;
-
-	rq = scsi_cmd_to_rq(cmd);
-	if (!blk_mq_request_started(rq))
-		return false;
-
-	return true;
+	return cmd && blk_mq_rq_state(scsi_cmd_to_rq(cmd)) == MQ_RQ_IN_FLIGHT;
 }
 
 /*
-- 
2.26.0


