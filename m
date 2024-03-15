Return-Path: <linux-kernel+bounces-103970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 448D887C747
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 02:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8F95B21901
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 01:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367E6612E;
	Fri, 15 Mar 2024 01:39:09 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C251833EE;
	Fri, 15 Mar 2024 01:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710466748; cv=none; b=KsQjpXzpqd740979OIfps2R9B11LS+lLVkeYWV12XxeNeD12sYXkkbM4ltlLAT/Krnea4zRs8vs9e2rCdbkzO9CSnQ+bLS5z3DvC+tgvBznawDJ3zA4C/5OMAmjU69hNmpMTRbIE7mzLFn8lpLgVQuCp+qNXEgztZejK9RqLMR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710466748; c=relaxed/simple;
	bh=2FGk0t2RqTNhelqRWQnnqW/C9tNCEf9IVYVudyb8/CI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OkdN2bolR/I87LEpPb0fl3OscGFR+ChcJm11SomDn4jzUjmipvn7n26D45NrFNCzIwVPAKkE+YmLZusTQXtDulofV7w0QZmXH2/YeKhnyvzIH8FQNQ3UvLc2effyE2PLouEYY343dszvHhFti8c9xb/9+Y8lLnAQNw33T7qTbAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 4329fb1049694ccd91161f4937037524-20240315
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:ca6aa687-1027-4107-b6fa-210f960fed13,IP:15,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-5
X-CID-INFO: VERSION:1.1.37,REQID:ca6aa687-1027-4107-b6fa-210f960fed13,IP:15,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-5
X-CID-META: VersionHash:6f543d0,CLOUDID:4c340585-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:240315092258KCW3XJI0,BulkQuantity:0,Recheck:0,SF:66|24|17|19|44|102,
	TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:ni
	l,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR
X-UUID: 4329fb1049694ccd91161f4937037524-20240315
X-User: liucong2@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw
	(envelope-from <liucong2@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1884722954; Fri, 15 Mar 2024 09:22:54 +0800
From: Cong Liu <liucong2@kylinos.cn>
To: sdf@google.com
Cc: akpm@linux-foundation.org,
	bpf@vger.kernel.org,
	ddrokosov@salutedevices.com,
	linux-kernel@vger.kernel.org,
	liucong2@kylinos.cn
Subject: [PATCH v2] tools/Makefile: Remove cgroup target
Date: Fri, 15 Mar 2024 09:22:48 +0800
Message-Id: <20240315012249.439639-1-liucong2@kylinos.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZfNXjd1ML2WJwOKX@google.com>
References: <ZfNXjd1ML2WJwOKX@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The tools/cgroup directory no longer contains a Makefile.  This patch
updates the top-level tools/Makefile to remove references to building
and installing cgroup components. This change reflects the current
structure of the tools directory and fixes the build failure when
building tools in the top-level directory.

linux/tools$ make cgroup
  DESCEND cgroup
make[1]: *** No targets specified and no makefile found.  Stop.
make: *** [Makefile:73: cgroup] Error 2

Signed-off-by: Cong Liu <liucong2@kylinos.cn>
---
 tools/Makefile | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/tools/Makefile b/tools/Makefile
index 37e9f6804832..276f5d0d53a4 100644
--- a/tools/Makefile
+++ b/tools/Makefile
@@ -11,7 +11,6 @@ help:
 	@echo ''
 	@echo '  acpi                   - ACPI tools'
 	@echo '  bpf                    - misc BPF tools'
-	@echo '  cgroup                 - cgroup tools'
 	@echo '  counter                - counter tools'
 	@echo '  cpupower               - a tool for all things x86 CPU power'
 	@echo '  debugging              - tools for debugging'
@@ -69,7 +68,7 @@ acpi: FORCE
 cpupower: FORCE
 	$(call descend,power/$@)
 
-cgroup counter firewire hv guest bootconfig spi usb virtio mm bpf iio gpio objtool leds wmi pci firmware debugging tracing: FORCE
+counter firewire hv guest bootconfig spi usb virtio mm bpf iio gpio objtool leds wmi pci firmware debugging tracing: FORCE
 	$(call descend,$@)
 
 bpf/%: FORCE
@@ -116,7 +115,7 @@ freefall: FORCE
 kvm_stat: FORCE
 	$(call descend,kvm/$@)
 
-all: acpi cgroup counter cpupower gpio hv firewire \
+all: acpi counter cpupower gpio hv firewire \
 		perf selftests bootconfig spi turbostat usb \
 		virtio mm bpf x86_energy_perf_policy \
 		tmon freefall iio objtool kvm_stat wmi \
@@ -128,7 +127,7 @@ acpi_install:
 cpupower_install:
 	$(call descend,power/$(@:_install=),install)
 
-cgroup_install counter_install firewire_install gpio_install hv_install iio_install perf_install bootconfig_install spi_install usb_install virtio_install mm_install bpf_install objtool_install wmi_install pci_install debugging_install tracing_install:
+counter_install firewire_install gpio_install hv_install iio_install perf_install bootconfig_install spi_install usb_install virtio_install mm_install bpf_install objtool_install wmi_install pci_install debugging_install tracing_install:
 	$(call descend,$(@:_install=),install)
 
 selftests_install:
@@ -155,7 +154,7 @@ freefall_install:
 kvm_stat_install:
 	$(call descend,kvm/$(@:_install=),install)
 
-install: acpi_install cgroup_install counter_install cpupower_install gpio_install \
+install: acpi_install counter_install cpupower_install gpio_install \
 		hv_install firewire_install iio_install \
 		perf_install selftests_install turbostat_install usb_install \
 		virtio_install mm_install bpf_install x86_energy_perf_policy_install \
@@ -169,7 +168,7 @@ acpi_clean:
 cpupower_clean:
 	$(call descend,power/cpupower,clean)
 
-cgroup_clean counter_clean hv_clean firewire_clean bootconfig_clean spi_clean usb_clean virtio_clean mm_clean wmi_clean bpf_clean iio_clean gpio_clean objtool_clean leds_clean pci_clean firmware_clean debugging_clean tracing_clean:
+counter_clean hv_clean firewire_clean bootconfig_clean spi_clean usb_clean virtio_clean mm_clean wmi_clean bpf_clean iio_clean gpio_clean objtool_clean leds_clean pci_clean firmware_clean debugging_clean tracing_clean:
 	$(call descend,$(@:_clean=),clean)
 
 libapi_clean:
@@ -209,7 +208,7 @@ freefall_clean:
 build_clean:
 	$(call descend,build,clean)
 
-clean: acpi_clean cgroup_clean counter_clean cpupower_clean hv_clean firewire_clean \
+clean: acpi_clean counter_clean cpupower_clean hv_clean firewire_clean \
 		perf_clean selftests_clean turbostat_clean bootconfig_clean spi_clean usb_clean virtio_clean \
 		mm_clean bpf_clean iio_clean x86_energy_perf_policy_clean tmon_clean \
 		freefall_clean build_clean libbpf_clean libsubcmd_clean \
-- 
2.34.1


