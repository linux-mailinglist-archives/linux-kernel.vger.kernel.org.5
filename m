Return-Path: <linux-kernel+bounces-163116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 458708B65F0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 00:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0401282AB3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 22:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0137A54919;
	Mon, 29 Apr 2024 22:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uci.edu header.i=@uci.edu header.b="ii/t5plc"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0803F2E3E5
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 22:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714431353; cv=none; b=WyXZP8uyqT1Vl/m+mOiuJqP6maOJn+ee+nW1j4rP1xkYoZolnurn/FywLUc7glK4xdXLAaOeYGjIfuHL2MWuC2tDRtqO/jobcwJJTGZr1yHdEL8UYI1a7r0OFYoXd8amMQVcduMd7iUryySRFuUIlltSgAOVFwXbsFH47kSNIxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714431353; c=relaxed/simple;
	bh=tU8k7uFthMUmH1zn47AFp/Y6MqilSJd/Cs0wXpqOZN0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Ahoxf0wO9F3Chw65zSGcdDUoqHHDi0skTzZ9yKH5FxMXSS8DSqWNSJY53/vb6zFnaszaMtqD4sKhS4s6aSMzNO2ABz3LxJdz6ZRCItpWzZ9sqXafdv1OUzlD+ab4qdkYkLsaE5XyZVkRkEl3nQ/kOchXpIOkX/QClb2/wgZyULQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uci.edu; spf=pass smtp.mailfrom=uci.edu; dkim=pass (2048-bit key) header.d=uci.edu header.i=@uci.edu header.b=ii/t5plc; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uci.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uci.edu
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6eddff25e4eso4330306b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 15:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uci.edu; s=google; t=1714431351; x=1715036151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=POlR7NQgiLwjOhYaRxz63ZKhGHYztGZkSOHzbrcjgOw=;
        b=ii/t5plcIwUYZsgZzpViw50PswbiAOQBPulmF5VHVDVMt90o+YO0k2ffZTRNhqpyp1
         +kMJq9gxaOVesaLDxK/1gG6dhEMZq8KupTNkqyvyOEEdQ0K1sdmJ0+vdQH1UpW3acMzh
         QDKdMoR/TeV38sjNrI5y0sKMnjw3rDonWM9FuTiCxTD8UH0KzWUSHrDmZqntGJ60Lfph
         65i6k7+snFe1vvj02DPJbLu6qScNJ9Pb/Kb4XVRQJ0iemTxqmvppg6SrBXoBe5FHBWjo
         Or9GN3fFy0a+kjl5Dj9OvOsUsOu3odpcb3DGojPV+wzdllpwVQTASKm2laDli8LFdrUU
         3CTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714431351; x=1715036151;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=POlR7NQgiLwjOhYaRxz63ZKhGHYztGZkSOHzbrcjgOw=;
        b=NkANWlyr0DxPN/v3CjXbjHRm8uNbubGvI26cmtrizmPuojdCbz6O/yfWxibjVoeWRX
         mnpnHsHsBPPkA2whu/RsNw6VG605lfGmucW19VaeHyXmGxZtBy/kpsYwoj10OGOTV6xj
         OiF3oGzWPX8Z5U8i0yVxtGeYqtTUCUll7Wv32FumRWAnCCxt8aw4pXVs0kkzdSuXzaUC
         BQijEdg/CRuBApZhU1tRr8N1bKJyg4VDJj4Y992eLQgHZiC3W4GL84GETSyZJKI1xtZm
         S1dYH3ZGdcmCoZmKJaPvIdsq/ushbFAwYKcddqksAF4UbbymPlgPVUM9UIOBtptfXRLD
         qq2g==
X-Forwarded-Encrypted: i=1; AJvYcCUg6gGCrTsttw0fF0ES2cqbWqOt8WjOAQbGh/VE6efTxMAxM66dkUUVP0gYqQUl1tES2w9fzazAHNuvOcwRHc+7APR3Oa4YojjUI+n5
X-Gm-Message-State: AOJu0YzAFieGDQfV8Bl930jpHETKJHfqGcBANkeKZrxKuKhHUHt10r26
	PToshSMo2nV3VeGHOxclnamPzMvNR6gI142xidYR/UXNJWN4UWTPlmM16wcuZoCmkWAx/irDR0Y
	+lKQ=
X-Google-Smtp-Source: AGHT+IEd7I6jT2tLz/KAtRkU3Yc07uF1+ZTS9TR3nGX3gf5lm4cWxbWHCn35G3KMXiEudHUWhvAcGw==
X-Received: by 2002:a05:6a00:3907:b0:6f3:86ac:5eae with SMTP id fh7-20020a056a00390700b006f386ac5eaemr952015pfb.28.1714431351160;
        Mon, 29 Apr 2024 15:55:51 -0700 (PDT)
