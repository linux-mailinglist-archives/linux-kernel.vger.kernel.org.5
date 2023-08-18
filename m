Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB6C780306
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 03:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356918AbjHRBUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 21:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356888AbjHRBUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 21:20:34 -0400
Received: from repost01.tmes.trendmicro.eu (repost01.tmes.trendmicro.eu [18.185.115.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B237C3A9F
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 18:20:30 -0700 (PDT)
Received: from 104.47.7.177_.trendmicro.com (unknown [172.21.183.240])
        by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 74D8A1000045E;
        Fri, 18 Aug 2023 01:20:29 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1692321628.689000
X-TM-MAIL-UUID: 07d632d7-cde6-43d8-9357-0a71ee8f957c
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (unknown [104.47.7.177])
        by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id A864910004D9B;
        Fri, 18 Aug 2023 01:20:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nhnjM0Bd/gRX/BedOVejWXGq4i26nDmwYBKbGJYBehC2J7ImRvn3e76yqJnBHUuvnz2w/Z1OSdP/F6+v5xkeSY0nJmovH4b8WSTQUAY/H0x7vxjRD8C22aPxNyOFJnNb+siryeQnYKBt29SGYJcpa8ABntGLkJFgVsgjtsIBYTrC9WFxsp4P3Jvl7lEP7BktvqGTwBubQne7BjT0EOfjpwDq/C0XkQ4cJ8erGV11a4H1g5JJkOOUTJktXZAp0RrWEeVSNLoS6Uk7QlhFERumZA5Mko2+2Iux01JkTpoz6pyWbN7OYVMZQOzQj6Bpjly8a6qgCgBzMBx1erUXZRyNOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5jhQPEYg1kz6RVlruhL6u/K0RpmZUCn+jdbW6TjVxME=;
 b=FuDyU7I9mdGvziL2xOCWUd+RxuvzWFXWDrNQk1ihlmabf+GBDtV/VQhq8OCbVkRsBeTKViAEAWy6PyJPj30wvuslm1IbhxQ3zrxv+SQBuKM3LcWCi+KoGhx6QjfUDHwAbMKLPIV9mwOJGLoLpDLEP5XjIvvcg9tCI1mAdGV/nUQ6YkZTs9uHNWLI5mUhrghrwL6rcY3hIcKLrBUiHLy85D2H4V4T2qLynejdQbXPw+ngACuV3+qkc8fluRtdcuJGuB1U8uAhEjz6jAHEMqExc6drjJKDyCvY9fFY3yKSNO2eKMta1/emDUwf2KyawcA5juYb0NQOXYpQubHAU+kFeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 217.66.60.4) smtp.rcpttodomain=arm.com smtp.mailfrom=opensynergy.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=opensynergy.com; dkim=none (message not signed); arc=none
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 217.66.60.4)
 smtp.mailfrom=opensynergy.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=opensynergy.com;
Received-SPF: Pass (protection.outlook.com: domain of opensynergy.com
 designates 217.66.60.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.66.60.4; helo=SR-MAIL-03.open-synergy.com; pr=C
From:   Peter Hilber <peter.hilber@opensynergy.com>
To:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org
Cc:     Peter Hilber <peter.hilber@opensynergy.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Richard Cochran <richardcochran@gmail.com>,
        netdev@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH v2 4/6] virtio_rtc: Add module and driver core
