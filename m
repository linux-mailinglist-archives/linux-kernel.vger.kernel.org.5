Return-Path: <linux-kernel+bounces-39648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0747183D44B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 07:34:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2EF61F23C81
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 06:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F2711731;
	Fri, 26 Jan 2024 06:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="A+23pySW"
Received: from esa3.hc1455-7.c3s2.iphmx.com (esa3.hc1455-7.c3s2.iphmx.com [207.54.90.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C460BC8CE;
	Fri, 26 Jan 2024 06:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706249628; cv=none; b=lIeZ+FJ2dCIAylFyNHKiSLCfH2AdvjztsuN0VCzJYwSWJiFQ6TbW0rdVEl3g/eo36Z83A+fE7hdmAlvZHFrwTpjJ4ra1NtjzoAvjoa9XxbcYqr6eaquy3pGZX3SAJcvtaYS5IsigKXB5qy9LekfO2DGoXXVbZC/PbQejIZp0B54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706249628; c=relaxed/simple;
	bh=l6yTGzECnxbB8OZB0NJoYVxxgTP+SkP164E/mu28NUY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mn6xyIAF3HygIXe9JrfeE7BfyzD53noy/x5WAsSXpxt+uk+wBua3mkGqaVNoJBrsBzePafWVc5y9x3lbrkEB9pTIJ1HZrbjo1BiLYuMJwre6oFi+yT/cQX/uq6/IH7C8kKnimeQn4qh/SHcP8DBybTdlHUfIdm8zj3Evjb4tbow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=A+23pySW; arc=none smtp.client-ip=207.54.90.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1706249625; x=1737785625;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l6yTGzECnxbB8OZB0NJoYVxxgTP+SkP164E/mu28NUY=;
  b=A+23pySWMiQxkiv7XBfBU663Wi7UjNqKCWOJqC5EUz31f4/b38zYrMWA
   /0ltrtLRoDKBE3dO0dFx/sQvlb/sRSJrEdhzyxs+OowQVxyA4C67rx2rx
   DXT511R/jdl4D5JM05Z3WJU7CVveTh2zIoAEBEaP9bcVbQixbOTu3E5Ct
   uOiIs8XNtqFgtf4lH+oYvm00NCFe1+lhMECl6GB+0h59GU9V8pKIA9x87
   NUC9VXeWJOHp/UJZoHceu5MBIGXazGkZyR7WRc/PonZJsn1KCblaNy2RJ
   FHqPye15dx0pDzJMsBeR9q4JTiEqq6Z0fF8OSe+yFdxXIxVP7OeH7sxEK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="147342519"
X-IronPort-AV: E=Sophos;i="6.05,216,1701097200"; 
   d="scan'208";a="147342519"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa3.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 15:13:36 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
	by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 4BBB2E05A3;
	Fri, 26 Jan 2024 15:13:33 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 7EEBED2945;
	Fri, 26 Jan 2024 15:13:32 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id E7DF5200A7EC5;
	Fri, 26 Jan 2024 15:13:31 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 2C4411A006C;
	Fri, 26 Jan 2024 14:13:31 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v2 2/4] arch/x86/events/core: Convert sprintf/snprintf to sysfs_emit
Date: Fri, 26 Jan 2024 14:13:17 +0800
Message-Id: <20240126061319.245901-2-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240126061319.245901-1-lizhijian@fujitsu.com>
References: <20240126061319.245901-1-lizhijian@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28142.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28142.005
X-TMASE-Result: 10--14.067700-10.000000
X-TMASE-MatchedRID: APZBv0eB5fI4ibokZ3+Q0CoiRKlBVkYIBXngI6jFvpfvd49YGReckE1N
	J2MN+nPkgxCMf8A0YpTFw+98ljZmfsCiHTNtFGyJzYK5U+QI3O5MVCcj56k8hs+FXdgLGTDcTR/
	R9+KYBGh755lTx6LDRoNGRAnK6GInCcAKiiVrTVKdVNZaI2n6/8E5XPQnBzGXq8KsbROd9VSArq
	oIZrVn15fzUkBpc072p43H9nP9RJduk59MVAVjnWLvWLmiffgqWQ3R4k5PTnC3L2aPW6sT0v2Sw
	ev/tyUib7vhAFDgsdOEor9sr5DKkJH0YXYnbGozFEUknJ/kEl7dB/CxWTRRu25FeHtsUoHuRBO+
	kqv47y8sCB9viE8u5u1NAh58qD9DpMnHtLJr2mUfwV6sBPR0lg==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Per filesystems/sysfs.rst, show() should only use sysfs_emit()
or sysfs_emit_at() when formatting the value to be returned to user space.

coccinelle complains that there are still a couple of functions that use
snprintf(). Convert them to sysfs_emit().

> ./arch/x86/events/core.c:1895:11-19: WARNING: please use sysfs_emit
                           ^^^^^ this one cannot convert to sysfs_emit
                                 where it intends to print a sub-string.

> ./arch/x86/events/core.c:2542:8-16: WARNING: please use sysfs_emit
> ./arch/x86/events/core.c:2600:8-16: WARNING: please use sysfs_emit

Most of this patch is generated by:
$ make coccicheck MODE=patch COCCI=scripts/coccinelle/api/device_attr_show.cocci M=arch/x86/events/core.c | sed -n '6,$p' | patch -p1

No functional change intended

CC: Peter Zijlstra <peterz@infradead.org>
CC: Ingo Molnar <mingo@redhat.com>
CC: Arnaldo Carvalho de Melo <acme@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>
CC: Alexander Shishkin <alexander.shishkin@linux.intel.com>
CC: Jiri Olsa <jolsa@kernel.org>
CC: Namhyung Kim <namhyung@kernel.org>
CC: Ian Rogers <irogers@google.com>
CC: Adrian Hunter <adrian.hunter@intel.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Borislav Petkov <bp@alien8.de>
CC: Dave Hansen <dave.hansen@linux.intel.com>
CC: x86@kernel.org
CC: "H. Peter Anvin" <hpa@zytor.com>
CC: linux-perf-users@vger.kernel.org
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
V2:
- Address Adrian's comment:
  leave "snprintf(page, next_str - str + 1, "%s", str)" alone, it
  intends to print a sub-string, that cannot covert to sysfs_emit simply.
-
V2: extract patch from the patch set[1] so that maintainer accept it separately.
[1] https://lore.kernel.org/lkml/20240116041129.3937800-1-lizhijian@fujitsu.com/
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 arch/x86/events/core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 09050641ce5d..20d963196e4c 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1832,7 +1832,7 @@ ssize_t events_sysfs_show(struct device *dev, struct device_attribute *attr, cha
 
 	/* string trumps id */
 	if (pmu_attr->event_str)
-		return sprintf(page, "%s\n", pmu_attr->event_str);
+		return sysfs_emit(page, "%s\n", pmu_attr->event_str);
 
 	return x86_pmu.events_sysfs_show(page, config);
 }
@@ -1855,7 +1855,7 @@ ssize_t events_ht_sysfs_show(struct device *dev, struct device_attribute *attr,
 	 * if they are owned by some other guest.  The user tool
 	 * has to re-read when a thread sibling gets onlined later.
 	 */
-	return sprintf(page, "%s",
+	return sysfs_emit(page, "%s",
 			topology_max_smt_threads() > 1 ?
 			pmu_attr->event_str_ht :
 			pmu_attr->event_str_noht);
@@ -1872,7 +1872,7 @@ ssize_t events_hybrid_sysfs_show(struct device *dev,
 	int i;
 
 	if (hweight64(pmu_attr->pmu_type) == 1)
-		return sprintf(page, "%s", pmu_attr->event_str);
+		return sysfs_emit(page, "%s", pmu_attr->event_str);
 
 	/*
 	 * Hybrid PMUs may support the same event name, but with different
@@ -1894,7 +1894,7 @@ ssize_t events_hybrid_sysfs_show(struct device *dev,
 			if (next_str)
 				return snprintf(page, next_str - str + 1, "%s", str);
 			else
-				return sprintf(page, "%s", str);
+				return sysfs_emit(page, "%s", str);
 		}
 		str = strchr(str, ';');
 		str++;
@@ -2539,7 +2539,7 @@ static ssize_t get_attr_rdpmc(struct device *cdev,
 			      struct device_attribute *attr,
 			      char *buf)
 {
-	return snprintf(buf, 40, "%d\n", x86_pmu.attr_rdpmc);
+	return sysfs_emit(buf, "%d\n", x86_pmu.attr_rdpmc);
 }
 
 static ssize_t set_attr_rdpmc(struct device *cdev,
@@ -2597,7 +2597,7 @@ static ssize_t max_precise_show(struct device *cdev,
 				  struct device_attribute *attr,
 				  char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%d\n", x86_pmu_max_precise());
+	return sysfs_emit(buf, "%d\n", x86_pmu_max_precise());
 }
 
 static DEVICE_ATTR_RO(max_precise);
-- 
2.29.2


