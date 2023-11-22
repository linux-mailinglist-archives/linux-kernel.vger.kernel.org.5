Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAFAC7F4FAF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 19:34:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344199AbjKVSe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 13:34:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343972AbjKVSe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 13:34:56 -0500
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2D2B2;
        Wed, 22 Nov 2023 10:34:51 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AMIU7WG010444;
        Wed, 22 Nov 2023 10:34:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=nnAMkel0k8y1T9oDp6Vw8fbx9YgqIo8UMTp42Oh5n5s=;
 b=RbR6N4mLQfxDGqTgTZNYkxRqn1NdnO1jeaGsUYXz/mFuuib41ZKEPE/dmdKM1XvsLn15
 kVDFknMPY7nbdcrFQTZkEVM3OElalgPiAcOUm7qbIZjD+FRp4OZrZpBQOMmrH2GciHdS
 1zCE/KsaTYcIHtKMy7kGdrAs4WBGDbISOzuPSyJ/pSsTTaqflHaQGuv8XnKqDnwEY0qt
 ZNSAyHGTo7N+4QRXVAN/TvK3KlB0hcMd0YZEaKzBDuWwo5Tc8pvr2jYQZVu91jJ/FdnY
 aWVNSQnqExuKb+1c5bS8rM6Ph4VblukWOcSBcVUuImgF6zdPH4mO088NniaNyoGu7o7K Lg== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3uh1jbcs7t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 22 Nov 2023 10:34:43 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 22 Nov
 2023 10:34:41 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Wed, 22 Nov 2023 10:34:42 -0800
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
        by maili.marvell.com (Postfix) with ESMTP id 8FAB33F7040;
        Wed, 22 Nov 2023 10:34:41 -0800 (PST)
From:   Shinas Rasheed <srasheed@marvell.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <hgani@marvell.com>, <vimleshk@marvell.com>, <egallen@redhat.com>,
        <mschmidt@redhat.com>, <pabeni@redhat.com>, <horms@kernel.org>,
        <kuba@kernel.org>, <davem@davemloft.net>, <wizhao@redhat.com>,
        <konguyen@redhat.com>, <jesse.brandeburg@intel.com>,
        <sumang@marvell.com>, Shinas Rasheed <srasheed@marvell.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        Sathesh Edara <sedara@marvell.com>,
        Eric Dumazet <edumazet@google.com>
Subject: [PATCH net-next v2 1/2] octeon_ep: Solve style issues in control net files
Date:   Wed, 22 Nov 2023 10:34:34 -0800
Message-ID: <20231122183435.2510656-2-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231122183435.2510656-1-srasheed@marvell.com>
References: <20231122183435.2510656-1-srasheed@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: pukhpuMS17sL-hK2UXC37r-8WlEaiK8B
X-Proofpoint-GUID: pukhpuMS17sL-hK2UXC37r-8WlEaiK8B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-22_13,2023-11-22_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Solve observed style issues for kernel documentation
and structure declarations in control net API definitions.

Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
---
V2:
   - Introduced the patch due to kernel doc style and structure
     initialisation comments obtained in V1 of patch 2

 .../marvell/octeon_ep/octep_ctrl_net.c        |  24 ++--
 .../marvell/octeon_ep/octep_ctrl_net.h        | 115 ++++++++++--------
 2 files changed, 76 insertions(+), 63 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.c b/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.c
