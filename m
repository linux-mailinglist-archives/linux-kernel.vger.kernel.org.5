Return-Path: <linux-kernel+bounces-96558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF5E875E1E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B324B21D6B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 07:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96164EB4A;
	Fri,  8 Mar 2024 07:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="XPXwAzt4"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16834E1DC;
	Fri,  8 Mar 2024 07:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709881373; cv=none; b=l4bbQfDVB3u2wHPaamYgsDavSnKH9FCB4DN+y3fspFX9EGAKYTiN+WH8r4qSR2y6qad9OJCzkHINe0Y7CMtpgHfAlMFgMuKE1GNCDPybBZ2b6oTaCa4Y/IU3fXwdZ6zKmk2cH881TuWC0MfFqs16Y9STziBLMK/scm4Hxtgf0MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709881373; c=relaxed/simple;
	bh=PAoomouKbOdQvIndHg/4IvzufyezdIjPnsSPwvJBt1c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QtW2E5lhxLtlWKQcQu8rp7ZVBQPIn8P3JT2OmPa+74UQMFYiFmhbz5ged8Tv5y1BMMsvXt8A/GbSQGlv8rSM78RfHzX4GFrhHHGDcSb4Q6DLA9i/ujuqazZKUpKhZ2MkEKsTfyBWUNDc8YuAGTtaUBR/4ogJr5h8KVsFHgXY1ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=XPXwAzt4; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: dc880b94dd1911eeb8927bc1f75efef4-20240308
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=3eAw1MxLJ/Z1C/F1OCuVuEQ3bEvjcOElWxZRU5ARRak=;
	b=XPXwAzt4pz0BM4rqsG0CkBudjsPIJeagw03r4YscMRSxx/haN5Vb3JThuJmJi1eDD0DXAmVVOni+lWKhOkh9ra8isgSFj/NWTCfWcsq95jIf94HnRpauI35L8G7oUVvbULDXTFLpVQfnvAvOgrN/XZsNbeL9a1J21t+IIJyI5VY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:53a474fa-9a44-49d8-8091-d614da0a7632,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6f543d0,CLOUDID:ec99a8ff-c16b-4159-a099-3b9d0558e447,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: dc880b94dd1911eeb8927bc1f75efef4-20240308
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <poshao.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1202741839; Fri, 08 Mar 2024 15:02:43 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 8 Mar 2024 15:02:42 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 8 Mar 2024 15:02:42 +0800
From: PoShao Chen <poshao.chen@mediatek.com>
To: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
CC: <lukasz.luba@arm.com>, <dietmar.eggemann@arm.com>, <rafael@kernel.org>,
	<mingo@kernel.org>, <rafael.j.wysocki@intel.com>, <rui.zhang@intel.com>,
	<vincent.guittot@linaro.org>, <daniel.lezcano@linaro.org>,
	<viresh.kumar@linaro.org>, <amit.kachhap@gmail.com>,
	<clive.lin@mediatek.com>, <ccj.yeh@mediatek.com>,
	<ching-hao.hsu@mediatek.com>, <poshao.chen@mediatek.com>
Subject: [PATCH 1/2] PM: EM: Add macro em_is_microwatts()
Date: Fri, 8 Mar 2024 14:59:21 +0800
Message-ID: <20240308065922.10329-1-poshao.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

This patch adds a new macro, em_is_microwatts(), which checks if
the EM_PERF_DOMAIN_MICROWATTS flag is set for a given Energy Model.
This macro enables other parts of the kernel, such as cooling
devices, to easily determine the unit of power used by the Energy
Model and to perform the necessary conversions if the values
are provided in microwatts.

Signed-off-by: PoShao Chen <poshao.chen@mediatek.com>
---
 include/linux/energy_model.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index 770755df852f..68145b4368d1 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -92,6 +92,7 @@ struct em_perf_domain {
 
 #define em_span_cpus(em) (to_cpumask((em)->cpus))
 #define em_is_artificial(em) ((em)->flags & EM_PERF_DOMAIN_ARTIFICIAL)
+#define em_is_microwatts(em) ((em)->flags & EM_PERF_DOMAIN_MICROWATTS)
 
 #ifdef CONFIG_ENERGY_MODEL
 /*
-- 
2.18.0


