Return-Path: <linux-kernel+bounces-103236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2845387BCC1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 13:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7868282510
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 12:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD51E6FB9D;
	Thu, 14 Mar 2024 12:25:54 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA606F510;
	Thu, 14 Mar 2024 12:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710419154; cv=none; b=iKOZrjC+3cOUNwJYnRi8IslAN0N3FpGaT1TZjzJfuJXaii3tpmfSUSgdWyUoPTl4ITTwaB4f2q3s2qxvHnZ9aK5RkaARpB/lYZKV/VOi2qStjnsdakwHw0zloya46lGmfRCbLAFzQRyTPQgf9L9lLb0oxwkr2lmL8hkZD7FJIC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710419154; c=relaxed/simple;
	bh=fxZUGgLaU7P7RYrilXMEGXSSwgi7cOfgV6jYVHaGkcY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=F+OfH2tdQcwul0/MxG0ouK4M7eO7ToICJHUZnkzTI2AAGtI40gUd4RJETh71ubOYUeFs0ZczCl6/lms0P7cqgSv6mJeKjL/M/QkTAZrtPMSj2GLG5wVns6OUxf1k29BvJgRyPjGsJUb/7JoARg9u/YIML1hC3gBB9eQ4TKlq4v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 7e8f2b001938452e850a9d2808b40d69-20240314
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:6ba4b253-d3b8-460b-803a-eba3d428fb02,IP:15,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-5
X-CID-INFO: VERSION:1.1.37,REQID:6ba4b253-d3b8-460b-803a-eba3d428fb02,IP:15,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-5
X-CID-META: VersionHash:6f543d0,CLOUDID:294ce5ff-c16b-4159-a099-3b9d0558e447,B
	ulkID:240314202541CBD1AVR6,BulkQuantity:0,Recheck:0,SF:66|38|24|17|19|44|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC
	:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: 7e8f2b001938452e850a9d2808b40d69-20240314
X-User: liucong2@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw
	(envelope-from <liucong2@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1185604398; Thu, 14 Mar 2024 20:25:37 +0800
From: Cong Liu <liucong2@kylinos.cn>
To: Andrew Morton <akpm@linux-foundation.org>,
	Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc: Cong Liu <liucong2@kylinos.cn>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH] tools/Makefile: Remove cgroup target
Date: Thu, 14 Mar 2024 20:25:32 +0800
Message-Id: <20240314122533.419754-1-liucong2@kylinos.cn>
X-Mailer: git-send-email 2.34.1
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

Fixes: 60433a9d038d ("samples: introduce new samples subdir for cgroup")
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


