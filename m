Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBFEA797C6F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 20:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235106AbjIGS4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 14:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235057AbjIGS4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 14:56:12 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9BE90
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 11:56:07 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 387Idr4T014377;
        Thu, 7 Sep 2023 18:55:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=4GoLLbYYxBgIAMwrhXKYctzZVm5/SCQdaxVSPAX4dH4=;
 b=jfrUj9c5l1Wg4jUbxD6vDuoNqjKrz60w38SsNDL7QnrqCWzu/OgPgOnVERRXjJxuQUMe
 0Vm6yCX6Ltq7/u6mj6ozEDdcdwLJ++EC15e+HX45O4W7OfnYJbIx8xeuzLDbMYfIYopD
 Ao2DgA8H4Hn0rND1iPj1N8fA1VKorQd9hDKSpzFvw7I/iKPic2bmIP3T8grzHdAKqrS+
 4fuZmTNFZ3GGfMNvkSIOnSNQzocmIZOqQoZrIrsC9sxgr4SMSZZJfnK5S7an+Qf7z2tM
 qSYgdugrPbIOyjfd0g0tZE36IzLCviKOrIe4ZVY0MAXWJROnD0c/EJGVhFTWELV3PUZS Yw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sym0881pt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Sep 2023 18:55:20 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 387HD2OQ037959;
        Thu, 7 Sep 2023 18:54:27 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3suugecg6q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Sep 2023 18:54:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HwAJtapyt/O+8qcMFF3lou7p9PRmkXUIaAC4xiIt73WJL/hfcaiqe4/wZ0ghe5jkr9V8otacd6uNXuXLWZHXEOXQqJVeegfT9NKIR3DJlcNe2rpGGGaEVAbn9HONVqGcAOi34tMSscK1dEmOz7TgFQWdTDyI9I9plCDaRUVuE4CyhmxBnxIaqzn2pk+fmhELEO7duWtoX1emgnkWCcM2o9VJ36s4a9ybcnC2fD6crsGSQ4xizo0Ql7IR9ASQ4dX1MgGsRFyMvQNdweTQ+LcQcX0g7c8z9alu6bn9Rl4MG/raSSzWJmFDeUy60qHHSMcVF3Z4GrvWs3jBC5adPUvB5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4GoLLbYYxBgIAMwrhXKYctzZVm5/SCQdaxVSPAX4dH4=;
 b=mkS4wKoPLfLWDhwmyoPFeLcvLGotHgWxAQPnCHk8U+IQOeEisuA6bJy8F25ZONm4u2tFeXuGrlqpZB5jyUtH63fuC6UtZgJMXitmnwiZLuUo31G9c+B2aoL4xHnsQiwWsCxpKGaKJbuUZ32SA9fAGezYLRm997S3CSPccy1arPrYSorvBML05XBT1jt9X0bXvk+CkPIwvGQMzU5SMnkas0+a2szEHPcVh9ocv4oMtu0Gj4ZELVOLWnos7bIzgjiQMDGb6ukjgi5XlPGAenV77kEBHcAMYxcUmF3c5Qzn6IA3KTpGKrWENlGV3aWW30B8lx+FizbpvG+KjcyPOCEHeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4GoLLbYYxBgIAMwrhXKYctzZVm5/SCQdaxVSPAX4dH4=;
 b=t+ZtoBK7/dS2Dn5kwfsxxAAyQ1K5H5nL4/FfZSILdC85Uf/Hp2j0uxcmjprbSlr5HPpm7PQbePtqL65VPOdN1VjCLNttdPPy776ZgdB4/c49typDLEM5kTrzK1B/uMET0Fy+XLV2zpiIjZ2pC9ckWLS/jp4MOkRHHwqn7Og19SE=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SN4PR10MB5621.namprd10.prod.outlook.com (2603:10b6:806:20f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 7 Sep
 2023 18:54:25 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054%4]) with mapi id 15.20.6745.035; Thu, 7 Sep 2023
 18:54:25 +0000
Date:   Thu, 7 Sep 2023 11:54:21 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Muchun Song <muchun.song@linux.dev>
Cc:     Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Rientjes <rientjes@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 07/11] hugetlb: perform vmemmap restoration on a list
 of pages
