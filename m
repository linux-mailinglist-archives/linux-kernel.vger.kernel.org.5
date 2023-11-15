Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B447C7EC62D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 15:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344233AbjKOOqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 09:46:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344118AbjKOOqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 09:46:33 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39D7D5D;
        Wed, 15 Nov 2023 06:46:29 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AFE3iVJ001884;
        Wed, 15 Nov 2023 14:46:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=Yv2ln5eiDA5qUdEVtCQjLwSezGYjsJspiaAOeq8XIPU=;
 b=q+zfKpq8lwMEg+R857uJo9cb7WG//pOIsvTZv1MosXE4vOdxJbDbDVuezvfzMkWO2yVm
 T26hIE6sCWeJ0uOrBvj9ompZwPxHkbeJr+OVewmk3/nhZPhIP+ipwhy9/mmnNJqn4zWa
 i/ybbTWuvSdyAChD8liyIcCqzp7dAxLQbkKWcF/NTXCujgLtVT6MLiYaUqopeu3VpxYI
 +iORZl/c09dX6FvCrjS3DTrH7Btfno2NzuMOCjKngYWJLaEnjl0DiuDSRsXw5rroTFYw
 H792ArNl6hObaCipzU99efXGZK7Vh92ljXIeZl1XGfr3aLXJTajltgF460ynEDCr4+i7 8A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2mdruyu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Nov 2023 14:46:24 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AFDr7rr006837;
        Wed, 15 Nov 2023 14:46:23 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uaxh36uhm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Nov 2023 14:46:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O0bB7jwYFyVrIFddrbOoNdjXSwTtmE8zkQT2zdy0qY7mGC6hPz4N1Zzxd/lvHqEHgVMkbdmoCkFG6EBjh2q5qRFfoI7sii+OYlGowGL9VPe5kdv8iEaItLaxcvxDToNUM5qcXRWeW5zZAcPu70LsxX8w5eMnRmzt0y4WxWILMI81mPWpEsax4qoltkrWmMZ0vuxXPx7bktMk7eeKmPPdgxcUCJ/AcbtU314j+AAu3re+MeBPyuPI2PKFhg08ZeUUrWVqNjgyCSr78PzXi3+LEnGar6Rce7C9t3M6wq8PIvXE11XcUAWfOjcoVRdGjUwRQwbwGuIi/mgAxbyb2CXMRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yv2ln5eiDA5qUdEVtCQjLwSezGYjsJspiaAOeq8XIPU=;
 b=B9+4M5RXNwLDZI22vCx3VMTMIMx82goE8n+q5VUVGuU0tcLiIF8fBXupivR56L3YtkbfYMYnY8nPR4FC0T0Ob27UYSvsWvzpk6YH9m/C9GS5+Y6fOtxWQJ/gB8KHGLi6zUwGwzQzL6diUY9n1JLHcmbgqjXvTW1BP7cjviKkFvWP83xvZtvDsS+4r+7NeGtshdWISjutjnUpCQfyKHHsbZKyCDkFRW9LVnenQKbkMbyV0/z8CS0DydQ7okocadY8dU8C1vagtEr0o8El+DOtOhTHPNG+lyWC2e27uEmJXeO4xVkQ0jYxeud+2mWHrHfJw/hbpCJWNsqIa7u7xcG/fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yv2ln5eiDA5qUdEVtCQjLwSezGYjsJspiaAOeq8XIPU=;
 b=KEabs2NXAQyWvsaGroT9YrEcMlVNwzHUAastr/GKLakq08XlpsP02biVTnvvC3s3KA0dyJV3S9A8BzX+8lvTxE5gzXa3ndPUnHOGrWqrfRxUMBaprJvkTznxXSmHzHOWWNK6OXthAjkJz67cf9eEmAwJotWc9/RAdf6Tcdh0szM=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by BLAPR10MB5044.namprd10.prod.outlook.com (2603:10b6:208:326::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.20; Wed, 15 Nov
 2023 14:46:21 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::abe0:e274:435c:5660]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::abe0:e274:435c:5660%4]) with mapi id 15.20.6977.018; Wed, 15 Nov 2023
 14:46:21 +0000
