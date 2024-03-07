Return-Path: <linux-kernel+bounces-94927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3368746DB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 04:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DC3D1C2182B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 03:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98DAF182BB;
	Thu,  7 Mar 2024 03:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="ktKeh/TV"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CBFCA6B;
	Thu,  7 Mar 2024 03:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709782630; cv=none; b=Cl0RqWYa+sU74ywSDNs92RSaLh855BrOI7pzD3a9YQAOxFwH+sdfpUlLw9N6DNotn2KQO5xd0l/s7tpFdK/6WrdJh9r6jswBEZ/Yyq2d6MdvzrezSUTG3YLyEhM0q/q9tVi+1j/nd4SpE92DLI5cZVfHiI8/N7jDxST5e2ohTvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709782630; c=relaxed/simple;
	bh=aCp+AUT/4zLjWJerWYamylzzm5U8yCYdwm8eCKs4tRQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DURlmnokUIH3S1IJLs9IBXe+mCXYvJzr5XIThOQlko+16WN9TZ7x/5jiReU9Z+BzK4FRJtVtEeV1SjTCecEXSo4xoHfL8xca3WSwkioheRIgAktWMpS12pHCiPc6Cn/LQFI85ep7T6ayHFfid5xanyytjeEb6N1w/tlYvXvvPVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=ktKeh/TV; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 427129jx031657;
	Wed, 6 Mar 2024 19:36:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=pfpt0220; bh=jfy7NVs8
	9fngLEbPB+eBY1F7wfNs/tTFv2zaGP28df4=; b=ktKeh/TVB5IAWh0G/B6wjT4Y
	72j8wMCMod/V1Ri2kgwNjNvyuhRg7SlOIGET8EXnq4uu+zqSMJbI9iBzkMjQGbki
	k3Ye1QqnkQsWpvgIIXhBEMXAZLYOhkdwPNA4Y66Ldw/eP0TMaJJt2RcWJjV7P8OD
	x4f1PR/r7Ywnedm92Zb6I/utOX49LycYaBErEf16SkJVBlweN7oGZb9uE8HL8/IP
	IibFJ7P6+lF6htdilFl2+B0QKGK7MkVUiJZjz9x6ZgGGcuqUQU3pFlQmqxmu2YEZ
	neF2Dgx3xyG28WtEVrKC/lzvVQ/+6r79fWvr5b9Yn73b1GNTU4nGlY/mx+dOAQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3wq3jfrdhb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 19:36:49 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Wed, 6 Mar 2024 19:36:37 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Wed, 6 Mar 2024 19:36:37 -0800
Received: from virtx40.. (unknown [10.28.34.196])
	by maili.marvell.com (Postfix) with ESMTP id 7B2B63F707F;
	Wed,  6 Mar 2024 19:36:32 -0800 (PST)
From: Linu Cherian <lcherian@marvell.com>
To: <suzuki.poulose@arm.com>, <mike.leach@linaro.org>, <james.clark@arm.com>,
        <leo.yan@linaro.org>
CC: <linux-arm-kernel@lists.infradead.org>, <coresight@lists.linaro.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <sgoutham@marvell.com>,
        <gcherian@marvell.com>, Linu Cherian <lcherian@marvell.com>
Subject: [PATCH v7 0/7] Coresight for Kernel panic and watchdog reset
Date: Thu, 7 Mar 2024 09:06:18 +0530
Message-ID: <20240307033625.325058-1-lcherian@marvell.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: p6VY66cGXlNNvXTuKQXYQLnOclJMxPFB
X-Proofpoint-ORIG-GUID: p6VY66cGXlNNvXTuKQXYQLnOclJMxPFB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_14,2024-03-06_01,2023-05-22_02

This patch series is rebased on v6.8-rc4 from coresisght tree,[1],
since latest changes are dependent on coresight_get/set_mode APIs.

Changelog from v6:
* Added special device files for reading crashdata, so that
  read_prevboot mode flag is removed. 
* Added new sysfs TMC device attribute, stop_on_flush.
  Stop on flush trigger event is disabled by default. 
  User need to explicitly enable this from sysfs for panic stop
  to work.
* Address parameter for panicstop ETM configuration is   
  chosen as kernel "panic" address by default.
* Added missing tmc_wait_for_tmcready during panic handling
* Few other misc code rearrangements. 