Received: from alpha.mshome.net (ip68-4-168-191.oc.oc.cox.net. [68.4.168.191])
        by smtp.gmail.com with ESMTPSA id e14-20020aa7824e000000b006edceb4ea9dsm19827265pfn.166.2024.04.29.15.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 15:55:50 -0700 (PDT)
From: Remington Brasga <rbrasga@uci.edu>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Remington Brasga <rbrasga@uci.edu>
Subject: [PATCH] Docs: typos/spelling
Date: Mon, 29 Apr 2024 22:55:27 +0000
Message-Id: <20240429225527.2329-1-rbrasga@uci.edu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix spelling and grammar in Docs descriptions

Signed-off-by: Remington Brasga <rbrasga@uci.edu>
---
 Documentation/admin-guide/hw-vuln/srso.rst                    | 2 +-
 Documentation/admin-guide/kernel-parameters.txt               | 2 +-
 Documentation/admin-guide/mm/ksm.rst                          | 2 +-
 Documentation/arch/m68k/buddha-driver.rst                     | 2 +-
 Documentation/arch/sparc/oradax/dax-hv-api.txt                | 2 +-
 Documentation/arch/x86/xstate.rst                             | 2 +-
 Documentation/core-api/entry.rst                              | 2 +-
 Documentation/driver-api/mtd/nand_ecc.rst                     | 2 +-
 Documentation/driver-api/scsi.rst                             | 2 +-
 Documentation/driver-api/usb/usb.rst                          | 2 +-
 Documentation/driver-api/wbrf.rst                             | 2 +-
 Documentation/filesystems/directory-locking.rst               | 4 ++--
 Documentation/filesystems/porting.rst                         | 4 ++--
 Documentation/mm/slub.rst                                     | 2 +-
 Documentation/security/SCTP.rst                               | 2 +-
 Documentation/translations/zh_TW/process/submit-checklist.rst | 2 +-
 16 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/Documentation/admin-guide/hw-vuln/srso.rst b/Documentation/admin-guide/hw-vuln/srso.rst
index e715bfc09879..4bd3ce3ba171 100644
--- a/Documentation/admin-guide/hw-vuln/srso.rst
+++ b/Documentation/admin-guide/hw-vuln/srso.rst
@@ -135,7 +135,7 @@ and does not want to suffer the performance impact, one can always
 disable the mitigation with spec_rstack_overflow=off.
 
 Similarly, 'Mitigation: IBPB' is another full mitigation type employing
-an indrect branch prediction barrier after having applied the required
+an indirect branch prediction barrier after having applied the required
 microcode patch for one's system. This mitigation comes also at
 a performance cost.
 
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 213d0719e2b7..bdf0112afdc5 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -7323,7 +7323,7 @@
 			This can be changed after boot by writing to the
 			matching /sys/module/workqueue/parameters file. All
 			workqueues with the "default" affinity scope will be
-			updated accordignly.
+			updated accordingly.
 
 	workqueue.debug_force_rr_cpu
 			Workqueue used to implicitly guarantee that work
diff --git a/Documentation/admin-guide/mm/ksm.rst b/Documentation/admin-guide/mm/ksm.rst
index a639cac12477..ad8e7a41f3b5 100644
--- a/Documentation/admin-guide/mm/ksm.rst
+++ b/Documentation/admin-guide/mm/ksm.rst
@@ -308,7 +308,7 @@ limited by the ``advisor_max_cpu`` parameter. In addition there is also the
 ``advisor_target_scan_time`` parameter. This parameter sets the target time to
 scan all the KSM candidate pages. The parameter ``advisor_target_scan_time``
 decides how aggressive the scan time advisor scans candidate pages. Lower
-values make the scan time advisor to scan more aggresively. This is the most
+values make the scan time advisor to scan more aggressively. This is the most
 important parameter for the configuration of the scan time advisor.
 
 The initial value and the maximum value can be changed with
diff --git a/Documentation/arch/m68k/buddha-driver.rst b/Documentation/arch/m68k/buddha-driver.rst
index 20e401413991..5d1bc824978b 100644
--- a/Documentation/arch/m68k/buddha-driver.rst
+++ b/Documentation/arch/m68k/buddha-driver.rst
@@ -173,7 +173,7 @@ When accessing IDE registers with A6=1 (for example $84x),
 the timing will always be mode 0 8-bit compatible, no matter
 what you have selected in the speed register:
 
-781ns select, IOR/IOW after 4 clock cycles (=314ns) aktive.
+781ns select, IOR/IOW after 4 clock cycles (=314ns) active.
 
 All  the  timings with a very short select-signal (the 355ns
 fast  accesses)  depend  on the accelerator card used in the
