Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D13F793138
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 23:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242290AbjIEVqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 17:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239870AbjIEVqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 17:46:24 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A22ACFF
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 14:45:44 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 385KnUr0009073;
        Tue, 5 Sep 2023 21:44:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=9OHDnOM7r2zXSFQchXv90fCms9LW5vnW7SnIblTgvg4=;
 b=JD/CLYXMNcfjyU9zGUIRWuw289c8sZEP4xb83rcUg5XllDy+SUMxKNF1p2TxgmQeLNqM
 NePN9cjIlB1sRAs9nbAQv4W/pF4Byv3C3AzQritmPr7hU4jxaC+O5IIpfbBzOAR6MG66
 VkBoV+Ma0b9TpNRuqUtETAtGynn/p9RhM/yTdH9/LD575QEe7Vh6Ftjk2PBHXmx/nPtd
 THvBcTqIB+yASpzauDM1gC24eoSz42rCTZeUljPIe2tgOpwhW94QU45GZ4vNtniPfp1o
 7uzzJai9Ommf+sbx5DSlSkH5/XoTiCZz33lPgSDo6gWjYOm3URJcN/aV12tTet+0P9mq /w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sxbq383ry-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Sep 2023 21:44:47 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 385Ju1RQ028130;
        Tue, 5 Sep 2023 21:44:46 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3suug5bd40-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Sep 2023 21:44:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C66doB5EX305ipq1I904tXWTrj6YEOf4hwvjfKfuYSeOAeheYrMLO2hCDzcxIkZPOED3kELtPnQcf0RY37q/herkQD+tuPRmhJ28bTFpcv1NejdIuJ8dISjAHtUIybjuxpzTQAYFDGgy7S26my+L4mK1hZznYYZUBC6qaQvduLq7U3Ez+c7Tmwww+5jKWX572ayPsc/KdEwv7nNeYeGWLZJoVluitxno3Nc1CYVDDsgxFvK9WqyCq9DJwPFsQ9LlLYBW9wX4ZhZmTLwfFlhgx0Wm8x0pjOKRcybg4JHkk5y/637N0G4/mW7x16kimCTrlQ9hVjFzREoHUw3TXCiWug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9OHDnOM7r2zXSFQchXv90fCms9LW5vnW7SnIblTgvg4=;
 b=kGLRpt0LjeTOsXwe+KtnQZKt8W9SKK+cvJdZ4XeriQpn0KoaIqyx3Gts9jPEEU5enbMvVUzcT70Iznq0lZ5Wq2eLWDWcRRUoG+q8k+nj91h7Htv5EXS8KpfBWCOWvpyspZFRf8Y4SUEORwI6na7YfgVZhT69rJDaRpb5eEPy6HYvqWMmAVlJo6lm7N28XBBQQVWhRLWajuPaLQpthRFrT5cVLkTB8bE0IfnWEvCMGH9qJqbeqHmfHkvhW9Wk4Ql/cXie/84Z7opWhW9nbqGwc/I8N6corneEHHDgfZGsEOTMxJEIM6kK6Wb0tZMWXyEoHpmTnQicA7sit9dw8/9vAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9OHDnOM7r2zXSFQchXv90fCms9LW5vnW7SnIblTgvg4=;
 b=JBpISu3+fXqYxr2r7LawlV4hI25J0MMlxp5xXY0onI9+UJKlenpilEwAZQjWythjLjQpLW6p7bUJE2OJV8q89UouXTRR2RUOifSLr+69+y6mBln7G0XlydLJCJopLpf1wkLNu28/3TkBEOJs6zkxuiOTn0vG4TvpNUgaLrPg/BI=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MW4PR10MB6395.namprd10.prod.outlook.com (2603:10b6:303:1ea::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 21:44:44 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::58d8:cf97:ae4b:1715]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::58d8:cf97:ae4b:1715%3]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 21:44:44 +0000
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
        Barry Song <song.bao.hua@hisilicon.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v2 08/11] hugetlb: batch freeing of vmemmap pages
