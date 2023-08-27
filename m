Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01C22789DF2
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 15:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjH0NCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 09:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjH0NCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 09:02:15 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2040.outbound.protection.outlook.com [40.92.40.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B0F13E
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 06:02:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CNyxfJYBGlDyV15J85IBtokkErwl2vXJ+t+DGM09oJ/zPQjOYm3jWzndmt4HjNtY2FHtIkck4EO21nnbeh1EnoHtAQsxm42HXJm9/SiRONzdmRQcpnc/IwEHUQMsBoBPLPdeab6IQ/LBw217Oosxvnn9Exs1IJekT344YVnFzAFzpZ0QVAWbaI9CoMMOTxreblcvP9NdpPu0fojSgkdlUE3CEJbsMaElljvgGdfTqZYQe7wm55oKKA25vwYPM8dkJvnIh3u20TJyYHDM/PFWDLPPKm1GjwtmFVK11yBYNqj18m+bXvV/SlXnjxe19mLXfpxNlVcY1UQwnzdmSjdTNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=97G8GsOig44zfrkGr2XYr28FfvlautVyVc122xyDBLg=;
 b=XYlTXUA7Y2HbipyNwC6aLn/y56QZVeII2J/7A16fbxAccxRgqQbXBQkSI4kZ+KX4f9emiFuBn+PNEb5+Siv483Y+X3feLqMul8lK/A/GzppCQowEKojw56xfox+GVwuCdygoRioA75GTVdEshNnhdd0SSrpbwNxRp8bqjgRtKRW/PD24UIYCGXpqLMuTfNKB0Yq0D5HtHpGZZ2IH7rkQs1/xn7ncueXg5lU3U1OLDjVmH/7UqCq0aHBMylHo1HBqo0lHj+y4zpClBPwGiSUWT/Svj+RE4AO0sBe9N6iITI5Ym6PLYvkDTxuiQN9WkHEMT7Pr/iBsCPGJTl1nFJ5MRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=97G8GsOig44zfrkGr2XYr28FfvlautVyVc122xyDBLg=;
 b=MfN8/EkW4cLzl7FI70GCDGgiDytcZshdDHWFJaW4tfu26AczIj03mejhOV9lPDutvYpHBwvfrUDtkwoTNHn6q7WGF7373FeCI3lYR9bQZoeSvzrTr+6DVmFGBeaBAUL7wECIqTFWXep9nNGly5f8lgev+UHEPROV/Nfp8c2ebnlNwdUd0kOh88MQm0moViypZFS/1eysHPbwD4WearU/EW3kMEorD+Qs+1ixFYapVoR1W1mPpsSkQweIZb+Ug2TDM7RSJ0lYPWyZXqeC0pZd2jHuj3VGOSlud7iD3J0pl2EJQ5MieSt59Wsvcbs/pAwpEt413GBK2m3bNuMVsdhWnA==
Received: from PH7PR11MB7643.namprd11.prod.outlook.com (2603:10b6:510:27c::22)
 by CH3PR11MB8444.namprd11.prod.outlook.com (2603:10b6:610:1ba::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Sun, 27 Aug
 2023 13:02:11 +0000
Received: from PH7PR11MB7643.namprd11.prod.outlook.com
 ([fe80::bfb7:d3a3:2ed:6e20]) by PH7PR11MB7643.namprd11.prod.outlook.com
 ([fe80::bfb7:d3a3:2ed:6e20%7]) with mapi id 15.20.6699.034; Sun, 27 Aug 2023
 13:02:10 +0000
Date:   Sun, 27 Aug 2023 09:02:07 -0400
From:   Oliver Crumrine <ozlinux@hotmail.com>
To:     gregkh@linuxfoundation.org, colin.i.king@gmail.com,
        sumitraartsy@gmail.com, u.kleine-koenig@pengutronix.de,
        geert@linux-m68k.org
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH v2] staging: octeon: clean up octeon ethernet driver
Message-ID: <PH7PR11MB7643572E8C1231C013762613BCE1A@PH7PR11MB7643.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TMN:  [0aovzwC9wF8TyEA4T6CJNmvbUVwikuIndpNfMcjQu1d22f1EcqDEH2fLS1qlRfzB]
X-ClientProxiedBy: BL1PR13CA0128.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::13) To PH7PR11MB7643.namprd11.prod.outlook.com
 (2603:10b6:510:27c::22)
