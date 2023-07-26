Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF4AF7627DF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 02:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbjGZAuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 20:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjGZAuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 20:50:20 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A86FD173B;
        Tue, 25 Jul 2023 17:50:19 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36PJIpvD028641;
        Wed, 26 Jul 2023 00:50:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=VW4IbVp6ceKI6Kk088oBWDdofKnC7ye6zLkMH1QGYYQ=;
 b=CJvP2lE9qX6EdhcA1uyc6LicQPWODsvl/j25gikqAczLgOoNyy9bOPPRAvJNoayBgmEQ
 Bf2iFgRz580b7u+yxY05j/lio9AkXDlp+qBa/+7Ou/OFmlUN6PLZUu0iegnzK3ZkOUKv
 NiZQpbEuLdAL9WbNbz2Rb+P40D4mA+LXZVZpnrFAnTAsPAtXjyah7sj1qky415IVrhvp
 JjfM60gePbbXrLnI8WURP4hsZ/13gsJm0ULd9CdDabWWanCM7uRzqtLcoDGGW3JBtWVz
 R1iXxFt1IH1bMU2iQdW9/QHuu1LuTKW+e1B4wbemxP78BZR2SKQtB0+i/3tzZK+rBDBf 2A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s06qtxb8u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jul 2023 00:50:08 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36Q0jPG0029450;
        Wed, 26 Jul 2023 00:50:07 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j5h56t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jul 2023 00:50:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nPjV0+onbtOMlQwiMXPbI1f5sVNX7xgUWz9px/A15fc5e8aksy0fLM3d4mXhMQ7pBvR1y7nzOXarAckv0ZE9TXyoatTVjrjYIA/Ld1U62ufEu8liIuSGJfMOQ10VQBgVTPDGM8rnH3LTv+629B2+Vg1T1Xs3UWkDFPr3i9gS5yo554t5s1L8AK9yhOuFHghBT5r8Q/rqGQ0j/3KTqalHBVL2lu2lIxoxRcoKH2kGXnSk6ChjH1iMihOr5lSVAj8decLvuMVWeuDnktWV67vVBKXPSg1ZDTyzUSaVQuiqPhURXUJpfROX0ovGTZO6nPpFIxTqtO7aJ1TWDZiK0YRuSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VW4IbVp6ceKI6Kk088oBWDdofKnC7ye6zLkMH1QGYYQ=;
 b=isBY9PUIbaKIRXGChX+QZXW0Niyzmx+gJOnbaVjsFY4FWpEwvm/hgSWl2srXkvGKi+vQ/KOlFRgurnoZlQtd+xFi21BlDwPVCnJZqh32dIcojdp145Gsi7VpXJ6iV5In8rGIO/UEfBo7vhmUgLHP4nhCN5SKXWt/hdsu+k4EO3JsWYVrX3DAO4X/S6bzLxurwWjWIluiEk/8AOwDZtLc5JDrZCxu89/PBENa77Vvhe1FT6hVEK1/xq2hRiOKUm/LqbNgnps4E9kRdcTLwGoGRH+X5W64V1z/EmiaQ40bDkao1AjZKav8hAbSnkLC40z2KrVKVswXhPlPIKa8R0MlQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VW4IbVp6ceKI6Kk088oBWDdofKnC7ye6zLkMH1QGYYQ=;
 b=OeyJn0x7ziuZoIsDtBVe4hKk9l8W+IIjjOhI+15aC37boaZKIBWRdecr8O6x568B/qkCeGbpvRPikXSlSdfw+xU0UbrG/cnGcwp5O41/A2dBKNejDB6E4mg5ys8b7fjum3ek6jEWytBoYIkiSRtOAxSTK9rWNnwZXj88iV3IWbA=
