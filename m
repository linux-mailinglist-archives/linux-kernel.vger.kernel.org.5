Return-Path: <linux-kernel+bounces-12499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D4C81F5C2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 08:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74C791C21D15
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 07:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2599F5393;
	Thu, 28 Dec 2023 07:57:22 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [203.110.167.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F8C63B1
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 07:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1703750229-1eb14e0c7d074c0001-xx1T2L
Received: from ZXSHMBX1.zhaoxin.com (ZXSHMBX1.zhaoxin.com [10.28.252.163]) by mx2.zhaoxin.com with ESMTP id blxFhhqhkdOaVL6N (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Thu, 28 Dec 2023 15:57:09 +0800 (CST)
X-Barracuda-Envelope-From: TonyWWang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHMBX1.zhaoxin.com
 (10.28.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 28 Dec
 2023 15:57:09 +0800
Received: from tony.zhaoxin.com (10.32.65.162) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 28 Dec
 2023 15:57:06 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
From: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.29.252.163
To: <rafael@kernel.org>, <lenb@kernel.org>, <robert.moore@intel.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<acpica-devel@lists.linux.dev>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	<hpa@zytor.com>, <mcgrof@kernel.org>, <peterz@infradead.org>,
	<j.granados@samsung.com>, <TonyWWang-oc@zhaoxin.com>,
	<ricardo.neri-calderon@linux.intel.com>, <viresh.kumar@linaro.org>,
	<linux-pm@vger.kernel.org>
CC: <CobeChen@zhaoxin.com>, <TimGuo@zhaoxin.com>, <LeoLiu-oc@zhaoxin.com>,
	<LindaChai@zhaoxin.com>
Subject: [PATCH 0/3] Add Zhaoxin preferred core support in acpi-cpufreq
Date: Thu, 28 Dec 2023 15:57:02 +0800
X-ASG-Orig-Subj: [PATCH 0/3] Add Zhaoxin preferred core support in acpi-cpufreq
Message-ID: <20231228075705.26652-1-TonyWWang-oc@zhaoxin.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Barracuda-Connect: ZXSHMBX1.zhaoxin.com[10.28.252.163]
X-Barracuda-Start-Time: 1703750229
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 1474
X-Barracuda-BRTS-Status: 0
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.118665
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------

For Zhaoxin CPUs, the cores' highest frequencies may be different, which
means that cores may run at different max frequencies,

According to ACPI-spec6 chapter 8.4.7, the per-core highest frequency
value can be obtained via cppc.

The core with the higher frequency have better performance, which can be
called as preferred core. And better performance can be achieved by
making the scheduler to run tasks on these preferred cores.

The cpufreq driver can use the highest frequency value as the prioriy of
core to make the scheduler try to get better performace.

More specifically:
Add cppc_get_highest_perf function in CPPC driver.
Export two funcions which will be used in acpi-cpufreq drvier.
In the acpi-cpufreq driver use cppc_get_highest_perf() to get highest
frequency value of each core, use sched_set_itmt_core_prio() to set
highest frequency value as core priority, and use sched_set_itmt_support()
provided by ITMT to tell the scheduler to favor on the preferred cores.

Tony W Wang-oc (3):
  ACPI: CPPC: Add get the highest perf register value support
  x86/sched/itmt: Export two API symbols
  ACPI: cpufreq: Add ITMT support when CPPC enabled for Zhaoxin CPUs

 arch/x86/kernel/itmt.c         |  2 ++
 drivers/acpi/cppc_acpi.c       | 13 ++++++++
 drivers/cpufreq/acpi-cpufreq.c | 56 +++++++++++++++++++++++++++++++++-
 include/acpi/cppc_acpi.h       |  5 +++
 4 files changed, 75 insertions(+), 1 deletion(-)

-- 
2.25.1


