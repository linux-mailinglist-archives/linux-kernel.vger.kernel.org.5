Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8562376A721
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 04:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbjHACoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 22:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbjHACoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 22:44:05 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A1310C3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 19:44:04 -0700 (PDT)
Received: from kwepemm600004.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RFKBz0PnbzVjxq;
        Tue,  1 Aug 2023 10:42:19 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 kwepemm600004.china.huawei.com (7.193.23.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 10:44:01 +0800
From:   Huisong Li <lihuisong@huawei.com>
To:     <xuwei5@hisilicon.com>, <arnd@arndb.de>, <krzk@kernel.org>,
        <sudeep.holla@arm.com>, <rdunlap@infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <soc@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <wanghuiqiang@huawei.com>,
        <tanxiaofei@huawei.com>, <liuyonglong@huawei.com>,
        <lihuisong@huawei.com>
Subject: [PATCH v6 2/2] doc: soc: hisilicon: Add Kunpeng HCCS driver documentation
Date:   Tue, 1 Aug 2023 10:41:19 +0800
Message-ID: <20230801024119.37215-3-lihuisong@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230801024119.37215-1-lihuisong@huawei.com>
References: <20230424073020.4039-1-lihuisong@huawei.com>
 <20230801024119.37215-1-lihuisong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600004.china.huawei.com (7.193.23.242)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
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
 .../sysfs-devices-platform-kunpeng_hccs       | 81 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 82 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-platform-kunpeng_hccs

diff --git a/Documentation/ABI/testing/sysfs-devices-platform-kunpeng_hccs b/Documentation/ABI/testing/sysfs-devices-platform-kunpeng_hccs
new file mode 100644
index 000000000000..fdb4e36310fb
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-devices-platform-kunpeng_hccs
@@ -0,0 +1,81 @@
+What:		/sys/devices/platform/HISI04Bx:00/chipX/all_linked
+What:		/sys/devices/platform/HISI04Bx:00/chipX/linked_full_lane
+What:		/sys/devices/platform/HISI04Bx:00/chipX/crc_err_cnt
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
+
+		================= ==== =========================================
+		all_linked:       (RO) if all enabled ports on this chip are
+				       linked (bool).
+		linked_full_lane: (RO) if all linked ports on this chip are full
+				       lane (bool).
+		crc_err_cnt:      (RO) total CRC err count for all ports on this
+				       chip.
+		================= ==== =========================================
+
+What:		/sys/devices/platform/HISI04Bx:00/chipX/dieY/all_linked
+What:		/sys/devices/platform/HISI04Bx:00/chipX/dieY/linked_full_lane
+What:		/sys/devices/platform/HISI04Bx:00/chipX/dieY/crc_err_cnt
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
+
+		================= ==== =========================================
+		all_linked:       (RO) if all enabled ports on this die are
+				       linked (bool).
+		linked_full_lane: (RO) if all linked ports on this die are full
+				       lane (bool).
+		crc_err_cnt:      (RO) total CRC err count for all ports on this
+				       die.
+		================= ==== =========================================
+
+What:		/sys/devices/platform/HISI04Bx:00/chipX/dieY/hccsN/type
+What:		/sys/devices/platform/HISI04Bx:00/chipX/dieY/hccsN/lane_mode
+What:		/sys/devices/platform/HISI04Bx:00/chipX/dieY/hccsN/enable
+What:		/sys/devices/platform/HISI04Bx:00/chipX/dieY/hccsN/cur_lane_num
+What:		/sys/devices/platform/HISI04Bx:00/chipX/dieY/hccsN/link_fsm
+What:		/sys/devices/platform/HISI04Bx:00/chipX/dieY/hccsN/lane_mask
+What:		/sys/devices/platform/HISI04Bx:00/chipX/dieY/hccsN/crc_err_cnt
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
+		Note: type, lane_mode and enable are fixed attributes on running
+		platform.
+
+		The HCCS port have the following attributes:
+
+		============= ==== =============================================
+		type:         (RO) port type (string), e.g. HCCS-v1 -> H32
+		lane_mode:    (RO) the lane mode of this port (string), e.g. x8
+		enable:       (RO) indicate if this port is enabled (bool).
+		cur_lane_num: (RO) current lane number of this port.
+		link_fsm:     (RO) link finite state machine of this port.
+		lane_mask:    (RO) current lane mask of this port, every bit
+			           indicates a lane.
+		crc_err_cnt:  (RO) CRC err count on this port.
+		============= ==== =============================================
diff --git a/MAINTAINERS b/MAINTAINERS
index 082e0c18a49a..53df506772dc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9375,6 +9375,7 @@ F:	drivers/i2c/busses/i2c-hisi.c
 HISILICON KUNPENG SOC HCCS DRIVER
 M:	Huisong Li <lihuisong@huawei.com>
 S:	Maintained
+F:	Documentation/ABI/testing/sysfs-devices-platform-kunpeng_hccs
 F:	drivers/soc/hisilicon/kunpeng_hccs.c
 F:	drivers/soc/hisilicon/kunpeng_hccs.h
 
-- 
2.33.0