Changelog from v5:
* Fixed issues reported by CONFIG_DEBUG_ATOMIC_SLEEP
* Fixed a memory leak while reading data from /dev/tmc_etrx in
  READ_PREVBOOT mode
* Tested reading trace data from crashdump kernel

Changelog from v4:
* Device tree binding
  - Description is made more explicit on the usage of reserved memory
    region
  - Mismatch in memory region names in dts binding and driver fixed
  - Removed "mem" suffix from the memory region names
* Rename "struct tmc_register_snapshot" ->  "struct tmc_crash_metadata",
  since it contains more than register snapshot.
  Related variables are named accordingly.
* Rename struct tmc_drvdata members
   resrv_buf -> crash_tbuf
   metadata  -> crash_mdata
* Size field in metadata refers to RSZ register and hence indicates the
  size in 32 bit words. ETR metadata follows this convention, the same
  has been extended to ETF metadata as well.
* Added crc32 for more robust metadata and tracedata validation.
* Added/modified dev_dbg messages during metadata validation
* Fixed a typo in patch 5 commit description

Changelog from v3:
* Converted the Coresight ETM driver change to a named configuration.
  RFC tag has been removed with this change.
* Fixed yaml issues reported by "make dt_binding_check"
* Added names for reserved memory regions 0 and 1
* Added prevalidation checks for metadata processing
* Fixed a regression introduced in RFC v3
  - TMC Status register was getting saved wrongly
* Reverted memremap attribute changes from _WB to _WC to match
  with the dma map attributes
* Introduced reserved buffer mode specific .sync op.
  This fixes a possible crash when reserved buffer mode was used in
  normal trace capture, due to unwanted dma maintenance operations.

v6 is posted here:
https://www.spinics.net/lists/kernel/msg5055812.html

Using Coresight for Kernel panic and Watchdog reset
===================================================
This patch series is about extending Linux coresight driver support to
address kernel panic and watchdog reset scenarios. This would help
coresight users to debug kernel panic and watchdog reset using
coresight trace data.

Coresight trace capture: Kernel panic
-------------------------------------
From the coresight driver point of view, addressing the kernel panic
situation has four main requirements.

a. Support for allocation of trace buffer pages from reserved memory area.
   Platform can advertise this using a new device tree property added to
   relevant coresight nodes.

b. Support for stopping coresight blocks at the time of panic

c. Saving required metadata in the specified format

d. Support for reading trace data captured at the time of panic

Allocation of trace buffer pages from reserved RAM
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
A new optional device tree property "memory-region" is added to the
ETR/ETF device nodes, that would give the base address and size of trace
buffer.

Static allocation of trace buffers would ensure that both IOMMU enabled
and disabled cases are handled. Also, platforms that support persistent
RAM will allow users to read trace data in the subsequent boot without
booting the crashdump kernel.

Note:
For ETR sink devices, this reserved region will be used for both trace
capture and trace data retrieval.
For ETF sink devices, internal SRAM would be used for trace capture,
and they would be synced to reserved region for retrieval.

Note: Patches 1 & 2 adds support for this.

Disabling coresight blocks at the time of panic
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In order to avoid the situation of losing relevant trace data after a
kernel panic, it would be desirable to stop the coresight blocks at the
time of panic.

This can be achieved by configuring the comparator, CTI and sink
devices as below,

Comparator(triggers on kernel panic) --->External out --->CTI --
								|
		 ETR/ETF stop <------External In <--------------
Note:

* Patch 6 provides the necessary ETR configuration.
* Patch 7 provides the necessary ETM configuration.

Saving metadata at the time of kernel panic
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Coresight metadata involves all additional data that are required for a
successful trace decode in addition to the trace data. This involves
ETR/ETF, ETE register snapshot etc.

A new optional device property "memory-region" is added to
the ETR/ETF/ETE device nodes for this.

Note: Patches 3 & 4 adds support for this.

Reading trace data captured at the time of panic
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Trace data captured at the time of panic, can be read from rebooted kernel
or from crashdump kernel using the below mentioned interface.

Note: Patch 5 adds support for this.

Steps for reading trace data captured in previous boot
++++++++++++++++++++++++++++++++++++++++++++++++++++++
1. cd /sys/bus/coresight/devices/tmc_etrXX/

2. Dump trace buffer crashdata to a file,

   #dd if=/dev/crash_tmc_etrXX of=~/cstrace.bin


General flow of trace capture and decode incase of kernel panic
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
1. Enable source and sink on all the cores using the sysfs interface.
   ETR sink will have trace buffers allocated from reserved memory,
   by selecting "resrv" buffer mode from sysfs.

