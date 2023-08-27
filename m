Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBA878A396
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 01:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbjH0X7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 19:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjH0X6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 19:58:42 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2042.outbound.protection.outlook.com [40.92.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E10107
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 16:58:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XRVu0p97pgT9au+WYJDNx5cfKBrXhj05hPenBgHt/AXZgfjL7/XvN4Fmz6WrPW/dnysw5+Bg+AYtTGPR9x73lXcm5lCjFDd2tEIJvQw2YNic+XtZ9UiF+WvUinhCF3TMjfUP8ekaOKJw4RhO6muSHH8NHYo5VG0Jx0Lj28v8q5dUANLfrWNqzq0pLyOwgokIpB8nKAXPEdjjJe379cLLM4qsTs3TSmB3e3eY/AgxfXcRC8pWousxMmackM6i7wvfvFhxrR7141ztU1pMkPcLDZo6l89oZTdwKbaudcrR8HYLLes/ZukEdtemAS/vlzneNZCnSdxKMPKORz+4+qKz2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BLWPbj8VIiB6pJNl4htaNulAgigZstpp79hyQyMtSGc=;
 b=OYM6LZtGTBFnnLOFoElegdGKZq9TwyJzIaHneaynBp857mC9cQr4xqxMFdRms8wmsPsv12iXQ1pnA/svHtGIM8By+xphKguJbitTVcCTZq0jZNQYdRIa/er4GHE8/qgUZTmu5KdXHro6WZfQY88/NXLFK+uu6HotznszizDLqk/hNIuuDqLI6xmjTvOZmlxv4KCN8CCkZUmfOIOh4x+c7D5EAxBGXWGF/FvpMTDkfH8RRuO3Tt4gQdYbfQBzGtt3/lIKwn2IcJKf0fSqQs3ZGHr39shQlroOxSSTTK+aS3tVnOAF8J3KPooHVqza9QQgFb1+rUHs4XwmDVgc/OQvaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BLWPbj8VIiB6pJNl4htaNulAgigZstpp79hyQyMtSGc=;
 b=UOCE1ll1+TfwjBIhXFXTKIgZhvAzWB12/4HePP4SsFLt/hsXMwZ5oD+yg0c0aYUMgkEvVPzkqjfjCGXm3DxaMbohqOXk9M41vTkMM9KTuK1uAs0s2B8ww8ygh3S5Fuq7G7VAoiIeJSx1EnpQnKiH52yYu+p1ap3VANUEA+4OvVedUSW2pxTa7NibfKjeT22WujyObYI0qV05hB5Bb8IHVtZkO01BVcYy8ash0+HJuqIpd4GRhAazU4rChaEdmEKUuRbh9WLgoQfKDS45A0xe69UY09hMm8bmnuZFcb+M33wMeyKSs7teAukS2Vpy49B8vRJ7mJrlHdNT4IFQPD/7ww==
Received: from PH7PR11MB7643.namprd11.prod.outlook.com (2603:10b6:510:27c::22)
 by BL3PR11MB6505.namprd11.prod.outlook.com (2603:10b6:208:38c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Sun, 27 Aug
 2023 23:58:38 +0000
Received: from PH7PR11MB7643.namprd11.prod.outlook.com
 ([fe80::bfb7:d3a3:2ed:6e20]) by PH7PR11MB7643.namprd11.prod.outlook.com
 ([fe80::bfb7:d3a3:2ed:6e20%7]) with mapi id 15.20.6699.034; Sun, 27 Aug 2023
 23:58:38 +0000
From:   Oliver Crumrine <ozlinux@hotmail.com>
To:     gregkh@linuxfoundation.org, colin.i.king@gmail.com,
        sumitraartsy@gmail.com, u.kleine-koenig@pengutronix.de,
        geert@linux-m68k.org
Cc:     Oliver Crumrine <ozlinux@hotmail.com>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH v3 1/6] staging: octeon: clean up the octeon ethernet driver
Date:   Sun, 27 Aug 2023 19:58:17 -0400
Message-ID: <PH7PR11MB7643335E674EE3396E78E004BCE1A@PH7PR11MB7643.namprd11.prod.outlook.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1693180346.git.ozlinux@hotmail.com>
References: <cover.1693180346.git.ozlinux@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [k5SqhQLFRCHGqX1W3Srpd3R2xxNNlI7scgTisdNffsHvnalz1b4VdXKnyatT3euN]
X-ClientProxiedBy: BL6PEPF00016410.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:17) To PH7PR11MB7643.namprd11.prod.outlook.com
 (2603:10b6:510:27c::22)
