Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D4D7EC450
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 15:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344085AbjKOOEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 09:04:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbjKOOE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 09:04:29 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6CEB3;
        Wed, 15 Nov 2023 06:04:25 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AFDXo3G018031;
        Wed, 15 Nov 2023 14:04:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=Yv2ln5eiDA5qUdEVtCQjLwSezGYjsJspiaAOeq8XIPU=;
 b=fnOu92fgHrIvWfDANHcd1OCZFZOJ30hz7BzULpYaNtO7buLZdsdMowxDNH13GhlfrPFS
 FgyloG7QXE+tCMoVlPyhvjzuXEi+ncBbgS8KmL+Yp5vM/lRE30+N3z+pRjUzjuFSP3D/
 FE8pu6e5wGboPDV68yZfjWcHJupAJD/BQckm4vtjeGY3OTm7xo9SCBhP6LprXFYBSRsd
 foDyThS270HBcDPURmRE8c7hhu+xmVU4+g9BPudZXP17ho5WpkLAlIhmpEj+dUeRUSDk
 d9Q99QomZIJeTZNwLOfKvnmXPXDIW2rVPKUycjZHLrKly7bfqGPIVWjJvLzKtsjSlt4r ew== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2n3gg1n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Nov 2023 14:04:22 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AFCeBNj013175;
        Wed, 15 Nov 2023 14:04:22 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uaxq13pq9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Nov 2023 14:04:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IiWyX5bD2XOR3jwqTugBXZD5H0NL/UFCzlTeuh6Z1iklPaxbkU2VjU4dNnarJ2lpvQiCvFg3n4iJlt9dby0uaDKoh4XNNtunNhnLEOtClbYRok6HIuEN5OHtY7HliWOJu/JCwzJbGqlaGV9isafI9pDxDTJlqVbc6z7SHJbGSMmxkcXlCnz5M0m1HSDOpKc/M0J7R+ok/IolEpOaFXTj/uuzOqQs1p1mntP/7pII0BH3+Tp/t3clp1PU2KLj//xAuTQ2w8Os7a5bXB7Y623r79UbgkMZR21HdEKOoYpcVQ+e6uo9gfVa5qa/WoZ892nBan1djSw4X4UKTXrIA2LL3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yv2ln5eiDA5qUdEVtCQjLwSezGYjsJspiaAOeq8XIPU=;
 b=lgkv7LXuxjbRcy59FAHgbufMtZ9JxXnJF5Pxas5eYCefSAxXPeEUwVtwJhW1eKLlRF20CfwY+T4e85u83Pa2xeq1FtWrEoVN/69xaB95SU1rVnqFCACxCH693Jrvb/8VguOEJ9NG09VnPA3dZFRgFRF6hdmvyJfNOAS1mZoC1Ljkicb8AtmIY3q7y4yf+5/4fb3CrCdB4H9hmnUkPblsqG72j5u/FqhpABLF7xr16pDkMBciiQAP2xoaD5IAEY2vFEcyqws29wr8TjVlyCJxLQneHYzefgt9HZzaJ1FPgm44rcpsjYfeRHrDDw6TqKvMPFZjaYc9joDdB/llP3NuGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yv2ln5eiDA5qUdEVtCQjLwSezGYjsJspiaAOeq8XIPU=;
 b=i8hwruLFXfAqxj5BLYoOt0kQS5iBukqFWyNaTJ0FI2dyePWc2A61tlMibf0w/da/WqMcKxozzQ18iun7Nsxme7uW8qSoZw9gimqAXjyIbNt1MleZsens4b+5IZiA6w8fuKmKcFxvBgtR8cfL3ABggUr/jl2w0fEmhIcpC0Y+co4=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH8PR10MB6388.namprd10.prod.outlook.com (2603:10b6:510:1c3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.32; Wed, 15 Nov
 2023 14:04:15 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::abe0:e274:435c:5660]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::abe0:e274:435c:5660%4]) with mapi id 15.20.6977.018; Wed, 15 Nov 2023
 14:04:14 +0000
