Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5FE78A1BE
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 23:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbjH0VOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 17:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbjH0VNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 17:13:53 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2053.outbound.protection.outlook.com [40.92.23.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B1DB9
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 14:13:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JuhYlbbqSoPZOwLR2aolbmqOmXql3T/E98OFObuRgicOs8Lm3/RdQUvnUwbarJ0uXI4TgbGLfnlir7pVFJIC5wTCKUUIv580hBBT7VYLZmYRKU8iYCRAcVyx22iTo+cIb7WtSTFUv9vHbYzIJ1NV+UI6vgbS6oxP6zIclyu1diW11wp6vkjaxaaQdfMyPXJWK0eqp/4D0UcL71dEJLgjLhmSyDd9vDRuB/czBq0KBWJqghU0VuhWKSGGXn8VUOnriaBS4BoydhZVvDP2a4JwQWCSXQ0R2rMPUjM0BaSBGIs13/fmi8qmGaYRMsGXn04tJUXHLJeKBM/5O8C1RHZj4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pTX+qcgalmIpRl3oWBUXAKSEYg4A3eFyYYn/P6dvO6o=;
 b=FAIhIDBCgQo1wMaZ4dlsJqfQU8CrDaUGjKJzHF08NGBLZRN05D37wY8qykp7JFZi0jiw5pYoAa7gMNHwEPEz4T3/7VHA4T7ephNd+fLUO60+iE5Nj/+5tNQTam1HcUIkplxrMCnBh0BppWhm+g88imbo4iCw3FqcJ4mKt03c0q2CE9Z05eUmUpeFfgmj1Ki/9rPIJm5ydcNhveCle2f2fCAaAVNnwWrQPZb88sI9S1c4XzG+bUlz9QESohJoK/bX2xPBO0J5q44DrMq00sfKJpZL+xYrtkaSBUz0MhdAMVtfGb0OnC+skDYEXPl6v/PyfnAHbvn3pwGGwzaX8ebajA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pTX+qcgalmIpRl3oWBUXAKSEYg4A3eFyYYn/P6dvO6o=;
 b=tKi5bHrChUsN2E1AOrWdyXcsgkQrChCPrN2s9twWHp4/F8XqrVOlzWvHcKhsldWAuzS68mylKj/MiFKQY0Hjir6e/+fL9HFgfBA8htIFjhssZ1JRg6MAZxSw4qZWAGeN3SAzdHLcjB028w9tJ/d8ICS1czLbquCHtSyVtqw6rOYUvrIRbyLJ7B0KSF3sCmKu72r7d6eBTftcBkhDkLrouCVT6fSxkGX7hGpsaBGkKrK00XV+GSQZuta6D5M3JV5cqwPXoN8Qhw99MY8MwLHBVJaxDZccqJyoqYnbbg/F2BSR0O3ABz51/A5cWASVNyAv/zz8Fq2mjXMZIimiKDu6cg==
Received: from PH7PR11MB7643.namprd11.prod.outlook.com (2603:10b6:510:27c::22)
 by CY5PR11MB6115.namprd11.prod.outlook.com (2603:10b6:930:2c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Sun, 27 Aug
 2023 21:13:49 +0000
Received: from PH7PR11MB7643.namprd11.prod.outlook.com
 ([fe80::bfb7:d3a3:2ed:6e20]) by PH7PR11MB7643.namprd11.prod.outlook.com
 ([fe80::bfb7:d3a3:2ed:6e20%7]) with mapi id 15.20.6699.034; Sun, 27 Aug 2023
 21:13:49 +0000
Date:   Sun, 27 Aug 2023 17:13:46 -0400
From:   Oliver Crumrine <ozlinux@hotmail.com>
To:     gregkh@linuxfoundation.org, colin.i.king@gmail.com,
        sumitraartsy@gmail.com, u.kleine-koenig@pengutronix.de,
        geert@linux-m68k.org
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH 3/6] staging: octeon: clean up the octeon ethernet driver
Message-ID: <PH7PR11MB764331BDC59CEF3096F4D510BCE1A@PH7PR11MB7643.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TMN:  [phfpiyOLWc90BDgpMNtPR1fwApimFcRL48We8RJ/CD2rK5P0MFFDHlD1azjS/7Uv]
X-ClientProxiedBy: MN2PR22CA0020.namprd22.prod.outlook.com
 (2603:10b6:208:238::25) To PH7PR11MB7643.namprd11.prod.outlook.com
 (2603:10b6:510:27c::22)
X-Microsoft-Original-Message-ID: <tz2vowrsqz5wjfp3xezr7kly3fgjbihokxc632hkffrfpuedjr@d6swflhxdmlp>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB7643:EE_|CY5PR11MB6115:EE_
X-MS-Office365-Filtering-Correlation-Id: e7aa3328-48c2-43db-410b-08dba74281aa
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DbWi0SJQnLgplBAkVxZSL7lUuIPxMirCBDpix4c3rbc2H7wBKrdU1yl3bp9C3udMBawsR/r73b8TL7j6f6bnLsCcUhuv24H4Z6uhzOmyLZ5IKFeucr02tKlydASi0nenSTsc9GJ05WpDLGm6tfOwE5YP79XXjHnSQXecIcOTI2OWKz0I5tumG5oaW2ggdEXOgfQmBae/sdfCo8TSnb3lA0m8uHBN0ZZoZfy89ykcF/ZwMXWYO/vAu3TYFBJS7O5RYifIanQCxLx4rUyqWSQOABU+5A1Jr944vj+mlrKAxVXWSZoWa0XxGiaD0WQqPT5LBBUX3zl/0ahFqOUqjtYh9ItphFMZc1IvBstvYskx6lG90o6Ut+jwBToSIz/69+CVXklk1r6iTj32NVWa7vtHSlDB/CWoojlQygmCuxBNi7VVmgSd9KuKxmPKHjMILYL1GYrWAp0dp3curC2b+b0Nr1qEDtGVnuPVUmotUvRHEMtV/zJAZQ2oLao9saN3w841gGxVIgyQcAObZSVKMdivKr3DlFbmVfpVtsgmqxOOC9izw4ogVZEXE1fFY044WJYr
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AVXE0CF9VMzS3gw0oNZwTOiWFtJqoawxg8jny2wx34MP0w9J2nSewSWxjcpz?=
 =?us-ascii?Q?cXo6dTmOCXf8Bam3KIWoOgqx3mMZBSVrmvBk5k6uwFPswJO2F2/MftUz/UOf?=
 =?us-ascii?Q?q/TOsJMpFARUDY3Q8jde68iYg6SxJevBzAVThAu4vX6D0dCw6e1J8SJfuuwV?=
 =?us-ascii?Q?0hcjprdCCRPlhEQ64vlA1aMxs9f5ypXVNe3jVbrLXQHOT86t7rlccqCzFmvq?=
 =?us-ascii?Q?UN3W7DZESDEU0He4LG6rSrODvniw/VPDS4vmRfO7wYOhMmdPO0BQsVr2yfru?=
 =?us-ascii?Q?RE7G1W0bxp6V/2zOxoDEzbnBQZU366si581ClCaYEsqGhx3O9pZn36eOqcOz?=
 =?us-ascii?Q?t8u1L9EtRSg5zIvMMCt95h5FKkXit1wTWO2Po7WJqkHP0pE4D+b4V7+LoWIx?=
 =?us-ascii?Q?E2Lm0p+6Fh+z/tnDQCa3iYdT2BGrlRa+a7vPla5GjQwaRMIBbt54yrwz0Q97?=
 =?us-ascii?Q?Smb7PFjCdhJR5AJl8dfGpBB5im6dTKLMuiyotEx9cYmCurcM+SCr30TJWus7?=
 =?us-ascii?Q?7KM5ODyWlBqBxWR9sklwPoFcTtdoWzaU8cBQamA3VVpWCK0tPmIlOf8WVofA?=
 =?us-ascii?Q?GnyqoIVhb1/sCa5b7ruJ5aU2gzRf7e8cRs3bTwdX/XOFjZ89mQFluQS5kw9j?=
 =?us-ascii?Q?dZ9I8NQqv0KnNhFbAnMR8DSBrzL+G64Snsdp43LDjLRiGuyJ8MpGxsNs7LQ8?=
 =?us-ascii?Q?p0Iusx3TAGActYeHNgngafXuzIQX1IPUUiYkQX68JjkHurSqsdLm3hCAlVR7?=
 =?us-ascii?Q?wPsSSn9CptDybH0V38SeXPuUAELje1AuiZswXuCqaLolVRufL7p0ZjSmHrbB?=
 =?us-ascii?Q?LP+g1DRhSdDTAJ3Q3lP/noeKv97usa3qh+g2f1o/EJ9HG63zNteOTxWGWWjA?=
 =?us-ascii?Q?2w7tjdMN9E7l+vv/p1v/7Yy70pFKXlLV4QGpGwB7ERk45Q4f1S3QbUGFCDPy?=
 =?us-ascii?Q?1zPWVYx6xcKc1tgBGf6ozylHIUo7b7cX52HCeauur24YyqB7YueZtIrD0qtf?=
 =?us-ascii?Q?mpagINxYtGSaR19NoZlaFXjkOO8N6+F8vt+nq7bWQCFdWqhi9Yp/wzVeyDVi?=
 =?us-ascii?Q?lzIvPFuZtyDMUTObq4cA+6HX5YY5MHA431mQIm1wAlv2gJHI+g+7FX5fp8QM?=
 =?us-ascii?Q?jNduUBIPjbjca63JzCbQ0HBu07payaHVYFGKDXqXaZhL1WLqU4P0uxM4p6wt?=
 =?us-ascii?Q?pOKTy5igUdoFWvzIBVPqEFz0x6MGXD455X4VgD7xU1NesrOAemZIWmWDEQZH?=
 =?us-ascii?Q?UYcAlwwetbjuRDknUUWrfT+sD9npQ3G8X0+bWIcIxA=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-e8f36.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: e7aa3328-48c2-43db-410b-08dba74281aa
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7643.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2023 21:13:49.3186
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
 drivers/staging/octeon/octeon-stubs.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/octeon/octeon-stubs.h b/drivers/staging/octeon/octeon-stubs.h
index 0b0c609a771c..4470c985dc5d 100644
--- a/drivers/staging/octeon/octeon-stubs.h
+++ b/drivers/staging/octeon/octeon-stubs.h
@@ -233,10 +233,10 @@ enum cvmx_helper_interface_mode {
 	CVMX_HELPER_INTERFACE_MODE_LOOP,
 };
 
-typedef enum {
+enum cvmx_pow_wait {
 	CVMX_POW_WAIT = 1,
 	CVMX_POW_NO_WAIT = 0,
-} cvmx_pow_wait_t;
+};
 
 typedef enum {
 	CVMX_PKO_LOCK_NONE = 0,
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
@@ -1356,7 +1356,7 @@ static inline struct cvmx_wqe *cvmx_pow_work_response_async(int scr_addr)
 	return wqe;
 }
 
-static inline struct cvmx_wqe *cvmx_pow_work_request_sync(cvmx_pow_wait_t wait)
+static inline struct cvmx_wqe *cvmx_pow_work_request_sync(enum cvmx_pow_wait wait)
 {
 	return (void *)(unsigned long)wait;
 }
-- 
2.39.3