index 0594607a2585..2eeeaa7188b1 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.c
@@ -122,7 +122,7 @@ int octep_ctrl_net_init(struct octep_device *oct)
 
 int octep_ctrl_net_get_link_status(struct octep_device *oct, int vfid)
 {
-	struct octep_ctrl_net_wait_data d = {0};
+	struct octep_ctrl_net_wait_data d = {};
 	struct octep_ctrl_net_h2f_req *req = &d.data.req;
 	int err;
 
@@ -139,7 +139,7 @@ int octep_ctrl_net_get_link_status(struct octep_device *oct, int vfid)
 int octep_ctrl_net_set_link_status(struct octep_device *oct, int vfid, bool up,
 				   bool wait_for_response)
 {
-	struct octep_ctrl_net_wait_data d = {0};
+	struct octep_ctrl_net_wait_data d = {};
 	struct octep_ctrl_net_h2f_req *req = &d.data.req;
 
 	init_send_req(&d.msg, req, state_sz, vfid);
@@ -154,7 +154,7 @@ int octep_ctrl_net_set_link_status(struct octep_device *oct, int vfid, bool up,
 int octep_ctrl_net_set_rx_state(struct octep_device *oct, int vfid, bool up,
 				bool wait_for_response)
 {
-	struct octep_ctrl_net_wait_data d = {0};
+	struct octep_ctrl_net_wait_data d = {};
 	struct octep_ctrl_net_h2f_req *req = &d.data.req;
 
 	init_send_req(&d.msg, req, state_sz, vfid);
@@ -168,7 +168,7 @@ int octep_ctrl_net_set_rx_state(struct octep_device *oct, int vfid, bool up,
 
 int octep_ctrl_net_get_mac_addr(struct octep_device *oct, int vfid, u8 *addr)
 {
-	struct octep_ctrl_net_wait_data d = {0};
+	struct octep_ctrl_net_wait_data d = {};
 	struct octep_ctrl_net_h2f_req *req = &d.data.req;
 	int err;
 
@@ -187,7 +187,7 @@ int octep_ctrl_net_get_mac_addr(struct octep_device *oct, int vfid, u8 *addr)
 int octep_ctrl_net_set_mac_addr(struct octep_device *oct, int vfid, u8 *addr,
 				bool wait_for_response)
 {
-	struct octep_ctrl_net_wait_data d = {0};
+	struct octep_ctrl_net_wait_data d = {};
 	struct octep_ctrl_net_h2f_req *req = &d.data.req;
 
 	init_send_req(&d.msg, req, mac_sz, vfid);
@@ -201,7 +201,7 @@ int octep_ctrl_net_set_mac_addr(struct octep_device *oct, int vfid, u8 *addr,
 int octep_ctrl_net_set_mtu(struct octep_device *oct, int vfid, int mtu,
 			   bool wait_for_response)
 {
-	struct octep_ctrl_net_wait_data d = {0};
+	struct octep_ctrl_net_wait_data d = {};
 	struct octep_ctrl_net_h2f_req *req = &d.data.req;
 
 	init_send_req(&d.msg, req, mtu_sz, vfid);
@@ -216,7 +216,7 @@ int octep_ctrl_net_get_if_stats(struct octep_device *oct, int vfid,
 				struct octep_iface_rx_stats *rx_stats,
 				struct octep_iface_tx_stats *tx_stats)
 {
-	struct octep_ctrl_net_wait_data d = {0};
+	struct octep_ctrl_net_wait_data d = {};
 	struct octep_ctrl_net_h2f_req *req = &d.data.req;
 	struct octep_ctrl_net_h2f_resp *resp;
 	int err;
@@ -236,7 +236,7 @@ int octep_ctrl_net_get_if_stats(struct octep_device *oct, int vfid,
 int octep_ctrl_net_get_link_info(struct octep_device *oct, int vfid,
 				 struct octep_iface_link_info *link_info)
 {
-	struct octep_ctrl_net_wait_data d = {0};
+	struct octep_ctrl_net_wait_data d = {};
 	struct octep_ctrl_net_h2f_req *req = &d.data.req;
 	struct octep_ctrl_net_h2f_resp *resp;
 	int err;
@@ -262,7 +262,7 @@ int octep_ctrl_net_set_link_info(struct octep_device *oct, int vfid,
 				 struct octep_iface_link_info *link_info,
 				 bool wait_for_response)
 {
-	struct octep_ctrl_net_wait_data d = {0};
+	struct octep_ctrl_net_wait_data d = {};
 	struct octep_ctrl_net_h2f_req *req = &d.data.req;
 
 	init_send_req(&d.msg, req, link_info_sz, vfid);
@@ -331,8 +331,8 @@ static int process_mbox_notify(struct octep_device *oct,
 void octep_ctrl_net_recv_fw_messages(struct octep_device *oct)
 {
 	static u16 msg_sz = sizeof(union octep_ctrl_net_max_data);
-	union octep_ctrl_net_max_data data = {0};
-	struct octep_ctrl_mbox_msg msg = {0};
+	union octep_ctrl_net_max_data data = {};
+	struct octep_ctrl_mbox_msg msg = {};
 	int ret;
 
 	msg.hdr.s.sz = msg_sz;
@@ -356,7 +356,7 @@ void octep_ctrl_net_recv_fw_messages(struct octep_device *oct)
 int octep_ctrl_net_get_info(struct octep_device *oct, int vfid,
 			    struct octep_fw_info *info)
 {
-	struct octep_ctrl_net_wait_data d = {0};
+	struct octep_ctrl_net_wait_data d = {};
 	struct octep_ctrl_net_h2f_resp *resp;
 	struct octep_ctrl_net_h2f_req *req;
 	int err;
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.h b/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.h
index b330f370131b..02b8fcf890d0 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.h
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.h
@@ -218,87 +218,95 @@ struct octep_ctrl_net_wait_data {
 	} data;
 };
 
-/** Initialize data for ctrl net.
+/**
+ * octep_ctrl_net_init() - Initialize data for ctrl net.
  *
- * @param oct: non-null pointer to struct octep_device.
+ * @oct: non-null pointer to struct octep_device.
  *
  * return value: 0 on success, -errno on error.
  */
 int octep_ctrl_net_init(struct octep_device *oct);
 
-/** Get link status from firmware.
+/** 
+ * octep_ctrl_net_get_link_status() - Get link status from firmware.
  *
- * @param oct: non-null pointer to struct octep_device.
- * @param vfid: Index of virtual function.
+ * @oct: non-null pointer to struct octep_device.
+ * @vfid: Index of virtual function.
  *
  * return value: link status 0=down, 1=up.
  */
 int octep_ctrl_net_get_link_status(struct octep_device *oct, int vfid);
 
-/** Set link status in firmware.
+/**
+ * octep_ctrl_net_set_link_status() - Set link status in firmware.
  *
- * @param oct: non-null pointer to struct octep_device.
- * @param vfid: Index of virtual function.
- * @param up: boolean status.
- * @param wait_for_response: poll for response.
+ * @oct: non-null pointer to struct octep_device.
+ * @vfid: Index of virtual function.
+ * @up: boolean status.
+ * @wait_for_response: poll for response.
  *
  * return value: 0 on success, -errno on failure
  */
 int octep_ctrl_net_set_link_status(struct octep_device *oct, int vfid, bool up,
 				   bool wait_for_response);
 
-/** Set rx state in firmware.
+/**
+ * octep_ctrl_net_set_rx_state() - Set rx state in firmware.
  *
- * @param oct: non-null pointer to struct octep_device.
- * @param vfid: Index of virtual function.
- * @param up: boolean status.
- * @param wait_for_response: poll for response.
+ * @oct: non-null pointer to struct octep_device.
+ * @vfid: Index of virtual function.
+ * @up: boolean status.
+ * @wait_for_response: poll for response.
  *
  * return value: 0 on success, -errno on failure.
  */
 int octep_ctrl_net_set_rx_state(struct octep_device *oct, int vfid, bool up,
 				bool wait_for_response);
 
-/** Get mac address from firmware.
+/** 
+ * octep_ctrl_net_get_mac_addr() - Get mac address from firmware.
  *
- * @param oct: non-null pointer to struct octep_device.
- * @param vfid: Index of virtual function.
- * @param addr: non-null pointer to mac address.
+ * @oct: non-null pointer to struct octep_device.
+ * @vfid: Index of virtual function.
+ * @addr: non-null pointer to mac address.
  *
  * return value: 0 on success, -errno on failure.
  */
 int octep_ctrl_net_get_mac_addr(struct octep_device *oct, int vfid, u8 *addr);
 
-/** Set mac address in firmware.
+/**
+ * octep_ctrl_net_set_mac_addr() - Set mac address in firmware.
  *
- * @param oct: non-null pointer to struct octep_device.
- * @param vfid: Index of virtual function.
- * @param addr: non-null pointer to mac address.
- * @param wait_for_response: poll for response.
+ * @oct: non-null pointer to struct octep_device.
+ * @vfid: Index of virtual function.
+ * @addr: non-null pointer to mac address.
+ * @wait_for_response: poll for response.
  *
  * return value: 0 on success, -errno on failure.
  */
 int octep_ctrl_net_set_mac_addr(struct octep_device *oct, int vfid, u8 *addr,
 				bool wait_for_response);
 
-/** Set mtu in firmware.
+/** 
+ * octep_ctrl_net_set_mtu() - Set mtu in firmware.
  *
- * @param oct: non-null pointer to struct octep_device.
- * @param vfid: Index of virtual function.
- * @param mtu: mtu.
- * @param wait_for_response: poll for response.
+ * @oct: non-null pointer to struct octep_device.
+ * @vfid: Index of virtual function.
+ * @mtu: mtu.
+ * @wait_for_response: poll for response.
  *
  * return value: 0 on success, -errno on failure.
  */
 int octep_ctrl_net_set_mtu(struct octep_device *oct, int vfid, int mtu,
 			   bool wait_for_response);
 
-/** Get interface statistics from firmware.
+/**
+ * octep_ctrl_net_get_if_stats() - Get interface statistics from firmware.
  *
- * @param oct: non-null pointer to struct octep_device.
- * @param vfid: Index of virtual function.
- * @param rx_stats: non-null pointer struct octep_iface_rx_stats.
- * @param tx_stats: non-null pointer struct octep_iface_tx_stats.
+ * @oct: non-null pointer to struct octep_device.
+ * @vfid: Index of virtual function.
+ * @rx_stats: non-null pointer struct octep_iface_rx_stats.
+ * @tx_stats: non-null pointer struct octep_iface_tx_stats.
  *
  * return value: 0 on success, -errno on failure.
  */
@@ -306,23 +314,25 @@ int octep_ctrl_net_get_if_stats(struct octep_device *oct, int vfid,
 				struct octep_iface_rx_stats *rx_stats,
 				struct octep_iface_tx_stats *tx_stats);
 
-/** Get link info from firmware.
+/**
+ * octep_ctrl_net_get_link_info() - Get link info from firmware.
  *
- * @param oct: non-null pointer to struct octep_device.
- * @param vfid: Index of virtual function.
- * @param link_info: non-null pointer to struct octep_iface_link_info.
+ * @oct: non-null pointer to struct octep_device.
+ * @vfid: Index of virtual function.
+ * @link_info: non-null pointer to struct octep_iface_link_info.
  *
  * return value: 0 on success, -errno on failure.
  */
 int octep_ctrl_net_get_link_info(struct octep_device *oct, int vfid,
 				 struct octep_iface_link_info *link_info);
 
-/** Set link info in firmware.
+/**
+ * octep_ctrl_net_set_link_info() - Set link info in firmware.
  *
- * @param oct: non-null pointer to struct octep_device.
- * @param vfid: Index of virtual function.
- * @param link_info: non-null pointer to struct octep_iface_link_info.
- * @param wait_for_response: poll for response.
+ * @oct: non-null pointer to struct octep_device.
+ * @vfid: Index of virtual function.
+ * @link_info: non-null pointer to struct octep_iface_link_info.
+ * @wait_for_response: poll for response.
  *
  * return value: 0 on success, -errno on failure.
  */
@@ -331,26 +341,29 @@ int octep_ctrl_net_set_link_info(struct octep_device *oct,
 				 struct octep_iface_link_info *link_info,
 				 bool wait_for_response);
 
-/** Poll for firmware messages and process them.
+/**
+ * octep_ctrl_net_recv_fw_messages() - Poll for firmware messages and process them.
  *
- * @param oct: non-null pointer to struct octep_device.
+ * @oct: non-null pointer to struct octep_device.
  */
 void octep_ctrl_net_recv_fw_messages(struct octep_device *oct);
 
-/** Get info from firmware.
+/**
+ * octep_ctrl_net_get_info() - Get info from firmware.
  *
- * @param oct: non-null pointer to struct octep_device.
- * @param vfid: Index of virtual function.
- * @param info: non-null pointer to struct octep_fw_info.
+ * @oct: non-null pointer to struct octep_device.
+ * @vfid: Index of virtual function.
+ * @info: non-null pointer to struct octep_fw_info.
  *
  * return value: 0 on success, -errno on failure.
  */
 int octep_ctrl_net_get_info(struct octep_device *oct, int vfid,
 			    struct octep_fw_info *info);
 
-/** Uninitialize data for ctrl net.
+/**
+ * octep_ctrl_net_uninit() - Uninitialize data for ctrl net.
  *
- * @param oct: non-null pointer to struct octep_device.
+ * @oct: non-null pointer to struct octep_device.
  *
  * return value: 0 on success, -errno on error.
  */
-- 
2.25.1