Date:   Tue,  5 Sep 2023 14:44:07 -0700
Message-ID: <20230905214412.89152-9-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230905214412.89152-1-mike.kravetz@oracle.com>
References: <20230905214412.89152-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MWH0EPF00056D13.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:16) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|MW4PR10MB6395:EE_
X-MS-Office365-Filtering-Correlation-Id: b300aa6c-3d1a-428f-ae49-08dbae59517f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: acLoCcx0XUDElInN06zaVDaXD9S3Gpl7HeOkCghmz/7QN1mH3QbohRCpwBzgYVe8sBOwP/4VPaDGAi9hV7aCguZoL47YjPNe0JJYznU3saHCEIAYaq4BWzcKfok/7f7wMPfmOhJL/0rxbRSYTxSJzNX9l1IN0Npdg75xPhCxv8fIByRttx5AGi5M8qhgm1ALvL979vvKla5JtAyb2dN0zDPT0ivpdyZfBWLRabkSGf9AJZFJFV3y7R66uezyDqycXubvG95/9MUBzU5gNnqRslitBQjS9TJMyKnENoK2jZs0GV5Ae8GVj9JmlxP8YPm+JyC8+PvOtQj9bwncrEkkNMUK1D8VSikEMrv1sKMGgLjkbFy7RJ8XSva/Jmnjg1BWSF43LdRnIQL/BwOD7xznn85svLCgaCu7A+UhqtzlcFwN8Sh9QkdO1GrXgWtE1keCUCOOPcMGlY7edJkZV70aKNPeIlVyhfWB35WeGtdFhAlC1wbE5wxpFGaji08zFusObeiKnf/HaXQJyG8EydVc/sWwkUJGbnzWoJd8HPry8jJw49+l8r156WR/g8zkvoze
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(39860400002)(396003)(136003)(186009)(1800799009)(451199024)(6666004)(6486002)(6512007)(6506007)(478600001)(38100700002)(2906002)(7416002)(107886003)(1076003)(2616005)(26005)(83380400001)(86362001)(36756003)(66946007)(5660300002)(54906003)(66476007)(66556008)(316002)(44832011)(8936002)(8676002)(4326008)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4cejnJjIGvgFWisxePGHPVDX8+52ZQosziP9oIkt9QGXTp3HlM5h0vahPlhh?=
 =?us-ascii?Q?Mo0m5tDoGpywIjerOVUkEIu14kPQHUkWGyAHtzFuNEtXDaUJ1wy/3t3+criR?=
 =?us-ascii?Q?B/w/mNsS6XzOOssHv0AbaiRBhI8olCYFsLXigv18RDKiYOUsYzor88gHjt3d?=
 =?us-ascii?Q?7zNGw5cJDbeblg9ux3VQwLfeJvJnLH/v0M2vozpDC/JIyVZyIOugl+o6aIEt?=
 =?us-ascii?Q?ZAg6weNCzZFtBdTB1285jXTd7hiPKK14qSdY/SI23AO3n/gB8OMJuTL7VX5X?=
 =?us-ascii?Q?5h4AA9gx4hlXPoN0Jv7l4wJX3fSR4fjk0+X1PyklMSyTMOegc7T1FljHeHrQ?=
 =?us-ascii?Q?S7/A0vIJ5BYbU3YZpdQNAerXDPBvca3uDbMuZPJ8VQL5UsrlO85xdPAOROJa?=
 =?us-ascii?Q?4SnyXID9TrkoPqu7GLVu0lB8GcaRDjRz4tXJzyKENwd3UFTJFT1yykIbN3X1?=
 =?us-ascii?Q?1lcn4Hqk0b/oO99KIEIPEjH0mK5jetd9rzSqxHyJPpsxugstTzSQigUBOix1?=
 =?us-ascii?Q?zA8+hwuNE1JaKSRKwVQ+OcMe1bXAl6T4JMAqmgg7xCmSYqVnEixlePdSbO5b?=
 =?us-ascii?Q?vf/FNlKvl1O4fq/OW7d0GyJZ03fr7C6pLQNaX/huOQTg/miVig081X2S/gN1?=
 =?us-ascii?Q?xb7isdWcLac5hpuAeceqMSMU1C2epNGD3nVhYbpiVgh4m2hCG7ti4I9heJzU?=
 =?us-ascii?Q?/T66umCaS0mqTC+AXuKwGDehg3gmez/qTYjqC3gVX/ix160royhtddyvd8ND?=
 =?us-ascii?Q?iru9NGQeIC+zwLu/HZ0lnq1QqMGIN3ezs0HeGts5Z9X1RrACHZg7fWCAqMj0?=
 =?us-ascii?Q?/AOGKBgbG/donybShya4Aw2tTmQUvgS0TP+ZQep/Uh3Ksl6YtCxxooFPypEa?=
 =?us-ascii?Q?coeO0MrYancyivGQjTPs8OxU0/0Yr2d5RvvQEbrr4rzqpkQqqUTTH09m1iNM?=
 =?us-ascii?Q?zZOdShV5c52g5H9KpU5oiHQXnsiwyQKyGKHzI2oHNJJA3diwPv/MMz/svLh2?=
 =?us-ascii?Q?UrYb4h/pc+SuB9vGH6i2cn/U+hCiA9pFeC50r0hpRix+x6Y3teZQG+IMZRkR?=
 =?us-ascii?Q?1G5ddAPRIwW8ISYuZ3EDMpn2D+7+5Z1Y7Vl5s6WMoxBUiTyc5W0W8z8O7CKx?=
 =?us-ascii?Q?sBeysRHDLO9jmj4Ge6B8kUA4Dl4aGDAwwU2UNkJRkgX6/35gV21UCmYoL9B1?=
 =?us-ascii?Q?o1BNjlvQJXz8+hdjTNHWQgcZ/60wnofVdEq6BmSRrS45iZaVe77iwsa0Ohcu?=
 =?us-ascii?Q?NMs6TBrGqOsXmFj/Tb/OOxsYayGjNNBoI/tVPaXwSJ4/Ju3i06VFb1VHMpll?=
 =?us-ascii?Q?R7FFr2WIgRCAsMlwQFNC94NCwT2PBmUkYTh0sHD9EHzf4tP1+e9KUFN5Hn53?=
 =?us-ascii?Q?z37927wmnn3Lrwe4BNSqUvrYkkwzkq923WuYIaWKKbAXmoSIoPCcVh9lbiax?=
 =?us-ascii?Q?jJ9mEviCzMZAcY8/4OjkSu9HcWl/Hurf7/PFF8KvDGQNTQGJbkvzVuTYNhdr?=
 =?us-ascii?Q?986BrOwLsqa/+CvEYd38OXvH31rQrdHpE43r9J38hz7k8hMtUkyNKUsRFRt1?=
 =?us-ascii?Q?INbH+LJfJAd9I8o+ICeCLbuYLWUQwyIncoWyU9eGIk6uizE44j7uV0nEeRHB?=
 =?us-ascii?Q?GQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?lMnKV1pzyydX1lFrd0p4wMPQAjPQ4YhsTDN7eBSTLcTAsA+B1RfZCEbHQ7bR?=
 =?us-ascii?Q?538oWP5Pbo2/8FfipTpXAmC7oS56C7+4Dp2tV91y652CP4SgGb9j4yB7xC/A?=
 =?us-ascii?Q?lLpaY7SnPGBSR0LK1MhoviZU18eMFXl5R+t5NE7oYzTpnMerHFt4iXdUH0q4?=
 =?us-ascii?Q?EsJRiu3pAZstKqStWRXfPjCOhdCv3JsrQD9CYSgAr5qzhIlntqWh8BCvvRES?=
 =?us-ascii?Q?igdjOmzckCjkMP5li7e8L4ztMjePxvDWpP/7NGRhKuEyYiZOtMANkQomRiOM?=
 =?us-ascii?Q?DqZMX9pwugFWHBVlUv/QRnyTHxV2+eKpcEjrCrzk4GC1ZSgtbSsWdR10oclx?=
 =?us-ascii?Q?9NyfgAw4ZIFBnyUiZ4LZP2xUmZ7u4otXPmbofPxD7lvcdeRyMBMiePMDZgr4?=
 =?us-ascii?Q?yX1cJZHLXrCqyhtwY0wELJoF4iv2rYrdidkY3Jx42QM3hSthOKEO4WihkzHv?=
 =?us-ascii?Q?D7aAFz9r0F4BZtJARQt1Wd4oGDg39K3bvmqq3toqIpV61WF+KkLLsLWg1wnu?=
 =?us-ascii?Q?g2l//Q0t4BfPdpJyQN0vzbHECEbnPHA4dTYZiETOcF9mr1S3pnstGz2EICD/?=
 =?us-ascii?Q?k/6I21WPH3KaQdIlUMLNx0PqnWNPTIAaKSxwnttmLl/i/WVSo7f1WkcFLaY4?=
 =?us-ascii?Q?5hAI5ReEsoBWFonw+K91+zsJ9h4hYqxsMJoKUCAhamIKpOOkdSlsm+D7hXR9?=
 =?us-ascii?Q?xTQ6BL5BpywZ7Zv1s5Gipo+rqp1ljqo79DXk0EyAVVi22OjKFWwddxUUBw8r?=
 =?us-ascii?Q?lJ04waO+yqaIGVEJigamgs4PofvrRiniX8YMMYMnWLtcR+ZuBkWFdHvkXKdM?=
 =?us-ascii?Q?RBQTJUYmz5O5fAiHGFSw8iEjh2b+m1vT6Tyzg6/WBX/KM1b/bNDgHFbgPUjb?=
 =?us-ascii?Q?2X3euaxJ6rGi1mNqEwrn8iJmSVFnyPYPWJxRowndZPO5br3d8lYxeZTJYu9t?=
 =?us-ascii?Q?L92gRjg89feLqllaE4xjSDPE+lLr4qZQtDQ9upmMXM1n7Jxqvs6QX353r969?=
 =?us-ascii?Q?B+xp4eGTFXCUKf84Z5hv0up48BJZImbTV7K9w+KIyu6jwiCMm6wN3X3J2k65?=
 =?us-ascii?Q?JKySmyt2Oo9dMsxppEcdU/fG25G8g3dlgn48Di7NBRgVUo2ZJFMs59zBpcAc?=
 =?us-ascii?Q?fkZstVY9W28Y?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b300aa6c-3d1a-428f-ae49-08dbae59517f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 21:44:44.7016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zf8C2iTmbE9lhFCG7MR15a0nW2EdzW8LSBKT5pFYJAuRgvOLWBLUHuxnhb+Rz3ICtDqMkuKqnvsZypln2vsv0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6395
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_13,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309050189
X-Proofpoint-GUID: VNfSrgJj8je6MQ2GCXhsRo5SHFZk5JTG
X-Proofpoint-ORIG-GUID: VNfSrgJj8je6MQ2GCXhsRo5SHFZk5JTG
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that batching of hugetlb vmemmap optimization processing is possible,
batch the freeing of vmemmap pages.  When freeing vmemmap pages for a
hugetlb page, we add them to a list that is freed after the entire batch
has been processed.

