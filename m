Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3387EC71A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 16:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233887AbjKOPZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 10:25:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbjKOPZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 10:25:19 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89C19C;
        Wed, 15 Nov 2023 07:25:16 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AFE3sBw010420;
        Wed, 15 Nov 2023 15:24:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=LvCBeNgwzUaaRDYbrRoxrXl3Hx8AjwQI2mdJlhnbp1o=;
 b=yg9Wn2y9NBWzZ1BmBZkJgna3NLo/DQylcDbnvRny4gePPs+AmkV6Yf9jv3IaKiUhQnrX
 dNJeibHnbEo2EOduo2nK5wr4ONfexSj8bI1TMud6X+28zjR6evsUUOAiSnTYZx8wS7LW
 iLjwTJjdgSnzA8S89V/LnLS9Q4rFEjpFdwFYib+x+zSQnzwNWRdsavIDb15Q8DQ+g4Hc
 EuL8yzLq2AF7vRZJpSPE/TuyJh1nWJmfO0OieF+ra+eKJljTdu7sF/DPrKk48jqmRjtV
 EyD9H9TyTv/bBu8UQgt++FhFVD/shvWWQBUgYUS3iniJ7iNNqe+F7RufmlT0Nx4QOWf2 jQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2na0ud3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Nov 2023 15:24:55 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AFF4MGA013168;
        Wed, 15 Nov 2023 15:24:54 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uaxq180mr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Nov 2023 15:24:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U9hwzLUMz6UTnRmGShuujXP4WPRNoqXRDwYmTb0gvYRDJ/oDzWYr1iSaeNdoyjYuKAtDeiCnA0XmAjvEG9Tr1crX1IPpMjdPNRs4E5DInAgYOlfGYi6LqlmfzuW8OT8TcaR+hFR/PWRmo5VUBu2aYlAGdQRjOtybVU8KbATlkCazmvyUPrM7q0NySAYdqLGpMpw9yt5yQ1uUGcxLZxXMW/ohSAikw98pr3YFP1py7IdVzs1itmlZq+LcIJvAMoEF89H0dX+DjXWLcTjYOx9xbaXiBK2XQ+4YQGrBfgksiQwDoXz8G5Mf3ugXCKOceFlgtWw9gCuVncPbwzgxNV82qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LvCBeNgwzUaaRDYbrRoxrXl3Hx8AjwQI2mdJlhnbp1o=;
 b=l3f28GXQUeAbb3ZEJK16NRoYaA1Qn4zCmDyBj5V5cAY1sB4/JY0VXiJB3P6s2gGWZLApYat22UFaOiDKgApCUkwVCvcYPdo1VcfMc3Q4QJgZywT0EnNnxAP9dSKfgDNmWYpmnuFeGwwwMwKEtxeD+FSBfh2Q0oJ8/fsOQ+iFFpJgOnvaB5++tb8GUcuzVaRObeI0DyiR5OxjeskCRy9bl6z55Jy0WsRzyIvs+viQgP0D/zCfUzH4yKqC+heZf3hNQ0Q1lAG76mZC/Z0NRWSKuI0LakSg7IYif3D8wG51f8b26QkzLLDtl18qdq7sGpATsgQ1A5GUY2Uv42bJUSsARQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LvCBeNgwzUaaRDYbrRoxrXl3Hx8AjwQI2mdJlhnbp1o=;
 b=EukovRb1vqC5Z5YAiLVar1e/JmSHs8YNF51v1VxuK7Ns0ALIMnlkGgX35IQKV+Lzbfh+BHq1Imz6cjCReA1hg/7vMKXi9C9tMgLQL4J8E45o5RfW0TZoYHRLpKbqX+qsS9/BHy0DHTJnK6Z6dpomU2hOEfvtxebiI+CFTFg5cZ8=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CY5PR10MB6119.namprd10.prod.outlook.com (2603:10b6:930:35::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.20; Wed, 15 Nov
 2023 15:24:51 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::abe0:e274:435c:5660]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::abe0:e274:435c:5660%4]) with mapi id 15.20.6977.018; Wed, 15 Nov 2023
 15:24:51 +0000