2. Run relevant tests.

3. On a kernel panic, all coresight blocks are disabled, necessary
   metadata is synced by kernel panic handler.

   System would eventually reboot or boot a crashdump kernel.

4. For  platforms that supports crashdump kernel, raw trace data can be
   dumped using the coresight sysfs interface from the crashdump kernel
   itself. Persistent RAM is not a requirement in this case.

5. For platforms that supports persistent RAM, trace data can be dumped
   using the coresight sysfs interface in the subsequent Linux boot.
   Crashdump kernel is not a requirement in this case. Persistent RAM
   ensures that trace data is intact across reboot.

Coresight trace capture: Watchdog reset
---------------------------------------
The main difference between addressing the watchdog reset and kernel panic
case are below,

a. Saving coresight metadata need to be taken care by the
   SCP(system control processor) firmware in the specified format,
   instead of kernel.

b. Reserved memory region given by firmware for trace buffer and metadata
   has to be in persistent RAM.
   Note: This is a requirement for watchdog reset case but optional
   in kernel panic case.

Watchdog reset can be supported only on platforms that meet the above
two requirements.

Testing Kernel panic on Linux 6.8
---------------------------------
1. Enable the preloaded ETM configuration

  #echo 1 > /sys/kernel/config/cs-syscfg/configurations/panicstop/enable

2. Configure CTI using sysfs interface

  #./cti_setup.sh

  #cat cti_setup.sh

  cd /sys/bus/coresight/devices/

  ap_cti_config () {
    #ETM trig out[0] trigger to Channel 0
    echo 0 4 > channels/trigin_attach
  }

  etf_cti_config () {
    #ETF Flush in trigger from Channel 0
    echo 0 1 > channels/trigout_attach
    echo 1 > channels/trig_filter_enable
  }

  etr_cti_config () {
    #ETR Flush in from Channel 0
    echo 0 1 > channels/trigout_attach
    echo 1 > channels/trig_filter_enable
  }

  ctidevs=`find . -name "cti*"`

  for i in $ctidevs
  do
          cd $i

          connection=`find . -name "ete*"`
          if [ ! -z "$connection" ]
          then
                  echo "AP CTI config for $i"
                  ap_cti_config
          fi

          connection=`find . -name "tmc_etf*"`
          if [ ! -z "$connection" ]
          then
                  echo "ETF CTI config for $i"
                  etf_cti_config
          fi

          connection=`find . -name "tmc_etr*"`
          if [ ! -z "$connection" ]
          then
                  echo "ETR CTI config for $i"
                  etr_cti_config
          fi

          cd ..
  done

Note: CTI connections are SOC specific and hence the above script is
added just for reference.

3. Choose reserved buffer mode for ETR buffer
  #echo "resrv" > /sys/bus/coresight/devices/tmc_etr0/buf_mode_preferred

4. Enable stop on flush trigger configuration
  #echo 1 > /sys/bus/coresight/devices/tmc_etr0/stop_on_flush 

4. Start Coresight tracing on cores 1 and 2 using sysfs interface

5. Run some application on core 1
  #taskset -c 1 dd if=/dev/urandom of=/dev/null &

6. Invoke kernel panic on core 2
  #echo 1 > /proc/sys/kernel/panic
  #taskset -c 2 echo c > /proc/sysrq-trigger

7. From rebooted kernel or crashdump kernel, read crashdata
 
  Note: For crashdump kernel option, please make sure "crash_kexec_post_notifiers" is
  added to the kernel bootargs.

  #dd if=/dev/crash_tmc_etr0 of=/trace/cstrace.bin

8. Run opencsd decoder tools/scripts to generate the instruction trace.

