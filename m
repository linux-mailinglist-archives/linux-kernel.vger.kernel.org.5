Return-Path: <linux-kernel+bounces-92337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18ACF871EBF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A586D1F236D6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89E55A4FE;
	Tue,  5 Mar 2024 12:14:56 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A167C5917C;
	Tue,  5 Mar 2024 12:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709640896; cv=none; b=kP1zfkbxi4BmK7W8eNj0aCNQysWNHit++BJZOiiokZyYA4yFQgJTKF0iL2Yxzgqi6ieFyj1MY6Vnp8nAoo7+3LmyjIjAXBgCseAHcr3NF8vJjRYntl/VaHGiix7lSgt1EHrjedFtTV6csC/yNTQ1GblMlwErGh+OVhkliB3CPVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709640896; c=relaxed/simple;
	bh=nB8UHD/mOQx9Sfo+EICVGTqA+L3BRilRmav32T6/HAk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VBitB6IqrwsD0aaeUOZ69opQZpssFYKNVj3Hz7hdZTZ+VvrJjFOK0g4bPOjYiDIn5LB4/2UiVXUPghA0rfVVYwGtO8Uclpim/CuzPxVBpWmO2BldA6tGWKF2zbC4ND2jSGtJm+PAG8k0Jp3ZNR3TeXdULjxEGaRi02hGkll6/Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TpvZk5W2Qz2BfKf;
	Tue,  5 Mar 2024 20:12:30 +0800 (CST)
Received: from canpemm500009.china.huawei.com (unknown [7.192.105.203])
	by mail.maildlp.com (Postfix) with ESMTPS id 1C9B61404F3;
	Tue,  5 Mar 2024 20:14:36 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 5 Mar 2024 20:14:30 +0800
From: Yicong Yang <yangyicong@huawei.com>
To: <will@kernel.org>, <sfr@canb.auug.org.au>, <linux-kernel@vger.kernel.org>,
	<linux-next@vger.kernel.org>
CC: <hejunhao3@huawei.com>, <yangyicong@hisilicon.com>
Subject: [PATCH -next] drivers/perf: hisi: Fix build warning of hisi-pcie-pmu.rst
Date: Tue, 5 Mar 2024 20:10:03 +0800
Message-ID: <20240305121003.4497-1-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500009.china.huawei.com (7.192.105.203)

From: Yicong Yang <yangyicong@hisilicon.com>

`make htmldocs SPHINXDIRS="admin-guide"` shows below warnings:
Documentation/admin-guide/perf/hisi-pcie-pmu.rst:48: ERROR: Unexpected indentation.
Documentation/admin-guide/perf/hisi-pcie-pmu.rst:49: WARNING: Block quote ends without a blank line; unexpected unindent.

Fix this.

Closes: https://lore.kernel.org/lkml/20231011172250.5a6498e5@canb.auug.org.au/
Fixes: 89a032923d4b ("docs: perf: Update usage for target filter of hisi-pcie-pmu")
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 Documentation/admin-guide/perf/hisi-pcie-pmu.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/admin-guide/perf/hisi-pcie-pmu.rst b/Documentation/admin-guide/perf/hisi-pcie-pmu.rst
index 678d3865560c..5541ff40e06a 100644
--- a/Documentation/admin-guide/perf/hisi-pcie-pmu.rst
+++ b/Documentation/admin-guide/perf/hisi-pcie-pmu.rst
@@ -44,6 +44,7 @@ The related events usually used to calculate the bandwidth, latency or others.
 They need to start and end counting at the same time, therefore related events
 are best used in the same event group to get the expected value. There are two
 ways to know if they are related events:
+
 a) By event name, such as the latency events "xxx_latency, xxx_cnt" or
    bandwidth events "xxx_flux, xxx_time".
 b) By event type, such as "event=0xXXXX, event=0x1XXXX".
-- 
2.24.0