Date:   Fri, 18 Aug 2023 03:20:10 +0200
Message-Id: <20230818012014.212155-5-peter.hilber@opensynergy.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230818012014.212155-1-peter.hilber@opensynergy.com>
References: <20230818012014.212155-1-peter.hilber@opensynergy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1EUR05FT068:EE_|FR2P281MB1718:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 7ce4a7fc-21fe-4b28-befe-08db9f894dcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pmloBnDNRR+Y/lLj4VDw86a4bo8TWxrZUU3LO1cBWow7XWsqREy6qocJfV7b8X8KGx+zFQRokoFf13VSpew6BldA1a5EElC2l3CNyMYHF1f3wMmmI1x+EvqaWZOhwBdqRmcu+X+ZsecEW4oqULY+klEg1qxFmG1w0YP5L1p3z+I3BpXtBkmmnu1ohgnmdwC/Au1mEt8nIfVwn/maFMrLATuSslDeq8liFWQFe1rgSqLja4WCObR1+KLsAAVvV5wWk9BnYdx6QUPPNLGdXufs5SiRH3sNejlMv3i+M/DeYIfO//TnaX9P0o0hreJoix4EpW00EvWCLji/SE6KP7nEpouF9reUb1M8KFJ1Tg6LyEHzWwbat/MqIfuqXoKzw2+XZCeIiWTpk7mYwXmxS5T8FINYMRuFv1DckbkA5lZAKyWRkMnbcU8FOldfnY72ZQ6stNMorfdLGr3YbqH4oGUnvpxKQEl12C8lulQAvDXypBUt+clOEn1oSKK97VRjw6RNdC5GZN2JZ6uIGcKio3FA7oOy/7f+T8iDL4ZCEsxUnTu3tKjd0q2GyChjNp8qnhG6Z/k0ikH0B/clonRYWIBr/20d9pk21t26cSUvJeGPML6W9l51yU7cWcXkdtPWAk1cJiRnzvdeMhBWCAckr+SDzA2y35dqaZZk6PjduMQUNqPkgmQ0DgN0z+oA7j7Ymx/LccOe9HwOcC+WleJTc/xSurA/yR4w3xraD4L60Wt73uVztk3GURbyHn/9a7AnE7n7ejjAdsepg5/Kx16gs2NwigXi8b1cWJSu0JxOxHoyBk8TfAc1W96bAw5O64Ha4UMS
X-Forefront-Antispam-Report: CIP:217.66.60.4;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SR-MAIL-03.open-synergy.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(346002)(39830400003)(186009)(82310400011)(1800799009)(451199024)(46966006)(36840700001)(66899024)(83380400001)(336012)(81166007)(86362001)(36756003)(47076005)(36860700001)(1076003)(40480700001)(26005)(2616005)(7416002)(8936002)(8676002)(4326008)(30864003)(41300700001)(54906003)(70206006)(70586007)(42186006)(2906002)(316002)(5660300002)(966005)(478600001)(12101799020)(44832011)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 01:20:26.6785
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ce4a7fc-21fe-4b28-befe-08db9f894dcd
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=800fae25-9b1b-4edc-993d-c939c4e84a64;Ip=[217.66.60.4];Helo=[SR-MAIL-03.open-synergy.com]
X-MS-Exchange-CrossTenant-AuthSource: VI1EUR05FT068.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2P281MB1718
X-TM-AS-ERS: 104.47.7.177-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1011-27820.003
X-TMASE-Result: 10--9.453500-4.000000
X-TMASE-MatchedRID: fg7dWpSZHJLJ+P2VFrJmrGy53dw2JHQm5f2pKgY/c023UJJ8+n/4RSJS
        j0953fkRWpS5sR1Imtmbfc6n6VIFW7O1F/ODk5naCqJ0RbJ3bb3t08AkgFFynZASM5lkTKECyom
        U41gxOyOvmMduBbYSfBOxOZUm/FwcqMfOugFNRj0v/mdfeJBuVwf8yw0JGfKV0SCNQ10PIeZ9OD
        X3a/d/aTkJ8R13PVYv5RN50ieMXjOJHPiCScEioNwK3aKXLlLAFT2urH0z7F2ocjoCWfKow0zXs
        GsDTkZg2agkMppXv0m2/m2VjREHcXV2KXA5dledk5TUws0flAgxF6GI4Gs7uFQxWbscxchmxHtx
        9qt/1r9FiIQ0fcK1gMaDKYR20wpbGzL7OqSPhBBch/PYekr/BIld6gdpSPED0g+dAcmSn6KEmEj
        VFBjobGwB+QHjMMuMBPsCWqKv2JA5D7FiRTCtpYruruLIWfnxAJ4bT6ig74eO46CtGFNzgCOOHp
        I1HwbloJemVG4ZAoyJwQLSKO0PQrxrCWBi8DCI5yGfPzaydsBG93nesqMHbi+IwZW+xLvQpUGBC
        dNug0+J2kTfSvROnyTFn7BsOu34soVZT6+KANBkj45Xbru8vs1EbCLqdpVOgWl+IkIeOg9TvP6c
        dvJ8PoiT66ki87L9n3kOOI6Tvb823OtOp2WuSdKVGtUbacqDN9OHqCW0zdFOTTx1QkSESf1uOCM
        2va6XQ/14LZTq1Fz+/sB9Ai8pRUPCAFQuRo+g977XxEC4bZPgOJe9wsMrCyLQjDgKVqdp7tihVU
        vb0P2aLS9iTK8RtOsQNAL2u95wD5teccobfJV8dniJUBtbDHwuCMDi78rnAuA4ZQEtO3paOxpgj
        iWHdQ9dk+6tnSFLxceaN/0Yt5pdQvLo+GtE13SXnr93fPCMzA2zeol7jys=
