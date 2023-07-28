Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7451766247
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 05:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232833AbjG1DGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 23:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233113AbjG1DFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 23:05:46 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8288930FC
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 20:05:44 -0700 (PDT)
Received: from kwepemm600004.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RBstl0cKzz1GDFX;
        Fri, 28 Jul 2023 11:04:47 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 kwepemm600004.china.huawei.com (7.193.23.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 28 Jul 2023 11:05:41 +0800
From:   Huisong Li <lihuisong@huawei.com>
To:     <xuwei5@hisilicon.com>, <arnd@arndb.de>, <krzk@kernel.org>,
        <sudeep.holla@arm.com>, <rdunlap@infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <soc@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <wanghuiqiang@huawei.com>,
        <tanxiaofei@huawei.com>, <liuyonglong@huawei.com>,
        <lihuisong@huawei.com>
Subject: [PATCH v4 2/2] doc: soc: hisilicon: Add Kunpeng HCCS driver documentation
Date:   Fri, 28 Jul 2023 11:03:02 +0800
Message-ID: <20230728030302.23356-3-lihuisong@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230728030302.23356-1-lihuisong@huawei.com>
References: <20230424073020.4039-1-lihuisong@huawei.com>
 <20230728030302.23356-1-lihuisong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600004.china.huawei.com (7.193.23.242)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the sysfs attributes description provided by HCCS driver on
Kunpeng SoC.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 .../sysfs-devices-platform-kunpeng_hccs       | 76 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 77 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-platform-kunpeng_hccs

diff --git a/Documentation/ABI/testing/sysfs-devices-platform-kunpeng_hccs b/Documentation/ABI/testing/sysfs-devices-platform-kunpeng_hccs
new file mode 100644
index 000000000000..70b2618f1869
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-devices-platform-kunpeng_hccs
@@ -0,0 +1,76 @@
+What:		/sys/devices/platform/HISI04Bx:00/chipX/all_linked
+		/sys/devices/platform/HISI04Bx:00/chipX/linked_full_lane
+		/sys/devices/platform/HISI04Bx:00/chipX/crc_err_cnt
+Date:		November 2023
+KernelVersion:	6.6
+Contact:	Huisong Li <lihuisong@huawei.org>
+Description:
+		The /sys/devices/platform/HISI04Bx:00/chipX/ directory
+		contains read-only attributes exposing some summarization
+		information of all HCCS ports under a specified chip.
+		The X in 'chipX' indicates the Xth chip on platform.
+
+		There are following attributes in this directory:
+		================= ==== =========================================
+		all_linked:       (RO) if all enabled ports on this chip are
+				       linked (bool).
+		linked_full_lane: (RO) if all linked ports on this chip are full
+				       lane (bool).
+		crc_err_cnt:      (RO) total CRC err count for all ports on this
+				       chip.
+		============= ==== =============================================
+
+What:		/sys/devices/platform/HISI04Bx:00/chipX/dieY/all_linked
+		/sys/devices/platform/HISI04Bx:00/chipX/dieY/linked_full_lane
+		/sys/devices/platform/HISI04Bx:00/chipX/dieY/crc_err_cnt
+Date:		November 2023
+KernelVersion:	6.6
+Contact:	Huisong Li <lihuisong@huawei.org>
+Description:
+		The /sys/devices/platform/HISI04Bx:00/chipX/dieY/ directory
+		contains read-only attributes exposing some summarization
+		information of all HCCS ports under a specified die.
+		The Y in 'dieY' indicates the hardware id of the die on chip who
+		has chip id X.
+
+		There are following attributes in this directory:
+		================= ==== =========================================
+		all_linked:       (RO) if all enabled ports on this die are
+				       linked (bool).
+		linked_full_lane: (RO) if all linked ports on this die are full
+				       lane (bool).
+		crc_err_cnt:      (RO) total CRC err count for all ports on this
+				       die.
+		============= ==== =============================================
+
+What:		/sys/devices/platform/HISI04Bx:00/chipX/dieY/hccsN/type
+		/sys/devices/platform/HISI04Bx:00/chipX/dieY/hccsN/lane_mode
+		/sys/devices/platform/HISI04Bx:00/chipX/dieY/hccsN/enable
+		/sys/devices/platform/HISI04Bx:00/chipX/dieY/hccsN/cur_lane_num
+		/sys/devices/platform/HISI04Bx:00/chipX/dieY/hccsN/lane_mask
+		/sys/devices/platform/HISI04Bx:00/chipX/dieY/hccsN/crc_err_cnt
+Date:		November 2023
+KernelVersion:	6.6
+Contact:	Huisong Li <lihuisong@huawei.org>
+Description:
+		The /sys/devices/platform/HISI04Bx/chipX/dieX/hccsN/ directory
+		contains read-only attributes exposing information about
+		a HCCS port. The N value in 'hccsN' indicates this port id.
+		The X in 'chipX' indicates the ID of the chip to which the
+		HCCS port belongs. For example, X ranges from to 'n - 1' if the
+		chip number on platform is n.
+		The Y in 'dieY' indicates the hardware id of the die to which
+		the hccs port belongs.
+
+		The HCCS port have the following attributes:
+		============= ==== =============================================
+		type:         (RO) port type (string), e.g. HCCS-v1 -> H32
+		lane_mode:    (RO) the lane mode of this port (string), e.g. x8
+		enable:       (RO) indicate if this port is enabled (bool).
+		cur_lane_num: (RO) current lane number of this port.
+		lane_mask:    (RO) current lane mask of this port, every bit
+			           indicates a lane.
+		crc_err_cnt:  (RO) CRC err count on this port.
+		============= ==== =============================================
+		Note: type, lane_mode and enable are fixed attributes on
+		      running platform.
diff --git a/MAINTAINERS b/MAINTAINERS
index c9e302c3ff48..764b20b1d19a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9491,6 +9491,7 @@ F:	drivers/crypto/hisilicon/zip/
 HISILICON KUNPENG SOC HCCS DRIVER
 M:	Huisong Li <lihuisong@huawei.com>
 S:	Maintained
+F:	Documentation/ABI/testing/sysfs-devices-platform-kunpeng_hccs
 F:	drivers/soc/hisilicon/kunpeng_hccs.c
 F:	drivers/soc/hisilicon/kunpeng_hccs.h
 
-- 
2.33.0

