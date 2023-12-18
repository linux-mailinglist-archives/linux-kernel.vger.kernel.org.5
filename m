Return-Path: <linux-kernel+bounces-3116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4AA81679A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 08:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A854728276D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 07:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A5B11CAA;
	Mon, 18 Dec 2023 07:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b="pvj2fo1G"
X-Original-To: linux-kernel@vger.kernel.org
Received: from refb02.tmes.trendmicro.eu (refb02.tmes.trendmicro.eu [18.185.115.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3BD101DF
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 07:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensynergy.com
Received: from 104.47.11.168_.trendmicro.com (unknown [172.21.19.48])
	by refb02.tmes.trendmicro.eu (Postfix) with ESMTPS id 74EDA109EA899;
	Mon, 18 Dec 2023 07:40:55 +0000 (UTC)
Received: from 104.47.11.168_.trendmicro.com (unknown [172.21.171.117])
	by repost01.tmes.trendmicro.eu (Postfix) with SMTP id A3F3A10000D09;
	Mon, 18 Dec 2023 07:40:48 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1702885247.890000
X-TM-MAIL-UUID: c9a2ed7b-3e21-45e1-873a-1a6bb68bdfaa
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (unknown [104.47.11.168])
	by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id D977A10045513;
	Mon, 18 Dec 2023 07:40:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IgHjm8UYjlVJFyEHxnFZsbowPk1ygE+VwbBx1FWPVR4NVk+y2pqGEXdjOQSVZe6TdSwX3YbiGsEnOD9Cj+y25BMiuVxuI9XXvn/0Y2gHjp/W37/6m58o2hZikitjCZE2Zo81GdSBwDY1OP0/dTFJkVEms8PyGvq8YA6g06M497GYeNaSEmYh0iWWT5aeDL6zM7OvpraFMSNybiRQXvSCFrGTG8elOSvRfrDliK4W+9xgnKwlSqEcnaQv6K/oMcWNiYreAfhl4l9m+RMVZXRKDJ4r1haDUn4dnHdTeOvbaiRAjAGREk1KnaKU0M6mK6RWAnpuw95x0ZaGCamU2jXcbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OXUXTr5MnMoux6dJYiFK9OGc0xghjE5J6idg6nuU+As=;
 b=oHjvilhHFyCmkvw3ezjAOA0NetqtEBxaFP/e0cHGZX282ZPGlbmBV9yN0cKnm7HvkYM3ttc+iuduwxFKZkU6NKMVAe5FkN5NdNTh6L+OyP472ok80if0U7WCCAfF22uYomY8l+gwlhxCkEcR/jqNd560ksJ//6fkkAg3F8UGWLZ1KgflgbIUnRsPrnDYsHBSul/UoBgh1sCqH3FuisAjQth9r69hULGGEIAmX71UwP6ae2fpFNMVcwHlBO3oc3VtDA9+NzE8F0E4PsXqmCpO1cpRc4ZZzkIx2hX4PwHlqpg0UBpWijtHNNUtWsuAdvZc/BVN9N4QzRjfiATi8PnBeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 217.66.60.4) smtp.rcpttodomain=arm.com smtp.mailfrom=opensynergy.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=opensynergy.com; dkim=none (message not signed); arc=none (0)
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 217.66.60.4)
 smtp.mailfrom=opensynergy.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=opensynergy.com;
Received-SPF: Pass (protection.outlook.com: domain of opensynergy.com
 designates 217.66.60.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.66.60.4; helo=SR-MAIL-03.open-synergy.com; pr=C
From: Peter Hilber <peter.hilber@opensynergy.com>
To: linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	virtio-dev@lists.oasis-open.org
Cc: Peter Hilber <peter.hilber@opensynergy.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Richard Cochran <richardcochran@gmail.com>,
	netdev@vger.kernel.org,
	Marc Zyngier <maz@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-rtc@vger.kernel.org,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [RFC PATCH v3 4/7] virtio_rtc: Add module and driver core
Date: Mon, 18 Dec 2023 08:38:42 +0100
Message-Id: <20231218073849.35294-5-peter.hilber@opensynergy.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231218073849.35294-1-peter.hilber@opensynergy.com>
References: <20231218073849.35294-1-peter.hilber@opensynergy.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1EUR05FT013:EE_|BEZP281MB2183:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 424d96d3-c56b-45cc-f53b-08dbff9ca511
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7r94Q/KByjcOs4RLe9V4mrtm9UPAdBiT2ztklYaR+8sKI+bY/plEsj95C2S0QjXbYCjuw1A+DPJPxyUrrQa4n5ybNwvltliNh5XPA4autJ83DR4+u+JGRsF5fc0aw1VPnYeHouGaqRYEt66ALeWhYGmm7bt1ZlK87vUfKA5pK4HXVzS/05qC0g+DgD3kHAYuRphv1R22l/7vED8bJ+tfyIQAygDxx5JoI/K110FYdTxBOs5Kg2a6PYFFMpdL4vSXUwDAQV7lH6OqqZXjQSkYn99zHgA5XGEG0UlQesb1jp3/BumKuSOKVvZLRTMjihgEvfGNbfUuAr4WVgqa1WbIbC5MiPicUUsL0UX41DQA11FQ/UooB6R7zhJWxlq3X2Ct3dwM3VDuEX9ET8meK1ZiVLqa+WVa2LB1rN0YpYfL9fN+FgEJU4lm/1h/hCGQ5bwVdTC94LiOPNpwIOu9AS5SS6NwNpzMTxGj+qTwHftvAHRrOebvIFH5TY/GNa8h6uc6eib2tz4lMRFJWOeRj5WVCSpupI+OovWSJW+z6ejKfEl0I6yiBuJPslFLW9FFO2SqVa7Hoi3nvSNV+UExuT6v4AhmuUwL1cSfXXIXD8q2Dd5tLhfvfMJyBMpBKj187F3lka6KE/nGAlRSdVIe/2ytj0UvkcHpYDCwzcpsgCiQ0J+Z2EcrpJXPjae5B+TTU46bmQbDhBiYiaRDokERfFxvZqCd2qPmJbRUTwgGZhci+HDv215rlLm8IRijHc/V7sm/VQ/9vPbqKlWobeV00uk1mticBkCUeMyxKQR3J6DlzEY=
X-Forefront-Antispam-Report:
	CIP:217.66.60.4;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SR-MAIL-03.open-synergy.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(39840400004)(136003)(230922051799003)(82310400011)(1800799012)(64100799003)(451199024)(186009)(46966006)(36840700001)(1076003)(8936002)(8676002)(70586007)(70206006)(54906003)(42186006)(40480700001)(336012)(4326008)(316002)(47076005)(2616005)(83380400001)(26005)(36860700001)(478600001)(44832011)(5660300002)(30864003)(2906002)(66899024)(81166007)(41300700001)(7416002)(86362001)(36756003)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 07:40:45.1518
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 424d96d3-c56b-45cc-f53b-08dbff9ca511
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=800fae25-9b1b-4edc-993d-c939c4e84a64;Ip=[217.66.60.4];Helo=[SR-MAIL-03.open-synergy.com]
X-MS-Exchange-CrossTenant-AuthSource:
	VI1EUR05FT013.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEZP281MB2183
X-TM-AS-ERS: 104.47.11.168-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-28064.005
X-TMASE-Result: 10--11.013800-4.000000
X-TMASE-MatchedRID: CtIu++P39qfJ+P2VFrJmrGy53dw2JHQm5f2pKgY/c023UJJ8+n/4RSJS
	j0953fkRWpS5sR1Imtmbfc6n6VIFW7O1F/ODk5naCqJ0RbJ3bb3t08AkgFFynZASM5lkTKECyom
	U41gxOyP6Hdz3qeagEi77M0+ZVDsAefdn9/iBHHCIv5GuVax7CtUusl/JVaRNTWyDQcBBlE2uX7
	jAFR99WZjz/Xnc2j+asen66SRX/zDT2djP7DKoDlJTtM6CHKVOgdXztqOEBnA3j/Mq9utADVBAV
	HJqFz648+eJ9G+ZDLXMglgMt0tendKRE65aapCPVj1dhrWbzEDOz+CaRbDFcNJAzldhFV5ZElJC
	CPFOoraxkjPUHfM63fWRBYx91SnJGzL7OqSPhBBch/PYekr/BIld6gdpSPED0g+dAcmSn6KEmEj
	VFBjobGwB+QHjMMuMBPsCWqKv2JA5D7FiRTCtpYruruLIWfnxAJ4bT6ig74eO46CtGFNzgMvlXM
	sLszNRZ5Hb8eCMiwmJwQLSKO0PQk+hKHoa1pxb4EfJdkIZseqWzpGKWacixMpF92GJdqYwypHo7
	H4BiWhVK6IRFkYf/EVdqu6tIw9L7KpIQycMJiKSVDKCuaiEl57EkV3V/yv71KMHTXl0Cwc3qcpb
	SwktedJekV7oL2iI8CzPa2JJ3rfDrHDfg5pEBtwy9mwTudtiDyrqR96pNEIvMl4D6O45r0E/4tc
	JwKwA30NycNnao1Kqh33SVadweN+n/AcCed6xAZiMK6zpatWdVbkPpTjx9yLQjDgKVqdpOkf5WX
	S1f7rfXDU2ciEUMsKjGRQnQ81hzxPIJ+YGuapbyCHfDNuoE9umu0ICVejLoli4ZoiOHT/pP8tMO
	yYmaA==
X-TMASE-XGENCLOUD: 72f14432-6e44-4bba-9967-37b6e77a700f-0-0-200-0
X-TM-Deliver-Signature: F0B89227EAA9D2F812BBF79DEDD49ECD
X-TM-Addin-Auth: OqR3sAhrLrz7vzeCVIUwEli7+BZzybzlZG7d5JYRf8++sR1fLYlPQJsVJSo
	Zh8bxdnuXxUe2JYdnk2oZeEs5y4wKwLtvgg1bfSL/vugYAo3JJgYIRvO34yXwwL01V2WQNQl38X
	aOsETD//yPtbn6K90ijC+866cXLZHIWstB84G9tZGZbvWcCeVBg2xE7oVUNl4rjlXEwyYx9rBjn
	2l6E+TtLvdR9VA4UiVbaxZVTLpD36hAruWKzd2METF0zKZy0712+XNxof9lMfpyYxjWFk+U514X
	y0lfPRTqQWyq9kM=.JAAt/ZQ3VvxzdO84Qbx1XGNSbUacqXf17GetPKSN81SNDj3TMKiFlHCEGX
	Z6E/mSEVWd/1MIFSXEiMJumhbLZYu+EvDzpi7l5rmeY0F8/OWj5MdNWH8gmL/rs3iLT6OReXRNM
	aK+diK+uGUFgIyWhyOHo2uWcgJJ21C7raj8uKsD0eX9OVVQikEPCtBwVeSWPY+CPg4N8PciKff7
	HT6QKfLM9B9L7s1efmdaHUcWb38/RohyqeZzkpVOP7oe7Q2zlS1sXZBviHpy1Vr0j8aRTEcACpM
	nulY33Sk1a0yFAPu4FL6bJUE3P4O7t6iAhyVApoqLs8tyC25BOJj7+miVUw==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
	s=TM-DKIM-20210503141657; t=1702885248;
	bh=rYoV0FIQr5fBnmtQC1XPWa9nex5nC2CM2wGwkMqGNkY=; l=28851;
	h=From:To:Date;
	b=pvj2fo1G0/tmT52X1+Qioy88ulh3Qv3LtLDukYmf+U1NMpNpErAEGV6IZRbhceQwK
	 wUl96ixFT56s/O6TMK6/v22cXHC+kZoPzr1PwuXCbw6Qd6XMTxZhQxeHh/jXhfL/Yu
	 HGLVzyylbPfq1vLbgi+raJizP4vtsTfhHcPLEbQguJCDUhT+5OXafYHBROVHWb/O/W
	 SKAFM5/tocAKsGxnW2m5m3To/zWjHXmCCj8q/yjWDwVbYzutiMHVIMLy5xXrjL5i4a
	 iUcyOK5zxJ4/pqdby7EBl9jvx+zWMqzpFOf4u6u5WyUtvvwbMCluzHd/AB5on2XmqI
	 o6d6A0fNAR7AQ==

Add the virtio_rtc module and driver core. The virtio_rtc module implements
a driver compatible with the proposed Virtio RTC device specification.
The Virtio RTC (Real Time Clock) device provides information about current
time. The device can provide different clocks, e.g. for the UTC or TAI time
standards, or for physical time elapsed since some past epoch. The driver
can read the clocks with simple or more accurate methods.

Implement the core, which interacts with the Virtio RTC device. Apart from
this, the core does not expose functionality outside of the virtio_rtc
module. A follow-up patch will expose PTP clocks.

Provide synchronous messaging, which is enough for the expected time
synchronization use cases through PTP clocks (similar to ptp_kvm) or RTC
Class driver.

Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
---

Notes:
    v3:
    
    - merge readq and controlq into a single requestq (spec v3)
    
    - don't guard cross-timestamping with feature bit (spec v3)
    
    - pad message headers to 64 bits (spec v3)
    
    - reduce clock id to 16 bits (spec v3)
    
    - change Virtio status codes (spec v3)
    
    - use 'VIRTIO_RTC_REQ_' prefix for request messages (spec v3)

 MAINTAINERS                          |   7 +
 drivers/virtio/Kconfig               |  13 +
 drivers/virtio/Makefile              |   2 +
 drivers/virtio/virtio_rtc_driver.c   | 761 +++++++++++++++++++++++++++
 drivers/virtio/virtio_rtc_internal.h |  23 +
 include/uapi/linux/virtio_rtc.h      | 144 +++++
 6 files changed, 950 insertions(+)
 create mode 100644 drivers/virtio/virtio_rtc_driver.c
 create mode 100644 drivers/virtio/virtio_rtc_internal.h
 create mode 100644 include/uapi/linux/virtio_rtc.h

diff --git a/MAINTAINERS b/MAINTAINERS
index b589218605b4..0c157a19bbfd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23200,6 +23200,13 @@ S:	Maintained
 F:	drivers/nvdimm/nd_virtio.c
 F:	drivers/nvdimm/virtio_pmem.c
 
+VIRTIO RTC DRIVER
+M:	Peter Hilber <peter.hilber@opensynergy.com>
+L:	virtualization@lists.linux.dev
+S:	Maintained
+F:	drivers/virtio/virtio_rtc_*
+F:	include/uapi/linux/virtio_rtc.h
+
 VIRTIO SOUND DRIVER
 M:	Anton Yakovlev <anton.yakovlev@opensynergy.com>
 M:	"Michael S. Tsirkin" <mst@redhat.com>
diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
index 0a53a61231c2..834dd14bc070 100644
--- a/drivers/virtio/Kconfig
+++ b/drivers/virtio/Kconfig
@@ -173,4 +173,17 @@ config VIRTIO_DMA_SHARED_BUFFER
 	 This option adds a flavor of dma buffers that are backed by
 	 virtio resources.
 
+config VIRTIO_RTC
+	tristate "Virtio RTC driver"
+	depends on VIRTIO
+	depends on PTP_1588_CLOCK_OPTIONAL
+	help
+	 This driver provides current time from a Virtio RTC device. The driver
+	 provides the time through one or more clocks.
+
+	 To compile this code as a module, choose M here: the module will be
+	 called virtio_rtc.
+
+	 If unsure, say M.
+
 endif # VIRTIO_MENU
diff --git a/drivers/virtio/Makefile b/drivers/virtio/Makefile
index 8e98d24917cc..f760414ed6ab 100644
--- a/drivers/virtio/Makefile
+++ b/drivers/virtio/Makefile
@@ -12,3 +12,5 @@ obj-$(CONFIG_VIRTIO_INPUT) += virtio_input.o
 obj-$(CONFIG_VIRTIO_VDPA) += virtio_vdpa.o
 obj-$(CONFIG_VIRTIO_MEM) += virtio_mem.o
 obj-$(CONFIG_VIRTIO_DMA_SHARED_BUFFER) += virtio_dma_buf.o
+obj-$(CONFIG_VIRTIO_RTC) += virtio_rtc.o
+virtio_rtc-y := virtio_rtc_driver.o
diff --git a/drivers/virtio/virtio_rtc_driver.c b/drivers/virtio/virtio_rtc_driver.c
new file mode 100644
index 000000000000..ef1ea14b3bec
--- /dev/null
+++ b/drivers/virtio/virtio_rtc_driver.c
@@ -0,0 +1,761 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * virtio_rtc driver core
+ *
+ * Copyright (C) 2022-2023 OpenSynergy GmbH
+ */
+
+#include <linux/completion.h>
+#include <linux/virtio.h>
+#include <linux/virtio_ids.h>
+#include <linux/virtio_config.h>
+#include <linux/module.h>
+
+#include <uapi/linux/virtio_rtc.h>
+
+#include "virtio_rtc_internal.h"
+
+/* virtqueue order */
+enum {
+	VIORTC_REQUESTQ,
+	VIORTC_MAX_NR_QUEUES,
+};
+
+/**
+ * struct viortc_vq - virtqueue abstraction
+ * @vq: virtqueue
+ * @lock: protects access to vq
+ */
+struct viortc_vq {
+	struct virtqueue *vq;
+	spinlock_t lock;
+};
+
+/**
+ * struct viortc_dev - virtio_rtc device data
+ * @vdev: virtio device
+ * @vqs: virtqueues
+ * @num_clocks: # of virtio_rtc clocks
+ */
+struct viortc_dev {
+	struct virtio_device *vdev;
+	struct viortc_vq vqs[VIORTC_MAX_NR_QUEUES];
+	u16 num_clocks;
+};
+
+/**
+ * struct viortc_msg - Message requested by driver, responded by device.
+ * @viortc: device data
+ * @req: request buffer
+ * @resp: response buffer
+ * @responded: vqueue callback signals response reception
+ * @refcnt: Message reference count, message and buffers will be deallocated
+ *	    once 0. refcnt is decremented in the vqueue callback and in the
+ *	    thread waiting on the responded completion.
+ *          If a message response wait function times out, the message will be
+ *          freed upon late reception (refcnt will reach 0 in the callback), or
+ *          device removal.
+ * @req_size: size of request in bytes
+ * @resp_cap: maximum size of response in bytes
+ * @resp_actual_size: actual size of response
+ */
+struct viortc_msg {
+	struct viortc_dev *viortc;
+	void *req;
+	void *resp;
+	struct completion responded;
+	refcount_t refcnt;
+	unsigned int req_size;
+	unsigned int resp_cap;
+	unsigned int resp_actual_size;
+};
+
+/**
+ * viortc_msg_init() - Allocate and initialize requestq message.
+ * @viortc: device data
+ * @msg_type: virtio_rtc message type
+ * @req_size: size of request buffer to be allocated
+ * @resp_cap: size of response buffer to be allocated
+ *
+ * Initializes the message refcnt to 2. The refcnt will be decremented once in
+ * the virtqueue callback, and once in the thread waiting on the message (on
+ * completion or timeout).
+ *
+ * Context: Process context.
+ * Return: non-NULL on success.
+ */
+static struct viortc_msg *viortc_msg_init(struct viortc_dev *viortc,
+					  u16 msg_type, unsigned int req_size,
+					  unsigned int resp_cap)
+{
+	struct viortc_msg *msg;
+	struct device *dev = &viortc->vdev->dev;
+	struct virtio_rtc_req_head *req_head;
+
+	msg = devm_kzalloc(dev, sizeof(*msg), GFP_KERNEL);
+	if (!msg)
+		return NULL;
+
+	init_completion(&msg->responded);
+
+	msg->req = devm_kzalloc(dev, req_size, GFP_KERNEL);
+	if (!msg->req)
+		goto err_free_msg;
+
+	req_head = msg->req;
+
+	msg->resp = devm_kzalloc(dev, resp_cap, GFP_KERNEL);
+	if (!msg->resp)
+		goto err_free_msg_req;
+
+	msg->viortc = viortc;
+	msg->req_size = req_size;
+	msg->resp_cap = resp_cap;
+
+	refcount_set(&msg->refcnt, 2);
+
+	req_head->msg_type = virtio_cpu_to_le(msg_type, req_head->msg_type);
+
+	return msg;
+
+err_free_msg_req:
+	devm_kfree(dev, msg->req);
+
+err_free_msg:
+	devm_kfree(dev, msg);
+
+	return NULL;
+}
+
+/**
+ * viortc_msg_release() - Decrement message refcnt, potentially free message.
+ * @msg: message requested by driver
+ *
+ * Context: Any context.
+ */
+static void viortc_msg_release(struct viortc_msg *msg)
+{
+	if (refcount_dec_and_test(&msg->refcnt)) {
+		struct device *dev = &msg->viortc->vdev->dev;
+
+		devm_kfree(dev, msg->req);
+		devm_kfree(dev, msg->resp);
+		devm_kfree(dev, msg);
+	}
+}
+
+/**
+ * viortc_do_cb() - generic virtqueue callback logic
+ * @vq: virtqueue
+ * @handle_buf: function to process a used buffer
+ *
+ * Context: virtqueue callback, typically interrupt. Takes and releases vq lock.
+ */
+static void viortc_do_cb(struct virtqueue *vq,
+			 void (*handle_buf)(void *token, unsigned int len,
+					    struct virtqueue *vq,
+					    struct viortc_vq *viortc_vq,
+					    struct viortc_dev *viortc))
+{
+	struct viortc_dev *viortc = vq->vdev->priv;
+	struct viortc_vq *viortc_vq;
+	bool cb_enabled = true;
+	unsigned long flags;
+	spinlock_t *lock;
+	unsigned int len;
+	void *token;
+
+	viortc_vq = &viortc->vqs[vq->index];
+	lock = &viortc_vq->lock;
+
+	for (;;) {
+		spin_lock_irqsave(lock, flags);
+
+		if (cb_enabled) {
+			virtqueue_disable_cb(vq);
+			cb_enabled = false;
+		}
+
+		token = virtqueue_get_buf(vq, &len);
+		if (!token) {
+			if (virtqueue_enable_cb(vq)) {
+				spin_unlock_irqrestore(lock, flags);
+				return;
+			}
+			cb_enabled = true;
+		}
+
+		spin_unlock_irqrestore(lock, flags);
+
+		if (token)
+			handle_buf(token, len, vq, viortc_vq, viortc);
+	}
+}
+
+/**
+ * viortc_requestq_hdlr() - process a requestq used buffer
+ * @token: token identifying the buffer
+ * @len: bytes written by device
+ * @vq: virtqueue
+ * @viortc_vq: device specific data for virtqueue
+ * @viortc: device data
+ *
+ * Signals completion for each received message.
+ *
+ * Context: virtqueue callback
+ */
+static void viortc_requestq_hdlr(void *token, unsigned int len,
+				 struct virtqueue *vq,
+				 struct viortc_vq *viortc_vq,
+				 struct viortc_dev *viortc)
+{
+	struct viortc_msg *msg = token;
+
+	msg->resp_actual_size = len;
+
+	/*
+	 * completion waiter must see our msg metadata, but complete() does not
+	 * guarantee a memory barrier
+	 */
+	smp_wmb();
+
+	complete(&msg->responded);
+	viortc_msg_release(msg);
+}
+
+/**
+ * viortc_cb_requestq() - callback for requestq
+ * @vq: virtqueue
+ *
+ * Context: virtqueue callback
+ */
+static void viortc_cb_requestq(struct virtqueue *vq)
+{
+	viortc_do_cb(vq, viortc_requestq_hdlr);
+}
+
+/**
+ * viortc_get_resp_errno() - converts virtio_rtc errnos to system errnos
+ * @resp_head: message response header
+ *
+ * Return: negative system errno, or 0
+ */
+static int viortc_get_resp_errno(struct virtio_rtc_resp_head *resp_head)
+{
+	switch (virtio_le_to_cpu(resp_head->status)) {
+	case VIRTIO_RTC_S_OK:
+		return 0;
+	case VIRTIO_RTC_S_EOPNOTSUPP:
+		return -EOPNOTSUPP;
+	case VIRTIO_RTC_S_EINVAL:
+		return -EINVAL;
+	case VIRTIO_RTC_S_ENODEV:
+		return -ENODEV;
+	case VIRTIO_RTC_S_EIO:
+	default:
+		return -EIO;
+	}
+}
+
+/**
+ * viortc_msg_xfer() - send message request, wait until message response
+ * @vq: virtqueue
+ * @msg: message with driver request
+ * @timeout_jiffies: message response timeout, 0 for no timeout
+ *
+ * Context: Process context. Takes and releases vq.lock. May sleep.
+ */
+static int viortc_msg_xfer(struct viortc_vq *vq, struct viortc_msg *msg,
+			   unsigned long timeout_jiffies)
+{
+	int ret;
+	unsigned long flags;
+	struct scatterlist out_sg[1];
+	struct scatterlist in_sg[1];
+	struct scatterlist *sgs[2] = { out_sg, in_sg };
+	bool notify;
+
+	sg_init_one(out_sg, msg->req, msg->req_size);
+	sg_init_one(in_sg, msg->resp, msg->resp_cap);
+
+	spin_lock_irqsave(&vq->lock, flags);
+
+	ret = virtqueue_add_sgs(vq->vq, sgs, 1, 1, msg, GFP_ATOMIC);
+	if (ret) {
+		spin_unlock_irqrestore(&vq->lock, flags);
+		/*
+		 * Release in place of the response callback, which will never
+		 * come.
+		 */
+		viortc_msg_release(msg);
+		return ret;
+	}
+
+	notify = virtqueue_kick_prepare(vq->vq);
+
+	spin_unlock_irqrestore(&vq->lock, flags);
+
+	if (notify)
+		virtqueue_notify(vq->vq);
+
+	if (timeout_jiffies) {
+		long timeout_ret;
+
+		timeout_ret = wait_for_completion_interruptible_timeout(
+			&msg->responded, timeout_jiffies);
+
+		if (!timeout_ret)
+			return -ETIMEDOUT;
+		else if (timeout_ret < 0)
+			return (int)timeout_ret;
+	} else {
+		ret = wait_for_completion_interruptible(&msg->responded);
+		if (ret)
+			return ret;
+	}
+
+	/*
+	 * Ensure we can read message metadata written in the virtqueue
+	 * callback.
+	 */
+	smp_rmb();
+
+	/*
+	 * There is not yet a case where returning a short message would make
+	 * sense, so consider any deviation an error.
+	 */
+	if (msg->resp_actual_size != msg->resp_cap)
+		return -EINVAL;
+
+	return viortc_get_resp_errno(msg->resp);
+}
+
+/*
+ * common message handle macros for messages of different types
+ */
+
+/**
+ * VIORTC_DECLARE_MSG_HDL_ONSTACK() - declare message handle on stack
+ * @hdl: message handle name
+ * @msg_suf_lowerc: message type suffix in lowercase
+ * @msg_suf_upperc: message type suffix in uppercase
+ */
+#define VIORTC_DECLARE_MSG_HDL_ONSTACK(hdl, msg_suf_lowerc, msg_suf_upperc) \
+	struct {                                                            \
+		struct viortc_msg *msg;                                     \
+		struct virtio_rtc_req_##msg_suf_lowerc *req;                \
+		struct virtio_rtc_resp_##msg_suf_lowerc *resp;              \
+		unsigned int req_size;                                      \
+		unsigned int resp_cap;                                      \
+		u16 msg_type;                                               \
+	} hdl = {                                                           \
+		NULL,                                                       \
+		NULL,                                                       \
+		NULL,                                                       \
+		sizeof(struct virtio_rtc_req_##msg_suf_lowerc),             \
+		sizeof(struct virtio_rtc_resp_##msg_suf_lowerc),            \
+		VIRTIO_RTC_REQ_##msg_suf_upperc,                            \
+	}
+
+/**
+ * VIORTC_MSG() - extract message from message handle
+ *
+ * Return: struct viortc_msg
+ */
+#define VIORTC_MSG(hdl) ((hdl).msg)
+
+/**
+ * VIORTC_MSG_INIT() - initialize message handle
+ * @hdl: message handle
+ * @viortc: device data (struct viortc_dev *)
+ *
+ * Context: Process context.
+ * Return: 0 on success, -ENOMEM otherwise.
+ */
+#define VIORTC_MSG_INIT(hdl, viortc)                                         \
+	({                                                                   \
+		typeof(hdl) *_hdl = &(hdl);                                  \
+									     \
+		_hdl->msg = viortc_msg_init((viortc), _hdl->msg_type,        \
+					    _hdl->req_size, _hdl->resp_cap); \
+		if (_hdl->msg) {                                             \
+			_hdl->req = _hdl->msg->req;                          \
+			_hdl->resp = _hdl->msg->resp;                        \
+		}                                                            \
+		_hdl->msg ? 0 : -ENOMEM;                                     \
+	})
+
+/**
+ * VIORTC_MSG_WRITE() - write a request message field
+ * @hdl: message handle
+ * @dest_member: request message field name
+ * @src_ptr: pointer to data of compatible type
+ *
+ * Writes the field in little-endian format.
+ */
+#define VIORTC_MSG_WRITE(hdl, dest_member, src_ptr)                         \
+	do {                                                                \
+		typeof(hdl) _hdl = (hdl);                                   \
+		typeof(src_ptr) _src_ptr = (src_ptr);                       \
+									    \
+		/* Sanity check: must match the member's type */            \
+		typecheck(typeof(_hdl.req->dest_member), *_src_ptr);        \
+									    \
+		_hdl.req->dest_member =                                     \
+			virtio_cpu_to_le(*_src_ptr, _hdl.req->dest_member); \
+	} while (0)
+
+/**
+ * VIORTC_MSG_READ() - read from a response message field
+ * @hdl: message handle
+ * @src_member: response message field name
+ * @dest_ptr: pointer to data of compatible type
+ *
+ * Converts from little-endian format and writes to dest_ptr.
+ */
+#define VIORTC_MSG_READ(hdl, src_member, dest_ptr)                     \
+	do {                                                           \
+		typeof(dest_ptr) _dest_ptr = (dest_ptr);               \
+								       \
+		/* Sanity check: must match the member's type */       \
+		typecheck(typeof((hdl).resp->src_member), *_dest_ptr); \
+								       \
+		*_dest_ptr = virtio_le_to_cpu((hdl).resp->src_member); \
+	} while (0)
+
+/*
+ * read requests
+ */
+
+/** timeout for clock readings, where timeouts are considered non-fatal */
+#define VIORTC_MSG_READ_TIMEOUT (msecs_to_jiffies(60 * 1000))
+
+/**
+ * viortc_read() - VIRTIO_RTC_REQ_READ wrapper
+ * @viortc: device data
+ * @vio_clk_id: virtio_rtc clock id
+ * @reading: clock reading [ns]
+ *
+ * Context: Process context.
+ * Return: Zero on success, negative error code otherwise.
+ */
+int viortc_read(struct viortc_dev *viortc, u16 vio_clk_id, u64 *reading)
+{
+	int ret;
+	VIORTC_DECLARE_MSG_HDL_ONSTACK(hdl, read, READ);
+
+	ret = VIORTC_MSG_INIT(hdl, viortc);
+	if (ret)
+		return ret;
+
+	VIORTC_MSG_WRITE(hdl, clock_id, &vio_clk_id);
+
+	ret = viortc_msg_xfer(&viortc->vqs[VIORTC_REQUESTQ], VIORTC_MSG(hdl),
+			      VIORTC_MSG_READ_TIMEOUT);
+	if (ret) {
+		dev_dbg(&viortc->vdev->dev, "%s: xfer returned %d\n", __func__,
+			ret);
+		goto out_release;
+	}
+
+	VIORTC_MSG_READ(hdl, clock_reading, reading);
+
+out_release:
+	viortc_msg_release(VIORTC_MSG(hdl));
+
+	return ret;
+}
+
+/**
+ * viortc_read_cross() - VIRTIO_RTC_REQ_READ_CROSS wrapper
+ * @viortc: device data
+ * @vio_clk_id: virtio_rtc clock id
+ * @hw_counter: virtio_rtc HW counter type
+ * @reading: clock reading [ns]
+ * @cycles: HW counter cycles during clock reading
+ *
+ * Context: Process context.
+ * Return: Zero on success, negative error code otherwise.
+ */
+int viortc_read_cross(struct viortc_dev *viortc, u16 vio_clk_id, u16 hw_counter,
+		      u64 *reading, u64 *cycles)
+{
+	int ret;
+	VIORTC_DECLARE_MSG_HDL_ONSTACK(hdl, read_cross, READ_CROSS);
+
+	ret = VIORTC_MSG_INIT(hdl, viortc);
+	if (ret)
+		return ret;
+
+	VIORTC_MSG_WRITE(hdl, clock_id, &vio_clk_id);
+	VIORTC_MSG_WRITE(hdl, hw_counter, &hw_counter);
+
+	ret = viortc_msg_xfer(&viortc->vqs[VIORTC_REQUESTQ], VIORTC_MSG(hdl),
+			      VIORTC_MSG_READ_TIMEOUT);
+	if (ret) {
+		dev_dbg(&viortc->vdev->dev, "%s: xfer returned %d\n", __func__,
+			ret);
+		goto out_release;
+	}
+
+	VIORTC_MSG_READ(hdl, clock_reading, reading);
+	VIORTC_MSG_READ(hdl, counter_cycles, cycles);
+
+out_release:
+	viortc_msg_release(VIORTC_MSG(hdl));
+
+	return ret;
+}
+
+/*
+ * control requests
+ */
+
+/**
+ * viortc_cfg() - VIRTIO_RTC_REQ_CFG wrapper
+ * @viortc: device data
+ * @num_clocks: # of virtio_rtc clocks
+ *
+ * Context: Process context.
+ * Return: Zero on success, negative error code otherwise.
+ */
+static int viortc_cfg(struct viortc_dev *viortc, u16 *num_clocks)
+{
+	int ret;
+	VIORTC_DECLARE_MSG_HDL_ONSTACK(hdl, cfg, CFG);
+
+	ret = VIORTC_MSG_INIT(hdl, viortc);
+	if (ret)
+		return ret;
+
+	ret = viortc_msg_xfer(&viortc->vqs[VIORTC_REQUESTQ], VIORTC_MSG(hdl),
+			      0);
+	if (ret) {
+		dev_dbg(&viortc->vdev->dev, "%s: xfer returned %d\n", __func__,
+			ret);
+		goto out_release;
+	}
+
+	VIORTC_MSG_READ(hdl, num_clocks, num_clocks);
+
+out_release:
+	viortc_msg_release(VIORTC_MSG(hdl));
+
+	return ret;
+}
+
+/**
+ * viortc_clock_cap() - VIRTIO_RTC_REQ_CLOCK_CAP wrapper
+ * @viortc: device data
+ * @vio_clk_id: virtio_rtc clock id
+ * @type: virtio_rtc clock type
+ *
+ * Context: Process context.
+ * Return: Zero on success, negative error code otherwise.
+ */
+static int viortc_clock_cap(struct viortc_dev *viortc, u16 vio_clk_id,
+			    u16 *type)
+{
+	int ret;
+	VIORTC_DECLARE_MSG_HDL_ONSTACK(hdl, clock_cap, CLOCK_CAP);
+
+	ret = VIORTC_MSG_INIT(hdl, viortc);
+	if (ret)
+		return ret;
+
+	VIORTC_MSG_WRITE(hdl, clock_id, &vio_clk_id);
+
+	ret = viortc_msg_xfer(&viortc->vqs[VIORTC_REQUESTQ], VIORTC_MSG(hdl),
+			      0);
+	if (ret) {
+		dev_dbg(&viortc->vdev->dev, "%s: xfer returned %d\n", __func__,
+			ret);
+		goto out_release;
+	}
+
+	VIORTC_MSG_READ(hdl, type, type);
+
+out_release:
+	viortc_msg_release(VIORTC_MSG(hdl));
+
+	return ret;
+}
+
+/**
+ * viortc_cross_cap() - VIRTIO_RTC_REQ_CROSS_CAP wrapper
+ * @viortc: device data
+ * @vio_clk_id: virtio_rtc clock id
+ * @hw_counter: virtio_rtc HW counter type
+ * @supported: xtstamping is supported for the vio_clk_id/hw_counter pair
+ *
+ * Context: Process context.
+ * Return: Zero on success, negative error code otherwise.
+ */
+int viortc_cross_cap(struct viortc_dev *viortc, u16 vio_clk_id, u16 hw_counter,
+		     bool *supported)
+{
+	int ret;
+	VIORTC_DECLARE_MSG_HDL_ONSTACK(hdl, cross_cap, CROSS_CAP);
+	u8 flags;
+
+	ret = VIORTC_MSG_INIT(hdl, viortc);
+	if (ret)
+		return ret;
+
+	VIORTC_MSG_WRITE(hdl, clock_id, &vio_clk_id);
+	VIORTC_MSG_WRITE(hdl, hw_counter, &hw_counter);
+
+	ret = viortc_msg_xfer(&viortc->vqs[VIORTC_REQUESTQ], VIORTC_MSG(hdl),
+			      0);
+	if (ret) {
+		dev_dbg(&viortc->vdev->dev, "%s: xfer returned %d\n", __func__,
+			ret);
+		goto out_release;
+	}
+
+	VIORTC_MSG_READ(hdl, flags, &flags);
+	*supported = !!(flags & VIRTIO_RTC_FLAG_CROSS_CAP);
+
+out_release:
+	viortc_msg_release(VIORTC_MSG(hdl));
+
+	return ret;
+}
+
+/*
+ * init, deinit
+ */
+
+/**
+ * viortc_clocks_init() - init local representations of virtio_rtc clocks
+ * @viortc: device data
+ *
+ * Context: Process context.
+ * Return: Zero on success, negative error code otherwise.
+ */
+static int viortc_clocks_init(struct viortc_dev *viortc)
+{
+	int ret;
+	u16 num_clocks;
+
+	ret = viortc_cfg(viortc, &num_clocks);
+	if (ret)
+		return ret;
+
+	if (num_clocks < 1) {
+		dev_err(&viortc->vdev->dev, "device reported 0 clocks\n");
+		return -ENODEV;
+	}
+
+	viortc->num_clocks = num_clocks;
+
+	/* In the future, PTP clocks will be initialized here. */
+	(void)viortc_clock_cap;
+
+	return ret;
+}
+
+/**
+ * viortc_init_vqs() - init virtqueues
+ * @viortc: device data
+ *
+ * Inits virtqueues and associated data.
+ *
+ * Context: Process context.
+ * Return: Zero on success, negative error code otherwise.
+ */
+static int viortc_init_vqs(struct viortc_dev *viortc)
+{
+	int ret;
+	struct virtio_device *vdev = viortc->vdev;
+	const char *names[VIORTC_MAX_NR_QUEUES];
+	vq_callback_t *callbacks[VIORTC_MAX_NR_QUEUES];
+	struct virtqueue *vqs[VIORTC_MAX_NR_QUEUES];
+	int nr_queues;
+
+	nr_queues = VIORTC_REQUESTQ + 1;
+	names[VIORTC_REQUESTQ] = "requestq";
+	callbacks[VIORTC_REQUESTQ] = viortc_cb_requestq;
+
+	ret = virtio_find_vqs(vdev, nr_queues, vqs, callbacks, names, NULL);
+	if (ret)
+		return ret;
+
+	viortc->vqs[VIORTC_REQUESTQ].vq = vqs[VIORTC_REQUESTQ];
+	spin_lock_init(&viortc->vqs[VIORTC_REQUESTQ].lock);
+
+	return 0;
+}
+
+/**
+ * viortc_probe() - probe a virtio_rtc virtio device
+ * @vdev: virtio device
+ *
+ * Context: Process context.
+ * Return: Zero on success, negative error code otherwise.
+ */
+static int viortc_probe(struct virtio_device *vdev)
+{
+	struct viortc_dev *viortc;
+	int ret;
+
+	viortc = devm_kzalloc(&vdev->dev, sizeof(*viortc), GFP_KERNEL);
+	if (!viortc)
+		return -ENOMEM;
+
+	vdev->priv = viortc;
+	viortc->vdev = vdev;
+
+	ret = viortc_init_vqs(viortc);
+	if (ret)
+		return ret;
+
+	virtio_device_ready(vdev);
+
+	/* Ready vdev for use by frontend devices initialized next. */
+	smp_wmb();
+
+	ret = viortc_clocks_init(viortc);
+	if (ret)
+		goto err_reset_vdev;
+
+	return 0;
+
+err_reset_vdev:
+	virtio_reset_device(vdev);
+	vdev->config->del_vqs(vdev);
+
+	return ret;
+}
+
+/**
+ * viortc_remove() - remove a virtio_rtc virtio device
+ * @vdev: virtio device
+ */
+static void viortc_remove(struct virtio_device *vdev)
+{
+	/* In the future, PTP clocks will be deinitialized here. */
+
+	virtio_reset_device(vdev);
+	vdev->config->del_vqs(vdev);
+}
+
+static struct virtio_device_id id_table[] = {
+	{ VIRTIO_ID_CLOCK, VIRTIO_DEV_ANY_ID },
+	{ 0 },
+};
+MODULE_DEVICE_TABLE(virtio, id_table);
+
+static struct virtio_driver virtio_rtc_drv = {
+	.driver.name = KBUILD_MODNAME,
+	.driver.owner = THIS_MODULE,
+	.id_table = id_table,
+	.probe = viortc_probe,
+	.remove = viortc_remove,
+};
+
+module_virtio_driver(virtio_rtc_drv);
+
+MODULE_DESCRIPTION("Virtio RTC driver");
+MODULE_AUTHOR("OpenSynergy GmbH");
+MODULE_LICENSE("GPL");
diff --git a/drivers/virtio/virtio_rtc_internal.h b/drivers/virtio/virtio_rtc_internal.h
new file mode 100644
index 000000000000..9267661b8030
--- /dev/null
+++ b/drivers/virtio/virtio_rtc_internal.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * virtio_rtc internal interfaces
+ *
+ * Copyright (C) 2022-2023 OpenSynergy GmbH
+ */
+
+#ifndef _VIRTIO_RTC_INTERNAL_H_
+#define _VIRTIO_RTC_INTERNAL_H_
+
+#include <linux/types.h>
+
+/* driver core IFs */
+
+struct viortc_dev;
+
+int viortc_read(struct viortc_dev *viortc, u16 vio_clk_id, u64 *reading);
+int viortc_read_cross(struct viortc_dev *viortc, u16 vio_clk_id, u16 hw_counter,
+		      u64 *reading, u64 *cycles);
+int viortc_cross_cap(struct viortc_dev *viortc, u16 vio_clk_id, u16 hw_counter,
+		     bool *supported);
+
+#endif /* _VIRTIO_RTC_INTERNAL_H_ */
diff --git a/include/uapi/linux/virtio_rtc.h b/include/uapi/linux/virtio_rtc.h
new file mode 100644
index 000000000000..f469276562d7
--- /dev/null
+++ b/include/uapi/linux/virtio_rtc.h
@@ -0,0 +1,144 @@
+/* SPDX-License-Identifier: ((GPL-2.0+ WITH Linux-syscall-note) OR BSD-3-Clause) */
+/*
+ * Copyright (C) 2022-2023 OpenSynergy GmbH
+ */
+
+#ifndef _LINUX_VIRTIO_RTC_H
+#define _LINUX_VIRTIO_RTC_H
+
+#include <linux/types.h>
+
+/* read request message types */
+
+#define VIRTIO_RTC_REQ_READ 0x0001
+#define VIRTIO_RTC_REQ_READ_CROSS 0x0002
+
+/* control request message types */
+
+#define VIRTIO_RTC_REQ_CFG 0x1000
+#define VIRTIO_RTC_REQ_CLOCK_CAP 0x1001
+#define VIRTIO_RTC_REQ_CROSS_CAP 0x1002
+
+/* Message headers */
+
+/** common request header */
+struct virtio_rtc_req_head {
+	__le16 msg_type;
+	__u8 reserved[6];
+};
+
+/** common response header */
+struct virtio_rtc_resp_head {
+#define VIRTIO_RTC_S_OK 0
+#define VIRTIO_RTC_S_EOPNOTSUPP 2
+#define VIRTIO_RTC_S_ENODEV 3
+#define VIRTIO_RTC_S_EINVAL 4
+#define VIRTIO_RTC_S_EIO 5
+	__u8 status;
+	__u8 reserved[7];
+};
+
+/* read requests */
+
+/* VIRTIO_RTC_REQ_READ message */
+
+struct virtio_rtc_req_read {
+	struct virtio_rtc_req_head head;
+	__le16 clock_id;
+	__u8 reserved[6];
+};
+
+struct virtio_rtc_resp_read {
+	struct virtio_rtc_resp_head head;
+	__le64 clock_reading;
+};
+
+/* VIRTIO_RTC_REQ_READ_CROSS message */
+
+struct virtio_rtc_req_read_cross {
+	struct virtio_rtc_req_head head;
+	__le16 clock_id;
+/** Arm Generic Timer Virtual Count */
+#define VIRTIO_RTC_COUNTER_ARM_VIRT 0
+/** Arm Generic Timer Physical Count */
+#define VIRTIO_RTC_COUNTER_ARM_PHYS 1
+/** x86 Time Stamp Counter */
+#define VIRTIO_RTC_COUNTER_X86_TSC 2
+	__le16 hw_counter;
+	__u8 reserved[4];
+};
+
+struct virtio_rtc_resp_read_cross {
+	struct virtio_rtc_resp_head head;
+	__le64 clock_reading;
+	__le64 counter_cycles;
+};
+
+/* control requests */
+
+/* VIRTIO_RTC_REQ_CFG message */
+
+struct virtio_rtc_req_cfg {
+	struct virtio_rtc_req_head head;
+	/* no request params */
+};
+
+struct virtio_rtc_resp_cfg {
+	struct virtio_rtc_resp_head head;
+	/** # of clocks -> clock ids < num_clocks are valid */
+	__le16 num_clocks;
+	__u8 reserved[6];
+};
+
+/* VIRTIO_RTC_REQ_CLOCK_CAP message */
+
+struct virtio_rtc_req_clock_cap {
+	struct virtio_rtc_req_head head;
+	__le16 clock_id;
+	__u8 reserved[6];
+};
+
+struct virtio_rtc_resp_clock_cap {
+	struct virtio_rtc_resp_head head;
+#define VIRTIO_RTC_CLOCK_UTC 0
+#define VIRTIO_RTC_CLOCK_TAI 1
+#define VIRTIO_RTC_CLOCK_MONO 2
+	__le16 type;
+	__u8 reserved[6];
+};
+
+/* VIRTIO_RTC_REQ_CROSS_CAP message */
+
+struct virtio_rtc_req_cross_cap {
+	struct virtio_rtc_req_head head;
+	__le16 clock_id;
+	__le16 hw_counter;
+	__u8 reserved[4];
+};
+
+struct virtio_rtc_resp_cross_cap {
+	struct virtio_rtc_resp_head head;
+#define VIRTIO_RTC_FLAG_CROSS_CAP (1 << 0)
+	__u8 flags;
+	__u8 reserved[7];
+};
+
+/** Union of request types for requestq */
+union virtio_rtc_req_requestq {
+	struct virtio_rtc_req_read read;
+	struct virtio_rtc_req_read_cross read_cross;
+	struct virtio_rtc_req_cfg cfg;
+	struct virtio_rtc_req_clock_cap clock_cap;
+	struct virtio_rtc_req_cross_cap cross_cap;
+};
+
+/** Union of response types for requestq */
+union virtio_rtc_resp_requestq {
+	struct virtio_rtc_resp_read read;
+	struct virtio_rtc_resp_read_cross read_cross;
+	struct virtio_rtc_resp_cfg cfg;
+	struct virtio_rtc_resp_clock_cap clock_cap;
+	struct virtio_rtc_resp_cross_cap cross_cap;
+};
+
+#endif /* _LINUX_VIRTIO_RTC_H */
-- 
2.40.1


