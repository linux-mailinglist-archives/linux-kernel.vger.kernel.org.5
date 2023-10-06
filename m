Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 403A07BB082
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 05:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbjJFDV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 23:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjJFDVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 23:21:30 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7AB0DE
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 20:21:25 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3962NikX027817;
        Fri, 6 Oct 2023 03:20:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=yWCzkeiwrw7E7zmdYoM/+u9CKp7c2Frl8b8zefaOlJQ=;
 b=ErFHN6DH0CjI6WYkViznXYwspj5E/1iK1/JG7CMCJSucvkNz9wK9UyJEFMrCY+4fiuuL
 Ibbe/UTZUeX7E+569HmhlarZVdIQpOkEMQO6QCl58L34lVNSMQZ1hB+yYJCq3pXWvpe9
 oXca5mWOTqCSmxWsRUY2CStXf+BlM6gedwGJ3GpA0vx8qyD2LKCus48kweTiLAjAfvsP
 51ISE6oamM9U1JMP9SuIYVqYKUJRLug82hAqIBv4hgcsSdX98XgPyotk8O9zPkRCjDaG
 +YF6WmX8mnfG7A6ksC5FKchS5Zr8924XtVi1abMWa9BQb4lBErcEp0edAYlgn2LkctbJ vA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tea3ejyap-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Oct 2023 03:20:26 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39632iwP002972;
        Fri, 6 Oct 2023 03:20:25 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tea49ypp5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Oct 2023 03:20:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PbkGBnMM+Mi7zIqYiY7Xgvtuv4FDZi7ODEOURs8bnLQVqxR0RJ1zSdS52vfVLWVdvY9HPvi9lEHMzN/woUsbjmvtlTJ6Gy4NxUT9BTqQ0rxr3QJwIWpQ33OU8qT5V6dlo1wmXK9tQwlvhCpexVAszjOoYqbay9ORoLKRows0kqzWjrJeKLMG6rONe5YYO/ISxsJp9pBdnp3J9hiwaAG1T2u9BsaBdQ2qlwcX6GiWBgvO8o8ilACf5/H55nhFE8fity8lOfsg/oOMOMvDLaTRtv18m5516gbxq4x3O4mA1nkCx0d1Xn8GyBOEtMbTUklgAh85XQoMGVfVmTHkvT6Zgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yWCzkeiwrw7E7zmdYoM/+u9CKp7c2Frl8b8zefaOlJQ=;
 b=HUPBR9wqfB1vK2Th9vsFP8bh0/lZrn4qoEikGjIFp+JQrplDQGdtKk9CklR4U+xSAV8xnVBtjzEFQZ8fiBLZRGQYLBzMAYU3De2ar+zOJahZoLwhSz1xgYoTu8o497wj9GfbF/rBsduAdPO9K6c97YNwt6Z7B2byyw/CVxskeM8TtWRIjaBfxZODWQWNWgEw/TwIJmFFKM+3+cKo+48jyQeydcdhb3igIFzCnzRU/JKqsrlOKzZVAtM5MipXKd2ludOaEoMebUbq2JUdvNFXOlp0+Aqn1WaDnkPOHJ/b3XSFg1Ds6HIKfKxOnjZz/UovkBHPOeeYqPa5abuNMZhd1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yWCzkeiwrw7E7zmdYoM/+u9CKp7c2Frl8b8zefaOlJQ=;
 b=ohwveF5CBGp9RVww7j17AGxt9fv4bbeH7xY8TTTaK89Opd+SezQXyFkMtDS215cUvD/6v5sLTooflYvhnBSBLc1Ad47qoe6H+tiR4tH3cPWlOw045CQGfzxftbquH/W0cvZhtRksdb5z4V8+9rTb4+0XO5j3OVpdi4Ac++LRqWk=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SA1PR10MB6615.namprd10.prod.outlook.com (2603:10b6:806:2b8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.38; Fri, 6 Oct
 2023 03:20:23 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::59f7:ec45:eb41:d8c2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::59f7:ec45:eb41:d8c2%6]) with mapi id 15.20.6838.033; Fri, 6 Oct 2023
 03:20:23 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
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
        Mike Kravetz <mike.kravetz@oracle.com>,
        James Houghton <jthoughton@google.com>
Subject: [PATCH v7 1/8] hugetlb: optimize update_and_free_pages_bulk to avoid lock cycles
Date:   Thu,  5 Oct 2023 20:20:03 -0700
Message-ID: <20231006032012.296473-2-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231006032012.296473-1-mike.kravetz@oracle.com>
References: <20231006032012.296473-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0244.namprd04.prod.outlook.com
 (2603:10b6:303:88::9) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SA1PR10MB6615:EE_
