Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFDF377CC24
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 13:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237003AbjHOLxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 07:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236910AbjHOLwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 07:52:54 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7100B199B;
        Tue, 15 Aug 2023 04:52:52 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37FBGvto021641;
        Tue, 15 Aug 2023 11:52:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=ykPB68bYYMAcPh3Hv4PYv7nXPX20eqlID0e4oK1Bp5E=;
 b=keduJAN/CdNgIA37LgelVq5Hw0CDm8NSak6DK55Jme10hAtPmsAsRz+I+IuGrUl8gxG1
 aLZv1bG8PWB0k8Q7Ggseq8rQbz/znq2XEXhXDit0CuMjbSKnJjoj8F9pQcnNwYq6yv6N
 m7bT/uyMCOf8vuMEsQ73v5BsB/E186xXk7BFuGBAiuJ/BmJPg3lQcb2PscHQAEd4UgD1
 F/RXGpIkJ/FRGMNw0uqaIYQ5nOhWzYirG9Sa4PrDmx8OSgeBIg5pBDrz5wNLvu3MkpVs
 eIJajlM0efjeN87hVUYvlZ1uw5f8fX6OI/x6nIcviVQj5PvZBw0Anzbo4f+hIHw8wxQf 9Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se2yfmg4c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Aug 2023 11:52:35 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37F9LOGC040286;
        Tue, 15 Aug 2023 11:52:34 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sey0qquxr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Aug 2023 11:52:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BJNCq4FPPY7uUs6NugVkNOE+A/wFGGw8kxQ9o3C+2+cETplUWEOJ1gHl+s7jDQ4zupFpOJl/SVJcn7zfdDpnoC9c+dOMuNV/dPFMnTZ7MVySGldTorhzmVrO8j6T6PfqXENZwwPjQWXXC3uqI++0in/RyZ9yM60ecfy7OQXYXDZ+t/HzvaD3iAaqEMoAwHxMsuiMAirUBYEHiKUNJZpI6Tb8coFDFS3Eap0ad+a20hO2zRRh/C/QUXgcu2/lcX+tChs30cgZzQ7mrG5UWDgZgImQCE1CKUxrg2+u6lfqEDdSKlcWTYCZsV13+vizPuiHNCLv1hon0gtq9zASOlmj3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ykPB68bYYMAcPh3Hv4PYv7nXPX20eqlID0e4oK1Bp5E=;
 b=hakm8AcsRThQciXinGYAfLMREW+hyZcnsvZ1alq2J0gRMSQRE6zJZeRWaZNGXlmJ1U9fRV3y2d7bXzD5RAock1gNoh0LwbsmCLDSaFNSpIALPf11MnEMGB9uZ7WCx0SMUc86nUKysJZIWGdESIueo9oZClkUADATnriTsXIs1Oskaa0EJ6NlAQyY7WLywZCQdu5Ee77zIBGEGUcjCENI8QygzB02VFntByhJpSNnpGkbljzPOUKZYtV3GGwWJ+paCw7QpArXS3MEzeiPNuMdmjJOTfvE3WyauPVUS4DeLuC0E5qGZG7kbz81nCvpiV45iBFKyRUdj4eDhGvymed96g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ykPB68bYYMAcPh3Hv4PYv7nXPX20eqlID0e4oK1Bp5E=;
 b=r/DrSL7dxvN6EguOXlUB50m7GXAWnZjVasjQQv2/qmxQAwQ6VJgR8Bz6ySXfHOZuuwJqhg5Wew9SKx3dsniwLtn0FGMZzWikCYNrK3YsiDeZGxxzLHVcz7ltmu5SlBnOovo/V4bGq6BmoIl++Sv/baMdBeSLCMHM5XPmJPqap+4=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA1PR10MB6710.namprd10.prod.outlook.com (2603:10b6:208:419::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Tue, 15 Aug
 2023 11:52:32 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%7]) with mapi id 15.20.6678.022; Tue, 15 Aug 2023
 11:52:32 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        chenxiang66@hisilicon.com, artur.paszkiewicz@intel.com,
        yanaijie@huawei.com, jinpu.wang@cloud.ionos.com, dlemoal@kernel.org
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 08/10] scsi: libsas: Delete sas_ata_task.set_affil_pol
Date:   Tue, 15 Aug 2023 11:51:54 +0000
Message-Id: <20230815115156.343535-9-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230815115156.343535-1-john.g.garry@oracle.com>
References: <20230815115156.343535-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0125.namprd11.prod.outlook.com
 (2603:10b6:806:131::10) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA1PR10MB6710:EE_