Received: from CO1PR10MB4754.namprd10.prod.outlook.com (2603:10b6:303:91::24)
 by SJ0PR10MB5672.namprd10.prod.outlook.com (2603:10b6:a03:3ef::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 00:50:05 +0000
Received: from CO1PR10MB4754.namprd10.prod.outlook.com
 ([fe80::f82a:5d0:624d:9536]) by CO1PR10MB4754.namprd10.prod.outlook.com
 ([fe80::f82a:5d0:624d:9536%7]) with mapi id 15.20.6609.032; Wed, 26 Jul 2023
 00:50:05 +0000
To:     Jinyoung Choi <j-young.choi@samsung.com>
Cc:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
Subject: Re: [PATCH] block: cleanup bio_integrity_prep
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq15y671opk.fsf@ca-mkp.ca.oracle.com>
References: <CGME20230725051839epcms2p8e4d20ad6c51326ad032e8406f59d0aaa@epcms2p8>
        <20230725051839epcms2p8e4d20ad6c51326ad032e8406f59d0aaa@epcms2p8>
Date:   Tue, 25 Jul 2023 20:50:02 -0400
In-Reply-To: <20230725051839epcms2p8e4d20ad6c51326ad032e8406f59d0aaa@epcms2p8>
        (Jinyoung Choi's message of "Tue, 25 Jul 2023 14:18:39 +0900")
Content-Type: text/plain
X-ClientProxiedBy: SA1P222CA0030.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:22c::6) To CO1PR10MB4754.namprd10.prod.outlook.com
 (2603:10b6:303:91::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4754:EE_|SJ0PR10MB5672:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c06225c-fa45-44bf-2642-08db8d724056
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /2ZLwjpP4OmsKTYHMOP2dZPdCwTrQhsw8Umm4NyMz5T2vsAfpS8LgxJViGrkL9QvaiIdLBkchlWF1kHpywaLE5qeRiyGqV2WJszmhPjP93D+5i3P2CpSCdP4mCx76RHG+DlkVShM+AW9+7U26IxEPjYPZ/pVt8aQWX3DUMn0Olj3zJH/GZDPooNeGA1wfK4dgPVjyprZb649fAQiY+PyIwvk6PutQ6+mlitO2QOoyyiIIDAGAUA6DtEN2D0PDzosA6A/LoboPyj711b0o2xKRWL+E8axqmbKqCa0YbGp/ir3bl7P9OA0auXmEZQTobG6arDin4wfZ1unuzbc/NQhDFqijngfq4wEt62mXbZQRu3U9h3R3Cv33eCZlzvNzY5CqRSj3VnjyaK0HZhpwcqv6zIYG5CN3EQllfmGlnv9mfbipxhazA9ZEEdFxZgS2DVqKv6H2uBbOVdoA9UbOfv6PBn4LrqDfMe5Zig/z9cLIOMtUrpOR5xeD8q+9eki4NxsmI+Upsk2sClB5k7dO9HOz3+Ywn4YQEYYqQtPpahwdszNoh1VnpWH7zCrruiR/MIz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4754.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(396003)(346002)(366004)(39860400002)(451199021)(6486002)(6512007)(6666004)(36916002)(478600001)(86362001)(54906003)(6506007)(5660300002)(558084003)(8936002)(26005)(186003)(41300700001)(2906002)(107886003)(38100700002)(316002)(4326008)(6916009)(8676002)(66476007)(66946007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lC+kzeK+VcbDe3qdz39V2xYNNp9En+9CLctK3knIY+RxWdw/mscmLXjfDiGJ?=
 =?us-ascii?Q?6fXhQkEBDzqMOb6tyPmkCktoZQb8yV6UzfJ6KaHVIgSxZk4YKM4r6ntKJG/y?=
 =?us-ascii?Q?JUq9ItVNnYG164g9ovnhVDG+r0Jr0d8t5vxuiGmBReOrVNi146VC/a/9rPhX?=
 =?us-ascii?Q?1jj/cIdyA+IuScZAIrldBk4Bo3LU6Z3kmgdzQjIj7VN3kbdURLA1Bwjug1tK?=
 =?us-ascii?Q?s2qWmgu8g3IKzt7rWj5TlrR0zB8ewq4zJuRZKNtigL2VeoGR1AJCiTePWlfC?=
 =?us-ascii?Q?JliGk4YLXwvbqr70IpNw6Z7nyKLSVPPqTubFadk6Z293ggVSwHzzOnpuKYqQ?=
 =?us-ascii?Q?9Uaqua3SERoXp9+0AKoqi0sV802rOHlcCRGhHyBR/v2dW/iHb2DxqDzyuTEY?=
 =?us-ascii?Q?45xU/qKLWhnzoKkzxreCsrKjxgbVhLhJRnyYcdGmr6J3Ss+vymfdjg695ucO?=
 =?us-ascii?Q?EtMTbzHTn6twV9L5i5dUViDzkBZ5Z2wJEPGM4/sRnmtn1sR+Y2pDdMbhGXpM?=
 =?us-ascii?Q?tZn1wsiwhsQ80ekBhLwoVsPEj25pDRwaN+duHIEIVIepdiNCGNUezl4mDCN0?=
 =?us-ascii?Q?SckYMu5HNODT9QYhkmNvHEQHSutPmH1XOzdqYRP6AKNLMWXrNUC+fluW988/?=
 =?us-ascii?Q?6eFwLQ5xaNsSAvD5ruIm1d4KdOBkGCcJxQ+Zb1+pdWPYsP3SvcP/OkYmjQHt?=
 =?us-ascii?Q?gLR2NbIhixKUcC8LcOpR8fR0+FjLpCfh5MXGXLbf3R3hKkswa8klIbUYUxTs?=
 =?us-ascii?Q?vR09ncFOT8iW3kq6QXMC+tov8rBmfhABHpzfWD+uYvyGhlyqHwJA+kCuBMIS?=
 =?us-ascii?Q?4OYnLY5U2IF2wHDJhZlmbbWbZ6ZT6+ME9XcK7V1FdVd02wo78b1JypseCiZs?=
 =?us-ascii?Q?Boq7LVgWZLifn6uABZPDd+VR6kFoNijqVn4ngVTfw/LYNfWD1W5hExKb5znQ?=
 =?us-ascii?Q?khZt7Nsl+DvKVWDyoHhvZtphuQP8GdpPTc9dZZimU1ltUi3W/NcUWoTD5D/o?=
 =?us-ascii?Q?0CF9alT7FWOwaFKQMi5vdtpmNHZm4UIZI7slnstsVstSw9jpGGcqRvr8+zjA?=
 =?us-ascii?Q?HiQc+r06ZpMlhRz/jVvAU3he2g0q/ll/Fku9m77xHbciFMUDA8sz9N+MEskj?=
 =?us-ascii?Q?1PV07EEyzPVz9d265pbhlMUPYacgJU4Lq1fjTlEHXguPZrt8R7TQ1SFzAwmQ?=
 =?us-ascii?Q?D34+ijpt/ywUR1RewbN/RG9ac7UI3ejCBcsT74g3DfU6oNXXOcEeixUR0hgD?=
 =?us-ascii?Q?PbkkAUgazWd7nondIobho3dwuzove4Mfad813t2PxwpKgK11F11Dcw5ahzDX?=
 =?us-ascii?Q?pmf4eRStykKAj/Xw/lKXhdpxPq+7ylCFvyRjbblLBlBRIIa8tSypdS7n7n9N?=
 =?us-ascii?Q?zg89iW9E2McFsdzqD0wwUkfz1/v0YVdlOiuYGtIXCXe5d/2J9GCDcd4Flrn6?=
 =?us-ascii?Q?Yr7lj7XCSPq9axDZJvopwtNRyeXJM+yeATDFQ08XKo5Q6hG5RQEv5fD28XqB?=
 =?us-ascii?Q?DGvDl7kcN0mkkPDwl4vL6t5wiEt0vcxZi0MJi7awAaOqq7PGpEEtq4ee6vr+?=
 =?us-ascii?Q?VeKSTQWt6ddp9JVfMJfxoTLNdhzVvdVZjRYB7wrOA7+M+I59VgnUixkOv0VV?=
 =?us-ascii?Q?sQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: qZyd0V95/jBSh1pOiShUvlV5LgzaL2vUIvf7Vpe9ayljtaASaFhHlamhB3lJuKa6WjBkbGDdlPcSSKmF3r6Xsspk3DyDxBXAnMk9ocGmLXpWq/cRNueBzUy98jpneeqD1OfXwDXeptSLKJLJqbXeaiA3I75r0jXoz4C/dvJL7/IuYllYCOHJy02zzDURMi+EX1a2nnwPM30WggeFEHO5E7jm+d/97y1XRDnwFFrdHyrgx95kK5ynyj+QmHUo5A8+tzUKo0oC9/mkVVmaHRqiPKwBDDGPsVaHgo03V3XR6V+iffcNmH+ppKBwYBiPecIiCgtiB2zM69xz0hbQM3VY1/b40KUfoU1LPgUt+DCtb3bRceTRWOJkDgkw8ee71L7E5jZXNjggZ34oZcFGqjja02cpZE5gUPkE7BvdA3r6JYhK9yJoaoU9zYkPie3M2lntxKZlBYVgE2pefYTCIyRoV00yOMmozO4LSsNJjjksdxrQiGW0WDWvO2DOvIr/jI7f8XscgjPf9MmGAfFDz+NDNTkfraLOXHzp9JfcPsLaXty4+1aAv34FeJdJ+0XiWcDtgUaPTcWiqzW5ucNxw8XwD7tBQjiqPe08WZ19DrjS7fDBLbxB6iEUbVVqTSUT/I/B8lkDOerYSIF3jimxhhdd0gnTEF+VHH5BeNqFboHwtnC75H16vLcvyPqwPgnmbFs1EDTp8Ime+p4Iwa+Ihp7Y6CoFzhekyufu13THN0p7BrEODojBU9+MYnPCYrq5Z0reZl/xE9oNUPopSlKG+m6+iHO7a7YNLzFEA95Ewq/hitihtLD6HOFcrxsRyclFvfeoIJLtpeH+MTqb0CXhPqTl7Q==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c06225c-fa45-44bf-2642-08db8d724056
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4754.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 00:50:04.9365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qnzqPVpbHHvp5LAdSXyxxedS1iwxf32FnVbsFfACEX+EBRFnP+9NiSo7Ra6TVH7aohXr1mNQJbLXr+E98c14LDYIDjnSPZote+tDE1DMeNE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5672
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_14,2023-07-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 phishscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307260006
X-Proofpoint-ORIG-GUID: H_VzcSvXscoVeOUqXv3qnGGEK3adLZMg
X-Proofpoint-GUID: H_VzcSvXscoVeOUqXv3qnGGEK3adLZMg
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Jinyoung,

> If a problem occurs in the process of creating an integrity payload,
> the status of bio is always BLK_STS_RESOURCE.

Looks fine.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
