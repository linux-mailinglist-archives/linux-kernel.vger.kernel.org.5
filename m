Return-Path: <linux-kernel+bounces-129748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A07D6896F73
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53ED9289EF8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D18414882F;
	Wed,  3 Apr 2024 12:52:26 +0000 (UTC)
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852421487E2;
	Wed,  3 Apr 2024 12:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712148746; cv=none; b=BNVn0gf2GUNknez4y8t/5i5rgRSb6evMEulrAh49Yk2Q/6XfYr7fUv1Thn2JuAO8cByBG9Eluuwz63+a11wtvHoc2V1ZQcsKzlG5B7DXnIrETcOJxMmRkVUCSlJO2esYVgQmtzPAFtecIjzW8quoWcs8KO+TF6Zwm5L1JFnapOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712148746; c=relaxed/simple;
	bh=Re5TwhQ0QoFy44j2poIlImy55nEU9kHehFfmXVKdsDQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dzBNhthfzDPy9q/OQHVsGGKxh49AYhAYo73wnOfvjR3JFqIJKiVW1CoFuL0kx7uauIp8pVcvdCL9kb/PrIo0McNzAi9qEXUkZs8tNzzFNnXsYaYMa5kUoxcPZSNhzJd1cCSVOrfA6U3FWNwmwCptWhcufTHOcpdbq4XIEp1YP6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtpsz4t1712148701tsac26x
X-QQ-Originating-IP: Pt3Yzg7Fbd/Gq685Lb68nVVJ5dOnwjDPocHW6PLILm8=
Received: from localhost ( [112.0.147.175])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 03 Apr 2024 20:51:39 +0800 (CST)
X-QQ-SSF: 01400000000000704000000A0000000
X-QQ-FEAT: Xz3VOcA7Mr3qdnC/UgwbBFEKd4PF3FRiz2wwJAjHOmXtauSBj/BAFRR5iv1FC
	vbqv1f5u4tnBbrG136Dyf8/U5jg+rC/llOC07zNbsyMfxXY07N+9nty6ZLdkQixx9ZlQqsR
	AWONM/ELyb/LOfBuuBStJ/Nebx8w/6VobWY5krrR6xslz8gvqVAquEhzanFmdj6fXo2ul8l
	WzAldMgUY72gyEQBSBdaEbiu6/0Kyat4hVoVcn+zhaNoCmr9pOWT87sStFgwjbnQp0o9jbl
	IrL/+lzKAjduNhaU8WzasgQ+gs+gVVxAt4OtbceTOJDCLbBJe8KNx2g+UNYi3dh+NYPe67O
	mp8jSDvKhnw1uGVs8YeVbQNbcrcFLGVXyubNXumlfmP7xiuwqTqOEktb6UExky/pt90IeYB
	cg96CN/Wg3BOs3IDP4dbPpAinEn71ejy
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 4473137723865551747
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
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Dawei Li <dawei.li@shingroup.cn>
Subject: [PATCH v2 01/10] cpumask: add cpumask_any_and_but()
Date: Wed,  3 Apr 2024 20:51:00 +0800
Message-Id: <20240403125109.2054881-2-dawei.li@shingroup.cn>
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

From: Mark Rutland <mark.rutland@arm.com>

In some cases, it's useful to be able to select a random cpu from the
intersection of two masks, excluding a particular CPU.

For example, in some systems an uncore PMU is shared by a subset of
CPUs, and management of this PMU is assigned to some arbitrary CPU in
this set. Whenever the management CPU is hotplugged out, we wish to
migrate responsibility to another arbitrary CPU which is both in this
set and online.

Today we can use cpumask_any_and() to select an arbitrary CPU in the
intersection of two masks. We can also use cpumask_any_but() to select
any arbitrary cpu in a mask excluding, a particular CPU.

To do both, we either need to use a temporary cpumask, which is
wasteful, or use some lower-level cpumask helpers, which can be unclear.

This patch adds a new cpumask_any_and_but() to cater for these cases.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
---
 include/linux/cpumask.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 1c29947db848..121f3ac757ff 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -388,6 +388,29 @@ unsigned int cpumask_any_but(const struct cpumask *mask, unsigned int cpu)
 	return i;
 }
 
+/**
+ * cpumask_any_and_but - pick a "random" cpu from *mask1 & *mask2, but not this one.
+ * @mask1: the first input cpumask
+ * @mask2: the second input cpumask
+ * @cpu: the cpu to ignore
+ *
+ * Returns >= nr_cpu_ids if no cpus set.
+ */
+static inline
+unsigned int cpumask_any_and_but(const struct cpumask *mask1,
+				 const struct cpumask *mask2,
+				 unsigned int cpu)
+{
+	unsigned int i;
+
+	cpumask_check(cpu);
+	i = cpumask_first_and(mask1, mask2);
+	if (i != cpu)
+		return i;
+
+	return cpumask_next_and(cpu, mask1, mask2);
+}
+
 /**
  * cpumask_nth - get the Nth cpu in a cpumask
  * @srcp: the cpumask pointer
-- 
2.27.0


