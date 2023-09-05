Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37495793134
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 23:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244524AbjIEVq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 17:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbjIEVqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 17:46:15 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D5ECEA
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 14:45:38 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 385LA6La007133;
        Tue, 5 Sep 2023 21:44:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=cvreQOpNKMda5aobqHfJE2Kae8a6KoZTDy8YOltS1Rc=;
 b=33M2LwQiSgPzY/OhY1W1/+DD3wdv90l5Y8GBBAThfqBHJw48hFBa1suTLdOkWqDCL3lg
 w57vMxCpIXwJsqnMWeif0nillZssHRZLjC2NvR0fvNOpUlfVHzemY2BBJm5DrqmsyeEK
 BCTfLuCGGEBUJki8iEe05s3Nfp3TIU5q4R46+/33cnefoOSoMHWYoXnLWquW2E4eoKsU
 0HOW/+UbgiyW5UJEux2pbg0ydmAWJgPYTOs/mn+NjjLkHEDUDE35fndAqa10shcx/7eC
 mh5mMi1SWv86t/fgacLDFa2qexpJzjmY6epF2HQpma3KPCqAPn/K5qC4glYCG8omU7C/ 6Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sxc0g82te-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Sep 2023 21:44:53 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 385LV2ns007675;
        Tue, 5 Sep 2023 21:44:52 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3suug5c767-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Sep 2023 21:44:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T10+dpJzm4hSKFDdQd7sFBQyXNVxU1jdjAQeV6FNQguLrUN099nJpG7F7R/kJCh0RMY7frFmY2l9RLCOscLdC8CsfAg1gqg/4UkzaPwPlrBZrMvXfjjEEnLd2cnvinsm3VSgXxLscHblWBP2FKiJ1CgaxW+a05nKhgvf+aGf3vbU59p0/QwVIo9aLocByAJ7oN9ySimOIce6F2aZGa8GXObO0eNmNwrPfUpNMwwr53VGUvcefNfPwLq2KgRfEDEx/XY4SScjP4yP1dyYlAnvEDqQjedj8oRr2BB4doNFxxnrFPpA/Pct4NThl1RRv9/kerOF0xuLjU94lEEpWcm6Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cvreQOpNKMda5aobqHfJE2Kae8a6KoZTDy8YOltS1Rc=;
 b=LcEsXxtxCKwRyBETrF18+nuRs6kwe8ymm+ALVGtBthELyzuIYp2RwzOHO4ipW4/qA1h92JFDhjxQbO1w3fgJu87C8v0ir0OfYQ5Q7O7xD8TrYH5LTyOeN0TfJzuwsuBb0exyWVThQsrJmNZKybATbtDWdBDeNyNZF/pr8jmrIzjGdnB4gijPZdftBKnKU21gIRuIUbEI9W93K5en1qpNGaTcBPQsysoGjcapiO+VFQFNjYJbLtr5jOSBFQRfzblpxn3VScP0gMOyHz5czXV3qoSb/KIPIhYEPLN4pbNuCSuhaoPSVkqyukhYXupcpAF/Uy46yiAQXDE/rvhDG1oR2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cvreQOpNKMda5aobqHfJE2Kae8a6KoZTDy8YOltS1Rc=;
 b=BmmpGOyP3ylzvtcOSRl9m/CIP5wvzErBGaIPslFu9xW2DvUWt4ZFQy9WeHTXCDi5bR8gwj/0B4gP/ibhQVA+PMJEwh/zPoh42XxD0P6Zr7nO/iU+xi0x4mHatwGGfytRim/xhGnpfz6AKp202QuhrQq7MTreS/RYs+hFPjZw7YU=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MW4PR10MB6395.namprd10.prod.outlook.com (2603:10b6:303:1ea::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 21:44:50 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::58d8:cf97:ae4b:1715]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::58d8:cf97:ae4b:1715%3]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 21:44:50 +0000
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
Subject: [PATCH v2 10/11] hugetlb: batch TLB flushes when freeing vmemmap
Date:   Tue,  5 Sep 2023 14:44:09 -0700
Message-ID: <20230905214412.89152-11-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230905214412.89152-1-mike.kravetz@oracle.com>
References: <20230905214412.89152-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MWH0EPF00056D11.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:14) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|MW4PR10MB6395:EE_
X-MS-Office365-Filtering-Correlation-Id: 607d7e75-f540-4546-281f-08dbae5954aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0YWm8+ZXa8Kk1htabM77hg8DYwpGFijTVPG9lsE3yYkY9jZ2NuiGJ36+oJgP47GTsFz0cvZ4L84LNhAtqhfy/Av2ypAVytAEc+Rcs6UMAyVwAyT5tKU2LMB6XviFtt5PURIPqqtP32oaLYdja7Rfl5Nv8QeNWz/Ll6vKHuD+EMxgggrwPUdh8gomP8oQVE7z8EKCB681CkJaxdEiw3Dt6umlI1L5H/TdTFNyf6dBdg5Ab0ykUJ8JB8mSCLZ8+zrS7J+e45KZbEZ5t3V9WRFRIWndaln/o8TPN6OWwuNvLgCldhsmygArROqyPK7E7eDP8yWehwxuxuIfI1PtXrM7+EMhs9GV4BVC153CYu/nwgRStMj3WqSc+UnfxtLphnBfQmk6A1ETW2BCy0Sd7uAGl8h3FBsh9QiOeJmGUAev7aJH6+gmzLbmJJkTw0tHYGQXt31a4PxuUf4I62E7MAuQe8Daj4/ywn3WGABy7FwQ9IglaVaOhP3/v3dPtUbyPVx/PlhNar0KIN8lznY15JE9Q21QlZbMCbGSxf4t1MSs8TQUiMzTtFrJ6IJN2UPinPjk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(39860400002)(396003)(136003)(186009)(1800799009)(451199024)(6666004)(6486002)(6512007)(6506007)(478600001)(38100700002)(2906002)(7416002)(107886003)(1076003)(2616005)(26005)(83380400001)(86362001)(36756003)(66946007)(5660300002)(54906003)(66476007)(66556008)(316002)(44832011)(8936002)(8676002)(4326008)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Jr6uKhdzVizJYNGnLPhXEjPDtG19OD4UaAK25NtqAkT07O+FCRV/bcgBZ51t?=
 =?us-ascii?Q?6WmWVQigDMMY1V0GHlQUKrd+nzPX+iUh8cNb7jOghdiTuS3oVLfVEYSUoz7f?=
 =?us-ascii?Q?2KFiZp//PwGhka2wnKEcKylvQXMxXfSSBkzJgv80WpyEh6dWYdu2PqvlbEZy?=
 =?us-ascii?Q?CU0r4+ZJ/xtoOevMXdHh20rptEYqnItcamk0tEczQAgMOYkEiJ2P24nPBPpC?=
 =?us-ascii?Q?+PtOmd/n5uPiw/r/rh9XpS+gP9m4fDn2zOprDUdAvBNR8x+kSD+9cJ08Y7x/?=
 =?us-ascii?Q?xR7AcsRTO9TaAnRCI8LG57z8PohosX9jvmy3Yr4Ge+5h56L/UivudWgB6CDe?=
 =?us-ascii?Q?647gAUbv8J80QCu7IVWH3dISZeLCNtDmzrOdp6PsNVY57gvaTegl6djHSDFb?=
 =?us-ascii?Q?/obtooOczfvDwJTbeFvt1qLOO5KjQiqlkSYGDKkrRsAkRiAvpym4uLdkQCmr?=
 =?us-ascii?Q?PcUF9vcJJE420EjDgopflkDvWRabYJdjnSZRQwfW3QA7trVFRwYa59YrCQQ+?=
 =?us-ascii?Q?nNEG50wLOtMT6GoltLGGYT3mrWtSGqU7+QEe71fpeziTvZMXLm+YlhucPL9U?=
 =?us-ascii?Q?yv8KE9dzjyyvJbNyIiAux7q2u05XqzPbGymEzOosVSQvVIT0ozp7yNdLVGpr?=
 =?us-ascii?Q?CDwHyx74+Najb1rOemZI6n/TJfueScx+nYtUAkm1A0f1MHkmM6sKbYcHTset?=
 =?us-ascii?Q?ZHsn9/xT25USMd5qEpNBVu8PdI2c0RJEiXlc/qC7ITlRPQzt/T9mXwjM4BLq?=
 =?us-ascii?Q?uhbrYXOTJee4MA0U79vRVseNSY7nLRajnFyk3cDQ3P7PzUwL5vLofL7s6LDJ?=
 =?us-ascii?Q?/YZwYE+KmgM0TyWBuqTlwfBufiPoeZRNE4hSCeLCGvbixbtqm3Apl/oXG5td?=
 =?us-ascii?Q?lsnDBzxQF+dS/u+Tji8yg+uDDi+ZDvZuPJYrRmJ5D667FRH9Eyrdb0Ga5JpQ?=
 =?us-ascii?Q?G4M2iJVApu13reRJCSUFIDxuJLqME0dW8v5ob+UTBqXZaET9h5CsS+JSWl8i?=
 =?us-ascii?Q?9UH2FTH25SD8/nuQUssfji8g+KMg03SAFB8DCcxjSfA4CekPz/DcTIwNs9Zz?=
 =?us-ascii?Q?7Vj/DyVBBlv+VZlS6tSmmgk79Nx8n0xGh1IirXgV8gdWolOz/AyhM4oi1khR?=
 =?us-ascii?Q?Os8NZzFq9fQQ02AzpN3+avgwEFUtQW6V4PQErKpR366w5Ni3DsomdzMFcSur?=
 =?us-ascii?Q?5DDP4GMcJxm3L8AJyjuomnBTN3BPa/+osfxrsLUiI93LUFeNCeCNXXwds6xj?=
 =?us-ascii?Q?FbsO5Q9XsEcE3XJi3ziUYvwk3avPvuGgkjKFnTAszCANwnyMQG2mOkBnzTf7?=
 =?us-ascii?Q?SdJ526o6XHYgFhHufrIPT55zjsBQ7nFdddkrZc/+iDu5bzVQC5yTCSv4cBUv?=
 =?us-ascii?Q?189sGTBJGEU55X9CeSPjBFxe1kmHqWTX/QWhgroqEsTqMNQmXguKQ8GevIfP?=
 =?us-ascii?Q?YRZSW5oqMQSWHNCnwDZFmsrWXcG5vv6FmTzlg8O2Vg9YYpbWl2WIfkjKJ+sn?=
 =?us-ascii?Q?f/hPLt7YcVzg9w7rj9JwcqmfSi3Qyvl8J85ZmLWxDZFprXosojarQ9/TmpUA?=
 =?us-ascii?Q?7DHUVXTn+nzL7dRnVBTjIuDWmu2gd8g04jo7vKk25z6RzvWzSHraLEJWno+l?=
 =?us-ascii?Q?9g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?QKnaUpw+70WBUYaSZe/HDJaIaTOSySI3UeXkn+reQInoVSGdhuvGqYZAqvZ5?=
 =?us-ascii?Q?Af0aMaxknV2pxHwgqrkureYhPihVFELSOuZw9l74RXIsgXZU8QJydkyc1H38?=
 =?us-ascii?Q?kct/NGOc8A3u1E5Sx8zplIj2VOI/t+cm20eIfrlTdKpk8Smxp65uwGfQUsRH?=
 =?us-ascii?Q?X0vwaAUOEy81x4BD2GtH8l1Vjebqcmh5O1mzydnO5yJYLvpfGMqox1k43cKt?=
 =?us-ascii?Q?/IlmEDu8Z9tICrzrgCDjuSPitox+EjTT9X/GjljgWYbfR5+xM985VlFnbtZi?=
 =?us-ascii?Q?xwhRgCrrF/9LKiwRA7L4C+7obAeiSDMe/WAPucdRUtIE17E61KTZf+V7qWvu?=
 =?us-ascii?Q?aSHutNbChIumwwrP+WSsfE3oBcIV2Q/xVY8duGS2OcrkVEGWdgUncdTGhqPY?=
 =?us-ascii?Q?u0juvGYkRh2aaxNf79MuMiC36cqUhPpK+RsotXWTfRgBf5LqOUj7DHnpqWsY?=
 =?us-ascii?Q?9ogOHmE2v1TC59WacSogAEtHUl5l0eJpmJlbHkLsf21cv9Y4CC2442eQna2x?=
 =?us-ascii?Q?w2t107m1bTH2VXjP2k+K2a6MafDW+BguXzNOLEkT9g/NchBekhp94oZfBmVl?=
 =?us-ascii?Q?x0SgRbKuUrXgzrSYncRip1FEJzBKUBr9lR7FujjlEAx0sAgjWFsEUFK6hwMS?=
 =?us-ascii?Q?PZK1USDLk9Z0XM+nc6AmFj14vAfaPsJ9JOKks260bhimPs+kRDQ8hY7MydiR?=
 =?us-ascii?Q?SwJQtAXV8LbfqX0NkKj+nXZQ5Ai9pr9FreoA3cjZ4ZezWQE5PopI2ykwOhh1?=
 =?us-ascii?Q?99KxLcxsp2yXFNrTDFXd5ZGoJuoNhFDsSlmBMmrAf0cazBvGgNB7g+6PfQTR?=
 =?us-ascii?Q?22xSNtipbVHU2BLWp0xkMfHZaE/A5YnaQo5FJ/NQhRLg9sugdoUIS8neEnLm?=
 =?us-ascii?Q?Tj8mBd9EMBTn78FL9f0aPPLymFey5C2wjNnYNxm9v3v2OoanbNrLq9zHMXS/?=
 =?us-ascii?Q?nvOnTXg5/DWxlg9PmOe3AdxbsS/liylySemyU/1EtpNLjT74a7J7MD3g89QP?=
 =?us-ascii?Q?3nLwO8S4sV8i+AXaOKGtqGA1nMboDD4cOCRQasnC5f46iJJkKWWh4YYzj03R?=
 =?us-ascii?Q?Fw/d8dE/v1WLS33/3OpeOrCneJY2o5aN1kbLZvNcS90HET9KzcM03nbsf9JC?=
 =?us-ascii?Q?lSODTo5VndyO?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 607d7e75-f540-4546-281f-08dbae5954aa
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 21:44:50.0122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4AmqggF1xTn7jLUJYAXudQFm9N4dS3HlSSKAfx4UQ5An1ges9Cp2e34prW3OUBRDbHZYj6U7qmJqykjJarQnEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6395
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_13,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309050189
X-Proofpoint-GUID: di88WQWgAm9obJiwKwKkiIXORxKdnhwS
X-Proofpoint-ORIG-GUID: di88WQWgAm9obJiwKwKkiIXORxKdnhwS
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joao Martins <joao.m.martins@oracle.com>

