Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F075E78A1BC
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 23:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjH0VMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 17:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjH0VML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 17:12:11 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2065.outbound.protection.outlook.com [40.92.23.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC47A8
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 14:12:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NYqTJFi1vZfBD7vnNUU3+8uBnmw4FKiNXimC6I8z43t7rkN6gHuTo7UK+2dpfkHkiYBc4F3EVsb1uZcdNrMKn0xoC92tJRg4MbWvmZicdINUuCIX9qkAp1CEkroBfCN2lX39eSPjPA+s0JBosARdZF/qv+y+vqZDEgZnguAmMkb47CLxifEVd0VC8HLwkOgI+CxhXlq7oBVODbZPoSIAkEdOQSxvuNwGD1EZuPIxiIDe6EmUsOWkXjSwZO4PSNVWqK2/In53eCI2bn7zNo/cQkEZRyDE+C/nw4iNNXSsZwgFv8R8171t61MwSB9LhAxvnmgfkAmD0outAGIvPar+7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FdXDI/GYdqfJGigMORnSNOFqzxayvkrYT2LW+tl1Od4=;
 b=blAoOoRAgCYbfy67XFhAXVpqIRfbFyUiixqkhJSfeAWJKs8ZXXkI/u702cs62C8nT/CQw1AYeg8TrGOv25IgwDwoXvl36VaORpbbWR6mI0yEhmISE5K/joPRQszfRuPYhHhXkiA1ensro0M5CVQBkuJ2eqKi9X59D8ntXPsjHTXqZaHR2YYyRgjQAvTRXsXE3jkeEzXNsJRr+k+X0q6JyjyWvTbfIBkRsrxvqvyBgDXWA2lFO0+Cw0ULAy6aXQ9D2YZyNUqGEnYLTKk7BNnGc4GOYft6ir2+vI67D6Es652Bq2tVMvY7RubNWULwCShR/fjqk7wxpQKifk7vo3X5AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FdXDI/GYdqfJGigMORnSNOFqzxayvkrYT2LW+tl1Od4=;
 b=sc3hpRJOmcWu08NU4R5sB0HB5OPKigan1N3jT5ku7qNwkUDGRaZVAw3VApqXDMv0pj624ASji+kM8+jo/1zKx9kQhsAFnqXVVGZVN8VRoEXDg0iR4ssIe7+3GNGpgeQFqUjVWFdF/2PKda6W2xy05idowEUIKmGAhtEi/z6bY1olflow77WsWQzZSEBSkdkkPY6XK45LTT2zvvkGs9yFC7eY/+Mw8r4v5M9a9D1s4dxS4UKP8Ik+AOfLeOgXyZgsU+omSAfRVAZqb0TB8RRUoe6AOGDsJlwXk+0h34bj7OvZ84ruQQXltnrVkPA2Q3kBTuvNKsGhCnYcXlTmq7sIkA==
Received: from PH7PR11MB7643.namprd11.prod.outlook.com (2603:10b6:510:27c::22)
 by CY5PR11MB6115.namprd11.prod.outlook.com (2603:10b6:930:2c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Sun, 27 Aug
 2023 21:12:07 +0000
Received: from PH7PR11MB7643.namprd11.prod.outlook.com
 ([fe80::bfb7:d3a3:2ed:6e20]) by PH7PR11MB7643.namprd11.prod.outlook.com
 ([fe80::bfb7:d3a3:2ed:6e20%7]) with mapi id 15.20.6699.034; Sun, 27 Aug 2023
 21:12:07 +0000
Date:   Sun, 27 Aug 2023 17:12:04 -0400
From:   Oliver Crumrine <ozlinux@hotmail.com>
To:     gregkh@linuxfoundation.org, colin.i.king@gmail.com,
        sumitraartsy@gmail.com, u.kleine-koenig@pengutronix.de,
        geert@linux-m68k.org
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH 1/6] staging: octeon: clean up the octeon ethernet driver
Message-ID: <PH7PR11MB76436F3A05897D8F8DC9F967BCE1A@PH7PR11MB7643.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TMN:  [29ZPbi+SR8aqL1hHHKUHFsD+8HXxIoUk54Ohnblq5PijCUI9sOG9CQKbj3W8tthc]
X-ClientProxiedBy: BL1PR13CA0253.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::18) To PH7PR11MB7643.namprd11.prod.outlook.com
 (2603:10b6:510:27c::22)
