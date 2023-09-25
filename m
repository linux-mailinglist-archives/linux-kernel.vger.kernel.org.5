Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48FC97AE29B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 01:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233538AbjIYXuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 19:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233621AbjIYXuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 19:50:01 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1729DCE2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 16:49:52 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38PNEP7D018843;
        Mon, 25 Sep 2023 23:49:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=3vbONjsZvravfMZFWf/jFmc0JqQCVqxQwTo9QP2uYlc=;
 b=RIqHiBBmHQMTyXOEEMefemMO4NV/X7W6OM6BEkhKDf9Ds57/+Y8b4yupOuGm3ttV0VjC
 wASMlBwocRlRTM6NhUbySNJhjsfoPy9/K7koDMeP2ZyrXcAxjxMhF/CuZV00NCtUEvuw
 dhTfH0X3lT/XtnILlWiepVL2rbzj4oKwuQd6qI6F0AAUhjNWHTwQXY/7V2lH2yIIgWEl
 PM9LMOtWg7OuVWmPi1TkEfLDdLePy5FjeVsREPDRCKm4k1d8uMQqAXyZIBwqfhJ8bhBv
 EK/mKIgVr7i3M0zLp0Op+Q7J3+Hhp78SflQTiio8dzLmtJc+v4QLFkFLibbGZIDmB1Wv AQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9qwbd5k1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Sep 2023 23:49:07 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38PN1bGg039385;
        Mon, 25 Sep 2023 23:49:06 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pfbbdek-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Sep 2023 23:49:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A3wMOkjIVefDxSv6LDDWpO0NHJWZSMN6Yb78cNQTrl/0N7WUL/3ci5FQS5oZRbusw7ptbg1BPnfUIEiykYZepWYtBWb+gFjFOIzzp/oIuN5Mv+otcc2n70U2tQ/5Sq5M53gQOhb2UgwA5fp8zMWBCUTC/4KSKA0fTL4QkC4pqFS3Jmro2QhHEigmtI6vWLyIp1Iq9hZ4jzdTOCGJ2LMcsN0ayXnUQVmQ7PNG853fnnY1QtEK2NP0qBFBwsBtZnlGt3K3DVF6Y+Q9o352bjH93GAKZs8gmQgbUjtUArzyOpW/p3epvIuQHb18FYqict7kS/GlXkIUyMqCjGsQTpNYHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3vbONjsZvravfMZFWf/jFmc0JqQCVqxQwTo9QP2uYlc=;
 b=AJzcPcbkfigl6A/i/2Q8DhmCpexVmeOeUuUF836tvycpFLS2/aAUfjnrh3LhMHLBgBMnPRbYzxtnDczEUkhwe4xD+fWykq2FvaHVrqUUMau34o1rrptLYE4EEkj+0Dun+fpVwzfaDy8Oq07sVgG/TlvVVJc2ntYAO14MSUX7ZyLqWaH1UWOryjNUoIPycmGpXMMBAPoh0tmFnygvF5ZeXiQXOObfvioHBvAb73szYgW8kYkVx6Ri0Uh5EmCtGSVfQyTubYcPC0J2j3mOXEIkXqGVmjRLf9q1XiU+PiMPokmhiOjvrHKUW7P1HHTcWenZaAxmdxOCpl0P2ROOtX2saw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3vbONjsZvravfMZFWf/jFmc0JqQCVqxQwTo9QP2uYlc=;
 b=oPKR+KNWg+7ly19zJ3ZceAniBf6uouNXV0iPI3EG8B7KhAL0DLTuRDYcBOT3kttmiUU4xwcZo43E/PVSF94kjpC/FgXLbrZjENIQDiQplQqMvauY7RASu2+WpTW43V/bey9fujbw9ETJky5cLGWa6jb1u/nAA/BUuwKLA7wmQXw=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CY8PR10MB6730.namprd10.prod.outlook.com (2603:10b6:930:95::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Mon, 25 Sep
 2023 23:49:03 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054%5]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 23:49:03 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Rientjes <rientjes@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Barry Song <21cnbao@gmail.com>, Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v6 6/8] hugetlb: batch PMD split for bulk vmemmap dedup
Date:   Mon, 25 Sep 2023 16:48:34 -0700
Message-ID: <20230925234837.86786-7-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230925234837.86786-1-mike.kravetz@oracle.com>
References: <20230925234837.86786-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0125.namprd03.prod.outlook.com
 (2603:10b6:303:8c::10) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CY8PR10MB6730:EE_
