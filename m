Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F93978A367
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 01:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjH0X1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 19:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjH0X01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 19:26:27 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2046.outbound.protection.outlook.com [40.92.40.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8948AB2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 16:26:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gXXhMXSvlkyjWpWlpTu0KsbqWk7LgtxcnDBwy3Xz6QwR5BIzJ/gGyX2iNCHH24iwaqjim3A3drFAMgXOpGi+KQ+ILPWaKfqjlAPKDftd6heySPsC86ipkZQBwrd1c8Cg2zmGH0fnZOCgAne90HJcpm9yfAaghwYh/P/z2NCkm55mA4dj7uGnu+V2mLsntv1CYfJ7K9UA1kMup/cqxdGzGeKVrm4hV2wn08h2BOyuLFBpO3mkIGbrx//gVRS/7Q8pXfTLuixyLYk4HdyMXh0U1TW91YQvAa//9+I+3MZmYeQ41ESsuTq/0ihenWoT/gXQFclrtreWwmsTnaUxqM0pPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H9ZcTvbjjwmH7khTxenib3GadtXET1mh5VUVWTZNQxc=;
 b=HPSqSh3nnddGDU4olUxrUZa50iEr+HY79E94vOdnQNpPFI5VWZ0LCONwBlXOFeh8rtvxHYNYTEsXXDaK98A7prLce/C0lWZvgEfG/i5PDCklsuOZxdR0It4a21Fgi1vpNrfi2Cnsk5mUUdWBJkjBivLMNL2wnG+sktYYP3JDLo5swbBrdvsp6piGKtkvuZ2xWyglsZNElP9Bm7/C4ixfMEqIJvHAtIDHH6c81XyvN+JxkOFD5s3nVX3UjneB9IvyEnUAMrWGElPLCblcHHZ1GYe4VtNDAeRLliOlMlhIC0+gXo0mgAhalNIiNSm2G4AFuPh92kxg+3GrT8JaJ30wUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H9ZcTvbjjwmH7khTxenib3GadtXET1mh5VUVWTZNQxc=;
 b=UYorronxRC/1iYHCebCTaOxTCRtTw89U3FFq05GjuZUjbBCbE8K+0XERjKo7GCGL/PscZr2xbjtdkrWNBfVzZOtRfl2AxLPIn/bqf0812ketKxoIwbRW0kQCYS3M0+bhc9EQWF/djnv1/RgE5Mod4ZReOZh9Mk/wiZtxXhSTXvGUpmG0NmRSBigQ3rcjj6rp/pnnp1Plk0qKLxaBBGSF4rglfzzDmOymWWyB/L7dxJuIUfRqmfNO7f386vc+EdZwfbC/QQkppmLfhJSAB8EJ9Sxe1+JMAWwZfuUPnrzGsdngYdGutjiL5JuuL/iMy1Qy0tF7EowFDDTYJ99vip+7Cg==
Received: from PH7PR11MB7643.namprd11.prod.outlook.com (2603:10b6:510:27c::22)
 by SN7PR11MB8027.namprd11.prod.outlook.com (2603:10b6:806:2de::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Sun, 27 Aug
 2023 23:26:17 +0000
Received: from PH7PR11MB7643.namprd11.prod.outlook.com
 ([fe80::bfb7:d3a3:2ed:6e20]) by PH7PR11MB7643.namprd11.prod.outlook.com
 ([fe80::bfb7:d3a3:2ed:6e20%7]) with mapi id 15.20.6699.034; Sun, 27 Aug 2023
 23:26:17 +0000
From:   Oliver Crumrine <ozlinux@hotmail.com>
To:     gregkh@linuxfoundation.org, colin.i.king@gmail.com,
        sumitraartsy@gmail.com, u.kleine-koenig@pengutronix.de,
        geert@linux-m68k.org
Cc:     Oliver Crumrine <ozlinux@hotmail.com>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH v2 2/6] staging: octeon: clean up the octeon ethernet driver
Date:   Sun, 27 Aug 2023 19:25:52 -0400
Message-ID: <PH7PR11MB764323F0778C215EB85F2B50BCE1A@PH7PR11MB7643.namprd11.prod.outlook.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1693177830.git.ozlinux@hotmail.com>
References: <cover.1693177830.git.ozlinux@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [Ud4VMmdMY6kgoA/6djZAiBQKgz9XH1OPQNu98RUITM2xd49Y5d53sJ2AS31VwBMN]
X-ClientProxiedBy: BL1PR13CA0005.namprd13.prod.outlook.com
 (2603:10b6:208:256::10) To PH7PR11MB7643.namprd11.prod.outlook.com
 (2603:10b6:510:27c::22)
X-Microsoft-Original-Message-ID: <4b6d2f7303b6a3d37e2aa62a76421acb8fef0146.1693177830.git.ozlinux@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB7643:EE_|SN7PR11MB8027:EE_
X-MS-Office365-Filtering-Correlation-Id: 19ccfa8d-3e76-4231-e6b0-08dba755037f
X-MS-Exchange-SLBlob-MailProps: AZnQBsB9XmrTVQo2E8YhiYZbimk9QHlfee0RmoCxeVJ9nB1vJLeXwXw0xPDLgrSMl42GWYv0wh55kYyHsOKGII0YR3bo45mDXT5qUvkTY3dlwXyv9UY4qAkGiSdcgRft1hJhzqxTjoR4/YDNf5fQntS98g0uKmtBK3IOa4sJnI/rw99b3y4tboe0nYN9/gGsAEdF6R30NlFMU7jPgonX0e2BhVv1IENGPSUEBsc8fmrgI7Te/rqL04PS7clMWGMyWLcuIWB+6EGeUBjHwKnUE9LXdb9suA/7g5cBMbOMFNmy9luipJHUT/Ui7sWPBXKrAaBh9Bxp7p7fxVZBaSz1SlJslWHYuRpJ1wpdxr6X8AKpb1a/Dt6/QL3dP6VraR2NipOz2cQYQnsq5iwlcho0S3Vojzz4rheIJGzAZutule2dn4w2pC3so8YcHEKl7NANGN7ief4YulQrSi3CtSp/FlnMv8Rdn7F+NXNdOmcm5SDcOcAy2+IPpfgOWCdxmSV0uY8liMGMUSpXEdgghjpIGVK3M7DVgzJlJsBTZ9ojUuvb+8r4oWofKP4ablTRXlXsfOlZ069No1pA8yLyryYs9/DtujioWP98PGQ8Tmq8vBe6tNKQ1+v/7Ppme6oDqbJgDUnzCy8sVS/7SsosPav2uRF2/PWwiWf4sVFYlKdzc9B1cBceas787jOVX1VHc/rmC34FV/ixe4ERgy+RgHA2RC0XLGYCv+8ETpvLgIKCyJ1nl5zEJDird+TPbqImOsLjrl+aUBrcjtc=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IKU9H5rEpVz5LAd90/810DLcCVF8TLDVGipuMOkvPefMuHXDLpX9t347WLJ35oRmT/gpO9KmNjNrN53mHwXoX/QF1edTSO0mC3SWfKvI3TrQ/oFt8Y8EZbxVqu1AtGPiy9HQ7WKYLNzgvz6PQwBduM8O3ZOoI9C0nz0oietgWqRwhJ9pXdL7Me4f7GEL2w5gFD7/UtTlzl7/MEFTVv4AJ+mSZGjWHVP5WN8bKLF3Q4rT89uUDMtqT4R2TpHLs6XFnjeRIN4mmQYsaVdO5vor9jwF594DIETmtB6NHADVD6sxAUBx0fxW8dZTaMSXg0s2V+OQ+5vx53kwcxsTqI1SGrIDIQiUy5iwea14BCRqt++2VusuVwrktP7d7eJlZN+mI1pX2Ax1tn3akIJO9PT5MsP4GheCJdERiRGUwowITomVg6mSKNVLeExPSnBq3nXtv+rnvbxnhMoiEsmdqwZMYRV75gFUt9I0DoE71SOBrE9nF+mBLfcmUXQ5oFo2petobbDz5B2yIE39xC96A1nru3nyosUxLQKLdAGnCfGpdHzXIbtnRQgxT2cuu+yhM4P4PPAKe3U7ldZq1JY5WUAzjThh9g71XajbRmZFsp7uP88lysnP9nM6OVosIJB0flbu
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KeFOHbJcOEAqeisbTTx5lJgCb/U47djr9TYgii5GwKSfNTvzxRieJZ3zekbU?=
 =?us-ascii?Q?mtmmJD8AfOFmDgUh8qKuBexT+JNOLXHTKKDp2NPp0Fz//g6r4B1xZt677OtE?=
 =?us-ascii?Q?ULaQ0mj6yG6Ce6aupMzfO5je2IVHOaJBd/kepsDBT0XmAiln8vRat2SRzwPh?=
 =?us-ascii?Q?Iv94Xix59PY+KKL8YgHFn7KxA6ZTg6mCd9JCgYuCex6v7taqZd4Or287fVlh?=
 =?us-ascii?Q?jsV2TKSqbyDTTC4l6i7pNq6B0h6NjDaXIBmoyjw0WXn0pVhHsRB8eJDF4D5V?=
 =?us-ascii?Q?jmrRyWSwmEOyD3apjSNcmrWP430Ih/mbRm+YKv2CWdPjpXsTn2/4BvUyqBN1?=
 =?us-ascii?Q?VTW6jeBz/Bnb7T1ttOAjpXsbJr7lpuQTQMeyGvhyp0R+n4BJVjdhF3vr7yZF?=
 =?us-ascii?Q?jUKLMGNPNY/Ul918tX3Q1b3zr2fqc0RG+S9ZzxbJZEBPzIuSYucw7BnzUpnp?=
 =?us-ascii?Q?NHuOhV08uWvCl3pXxXMMgOdiPPgf1CFoTuXIsAVf+ZBmMUPKzdyxTiyVck41?=
 =?us-ascii?Q?LrGhjLO6qAhbIlhGnCcB8QNlQng95RkhAU29nY1nOtV6EL8QBKjLYXQkxzYV?=
 =?us-ascii?Q?7xgurwGDWzw2g01OrANLdNEI2pWx1eShb3U/9CXQPwxmmM/AOkviw1H9QcOo?=
 =?us-ascii?Q?m0H2FZlXxlrZU3onPB1QXYQPp6GmmVFJWgQ8DGpsEBMRXz7GjKBn6c8rrPvE?=
 =?us-ascii?Q?x8+2Q5gvb4Rbv2fQVsKRl6xTnhltSQLzn9wRo+rdNIACiI6nOsaVvne00XxA?=
 =?us-ascii?Q?0iOJK/NVjyuqpusicYHvoBufGyyWLWgOooyKYNLc+FYX8dXAqx/JrAFdUNv/?=
 =?us-ascii?Q?Fi7f87GDCxaQmT4EL3yDuhJiG1BQUoZD5b20kmTIx8+f1UytH3ol7hsUPgKQ?=
 =?us-ascii?Q?MMSvhN3C9bTbVEP471IscG/ySg0WNXPFFqF7Ty501ta8VmMGcY7Nli7MKpQz?=
 =?us-ascii?Q?JnsfVaMoSAQh8EuGCcktwUqgmo0QXhcvI0HGbmSKcxjMxoUrmOcGpZSeUc0N?=
 =?us-ascii?Q?i8MNd164HWc11d/uvUkNV/1k6X0Db+c2al52ImtoWIakjiRhZ/Z4GYpPd/gY?=
 =?us-ascii?Q?F3Sq7hFXUwvsPMxI6ZwQRQ0/tD2Ed4SxnvhwphOubMNfCQYKI7hibivAOqG6?=
 =?us-ascii?Q?HeHpa1bl7+4+2aO6NCmASZQUSfXvx8ilQA+SP/pFZiL1eV3g5DaMnRUosxN2?=
 =?us-ascii?Q?ldohOq3f5HTa8K++NgMN1DoAooHOarZRA0HoG6QEfGcH/lFrYmpqF+m3hNyr?=
 =?us-ascii?Q?RsmWRXn5XnCSgJ5hPh8o2PNnlBpDFCyU6moSRedApw=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-e8f36.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 19ccfa8d-3e76-4231-e6b0-08dba755037f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7643.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2023 23:26:17.8915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8027
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the octeon ethernet driver better adhere to the
kernel coding standard

Signed-off-by: Oliver Crumrine <ozlinux@hotmail.com>
---
v2: Actually send the patch set properly

 drivers/staging/octeon/ethernet.c     | 2 +-
 drivers/staging/octeon/octeon-stubs.h | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/octeon/ethernet.c b/drivers/staging/octeon/ethernet.c
index 9eee28f2940c..023b107e077a 100644
--- a/drivers/staging/octeon/ethernet.c
+++ b/drivers/staging/octeon/ethernet.c
@@ -798,7 +798,7 @@ static int cvm_oct_probe(struct platform_device *pdev)
 
 	num_interfaces = cvmx_helper_get_number_of_interfaces();
 	for (interface = 0; interface < num_interfaces; interface++) {
-		cvmx_helper_interface_mode_t imode =
+		enum cvmx_helper_interface_mode imode =
 		    cvmx_helper_interface_get_mode(interface);
 		int num_ports = cvmx_helper_ports_on_interface(interface);
 		int port;
diff --git a/drivers/staging/octeon/octeon-stubs.h b/drivers/staging/octeon/octeon-stubs.h
index 9f269626b862..0b0c609a771c 100644
--- a/drivers/staging/octeon/octeon-stubs.h
+++ b/drivers/staging/octeon/octeon-stubs.h
@@ -220,7 +220,7 @@ enum cvmx_spi_mode {
 	CVMX_SPI_MODE_DUPLEX = 3
 };
 
-typedef enum {
+enum cvmx_helper_interface_mode {
 	CVMX_HELPER_INTERFACE_MODE_DISABLED,
 	CVMX_HELPER_INTERFACE_MODE_RGMII,
 	CVMX_HELPER_INTERFACE_MODE_GMII,
@@ -231,7 +231,7 @@ typedef enum {
 	CVMX_HELPER_INTERFACE_MODE_PICMG,
 	CVMX_HELPER_INTERFACE_MODE_NPI,
 	CVMX_HELPER_INTERFACE_MODE_LOOP,
-} cvmx_helper_interface_mode_t;
+};
 
 typedef enum {
 	CVMX_POW_WAIT = 1,
@@ -1265,8 +1265,8 @@ static inline void cvmx_pko_get_port_status(uint64_t port_num, uint64_t clear,
 					    cvmx_pko_port_status_t *status)
 { }
 
-static inline cvmx_helper_interface_mode_t cvmx_helper_interface_get_mode(int
-								   interface)
+static inline enum cvmx_helper_interface_mode cvmx_helper_interface_get_mode(int
+								       interface)
 {
 	return 0;
 }
-- 
2.39.3

