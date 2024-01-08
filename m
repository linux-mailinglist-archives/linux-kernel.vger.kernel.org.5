Return-Path: <linux-kernel+bounces-19594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F7E826F57
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 14:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0E1CB22179
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 13:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F1041231;
	Mon,  8 Jan 2024 13:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b="yk+Gflt+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from refb01.tmes.trendmicro.eu (refb01.tmes.trendmicro.eu [18.185.115.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B44D44C7D;
	Mon,  8 Jan 2024 13:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensynergy.com
Received: from 104.47.7.169_.trendmicro.com (unknown [172.21.9.50])
	by refb01.tmes.trendmicro.eu (Postfix) with ESMTPS id 8828810C62B6B;
	Mon,  8 Jan 2024 13:11:01 +0000 (UTC)
Received: from 104.47.7.169_.trendmicro.com (unknown [172.21.199.136])
	by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 4975F10000D03;
	Mon,  8 Jan 2024 13:10:54 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1704719451.745000
X-TM-MAIL-UUID: ead84477-01ee-4189-bb58-fc8edd8a776c
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (unknown [104.47.7.169])
	by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id B616E100003AD;
	Mon,  8 Jan 2024 13:10:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IFEVcEyeLZS0EcvERlDYEkfKndErWVFBONB2oKvQGAOYiYw+JiBTOFV+FRjZ4n8kmZI8RZlYTt7RlUozinvSw5VQc2HgYqqtN0atdZCPE/W3N3hMeZdtsny8jOzFQKV+x2RTSFNhhhlNsWg/k4GLFHQ/nhvBoTUeFfB7AEGA+lA71FqVhLMTkWbWvs1SgSTe5CG7fHKYMPAr13LBH0q7kMK8T0+BSNwKHJDt0yCFLzr5PR6z9O1a5CuWqJpuPSYAvYmY24EnsCtJUSmcvFoq5o9pPEc/Y22bjRBMW4iFGQYHIDrzA9rrWnZBpxbWtsncurRwjYrkH6gTakiQhbuFRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=urhI8IegTqAaUJl4uyRR/YWlMZyYvw4IvBJ09z0kbCY=;
 b=Fv6ryGp1sPKgLKXDlW9e1UPSIhPYBQJ9WFiHnFgVZKcOZTq0+hsRJhlc33kSFMEjIrNykaZTJCHyPlkFyy9QionQw7MVHBnTjgrNYSAFzSA586igm9VGZeSqkqpuBam8YxtNWvctkkPR/D2Xuf4dyZ+9Q7h++tEPucqlVUZaYnmhfKjwcO0svWrk8jPhXpezG5eOVGlP/f/BBgMbnT3pIkFiwOq2zSsR+VyNMX/n55Tq3wF+a73+hHJ45+sWmHkk5WS2GCFZTtgG9SudKRE1MtfGxxMrCJxZBBPBPXOa4rE5JyB6nFS/fGrUJ8KsReRjhpdpM+KSzRGcHFV3RWNi9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 217.66.60.4) smtp.rcpttodomain=davemloft.net smtp.mailfrom=opensynergy.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=opensynergy.com; dkim=none (message not signed); arc=none (0)
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 217.66.60.4)
 smtp.mailfrom=opensynergy.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=opensynergy.com;
