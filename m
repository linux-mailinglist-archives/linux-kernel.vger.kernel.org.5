Return-Path: <linux-kernel+bounces-3112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C42F816791
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 08:41:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C5611C223C0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 07:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3AE1F9E4;
	Mon, 18 Dec 2023 07:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b="0I4AoBdA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from repost01.tmes.trendmicro.eu (repost01.tmes.trendmicro.eu [18.185.115.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF19E578
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 07:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensynergy.com
Received: from 104.47.11.169_.trendmicro.com (unknown [172.21.165.80])
	by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 9B89410001333;
	Mon, 18 Dec 2023 07:40:51 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1702885251.036000
X-TM-MAIL-UUID: d7ec7c30-d5a0-478c-970d-ed207558c072
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (unknown [104.47.11.169])
	by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id 08E9710000407;
	Mon, 18 Dec 2023 07:40:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jpcpK80/qbWNIZdYRSpt+2uSDb0xzQ8LaSHVfXTpWpdHDYS/VVyqJdK29oFx9VNpJNXFk+DrM5BHssAheUZrMwoZW2SCCe6KfGKF2jP0Pnfx0d/DhwveYJskdo6wTFJ0utHOBndCh6KWSSIfioEIyqKziSVj7D11Mhrp7r9w5nvT1BQFoFHCAAB3M3dcl0t/ZRkrli4zu1wx2EepB+ss/0Z3/+IYEMszMMhZPba90NTcLHdDfUdzw16mpbpCeuUtwKNjNCPuKwtLkTTrlc/jvdU2W5A2tV48C7BiZ4Op4Dh61urXaksCaviUwRpZi+tF40WsyK90nagycsbZIGDDLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2prUkZRVNY0FTA+o+kDgRaNf+5zCWU9dRgxNuO+ktug=;
 b=knY+AvmSUTe29Nq+ttTTbZUbl0Y8VouukYVQuMuFVdHchPGUmVvC4uhyu4ttOY9DKx/9TTDBEYWMGuJidQU74DI6VC3F3x5w+OXTMhxlrjVcNo/zjKORx0jGQqoaGwcptucPKPElAP//5q7Ox+jVOy/yuL34x0TWt+dIlEx0CPduFcfPytn5H82cOXS/Rm2v3lt9BFIcD7TD/p7PlB6LK3aUWHrx/+viLjyZQNvakvVY00uLVWGtMci2Bdsbg0Rs5q/tk2tIwEOL/JQcFw/3JMt4Akh9TBAUnKgl1Veajal/CKQKqgI66cBpLXazdXpOwXnZko9FlOs+wUXnrath7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 217.66.60.4) smtp.rcpttodomain=bootlin.com smtp.mailfrom=opensynergy.com;
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
	virtio-dev@lists.oasis-open.org,
	linux-rtc@vger.kernel.org