This enhances the ability to return contiguous ranges of memory to the
low level allocators.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb_vmemmap.c | 60 ++++++++++++++++++++++++++++----------------
 1 file changed, 38 insertions(+), 22 deletions(-)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 79de984919ef..a715712df831 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -306,18 +306,21 @@ static void vmemmap_restore_pte(pte_t *pte, unsigned long addr,
  * @end:	end address of the vmemmap virtual address range that we want to
  *		remap.
  * @reuse:	reuse address.
+ * @vmemmap_pages: list to deposit vmemmap pages to be freed.  It is callers
+ *		responsibility to free pages.
  *
  * Return: %0 on success, negative error code otherwise.
  */
 static int vmemmap_remap_free(unsigned long start, unsigned long end,
-			      unsigned long reuse)
+			      unsigned long reuse,
+			      struct list_head *vmemmap_pages)
 {
 	int ret;
-	LIST_HEAD(vmemmap_pages);
+	LIST_HEAD(freed_pages);
 	struct vmemmap_remap_walk walk = {
 		.remap_pte	= vmemmap_remap_pte,
 		.reuse_addr	= reuse,
-		.vmemmap_pages	= &vmemmap_pages,
+		.vmemmap_pages	= &freed_pages,
 	};
 	int nid = page_to_nid((struct page *)start);
 	gfp_t gfp_mask = GFP_KERNEL | __GFP_THISNODE | __GFP_NORETRY |
@@ -335,7 +338,7 @@ static int vmemmap_remap_free(unsigned long start, unsigned long end,
 	if (walk.reuse_page) {
 		copy_page(page_to_virt(walk.reuse_page),
 			  (void *)walk.reuse_addr);
-		list_add(&walk.reuse_page->lru, &vmemmap_pages);
+		list_add(&walk.reuse_page->lru, &freed_pages);
 	}
 
 	/*
@@ -366,15 +369,14 @@ static int vmemmap_remap_free(unsigned long start, unsigned long end,
 		walk = (struct vmemmap_remap_walk) {
 			.remap_pte	= vmemmap_restore_pte,
 			.reuse_addr	= reuse,
-			.vmemmap_pages	= &vmemmap_pages,
+			.vmemmap_pages	= &freed_pages,
 		};
 
 		vmemmap_remap_range(reuse, end, &walk);
 	}
 	mmap_read_unlock(&init_mm);
 
-	free_vmemmap_page_list(&vmemmap_pages);
-
+	list_splice(&freed_pages, vmemmap_pages);
 	return ret;
 }
 
@@ -553,17 +555,9 @@ static bool vmemmap_should_optimize(const struct hstate *h, const struct page *h
 	return true;
 }
 
-/**
- * hugetlb_vmemmap_optimize - optimize @head page's vmemmap pages.
- * @h:		struct hstate.
- * @head:	the head page whose vmemmap pages will be optimized.
- *
- * This function only tries to optimize @head's vmemmap pages and does not
- * guarantee that the optimization will succeed after it returns. The caller
- * can use HPageVmemmapOptimized(@head) to detect if @head's vmemmap pages
- * have been optimized.
- */
-void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head)
+static void __hugetlb_vmemmap_optimize(const struct hstate *h,
+					struct page *head,
+					struct list_head *vmemmap_pages)
 {
 	unsigned long vmemmap_start = (unsigned long)head, vmemmap_end;
 	unsigned long vmemmap_reuse;
@@ -580,21 +574,43 @@ void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head)
 
 	/*
 	 * Remap the vmemmap virtual address range [@vmemmap_start, @vmemmap_end)
-	 * to the page which @vmemmap_reuse is mapped to, then free the pages
-	 * which the range [@vmemmap_start, @vmemmap_end] is mapped to.
+	 * to the page which @vmemmap_reuse is mapped to.  Add pages previously
+	 * mapping the range to vmemmap_pages list so that they can be freed by
+	 * the caller.
 	 */
-	if (vmemmap_remap_free(vmemmap_start, vmemmap_end, vmemmap_reuse))
+	if (vmemmap_remap_free(vmemmap_start, vmemmap_end, vmemmap_reuse, vmemmap_pages))
 		static_branch_dec(&hugetlb_optimize_vmemmap_key);
 	else
 		SetHPageVmemmapOptimized(head);
 }
 
+/**
+ * hugetlb_vmemmap_optimize - optimize @head page's vmemmap pages.
+ * @h:		struct hstate.
+ * @head:	the head page whose vmemmap pages will be optimized.
+ *
+ * This function only tries to optimize @head's vmemmap pages and does not
+ * guarantee that the optimization will succeed after it returns. The caller
+ * can use HPageVmemmapOptimized(@head) to detect if @head's vmemmap pages
+ * have been optimized.
+ */
+void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head)
+{
+	LIST_HEAD(vmemmap_pages);
+
+	__hugetlb_vmemmap_optimize(h, head, &vmemmap_pages);
+	free_vmemmap_page_list(&vmemmap_pages);
+}
+
 void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_list)
 {
 	struct folio *folio;
+	LIST_HEAD(vmemmap_pages);
 
 	list_for_each_entry(folio, folio_list, lru)
-		hugetlb_vmemmap_optimize(h, &folio->page);
+		__hugetlb_vmemmap_optimize(h, &folio->page, &vmemmap_pages);
+
+	free_vmemmap_page_list(&vmemmap_pages);
 }
 
 static struct ctl_table hugetlb_vmemmap_sysctls[] = {
-- 
2.41.0

