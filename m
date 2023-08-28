Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C49A978B21F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 15:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbjH1Nkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 09:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbjH1NkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 09:40:13 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2098.outbound.protection.outlook.com [40.92.41.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1D691
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 06:40:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A8L3RMGXWii+m0tZT+BlARHT1/2RMevwAWSUpTEM2l/+q3jFDpM6V0iRPiaT21g6QgohgWseiHvyz0d4ZcKaYpOBdTIYiEiLjoFBWz/+sl5HJ0IzZusJXzUjE5RJ7CuW5I/5lzMGLh7avaAoXMqBFuAix9bGaEE6XATK82xCn8BZ7B0CYvBKNFZocWD/qIxxc4qqjeEI+Tc8gpznPrtOI8rMCxjkYJEd2HB5PvEstVyk2L/K4k7BzVXhZ/z5dpKFHY59ApWu/dMX9tKHefv9UiCao7RCo94r6roUOMfuRMYLmH6R+qeeCoh9L6OikyYNpWoUqgUTPjsao12NJzoxhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1n9gWOquDqqTAuCoI7qf9w9asAKUv/K8iOaX+Owi+Mg=;
 b=iCY5Zo2c3i9uxyed2NcK+jY1G6hciYveeVhfTjJrMmQuqc0J045eMhw0kByqGExIqXDQRngnBNSzPplMhenyQ5BOsfko+XstNmZdQfdSL0Gcp/SPfQsPlnvO4XaVTRZIc5jyqEDqZTIFehk8pQgKnMdEw/0ou8QWh67D/h1iqQoVQhfGnuH52CaCCDpXyGRVDvbqAnCvJVrwTKjy+ESf3bEYsOpzWpXFWpGy0RtugqsU0ItM5GhbC4JfK5YeKhn9UoNk0pfbc+EwK5ryGD3UNKBVXTMjKU7991PC4fvnz5wrJIgeediOsBZL0ewnQN/x04Wotp+piE94UpJAse4+PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1n9gWOquDqqTAuCoI7qf9w9asAKUv/K8iOaX+Owi+Mg=;
 b=uOe7KZfIXrxa9kBWxrCou4DGainYUt2Vba55e9VYGzQsbfabfO7j5J29flOxLrNX33EQ2zNgFAk2qdoyKptpThX2004i7obzuEwlkLYInXLLch4+eE6gAQ2fLjkfMuxX6DB5eZzp60Xm3WQ/mbKsno2FBIKC+eTZ3Ed6UtH3O3UKkYIR07EeKFnXA3QsgQNzi8YqS26x/xOmpupOiG4BYvSEJBMcQAK56oyglDmTHHhEkpJ8XEoO0NqfGzdcOMW2lvR6h/+vmn3zicXgV+jE4y9uacjfJVXcTFFvZbrLj/Vs9/0QEjFykJEHq4XBfrACQ2CujUPHbrKQuAdF2evfLQ==
Received: from PH7PR11MB7643.namprd11.prod.outlook.com (2603:10b6:510:27c::22)
 by PH7PR11MB5768.namprd11.prod.outlook.com (2603:10b6:510:131::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 13:40:05 +0000
Received: from PH7PR11MB7643.namprd11.prod.outlook.com
 ([fe80::bfb7:d3a3:2ed:6e20]) by PH7PR11MB7643.namprd11.prod.outlook.com
 ([fe80::bfb7:d3a3:2ed:6e20%7]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 13:40:05 +0000
From:   Oliver Crumrine <ozlinux@hotmail.com>
To:     gregkh@linuxfoundation.org, colin.i.king@gmail.com,
        sumitraartsy@gmail.com, u.kleine-koenig@pengutronix.de,
        geert@linux-m68k.org
Cc:     Oliver Crumrine <ozlinux@hotmail.com>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH v4 1/6] staging: octeon: clean up the octeon ethernet driver
Date:   Mon, 28 Aug 2023 09:39:14 -0400
Message-ID: <PH7PR11MB7643C65E067BAB032F930488BCE0A@PH7PR11MB7643.namprd11.prod.outlook.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1693229582.git.ozlinux@hotmail.com>
References: <cover.1693229582.git.ozlinux@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [FmL0g6Q91ofp/xCe+VZZAi8ePUgY4Ipcvq5twNBishwC067vGI04n8f2rwVl2JNV]
X-ClientProxiedBy: MN2PR16CA0050.namprd16.prod.outlook.com
 (2603:10b6:208:234::19) To PH7PR11MB7643.namprd11.prod.outlook.com
 (2603:10b6:510:27c::22)
X-Microsoft-Original-Message-ID: <1a5289442790798dd7eb80884cdaa8334b99c78a.1693229582.git.ozlinux@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB7643:EE_|PH7PR11MB5768:EE_
X-MS-Office365-Filtering-Correlation-Id: 5355d537-9f04-4816-6be5-08dba7cc4931
X-MS-Exchange-SLBlob-MailProps: AZnQBsB9Xmr1VCrDDYJl/lCLgD1Tr5zrrErctzovFMDamg3rlCqOA+rl0JQn125K9iLBu6TAQri9Jvo39k9pMMLfUbNGdphISrJpuh9IsAqi0qUwjNFzzJ6zWKPLRJWz/PyQxRv72b23w1CVA77Cii80ALF988Wl9hItL2Lsq+h8WXFTFIGspyD0JGWpcap0qHbwloRduPcusk0bbMpb1Ih0FZkwfyzpcHay/kTj8idNl9rD76pARqmM6fiXDkOx2VB2mA19U70csrPPzusb0jLE/rzfkikA5A0NKUr6RuNjLabQ/nsA2voWIoW5+qezI5sM0mtlpIr6ZfhaiqQaa/Pm6uOVzxj0d1lXhaKzEboOg2fwDRFq5wovK3Jy1+GYXWCtVjmY/bgxVrNu1Os6l9rNk/3n7IK18yi/jEYYfCSaKoHFIG7+RIdL9NC/SLfU6eNrFni1uVjN1nuCMv/vWDgb/eEGgly7I4K1rH5WEh9DJxOZlYh07SVN7X4N2pde5WrEu9VNqSZ5GH7KuzjyjwJvzEysYB6iFjxkWiPPLQ0hjuFZiGEM5juDbZeTT/oXWUF85xsqlI1tMs6boXPTkoIYSBgUjTul5XACG00jJXqoqBhitRbvxGHTVsO+FWxfgySGMrxdAVFGgYz6JAHdPhS8p9Sjci++5WD5KKFFjiSm0XIEpn/dis8radwb6azyCfCRlCUw/7EpX9U87pq9gKFsv1s/TD1gevZr5qnRwfrm70Ibn+0HN1pZ9ClBt/Az6tMgkkMBP/U=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zmqR0d/JLvT03uOfHSPu1sbsf6ipD6/+T4ffampq6CoQ59drXG9goo3KGg90ISkhmVgYjTUEEv92UcBxbhCVBSVfOhhu2RJgMND6nWMnP/ltmwdc0QmMAPu7auy8vLwgj+d4DABuNaaK5Pvzf4Vz5/M6trqQTIycmSHf72kOLEjvYL7lotxTQyqCHnpmrfPIf+dosWpTGpe/ApbA+vzr8wh+fpz3xxdEq0DFw9EEiMdSR67jIhuQ7QJFYDPxq8LRzw9ll5bu7E28krxczar8SSF8o8gPmX8wEWo10rjYy3icCioDWM+rHRSorB57w5NV4yKGohWUVk26bCI3ZbFYKaoFyIF/UVlFi1JeEpfnrTrcumo0t+OQ47z8zNP/aXdtAXSMrUbWQT6xQIllA+NVskzy8VR16zHGIBML90PoT5rf9Fqzfzw7fgcS2LJL7azGyAZHhK9wFQlewADVcxovyp/d3vkFWE20tbySju72r+3ACCqLYNtFxLXLM2crEZ4SZ9C+1zC/JXR12CQUXNOHH7BWaIAwnN9vW1hipmn5dyu3SkgrmkiW616fymyK+b9fZ0pOkrAL4jdtqg7zPnozvRVhf1LfakHbgpk4J+FyZE1UflSN/XCYdLBq3guY7rur
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z0iZtU0xL6RHtm73vFeSMtTAQ/1EbXCWBUS8O2ArJVgp6SRZKhr4S9Lp5b+n?=
 =?us-ascii?Q?qSL3FADhuXt3oDrbKa6q45pqeQ/qxCW88WE53wuN2v8ZLB9hH9ukwSLAiSo7?=
 =?us-ascii?Q?oyw3kXYymdUy3FtkwWnwgAF2oRol0WO7r/bQ+5ACp5gbgQRAFdpZX1ip3e2o?=
 =?us-ascii?Q?wmPBNeeicwOsi3PPU1aokn4P2F9cHhaukGTNliB/reUtoq3sVLkzV2IOzJUS?=
 =?us-ascii?Q?W9KZGNfScR8XqccZSOK16UQdBUWYhLA52kZ8UrCwg1fCDVm5S0Wi5vAwzCRg?=
 =?us-ascii?Q?Q1/ZshPf4+mFUc2b/LcjRqbCQYTpJPW89ToVjj7nw8G4itrcHQcSETaQHoa9?=
 =?us-ascii?Q?5YyTb6inMgyyW+egPxTmQvRrHKFa7Pfr4+W0HQAg33KOCM+83l+Z6i3ssVjS?=
 =?us-ascii?Q?vbjoK34D8j6MYS9+LzN1xk/ApS/iVfLXZg60+BrYGHMM3aSA9hZtT6+nQqeR?=
 =?us-ascii?Q?WMaIJO0HXWTHEultZ7AfxNXh9EA5db4OPa8MU4O6Ce2fbyyi4oR7JWprtZOK?=
 =?us-ascii?Q?UpuW552g1ns9oHaXwA6iRXMxb7Rk6wsLe8CIYDj/IhK99GD8fFTyBrCaLXSB?=
 =?us-ascii?Q?69ixe9JBskc4D8bmnxgUJsIDxoSRVO829P+8/jaqknV/w9pao0l8e1HQrxg+?=
 =?us-ascii?Q?S130vwi/GD8s1VMROcrarYIGkLC6/pyK15G+dRT0DZiC8mouKXyVgMC7YCDT?=
 =?us-ascii?Q?YzBDJSh+FVvm8Ybeq9cqtWdPctcS2z2w2HRiETThDC/fL7HRFzNUzUnyzSx1?=
 =?us-ascii?Q?kEwQDcTwnXaPxKKNSIorrX9LrPupCuetsAC3tQ7uHgGjyElwL5uCDWgfqXMn?=
 =?us-ascii?Q?BcOT359Gh1fb+MvljdnehU62tXgkxt7BRaSjL4GLTyZTKW2yqNxetAHG4DsU?=
 =?us-ascii?Q?cbi36DtNAPdAjCUT06/DR2EIvxi2soM+hSsm1mUjBmWEdW6P+Ei2PAogIxwu?=
 =?us-ascii?Q?VtKXMmG4TeO3jmGLtxJjvsv7l3NS5YjI0GnlMLCDKJN7YzpQ5673yqopvai1?=
 =?us-ascii?Q?zCAWDpJwOwuf1ey71KOLhNqH2HrqmgDXrtChqignN9PSIqCMvYUirV78R5An?=
 =?us-ascii?Q?e5ZiFHKBHMPNf/vtbug7RJ+27R4Co57RUTNe+RjaX3gsYSFuSE5Sn7jBNtkv?=
 =?us-ascii?Q?wYVQOYGyi7nE/lprh+1teGeBeWBWPLeSZMkpocbbB4r23NhmDpiHdHyKiEJJ?=
 =?us-ascii?Q?jTgY00LLlEwtO966BMfHc6IvOUcIPDGaDbKY8dRNBnsSM2ztJGLJcEIj5oD8?=
 =?us-ascii?Q?ov1oizUVTMTr/7KAdjnUO4fMD8hyy9UwiPPjDbBhow=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-e8f36.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 5355d537-9f04-4816-6be5-08dba7cc4931
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7643.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 13:40:04.9503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5768
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
v3: Fixed a bug where I forgot to change all instances of a struct
v4: Actually fix that bug (this is my first patch, give me a break)

 drivers/staging/octeon/octeon-stubs.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/octeon/octeon-stubs.h b/drivers/staging/octeon/octeon-stubs.h
index 3e7b92cd2e35..9f269626b862 100644
--- a/drivers/staging/octeon/octeon-stubs.h
+++ b/drivers/staging/octeon/octeon-stubs.h
@@ -213,12 +213,12 @@ enum cvmx_fau_op_size {
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
 
 typedef enum {
 	CVMX_HELPER_INTERFACE_MODE_DISABLED,
@@ -1362,7 +1362,7 @@ static inline struct cvmx_wqe *cvmx_pow_work_request_sync(cvmx_pow_wait_t wait)
 }
 
 static inline int cvmx_spi_restart_interface(int interface,
-					cvmx_spi_mode_t mode, int timeout)
+					enum cvmx_spi_mode mode, int timeout)
 {
 	return 0;
 }
-- 
2.39.3