X-MS-Office365-Filtering-Correlation-Id: a2751397-666d-4a53-5270-08dbbe21ff32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LArM927dLM33lUpMgw9ceM9vDGwF5A+LYEe9pKEE8ZtUG6l8mh1K5bb9alSFqhPfYZBO4FKHgl8Q1pqs/GZbj4hpjvQUpADz8xmr6MGJD+Kuu7nogf5Q03SUOjFltBxmGet40Ss3Tfr771NSqYLdMM9EbW3OnXCOjrgEOXfaZ/SbJRjDUcWCGaCo9753x0Xmlmfba6ogPqSrBYginR6NRdQmtMQNpsOLbvpBIlnXoOsUZhqFfvaiwjmzhMCx3FNjn6sV9KTO16QxJKOdelX7qFfgvdec7Gg46rJ/bNyHu+c4Z0o1TUmJLWGRi8M/DgfFjstZYsdxyHxPx+hV+k7pHI2jhjwkxizXFnAmOc99hHs5SY6SoCufMKf7eKWH8cannmboyvF3K9iI2CiGoNRpRkSDO4eQZc0GDjWdU5cO9Ynv6Ocy0RrNeG0oTkEc/NT1sUIgoIuMequZsamaUGRifKoTwaAJ3J8vJhjPFlNTF82eMCbI4MlCoewXd91nSCy2JdGzgTIMIK1TwyhnlVab8mt15GfSY5TmKVSehbZNidVEN9dGaCAdAgbnU+I3Dz1H
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(366004)(376002)(346002)(230922051799003)(186009)(1800799009)(451199024)(478600001)(6506007)(6666004)(6486002)(1076003)(2906002)(2616005)(5660300002)(6512007)(7416002)(54906003)(316002)(107886003)(66946007)(8936002)(66476007)(8676002)(4326008)(41300700001)(44832011)(66556008)(26005)(38100700002)(36756003)(86362001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jjYlHVmXbFK9XFU6jg7b0rDR4Kxzxm+sgeSwTVf+UeWzviNrlAhAutxA0mA+?=
 =?us-ascii?Q?iULi151QeovUJQ+LOP5UG4kXUnVMn7GEo0GQ7sGK0WpjvV6NZoPniLqqdEEH?=
 =?us-ascii?Q?lMcDZwTwtrkgVQsfrH0YKOBbnmF+RX5s0CCkjpj/8wrHac5h4rEATV+Q/hiQ?=
 =?us-ascii?Q?Buy8DfuQiP5Oc+1RQlX1TufKooZYQ051f4WX2flqU9qJ7q6yOcvAiSkmjQZp?=
 =?us-ascii?Q?YWOvxfCrrnizL5pgAXEjnzlRthwmtyH+jV56MrABm1S6in/bTv+icwEooTxZ?=
 =?us-ascii?Q?7Xj09V8v9eeqL+RkGLCDbtze7ljV//BOCAUTc1/RZaoceqsbpzG9uPmJG2QL?=
 =?us-ascii?Q?FOD6vI7RZIajQW4OTQ+KZEtxSGiZ/e+JS7kahXGDpmwnjOkXhXVaY4cxpkjM?=
 =?us-ascii?Q?tPV3KK28iQvHXF/hoj90pFDzRBfMHJ6HPemdR7JpaNaAb6OZCfgbnjLn6IjM?=
 =?us-ascii?Q?aiiDa+/ZBySuEJETyrALpF93Nj+s+O+ntLhH/AVzK0wozdxG+SodlRIruoul?=
 =?us-ascii?Q?5DZMOS/tWnBhKru9fjO+H0n7C0dRtYrU4RWKXgnpbJ8XXpvW58vQGpT73qEk?=
 =?us-ascii?Q?iPlyv+HwInsKtZEKcbiatNjGOxl4OZf7BA+9IuzGe2tJuOzu8z+qQZ+PLM5l?=
 =?us-ascii?Q?G/ovL2beC4cm5rU6LIv9lpUYpucNlYAoZZMCgw8edP/+krK/O1evEDNvpP+y?=
 =?us-ascii?Q?NAZDI/fnF9t19g2WgEkr6D4ae2HHAMUBBukqKjuXH1W++mIJXhU653zSjlD5?=
 =?us-ascii?Q?uaYR1PHf6Scmjg2q72pVIiJYff5+Zj7K6Ajks72EXoHyVPBe0HCewvrr9lQp?=
 =?us-ascii?Q?Q51L61e1d7YXfUasN1XmzCe1QPpduRL9UvYnZQXXLclpueNqGn8nKO6WhKiE?=
 =?us-ascii?Q?2BN+UDMaCGj+Zgbran7exfDjhgtxi2unh8mpcwddkPHe8bpY5UTThn+ozZzo?=
 =?us-ascii?Q?kAILbf83pmHb4nBjrE+A1TOQgWGjUt3aBVH2D0Sg7txJyP060hfbEAvhkyZb?=
 =?us-ascii?Q?vd4B+9z5gg/4qT0+DWXEkbF5S3OpRwKblt1sMnyfrQqdYDUPopeswO+/ues4?=
 =?us-ascii?Q?hTfrp0p98P6Ztv8R6RcpFx4r8ASxkMGI4RQ9CxjGxW3/J6w6ui6+HufT3W+7?=
 =?us-ascii?Q?PFFYmB34DPRL44bAbFbo8zwhTsENWWnJv9dTmOrYlqQuHAD1rEXS4iqEFlgP?=
 =?us-ascii?Q?awNmjGRDyqJVprKfkjVvcxSDpnhmmAdtlFjX9AFN5e0FhU+NU2oNI2C9y4y4?=
 =?us-ascii?Q?3EerlvxIzLPzgYtKaYHIzhWGP2vr5geVmqN7/JQieZgeaPTDmg73TUZRxhL6?=
 =?us-ascii?Q?TqTLVCAJayEJtzZ8tMAieymsG4qFuPECN7miGg57HTdnhwCZqnqmpoHRl9xX?=
 =?us-ascii?Q?DuXcXgsccG1imXJ8b3vtRvUCiA3d+VMhYFAOIGBOrL87XAYNlV3hI3iGSyly?=
 =?us-ascii?Q?LBe24MRT78f/WYcb1/Jq0GV6nIn//6/AIy547vuwsiYDHi988XV+16/PdkM0?=
 =?us-ascii?Q?gQ2xIT+Z8MN4INTfKbTOXiwZv5uQhkccSsVYtGZS1cPQN4ErJJcOpzEAD+z6?=
 =?us-ascii?Q?BEZwdQFCcCscJFVeqhwgDqbCbf8TROcxfxv92w6f8uphBdUbyIaLm3Y/+M8f?=
 =?us-ascii?Q?7A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?FvaRKkpSAsiVFUJIZuumIOLhxNft/fsR5Q2ihL1/hzM8VFbMbXEzbUfmlUOY?=
 =?us-ascii?Q?RsY+VXWep9I3dlCyRteL0h+ZSdDIbJM/oDhnlk3UhU8e1U1dJ8XV2EIc4IOy?=
 =?us-ascii?Q?0R0kwNFhquzTkhObjOEufK7WhHNTemv4OgX9YZ1VDVPAWmNVy7FhQqDmFQ8M?=
 =?us-ascii?Q?yCIjKKSpiH/LQkt+B4EDl/crla1uAZTuTiyyNvLjPoA2iAwcZ43+Ubm9cP5g?=
 =?us-ascii?Q?84td5tcpog46ekzRJ4McXM5rkRGJgguaC5Ys2Ku08OzlpRW2RkuyPxuhqvrl?=
 =?us-ascii?Q?Eiaese47hM3Es9/HfbKc7EJ/dfK69uHkuuuBgSJx9bn3MYRSkjtVmKxCcNyS?=
 =?us-ascii?Q?OtBc4rH0frw/X5zXc4frrVCRgwTREAhnuszvhPADruxlAQRIXuSrV3CVZNBh?=
 =?us-ascii?Q?6ypOqT+YqB4sqjpvP1rcpivwnxnuGRLPjtvwS9gh82RxwhxjBEBHEzb0L9OP?=
 =?us-ascii?Q?2mEfbe7BqcLQIxMJAeT3lDb6XR5UmXOfYk9hnguJkGd9MwhwmaZAvyCPBCsc?=
 =?us-ascii?Q?omtU3i1kNHx5y5wIKIax/WviNNwgREdx8aZLW/ihKpclUtiGmWC5TY73/fNu?=
 =?us-ascii?Q?wBbvHcAhTsfdstM/G0Qboz7Fo0Dt+b8TbbeSVo4NP7kq066o5TyFs58pIVzk?=
 =?us-ascii?Q?vhAZENA5Tb+QsYtHRgqVUW8z48DqAfGCL0qU79uM9BaYMUh47yhcj0Mlv9Rt?=
 =?us-ascii?Q?hanHtkLun57AjLwpjkCEuXi051DsRRTsMBfNju610C/8kzLJiQvA5e9sQpx+?=
 =?us-ascii?Q?2Gz879AtTouaz05viywQe3YAy/oIJA5o2uzMn9RqmyMcW3jf2eRuXiUt5kEX?=
 =?us-ascii?Q?SvaqO79AS4EHKSFKd9VvUdbLl4hR7sK4vAU7N+U69lfEq7jim2LwUhyA9coM?=
 =?us-ascii?Q?DdBzX4KceZnIZaFpVG26GSKcuFlk1nr0Anado7InFQMmrbFW44bxPHxhVcqx?=
 =?us-ascii?Q?dpAGOxQJ3DU/Sis/QFpE9C26vPqIeAPohZpO0IeAPDDNohTvf+WY4J6lvlan?=
 =?us-ascii?Q?Yu7ccDxbU/PwqvoiGG1ccgxpyPdTTT55iJYdnneNCZ9SoqV5PXJqoLdVgiA+?=
 =?us-ascii?Q?IzbOo151K85M4Pay5BXbSSIW9xrQKpgF76iGwbBg4SDjwRFT1HDcrcHIraEE?=
 =?us-ascii?Q?uKIjBfod6l4Y?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2751397-666d-4a53-5270-08dbbe21ff32
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 23:49:03.0562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u4eGjld0LxFsIGAYClQpmaOJZZC8fvwoILCsx4UKbAQggmJHiK7rcdol5JvFvzt493qbrp+5MnEIhevgI3pANQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6730
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-25_18,2023-09-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309250185
X-Proofpoint-GUID: hvMi1pojaw9HmLZcxevzTBP5YCmST8na
X-Proofpoint-ORIG-GUID: hvMi1pojaw9HmLZcxevzTBP5YCmST8na
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joao Martins <joao.m.martins@oracle.com>

In an effort to minimize amount of TLB flushes, batch all PMD splits
belonging to a range of pages in order to perform only 1 (global) TLB
flush.

Add a flags field to the walker and pass whether it's a bulk allocation
or just a single page to decide to remap. First value
(VMEMMAP_SPLIT_NO_TLB_FLUSH) designates the request to not do the TLB
flush when we split the PMD.

Rebased and updated by Mike Kravetz

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb_vmemmap.c | 92 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 88 insertions(+), 4 deletions(-)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 4ac521e596db..10739e4285d5 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -27,6 +27,8 @@
  * @reuse_addr:		the virtual address of the @reuse_page page.
  * @vmemmap_pages:	the list head of the vmemmap pages that can be freed
  *			or is mapped from.
+ * @flags:		used to modify behavior in vmemmap page table walking
+ *			operations.
  */
 struct vmemmap_remap_walk {
 	void			(*remap_pte)(pte_t *pte, unsigned long addr,
@@ -35,9 +37,13 @@ struct vmemmap_remap_walk {
 	struct page		*reuse_page;
 	unsigned long		reuse_addr;
 	struct list_head	*vmemmap_pages;
+
+/* Skip the TLB flush when we split the PMD */
+#define VMEMMAP_SPLIT_NO_TLB_FLUSH	BIT(0)
+	unsigned long		flags;
 };
 
-static int split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start)
+static int split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start, bool flush)
 {
 	pmd_t __pmd;
 	int i;
@@ -80,7 +86,8 @@ static int split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start)
 		/* Make pte visible before pmd. See comment in pmd_install(). */
 		smp_wmb();
 		pmd_populate_kernel(&init_mm, pmd, pgtable);
-		flush_tlb_kernel_range(start, start + PMD_SIZE);
+		if (flush)
+			flush_tlb_kernel_range(start, start + PMD_SIZE);
 	} else {
 		pte_free_kernel(&init_mm, pgtable);
 	}
