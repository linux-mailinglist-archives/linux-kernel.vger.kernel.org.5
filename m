Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6923812983
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 08:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjLNHiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 02:38:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjLNHiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 02:38:07 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D535B9;
        Wed, 13 Dec 2023 23:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702539493; x=1734075493;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=s2pn4yZl0XYTp65Nn5lvuI7n/QI1GItpUEXHrwpjM9A=;
  b=BBgxT82kFOUkxCI4MYyQPQKAfHIHKZc50MvaP7ltfnOxFpmZhuSHRYKN
   3dgMT3TMoP3wzOM5EYuywcHiWCb8Vlw6za8Ub/c2Or9wX7R4T4+tKIi1T
   EIcV0k3QM2cz6v+Eo3PT1+0yIiM3eGtMwwm9YsB1yJinZYWU1ODSzqvvM
   uo5h5FL99MNf6RWdDckoa4eJvp7jr/E8mqTXSlGmu/sKJ5Ap5bDEK9hWB
   uenAHWK3DpeYlI7XZ6NhtNRnj/lgbYvhsmUifjG9d9mUwjyXYFcJ9RTHR
   hOm8EIbGwm+R55yfPw5aLevRddLquF/5jD8l/vpeEpK+vDHSobzx8r+/z
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="481275512"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="481275512"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 23:38:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="723972059"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="723972059"
Received: from llblake-mobl1.amr.corp.intel.com (HELO [192.168.1.200]) ([10.213.191.124])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 23:38:11 -0800
From:   Vishal Verma <vishal.l.verma@intel.com>
Date:   Thu, 14 Dec 2023 00:37:54 -0700
Subject: [PATCH v5 1/4] Documentatiion/ABI: Add ABI documentation for
 sys-bus-dax
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231214-vv-dax_abi-v5-1-3f7b006960b4@intel.com>
References: <20231214-vv-dax_abi-v5-0-3f7b006960b4@intel.com>
In-Reply-To: <20231214-vv-dax_abi-v5-0-3f7b006960b4@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>
Cc:     linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-cxl@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mm@kvack.org
X-Mailer: b4 0.13-dev-433a8
X-Developer-Signature: v=1; a=openpgp-sha256; l=5934;
 i=vishal.l.verma@intel.com; h=from:subject:message-id;
 bh=s2pn4yZl0XYTp65Nn5lvuI7n/QI1GItpUEXHrwpjM9A=;
 b=owGbwMvMwCXGf25diOft7jLG02pJDKlVGx4VxXeVLzrzw/Rzevi5Y9KH3GbOf7RvZum9o3Ouq
 E1sv6TV21HKwiDGxSArpsjyd89HxmNy2/N5AhMcYeawMoEMYeDiFICJ2Isx/OHn+2U8ea3O/vwu
 Tesphzmq5lYYaJ1peJkQ9+FcOvPT7GhGhs2HTzq8qm+IF3kimLko9v/0y/bhllrfTy0IN5ZJ/lB
 7hQsA
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp;
 fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing sysfs ABI documentation for the device DAX subsystem.
Various ABI attributes under this have been present since v5.1, and more
have been added over time. In preparation for adding a new attribute,
add this file with the historical details.

Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-dax | 136 ++++++++++++++++++++++++++++++++
 1 file changed, 136 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-dax b/Documentation/ABI/testing/sysfs-bus-dax
