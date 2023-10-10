Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 823517BF077
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 03:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379376AbjJJBsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 21:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378945AbjJJBsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 21:48:05 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85CA9D;
        Mon,  9 Oct 2023 18:48:04 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39A002hu018232;
        Tue, 10 Oct 2023 01:47:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=nq5oEFCN9OUr77vNOpYmtcoIfNSq1Jr4egBHPB8kbwg=;
 b=jlJGelZIQVAS3ZefKoN1prX++E5UC7MD8Ph3uHXSB+OVHFQA+EnF7URKahrbuvFKIrLm
 tOtamxvx4qtjdSlSCuRaprwBrO8bxlYZdU6IgXaam1f19pmaLEKaUC4xfYGL+6pw06VG
 Rf/f17fAEeBD1XdZS6VwsAAzFMNlsSHJH+YNKrED9O/oxarSK1SERiJgacvNq6RQpPZy
 XLqUKCgjFEDPC8sbWTwmkFGK4hefxuxbbUXDHmupLd5hw6RbTExB0/KVH4/ttv+9GrVO
 a1hhMwLSAa6a7u0gJx5B6X3kgzGtue4YP/3ROICoi2ri3MMfILiT5n3CuP4DTIKWKSCe 1Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tjx8cc1fv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Oct 2023 01:47:59 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 399NHU4S014639;
        Tue, 10 Oct 2023 01:47:58 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tjwsbed7e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Oct 2023 01:47:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B8JZrEpdZJVfvL/XcxJ2aXkqf4zE/if8Yn3w1sGIz9bCrEkmg5gjXmkhPTq1zZLizzWNEIt6LX0zE0aeQ1qhIC9CJSzZV1P3JdSUHFYxJ6vxkyuvMPMZ+j5G7CKfXEmLNGaIJp0KBV19KfFELQ8tyCO2XFvEN/+TtW9uDhAJFXhwnmz52fNpiNl2n3TNfeqMK1bLGmKIgFHf9CegTdQe4+ix5k1qIlH5dVEyPsKRbNScmdajOnEeeOCyULIZ6sx1qo31WMZQljvdqx6C9xNUT0yikmoHiwcIakWpk2TWDghhTSEHaLDjpc2rQG+ljKyNjB0DZCQIY5+i+dTl14+xCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nq5oEFCN9OUr77vNOpYmtcoIfNSq1Jr4egBHPB8kbwg=;
 b=QnCOWotz3nmdvqMhakJqtnlvhpV00sCbq02oVzsZca9IXTlfhT8CcyIzsTSnmuM8/SOOcDLKDMKmzSR14AoA/pNmDKKyzCR3vqPprktTI4C6t01WtiuG5WcUsZ6FJsEmRIa/MlmXDORXA54T5r5XPmDnIsLQl0TTw07y3SdllSdhxo8xCRBl+riiA57OXKOsHFpIjNZZpqvYV5hHs/pe0et1r1INn/4A//9I2Lg20TxSbTjK2ToMUGJyYgDL4vOdo4UJ0q3yULmhUb0g8sRv4BHjHxD+8pOr4GRKd4KqTi+Iy6T0OaIXLmoLSuV1ct7w2zrVqX1t03HFzMmH8iPTZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nq5oEFCN9OUr77vNOpYmtcoIfNSq1Jr4egBHPB8kbwg=;
 b=DM4IPERoamzJinm6H2MO4geMUcYK6Yoe9G+eNMcXLCveHq0Y6+syI1k/Jkzd/QuSgnNXbyRc8dkfMxKh3L461+cQ+8NH2b977dI1jN/CDsQLtKtQUmkua424Q9BWM7j4rjUbJld4O18L7IkmwXeNoJBD4aQV6rvqxvGTvkL4mMM=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CY5PR10MB6190.namprd10.prod.outlook.com (2603:10b6:930:32::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 01:47:56 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1ae3:44f0:f5b:2383]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1ae3:44f0:f5b:2383%4]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 01:47:56 +0000
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: Re: [PATCH v1 1/1] scsi: ufs: ufs-pci: Switch to use
 acpi_evaluate_dsm_typed()
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1lecbnt8p.fsf@ca-mkp.ca.oracle.com>
References: <20231002135125.2602895-1-andriy.shevchenko@linux.intel.com>
Date:   Mon, 09 Oct 2023 21:47:47 -0400
In-Reply-To: <20231002135125.2602895-1-andriy.shevchenko@linux.intel.com>
        (Andy Shevchenko's message of "Mon, 2 Oct 2023 16:51:25 +0300")
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0054.namprd02.prod.outlook.com
 (2603:10b6:207:3d::31) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CY5PR10MB6190:EE_
X-MS-Office365-Filtering-Correlation-Id: 298c8109-953d-48ec-f01b-08dbc932e89c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6Tzihlcsuy2BC2Fs9J5kl+xYZ1gLUwPvV2hb7tU8rPlEPrtIksnGbKO/OkRwvlqOhlyPoyGqswmCZLxbdBWXct0N2fX2fAGeSMqWBZEJrmXaYDJ3OpJkgPlbWd2LuKLEF7WRSFj4mEbARL7ai37KrpPcO+OsPfVqP4T3MUQ55EDbIbeC4gfW+8qI2v+jTg+VuEx25e7+Oc4BltGGA4Eidd/rhNZWuWHDHDl7beNVcasl22kqDFS0ikG5k6sWED30zQSNmI9h/rV8bcY5r7zBkCXcNEOGzVGkW+FxOP1Ck9YtxbGlVJMC2iGQMuz8JIivx/a3GJt+JS4xplQGmPSxSbh2o9A3l4ty/CgIKqEjQB4iE62mM7LtEQRDuFsyKlLFoUKowtKOm+7d6BtAOWcE1I2REdge+ugoYnk+IN4VFofClpIWyrAJ6gJBE0ngeCZAuPeKKeNkkwFLHWCoV1KplQMSLuzbXc21mso3OPM51O4zH66ORWOdbWkIr1CUekVD9zZkYLFVZD0GbPiZm4/cwEYxlFQ3EPBj105ovCk1Empb2UHTFtCQHJF9onErzS/b
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(376002)(39860400002)(136003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(6512007)(36916002)(38100700002)(86362001)(26005)(558084003)(2906002)(6486002)(6666004)(6506007)(478600001)(4326008)(8676002)(8936002)(41300700001)(316002)(5660300002)(6916009)(66476007)(66946007)(66556008)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Vq20f5gP7ClREDo+F7cPMXncy2H0ASnWouqUxzOgBsVBmWqgWowiFrKGBEPN?=
 =?us-ascii?Q?IIHfT+A7ijnhAGqq9U1ij0jEQFIGV39WJUBu/SOc4XwrhMPqBTY40AU+s6v4?=
 =?us-ascii?Q?nTfGLGUZuXHs1NlLumdtutznp0VPHMCPceRohpocI5gJLqmf6C6Ly04OaGmB?=
 =?us-ascii?Q?qrCN2F94uZmF7e0PGc3+2ifD+GL2Lz3x9q/dPqwocjKW0/KzZ01tpGtpEo5/?=
 =?us-ascii?Q?oKDiGjL/BsYuVYgiKyY82YAXcX4mQ9k9ngzQ2L5BKmEJLIZam6iLeiXjjOKq?=
 =?us-ascii?Q?ZC2YeiCAPcO0i611imgFrWVbvEVJ2VC1RuC2qLSYmUcgOGnGMbUeFuMNJf3a?=
 =?us-ascii?Q?o9tgH7wOsZ8PVoSdlIBglmudz5TN/Ys2JCcektmTTDjv/5VY25khDqfi4fCY?=
 =?us-ascii?Q?kEH2pRSwMEOnNRdFiky5NyndxWif2K2XHAMOXcPIgTJtmUv8Ll9kRvlsQG8x?=
 =?us-ascii?Q?R1bni9khSweVFLsp/uNYRnC4kjUOralKZmhpewT/gDO+6qyWYDmWE2kJrO8u?=
 =?us-ascii?Q?hDMXywWIRH7jmi3sbdqtgs5QmUJQIT5YyCW8Vn3GrLREacDXmBCEof4kWPVy?=
 =?us-ascii?Q?60sfw+0JgvHQ60/tuoB/WvIz5sfxd0vkTGQG4yQRMF+/LZJ9MhZc+D1JYTqf?=
 =?us-ascii?Q?7plfT2AIaHGiIriA8PCVR6AbsUyFYyutEW6JqrDOW7UMPdtwkvwiJQr0mHt3?=
 =?us-ascii?Q?Dm/xzk4Hn5C69mgbmsv25eEYCpZAzWDBixy/YJmh1L7Dvlb70DbA0RCjcSQz?=
 =?us-ascii?Q?chY1J5niOFI1EEipotffngJ+i/xlPfeY/ykSKBG0+4ygmWCbg/YukwbSntiu?=
 =?us-ascii?Q?4P9rVqQK/vzrm73Ezxt40HFgtkHX+V1Iyq+WwRXgBIyNFYmXpPYdh1cMz9RI?=
 =?us-ascii?Q?5VuJmiGqcfzFM6XdNekb6ixvf8YRWkPzmhKgnt8n1od0yzpk97Kq357nIV6J?=
 =?us-ascii?Q?WI/zGRJJzqIw+ipEklJB3KSSh7EnM0ZHxNbefRBnaabTSDkOZcYfI4HW3WgE?=
 =?us-ascii?Q?niZO18viVojtbBEKFZl5OFx9YmtBnMygYp8Bj913WM0J6Cc9yj0Gzm31bW11?=
 =?us-ascii?Q?cq1dbpFjMxeJzxNNEaDQQniLrW6S9SVThRpfgzfxjCWhJ/y0unQMCxKMLLdR?=
 =?us-ascii?Q?BYcbaXdajHndsod7BzL+oNcz1Etekw5nsclmuaMpPwDbj1sIlkN6gXUpowyx?=
 =?us-ascii?Q?JQSyvo9Sigz1FcYbObUJ/a1cyImioEicA4DGOBToPSHHwNhEIS7zYzY0Bk46?=
 =?us-ascii?Q?0+RaOoh0n9xXosqxum/Hme3sK3O+ZaD1cZajAsWKzrnOc8eJa21i8fPyVDg+?=
 =?us-ascii?Q?8NBi3YjYhmcJxtaDlEQsHugz0MApteL0jxB3HXiEJqJwUZXp4R+hwV4XEIJ7?=
 =?us-ascii?Q?YHdpf0mRIdNceOnY7QdUgFX7ZDBYHeZzUQC/QM3FmRdIJSX2gczI4z4Aabwa?=
 =?us-ascii?Q?OUUzuBTkZe5xm0sHE4MZeiVrjWMRnU3iFvcQbGh5wAmA13YF0B5hbPI/RV3E?=
 =?us-ascii?Q?qFPMB4jhvlJyOAcUyQ7Fht4I3v9HI5cZ7xr+Z8iRcCXJRU3SpzVK96yJNMIx?=
 =?us-ascii?Q?OCgSCt6fvJmYPiXdXes173JQtbYafuswDd24bi2ql4dRH20jyXPj+t9o6W72?=
 =?us-ascii?Q?ZQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Us6yec/UYGi67tbSeSqTURaVdJcZr38ZotPwhNUdZgDy9HK07h85h7oW0LmAOJEY/M9jpioCqSDk9UAYWO3Qkrb7SM42flE8ItJ7eIRp4uO2r0VJKwUCOoGHYsI9vXwl06oSp4bgqxEmvajwiFZsEMUjJA1fN8I8W7k/GKfxl4ut+GSbOjfE5IzRhr0o2DYbV6sYxad6YBhnpzzdwZ1EB9VuRVNOufkPo2PKT+euIdq8yNWYhI9gq9VPo1qO8MH40lD588qDbdTTQlI2PBx2Ch2l5k3tGFzhTIvD2dTRzbJH8ibPK1XTQ98EGVCd+o+WlPfW3i3gdbtxlaz/uza6idjFo8kfKj1C11L6HUWBBlHLXZxeb54EE3bmTXx5oyyNWvx7HuS8yj7q8PsPLx61NNEvUSaqJMxchNuHmGxY5Bfgb8AyWhWuCdREEnR5UnjyIlqXNzpGRHjj+p1QA3/a1d3cbStlDaVbovxnaDPqW1YYomcI+xu0Cmk5OECkIPXmKaScnDSvWn1uK2p6iP8zWugMCHJBwKj4XWVKs1puLAX+euN/UWr20ULc/JVGs98c+Ryz8YAvEzsLBocrd+r1JAABwLnAtQKJUd858pTsFiXgnuxENbTZrjt1aEELiG5M4QWHEa0uShR4ap+Lu/V1/YsbI0MkhBRs1CJ/ErJWPT8/cmxuqFWmr5Bxm8lhPa6Zx5/lZaRF3stJpFRCncX1qJVN9jWGAswLxuM9twdktXesWmUzt07omU/w065n70CCozK+SbQZJKDyoW6m9tbXFKvvwJMmtDt6RpDJflHkRu48f52c+iMfumP0E+cqMdZI/szPXFQBS5L6T1D3gU3PMSTC9FJkyZEWFjJa64qoj+g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 298c8109-953d-48ec-f01b-08dbc932e89c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 01:47:56.2098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gGSY7rtVGAXEpbBTvePKQpS2swy2X3SVMI5e+iYPJlCgtN/L/nGvGcIonwlojFMewsK2kXUbfzJ/yUKfA8bwoc8CJ/2bvWX0CA/OxFUHuvA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6190
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-10_01,2023-10-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxlogscore=679 phishscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310100011
X-Proofpoint-ORIG-GUID: -ebyZ5SqmcITVdNNShS7ix5K7AEpsKto
X-Proofpoint-GUID: -ebyZ5SqmcITVdNNShS7ix5K7AEpsKto
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Andy,

> The acpi_evaluate_dsm_typed() provides a way to check the type of the
> object evaluated by _DSM call. Use it instead of open coded variant.

Applied to 6.7/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