X-TMASE-XGENCLOUD: e12a6b4c-758f-4a38-90ce-82682faa54c3-0-0-200-0
X-TM-Deliver-Signature: 74E86B8F519311B47EDB0D7DF7B73993
X-TM-Addin-Auth: xP/K8Afi/R+ChjI65nq/n+kyp0htZluDrIhqDGfZiMbaD9KkmOWCGxhIC1j
        nr9UKt2XAkuDTgr+XHTLCoJ4jwkHMhDxG8G/wVYscK8LmeeiFH792lodqTcLIxvxs8Hpx1qhm1w
        Lsaqex+vEE4nnon70t2fARL3dsfn30lWHgIulxFTcM31QELwK08qb02dzkg8E+91xxTRUmO6w6R
        KeHY+FrV70Z0UOLfXIL6yGr5ZtuPTwskBkJytrdk63fNPIQpIpuqyM5VHshikXh4IEFx1scyH4D
        +Aay1K+XRXY6Z9w=.1yM9zlSD1Rw1dIdcBz1m8AL+qIDwsX/IOQzsDnhFybh5R00IqWt3DZQzlX
        a7LwSLaDemis8TjFWlTb8jmFAQuX9J5detoZ0y/HMT84AHEhkpMJswCm0CxSbyoBwvQkvgxigBo
        KPADoVuMLJsNyvZ2kbOY0tv3cnTvU84+Kp6Ff66iGo+fkWgZcn0pTPEuC1ZxTOmzJBhcz623LW2
        xfRIUTKuj8FYMFmk21rUjZUaG6q6GM73csdRkdGHfppQXEX6XKYGpm7lbeb1DP4MbpsMnBRWwRT
        Lxnn8oAEXZo6k1EV+zqt/cYhbUc11/Fp/+knbGqHdau/y/fPyOKk2cCrlvA==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
        s=TM-DKIM-20210503141657; t=1692321629;
        bh=AAPoDpFjJAshqu44VeHpHnN8CWDkXcD0i4h1ESjtCbk=; l=28231;
        h=From:To:Date;
        b=EVCfDxju678A+v5tUHCUdLP0IX8rQXDUA+O1eCzu67mKcbTTJvNFBhEKJXSuqfHWP
         lXyiZlzm652hTPVFiXAj+/NHKJpmF1wb6+Hte1/fWnmDx3rJMFAOMIKdU9eHHGcFeI
         xwRYBoGvjSahDlMwVjKGvVLZes3TPU3GhIWQ27+/rpyGcIuiBYPiQnt0rmwXc5TB5B
         UZ8WCcWWu+gElMfaxd7NlBM1R5MbnomxlJqTV+SMUIMA8L1lx03hIZ9FEkw4bwxjad
         AlcZTWYwSlkTf6perrhr/5ZPTI5fSYdWTsBQUsVW1c4gmjIjpkx1lxOLmOj1B1flZn
         bPAacjBAITF2g==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the virtio_rtc module and driver core. The virtio_rtc module implements
