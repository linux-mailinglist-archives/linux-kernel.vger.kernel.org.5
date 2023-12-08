Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBC5E809B92
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 06:12:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235788AbjLHFLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 00:11:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235817AbjLHFLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 00:11:35 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22AA21BC7;
        Thu,  7 Dec 2023 21:11:02 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B84jCvp011957;
        Fri, 8 Dec 2023 05:10:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=pCZpbXKYSsFrdNYrx05pQZdYkoqRPai4gZRDRdPIohA=;
 b=i+hm6Lj/XS4EuU8vtmwBfP8EKF288IsYMY7dZ8MxOJCVK9A40n3D8/T/YYoT1DjV+wlE
 E2q9p8rK9ECCgbAx8EXbkYTELzCLf8Bi7lmOgJXso2jywZXf9Wl18aO+RfHwm3I4mRl8
 ptty90ZdjD9M96Z3nopeSWsjCsRj2AN4Ycz+YbpdY0Y1dwknvBKghVy86OEfsTVnV1mQ
 mW4vYlmCMew2nlunthM7i5mnnRD91XvS8lO22d3LDLOOBlJDYuf6dqwC1Twetrgl2Ay2
 gHWgObf2aXpapEIYPQuO4BQzBiYFbOyHiIgDcd6p1OtFgQkOaeUkeOwf+UM1KGJwO+hd sg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3utd0mn90k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Dec 2023 05:10:55 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3B84R2TK016958;
        Fri, 8 Dec 2023 05:10:55 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3utan75x4q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Dec 2023 05:10:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DXKMPCWPp37fvt4w9eMCDB7mJVxHm6oWzIh10pA2Q1ETuWFZ6ubE614W+iyLRqa4kn714byqlYiSKTzyoOlUE1j2ZPITd5D9l1QniwbEhIQPu1c0I/bOrhNTLdDufQSxNWRKwKq/4nVsnDdr9o+HDrN6KfBEFilb01qSUfBBqAJS9CQxA+J1hr9mM2fR9yR6yXf1gNmvuUoxfDlUrPVhlIrpp/Oj4qTLfAibNJrE8zowrvd6c6aLNOyDYUGor3FhWIeyJbQkRQgc48SPTTYbufvD6DEWWk20DFHzh+30Bu83SH8IhhjuCRYw+h2r71Uh/L8Lh3OQVzyUqPYISeHNtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pCZpbXKYSsFrdNYrx05pQZdYkoqRPai4gZRDRdPIohA=;
 b=LTkTrulr7eLa/1KoIzKlxwxnRrN0z0avaV2vorgjpLoh6uumanJtWKuZ938fJzdJBbtlN8jlTtWjBiZeC0mQPmziFwW8v79RLiLn8Em89VhntSguRDcLjZsZTKXQpxaAys6I8s4aDFEhuyYMPiG7ADCYbMJ1N5YGfqPgNamn16llrlFI6geU1ZIlnZSZ9S9MXQAF4c8l3KTarZH4cgfimShuw6BOhvb125850ypCMStp/9spoCgRSSIuQYxoS8gmSeWNfwZZ1p5bYOSc/UlD4xV3F0QvHN968mLRKCd0P5UQ0ev+Wjv+1IdflxBzxvl8UURtgDJI7wEZ9sTatXJG/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pCZpbXKYSsFrdNYrx05pQZdYkoqRPai4gZRDRdPIohA=;
 b=IqW+dSEHAuZAzOQFc5/fpxIOfIeR6mGKq3B6XOEX52gJcp7vxNPjxZSd8rxeqXuqNgNDiFb6j8oLPXK37tZG65TiHnzb+jkWqHD/7wQWM0g4C25boP+MXRFx8paArDUQAnLVoszYVpxjHWka/qzxVDOOvmxgD0wCa6MH2bqcNaE=