To:     Justin Stitt <justinstitt@google.com>
Cc:     James Smart <james.smart@broadcom.com>,
        Ram Vegesna <ram.vegesna@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] scsi: elx: libefc: replace deprecated strncpy with
 strscpy_pad/memcpy
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1ttpn13d7.fsf@ca-mkp.ca.oracle.com>
References: <20231026-strncpy-drivers-scsi-elx-libefc-efc_node-h-v2-1-5c083d0c13f4@google.com>
Date:   Wed, 15 Nov 2023 09:46:19 -0500
In-Reply-To: <20231026-strncpy-drivers-scsi-elx-libefc-efc_node-h-v2-1-5c083d0c13f4@google.com>
        (Justin Stitt's message of "Thu, 26 Oct 2023 01:53:13 +0000")
Content-Type: text/plain
X-ClientProxiedBy: PH8PR02CA0007.namprd02.prod.outlook.com
 (2603:10b6:510:2d0::18) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|BLAPR10MB5044:EE_
X-MS-Office365-Filtering-Correlation-Id: 29b25f75-15f2-48dd-dbd8-08dbe5e9a238
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qyvoi1rggAg3ogzl4EpRqjkAPVcL03EKtW8pFlscuK3nC5awXzmap1R4tAErQpYdZLlIEbdBNwkuGkqVFzPTUDqAR2ND2ghBon0K2y8/WSUrILSSplD8LCqiOE5Rz2J1ARb9NajYfqtRZ8hlcca2+UgcVw+16C7GsrFcuE2nc5OFpuF79qjUtrkJaoKDxaVrC1d9a4XvbtYkWvNGUDl7WDn+pPc+iQNRYhBllmUL/LB5TAV1A8znFkXnfn3/6RMC99SDuvKVSDrzsPFPGWgcGYizIWLiJRGaELei4pC5Urq7rlgHUToNn5QY4Ba6PChqCWMzEsapKKnSb8Sl3nVxzjbRfEM+SpSXwo6eih9Y+IGY0GDuGSrk3WyB7oC99docu3shA1sAOAfSCdoa3KIcXDkkxUd5cUOxWw1X2/olZSiw4g6Kh356++GSf+lH01wtM2x8xl3DvDJJK6kx2jOCld6hCKctssxhAVhqpQtNd1m9TvnecrrmjC1/ZkN8VE+cRujpk2VfdVT6r9ptASsLC65ucFkifbmP1dIzbbegdwjOSJk4Q8+BX2VFIwnK7LJn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(396003)(136003)(346002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(6486002)(478600001)(2906002)(6512007)(6506007)(36916002)(86362001)(5660300002)(316002)(66556008)(54906003)(66946007)(6916009)(66476007)(4326008)(8676002)(8936002)(558084003)(41300700001)(38100700002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PyZXCHKZpvzV43NiUdXLsnScOWJMtXfeZt+vrWmqysOpz39poz3fCnsCusTZ?=
 =?us-ascii?Q?WcKycAR2TW4gaAyZIdgQ8dh8OH/Iofc2RR/Ut51wUoa1r2OhjqTSfxcPTHvP?=
 =?us-ascii?Q?y1MY9L/hnjVejQ7j2unEIJOX+y+TuPgQC+XPCSqTS0DAeVlO4rVP8R9Ey7ud?=
 =?us-ascii?Q?1sRRMb8N1j4F0EOKTNR4Jn3siEFAJ5hSX3A9YJ3iZO8l9j9HwEzsoCl5dJk9?=
 =?us-ascii?Q?sUyBEWMt0y/9G6DL9QT9C5gmNR8fJkWUadaDjhUvFmdN3u2ANxLO/NlAY5uM?=
 =?us-ascii?Q?Ysd8aYuU8ZaqNKqHsUIDBI13BGBAqAuTMp9MWOoDN+Y0ABLy+xkb/eT57MEi?=
 =?us-ascii?Q?eoXIKa8axzM3JddvVwZ8DXmuRJPHxhT7Pw66JkUOMih2VSE2RsNYsELvfVXK?=
 =?us-ascii?Q?0LYXQA0O6MV3wVsGCBagqnEGB3Owch7d5RN9SqCFvKMEq9nXwTWuvash+O9h?=
 =?us-ascii?Q?nCM/9f2ApbteSnTHOl66g0rxfBHwYoSB1KBRP4mTr/JPfTxslmztS+uNmuP/?=
 =?us-ascii?Q?nrrVoMnt0TQX2Z4y4wMeHoZOvklsjYcdLfZGeTZBrlq99hL9iDJFsFO4PVXq?=
 =?us-ascii?Q?5bGuNSMI0308SfGIM9KEaF3kF+tod0xfziotRc4GzM0mUgbKcXYo6ycO0iXf?=
 =?us-ascii?Q?vZln+L6NHuZjReuX2ljOKZ4Vy71/Vvmcz0uhF1aqm09jvNfbHI4XT3TrO23Y?=
 =?us-ascii?Q?YUyCtzw0TS7gWdwNKsS2FySqclcIWqtzRdjOFDDQORhsqqAuyzq/nxU9aOYV?=
 =?us-ascii?Q?KGlwOIIdEK88NzQmaZExkeCDc11REhNPcaILOAmf3L/hTwQGqDUFD/GcSvse?=
 =?us-ascii?Q?Ecs2LiLN08A3a4ojGgtt9yPxuEfGW/SOKNEsTqc3eBLc/omvB2bqKfyVhpky?=
 =?us-ascii?Q?zTIsgjtZV3/pMB5tKeZNfTQaQSmqVP3KsIOMuiX8h9j6iJ4a2EiOTJfCRcqj?=
 =?us-ascii?Q?COv913bWY12xYAudbG0AqD79jZg3tRioplSG/vtAIG+Y5+zBf4EYcEdYoUdY?=
 =?us-ascii?Q?YQeVZnXiU3jvSlx6RdBxH9DSHnniFbflOnZ8lDJ2XPHf8bVxjEkl+GJgphv7?=
 =?us-ascii?Q?mGAEIKmJNCHsGSbzTDe2UWfWitsQxwWAHhiZ963URrTGOdCRkjg5wAZvdGSw?=
 =?us-ascii?Q?ZjtEm5VQqdEcYQQGRUTQ5a9IduUaYybmvcmV+ZA3FLZj09YISs8gdEfYXXSg?=
 =?us-ascii?Q?cg9Z8GFs+L2jrjZGOrEcqimbSHbptuPmok/NZFyNjXD10R4J77Jr/epIuurH?=
 =?us-ascii?Q?g0oVvNDB7/ol1pMfITt3ws5aahEzBHIyjvc+g4HeJRdROMEcAUybDSwNZzDr?=
 =?us-ascii?Q?KrLHUWcV4FpFBuMWaqpw+xcbCUG+SO3vGWZJju0u35JMb3LvUuIfJEtZjqnU?=
 =?us-ascii?Q?9Yk6Nio8kDdtTmKm4zU91y9cafi1Gpl0VIKKv6Si6NS1UebRhlcGyrXasKWf?=
 =?us-ascii?Q?Wrxhq2v3osOgbKF3EdlVNNGodbCtqBOz63jXKJswRnCD7CnaFrFgIhKHiMf1?=
 =?us-ascii?Q?4DpCq60MLK3///gk+SyxnP67W//H9Qs1xDFzFdZxVBXPfg801oHWhFbgAcb7?=
 =?us-ascii?Q?v2VYZbRkIZ2wr9VXxazKhTjUPhFzb9N1WrwKWlYjIAoCoo7Yvm226XT+rB0B?=
 =?us-ascii?Q?jw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: FSYM483te65+8R1qUq3aN9jg7lcgXsqhqY9ks77tCk6xMX4QHeTT9sQ1E/o3Qi+TM5cAL4alePpidXtv8feSVW7DOPnKw/nKKmnqZJ/rmEhlICvuaYmLS5eyd05IadzOWy286Wxj3was/v7Twgg2t9AzLx50ZM2kejAaAF80SELOIH0T47BgX2muben2WzSRn/0PtqCf71VG2KqPrzmDv0My5+xT3n4os3J4d2b18s/JQtUKhYM+h6wgwaN/xtt6JaCXV93euaSuQG+MuZuHQ8dP21iBnlGKo1K1DoEtufy6febVQvlc2BZT3SrK51S/+3TUXgBVUC1YK6oqBpTs24ME+JQe1QrXwwa8wj3EVDdWAQPUbrBFdED/GVBcBhf1sUz7DoIq+RWOzhmorL5IQt6ykD1HxC1wOVus1tuxqo70tEUYMAYSug5O5skS4F8Kq8ASziA/3p8kS9G/StNpgTDclwa6lOa76HAcdS6/xDkrhR2pZJAb1M1mKSAMKY8Ror715+YivSGXpSZxMrAXoqt81bjJOx3cIaiE9fsgUwRrVSDvyqiE7R0WuqQACh12MnZXcPo79tW4+1FodLc+9jPxuu17op1UyAro4vrVBNFKmhRPud888GCM9jxVEUETuMZcVDLqwkRu+7HvYo+frTBWJuFl854a/rXIFvyozYl9e4mrAU+Rt4gc13M+0RDJR7EFnjZubZ/g81wpLnyu7vjxB0oA2uLOMTZT916MqBVZCGfRE8UQ+WAnFXYy2WG+te56AE8hwY6Mcrk40cEya4UEU35IkZxyWRVVwb+sbMzh/F19flITqqUylCt3WjEMqffSjd0sJ6Kr/5K4WeR5RqaXJu+uaJvK7hYKVP8Luoo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29b25f75-15f2-48dd-dbd8-08dbe5e9a238
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 14:46:21.6056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J+4n9uciMdiYltQ2WGpsjgG9i4MKN8KCmHBO78H8I4rvUkj+inZpjxRPH7jAGddrwhXtxUU8+siaulSUCjgIUvdAqlcC9VdxM8IsErw21DQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5044
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-15_13,2023-11-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 phishscore=0 mlxlogscore=828 adultscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311150113
X-Proofpoint-GUID: Vujte0PedN_CjP3mGwTkI8ZrlG5WDkga
X-Proofpoint-ORIG-GUID: Vujte0PedN_CjP3mGwTkI8ZrlG5WDkga
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
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
