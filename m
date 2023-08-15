Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F66277CC18
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 13:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236967AbjHOLxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 07:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236908AbjHOLwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 07:52:45 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF41C9;
        Tue, 15 Aug 2023 04:52:44 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37FAun44020678;
        Tue, 15 Aug 2023 11:52:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=Y1O6alX8OftF2Cfgvip6u2b3sKso+cY4JLcvUn2AHoQ=;
 b=txL+r8AONzM1vU/nBV0XhXyiQV3RPjQLKXalaCqZMOhGyKxuoAZ+4Ci9Kt8nJVkLshfM
 RWW2bLnD9UoOY8Ze6KKllOinZdjl2jHFyGIyRpPLYB5VEMN+wzoWZdkVl8Tg3Wo6o3HC
 QKNbIZNXTYiarnxkEWjsTJRln0vpkGuhkABuZA8iMuAiH0B4X4ZCfShBlJHC/BRIeSnT
 zCWjudFaZQgPfs6BIzUaUvTxaOslIOwlLSE1MkWk2gctQg3WOZMLQ0oayl/Q3XZrfbzi
 duv6xlA6VQ6l12oxm2q1ZCZ0Jg1QYwLfLeuv1UfPSQ/9vUQ144OgfrnvA2cepo3FvkiJ Vw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se2y2vh1t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Aug 2023 11:52:21 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37FBFq6C019891;
        Tue, 15 Aug 2023 11:52:20 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sey3v7te9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Aug 2023 11:52:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aHrgod2/VaR07F6wxIh48Q6DVSpFAKcEZYV5alXheG5yVcKv8dz85O8YWckrEoUvg+HrmllPnpuUDzPU46SdZpS3GrR9QlGA0Uk3V3524gyS45NgaaKqQErpyq/7Y2VAOhN37JaVVH4poh3zyAqw5VTVia1eHkBMjvDRIZeOYC9Z3U1pCSLAedaN2x7gyEu+QkGt21W7A7Gt/OMvEb7rEjxP/ZwQv5CEe9qBydXEX/u6h0jiQPIbVFBXS0Naghs5Qro1U/u9PqC/eJy3Xy+jW3jQk1Pizef7SvpFYQqnM1Ph4hYLdXmRnQaIMnW0yo/E/RKIW/PBkE9YmFFaq1r/og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y1O6alX8OftF2Cfgvip6u2b3sKso+cY4JLcvUn2AHoQ=;
 b=c/Br+gCMtshMmQwoMHMQWniBlSpEiwhGIDGsF2xI5gW2g3+BzA8UnVlsp2Wi0t/I3edsR6fdOG+vKkoNuzTWiROt7iFveEWkO2SDrWP/1NY7Xs89ozql9ci+joXfLuOEz7eUYYmVKgJACUKHCbeznaVG0a0+WJR0OCEdd/rPnD5wsPFQdm5Y5OFbcqJc0vkCSVb5ssA5yoqJmAUx1cRdKF4ore6i0X2bQ+A585Dw8/3xwMrZQTVByVtqwxmF/8wS+5zsQxhY0LZ2kJNVBRUw94rD0igYhAWe++YDY4PIG+1SRxjOb9CddOCqrr3ydNrnpfSZqDvqnqSWNtuSaxUPaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y1O6alX8OftF2Cfgvip6u2b3sKso+cY4JLcvUn2AHoQ=;
 b=S10+Mqb49jy7pPT0l+9wKLJJKWj+I/0fYA3j9G5cCyUDQ7aQO4HZk9A+AvD00eRKvmVGBnC4eGAmQdkpzVrvANi1BDyFUs2f+JM3h06vlwPOQdaoQ7Y7x6x1XfdQXjmLAPZa+O/98pTkkB8hPmst2/h0zcBRXKWaxNiV8ZIh/ng=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH0PR10MB4488.namprd10.prod.outlook.com (2603:10b6:510:35::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 11:52:18 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%7]) with mapi id 15.20.6678.022; Tue, 15 Aug 2023
 11:52:18 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        chenxiang66@hisilicon.com, artur.paszkiewicz@intel.com,
        yanaijie@huawei.com, jinpu.wang@cloud.ionos.com, dlemoal@kernel.org
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 00/10] libsas: Some tidy-up
Date:   Tue, 15 Aug 2023 11:51:46 +0000
Message-Id: <20230815115156.343535-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN6PR05CA0009.namprd05.prod.outlook.com
 (2603:10b6:805:de::22) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH0PR10MB4488:EE_