@@ -127,11 +134,20 @@ static int vmemmap_pmd_range(pud_t *pud, unsigned long addr,
 	do {
 		int ret;
 
-		ret = split_vmemmap_huge_pmd(pmd, addr & PMD_MASK);
+		ret = split_vmemmap_huge_pmd(pmd, addr & PMD_MASK,
+				!(walk->flags & VMEMMAP_SPLIT_NO_TLB_FLUSH));
 		if (ret)
 			return ret;
 
 		next = pmd_addr_end(addr, end);
+
+		/*
+		 * We are only splitting, not remapping the hugetlb vmemmap
+		 * pages.
+		 */
+		if (!walk->remap_pte)
+			continue;
+
 		vmemmap_pte_range(pmd, addr, next, walk);
 	} while (pmd++, addr = next, addr != end);
 
@@ -198,7 +214,8 @@ static int vmemmap_remap_range(unsigned long start, unsigned long end,
 			return ret;
 	} while (pgd++, addr = next, addr != end);
 
-	flush_tlb_kernel_range(start, end);
+	if (walk->remap_pte)
+		flush_tlb_kernel_range(start, end);
 
 	return 0;
 }
@@ -297,6 +314,36 @@ static void vmemmap_restore_pte(pte_t *pte, unsigned long addr,
 	set_pte_at(&init_mm, addr, pte, mk_pte(page, pgprot));
 }
 
