Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D61137A560C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 01:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbjIRXDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 19:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjIRXDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 19:03:36 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B5110B
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 16:03:21 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38IK4vGV015829;
        Mon, 18 Sep 2023 23:02:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=9QgPmeLLE6Ld0BB2W1wJ/WRXNP2Ic8blIblUcqvJ17E=;
 b=Io9M3ipDha8sntlnBYcpAiN2zw6oc99hf+oW9rD0GUJOu9FMlebDAMALDtXr2Pl7Klji
 ejCW6BL+x0IiUj+iKb4LlwQnCq4jw/qnMqTryhjmG5o/GkDkVYFT/KDHbuwyCikO1tGX
 /JIMxeR55vLn/ZLqlhyBtzQE2gfR529HwUZVAmVhfwaYlk684OcE8+6rWvBh6cb3DC+D
 TFI1ByXxuVfKUV936CYUru5/DwVcx1fSrdUc4lztDInjjBcC5CeLZJFg17RXcM0odkAX
 7T5v8Lx0S3PoqrnH0vFto0HilTmVeU7ONOwz8iHX7YYj2lW3abrJ3ljrQ9PJcAIzqg2I /Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t54wukkme-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Sep 2023 23:02:22 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38ILkqos012129;
        Mon, 18 Sep 2023 23:02:21 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t52t55a0b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Sep 2023 23:02:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SJb3PUskidDPxM61y7DqRnqOptoSvOo9qdXj+NJmLR881DWyYS1RapchRgmbdMTieN5WxDfOWRogQvNYKiDMnnwJ2XMp35+wJx9WZbSf1xk0nnUCblOunShoELe3YGljMbUSFpHanKt0Rf425cyzUToDz0D4SeK+hRBeTMaE9nFD3f2VHouORKt0zFfFSE9yhFWpv2/5D7LRMWBe1UmT9Do3rxCd4tm4s1dETzb749N4B/lafa5X+s4Wj6cITPhp/zgz/JOG77tsaNcHQWWbIcipnfl+/8jT08pqRyIJfDpyYmSxQsFefxvbsRy1u/vAcudb8a11uesnMvt1SoOR0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9QgPmeLLE6Ld0BB2W1wJ/WRXNP2Ic8blIblUcqvJ17E=;
 b=GkuXan3oZ5wT9Pqtagja8cgn3MLRVS0MEgQKWnPsfbtjZO+Mj8XB5W6yEdkxMTmwv3J7NCA3Id7m+SmiBtUzRrx2VYN34Ul7iaa/OZ8mfF1n8EOqjFmBii4c88GMHe5pPTe4zqEWbV1yMeqeE2AlZu3bvnfz75v+nmSh/R/M6cg348UUtLHVAl4s7BLPW/vl+EC4F/tdFKd+sqOLu89KLHMcDhAJIk2zH5sUdx/RD12YUfCq16Ys47OzXcKSOW5bPelESPbRnUM8t2Ov3/C3pn1G4BF6+vnDppkmb5jVdmLQd6KrQU3zZ+OAqjQmbTuDM3ui4iheT/zzg10AogDxBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9QgPmeLLE6Ld0BB2W1wJ/WRXNP2Ic8blIblUcqvJ17E=;
 b=eiULz5VbVq1agH/02/xHbaQ2yUWz2VkRI1uhTAXxEvlFgdqMILk+5I3RSWHtwoYjW7VMYb8no4eHGRT2ClQ0Lxra7fJ00Z3lecG3ztQgkjKkGwfB301Mm4zFC1QQB2SfmTP/AizX9Gs2OjiVpu05VWFXZLs3Yb7VSLu5xxjGsxw=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DS0PR10MB7204.namprd10.prod.outlook.com (2603:10b6:8:f3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.24; Mon, 18 Sep
 2023 23:02:12 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054%5]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 23:02:12 +0000
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
Subject: [PATCH v4 2/8] hugetlb: restructure pool allocations
Date:   Mon, 18 Sep 2023 16:01:54 -0700
Message-ID: <20230918230202.254631-3-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230918230202.254631-1-mike.kravetz@oracle.com>
References: <20230918230202.254631-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0197.namprd04.prod.outlook.com
 (2603:10b6:303:86::22) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|DS0PR10MB7204:EE_