X-MS-Office365-Filtering-Correlation-Id: ced78437-c6e4-464f-5530-08db9d86137f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 07WeJ0dorIEKIa1zGG00iwbjGz4m7QKH2KXFYdn2l48QifQgqEsouG+xhPTA6Wtox62ervSacGpfdTvUADYXhT3nHh7YtPefWMQbyyzMZzMM7oKudAzjB0CdS0IYiLAyrbIKTho51TtElJ8Av+6g74TvAcpswPIByKzZ2kabaJq7pL7jnfWv7qk+y8iSl0mg+a0bQwTSZaY11SL1T9ZPAyzlfGl/JIl1NhqQfSn6JSW2mjU2CJpJ+RH29BUUsfEX9B44yae4O+O8/ZjhxtAMcy+74WjOZ7JR7gsfXHYfbF6zWvoAzK2U5UgIG6fSdv9ffHZoq969lH+Mb3ENPRBM0MY2KkinLIz0Ba0vU6rvNV4khvwK4l22VVrkDtrrnjqHYts61KZoJXJhWn2v8BFlZb6UvcTGGVQe4gawgZdY3f8c090DzNcMpT9kJuPpriovONai9jUY9KJWB6YeFHxOCD/STzYlwDOKWYqhyPTYdOWm4HhRsNIlcXHgOVO6vzOWg3mAmymi3BdOzF0nWE/SsbFt/hH3KWdyfIzDBvlZIEM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230030)(39860400002)(136003)(366004)(346002)(376002)(396003)(1800799009)(186009)(451199023)(6506007)(107886003)(26005)(1076003)(2616005)(6512007)(86362001)(8676002)(966005)(478600001)(4326008)(41300700001)(38100700002)(66946007)(316002)(83380400001)(66476007)(5660300002)(103116003)(6486002)(36756003)(8936002)(66556008)(6666004)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IgOQ0qPAJVi7Hu8iJAKrJvXLuGurcj5r3eVrnC1PI/ZxxRjYQkIK7yx5FDOl?=
 =?us-ascii?Q?TqnuTN8Nkx8qqnIS08RHcBIWOVWeCUXOBu/YyOT15jOcx7hUKjnBHQI2r1iT?=
 =?us-ascii?Q?g5vKvB4mJDH0eitep8tc2tqnGYOcSZ/ebANZVBeQQODZh/F7AhLYjLQYP037?=
 =?us-ascii?Q?ESrAuKS8G3FnjAxiuZVP0oWV3R8KT49xOHS/It5tQxnzFYDuncyQxfx2qXnr?=
 =?us-ascii?Q?NuRllUPM3i3SLSN7dgIM/JWVFrQOrcsZVA9LEpETin9PvqPIriq3FT/QKQuv?=
 =?us-ascii?Q?/QERlHKdUFM+oSs/R9YPfREDMydY+VBxNYGlo15sq4XwXU36Q/SbfMgWPQRe?=
 =?us-ascii?Q?h70KXhz6HPsQ2fGWGv+f4jPtMTTCzAA+JPeMwh+tM+F6/ZzW3vCGN2FsewpF?=
 =?us-ascii?Q?eRNYnmr3aK/5tf3OearfG/ZulhnUGZvyeXbGZ+1NS2Y3gyhFCiX7ekuF/8p3?=
 =?us-ascii?Q?dE1Snmy7uFhBtt7yZM4WbeeITRKbXc5ZSZtjYxqzdR6E26lgBFbQ63kxfnUe?=
 =?us-ascii?Q?Y7458C37tSbSD3Ma7Xbr4sJ+VAXPDRfutpsCzzM1YmoDL7VT98kTxbrxhZa2?=
 =?us-ascii?Q?aYPxv5w0iw2VlHPABZ4s5ctfNj7FvSGZoPFSZy+ocLl4sAwPVgsXO06AhHfG?=
 =?us-ascii?Q?pWMhqcHb07IxZ/ajNqqG023b3gQ2djrLM3g5MwPIwttuihCGxPC00nXB1Atj?=
 =?us-ascii?Q?EXP+V4EqWWjw1aWTbOuVNivxP7nrPjvcIZWlujbALHsOuhgeqrF91HwIncpB?=
 =?us-ascii?Q?aHuY1rK+pQTziqgd+7OKqVX4JwsYqHwMuMIUqW8UQmGKMeRI/SSimwjfbSUp?=
 =?us-ascii?Q?Ktg51MuJ1I3IXeXjYt8KdHYS6TlJo+N/655enkL1ejGNNIHoobjWAX5b3gRO?=
 =?us-ascii?Q?Oy90vt/FWKURNheWcCYWg9nGq++RWmdCfHbvYdnpPaT2MHJvC7Sx2abDFjDL?=
 =?us-ascii?Q?KWTx/ibpsYM0DcVwC7A9rReSUWQMVlTcJvvaREvQYc6CtLOP4ebMExAIUavu?=
 =?us-ascii?Q?2ZVGg0Vyie1Bq4/G6hiI23p0lpdWusw+V2NGe6gBiF8ByuGHqlyu8RWU+eaC?=
 =?us-ascii?Q?8eH7CrpPLN6lsfq1Jxul7Mffch3Y12DWCHJYWAl4p/LrL0n+f38QZUUUYyxg?=
 =?us-ascii?Q?6rwX8j5RQkgwqw7UY0j8ygJDLchc0oC81XJzq0YpcKSSalcWFeH5XhSPX4fu?=
 =?us-ascii?Q?IPl2ntL494VvVYiD9WFKhFs1ZnI7mqTDiBal2x9Ybhy81s5Qx8h5uaeNEOQG?=
 =?us-ascii?Q?faOS7lTS/FBl89cjcW47XDrU7Bs43NqXtUSyGhr4MiJa1xq4Oz1Wkp/bRrnS?=
 =?us-ascii?Q?bhPQiDKkl8ksXr2zTfXhhRitjHNzFYlcR6MM5ZgvRNaGFpd7n1dNtWx1p0PS?=
 =?us-ascii?Q?rGzLWxhsRp+1B3A0T1uxppBxdZeWhLg5+QC1AD9I2ibvLnOjDoJ90nwc6SaS?=
 =?us-ascii?Q?IZPdxySBBOGcm4D5P3bZu0F3I+h291RmqkxrvCTigYYHc+2dLqBebOvqJEWP?=
 =?us-ascii?Q?TOQtE9p/PRjCp4EhEwN1nUe3m3Yezc3OfhErBKjGHUN7HtQIVQ61IVEWp06C?=
 =?us-ascii?Q?3rYzA7dneEqEY7TwZG2J5BS+BVkcqjRoHws8NwLHh7VOnmkZqcrcE/yoPu60?=
 =?us-ascii?Q?Vw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?pMn+JoCkVmfvHckPgsF8qmBW9HKuXamxkw+5ynX3FLZOVACCbnfROyjoN0Ek?=
 =?us-ascii?Q?QJAWnRqWXpVUfj/o904WKq0pamBWlAAP5rL8ExwemsGixiTlt1NoHJSnba1z?=
 =?us-ascii?Q?ix1Yn/Czv67/7lf6JdxQsi6Y9zb/f1Zf3mfZF4Ht9eSxc6nP4KCk/JdLsr5H?=
 =?us-ascii?Q?pyppVRnB5anhew90FGBhRuX3TjfJF1oO2uuAEDqBCXKVHl8elw2uvD/qYy2/?=
 =?us-ascii?Q?s0K8TXCvJIfhkSg3eIWeXzc9xcl/cTzbfimYpjerYuc5SlPlbDu53odyuHQ2?=
 =?us-ascii?Q?jD/WhDcBWCb1QGXGEoAzz4T2iAjTaWmokiaegppaEiHu0zVnGGydRLqyAnQJ?=
 =?us-ascii?Q?6G1NcuRdAvwmgvhCs5i72pjpIU9RaVAzZwLBV8IMhn+QXWbl0tYqEBsKTB4C?=
 =?us-ascii?Q?MEBZ0+TM+i3urLu1baPK4VlkK7+sn6vUtaRhPr3cibc1UUtxsvdo3/JjY8GI?=
 =?us-ascii?Q?wh6G9QcsLD06iZD40oRjPpR21pc/NeMolf49UvY1Z8ODjR/HFfI7v2hiZCA/?=
 =?us-ascii?Q?cgqqa4nT3uZS5aJyIAVTYtTkuJz5afAedsQ4pQcjZ/I1BVC7fayQPxmTwN9u?=
 =?us-ascii?Q?pUAu2YNl5ZL57Q56WwE9ENdjQhIPackYCtaj5AepVpS+VgosN0sGD7EKE45B?=
 =?us-ascii?Q?BZC69kz+BDkMCmIvj3Az9kmwGHB2Mk6odrrUu6ohgA5q2i2ro6MmS913+KAR?=
 =?us-ascii?Q?nIfWN64/iE36XHuChg/O2nc72AZwU2OFgn4zWj/r6dL5r+/IMcnw17ynhPlo?=
 =?us-ascii?Q?HzzcgZ6m7QeRYHwrK9mTLYLIY1CSYwYNlHuXo2DmwxctIRVP8Twff5t0FhC6?=
 =?us-ascii?Q?LKB8SmvKxI/4lh89TnnnvBN3tFCdNy5TgcHDyBJYGeAv2Hi6OS5zyk3EJKAR?=
 =?us-ascii?Q?J8vJLRY3DqO/mioy1Uon6Ms0pOFfDZqSVfXNQPVGL9m1u1bMDhMn/GD8nb4/?=
 =?us-ascii?Q?hYNZ85tMN16ilBklxfT/jg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ced78437-c6e4-464f-5530-08db9d86137f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 11:52:18.2591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /jY6ltbML56MZxiOi98vSu6i3T0+/RmbzgEtkd7aCx1mlxOHH1GsOPq0qahARSMGDC8NpDN7GiARWAIrsml56A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4488
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-15_10,2023-08-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=993
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308150106
X-Proofpoint-ORIG-GUID: Mf38Qp5JQhOUyWY0G9HhmNj5m_5PkQFq
X-Proofpoint-GUID: Mf38Qp5JQhOUyWY0G9HhmNj5m_5PkQFq
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series tidies-up libsas a bit, including:
- delete structure(s) with only one member
- delete structure members which are only ever set
- delete structure members which are never set and code which relies on
  that member being set
  