+/**
+ * vmemmap_remap_split - split the vmemmap virtual address range [@start, @end)
+ *                      backing PMDs of the directmap into PTEs
+ * @start:     start address of the vmemmap virtual address range that we want
+ *             to remap.
+ * @end:       end address of the vmemmap virtual address range that we want to
+ *             remap.
+ * @reuse:     reuse address.
+ *
+ * Return: %0 on success, negative error code otherwise.
+ */
+static int vmemmap_remap_split(unsigned long start, unsigned long end,
+				unsigned long reuse)
+{
+	int ret;
+	struct vmemmap_remap_walk walk = {
+		.remap_pte	= NULL,
+		.flags		= VMEMMAP_SPLIT_NO_TLB_FLUSH,
+	};
+
+	/* See the comment in the vmemmap_remap_free(). */
+	BUG_ON(start - reuse != PAGE_SIZE);
+
+	mmap_read_lock(&init_mm);
+	ret = vmemmap_remap_range(reuse, end, &walk);
+	mmap_read_unlock(&init_mm);
+
+	return ret;
+}
+
 /**
  * vmemmap_remap_free - remap the vmemmap virtual address range [@start, @end)
  *			to the page which @reuse is mapped to, then free vmemmap
@@ -320,6 +367,7 @@ static int vmemmap_remap_free(unsigned long start, unsigned long end,
 		.remap_pte	= vmemmap_remap_pte,
 		.reuse_addr	= reuse,
 		.vmemmap_pages	= vmemmap_pages,
+		.flags		= 0,
 	};
 	int nid = page_to_nid((struct page *)reuse);
 	gfp_t gfp_mask = GFP_KERNEL | __GFP_NORETRY | __GFP_NOWARN;
@@ -368,6 +416,7 @@ static int vmemmap_remap_free(unsigned long start, unsigned long end,
 			.remap_pte	= vmemmap_restore_pte,
 			.reuse_addr	= reuse,
 			.vmemmap_pages	= vmemmap_pages,
+			.flags		= 0,
 		};
 
 		vmemmap_remap_range(reuse, end, &walk);
@@ -419,6 +468,7 @@ static int vmemmap_remap_alloc(unsigned long start, unsigned long end,
 		.remap_pte	= vmemmap_restore_pte,
 		.reuse_addr	= reuse,
 		.vmemmap_pages	= &vmemmap_pages,
+		.flags		= 0,
 	};
 
 	/* See the comment in the vmemmap_remap_free(). */
