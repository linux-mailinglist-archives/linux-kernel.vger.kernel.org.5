Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 118D276285C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 03:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbjGZBzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 21:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjGZBzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 21:55:43 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A084F188;
        Tue, 25 Jul 2023 18:55:42 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36PJImkN014420;
        Wed, 26 Jul 2023 01:55:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=c/moor8Z88R/EDB9dMSjN/c90UHo/3lDSyQxCrEELuI=;
 b=S65IHCo+7ga18l1Y6E84P1bcPjvvzoncShdD1iZvS21pW592rzSp/r47eqJkAsxkSvt1
 rXsG/Q2lPU51jRfaaeKetgHQCzzmxSSOuSUFjcrZU0jiIeGR95h1cH8SPFQBP27NYQyH
 fDg/lzOwE3AXISlzUXBlsdBvuhSB04ARpWDXaMgFxOQU3wvXGgIEmHzB8rJOQsHdusIb
 KVwXJGG1IMox4AjO/gXOABK64mD0n7lRsBrpFwh3SwR6CQQFSNEIWsx9Yf/0o5OO584Z
 v5ZF8NA2iiAl4N/0wD1cXkCnRRAgNflwoU5CEYvTY5rf2iD2F8PmIquXAWAZ0VZBzlMh xA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s05w3pe2n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jul 2023 01:55:29 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36Q0X5kJ033437;
        Wed, 26 Jul 2023 01:55:28 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s05jbu59a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jul 2023 01:55:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lP8gwkNZmYEGqvStBwgmXVyB75NRVx2TN5MOcI2ufwZ8bp32dgJgAJFu1q2Nw9h8jrhQtdtnbZPzlO68fzAYehNN2W29DQsy3OiTbe/6zWMsWnpruByaiOnMRXiW3r7rms+l1Uprp7cA9hhRmIe1AIGagUcKyMlXKMtMb77FE4m0SNGzOhyeeJJ6lYlzBK0H3GMiRM5IlzNu0AXBh1WZ5zOBudX7EiZEgNmNMUD3ADWxUa4KoTmurpJDfMiTvyw+2y4wrCXcS0yUKACHjB1OdJhJk0+uysokx8PWjvWwdBnxQ7LHYaZVDjss/8OYGsEoR1nD9wXTM4CpiZNsbywz8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c/moor8Z88R/EDB9dMSjN/c90UHo/3lDSyQxCrEELuI=;
 b=IMV4dtCwECJ348erGc+YLgWqDN4hlL9TdMLEye1esAD0O3c6yACeNgvB8pwXjsjy+GTxT/lrsB9YdNNz5J5iVOtaY6zYkc3qOZqgcUhXi3O5PjnGrNH/kXnIuRUiDpsBYTnViizp5a/XwGgEgxANJXKR7aO4IfFiC5bDzQl+HQp3cl8D3Coq7iUFVvQnwxjTZa/AInAHI6cntwiYO5nfI4FiEX9sKZmyMotPiXKeJfy/OERexipKJ+BlrSsLbgxNE9tMXrtFgPEYquCUdrzmNl8R8diaT+9wiegr8BWlAyGvoqHV6x09p2k0tQ94NlIZa9e4w/JbZD5MfHyiIG+jzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/moor8Z88R/EDB9dMSjN/c90UHo/3lDSyQxCrEELuI=;
 b=svBDvZMkhmI5EfOfkWSxaUfybif2t+eCa22UnoivF/y3rz1mJ6+2WzyPubo7Kuj0gUZxpu0QmTplKL3KkysVZ6QQw8JC6XLQMs463IiecofPOliUiQKRbXoE1wcoEiaiJQsgjJMBA3/MmzRRpu4bI3kcsf46Jn1fEbYQCoTYHnM=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DS0PR10MB7152.namprd10.prod.outlook.com (2603:10b6:8:f1::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.33; Wed, 26 Jul 2023 01:55:26 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::2dff:95b6:e767:d012]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::2dff:95b6:e767:d012%4]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 01:55:26 +0000
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     <lduncan@suse.com>, <cleech@redhat.com>,
        <michael.christie@oracle.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <haowenchao@huawei.com>,
        <open-iscsi@googlegroups.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] scsi: iscsi: Remove unused extern declaration
 iscsi_lookup_iface()
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq18rb3zbb0.fsf@ca-mkp.ca.oracle.com>
References: <20230725141531.10424-1-yuehaibing@huawei.com>
Date:   Tue, 25 Jul 2023 21:55:20 -0400
In-Reply-To: <20230725141531.10424-1-yuehaibing@huawei.com>
        (yuehaibing@huawei.com's message of "Tue, 25 Jul 2023 22:15:31 +0800")
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0087.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::20) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|DS0PR10MB7152:EE_
X-MS-Office365-Filtering-Correlation-Id: c5163702-1981-4476-41f6-08db8d7b61cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8V3tsdSu8e9BxHhIZGA/CsEC2s2hihWD/VtC6lm2+tl1IEY4vz2vwrEUvrVe9uszXArvEyKslpqDqkaDa3CE3vzzlDUN9nENevWmSI9uaf19oTHT/5bwRPgwqMZl5uWZpOeKc3TWRPXK1drCms9zeODwVFJsvugE/Nlm12d6JZ6FzM+iZLfts1Q4HPAe//m2g6xD3zZLr8y1GSSPMEIpVgkMTdkSUFWxKL5UGE+ZH7f1fpiYDFQv8zvdZHzqR/xe/Ff0soidEQhPcsqAGu1BHXSNbgY7BnCLSJJiVQP63UrnUIrBEAv2RDMY01msmqAoyMyxYtfj50v2ai7u5cOJ4tuHGpb1ZpmP/iI2/te1lCKu/zpmtcXmnxlMwC5waiAVgffvU7BVM6J4YIm+K5R6LRPvFEC7EE+ivy+3C/GO6WbOZ0NJK/xziP52Dne9ES++8JG/WaFx1csS3faVh1n6Zqv+XtQDf8Owby2/HfbC82v//W7ktxjC10JIt4qEWDixdlk7A/eRUNRNrNdclMrjbpqHS+Xeadt7r/5iBd8kNL+15Gd+x4ZqKwi3KuZez+jB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(39860400002)(396003)(136003)(346002)(451199021)(6486002)(54906003)(66476007)(66556008)(66946007)(86362001)(38100700002)(478600001)(26005)(6512007)(36916002)(186003)(6506007)(6666004)(558084003)(41300700001)(5660300002)(2906002)(316002)(6916009)(4326008)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ilZEr8+mZCL5Qmjg/An2oPIbD2B0EnOTwI+ya2jntYo0aVGUCLnLoXr9R3mv?=
 =?us-ascii?Q?RhskaFNj6XHE9xVhU5lfs6sI+mquuuV5nLKXBC83CHUwc3sNULyaNmCiZkRh?=
 =?us-ascii?Q?dT264J2qsH6VQA+19iwnQwLExWrTRq+z5sywrlAGM/9/cFQ9HZe33/DKdyRz?=
 =?us-ascii?Q?/JuFgBMZSau3aTK4idB02zxcLvQGvy3G6UWFoQCbLxBazW9xyc/gt7MKSqQu?=
 =?us-ascii?Q?Amy+k0PrrtdWKfni+B8uZmD4Bgyj6HxAHPvOUbwb7FMNrHs6ummQNx+uuo/E?=
 =?us-ascii?Q?4uTLu2aV7TO7o1OPPe/6CDrdeHcBjwPLxzizj/Y0Z8qHurgUnXeYY1bowRdH?=
 =?us-ascii?Q?0JqbIcJ0rGRwDJuub2Cbs+YZ93au1uACNTsLWiQOENHWIW4iCnH1OJMJMKyh?=
 =?us-ascii?Q?DmIeAInHRmZ47PEv5t/n/uu5/aFCAelexGXqana51Q7E3Z2qweTo+/GkksW9?=
 =?us-ascii?Q?bW0uSvBNzmXzLcb1nrzDbgWPTAbsWi5B4Rvae53hLYCB1kVAnKKoAbeeqKoL?=
 =?us-ascii?Q?+WdQwtrxnwkGqmTXWoX7dkHqc10A5n2kR94CAIBhZMnsGg4rClLTqdihdnTt?=
 =?us-ascii?Q?jPWhQM2G/iHPERDjFzax38yMEpsZ8tPQXurB28qTmkJgxchQKTZHR3hhuAYJ?=
 =?us-ascii?Q?mLQQ5yFTffORJ6CPnmNk1IcpzPcdvdtDjioPnbXmTZ5M+fWt8al4pQgXfUUs?=
 =?us-ascii?Q?w31v01lLCpiSr6xME7ez4A4kj11Kuw8+FhMe9bSH1RL7NqfgrN2FJBrf6iTM?=
 =?us-ascii?Q?j5J0jn75crBbaY0En/ZfijiGEzBXCjdActudpCeQ5snmuAJkINYzd0Y0YMTl?=
 =?us-ascii?Q?UtAC8YV1Iu9pPjrSJMcpPjQ2fOvgN3iBpxv6PY4U9zHdpIGYUw1OatHHWSDK?=
 =?us-ascii?Q?y9k/RBnvwfRlUhgEwYewgmcSzDsUw/bUYMJ/H6IHW2IIAsitfv/lmv4ZTXGh?=
 =?us-ascii?Q?fGiPP6+DWSNFsvpkIy9fmS5+2hD3KUFwijPZwv6luZdeqOHwqN4QRf80ZSOc?=
 =?us-ascii?Q?/tDozeKaYZma431tInPMnaRvfLgXoisAgq51PMgGQyJRfZ74Fp5Fl3ssAItF?=
 =?us-ascii?Q?AQpk65Gq5Z92dN17NScIMzs5F20Pf0S7sz6A65xQ2U2k5hhpWlWvfS3QrviH?=
 =?us-ascii?Q?CQ3wFZn1qKteAL7/Mpd6EJz/OUxjcUmNiRxxMjELuBboanassBYm7Z4czsoW?=
 =?us-ascii?Q?ZPeR6w5QMgjS/82GvZCErPfrDdtjECU/aGc9Jxf40A6hwNgv+yqCDwoJOibw?=
 =?us-ascii?Q?ukVRqREZyva37+lFpQJ+D/4VW8W4PCr8f2ef5+cvoDpaltNQ8yWLhL5Ba6dR?=
 =?us-ascii?Q?4A6J9ykSJ77JEBrNGzSW3s7Andsl9P/PoHyrqDl0Qa2zZfJK2JuzoJ4PcWZU?=
 =?us-ascii?Q?bsNKYabKyLh1Ju3ofFgap2o7mJPjcsw/jRyxDn0/zlkhaVHrBlYEfxAaousT?=
 =?us-ascii?Q?0fEFvMC+obgXPzKo0+DgrKbjrIE/DYk08O71tYcXmNtBL5Wu02d4f0Q//BuD?=
 =?us-ascii?Q?VIXxw5upmV7Issy1B9ZRhGDaSovoKWmv3XvUpSv0jh69kYOlh4r/17eBBL0p?=
 =?us-ascii?Q?270JOX2Ni38VevIYMlYK4VMHbhWiXa3oV/qbIsGxMZ51O6vj8qn6G/hrwCfl?=
 =?us-ascii?Q?Gw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 3E6ybcp55EqwNb1p7VNb1FwK6l1ml9SXfNSQY5pW+Y3DUCt/k77+THAza/jr8WzFQh9bkCqJryKQ5VASZkr2Qx55sTh/wiEoULDZIXGKtj74wgVJiy3ZBQ6/tbnsKHOu4ztFmwm5nPDbWoxVdDq5Sf21u5GNL61pkNzmIR10mkqjJahrMCJrOuPTj2bf6qr9Ff8vuM5F1vE35qgaSXaNLsbHOAZhqppxaCIEQwEblKVRuZ9JMapiWLEQiW0YqxE5yOF8Kk+2mHU/FoSxeTpHIKa+j6jfd3sIdLY+FxFdfYuslK8h1VO1nGlK+ZuarbJrd8p5NN5tKoZYiuMfX522PE0v/1y57V+vh2P1I3xufc7BIjnADjjqFUiVnH6O9FOkpO/9a5YxT1McBMzXtg8aQ+0jQBCttPU6eDHGf5aF7uRoKtoPc11mSgKB+TfxdK4VKyob3BbJxPWIMYQ3ug1ibC77ycu0ZTP7b9GjF+WTPJjZX2GcEzKHl1UnBpDYo7iu//2odzg+7oqZ20rH4NKwyiAOXtUzrq+6dWk3PEA3U13hhaf8KTafPOATCYRB0S8i0fneIBYcnjZfr+/TISOZ9YmX30PROO6inXwe7SU7oCA8GS2zoYyLf5xR5/X7Td+DE/HWQmjuh7FnwALffiiTEwmA55tsHSIRNbS1up4uoUZmHVzfe9P8LDAjicAqjdPAyvMXTHR3UNwJzxH5bCbq2O0I5Y/H6z1H3SnqVtQ0O+9B2h+DZchuhGZc8mtXrWUu4JjPZzKF2pxILau89Y9J8g+3eo3te3dFNojLkMSQ8eT4ThLg9simm3ZX3irfzFj9h5F7DJP6Nk2CzelM92czF/UzQ4wV2i+VqGWJoMkmvOBTMwSqzAc7IDfGNr6vrUFjfwHShuQKRRmYIyPblxczMgMvKxI+g7MNy//Vs0uf1y4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5163702-1981-4476-41f6-08db8d7b61cf
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 01:55:26.6284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gHry2OzskCsWH9C8Ca8T/DJ+l0V/DlRwhG5WMv4YSaFNjwE+2XAJ2jBsev0UJRfi0DF7LVN4dCJt6BJdBbU1rG+WvBIeMmyJ6+O9SnM1hmw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7152
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_14,2023-07-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 mlxlogscore=874 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307260014
X-Proofpoint-GUID: CdawmuKirv4tQsI5i2CANqKzP0TuEdOc
X-Proofpoint-ORIG-GUID: CdawmuKirv4tQsI5i2CANqKzP0TuEdOc
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


YueHaibing,

> This is not used anymore, so can be removed.

Applied to 6.6/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