Received: from SN6PR10MB2975.namprd10.prod.outlook.com (2603:10b6:805:d2::10)
 by BLAPR10MB5316.namprd10.prod.outlook.com (2603:10b6:208:326::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.28; Fri, 8 Dec
 2023 05:10:52 +0000
Received: from SN6PR10MB2975.namprd10.prod.outlook.com
 ([fe80::de47:3c1f:a55b:58d0]) by SN6PR10MB2975.namprd10.prod.outlook.com
 ([fe80::de47:3c1f:a55b:58d0%7]) with mapi id 15.20.7068.028; Fri, 8 Dec 2023
 05:10:52 +0000
From:   Kris Van Hees <kris.van.hees@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     Kris Van Hees <kris.van.hees@oracle.com>,
        Nick Alcock <nick.alcock@oracle.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jiri Olsa <olsajiri@gmail.com>
Subject: [PATCH 2/6] module: add CONFIG_BUILTIN_RANGES option
Date:   Fri,  8 Dec 2023 00:07:48 -0500
Message-ID: <20231208050752.2787575-3-kris.van.hees@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231208050752.2787575-1-kris.van.hees@oracle.com>
References: <20231208050752.2787575-1-kris.van.hees@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR02CA0017.namprd02.prod.outlook.com
 (2603:10b6:208:fc::30) To SN6PR10MB2975.namprd10.prod.outlook.com
 (2603:10b6:805:d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB2975:EE_|BLAPR10MB5316:EE_
X-MS-Office365-Filtering-Correlation-Id: eaaf2d45-33fe-4caf-809c-08dbf7ac0cc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RX4JyULxhMUtqkcEoPGWPXfNgOEup03XIrP6Lscu693jj3EGpOwIK7iMo977mUc8HmTkNwGr8SVkZFJbrdOz5SIdrd3pXpzsNSod6ZjZsXW5Fr38B0BbGfK8UT5jsM+Qx9XRQcrGZkPsONu4VXImi5ILuhbWwm8R9j2Q3IOIzXEqS76N9j55w/BsG6KCMkGBoM4YLm6EK6NtFAEZsu34SzBPg679XX/vsvbgnIdJfICAgtrHrLQznENYOZmEtkll9OvhvJFy7hTLVM4ZWFBpTgnZXyICHnnW+dIyON65MqO0n0GVQcXh7EsEVfGPHd8P7o1bKL9Qro0BBGUrHHEd1QU8kE4R4ssxcyJWRCXTGLGQKDzlQQH/me7DD0aTf+LSTaT7jbzUzLTaEaU35tCDFypUBgzEfh9uSFAq9snbWA8DK7B9YUmTVh6AwDW6bYt6yz9HKKYBaWtTz3UfswWXvSYT8Cn79M/uI3EWINRHrTJp5ZNY/JjjYBidw/Ox3uDRN2P7Xt/7oTpK2vLMMtmO2elDT0f+apcj2hkvhtL+8+Mwg6QGHjMCyFuG9bGJ5VcZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2975.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(136003)(346002)(366004)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(6486002)(478600001)(66556008)(66476007)(54906003)(66946007)(38100700002)(6512007)(26005)(316002)(6666004)(6506007)(2616005)(1076003)(2906002)(8936002)(8676002)(86362001)(4326008)(5660300002)(103116003)(36756003)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g9xM8f4XE+8kcMNSjwksTVg5/MXtzowzEbb+ME0t3bsR2drz4XsusK3IEmdc?=
 =?us-ascii?Q?lKb+dCkXQDauhspUS5ZMs/EcNhbPCKjt9797RWVVSI/CqaMK4xdK2grbIsho?=
 =?us-ascii?Q?veEH475cYFmU27IwHptuG20bVRCspGdBC/ZLRxSf304Ur+D2WOHf+IQ/WAP1?=
 =?us-ascii?Q?98JtTOflrDVR9i0ECeZJQ9ErNES9uebgGQRK6GyLlO12mwAsIZEAzKQbqtvj?=
 =?us-ascii?Q?FmhhFh43nrQ4Do+zyvz+iEo987UwtGea6i7DBvhWmXIvgAtSgUJVvYhDQU1K?=
 =?us-ascii?Q?Oxeq4ebDMbyNZBKRDJ+lx/rVW8PIHLyLAwDwelg9+UqXc31iBfBZZOPYh/xo?=
 =?us-ascii?Q?PlyANiW5/YBPcmsytZ5pLnXgtGr1yNGrYtwtbf8RMn4QohXfElBtX4wSN3EB?=
 =?us-ascii?Q?V7jE8oE7K2uAErTfrJom5qHBK9yhnV3tb52D6QGooEwrxHiDoaFOXb0oNqFa?=
 =?us-ascii?Q?TNXicNORhKBtR8m4+zrFUb19ggokFwn8ifpj1/E48iOMo+QXrcWOV1cF4YQj?=
 =?us-ascii?Q?wrnrhVA9nPEdePVqAueNJyi3F5PQbT+FUe3EwFelMYODYuI+0hjIkg5zB9DP?=
 =?us-ascii?Q?3Zjw0lBcMdofGZF8V0wvyyeXNTMYDJpMJvV5bx9js+bwGVtzalkDKPobDMbn?=
 =?us-ascii?Q?QSB8LZlLGLHVCoL6avoXFgUGIsksEKyGp7lPxqBinCNjzsxZMZThFqHxEMyT?=
 =?us-ascii?Q?na/FyGNw7m9UMeXijyyBdF42jv/hTvUL9msYQzFhcgjp2JUX/F5+PtL+TylY?=
 =?us-ascii?Q?vqneOKeTG/E51juQIASxj6ZMGUcdb89sqbNGQmgQnzRdhL2JKE+feEeLFfvs?=
 =?us-ascii?Q?tzPBWBf13/X3NTwBr7GCnd8IYQqzwQ0mmgPcOwvt0vOfyovtNTRhUcyc8yU3?=
 =?us-ascii?Q?GwXVsN1DnaNHNchEttxvfEeBAxl8C8bcsQJP8aaNA4D0jltewSyNl6gH1yqs?=
 =?us-ascii?Q?9hkJ4aXeUSE9HPGwOfpyccet2raBcEgZ20oGJRpIo8l/PX5wQ4MhR3DwVtO2?=
 =?us-ascii?Q?PpFyNdVtRfpV4I7Zfga9uebhmEdjQWeieVG0XDhq9o/mLWkr6/RUsn7wrkhl?=
 =?us-ascii?Q?v1Hjp0Qo2fbkxyOrjjCaSx8FdlQLCbNaY58v13rMa2UHhlprXUsNZCwb8/IJ?=
 =?us-ascii?Q?/yYKmXIEYaxV3oqAVx1QM4ppTGIHYLZHkhNQezc+Zvuoy25KAF8pW7rw+Hw4?=
 =?us-ascii?Q?901AWrFPRnCklftbh7VVYbIouLF4tovZR2hvfCMndqwa06u8n5CqK4IyFpLA?=
 =?us-ascii?Q?pttAid4pV7qp+BlImI2+LO7+0k/hD85Vnh8BxmUWKhiidPaXGKZeHA9qHq9/?=
 =?us-ascii?Q?dsXC0Xf2nSrcshNXjlHpIDvEa5UyCkMncfSRVF5EdYs42y697XJvm8Kha/LZ?=
 =?us-ascii?Q?bknMyHPIvIqf5XiLD7Pc8Hb+7D9r1QikjP2m3C0hHa3oPbb6EtSW7DUpJVsj?=
 =?us-ascii?Q?UzYUg9bdNTJ+QJJjNi2JI6OMMW21EsPGJoHjhASVHZ0DYFloTNLsCHK5eU2L?=
 =?us-ascii?Q?HQFKCjFLsDLg8gwqZ51WiVTpnPb9zoK2lVrEWvuGjiXPZnT9IFTFXLZchCk2?=
 =?us-ascii?Q?oFKGCxXI24qUEFHrApO38wkH9DP5K62jYYWF/YjWc1vXw81e3sotvs/I/3ZR?=
 =?us-ascii?Q?1A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: aj0Ta1P7O0WGZBss4t3iPc2A/awKlWaBBoLr26hx9Y3S9L0m6vNPELFh0naciasGVkVFpFc6K1FfV3aFLG9cpIODrZaCbzXygXHDllw8xPpcB7Vejak0PLDeQlVpEtOsxGwfuxZxDigF602J8Cjlx07IFwECzM339qYt5mJquuvnM0wF/1VBQeeoudUgqZFYiADAXo9qLBe2/e9970dVKb0XCdXlGd2cT2q/KPC2xPQSXNpNkTucqATsJmmCyQYmwiA5TkSPnjqj0YmzfB1ATPZLZzWRqb36xpSY8Mjfc3GNoI676wsOFbPeDsQ189O3lGFKuY880N+Pq3mV/GiZv9N/kK3w/AGg2uUraQu0RLov8CWhhiVSDdnjCZU6SVq0G6BIBsK7kBdWCFZzBWUvLirLxlHdxrskPj4mmO4T4tTQ1NVuCpJ4H4OQTFn8kq+wB/7KcWqnEEUJcQKnBVtSvG8aB4EA01cCD4bePywZo19nLTGZj0nsTEpw2IPTK3+BAfIaTKREZu/Q9lKkc53Pq+bM4+YDqI8M70ZcCajpA3QiQJj1FmtX058VTueqD3U/n5H1ZJN/P2ynlojwFXiH6KbxJvXTv98LeMizttGEMUrIU8v3uLf0tXPZENr620n4eMWlUGqMX8R37FrpfSnssg2b9AjFMOhMsekDsMJMC/2dQAyZH8q/D9yQMS+yheyHB2iGZOwBl2r5mL1O6zFO/ldnMieVtjHrkhbqVE905bkzyeD4iDk3ffwvK0xSvKKL3SyCoTBbNMVVSdEg33fVsDml0oDjIpF1S30qshBcZV6B0iK7CKyhwd252JNnsRMev0BuMwLD7qBmgn/pmaQ9RfbbCO9gnQdIPDfg/iTD7TiiNJ6Cml9hLDzh2bP3HYd0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaaf2d45-33fe-4caf-809c-08dbf7ac0cc6
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2975.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 05:10:52.4780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AnBcQWJkEeXvzxPcCBfZh+sJ3HY12hy8ERFhKLeoM7SwwrkIwvwl2KIhj4RRBCB6/WqPaTq/PVqU8lMx464DPRd+KwXHAPnzA7rrQEXaatg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5316
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-08_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 phishscore=0
 bulkscore=0 adultscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312080038
X-Proofpoint-GUID: xRO5OL__Yd41Ds2rc9qu-voo4RjUHP7E
X-Proofpoint-ORIG-GUID: xRO5OL__Yd41Ds2rc9qu-voo4RjUHP7E
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CONFIG_BUILTIN_RANGES option controls whether offset range data is
generated for kernel modules that are built into the kernel image.

Signed-off-by: Kris Van Hees <kris.van.hees@oracle.com>
Reviewed-by: Nick Alcock <nick.alcock@oracle.com>
Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
---
 kernel/module/Kconfig | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/kernel/module/Kconfig b/kernel/module/Kconfig
index 33a2e991f608..0798439b11ac 100644
--- a/kernel/module/Kconfig
+++ b/kernel/module/Kconfig
@@ -389,4 +389,21 @@ config MODULES_TREE_LOOKUP
 	def_bool y
 	depends on PERF_EVENTS || TRACING || CFI_CLANG
 
+config BUILTIN_RANGES
+	bool "Generate address range information for builtin modules"
+	depends on VMLINUX_MAP
+	help
+	  When modules are built into the kernel, there will be no module name
+	  associated with its symbols in /proc/kallsyms.  Tracers may want to
+	  identify symbols by module name and symbol name regardless of whether
+	  the module is configured as loadable or not.
+
+	  This option generates modules.builtin.ranges in the build tree with
+	  offset ranges (per ELF section) for the module(s) they belong to.
+	  It also records an anchor symbol to determine the load address of the
+	  section.
+
+	  It is fully compatible with CONFIG_RANDOMIZE_BASE and similar late-
+	  address-modification options.
+
 endif # MODULES
-- 
2.42.0

