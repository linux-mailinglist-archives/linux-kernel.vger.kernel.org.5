Return-Path: <linux-kernel+bounces-148002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F428A7C6D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42B0B281E6D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 06:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9ED65BA0;
	Wed, 17 Apr 2024 06:42:00 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7F9535D1
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 06:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713336119; cv=none; b=HvrYRMNqI3QUWA2k7nuVajQ6/fF/HP2CllZ6nlVO7bEyre6TOZ+lWDlq72ayJmz+w5eoaMb803rHprcTi6W3Lc3rI7pDvidSkKRjmo26y5ID+5AJ14gh44ukqWT4T2Qjg9fKN40Jxn0aAaye7FqeeLOpJ97ULyjKrHBbIqtcj3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713336119; c=relaxed/simple;
	bh=AEbk5aMxxRyZHx7qTokquYFHWN/IuT7YTIFTCO9lLnI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L1RSQRyIAyTtPQG1eEDRFOx+N6L8TWJFlBXfxMX3YqGG39qi47jNZwwYeNNSToVCQW2T0GQAkt1zFXKt/CQkfLMxk0WMMJ5C0V/czdyOBNn1nxZtO320aOWzQQaE2IHUmz1Cvxl0f0NeIiE5p7fbYY5msigd8IiX/vngUOKez80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4VKB8Y3nRQzNnhY;
	Wed, 17 Apr 2024 14:39:25 +0800 (CST)
Received: from kwepemi500024.china.huawei.com (unknown [7.221.188.100])
	by mail.maildlp.com (Postfix) with ESMTPS id 13606180080;
	Wed, 17 Apr 2024 14:41:49 +0800 (CST)
Received: from huawei.com (10.175.103.91) by kwepemi500024.china.huawei.com
 (7.221.188.100) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 17 Apr
 2024 14:41:46 +0800
From: Zeng Heng <zengheng4@huawei.com>
To: <xiexiuqi@huawei.com>, <catalin.marinas@arm.com>, <will@kernel.org>,
	<liuxin350@huawei.com>, <zuoze1@huawei.com>, <wangkefeng.wang@huawei.com>,
	<zhengzengkai@huawei.com>, <libaokun1@huawei.com>, <liushixin2@huawei.com>,
	<wangxiongfeng2@huawei.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<weiyongjun1@huawei.com>, <liwei391@huawei.com>
Subject: [PATCH OLK-6.6] arm64: enable CONFIG_ARM64_MPAM in openeuler_defconfig
Date: Wed, 17 Apr 2024 14:41:04 +0800
Message-ID: <20240417064104.2477916-1-zengheng4@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500024.china.huawei.com (7.221.188.100)

hulk inclusion
category: feature
bugzilla: https://gitee.com/openeuler/kernel/issues/I8T2RT

---------------------------

Support MPAM feature as default the arm64 configuration.

Signed-off-by: Zeng Heng <zengheng4@huawei.com>
---
 arch/arm64/configs/openeuler_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/configs/openeuler_defconfig b/arch/arm64/configs/openeuler_defconfig
index afd13d9e3840..68f06681704f 100644
--- a/arch/arm64/configs/openeuler_defconfig
+++ b/arch/arm64/configs/openeuler_defconfig
@@ -526,7 +526,7 @@ CONFIG_ARM64_PTR_AUTH_KERNEL=y
 # ARMv8.4 architectural features
 #
 CONFIG_ARM64_AMU_EXTN=y
-# CONFIG_ARM64_MPAM is not set
+CONFIG_ARM64_MPAM=y
 CONFIG_ARM64_TLB_RANGE=y
 # end of ARMv8.4 architectural features
 
-- 
2.25.1