X-Microsoft-Original-Message-ID: <dfxnlxc6nxwk6qxlv4tf67hzyd6maofv5f4w5y7eyijywrdwxs@nmc4trwiduxb>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB7643:EE_|CH3PR11MB8444:EE_
X-MS-Office365-Filtering-Correlation-Id: 62e6a8c2-9449-4a6f-1314-08dba6fdd343
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p4hZk4R9sg/lRN7zqdoDFxqCQkoNqAzfsi3rzwhytmZRBRRtQg6t2PpIuw3nZLuc9hz8dmCw9tSs9Nrrw8JVihk3sP4ABZ4qPjkwtQm0Rw7edxO30f0LxU4/ax8MF/3ua5mbeL8+XVArLkuX9PSkqM7qT2ydvk3oHyLza2Pf/MOUrjQehEifkkxmHNiDbBskxD3ESJQsgfTWEBIXux5vlPcAAldrYKX5880AGOBf2yCRUjKdTOcy7HyJHayzLZ0+nW+LYWQ6onWfe8d76CwBduLPUyKQtbfKQCUYoIL3ba9HtBbdvjQNV4lcvpwgKMHpj+zWZHOuAQ/SNKTvtNEbHB2wGBLj2qyE36LeLsnBiujDSfHBtPUnuM7bGiNijJ8OUFa15trvvbi8gFVOPURleoZSX3yB9pAXHoh2A9HZEKuaaM5eHk5K8hLa4wj6KLf/27pVwuDdT2yXqg28t4IWclg9bAygZZ5zFdaFpCjbbsBGUlHovWqOcYqjni9bRUhUFf41gSpmhsGCZ861OkTsnD9eIe/3+QA/KWf026ehVXGdqtJOfpr7pmD2gRtVdqdJ
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ew1I19J3mvr7tsxlLlcCdbsdPo2XAyEer42QJprc7lvoijLG7p2OK2gjVznU?=
 =?us-ascii?Q?NnUEHlySvqc+Opi6w17P31jiSO9IIz2Q3knDEOqREjnEulrmwMDocyf5cLQV?=
 =?us-ascii?Q?RICspJ2Qd4++dpwpHw04C0LNV/fGFIKeGMWftfZHfJfm19Uk2fWETmkbG3yI?=
 =?us-ascii?Q?hxaUUh7DRUdBLDh93LqvjVbY2D4rMhxOxpVa4jZZwUSU+vrVJ+DB2IVqXA82?=
 =?us-ascii?Q?QuB8lnilGMDU2dlmukUO5/zehsKeCwBUjpFq7tMr0s9GjFp0TO3pbPHD6Ynz?=
 =?us-ascii?Q?yzdR8rsSfDk1U0NRfuZ8f5XgdTVm+OaH6CHE4iIkdkKejuZe3CSymrw1PEp9?=
 =?us-ascii?Q?K/tqqVM7o+cHbXWDB4rElmtKf2aYsujGgPd/H6wokD+pzuj1HT5CfdrVfDS8?=
 =?us-ascii?Q?XDb+ePklt0qNwAnTJbiyU1NUD/qP/H2QJojLJkGesMlJwhJVKmDdsK4A6GEr?=
 =?us-ascii?Q?Cg/kVeGGsFmar6yXWfeKYC1Qn/YGhSU5DVmOjvgOoVOtvYmXEvXtmmezD4I+?=
 =?us-ascii?Q?itPtchahN7B9iz+3XkkIzY1/u8wWijuwRFXVe9vktgeFXZg8eYMnqC3xsA4w?=
 =?us-ascii?Q?fsaMUIvqHk6OP3p2t1O6UyLeUNqDOxvDW7Eu8KUfh1613F08hSAqpEwKpz4C?=
 =?us-ascii?Q?7ZGjko7/0EMV6rU+kE1fsMvbjacTBkSoaAoF75Gi4eO85M1E8fEE6wcG6Rsy?=
 =?us-ascii?Q?XRFeOUqvEDmvds1j9UsOiAoHGbFbNj1kmPC8V9Bl5Ewbp5qJr+TN8pIVSVdh?=
 =?us-ascii?Q?qOgq4b6E42e/kdXGpJqjmOqiceFZkSZFvcpwUXCQ9RISDgK3eG8EpMJXiqhx?=
 =?us-ascii?Q?rOT7dD//rS1ATo8DeI/fHq+h8Ih1hMMp3M85qhN6lt0ScrBKokskfMDzjLyC?=
 =?us-ascii?Q?MMqSVj4JxZ3S1dS1AV1xzedj47UBQDNvMLIoP99chMLeY2KVbyrnlRrxjctE?=
 =?us-ascii?Q?hflak2hERUi8u5pjLQAgOdmS4MJJhYDdvHrv97ZlrPwluyO29En82o89SSeg?=
 =?us-ascii?Q?xIuZq5AFpmsu1XzRINshY0UdM4M5Z9Kr+36nF4r6GqyvtvuKc1UA2Eq3aYQI?=
 =?us-ascii?Q?i/BoytGSJZ/Gv3g856swXnDV+QTEbcOcm1xS1EZHCPAKF8knnVnbeAWzLTVT?=
 =?us-ascii?Q?pwIR/Dmo4IPyTRqlhopCXobeIvL/wlQTjB+KFPDMOg2R1t2Brb1rnlKF8yGh?=
 =?us-ascii?Q?GA0SIy2wOiwE0PNJFFeGY6CN3NBXdwJBd2fntMH82RFm7xwWtlFNQCH1Qf32?=
 =?us-ascii?Q?cJLRKMeoGw0CwwE82YO9EkzKYwLB+ms6ZiQQ69xaBQ=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-e8f36.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 62e6a8c2-9449-4a6f-1314-08dba6fdd343
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7643.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2023 13:02:10.9290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8444
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the octeon ethernet driver better adhere to the kernel
coding standard