Sample Core 1 instruction trace dump:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	A                                  etm4_enable_hw: ffff800008ae1dd4
	CONTEXT EL2                        etm4_enable_hw: ffff800008ae1dd4
	I                                  etm4_enable_hw: ffff800008ae1dd4:
	d503201f   nop
	I                                  etm4_enable_hw: ffff800008ae1dd8:
	d503201f   nop
	I                                  etm4_enable_hw: ffff800008ae1ddc:
	d503201f   nop
	I                                  etm4_enable_hw: ffff800008ae1de0:
	d503201f   nop
	I                                  etm4_enable_hw: ffff800008ae1de4:
	d503201f   nop
	I                                  etm4_enable_hw: ffff800008ae1de8:
	d503233f   paciasp
	I                                  etm4_enable_hw: ffff800008ae1dec:
	a9be7bfd   stp     x29, x30, [sp, #-32]!
	I                                  etm4_enable_hw: ffff800008ae1df0:
	910003fd   mov     x29, sp
	I                                  etm4_enable_hw: ffff800008ae1df4:
	a90153f3   stp     x19, x20, [sp, #16]
	I                                  etm4_enable_hw: ffff800008ae1df8:
	2a0003f4   mov     w20, w0
	I                                  etm4_enable_hw: ffff800008ae1dfc:
	900085b3   adrp    x19, ffff800009b95000 <reserved_mem+0xc48>
	I                                  etm4_enable_hw: ffff800008ae1e00:
	910f4273   add     x19, x19, #0x3d0
	I                                  etm4_enable_hw: ffff800008ae1e04:
	f8747a60   ldr     x0, [x19, x20, lsl #3]
	E                                  etm4_enable_hw: ffff800008ae1e08:
	b4000140   cbz     x0, ffff800008ae1e30 <etm4_starting_cpu+0x50>
	I    149.039572921                 etm4_enable_hw: ffff800008ae1e30:
	a94153f3   ldp     x19, x20, [sp, #16]
	I    149.039572921                 etm4_enable_hw: ffff800008ae1e34:
	52800000   mov     w0, #0x0                        // #0
	I    149.039572921                 etm4_enable_hw: ffff800008ae1e38:
	a8c27bfd   ldp     x29, x30, [sp], #32

	..snip

	    149.052324811           chacha_block_generic: ffff800008642d80:
	9100a3e0   add     x0,
	I    149.052324811           chacha_block_generic: ffff800008642d84:
	b86178a2   ldr     w2, [x5, x1, lsl #2]
	I    149.052324811           chacha_block_generic: ffff800008642d88:
	8b010803   add     x3, x0, x1, lsl #2
	I    149.052324811           chacha_block_generic: ffff800008642d8c:
	b85fc063   ldur    w3, [x3, #-4]
	I    149.052324811           chacha_block_generic: ffff800008642d90:
	0b030042   add     w2, w2, w3
	I    149.052324811           chacha_block_generic: ffff800008642d94:
	b8217882   str     w2, [x4, x1, lsl #2]
	I    149.052324811           chacha_block_generic: ffff800008642d98:
	91000421   add     x1, x1, #0x1
	I    149.052324811           chacha_block_generic: ffff800008642d9c:
	f100443f   cmp     x1, #0x11


Sample Core 2 instruction trace dump(kernel panic triggered core):
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	A                                  etm4_enable_hw: ffff800008ae1dd4
	CONTEXT EL2                        etm4_enable_hw: ffff800008ae1dd4
	I                                  etm4_enable_hw: ffff800008ae1dd4:
	d503201f   nop
	I                                  etm4_enable_hw: ffff800008ae1dd8:
	d503201f   nop
	I                                  etm4_enable_hw: ffff800008ae1ddc:
	d503201f   nop
	I                                  etm4_enable_hw: ffff800008ae1de0:
	d503201f   nop
	I                                  etm4_enable_hw: ffff800008ae1de4:
	d503201f   nop
	I                                  etm4_enable_hw: ffff800008ae1de8:
	d503233f   paciasp
	I                                  etm4_enable_hw: ffff800008ae1dec:
	a9be7bfd   stp     x29, x30, [sp, #-32]!
	I                                  etm4_enable_hw: ffff800008ae1df0:
	910003fd   mov     x29, sp
	I                                  etm4_enable_hw: ffff800008ae1df4:
	a90153f3   stp     x19, x20, [sp, #16]
	I                                  etm4_enable_hw: ffff800008ae1df8:
	2a0003f4   mov     w20, w0
	I                                  etm4_enable_hw: ffff800008ae1dfc:
	900085b3   adrp    x19, ffff800009b95000 <reserved_mem+0xc48>
	I                                  etm4_enable_hw: ffff800008ae1e00:
	910f4273   add     x19, x19, #0x3d0
	I                                  etm4_enable_hw: ffff800008ae1e04:
	f8747a60   ldr     x0, [x19, x20, lsl #3]
	E                                  etm4_enable_hw: ffff800008ae1e08:
	b4000140   cbz     x0, ffff800008ae1e30 <etm4_starting_cpu+0x50>
	I    149.046243445                 etm4_enable_hw: ffff800008ae1e30:
	a94153f3   ldp     x19, x20, [sp, #16]
	I    149.046243445                 etm4_enable_hw: ffff800008ae1e34:
	52800000   mov     w0, #0x0                        // #0
	I    149.046243445                 etm4_enable_hw: ffff800008ae1e38:
	a8c27bfd   ldp     x29, x30, [sp], #32
	I    149.046243445                 etm4_enable_hw: ffff800008ae1e3c:
	d50323bf   autiasp
	E    149.046243445                 etm4_enable_hw: ffff800008ae1e40:
	d65f03c0   ret
	A                                ete_sysreg_write: ffff800008adfa18

	..snip

	I     149.05422547                          panic: ffff800008096300:
	a90363f7   stp     x23, x24, [sp, #48]
	I     149.05422547                          panic: ffff800008096304:
	6b00003f   cmp     w1, w0
	I     149.05422547                          panic: ffff800008096308:
	3a411804   ccmn    w0, #0x1, #0x4, ne  // ne = any
	N     149.05422547                          panic: ffff80000809630c:
	540001e0   b.eq    ffff800008096348 <panic+0xe0>  // b.none
	I     149.05422547                          panic: ffff800008096310:
	f90023f9   str     x25, [sp, #64]
	E     149.05422547                          panic: ffff800008096314:
	97fe44ef   bl      ffff8000080276d0 <panic_smp_self_stop>
	A                                           panic: ffff80000809634c
	I     149.05422547                          panic: ffff80000809634c:
	910102d5   add     x21, x22, #0x40
	I     149.05422547                          panic: ffff800008096350:
	52800020   mov     w0, #0x1                        // #1
	E     149.05422547                          panic: ffff800008096354:
	94166b8b   bl      ffff800008631180 <bust_spinlocks>
	N    149.054225518                 bust_spinlocks: ffff800008631180:
	340000c0   cbz     w0, ffff800008631198 <bust_spinlocks+0x18>
	I    149.054225518                 bust_spinlocks: ffff800008631184:
	f000a321   adrp    x1, ffff800009a98000 <pbufs.0+0xbb8>
	I    149.054225518                 bust_spinlocks: ffff800008631188:
	b9405c20   ldr     w0, [x1, #92]
	I    149.054225518                 bust_spinlocks: ffff80000863118c:
	11000400   add     w0, w0, #0x1
	I    149.054225518                 bust_spinlocks: ffff800008631190:
	b9005c20   str     w0, [x1, #92]
	E    149.054225518                 bust_spinlocks: ffff800008631194:
	d65f03c0   ret
	A                                           panic: ffff800008096358


Future Improvements
-------------------
* Explore changing CTI sysfs script to system configuration manager profile
* Explore Perf based trace capture and decode

Links:
1. https://kernel.googlesource.com/pub/scm/linux/kernel/git/coresight/linux.git/+/refs/heads/next


Linu Cherian (7):
  dt-bindings: arm: coresight-tmc: Add "memory-region" property
  coresight: tmc-etr: Add support to use reserved trace memory
  coresight: core: Add provision for panic callbacks
  coresight: tmc: Enable panic sync handling
  coresight: tmc: Add support for reading crash data
  coresight: tmc: Stop trace capture on FlIn
  coresight: config: Add preloaded configuration

 .../bindings/arm/arm,coresight-tmc.yaml       |  26 ++
 drivers/hwtracing/coresight/Makefile          |   2 +-
 .../coresight/coresight-cfg-preload.c         |   2 +
 .../coresight/coresight-cfg-preload.h         |   2 +
 .../hwtracing/coresight/coresight-cfg-pstop.c |  83 +++++
 drivers/hwtracing/coresight/coresight-core.c  |  37 ++
 .../coresight/coresight-etm4x-core.c          |   1 +
 .../hwtracing/coresight/coresight-tmc-core.c  | 248 +++++++++++++-
 .../hwtracing/coresight/coresight-tmc-etf.c   | 161 ++++++++-
 .../hwtracing/coresight/coresight-tmc-etr.c   | 322 +++++++++++++++++-
 drivers/hwtracing/coresight/coresight-tmc.h   |  83 +++++
 include/linux/coresight.h                     |  25 ++
 12 files changed, 972 insertions(+), 20 deletions(-)
 create mode 100644 drivers/hwtracing/coresight/coresight-cfg-pstop.c

-- 
2.34.1


