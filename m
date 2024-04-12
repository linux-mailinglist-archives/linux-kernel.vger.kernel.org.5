Return-Path: <linux-kernel+bounces-143079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A9E8A33D2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A221AB25BD4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6808714900B;
	Fri, 12 Apr 2024 16:25:51 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4227E148311;
	Fri, 12 Apr 2024 16:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712939150; cv=none; b=CaOJe4EsIjzZfTEDgK/2cjHo7TsJ67Cvp9LSPhVMtBZf0qC+JVfoH0w78S1XKcr/l62zKlIx1Gw9kYbn1FWZTZnLRCFzKvpVkje4DQfpIZxPI4z6vabbfXBj6jh1FH8jcxPzS33U7gPDIQ5ofOM505AA7eAToflyD4uAN6XQqpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712939150; c=relaxed/simple;
	bh=noEGg3C/yA7DKHmdCn3MGEP9cOgqwwKmxb2RZDtBODg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s6JMwP4kbVPGWYTsCkIBpsrxgppmZfhyxRXdnKn0PAOvN8Z7DKEfSWZtADe8huiMZ+O0px8055NGzC9UJxJNfc+azz4Mgqllv8I/Iqc5ZtE1FHuu5u25l3eY48wjWdRvT3JZKly6OS9bCWu4wlGhic2bT87Qrp9z59B95JWU5p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VGMMQ1W91z6K5nQ;
	Sat, 13 Apr 2024 00:24:02 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id BD2FA1400CF;
	Sat, 13 Apr 2024 00:25:46 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Apr 2024 17:25:46 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de
 Melo <acme@kernel.org>, Will Deacon <will@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<gregkh@linuxfoundation.org>
CC: <linuxarm@huawei.com>, Shaokun Zhang <zhangshaokun@hisilicon.com>, Yicong
 Yang <yangyicong@hisilicon.com>, Jiucheng Xu <jiucheng.xu@amlogic.com>,
	Khuong Dinh <khuong@os.amperecomputing.com>, Atish Patra
	<atishp@atishpatra.org>, Anup Patel <anup@brainfault.org>, Andy Gross
	<agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, Frank Li
	<Frank.li@nxp.com>, Shuai Xue <xueshuai@linux.alibaba.com>, Vineet Gupta
	<vgupta@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Fenghua Yu
	<fenghua.yu@intel.com>, Dave Jiang <dave.jiang@intel.com>, Wu Hao
	<hao.wu@intel.com>, Tom Rix <trix@redhat.com>, <linux-fpga@vger.kernel.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>, Liang Kan
	<kan.liang@linux.intel.com>
Subject: [PATCH v2 29/30] Documentation: ABI + trace: hisi_ptt: update paths to bus/event_source
Date: Fri, 12 Apr 2024 17:10:56 +0100
Message-ID: <20240412161057.14099-30-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240412161057.14099-1-Jonathan.Cameron@huawei.com>
References: <20240412161057.14099-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

To allow for assigning a suitable parent to the struct pmu device
update the documentation to describe the device via the event_source
bus where it will remain accessible.

For the ABI documention file also rename the file as it is named
after the path.

Reviewed-by: Yicong Yang <yangyicong@hisilicon.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 ...i_ptt => sysfs-bus-event_source-devices-hisi_ptt} | 12 ++++++------
 Documentation/trace/hisi-ptt.rst                     |  4 ++--
 MAINTAINERS                                          |  2 +-
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-devices-hisi_ptt b/Documentation/ABI/testing/sysfs-bus-event_source-devices-hisi_ptt
similarity index 90%
rename from Documentation/ABI/testing/sysfs-devices-hisi_ptt
rename to Documentation/ABI/testing/sysfs-bus-event_source-devices-hisi_ptt
index d7e206b4901c..1119766564d7 100644
--- a/Documentation/ABI/testing/sysfs-devices-hisi_ptt
+++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices-hisi_ptt
@@ -1,4 +1,4 @@
-What:		/sys/devices/hisi_ptt<sicl_id>_<core_id>/tune
+What:		/sys/bus/event_source/devices/hisi_ptt<sicl_id>_<core_id>/tune
 Date:		October 2022
 KernelVersion:	6.1
 Contact:	Yicong Yang <yangyicong@hisilicon.com>
@@ -8,7 +8,7 @@ Description:	This directory contains files for tuning the PCIe link
 
 		See Documentation/trace/hisi-ptt.rst for more information.
 