a driver compatible with the proposed Virtio RTC device specification [1].
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

[1] https://lists.oasis-open.org/archives/virtio-comment/202306/msg00592.html

Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
---
 MAINTAINERS                          |   7 +
 drivers/virtio/Kconfig               |  14 +
 drivers/virtio/Makefile              |   2 +
 drivers/virtio/virtio_rtc_driver.c   | 736 +++++++++++++++++++++++++++
 drivers/virtio/virtio_rtc_internal.h |  23 +
 include/uapi/linux/virtio_rtc.h      | 159 ++++++
 6 files changed, 941 insertions(+)
 create mode 100644 drivers/virtio/virtio_rtc_driver.c
 create mode 100644 drivers/virtio/virtio_rtc_internal.h
 create mode 100644 include/uapi/linux/virtio_rtc.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 11b470d38e3f..025c0f8fb7a6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22841,6 +22841,13 @@ S:	Maintained
 F:	drivers/nvdimm/nd_virtio.c
 F:	drivers/nvdimm/virtio_pmem.c
 
+VIRTIO RTC DRIVER
+M:	Peter Hilber <peter.hilber@opensynergy.com>
+L:	virtualization@lists.linux-foundation.org
+S:	Maintained
+F:	drivers/virtio/virtio_rtc_*
+F:	include/uapi/linux/virtio_rtc.h
+
 VIRTIO SOUND DRIVER
 M:	Anton Yakovlev <anton.yakovlev@opensynergy.com>
 M:	"Michael S. Tsirkin" <mst@redhat.com>
diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
index 0a53a61231c2..e3dbf16fa977 100644
--- a/drivers/virtio/Kconfig
+++ b/drivers/virtio/Kconfig
@@ -173,4 +173,18 @@ config VIRTIO_DMA_SHARED_BUFFER
 	 This option adds a flavor of dma buffers that are backed by
 	 virtio resources.
 