Message-ID: <20230907185421.GD3640@monkey>
References: <20230905214412.89152-1-mike.kravetz@oracle.com>
 <20230905214412.89152-8-mike.kravetz@oracle.com>
 <5e091211-9a32-8480-55fb-faff6a0fadef@linux.dev>
 <38E2F051-E00B-4104-A616-0EEB2729386F@linux.dev>
 <20230906211234.GC3612@monkey>
 <B8F68838-8C78-4BF1-AEC8-D89BCD49ECC7@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B8F68838-8C78-4BF1-AEC8-D89BCD49ECC7@linux.dev>
X-ClientProxiedBy: MW4PR04CA0227.namprd04.prod.outlook.com
 (2603:10b6:303:87::22) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SN4PR10MB5621:EE_
X-MS-Office365-Filtering-Correlation-Id: 36ca834a-3736-4686-8f3d-08dbafd3dafe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8M06SK90O9IwplKVOQdZpig/nIAUGowmBNWXU41MblTCg0c+qk+6svtJ9Dspo1zeb8do17ZGPO8qNPdFxfkfGNtrUNbJuMFvI6evsFwCVaI/7IgTrITeX1BTpCN3wHT0YxDxEGM0rSyqC0HO/MZH+xIvg7AJZo9lMhVE/rCGY1gGmJNO8btMAKqnQzY+kGQ7/wQVA2+c13lNAx4Mi1BNUWMHD7wjTWnvcf+YbUwqZgEL1xBBysoJAIK1DOfDzlQlsyaky4APTDVuovY8NPzb86tmLpzXOB1cG7XmqcCBLKCwISZWNHksAL2FJ6IhtKuneOleaiFSQwW83Ya14GMDf6Stt/ABhKDqXpQrPtxT7JKRa22+nNJpay3/8EuSxajqV381xKAVcGucnKRKPcRNdeifBH7+MYtuKtJN6o6u4bRcl2pOpjA7SV0AxFJ6cKRniVBv5JkP+40tLs4/SREfDmyPB1sDGXX0JEsPLLwoEKxlEXD1wp3c4MKwefQ76IDQq9n2cDsGax3h90Yp01MvS/qMbn+eOiGT8NF63+dmWOo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(136003)(346002)(366004)(376002)(396003)(186009)(1800799009)(451199024)(38100700002)(478600001)(966005)(53546011)(83380400001)(6512007)(9686003)(33716001)(6486002)(6506007)(26005)(33656002)(6666004)(1076003)(6916009)(316002)(54906003)(66476007)(44832011)(7416002)(2906002)(8936002)(4326008)(41300700001)(8676002)(5660300002)(86362001)(66556008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sVpRXzW36ZOq+mctTRN/KW7f6bAUqUGz6MWBZ+F0ZcB9G2D1+ArDP/EtAVOc?=
 =?us-ascii?Q?qMyPBwO8uaiy2XDgQYJkL4ZcgJkuycvUVWqcfmqMRcLA92PBBF/aADFzCxxL?=
 =?us-ascii?Q?oIdR2hTuq6I2pNicP544NFIwWXzl8EhFtLMxDGs2+lSs197cyBEoHhA6u9WS?=
 =?us-ascii?Q?b+VZ+9lOvfn1en6QnOVOTwPI+9v25PGTzlZ5VJDArCnXNkbxlRc8z/rKdyNk?=
 =?us-ascii?Q?R+XqX5pcJAEiY/Sn2TsXsFGGNWopkSKAdmIWdRa4c14psOFwWk4pKWZLwMu5?=
 =?us-ascii?Q?wYulZy21jPoeM/meAWW8/NV1HhUtDgiJY24BzGOhUVzspmFk7PvYZg1RmNaB?=
 =?us-ascii?Q?85NHRg6/odINwiMaDkDwgLMi3Q9GqXvWOZiACKxcWtRKMDOEjuUPpzUXXUwe?=
 =?us-ascii?Q?oW4aI465lWdc0ENCGPJ90aoLMFqWvGMGOCZg1sQF3iawHCcSuSbEe+EALxVw?=
 =?us-ascii?Q?iwF0/U4OR+8CNBTIqgT/Wd22QylZGfAaaYkd/zTWIfA0TqNMV9W7X8rgrLwb?=
 =?us-ascii?Q?cGH+c8ywVxe/yQCf8nVqzj1bjq2PLiAuxv/dqMserQlKJMBMwnNzI+3pcFY0?=
 =?us-ascii?Q?SpJ+Lfb+nqDC7OLQIBXqlbIZ82sycB7xpI5yKBSF2nUkhgYGoXTvBwWtehV5?=
 =?us-ascii?Q?3prEipmJqg0xVKcaLBpgr4Icgss3gbSNM3mARyH+ewLgaQpB3EfFupU7WSvC?=
 =?us-ascii?Q?5GJZCXTaQQFTJfAyn6TaZXPZCRoRWoYzXzX2xpj8sBsCs4DLXts74yfLv+09?=
 =?us-ascii?Q?JR0sBBvFcQjmwhZVZJO2A7OBeWkCbp4t6BfmKsmzb1jWRteFnfHt1pxGuSuw?=
 =?us-ascii?Q?T1wX+cbV529eLk4JE2zk8yEDdjl1D2rkNC1lv5QW2u5NOa/dhlw/FwgO9cU6?=
 =?us-ascii?Q?nfEx/9iCk+caG40+gZpExdk7AiYVuCm8hbvwN44thk5eEZDKeujEt0mbbHOw?=
 =?us-ascii?Q?peXutN+QkpFy+FpUrIIFfXq/t/aZ5w6dssbYCVt/y1WbQVygfHBOOsEi9dE6?=
 =?us-ascii?Q?PDdsWyPwYDOReS8vSbMpSSu2fQTTPfk9pkQ9ZBXxaUq8FsGpiHIVCuL3rwMk?=
 =?us-ascii?Q?w54lJNwyQMIzLD4sYMUG6S9F60PqQ+9PvY0/Bl1zQjsazaSjrEadoA3AuP/z?=
 =?us-ascii?Q?OdCU/1N9dO3jzlZ5pypyf1BpOH0jQGKVLPKU2RY4kSeIs/hSFhqIlYBaOOxq?=
 =?us-ascii?Q?xg1ahFn4z9uVoV6+5vUKIVvwgefeXhBWJ+p1TmfPWPuJI+dhugcnA3qdgKgA?=
 =?us-ascii?Q?QbH2EgmQXvmHKu40TQv7j86/FnRAGOtVyUwEyOQGpDm3fmhauaMqGD7SywTb?=
 =?us-ascii?Q?NDxW0LHejbyJyWKr3NNiF37+YfTCftoo0Sl0KdlM3VvUqepsRedbuRAbaR+w?=
 =?us-ascii?Q?LH2QsjFJmS6qql4PU1BsdotxLBnZkRMlpYkyTbKsHJ3wTc4mtJMXVgIHYixQ?=
 =?us-ascii?Q?KInvDd0NVKtNJfKjWe6iH2xEBuWcHV7sgJ89n3AT/oha+/4uiBCwOX14XU5L?=
 =?us-ascii?Q?4y8zs7fMRVV5ZuI5EjFndG3R1DIGZkbdeRwcvQ5LZkYDxwehQDDh4SwC1TAF?=
 =?us-ascii?Q?IGD4K5joT4wSWTIMD/fUzPtPP24T7C5jnZyqPK7kHaV0/zR7XM5kr0hceOqk?=
 =?us-ascii?Q?BA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?9zcfdNHXhuzktyIvS3LbUHyyUNMah09ti+Dgx7Kek9u5Um2hbTjPZjSKEZK5?=
 =?us-ascii?Q?TfHWz9YKD9IADL/JTq7k8Gs+AQJsMuNMPeKW4ri4lWO4bvA2JhGVTxI51scS?=
 =?us-ascii?Q?iBQpv4gqIgfFIZ8IBxvTcECPRZkAfVRvs0Y3j+BhtSxOJJIIWb5CFrhThvEB?=
 =?us-ascii?Q?7F1LhdU7OAGzfhBL2my6CYiPVOPJtVmZEKgzToioCkSSAtAQWa20jUZhs8Qn?=
 =?us-ascii?Q?C8PnvDT4x0ogTekE9/AhYSVc7eJnYN/5N23OXsYcXhU8gqfn0KP3xmWzM/Y+?=
 =?us-ascii?Q?3AMXItcoMxs8xCDMfj/SjjtX0RufAw8dKXNSIaPqaHFsiPFGwgiAcmmff/ya?=
 =?us-ascii?Q?OzQRB+/DxJ/eAbkA3l4AkmA7HnbhCVt8YigFD97rMfFUyRS1GLyx4kFJoCGR?=
 =?us-ascii?Q?kOq4xvzacWSZFX5VBiGanT86qMkOFC0QRt6YXrZnQ8Lv8yUEp4xktTI3/+hY?=
 =?us-ascii?Q?kG/BHWl3sLtQXJ6N59fTIpkeUJKJs3gxXBfrAQJIKcMn4VPN1KVTqcQZ0DfW?=
 =?us-ascii?Q?+RD7IMP+nGxSz+8ZNPbXfhKykR0TIhbNQj852QKC75L6JWQL/fpkeWkQtije?=
 =?us-ascii?Q?HQ7PjE4hs0+CPLszffVjSkRUM1JEHlkaU+2bQKLZ5N+DdZFQcwSh4Vj7pBWf?=
 =?us-ascii?Q?xzDelFNBrvX7HKivz4bIu4aSM4bUiokrZ+5WlqH/z09BlG5oaoBddnzkCphg?=
 =?us-ascii?Q?/d+FEO6+bKyCKlvt5PXlhZsQBvwdS/N8DXLZSJPMdpppNSyDNdegXFzqh/lq?=
 =?us-ascii?Q?Fqc5o1BuZw/CXGY4vu57woL2G2wvlfyHa49fqqGe8PXAcG4wvyxHm39FFzyA?=
 =?us-ascii?Q?HvLqPPAqvgBiVGgkT84z/vw+VFEoJZ5mTjlFOcze7y87RkoDH5bTcnDXLFe4?=
 =?us-ascii?Q?3VoLVLcOSSd4w0vceUWLu2FOma3DA7F7CFtQZpEnb9VS7BvfWmZ24+TbL07O?=
 =?us-ascii?Q?orEHnm9yuHM0j5w74cVn4NNGAU5VUrVDM5YkyREdu//cYBwgQEtA3CVUyXEQ?=
 =?us-ascii?Q?ruF+LS2QOer5cubADDSoELyQxY8pexWZOh9bcR5T4QVuuo5DTAXEJYL98sdg?=
 =?us-ascii?Q?DaWZaUWjXxXzWBpPtYuCQC3bytvm3Gdv4+Qp0nlJmbETzaMUPG7xsIe17WoD?=
 =?us-ascii?Q?EjUrU/tdLB3j?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36ca834a-3736-4686-8f3d-08dbafd3dafe
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 18:54:25.2529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Mr3uRIV3AlgKAmWuc5kuBovRo+lB24Wd69BdCQJyXxJJXqd1ZYtqGsagf3XayX9QiH2byliQQODM2OGyAOmZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5621
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-07_11,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309070167
X-Proofpoint-ORIG-GUID: eR6uzC2b60zmGiXP0O3R4IySRUi8y-i-
X-Proofpoint-GUID: eR6uzC2b60zmGiXP0O3R4IySRUi8y-i-
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/23 11:33, Muchun Song wrote:
> 
> 
> > On Sep 7, 2023, at 05:12, Mike Kravetz <mike.kravetz@oracle.com> wrote:
> > 
> > On 09/06/23 16:07, Muchun Song wrote:
> >>> On Sep 6, 2023, at 15:33, Muchun Song <muchun.song@linux.dev> wrote:
> >>> On 2023/9/6 05:44, Mike Kravetz wrote:
> >>>> When removing hugetlb pages from the pool, we first create a list
> >>>> of removed pages and then free those pages back to low level allocators.
> >>>> Part of the 'freeing process' is to restore vmemmap for all base pages
> >>>> if necessary.  Pass this list of pages to a new routine
> >>>> hugetlb_vmemmap_restore_folios() so that vmemmap restoration can be
> >>>> performed in bulk.
> >>>> 
> >>>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> >>>> ---
> >>>> mm/hugetlb.c         |  3 +++
> >>>> mm/hugetlb_vmemmap.c | 13 +++++++++++++
> >>>> mm/hugetlb_vmemmap.h |  5 +++++
> >>>> 3 files changed, 21 insertions(+)
> >>>> 
> >>>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> >>>> index 554be94b07bd..dd2dbc256172 100644
> >>>> --- a/mm/hugetlb.c
> >>>> +++ b/mm/hugetlb.c
> >>>> @@ -1838,6 +1838,9 @@ static void update_and_free_pages_bulk(struct hstate *h, struct list_head *list)
> >>>> {
> >>>>  struct folio *folio, *t_folio;
> >>>> + /* First restore vmemmap for all pages on list. */
> >>>> + hugetlb_vmemmap_restore_folios(h, list);
> >>>> +
> >>>>  list_for_each_entry_safe(folio, t_folio, list, lru) {
> >>>>  update_and_free_hugetlb_folio(h, folio, false);
> >>>>  cond_resched();
> >>>> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> >>>> index ac5577d372fe..79de984919ef 100644
> >>>> --- a/mm/hugetlb_vmemmap.c
> >>>> +++ b/mm/hugetlb_vmemmap.c
> >>>> @@ -481,6 +481,19 @@ int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head)
> >>>>  return ret;
> >>>> }
> >>>> +/*
> >>>> + * This function will attempt to resore vmemmap for a list of folios.  There
> >>>> + * is no guarantee that restoration will be successful for all or any folios.
> >>>> + * This is used in bulk operations, and no feedback is given to the caller.
> >>>> + */
> >>>> +void hugetlb_vmemmap_restore_folios(const struct hstate *h, struct list_head *folio_list)
> >>>> +{
> >>>> + struct folio *folio;
> >>>> +
> >>>> + list_for_each_entry(folio, folio_list, lru)
> >>>> + (void)hugetlb_vmemmap_restore(h, &folio->page);
> >>> 
> >>> I am curious about the purpose of "void" here, seems it it not necessnary,
> >>> ritgh? We cound see so many palces where we do not add the void if the caller
> >>> does not care about the return value of the callee.
> >> 
> >> Another question: should we stop restoring vmemmap pages when
> >> hugetlb_vmemmap_restore() fails? In which case, I suspect there
> >> is no memory probably, there is no need to continue, right?
> > 
> > Recall that the list of hugetlb pages may be from multiple nodes.  My first
> > thought was that we should continue because memory allocation may fail on one
> > node but succeed on another.  However, with
> > https://lore.kernel.org/linux-mm/20230905031312.91929-1-yuancan@huawei.com/
> > memory allocation should fall back to other nodes.  So, yes I do believe it
> > would make sense to stop when hugetlb_vmemmap_restore returns ENOMEM as
> > we are unlikely to make forward progress.
> 
> Agree.
> 
> > 
> > Today's behavior will try to restore vmemmap for all pages.  No stopping
> > on error.
> > 
> > I have mixed thoughts on this.  Quitting on error 'seems reasonable'.
> > However, if we continue we 'might' be able to allocate vmemmap for one
> > hugetlb page.  And, if we free one hugetlb page that should provide
> > vmemmap for several more and we may be able to free most pages on the
> > list.
> 
> Yes. A good point. But there should be a non-optimized huge page been
> freed somewhere in parallel, otherwise we still cannot allocate memory.

It does not have to be another huge page being freed in parallel.  It
could be that when allocating vmemmap for a 1G hugetlb page we were one
(4K) page short of what was required.  If someone else frees a 4K page,
freeing the next 1G page may succeed.
-- 
Mike Kravetz

> However, the freeing operation happens after hugetlb_vmemmap_restore_folios.
> If we want to handle this, we should rework update_and_free_pages_bulk()
> to do a try when at least a huge pages is freed.
