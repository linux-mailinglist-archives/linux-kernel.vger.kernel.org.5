Return-Path: <linux-kernel+bounces-129753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D904896F85
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EAC01C2653E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CC61474D2;
	Wed,  3 Apr 2024 12:53:47 +0000 (UTC)
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1914146D41;
	Wed,  3 Apr 2024 12:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712148826; cv=none; b=ueKCy4iJPGJ7uJnL4jRcUMAlJIQwti4Fr1U704plMs27Ud8kvDdoI/+hKkF6yXTlAiJbvvKtZTRcSCK5n9mPVg8abNiAuPbLarAGTVmNoxSNSxeJkNvHckfxP52KgnRpua5hqUgcKq5IqzD3IuGdSLXGrzTZ0WkvKNRcpYqpTi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712148826; c=relaxed/simple;
	bh=N3+jmIFBH0AMFXfes14ZXbK3viT/FuJyr71Pf7bRYZ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NzbgNJWejMgm4lOc+PHgtOr9JHkxNFK1jqfH7/5fw1KaKy7l1DjCAKcu8v/MdZUFrMXxQZVrKiMsb80u/4Ym9PHPwnTnlIViUgokfpYF4EHYgU9KZFDDcTEOPhu+7n8V4x0L4W7BsS35QG7WMX4hEFkXTjDhQPFYwCHapyq1T50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtpsz15t1712148732tmp3f7
X-QQ-Originating-IP: hp+qVMYBYDmNau3Xt2Ytvj+o84IW5qbOYg/vMTzRtwI=
Received: from localhost ( [112.0.147.175])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 03 Apr 2024 20:52:10 +0800 (CST)
X-QQ-SSF: 01400000000000704000000A0000000
X-QQ-FEAT: RrZlkntZBfm1BsuX7v8GUrYbIkXGb4KuNkFygyd4NSEyO16QA+4WGckn64RjL
	GQFe6dzbLRg7F9sTRNLUVBLFrP0rvndGl/KOt+YRefEqq0HIn54Nplviah+iU0q6GSWbAiD
	pqeN4oYni807Hlr+46rlinuWIzRgTDL7fVUzFfxltUv7p2S8/oFTKU3Ffrg4sqJ6WWEcO8k
	r+R/hy/qxUpId1vFasEipX+0GrflA4/30UbqmZlOmg1fNjf9v8bqI4/Xq8KjOTPQqVuefPj
	dVAn1+gr/nNR/cMYm4sQimsog4nuA2iK19IglEXwpv/IndcFXiqcTKxYvEO0SZ5eQDycOyD
	w8qI54wY5oChA3Cjnv/PrqAW4VXkXOpRHF62e7My9Zjh0Ezr4EeYac5ZhxuzRyEh8pOP5Ja
	uEYnDh0vp5Ribc1zi9ZB1bNKIdKO4Y2B
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 4140137453108644267
From: Dawei Li <dawei.li@shingroup.cn>
To: will@kernel.org,
	mark.rutland@arm.com,
	yury.norov@gmail.com,
	linux@rasmusvillemoes.dk
Cc: xueshuai@linux.alibaba.com,
	renyu.zj@linux.alibaba.com,
	yangyicong@hisilicon.com,
	jonathan.cameron@huawei.com,
	andersson@kernel.org,
	konrad.dybcio@linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Dawei Li <dawei.li@shingroup.cn>
Subject: [PATCH v2 03/10] perf/arm-cmn: Avoid placing cpumask var on stack
Date: Wed,  3 Apr 2024 20:51:02 +0800
Message-Id: <20240403125109.2054881-4-dawei.li@shingroup.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240403125109.2054881-1-dawei.li@shingroup.cn>
References: <20240403125109.2054881-1-dawei.li@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1

For CONFIG_CPUMASK_OFFSTACK=y kernel, explicit allocation of cpumask
variable on stack is not recommended since it can cause potential stack
overflow.

Instead, kernel code should always use *cpumask_var API(s) to allocate
cpumask var in config-neutral way, leaving allocation strategy to
CONFIG_CPUMASK_OFFSTACK.

But dynamic allocation in cpuhp's teardown callback is somewhat problematic
for if allocation fails(which is unlikely but still possible):
- If -ENOMEM is returned to caller, kernel crashes for non-bringup
  teardown;
- If callback pretends nothing happened and returns 0 to caller, it may
  trap system into an in-consisitent/compromised state;

Use newly-introduced cpumask_any_and_but() to address all issues above.
It eliminates usage of temporary cpumask var in generic way, no matter how
the cpumask var is allocated.

Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
---
 drivers/perf/arm-cmn.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index 7ef9c7e4836b..6bfb0c4a1287 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -1950,20 +1950,20 @@ static int arm_cmn_pmu_offline_cpu(unsigned int cpu, struct hlist_node *cpuhp_no
 	struct arm_cmn *cmn;
 	unsigned int target;
 	int node;
-	cpumask_t mask;
 
 	cmn = hlist_entry_safe(cpuhp_node, struct arm_cmn, cpuhp_node);
 	if (cpu != cmn->cpu)
 		return 0;
 
 	node = dev_to_node(cmn->dev);
-	if (cpumask_and(&mask, cpumask_of_node(node), cpu_online_mask) &&
-	    cpumask_andnot(&mask, &mask, cpumask_of(cpu)))
-		target = cpumask_any(&mask);
-	else
+
+	target = cpumask_any_and_but(cpumask_of_node(node), cpu_online_mask, cpu);
+	if (target >= nr_cpu_ids)
 		target = cpumask_any_but(cpu_online_mask, cpu);
+
 	if (target < nr_cpu_ids)
 		arm_cmn_migrate(cmn, target);
+
 	return 0;
 }
 
-- 
2.27.0