@@ -628,11 +678,45 @@ void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head)
 	free_vmemmap_page_list(&vmemmap_pages);
 }
 
+static int hugetlb_vmemmap_split(const struct hstate *h, struct page *head)
+{
+	unsigned long vmemmap_start = (unsigned long)head, vmemmap_end;
+	unsigned long vmemmap_reuse;
+
+	if (!vmemmap_should_optimize(h, head))
+		return 0;
+
+	vmemmap_end	= vmemmap_start + hugetlb_vmemmap_size(h);
+	vmemmap_reuse	= vmemmap_start;
+	vmemmap_start	+= HUGETLB_VMEMMAP_RESERVE_SIZE;
+
+	/*
+	 * Split PMDs on the vmemmap virtual address range [@vmemmap_start,
+	 * @vmemmap_end]
+	 */
+	return vmemmap_remap_split(vmemmap_start, vmemmap_end, vmemmap_reuse);
+}
+
 void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_list)
 {
 	struct folio *folio;
 	LIST_HEAD(vmemmap_pages);
 
+	list_for_each_entry(folio, folio_list, lru) {
+		int ret = hugetlb_vmemmap_split(h, &folio->page);
+
+		/*
+		 * Spliting the PMD requires allocating a page, thus lets fail
+		 * early once we encounter the first OOM. No point in retrying
+		 * as it can be dynamically done on remap with the memory
+		 * we get back from the vmemmap deduplication.
+		 */
+		if (ret == -ENOMEM)
+			break;
+	}
+
+	flush_tlb_all();
+
 	list_for_each_entry(folio, folio_list, lru) {
 		int ret = __hugetlb_vmemmap_optimize(h, &folio->page,
 								&vmemmap_pages);
-- 
2.41.0