diff --git a/Documentation/arch/sparc/oradax/dax-hv-api.txt b/Documentation/arch/sparc/oradax/dax-hv-api.txt
index 7ecd0bf4957b..ef1a4c2bf08b 100644
--- a/Documentation/arch/sparc/oradax/dax-hv-api.txt
+++ b/Documentation/arch/sparc/oradax/dax-hv-api.txt
@@ -41,7 +41,7 @@ Chapter 36. Coprocessor services
         submissions until they succeed; waiting for an outstanding CCB to complete is not necessary, and would
         not be a guarantee that a future submission would succeed.
 
-        The availablility of DAX coprocessor command service is indicated by the presence of the DAX virtual
+        The availability of DAX coprocessor command service is indicated by the presence of the DAX virtual
         device node in the guest MD (Section 8.24.17, “Database Analytics Accelerators (DAX) virtual-device
         node”).
 
diff --git a/Documentation/arch/x86/xstate.rst b/Documentation/arch/x86/xstate.rst
index ae5c69e48b11..cec05ac464c1 100644
--- a/Documentation/arch/x86/xstate.rst
+++ b/Documentation/arch/x86/xstate.rst
@@ -138,7 +138,7 @@ Note this example does not include the sigaltstack preparation.
 Dynamic features in signal frames
 ---------------------------------
 
-Dynamcally enabled features are not written to the signal frame upon signal
+Dynamically enabled features are not written to the signal frame upon signal
 entry if the feature is in its initial configuration.  This differs from
 non-dynamic features which are always written regardless of their
 configuration.  Signal handlers can examine the XSAVE buffer's XSTATE_BV
