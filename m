Return-Path: <linux-kernel+bounces-3118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E432181679E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 08:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AE061F21169
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 07:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6307D12B89;
	Mon, 18 Dec 2023 07:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b="H0fLhR/H"
X-Original-To: linux-kernel@vger.kernel.org
Received: from refb01.tmes.trendmicro.eu (refb01.tmes.trendmicro.eu [18.185.115.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1754D1079A
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 07:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensynergy.com
Received: from 104.47.7.168_.trendmicro.com (unknown [172.21.19.198])
	by refb01.tmes.trendmicro.eu (Postfix) with ESMTPS id 5640210B375C2
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 07:40:56 +0000 (UTC)
Received: from 104.47.7.168_.trendmicro.com (unknown [172.21.199.136])
	by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 3790310000C2F;
	Mon, 18 Dec 2023 07:40:49 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1702885248.524000
X-TM-MAIL-UUID: 25eae262-8632-49cc-ab01-ae3864541886
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (unknown [104.47.7.168])
	by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id 800C810000E27;
	Mon, 18 Dec 2023 07:40:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C6kbiQ6fnh5HHTU3odyBsR9pF3Q1FutO5fm2kpzUEoAwkmq7kGxWhxHbN70YhHtgPrfz2gVntvuMDLaEJ7S5RJM3D/eCm22J65q5cDgh2s2Vb+iB5BztlxfQtxPeuwiF3UDWSMFWHQamQFfs3fobbrCAbi/Vd9LEOLClF8ccPj+zknH/fzfepIDX0yv6nPxH7yjA+QXeoDXfxx4zrsE9h/HwfhZC6h0dN9HIwtTgkOXTftQAUQjiHIyipXdeTgNVuopp5lAlBqFZ7+UMMPyZS9O8bZMfmrYGwSRLhqB9fzOIEQ/Iko5BWovPKJEfnMXb7e/fTxyDUwo+fJ875RKsVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1StdKZOEhSHpd4g5bnliwSpc7ybHZgpRcNTDlpLxVW8=;
 b=IXlZpADEUzjBEVSNl/sMCKjiQunviy7eawOPKzoIJrnmXpw+R76j8Tb500jfpbLqItoixybg+YkW8LQnaqfg3CGqjaHIYB//9LSk7W9S8gBrfKNv0u4cTO3iwBnXB8I0mIaCEzCeAanT7yADYX17T+hHWtWkgUJon72R9Yx9RIzV8eQGD8LnmkSuzhFpCa5gquqD8KTUasFWMP5rVIYDbs4G0wAPdliyyYbRFJAsqMHMtG1X9Co/sw9qs+pQGnlwrNk/x2mAceVT1MMctINqe2IeSwQaTAMlPBa/lOqFypugvPvKYnZ2782e6TRtmwc1e2a1u9A9E/TMiLs8BwYAaQ==
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
	linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH v3 5/7] virtio_rtc: Add PTP clocks
Date: Mon, 18 Dec 2023 08:38:43 +0100
Message-Id: <20231218073849.35294-6-peter.hilber@opensynergy.com>
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
X-MS-TrafficTypeDiagnostic: VI1EUR05FT024:EE_|FRYP281MB2285:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ab43eca4-4bf5-4a88-ca17-08dbff9ca5bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Dqp20AZwGNI0CPtT+UB+vD7hiKb2iVHLHWQ3MNYevKceb2JaLfyTALh0SqFXjfDx1Y4KhjOllGgZ+hkTKmnl8wKB3LjqGgc3PUqrnYZULWgXHql9tDBol083FI4D4WDRnlSn5Gw4j2edbvyMBpKgDUjb1Mt+TnpNnF9fQLtpL9/YIddkAk7kG0NHXkafRzaw3v/FaQ4cvpd+xvg0Y/m/USi/tR65qltyCo8xpvMzj2M0EGg4icAWWXUGmH781cX+BsywHuWeTzeOl0RXwUHy8pFCbMrMMFrr2QOQNfaYCPXYewSBYXfxOqjw3QksL8Be48uFZ2wuwGlvBjGXbnuvtXIrSSfQxUW2NAx8nQoNen7zKyNRRxI1nkYOu7Wc4QHTg7pzq3Nggra174KB5AURG8mX+4RY6/czBxEoAHj5d/O5T5Z9uX4VpJ/u5mqNzNW6IoySV84zWPT1hFVYyOgMBWni/wfKLOo70GufpbzvP/TqnJU4FV+IZc0lvbkBCH5+lWTG3E4XwMtZMyzCn2C/PPwpAkqQhVHvCDCa0KAOtWLwmL9+o0e1VSEBIgEBP7yhua7/Ox/qikX+KM8lbSYaWalQVReX6setsLto3M0l/lDfVwHEvlpIGMknUtxuCsG1EheVKguvBnMSkKh5lojGUYNsgO21IKQrBv8DLDtG9rbpWW/uMvwdDA/gRfXBjUMbTh8NFrzTEFtunacLoo6VIkM8JQ2mjyWU4mOjSUx+1Z75qz3EqV3pvNMsq4uljm7UxjSJRObVWtaw9Xt1gDDojVhMWjioPmMJ4VAg3rON3/EDEXKBl2QX1SC0EHRKJWJ4glphS0EoJGTOV7ARDHuwrQ==
X-Forefront-Antispam-Report:
	CIP:217.66.60.4;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SR-MAIL-03.open-synergy.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(136003)(39840400004)(230922051799003)(230173577357003)(230273577357003)(82310400011)(64100799003)(1800799012)(186009)(451199024)(36840700001)(46966006)(40480700001)(70586007)(86362001)(81166007)(36756003)(316002)(36860700001)(26005)(2616005)(83380400001)(47076005)(1076003)(336012)(478600001)(2906002)(30864003)(54906003)(42186006)(70206006)(5660300002)(8676002)(4326008)(8936002)(7416002)(44832011)(41300700001)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 07:40:46.2910
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab43eca4-4bf5-4a88-ca17-08dbff9ca5bf
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=800fae25-9b1b-4edc-993d-c939c4e84a64;Ip=[217.66.60.4];Helo=[SR-MAIL-03.open-synergy.com]
X-MS-Exchange-CrossTenant-AuthSource:
	VI1EUR05FT024.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRYP281MB2285
X-TM-AS-ERS: 104.47.7.168-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-28064.005
X-TMASE-Result: 10--21.325500-4.000000
X-TMASE-MatchedRID: 2kGot8vQMiMY9bhGrdH9F9wy9mwTudtiRyG5SSR7mMGmopAzNrNOJn+F
	psIKKIVlk8IAUKtJYbMmnuaVQc5qV4oSaqhQo1toHW+C8sNk3WDFZzmk4ajzuCe5CWghtIzPb1O
	21F3h9PlzEFhMBQYFa/6kCjQkL+3Saroq2fxRivXHfwwbjh/dN1pMWq1GqY9ju/MvHv8cqImjxj
	+USeWICAX/qC69skJNMMrUUp1wb2VcV4l6mBSRB4gBJ2REjJVpgz5VmKZ8x87hCm8am+SP54vPi
	Bq/iW91MpPx8OFzfY0ZvOplNriRSZNrG/k+iz71sX4aFYAMIYMH/MsNCRnylfdjLuGFwc5lKq+K
	d6L61hF4tsh0iB6GbJB2/4Zk/kdWbc6z6hWXfyJ4ZqfDdG89Lhwr5LLKUXeOj8v426/NdLLWnmC
	QJIfHDBHANFoXrZpZGVpXbIDItBH3wLs+FSaf2UgfObGUdKnYnVW5D6U48feW56JO955kYFJNns
	bht/io0d8wVypPKQL96AoZAp2e8GgglWUFUjT3T+vZ3ApQRadQKm83vawLhOZb2thtW+nUrNM+r
	nFOGvZMwliXkYTsHQSQKEUpr4ba//lyRKkbk7rUT+gPVIJo9wzQf42ldnd7ijEMAGpMmld/kU2H
	5OXFVazBcn//fMoK6xA0Ava73nAPm15xyht8lXx2eIlQG1sMfC4IwOLvyucC4DhlAS07elo7GmC
	OJYd1AqYBE3k9Mpw=
X-TMASE-XGENCLOUD: 27111c8c-4602-4731-9fc0-fbea16473411-0-0-200-0
X-TM-Deliver-Signature: 169D64F23498B905EE744F478B3C02D0
X-TM-Addin-Auth: yto/9jN21XddCFvkohIG+Sbq3Q8zSTqnlQLf+PnGBnDN9YOoRakO2dJr/ZE
	07L1x1hhYsdu9IwHjBF25p20sOa38buGH32UWKnKl02kmPb0L36x9FY6q3kJJ5agvwFVagEQy7o
	0ujWpgIN2AcUtzNyy+9RfUl8W5+Ofrj3SyhzMYMyv+UUncLJYNxQt37AV1rqCV3lRus9fCEY3wc
	kPQVpkAX2hx0OO1rJOaKgMMtc9wwAIjbxCetFgGf4C2pVLWWsWvUOTnDorUyEALqN2CNuB6hUUs
	cAoWUY2wL+aQGro=.3ImFcXDkcCA2In7iZLEEPnxStOi4xjNCsrdKOEQ9PqFsUMclUJV18RrzZH
	+I3RsCZjBG7EaWNqdnPp8sNaxR6jU/+WEjyvToT/A6jU1JvOD7brHs8nvIhlvzBOmh39ojROwMN
	bAVtWA+9MIs0oBGIQjRWT5fWoXgLuKeQTUQphY8BBHSJVnT9E9frOjS2HG5sXDVZP2g33W2WaTb
	YR6C2WFEdjpTy5k/o2fxHZ9gYadl/4KwRVI9NIMAkHtI8HUxDt8Tq6KJmcrc+oul7iL2I/WY/G2
	dPhtQfZj1mYifxK3NodRavOFIIqt+tT+/AnXBeJZMM5CKOERAhLLAaOdlZg==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
	s=TM-DKIM-20210503141657; t=1702885249;
	bh=aTm1DW57gLEsef7Sllsfu+XvPKCKzaeU5XR9q3DkYDQ=; l=20262;
	h=From:To:Date;
	b=H0fLhR/HRexVgeg/gmp0Ni91QA5B4f5R0/XGCDo/TfIvdCkt54W22YcLJqolPS0ah
	 8rFjYiG/pGXiNlHLfNTlbbNaTtSHeKkJbJahJfssA9gmhV5VGmffEwPCxPIpdjpZaW
	 0S2W6d2WWImZVvdupKJaElRzih1VXUrM2Cd1DUP0svpEm0H1Eq7woCPHCTvFnhAM4q
	 cdnWA2KOotPtgaY0dZM1KhbRu/2VlimpnGumWionfsfHOCXySOPvNAi/omVCbhMj6x
	 OxL7V7FF5p1vBIcwkDsnv3vwz39eeKMXR62ziVSpsvlW3YK8KujVQPTwxPPHbrGrTY
	 XAQVYHa/47z2Q==

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
class devices, do not have VIRTIO_RTC depend on PTP_1588_CLOCK.

Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
---

Notes:
    v3:
    
    - don't guard cross-timestamping with feature bit (spec v3)
    
    - reduce clock id to 16 bits (spec v3)
    
    v2:
    
    - Depend on prerequisite patch series "treewide: Use clocksource id for
      get_device_system_crosststamp()".
    
    - Check clocksource id before sending crosststamp message to device.
    
    - Do not support multiple hardware counters at runtime any more, since
      distinction of Arm physical and virtual counter appears unneeded after
      discussion with Marc Zyngier.

 drivers/virtio/Kconfig               |  23 +-
 drivers/virtio/Makefile              |   1 +
 drivers/virtio/virtio_rtc_driver.c   | 131 +++++++++-
 drivers/virtio/virtio_rtc_internal.h |  46 ++++
 drivers/virtio/virtio_rtc_ptp.c      | 342 +++++++++++++++++++++++++++
 5 files changed, 539 insertions(+), 4 deletions(-)
 create mode 100644 drivers/virtio/virtio_rtc_ptp.c

diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
index 834dd14bc070..8542b2f20201 100644
--- a/drivers/virtio/Kconfig
+++ b/drivers/virtio/Kconfig
@@ -179,11 +179,32 @@ config VIRTIO_RTC
 	depends on PTP_1588_CLOCK_OPTIONAL
 	help
 	 This driver provides current time from a Virtio RTC device. The driver
-	 provides the time through one or more clocks.
+	 provides the time through one or more clocks. The Virtio RTC PTP
+	 clocks must be enabled to expose the clocks to userspace.
 
 	 To compile this code as a module, choose M here: the module will be
 	 called virtio_rtc.
 
 	 If unsure, say M.
 
+if VIRTIO_RTC
+
+comment "WARNING: Consider enabling VIRTIO_RTC_PTP."
+	depends on !VIRTIO_RTC_PTP
+
+comment "Enable PTP_1588_CLOCK in order to enable VIRTIO_RTC_PTP."
+	depends on PTP_1588_CLOCK=n
+
+config VIRTIO_RTC_PTP
+	bool "Virtio RTC PTP clocks"
+	default y
+	depends on PTP_1588_CLOCK
+	help
+	 This exposes any Virtio RTC clocks as PTP Hardware Clocks (PHCs) to
+	 userspace.
+
+	 If unsure, say Y.
+
+endif # VIRTIO_RTC
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
index ef1ea14b3bec..c331b7383285 100644
--- a/drivers/virtio/virtio_rtc_driver.c
+++ b/drivers/virtio/virtio_rtc_driver.c
@@ -35,11 +35,16 @@ struct viortc_vq {
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
 
@@ -626,6 +631,109 @@ int viortc_cross_cap(struct viortc_dev *viortc, u16 vio_clk_id, u16 hw_counter,
  * init, deinit
  */
 
+/**
+ * viortc_init_ptp_clock() - init and register PTP clock
+ * @viortc: device data
+ * @vio_clk_id: virtio_rtc clock id
+ * @clock_type: virtio_rtc clock type
+ *
+ * Context: Process context.
+ * Return: Zero on success, negative error code otherwise.
+ */
+static int viortc_init_ptp_clock(struct viortc_dev *viortc, u16 vio_clk_id,
+				 u16 clock_type)
+{
+	struct device *dev = &viortc->vdev->dev;
+	char ptp_clock_name[PTP_CLOCK_NAME_LEN];
+	const char *type_name;
+	/* fit prefix + u16 in decimal */
+	char type_name_buf[5 + 5 + 1];
+	struct viortc_ptp_clock *vio_ptp;
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
+	vio_ptp = viortc_ptp_register(viortc, dev, vio_clk_id, ptp_clock_name);
+	if (IS_ERR(vio_ptp)) {
+		dev_err(dev, "failed to register PTP clock '%s'\n",
+			ptp_clock_name);
+		return PTR_ERR(vio_ptp);
+	}
+
+	viortc->clocks_to_unregister[vio_clk_id] = vio_ptp;
+
+	if (!vio_ptp)
+		dev_warn(dev, "clock %d is not exposed to userspace\n",
+			 vio_clk_id);
+
+	return 0;
+}
+
+/**
+ * viortc_init_clock() - init local representation of virtio_rtc clock
+ * @viortc: device data
+ * @vio_clk_id: virtio_rtc clock id
+ *
+ * Initializes PHC and/or RTC class device to represent virtio_rtc clock.
+ *
+ * Context: Process context.
+ * Return: Zero on success, negative error code otherwise.
+ */
+static int viortc_init_clock(struct viortc_dev *viortc, u16 vio_clk_id)
+{
+	u16 clock_type;
+	int ret;
+
+	ret = viortc_clock_cap(viortc, vio_clk_id, &clock_type);
+	if (ret)
+		return ret;
+
+	if (IS_ENABLED(CONFIG_VIRTIO_RTC_PTP)) {
+		ret = viortc_init_ptp_clock(viortc, vio_clk_id, clock_type);
+		if (ret)
+			return ret;
+	}
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
@@ -637,6 +745,7 @@ static int viortc_clocks_init(struct viortc_dev *viortc)
 {
 	int ret;
 	u16 num_clocks;
+	unsigned int i;
 
 	ret = viortc_cfg(viortc, &num_clocks);
 	if (ret)
@@ -649,8 +758,22 @@ static int viortc_clocks_init(struct viortc_dev *viortc)
 
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
+
+	return 0;
+
+err_free_clocks:
+	viortc_clocks_exit(viortc);
 
 	return ret;
 }
@@ -734,7 +857,9 @@ static int viortc_probe(struct virtio_device *vdev)
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
index 9267661b8030..0dedced4aeae 100644
--- a/drivers/virtio/virtio_rtc_internal.h
+++ b/drivers/virtio/virtio_rtc_internal.h
@@ -9,6 +9,7 @@
 #define _VIRTIO_RTC_INTERNAL_H_
 
 #include <linux/types.h>
+#include <linux/ptp_clock_kernel.h>
 
 /* driver core IFs */
 
@@ -20,4 +21,49 @@ int viortc_read_cross(struct viortc_dev *viortc, u16 vio_clk_id, u16 hw_counter,
 int viortc_cross_cap(struct viortc_dev *viortc, u16 vio_clk_id, u16 hw_counter,
 		     bool *supported);
 
+/* PTP IFs */
+
+struct viortc_ptp_clock;
+
+#if IS_ENABLED(CONFIG_VIRTIO_RTC_PTP)
+
+struct viortc_ptp_clock *viortc_ptp_register(struct viortc_dev *viortc,
+					     struct device *parent_dev,
+					     u16 vio_clk_id,
+					     const char *ptp_clock_name);
+int viortc_ptp_unregister(struct viortc_ptp_clock *vio_ptp,
+			  struct device *parent_dev);
+
+#else
+
+static inline struct viortc_ptp_clock *
+viortc_ptp_register(struct viortc_dev *viortc, struct device *parent_dev,
+		    u16 vio_clk_id, const char *ptp_clock_name)
+{
+	return NULL;
+}
+
+static inline int viortc_ptp_unregister(struct viortc_ptp_clock *vio_ptp,
+					struct device *parent_dev)
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
index 000000000000..4592cd070772
--- /dev/null
+++ b/drivers/virtio/virtio_rtc_ptp.c
@@ -0,0 +1,342 @@
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
+ * @ptp_clock: PTP clock handle
+ * @viortc: virtio_rtc device data
+ * @ptp_info: PTP clock description
+ * @vio_clk_id: virtio_rtc clock id
+ * @have_cross: device supports crosststamp with available HW counter
+ */
+struct viortc_ptp_clock {
+	struct ptp_clock *ptp_clock;
+	struct viortc_dev *viortc;
+	struct ptp_clock_info ptp_info;
+	u16 vio_clk_id;
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
+/* Weak function in case get_device_system_crosststamp() is not supported */
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
+ * @hw_counter: virtio_rtc HW counter type
+ * @cs_id: clocksource id corresponding to hw_counter
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
+	if (ret)
+		pr_debug("%s: get_device_system_crosststamp() returned %d\n",
+			 __func__, ret);
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
+ *
+ * Context: Process context.
+ * Return: Pointer on success, ERR_PTR() otherwise; NULL if PTP clock support
+ *         not available.
+ */
+struct viortc_ptp_clock *viortc_ptp_register(struct viortc_dev *viortc,
+					     struct device *parent_dev,
+					     u16 vio_clk_id,
+					     const char *ptp_clock_name)
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
+	ret = viortc_ptp_get_cross_cap(viortc, vio_ptp);
+	if (ret)
+		goto err_free_dev;
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
2.40.1