-What:		/sys/devices/hisi_ptt<sicl_id>_<core_id>/tune/qos_tx_cpl
+What:		/sys/bus/event_source/devices/hisi_ptt<sicl_id>_<core_id>/tune/qos_tx_cpl
 Date:		October 2022
 KernelVersion:	6.1
 Contact:	Yicong Yang <yangyicong@hisilicon.com>
@@ -18,7 +18,7 @@ Description:	(RW) Controls the weight of Tx completion TLPs, which influence
 		will return an error, and out of range values will be converted
 		to 2. The value indicates a probable level of the event.
 
-What:		/sys/devices/hisi_ptt<sicl_id>_<core_id>/tune/qos_tx_np
+What:		/sys/bus/event_source/devices/hisi_ptt<sicl_id>_<core_id>/tune/qos_tx_np
 Date:		October 2022
 KernelVersion:	6.1
 Contact:	Yicong Yang <yangyicong@hisilicon.com>
@@ -28,7 +28,7 @@ Description:	(RW) Controls the weight of Tx non-posted TLPs, which influence
 		will return an error, and out of range values will be converted
 		to 2. The value indicates a probable level of the event.
 
-What:		/sys/devices/hisi_ptt<sicl_id>_<core_id>/tune/qos_tx_p
+What:		/sys/bus/event_source/devices/hisi_ptt<sicl_id>_<core_id>/tune/qos_tx_p
 Date:		October 2022
 KernelVersion:	6.1
 Contact:	Yicong Yang <yangyicong@hisilicon.com>
@@ -38,7 +38,7 @@ Description:	(RW) Controls the weight of Tx posted TLPs, which influence the
 		will return an error, and out of range values will be converted
 		to 2. The value indicates a probable level of the event.
 
-What:		/sys/devices/hisi_ptt<sicl_id>_<core_id>/tune/rx_alloc_buf_level
+What:		/sys/bus/event_source/devices/hisi_ptt<sicl_id>_<core_id>/tune/rx_alloc_buf_level
 Date:		October 2022
 KernelVersion:	6.1
 Contact:	Yicong Yang <yangyicong@hisilicon.com>
@@ -49,7 +49,7 @@ Description:	(RW) Control the allocated buffer watermark for inbound packets.
 		will return an error, and out of range values will be converted
 		to 2. The value indicates a probable level of the event.
 
-What:		/sys/devices/hisi_ptt<sicl_id>_<core_id>/tune/tx_alloc_buf_level
+What:		/sys/bus/event_source/devices/hisi_ptt<sicl_id>_<core_id>/tune/tx_alloc_buf_level
 Date:		October 2022
 KernelVersion:	6.1
 Contact:	Yicong Yang <yangyicong@hisilicon.com>
diff --git a/Documentation/trace/hisi-ptt.rst b/Documentation/trace/hisi-ptt.rst
index 989255eb5622..6eef28ebb0c7 100644
--- a/Documentation/trace/hisi-ptt.rst
+++ b/Documentation/trace/hisi-ptt.rst
@@ -40,7 +40,7 @@ IO dies (SICL, Super I/O Cluster), where there's one PCIe Root
 Complex for each SICL.
 ::
 
-    /sys/devices/hisi_ptt<sicl_id>_<core_id>
+    /sys/bus/event_source/devices/hisi_ptt<sicl_id>_<core_id>
 
 Tune
 ====
@@ -53,7 +53,7 @@ Each event is presented as a file under $(PTT PMU dir)/tune, and
 a simple open/read/write/close cycle will be used to tune the event.
 ::
 
-    $ cd /sys/devices/hisi_ptt<sicl_id>_<core_id>/tune
+    $ cd /sys/bus/event_source/devices/hisi_ptt<sicl_id>_<core_id>/tune
     $ ls
     qos_tx_cpl    qos_tx_np    qos_tx_p
     tx_path_rx_req_alloc_buf_level
diff --git a/MAINTAINERS b/MAINTAINERS
index aea47e04c3a5..2f0a97aa1e60 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9796,7 +9796,7 @@ M:	Yicong Yang <yangyicong@hisilicon.com>
 M:	Jonathan Cameron <jonathan.cameron@huawei.com>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
-F:	Documentation/ABI/testing/sysfs-devices-hisi_ptt
+F:	Documentation/ABI/testing/sysfs-bus-event_source-devices-hisi_ptt
 F:	Documentation/trace/hisi-ptt.rst
 F:	drivers/hwtracing/ptt/
 F:	tools/perf/arch/arm64/util/hisi-ptt.c
-- 
2.39.2