X-Microsoft-Original-Message-ID: <1a5289442790798dd7eb80884cdaa8334b99c78a.1693180346.git.ozlinux@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB7643:EE_|BL3PR11MB6505:EE_
X-MS-Office365-Filtering-Correlation-Id: 54882df4-8ba8-4126-7f17-08dba7598822
X-MS-Exchange-SLBlob-MailProps: AZnQBsB9XmrTVQo2E8YhiYZbimk9QHlfee0RmoCxeVIs0rXLXVISVd30RHa4ZpFaiGfBzCcHm5tdf3YJ8o73lplugg5k2x9QZgwZGzHFHtEXfHoVHTYOTxwZ4he52r4A39yuydDctNbDgSCBhuxNFYYA6GOcaBBEdmKGH+cspwvhIhIQ+nP4scFOiwaNujubQc41r/+JaTfhYO9mNYACBUd4NJ7YChisxv5ohq6rWDd060fc4b5YJlP+rwpFpRwI7tAvwHlcaCMRpYT7wVXnXiPCpsmYC6F49CVjNlc4UDke3ob5hlhFyOqhbhl8fc1kLi372ECyvrG9PC0DDtF7x4OiqI4OX6PsBo4MNBZa7/3y/TikGJSS5p643mr86bhwqvUjXSO4Qq7Faahj5/hNpiXfjf4uPWVC+1ABnmn2SLXqHGPDBIxDVGxzLOKYQ+Dz9KQWRi5ERXMYewLF8aprFMo7eTMKPrOJwJmToOAXC/ZiWWDJCLsj/hIA1LABKRo6j8FjpvCMwwxia5r4a3DZyoYg4P+QQ7+RQUU/kesPPsDnPN+RHTOu/G80+6HwoWvWulziRdjvmbZV4skcJGs1vP+FldYt9jmNj1j3WoIsB41LKKRRiEr5nOg4kbt5kMdorb/k85Bn9ZT0z+sNJA354ZhQ2m37/MH4SoqAhv+hPkY/c+MJUEyA6mo1z12L3KEU5XZy0XfmsqDSd5GyktkR18XS1/Qxb7QHjGYrQHvZ4FnejLvOKQKgm7t/47+efHiMFu7oddzOEC0=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rjj+sVzQguiun3ugMrvj1+2n78Iq7rCd8RKdKWEmMnueoAzh9PifzYJyhbCZECLUOR+emGdRjBGvztYXXvTOGUXV87dDzbnzeHk9fW4HozS8YtoqAHTc2zIHiyCuw3G46+YbXCpX+BssF0u9SXCIv8Cowc80cFlgGuhyTA4GyN20fTxjML4eRxscIjjw5YAJrjvcKObUWOKdihB1656U+lqbhml4rR3Qjk58QA7joJ//9hkrvD993ANC+Od0LNkUbNoF1CAYMc857zhhBuRNAgW/QEnreMERH0LpifNA2ECHxnjfvq+euDh61vB5U1JJHhrLXdzuwBC/xvT4dqzxkQbCAMcntmjILP+BsiDOkVDXsg2/3LEg3yFS9lUOhPeFzU4R0+h4qb0JTFyXHpfx/6AzH6pxN1mwVeFLc65x7HxXo9qsAXO22YSnyCJKMINN/IjkJR0hh/kULrkCacfMbwQh5Im/3cjCu95UXUVCihButucIHBw8P9nwfrDZtAMjGI4sznSOxM3tYqI0RlvmbEYwi29bnKlnzCHpg8XSATpZZeUaWuwpuj20lsnoliVzRSeEIyiuauHCvlerN3ax59bIjGsHtV012O6QsF+3p+9k6PES0W2tydpYO8xTwTFB
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mwV48NZJdg1P1c53fyO5oHerR/CLFAElP6KkjalkJhvp/2/7vUbIhxVi6xi6?=
 =?us-ascii?Q?Yt/AY+b+6Qff8HYFaxVM7biDCRDW9LPhhPneSsP9fSpPswGa4rivwGhswZAW?=
 =?us-ascii?Q?28mDsUH91gI4JYysb9bhOPsSvCdQdjBpPSzfJSUBEtmzWcUJxXLBqtHbGgEK?=
 =?us-ascii?Q?sibBGiOrag8qDxGaDPjeN5MwNiEcTC754GOfqvTxhUhKaBzrjA0Vn7rynhn/?=
 =?us-ascii?Q?ZNxg7sP3nvlR5Z4qmWoGXGv5HPT18MoWvkN+Vm1HOj2Ks7vxu8SbDBfxzcuJ?=
 =?us-ascii?Q?5DTlEjbUACvMYvVdqOUq05mMfeMcAabIO8FOsd8ebxqaSOo7TGigeVOGOYUa?=
 =?us-ascii?Q?m0o30jx+3C7V8sF/s/QjRy4pwOlVGHmsqqppW4sZ5IxbsXuSBifqB2tifU01?=
 =?us-ascii?Q?Bw/sAgZCDBOBRVIiHmtZQ5GqfrK+An+jhnkE6HtPDmQWKqg6sqBphok64GO/?=
 =?us-ascii?Q?hsF/Lu9CDfxf7ivjPupLHsCNicpXxqUHT1WqFk9ohcc7AtVUWHLuizhxInC5?=
 =?us-ascii?Q?n42Star7EtfhkCEaWaFSJGW7EqyBC1ZJ8VYNZDKELUxW4+VbuXX11R4Md1cn?=
 =?us-ascii?Q?/j9JYoHb/soVQj++vGqC/dhnmprJVnMEy7B+Ux1QZ5w0gE0liCUJtDyCLX23?=
 =?us-ascii?Q?I+w1s9JVAiBma8dRJ1sP90opj+uY9+hDCDO0G1E3Wu/R8z2Km8qpR8WOLL1+?=
 =?us-ascii?Q?UxaScxJcB+lZbKRwoy/17iMrE8f//v9mgsvUBQRTZpdbpLi/pPtg4qfGALjv?=
 =?us-ascii?Q?B3N+4XV1F5K7wVHFVoqdGC0Tmn9WGP92bNPDRaj0RdyZORQsbxeOH1TRQ2sK?=
 =?us-ascii?Q?zg1z4FoOT261FrlR4BOha/gVopb2J3cMyVrRS01Y1tBkRB06kRO2nOPHHHsS?=
 =?us-ascii?Q?UiEP1XCOskKP5rTeFiqWcvnANNb4oHnU3CdlXbODuKufdpbEUveO8yuZtmqo?=
 =?us-ascii?Q?vRnsbsY+RDWsva/wFbdaGmgH0AkNmPMViYw1LycEhXniIVWVZPD4Yj1YXKeh?=
 =?us-ascii?Q?7TniQFHuF75E8GtjsGLmZegu/2MR0O4zs+SODU6rBInEC10fFCFU8H+kJfgu?=
 =?us-ascii?Q?0p/LUxmM8HbvK7WhBU4a5kly6xOf1eYCGKQrTwRvPkfF+yyqvYq9kiNKNMiY?=
 =?us-ascii?Q?oKSvjSla3WUN7NeyY4RfjcqpWK9we+KHovf3WkiN/r8yZ3aP3t8rIQATe5HX?=
 =?us-ascii?Q?eQ6AsfWp2D5AMg/kONkXJDEe+YCGPg2we4SfGlrbXyv8DI9nrNl84GNloJbd?=
 =?us-ascii?Q?6qiZbcEcnQvnKw4c6a/0qmbjWace0XWYFkKBwIW72Q=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-e8f36.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 54882df4-8ba8-4126-7f17-08dba7598822
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7643.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2023 23:58:38.3413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6505
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
kernel coding standard.

Signed-off-by: Oliver Crumrine <ozlinux@hotmail.com>
---
v2: Actually send the patch set properly
v3: Fixed a problem where I forgot to rename all instances of a struct

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

