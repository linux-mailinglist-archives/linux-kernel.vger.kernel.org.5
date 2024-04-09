Return-Path: <linux-kernel+bounces-136889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD29889D96C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB6EB1C224C5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A1112D77D;
	Tue,  9 Apr 2024 12:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="HiYwBjzH"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A13312D74E;
	Tue,  9 Apr 2024 12:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712667100; cv=none; b=KVV8epURTaC3x1fQZVBrMVoJ096w6P61wBCSnGMVZJfLgoGj3MmFH3vSij7vZw8lUp+3R/b5TguLBhnErpJO4/TfUPItC+IPkyHRRSDeIuFvGgqWw+iPPEJ+isEdOZuC4KKo2wyNL8xbd+ozXFjaZWLf9rvKIrQHTIn2KA64rJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712667100; c=relaxed/simple;
	bh=DYX4vIIIOWQc+9yScerhkr5DQdAMibuqO+5fAhz/7SQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Jl7cXoHS7B0po99Xo2XBiZFUdGor6SmYHjjvFPpBH5HPEZGSFqul+mFwqlkCEgw8FUnvhFe6azG5NCyL0OM/RCtG594UsqPp65Iw3QM0cWcjD+pTNwrWW+V52YFihLHnOAVZCaIXpoRHJyHCroe5BUk83HGy0KJUZQZOoa4t9JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=HiYwBjzH; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=WZivz
	wtwPwc9kG+G0Vu61F+ka3jn+iKxoNnbOmG8MBQ=; b=HiYwBjzHMXzn90wwkRVrs
	I26kNBLc5BLIhBVnj+TflXJM3u/IJPjjE8n0b7DpAUoIK53jOrz8ak0z6TL6vCqI
	bGzeKgxk6zaROx2q+2kjlTV9Fwtoz2BDdHi18N3r+EjLldOsUJQNHOpM3f7vJpn+
	oDfb/4vrqiMCN9TpwbSlso=
Received: from localhost.localdomain (unknown [101.86.11.106])
	by gzga-smtp-mta-g2-5 (Coremail) with SMTP id _____wDXL2GEORVm3QVrAg--.35825S4;
	Tue, 09 Apr 2024 20:50:47 +0800 (CST)
From: Lizhe <sensor1010@163.com>
To: rafael@kernel.org,
	viresh.kumar@linaro.org,
	ilpo.jarvinen@linux.intel.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lizhe <sensor1010@163.com>
Subject: [PATCH] cpufreq: pcc-cpufreq: Remove redundant exit() functions
Date: Tue,  9 Apr 2024 05:50:03 -0700
Message-Id: <20240409125003.3444-1-sensor1010@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXL2GEORVm3QVrAg--.35825S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jw1xZF4rGr4ftry5Gr1xZrb_yoWDGrg_C3
	y3ur17GrWj9w1DtF17Gr48tryaya12qr1v9F10y39IkF17Ar9Yvr1kWr17WrW8Xw4rGF9r
	A3y0vF17uw4UAjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sREvtAtUUUUU==
X-CM-SenderInfo: 5vhq20jurqiii6rwjhhfrp/1tbiSAe7q2XAk0aYWgAAst

The return value of exit() is 0 and it performs no action.
This function can be omitted. Please refer to the end condition
check in the __cpufreq_offline() function.

Signed-off-by: Lizhe <sensor1010@163.com>
---
 drivers/cpufreq/pcc-cpufreq.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/cpufreq/pcc-cpufreq.c b/drivers/cpufreq/pcc-cpufreq.c
index 6f8b5ea7aeae..771efbf51a48 100644
--- a/drivers/cpufreq/pcc-cpufreq.c
+++ b/drivers/cpufreq/pcc-cpufreq.c
@@ -562,18 +562,12 @@ static int pcc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	return result;
 }
 
-static int pcc_cpufreq_cpu_exit(struct cpufreq_policy *policy)
-{
-	return 0;
-}
-
 static struct cpufreq_driver pcc_cpufreq_driver = {
 	.flags = CPUFREQ_CONST_LOOPS,
 	.get = pcc_get_freq,
 	.verify = pcc_cpufreq_verify,
 	.target = pcc_cpufreq_target,
 	.init = pcc_cpufreq_cpu_init,
-	.exit = pcc_cpufreq_cpu_exit,
 	.name = "pcc-cpufreq",
 };
 
-- 
2.25.1


