Return-Path: <linux-kernel+bounces-8492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7EAF81B893
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66B581F269A4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751D776099;
	Thu, 21 Dec 2023 13:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1u+yrJn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE177609B;
	Thu, 21 Dec 2023 13:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d3cfb1568eso6929655ad.1;
        Thu, 21 Dec 2023 05:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703165391; x=1703770191; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KYWiDqA/xVqURnqXRXqj1df8Wv23bEonDjlL7ZycWBs=;
        b=A1u+yrJnfkyNq3+pCed94353DWTMDfeIV5OF/83Pk7YzpMCuXIu0sSPApIsc5zs5CB
         hL4mcdmebYqDh4Nev7gP+i6zMbqjMoMYkplSXDNQHiVQ/OPmDuSVcYwSwxjAFwfUNBea
         urvrHWsQYbycvWNNAC87SKZhTRcl1UOTxqWWH5rUXQhQBEIJghpK0lKZtD86E/qehJOU
         hnwxUmIOGDtiT7vUX0E5sCNSHCgPtKw4XI20hH98zXHgozeGCW6zFYRE8EIKTTLe4NKx
         ltpMnsKbjUxpAUxLEe+0C32/9kKXuC8eYO2/Mps8a4KSwGLc0G3KRxgDjzQlql+k6gmC
         7Wlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703165391; x=1703770191;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KYWiDqA/xVqURnqXRXqj1df8Wv23bEonDjlL7ZycWBs=;
        b=XGNngtKy810F5QrPAfFFbRPCPO2xTcDYBGNv+4U+6xA+cVKw8jimH8BXP+nl3AkvLX
         UQnHK81SdRUsOV+gjWhhJuAkHBIrRSLBT4zK71AdDMcBmO4fR+O4yUktOnNRPErUJ5oN
         SPVx9PYslsqEP9XmkX75lTaJCtp3NaLwuttI8IFwvqaj/pJkK6YOaYyVHrF28LGI6x1p
         hz7ivZRtlBCOWd4Jj9MNRV+Qo+NLo176++FnNnR9OgRyqmsqPe0QgPTPQhHfQhIqVU0y
         bPSj9DJxzAKKTcSXQWRHQZJn67Gun58KO0Em5VMmaEVnl5NfweQc4XdjyyUet6oYZscu
         OOng==
X-Gm-Message-State: AOJu0YxclgxisTW3xxYbqRD7OK6voyAGCNDoTqSPDCE6rnDBt/VIOkhZ
	gzNoJtvl/It2FpImAdq/ekV/unBHHis=
X-Google-Smtp-Source: AGHT+IFFoM0rhYvpy9+Lbrf0OF4O0nZ9UnuICWHyRxK6jqe62Ztv/naVB+Q23U7A2DwZEymCG5+hcw==
X-Received: by 2002:a17:903:2347:b0:1d3:c730:f0a2 with SMTP id c7-20020a170903234700b001d3c730f0a2mr7762164plh.118.1703165390748;
        Thu, 21 Dec 2023 05:29:50 -0800 (PST)
Received: from ruipeng-ThinkCentre-M730e-N010.company.local (014136220210.static.ctinets.com. [14.136.220.210])
        by smtp.gmail.com with ESMTPSA id 28-20020a17090a1a1c00b0028b3539cd97sm4372382pjk.20.2023.12.21.05.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 05:29:50 -0800 (PST)
From: Ruipeng Qi <ruipengqi7@gmail.com>
To: corbet@lwn.net,
	rafael.j.wysocki@intel.com,
	gregkh@linuxfoundation.org,
	bagasdotme@gmail.com,
	carlos.bilbao@amd.com,
	vegard.nossum@oracle.com
Cc: skhan@linuxfoundation.org,
	srinivas.pandruvada@linux.intel.com,
	qiruipeng@lixiang.com,
	linux@leemhuis.info,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/7] doc: Add osdump guide