Cc: Peter Hilber <peter.hilber@opensynergy.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [RFC PATCH v3 7/7] virtio_rtc: Add RTC class driver
Date: Mon, 18 Dec 2023 08:38:45 +0100
Message-Id: <20231218073849.35294-8-peter.hilber@opensynergy.com>
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
X-MS-TrafficTypeDiagnostic: AM6EUR05FT059:EE_|FRYP281MB2287:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: dcd0f863-b3d1-4816-267d-08dbff9ca73a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ApKFjTmyLhQISZsCDlGxMa9kfbV29IooHEULoQvOt7+K+ok1HEgot4+b/nKQ0BtYb08xo40g276UDdqCzk5jCjzOE9SLI2pNFBxGG2/ANtjbWyiI+jIBkQCr+R/fWnp/N082UF4FYUBsBd5RMc7UISE8NK0OhNX/4jLXGvixJDZdaQ3mS4DMcEh/VyY2VpW0BfSs1TkK3m8rVR8BETkoIylfmBuWTammltXfhfE9Y10UOAAX8MLd++guQMb4lM+nUKdeb0pa3L3MdKgv+0F/yXalJAh4o0i2S5EUwJKv4m6uEcx8ml4ciqJlOfD/q4NKuMhesY9i3AXH/9ZXzzK0QcL9vpcnznWWvMEkJ7ackTVhCuQCB76gvuJSDdhhOya9ZNASM4vURaVXSInb8sjC153+qOuUVa14CNMAqsMwE3ulKLpYPg+AbCj56HkI5gtOU1h8CMnEA9nQRLZjco1dPiuiIb/sRe6UGbc3wlOfLLu0nH9rjTfaZeMx85HMf0GZ4hE4OSAMK9V2BccCJZKDlafDpazCimPfHcp1gCmFRso4SXjO/NGjrK/O2i2z6gOwl/A+YEaCOdWeFHUFRgw6kmk0bft/l11ezDAH2fvcL/05B4TYgzFuuH/Fmj3ZtMKP/Fgrj3Ut79yqExDvL2P8V9O66SHN5V+o/XPxd8XH/Fy12h12eeu36U0hwK1TKSujXO8O6r0cpQ6IBcEE5ABWhOxiNF2R5h1OOc62N/mskAWDJp6Fz8uFNqOnC2qhWU5nUR3xmUmPPFl9V0Pr8QElcdCX4aLjhG771Ug7Jb1C0qqDgQct8SHzoRW7swtJMEG4S0OlyG8RPoUJtv+WEs9oYA==
X-Forefront-Antispam-Report:
	CIP:217.66.60.4;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SR-MAIL-03.open-synergy.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(136003)(396003)(346002)(39840400004)(376002)(230922051799003)(230273577357003)(230173577357003)(186009)(64100799003)(82310400011)(451199024)(1800799012)(36840700001)(46966006)(40480700001)(70586007)(86362001)(81166007)(36756003)(36860700001)(47076005)(83380400001)(5660300002)(336012)(26005)(2616005)(1076003)(2906002)(30864003)(54906003)(42186006)(70206006)(8936002)(8676002)(4326008)(478600001)(316002)(44832011)(41300700001)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 07:40:48.7862
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dcd0f863-b3d1-4816-267d-08dbff9ca73a
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=800fae25-9b1b-4edc-993d-c939c4e84a64;Ip=[217.66.60.4];Helo=[SR-MAIL-03.open-synergy.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM6EUR05FT059.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRYP281MB2287
X-TM-AS-ERS: 104.47.11.169-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-28064.005
X-TMASE-Result: 10--20.975100-4.000000
X-TMASE-MatchedRID: HE8hON2ynzcZcVp47R3UL4i/ka5VrHsK59KGlOljPvudWHshdQbtCmj7
	YB3H2ACVroemFU6CMMt2c8QLYDsid7HIqhLyDZStx35zxu/gQ2a6wG+1uTW14JdigZi17dHqiiD
	5/mqQEv3XmD2V2hHPPhm86mU2uJFJvhggj6xTCeGheJ4X7s7SmoM+VZimfMfO4QpvGpvkj+eLz4
	gav4lvdTKT8fDhc32NGbzqZTa4kUmTaxv5Pos+9bF+GhWADCGDB/zLDQkZ8pX3Yy7hhcHOZUkDm
	TLjTIiV9XuNqVIcQim2/m2VjREHcXV2KXA5dledk5TUws0flAjmA0wyh8gcn0hGs13Bi4vq2R0Y
	BCalbtLOrvLZg63S7caHD1snQ4DU5acuDxctLyzJtoyGVE0N8J/3FGZTHRdAzlzdPgwPz4TPNHj
	34vvM/ZFTEeUAtxHGvmV+TYH45pwnFbk2KPuAbAm9LIMJ3oyCz2luKw/BlozQ20YfCq2u8jmy/Q
	TJSx1wsjjTgfiEfufvTl2mStwk1xPSDOhTpONb5EX3mCzYKG4n/i0u8thcpKiqsiuuQaXiu5O+W
	bkQuS1BcU6CpTnhbMSnIV45MVcNITqikU7uj0tIHzmxlHSp2PiqvKqCLVt1ojKyNVmXOrv17wdl
	9yt6Y3fAXoF8xEcLtISJoH+KyQ0v49UPRUOtXcVNAYApHGPk2j7jyCKpnCcSCDdzAMeX/RLdYzv
	1bejiZrfFxrTdHoz+61oPYZ99anht3q2IwW5dftwZ3X11IV0=
X-TMASE-XGENCLOUD: eee4f4ab-e6a9-4f0b-93f5-89333376bf31-0-0-200-0
X-TM-Deliver-Signature: 963450F06DA24750A172672A8241A86A
X-TM-Addin-Auth: AhrXST7ML2QfYEoiYNg+7olDP5RMIrQ304udOvkQM0EEIbVHv2GJHiHAjml
	16qClXjcdMRyDVkIktj6+ir9xt5034wSpWSY+8208G1HP88Cphl4PodXpx0MD2YDWlhobJkoKiD
	EdxvwEkwjPAfxxvby9x9Ybc1UhmKf7emDnjBbUCrvNVDwhSq6wOT4vkkk0UUWoKFmOmZ92ZVXsi
	Bt+F+vSxLU2fTsv6M3Aups6oG1J1hvhbOIYGSlXz5IJlBtXdbQrhtBtwcEQxOUtFVEReO9+o6OH
	N91D6HkrLEDAY64=.hrM+jxJgRDcxCRHlTjhzwdEfH21SaupkfjOBKXgMoYLa33O6c+OXIQRQlD
	yoxbpWYecLbPwUsb/cYCXEZzlT+IusajD7UX+sQGXzjrrxLX9xsmQqMQZNuAvUAoRu6IpYjWQt2
	0aq42h/WcXJMs2BR9U5NWoul59N56CtuZoi9glbQ2NH/AitI/AnaBHz7h4grMwAVTNMtay+SV+3
	HOHFqGbkPEQayg0w9BFTiplH5JTFLl49x5JX0syfcitIPJ5iLfyC27In9MtzRxYYylBetQJzDGe
	5lflie0KcXEgLI6W5QU7onhiK7gmiVuZd6o5bfowkgb/DX+e+sOXxE6cYdg==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
	s=TM-DKIM-20210503141657; t=1702885251;
	bh=o/K5jOWoeGu336KD1xhaOpjJKfGQa031n6XzJYQZOK0=; l=34717;
	h=From:To:Date;
	b=0I4AoBdAlRj1NynfwuFonhTm9CgGgiqffaGrXCaDNxRtDOYkUtYYsrrrvGCnWy6oc
	 WmcQn0fdFu1zHHYboDpnuoIY4lQtMcD1GP4f3vJxfgTO1L9f/ShOpBhys3t7PFhZbs
	 YRt67Ozzt0t4J3aRblSHFqcjJXO2nODsm5RbtkljoDb18RhZdncvZFw0Sve6/2IJpq
	 heQiSi/o3Iq0bOrU0BPm1Hz+hPiCSwfCAq96o2Ef/PNqrid3FX32mQB59Sbw8I9mB3
	 AkzQmhpQ9NAseHIBSv0mQwJYaTZGGoQ+G0/X3kMHgN3/nam5jFDX5Luaos+0XugquI
	 mOHbS40QJ6h9g==

Expose the virtio-rtc UTC clock as an RTC clock to userspace, if it is
present. Support RTC alarm if the virtio-rtc alarm feature is present. The
virtio-rtc device signals an alarm by marking an alarmq buffer as used.

Peculiarities
-------------

A virtio-rtc clock is a bit special for an RTC clock in that

- the clock may step (also backwards) autonomously at any time and

- the device, and its notification mechanism, will be reset during boot or
  resume from sleep.

The virtio-rtc device avoids that the driver might miss an alarm. The
device signals an alarm whenever the clock has reached or passed the alarm
time, and also when the device is reset (on boot or resume from sleep), if
the alarm time is in the past.

Open Issue
----------

The CLOCK_BOOTTIME_ALARM will use the RTC clock to wake up from sleep, and
implicitly assumes that no RTC clock steps will occur during sleep. The RTC
class driver does not know whether the current alarm is a real-time alarm
or a boot-time alarm.

Perhaps this might be handled by the driver also setting a virtio-rtc
monotonic alarm (which uses a clock similar to CLOCK_BOOTTIME_ALARM). The
virtio-rtc monotonic alarm would just be used to wake up in case it was a
CLOCK_BOOTTIME_ALARM alarm.

Otherwise, the behavior should not differ from other RTC class drivers.

Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
---

Notes:
    Added in v3.

 drivers/virtio/Kconfig               |  21 +-
 drivers/virtio/Makefile              |   1 +
 drivers/virtio/virtio_rtc_class.c    | 269 +++++++++++++++
 drivers/virtio/virtio_rtc_driver.c   | 477 ++++++++++++++++++++++++++-
 drivers/virtio/virtio_rtc_internal.h |  53 +++
 include/uapi/linux/virtio_rtc.h      |  88 ++++-
 6 files changed, 902 insertions(+), 7 deletions(-)
 create mode 100644 drivers/virtio/virtio_rtc_class.c

diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
index d35c728778d2..e97bb2e9eca1 100644
--- a/drivers/virtio/Kconfig
+++ b/drivers/virtio/Kconfig
@@ -180,7 +180,8 @@ config VIRTIO_RTC
 	help
 	 This driver provides current time from a Virtio RTC device. The driver
 	 provides the time through one or more clocks. The Virtio RTC PTP
-	 clocks must be enabled to expose the clocks to userspace.
+	 clocks and/or the Real Time Clock driver for Virtio RTC must be
+	 enabled to expose the clocks to userspace.
 
 	 To compile this code as a module, choose M here: the module will be
 	 called virtio_rtc.
@@ -189,8 +190,8 @@ config VIRTIO_RTC
 
 if VIRTIO_RTC
 
-comment "WARNING: Consider enabling VIRTIO_RTC_PTP."
-	depends on !VIRTIO_RTC_PTP
+comment "WARNING: Consider enabling VIRTIO_RTC_PTP and/or VIRTIO_RTC_CLASS."
+	depends on !VIRTIO_RTC_PTP && !VIRTIO_RTC_CLASS
 
 comment "Enable PTP_1588_CLOCK in order to enable VIRTIO_RTC_PTP."
 	depends on PTP_1588_CLOCK=n
@@ -218,6 +219,20 @@ config VIRTIO_RTC_ARM
 
 	 If unsure, say Y.
 
+comment "Enable RTC_CLASS in order to enable VIRTIO_RTC_CLASS."
+	depends on RTC_CLASS=n
+
+config VIRTIO_RTC_CLASS
+	bool "Real Time Clock driver for Virtio RTC"
+	default y
+	depends on RTC_CLASS
+	help
+	 This exposes the Virtio RTC UTC clock as a Linux Real Time Clock. It
+	 only has an effect if the Virtio RTC device has a UTC clock. The Real
+	 Time Clock is read-only, and may support setting an alarm.
+
+	 If unsure, say Y.
+
 endif # VIRTIO_RTC
 
 endif # VIRTIO_MENU
diff --git a/drivers/virtio/Makefile b/drivers/virtio/Makefile
index 781dff9f8822..6c26bad777db 100644
--- a/drivers/virtio/Makefile
+++ b/drivers/virtio/Makefile
@@ -16,3 +16,4 @@ obj-$(CONFIG_VIRTIO_RTC) += virtio_rtc.o
 virtio_rtc-y := virtio_rtc_driver.o
 virtio_rtc-$(CONFIG_VIRTIO_RTC_PTP) += virtio_rtc_ptp.o
 virtio_rtc-$(CONFIG_VIRTIO_RTC_ARM) += virtio_rtc_arm.o
+virtio_rtc-$(CONFIG_VIRTIO_RTC_CLASS) += virtio_rtc_class.o
diff --git a/drivers/virtio/virtio_rtc_class.c b/drivers/virtio/virtio_rtc_class.c
new file mode 100644
index 000000000000..fcb694f0f9a0
--- /dev/null
+++ b/drivers/virtio/virtio_rtc_class.c
@@ -0,0 +1,269 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * virtio_rtc RTC class driver
+ *
+ * Copyright (C) 2023 OpenSynergy GmbH
+ */
+
+#include <linux/overflow.h>
+#include <linux/rtc.h>
+#include <linux/time64.h>
+
+#include <uapi/linux/virtio_rtc.h>
+
+#include "virtio_rtc_internal.h"
+
+/**
+ * struct viortc_class - RTC class wrapper
+ * @viortc: virtio_rtc device data
+ * @rtc: RTC device
+ * @vio_clk_id: virtio_rtc clock id
+ * @stopped: Whether RTC ops are disallowed. Access protected by rtc_lock().
+ */
+struct viortc_class {
+	struct viortc_dev *viortc;
+	struct rtc_device *rtc;
+	u16 vio_clk_id;
+	bool stopped;
+};
+
+/**
+ * viortc_class_get_locked() - get RTC class wrapper, if ops allowed
+ * @dev: virtio device
+ *
+ * Gets the RTC class wrapper from the virtio device, if it is available and
+ * ops are allowed.
+ *
+ * Context: Caller must hold rtc_lock().
+ * Return: RTC class wrapper if available and ops allowed, ERR_PTR otherwise.
+ */
+static struct viortc_class *viortc_class_get_locked(struct device *dev)
+{
+	struct viortc_class *viortc_class;
+
+	viortc_class = viortc_class_from_dev(dev);
+	if (IS_ERR(viortc_class))
+		return viortc_class;
+
+	if (viortc_class->stopped)
+		return ERR_PTR(-EBUSY);
+
+	return viortc_class;
+}
+
+/**
+ * viortc_class_read_time() - RTC class op read_time
+ * @dev: virtio device
+ * @tm: read time
+ *
+ * Context: Process context.
+ * Return: Zero on success, negative error code otherwise.
+ */
+static int viortc_class_read_time(struct device *dev, struct rtc_time *tm)
+{
+	struct viortc_class *viortc_class;
+	time64_t sec;
+	int ret;
+	u64 ns;
+
+	viortc_class = viortc_class_get_locked(dev);
+	if (IS_ERR(viortc_class))
+		return PTR_ERR(viortc_class);
+
+	ret = viortc_read(viortc_class->viortc, viortc_class->vio_clk_id, &ns);
+	if (ret)
+		return ret;
+
+	sec = ns / NSEC_PER_SEC;
+
+	rtc_time64_to_tm(sec, tm);
+
+	return 0;
+}
+
+/**
+ * viortc_class_read_alarm() - RTC class op read_alarm
+ * @dev: virtio device
+ * @alrm: alarm read out
+ *
+ * Context: Process context.
+ * Return: Zero on success, negative error code otherwise.
+ */
+static int viortc_class_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
+{
+	struct viortc_class *viortc_class;
+	time64_t alarm_time_sec;
+	u64 alarm_time_ns;
+	bool enabled;
+	int ret;
+
+	viortc_class = viortc_class_get_locked(dev);
+	if (IS_ERR(viortc_class))
+		return PTR_ERR(viortc_class);
+
+	ret = viortc_read_alarm(viortc_class->viortc, viortc_class->vio_clk_id,
+				&alarm_time_ns, &enabled);
+	if (ret)
+		return ret;
+
+	alarm_time_sec = alarm_time_ns / NSEC_PER_SEC;
+	rtc_time64_to_tm(alarm_time_sec, &alrm->time);
+
+	alrm->enabled = enabled;
+
+	return 0;
+}
+
+/**
+ * viortc_class_set_alarm() - RTC class op set_alarm
+ * @dev: virtio device
+ * @alrm: alarm to set
+ *
+ * Context: Process context.
+ * Return: Zero on success, negative error code otherwise.
+ */
+static int viortc_class_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
+{
+	struct viortc_class *viortc_class;
+	time64_t alarm_time_sec;
+	u64 alarm_time_ns;
+
+	viortc_class = viortc_class_get_locked(dev);
+	if (IS_ERR(viortc_class))
+		return PTR_ERR(viortc_class);
+
+	alarm_time_sec = rtc_tm_to_time64(&alrm->time);
+
+	if (alarm_time_sec < 0)
+		return -EINVAL;
+
+	if (check_mul_overflow((u64)alarm_time_sec, (u64)NSEC_PER_SEC,
+			       &alarm_time_ns))
+		return -EINVAL;
+
+	return viortc_set_alarm(viortc_class->viortc, viortc_class->vio_clk_id,
+				alarm_time_ns, alrm->enabled);
+}
+
+/**
+ * viortc_class_alarm_irq_enable() - RTC class op alarm_irq_enable
+ * @dev: virtio device
+ * @enabled: enable or disable alarm IRQ
+ *
+ * Context: Process context.
+ * Return: Zero on success, negative error code otherwise.
+ */
+static int viortc_class_alarm_irq_enable(struct device *dev,
+					 unsigned int enabled)
+{
+	struct viortc_class *viortc_class;
+
+	viortc_class = viortc_class_get_locked(dev);
+	if (IS_ERR(viortc_class))
+		return PTR_ERR(viortc_class);
+
+	return viortc_set_alarm_enabled(viortc_class->viortc,
+					viortc_class->vio_clk_id, enabled);
+}
+
+static const struct rtc_class_ops viortc_class_with_alarm_ops = {
+	.read_time = viortc_class_read_time,
+	.read_alarm = viortc_class_read_alarm,
+	.set_alarm = viortc_class_set_alarm,
+	.alarm_irq_enable = viortc_class_alarm_irq_enable,
+};
+
+static const struct rtc_class_ops viortc_class_no_alarm_ops = {
+	.read_time = viortc_class_read_time,
+};
+
+/**
+ * viortc_class_alarm() - propagate alarm notification as alarm interrupt
+ * @viortc_class: RTC class wrapper
+ * @vio_clk_id: virtio_rtc clock id
+ *
+ * Context: Any context.
+ */
+void viortc_class_alarm(struct viortc_class *viortc_class, u16 vio_clk_id)
+{
+	if (WARN_ONCE(
+		    !viortc_class,
+		    "virtio_rtc: unexpected alarm, no RTC class device available\n"))
+		return;
+
+	if (vio_clk_id != viortc_class->vio_clk_id) {
+		dev_err_ratelimited(&viortc_class->rtc->dev,
+				    "%s: unexpected clock id %d != %d\n",
+				    __func__, vio_clk_id,
+				    viortc_class->vio_clk_id);
+		return;
+	}
+
+	rtc_update_irq(viortc_class->rtc, 1, RTC_AF | RTC_IRQF);
+}
+
+/**
+ * viortc_class_stop() - disallow RTC class ops
+ * @viortc_class: RTC class wrapper
+ *
+ * Context: Process context. Caller must NOT hold rtc_lock().
+ */
+void viortc_class_stop(struct viortc_class *viortc_class)
+{
+	rtc_lock(viortc_class->rtc);
+
+	viortc_class->stopped = true;
+
+	rtc_unlock(viortc_class->rtc);
+}
+
+/**
+ * viortc_class_register() - register RTC class device
+ * @viortc_class: RTC class wrapper
+ *
+ * Context: Process context.
+ * Return: Zero on success, negative error code otherwise.
+ */
+int viortc_class_register(struct viortc_class *viortc_class)
+{
+	return devm_rtc_register_device(viortc_class->rtc);
+}
+
+/**
+ * viortc_class_init() - init RTC class wrapper and device
+ * @viortc: device data
+ * @vio_clk_id: virtio_rtc clock id
+ * @have_alarm: expose alarm ops
+ * @parent_dev: virtio device
+ *
+ * Context: Process context.
+ * Return: RTC class wrapper on success, ERR_PTR otherwise.
+ */
+struct viortc_class *viortc_class_init(struct viortc_dev *viortc,
+				       u16 vio_clk_id, bool have_alarm,
+				       struct device *parent_dev)
+{
+	struct viortc_class *viortc_class;
+	struct rtc_device *rtc;
+
+	viortc_class =
+		devm_kzalloc(parent_dev, sizeof(*viortc_class), GFP_KERNEL);
+	if (!viortc_class)
+		return ERR_PTR(-ENOMEM);
+
+	viortc_class->viortc = viortc;
+
+	rtc = devm_rtc_allocate_device(parent_dev);
+	if (IS_ERR(rtc))
+		return ERR_PTR(PTR_ERR(rtc));
+
+	viortc_class->rtc = rtc;
+
+	clear_bit(RTC_FEATURE_UPDATE_INTERRUPT, rtc->features);
+
+	rtc->ops = have_alarm ? &viortc_class_with_alarm_ops :
+				&viortc_class_no_alarm_ops;
+	rtc->range_max = U64_MAX / NSEC_PER_SEC;
+
+	return viortc_class;
+}
diff --git a/drivers/virtio/virtio_rtc_driver.c b/drivers/virtio/virtio_rtc_driver.c
index c331b7383285..a4b5c3634de9 100644
--- a/drivers/virtio/virtio_rtc_driver.c
+++ b/drivers/virtio/virtio_rtc_driver.c
@@ -9,15 +9,19 @@
 #include <linux/virtio.h>
 #include <linux/virtio_ids.h>
 #include <linux/virtio_config.h>
+#include <linux/device.h>
 #include <linux/module.h>
 
 #include <uapi/linux/virtio_rtc.h>
 
 #include "virtio_rtc_internal.h"
 
+#define VIORTC_ALARMQ_BUF_CAP sizeof(union virtio_rtc_notif_alarmq)
+
 /* virtqueue order */
 enum {
 	VIORTC_REQUESTQ,
+	VIORTC_ALARMQ,
 	VIORTC_MAX_NR_QUEUES,
 };
 
@@ -34,17 +38,23 @@ struct viortc_vq {
 /**
  * struct viortc_dev - virtio_rtc device data
  * @vdev: virtio device
+ * @viortc_class: RTC class wrapper for UTC clock, NULL if not available
  * @vqs: virtqueues
  * @clocks_to_unregister: Clock references, which are only used during device
  *                        removal.
  *			  For other uses, there would be a race between device
  *			  creation and setting the pointers here.
+ * @alarmq_bufs: alarmq buffers list
+ * @num_alarmq_bufs: # of alarmq buffers
  * @num_clocks: # of virtio_rtc clocks
  */
 struct viortc_dev {
 	struct virtio_device *vdev;
+	struct viortc_class *viortc_class;
 	struct viortc_vq vqs[VIORTC_MAX_NR_QUEUES];
 	struct viortc_ptp_clock **clocks_to_unregister;
+	void **alarmq_bufs;
+	unsigned int num_alarmq_bufs;
 	u16 num_clocks;
 };
 
@@ -75,6 +85,60 @@ struct viortc_msg {
 	unsigned int resp_actual_size;
 };
 
+/**
+ * viortc_class_from_dev() - Get RTC class object from virtio device.
+ * @dev: virtio device
+ *
+ * Context: Any context.
+ * Return: RTC class object if available, ERR_PTR otherwise.
+ */
+struct viortc_class *viortc_class_from_dev(struct device *dev)
+{
+	struct virtio_device *vdev;
+	struct viortc_dev *viortc;
+
+	vdev = container_of(dev, typeof(*vdev), dev);
+	viortc = vdev->priv;
+
+	return viortc->viortc_class ?: ERR_PTR(-ENODEV);
+}
+
+/**
+ * viortc_alarms_supported() - Whether device and driver support alarms.
+ * @vdev: virtio device
+ *
+ * NB: Device and driver may not support alarms for the same clocks.
+ *
+ * Context: Any context.
+ * Return: True if both device and driver can support alarms.
+ */
+static bool viortc_alarms_supported(struct virtio_device *vdev)
+{
+	return IS_ENABLED(CONFIG_VIRTIO_RTC_CLASS) &&
+	       virtio_has_feature(vdev, VIRTIO_RTC_F_ALARM);
+}
+
+/**
+ * viortc_feed_vq() - Make a device write-only buffer available.
+ * @viortc: device data
+ * @vq: notification virtqueue
+ * @buf: buffer
+ * @buf_len: buffer capacity in bytes
+ * @data: token, identifying buffer
+ *
+ * Context: Caller must prevent concurrent access to vq.
+ * Return: Zero on success, negative error code otherwise.
+ */
+static int viortc_feed_vq(struct viortc_dev *viortc, struct virtqueue *vq,
+			  void *buf, unsigned int buf_len, void *data)
+{
+	struct scatterlist sg;
+
+	sg_init_one(&sg, buf, buf_len);
+
+	return virtqueue_add_inbuf(vq, &sg, 1, data, GFP_ATOMIC);
+}
+
 /**
  * viortc_msg_init() - Allocate and initialize requestq message.
  * @viortc: device data
@@ -239,6 +303,81 @@ static void viortc_cb_requestq(struct virtqueue *vq)
 	viortc_do_cb(vq, viortc_requestq_hdlr);
 }
 
+/**
+ * viortc_alarmq_hdlr() - process an alarmq used buffer
+ * @token: token identifying the buffer
+ * @len: bytes written by device
+ * @vq: virtqueue
+ * @viortc_vq: device specific data for virtqueue
+ * @viortc: device data
+ *
+ * Processes a VIRTIO_RTC_NOTIF_ALARM notification by calling the RTC class
+ * driver. Makes the buffer available again.
+ *
+ * Context: virtqueue callback
+ */
+static void viortc_alarmq_hdlr(void *token, unsigned int len,
+			       struct virtqueue *vq,
+			       struct viortc_vq *viortc_vq,
+			       struct viortc_dev *viortc)
+{
+	struct virtio_rtc_notif_alarm *notif = token;
+	struct virtio_rtc_notif_head *head = token;
+	unsigned long flags;
+	u16 clock_id;
+	bool notify;
+
+	if (len < sizeof(*head)) {
+		dev_err_ratelimited(
+			&viortc->vdev->dev,
+			"%s: ignoring notification with short header\n",
+			__func__);
+		goto feed_vq;
+	}
+
+	if (virtio_le_to_cpu(head->msg_type) != VIRTIO_RTC_NOTIF_ALARM) {
+		dev_err_ratelimited(&viortc->vdev->dev,
+				    "%s: unknown notification type\n",
+				    __func__);
+		goto feed_vq;
+	}
+
+	if (len < sizeof(*notif)) {
+		dev_err_ratelimited(&viortc->vdev->dev,
+				    "%s: alarm notification too small\n",
+				    __func__);
+		goto feed_vq;
+	}
+
+	clock_id = virtio_le_to_cpu(notif->clock_id);
+
+	viortc_class_alarm(viortc->viortc_class, clock_id);
+
+feed_vq:
+	spin_lock_irqsave(&viortc_vq->lock, flags);
+
+	WARN_ON(viortc_feed_vq(viortc, vq, notif, VIORTC_ALARMQ_BUF_CAP,
+			       token));
+
+	notify = virtqueue_kick_prepare(vq);
+
+	spin_unlock_irqrestore(&viortc_vq->lock, flags);
+
+	if (notify)
+		virtqueue_notify(vq);
+}
+
+/**
+ * viortc_cb_alarmq() - callback for alarmq
+ * @vq: virtqueue
+ *
+ * Context: virtqueue callback
+ */
+static void viortc_cb_alarmq(struct virtqueue *vq)
+{
+	viortc_do_cb(vq, viortc_alarmq_hdlr);
+}
+
 /**
  * viortc_get_resp_errno() - converts virtio_rtc errnos to system errnos
  * @resp_head: message response header
@@ -554,12 +693,13 @@ static int viortc_cfg(struct viortc_dev *viortc, u16 *num_clocks)
  * @viortc: device data
  * @vio_clk_id: virtio_rtc clock id
  * @type: virtio_rtc clock type
+ * @flags: struct virtio_rtc_resp_clock_cap.flags
  *
  * Context: Process context.
  * Return: Zero on success, negative error code otherwise.
  */
 static int viortc_clock_cap(struct viortc_dev *viortc, u16 vio_clk_id,
-			    u16 *type)
+			    u16 *type, u8 *flags)
 {
 	int ret;
 	VIORTC_DECLARE_MSG_HDL_ONSTACK(hdl, clock_cap, CLOCK_CAP);
@@ -579,6 +719,7 @@ static int viortc_clock_cap(struct viortc_dev *viortc, u16 vio_clk_id,
 	}
 
 	VIORTC_MSG_READ(hdl, type, type);
+	VIORTC_MSG_READ(hdl, flags, flags);
 
 out_release:
 	viortc_msg_release(VIORTC_MSG(hdl));
@@ -627,10 +768,176 @@ int viortc_cross_cap(struct viortc_dev *viortc, u16 vio_clk_id, u16 hw_counter,
 	return ret;
 }
 
+/**
+ * viortc_read_alarm() - VIRTIO_RTC_REQ_READ_ALARM wrapper
+ * @viortc: device data
+ * @vio_clk_id: virtio_rtc clock id
+ * @alarm_time: alarm time in ns
+ * @enabled: whether alarm is enabled
+ *
+ * Context: Process context.
+ * Return: Zero on success, negative error code otherwise.
+ */
+int viortc_read_alarm(struct viortc_dev *viortc, u16 vio_clk_id,
+		      u64 *alarm_time, bool *enabled)
+{
+	VIORTC_DECLARE_MSG_HDL_ONSTACK(hdl, read_alarm, READ_ALARM);
+	u8 flags;
+	int ret;
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
+	VIORTC_MSG_READ(hdl, alarm_time, alarm_time);
+	VIORTC_MSG_READ(hdl, flags, &flags);
+
+	*enabled = !!(flags & VIRTIO_RTC_FLAG_ALARM_ENABLED);
+
+out_release:
+	viortc_msg_release(VIORTC_MSG(hdl));
+
+	return ret;
+}
+
+/**
+ * viortc_set_alarm() - VIRTIO_RTC_REQ_SET_ALARM wrapper
+ * @viortc: device data
+ * @vio_clk_id: virtio_rtc clock id
+ * @alarm_time: alarm time in ns
+ * @alarm_enable: enable or disable alarm
+ *
+ * Context: Process context.
+ * Return: Zero on success, negative error code otherwise.
+ */
+int viortc_set_alarm(struct viortc_dev *viortc, u16 vio_clk_id, u64 alarm_time,
+		     bool alarm_enable)
+{
+	VIORTC_DECLARE_MSG_HDL_ONSTACK(hdl, set_alarm, SET_ALARM);
+	u8 flags = 0;
+	int ret;
+
+	ret = VIORTC_MSG_INIT(hdl, viortc);
+	if (ret)
+		return ret;
+
+	if (alarm_enable)
+		flags |= VIRTIO_RTC_FLAG_ALARM_ENABLED;
+
+	VIORTC_MSG_WRITE(hdl, clock_id, &vio_clk_id);
+	VIORTC_MSG_WRITE(hdl, alarm_time, &alarm_time);
+	VIORTC_MSG_WRITE(hdl, flags, &flags);
+
+	ret = viortc_msg_xfer(&viortc->vqs[VIORTC_REQUESTQ], VIORTC_MSG(hdl),
+			      0);
+	if (ret) {
+		dev_dbg(&viortc->vdev->dev, "%s: xfer returned %d\n", __func__,
+			ret);
+		goto out_release;
+	}
+
+out_release:
+	viortc_msg_release(VIORTC_MSG(hdl));
+
+	return ret;
+}
+
+/**
+ * viortc_set_alarm_enabled() - VIRTIO_RTC_REQ_SET_ALARM_ENABLED wrapper
+ * @viortc: device data
+ * @vio_clk_id: virtio_rtc clock id
+ * @alarm_enable: enable or disable alarm
+ *
+ * Context: Process context.
+ * Return: Zero on success, negative error code otherwise.
+ */
+int viortc_set_alarm_enabled(struct viortc_dev *viortc, u16 vio_clk_id,
+			     bool alarm_enable)
+{
+	VIORTC_DECLARE_MSG_HDL_ONSTACK(hdl, set_alarm_enabled,
+				       SET_ALARM_ENABLED);
+	u8 flags = 0;
+	int ret;
+
+	ret = VIORTC_MSG_INIT(hdl, viortc);
+	if (ret)
+		return ret;
+
+	if (alarm_enable)
+		flags |= VIRTIO_RTC_FLAG_ALARM_ENABLED;
+
+	VIORTC_MSG_WRITE(hdl, clock_id, &vio_clk_id);
+	VIORTC_MSG_WRITE(hdl, flags, &flags);
+
+	ret = viortc_msg_xfer(&viortc->vqs[VIORTC_REQUESTQ], VIORTC_MSG(hdl),
+			      0);
+	if (ret) {
+		dev_dbg(&viortc->vdev->dev, "%s: xfer returned %d\n", __func__,
+			ret);
+		goto out_release;
+	}
+
+out_release:
+	viortc_msg_release(VIORTC_MSG(hdl));
+
+	return ret;
+}
+
 /*
  * init, deinit
  */
 
+/**
+ * viortc_init_clock_rtc_class() - init and register a RTC class device
+ * @viortc: device data
+ * @vio_clk_id: virtio_rtc clock id
+ * @flags: struct virtio_rtc_resp_clock_cap.flags
+ *
+ * The clock must be a UTC clock.
+ *
+ * Context: Process context.
+ * Return: Zero on success, negative error code otherwise.
+ */
+static int viortc_init_clock_rtc_class(struct viortc_dev *viortc,
+				       u16 vio_clk_id, u8 flags)
+{
+	struct virtio_device *vdev = viortc->vdev;
+	struct viortc_class *viortc_class;
+	struct device *dev = &vdev->dev;
+	bool have_alarm;
+
+	if (viortc->viortc_class) {
+		dev_warn_once(
+			dev,
+			"multiple UTC clocks are present, but creating only one RTC class device\n");
+		return 0;
+	}
+
+	have_alarm = viortc_alarms_supported(vdev) &&
+		     !!(flags & VIRTIO_RTC_FLAG_ALARM_CAP);
+
+	viortc_class = viortc_class_init(viortc, vio_clk_id, have_alarm, dev);
+	if (IS_ERR(viortc_class))
+		return PTR_ERR(viortc_class);
+
+	viortc->viortc_class = viortc_class;
+
+	if (have_alarm)
+		device_init_wakeup(dev, true);
+
+	return viortc_class_register(viortc_class);
+}
+
 /**
  * viortc_init_ptp_clock() - init and register PTP clock
  * @viortc: device data
@@ -698,12 +1005,20 @@ static int viortc_init_ptp_clock(struct viortc_dev *viortc, u16 vio_clk_id,
 static int viortc_init_clock(struct viortc_dev *viortc, u16 vio_clk_id)
 {
 	u16 clock_type;
+	u8 flags;
 	int ret;
 
-	ret = viortc_clock_cap(viortc, vio_clk_id, &clock_type);
+	ret = viortc_clock_cap(viortc, vio_clk_id, &clock_type, &flags);
 	if (ret)
 		return ret;
 
+	if (clock_type == VIRTIO_RTC_CLOCK_UTC &&
+	    IS_ENABLED(CONFIG_VIRTIO_RTC_CLASS)) {
+		ret = viortc_init_clock_rtc_class(viortc, vio_clk_id, flags);
+		if (ret)
+			return ret;
+	}
+
 	if (IS_ENABLED(CONFIG_VIRTIO_RTC_PTP)) {
 		ret = viortc_init_ptp_clock(viortc, vio_clk_id, clock_type);
 		if (ret)
@@ -714,7 +1029,7 @@ static int viortc_init_clock(struct viortc_dev *viortc, u16 vio_clk_id)
 }
 
 /**
- * viortc_clocks_exit() - unregister PHCs
+ * viortc_clocks_exit() - unregister PHCs, stop RTC ops
  * @viortc: device data
  */
 static void viortc_clocks_exit(struct viortc_dev *viortc)
@@ -732,6 +1047,9 @@ static void viortc_clocks_exit(struct viortc_dev *viortc)
 
 		WARN_ON(viortc_ptp_unregister(vio_ptp, &viortc->vdev->dev));
 	}
+
+	if (viortc->viortc_class)
+		viortc_class_stop(viortc->viortc_class);
 }
 
 /**
@@ -778,6 +1096,74 @@ static int viortc_clocks_init(struct viortc_dev *viortc)
 	return ret;
 }
 
+/**
+ * viortc_alloc_vq_bufs() - allocate alarmq buffers
+ * @viortc: device data
+ * @num_elems: # of buffers
+ * @buf_cap: per-buffer device-writable capacity in bytes
+ *
+ * Context: Process context.
+ * Return: Zero on success, negative error code otherwise.
+ */
+static int viortc_alloc_vq_bufs(struct viortc_dev *viortc,
+				unsigned int num_elems, u32 buf_cap)
+{
+	struct device *dev = &viortc->vdev->dev;
+	void **buf_list;
+	unsigned int i;
+	void *buf;
+
+	buf_list = devm_kcalloc(dev, num_elems, sizeof(*buf_list), GFP_KERNEL);
+	if (!buf_list)
+		return -ENOMEM;
+
+	viortc->alarmq_bufs = buf_list;
+	viortc->num_alarmq_bufs = num_elems;
+
+	for (i = 0; i < num_elems; i++) {
+		buf = devm_kzalloc(dev, buf_cap, GFP_KERNEL);
+		if (!buf)
+			return -ENOMEM;
+
+		buf_list[i] = buf;
+	}
+
+	return 0;
+}
+
+/**
+ * viortc_populate_vq() - populate alarmq with device-writable buffers
+ * @viortc: device data
+ * @vq: virtqueue
+ * @buf_cap: device-writable buffer size in bytes
+ *
+ * Populates the alarmq with pre-allocated buffers.
+ *
+ * The caller is responsible for kicking the device.
+ *
+ * Context: Process context.
+ * Return: Zero on success, negative error code otherwise.
+ */
+static int viortc_populate_vq(struct viortc_dev *viortc, struct virtqueue *vq,
+			      u32 buf_cap)
+{
+	unsigned int num_elems, i;
+	void *buf;
+	int ret;
+
+	num_elems = viortc->num_alarmq_bufs;
+
+	for (i = 0; i < num_elems; i++) {
+		buf = viortc->alarmq_bufs[i];
+
+		ret = viortc_feed_vq(viortc, vq, buf, buf_cap, buf);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 /**
  * viortc_init_vqs() - init virtqueues
  * @viortc: device data
@@ -794,12 +1180,22 @@ static int viortc_init_vqs(struct viortc_dev *viortc)
 	const char *names[VIORTC_MAX_NR_QUEUES];
 	vq_callback_t *callbacks[VIORTC_MAX_NR_QUEUES];
 	struct virtqueue *vqs[VIORTC_MAX_NR_QUEUES];
+	unsigned int num_elems;
+	bool have_alarms;
 	int nr_queues;
 
+	have_alarms = viortc_alarms_supported(vdev);
+
 	nr_queues = VIORTC_REQUESTQ + 1;
 	names[VIORTC_REQUESTQ] = "requestq";
 	callbacks[VIORTC_REQUESTQ] = viortc_cb_requestq;
 
+	if (have_alarms) {
+		nr_queues = VIORTC_ALARMQ + 1;
+		names[VIORTC_ALARMQ] = "alarmq";
+		callbacks[VIORTC_ALARMQ] = viortc_cb_alarmq;
+	}
+
 	ret = virtio_find_vqs(vdev, nr_queues, vqs, callbacks, names, NULL);
 	if (ret)
 		return ret;
@@ -807,6 +1203,25 @@ static int viortc_init_vqs(struct viortc_dev *viortc)
 	viortc->vqs[VIORTC_REQUESTQ].vq = vqs[VIORTC_REQUESTQ];
 	spin_lock_init(&viortc->vqs[VIORTC_REQUESTQ].lock);
 
+	if (have_alarms) {
+		viortc->vqs[VIORTC_ALARMQ].vq = vqs[VIORTC_ALARMQ];
+		spin_lock_init(&viortc->vqs[VIORTC_ALARMQ].lock);
+
+		num_elems = virtqueue_get_vring_size(vqs[VIORTC_ALARMQ]);
+		if (num_elems == 0)
+			return -ENOSPC;
+
+		if (!viortc->alarmq_bufs) {
+			ret = viortc_alloc_vq_bufs(viortc, num_elems,
+						   VIORTC_ALARMQ_BUF_CAP);
+			if (ret)
+				return ret;
+		} else {
+			viortc->num_alarmq_bufs =
+				min(num_elems, viortc->num_alarmq_bufs);
+		}
+	}
+
 	return 0;
 }
 
@@ -819,6 +1234,7 @@ static int viortc_init_vqs(struct viortc_dev *viortc)
  */
 static int viortc_probe(struct virtio_device *vdev)
 {
+	struct virtqueue *alarm_vq;
 	struct viortc_dev *viortc;
 	int ret;
 
@@ -842,6 +1258,26 @@ static int viortc_probe(struct virtio_device *vdev)
 	if (ret)
 		goto err_reset_vdev;
 
+	if (viortc_alarms_supported(vdev)) {
+		/*
+		 * Now that the RTC device was registered, ready viortc to
+		 * receive alarms.
+		 */
+		smp_wmb();
+
+		alarm_vq = viortc->vqs[VIORTC_ALARMQ].vq;
+
+		ret = viortc_populate_vq(viortc, alarm_vq,
+					 VIORTC_ALARMQ_BUF_CAP);
+		if (ret)
+			goto err_reset_vdev;
+
+		if (!virtqueue_kick(alarm_vq)) {
+			ret = -EIO;
+			goto err_reset_vdev;
+		}
+	}
+
 	return 0;
 
 err_reset_vdev:
@@ -865,6 +1301,35 @@ static void viortc_remove(struct virtio_device *vdev)
 	vdev->config->del_vqs(vdev);
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int viortc_freeze(struct virtio_device *dev)
+{
+	return 0;
+}
+
+static int viortc_restore(struct virtio_device *dev)
+{
+	struct viortc_dev *viortc = dev->priv;
+	int ret;
+
+	ret = viortc_init_vqs(viortc);
+	if (ret)
+		return ret;
+
+	if (viortc_alarms_supported(dev))
+		ret = viortc_populate_vq(viortc, viortc->vqs[VIORTC_ALARMQ].vq,
+					 VIORTC_ALARMQ_BUF_CAP);
+
+	return ret;
+}
+#endif
+
+static unsigned int features[] = {
+#if IS_ENABLED(CONFIG_VIRTIO_RTC_CLASS)
+	VIRTIO_RTC_F_ALARM,
+#endif
+};
+
 static struct virtio_device_id id_table[] = {
 	{ VIRTIO_ID_CLOCK, VIRTIO_DEV_ANY_ID },
 	{ 0 },
@@ -874,9 +1339,15 @@ MODULE_DEVICE_TABLE(virtio, id_table);
 static struct virtio_driver virtio_rtc_drv = {
 	.driver.name = KBUILD_MODNAME,
 	.driver.owner = THIS_MODULE,
+	.feature_table = features,
+	.feature_table_size = ARRAY_SIZE(features),
 	.id_table = id_table,
 	.probe = viortc_probe,
 	.remove = viortc_remove,
+#ifdef CONFIG_PM_SLEEP
+	.freeze = viortc_freeze,
+	.restore = viortc_restore,
+#endif
 };
 
 module_virtio_driver(virtio_rtc_drv);
diff --git a/drivers/virtio/virtio_rtc_internal.h b/drivers/virtio/virtio_rtc_internal.h
index 0dedced4aeae..ebd5dbf5bbc5 100644
--- a/drivers/virtio/virtio_rtc_internal.h
+++ b/drivers/virtio/virtio_rtc_internal.h
@@ -8,8 +8,11 @@
 #ifndef _VIRTIO_RTC_INTERNAL_H_
 #define _VIRTIO_RTC_INTERNAL_H_
 
+#include <linux/device.h>
+#include <linux/err.h>
 #include <linux/types.h>
 #include <linux/ptp_clock_kernel.h>
+#include <linux/virtio.h>
 
 /* driver core IFs */
 
@@ -20,6 +23,16 @@ int viortc_read_cross(struct viortc_dev *viortc, u16 vio_clk_id, u16 hw_counter,
 		      u64 *reading, u64 *cycles);
 int viortc_cross_cap(struct viortc_dev *viortc, u16 vio_clk_id, u16 hw_counter,
 		     bool *supported);
+int viortc_read_alarm(struct viortc_dev *viortc, u16 vio_clk_id,
+		      u64 *alarm_time, bool *enabled);
+int viortc_set_alarm(struct viortc_dev *viortc, u16 vio_clk_id, u64 alarm_time,
+		     bool alarm_enable);
+int viortc_set_alarm_enabled(struct viortc_dev *viortc, u16 vio_clk_id,
+			     bool alarm_enable);
+
+struct viortc_class;
+
+struct viortc_class *viortc_class_from_dev(struct device *dev);
 
 /* PTP IFs */
 
@@ -66,4 +79,44 @@ static inline int viortc_ptp_unregister(struct viortc_ptp_clock *vio_ptp,
  */
 int viortc_hw_xtstamp_params(u16 *hw_counter, enum clocksource_ids *cs_id);
 
+/* RTC class IFs */
+
+#if IS_ENABLED(CONFIG_VIRTIO_RTC_CLASS)
+
+void viortc_class_alarm(struct viortc_class *viortc_class, u16 vio_clk_id);
+
+void viortc_class_stop(struct viortc_class *viortc_class);
+
+int viortc_class_register(struct viortc_class *viortc_class);
+
+struct viortc_class *viortc_class_init(struct viortc_dev *viortc,
+				       u16 vio_clk_id, bool have_alarm,
+				       struct device *parent_dev);
+
+#else /* CONFIG_VIRTIO_RTC_CLASS */
+
+static inline void viortc_class_alarm(struct viortc_class *viortc_class,
+				      u16 vio_clk_id)
+{
+}
+
+static inline void viortc_class_stop(struct viortc_class *viortc_class)
+{
+}
+
+static inline int viortc_class_register(struct viortc_class *viortc_class)
+{
+	return -ENODEV;
+}
+
+static inline struct viortc_class *viortc_class_init(struct viortc_dev *viortc,
+						     u16 vio_clk_id,
+						     bool have_alarm,
+						     struct device *parent_dev)
+{
+	return ERR_PTR(-ENODEV);
+}
+
+#endif /* CONFIG_VIRTIO_RTC_CLASS */
+
 #endif /* _VIRTIO_RTC_INTERNAL_H_ */
diff --git a/include/uapi/linux/virtio_rtc.h b/include/uapi/linux/virtio_rtc.h
index f469276562d7..26be3574fabe 100644
--- a/include/uapi/linux/virtio_rtc.h
+++ b/include/uapi/linux/virtio_rtc.h
@@ -8,6 +8,9 @@
 
 #include <linux/types.h>
 
+/* alarm feature */
+#define VIRTIO_RTC_F_ALARM 0
+
 /* read request message types */
 
 #define VIRTIO_RTC_REQ_READ 0x0001
@@ -18,6 +21,13 @@
 #define VIRTIO_RTC_REQ_CFG 0x1000
 #define VIRTIO_RTC_REQ_CLOCK_CAP 0x1001
 #define VIRTIO_RTC_REQ_CROSS_CAP 0x1002
+#define VIRTIO_RTC_REQ_READ_ALARM 0x1003
+#define VIRTIO_RTC_REQ_SET_ALARM 0x1004
+#define VIRTIO_RTC_REQ_SET_ALARM_ENABLED 0x1005
+
+/* alarmq message types */
+
+#define VIRTIO_RTC_NOTIF_ALARM 0x2000
 
 /* Message headers */
 
@@ -38,6 +48,12 @@ struct virtio_rtc_resp_head {
 	__u8 reserved[7];
 };
 
+/** common notification header */
+struct virtio_rtc_notif_head {
+	__le16 msg_type;
+	__u8 reserved[6];
+};
+
 /* read requests */
 
 /* VIRTIO_RTC_REQ_READ message */
@@ -104,7 +120,9 @@ struct virtio_rtc_resp_clock_cap {
 #define VIRTIO_RTC_CLOCK_TAI 1
 #define VIRTIO_RTC_CLOCK_MONO 2
 	__le16 type;
-	__u8 reserved[6];
+#define VIRTIO_RTC_FLAG_ALARM_CAP (1 << 0)
+	__u8 flags;
+	__u8 reserved[5];
 };
 
 /* VIRTIO_RTC_REQ_CROSS_CAP message */
@@ -123,6 +141,53 @@ struct virtio_rtc_resp_cross_cap {
 	__u8 reserved[7];
 };
 
+/* VIRTIO_RTC_REQ_READ_ALARM message */
+
+struct virtio_rtc_req_read_alarm {
+	struct virtio_rtc_req_head head;
+	__le16 clock_id;
+	__u8 reserved[6];
+};
+
+struct virtio_rtc_resp_read_alarm {
+	struct virtio_rtc_resp_head head;
+	__le64 alarm_time;
+#define VIRTIO_RTC_FLAG_ALARM_ENABLED (1 << 0)
+	__u8 flags;
+	__u8 reserved[7];
+};
+
+/* VIRTIO_RTC_REQ_SET_ALARM message */
+
+struct virtio_rtc_req_set_alarm {
+	struct virtio_rtc_req_head head;
+	__le64 alarm_time;
+	__le16 clock_id;
+	/* flag VIRTIO_RTC_ALARM_ENABLED */
+	__u8 flags;
+	__u8 reserved[5];
+};
+
+struct virtio_rtc_resp_set_alarm {
+	struct virtio_rtc_resp_head head;
+	/* no response params */
+};
+
+/* VIRTIO_RTC_REQ_SET_ALARM_ENABLED message */
+
+struct virtio_rtc_req_set_alarm_enabled {
+	struct virtio_rtc_req_head head;
+	__le16 clock_id;
+	/* flag VIRTIO_RTC_ALARM_ENABLED */
+	__u8 flags;
+	__u8 reserved[5];
+};
+
+struct virtio_rtc_resp_set_alarm_enabled {
+	struct virtio_rtc_resp_head head;
+	/* no response params */
+};
+
 /** Union of request types for requestq */
 union virtio_rtc_req_requestq {
 	struct virtio_rtc_req_read read;
@@ -130,6 +195,9 @@ union virtio_rtc_req_requestq {
 	struct virtio_rtc_req_cfg cfg;
 	struct virtio_rtc_req_clock_cap clock_cap;
 	struct virtio_rtc_req_cross_cap cross_cap;
+	struct virtio_rtc_req_read_alarm read_alarm;
+	struct virtio_rtc_req_set_alarm set_alarm;
+	struct virtio_rtc_req_set_alarm_enabled set_alarm_enabled;
 };
 
 /** Union of response types for requestq */
@@ -139,6 +207,24 @@ union virtio_rtc_resp_requestq {
 	struct virtio_rtc_resp_cfg cfg;
 	struct virtio_rtc_resp_clock_cap clock_cap;
 	struct virtio_rtc_resp_cross_cap cross_cap;
+	struct virtio_rtc_resp_read_alarm read_alarm;
+	struct virtio_rtc_resp_set_alarm set_alarm;
+	struct virtio_rtc_resp_set_alarm_enabled set_alarm_enabled;
+};
+
+/* alarmq notifications */
+
+/* VIRTIO_RTC_NOTIF_ALARM notification */
+
+struct virtio_rtc_notif_alarm {
+	struct virtio_rtc_notif_head head;
+	__le16 clock_id;
+	__u8 reserved[6];
+};
+
+/** Union of notification types for alarmq */
+union virtio_rtc_notif_alarmq {
+	struct virtio_rtc_notif_alarm alarm;
 };
 
 #endif /* _LINUX_VIRTIO_RTC_H */
-- 
2.40.1


