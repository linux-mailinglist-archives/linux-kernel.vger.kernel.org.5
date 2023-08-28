Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A290278B220
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 15:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbjH1Nkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 09:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbjH1NkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 09:40:14 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2098.outbound.protection.outlook.com [40.92.41.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14B09C
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 06:40:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e8QqBrcezr4BpgdecuQOaFU81Id8DPlXw4lC9lHcvpSj7UdhlfEzqybEhaO4hxzzESn1pDrg9I6eosNbylSCjY7pguobygcMXh0v5SEm9P4KNcZt08TaAxfYSmeI9vhIFMce3PLmge0oxiEjnhgGVsmWvwwcFc79IVs8Ej1zg/bpPyYGcZBEG3i1W/V4P0UU/8PwlfAQsnjomzd1jsHXVxo+D1Qizg2rQZe02SbrOceXkPQ1o0/+Q9zJTdR7riUERTEMvaD3Q6YuUyfjiDmEGFGAB4xx/2J4h1Gfts7b23io4KePnTTGqvaXWdSaeWYWB/9xLxTtiw7XS8Lcdh+Rkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n7gua6XTHSEzgeyuvb2rOvIyGRFyl7sGE6kXcnUjnqs=;
 b=UQHkbn48DUDbxbjjkP/sKrFyrTbYZKvffqtuiV9QofWDYoSrRiQqjpQhNBlzwEPHbTYbTuqgfHZ8QxyhbvW3+WC33mjyoedu75Re5YD4f6YRG3q+QNcGPeTlIZvWBMhGXZlB6Po/HHLKUu/VtC8GHXFeDeE85tQz7sN1BfW7u5xmRXaRO+a2OrErtC7Z8CI7NIXTyC28UV6a4fRKBrxUTkcEj/aG9iJXnI/T31rYYF64bnj3UyDGaRqh23kBYHrYlLIcTTtLyadaOUxIaYZpYfv29N88syQDZAVP70eI72vmpXYoES3YyWqm6rG18hearjjQ4T1EIyoFD/gM0SMqZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n7gua6XTHSEzgeyuvb2rOvIyGRFyl7sGE6kXcnUjnqs=;
 b=PIktvzb3/dgQJqjPgmWa6kt+PKBzrv9S6U9KDNo9Kg/F9Cm9UVckLy7VcLLOBQQazdgpE26BdEaRnQzKS42/Zirpi1LExnpSHxEWvhGnY5mg11r3WM+bL/7u/tosBNoExA9DEW3qxpz3FSfYVdeYWTu83btZjzwtfY/v0z7drMLhBBqhRxpzYJEXZSSgJ5MBVzu++EzHzP+RgtVEKKMr/sX4042eqoxWkkDOEvhWHm/RNDFa+kbPMDXWo9w/6cFldmw6zJQKHugQlrwSI+ghmI4kcfnKCA6KSvVFflZIkqkjUoxPpS28vIaqbIHNZet8Z7pllZWuiU4w8LxEJBuCOA==
Received: from PH7PR11MB7643.namprd11.prod.outlook.com (2603:10b6:510:27c::22)
 by PH7PR11MB5768.namprd11.prod.outlook.com (2603:10b6:510:131::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 13:40:09 +0000
Received: from PH7PR11MB7643.namprd11.prod.outlook.com
 ([fe80::bfb7:d3a3:2ed:6e20]) by PH7PR11MB7643.namprd11.prod.outlook.com
 ([fe80::bfb7:d3a3:2ed:6e20%7]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 13:40:09 +0000
From:   Oliver Crumrine <ozlinux@hotmail.com>
To:     gregkh@linuxfoundation.org, colin.i.king@gmail.com,
        sumitraartsy@gmail.com, u.kleine-koenig@pengutronix.de,
        geert@linux-m68k.org
Cc:     Oliver Crumrine <ozlinux@hotmail.com>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH v4 2/6] staging: octeon: clean up the octeon ethernet driver
Date:   Mon, 28 Aug 2023 09:39:15 -0400
Message-ID: <PH7PR11MB76435B4F086434D1478523C4BCE0A@PH7PR11MB7643.namprd11.prod.outlook.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1693229582.git.ozlinux@hotmail.com>
References: <cover.1693229582.git.ozlinux@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [J1hYYfhwKuhMbbmIZzbenr6bgeQ9JzQ1iqa3Q1AAbQ2GsdlqS2Olo8JjQypBoL5w]
X-ClientProxiedBy: MN2PR05CA0011.namprd05.prod.outlook.com
 (2603:10b6:208:c0::24) To PH7PR11MB7643.namprd11.prod.outlook.com
 (2603:10b6:510:27c::22)
X-Microsoft-Original-Message-ID: <4b6d2f7303b6a3d37e2aa62a76421acb8fef0146.1693229582.git.ozlinux@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB7643:EE_|PH7PR11MB5768:EE_
X-MS-Office365-Filtering-Correlation-Id: 53c80ac1-d2bb-43a6-a409-08dba7cc4b04
X-MS-Exchange-SLBlob-MailProps: AZnQBsB9Xmr1VCrDDYJl/lCLgD1Tr5zrrErctzovFMCNMg/I8W+CcJnVCHCKmVks4WV502LpR1vqir0aF+Rv+ujDhKWLJX431dMTEOOnxelElWWuJBtG8iTUIKyvxfR3rNASJ7LH0/rvm5DCsio7AdFuO1pEYgV8zMW4Gl8XcJ1FqEgwFBwjwbpbSIEdSzCYSVswtfqogRB0yGmoQyVKVAYDiXDpc57vm/9ktGp1GWuRbmrppQVUGLJcLnj6MmaXnO8ZtqM/n2GF27CWt7BI0FrifRgeGQuEIaWBvtA4FQ8SpfX0lXlMA2avC6pgL3Nfb+PPZmzTa1YaN7ABEk3XAgsVZUqLrUufQYJp8XlpRh0abYRKC+X1iZGePMsZuDycMI5Ci+/Kf5//FnRP8Ls/zT1z4TUL8k3VA8W2d/Tdp7Oxdt5wlWIQgFbUUb5OBIWclfibWxndZysBZ5DpqpTPcD0Ege23geUpGruRh866NJQNVpAeL+n9Z5Mdm7SGNmeLZqsXsrLYsK5vZX6cFsVMKf2YCUiK4t+JZZSwAVURLMbiTMth+waw39GxzmOveoFA7btt0itYDkUN0BmkXNFmWqqzDT6rulprh7uu30WyIvRd5j8htSfra4g0VOL7rAhTNF6zlnYbgMg3CWshSPA/jB73dWEE49uE2eDSzKhOqo6GwQb/b7ebc2YDFD1riIH6wMF4uDX9baQzh7EpBL6V/MAITeFi8WfPSHgPjy1isgHas2qUtYHT/ZAkYBRXPoIsHtNxhEMhGnY=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J+vkudQxnYpX1u5PAF5gyYM8GKjzcX2Dw9qjPFSEXCpaeCoC1uhB2Ioraq+1sRwzt39UIAfKJpbkzSjBuD+myOqy585/6JBOhRWukvOg8EQ7nnUMY3PitWJP0rLLozVAriGtIuRm4K1qrM1JXE9maWfVWAdYzob3xzW4od9QWqhjEJnG0zc0dE1NFyeK0Cd2FcmnJ7UPdXayuNjMAR+7k8P1MUQklvdYmSyuGz2Lq5l4FbhW0iA5Fe1lqGy7G9IF6V4MsI8YiZPvjeYwuW3aQ2b4gGcI7dB4KTtXdFUkaugJeDLtiaQzbjkGTfqH0KaRsytH05IycpZ5dNghs6INGrUl6DGyLAM+TofV6t+F5RzNimFx0Cep96Kq5WgEg1Q5/63P/RSRFpARFxhjIPiyTRMNvRejvCKG4dXUfX5AwPrhUgWIrEictO1QaAaLvXfofuQr0IA1VyXWZb8qzOr1238QWY/Sjk9FUKr8uPE3Ixa8Vt8HNZG9RFMGA8GcMMzyETZIb8bQPoDqy9cENfK8NjhlfPBN0vGIDUD16uXtckA23W1EeFnSHWorr7XhXA49MzfuHAbcioi1Q44DuVmZX9s/zekeblEkrLxar67sg8E730lUDD6HYH5vvT/WWOJi
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eKOEcqVrF1AVoAkoJNgFIxejRQNczQBDCuDQZ2lSwfHX9PF9S5WKGqSFHmIp?=
 =?us-ascii?Q?HWhWSppzy0H5DziYr8dz/QgBRXWV6E7Gph5niumnlORyBHCO/Lp54a2JtSo/?=
 =?us-ascii?Q?NKMHE3FV/cDoDZdkYFRhEcdMal6Tq4queHOkvleibYm7D5y4Vf0rs3EiPwSy?=
 =?us-ascii?Q?4XcQcnuoVUWxiS0r0mHOKHT81fG129ZRoWE7moddD+ffu7KDHz4qhiK+jUYb?=
 =?us-ascii?Q?9c5BOCSNETIY7ElR5dB+RE2cwNswOyu6154PZrtaITgEOAZABVQEdbbPfks3?=
 =?us-ascii?Q?ADJUdoFoeaAsjI58/DS19WXjro3MaAK/0SVWjQEPX7GssvvTTmvpFP2c8IWS?=
 =?us-ascii?Q?d4DL54iiYicBxAaArl7H35MllZn/s33G2dLQY22MAGmBB/wQ+mY+NjUAsc6B?=
 =?us-ascii?Q?MzpKYz6Nv2jicgpDltqbHS93x3QSfbUr/wO6AL9iWonRLrnA6l+qhIpscwgw?=
 =?us-ascii?Q?MXyYmSc4egx3LbO4B1h7dC2ZBSvhU9Y5XfnpjzC0ApCh9orUxaGSbIwP1U9u?=
 =?us-ascii?Q?U6atjaWZq0NbSn9dG7oZ8RqIunqZUrhGmjc1yObzJbOy/oLGR2O3U0tlAyyU?=
 =?us-ascii?Q?E5LMY/ukvIBeCxqx3mj/b7/j+eERCJbJWByf8t0q1bhipzWVr45+0MWQ1bVx?=
 =?us-ascii?Q?c3QEHNInDQRwqoWaBR34pgm12xtj8bRd42Mkv92Xda0Zoe0HlBYxMVzqEsnt?=
 =?us-ascii?Q?KV9Jdket9Xh7TIQAidpGC6ZpudYDxZ5RhSD5RFUdTK/Uxa6hGJVBrIsXBJxF?=
 =?us-ascii?Q?7+8UFahCP3ExU7mNPGTL9K6aXTTPlrn6Bt21+OtbPVT5p1DFSjKHtofcP2Nv?=
 =?us-ascii?Q?xjp6/2Q2g6P5AR6XdiE1c5zDMb97ebDULTN7jJ0W0UUwZVnakykmosfDCOiw?=
 =?us-ascii?Q?9lOkiEZeVe/SJB3NSmla9uanW1vbvHPFjxpIStoNJgIofBAEKSU6U05D/Awi?=
 =?us-ascii?Q?qV0GmZNyhol2i9XSQ/gxJfrBfNZwy01dU4S3MYRSe7XZ6+Va8sdEYAOIiK3J?=
 =?us-ascii?Q?0KPBk7mit9+P3pEg+ZVlGVSDvXKSmexep9ykDnEryp+hVooHFiXBHVp7PRKk?=
 =?us-ascii?Q?Fmi4kg1LyAvE3/Zp1W4Ls5brQoqWVmNrvmoH//KJtF+G7cioYP7qil/c+NsI?=
 =?us-ascii?Q?UaU1K6Lh/DzY3QbQFY6mho/4iVfTLW0LPpBD9fuW7LAc1PgC+GqV6Qrsv1/1?=
 =?us-ascii?Q?JHGgIoh7UtQDhPaI0aGLO9EA8eM0OtgeUAdYuPn3V4pKU5ibv7pWZ8BwyCeo?=
 =?us-ascii?Q?kaUY9S7vR8y1yYg7xv3D6WO1+v1Pjue6jmxPrCJp4w=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-e8f36.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 53c80ac1-d2bb-43a6-a409-08dba7cc4b04
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7643.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 13:40:08.0256
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