This conflicts with the following series:
https://lore.kernel.org/linux-scsi/20230809132249.37948-1-yuehaibing@huawei.com/

Any conflict should be trivial to resolve.

Based on mkp-scsi staging at a18e81d17a7e ("scsi: ufs: ufs-pci: Add support for QEMU")

This series is compile tested only.

Differences to v1:
- Add RB tags from Damien and Jason (thanks)
- Set cmd_iu->task_prio = 0 in sci_io_request_build_ssp_command_iu()
  (Damien)

John Garry (10):
  scsi: libsas: Delete sas_ha_struct.lldd_module
  scsi: libsas: Delete enum sas_class
  scsi: libsas: Delete enum sas_phy_type
  scsi: libsas: Delete struct scsi_core
  scsi: libsas: Delete sas_ssp_task.retry_count
  scsi: libsas: Delete sas_ssp_task.enable_first_burst
  scsi: libsas: Delete sas_ssp_task.task_prio
  scsi: libsas: Delete sas_ata_task.set_affil_pol
  scsi: libsas: Delete sas_ata_task.stp_affil_pol
  scsi: libsas: Delete sas_ata_task.retry_count

 drivers/scsi/aic94xx/aic94xx_hwi.c     |  4 +---
 drivers/scsi/aic94xx/aic94xx_init.c    |  7 +++----
 drivers/scsi/aic94xx/aic94xx_task.c    | 12 ++---------
 drivers/scsi/hisi_sas/hisi_sas_main.c  |  9 +++-----
 drivers/scsi/hisi_sas/hisi_sas_v1_hw.c |  9 ++------
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c |  3 +--
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c |  9 ++++----
 drivers/scsi/isci/host.h               |  2 +-
 drivers/scsi/isci/init.c               |  5 ++---
 drivers/scsi/isci/phy.c                |  2 --
 drivers/scsi/isci/request.c            |  2 +-
 drivers/scsi/libsas/sas_ata.c          |  9 ++++----
 drivers/scsi/libsas/sas_discover.c     |  8 +++----
 drivers/scsi/libsas/sas_expander.c     |  2 +-
 drivers/scsi/libsas/sas_host_smp.c     |  4 ++--
 drivers/scsi/libsas/sas_init.c         | 16 +++++++-------
 drivers/scsi/libsas/sas_internal.h     |  1 -
 drivers/scsi/libsas/sas_phy.c          |  8 +++----
 drivers/scsi/libsas/sas_port.c         |  8 +++----
 drivers/scsi/libsas/sas_scsi_host.c    | 15 +++++++------
 drivers/scsi/mvsas/mv_init.c           |  7 ++-----
 drivers/scsi/mvsas/mv_sas.c            |  9 ++------
 drivers/scsi/pm8001/pm8001_hwi.c       |  3 ---
 drivers/scsi/pm8001/pm8001_init.c      |  5 +----
 drivers/scsi/pm8001/pm80xx_hwi.c       |  3 ---
 include/scsi/libsas.h                  | 29 +-------------------------
 26 files changed, 59 insertions(+), 132 deletions(-)

-- 
2.31.1

