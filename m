Return-Path: <linux-kernel+bounces-93765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE686873441
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE5101C2122F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9C2605B0;
	Wed,  6 Mar 2024 10:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="X++/zVCQ"
Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com [139.138.37.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BE06089F;
	Wed,  6 Mar 2024 10:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.37.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709721030; cv=none; b=AY5Pzk5Vc9Yg1Qk7kGLt7h/Ii5A9ub9+XAy4K3ESNXqS/Y/bSIzQTi7Li+W7Aayj8EI2n30wWF8dsjieklQ1/eW9Zo8egbmU51GPlpHt7C7v4aLQBlAo1mjyUFR3Pp+dDhio6Dg8wJAGfGOgmmvFUXnFcx2lq/G/327YGTmuTEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709721030; c=relaxed/simple;
	bh=Nq7SMqNBqa42A9Gw9it0V4iEBEk255GCXGK0EU8r0Nc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l1vVJHVNM5LNn/5XND9Y0gZbLMBdbifNrsN7ivC8YFxgR8sljqpeZtIsluCNROY6kR2rreXpwdr4O7wFiiQZmRpdIzcaviDQVvBTx3DCIafpyjVLXNWHFwFw4/MNRyJYlFmbAUSKNJRwylUAJzxe0ydnZ+B7igXzjKeOH0F5yEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=X++/zVCQ; arc=none smtp.client-ip=139.138.37.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1709721029; x=1741257029;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Nq7SMqNBqa42A9Gw9it0V4iEBEk255GCXGK0EU8r0Nc=;
  b=X++/zVCQWbD3RwO4sV0R5jBoWm59aunLFlpz3wvSj7tUIUr1+QIcfxcw
   rUs51YTB9zQ4GsEFyK7E9vjQzv0Au7y/DHG9M/IIFiCx7tL2jEhH7HUXZ
   chdvdHYTFqV6pzIBWj11H5sAtkQ/5VztBHXXiORyfbehxUOTV2ZPhDbbo
   0/vGrLBods4ZHkPHoHSMHz4JikXFb9z6EalEfAX2XZhSG7SsF8+yNrddq
   j3yL4Pimm6h3PUI9+zXPNs6wxWMi1QvXj5go7YYDTGpjexIN++Vqqfss8
   zIrxwjNOuKfwNc4iyucLrPUjbkzprpGv7peddPfybMqsSH0zoBMZYiYI5
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="130699036"
X-IronPort-AV: E=Sophos;i="6.06,208,1705330800"; 
   d="scan'208";a="130699036"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 19:29:16 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
	by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id C7383E5EA4;
	Wed,  6 Mar 2024 19:29:12 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 06543D21CB;
	Wed,  6 Mar 2024 19:29:12 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 3D7B22030C7E0;
	Wed,  6 Mar 2024 19:29:11 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 4A1AE1A006A;
	Wed,  6 Mar 2024 18:29:10 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: y-goto@fujitsu.com,
	Alison Schofield <alison.schofield@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	hpa@zytor.com,
	Ingo Molnar <mingo@redhat.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vishal Verma <vishal.l.verma@intel.com>,
	linux-cxl@vger.kernel.org,
	linux-mm@kvack.org,
	nvdimm@lists.linux.dev,
	x86@kernel.org,
	kexec@lists.infradead.org,
	Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH v3 6/7] x86/crash: make device backed vmemmap dumpable for kexec_file_load
Date: Wed,  6 Mar 2024 18:28:45 +0800
Message-Id: <20240306102846.1020868-7-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240306102846.1020868-1-lizhijian@fujitsu.com>
References: <20240306102846.1020868-1-lizhijian@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28234.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28234.006
X-TMASE-Result: 10--8.255800-10.000000
X-TMASE-MatchedRID: Eprm7pA/VZ5ZxhI5bGrNsjiEPRj9j9rvSdIdCi8Ba4AiqRodPpseIRwE
	EIVsM/kp/lneBjailE5V00+whwxVQy/7QU2czuUNA9lly13c/gH4uJ1REX4MHbs3Yh2IOCYzJti
	zbkLGoS92PULLZTziuytFAV6Sdl32oFf+7ciBzQpYKMMlFh4BncnlJe2gk8vIMzT8XBPSpdajxY
	yRBa/qJXcsDK2xBHh7jaPj0W1qn0Q7AFczfjr/7LEnb/1qBW++QLtrZDNFv46p+VAyfOE7vP5i9
	RGEpFvIT2g+olvABKw=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Add resources with specific flags to PT_LOADs of the elfcorehdr so that
these resources can be dumpable. This change is for kexec_file_load(2)
while kexec_load(2) setups the PT_LOADs according to its parameters
by the callers which usually rely on resources' name from /proc/iomem

CC: Thomas Gleixner <tglx@linutronix.de>
CC: Ingo Molnar <mingo@redhat.com>
CC: Borislav Petkov <bp@alien8.de>
CC: Dave Hansen <dave.hansen@linux.intel.com>
CC: Baoquan He <bhe@redhat.com>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: "H. Peter Anvin" <hpa@zytor.com>
CC: x86@kernel.org
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 arch/x86/kernel/crash.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index b6b044356f1b..b8426fedd2cd 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -146,6 +146,8 @@ static struct crash_mem *fill_up_crash_elf_data(void)
 	if (!nr_ranges)
 		return NULL;
 
+	walk_device_backed_vmemmap_res(0, -1, &nr_ranges,
+				       get_nr_ram_ranges_callback);
 	/*
 	 * Exclusion of crash region and/or crashk_low_res may cause
 	 * another range split. So add extra two slots here.
@@ -212,6 +214,9 @@ static int prepare_elf_headers(void **addr, unsigned long *sz,
 	if (ret)
 		goto out;
 
+	walk_device_backed_vmemmap_res(0, -1, cmem,
+				       prepare_elf64_ram_headers_callback);
+
 	/* Exclude unwanted mem ranges */
 	ret = elf_header_exclude_ranges(cmem);
 	if (ret)
-- 
2.29.2


