Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA9817D82BD
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 14:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344951AbjJZMfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 08:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbjJZMfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 08:35:37 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2085.outbound.protection.outlook.com [40.107.117.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11120193;
        Thu, 26 Oct 2023 05:35:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h5N2nY2rcxChfJVsh54FKEpc9om+bYYQojZF/wI+agerJdXjtcDgaevMvU37UJicJJFjBZ2Gzf8X347BB0p149YhcNATh6keSs1GY7jGqT1zxoHlCKREiOr7p5VIXMnr4yAIg076KbRorrdeMA3gKSbuIhWVdwPFqCy6+ASXa+IDdSVJvL4gg4gozvk81xSUM4izNJoQTuoTjn/nQkCtnj7KCwzFZof4EmtnJxnOpLYQcUJmiqOavo7YZXhVHfMktO3kMOnxZsCFz1AilA+FmlyxyfgDbCAo2TI1Lg47IjlhX9Ctcs6A7V5JAQDJIc8T2bob9DwfaBawy6gR8wC69g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9/8EtJnHjwQXv2AJQwlbgbRWAu5AJu3G2d/WrNKRs1w=;
 b=EYrQLZ7310O1ZIc3qUww9h573eIR/ek3R96rrvgxoTFtpt9W/EQ4OUIpIX3WC28aK48x1HCTwA9s/y4T/HWUfLZoM3MTfgk8VUr0a0ajm48ZJsYNw+Rd2vvjDPg/EEUt0BgApMoAoD9Ow5rpIPjz6OTxzB97RvWmjnXrxWG4SklP9/eHpkx9/1PjO2vgTFLqsW1CQxVZXuoMYUKxSme3y9BZNuqy5a5PYcEorP+zeRP3Ct+YQpLeCwAmSi4+CAiXfboY9MWFZsVQzEouOX1zrwyM12qU0gWdV9CP5qcxdl7UwuoadVQ0IgumgHaBOklGQkaVlatmklHghslzk6ckGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fibocom.com; dmarc=pass action=none header.from=fibocom.com;
 dkim=pass header.d=fibocom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fibocomcorp.onmicrosoft.com; s=selector1-fibocomcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/8EtJnHjwQXv2AJQwlbgbRWAu5AJu3G2d/WrNKRs1w=;
 b=xOL/m+xK8RWzNhBydtG/9sRDrFmP4oilpZJzfykOPZsskKlyKVRYy/64bTpQW/t9Scm51XM3BHMuIJ5e/CNE/H4x7OV6+rinDHoL9K8gZfsMRXSJoc+PoexlGztGPlnl1VVMT3t/GXD64aMo1jXeGG40jtwzS9uhoOsPEeCOsGQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fibocom.com;
Received: from TYZPR02MB5088.apcprd02.prod.outlook.com (2603:1096:400:71::13)
 by SEYPR02MB7439.apcprd02.prod.outlook.com (2603:1096:101:1df::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Thu, 26 Oct
 2023 12:35:19 +0000
Received: from TYZPR02MB5088.apcprd02.prod.outlook.com
 ([fe80::e6c0:ad44:ccaa:789]) by TYZPR02MB5088.apcprd02.prod.outlook.com
 ([fe80::e6c0:ad44:ccaa:789%6]) with mapi id 15.20.6907.032; Thu, 26 Oct 2023
 12:35:19 +0000
From:   Puliang Lu <puliang.lu@fibocom.com>
To:     johan@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Puliang Lu <puliang.lu@fibocom.com>
Subject: [PATCH] USB: serial: option: modify Fibocom to DELL custom modem FM101R-GL
Date:   Thu, 26 Oct 2023 20:35:06 +0800
Message-Id: <20231026123506.26453-1-puliang.lu@fibocom.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2PR01CA0016.apcprd01.prod.exchangelabs.com
 (2603:1096:100:41::28) To TYZPR02MB5088.apcprd02.prod.outlook.com
 (2603:1096:400:71::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR02MB5088:EE_|SEYPR02MB7439:EE_
X-MS-Office365-Filtering-Correlation-Id: 6020dbb7-329e-42e5-b880-08dbd62003a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XOruGRAmaD/u+XVsrJeANGnNtBdc/QXXz04dOjudHH0o2dp8JkS6IiICHEn4rdtHv00i3NA5pKWy/AhGmnHCkDjzP0h3OBTh0W4rgFg/3Rw49qMb7xa1sd3+0NWChruJ90IxBkpATqRvNLSYDYGCmaGrBKSFUllwAZI5TTnVwiWBlLHwI9Gtnkezv5AC0tZ2FbvW22zG6tbHGOYyZF67G9YKrjlQ80AHfzMthKXZZiZ+Yu/H+LcnnzA2ZLV6htdfG6BBaEzyigi0z978hUqJ6LfB7Shdce+/dbkg1MycqHcP65pPEQEe4p4i4NWAfSiMizCEa9xe9qy1oxd/X1Y3ZJDGnvALrV65IwQh/JihUU48c3lH5JK6tyEXGEgr13BOILuRkNK6Hd8ETbuUBXeiQYRyqXjT61HkxoTNAX7i8yOxvntxG4sqPqRfO/ku9Ssj7szkJS4MigjXaXephpS0BWLmp12HH/00rYhbLojlp9v6tvqqRVz7p8k2KnrqOdWtDtxvYXqn2gY0J7tcsSMrJmQb6t5lts1KwUj46yuxvvf0oWm1il00yTFMAiKZsx0k
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR02MB5088.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(136003)(396003)(39850400004)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(5660300002)(1076003)(316002)(83380400001)(44832011)(41300700001)(4326008)(8676002)(8936002)(38100700002)(6916009)(52116002)(478600001)(6506007)(6486002)(6512007)(6666004)(66946007)(86362001)(66556008)(66476007)(107886003)(4744005)(2616005)(36756003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NnLnevdIfxvWUjLZFFn7hzaWn5ASxL+VSJsgDx+flk4gKTJqosur4V3m910f?=
 =?us-ascii?Q?tNK/BBD8H5nMW8r8iLfvMU5xanMelAKtmxnTZElxdb4D+rja+mYWczqOGzSs?=
 =?us-ascii?Q?K3VKBsbvS7fOSsNdvUr8mFMw42dAQVMqWEB4xfnoXI66PJB0OupOHNI2Gns7?=
 =?us-ascii?Q?oUu/jAtAiJtG9gpZ4su5VGfQogK93VZy9LknnS41VNZcZ0LO/TjxKBHdO9Jm?=
 =?us-ascii?Q?8oVmXaj+IXIUQGn1tKHoLn0XevInm4Ztg4Nlci2mbLIvI86oNwNp0/J+k+X/?=
 =?us-ascii?Q?5yxBSXldJoM2SmBWUZeD2CYB7y0TTd/TAs1FE9rNyVm62Kae6uWDeJS22SVx?=
 =?us-ascii?Q?hZTsncJ0+UpUDCC+G/QF9yfiy8H/HY+cs0dE2DprwGATboxRpYD7/5weeeYz?=
 =?us-ascii?Q?sidrZz8ammO7bBZqvqS4K9iWPFWfCosPT1FO/TXWY5PTXuyj+j8ziC8iHIXs?=
 =?us-ascii?Q?8Ncca0GoxL2HEQSusjT6VqWShutjd2R7Cv96dBkR2zrWDyH8xOm47wj91dft?=
 =?us-ascii?Q?dFDsF99M7aVBN7DehbL+/A6MMCU4KicCIIC+a/Dflx0OycQ5QEBpUl1uRnHH?=
 =?us-ascii?Q?OK0Os5W0jV4cuTdw5baeRYMuRv+u8cMJtmGgB62MLC3vHkLoeFGupamGZda9?=
 =?us-ascii?Q?dpFc58uEc4Mp8kIMS6w5LpD5yJhn9rVmhEuxXN8lC2F6D7LD+nlXBWCrtitp?=
 =?us-ascii?Q?Pfi2J3dU9EYXucfiz01XUaAiu7k/6ycAOpafTHiTZrXFTr7+1jX0gOSNlkPo?=
 =?us-ascii?Q?Y5p1b080MOX6u5rOvM3V0GkHgp4Vi02ciYLrUud7mQVw5xsukM+RBCqjyr6k?=
 =?us-ascii?Q?nUyrDezORV2A/6kYMRK7wGbqk1v00/X0kXTZAtJp5pic4TK2O75atecIccCG?=
 =?us-ascii?Q?2H3nIXFBfa+wvrrb0YmuXkpaJ/uz6HJf1FOzCtcX7GqeZF3L6cD5WCTdOnpa?=
 =?us-ascii?Q?aDwEe1DLHDfDWBViLp7eroDvxV9gRsiD6swrwYcxXkP+RL8pohpBcY03bCsV?=
 =?us-ascii?Q?xCGrE4K8CXNNNrBbI6vdsWEMSwTYu6Ftq/i9/Vj/4zkkyVVIpOek+K9k6RPX?=
 =?us-ascii?Q?YaAvkUhBOF8uD8yktTI8itG1si9D1hyuCemwrocz+1q29E+zoNEuDISI2hk3?=
 =?us-ascii?Q?2s2rHQJOLbPmBImjHc+AbZxMrgxFvGuN1kd3KtTWBO2c5P1B/qgHBzOe3Scc?=
 =?us-ascii?Q?iqhKbdnxc0Jq9lPE/kbpxzWpU/sFwHuik7D58SIvf9XzyuXXLDn9eCAkV/HN?=
 =?us-ascii?Q?3+f1fcaVdYZjx0EvIfrUgTA5Y0+rumKz5UJFvoEfjOMvX3pr8nfej3bgucP0?=
 =?us-ascii?Q?L9lI0KxX5c8PJwas0YXf1HIBgH9Md2pv0Yl0BQ3rbJq4tZAU4xs79Zv3H0Xb?=
 =?us-ascii?Q?CC99gy14L7byLQfDnA3MRJcHikUU2WLUQkmLawhf8xcLO0yZAuejL4Odp7KY?=
 =?us-ascii?Q?qf/sbtiS0V8KigvVlnw9cRUu6p9klqimaw+tV9O1f9O6+YmtRMsdGq0gOh9s?=
 =?us-ascii?Q?6tEEOxs7nLSHAmG7ad1d+P0O3QSKqLmZQD9D8UQDAC8a1Se0098u81E7+r+m?=
 =?us-ascii?Q?01whJFKhoGwqKcpmOnZ6BZET4bWtfCOiID6QNgl/DGFkulSlLzdcTzu77VNu?=
 =?us-ascii?Q?ZNbL6LA0YAlZBnq4I7zwfrVoZG34QEBgx9ww79g9fxXF?=
X-OriginatorOrg: fibocom.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6020dbb7-329e-42e5-b880-08dbd62003a7
X-MS-Exchange-CrossTenant-AuthSource: TYZPR02MB5088.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 12:35:19.2562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 889bfe61-8c21-436b-bc07-3908050c8236
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zNEphSDKlLKOw+w/mWThovnTzIUxnOdvxsnyKiBK49AY9Jjk7XlKP4sKEyX66VckrzMiQBTGyosy01jhzFwzgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR02MB7439
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify the definition of Fibocom USB serial option driver
FM101R-GL different variants

- VID:PID 413C:8213, FM101R-GL ESIM are laptop M.2 cards (with
  MBIM interfaces for Linux)

- VID:PID 413C:8215, FM101R-GL are laptop M.2 cards (with
  MBIM interface for Linux)

0x8213: mbim, tty
0x8215: mbim, tty

Signed-off-by: Puliang Lu <puliang.lu@fibocom.com>
---
 drivers/usb/serial/option.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 45dcfaadaf98..3aa219275509 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -203,8 +203,8 @@ static void option_instat_callback(struct urb *urb);
 #define DELL_PRODUCT_5829E_ESIM			0x81e4
 #define DELL_PRODUCT_5829E			0x81e6
 
-#define DELL_PRODUCT_FM101R			0x8213
-#define DELL_PRODUCT_FM101R_ESIM		0x8215
+#define DELL_PRODUCT_FM101R_ESIM		0x8213
+#define DELL_PRODUCT_FM101R				0x8215
 
 #define KYOCERA_VENDOR_ID			0x0c88
 #define KYOCERA_PRODUCT_KPC650			0x17da
-- 
2.34.1