X-MS-Office365-Filtering-Correlation-Id: 808d10d8-a751-44ac-a47a-08dbc61b2d44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LU+MksQPgRH3m8lI3fLDSEeT5cpAQ+EFJD4GTQJSVnwr9I9d4R0qVytU9SvZ/AMM7HPESkJdhY6WsLqviHR2/XMK5aHxncrohde0iGSCY7PlQbHftfhStsUENBa7mAXPUiFyx+T1y7b5xF4RHb7gyZFDh9RDXkbi8ZG6DbbXQ6jw1TPrQD4tkKRO3bjVrwyD1cvyXftB3zWU/aWZCyULtMuP/jbXR9H4R84FL4Y151ihmk+UOFEyU41/QKuqExgYWOGx8EtLFS6muM62wDCeiZ0GtydoD2/P1yTWkXDb5bnuV1CPRfrf06G399PWoujfziX+lcVX4nsGvq1uRYip/kZLKS9+2QpUAsrdqd1g0uG7LdsLPepuCPpGUX9MEb6IwwE31TIlg8z0hZDa4Zk5TwKs7qCUl2bpXmZm/tKFbPn+NdOvgSLFok36s6pU6wkIFbNl7nRPlsmJdYRsqgjbuNPck47Snptb8sJcvPzkY7ua7S/XgSlz/6jT08rpVfHF4orqIDIyqAPcDib9puEWVh0wihMQPZBZdqutJ+nijpd5r8avEApYoik1SnhKU/+j
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(39860400002)(346002)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(316002)(54906003)(66946007)(66476007)(66556008)(41300700001)(1076003)(2616005)(86362001)(6512007)(6506007)(26005)(6666004)(36756003)(6486002)(478600001)(38100700002)(83380400001)(44832011)(15650500001)(7416002)(2906002)(4326008)(8936002)(8676002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gbX9EgG9E4uTEYIUU4irzj3U4mcv18aknhvQRsTG1OwPH6wK47J1UPj53mvM?=
 =?us-ascii?Q?m/w8AHqPY4TMbS7nPgpIVFBST9nclezWgXJiXr1ni4J8VGbgcSSOKQOnQJNY?=
 =?us-ascii?Q?BRguidTc0qlHpCYuM/64Vb/wIWubnPCBNNqTZMyA6KB2qsQ+y2g6Rxjfb9PG?=
 =?us-ascii?Q?2sN0kbwbuMZAhADInsJrZqXTswz1SYIQ/tbegY7Ker/X8ptvrf8kAxnJYpIn?=
 =?us-ascii?Q?05vYURLbK5UalsPB5i+cUb4D9fm9Safw3I0eYyX9sL1ucHT5kAlTYglAKfPA?=
 =?us-ascii?Q?qpn9jpXUmOT9AlptrpZxU2FQOKKZlEB/SHDhBjqmBPorEORwf/4kofjJcoQi?=
 =?us-ascii?Q?/yzvK1RYnLNanF8Z7R/6Bd77I9TJT4ikCvJ19/jE/sCvdj5dM6q6fdoc+GWo?=
 =?us-ascii?Q?DbE+bnDJ1XnSGJouWkaYZ54PT3rSj3bHYMrQeNgpPnvgqU1d5JUY3EpjUAMe?=
 =?us-ascii?Q?t5YkPYbcVYAqvWdQCiVgxAt420V9uQpqukQhiJO28y/xRv+dZCxxX71bHkWl?=
 =?us-ascii?Q?u6mF7pow6t39bGnwAKztKtwHbUNid+7LB3g5sbeDuZxX1qW0TdQAYf2+Pfev?=
 =?us-ascii?Q?g+IW1dvKEtqj0UPVk7dXtv3JbLQ6d76e6yNb948QmQBXV650pA4MPFsIjgda?=
 =?us-ascii?Q?gu3BlVbIDn7ZOrbUQG+QkQAb3YTtawLtGdyVEPjKQ2RCy/gc8VTCpeaQZVy3?=
 =?us-ascii?Q?WZwjMSdWwr3tQeqU9LHNkGhuvZuGznwk0ruK1rxf2kGuAhVba50WV7iC+1PA?=
 =?us-ascii?Q?t/4CcelG7vJkTtrFKKxuHPhb8Ti2BWpfILvHfw7jupm0aVrjq96MehQUnkM/?=
 =?us-ascii?Q?zFhrLP++GiTHIWBnqv4LZvnXmENcDcvq289A3WjuC4OAHhZD/ieKSU086Wqw?=
 =?us-ascii?Q?prYMQl6XNIfnYQMAiL/jSbe1cqtF9rpara+Crwf5+hJOqQefYnmmBFKxglnY?=
 =?us-ascii?Q?vt+++H4CIvUF2G4j2n9lo4hYz5n7FGdMVsJyej8R9Jby57XkAzUhbalpK0vG?=
 =?us-ascii?Q?ZlEaMbMWvz37tMWjwjVexQBsjF6o4E4mZZ4dwMt9BYrFkYjz7kJwEtTYgUrM?=
 =?us-ascii?Q?t58uxhJ1pL7nfCkmgV1y8m4WYRIFu7M303Ga2hRF7UTngDfOeC1mG7R0162S?=
 =?us-ascii?Q?/JjK83xWGjQxWZVE8F1KeAFDf1izvOAJX1owk8OevfR2npEWxKkNjFA+Vi5E?=
 =?us-ascii?Q?ZSQ7OhspgHLU4KFNRIFmZLVD9I4+ug5NjeC9I25AeUj/wem8zc9QZ0VHdxaA?=
 =?us-ascii?Q?T0O8Ou3XTDePbIRXI+jkBVGm5fAIE/yUj2YztLdzTY4IEvqC6Yn9CnkQP4z7?=
 =?us-ascii?Q?RYKbhWXHPFT6QWHgy8kyvYLJaEGVd+M0IJ81ufDevWTa34tZjfPDHTerQ4XP?=
 =?us-ascii?Q?hbkJ5yc7762RjqeOKE0JcpsYKYuUCgJqEd/a76OONDpyQgLbY2c3CroTabn/?=
 =?us-ascii?Q?lqo4VMLFeMbARrJOl6vUuhLH7C5AVImVG6xGFjE1eP4WMfJBeGClI20CuF2X?=
 =?us-ascii?Q?FHerbww+EkS7r7l9vslI1rDQZC25XBVwBgSkZ+fs6nT6zZm6zREx1t8QB/tS?=
 =?us-ascii?Q?9QOSUVf1QBtjvUdzClJl6vvUonbuUBa/SFmPVsa7?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?+fI7QeKj1IWlcrDz6kQRckh8/gjLlKdMesLWUF87GXYZv86rP3EE8Gs4nW75?=
 =?us-ascii?Q?wwyu59bRQIwVvvvPGJanUPgSmfqEhupm2o3KaKNcJgTcjv4UKfYW659aOOk5?=
 =?us-ascii?Q?anT69Jg2hc1RQTogvuzAfjDzlFCm3ZFUEzQ209TRhiGCJw38SfFxeqzNg5/t?=
 =?us-ascii?Q?7Lxddbj5v1eeA/hA2BMya5YZ9fOvCihkE5m/awjqJ4EAVvws+hMrvCmhyASu?=
 =?us-ascii?Q?rL9D9Pc1E+g0tXosbBwlf+GYs2afsPsnrNpbPLxM7B7AxKJSk+uf7HdxmyVY?=
 =?us-ascii?Q?/ACzIvA31YZ6gfODue/hapN1IB5Ab+TGr8ik6ySFuaNWud/1cBtlXoQieArw?=
 =?us-ascii?Q?TEoKI0skKmMzEfLr0aJXTljHz12LNnlo5nUS2+TPn14l5C/mWkQb8QacQb1Q?=
 =?us-ascii?Q?RLxSDRxj/ihyabpCAm9cX1iGOsHybOV1FO31MZp1DzI7cy9bSpzEDfrNcixN?=
 =?us-ascii?Q?svy3MxJKpXMQH4mU7sF49cAqTdQjsvXovaAehgs85aVWN+K6fC9rMJ6h0W49?=
 =?us-ascii?Q?ai1K29BNSlK3lZdCT2HBGlzSWR9ND1m5rXdJwHkR1ULE8JK8COYoBJ5cg5RK?=
 =?us-ascii?Q?fza7eCOjL5JGZfEn/Lym34pd9H5X0FtNdMQ6k6hguT+BUOd9wcyILFdrBGeR?=
 =?us-ascii?Q?PxAd7SH5soVwhrJvDM06w9h64T059EbmdV5n7QKPxu1AvH6i1nvsShTODBhU?=
 =?us-ascii?Q?lzzmW7Ix4Fx3WMFemjpoNC56oQlSziFFunlcmx9/Tura33HjuuPr/uwS3V05?=
 =?us-ascii?Q?9au7XRsgSboSjyHD6EhSjqoPI/lXVlJEU63j7vkjA6Xvz87qPm/FXV/HBS9y?=
 =?us-ascii?Q?xM4N10YhGACeERX2etBQfjLQBwC4rBpNWCe0yBgaSq/uKdFwjAx1vB7p3mzj?=
 =?us-ascii?Q?rFgPQ2Ej8xtW74vHuBiArbiuXG7XawsI7r2C6ZxM/h6YEJCewWiyU92LqzDm?=
 =?us-ascii?Q?MFJUli4U7tLLMKwyKpJqkOwKmjFP09qTWQO2xqpe6ttd3r+9GP5gzq7Ckobc?=
 =?us-ascii?Q?1r+SYAF7kxRwb/R0RyC/oNyYjpvo01zzJACdgygcUY5ViaR+hWb3BPdzHGVD?=
 =?us-ascii?Q?J0WhIjARXWeXyjH6cuMOPfLk9vqJqPcbJ7frZHcpfTpMJmLEaKuHBhWDeO+e?=
 =?us-ascii?Q?pevNrAWlqBSa9Udb5rL+A/t1c/sz7WD6fw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 808d10d8-a751-44ac-a47a-08dbc61b2d44
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 03:20:23.0321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n4Xi6UUWRCzUVqX1FUSsq2KaKY1S3DqeIy7x7kBgHg65Rgli3b/mU6HsuPgK9sgTWNkhZhE0MWEW2G5zrUW5tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6615
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-05_18,2023-10-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310060024
X-Proofpoint-ORIG-GUID: NrqZk-iaAy5Mme0Hx-MT1mRc6TmxSkx-
X-Proofpoint-GUID: NrqZk-iaAy5Mme0Hx-MT1mRc6TmxSkx-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

update_and_free_pages_bulk is designed to free a list of hugetlb pages
back to their associated lower level allocators.  This may require
allocating vmemmmap pages associated with each hugetlb page.  The
hugetlb page destructor must be changed before pages are freed to lower
level allocators.  However, the destructor must be changed under the
hugetlb lock.  This means there is potentially one lock cycle per page.

Minimize the number of lock cycles in update_and_free_pages_bulk by:
1) allocating necessary vmemmap for all hugetlb pages on the list
2) take hugetlb lock and clear destructor for all pages on the list
3) free all pages on list back to low level allocators

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: James Houghton <jthoughton@google.com>
---
 mm/hugetlb.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index c1171801a3ba..d7679d37d072 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1830,7 +1830,46 @@ static void update_and_free_hugetlb_folio(struct hstate *h, struct folio *folio,
 static void update_and_free_pages_bulk(struct hstate *h, struct list_head *list)
 {
 	struct folio *folio, *t_folio;
+	bool clear_dtor = false;
 
+	/*
+	 * First allocate required vmemmmap (if necessary) for all folios on
+	 * list.  If vmemmap can not be allocated, we can not free folio to
+	 * lower level allocator, so add back as hugetlb surplus page.
+	 * add_hugetlb_folio() removes the page from THIS list.
+	 * Use clear_dtor to note if vmemmap was successfully allocated for
+	 * ANY page on the list.
+	 */
+	list_for_each_entry_safe(folio, t_folio, list, lru) {
+		if (folio_test_hugetlb_vmemmap_optimized(folio)) {
+			if (hugetlb_vmemmap_restore(h, &folio->page)) {
+				spin_lock_irq(&hugetlb_lock);
+				add_hugetlb_folio(h, folio, true);
+				spin_unlock_irq(&hugetlb_lock);
+			} else
+				clear_dtor = true;
+		}
+	}
+
+	/*
+	 * If vmemmmap allocation was performed on any folio above, take lock
+	 * to clear destructor of all folios on list.  This avoids the need to
+	 * lock/unlock for each individual folio.
+	 * The assumption is vmemmap allocation was performed on all or none
+	 * of the folios on the list.  This is true expect in VERY rare cases.
+	 */
+	if (clear_dtor) {
+		spin_lock_irq(&hugetlb_lock);
+		list_for_each_entry(folio, list, lru)
+			__clear_hugetlb_destructor(h, folio);
+		spin_unlock_irq(&hugetlb_lock);
+	}
+
+	/*
+	 * Free folios back to low level allocators.  vmemmap and destructors
+	 * were taken care of above, so update_and_free_hugetlb_folio will
+	 * not need to take hugetlb lock.
+	 */
 	list_for_each_entry_safe(folio, t_folio, list, lru) {
 		update_and_free_hugetlb_folio(h, folio, false);
 		cond_resched();
-- 
2.41.0