Now that a list of pages is deduplicated at once, the TLB
flush can be batched for all vmemmap pages that got remapped.

Add a flags field and pass whether it's a bulk allocation or
just a single page to decide to remap.

The TLB flush is global as we don't have guarantees from caller
that the set of folios is contiguous, or to add complexity in
composing a list of kVAs to flush.

Modified by Mike Kravetz to perform TLB flush on single folio if an
error is encountered.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb_vmemmap.c | 38 ++++++++++++++++++++++++++++++--------
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index d956551699bc..8c85e2c38538 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -27,6 +27,7 @@
  * @reuse_addr:		the virtual address of the @reuse_page page.
  * @vmemmap_pages:	the list head of the vmemmap pages that can be freed
  *			or is mapped from.
+ * @flags:		used to modify behavior in bulk operations
  */
 struct vmemmap_remap_walk {
 	void			(*remap_pte)(pte_t *pte, unsigned long addr,
@@ -35,6 +36,8 @@ struct vmemmap_remap_walk {
 	struct page		*reuse_page;
 	unsigned long		reuse_addr;
 	struct list_head	*vmemmap_pages;
+#define VMEMMAP_NO_TLB_FLUSH		BIT(0)
+	unsigned long		flags;
 };
 
 static int split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start, bool flush)
@@ -208,7 +211,7 @@ static int vmemmap_remap_range(unsigned long start, unsigned long end,
 			return ret;
 	} while (pgd++, addr = next, addr != end);
 
-	if (walk->remap_pte)
+	if (walk->remap_pte && !(walk->flags & VMEMMAP_NO_TLB_FLUSH))
 		flush_tlb_kernel_range(start, end);
 
 	return 0;
@@ -348,12 +351,14 @@ static int vmemmap_remap_split(unsigned long start, unsigned long end,
  * @reuse:	reuse address.
  * @vmemmap_pages: list to deposit vmemmap pages to be freed.  It is callers
  *		responsibility to free pages.
+ * @flags:	modifications to vmemmap_remap_walk flags
  *
  * Return: %0 on success, negative error code otherwise.
  */
 static int vmemmap_remap_free(unsigned long start, unsigned long end,
 			      unsigned long reuse,
-			      struct list_head *vmemmap_pages)
+			      struct list_head *vmemmap_pages,
+			      unsigned long flags)
 {
 	int ret;
 	LIST_HEAD(freed_pages);
@@ -361,6 +366,7 @@ static int vmemmap_remap_free(unsigned long start, unsigned long end,
 		.remap_pte	= vmemmap_remap_pte,
 		.reuse_addr	= reuse,
 		.vmemmap_pages	= &freed_pages,
+		.flags		= flags,
 	};
 	int nid = page_to_nid((struct page *)start);
 	gfp_t gfp_mask = GFP_KERNEL | __GFP_THISNODE | __GFP_NORETRY |
@@ -410,6 +416,7 @@ static int vmemmap_remap_free(unsigned long start, unsigned long end,
 			.remap_pte	= vmemmap_restore_pte,
 			.reuse_addr	= reuse,
 			.vmemmap_pages	= &freed_pages,
+			.flags		= 0,
 		};
 
 		vmemmap_remap_range(reuse, end, &walk);
@@ -597,7 +604,8 @@ static bool vmemmap_should_optimize(const struct hstate *h, const struct page *h
 
 static void __hugetlb_vmemmap_optimize(const struct hstate *h,
 					struct page *head,
-					struct list_head *vmemmap_pages)
+					struct list_head *vmemmap_pages,
+					unsigned long flags)
 {
 	unsigned long vmemmap_start = (unsigned long)head, vmemmap_end;
 	unsigned long vmemmap_reuse;
@@ -607,6 +615,18 @@ static void __hugetlb_vmemmap_optimize(const struct hstate *h,
 		return;
 
 	static_branch_inc(&hugetlb_optimize_vmemmap_key);
+	/*
+	 * Very Subtle
+	 * If VMEMMAP_NO_TLB_FLUSH is set, TLB flushing is not performed
+	 * immediately after remapping.  As a result, subsequent accesses
+	 * and modifications to struct pages associated with the hugetlb
+	 * page could bet to the OLD struct pages.  Set the vmemmap optimized
+	 * flag here so that it is copied to the new head page.  This keeps
+	 * the old and new struct pages in sync.
+	 * If there is an error during optimization, we will immediately FLUSH
+	 * the TLB and clear the flag below.
+	 */
+	SetHPageVmemmapOptimized(head);
 
 	vmemmap_end	= vmemmap_start + hugetlb_vmemmap_size(h);
 	vmemmap_reuse	= vmemmap_start;
@@ -618,10 +638,10 @@ static void __hugetlb_vmemmap_optimize(const struct hstate *h,
 	 * mapping the range to vmemmap_pages list so that they can be freed by
 	 * the caller.
 	 */
-	if (vmemmap_remap_free(vmemmap_start, vmemmap_end, vmemmap_reuse, vmemmap_pages))
+	if (vmemmap_remap_free(vmemmap_start, vmemmap_end, vmemmap_reuse, vmemmap_pages, flags)) {
 		static_branch_dec(&hugetlb_optimize_vmemmap_key);
-	else
-		SetHPageVmemmapOptimized(head);
+		ClearHPageVmemmapOptimized(head);
+	}
 }
 
 /**
@@ -638,7 +658,7 @@ void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head)
 {
 	LIST_HEAD(vmemmap_pages);
 
-	__hugetlb_vmemmap_optimize(h, head, &vmemmap_pages);
+	__hugetlb_vmemmap_optimize(h, head, &vmemmap_pages, 0UL);
 	free_vmemmap_page_list(&vmemmap_pages);
 }
 
@@ -672,7 +692,9 @@ void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_l
 	flush_tlb_all();
 
 	list_for_each_entry(folio, folio_list, lru)
-		__hugetlb_vmemmap_optimize(h, &folio->page, &vmemmap_pages);
+		__hugetlb_vmemmap_optimize(h, &folio->page, &vmemmap_pages, VMEMMAP_NO_TLB_FLUSH);
+
+	flush_tlb_all();
 
 	free_vmemmap_page_list(&vmemmap_pages);
 }
-- 
2.41.0