+config VIRTIO_RTC
+	tristate "Virtio RTC driver"
+	depends on VIRTIO
+	depends on PTP_1588_CLOCK_OPTIONAL
+	help
+	 This driver provides current time from a Virtio RTC device. The driver
+	 provides the time through one or more clocks. The driver sub-option
+	 VIRTIO_RTC_PTP must be enabled to expose the clocks to userspace.
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
index 000000000000..424500d2c4f7
--- /dev/null
+++ b/drivers/virtio/virtio_rtc_driver.c
@@ -0,0 +1,736 @@
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
+	VIORTC_READQ,
+	VIORTC_CONTROLQ,
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
+ * viortc_msg_init() - Allocate and initialize message.
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
+ * viortc_cb() - callback for readq and controlq
+ * @vq: virtqueue with device response
+ *
+ * Signals completion for each received message.
+ *
+ * Context: virtqueue callback, typically interrupt. Takes and releases vq lock.
+ */
+static void viortc_cb(struct virtqueue *vq)
+{
+	struct viortc_dev *viortc = vq->vdev->priv;
+	spinlock_t *lock = &viortc->vqs[vq->index].lock;
+	unsigned long flags;
+	struct viortc_msg *msg;
+	unsigned int len;
+	bool cb_enabled = true;
+
+	for (;;) {
+		spin_lock_irqsave(lock, flags);
+
+		if (cb_enabled) {
+			virtqueue_disable_cb(vq);
+			cb_enabled = false;
+		}
+
+		msg = virtqueue_get_buf(vq, &len);
+		if (!msg) {
+			if (virtqueue_enable_cb(vq)) {
+				spin_unlock_irqrestore(lock, flags);
+				return;
+			}
+			cb_enabled = true;
+		}
+
+		spin_unlock_irqrestore(lock, flags);
+
+		if (msg) {
+			msg->resp_actual_size = len;
+
+			/*
+			 * completion waiter must see our msg metadata, but
+			 * complete() does not guarantee a memory barrier
+			 */
+			smp_wmb();
+
+			complete(&msg->responded);
+			viortc_msg_release(msg);
+		}
+	}
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
+	case VIRTIO_RTC_S_UNSUPP:
+		return -EOPNOTSUPP;
+	case VIRTIO_RTC_S_INVAL:
+		return -EINVAL;
+	case VIRTIO_RTC_S_NODEV:
+		return -ENODEV;
+	case VIRTIO_RTC_S_DEVERR:
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
+		VIRTIO_RTC_M_##msg_suf_upperc,                              \
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
+ * readq messages
+ */
+
+/** timeout for clock readings, where timeouts are considered non-fatal */
+#define VIORTC_MSG_READ_TIMEOUT (msecs_to_jiffies(60 * 1000))
+
+/**
+ * viortc_read() - VIRTIO_RTC_M_READ message wrapper
+ * @viortc: device data
+ * @vio_clk_id: virtio_rtc clock id
+ * @reading: clock reading [ns]
+ *
+ * Context: Process context.
+ * Return: Zero on success, negative error code otherwise.
+ */
+int viortc_read(struct viortc_dev *viortc, u64 vio_clk_id, u64 *reading)
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
+	ret = viortc_msg_xfer(&viortc->vqs[VIORTC_READQ], VIORTC_MSG(hdl),
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
+ * viortc_read_cross() - VIRTIO_RTC_M_READ_CROSS message wrapper
+ * @viortc: device data
+ * @vio_clk_id: virtio_rtc clock id
+ * @hw_counter: virtio_rtc HW counter type
+ * @reading: clock reading [ns]
+ * @cycles: HW counter cycles during clock reading
+ *
+ * Context: Process context.
+ * Return: Zero on success, negative error code otherwise.
+ */
+int viortc_read_cross(struct viortc_dev *viortc, u64 vio_clk_id, u16 hw_counter,
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
+	ret = viortc_msg_xfer(&viortc->vqs[VIORTC_READQ], VIORTC_MSG(hdl),
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
+ * controlq messages
+ */
+
+/**
+ * viortc_cfg() - VIRTIO_RTC_M_CFG message wrapper
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
+	ret = viortc_msg_xfer(&viortc->vqs[VIORTC_CONTROLQ], VIORTC_MSG(hdl),
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
+ * viortc_clock_cap() - VIRTIO_RTC_M_CLOCK_CAP message wrapper
+ * @viortc: device data
+ * @vio_clk_id: virtio_rtc clock id
+ * @type: virtio_rtc clock type
+ *
+ * Context: Process context.
+ * Return: Zero on success, negative error code otherwise.
+ */
+static int viortc_clock_cap(struct viortc_dev *viortc, u64 vio_clk_id,
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
+	ret = viortc_msg_xfer(&viortc->vqs[VIORTC_CONTROLQ], VIORTC_MSG(hdl),
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
+ * viortc_cross_cap() - VIRTIO_RTC_M_CROSS_CAP message wrapper
+ * @viortc: device data
+ * @vio_clk_id: virtio_rtc clock id
+ * @hw_counter: virtio_rtc HW counter type
+ * @supported: xtstamping is supported for the vio_clk_id/hw_counter pair
+ *
+ * Context: Process context.
+ * Return: Zero on success, negative error code otherwise.
+ */
+int viortc_cross_cap(struct viortc_dev *viortc, u64 vio_clk_id, u16 hw_counter,
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
+	ret = viortc_msg_xfer(&viortc->vqs[VIORTC_CONTROLQ], VIORTC_MSG(hdl),
+			      0);
+	if (ret) {
+		dev_dbg(&viortc->vdev->dev, "%s: xfer returned %d\n", __func__,
+			ret);
+		goto out_release;
+	}
+
+	VIORTC_MSG_READ(hdl, flags, &flags);
+	*supported = !!(flags & BIT(VIRTIO_RTC_FLAG_CROSS_CAP));
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
+	return 0;
+}
+
+/**
+ * viortc_init_vqs() - init virtqueues
+ * @viortc: device data
+ *
+ * Context: Process context.
+ * Return: Zero on success, negative error code otherwise.
+ *
+ * Init virtqueues, and their abstractions.
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
+	names[VIORTC_READQ] = "readq";
+	callbacks[VIORTC_READQ] = viortc_cb;
+
+	names[VIORTC_CONTROLQ] = "controlq";
+	callbacks[VIORTC_CONTROLQ] = viortc_cb;
+
+	nr_queues = 2;
+
+	ret = virtio_find_vqs(vdev, nr_queues, vqs, callbacks, names, NULL);
+	if (ret)
+		return ret;
+
+	viortc->vqs[VIORTC_READQ].vq = vqs[VIORTC_READQ];
+	spin_lock_init(&viortc->vqs[VIORTC_READQ].lock);
+
+	viortc->vqs[VIORTC_CONTROLQ].vq = vqs[VIORTC_CONTROLQ];
+	spin_lock_init(&viortc->vqs[VIORTC_CONTROLQ].lock);
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
+static unsigned int features[] = {
+	VIRTIO_RTC_F_READ_CROSS,
+};
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
+	.feature_table = features,
+	.feature_table_size = ARRAY_SIZE(features),
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
index 000000000000..c2b5387f506f
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
+int viortc_read(struct viortc_dev *viortc, u64 vio_clk_id, u64 *reading);
+int viortc_read_cross(struct viortc_dev *viortc, u64 vio_clk_id, u16 hw_counter,
+		      u64 *reading, u64 *cycles);
+int viortc_cross_cap(struct viortc_dev *viortc, u64 vio_clk_id, u16 hw_counter,
+		     bool *supported);
+
+#endif /* _VIRTIO_RTC_INTERNAL_H_ */
diff --git a/include/uapi/linux/virtio_rtc.h b/include/uapi/linux/virtio_rtc.h
new file mode 100644
index 000000000000..0926b3d58254
--- /dev/null
+++ b/include/uapi/linux/virtio_rtc.h
@@ -0,0 +1,159 @@
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
+/* Device-specific features */
+
+#define VIRTIO_RTC_F_READ_CROSS 0
+
+/* readq message types */
+
+#define VIRTIO_RTC_M_READ 0x0001
+#define VIRTIO_RTC_M_READ_CROSS 0x0002
+
+/* controlq message types */
+
+#define VIRTIO_RTC_M_CFG 0x1000
+#define VIRTIO_RTC_M_CLOCK_CAP 0x1001
+#define VIRTIO_RTC_M_CROSS_CAP 0x1002
+
+/* Message headers */
+
+/** common request header */
+struct virtio_rtc_req_head {
+	__le16 msg_type;
+	__u8 reserved[2];
+};
+
+/** common response header */
+struct virtio_rtc_resp_head {
+#define VIRTIO_RTC_S_OK 0
+#define VIRTIO_RTC_S_UNSUPP 1
+#define VIRTIO_RTC_S_NODEV 2
+#define VIRTIO_RTC_S_INVAL 3
+#define VIRTIO_RTC_S_DEVERR 4
+	__u8 status;
+	__u8 reserved[3];
+};
+
+/* readq messages */
+
+/* VIRTIO_RTC_M_READ message */
+
+struct virtio_rtc_req_read {
+	struct virtio_rtc_req_head head;
+	__u8 reserved[4];
+	__le64 clock_id;
+};
+
+struct virtio_rtc_resp_read {
+	struct virtio_rtc_resp_head head;
+	__u8 reserved[4];
+	__le64 clock_reading;
+};
+
+/* VIRTIO_RTC_M_READ_CROSS message */
+
+struct virtio_rtc_req_read_cross {
+	struct virtio_rtc_req_head head;
+/** Arm Generic Timer Virtual Count */
+#define VIRTIO_RTC_COUNTER_ARM_VIRT 0
+/** Arm Generic Timer Physical Count */
+#define VIRTIO_RTC_COUNTER_ARM_PHYS 1
+/** x86 Time Stamp Counter */
+#define VIRTIO_RTC_COUNTER_X86_TSC 2
+	__le16 hw_counter;
+	__u8 reserved[2];
+	__le64 clock_id;
+};
+
+struct virtio_rtc_resp_read_cross {
+	struct virtio_rtc_resp_head head;
+	__u8 reserved[4];
+	__le64 clock_reading;
+	__le64 counter_cycles;
+};
+
+/** Union of request types for readq */
+union virtio_rtc_req_readq {
+	struct virtio_rtc_req_read read;
+	struct virtio_rtc_req_read_cross read_cross;
+};
+
+/** Union of response types for readq */
+union virtio_rtc_resp_readq {
+	struct virtio_rtc_resp_read read;
+	struct virtio_rtc_resp_read_cross read_cross;
+};
+
+/* controlq messages */
+
+/* VIRTIO_RTC_M_CFG message */
+
+struct virtio_rtc_req_cfg {
+	struct virtio_rtc_req_head head;
+	/* no request params */
+	__u8 reserved[4];
+};
+
+struct virtio_rtc_resp_cfg {
+	struct virtio_rtc_resp_head head;
+	/** # of clocks -> clock ids < num_clocks are valid */
+	__le16 num_clocks;
+	__u8 reserved[10];
+};
+
+/* VIRTIO_RTC_M_CLOCK_CAP message */
+
+struct virtio_rtc_req_clock_cap {
+	struct virtio_rtc_req_head head;
+	__u8 reserved[4];
+	__le64 clock_id;
+};
+
+struct virtio_rtc_resp_clock_cap {
+	struct virtio_rtc_resp_head head;
+#define VIRTIO_RTC_CLOCK_UTC 0
+#define VIRTIO_RTC_CLOCK_TAI 1
+#define VIRTIO_RTC_CLOCK_MONO 2
+	__le16 type;
+	__u8 reserved[10];
+};
+
+/* VIRTIO_RTC_M_CROSS_CAP message */
+
+struct virtio_rtc_req_cross_cap {
+	struct virtio_rtc_req_head head;
+	__le16 hw_counter;
+	__u8 reserved[2];
+	__le64 clock_id;
+};
+
+struct virtio_rtc_resp_cross_cap {
+	struct virtio_rtc_resp_head head;
+#define VIRTIO_RTC_FLAG_CROSS_CAP 0
+	__u8 flags;
+	__u8 reserved[11];
+};
+
+/** Union of request types for controlq */
+union virtio_rtc_req_controlq {
+	struct virtio_rtc_req_cfg cfg;
+	struct virtio_rtc_req_clock_cap clock_cap;
+	struct virtio_rtc_req_cross_cap cross_cap;
+};
+
+/** Union of response types for controlq */
+union virtio_rtc_resp_controlq {
+	struct virtio_rtc_resp_cfg cfg;
+	struct virtio_rtc_resp_clock_cap clock_cap;
+	struct virtio_rtc_resp_cross_cap cross_cap;
+};
+
+#endif /* _LINUX_VIRTIO_RTC_H */
-- 
2.39.2