diff --git a/Documentation/core-api/entry.rst b/Documentation/core-api/entry.rst
index e12f22ab33c7..a15f9b1767a2 100644
--- a/Documentation/core-api/entry.rst
+++ b/Documentation/core-api/entry.rst
@@ -18,7 +18,7 @@ exceptions`_, `NMI and NMI-like exceptions`_.
 Non-instrumentable code - noinstr
 ---------------------------------
 
-Most instrumentation facilities depend on RCU, so intrumentation is prohibited
+Most instrumentation facilities depend on RCU, so instrumentation is prohibited
 for entry code before RCU starts watching and exit code after RCU stops
 watching. In addition, many architectures must save and restore register state,
 which means that (for example) a breakpoint in the breakpoint entry code would
diff --git a/Documentation/driver-api/mtd/nand_ecc.rst b/Documentation/driver-api/mtd/nand_ecc.rst
index 74347c14a70b..a0d681f26a2e 100644
--- a/Documentation/driver-api/mtd/nand_ecc.rst
+++ b/Documentation/driver-api/mtd/nand_ecc.rst
@@ -462,7 +462,7 @@ statements is reduced. This is also reflected in the assembly code.
 Analysis 3
 ==========
 
-Very weird. Guess it has to do with caching or instruction parallellism
+Very weird. Guess it has to do with caching or instruction parallelism
 or so. I also tried on an eeePC (Celeron, clocked at 900 Mhz). Interesting
 observation was that this one is only 30% slower (according to time)
 executing the code as my 3Ghz D920 processor.
diff --git a/Documentation/driver-api/scsi.rst b/Documentation/driver-api/scsi.rst
index 64b231d125e0..ec92ea2c82cd 100644
--- a/Documentation/driver-api/scsi.rst
+++ b/Documentation/driver-api/scsi.rst
@@ -259,7 +259,7 @@ attributes for Serial Attached SCSI, a variant of SATA aimed at large
 high-end systems.
 
 The SAS transport class contains common code to deal with SAS HBAs, an
-aproximated representation of SAS topologies in the driver model, and
+approximated representation of SAS topologies in the driver model, and
 various sysfs attributes to expose these topologies and management
 interfaces to userspace.
 
diff --git a/Documentation/driver-api/usb/usb.rst b/Documentation/driver-api/usb/usb.rst
index fb41768696ec..89f9c37bb979 100644
--- a/Documentation/driver-api/usb/usb.rst
+++ b/Documentation/driver-api/usb/usb.rst
@@ -422,7 +422,7 @@ USBDEVFS_CONNECTINFO
 
 USBDEVFS_GET_SPEED
     Returns the speed of the device. The speed is returned as a
-    nummerical value in accordance with enum usb_device_speed
+    numerical value in accordance with enum usb_device_speed
 
     File modification time is not updated by this request.
 
diff --git a/Documentation/driver-api/wbrf.rst b/Documentation/driver-api/wbrf.rst
index f48bfa029813..6b18833e2e69 100644
--- a/Documentation/driver-api/wbrf.rst
+++ b/Documentation/driver-api/wbrf.rst
@@ -68,7 +68,7 @@ The expected flow for the consumers:
 can be enabled for the device.
 2. Call `amd_wbrf_register_notifier` to register for notification
 of frequency band change(add or remove) from other producers.
-3. Call the `amd_wbrf_retrieve_freq_band` initally to retrieve
+3. Call the `amd_wbrf_retrieve_freq_band` initially to retrieve
 current active frequency bands considering some producers may broadcast
 such information before the consumer is up.
 4. On receiving a notification for frequency band change, run
diff --git a/Documentation/filesystems/directory-locking.rst b/Documentation/filesystems/directory-locking.rst
index 05ea387bc9fb..6fdf0b02df43 100644
--- a/Documentation/filesystems/directory-locking.rst
+++ b/Documentation/filesystems/directory-locking.rst
@@ -44,7 +44,7 @@ For our purposes all operations fall in 6 classes:
 	* decide which of the source and target need to be locked.
 	  The source needs to be locked if it's a non-directory, target - if it's
 	  a non-directory or about to be removed.
-	* take the locks that need to be taken (exlusive), in inode pointer order
+	* take the locks that need to be taken (exclusive), in inode pointer order
 	  if need to take both (that can happen only when both source and target
 	  are non-directories - the source because it wouldn't need to be locked
 	  otherwise and the target because mixing directory and non-directory is
@@ -234,7 +234,7 @@ among the children, in some order.  But that is also impossible, since
 neither of the children is a descendent of another.
 
 That concludes the proof, since the set of operations with the
-properties requiered for a minimal deadlock can not exist.
+properties required for a minimal deadlock can not exist.
 
 Note that the check for having a common ancestor in cross-directory
 rename is crucial - without it a deadlock would be possible.  Indeed,
diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index 1be76ef117b3..f2b44c2400c6 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -858,7 +858,7 @@ be misspelled d_alloc_anon().
 
 **mandatory**
 
-[should've been added in 2016] stale comment in finish_open() nonwithstanding,
+[should've been added in 2016] stale comment in finish_open() notwithstanding,
 failure exits in ->atomic_open() instances should *NOT* fput() the file,
 no matter what.  Everything is handled by the caller.
 
@@ -989,7 +989,7 @@ This mechanism would only work for a single device so the block layer couldn't
 find the owning superblock of any additional devices.
 
 In the old mechanism reusing or creating a superblock for a racing mount(2) and
-umount(2) relied on the file_system_type as the holder. This was severly
+umount(2) relied on the file_system_type as the holder. This was severely
 underdocumented however:
 
 (1) Any concurrent mounter that managed to grab an active reference on an
diff --git a/Documentation/mm/slub.rst b/Documentation/mm/slub.rst
index b517ee28a955..60d350d08362 100644
--- a/Documentation/mm/slub.rst
+++ b/Documentation/mm/slub.rst
@@ -80,7 +80,7 @@ to the dentry cache with::
 
 Debugging options may require the minimum possible slab order to increase as
 a result of storing the metadata (for example, caches with PAGE_SIZE object
-sizes).  This has a higher liklihood of resulting in slab allocation errors
+sizes).  This has a higher likelihood of resulting in slab allocation errors
 in low memory situations or if there's high fragmentation of memory.  To
 switch off debugging for such caches by default, use::
 
diff --git a/Documentation/security/SCTP.rst b/Documentation/security/SCTP.rst
index b73eb764a001..6d80d464ab6e 100644
--- a/Documentation/security/SCTP.rst
+++ b/Documentation/security/SCTP.rst
@@ -81,7 +81,7 @@ A summary of the ``@optname`` entries is as follows::
                             destination addresses.
 
     SCTP_SENDMSG_CONNECT  - Initiate a connection that is generated by a
-                            sendmsg(2) or sctp_sendmsg(3) on a new asociation.
+                            sendmsg(2) or sctp_sendmsg(3) on a new association.
 
     SCTP_PRIMARY_ADDR     - Set local primary address.
 
diff --git a/Documentation/translations/zh_TW/process/submit-checklist.rst b/Documentation/translations/zh_TW/process/submit-checklist.rst
index 43f2e3c5b514..0ecb187753e4 100644
--- a/Documentation/translations/zh_TW/process/submit-checklist.rst
+++ b/Documentation/translations/zh_TW/process/submit-checklist.rst
@@ -31,7 +31,7 @@ Linux內核補丁提交檢查單
 
    c) 使用 ``O=builddir`` 時可以成功編譯
 
-   d) 任何 Doucmentation/ 下的變更都能成功構建且不引入新警告/錯誤。
+   d) 任何 Documentation/ 下的變更都能成功構建且不引入新警告/錯誤。
       用 ``make htmldocs`` 或 ``make pdfdocs`` 檢驗構建情況並修復問題。
 
 3) 通過使用本地交叉編譯工具或其他一些構建設施在多個CPU體系結構上構建。
-- 
2.34.1


