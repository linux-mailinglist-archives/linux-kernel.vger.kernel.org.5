Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57E09780307
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 03:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356928AbjHRBUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 21:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356889AbjHRBUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 21:20:34 -0400
Received: from repost01.tmes.trendmicro.eu (repost01.tmes.trendmicro.eu [18.185.115.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5403A99
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 18:20:31 -0700 (PDT)
Received: from 104.47.11.172_.trendmicro.com (unknown [172.21.183.240])
        by repost01.tmes.trendmicro.eu (Postfix) with SMTP id B864C100004D9;
        Fri, 18 Aug 2023 01:20:30 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1692321626.022000
X-TM-MAIL-UUID: c84f0596-dfda-482b-b277-84bd576188aa
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (unknown [104.47.11.172])
        by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id 0597610000405;
        Fri, 18 Aug 2023 01:20:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bKiS8AJ1HVF03EgkntvIaqgecwvt5+Nt6s7rTyTKjD0DOGRTSyZ5svBbcQmUiYyZKYyclbouQU7hgsoAxyTbeBiVVBOkyNP/G8BtC4/nCKQPw23ZdUINPFLnD4Ryjtjcb2z4JhU+GNRUKi4YD+fsGa+TlPGbZOwwI6ZROQCsfDs/kilLf6UCD6YahbG0smfHKtVnAm3W96ccs7fusntTVS2ChNX1cGG0ZQHFdATuwYSA6DzAs2PJE/0k7zppQSSrmKqjUXVZNbe4Xi2D3I6t0jjADZdt2TjK2+fDSS2/8SOvDwErPWlcB9+DjXUfAjH6wuKAyj4s2k01+g6THWrHRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gKdGMR5s37Lk9N+Fl0koeY9QuXg+9X7xm0/FoLblK7A=;
 b=eL8v1u3oVzKOJEWEF4UMmoeL9M47r/MX0r1Vb6VB02uP8ECKsYm40YGQj1r+BvMsefRiiWUtdGsFZjQEbev4x39GCZNS82g4T+nWyHTQnZmN7jsYYoMnee/D4mzQhpDKOW5A8eFlvPowBAzE1IwQpdITTd9Z4YDxWZSVs7Eo8QhHKlS/9mTk7Jhht5VUNPAECFAJFgnRVY5v6bNOF1V1p2Ez4C1vS3/NAGOmvj+NMH71QXilUjrP76YyCXbqg/PereamlAsqXpj5G+BQVqqiVs//R+z15kEBXAEHaTgAH282tNk+NU9Ssd3EnpNJ9Xn0PM1eF6KTzZYtWkL6yUqN5w==
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
        virtio-dev@lists.oasis-open.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Peter Hilber <peter.hilber@opensynergy.com>,
        "Christopher S. Hall" <christopher.s.hall@intel.com>,
        Jason Wang <jasowang@redhat.com>,
        John Stultz <jstultz@google.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
        Richard Cochran <richardcochran@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [RFC PATCH v2 0/6] Add virtio_rtc module and related changes
Date:   Fri, 18 Aug 2023 03:20:06 +0200
Message-Id: <20230818012014.212155-1-peter.hilber@opensynergy.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8EUR05FT014:EE_|BEZP281MB3222:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 5c5e362c-4eb8-4ac1-3c63-08db9f894c3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BRkfQMWDOKMhZd04PCp+0TIOMJzVlKrQNiN9/44P2gZ2XXDM18uKwXsyHXzQfm59cQ1+yPGOsAylLxWpUl4ZGASkknegD05F+8Bndfa3F9aonOZaBE2UVEyE9JK9ckq1//ebxImFMeOqH3B6QAIX3wULkbuQqM0VxbY9ws2qFjJ0Q43dcFot1NgbSWmyf5bWVrw3yoFDoRXT0VNUTzLC8dDrV66bPUgqNwapAsPlNwe6q9QwbnfdQAfyDOD3PLyObwppmA/xQk7NfoGXbhurYP5LC1K9Qjnjf6DulZXxS+TzrNwOKLCBxCTB/nZelT3HOVa+ip31rMAi7rPYjQs1hOKNFCA3dSMAF1VZGQh5JYp1kYE+Z/GoKOnQd91klUcpy16u/pqszuVdnZ20GQjzrRVrHgSKLWuCfme3kZpHbTeEJ7vR81hqO+f4eTgsk+Kd3+KDt367vr5EPp1kpgPVuChBRVV+eWjRkeB4jVyhrhD5wuWfGLPCF+Y4wgQcNZQyxAb+Z3fi3I0NVzpv2sYjSVmv9E+W4XXv1PTfFKj5FszD8zUa9UmF0e3EalZbkVpfDJtj7t6wB83ptpjvg+5LeWuJPziC7bICiVCLup+wbqa6Kt7u4YWoZj+VApropQzzV+icqTgBHRuVuC+prQCAc2eMAym1MhR0ikosPA0etXBswRgjERTZf6GXYDcA7AW+5paN2xSbvkvV4zc4Y4ZS/bcW3ZIw4qD7gzas6rCV8e7OLg+WBGayvyDdGTn50efyPh+KG6u6W/BMaqH7Qwlo1nf/MDT6UcUXjYcPplVPSehCqONFldZsnoQ7u4FJgYNqkKW+hsCDKwvQ3wlCebhiyA==
X-Forefront-Antispam-Report: CIP:217.66.60.4;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SR-MAIL-03.open-synergy.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(346002)(39840400004)(186009)(82310400011)(1800799009)(451199024)(36840700001)(46966006)(40480700001)(8676002)(8936002)(4326008)(478600001)(12101799020)(54906003)(42186006)(316002)(966005)(70206006)(70586007)(41300700001)(47076005)(81166007)(36860700001)(336012)(26005)(7416002)(36756003)(44832011)(2616005)(5660300002)(1076003)(2906002)(86362001)(83380400001)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 01:20:24.0380
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c5e362c-4eb8-4ac1-3c63-08db9f894c3d
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=800fae25-9b1b-4edc-993d-c939c4e84a64;Ip=[217.66.60.4];Helo=[SR-MAIL-03.open-synergy.com]
X-MS-Exchange-CrossTenant-AuthSource: DB8EUR05FT014.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEZP281MB3222
X-TM-AS-ERS: 104.47.11.172-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1011-27820.003
X-TMASE-Result: 10--23.573800-4.000000
X-TMASE-MatchedRID: sHskM9Mmy801ES5mXStnyvHn6ZcQIyrXoJ9fUBwJTsxthzrTp6Bm2Zmg
        kd7c0mklPam+4FXhyE84al3F5wm3Brb67tz1B0bv98pvHsX7ODiMVe9CAxGt5W9P1W94aaoPVVX
        wwYW5AKJytGZv03ETXMPGx059yEffk/dA6P3T5Fs70BtMXRaQwn6u8VnsVatcBVFM4/LXBZvOja
        g0/IdOhG0x9eFyDN2tlANjrImr1cqp8JFEZ3/P50sfZgIcSmI9hp8n5idm/1+MhNlgOObH7jAY/
        ryBUXH8n/2b/J8leHkcr+6JWSm8AJYu9uIRhW9UBA/ZR5qnp8MSRRLwSueD2pq9yKH2z9zof7gV
        kqVnVBRw+j79Dup6Yc6Esjl50ngWYYYYNt9yJXntybwgd4MHW2txVUHuXeM7N4/zKvbrQA3s8oa
        cIeSp9UGkmEQzE3e6yW6VnkgftEY+xnE+4zwEsogBJ2REjJVpIyQ2IZ1g8yYC28FWVjkhF3LF2V
        aOJmfSW/Rdcb8TrA2zS0Lflen+5stQtgO74Vvs5PkCeM7tNe2bxe+IeXw0e+/Q+cyzRSxRDMKi7
        N8lhnbfXDU2ciEUMsKjGRQnQ81hzxPIJ+YGuapbyCHfDNuoE9umu0ICVejLoli4ZoiOHT8g4pZY
        xslhbQ40qJRZ9yNbA/3R8k/14e0=
X-TMASE-XGENCLOUD: 20c37737-387b-45f5-bf68-d2cc8a099a7c-0-0-200-0
X-TM-Deliver-Signature: 89371F398640FAE8DCA40378026D5088
X-TM-Addin-Auth: nr3lMOf7cvoizeN6HW9g/kPvJ2duDMiCroQ3j91XOa4E5TFSgr10lUn7iL9
        QAjLqkMDklAdA50P8cZI5taZc3avOq6CIxvwhA6yDTHfDUlP/b6OtLOdT42nwOl/k8PmBoNbLeJ
        u9Z+6hcUnXhGEHivmsqRYZTQ4fj9aUz19i2EM111D82VEYtfVArnxrPW3a9ITENdX8WPU6U36Ct
        AVuRHSwfcsWU09c02PA/j62uzHc4CCJIY/P2wHbKTNARuvE6q0sckS7vYslQt3yslSY4w5uFTvk
        nUt4d+axRbdEO6E=.KJ9BsykSNLddJ2S2g+JWpOM7g8yfZdQdxcv9xbTPgoUBaXXZX84WR9KGKp
        qoiYaWP88E532o+oX8n8gS6uWTiNqiPSC+RjcUNVhO829MlxrLVi9y3LQI2p1ab2MI+Zge5HQtG
        7EYJ8rcQb1VWFyn4VR1W5fpnz01yJDKynZ+GgRMxUJ7gJeGlf+9HBEM7zRxZDZvYxGj4w3DNkJJ
        do0Ylg0jpjlQnQ9gwngTcLLCAsAq6iMzORVB394L56Zyge9O+tW9K82bNgYdy0+nZ7FJbTrQ4L9
        xwqBeGxCErQrveF0/50wR1FnsCWC6/dbo7vWJrtvMhFXSfjVBdj1Gm7p97g==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
        s=TM-DKIM-20210503141657; t=1692321630;
        bh=hNXiEJgUahR5qr3avbK/sTRL263lfMdKT6x222P0YBw=; l=8810;
        h=From:To:Date;
        b=TILvzsakpGnv9VT+qT1LGnmBEA7s0CPp1WyYiXCmJfsoZmMT+yZGBpzgQmkCtUe9E
         Y6a1guaRu+ieYUzE5zX8zFDAyZGa8vItpVZlJq9PCnNiZsGk9onpPQrhdrXyICxdTL
         3r93bR3Ly98WZapxC2pYDtDgqe/L8D9XkU2YdA1hINza6DLNUm28V3u0bnpb1CbJuj
         +DhdmIAVvMJORDPDcOqvffPVY5a/lJZ5j510l57QfGdUHGZ+A8ZmqS7446FRWGY1Ke
         +52Quyg1hHDVHFzkmnI9OF7PSTQn96gbPNytIrkeCA8t7h+ArVDfK7kyF73QIm7egu
         ID4GPqbeF6cpw==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2 brings changes mostly to the preparatory patches. Notably, the changes
to arm_arch_timer are dropped in favor of a prerequisite series [5]
which changes the get_device_system_crosststamp() interface.

At the moment, the proposed Virtio specification for virtio_rtc is being
discussed [3], and this will result in some renaming and maybe more
changes.

This patch series depends on the patch series "treewide: Use clocksource id
for get_device_system_crosststamp()" [5]. Pull [4] to get the combined
series on top of mainline.

This patch series adds the virtio_rtc module, and related bugfixes and
small interface extensions. The virtio_rtc module implements a driver
compatible with the proposed Virtio RTC device specification [1]. The
Virtio RTC (Real Time Clock) device provides information about current
time. The device can provide different clocks, e.g. for the UTC or TAI time
standards, or for physical time elapsed since some past epoch. The driver
can read the clocks with simple or more accurate methods.

The series first fixes some bugs in the get_device_system_crosststamp()
interpolation code, which is required for reliable virtio_rtc operation.
Then, add the virtio_rtc implementation.

For the Virtio RTC device, there is currently a proprietary implementation,
which has been used for provisional testing.

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

The following udev rule can be used to get a symlink /dev/ptp_virtio to the
UTC clock:

	SUBSYSTEM=="ptp", ATTR{clock_name}=="Virtio PTP UTC", SYMLINK += "ptp_virtio"

The following chrony configuration directive can then be added in
/etc/chrony/chrony.conf to synchronize to the Virtio UTC clock:

	refclock PHC /dev/ptp_virtio refid PHCV poll -1 dpoll -1

This patch series adds virtio_rtc not in drivers/ptp, but as a generic
Virtio driver. In the near future, virtio_rtc should be extended with an
RTC Class driver, along with extensions to the Virtio RTC device draft spec
to support RTC alarms.

Feedback is greatly appreciated.

[1] https://lists.oasis-open.org/archives/virtio-comment/202306/msg00592.html
[2] https://chrony.tuxfamily.org/
[3] https://lore.kernel.org/virtio-comment/20230630092959.392381-1-peter.hilber@opensynergy.com/
[4] https://github.com/OpenSynergy/linux.git virtio-rtc-v2-on-master
[5] https://lore.kernel.org/lkml/20230818011256.211078-1-peter.hilber@opensynergy.com/T/#t

v2:

- Depend on patch series "treewide: Use clocksource id for
  get_device_system_crosststamp()" to avoid requiring a clocksource pointer
  with get_device_system_crosststamp().

- Assume Arm Generic Timer will use CP15 virtual counter. Drop
  arm_arch_timer helper functions (Marc Zyngier).

- Improve cross-timestamp fixes problem description and implementation
  (John Stultz).


Peter Hilber (6):
  timekeeping: Fix cross-timestamp interpolation on counter wrap
  timekeeping: Fix cross-timestamp interpolation corner case decision
  timekeeping: Fix cross-timestamp interpolation for non-x86
  virtio_rtc: Add module and driver core
  virtio_rtc: Add PTP clocks
  virtio_rtc: Add Arm Generic Timer cross-timestamping

 MAINTAINERS                          |   7 +
 drivers/virtio/Kconfig               |  43 ++
 drivers/virtio/Makefile              |   4 +
 drivers/virtio/virtio_rtc_arm.c      |  22 +
 drivers/virtio/virtio_rtc_driver.c   | 841 +++++++++++++++++++++++++++
 drivers/virtio/virtio_rtc_internal.h |  71 +++
 drivers/virtio/virtio_rtc_ptp.c      | 347 +++++++++++
 include/uapi/linux/virtio_rtc.h      | 159 +++++
 kernel/time/timekeeping.c            |  11 +-
 9 files changed, 1499 insertions(+), 6 deletions(-)
 create mode 100644 drivers/virtio/virtio_rtc_arm.c
 create mode 100644 drivers/virtio/virtio_rtc_driver.c
 create mode 100644 drivers/virtio/virtio_rtc_internal.h
 create mode 100644 drivers/virtio/virtio_rtc_ptp.c
 create mode 100644 include/uapi/linux/virtio_rtc.h


base-commit: 2c41bbf973b0c1190e4579bfe86405273c14d822
-- 
2.39.2