To:     Justin Stitt <justinstitt@google.com>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] scsi: ch: replace deprecated strncpy with strscpy
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq17cmj2jvu.fsf@ca-mkp.ca.oracle.com>
References: <20231023-strncpy-drivers-scsi-ch-c-v1-1-dc67ba8075a3@google.com>
Date:   Wed, 15 Nov 2023 09:04:12 -0500
In-Reply-To: <20231023-strncpy-drivers-scsi-ch-c-v1-1-dc67ba8075a3@google.com>
        (Justin Stitt's message of "Mon, 23 Oct 2023 20:20:14 +0000")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0284.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::19) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|PH8PR10MB6388:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a35d2db-201c-450c-b41a-08dbe5e3c016
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7bwfNDZxbRk7e4nliJln0O1icaTGc6tSi+l2k7lGz61+qB+amwmr+oM6tIBKKgoVJlFd8tKGn3Ksn4G/LGiLtGLVl05k9QhnayLhDTxyQCshpKvJ3OWLAJQr7Bklk1p1MDy7ZNT7zIOg0qpIu39D7ZINEZvwdXAzZG4U/dyh0Qpv/oTz1hhxGaKT9cTjceEgCghaN6+0dsqJJ92HbtY96J75EAZlgro3MJdcSTf5sH3M54isEKGRj1mMN2op7gDJO8AeINsguuOLxsZ5e/9n0AHm4n7eQ7DfXW6jNLIDyfNEeD0WWau7/l8W8BbIgProvM/I2pBfRUy+2JtCRMqfXKIcfvi7QwOUN94jJhObGrDUD4r0q1RBoYU5brJTla+VQlM9/j0W1Rgh4OX42UOLiij9ABIcoNr/H0MbaE8ZKtkk08p/Fhf5l6cE/QSldwQj2Oi0RvSsBusvBHn0BtEbVTzvat/+M64He/43CEVMnM8LkbfMmGgefzEtv0rmEXTlJlpSWnW750+Msjveqlh/uIw9M5WGl02okTja6SbqiDN9NLb0AkKlsO9qWlIWD15yOG/7I7kDLEcP+KrcwvKOg47yModusKhnVt7V+SjF8PeSjtLCvzkgOjDVigWlwEEm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(376002)(346002)(39860400002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(66556008)(66476007)(6916009)(66946007)(86362001)(38100700002)(54906003)(558084003)(6512007)(26005)(6506007)(36916002)(2906002)(478600001)(316002)(6486002)(5660300002)(4326008)(8936002)(41300700001)(8676002)(156123004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2trx1vW4kZ4cKy5c75LRXEZNcIeG2LEkHDJ60T6pDVQ8xgbOtiy/dFlsATKv?=
 =?us-ascii?Q?w72VaOO2n4XjSWuoQGYwU2BCayuAMxR47h9f4GXGR49BCG0NI2tOeOLIRiEX?=
 =?us-ascii?Q?bXQw520UnQYNgUEjoWkCFU7BJ4TH2S/GNPk9jL4qqvID3oZTgKMPirFxPbQ2?=
 =?us-ascii?Q?WY/UV90wK6cDWFN6b84ie+/SnTJuFeopqMBqjkl7KDekRE8bqqQqoSCOSY63?=
 =?us-ascii?Q?2vKtGczzusFO5AD3WSDTfU91c0FDJ8r00E7JXXZ+9tf4CLBrDdO9tkP0X1UH?=
 =?us-ascii?Q?/vZYU04ajq6ncCe9ESPxMQwKL/dAZP/7kgTu7lDCgQtyz0BTj8sj4GINDnM/?=
 =?us-ascii?Q?y1P4lXf7XRoFygM6+eXxX2BhVDMfePafHUaQK4j0zbMI0Ls/vZgZtQIZhdT+?=
 =?us-ascii?Q?/fdWzl12vktuCodCgQqg/1vY3IO8Hi5jBGJqSGer2HoqRvHW3GSHYHX8/Byg?=
 =?us-ascii?Q?DYpBMTyva/CClhmuSJunDMdTbFAd+fKDHxRXGpqLNISDQAZ6qzPFPlw5ifHa?=
 =?us-ascii?Q?CYgeVbEcXaYbwOaW3QzEbdpezM75wSU+zGYoMI572NJ35b6SgkCCkzVDmlfT?=
 =?us-ascii?Q?MywVHAeMYK6JFH4VZGHopXK8ESDRerixCzK9Ccy1Wjy9bYQVQiBMjEnH6uAi?=
 =?us-ascii?Q?f/p8PIYmOivgt9p69RJWEbuHg8fnC8PZyw6MRCmusS2Zet3MLxJSv/GX+ckJ?=
 =?us-ascii?Q?HD/L1/bz8ej/HnuYclMlkRyRcC1fUl+cY/4PAJ9egm3iAk7+cF3VuUjw5E1y?=
 =?us-ascii?Q?dx09GRmf9QFYmW9S1DWynqtORghMJfVQqbchVwXGguVjlfdwS20mmKv7+dHV?=
 =?us-ascii?Q?iTaFKEd8wvveMO+8o7fMyniDQpe0WYjbTmAlaGhkVHT8mnwlu5Z3r6vfMU/D?=
 =?us-ascii?Q?E3hyLbilmuDgOmmkOOIsyLLTw7UQPnwYUUo0TZ9asHVxTaxn0duQXssviWJq?=
 =?us-ascii?Q?98Wgi+0UCVjWKvwG6Cwx1NH2LcvIoPXXjyMLLy34mpaxrg8ddfgbEA4YEdNq?=
 =?us-ascii?Q?X22MwPILK17ZK0L2wB0eR410MPmcWiPTPLnh2JgzfhZYraoAVqQYev0imCAN?=
 =?us-ascii?Q?0IJ9yxNr3esCskBGFkecMzYGy6Ur8Ja29zy4OzaACC6FG+lbCnIxHfgalb6o?=
 =?us-ascii?Q?beX9ow/1/YQL2kKj42BAD9OwQOgCXUiQ7JTyTxBfOoEQsQ++o5XxnSvm6bl7?=
 =?us-ascii?Q?lMlevTI9g1VnI0PIJDx68DEml401jerMWsart15PTHdPLeTetc/wX6izyPnZ?=
 =?us-ascii?Q?2YW1s4RGTkMC/kvG6f75QaZNWchH1NgMSG3C4NbTJj/xvCimh+WafTXComgZ?=
 =?us-ascii?Q?+50cDi4zRt8CsaYNAcEesa2ESuDMdfaB/VdsWJOW9lw0MYQILtkygNG/aELe?=
 =?us-ascii?Q?qkEQ1geliJw1znu5uwT8/cZYViVKpXuR5aAAoHtvon26R1LT5ApqJslSv5rS?=
 =?us-ascii?Q?F7wfpewOnjevC5gcteACIPghzlq9I1XHWjv50F2cBMhSzLh76M9sPKFNQAE2?=
 =?us-ascii?Q?CY9IzJiHNPEiKh7CsntdQ58y2EV21jbh+U7bfdwV2nLaTrffKxFB48YxJHkn?=
 =?us-ascii?Q?OyZ4/Qpkic8c+6TULliPPvBOr6BGBOioOxzPwh70untUQATGulGTFUuYbLZL?=
 =?us-ascii?Q?Mg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: BckRIT0c2/Ocs3glFyTnZdvnumS2a0Kmft8LRWT22TxZwhuNSxmwnDoe35BbblEJWk/UKGGM/ZCMU36d0OZ3cg62Ri/wVhfrxkuBIoB4SBM5Ie9vjar3DTytLKGMoY+IJPHNb7MwLIXIhDDu+DlFaZHjcVrOOlOVCuBOJ8UzT9W9ouyjOyprI2ky6QQeSV0hZnEQ6bjbm2qFO7o4wbGxBkm2+0EaheM5wIca9mY0NBLur+Uz1O2+aXLFF2xf2+djCOMkxiYG0RtwdevX2NcyhrORcCmzA2PR5txuhEkMWs2q6fj4Xef26gKjDuFZbe5AjsRBhBIDCSBYTl4LtoRMWZDhSV1OC3TYk5XjQMXQSD9XqxSXYE4Z4ER9AGWN4KErJNU3bvHZX1n1EA5R2p5KSDnPwCLrGbiWmbe32UdPINEXMRh70Yq491nt/Cf7JmYffGlaLJr/wBt11kG4e0e+DPLYaFmsmYUpgq5UnG0Ze1TMW6P8zb/ZbbKRbkisJg7W4GuVhgw8H1LuqkIIw9L4ixpWuPF4soZ3s3R3qEWVe7cexxXzmDrjsDYw30R5ex94y1gAFyQGsCWDtth7ZY4tgfRexDu17CoNQOyC55HPk4+k8SkKZSptkeGLA4UxAj+5CkPYnnPiulV2wrrOrPzIMn5qkTXPFX+ixV0xo6jCmcJ31jiau+y1kEsh1jdUTKGUmeZha4wQ3PzjIlbCP+72y40x7UI47sOzj04+xvXlmC35el3t9kAQx1DuoTRwLF5qKduFhNwnkBUERv0T6Z47osxhGaiyxsrEPOANM4Ec2fNQvfQyE8Q3yPffxyAO1ZB/JOsTH4OQA/8mGqaTTqk7JA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a35d2db-201c-450c-b41a-08dbe5e3c016
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 14:04:14.7102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mo31faIiROvEvdCU4V1jHI/H+XbxsUEuPKjLOUFZRvKpMOvFRyedKPzMO8hFuV8kK8YP3EqdHJ+TjYFtr8/72mMJ1xXx8/UXoWn8BRKW/P4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6388
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-15_13,2023-11-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 bulkscore=0
 phishscore=0 suspectscore=0 mlxlogscore=819 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311150109
X-Proofpoint-GUID: 9g80wyZ48bELw-I4rD5EVynGr1_lEccS
X-Proofpoint-ORIG-GUID: 9g80wyZ48bELw-I4rD5EVynGr1_lEccS
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Justin,

> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.

Applied to 6.8/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
