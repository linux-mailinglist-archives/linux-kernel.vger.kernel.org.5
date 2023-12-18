Return-Path: <linux-kernel+bounces-3115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF243816797
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 08:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8721F282C87
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 07:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8040B11713;
	Mon, 18 Dec 2023 07:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b="UYtxa4fX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from refb01.tmes.trendmicro.eu (refb01.tmes.trendmicro.eu [18.185.115.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B64AF9EE
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 07:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensynergy.com
Received: from 104.47.7.169_.trendmicro.com (unknown [172.21.9.90])
	by refb01.tmes.trendmicro.eu (Postfix) with ESMTPS id 7B3C510B22ABF;
	Mon, 18 Dec 2023 07:40:54 +0000 (UTC)
Received: from 104.47.7.169_.trendmicro.com (unknown [172.21.199.136])
	by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 9C06D10000D11;
	Mon, 18 Dec 2023 07:40:47 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1702885245.012000
X-TM-MAIL-UUID: 28198508-2a03-4700-a5fa-aeca2680908b
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (unknown [104.47.7.169])
	by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id 033D410000E22;
	Mon, 18 Dec 2023 07:40:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KwzptlNe6b8J5quWdxoZcV1qIeOUDZ/6OMHeAsu1kfZwUEz6OcPmNaCuAGpVeqggA2Nbm8vcF0a97Ua4X/GMMp8ofdB3hfsdn/asBgvBDkitSYx7dxqfuZPXQuB0wQVvrag8lZjKNV7OGjVDwH4alb6eJA/JfJdIC+a4yHf1+mco2so4rYFwbLXIAjL/AUrCXGJXcvO8rCZX9y/wkl3mUYvrm7LXclptK0+9GQmerBkGuIktaYwaj+kbB7FM5w2dRvhK/SgyuWuiB32S2N2Aef2mBYRKqLa8JX7uaNI8TQuDK0Qpq7YQR0IP0dwGWq1mcA47wWsaSmnW3epytOXZMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d+hC6iohx4wnPIyijDMGAV39cYrod9gNtUyxP57qoWE=;
 b=J6gYyelz+zVvXHdS5jYEPWJb0iKE5WIvr7uUgpWMpc8SgOm8N2xI810caACVkO/cSMPHY1Gv5e1r4MGuxUVidhiY63WTRDIhZ1iMolG8YOxoyPaxQDiy8YbnDtF+PKXnh/sk5U29qPryDlnGz89n8xnSvwqWXNa3Fs+slTQBE55wa5R80IOVDO5K0pCiwJ4cgE98trNWFLpXh7TjCWdBzLjSTMrXpl2DCHqvM5ELVA31QaCCQMATSA5RI8PNbAextjWp+8ShP8f0AsigHFCkgCjHMuaUIMw2zO77pFAMNr871TSF8+35yhLuCiVq7nKhekjabcY19cLlZI7ibOeqBw==
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
	virtio-dev@lists.oasis-open.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rtc@vger.kernel.org
Cc: Peter Hilber <peter.hilber@opensynergy.com>,
	"Christopher S. Hall" <christopher.s.hall@intel.com>,
	Jason Wang <jasowang@redhat.com>,
	John Stultz <jstultz@google.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	netdev@vger.kernel.org,
	Richard Cochran <richardcochran@gmail.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Marc Zyngier <maz@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [RFC PATCH v3 0/7] Add virtio_rtc module and related changes