new file mode 100644
index 000000000000..6359f7bc9bf4
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-dax
@@ -0,0 +1,136 @@
+What:		/sys/bus/dax/devices/daxX.Y/align
+Date:		October, 2020
+KernelVersion:	v5.10
+Contact:	nvdimm@lists.linux.dev
+Description:
+		(RW) Provides a way to specify an alignment for a dax device.
+		Values allowed are constrained by the physical address ranges
+		that back the dax device, and also by arch requirements.
+
+What:		/sys/bus/dax/devices/daxX.Y/mapping
+Date:		October, 2020
+KernelVersion:	v5.10
+Contact:	nvdimm@lists.linux.dev
+Description:
+		(WO) Provides a way to allocate a mapping range under a dax
+		device. Specified in the format <start>-<end>.
+
+What:		/sys/bus/dax/devices/daxX.Y/mapping[0..N]/start
+What:		/sys/bus/dax/devices/daxX.Y/mapping[0..N]/end
+What:		/sys/bus/dax/devices/daxX.Y/mapping[0..N]/page_offset
+Date:		October, 2020
+KernelVersion:	v5.10
+Contact:	nvdimm@lists.linux.dev
+Description:
+		(RO) A dax device may have multiple constituent discontiguous
+		address ranges. These are represented by the different
+		'mappingX' subdirectories. The 'start' attribute indicates the
+		start physical address for the given range. The 'end' attribute
+		indicates the end physical address for the given range. The
+		'page_offset' attribute indicates the offset of the current
+		range in the dax device.
+
+What:		/sys/bus/dax/devices/daxX.Y/resource
+Date:		June, 2019
+KernelVersion:	v5.3
+Contact:	nvdimm@lists.linux.dev
+Description:
+		(RO) The resource attribute indicates the starting physical
+		address of a dax device. In case of a device with multiple
+		constituent ranges, it indicates the starting address of the
+		first range.
+
+What:		/sys/bus/dax/devices/daxX.Y/size
+Date:		October, 2020
+KernelVersion:	v5.10
+Contact:	nvdimm@lists.linux.dev
+Description:
+		(RW) The size attribute indicates the total size of a dax
+		device. For creating subdivided dax devices, or for resizing
+		an existing device, the new size can be written to this as
+		part of the reconfiguration process.
+
+What:		/sys/bus/dax/devices/daxX.Y/numa_node
+Date:		November, 2019
+KernelVersion:	v5.5
+Contact:	nvdimm@lists.linux.dev
+Description:
+		(RO) If NUMA is enabled and the platform has affinitized the
+		backing device for this dax device, emit the CPU node
+		affinity for this device.
+
+What:		/sys/bus/dax/devices/daxX.Y/target_node
+Date:		February, 2019
+KernelVersion:	v5.1
+Contact:	nvdimm@lists.linux.dev
+Description:
+		(RO) The target-node attribute is the Linux numa-node that a
+		device-dax instance may create when it is online. Prior to
+		being online the device's 'numa_node' property reflects the
+		closest online cpu node which is the typical expectation of a
+		device 'numa_node'. Once it is online it becomes its own
+		distinct numa node.
+
+What:		$(readlink -f /sys/bus/dax/devices/daxX.Y)/../dax_region/available_size
+Date:		October, 2020
+KernelVersion:	v5.10
+Contact:	nvdimm@lists.linux.dev
+Description:
+		(RO) The available_size attribute tracks available dax region
+		capacity. This only applies to volatile hmem devices, not pmem
+		devices, since pmem devices are defined by nvdimm namespace
+		boundaries.
+
+What:		$(readlink -f /sys/bus/dax/devices/daxX.Y)/../dax_region/size
+Date:		July, 2017
+KernelVersion:	v5.1
+Contact:	nvdimm@lists.linux.dev
+Description:
+		(RO) The size attribute indicates the size of a given dax region
+		in bytes.
+
+What:		$(readlink -f /sys/bus/dax/devices/daxX.Y)/../dax_region/align
+Date:		October, 2020
+KernelVersion:	v5.10
+Contact:	nvdimm@lists.linux.dev
+Description:
+		(RO) The align attribute indicates alignment of the dax region.
+		Changes on align may not always be valid, when say certain
+		mappings were created with 2M and then we switch to 1G. This
+		validates all ranges against the new value being attempted, post
+		resizing.
+
+What:		$(readlink -f /sys/bus/dax/devices/daxX.Y)/../dax_region/seed
+Date:		October, 2020
+KernelVersion:	v5.10
+Contact:	nvdimm@lists.linux.dev
+Description:
+		(RO) The seed device is a concept for dynamic dax regions to be
+		able to split the region amongst multiple sub-instances.  The
+		seed device, similar to libnvdimm seed devices, is a device
+		that starts with zero capacity allocated and unbound to a
+		driver.
+
+What:		$(readlink -f /sys/bus/dax/devices/daxX.Y)/../dax_region/create
+Date:		October, 2020
+KernelVersion:	v5.10
+Contact:	nvdimm@lists.linux.dev
+Description:
+		(RW) The create interface to the dax region provides a way to
+		create a new unconfigured dax device under the given region, which
+		can then be configured (with a size etc.) and then probed.
+
+What:		$(readlink -f /sys/bus/dax/devices/daxX.Y)/../dax_region/delete
+Date:		October, 2020
+KernelVersion:	v5.10
+Contact:	nvdimm@lists.linux.dev
+Description:
+		(WO) The delete interface for a dax region provides for deletion
+		of any 0-sized and idle dax devices.
+
+What:		$(readlink -f /sys/bus/dax/devices/daxX.Y)/../dax_region/id
+Date:		July, 2017
+KernelVersion:	v5.1
+Contact:	nvdimm@lists.linux.dev
+Description:
+		(RO) The id attribute indicates the region id of a dax region.

-- 
2.41.0

