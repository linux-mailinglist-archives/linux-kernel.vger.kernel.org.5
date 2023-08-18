Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB12D780308
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 03:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356937AbjHRBUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 21:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356891AbjHRBUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 21:20:35 -0400
Received: from repost01.tmes.trendmicro.eu (repost01.tmes.trendmicro.eu [18.185.115.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D783AA4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 18:20:32 -0700 (PDT)
Received: from 104.47.7.173_.trendmicro.com (unknown [172.21.201.37])
        by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 19B2710000D04;
        Fri, 18 Aug 2023 01:20:31 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1692321630.480000
X-TM-MAIL-UUID: 21e86b46-3d26-41f1-8615-46636669d81d
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (unknown [104.47.7.173])
        by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id 757B11000030B;
        Fri, 18 Aug 2023 01:20:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gm7JNc0dOUo1FUFqTVJk+tWKRM6O0GO1ROrFj/wOXoN9JyaJ8ql07q4U5cOa8XtVOI3GkWVVxfxdC9YJMtKcwkaf3AOLVR/IMc/LchEIyHtYPtZgzroQdjwJjm3oz+O/YRm89lYGflGQcIYgyxhWEwAaqJ/jcTIB3L3Vu2Olrg+RLQjWXtTddvKAuXPdybHiB7juxOXBGEcesYXTYNvo1WnMDMGwNLhKK0OG1U//Zc6HNwPOSvI9kctpA/7pUIA2CQcBovINWOo/xn81oFysfmiSZLReyt8QB1QklhoPeCIKPPuYuoxjbPA/SnwpSlQHdCTpvAcmNe3Dlf0bvw+Ywg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fxnj1aoFhV1/cq7zApEAs6WyOZnKJpiRG9kdG5q++lM=;
 b=BslYsiyDrPu4ve+EbKsAeS+bSLbV1tOmn+7qVbtfEK3OtkJP5t85LrgeKnitfMFudtG+E2TEo9p5Cnuxip/sRoClofWCxCtNf5jWfr8QBadODz58UGwTiJzDQGPC8JEl2l5qe1gOl2/XtBGhEFav5lxUmE8F5oxk/WYDh5rJR9KCiGtkDmVJ2FUaAO1+OXoFrBpECuswYpyKjqDs7sHwRJfM+jU2m4xRRfT+4I6QUQr1jy548hKtr14l0HB7dNwN5VRV2kV1+zf0OOAxsHh1mOMl4R2ghVJ1v9jhKUZvdQpbAWzkKX7baOTGzC7xQ8bA/l+b0b4RKSsj0ea7+K0KfA==
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
Subject: [RFC PATCH v2 5/6] virtio_rtc: Add PTP clocks
Date:   Fri, 18 Aug 2023 03:20:11 +0200
Message-Id: <20230818012014.212155-6-peter.hilber@opensynergy.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230818012014.212155-1-peter.hilber@opensynergy.com>
References: <20230818012014.212155-1-peter.hilber@opensynergy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8EUR05FT051:EE_|BE1P281MB2918:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 12ef3246-6da2-48cc-740e-08db9f894e81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E3W2IYB4VG9H86AGpHdVtKGDk9lLl9AJu6VjGL/gUYH/+qtLcFXVJapuwzlfxuFDqnfvGH3/KCeGLP42hzX54qWRoXEukEJAmpB75TiXfUo/Jo5XK+lVRui8IN7YaM4+LVEeOzbp02N5ccypxqXr+j0rEZ76BsHimuF55K3Qq4+WieddnqcBCMGZ6+/ue68IAYTxxKZWIt3S6N2aVY+6Iw6n9SkB1jVWa/dlcT8NNoS8nWSwYw30+9MoFmadRG4zmJHt5Nt/8A+A1AnyT6whQ8Z6BPrn6jys/bkXssIDdxGkT0S7fypEiVQlGbph7gZl5Vdz0EUxc1L4P1NwtpypOW2WK1VzbYqffhYslWOXMzI5FOvD4yCIwj1D2Hvu6lHPCsY/IXaF16UsNluxtaLZhy8XuyulzRobiVZkBMzevYal8/y2ypTDsScR6C5O72qm6KP/+NY8JdkzURRYxDph2xg+K5veV4zwX3z3LMkJrBk4rd/sSV/dnNB2tPBmYBPC+1TiCi0voFkETqTjMBIUQCBQrPYQPDzt8LsPjtoginpLC1p0eE4ZN3bxruilCwct00zXcjqxwoe6LMsKXciI0SajFR6eOgvvzAAx3HttcXLfuwT7ru24oQy5Pc7Q1cQNETGuxTgTOHAKggMBCNbOSiZXfFPE29LnpHWEiuAwTPVIJ6+u2K5+UzsLsEGCFJXoAhyXKomRaVj/JILASByBE+4c6kSoSLDhJCwDznaU7m1RHj1a+d8xYDzyQL1uYynYrnB7aqIrTB9xyxNn8aVmvFUZSYFkhMJjuh2/ySK/Ml7fDd3/DE51kxa/50zQ4AaA
X-Forefront-Antispam-Report: CIP:217.66.60.4;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SR-MAIL-03.open-synergy.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(136003)(39850400004)(451199024)(186009)(82310400011)(1800799009)(36840700001)(46966006)(8676002)(8936002)(4326008)(7416002)(70206006)(70586007)(42186006)(54906003)(30864003)(41300700001)(2616005)(40480700001)(26005)(12101799020)(44832011)(316002)(2906002)(5660300002)(478600001)(36756003)(36860700001)(47076005)(1076003)(83380400001)(82740400003)(81166007)(86362001)(336012)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 01:20:27.8406
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12ef3246-6da2-48cc-740e-08db9f894e81
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=800fae25-9b1b-4edc-993d-c939c4e84a64;Ip=[217.66.60.4];Helo=[SR-MAIL-03.open-synergy.com]
X-MS-Exchange-CrossTenant-AuthSource: DB8EUR05FT051.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1P281MB2918
X-TM-AS-ERS: 104.47.7.173-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1011-27820.003
X-TMASE-Result: 10--20.765500-4.000000
X-TMASE-MatchedRID: 5y2TnboncNEY9bhGrdH9F9wy9mwTudtiRyG5SSR7mMGmopAzNrNOJn+F
        psIKKIVlk8IAUKtJYbMmnuaVQc5qV4oSaqhQo1toHW+C8sNk3WDFZzmk4ajzuCe5CWghtIzPb1O
        21F3h9PlzEFhMBQYFa/6kCjQkL+3Saroq2fxRivXHfwwbjh/dN1pMWq1GqY9jkBIzmWRMoQJIEM
        g/mVesL4yXmNxvasqVKOq0uwjm7E15BzMVCHZcS/gxOc6+WoXc3O2+pOfl+vcwLJ9PZUBQhdvdj
        Z1tR/4hQpP6/vBOuJOuxupDoex129/NzBWY5iArO9AbTF0WkMLyQ6dAmPdzEv7u2ibb+jWaW2io
        yVv78CKxGV70F5p1w1FpbN34u8eDu+0/hUFeJLPFPyeOO7dH/hYcP2hNqlOaYXmNTfcTn35rAiD
        6bCwinZOzOj2nffcU8WIpDLwfrXndTd5ynKTK2AGYjCus6WrV4rJ9GpJh5eGf0yAlW3GEerxaMa
        1kAGYhDJGx4fIYRwBhJgOUTj6ZojlUWmgsqsw2bUBkpsDXXnKB37bQADgKrw3V01gTbr0scY6fM
        I/vfQzBw2pT5AT8XU0hqK5zJSrs14hlIu0VY/C69rtClqkCjUIp2pwQ814LDANFWLhvOTlPQFFk
        0j5jBsA2iDfbpfy+AVpeDm8nJoLwnQHFZbUP3moEkqixPwVYOfEmq6feyfMlCGssfkpInQ==
X-TMASE-XGENCLOUD: 2f01c61e-e23e-48cb-8d53-3568fa149957-0-0-200-0
X-TM-Deliver-Signature: 81196FC6497F7D957558393AAB6EA8FE
X-TM-Addin-Auth: sA67C81kzuL0GDDSonBvEt56r+vQvMmnkTM9worFLViqUooYkyPgxEd9F9w
        xZk+6VpDblwfVkUbaLWOQHGzPW4UoVzfYIvpqY0hr7GxVl71uQSs1W8jusGeRku7hZqZMxZCuWE
        YV8qaLIpWKuVasCFhDBntSawcbwnZJGs45ZUAevpK/MfmZ1wy3Aa+fhFZnHuct3xyTeFyq3Hwx9
        0TpfB2nPga5ixKbnY++alsWSlGkO/pdiMvR3bwcT0FxQ8ZNQQXO8m5RftT2VgBlGDwEjNeABt/z
        z75dHhES5vK6TRA=.FdLABAJ7DaT3ILuZAnLbrJMBV96vGsfcTFJ8kd4wvpDbBeqouwJkxsdHFG
        P6LAqyp6DBx4RlArjgvZLHzVQRb5ANxavb6jBYaDRAe2F76sugp33mWVELGv/Wu45D6AjMRBOFl
        lSnxjKEkeZHEKMbdpgE++XhzCl5he2xce+k4wtr6Cmd2L2HGCsGxPM44dO4AS153QT9GMfQi45P
        1nRUdc8CIAGOPh63X82rwx3qAz5ZnGr5Sq0iUEv8AV1GBhqmj0M2hpsL/y19VZTTsdy9/aoQJ3C
        fybugIMwjq8xKmrAVp1ZPhBeP7MmoluoDRSwa5iwQHHIqcY683ifog+ULJA==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
        s=TM-DKIM-20210503141657; t=1692321630;
        bh=KN8wOw4n1b4CHCrTJvmvFzZuXcBNhYPax2ze23jATUA=; l=19435;
        h=From:To:Date;
        b=T/sCYKuUiFNPX3DJ4QQcF3cs7tlhncS/RUAa3lJ/zbFvkIqW9DaN+wQ6VPpJyalPx
         9jcBg6mmZ5DYbcwFv3FtiApDHG4NNH9+m9Lr8qQxPhMIDVi0iSLjnMdEhZL/LqkITs
         sXTn8u6wDuK8jycjZxMe7EiB2yYRNv/ToMbli1UL1Ooq04XNzUT3E0qAfubRSDIiSd
         U5ZDIEX52Z3ohU0j7qkRWGZrHJroGa+9EXeVWUIGIgwWPXirEs2Dec3GsVdDjwA6TU
         wuIKSzgIlE7SJWbw9FbRyBVFatD0GWxtUHZ4aJIEMMXuw8IfW8Vc/BF0tWHOVsGIwd
         e2/aIwM02QBbA==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expose the virtio_rtc clocks as PTP clocks to userspace, similar to
ptp_kvm. virtio_rtc can expose multiple clocks, e.g. a UTC clock and a
monotonic clock. Userspace should distinguish different clocks through the
name assigned by the driver. A udev rule such as the following can be used
to get a symlink /dev/ptp_virtio to the UTC clock:

	SUBSYSTEM=="ptp", ATTR{clock_name}=="Virtio PTP UTC", SYMLINK += "ptp_virtio"

The preferred PTP clock reading method is ioctl PTP_SYS_OFFSET_PRECISE2,
through the ptp_clock_info.getcrosststamp() op. For now,
PTP_SYS_OFFSET_PRECISE2 will return -EOPNOTSUPP through a weak function.
PTP_SYS_OFFSET_PRECISE2 requires cross-timestamping support for specific
clocksources, which will be added in the following. If the clocksource
specific code is enabled, check that the Virtio RTC device supports the
respective HW counter before obtaining an actual cross-timestamp from the
Virtio device.

The Virtio RTC device response time may be higher than the timekeeper
seqcount increment interval. Therefore, obtain the cross-timestamp before
calling get_device_system_crosststamp().

As a fallback, support the ioctl PTP_SYS_OFFSET_EXTENDED2 for all
platforms.

Assume that concurrency issues during PTP clock removal are avoided by the
posix_clock framework.

Kconfig recursive dependencies prevent virtio_rtc from implicitly enabling
PTP_1588_CLOCK, therefore just warn the user if PTP_1588_CLOCK is not
available. Since virtio_rtc should in the future also expose clocks as RTC
class devices, it should make sense to not have VIRTIO_RTC depend on
PTP_1588_CLOCK.

Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
---

Notes:
    v2:
    
    - Depend on prerequisite patch series "treewide: Use clocksource id for
      get_device_system_crosststamp()".
    
    - Check clocksource id before sending crosststamp message to device.
    
    - Do not support multiple hardware counters at runtime any more, since
      distinction of Arm physical and virtual counter appears unneeded after
      discussion with Marc Zyngier.

 drivers/virtio/Kconfig               |  16 ++
 drivers/virtio/Makefile              |   1 +
 drivers/virtio/virtio_rtc_driver.c   | 111 ++++++++-
 drivers/virtio/virtio_rtc_internal.h |  48 ++++
 drivers/virtio/virtio_rtc_ptp.c      | 347 +++++++++++++++++++++++++++
 5 files changed, 520 insertions(+), 3 deletions(-)
 create mode 100644 drivers/virtio/virtio_rtc_ptp.c

diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
index e3dbf16fa977..7369ecd7dd01 100644
--- a/drivers/virtio/Kconfig
+++ b/drivers/virtio/Kconfig
@@ -187,4 +187,20 @@ config VIRTIO_RTC
 
 	 If unsure, say M.
 
+comment "WARNING: The Virtio RTC driver is useless without VIRTIO_RTC_PTP."
+	depends on VIRTIO_RTC && !VIRTIO_RTC_PTP
+
+comment "Enable PTP_1588_CLOCK in order to enable VIRTIO_RTC_PTP."
+	depends on VIRTIO_RTC && PTP_1588_CLOCK=n
+
+config VIRTIO_RTC_PTP
+	bool "Virtio RTC PTP clocks"
+	default y
+	depends on VIRTIO_RTC && PTP_1588_CLOCK
+	help
+	 This exposes any Virtio RTC clocks as PTP Hardware Clocks (PHCs) to
+	 userspace.
+
+	 If unsure, say Y.
+
 endif # VIRTIO_MENU
diff --git a/drivers/virtio/Makefile b/drivers/virtio/Makefile
index f760414ed6ab..4d48cbcae6bb 100644
--- a/drivers/virtio/Makefile
+++ b/drivers/virtio/Makefile
@@ -14,3 +14,4 @@ obj-$(CONFIG_VIRTIO_MEM) += virtio_mem.o
 obj-$(CONFIG_VIRTIO_DMA_SHARED_BUFFER) += virtio_dma_buf.o
 obj-$(CONFIG_VIRTIO_RTC) += virtio_rtc.o
 virtio_rtc-y := virtio_rtc_driver.o
+virtio_rtc-$(CONFIG_VIRTIO_RTC_PTP) += virtio_rtc_ptp.o
diff --git a/drivers/virtio/virtio_rtc_driver.c b/drivers/virtio/virtio_rtc_driver.c
index 424500d2c4f7..3c11fa95b9a7 100644
--- a/drivers/virtio/virtio_rtc_driver.c
+++ b/drivers/virtio/virtio_rtc_driver.c
@@ -36,11 +36,16 @@ struct viortc_vq {
  * struct viortc_dev - virtio_rtc device data
  * @vdev: virtio device
  * @vqs: virtqueues
+ * @clocks_to_unregister: Clock references, which are only used during device
+ *                        removal.
+ *			  For other uses, there would be a race between device
+ *			  creation and setting the pointers here.
  * @num_clocks: # of virtio_rtc clocks
  */
 struct viortc_dev {
 	struct virtio_device *vdev;
 	struct viortc_vq vqs[VIORTC_MAX_NR_QUEUES];
+	struct viortc_ptp_clock **clocks_to_unregister;
 	u16 num_clocks;
 };
 
@@ -588,6 +593,89 @@ int viortc_cross_cap(struct viortc_dev *viortc, u64 vio_clk_id, u16 hw_counter,
  * init, deinit
  */
 
+/**
+ * viortc_init_clock() - init local representation of virtio_rtc clock (PHC)
+ * @viortc: device data
+ * @vio_clk_id: virtio_rtc clock id
+ *
+ * Context: Process context.
+ * Return: Zero on success, negative error code otherwise.
+ */
+static int viortc_init_clock(struct viortc_dev *viortc, u64 vio_clk_id)
+{
+	int ret;
+	u16 clock_type;
+	char ptp_clock_name[PTP_CLOCK_NAME_LEN];
+	const char *type_name;
+	/* fit prefix + u16 in decimal */
+	char type_name_buf[5 + 5 + 1];
+	bool has_xtstamp_feature;
+	struct viortc_ptp_clock *vio_ptp;
+	struct virtio_device *vdev = viortc->vdev;
+
+	ret = viortc_clock_cap(viortc, vio_clk_id, &clock_type);
+	if (ret)
+		return ret;
+
+	switch (clock_type) {
+	case VIRTIO_RTC_CLOCK_UTC:
+		type_name = "UTC";
+		break;
+	case VIRTIO_RTC_CLOCK_TAI:
+		type_name = "TAI";
+		break;
+	case VIRTIO_RTC_CLOCK_MONO:
+		type_name = "monotonic";
+		break;
+	default:
+		snprintf(type_name_buf, sizeof(type_name_buf), "type %hu",
+			 clock_type);
+		type_name = type_name_buf;
+	}
+
+	snprintf(ptp_clock_name, PTP_CLOCK_NAME_LEN, "Virtio PTP %s",
+		 type_name);
+
+	has_xtstamp_feature = virtio_has_feature(vdev, VIRTIO_RTC_F_READ_CROSS);
+
+	vio_ptp = viortc_ptp_register(viortc, &vdev->dev, vio_clk_id,
+				      ptp_clock_name, has_xtstamp_feature);
+	if (IS_ERR(vio_ptp)) {
+		dev_err(&vdev->dev, "failed to register PTP clock '%s'\n",
+			ptp_clock_name);
+		return PTR_ERR(vio_ptp);
+	}
+
+	viortc->clocks_to_unregister[vio_clk_id] = vio_ptp;
+
+	if (!vio_ptp)
+		dev_warn(&vdev->dev, "clock %llu is not exposed to userspace\n",
+			 vio_clk_id);
+
+	return 0;
+}
+
+/**
+ * viortc_clocks_exit() - unregister PHCs
+ * @viortc: device data
+ */
+static void viortc_clocks_exit(struct viortc_dev *viortc)
+{
+	unsigned int i;
+	struct viortc_ptp_clock *vio_ptp;
+
+	for (i = 0; i < viortc->num_clocks; i++) {
+		vio_ptp = viortc->clocks_to_unregister[i];
+
+		if (!vio_ptp)
+			continue;
+
+		viortc->clocks_to_unregister[i] = NULL;
+
+		WARN_ON(viortc_ptp_unregister(vio_ptp, &viortc->vdev->dev));
+	}
+}
+
 /**
  * viortc_clocks_init() - init local representations of virtio_rtc clocks
  * @viortc: device data
@@ -599,6 +687,7 @@ static int viortc_clocks_init(struct viortc_dev *viortc)
 {
 	int ret;
 	u16 num_clocks;
+	unsigned int i;
 
 	ret = viortc_cfg(viortc, &num_clocks);
 	if (ret)
@@ -611,10 +700,24 @@ static int viortc_clocks_init(struct viortc_dev *viortc)
 
 	viortc->num_clocks = num_clocks;
 
-	/* In the future, PTP clocks will be initialized here. */
-	(void)viortc_clock_cap;
+	viortc->clocks_to_unregister =
+		devm_kcalloc(&viortc->vdev->dev, num_clocks,
+			     sizeof(*viortc->clocks_to_unregister), GFP_KERNEL);
+	if (!viortc->clocks_to_unregister)
+		return -ENOMEM;
+
+	for (i = 0; i < num_clocks; i++) {
+		ret = viortc_init_clock(viortc, i);
+		if (ret)
+			goto err_free_clocks;
+	}
 
 	return 0;
+
+err_free_clocks:
+	viortc_clocks_exit(viortc);
+
+	return ret;
 }
 
 /**
@@ -703,7 +806,9 @@ static int viortc_probe(struct virtio_device *vdev)
  */
 static void viortc_remove(struct virtio_device *vdev)
 {
-	/* In the future, PTP clocks will be deinitialized here. */
+	struct viortc_dev *viortc = vdev->priv;
+
+	viortc_clocks_exit(viortc);
 
 	virtio_reset_device(vdev);
 	vdev->config->del_vqs(vdev);
diff --git a/drivers/virtio/virtio_rtc_internal.h b/drivers/virtio/virtio_rtc_internal.h
index c2b5387f506f..ccf621a749da 100644
--- a/drivers/virtio/virtio_rtc_internal.h
+++ b/drivers/virtio/virtio_rtc_internal.h
@@ -9,6 +9,7 @@
 #define _VIRTIO_RTC_INTERNAL_H_
 
 #include <linux/types.h>
+#include <linux/ptp_clock_kernel.h>
 
 /* driver core IFs */
 
@@ -20,4 +21,51 @@ int viortc_read_cross(struct viortc_dev *viortc, u64 vio_clk_id, u16 hw_counter,
 int viortc_cross_cap(struct viortc_dev *viortc, u64 vio_clk_id, u16 hw_counter,
 		     bool *supported);
 
+/* PTP IFs */
+
+struct viortc_ptp_clock;
+
+#if IS_ENABLED(CONFIG_VIRTIO_RTC_PTP)
+
+struct viortc_ptp_clock *viortc_ptp_register(struct viortc_dev *viortc,
+					     struct device *parent_dev,
+					     u64 vio_clk_id,
+					     const char *ptp_clock_name,
+					     bool try_enable_xtstamp);
+int viortc_ptp_unregister(struct viortc_ptp_clock *vio_ptp,
+			  struct device *parent_dev);
+
+#else
+
+static inline struct viortc_ptp_clock *
+viortc_ptp_register(struct viortc_dev *viortc, struct device *parent_dev,
+		    u64 vio_clk_id, const char *ptp_clock_name,
+		    bool try_enable_xtstamp)
+{
+	return NULL;
+}
+
+int viortc_ptp_unregister(struct viortc_ptp_clock *vio_ptp,
+			  struct device *parent_dev)
+{
+	return -ENODEV;
+}
+
+#endif
+
+/* HW counter IFs */
+
+/**
+ * viortc_hw_xtstamp_params() - get HW-specific xtstamp params
+ * @hw_counter: virtio_rtc HW counter type
+ * @cs_id: clocksource id corresponding to hw_counter
+ *
+ * Gets the HW-specific xtstamp params. Returns an error if the driver cannot
+ * support xtstamp.
+ *
+ * Context: Process context.
+ * Return: Zero on success, negative error code otherwise.
+ */
+int viortc_hw_xtstamp_params(u16 *hw_counter, enum clocksource_ids *cs_id);
+
 #endif /* _VIRTIO_RTC_INTERNAL_H_ */
diff --git a/drivers/virtio/virtio_rtc_ptp.c b/drivers/virtio/virtio_rtc_ptp.c
new file mode 100644
index 000000000000..c79544d13a64
--- /dev/null
+++ b/drivers/virtio/virtio_rtc_ptp.c
@@ -0,0 +1,347 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Expose virtio_rtc clocks as PTP clocks.
+ *
+ * Copyright (C) 2022-2023 OpenSynergy GmbH
+ *
+ * Derived from ptp_kvm_common.c, virtual PTP 1588 clock for use with KVM
+ * guests.
+ *
+ * Copyright (C) 2017 Red Hat Inc.
+ */
+
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/ptp_clock_kernel.h>
+
+#include <uapi/linux/virtio_rtc.h>
+
+#include "virtio_rtc_internal.h"
+
+/**
+ * struct viortc_ptp_clock - PTP clock abstraction
+ * @vio_clk_id: virtio_rtc clock id
+ * @ptp_clock: PTP clock handle
+ * @viortc: virtio_rtc device data
+ * @ptp_info: PTP clock description
+ * @have_cross: device supports crosststamp with available HW counter
+ */
+struct viortc_ptp_clock {
+	u64 vio_clk_id;
+	struct ptp_clock *ptp_clock;
+	struct viortc_dev *viortc;
+	struct ptp_clock_info ptp_info;
+	bool have_cross;
+};
+
+/**
+ * struct viortc_ptp_cross_ctx - context for get_device_system_crosststamp()
+ * @device_time: device clock reading
+ * @system_counterval: HW counter value at device_time
+ *
+ * Provides the already obtained crosststamp to get_device_system_crosststamp().
+ */
+struct viortc_ptp_cross_ctx {
+	ktime_t device_time;
+	struct system_counterval_t system_counterval;
+};
+
+/* Weak functions in case get_device_system_crosststamp() is not supported */
+
+int __weak viortc_hw_xtstamp_params(u16 *hw_counter,
+				    enum clocksource_ids *cs_id)
+{
+	return -EOPNOTSUPP;
+}
+
+/**
+ * viortc_ptp_get_time_fn() - callback for get_device_system_crosststamp()
+ * @device_time: device clock reading
+ * @system_counterval: HW counter value at device_time
+ * @ctx: context with already obtained crosststamp
+ *
+ * Return: zero (success).
+ */
+static int viortc_ptp_get_time_fn(ktime_t *device_time,
+				  struct system_counterval_t *system_counterval,
+				  void *ctx)
+{
+	struct viortc_ptp_cross_ctx *vio_ctx = ctx;
+
+	*device_time = vio_ctx->device_time;
+	*system_counterval = vio_ctx->system_counterval;
+
+	return 0;
+}
+
+/**
+ * viortc_ptp_do_xtstamp() - get crosststamp from device
+ * @vio_ptp: virtio_rtc PTP clock
+ * @ctx: context for get_device_system_crosststamp()
+ *
+ * Reads HW-specific crosststamp from device.
+ *
+ * Context: Process context.
+ * Return: Zero on success, negative error code otherwise.
+ */
+static int viortc_ptp_do_xtstamp(struct viortc_ptp_clock *vio_ptp,
+				 struct viortc_ptp_cross_ctx *ctx,
+				 u16 hw_counter, enum clocksource_ids cs_id)
+{
+	u64 ns;
+	u64 max_ns;
+	int ret;
+
+	ctx->system_counterval.cs_id = cs_id;
+
+	ret = viortc_read_cross(vio_ptp->viortc, vio_ptp->vio_clk_id,
+				hw_counter, &ns,
+				&ctx->system_counterval.cycles);
+	if (ret)
+		return ret;
+
+	max_ns = (u64)ktime_to_ns(KTIME_MAX);
+	if (ns > max_ns)
+		return -EINVAL;
+
+	ctx->device_time = ns_to_ktime(ns);
+
+	return 0;
+}
+
+/*
+ * PTP clock operations
+ */
+
+/**
+ * viortc_ptp_getcrosststamp() - PTP clock getcrosststamp op
+ * @vio_ptp: virtio_rtc PTP clock
+ * @xtstamp: crosststamp
+ *
+ * Context: Process context.
+ * Return: Zero on success, negative error code otherwise.
+ */
+static int viortc_ptp_getcrosststamp(struct ptp_clock_info *ptp,
+				     struct system_device_crosststamp *xtstamp)
+{
+	struct viortc_ptp_clock *vio_ptp =
+		container_of(ptp, struct viortc_ptp_clock, ptp_info);
+	int ret;
+	struct system_time_snapshot history_begin;
+	struct viortc_ptp_cross_ctx ctx;
+	enum clocksource_ids cs_id;
+	u16 hw_counter;
+
+	if (!vio_ptp->have_cross)
+		return -EOPNOTSUPP;
+
+	ret = viortc_hw_xtstamp_params(&hw_counter, &cs_id);
+	if (ret)
+		return ret;
+
+	ktime_get_snapshot(&history_begin);
+	if (history_begin.cs_id != cs_id)
+		return -EOPNOTSUPP;
+
+	/*
+	 * Getting the timestamp can take many milliseconds with a slow Virtio
+	 * device. This is too long for viortc_ptp_get_time_fn() passed to
+	 * get_device_system_crosststamp(), which has to usually return before
+	 * the timekeeper seqcount increases (every tick or so).
+	 *
+	 * So, get the actual cross-timestamp first.
+	 */
+	ret = viortc_ptp_do_xtstamp(vio_ptp, &ctx, hw_counter, cs_id);
+	if (ret)
+		return ret;
+
+	ret = get_device_system_crosststamp(viortc_ptp_get_time_fn, &ctx,
+					    &history_begin, xtstamp);
+	if (ret) {
+		pr_debug("%s: get_device_system_crosststamp() returned %d\n",
+			 __func__, ret);
+	}
+
+	return ret;
+}
+
+/** viortc_ptp_adjfine() - unsupported PTP clock adjfine op */
+static int viortc_ptp_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
+{
+	return -EOPNOTSUPP;
+}
+
+/** viortc_ptp_adjtime() - unsupported PTP clock adjtime op */
+static int viortc_ptp_adjtime(struct ptp_clock_info *ptp, s64 delta)
+{
+	return -EOPNOTSUPP;
+}
+
+/** viortc_ptp_settime64() - unsupported PTP clock settime64 op */
+static int viortc_ptp_settime64(struct ptp_clock_info *ptp,
+				const struct timespec64 *ts)
+{
+	return -EOPNOTSUPP;
+}
+
+/**
+ * viortc_ptp_gettimex64() - PTP clock gettimex64 op
+ *
+ * Context: Process context.
+ */
+static int viortc_ptp_gettimex64(struct ptp_clock_info *ptp,
+				 struct timespec64 *ts,
+				 struct ptp_system_timestamp *sts)
+{
+	struct viortc_ptp_clock *vio_ptp =
+		container_of(ptp, struct viortc_ptp_clock, ptp_info);
+	u64 ns;
+	int ret;
+
+	ptp_read_system_prets(sts);
+	ret = viortc_read(vio_ptp->viortc, vio_ptp->vio_clk_id, &ns);
+	ptp_read_system_postts(sts);
+
+	if (ret)
+		return ret;
+
+	if (ns > (u64)S64_MAX)
+		return -EINVAL;
+
+	*ts = ns_to_timespec64((s64)ns);
+
+	return 0;
+}
+
+/** viortc_ptp_enable() - unsupported PTP clock enable op */
+static int viortc_ptp_enable(struct ptp_clock_info *ptp,
+			     struct ptp_clock_request *rq, int on)
+{
+	return -EOPNOTSUPP;
+}
+
+/**
+ * viortc_ptp_info_template - ptp_clock_info template
+ *
+ * The .name member will be set for individual virtio_rtc PTP clocks.
+ */
+static const struct ptp_clock_info viortc_ptp_info_template = {
+	.owner = THIS_MODULE,
+	/* .name is set according to clock type */
+	.adjfine = viortc_ptp_adjfine,
+	.adjtime = viortc_ptp_adjtime,
+	.gettimex64 = viortc_ptp_gettimex64,
+	.settime64 = viortc_ptp_settime64,
+	.enable = viortc_ptp_enable,
+	.getcrosststamp = viortc_ptp_getcrosststamp,
+};
+
+/**
+ * viortc_ptp_unregister() - PTP clock unregistering wrapper
+ * @vio_ptp: virtio_rtc PTP clock
+ * @parent_dev: parent device of PTP clock
+ *
+ * Return: Zero on success, negative error code otherwise.
+ */
+int viortc_ptp_unregister(struct viortc_ptp_clock *vio_ptp,
+			  struct device *parent_dev)
+{
+	int ret = ptp_clock_unregister(vio_ptp->ptp_clock);
+
+	if (!ret)
+		devm_kfree(parent_dev, vio_ptp);
+
+	return ret;
+}
+
+/**
+ * viortc_ptp_get_cross_cap() - get xtstamp support info from device
+ * @viortc: virtio_rtc device data
+ * @vio_ptp: virtio_rtc PTP clock abstraction
+ *
+ * Context: Process context.
+ * Return: Zero on success, negative error code otherwise.
+ */
+static int viortc_ptp_get_cross_cap(struct viortc_dev *viortc,
+				    struct viortc_ptp_clock *vio_ptp)
+{
+	int ret;
+	enum clocksource_ids cs_id;
+	u16 hw_counter;
+	bool xtstamp_supported;
+
+	ret = viortc_hw_xtstamp_params(&hw_counter, &cs_id);
+	if (ret) {
+		vio_ptp->have_cross = false;
+		return 0;
+	}
+	(void)cs_id;
+
+	ret = viortc_cross_cap(viortc, vio_ptp->vio_clk_id, hw_counter,
+			       &xtstamp_supported);
+	if (ret)
+		return ret;
+
+	vio_ptp->have_cross = xtstamp_supported;
+
+	return 0;
+}
+
+/**
+ * viortc_ptp_register() - prepare and register PTP clock
+ * @viortc: virtio_rtc device data
+ * @parent_dev: parent device for PTP clock
+ * @vio_clk_id: id of virtio_rtc clock which backs PTP clock
+ * @ptp_clock_name: PTP clock name
+ * @try_enable_xtstamp: enable xtstamp op, if available
+ *
+ * Context: Process context.
+ * Return: Pointer on success, ERR_PTR() otherwise; NULL if PTP clock support
+ *         not available.
+ */
+struct viortc_ptp_clock *viortc_ptp_register(struct viortc_dev *viortc,
+					     struct device *parent_dev,
+					     u64 vio_clk_id,
+					     const char *ptp_clock_name,
+					     bool try_enable_xtstamp)
+{
+	struct viortc_ptp_clock *vio_ptp;
+	struct ptp_clock *ptp_clock;
+	ssize_t len;
+	int ret;
+
+	vio_ptp = devm_kzalloc(parent_dev, sizeof(*vio_ptp), GFP_KERNEL);
+	if (!vio_ptp)
+		return ERR_PTR(-ENOMEM);
+
+	vio_ptp->viortc = viortc;
+	vio_ptp->vio_clk_id = vio_clk_id;
+	vio_ptp->ptp_info = viortc_ptp_info_template;
+	len = strscpy(vio_ptp->ptp_info.name, ptp_clock_name,
+		      sizeof(vio_ptp->ptp_info.name));
+	if (len < 0) {
+		ret = len;
+		goto err_free_dev;
+	}
+
+	if (try_enable_xtstamp) {
+		ret = viortc_ptp_get_cross_cap(viortc, vio_ptp);
+		if (ret)
+			goto err_free_dev;
+	}
+
+	ptp_clock = ptp_clock_register(&vio_ptp->ptp_info, parent_dev);
+	if (IS_ERR(ptp_clock))
+		goto err_on_register;
+
+	vio_ptp->ptp_clock = ptp_clock;
+
+	return vio_ptp;
+
+err_on_register:
+	ret = PTR_ERR(ptp_clock);
+
+err_free_dev:
+	devm_kfree(parent_dev, vio_ptp);
+	return ERR_PTR(ret);
+}
-- 
2.39.2