X-Microsoft-Original-Message-ID: <myp3wbxeqytaoupflycbgsnxjgszz3l3cq6zbyi3fbjf6lwpd7@ygh2gtxm5dmv>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB7643:EE_|CY5PR11MB6115:EE_
X-MS-Office365-Filtering-Correlation-Id: eb9092e9-3a93-4b98-00ce-08dba74244f4
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Er4zWfsPDX4/H4a7m15DJVHUIsI81wSHvnF47mtly41e5njTImKi6NRXDvTvsUr6eP6kQs2DEys297yShWnPe/Ky+gWYiVq+/2Q+WB0KrcF4a1lZQUMlK2P8qZqw3p+hkCSVzAKSKdKrKYqbyMDqdH3ZW4CoPeVZbRo6M95VfW4eR8VvG80wlOsQ82V5hG8dB3Bp07Ei7qqxLjdQcAb6ZjMUrVO9DqzYN9MRcHNBmkayyPIzXssyROhXl9pP4jJMtlLp/UwM9DY0hPnICOPykPquAUtgZPt5GwjF+IjdG43QWUlbrBISk0VQz41HWYyzIcaZc3yVaWzr3cFfK7A0Ron70JCrLu+tL2QDluf4FsFc++QeuJukeC4MppkpMQfcKPnT4kqxedxgDyM/A+Gk+7ESPlIgfZpVLLmyorN32K+LTX+zRJomiETXnxUxQswu8uYBOfRV9dvy89q8I2PccRDvNwHxCiOxmb0vWFJ1L8Ma1T4zM175VkXMmBHsJkSZrrKHC38XzTrwySgwZ8Oof1WldnIJ1p6ScEQXhv9RJR4rUgDF+egI0HcyJa5g4dBl
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nrwOL6tB9N8RoBpxTMB6IGETqFKnoLbCr8z5jq8teNFp7wmebkz36MvuzCBB?=
 =?us-ascii?Q?9iBECyxThCyb+/85hyvTgNA6DRlvb5StURqdr9cKg3P0a7VpkvKnCVfuYW1P?=
 =?us-ascii?Q?pn33h9N0I2dYIiZvDHy+rlvi5yN956BHQYxdkA2tyIVN6gWVgSXxnwD9ONrk?=
 =?us-ascii?Q?xQnKnYjQF/Btzk9DJ252qSOPXmxDZCt0kU8mYwymQfVFS7aDB0u7tnlE917m?=
 =?us-ascii?Q?brEUdW4RzjhLuTrZQcFDDJOPDi5cdKsei9kYJBBmEPI4RXeWsI8H4Az/hpLr?=
 =?us-ascii?Q?kK78gQYuQTAWgXkfw5QFOBs70NRgQCYc0pb/hl9u5sQpo0I2U3ZLazk3TK5k?=
 =?us-ascii?Q?5OAsKEmdfLo5hiBM+bDXcNEgb5ow92emGJcuFj+wNofiT7wp7SNj8EVn1VeP?=
 =?us-ascii?Q?wfJ6RAq5sJqyx+6DDqXyM2hL08Bc8t2v0g+6nznYpNOTqGqhGxEJvOnBcjaL?=
 =?us-ascii?Q?Wiqv8NvEbK//68ov6H5a3TOKQdAfGRbrs6VfqWrR/S5lpuJd5iH+QI2VnImH?=
 =?us-ascii?Q?Wed9fYWDsU0YoZGM1jTXx6/jF9nAdZW/YgyIxJMkihJzkfuI5XPUe95yGXt+?=
 =?us-ascii?Q?yuvlP3RxAH48iXqLEujTKvD1NKWQsRXye+YPsCYGMQYsKPkWNTJcZ7mqa5QE?=
 =?us-ascii?Q?/6BITH8DefReYFgKBcAqO5DJ76MTd+wXp33AYkorAbgAV6QuUIoCMwHanM8c?=
 =?us-ascii?Q?lbfEiMGDmQVU07BloL1F3IPTFJKa0p8YawlvHHn6eogQ6PUzeDooveH7h4Gw?=
 =?us-ascii?Q?BJIiSn1tNT4nS436r9U/wTRkT5TdvDt0y7/DvgVR2zW/mTzG1aW780dS5Q9Y?=
 =?us-ascii?Q?trtOToHAvmaK94JgYCAlMDwvrJV6baKNu97FI3de+4huoiLXGTaxOFXM20vi?=
 =?us-ascii?Q?78CZT4IW8W9Fzf3FbZWRANJ2TcRaKpaLp0Ns7WncrATH8iGMwKz+EQdEHffl?=
 =?us-ascii?Q?YyeA50YBVJ0byjJa6QXTo4JjLxNMBcPbZlGfzg/47WVRv+Je73+TBkYfgzO4?=
 =?us-ascii?Q?GpbtenghZk5XbPZ6G3/3/9mbryX2kbCfnTGmG9x+5XP7kAEXx2L+PEtrlQUu?=
 =?us-ascii?Q?po0ZuDA8xNGqLesU4saYJrhmo7pejbIFgatLD3naEDPD9UzeKV4OARmWxJQ+?=
 =?us-ascii?Q?DPitUhFdWj568OuZoX5lNOvmNo8a/zRd6dbLAbXCS/a9iD7QfaKk23YGAvQW?=
 =?us-ascii?Q?HW746XX7a149sljDUFS+gnqJ8QhPC6K4EKIfeAyPOQOGm62lvfXwO/dFYC8Z?=
 =?us-ascii?Q?7Twfh6nMlDQx3OVAlS7WfCPby9a3ih/ZAdsKqWKdDQ=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-e8f36.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: eb9092e9-3a93-4b98-00ce-08dba74244f4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7643.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2023 21:12:07.4208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6115
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

