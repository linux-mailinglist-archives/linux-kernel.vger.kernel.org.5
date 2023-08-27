Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0AEE7899F4
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 02:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjH0AuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 20:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjH0Atz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 20:49:55 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2081.outbound.protection.outlook.com [40.92.21.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28AF19A
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 17:49:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fG2NXVfTL06er8kr8+4INb0d+gZYgU3dhjE+lww2cq6SEl65YCqiF6O1waAnfjlcwMwQQiHQPtwoC0oN7+f5w8nN/kD57aKm5RWM6QLHmiBy+lyeRAVTy00O0Wn0+ec6gBjF3scRdOjSgFhdBsheo6qpUCSroXkhHVKNoCZKMgTVvbjvc6fN+JY3UOdaXgbKDIm/mE/NASlgQDcvRb3xz736sQkeJEuKeapOefSDIWkGD1LUFBfbOas8M6CO8EIE0OGd91jblB1HB/14ZuflJrIUYW50jIUfvNQgMnUS8xELF8FjZAeLxsyGkl9DADafXJtzhzI9MF60nRMYuYILVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dd/NJybv7YfCv8DCX5NYuML49sH97N6MpHRThEq+9RA=;
 b=obsk9IqD5F4r6UlAKfbLZy75FvRfRU3yZOCS+B+jge4HeaqErZZn1fophNOj3ERsxtA8aLNkvvaG4NFGOYv7nyF3Jbuu9lrkpn+3f2tLaXslOe9d5fysUpMeBtuOcMBz/tZ7IH2dpbQLW4qURdEhjrUHyc8U0er6BZxpoJyvR3T0Z1N1ctSW53wzN8Qr8YKY0vas0X2mTe9DuxDTj22ODT7Q5NfBU/+XfX/+YWn4BYezc+MwtjYoZlzs5cy70RdERsc1sH4HkxXJXsrKJNcEa0Shk6dxYoruf5bK0vcBodxzW5DU0osxS2L6gsqsx8Rb1lGxQkdntpI3Y7AEEd/3fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dd/NJybv7YfCv8DCX5NYuML49sH97N6MpHRThEq+9RA=;
 b=r88Pz/W06NA3NsvqDBSR82pzmA3mE7XcUUAHt0NwsEkV660WBW0T83vOclTQVfsAKhEEHH0oCbEucCN5CgSdm/NXF97Rq4YJDswUM0ZsRgSrOCQT1EPzTyYD3oXxHxJrJT0t1AVaZc6czAxhsQPMB4Rk7gkq+9Lmh4/xQUsY/6ZMBrd20lSNSLAZ7Jgyt+doCcxbOYJRD/kGJtafsY2cU6m8oW+3tx4016garOqrQAT3QQNjC1RnvMS12IFLWemw+yunDX8JT8IXMJGWxON3FNKOEy8jys3h08O4Ft7pjah9S6rSL/4TXXa4H5UesZJhhq2zfql2Tl33gCJ0qd4hdg==
Received: from PH7PR11MB7643.namprd11.prod.outlook.com (2603:10b6:510:27c::22)
 by SJ0PR11MB6790.namprd11.prod.outlook.com (2603:10b6:a03:483::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Sun, 27 Aug
 2023 00:49:50 +0000
Received: from PH7PR11MB7643.namprd11.prod.outlook.com
 ([fe80::bfb7:d3a3:2ed:6e20]) by PH7PR11MB7643.namprd11.prod.outlook.com
 ([fe80::bfb7:d3a3:2ed:6e20%7]) with mapi id 15.20.6699.034; Sun, 27 Aug 2023
 00:49:50 +0000
Date:   Sat, 26 Aug 2023 20:49:47 -0400
To:     gregkh@linuxfoundation.org, colin.i.king@gmail.com,
        sumitraartsy@gmail.com, nhuck@google.com,
        u.kleine-koenig@pengutronix.de, geert@linux-m68k.org
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH] Clean up the octeon ethernet driver
Message-ID: <PH7PR11MB764393FA00BBB83B25B8853EBCE1A@PH7PR11MB7643.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
From:   <ozlinux@hotmail.com>
X-TMN:  [f+OuFGsYecfGuxYkhAItgmYrOL3VG7kctyUJQscCnQUPLg8pvvgMLcPIyk9qiYl6]
X-ClientProxiedBy: BLAPR03CA0074.namprd03.prod.outlook.com
 (2603:10b6:208:329::19) To PH7PR11MB7643.namprd11.prod.outlook.com
 (2603:10b6:510:27c::22)
X-Microsoft-Original-Message-ID: <bhoj5rnr26ymviqwbnalutlgwy3cuyilgvyzatcfy23ckej6dq@3h3hfsntz2ip>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB7643:EE_|SJ0PR11MB6790:EE_
X-MS-Office365-Filtering-Correlation-Id: ae6c8842-6521-400a-950c-08dba697849d
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pjCsGEUmfx6X0ocAejo1MPto2ISDb3k3eBTPZ87BrQTw2Qki92TXOZt7099pmIJu1Ms4mxw9QPYHdJ/HtJxBmtMPKzO/nsm7aNHiakoO+fAEe3Z/xwVz9mdHXabRvzD3dUtIx+oJkk3L6EQ/50bHUJYIRGATYMVru0XfcNiCvjWJ1fw7UHbc0SCCMXubcd9JsEr4Pq2VrGthxRFZa/6cBsazhPi1+5UuoTYMewp8LXlyLAnwUMHPP2yzBHjPpqHtXRKYBgPIBikmNF+l3BNJTBHmqMU9P6oZjijqVLQ8V1YiYlI2YRGQSPwFpD8qwUTURULkqUojl10cHPvxTiQ97LRYLtNjHuHXJml6t/R4PtCpQqcn6MdBY0z0VxD4QNFrXE2Y+feMAVwIFRr8XR9mKyhhkkgl2GHE/PShYHDef2JzuDQRBNQtEHYu41sLAsLJArUaoCV/tltWJandgVRow8D2hRMNgkgy9AtYLij5zZVfSUPJtSIzXUFdoQNQxK6jKX8u9AsEQVrwIWlYH8zeBlADMY7sD3vp+eVj1XeGvq0Q3ZZ+gwY+Irqef3bdkKXv
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mvVrfmTjFl5oRh2H8N6ugXs3GxVclFWeH5KPLegS7DnWyqfmK602clQvLSm6?=
 =?us-ascii?Q?cW4Rj2Y3HGMLqHRO0mTbJr2P2yEjUw7oQOGWqCnvEn4U1HSANEus/fjuHP6U?=
 =?us-ascii?Q?FF8Fq6mF+Es3caIhPMuCi5a+u3dIA8WH8sKJcXzmWfjcBy8MvtWoWDD5LzJT?=
 =?us-ascii?Q?7JiMB/j2GeQSPJL5+fQFJOa48lpYJY/bOrQ9zY4JJ4/oND3gH76U/xlFtej7?=
 =?us-ascii?Q?7tIlh0d3T1ApHt7vPVEhkcPPV7riKiSWAZVqYmghXnz7SeR9frhBDwDSMw1d?=
 =?us-ascii?Q?03KLzAbWasARm1CWtBVLKhJW8gn2GlO0BDy0pljBV48zwPdXKMd6QNUluayi?=
 =?us-ascii?Q?6CJo1NBeYvkzpIdR/J6Y/go+BnH4BmY3QfbYEw3eCOo0/MhI4qLKGIpyr8Lx?=
 =?us-ascii?Q?+GSvVvMpzKNVCdCnB/cPlOAulUj5oUR6+KcUqMEbGDgOW8tGuqjDVZJFqiOk?=
 =?us-ascii?Q?Ao664+e+iuHIQ0hGI1Zpx3zjlMLetxDLJ1TEsM5MtXrzWr+GKPgvuOuo1ZpK?=
 =?us-ascii?Q?e6vSvtaUL6Ak18+B1H8kJXtbXqyemrp5Emoe4OdsSf7hRAGAUBxEyqzXvi+P?=
 =?us-ascii?Q?TXzCsxXgXoLrW4ots3jvQzmRiTAvwg61tvz+AX7NhFzHs+Wpz99vHdUUG1DW?=
 =?us-ascii?Q?ecvFl6veY+XawsXWYzxLX4C8xvcR6hdnz7uCkkm2SIy5Q6nRdMUsdldlUHdC?=
 =?us-ascii?Q?/XxyYDP441oR8G0eTE+Sw7Wj93H9XbBojdF9JLbtl/j9aF2NGoOFniIY8nVu?=
 =?us-ascii?Q?wQKA6LHvX0xhJVOsWmq4o9Hws8IWfBiPV0q4KV4b1z/OtkZLyqFHHevM3gG9?=
 =?us-ascii?Q?ACjURjVmJZOLsu8RtXhzRn57c0uU+pyNx+jYJu3MTGVv0OuMKzWw9yNmsNQr?=
 =?us-ascii?Q?mZObZiVROZrOvxjl/Q3XggO7A16Yj8neGSW1eEe1fzlaLQVv8FlyXeymyevm?=
 =?us-ascii?Q?o1uQlsbu977Hs4vfSlKrISVjmhJ1gzwDyOU89qHxymJEtwj8lNWkEuSF7aTq?=
 =?us-ascii?Q?O2XnyfOMSiZEqdkB9tw5yjYLBX5CyEtDnMbz1e77yMVT5TFa1/y1YZqhBKZ5?=
 =?us-ascii?Q?Qen+Tsw5HBynJ1fllj1IYuboUSxhFRSOXY6Mp8UXpg8yOs+zBuVAS6H1X2c2?=
 =?us-ascii?Q?NS09toCfJ0nm65J8vZ1lkfOEV6LZWzeBaEg1lmrhbHxJr62NsTEcB8gY/TIm?=
 =?us-ascii?Q?a7UOd11V0F6uyAeN04fZMoq/5/6mhOIujHMWn6z+CrUVX4miPkvYp+usG8nZ?=
 =?us-ascii?Q?J6QYCui6kw1t1C0pd0q+X+G5S6hc3IiHv/7egzsRnw=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-e8f36.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: ae6c8842-6521-400a-950c-08dba697849d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7643.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2023 00:49:50.1775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6790
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch cleans up the octeon ethernet driver,
and makes it better adhere to the kernel coding
standard.

I am sending in this patch as part of the 
Eudyptula Challenge.

Signed-off-by: Oliver Crumrine <ozlinux@hotmail.com>

---
 drivers/staging/octeon/ethernet.c     |  6 ++--
 drivers/staging/octeon/octeon-stubs.h | 50 +++++++++++++--------------
 2 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/staging/octeon/ethernet.c b/drivers/staging/octeon/ethernet.c
index 9eee28f2940c..8e1f4b987a25 100644
--- a/drivers/staging/octeon/ethernet.c
+++ b/drivers/staging/octeon/ethernet.c
@@ -201,8 +201,8 @@ EXPORT_SYMBOL(cvm_oct_free_work);
  */
 static struct net_device_stats *cvm_oct_common_get_stats(struct net_device *dev)
 {
-	cvmx_pip_port_status_t rx_status;
-	cvmx_pko_port_status_t tx_status;
+	struct cvmx_pip_port_status rx_status;
+	struct cvmx_pko_port_status tx_status;
 	struct octeon_ethernet *priv = netdev_priv(dev);
 
 	if (priv->port < CVMX_PIP_NUM_INPUT_PORTS) {
@@ -798,7 +798,7 @@ static int cvm_oct_probe(struct platform_device *pdev)
 
 	num_interfaces = cvmx_helper_get_number_of_interfaces();
 	for (interface = 0; interface < num_interfaces; interface++) {
-		cvmx_helper_interface_mode_t imode =
+		enum cvmx_helper_interface_mode imode =
 		    cvmx_helper_interface_get_mode(interface);
 		int num_ports = cvmx_helper_ports_on_interface(interface);
 		int port;
diff --git a/drivers/staging/octeon/octeon-stubs.h b/drivers/staging/octeon/octeon-stubs.h
index 3e7b92cd2e35..0da5a4b7288b 100644
--- a/drivers/staging/octeon/octeon-stubs.h
+++ b/drivers/staging/octeon/octeon-stubs.h
@@ -213,14 +213,14 @@ enum cvmx_fau_op_size {
 	CVMX_FAU_OP_SIZE_64 = 3
 };
 
-typedef enum {
+enum cvmx_spi_mode {
 	CVMX_SPI_MODE_UNKNOWN = 0,
 	CVMX_SPI_MODE_TX_HALFPLEX = 1,
 	CVMX_SPI_MODE_RX_HALFPLEX = 2,
 	CVMX_SPI_MODE_DUPLEX = 3
-} cvmx_spi_mode_t;
+};
 
-typedef enum {
+enum cvmx_helper_interface_mode{
 	CVMX_HELPER_INTERFACE_MODE_DISABLED,
 	CVMX_HELPER_INTERFACE_MODE_RGMII,
 	CVMX_HELPER_INTERFACE_MODE_GMII,
@@ -231,20 +231,20 @@ typedef enum {
 	CVMX_HELPER_INTERFACE_MODE_PICMG,
 	CVMX_HELPER_INTERFACE_MODE_NPI,
 	CVMX_HELPER_INTERFACE_MODE_LOOP,
-} cvmx_helper_interface_mode_t;
+};
 
-typedef enum {
+enum cvmx_pow_wait{
 	CVMX_POW_WAIT = 1,
 	CVMX_POW_NO_WAIT = 0,
-} cvmx_pow_wait_t;
+};
 
-typedef enum {
+enum cvmx_pko_lock{
 	CVMX_PKO_LOCK_NONE = 0,
 	CVMX_PKO_LOCK_ATOMIC_TAG = 1,
 	CVMX_PKO_LOCK_CMD_QUEUE = 2,
-} cvmx_pko_lock_t;
+};
 
-typedef enum {
+enum cvmx_pko_status {
 	CVMX_PKO_SUCCESS,
 	CVMX_PKO_INVALID_PORT,
 	CVMX_PKO_INVALID_QUEUE,
@@ -252,7 +252,7 @@ typedef enum {
 	CVMX_PKO_NO_MEMORY,
 	CVMX_PKO_PORT_ALREADY_SETUP,
 	CVMX_PKO_CMD_QUEUE_INIT_ERROR
-} cvmx_pko_status_t;
+};
 
 enum cvmx_pow_tag_type {
 	CVMX_POW_TAG_TYPE_ORDERED   = 0L,
@@ -384,7 +384,7 @@ union cvmx_ipd_sub_port_qos_cnt {
 	} s;
 };
 
-typedef struct {
+struct cvmx_pip_port_status{
 	uint32_t dropped_octets;
 	uint32_t dropped_packets;
 	uint32_t pci_raw_packets;
@@ -407,13 +407,13 @@ typedef struct {
 	uint32_t inb_packets;
 	uint64_t inb_octets;
 	uint16_t inb_errors;
-} cvmx_pip_port_status_t;
+};
 
-typedef struct {
+struct cvmx_pko_port_status{
 	uint32_t packets;
 	uint64_t octets;
 	uint64_t doorbell;
-} cvmx_pko_port_status_t;
+};
 
 union cvmx_pip_frm_len_chkx {
 	uint64_t u64;
@@ -1258,15 +1258,15 @@ static inline int octeon_is_simulation(void)
 }
 
 static inline void cvmx_pip_get_port_status(uint64_t port_num, uint64_t clear,
-					    cvmx_pip_port_status_t *status)
+					    struct cvmx_pip_port_status *status)
 { }
 
 static inline void cvmx_pko_get_port_status(uint64_t port_num, uint64_t clear,
-					    cvmx_pko_port_status_t *status)
+					    struct cvmx_pko_port_status *status)
 { }
 
-static inline cvmx_helper_interface_mode_t cvmx_helper_interface_get_mode(int
-								   interface)
+static inline enum cvmx_helper_interface_mode cvmx_helper_interface_get_mode(int
+									     interface)
 {
 	return 0;
 }
@@ -1342,11 +1342,11 @@ static inline unsigned int cvmx_get_core_num(void)
 }
 
 static inline void cvmx_pow_work_request_async_nocheck(int scr_addr,
-						       cvmx_pow_wait_t wait)
+						       enum cvmx_pow_wait wait)
 { }
 
 static inline void cvmx_pow_work_request_async(int scr_addr,
-					       cvmx_pow_wait_t wait)
+					       enum cvmx_pow_wait wait)
 { }
 
 static inline struct cvmx_wqe *cvmx_pow_work_response_async(int scr_addr)
@@ -1356,13 +1356,13 @@ static inline struct cvmx_wqe *cvmx_pow_work_response_async(int scr_addr)
 	return wqe;
 }
 
-static inline struct cvmx_wqe *cvmx_pow_work_request_sync(cvmx_pow_wait_t wait)
+static inline struct cvmx_wqe *cvmx_pow_work_request_sync(enum cvmx_pow_wait wait)
 {
 	return (void *)(unsigned long)wait;
 }
 
 static inline int cvmx_spi_restart_interface(int interface,
-					cvmx_spi_mode_t mode, int timeout)
+					     enum cvmx_spi_mode mode, int timeout)
 {
 	return 0;
 }
@@ -1381,12 +1381,12 @@ static inline union cvmx_gmxx_rxx_rx_inbnd cvmx_spi4000_check_speed(int interfac
 }
 
 static inline void cvmx_pko_send_packet_prepare(uint64_t port, uint64_t queue,
-						cvmx_pko_lock_t use_locking)
+						enum cvmx_pko_lock use_locking)
 { }
 
-static inline cvmx_pko_status_t cvmx_pko_send_packet_finish(uint64_t port,
+static inline enum cvmx_pko_status cvmx_pko_send_packet_finish(uint64_t port,
 		uint64_t queue, union cvmx_pko_command_word0 pko_command,
-		union cvmx_buf_ptr packet, cvmx_pko_lock_t use_locking)
+		union cvmx_buf_ptr packet, enum cvmx_pko_lock use_locking)
 {
 	return 0;
 }
-- 
2.39.3