Date: Mon, 18 Dec 2023 08:38:38 +0100
Message-Id: <20231218073849.35294-1-peter.hilber@opensynergy.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1EUR05FT027:EE_|FR3P281MB1567:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 6451ae63-c410-4d78-794e-08dbff9ca3ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XETNSviSLuDUUElJVzMmExQYoGaeFAQSR35cET4DulS3gIxuclF0vWgHHVpxLQhNjmgobWf3vNUF54zIRXQpBNoM2reBq8DvNjY2bW8uh3LaxBTH+LFW6g/BZuwrJTq7VmmVIJUkINgxLgJXYYT7iUZhf4VSQLTapGFqmAjKd2fammrqnM4Ik3/JY05cFNbSXeGOS5qOV4A9ysKhnL0DVUwEusl5hlXJsyY163zM8o9lAig/hDt69F6ZqhuGQJKnZq6+Xcb/234VeY3RtQjt/yyHB8qWr03WobT9GayhWaKSCyhDxr5JQY0R8jUrl10lE6rfeP8hkaRqggAaABO7JOY/HjOoOGtiLSZop+xwqU3AfdNAfN1A8yunFHAxnzUYAX1S96KZBPCyN5+wBJHMyMErQnNLUw3BPqn2C2Sl3SkWaNQ7L+4by6IpXujmgT4gGfsjo/NR6VAEx10mf3B8Xg6hr7X7rF8ziqcu6CWGGtuM5/gW+rtPkoa2L7Xb+kzAyMW1umfaoRMBFk+xjf1n6BHKfR03BwrrwPs/AT/Y0t12OhaLq2bBbNBdxiHZ3AygrSHFL9biuH3x2v0YbhGJtbRtMYGOScWSqK5GVnAok7dCBjecEtxYBFjI25IF+/HyIEW2hHC24grWBSVoCjHFKH2Z4Tzz3k4Q9RSWRe5PjDJArHyxTU+6sgp7yuxdNT8PU8U7sFbeVOig3rvQiR7lHzI9YCXEh0AWLkejMUcj52UVNpDF2KIwYRyWl50k3l7OzRvqFkXnhI3+xLPmX9G84g==
X-Forefront-Antispam-Report:
	CIP:217.66.60.4;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SR-MAIL-03.open-synergy.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(396003)(39830400003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(82310400011)(46966006)(36840700001)(336012)(83380400001)(26005)(1076003)(2616005)(36860700001)(47076005)(4326008)(44832011)(41300700001)(7416002)(2906002)(966005)(478600001)(316002)(42186006)(54906003)(8936002)(8676002)(70206006)(70586007)(5660300002)(36756003)(86362001)(81166007)(40480700001)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 07:40:43.0474
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6451ae63-c410-4d78-794e-08dbff9ca3ce
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=800fae25-9b1b-4edc-993d-c939c4e84a64;Ip=[217.66.60.4];Helo=[SR-MAIL-03.open-synergy.com]
X-MS-Exchange-CrossTenant-AuthSource:
	VI1EUR05FT027.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR3P281MB1567
X-TM-AS-ERS: 104.47.7.169-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-28064.005
X-TMASE-Result: 10--27.729800-4.000000
X-TMASE-MatchedRID: sHskM9Mmy82jUFTkIPYrnGy53dw2JHQm59KGlOljPvtH7TVMOMpqUm9h
	cWbYdsjRBf+oLr2yQk1ErIfdBFneW1qm5HDlCqpj8efplxAjKten2i3kZizDsSimJVj5dukrr2U
	ZR/HJv/hBPzSMgZ5XbXWEMHF8clRqNVqd3XsX2Vb24vmE69obUusCZSpF32VZnFPS5wCjpHZswf
	mutPEm12mZiAX3CMRYwwYLyMb/oe607aCop6XLRHQK0rQOCABezmG9pmg8ncKP9mtBIkWXYyOOH
	pI1HwblQo3F0uWePB+seUtgw4Zmujr/DEybvAaNuva7QpapAo1H3ls04QB56HHs7RH0C1HiraqC
	v7pIOOJDFPIF0Vh5UPeAK/DlpM8DO8W+8t9FmIFzHmBtsVCbBGBG77R/t8gKPiYO7EHc52hlIvg
	AojhYfvez8J7InaCwBoXLchbhUqsDLvJy6pB8hY8Hmgwag40IZNsIhOcaMtCrUVp6ho4UsO/yMk
	wYZmJ20Tt5NrgaswT5PQU6uVMf/IiYtM5LMzdS+DE5zr5ahdwNi5sB0+4vp4HPZlxvWzUUji3yp
	wbXmz5aqC2oXMB+C+sQNAL2u95wD5teccobfJV8dniJUBtbDHwuCMDi78rnz6RkZznaT3nLIcKZ
	m0DMBN/upPexrMg4lExlQIQeRG0=
X-TMASE-XGENCLOUD: aea0283c-8fe3-410f-826f-59415184e9b2-0-0-200-0
X-TM-Deliver-Signature: 949930DF5805738B3EBE1D43A8096C15
X-TM-Addin-Auth: JH6ehlryyo1R2Fqa8f5NYKieqXGcw5xXseKW0gWmjsRlRCtTW8Y4pmA7dEj
	hYSFuS7SdEFIX3nB4bIy8qWP+Q38IIeKk185oNOM0pecA8Fopg432TX4ueqpN9dSzTkDDNnpCYB
	VSec8/9cUn3RZUiKX4PHQJPOmD0ue6BIjVW9BgixhlB3aIt30XVSESlQNLID4bf41Cy4CmJ+9BR
	mK6TG1amwuggSMe26iruPkwWxxrfcnYtciC+yMeVRFPtxfHBj1HldOUSm0in8fHbpixIgI+FWno
	cWwuiPY8d1rXdEs=.mW8rvV+XXobfiUeP94Zvl++x72hK7XmNS7GAyUUovNOoFjXzGxMqWrkIzM
	HrNTftZAvnlFSMr7endXcZkXbgw6o2D5BXzfSvNr4C/G2RHXxrzFfY0XgZZHWwAFIECpkZLVcVM
	iPxW48MjooZCirfN8GLuDFZiN7izR02QOSV+ACVxycNzU2dlzqFuBK2nbQy3OwW9A2Ge7urqHx5
	zyKUfzPZQ5JuA0JgweXzLkP5S5zN3FuLyBunBnwcR3Mt3GpM2vvbgI5TwMJoYLWOQu+fH6jE4Rp
	85zyGbJw3vtG8+rrpHo+I8vb4BczKMZM88DwL43JNvk8KvC9RIRtxc38F4g==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
	s=TM-DKIM-20210503141657; t=1702885247;
	bh=lxDkrX7xfSAlNDwA0i7tuOt26IU16OhJTJMSpS/9NAU=; l=9098;
	h=From:To:Date;
	b=UYtxa4fX/NUqJ4w1D/cNPh+Y7cjZPVHP3nwRW8t4IluWWYTbdFLQMzWQKlz2NMDei
	 a2tLVlgHLIfMmQNSr+3Acsvuki6Sm3PWdjAIfEG0yZ9aKHESNZnwox1vMw6kvyJfgt
	 X0otXE04Ox2rqxKs3/QrK/DoQ967ctPcrMUZmeLxyYLV8R2xdFgOJzBWx27onOyyUq
	 zqaKUBbiYxMBuMgl6KC8PpwPmffRQ/XNoNywW5XJ+HU3HjIVwQpDDtiFtfcy6imew7
	 duTgmZUGageZ7gfFicyHM0xDzsPmNfezSA38osVpR/R7ANoj0WldTU8hNHbGIHlqPj
	 BifmsspSUT2yw==

RFC v3 updates
--------------

This series implements a driver for a virtio-rtc device conforming to spec
RFC v3 [1]. It now includes an RTC class driver with alarm, in addition to
the PTP clock driver already present before.

This patch series depends on the patch series "treewide: Use clocksource id
for get_device_system_crosststamp()" [3]. Pull [4] to get the combined
series on top of mainline.

Overview
--------

This patch series adds the virtio_rtc module, and related bugfixes. The
virtio_rtc module implements a driver compatible with the proposed Virtio
RTC device specification [1]. The Virtio RTC (Real Time Clock) device
provides information about current time. The device can provide different
clocks, e.g. for the UTC or TAI time standards, or for physical time
elapsed since some past epoch. The driver can read the clocks with simple
or more accurate methods. Optionally, the driver can set an alarm.

The series first fixes some bugs in the get_device_system_crosststamp()
interpolation code, which is required for reliable virtio_rtc operation.
Then, add the virtio_rtc implementation.

For the Virtio RTC device, there is currently a proprietary implementation,
which has been used for provisional testing.

PTP clock interface
-------------------

virtio_rtc exposes clocks as PTP clocks to userspace, similar to ptp_kvm.
If both the Virtio RTC device and this driver have special support for the
current clocksource, time synchronization programs can use
cross-timestamping using ioctl PTP_SYS_OFFSET_PRECISE2 aka
PTP_SYS_OFFSET_PRECISE. Similar to ptp_kvm, system time synchronization
with single-digit ns precision is possible with a quiescent reference clock
(from the Virtio RTC device). This works even when the Virtio device
response is slow compared to ptp_kvm hypercalls.

The following illustrates a test using PTP_SYS_OFFSET_PRECISE, with
interspersed strace log and chrony [2] refclocks log, on arm64. In the
example, chrony tracks a virtio_rtc PTP clock ("PHCV", /dev/ptp0). The raw
offset between the virtio_rtc clock and CLOCK_REALTIME is 0 to 1 ns. At the
device side, the Virtio RTC device artificially delays both the clock read
request, and the response, by 50 ms. Cross-timestamp interpolation still
works with this delay. chrony also monitors a ptp_kvm clock ("PHCK",
/dev/ptp3) for comparison, which yields a similar offset.

	ioctl(5</dev/ptp3>, PTP_SYS_OFFSET_PRECISE, 0xffffe86691c8) = 0 <0.000329>
	===============================================================================
	   Date (UTC) Time         Refid  DP L P  Raw offset   Cooked offset      Disp.
	===============================================================================
	2023-06-29 18:49:55.595742 PHCK    0 N 0  1.000000e-09  8.717931e-10  5.500e-08
	2023-06-29 18:49:55.595742 PHCK    - N -       -        8.717931e-10  5.500e-08
	ioctl(6</dev/ptp0>, PTP_SYS_OFFSET_PRECISE, 0xffffe86691c8) = 0 <0.101545>
	2023-06-29 18:49:56.147766 PHCV    0 N 0  1.000000e-09  8.801870e-10  5.500e-08
	2023-06-29 18:49:56.147766 PHCV    - N -       -        8.801870e-10  5.500e-08
	ioctl(5</dev/ptp3>, PTP_SYS_OFFSET_PRECISE, 0xffffe86691c8) = 0 <0.000195>
	2023-06-29 18:49:56.202446 PHCK    0 N 0  1.000000e-09  7.364180e-10  5.500e-08
	2023-06-29 18:49:56.202446 PHCK    - N -       -        7.364180e-10  5.500e-08
	ioctl(6</dev/ptp0>, PTP_SYS_OFFSET_PRECISE, 0xffffe86691c8) = 0 <0.101484>
	2023-06-29 18:49:56.754641 PHCV    0 N 0  0.000000e+00 -2.617368e-10  5.500e-08
	2023-06-29 18:49:56.754641 PHCV    - N -       -       -2.617368e-10  5.500e-08
	ioctl(5</dev/ptp3>, PTP_SYS_OFFSET_PRECISE, 0xffffe86691c8) = 0 <0.000270>
	2023-06-29 18:49:56.809282 PHCK    0 N 0  1.000000e-09  7.779321e-10  5.500e-08
	2023-06-29 18:49:56.809282 PHCK    - N -       -        7.779321e-10  5.500e-08
	ioctl(6</dev/ptp0>, PTP_SYS_OFFSET_PRECISE, 0xffffe86691c8) = 0 <0.101510>
	2023-06-29 18:49:57.361376 PHCV    0 N 0  0.000000e+00 -2.198794e-10  5.500e-08
	2023-06-29 18:49:57.361376 PHCV    - N -       -       -2.198794e-10  5.500e-08

This patch series only adds special support for the Arm Generic Timer
clocksource. At the driver side, it should be easy to support more
clocksources.

Fallback PTP clock interface
----------------------------

Without special support for the current clocksource, time synchronization
programs can still use ioctl PTP_SYS_OFFSET_EXTENDED2 aka
PTP_SYS_OFFSET_EXTENDED. In this case, precision will generally be worse
and will depend on the Virtio device response characteristics.

The following illustrates a test using PTP_SYS_OFFSET_EXTENDED, with
interspersed strace log and chrony refclocks log, on x86-64 (with `ts'
values omitted):

	ioctl(5, PTP_SYS_OFFSET_EXTENDED, {n_samples=10, ts=OMITTED}) = 0
	===============================================================================
	   Date (UTC) Time         Refid  DP L P  Raw offset   Cooked offset      Disp.
	===============================================================================
	2023-06-28 14:11:26.697782 PHCV    0 N 0  3.318200e-05  3.450891e-05  4.611e-06
	2023-06-28 14:11:26.697782 PHCV    - N -       -        3.450891e-05  4.611e-06
	ioctl(5, PTP_SYS_OFFSET_EXTENDED, {n_samples=10, ts=OMITTED}) = 0
	2023-06-28 14:11:27.208763 PHCV    0 N 0 -3.792800e-05 -4.023965e-05  4.611e-06
	2023-06-28 14:11:27.208763 PHCV    - N -       -       -4.023965e-05  4.611e-06
	ioctl(5, PTP_SYS_OFFSET_EXTENDED, {n_samples=10, ts=OMITTED}) = 0
	2023-06-28 14:11:27.722818 PHCV    0 N 0 -3.328600e-05 -3.134404e-05  4.611e-06
	2023-06-28 14:11:27.722818 PHCV    - N -       -       -3.134404e-05  4.611e-06
	ioctl(5, PTP_SYS_OFFSET_EXTENDED, {n_samples=10, ts=OMITTED}) = 0
	2023-06-28 14:11:28.233572 PHCV    0 N 0 -4.966900e-05 -4.584331e-05  4.611e-06
	2023-06-28 14:11:28.233572 PHCV    - N -       -       -4.584331e-05  4.611e-06
	ioctl(5, PTP_SYS_OFFSET_EXTENDED, {n_samples=10, ts=OMITTED}) = 0
	2023-06-28 14:11:28.742737 PHCV    0 N 0  4.902700e-05  5.361388e-05  4.611e-06
	2023-06-28 14:11:28.742737 PHCV    - N -       -        5.361388e-05  4.611e-06

PTP clock setup
---------------

The following udev rule can be used to get a symlink /dev/ptp_virtio to the
UTC clock:

	SUBSYSTEM=="ptp", ATTR{clock_name}=="Virtio PTP UTC", SYMLINK += "ptp_virtio"

The following chrony configuration directive can then be added in
/etc/chrony/chrony.conf to synchronize to the Virtio UTC clock:

	refclock PHC /dev/ptp_virtio refid PHCV poll -1 dpoll -1

RTC interface
-------------

This patch series adds virtio_rtc as a generic Virtio driver, including
both a PTP clock driver and an RTC class driver.

Feedback is greatly appreciated.

[1] https://lore.kernel.org/virtio-comment/20231218064253.9734-1-peter.hilber@opensynergy.com/
[2] https://chrony.tuxfamily.org/
[3] https://lore.kernel.org/lkml/20231215220612.173603-1-peter.hilber@opensynergy.com/
[4] https://github.com/OpenSynergy/linux.git virtio-rtc-v3-on-master

v3:

- Update to conform to virtio spec RFC v3 (no significant behavioral
  changes).

- Add RTC class driver with alarm according to virtio spec RFC v3.

- For cross-timestamp corner case fix, switch back to v1 style closed
  interval test (Thomas Gleixner).

v2:

- Depend on patch series "treewide: Use clocksource id for
  get_device_system_crosststamp()" to avoid requiring a clocksource pointer
  with get_device_system_crosststamp().

- Assume Arm Generic Timer will use CP15 virtual counter. Drop
  arm_arch_timer helper functions (Marc Zyngier).

- Improve cross-timestamp fixes problem description and implementation
  (John Stultz).


Peter Hilber (7):
  timekeeping: Fix cross-timestamp interpolation on counter wrap
  timekeeping: Fix cross-timestamp interpolation corner case decision
  timekeeping: Fix cross-timestamp interpolation for non-x86
  virtio_rtc: Add module and driver core
  virtio_rtc: Add PTP clocks
  virtio_rtc: Add Arm Generic Timer cross-timestamping
  virtio_rtc: Add RTC class driver

 MAINTAINERS                          |    7 +
 drivers/virtio/Kconfig               |   62 ++
 drivers/virtio/Makefile              |    5 +
 drivers/virtio/virtio_rtc_arm.c      |   22 +
 drivers/virtio/virtio_rtc_class.c    |  269 +++++
 drivers/virtio/virtio_rtc_driver.c   | 1357 ++++++++++++++++++++++++++
 drivers/virtio/virtio_rtc_internal.h |  122 +++
 drivers/virtio/virtio_rtc_ptp.c      |  342 +++++++
 include/uapi/linux/virtio_rtc.h      |  230 +++++
 kernel/time/timekeeping.c            |   24 +-
 10 files changed, 2428 insertions(+), 12 deletions(-)
 create mode 100644 drivers/virtio/virtio_rtc_arm.c
 create mode 100644 drivers/virtio/virtio_rtc_class.c
 create mode 100644 drivers/virtio/virtio_rtc_driver.c
 create mode 100644 drivers/virtio/virtio_rtc_internal.h
 create mode 100644 drivers/virtio/virtio_rtc_ptp.c
 create mode 100644 include/uapi/linux/virtio_rtc.h


base-commit: 2c41b211d72c1eb350c7629a8c85234fef0d12c1
-- 
2.40.1