Date: Thu, 21 Dec 2023 21:29:43 +0800
Message-Id: <20231221132943.653-1-ruipengqi7@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: qiruipeng <qiruipeng@lixiang.com>

Add osdump guide for the users who try to compile with osdump enabled,
use, and analysis real system problem.

Signed-off-by: qiruipeng <qiruipeng@lixiang.com>
---
 Documentation/admin-guide/index.rst  |  1 +
 Documentation/admin-guide/osdump.rst | 94 ++++++++++++++++++++++++++++
 2 files changed, 95 insertions(+)
 create mode 100644 Documentation/admin-guide/osdump.rst

diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
index 43ea35613dfc..1212ff4d130e 100644
--- a/Documentation/admin-guide/index.rst
+++ b/Documentation/admin-guide/index.rst
@@ -116,6 +116,7 @@ configure specific aspects of kernel behavior to your liking.
    mono
    namespaces/index
    numastat
+   osdump
    parport
    perf-security
    pm/index
diff --git a/Documentation/admin-guide/osdump.rst b/Documentation/admin-guide/osdump.rst
new file mode 100644
index 000000000000..5738b03ff684
--- /dev/null
+++ b/Documentation/admin-guide/osdump.rst
@@ -0,0 +1,94 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===================================================
+Documentation for osdump - The Os Minidump Solution
+===================================================
+
+Overview
+========
+
+Osdump is a new crash dumping solution aiming at specific embedded
+devices within Automotive or Industrial having the following features:
+ - limited memory.
+ - require quick reboots after system faults.
+
+To minimize the dump file size and maximize the dump process speed,
+Osdump provides the following features:
+ - excludes userspace memory, focusing solely on resolving OS-related issues.
+ - eliminates constant data such as text segments.
+ - core OS data for dumping, this includes:
+    - static allocated bss and data segments
+    - dynamic data such as:
+       - slub data for small-sized data
+       - some large-sized data alloced in pages.
+ - compresses dump data to help reduce dump file size
+
+Considering the large volume of non-contiguous data, a binary data format is
+used directly.
+
+By utilizing the dump file and vmlinux, a standard elf format file can be
+reassembled and parsed using crash tool.
+
+Declare
+========
+Mainly test on arm64 with 2G DDR, selecting slub as SLAB allocator, 39-bit for
+address space size.
+
+Configure and Build
+===================
+
+Kernel config
+-------------
+Disable CRASH_CORE, SLUB_DEBUG, and SLUB_TINY, and then select CONFIG_OS_MINIDUMP.
+
+Dts config
+----------
+Add one reserved region for osdump. Its size depends DDR size you are using. Here
+add one 16M reserved region with 2G's DDR.
+
+osdump {
+	compatible = "osdump";
+	reg = <0 0x64000000 0 0x1000000>;
+};
+
+Build the image after you have done with configuration.
+
+Trigger one panic and analysis it
+=================================
+
+0) Precondition
+---------------
+DDR won't poweroff during panic. Its content should not be lose.
+
+1) Generate dump file
+---------------------
+When a panic occurs, it will dump core data into specific reserved region.
+
+echo c > /proc/sysrq-trigger
+
+2) Get dump file
+----------------
+When system reboot from panic, run the following command to get dump file.
+
+cat /proc/osdump > ./osdump
+
+Got 13M dump file on my side.
+
+3) Run crash tool to generate standard elf file
+-----------------------------------------------
+
+crash --enable_raw_dumpfile ./vmlinux ./osdump  -m vabits_actual=39 --machdep\
+	kimage_voffset=0xffffffbf8f000000 --machdep phys_offset=0x80000000
+
+Add new feature for crash tool that reassemble a standard elf format file with
+the dump file and vmlinux. Will submit this patch later.
+
+4) Analysis with crash tool
+---------------------------
+
+crash ./vmlinux ./osdump_elf
+
+
+Note
+====
+disable when select CRASH_CORE, SLUB_DEBUG, or SLUB_TINY.
-- 
2.17.1