X-MS-Office365-Filtering-Correlation-Id: c5e78614-1406-4213-a25f-08dbb89b4adb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8DbDChEAMM24ur0zuDg8Stt/Nr9x1B1HB4JBa19KPg6fDMkPHxwm/49C/La2xaGq5FKjDABTUcmdk5J1VUBryf3pymyDq54nX72q2UlVeOt7O1oitZrqe2iYJRZHP/GsLoGTXuyPGiat/95khtOmOem4/4cgjWDa5y0nARqZ9F2gE85hRyWevPU9XXM9En0TIasYwZREIKsXNLfQJRTm/loaujyRdKIOUZBSc2K+e+25fjeImEzz1JNq/selQKX3gfoEzsm9F0s15OpoR7GiUsyxqRmx8+sad+rTl2psAmlIrqDgB78cEK2sh94bab6UrpnfPtM1OwtG8KVoPO6531WooBiHCpYIhaFvTUPdmEzrceZJek3MIdDSK3xzW6a+tm6UwHdJkxmp2a+X+XhJYapUD01hq/o7vXj+vyia3zEDg6A+PX5EpAmZDP6lTv51HTeo57oz7sBK8IwRlpA+p/gI10cFnJLH2VMwy5RUwHzh7bUbKAbR/j96GdVvn+inL/t2Usmee2G5qqloO7uMXJT2VNJs5DJtgIxIIyy1Bz8Zba/6dzm8/t1nB5/CqSGD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(136003)(366004)(396003)(451199024)(1800799009)(186009)(6486002)(5660300002)(44832011)(6506007)(86362001)(6512007)(54906003)(316002)(38100700002)(66946007)(66556008)(41300700001)(66476007)(6666004)(478600001)(8936002)(2616005)(26005)(2906002)(36756003)(30864003)(107886003)(8676002)(1076003)(4326008)(83380400001)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IEt/LQVJM1JUAwUW27fzmPg0Wa1zUHDfDrr7oD4d7W006VCZWIy8NcN303um?=
 =?us-ascii?Q?4daO5YhqmQb2WHdLrUL0bSN7Tp+tN+aTBaGn5cgbbLj5fg2FZCduipb2JdHY?=
 =?us-ascii?Q?udi5F7l35ZPpTzxpgYMGArnwlZaxP7rBXrgXFNmibXq4FllNJw/L6GTxnPnd?=
 =?us-ascii?Q?DEUJdj5R2h9MK/XSD80LKwNnfdwoxC9EnLwWEjencJt485nf/44kEytkzM+L?=
 =?us-ascii?Q?ycEnowlUH1otq+LMmvxmEIUB1xJhmvhR1vvLwUZpFplaeoHfV/YSF1xs98pt?=
 =?us-ascii?Q?YtpFUIVD6rFf19zcjEGMzG1dIv0TauVLBy/brkMbkx+pw9dzPOzZZ6D0wdHM?=
 =?us-ascii?Q?dR6cUzwyuShfrUESGNpVX0j2z2iXYQjSftBxAxujjE2RYXi04scMTbKvODju?=
 =?us-ascii?Q?4Wk5Y8bo6Yh6pKQx5247Y5FiUoW2dshS+sefFQz3ol6jWjIIKGLC8/vk5tD/?=
 =?us-ascii?Q?aIQsZsuwEunlSwyLs6st0k4em0B63z3bDXe9G4N6ebd7MbzSqhur0klbt4su?=
 =?us-ascii?Q?rEkzV8rGD2E253OCjl0JX0ODM+OhFgZ+t5cpUIXkP1ww4cPZfYef6PWHGFEv?=
 =?us-ascii?Q?KRasnH9fUlWV77zaJhsPqC5/kP3NShDgmk3KjawazPqZ89cSy61rYJXrHxW7?=
 =?us-ascii?Q?2YS2L9FxUOTkryAJW+Pz3gxMYNKQsnCU/OoWJS0H7RC1ih/YI/9+9QG7a/oJ?=
 =?us-ascii?Q?NFfXg0NUEhpnwgYoaKoHHybzUiG0Rw40oAU4Kq+hrOpz8BIhMweu3xrEGahV?=
 =?us-ascii?Q?im6Xd9ezpEJZXGDjXAfrK8nKB38CBm7E8uSVNgBkv7sdELblzPprv8wVvNH2?=
 =?us-ascii?Q?SC/Q6S7wAOCU1wZdB4D3qgS8r/Vw7gRw7YxWgRxRfLxiTQBEZ+ed6+eTvYci?=
 =?us-ascii?Q?DuNfmW3QANOfeTFpc66n9OjaAe/cZUGOBj2vVckriIYfn14as1gMWPRcacLf?=
 =?us-ascii?Q?4ud0YyL6AVbBz2I7g6/kP+WFJZKI8XEFyKXnFE7maLgzdTtF2ajNgvUZnneK?=
 =?us-ascii?Q?bq+p3Kc5lrEu8oOn2qL/HbyxhurmZfkiYJxndoIgvxlH3gkB8M8XAOOmKyiX?=
 =?us-ascii?Q?pZ14oxT6XyCzOKG8wvUuSPTs1NED9bbOioiqfzRZZeVzEY40CZ+AsmAzd2Ez?=
 =?us-ascii?Q?zzzLwtCgCHpDtweH0s1zPucIuLrpAWDXMhGqCUekGatN938ODupM+fd7xoJB?=
 =?us-ascii?Q?OO91gR6X7uUMnxcAtzq6/Ig2lND8xLT/xrSGpucW+0S/UQVheg125fR5wpZT?=
 =?us-ascii?Q?f0wrHbCn4yur+Q6SVR+T0Qt2lfW46r0fbRHtTHiT7bFJKJZ9JApeL447yCzk?=
 =?us-ascii?Q?PklhHtPh/pt/ONkUcpcjRstf2wxcLl2pjRQkCzIhYNPzkxY7y5c/hGEB7J+K?=
 =?us-ascii?Q?mqJ8JHel61LIZqSe4yRMdFewyxNtVus7920MvsvY1fKKuKaJ7TxKtsGI7sRh?=
 =?us-ascii?Q?/yh4i2k/1mY5KXUsy/axNQcyA26GgckX7ib6lWBdWGW6/TA/ITKqKgoYNKjg?=
 =?us-ascii?Q?do7rV5X5QpziGOFlVTrsN+3912xZlx+sSX9Uf1BDZPvtltcBwFP6vQ6eWjFk?=
 =?us-ascii?Q?+MNAo69OmrX43ryuICAAfXAioEptG04pR7MKj6/XY7acevmSg7jBYyYKv8Rk?=
 =?us-ascii?Q?Pw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?dQvt6K1IY7v3YCyFavqYFh872u4U0KK5F9599no9bjZmhGPbY3wZLtpvvauV?=
 =?us-ascii?Q?xfjJTDrvnDO/cR139YNdh/HfsRKteZJBpZ6ksn1HUPmFWtiviwB2OfCcDxmI?=
 =?us-ascii?Q?zDwxWWs9Ykn4ZskU/JaCTaUv6NnqZDPHWQAgbxbT1QaXybU6fkmLk1AinQXx?=
 =?us-ascii?Q?cx1VxGAKcyp1qgINKg5Wyg8OlrdzTgBYgoIO7SN/vMLccR2VTO2sVTTZ5umW?=
 =?us-ascii?Q?f0LJNTODv7HTtgHSF5kYp4Ux8EysHEf59NFekyvZN5K0wFlfhSh0uyRzP8fu?=
 =?us-ascii?Q?rENvEtT9TaGper50PGalqmV+nKARHIXCCYCg42ddNhbGj5tdoiKAZK/NQo5E?=
 =?us-ascii?Q?Zg25gv3cSqbUSsqfUTwctxaEja06U0TQFPwWYpxtJ2cWpgVIayt40ShGkwhi?=
 =?us-ascii?Q?moR0K49JYMP/Hu9bs4hrmT52pQ3pCbq9KnZOJEYAkHcJeegAcq97oCTq74MA?=
 =?us-ascii?Q?DlBr/dSkG3qRJLbOeSQeZMLNCicUwdX+NilVmM83qGfFiCasJJ0Y6ypU0KB9?=
 =?us-ascii?Q?efMJJEtjkhD0rR2p1eGPadOBqArrnTdd3sJ91zv+mjL+L+lhbWVoiZIZwxKL?=
 =?us-ascii?Q?z8gU/OYNW1kmgFUxziaj+tPPQ8yrgTb5FVB/3FJRifdx7+8thE1l5dYbKMcm?=
 =?us-ascii?Q?Au+As8rmUBQDNswsbrUdhRfCuMSIef0BjYxGsgjZyBZ7UyL/iTxSu4L6sG3x?=
 =?us-ascii?Q?sMqTVLbZDi6gnl6yse8qCeoX3QfbDqOx39qi08p88I269Pc04LJnWZrk61x1?=
 =?us-ascii?Q?9Htg763Bsli1JO/45ghD3S9hhvbHS65fk0F0+atYxT42b1Ehg/LAxgXXq5Rh?=
 =?us-ascii?Q?ryncFlsrMBZsY+7eEAaO9HqYUq1wCQvgSNTCw7xVeMo+v1AkiCANTmPXJMvq?=
 =?us-ascii?Q?LnZjfFyg9K1uJWoF4+Gr50ZH1iNBv76b4T83n99HO9kEmd+dDn75Deo8yTC6?=
 =?us-ascii?Q?dF+JNDRSajGPDPQwiKR5bV544DaK3o6tHPKMPEjinhzxvMQMgzLx9Hs0E08m?=
 =?us-ascii?Q?JyLFXcPvzwVfMw1XclBlOh6VTIWyQEYgjxnCVrt1w96e+Ss6sdP9Cz7pq/gM?=
 =?us-ascii?Q?XkV+aQ3h3HYdUW5boBKPPiFAPOWWOocFXSyhQDaKwyE4Eio2uF1JiN4qfk4A?=
 =?us-ascii?Q?f3ByF57JbjIk?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5e78614-1406-4213-a25f-08dbb89b4adb
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 23:02:11.9849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hQeqc8TXBJJwnEsdZSLYDzaJfmRkwpKiU57+EHxmnhkWjxoZU0C/rKXHS32VdIHMy+K7WNLhWUFhRD99mYuJ0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7204
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-18_11,2023-09-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 malwarescore=0
 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309180199