X-MS-Office365-Filtering-Correlation-Id: 7747baa4-4131-465e-1763-08db9d861be3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J8OX6/d2/G+Ym8Ai0RJeoYgyyrUyfRumoRESK6F1xGpCHtx2DoSnF3pCkaNbqLAS00c/SXPsTCf/UeMNYNlBnodOI9osPQwDAGnwbJTqyb/8ww+8dG4X4O9mmXmMfmBR6s5ve5N2GqCdfdmQYZrmRRifoVu+7W+jiYG0HzWmM8hZ2XZUOtmIEjl9+imi42s18kjbIuGRGXa88By74rWDKfq/+I1Ar2gpx9S7gxcwlYT//D7fMd5BO1fRWbLDHDe8t9NsS98n/we73DHBrXn8UdE+OKN+6M3q5MscnLorBAvsk0u+WYGkMHdjs6YL1TqCMUADPqCmtzPo/qRoihYriCJL5VDuk/ZNl4jWZn5lH+a6eU39UwI++gXyCqtnptp47x8onMBdJV+aUstP7lc/r9vyk8hmGa4tt2+KtQrrrXc+rRBNUjcwffXjyUYJlBKOZcmiGuhNPlXjHTpxLEFjN9tvSlSlRO4pPrCplLSjZllBTLoMGPLpzNBCFjhlPaOJZeiBdZ7ymnG5Bnh2lEiSdmXhSphMZnYGCC5ruCNakeQ7iUYBBFiMxqaCIbyjb3VT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230030)(366004)(346002)(396003)(376002)(39860400002)(136003)(1800799009)(186009)(451199023)(38100700002)(41300700001)(107886003)(6512007)(2616005)(5660300002)(103116003)(2906002)(36756003)(4326008)(316002)(66946007)(66476007)(6666004)(83380400001)(478600001)(8936002)(66556008)(26005)(1076003)(86362001)(8676002)(6486002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FZyLOQ4OEHI9hp7PnU82S6oDf+jTXdmKmmTGcd2FYyUFoCrsJqfUjAgoXXvC?=
 =?us-ascii?Q?5kOP91xdd7S0GHuaJpNSgwj+43ySgu9D6c5uOZHX/LGX2A06g3mX9VMEIOp7?=
 =?us-ascii?Q?jcsBYD2NaL3qpHYX/XQ0jvYNYfV7pIrZdXQb85llfRFt8BXq6qDmNsdpWta5?=
 =?us-ascii?Q?Qmj/IWUIbwI56R7LAUTmeM8gob+ZLdfyP3Lq86wYw/GYBR/E78OauH5i/ADy?=
 =?us-ascii?Q?pEDDxihLSENdWNjpTWs5fg3jhq+xm9vlRHbofo0SUvmNUcZ4XuZVjm8NYw12?=
 =?us-ascii?Q?h11fddutDf5fqtYLyr3TvOv92yATg9T2u3rrsCadANy0RvOJYVKwALfYwcWN?=
 =?us-ascii?Q?hF5muaZKkXVdZlxLgXddE8w+Dr/xwePc7kuU19Jy+71waAbl7G7fH6ef1//k?=
 =?us-ascii?Q?V8v10MvRRrrWlC5vlOpGbHZwGeZzhYMOY3UMxnc4s338nw4a0tMCjGdAwxvy?=
 =?us-ascii?Q?qFNkwoz+ZUkCKE4OzC6fsicr7gnbWTM+J4Ts0fkleeHD4Yi9CfRvhKY83os2?=
 =?us-ascii?Q?C0w6nl3Vd6+dFfwSAYxB24GlTSnS9nadi+pDOoA6h1kXgAhRPK9vA6xUGmFA?=
 =?us-ascii?Q?gPZ0QxkMbnFA/qXRhCx0/TRobe0IiT3FuG4O2x5kfQNZ7Vwp08EW1FECz9JS?=
 =?us-ascii?Q?53PMdi3EodXegFHL3Vd/XpwRuUo44h9FLviOG4TS81jcpC1d6dPgJGTwkYxc?=
 =?us-ascii?Q?r0WoUfqtRrexJwIVMJ2I6nli72b3kqwHt6KvPnSdDONpnNQt10awKyhqXky6?=
 =?us-ascii?Q?9oJQ6MvIojYPerD4G6BzaZcVR2MzjniC0bO2m31e3b30domlqk73DktIavnz?=
 =?us-ascii?Q?s8tVPqLuUcUUsb9MkuAGebXYUTENwe7gXlRrZxLTUo4rLbeevcKieoXmaqDE?=
 =?us-ascii?Q?S/fYH+U05m6R8tkJ77LSQzVuzBgGAYBlpmHFVcZffNghtnUE/IzBBEt/pxor?=
 =?us-ascii?Q?VBF2Nhr3PObSJC34pg1TfZstFy8UcNyrgG/vx3/ncB0Ncu+J71lfL/BN+PE4?=
 =?us-ascii?Q?q3Pdxqs1gK8LD5Cdo/CgAb1qzi15jKbAPOaFsLw+CBscVDexFY/rVATyHVC6?=
 =?us-ascii?Q?P0GC3W4Zy4kfyGJbtXCsrgaMCF5egxB8x/YlmDcUdnEwjKaM2W2JDlOfSORE?=
 =?us-ascii?Q?vZ7tOY3TNnKAS2KzRpGGmgmE3zZ6gqKRqtQUz3Ntj187T3MpmwEdedmgqsET?=
 =?us-ascii?Q?80z3MF0iVhNK1dGUqsdeNgcFHwZkYpghnBF1E4ov22Q2QiGhksEFiZhSu/yf?=
 =?us-ascii?Q?udifFb1DL7ipmC/OGmg2gJ6j6f+debYDIG0B8FTx+JzaqUethkey/vsSP+n6?=
 =?us-ascii?Q?ierrxG+Wc1+wqiRN+SGRnLEGNAXJqVj9vLeKC0w0vKEwqRZAhL2BwatDegW3?=
 =?us-ascii?Q?eMpiS68brFtBHY36YPOeJaQ78QHULwHk1q/FGRMLjBIXouuBGaaveiYTmeAo?=
 =?us-ascii?Q?CcxbCX2jXEeHZHTUXrg8Lr6PlXkF2lz9WIfLgkGpWEefgKQ0ZYHpK9V2ITkG?=
 =?us-ascii?Q?KafbMzehkKiesy1VWB2U+2fXulEbBLe60QDygSAW5Hru2mCY9dlP9qWyhsQj?=
 =?us-ascii?Q?cciL+buuIFBMdYklcIVUhaSqQoYU0T/X+Y423xYjh9FKxw5HrN5bNQ6giFO/?=
 =?us-ascii?Q?MQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?T2JKUwmJSqUwvh/amQI52tCVDRjwy7FU/mi7JFKZjMQXU6g9JG+XcWgEemz/?=
 =?us-ascii?Q?MhL6xde4VKzyHw9DLSN5AUyfX0OiKFQr4iM/IDYyxSyYXUODhZElK4RC+ij9?=
 =?us-ascii?Q?ms3755C+EVrcxQYtckAetXIQCv5XB9UXeEANC1riU0LssRvfeOzyYQRpYIP4?=
 =?us-ascii?Q?6rj2VUKWCoby7Zr//Ntfz4qJMP5Uu6/UlBxv/ZOIAJ912qWF89i8+4oRPF63?=
 =?us-ascii?Q?bArsxTFkPpfmDttsGMuxiEyZ4snEychKjz4TxPz1rBNF8IVFrjRZv5AYmLpT?=
 =?us-ascii?Q?mzPRYJ+GFP+kSTE2/JZSB7y6OaemzArFIhr7az2aGYy4Zqsw+ucO7GNDHRy9?=
 =?us-ascii?Q?3nJntfmyCqSejse94Uqe7CYi4KYl/GupQJoketDqBsIkMbxdDdi2nQOEahQO?=
 =?us-ascii?Q?U1qTOgt4RIezfekeKCD2mQtoWS/schVHSeXH2SfdU23uu+LXkCANo7RCJOl4?=
 =?us-ascii?Q?7/7WEvkrJZy9UP4QEFvbnFy1nuQnRUx1EU3366XkT8WgqnOBdIpBH4mW0g5J?=
 =?us-ascii?Q?gJNf5Gsghu/U2x3evYE4/cM5gj4FqNHfumJyNy0iU1BF95phIUns5Po2r9GQ?=
 =?us-ascii?Q?GygV+eggzj0NKF4wHjZYcPrZ/uw1MYb0Qsx8iclxq89sczanTahX5AzNPGuj?=
 =?us-ascii?Q?g4O9jmgzcj5HZ1t19RGQSZ6MhlsvmIbHr40ft6BHQcQvCjyBOH1K3LE8ZbIE?=
 =?us-ascii?Q?fKoQx8WMsEDZiVcd95w8Z0hJDp3PDZMN5LTznrBRsZKAn+y0cycL9crYOee0?=
 =?us-ascii?Q?kaJuJPl+ntr+BE5VIlvDcjr4UH/bQ1tZjACXZARraDV1cBXJmgS9o/1q1Qnb?=
 =?us-ascii?Q?BiCvqsWMrX3SaVNx2IulC5pcIjr2Ttu8aH5/Bjn2kyVqrXJCUNGt4hWZVcqu?=
 =?us-ascii?Q?4GVBVPa7NB1/Ve5Pm5SCpgUurtPRxxVQPD/nkOZF/MINBgWvVoKCzb3TsQ5v?=
 =?us-ascii?Q?1rJoglPnWSz3dSORvgH6AA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7747baa4-4131-465e-1763-08db9d861be3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 11:52:32.3591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GS0xrmd+TFrPLlva8fGkRKPkUeHWJ/3hOt4esDfRfifqwBE/M1WcQh0HhTBo6CBSCAaLxdvx8fv/bFM8P0A8eA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6710
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-15_10,2023-08-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308150106
X-Proofpoint-ORIG-GUID: HP3fuyENS2vTaNpUN_3-CoeI_2ulvkxL
X-Proofpoint-GUID: HP3fuyENS2vTaNpUN_3-CoeI_2ulvkxL
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since libsas was introduced in commit 2908d778ab3e ("[SCSI] aic94xx: new
driver"), sas_ata_task.set_affil_pol is never set, so delete it and the
reference in asd_build_ata_ascb().

Signed-off-by: John Garry <john.g.garry@oracle.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/scsi/aic94xx/aic94xx_task.c | 7 +++----
 include/scsi/libsas.h               | 1 -
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/aic94xx/aic94xx_task.c b/drivers/scsi/aic94xx/aic94xx_task.c
index f67983e8b262..ca435811c310 100644
--- a/drivers/scsi/aic94xx/aic94xx_task.c
+++ b/drivers/scsi/aic94xx/aic94xx_task.c
@@ -390,11 +390,10 @@ static int asd_build_ata_ascb(struct asd_ascb *ascb, struct sas_task *task,
 
 		scb->ata_task.retry_count = task->ata_task.retry_count;
 
-		flags = 0;
-		if (task->ata_task.set_affil_pol)
-			flags |= SET_AFFIL_POLICY;
 		if (task->ata_task.stp_affil_pol)
-			flags |= STP_AFFIL_POLICY;
+			flags = STP_AFFIL_POLICY;
+		else
+			flags = 0;
 		scb->ata_task.flags = flags;
 	}
 	ascb->tasklet_complete = asd_task_tasklet_complete;
diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
index 5b2e6932c564..3a52094090a1 100644
--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -529,7 +529,6 @@ struct sas_ata_task {
 
 	u8     dma_xfer:1;	  /* PIO:0 or DMA:1 */
 	u8     use_ncq:1;
-	u8     set_affil_pol:1;
 	u8     stp_affil_pol:1;
 
 	u8     device_control_reg_update:1;
-- 
2.31.1