To:     Can Guo <quic_cang@quicinc.com>
Cc:     bvanassche@acm.org, mani@kernel.org, stanley.chu@mediatek.com,
        adrian.hunter@intel.com, beanhuo@micron.com, avri.altman@wdc.com,
        junwoo80.lee@samsung.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Lu Hongfei <luhongfei@vivo.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH v4] scsi: ufs: ufs-sysfs: Expose UFS power info
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1msvf11l6.fsf@ca-mkp.ca.oracle.com>
References: <1698890324-7374-1-git-send-email-quic_cang@quicinc.com>
Date:   Wed, 15 Nov 2023 10:24:48 -0500
In-Reply-To: <1698890324-7374-1-git-send-email-quic_cang@quicinc.com> (Can
        Guo's message of "Wed, 1 Nov 2023 18:58:36 -0700")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0202.namprd05.prod.outlook.com
 (2603:10b6:a03:330::27) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CY5PR10MB6119:EE_
X-MS-Office365-Filtering-Correlation-Id: 111d2024-5e72-4caf-ef53-08dbe5ef02c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jIM+qVrx7WG2/1MxQj92D3YVm7za89swvNVKcDBbZnwdPEkGs5DVWeU//VjnJ0dDPrFi+bp0L8SxCDdl+ezJ6UB9ZxuDMIR/mLZjPJdcELP6eY8QeYPEaQqJ+xBpzrPbpXsXeF3uewv6p16ZmIt50amcO+o0c23lYIlhSfOkY6+ZJnrSRvV/wqbWJthpAAmMGtV6ntMu0pDDLKkKTmq3vC3FBSpiSpZSEgY/szAdEQzAxjWo8P+IbkVNh6bsjhVajwn4NDWb+hW+NZ4N9YFbgWvPUx4NgrFsobUHrmBXRkwZ54EbS0ot4872Pw5l4y/0b8+L+yiV5RCOeRSqqsBzBAhVqMMrU1pH02cKUmdCc90Rf0y/3KswKXNpmahaHj1bJZNPn0qY2+0dYTJLgqh0f5ZhgSH97c2GdNWyRuIjIX9sHlPLlOqt/p7sUNBjTqWaQQnq+BopZc3DWsLhtmVb4L6SI4JlAim0ijwpWDMbI7D+x9j1GCuwpHl9C6IxWzC04DDo3bKWmgB+h7Ah0m3/FNUC97uvvdv8ag0EBDmIjuSk5KlErFEhBTezebCNGK97
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(396003)(39860400002)(366004)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(316002)(6916009)(66556008)(8676002)(4326008)(66476007)(54906003)(66946007)(8936002)(478600001)(6666004)(6486002)(41300700001)(86362001)(5660300002)(7416002)(4744005)(2906002)(38100700002)(26005)(36916002)(6512007)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vQRd88gPorPjyV2uQByUMj9tA/fj2YldJ78Ltzj0lcbskND0aNMMnN/OPR2I?=
 =?us-ascii?Q?hFGfl5HaGJwtHLCI9+GR9Ua7lg3FAnZFDOubVevuoP/I3K4B4nErKIBL6eax?=
 =?us-ascii?Q?E+d88tE1/bv3dbe2fmHkBy0P8aGXsTnhr/1mE2w6cUtsnMginQcY2Sg+G1eX?=
 =?us-ascii?Q?KZdWIheFmY789tI2MmlY/qYl97p7tD+cDU5KYBWVsBs/FrVSf0l8X4Er1to/?=
 =?us-ascii?Q?lXDKwqmcgaRzED+dY/fpZ+X0nLZmu/wHPxsVpNAXNeSPiGHxjp/WTAnD+OgV?=
 =?us-ascii?Q?+p724ZOqIVXjnCijXMe0mNJ44XZ8SLOfD2GSj6cz+vCWJnc6Ip1i2z87Muje?=
 =?us-ascii?Q?a9c9SXSggmC2dGTbvJlJOVLCLQlumAoB0mYxNpMOlMRyZyQWOq7D/1IrctZQ?=
 =?us-ascii?Q?XAopX+TMNsnQ0YtWq6YOkApfVQEY6nAbG8D2r5/3C67FZhVebheVhejkXqui?=
 =?us-ascii?Q?mhciQbDUezYJzAKcNAcDuUy2PPoC1r8PUxhrnND67NSqYYEqXhiVBvN65zMN?=
 =?us-ascii?Q?T0Or0poMABf65BiWlDw1nNJbtl+cwX059jIiqNg6YAPnyBkp8ym0CE2Cwf3f?=
 =?us-ascii?Q?RDX4GVDRenKcifGSi/mjhU1zB8ewgad7IkUsR3fLbuKF+oyjKBBXOZrdN3Y1?=
 =?us-ascii?Q?gL3x9X3JQCK22yajxfhSXzjw1XEKgebM5sGxgayjIBIdAmU9paGSPkLF9sWH?=
 =?us-ascii?Q?SsgKik+QAfH7TfFi3oUbE3mnnTqncukk8D1UDa9Z8PDEOsVKdbsD+ghlhOi7?=
 =?us-ascii?Q?Vm9eb5AKtPuAqmhT+kebEp8egvk+7/J6QZNosijwhgrQUVmUh2OKdmfRaSBy?=
 =?us-ascii?Q?WLMk/gVnpdXW8p1mfbwoXdPW5IU2vT85kLRA7f8g43kzbVqJYuN+IlLCvOEq?=
 =?us-ascii?Q?sXd+FOY/n60zaPJ3WOG1uPdUL3MaLLcBjILaq7bD3+/rvP5zk3i8sm6WerMS?=
 =?us-ascii?Q?4OMgTo+cTelLSOYIMo2KKu3XMDPqy23OVs8CVXJ/59dgoFGKjb540INw2TBy?=
 =?us-ascii?Q?x9EKKgpC5noDY+EAQ9xTjs4lMc7RIY9b72D2ynWhZOVvtJe1Q8tKvCxFR+rH?=
 =?us-ascii?Q?vMJXXqzBhGmrK/221/LCPB4XbGWGTCUArDrc7IuNey5iOgxmU6tiHSG7ZgAT?=
 =?us-ascii?Q?p/0RRJh0+9IaenxAYznDmBxv4OY+XQHFt7jGj6LvjORpLytVpDLt3pJUozlV?=
 =?us-ascii?Q?Q6i30S8LpkDknjLXHRzyfJXWzqN4W4g0SyXQHc/vsBJ9qaJlX18xKLSQFFez?=
 =?us-ascii?Q?+u30zgklUElMEUsVTVY3BGb/7XbMoB3VxHI3X5293fAxVDE+uShytGlT5umB?=
 =?us-ascii?Q?E+UjUS80X6/9vCnWFbmpcXfsN28lX3fYOMnt2lWgq8rp0ci08xLoAdmwGJby?=
 =?us-ascii?Q?OC+goPAZtmJdz24T+w433YiXRJBQbBvIaaR6dfayjDeiX44FACxI4SMg0bCt?=
 =?us-ascii?Q?gvZwpKsclszfM6Yrz4Gj4AYS7aykLmKR7ULBspNDy7jEWjKlH0U8sZ9kbHTJ?=
 =?us-ascii?Q?+hrMZhevHMn+OJO2j5EKtYiHEn5Yo6BnsfcxK27Nf9BUwdc8HOeFkRdYYoNp?=
 =?us-ascii?Q?cyttU3nwpUpyv4iSWpIQ/oGNwOoMkB6Xlegt27t9eh4j1p7UfbKwsaG7/Ybx?=
 =?us-ascii?Q?Pw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?CtzwCuoMpmNpMBy4sihsvq6k5eJlk1A35diDR/TB6RRAOu2OExbGHDSApgTf?=
 =?us-ascii?Q?58D7xxmAKkV5OEvZYWmWAqLgV64wj7H+mdoVVY2cd7ESKE5/DFySRIJlxEOh?=
 =?us-ascii?Q?lxuP7Av6/TVuEz3O+7zMEbiqQkzYedSjEJaplt/lmly6atPIELk3sobSEap6?=
 =?us-ascii?Q?sFZdf8lBLyXhkoiCZ/47KZAzuU+zmvfve9GJCDmOzYeZLN5j45o/Mk//RCMy?=
 =?us-ascii?Q?BKgavyU4Y4zwPGppTvlpSWhPdbEHSXDWrUUkHnxnyb7wiZbIFm+pLfyoAUtu?=
 =?us-ascii?Q?GWB5FoHTd7k6RYE7/uSAEIP6avegxIrfGCOJNxcAZSfUzqbYxvIMSByZblwe?=
 =?us-ascii?Q?RVeP8VsftsTbFb9klLy8DuRvkD+55wi6DPofC7fy4FK1TO3vY7oGxw0ue3Si?=
 =?us-ascii?Q?oooVxv/aKDZUwbw9tc8po8DAEMGRAgMqmeJK3aYIuzdhCFrkG5F+YLqXLR5P?=
 =?us-ascii?Q?xTcmdWUFjr/xWvy/YMrCXzUAHelxbFENzDbsfzHJaokWrUqFVuKvxWW33CfT?=
 =?us-ascii?Q?//YJabJIbXkV5zOeJHWHljswWsuP/19V7R093m1i2GLyw/he6DWWcrM4IvSp?=
 =?us-ascii?Q?cVtrWb1GA4Ai91LO5Dg0m6n9Zson9Sa25f17J6dZOSLnhvrhQUsKhfYyY9Qt?=
 =?us-ascii?Q?Hw/O4OACpWKXFNKbsZ8ddlW7sS7aCA9m+PUY7vIakzvJ6mQ53XcRv3+AA1uH?=
 =?us-ascii?Q?e7far+zzwjuW70cQTHEoqEQDTVfOOA4jgWuAurgDVmhMwwMbBvjyF3Z2eHil?=
 =?us-ascii?Q?G6g50Fq3g3y87py1igogqyRKXkpqoELja2NPtyuf4DNhqNdqlI/SMVJwoNHF?=
 =?us-ascii?Q?CCzQhOKWQ5yl8uUMd21ade2yhMB6to3WG6j4tGxOGB0m88vIs7Scrhg9/doy?=
 =?us-ascii?Q?L+0Ziq+OeqXbiWq73uZmf/AeuZB12ljuiFa+e4wy1AsfygsS+V3bC7R6/8/O?=
 =?us-ascii?Q?r2XDbypsv7iJD6P2+EMmL0xUYfl707aMLzsBskTL2aUVJAMbOV9UeM/Pr1iT?=
 =?us-ascii?Q?TcuNKiyw3atiTBox+s/j35+C8tcrDbG5hTPFYv42eb21kLM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 111d2024-5e72-4caf-ef53-08dbe5ef02c2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 15:24:51.0582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wih0Tf7kS8rorpN4gtZU7USvWb/Ng9RdNiXunOQbXuum6AcHXiRGqBnpEd7K0Zcr3zxgQmjXcM6CNqra5o5axKvHa1IqYQbLhIjb6jjCMsc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6119
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-15_14,2023-11-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 bulkscore=0
 phishscore=0 suspectscore=0 mlxlogscore=729 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311150115
X-Proofpoint-GUID: LkI9LEijftteWqkenzAmyui0QKfca0xm
X-Proofpoint-ORIG-GUID: LkI9LEijftteWqkenzAmyui0QKfca0xm
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Can,

> Having UFS power info available in sysfs makes it easier to tell the
> state of the link during runtime considering we have a bunch of power
> saving features and various combinations for backward compatibility.

Applied to 6.8/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