X-Proofpoint-GUID: -HE2HcyGlqKCGdy9spGJRkPu0YBs-Pmh
X-Proofpoint-ORIG-GUID: -HE2HcyGlqKCGdy9spGJRkPu0YBs-Pmh
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allocation of a hugetlb page for the hugetlb pool is done by the routine
alloc_pool_huge_page.  This routine will allocate contiguous pages from
a low level allocator, prep the pages for usage as a hugetlb page and
then add the resulting hugetlb page to the pool.

In the 'prep' stage, optional vmemmap optimization is done.  For
performance reasons we want to perform vmemmap optimization on multiple
hugetlb pages at once.  To do this, restructure the hugetlb pool
allocation code such that vmemmap optimization can be isolated and later
batched.

The code to allocate hugetlb pages from bootmem was also modified to
allow batching.

No functional changes, only code restructure.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 183 ++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 144 insertions(+), 39 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 1ca0377c62ab..8624286be273 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1970,16 +1970,21 @@ static void __prep_account_new_huge_page(struct hstate *h, int nid)
 	h->nr_huge_pages_node[nid]++;
 }
 
-static void __prep_new_hugetlb_folio(struct hstate *h, struct folio *folio)
+static void init_new_hugetlb_folio(struct hstate *h, struct folio *folio)
 {
 	folio_set_hugetlb(folio);
-	hugetlb_vmemmap_optimize(h, &folio->page);
 	INIT_LIST_HEAD(&folio->lru);
 	hugetlb_set_folio_subpool(folio, NULL);
 	set_hugetlb_cgroup(folio, NULL);
 	set_hugetlb_cgroup_rsvd(folio, NULL);
 }
 
