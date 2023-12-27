Return-Path: <linux-kernel+bounces-12010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5CC381EED1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 13:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E805D1C224DF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 12:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0340744C6A;
	Wed, 27 Dec 2023 12:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Fqxkr07q"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256BF45001;
	Wed, 27 Dec 2023 12:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mx0b-0016f401.pphosted.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BR6g9G8007435;
	Wed, 27 Dec 2023 04:33:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	pfpt0220; bh=AyR61wXIiz22J6XT2KA/KC4IPW9Adjj9ZSNInPNcDJ0=; b=Fqx
	kr07qQSA7PT89yvojwOIk8G9mBNaB5+Otj/HASMPTt4gfD2lKPlGNoMF9TWaWcX5
	4QUDMOq6hhpAsJpNJLkHA4nKHPaM6M0fz8BMj8BYltrKmXx4Tym7cr17vmeBzjjg
	8+v4uzlC4GqI+MDXvGCkkmjjRJ1bCOo/kv3cbjpt93g3ecE+9qkOWy5bEj/DtoFL
	DLEmZTbTMs5VgjomvpuhyYNISFX7OGy2fYpACk/SVUP6GTJZ9IvzF6gQc18ejPdN
	o9aHXbl+H1NJ5Cvh0YfhDmsO5641iywF830d+3/EDdme4KrP/eTLu9+1Ov9B8Sto
	/Iz7x4xhLwVhXSRpa2A==
Received: from dc5-exch02.marvell.com ([199.233.59.182])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3v5yxp0a5t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Wed, 27 Dec 2023 04:33:20 -0800 (PST)
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 27 Dec
 2023 04:33:18 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Wed, 27 Dec 2023 04:33:17 -0800
Received: from dc3lp-swdev041.marvell.com (dc3lp-swdev041.marvell.com [10.6.60.191])
	by maili.marvell.com (Postfix) with ESMTP id E8A515B6937;
	Wed, 27 Dec 2023 04:33:11 -0800 (PST)
From: Elad Nachman <enachman@marvell.com>
To: <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <andrew@lunn.ch>, <gregory.clement@bootlin.com>,
        <sebastian.hesselbarth@gmail.com>, <huziji@marvell.com>,
        <ulf.hansson@linaro.org>, <catalin.marinas@arm.com>, <will@kernel.org>,
        <adrian.hunter@intel.com>, <thunder.leizhen@huawei.com>,
        <bhe@redhat.com>, <akpm@linux-foundation.org>, <yajun.deng@linux.dev>,
        <chris.zjh@huawei.com>, <linux-mmc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC: <enachman@marvell.com>, <cyuval@marvell.com>
Subject: [PATCH 2/4] dt-bindings: mmc: add Marvell ac5
Date: Wed, 27 Dec 2023 14:32:55 +0200
Message-ID: <20231227123257.1170590-3-enachman@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231227123257.1170590-1-enachman@marvell.com>
References: <20231227123257.1170590-1-enachman@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: GCD9rNl3OXNNyd3NGLlHc9V8yELlGl5x
X-Proofpoint-GUID: GCD9rNl3OXNNyd3NGLlHc9V8yELlGl5x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02

From: Elad Nachman <enachman@marvell.com>

Add dt bindings for Marvell ac5 eMMC controller

Signed-off-by: Elad Nachman <enachman@marvell.com>
---
 Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml b/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
index 3a8e74894ae0..50c6de8bf0bc 100644
--- a/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
@@ -34,6 +34,9 @@ properties:
           - const: marvell,armada-3700-sdhci
           - const: marvell,sdhci-xenon
 
+      - items:
+          - const: marvell,ac5-sdhci
+          - const: marvell,armada-ap806-sdhci
   reg:
     minItems: 1
     maxItems: 2
-- 
2.25.1


