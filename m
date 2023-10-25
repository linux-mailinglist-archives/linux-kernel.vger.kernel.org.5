Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD807D66E1
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 11:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234282AbjJYJdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 05:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232808AbjJYJdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 05:33:43 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6CAADC;
        Wed, 25 Oct 2023 02:33:41 -0700 (PDT)
Received: from kwepemi500024.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SFkBl3Wd5zpWT2;
        Wed, 25 Oct 2023 17:28:47 +0800 (CST)
Received: from huawei.com (10.175.103.91) by kwepemi500024.china.huawei.com
 (7.221.188.100) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 25 Oct
 2023 17:33:38 +0800
From:   Zeng Heng <zengheng4@huawei.com>
To:     <broonie@kernel.org>, <joey.gouly@arm.com>, <will@kernel.org>,
        <amit.kachhap@arm.com>, <rafael@kernel.org>,
        <catalin.marinas@arm.com>, <james.morse@arm.com>,
        <mark.rutland@arm.com>, <maz@kernel.org>,
        <viresh.kumar@linaro.org>, <sumitg@nvidia.com>,
        <yang@os.amperecomputing.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <wangxiongfeng2@huawei.com>, <xiexiuqi@huawei.com>
Subject: [PATCH 1/3] arm64: cpufeature: Export cpu_has_amu_feat()
Date:   Wed, 25 Oct 2023 17:38:45 +0800
Message-ID: <20231025093847.3740104-2-zengheng4@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231025093847.3740104-1-zengheng4@huawei.com>
References: <20231025093847.3740104-1-zengheng4@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500024.china.huawei.com (7.221.188.100)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export the cpu_has_amu_feat() function for using by cppc_cpufreq.c to check
if the processor implements ARM's Activity Monitor Unit (AMU).

Signed-off-by: Zeng Heng <zengheng4@huawei.com>
---
 arch/arm64/kernel/cpufeature.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 444a73c2e638..47195e66a820 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1935,6 +1935,7 @@ bool cpu_has_amu_feat(int cpu)
 {
 	return cpumask_test_cpu(cpu, &amu_cpus);
 }
+EXPORT_SYMBOL(cpu_has_amu_feat);
 
 int get_cpu_with_amu_feat(void)
 {
-- 
2.25.1