+static void __prep_new_hugetlb_folio(struct hstate *h, struct folio *folio)
+{
+	init_new_hugetlb_folio(h, folio);
+	hugetlb_vmemmap_optimize(h, &folio->page);
+}
+
 static void prep_new_hugetlb_folio(struct hstate *h, struct folio *folio, int nid)
 {
 	__prep_new_hugetlb_folio(h, folio);
@@ -2190,16 +2195,9 @@ static struct folio *alloc_buddy_hugetlb_folio(struct hstate *h,
 	return page_folio(page);
 }
 
-/*
- * Common helper to allocate a fresh hugetlb page. All specific allocators
- * should use this function to get new hugetlb pages
- *
- * Note that returned page is 'frozen':  ref count of head page and all tail
- * pages is zero.
- */
-static struct folio *alloc_fresh_hugetlb_folio(struct hstate *h,
-		gfp_t gfp_mask, int nid, nodemask_t *nmask,
-		nodemask_t *node_alloc_noretry)
+static struct folio *__alloc_fresh_hugetlb_folio(struct hstate *h,
+				gfp_t gfp_mask, int nid, nodemask_t *nmask,
+				nodemask_t *node_alloc_noretry)
 {
 	struct folio *folio;
 	bool retry = false;
@@ -2212,6 +2210,7 @@ static struct folio *alloc_fresh_hugetlb_folio(struct hstate *h,
 				nid, nmask, node_alloc_noretry);
 	if (!folio)
 		return NULL;
+
 	if (hstate_is_gigantic(h)) {
 		if (!prep_compound_gigantic_folio(folio, huge_page_order(h))) {
 			/*
@@ -2226,32 +2225,84 @@ static struct folio *alloc_fresh_hugetlb_folio(struct hstate *h,
 			return NULL;
 		}
 	}
-	prep_new_hugetlb_folio(h, folio, folio_nid(folio));
 
 	return folio;
 }
 
+static struct folio *only_alloc_fresh_hugetlb_folio(struct hstate *h,
+		gfp_t gfp_mask, int nid, nodemask_t *nmask,
+		nodemask_t *node_alloc_noretry)
+{
+	struct folio *folio;
+
+	folio = __alloc_fresh_hugetlb_folio(h, gfp_mask, nid, nmask,
+						node_alloc_noretry);
+	if (folio)
+		init_new_hugetlb_folio(h, folio);
+	return folio;
+}
+
 /*
- * Allocates a fresh page to the hugetlb allocator pool in the node interleaved
- * manner.
+ * Common helper to allocate a fresh hugetlb page. All specific allocators
+ * should use this function to get new hugetlb pages
+ *
+ * Note that returned page is 'frozen':  ref count of head page and all tail
+ * pages is zero.
  */
-static int alloc_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
-				nodemask_t *node_alloc_noretry)
+static struct folio *alloc_fresh_hugetlb_folio(struct hstate *h,
+		gfp_t gfp_mask, int nid, nodemask_t *nmask,
+		nodemask_t *node_alloc_noretry)
 {
 	struct folio *folio;
-	int nr_nodes, node;
+
+	folio = __alloc_fresh_hugetlb_folio(h, gfp_mask, nid, nmask,
+						node_alloc_noretry);
+	if (!folio)
+		return NULL;
+
+	prep_new_hugetlb_folio(h, folio, folio_nid(folio));
+	return folio;
+}
+
+static void prep_and_add_allocated_folios(struct hstate *h,
+					struct list_head *folio_list)
+{
+	struct folio *folio, *tmp_f;
+
+	/*
+	 * Add all new pool pages to free lists in one lock cycle
+	 */
+	spin_lock_irq(&hugetlb_lock);
+	list_for_each_entry_safe(folio, tmp_f, folio_list, lru) {
+		__prep_account_new_huge_page(h, folio_nid(folio));
+		enqueue_hugetlb_folio(h, folio);
+	}
+	spin_unlock_irq(&hugetlb_lock);
+
+	INIT_LIST_HEAD(folio_list);
+}
+
+/*
+ * Allocates a fresh hugetlb page in a node interleaved manner.  The page
+ * will later be added to the appropriate hugetlb pool.
+ */
+static struct folio *alloc_pool_huge_folio(struct hstate *h,
+					nodemask_t *nodes_allowed,
+					nodemask_t *node_alloc_noretry)
+{
 	gfp_t gfp_mask = htlb_alloc_mask(h) | __GFP_THISNODE;
+	int nr_nodes, node;
 
 	for_each_node_mask_to_alloc(h, nr_nodes, node, nodes_allowed) {
-		folio = alloc_fresh_hugetlb_folio(h, gfp_mask, node,
+		struct folio *folio;
+
+		folio = only_alloc_fresh_hugetlb_folio(h, gfp_mask, node,
 					nodes_allowed, node_alloc_noretry);
-		if (folio) {
-			free_huge_folio(folio); /* free it into the hugepage allocator */
-			return 1;
-		}
+		if (folio)
+			return folio;
 	}
 
-	return 0;
+	return NULL;
 }
 
 /*
@@ -3264,25 +3315,35 @@ static void __init hugetlb_folio_init_vmemmap(struct folio *folio,
  */
 static void __init gather_bootmem_prealloc(void)
 {
+	LIST_HEAD(folio_list);
 	struct huge_bootmem_page *m;
+	struct hstate *h, *prev_h = NULL;
 
 	list_for_each_entry(m, &huge_boot_pages, list) {
 		struct page *page = virt_to_page(m);
 		struct folio *folio = (void *)page;
-		struct hstate *h = m->hstate;
+
+		h = m->hstate;
+		/*
+		 * It is possible to have multiple huge page sizes (hstates)
+		 * in this list.  If so, process each size separately.
+		 */
+		if (h != prev_h && prev_h != NULL)
+			prep_and_add_allocated_folios(prev_h, &folio_list);
+		prev_h = h;
 
 		VM_BUG_ON(!hstate_is_gigantic(h));
 		WARN_ON(folio_ref_count(folio) != 1);
 
 		hugetlb_folio_init_vmemmap(folio, h,
 					   HUGETLB_VMEMMAP_RESERVE_PAGES);
-		prep_new_hugetlb_folio(h, folio, folio_nid(folio));
+		__prep_new_hugetlb_folio(h, folio);
 		/* If HVO fails, initialize all tail struct pages */
 		if (!HPageVmemmapOptimized(&folio->page))
 			hugetlb_folio_init_tail_vmemmap(folio,
 						HUGETLB_VMEMMAP_RESERVE_PAGES,
 						pages_per_huge_page(h));
-		free_huge_folio(folio); /* add to the hugepage allocator */
+		list_add(&folio->lru, &folio_list);
 
 		/*
 		 * We need to restore the 'stolen' pages to totalram_pages
@@ -3292,6 +3353,8 @@ static void __init gather_bootmem_prealloc(void)
 		adjust_managed_page_count(page, pages_per_huge_page(h));
 		cond_resched();
 	}
+
+	prep_and_add_allocated_folios(h, &folio_list);
 }
 
 static void __init hugetlb_hstate_alloc_pages_onenode(struct hstate *h, int nid)
@@ -3325,9 +3388,22 @@ static void __init hugetlb_hstate_alloc_pages_onenode(struct hstate *h, int nid)
 	h->max_huge_pages_node[nid] = i;
 }
 
+/*
+ * NOTE: this routine is called in different contexts for gigantic and
+ * non-gigantic pages.
+ * - For gigantic pages, this is called early in the boot process and
+ *   pages are allocated from memblock allocated or something similar.
+ *   Gigantic pages are actually added to pools later with the routine
+ *   gather_bootmem_prealloc.
+ * - For non-gigantic pages, this is called later in the boot process after
+ *   all of mm is up and functional.  Pages are allocated from buddy and
+ *   then added to hugetlb pools.
+ */
 static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
 {
 	unsigned long i;
+	struct folio *folio;
+	LIST_HEAD(folio_list);
 	nodemask_t *node_alloc_noretry;
 	bool node_specific_alloc = false;
 
@@ -3369,14 +3445,25 @@ static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
 
 	for (i = 0; i < h->max_huge_pages; ++i) {
 		if (hstate_is_gigantic(h)) {
+			/*
+			 * gigantic pages not added to list as they are not
+			 * added to pools now.
+			 */
 			if (!alloc_bootmem_huge_page(h, NUMA_NO_NODE))
 				break;
-		} else if (!alloc_pool_huge_page(h,
-					 &node_states[N_MEMORY],
-					 node_alloc_noretry))
-			break;
+		} else {
+			folio = alloc_pool_huge_folio(h, &node_states[N_MEMORY],
+							node_alloc_noretry);
+			if (!folio)
+				break;
+			list_add(&folio->lru, &folio_list);
+		}
 		cond_resched();
 	}
+
+	/* list will be empty if hstate_is_gigantic */
+	prep_and_add_allocated_folios(h, &folio_list);
+
 	if (i < h->max_huge_pages) {
 		char buf[32];
 
@@ -3510,7 +3597,9 @@ static int adjust_pool_surplus(struct hstate *h, nodemask_t *nodes_allowed,
 static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 			      nodemask_t *nodes_allowed)
 {
-	unsigned long min_count, ret;
+	unsigned long min_count;
+	unsigned long allocated;
+	struct folio *folio;
 	LIST_HEAD(page_list);
 	NODEMASK_ALLOC(nodemask_t, node_alloc_noretry, GFP_KERNEL);
 
@@ -3587,7 +3676,8 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 			break;
 	}
 
-	while (count > persistent_huge_pages(h)) {
+	allocated = 0;
+	while (count > (persistent_huge_pages(h) + allocated)) {
 		/*
 		 * If this allocation races such that we no longer need the
 		 * page, free_huge_folio will handle it by freeing the page
@@ -3598,15 +3688,32 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 		/* yield cpu to avoid soft lockup */
 		cond_resched();
 
-		ret = alloc_pool_huge_page(h, nodes_allowed,
+		folio = alloc_pool_huge_folio(h, nodes_allowed,
 						node_alloc_noretry);
-		spin_lock_irq(&hugetlb_lock);
-		if (!ret)
+		if (!folio) {
+			prep_and_add_allocated_folios(h, &page_list);
+			spin_lock_irq(&hugetlb_lock);
 			goto out;
+		}
+
+		list_add(&folio->lru, &page_list);
+		allocated++;
 
 		/* Bail for signals. Probably ctrl-c from user */
-		if (signal_pending(current))
+		if (signal_pending(current)) {
+			prep_and_add_allocated_folios(h, &page_list);
+			spin_lock_irq(&hugetlb_lock);
 			goto out;
+		}
+
+		spin_lock_irq(&hugetlb_lock);
+	}
+
+	/* Add allocated pages to the pool */
+	if (!list_empty(&page_list)) {
+		spin_unlock_irq(&hugetlb_lock);
+		prep_and_add_allocated_folios(h, &page_list);
+		spin_lock_irq(&hugetlb_lock);
 	}
 
 	/*
@@ -3632,8 +3739,6 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 	 * Collect pages to be removed on list without dropping lock
 	 */
 	while (min_count < persistent_huge_pages(h)) {
-		struct folio *folio;
-
 		folio = remove_pool_hugetlb_folio(h, nodes_allowed, 0);
 		if (!folio)
 			break;
-- 
2.41.0