Signed-off-by: Oliver Crumrine <ozlinux@hotmail.com>
---
 drivers/staging/octeon/ethernet.c     |  6 +--
 drivers/staging/octeon/octeon-stubs.h | 53 ++++++++++++++-------------
 2 files changed, 30 insertions(+), 29 deletions(-)

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
index 3e7b92cd2e35..1e3b32b304dc 100644
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
+enum cvmx_helper_interface_mode {
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
+enum cvmx_pow_wait {
 	CVMX_POW_WAIT = 1,
 	CVMX_POW_NO_WAIT = 0,
-} cvmx_pow_wait_t;
+};
 
-typedef enum {
+enum cvmx_pko_lock {
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
+struct cvmx_pip_port_status {
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
+struct cvmx_pko_port_status {
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
@@ -1381,12 +1381,13 @@ static inline union cvmx_gmxx_rxx_rx_inbnd cvmx_spi4000_check_speed(int interfac
 }
 
 static inline void cvmx_pko_send_packet_prepare(uint64_t port, uint64_t queue,
-						cvmx_pko_lock_t use_locking)
+						enum cvmx_pko_lock use_locking)
 { }
 
-static inline cvmx_pko_status_t cvmx_pko_send_packet_finish(uint64_t port,
-		uint64_t queue, union cvmx_pko_command_word0 pko_command,
-		union cvmx_buf_ptr packet, cvmx_pko_lock_t use_locking)
+static inline enum cvmx_pko_status cvmx_pko_send_packet_finish(uint64_t port, uint64_t queue,
+							       union cvmx_pko_command_word0 pko_command,
+							       union cvmx_buf_ptr packet,
+							       enum cvmx_pko_lock use_locking)
 {
 	return 0;
 }
-- 
2.39.3