Received-SPF: Pass (protection.outlook.com: domain of opensynergy.com
 designates 217.66.60.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.66.60.4; helo=SR-MAIL-03.open-synergy.com; pr=C
From: Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com>
To: Wolfgang Grandegger <wg@grandegger.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Harald Mommer <harald.mommer@opensynergy.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Damir Shaikhutdinov <Damir.Shaikhutdinov@opensynergy.com>,
	linux-kernel@vger.kernel.org,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: [PATCH v5] can: virtio: Initial virtio CAN driver.
Date: Mon,  8 Jan 2024 14:10:35 +0100
Message-ID: <20240108131039.2234044-1-Mikhail.Golubev-Ciuchea@opensynergy.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6EUR05FT034:EE_|BEVP281MB3557:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b5948090-1896-4fef-10eb-08dc104b3abc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qgTjWVbOLEPqVAJfbExdw35XJtwMCXcFaAMSU3DN85XUakkKTHa06hBWeFT4HAlYAOnAejQfB8t19ns6Isb5+x/FR1ZfpbdxdP0SKo1h9Z24OK2I4E66f0oIux3sRHpiit8AeSeupLBNXZHnj/rF+A4LZIFwlje9LCSZVZoZUCg9WJcuj0lpcmxtabIKyuoRkYrOBqlIkAq+/9OID4Z5UzcZ0QQP4vdS0BiKOES2LZuqszeHGgnoj89+rGx0rc3+mX/1pi3WUL+0g85NcGmJbJR9wKL+7St5vwuglzufvFEtxeuXOJf0mjQKfmPvE32ZxF9hCHX6mg6i4GGePoGY13QP6PaVP+Nz/Da6NTmUjeC8jnsiX7OIIprHHtLeSSzEhCrqnXU4+Q6HHcLOuniEzcHj71gSH55MPsvQRxVRLUsfVX2KUpg458c6lrPABfPyYD3XVG33BFyrIiNQ9CjEjKuNoe6mS6oxzWIuiCdVJC44YCHzQUlUlai8ibz7ztos/6wKNRWlvuZVdrnWGxTccyVOKuSF7Vbm0KHlXXZSl8fy/wLCwrqXrPXeo+9XQuRs0Vxqg/PWj7cwfon7RdbioDHSnA1R7RAma1mND+w0f6hkxvD5S/M70Rum1/A9/t6oB4MMb1VNCIsfjCGyM9em/PxZUAniqDVpwLKP0njcn/yQ0zgYlTdYDT/tinc19Q3D7enH8CtGoKkedELj3tu6JYhFTAclwa/z//wRJNv5yBxR7cvRF29ZGYltEa6ANvObe+nPu5BSVwJWBDDS2r90ASmY9VHD7z+Gengqr4XXSec=
X-Forefront-Antispam-Report:
	CIP:217.66.60.4;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SR-MAIL-03.open-synergy.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(396003)(39840400004)(230922051799003)(1800799012)(186009)(64100799003)(82310400011)(451199024)(36840700001)(46966006)(41300700001)(1076003)(47076005)(921011)(83380400001)(336012)(40480700001)(966005)(2906002)(70586007)(70206006)(42186006)(316002)(478600001)(2616005)(26005)(36860700001)(86362001)(81166007)(110136005)(7416002)(30864003)(36756003)(5660300002)(4326008)(8676002)(8936002)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 13:10:47.2981
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5948090-1896-4fef-10eb-08dc104b3abc
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=800fae25-9b1b-4edc-993d-c939c4e84a64;Ip=[217.66.60.4];Helo=[SR-MAIL-03.open-synergy.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM6EUR05FT034.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEVP281MB3557
X-TM-AS-ERS: 104.47.7.169-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-28106.007
X-TMASE-Result: 10--18.345800-4.000000
X-TMASE-MatchedRID: jqlPWUYVHrUXGb5q45WScaWHGm239Fn1g8Gct9wEwAvrlkvw0pZ13IEu
	0/Z6z0OEohwx7eE+ixXaJrCAW8AFlE4Ywdn9L1FeMW8yzoMuP8Z4ZqfDdG89LisZXvcCxTRn30z
	/E8e/OqI7mVlacjgdS8JPw9PXFsaaSHL/AuXDoCt79AJyJfAb28cYejHW17ig7pj93msZ52E0B3
	gGQi7YxEtso+Tcc2HDj+KBRGz6oW/xD2T5lCnOaoiYtM5LMzdS+DE5zr5ahdzc7b6k5+X69zAsn
	09lQFCFrICz6b6B6MvEvmJn5M5RIdfSN/4na0Pw7mkXwgfniYyxfhoVgAwhg1aMDW2nugceqrPj
	ytLilDUbUyMHypcMbRHANFoXrZpZGp9d1uqXSnjBZoJuIJXoukiFscI0m1moVhKZogdsCNupaB8
	gxaWhLGod1dweE6KTSxlXpJq3UjP/G/yQFoCTIm3/26W8zRAxuZEyPAaUanKJXeoHaUjxA13WG5
	Zj0johrR51r1k973wGS81PHrAy/Nn+p9TpqzFoOTDDmuB9VXm7/BkSrGh1lgxMC1n35TFCjQBDb
	6+Vi9sVH0G2Q11HWZawkQ5fMOixKs7sSEN+w2IzUIiLiSu3pwWbP9hRrIxQ8AZW7+gNouwK9l7Z
	m9RxOGOQhw3ufhNCE9zq0DFHcJSjo44TjV7NaTBRS9ab1MHsSB85sZR0qdiLFiRhVZkcVfkG4SP
	4ltI7rkjuhfDVi7sDwKW/9I3enq3Yr8r50bfdQ/oBc6KOvLnvJH+Eu3XLaDLai1uomgFqeDAmjl
	AyxX2jxj+USeWICI3F8WiDWQM4AXh7Db4fRPaJ/JFAsRFjSkI9AEPfED/do4NJa7SjFsrqB8q0D
	tiGWu2bIS/HALlk/tHavvvzXHGtCyfpTyGFMTnxJqun3snzJQhrLH5KSJ0=
X-TMASE-XGENCLOUD: 508208f2-ddd9-4677-a08a-26797535f6c7-0-0-200-0
X-TM-Deliver-Signature: 77429170D317532D46DE32BFCDD214E7
X-TM-Addin-Auth: 43COw0pbHlGwEgXaKkWGuFDylo7zIFgyoH4tCNR/5yxNbXoi4HU3/Yyh7cz
	eW4qICMr8whNwaWMl2KSaYReDbB47n9XXRzDgmfvC54w1iZR9S6Q9KOyojH6jN+FnyNfCqMEZaL
	gf5N3ivaSKi/eAdopy2o6em3QArIGCMj3cNv5QHCc6VQmfjglB+rdQZg1xYCrDWXxtxRhk8Pb4+
	zLRGWQjp0PJ0IIA3KVRAsE68VQA/pbrlrWHWl4La7sj21LrChyfJOBTNQ0lIsUUTnH60pYmrG2e
	yDDmIOa4PQiD/zTqARkUX5stGx+Iok4Rd+m3.wuF8nY08VCLdorbFZwdqXRXWRaNvr35sEXwMYH
	SdqR66l/PDuqD9bIVQfNQroonqCEsL+W1aV7g5U3SX6s+rzQLFe7z3UyMuKXONkhGpXpvjOJksd
	ardL0myqFmwh6yxWtBAw/C1vC7NaDx33qf7E02oCkicWvCbsX1XP98gsXJnqJ44Gl/1Yqe97Nv9
	rBGRnAr30dG+9QGq3+iLVzDUNDO6DGNI+5E/1xghF1IZrdXYT4N9uiLDnQ4W89RnPz0ASIgz0xM
	vfvjBe9XwgH47NOJdPS6VoGb3Q49z8RP3goL2KIGaUHscqXVD3fFq8e4OLJrhqcPcS3RiG4vaa+
	2scQ==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
	s=TM-DKIM-20210503141657; t=1704719454;
	bh=IRrOLjyKS451BkVxxyJfHBcz1epNWq4Jat2x7NzuyYc=; l=36122;
	h=From:To:Date;
	b=yk+Gflt+vrHOari+fY2FWKxtr351Hrwcre/rAZ7H2HxlibYsWhdxG/dYsAR/EY80g
	 AY2f4mDtsa/6kNIOGkV6YwOGDMFPfL3YVMjMhKwPGCAmzYo4epDcs0loEF1ORF353c
	 iaAAdTJ6lNKCPnVRq2YtNppDDwQrRefEQ4DyavqFynlscbZudPlfJ1AQgqj2UCr+rn
	 A8qZMPIrw6UG5Me3qabwOJnt3oTCSoX1AXoTsQXOUMzE1am3VX3mWI8NSW09v80thd
	 1qx+Fz1b4PUlWp88Y3EApV8VQ2JPwi/B8Ys9xSgoiz/Ry/sXagY2P4AJutefvpDQA9
	 OHxF3+PEkweRw==

From: Harald Mommer <harald.mommer@opensynergy.com>

- CAN Control

  - "ip link set up can0" starts the virtual CAN controller,
  - "ip link set up can0" stops the virtual CAN controller

- CAN RX

  Receive CAN frames. CAN frames can be standard or extended, classic or
  CAN FD. Classic CAN RTR frames are supported.

- CAN TX

  Send CAN frames. CAN frames can be standard or extended, classic or
  CAN FD. Classic CAN RTR frames are supported.

- CAN BusOff indication

  CAN BusOff is handled by a bit in the configuration space.

Signed-off-by: Harald Mommer <Harald.Mommer@opensynergy.com>
Signed-off-by: Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com>
Co-developed-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Damir Shaikhutdinov <Damir.Shaikhutdinov@opensynergy.com>
---

V5:
* Re-base on top of linux-next (next-20240103)
* Tested with https://github.com/OpenSynergy/qemu/tree/virtio-can-spec-rfc-v3

RFC V4:
* Apply reverse Christmas tree style
* Add member *classic_dlc to RX and TX CAN frames
* Fix race causing a NETDEV_TX_BUSY return
* Fix TX queue going stuck on -ENOMEM
* Update stats.tx_dropped on kzalloc() failure
* Replace "(err != 0)" with "(unlikely(err))"
* Use "ARRAY_SIZE(sgs)"
* Refactor SGs in virtio_can_send_ctrl_msg()
* Tested with https://github.com/OpenSynergy/qemu/tree/virtio-can-spec-rfc-v3

RFC V3:
* Incorporate patch "[PATCH] can: virtio-can: cleanups" from
  https://lore.kernel.org/all/20230424-footwear-daily-9339bd0ec428-mkl@pengutronix.de/
* Add missing can_free_echo_skb()
* Replace home-brewed ID allocator with the standard one from kernel
* Simplify flow control
* Tested with https://github.com/OpenSynergy/qemu/tree/virtio-can-spec-rfc-v3

RFC V2:
* Remove the event indication queue and use the config space instead, to
  indicate a bus off condition
* Rework RX and TX messages having a length field and some more fields for CAN
  EXT
* Fix CAN_EFF_MASK comparison
* Remove MISRA style code (e.g. '! = 0u')
* Remove priorities leftovers
* Remove BUGONs
* Based on virtio can spec RFCv3
* Tested with https://github.com/OpenSynergy/qemu/tree/virtio-can-spec-rfc-v3


 MAINTAINERS                     |    7 +
 drivers/net/can/Kconfig         |   12 +
 drivers/net/can/Makefile        |    1 +
 drivers/net/can/virtio_can.c    | 1008 +++++++++++++++++++++++++++++++
 include/uapi/linux/virtio_can.h |   75 +++
 5 files changed, 1103 insertions(+)
 create mode 100644 drivers/net/can/virtio_can.c
 create mode 100644 include/uapi/linux/virtio_can.h

diff --git a/MAINTAINERS b/MAINTAINERS
index cef9597b90ac..d3892370db2b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23214,6 +23214,13 @@ F:	drivers/scsi/virtio_scsi.c
 F:	include/uapi/linux/virtio_blk.h
 F:	include/uapi/linux/virtio_scsi.h
 
+VIRTIO CAN DRIVER
+M:	"Harald Mommer" <harald.mommer@opensynergy.com>
+L:	linux-can@vger.kernel.org
+S:	Maintained
+F:	drivers/net/can/virtio_can.c
+F:	include/uapi/linux/virtio_can.h
+
 VIRTIO CONSOLE DRIVER
 M:	Amit Shah <amit@kernel.org>
 L:	virtualization@lists.linux.dev
diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
index eb410714afc2..f966bab19ed8 100644
--- a/drivers/net/can/Kconfig
+++ b/drivers/net/can/Kconfig
@@ -215,6 +215,18 @@ config CAN_XILINXCAN
 	  Xilinx CAN driver. This driver supports both soft AXI CAN IP and
 	  Zynq CANPS IP.
 
+config CAN_VIRTIO_CAN
+	depends on VIRTIO
+	tristate "Virtio CAN device support"
+	default n
+	help
+	  Say Y here if you want to support for Virtio CAN.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called virtio-can.
+
+	  If unsure, say N.
+
 source "drivers/net/can/c_can/Kconfig"
 source "drivers/net/can/cc770/Kconfig"
 source "drivers/net/can/ctucanfd/Kconfig"
diff --git a/drivers/net/can/Makefile b/drivers/net/can/Makefile
index ff8f76295d13..4488e591736e 100644
--- a/drivers/net/can/Makefile
+++ b/drivers/net/can/Makefile
@@ -30,6 +30,7 @@ obj-$(CONFIG_CAN_PEAK_PCIEFD)	+= peak_canfd/
 obj-$(CONFIG_CAN_SJA1000)	+= sja1000/
 obj-$(CONFIG_CAN_SUN4I)		+= sun4i_can.o
 obj-$(CONFIG_CAN_TI_HECC)	+= ti_hecc.o
+obj-$(CONFIG_CAN_VIRTIO_CAN)	+= virtio_can.o
 obj-$(CONFIG_CAN_XILINXCAN)	+= xilinx_can.o
 
 subdir-ccflags-$(CONFIG_CAN_DEBUG_DEVICES) += -DDEBUG
diff --git a/drivers/net/can/virtio_can.c b/drivers/net/can/virtio_can.c
new file mode 100644
index 000000000000..924a7c19e438
--- /dev/null
+++ b/drivers/net/can/virtio_can.c
@@ -0,0 +1,1008 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * CAN bus driver for the Virtio CAN controller
+ * Copyright (C) 2021-2023 OpenSynergy GmbH
+ */
+
+#include <linux/atomic.h>
+#include <linux/idr.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/netdevice.h>
+#include <linux/stddef.h>
+#include <linux/can/dev.h>
+#include <linux/virtio.h>
+#include <linux/virtio_ring.h>
+#include <linux/virtio_can.h>
+
+/* CAN device queues */
+#define VIRTIO_CAN_QUEUE_TX 0 /* Driver side view! The device receives here */
+#define VIRTIO_CAN_QUEUE_RX 1 /* Driver side view! The device transmits here */
+#define VIRTIO_CAN_QUEUE_CONTROL 2
+#define VIRTIO_CAN_QUEUE_COUNT 3
+
+#define CAN_KNOWN_FLAGS \
+	(VIRTIO_CAN_FLAGS_EXTENDED |\
+	 VIRTIO_CAN_FLAGS_FD |\
+	 VIRTIO_CAN_FLAGS_RTR)
+
+/* Max. number of in flight TX messages */
+#define VIRTIO_CAN_ECHO_SKB_MAX 128
+
+struct virtio_can_tx {
+	struct list_head list;
+	unsigned int putidx;
+	struct virtio_can_tx_out tx_out;
+	struct virtio_can_tx_in tx_in;
+};
+
+/* virtio_can private data structure */
+struct virtio_can_priv {
+	struct can_priv can;	/* must be the first member */
+	/* NAPI for RX messages */
+	struct napi_struct napi;
+	/* NAPI for TX messages */
+	struct napi_struct napi_tx;
+	/* The network device we're associated with */
+	struct net_device *dev;
+	/* The virtio device we're associated with */
+	struct virtio_device *vdev;
+	/* The virtqueues */
+	struct virtqueue *vqs[VIRTIO_CAN_QUEUE_COUNT];
+	/* I/O callback function pointers for the virtqueues */
+	vq_callback_t *io_callbacks[VIRTIO_CAN_QUEUE_COUNT];
+	/* Lock for TX operations */
+	spinlock_t tx_lock;
+	/* Control queue lock. Defensive programming, may be not needed */
+	struct mutex ctrl_lock;
+	/* Wait for control queue processing without polling */
+	struct completion ctrl_done;
+	/* List of virtio CAN TX message */
+	struct list_head tx_list;
+	/* Array of receive queue messages */
+	struct virtio_can_rx rpkt[128];
+	/* Those control queue messages cannot live on the stack! */
+	struct virtio_can_control_out cpkt_out;
+	struct virtio_can_control_in cpkt_in;
+	/* Data to get and maintain the putidx for local TX echo */
+	struct ida tx_putidx_ida;
+	/* In flight TX messages */
+	atomic_t tx_inflight;
+	/* BusOff pending. Reset after successful indication to upper layer */
+	bool busoff_pending;
+};
+
+/* Function copied from virtio_net.c */
+static void virtqueue_napi_schedule(struct napi_struct *napi,
+				    struct virtqueue *vq)
+{
+	if (napi_schedule_prep(napi)) {
+		virtqueue_disable_cb(vq);
+		__napi_schedule(napi);
+	}
+}
+
+/* Function copied from virtio_net.c */
+static void virtqueue_napi_complete(struct napi_struct *napi,
+				    struct virtqueue *vq, int processed)
+{
+	int opaque;
+
+	opaque = virtqueue_enable_cb_prepare(vq);
+	if (napi_complete_done(napi, processed)) {
+		if (unlikely(virtqueue_poll(vq, opaque)))
+			virtqueue_napi_schedule(napi, vq);
+	} else {
+		virtqueue_disable_cb(vq);
+	}
+}
+
+static void virtio_can_free_candev(struct net_device *ndev)
+{
+	struct virtio_can_priv *priv = netdev_priv(ndev);
+
+	ida_destroy(&priv->tx_putidx_ida);
+	free_candev(ndev);
+}
+
+static int virtio_can_alloc_tx_idx(struct virtio_can_priv *priv)
+{
+	int tx_idx;
+
+	tx_idx = ida_alloc_range(&priv->tx_putidx_ida, 0,
+				 priv->can.echo_skb_max - 1, GFP_KERNEL);
+	if (tx_idx >= 0)
+		atomic_add(1, &priv->tx_inflight);
+
+	return tx_idx;
+}
+
+static void virtio_can_free_tx_idx(struct virtio_can_priv *priv,
+				   unsigned int idx)
+{
+	ida_free(&priv->tx_putidx_ida, idx);
+	atomic_sub(1, &priv->tx_inflight);
+}
+
+/* Create a scatter-gather list representing our input buffer and put
+ * it in the queue.
+ *
+ * Callers should take appropriate locks.
+ */
+static int virtio_can_add_inbuf(struct virtqueue *vq, void *buf,
+				unsigned int size)
+{
+	struct scatterlist sg[1];
+	int ret;
+
+	sg_init_one(sg, buf, size);
+
+	ret = virtqueue_add_inbuf(vq, sg, 1, buf, GFP_ATOMIC);
+	virtqueue_kick(vq);
+	if (ret == 0)
+		ret = vq->num_free;
+	return ret;
+}
+
+/* Send a control message with message type either
+ *
+ * - VIRTIO_CAN_SET_CTRL_MODE_START or
+ * - VIRTIO_CAN_SET_CTRL_MODE_STOP.
+ *
+ * Unlike AUTOSAR CAN Driver Can_SetControllerMode() there is no requirement
+ * for this Linux driver to have an asynchronous implementation of the mode
+ * setting function so in order to keep things simple the function is
+ * implemented as synchronous function. Design pattern is
+ * virtio_console.c/__send_control_msg() & virtio_net.c/virtnet_send_command().
+ */
+static u8 virtio_can_send_ctrl_msg(struct net_device *ndev, u16 msg_type)
+{
+	struct scatterlist sg_out, sg_in, *sgs[2] = { &sg_out, &sg_in };
+	struct virtio_can_priv *priv = netdev_priv(ndev);
+	struct device *dev = &priv->vdev->dev;
+	struct virtqueue *vq;
+	unsigned int len;
+	int err;
+
+	vq = priv->vqs[VIRTIO_CAN_QUEUE_CONTROL];
+
+	/* The function may be serialized by rtnl lock. Not sure.
+	 * Better safe than sorry.
+	 */
+	mutex_lock(&priv->ctrl_lock);
+
+	priv->cpkt_out.msg_type = cpu_to_le16(msg_type);
+	sg_init_one(&sg_out, &priv->cpkt_out, sizeof(priv->cpkt_out));
+	sg_init_one(&sg_in, &priv->cpkt_in, sizeof(priv->cpkt_in));
+
+	err = virtqueue_add_sgs(vq, sgs, 1u, 1u, priv, GFP_ATOMIC);
+	if (err != 0) {
+		/* Not expected to happen */
+		dev_err(dev, "%s(): virtqueue_add_sgs() failed\n", __func__);
+	}
+
+	if (!virtqueue_kick(vq)) {
+		/* Not expected to happen */
+		dev_err(dev, "%s(): Kick failed\n", __func__);
+	}
+
+	while (!virtqueue_get_buf(vq, &len) && !virtqueue_is_broken(vq))
+		wait_for_completion(&priv->ctrl_done);
+
+	mutex_unlock(&priv->ctrl_lock);
+
+	return priv->cpkt_in.result;
+}
+
+static void virtio_can_start(struct net_device *ndev)
+{
+	struct virtio_can_priv *priv = netdev_priv(ndev);
+	u8 result;
+
+	result = virtio_can_send_ctrl_msg(ndev, VIRTIO_CAN_SET_CTRL_MODE_START);
+	if (result != VIRTIO_CAN_RESULT_OK) {
+		/* Not expected to happen */
+		netdev_err(ndev, "CAN controller start failed\n");
+	}
+
+	priv->busoff_pending = false;
+	priv->can.state = CAN_STATE_ERROR_ACTIVE;
+
+	/* Switch carrier on if device was not connected to the bus */
+	if (!netif_carrier_ok(ndev))
+		netif_carrier_on(ndev);
+}
+
+/* See also m_can.c/m_can_set_mode()
+ *
+ * It is interesting that not only the M-CAN implementation but also all other
+ * implementations I looked into only support CAN_MODE_START.
+ * That CAN_MODE_SLEEP is frequently not found to be supported anywhere did not
+ * come not as surprise but that CAN_MODE_STOP is also never supported was one.
+ * The function is accessible via the method pointer do_set_mode in
+ * struct can_priv. As usual no documentation there.
+ * May not play any role as grepping through the code did not reveal any place
+ * from where the method is actually called.
+ */
+static int virtio_can_set_mode(struct net_device *dev, enum can_mode mode)
+{
+	switch (mode) {
+	case CAN_MODE_START:
+		virtio_can_start(dev);
+		netif_wake_queue(dev);
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+/* Called by issuing "ip link set up can0" */
+static int virtio_can_open(struct net_device *dev)
+{
+	/* start the virtio_can controller */
+	virtio_can_start(dev);
+
+	/* RX and TX napi were already enabled in virtio_can_probe() */
+	netif_start_queue(dev);
+
+	return 0;
+}
+
+static void virtio_can_stop(struct net_device *ndev)
+{
+	struct virtio_can_priv *priv = netdev_priv(ndev);
+	struct device *dev = &priv->vdev->dev;
+	u8 result;
+
+	result = virtio_can_send_ctrl_msg(ndev, VIRTIO_CAN_SET_CTRL_MODE_STOP);
+	if (result != VIRTIO_CAN_RESULT_OK)
+		dev_err(dev, "CAN controller stop failed\n");
+
+	priv->busoff_pending = false;
+	priv->can.state = CAN_STATE_STOPPED;
+
+	/* Switch carrier off if device was connected to the bus */
+	if (netif_carrier_ok(ndev))
+		netif_carrier_off(ndev);
+}
+
+static int virtio_can_close(struct net_device *dev)
+{
+	netif_stop_queue(dev);
+	/* Keep RX napi active to allow dropping of pending RX CAN messages,
+	 * keep TX napi active to allow processing of cancelled CAN messages
+	 */
+	virtio_can_stop(dev);
+	close_candev(dev);
+
+	return 0;
+}
+
+static netdev_tx_t virtio_can_start_xmit(struct sk_buff *skb,
+					 struct net_device *dev)
+{
+	const unsigned int hdr_size = offsetof(struct virtio_can_tx_out, sdu);
+	struct scatterlist sg_out, sg_in, *sgs[2] = { &sg_out, &sg_in };
+	struct canfd_frame *cf = (struct canfd_frame *)skb->data;
+	struct virtio_can_priv *priv = netdev_priv(dev);
+	netdev_tx_t xmit_ret = NETDEV_TX_OK;
+	struct virtio_can_tx *can_tx_msg;
+	struct virtqueue *vq;
+	unsigned long flags;
+	u32 can_flags;
+	int putidx;
+	int err;
+
+	vq = priv->vqs[VIRTIO_CAN_QUEUE_TX];
+
+	if (can_dev_dropped_skb(dev, skb))
+		goto kick; /* No way to return NET_XMIT_DROP here */
+
+	/* No local check for CAN_RTR_FLAG or FD frame against negotiated
+	 * features. The device will reject those anyway if not supported.
+	 */
+
+	can_tx_msg = kzalloc(sizeof(*can_tx_msg), GFP_ATOMIC);
+	if (!can_tx_msg) {
+		dev->stats.tx_dropped++;
+		goto kick; /* No way to return NET_XMIT_DROP here */
+	}
+
+	can_tx_msg->tx_out.msg_type = cpu_to_le16(VIRTIO_CAN_TX);
+	can_flags = 0;
+
+	if (cf->can_id & CAN_EFF_FLAG) {
+		can_flags |= VIRTIO_CAN_FLAGS_EXTENDED;
+		can_tx_msg->tx_out.can_id = cpu_to_le32(cf->can_id & CAN_EFF_MASK);
+	} else {
+		can_tx_msg->tx_out.can_id = cpu_to_le32(cf->can_id & CAN_SFF_MASK);
+	}
+	if (cf->can_id & CAN_RTR_FLAG)
+		can_flags |= VIRTIO_CAN_FLAGS_RTR;
+	else
+		memcpy(can_tx_msg->tx_out.sdu, cf->data, cf->len);
+	if (can_is_canfd_skb(skb))
+		can_flags |= VIRTIO_CAN_FLAGS_FD;
+
+	can_tx_msg->tx_out.flags = cpu_to_le32(can_flags);
+	can_tx_msg->tx_out.length = cpu_to_le16(cf->len);
+
+	/* Prepare sending of virtio message */
+	sg_init_one(&sg_out, &can_tx_msg->tx_out, hdr_size + cf->len);
+	sg_init_one(&sg_in, &can_tx_msg->tx_in, sizeof(can_tx_msg->tx_in));
+
+	putidx = virtio_can_alloc_tx_idx(priv);
+
+	if (unlikely(putidx < 0)) {
+		/* -ENOMEM or -ENOSPC here. -ENOSPC should not be possible as
+		 * tx_inflight >= can.echo_skb_max is checked in flow control
+		 */
+		WARN_ON_ONCE(putidx == -ENOSPC);
+		kfree(can_tx_msg);
+		dev->stats.tx_dropped++;
+		goto kick; /* No way to return NET_XMIT_DROP here */
+	}
+
+	can_tx_msg->putidx = (unsigned int)putidx;
+
+	/* Protect list operation */
+	spin_lock_irqsave(&priv->tx_lock, flags);
+	list_add_tail(&can_tx_msg->list, &priv->tx_list);
+	spin_unlock_irqrestore(&priv->tx_lock, flags);
+
+	/* Push loopback echo. Will be looped back on TX interrupt/TX NAPI */
+	can_put_echo_skb(skb, dev, can_tx_msg->putidx, 0);
+
+	/* Protect queue and list operations */
+	spin_lock_irqsave(&priv->tx_lock, flags);
+	err = virtqueue_add_sgs(vq, sgs, 1u, 1u, can_tx_msg, GFP_ATOMIC);
+	if (unlikely(err)) { /* checking vq->num_free in flow control */
+		list_del(&can_tx_msg->list);
+		can_free_echo_skb(dev, can_tx_msg->putidx, NULL);
+		virtio_can_free_tx_idx(priv, can_tx_msg->putidx);
+		spin_unlock_irqrestore(&priv->tx_lock, flags);
+		netif_stop_queue(dev);
+		kfree(can_tx_msg);
+		/* Expected never to be seen */
+		netdev_warn(dev, "TX: Stop queue, err = %d\n", err);
+		xmit_ret = NETDEV_TX_BUSY;
+		goto kick;
+	}
+
+	/* Normal flow control: stop queue when no transmission slots left */
+	if (atomic_read(&priv->tx_inflight) >= priv->can.echo_skb_max ||
+	    vq->num_free == 0 || (vq->num_free < ARRAY_SIZE(sgs) &&
+	    !virtio_has_feature(vq->vdev, VIRTIO_RING_F_INDIRECT_DESC))) {
+		netif_stop_queue(dev);
+		netdev_dbg(dev, "TX: Normal stop queue\n");
+	}
+
+	spin_unlock_irqrestore(&priv->tx_lock, flags);
+
+kick:
+	if (netif_queue_stopped(dev) || !netdev_xmit_more()) {
+		if (!virtqueue_kick(vq))
+			netdev_err(dev, "%s(): Kick failed\n", __func__);
+	}
+
+	return xmit_ret;
+}
+
+static const struct net_device_ops virtio_can_netdev_ops = {
+	.ndo_open = virtio_can_open,
+	.ndo_stop = virtio_can_close,
+	.ndo_start_xmit = virtio_can_start_xmit,
+	.ndo_change_mtu = can_change_mtu,
+};
+
+static int register_virtio_can_dev(struct net_device *dev)
+{
+	dev->flags |= IFF_ECHO;	/* we support local echo */
+	dev->netdev_ops = &virtio_can_netdev_ops;
+
+	return register_candev(dev);
+}
+
+/* Compare with m_can.c/m_can_echo_tx_event() */
+static int virtio_can_read_tx_queue(struct virtqueue *vq)
+{
+	struct virtio_can_priv *can_priv = vq->vdev->priv;
+	struct net_device *dev = can_priv->dev;
+	struct virtio_can_tx *can_tx_msg;
+	struct net_device_stats *stats;
+	unsigned long flags;
+	unsigned int len;
+	u8 result;
+
+	stats = &dev->stats;
+
+	/* Protect list and virtio queue operations */
+	spin_lock_irqsave(&can_priv->tx_lock, flags);
+
+	can_tx_msg = virtqueue_get_buf(vq, &len);
+	if (!can_tx_msg) {
+		spin_unlock_irqrestore(&can_priv->tx_lock, flags);
+		return 0; /* No more data */
+	}
+
+	if (unlikely(len < sizeof(struct virtio_can_tx_in))) {
+		netdev_err(dev, "TX ACK: Device sent no result code\n");
+		result = VIRTIO_CAN_RESULT_NOT_OK; /* Keep things going */
+	} else {
+		result = can_tx_msg->tx_in.result;
+	}
+
+	if (can_priv->can.state < CAN_STATE_BUS_OFF) {
+		/* Here also frames with result != VIRTIO_CAN_RESULT_OK are
+		 * echoed. Intentional to bring a waiting process in an upper
+		 * layer to an end.
+		 * TODO: Any better means to indicate a problem here?
+		 */
+		if (result != VIRTIO_CAN_RESULT_OK)
+			netdev_warn(dev, "TX ACK: Result = %u\n", result);
+
+		stats->tx_bytes += can_get_echo_skb(dev, can_tx_msg->putidx,
+						    NULL);
+		stats->tx_packets++;
+	} else {
+		netdev_dbg(dev, "TX ACK: Controller inactive, drop echo\n");
+		can_free_echo_skb(dev, can_tx_msg->putidx, NULL);
+	}
+
+	list_del(&can_tx_msg->list);
+	virtio_can_free_tx_idx(can_priv, can_tx_msg->putidx);
+
+	/* Flow control */
+	if (netif_queue_stopped(dev)) {
+		netdev_dbg(dev, "TX ACK: Wake up stopped queue\n");
+		netif_wake_queue(dev);
+	}
+
+	spin_unlock_irqrestore(&can_priv->tx_lock, flags);
+
+	kfree(can_tx_msg);
+
+	return 1; /* Queue was not empty so there may be more data */
+}
+
+/* Poll TX used queue for sent CAN messages
+ * See https://wiki.linuxfoundation.org/networking/napi function
+ * int (*poll)(struct napi_struct *napi, int budget);
+ */
+static int virtio_can_tx_poll(struct napi_struct *napi, int quota)
+{
+	struct net_device *dev = napi->dev;
+	struct virtio_can_priv *priv;
+	struct virtqueue *vq;
+	int work_done = 0;
+
+	priv = netdev_priv(dev);
+	vq = priv->vqs[VIRTIO_CAN_QUEUE_TX];
+
+	while (work_done < quota && virtio_can_read_tx_queue(vq) != 0)
+		work_done++;
+
+	if (work_done < quota)
+		virtqueue_napi_complete(napi, vq, work_done);
+
+	return work_done;
+}
+
+static void virtio_can_tx_intr(struct virtqueue *vq)
+{
+	struct virtio_can_priv *can_priv = vq->vdev->priv;
+
+	virtqueue_disable_cb(vq);
+	napi_schedule(&can_priv->napi_tx);
+}
+
+/* This function is the NAPI RX poll function and NAPI guarantees that this
+ * function is not invoked simultaneously on multiple processors.
+ * Read a RX message from the used queue and sends it to the upper layer.
+ * (See also m_can.c / m_can_read_fifo()).
+ */
+static int virtio_can_read_rx_queue(struct virtqueue *vq)
+{
+	const unsigned int header_size = offsetof(struct virtio_can_rx, sdu);
+	struct virtio_can_priv *priv = vq->vdev->priv;
+	struct net_device *dev = priv->dev;
+	struct net_device_stats *stats;
+	struct virtio_can_rx *can_rx;
+	unsigned int transport_len;
+	struct canfd_frame *cf;
+	struct sk_buff *skb;
+	unsigned int len;
+	u32 can_flags;
+	u16 msg_type;
+	u32 can_id;
+
+	stats = &dev->stats;
+
+	can_rx = virtqueue_get_buf(vq, &transport_len);
+	if (!can_rx)
+		return 0; /* No more data */
+
+	if (transport_len < header_size) {
+		netdev_warn(dev, "RX: Message too small\n");
+		goto putback;
+	}
+
+	if (priv->can.state >= CAN_STATE_ERROR_PASSIVE) {
+		netdev_dbg(dev, "%s(): Controller not active\n", __func__);
+		goto putback;
+	}
+
+	msg_type = le16_to_cpu(can_rx->msg_type);
+	if (msg_type != VIRTIO_CAN_RX) {
+		netdev_warn(dev, "RX: Got unknown msg_type %04x\n", msg_type);
+		goto putback;
+	}
+
+	len = le16_to_cpu(can_rx->length);
+	can_flags = le32_to_cpu(can_rx->flags);
+	can_id = le32_to_cpu(can_rx->can_id);
+
+	if (can_flags & ~CAN_KNOWN_FLAGS) {
+		stats->rx_dropped++;
+		netdev_warn(dev, "RX: CAN Id 0x%08x: Invalid flags 0x%x\n",
+			    can_id, can_flags);
+		goto putback;
+	}
+
+	if (can_flags & VIRTIO_CAN_FLAGS_EXTENDED) {
+		can_id &= CAN_EFF_MASK;
+		can_id |= CAN_EFF_FLAG;
+	} else {
+		can_id &= CAN_SFF_MASK;
+	}
+
+	if (can_flags & VIRTIO_CAN_FLAGS_RTR) {
+		if (!virtio_has_feature(vq->vdev, VIRTIO_CAN_F_RTR_FRAMES)) {
+			stats->rx_dropped++;
+			netdev_warn(dev, "RX: CAN Id 0x%08x: RTR not negotiated\n",
+				    can_id);
+			goto putback;
+		}
+		if (can_flags & VIRTIO_CAN_FLAGS_FD) {
+			stats->rx_dropped++;
+			netdev_warn(dev, "RX: CAN Id 0x%08x: RTR with FD not possible\n",
+				    can_id);
+			goto putback;
+		}
+
+		if (len > 0xF) {
+			stats->rx_dropped++;
+			netdev_warn(dev, "RX: CAN Id 0x%08x: RTR with DLC > 0xF\n",
+				    can_id);
+			goto putback;
+		}
+
+		if (len > 0x8)
+			len = 0x8;
+
+		can_id |= CAN_RTR_FLAG;
+	}
+
+	if (transport_len < header_size + len) {
+		netdev_warn(dev, "RX: Message too small for payload\n");
+		goto putback;
+	}
+
+	if (can_flags & VIRTIO_CAN_FLAGS_FD) {
+		if (!virtio_has_feature(vq->vdev, VIRTIO_CAN_F_CAN_FD)) {
+			stats->rx_dropped++;
+			netdev_warn(dev, "RX: CAN Id 0x%08x: FD not negotiated\n",
+				    can_id);
+			goto putback;
+		}
+
+		if (len > CANFD_MAX_DLEN)
+			len = CANFD_MAX_DLEN;
+
+		skb = alloc_canfd_skb(priv->dev, &cf);
+	} else {
+		if (!virtio_has_feature(vq->vdev, VIRTIO_CAN_F_CAN_CLASSIC)) {
+			stats->rx_dropped++;
+			netdev_warn(dev, "RX: CAN Id 0x%08x: classic not negotiated\n",
+				    can_id);
+			goto putback;
+		}
+
+		if (len > CAN_MAX_DLEN)
+			len = CAN_MAX_DLEN;
+
+		skb = alloc_can_skb(priv->dev, (struct can_frame **)&cf);
+	}
+	if (!skb) {
+		stats->rx_dropped++;
+		netdev_warn(dev, "RX: No skb available\n");
+		goto putback;
+	}
+
+	cf->can_id = can_id;
+	cf->len = len;
+	if (!(can_flags & VIRTIO_CAN_FLAGS_RTR)) {
+		/* RTR frames have a DLC but no payload */
+		memcpy(cf->data, can_rx->sdu, len);
+	}
+
+	if (netif_receive_skb(skb) == NET_RX_SUCCESS) {
+		stats->rx_packets++;
+		if (!(can_flags & VIRTIO_CAN_FLAGS_RTR))
+			stats->rx_bytes += cf->len;
+	}
+
+putback:
+	/* Put processed RX buffer back into avail queue */
+	virtio_can_add_inbuf(vq, can_rx, sizeof(struct virtio_can_rx));
+
+	return 1; /* Queue was not empty so there may be more data */
+}
+
+/* See m_can_poll() / m_can_handle_state_errors() m_can_handle_state_change() */
+static int virtio_can_handle_busoff(struct net_device *dev)
+{
+	struct virtio_can_priv *priv = netdev_priv(dev);
+	struct can_frame *cf;
+	struct sk_buff *skb;
+
+	if (!priv->busoff_pending)
+		return 0;
+
+	if (priv->can.state < CAN_STATE_BUS_OFF) {
+		netdev_dbg(dev, "entered error bus off state\n");
+
+		/* bus-off state */
+		priv->can.state = CAN_STATE_BUS_OFF;
+		priv->can.can_stats.bus_off++;
+		can_bus_off(dev);
+	}
+
+	/* propagate the error condition to the CAN stack */
+	skb = alloc_can_err_skb(dev, &cf);
+	if (unlikely(!skb))
+		return 0;
+
+	/* bus-off state */
+	cf->can_id |= CAN_ERR_BUSOFF;
+
+	/* Ensure that the BusOff indication does not get lost */
+	if (netif_receive_skb(skb) == NET_RX_SUCCESS)
+		priv->busoff_pending = false;
+
+	return 1;
+}
+
+/* Poll RX used queue for received CAN messages
+ * See https://wiki.linuxfoundation.org/networking/napi function
+ * int (*poll)(struct napi_struct *napi, int budget);
+ * Important: "The networking subsystem promises that poll() will not be
+ * invoked simultaneously (for the same napi_struct) on multiple processors"
+ */
+static int virtio_can_rx_poll(struct napi_struct *napi, int quota)
+{
+	struct net_device *dev = napi->dev;
+	struct virtio_can_priv *priv;
+	struct virtqueue *vq;
+	int work_done = 0;
+
+	priv = netdev_priv(dev);
+	vq = priv->vqs[VIRTIO_CAN_QUEUE_RX];
+
+	work_done += virtio_can_handle_busoff(dev);
+
+	while (work_done < quota && virtio_can_read_rx_queue(vq) != 0)
+		work_done++;
+
+	if (work_done < quota)
+		virtqueue_napi_complete(napi, vq, work_done);
+
+	return work_done;
+}
+
+static void virtio_can_rx_intr(struct virtqueue *vq)
+{
+	struct virtio_can_priv *can_priv = vq->vdev->priv;
+
+	virtqueue_disable_cb(vq);
+	napi_schedule(&can_priv->napi);
+}
+
+static void virtio_can_control_intr(struct virtqueue *vq)
+{
+	struct virtio_can_priv *can_priv = vq->vdev->priv;
+
+	complete(&can_priv->ctrl_done);
+}
+
+static void virtio_can_config_changed(struct virtio_device *vdev)
+{
+	struct virtio_can_priv *can_priv = vdev->priv;
+	u16 status;
+
+	status = virtio_cread16(vdev, offsetof(struct virtio_can_config,
+					       status));
+
+	if (!(status & VIRTIO_CAN_S_CTRL_BUSOFF))
+		return;
+
+	if (!can_priv->busoff_pending &&
+	    can_priv->can.state < CAN_STATE_BUS_OFF) {
+		can_priv->busoff_pending = true;
+		napi_schedule(&can_priv->napi);
+	}
+}
+
+static void virtio_can_populate_vqs(struct virtio_device *vdev)
+
+{
+	struct virtio_can_priv *priv = vdev->priv;
+	struct virtqueue *vq;
+	unsigned int idx;
+	int ret;
+
+	/* Fill RX queue */
+	vq = priv->vqs[VIRTIO_CAN_QUEUE_RX];
+	for (idx = 0; idx < ARRAY_SIZE(priv->rpkt); idx++) {
+		ret = virtio_can_add_inbuf(vq, &priv->rpkt[idx],
+					   sizeof(struct virtio_can_rx));
+		if (ret < 0) {
+			dev_dbg(&vdev->dev, "rpkt fill: ret=%d, idx=%u\n",
+				ret, idx);
+			break;
+		}
+	}
+	dev_dbg(&vdev->dev, "%u rpkt added\n", idx);
+}
+
+static int virtio_can_find_vqs(struct virtio_can_priv *priv)
+{
+	/* The order of RX and TX is exactly the opposite as in console and
+	 * network. Does not play any role but is a bad trap.
+	 */
+	static const char * const io_names[VIRTIO_CAN_QUEUE_COUNT] = {
+		"can-tx",
+		"can-rx",
+		"can-state-ctrl"
+	};
+
+	priv->io_callbacks[VIRTIO_CAN_QUEUE_TX] = virtio_can_tx_intr;
+	priv->io_callbacks[VIRTIO_CAN_QUEUE_RX] = virtio_can_rx_intr;
+	priv->io_callbacks[VIRTIO_CAN_QUEUE_CONTROL] = virtio_can_control_intr;
+
+	/* Find the queues. */
+	return virtio_find_vqs(priv->vdev, VIRTIO_CAN_QUEUE_COUNT, priv->vqs,
+			       priv->io_callbacks, io_names, NULL);
+}
+
+/* Function must not be called before virtio_can_find_vqs() has been run */
+static void virtio_can_del_vq(struct virtio_device *vdev)
+{
+	struct virtio_can_priv *priv = vdev->priv;
+	struct list_head *cursor, *next;
+	struct virtqueue *vq;
+
+	/* Reset the device */
+	if (vdev->config->reset)
+		vdev->config->reset(vdev);
+
+	/* From here we have dead silence from the device side so no locks
+	 * are needed to protect against device side events.
+	 */
+
+	vq = priv->vqs[VIRTIO_CAN_QUEUE_CONTROL];
+	while (virtqueue_detach_unused_buf(vq))
+		; /* Do nothing, content allocated statically */
+
+	vq = priv->vqs[VIRTIO_CAN_QUEUE_RX];
+	while (virtqueue_detach_unused_buf(vq))
+		; /* Do nothing, content allocated statically */
+
+	vq = priv->vqs[VIRTIO_CAN_QUEUE_TX];
+	while (virtqueue_detach_unused_buf(vq))
+		; /* Do nothing, content to be de-allocated separately */
+
+	/* Is keeping track of allocated elements by an own linked list
+	 * really necessary or may this be optimized using only
+	 * virtqueue_detach_unused_buf()?
+	 */
+	list_for_each_safe(cursor, next, &priv->tx_list) {
+		struct virtio_can_tx *can_tx;
+
+		can_tx = list_entry(cursor, struct virtio_can_tx, list);
+		list_del(cursor);
+		kfree(can_tx);
+	}
+
+	if (vdev->config->del_vqs)
+		vdev->config->del_vqs(vdev);
+}
+
+/* See virtio_net.c/virtnet_remove() and also m_can.c/m_can_plat_remove() */
+static void virtio_can_remove(struct virtio_device *vdev)
+{
+	struct virtio_can_priv *priv = vdev->priv;
+	struct net_device *dev = priv->dev;
+
+	unregister_candev(dev);
+
+	/* No calls of netif_napi_del() needed as free_candev() will do this */
+
+	virtio_can_del_vq(vdev);
+
+	virtio_can_free_candev(dev);
+}
+
+static int virtio_can_validate(struct virtio_device *vdev)
+{
+	/* CAN needs always access to the config space.
+	 * Check that the driver can access the config space
+	 */
+	if (!vdev->config->get) {
+		dev_err(&vdev->dev, "%s failure: config access disabled\n",
+			__func__);
+		return -EINVAL;
+	}
+
+	if (!virtio_has_feature(vdev, VIRTIO_F_VERSION_1)) {
+		dev_err(&vdev->dev,
+			"device does not comply with spec version 1.x\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int virtio_can_probe(struct virtio_device *vdev)
+{
+	struct virtio_can_priv *priv;
+	struct net_device *dev;
+	int err;
+
+	dev = alloc_candev(sizeof(struct virtio_can_priv),
+			   VIRTIO_CAN_ECHO_SKB_MAX);
+	if (!dev)
+		return -ENOMEM;
+
+	priv = netdev_priv(dev);
+
+	ida_init(&priv->tx_putidx_ida);
+
+	netif_napi_add(dev, &priv->napi, virtio_can_rx_poll);
+	netif_napi_add(dev, &priv->napi_tx, virtio_can_tx_poll);
+
+	SET_NETDEV_DEV(dev, &vdev->dev);
+
+	priv->dev = dev;
+	priv->vdev = vdev;
+	vdev->priv = priv;
+
+	priv->can.do_set_mode = virtio_can_set_mode;
+	/* Set Virtio CAN supported operations */
+	priv->can.ctrlmode_supported = CAN_CTRLMODE_BERR_REPORTING;
+	if (virtio_has_feature(vdev, VIRTIO_CAN_F_CAN_FD)) {
+		err = can_set_static_ctrlmode(dev, CAN_CTRLMODE_FD);
+		if (err != 0)
+			goto on_failure;
+	}
+
+	/* Initialize virtqueues */
+	err = virtio_can_find_vqs(priv);
+	if (err != 0)
+		goto on_failure;
+
+	INIT_LIST_HEAD(&priv->tx_list);
+
+	spin_lock_init(&priv->tx_lock);
+	mutex_init(&priv->ctrl_lock);
+
+	init_completion(&priv->ctrl_done);
+
+	virtio_can_populate_vqs(vdev);
+
+	register_virtio_can_dev(dev);
+
+	napi_enable(&priv->napi);
+	napi_enable(&priv->napi_tx);
+
+	/* Request device going live */
+	virtio_device_ready(vdev); /* Optionally done by virtio_dev_probe() */
+
+	return 0;
+
+on_failure:
+	virtio_can_free_candev(dev);
+	return err;
+}
+
+/* Compare with m_can.c/m_can_suspend(), virtio_net.c/virtnet_freeze() and
+ * virtio_card.c/virtsnd_freeze()
+ */
+static int __maybe_unused virtio_can_freeze(struct virtio_device *vdev)
+{
+	struct virtio_can_priv *priv = vdev->priv;
+	struct net_device *ndev = priv->dev;
+
+	napi_disable(&priv->napi);
+	napi_disable(&priv->napi_tx);
+
+	if (netif_running(ndev)) {
+		netif_stop_queue(ndev);
+		netif_device_detach(ndev);
+		virtio_can_stop(ndev);
+	}
+
+	priv->can.state = CAN_STATE_SLEEPING;
+
+	virtio_can_del_vq(vdev);
+
+	return 0;
+}
+
+/* Compare with m_can.c/m_can_resume(), virtio_net.c/virtnet_restore() and
+ * virtio_card.c/virtsnd_restore()
+ */
+static int __maybe_unused virtio_can_restore(struct virtio_device *vdev)
+{
+	struct virtio_can_priv *priv = vdev->priv;
+	struct net_device *ndev = priv->dev;
+	int err;
+
+	err = virtio_can_find_vqs(priv);
+	if (err != 0)
+		return err;
+	virtio_can_populate_vqs(vdev);
+
+	priv->can.state = CAN_STATE_ERROR_ACTIVE;
+
+	if (netif_running(ndev)) {
+		virtio_can_start(ndev);
+		netif_device_attach(ndev);
+		netif_start_queue(ndev);
+	}
+
+	napi_enable(&priv->napi);
+	napi_enable(&priv->napi_tx);
+
+	return 0;
+}
+
+static struct virtio_device_id virtio_can_id_table[] = {
+	{ VIRTIO_ID_CAN, VIRTIO_DEV_ANY_ID },
+	{ 0 },
+};
+
+static unsigned int features[] = {
+	VIRTIO_CAN_F_CAN_CLASSIC,
+	VIRTIO_CAN_F_CAN_FD,
+	VIRTIO_CAN_F_LATE_TX_ACK,
+	VIRTIO_CAN_F_RTR_FRAMES,
+};
+
+static struct virtio_driver virtio_can_driver = {
+	.feature_table = features,
+	.feature_table_size = ARRAY_SIZE(features),
+	.driver.name = KBUILD_MODNAME,
+	.driver.owner = THIS_MODULE,
+	.id_table = virtio_can_id_table,
+	.validate = virtio_can_validate,
+	.probe = virtio_can_probe,
+	.remove = virtio_can_remove,
+	.config_changed = virtio_can_config_changed,
+#ifdef CONFIG_PM_SLEEP
+	.freeze = virtio_can_freeze,
+	.restore = virtio_can_restore,
+#endif
+};
+
+module_virtio_driver(virtio_can_driver);
+MODULE_DEVICE_TABLE(virtio, virtio_can_id_table);
+
+MODULE_AUTHOR("OpenSynergy GmbH");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("CAN bus driver for Virtio CAN controller");
diff --git a/include/uapi/linux/virtio_can.h b/include/uapi/linux/virtio_can.h
new file mode 100644
index 000000000000..7cf613bb3f1a
--- /dev/null
+++ b/include/uapi/linux/virtio_can.h
@@ -0,0 +1,75 @@
+/* SPDX-License-Identifier: BSD-3-Clause */
+/*
+ * Copyright (C) 2021-2023 OpenSynergy GmbH
+ */
+#ifndef _LINUX_VIRTIO_VIRTIO_CAN_H
+#define _LINUX_VIRTIO_VIRTIO_CAN_H
+
+#include <linux/types.h>
+#include <linux/virtio_types.h>
+#include <linux/virtio_ids.h>
+#include <linux/virtio_config.h>
+
+/* Feature bit numbers */
+#define VIRTIO_CAN_F_CAN_CLASSIC        0
+#define VIRTIO_CAN_F_CAN_FD             1
+#define VIRTIO_CAN_F_LATE_TX_ACK        2
+#define VIRTIO_CAN_F_RTR_FRAMES         3
+
+/* CAN Result Types */
+#define VIRTIO_CAN_RESULT_OK            0
+#define VIRTIO_CAN_RESULT_NOT_OK        1
+
+/* CAN flags to determine type of CAN Id */
+#define VIRTIO_CAN_FLAGS_EXTENDED       0x8000
+#define VIRTIO_CAN_FLAGS_FD             0x4000
+#define VIRTIO_CAN_FLAGS_RTR            0x2000
+
+struct virtio_can_config {
+#define VIRTIO_CAN_S_CTRL_BUSOFF (1u << 0) /* Controller BusOff */
+	/* CAN controller status */
+	__le16 status;
+};
+
+/* TX queue message types */
+struct virtio_can_tx_out {
+#define VIRTIO_CAN_TX                   0x0001
+	__le16 msg_type;
+	__le16 length; /* 0..8 CC, 0..64 CAN-FD, 0..2048 CAN-XL, 12 bits */
+	__u8 reserved_classic_dlc; /* If CAN classic length = 8 then DLC can be 8..15 */
+	__u8 padding;
+	__le16 reserved_xl_priority; /* May be needed for CAN XL priority */
+	__le32 flags;
+	__le32 can_id;
+	__u8 sdu[64];
+};
+
+struct virtio_can_tx_in {
+	__u8 result;
+};
+
+/* RX queue message types */
+struct virtio_can_rx {
+#define VIRTIO_CAN_RX                   0x0101
+	__le16 msg_type;
+	__le16 length; /* 0..8 CC, 0..64 CAN-FD, 0..2048 CAN-XL, 12 bits */
+	__u8 reserved_classic_dlc; /* If CAN classic length = 8 then DLC can be 8..15 */
+	__u8 padding;
+	__le16 reserved_xl_priority; /* May be needed for CAN XL priority */
+	__le32 flags;
+	__le32 can_id;
+	__u8 sdu[64];
+};
+
+/* Control queue message types */
+struct virtio_can_control_out {
+#define VIRTIO_CAN_SET_CTRL_MODE_START  0x0201
+#define VIRTIO_CAN_SET_CTRL_MODE_STOP   0x0202
+	__le16 msg_type;
+};
+
+struct virtio_can_control_in {
+	__u8 result;
+};
+
+#endif /* #ifndef _LINUX_VIRTIO_VIRTIO_CAN_H */
-- 
2.43.0


