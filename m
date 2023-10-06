Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 015F67BB07E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 05:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjJFDVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 23:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjJFDVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 23:21:24 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420C2EA
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 20:21:20 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3962O5IM013551;
        Fri, 6 Oct 2023 03:20:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=Tsc70UZvKWYWI+spZQiVZ3u2z8ZAo9dlRTusEOzzs6g=;
 b=olpdDtdzl/CwxMMvnqZEFjSQX+IquBx9RLp19IIjNUhzsJR7/nDQwPi7b7smEgQEl/Ew
 e3iaocS/eUd5VcsIAzDRPvUSyTsyrlOXPlNKO0JM666X3DQi2lS4YQpETHCMA5aod0zl
 O2tI3Fw5hiksBkI1Fe09JhpKPZaLDRceEtS26O7CtIIlqFnHizeHZ2MzQasgIoVi1Qo6
 g5PmFCTktRdMuACOEGr8abul8hD512e6t7TL//f5SITVGRwHdai1sCzrSVElD17Cf201
 rA2MKurRlVcB2piZAei1w7VmlvzgtOajt2xEs+5cnHh/VttLYGgJyfDjxvrX1VCS5WhB uw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tebqe31sn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Oct 2023 03:20:45 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3960ZFQd000462;
        Fri, 6 Oct 2023 03:20:44 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2044.outbound.protection.outlook.com [104.47.56.44])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tea49xw5j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Oct 2023 03:20:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G5iPwe0XAUt0yYZMacMLd33X+fYyEigQzt+p2RCGfzPatrJjuxVbVSQ+vpjwv8Vz11SGQNECaqN+QbX01orMNPA2gDXmj1S6m/1NNYIVc6bE5uepHTFCrtI1yKrGUksq1EGCjGJK0gL3w9Dof+GRS5pcAsrqI4RiYqgSxNGQawbHeIwe/CbixTFjItoShPkELsz1GzclnkbCl2dF7Y28avBfUTESQemf/oAXRC667USw94DjBcos8Lyf5h2LIpvf1rWCukXFekRFEoANyghcGcsFpPUoZILonOS91GovU1F+h6zEpeDs2wbf+Cri8r/tVuvatsyw7Nnp1eanvIi1tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tsc70UZvKWYWI+spZQiVZ3u2z8ZAo9dlRTusEOzzs6g=;
 b=czXjKQHfK+InGMIsUV3Y2zoX6mebVFmVAqAvj4yJh06UgEHIaFdPdBqwj1AWB6IDKpamySrf5TNzNbC5ojB19a/huaetCVQjxkYX2VXdEcjCWeXL3dBCo9N6CQkaWmQgenwMzy4uiFZervuaKIhL7thZVpzaZ3irQBO6SE93qqcGmLTkjhc+LO/wPzedi6BI7AAZE7Z0hS7bjbNdPfAgQls/+n3oOWTJCBruGARtIdlXtttj3zrk3eSr0iwawV1E87AKoT78DNTAVSRmPRD/DCMRszibxoBjQT4BQruafkbaqWIjgAYYb+cb/olsFp1h1wedGwupoTS4gLem7r6Kyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tsc70UZvKWYWI+spZQiVZ3u2z8ZAo9dlRTusEOzzs6g=;
 b=g4Tuc5vx5yDq6klYbhgJdI2+UdFcQdljiponoS4TzqPh8+XBKLRGHFXN8N0ShHyjJDvG/2FNbGzYFjDfSdfAZS3sKAT9P77jwtdEkTVpHlfxee2sw6+QDdXxBADpCttCRiL30xuIiVNwrVLyqiXV0lv1oyYcAG6AClqJjhj3tDE=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DS7PR10MB5391.namprd10.prod.outlook.com (2603:10b6:5:3ac::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.38; Fri, 6 Oct
 2023 03:20:41 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::59f7:ec45:eb41:d8c2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::59f7:ec45:eb41:d8c2%6]) with mapi id 15.20.6838.033; Fri, 6 Oct 2023
 03:20:41 +0000
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
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v7 7/8] hugetlb: batch TLB flushes when freeing vmemmap
Date:   Thu,  5 Oct 2023 20:20:09 -0700
Message-ID: <20231006032012.296473-8-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231006032012.296473-1-mike.kravetz@oracle.com>
References: <20231006032012.296473-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0357.namprd03.prod.outlook.com
 (2603:10b6:303:dc::32) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|DS7PR10MB5391:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d80be4f-e16b-4ea5-1abf-08dbc61b383f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W/cYXfL1LFwvYYhs9Ds/a8TPTpSdzs0VMGXU5UsO64Oo+Dc5jyRZ4eV4ymkdLdHZ60VZhdCHWgC0DEU1JvgyAeYQqiXeOjXLV13/9IAPIhfkd/awo4qnZ/3Q51iP9vNFt7HOUcCA7UrXZWNJqqBdp+7Qcq5AkR5yiA1VLS1vXmzhfTA7PtR7/FUwgHcNd0PDIdTnatqE22nqkP08GXIKN5eUDcmQoI/N8DNuypLLyHC2/0ZwROWiX5S4SDvQfdjD6OogxinIiH/7Aa3faVDAx8kjA+HeUns34JSJcfUyUJe0t8aFACUCuB2zPdCEW2tMGbhKV0zTbOuuIEN9jUZe/yf/43SwDAD1Z8gN/03KJDfjhdJwNjG8KoF1zHT2t3jJsPoNU1Fs+jqjSuZW+crktZBZrttMDh5l39Plu/9hjNOt8WTFBwbR9vEMtBpTBeJkYFf/xj2QI6QCea2L/nYonuqDvPo1ZR+dCZzCiZehtoFgZbGZuyQl0yFm5t7UNIAuYW+7yRHcsUx3JbSJRyD3xF+ytzCtN0XL0CX/vdqRU7qJ2AOs0YjXzduGm695Z4eA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(376002)(136003)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(6506007)(6666004)(6512007)(6486002)(478600001)(38100700002)(86362001)(2906002)(7416002)(316002)(41300700001)(2616005)(83380400001)(1076003)(107886003)(26005)(36756003)(44832011)(66946007)(66556008)(66476007)(5660300002)(54906003)(4326008)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9tGa+2DSHFIMvqeG4oW3Uw3sRQ77YNnIrRFMLm7KF7KXi6PbpqP1pPUo9Zi0?=
 =?us-ascii?Q?obEJraBICepfd4hY9jHdvl79wgs5EjKXnTe4b8mAQt9txuGskn5INTgsqM/2?=
 =?us-ascii?Q?E222EnpK1ai/ppQAZKET3ed1OjXegZ5qXNpP3jQQrNKYgQDqUo9WQHwcrad/?=
 =?us-ascii?Q?Oh9dfO4Wm+PUQId0xLS+OcZDI6yWli1GqA0M9mw+57Etq+J8ndeyLLymXg2R?=
 =?us-ascii?Q?RPoMLCfwfu4zmn3ZNP8WV/QNAmrKaNaQyKs2hLBpPtkgfEXzWV3TJw2D4umz?=
 =?us-ascii?Q?Tq/Ro+5AWfrm4/L3jFfk4pJx9k0I7BihYUDmKORBi1ndLRtXa4Sh05FSQhk3?=
 =?us-ascii?Q?UcA+lsB7rLrSWUSAQphSnTIHU5b3DY9QXMkVDsM2MF0cs/jvlocsGdbf3Ke7?=
 =?us-ascii?Q?o+zN/J/kXcqP+EkeRd0cOI2Pifwzglre/crx+3SncpXiG2wPIxU9fVZuNMbN?=
 =?us-ascii?Q?lbVB421SqtiG8PZUFAOVqK30jsGhrqDyiYlmULgCnP2dyyEu0YGE2BaXHD3i?=
 =?us-ascii?Q?dthMBqEFZDpQq2Uvd+HOOzBj1Cft1qoFToFG77jSXaceazxnv5NC0DJbBjSd?=
 =?us-ascii?Q?gsMFayE1yk7ssLfkXLXw5B9OJTTv6CGrpiC7BkwrlR8PpuJRUlDqnTH6wsPP?=
 =?us-ascii?Q?PcV6b+PQUZ8tno1ylvDXhZ5l5IcdPhvMl7L9I1yLUn4LXkVoUpevMLUPlGuk?=
 =?us-ascii?Q?qDCvnXmS3MPGZyHSSmhl6DfIvsiYSw+JyI8igpNXy/Jom8xhw5/489lN/fZ4?=
 =?us-ascii?Q?i3bVWRQZUrLZ4UngZxb6UtIngdlBow2KZ9PoIVZ6TPLuYNpetSDseXTQ9SPQ?=
 =?us-ascii?Q?xASBjMw/RVgEFxTBJQKuQQYfM532H19+fYIcBK/QcROcmXtEGu0HvitDql4E?=
 =?us-ascii?Q?/TIfXSLvFes16aQvaLl0ZDeGjJ594ck40CFLRfeWlyf0jzkjDoMaSYTRXPPg?=
 =?us-ascii?Q?Nlk/YjFZ72USLmwQx8VNiMkug3QuDDJwQmKToitzIa3qDQg2/6gBDSqv2FD2?=
 =?us-ascii?Q?88/C0H5XDJj63uCks7LLhHrH9HKdTp4ANnj1dhDmfand+LZaB6yVuK+AxyP+?=
 =?us-ascii?Q?m2OzNOrxwNpxHJDbagGOhV1RPzzVCUaH41VS4ltqNJVVM6t6uAKrBu8Qw7Hk?=
 =?us-ascii?Q?WPbC8+/AcAsjYy2laGHZ7pXg6Cfw3vkEiJ+jeZ3ikrSAjlspJixzR+tGLCs4?=
 =?us-ascii?Q?aj3SfUr2NLJBCwjIUQihGGH1Bf/bcdtzIG9sIdzhZDHaPriRxjg4JEL/5+72?=
 =?us-ascii?Q?y1VNNdxfQ3/6BE5v5hGRGaFC1s164P+wcoFobwr2eVE81NBtqyeSyWxE+QQP?=
 =?us-ascii?Q?RWYU9wGQcwhIcKjjdgMFvWsLgLiPWN1Z1Gx0q2Pm9g/cI51K+gratrxCGzCO?=
 =?us-ascii?Q?nsNHlqKVYY/EEqapHDLFSW+dnbKnDAuG/+jydirSNO9zh7QWohP6SK0NHbei?=
 =?us-ascii?Q?2PX+QJWEaiAvR3Cag/ZKvylvpOO4Xsc9u5G9U8TMvCMN8FSleiUSW3CKD5KQ?=
 =?us-ascii?Q?HFJqsIPF1WiC57r3rNVfD7YidCAloxTUB3nTL7TgqfEW84YD9yCJYyo8+eXw?=
 =?us-ascii?Q?YhhSvpRF4AEvVLh+GG0MKES2d3+rDRI/rjPlLEIPGYmr8bdb54aSQYxswWzS?=
 =?us-ascii?Q?qw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?yLpf8DyXI//t1sGbnSBP6Ts/fSd7j2mwwpN4gOox/Z7mYjRWmHysTCCOkXY6?=
 =?us-ascii?Q?AEZuaH/3VbvY1strOqm1TcdNbquJ2YZcH/0Qe6QalY6PKWV3do8cmYQcm8Pm?=
 =?us-ascii?Q?Yx5KN0Zxt0/7oJtBVZ3uP3DdPuYdUSw2QdJg8S6S4TA+E5+nebIwqAIoakva?=
 =?us-ascii?Q?+J/bBGMFDGDTVoy9rN1ouMMwenWroAw4Q0w+9j+YMFBayCID1mX/OZ5npllR?=
 =?us-ascii?Q?5DKlt7cz8suHsHsEvRYkXpxhmO5D5kq2FFQeNsRNj2/LveuLNN1huUd8Ustd?=
 =?us-ascii?Q?BhV/kmb4vp1YikLaF4lqSMekVn0xtzdNxmEi7snqCMM/8GGOFqt1O2UmopkP?=
 =?us-ascii?Q?YjlrYKr6fFmqeXxvCvLXn650ShKJ1byu43a5qdku9tn6xT48ZIl1HRIX9GEM?=
 =?us-ascii?Q?LSWmZYP8P2OJKy1og60M/cUL16p6GZEAkooF5CuTLcE/i3nv61kmyQI54tsB?=
 =?us-ascii?Q?6Zf96gl6NidjWadh9riAHvgHUsjJ+3RfVFycQz7cvpGcfuYdIJOTawjH/F0H?=
 =?us-ascii?Q?2VMCyh5uN8id7aYKl4ZMeNouV76yxbBMlTA5pEKOpUvBDbhs3Jyp3VNW0BOf?=
 =?us-ascii?Q?+51dDeQ74m/6sIPEOAJ/waxDRr+QWNWSx3edP+nIhymwUXXKatviZSwHxixi?=
 =?us-ascii?Q?4lFWop6b/TriPteI8Vor5Xutw5Vt/riBA98x18e/PuE461sYKGe7uHMj6qh+?=
 =?us-ascii?Q?HQyWHVJtOyiy6pxNjLccqrrmKNDQxpM+D9FO6O2uA8oT/vpJxZ2JimZ0Qyn9?=
 =?us-ascii?Q?zAszFpGJeGelqh8uGIbIPoThGH8Hv4l/wSMTwUMfsCcbOS+ebLgHCOnt/q6R?=
 =?us-ascii?Q?dhoV5IT/JUEQv+Yas+Nv7l/FKN8pYiRSboVlEhHHKkQOO+qltyyvTqf+f+Cv?=
 =?us-ascii?Q?P4rf3t6CthYx/YKLrZ1dRCDOmjacq0kJvcIHii5fzWclR4vCksifyQKDGRgM?=
 =?us-ascii?Q?fCVqq/IorX5MOdnF5a6lcwJ2Di3ayE5FhMtXiNJkoLuy4D4TMoqiuAmG6lE2?=
 =?us-ascii?Q?zck8HYdUyKaeZZvC4C2WpmYZpwOB/NRqAbGWSDDFRGVrEBJpy/8OXRlOCizT?=
 =?us-ascii?Q?cj0/lCBflHonQMNlHXCs84hh4M9KNpnlUoNfo+g/49+Rik7GfHMiSnq2iUpt?=
 =?us-ascii?Q?U52I82DCrRQVgRKw71u5O8W4k4illTmojg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d80be4f-e16b-4ea5-1abf-08dbc61b383f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 03:20:41.4226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D0RhtxQO8uLswloaQpO6+HggiAeSMBiUdm+T4jrIdafgVGUa4OeABoz3ZAJXTPiSz0eLDyxqGBDjuhP2FqyyUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5391
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-05_18,2023-10-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310060024
X-Proofpoint-GUID: -47XGJ4857WhJEnnl-UfNGV4jqLyXxaq
X-Proofpoint-ORIG-GUID: -47XGJ4857WhJEnnl-UfNGV4jqLyXxaq
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

Expand the flags field value to pass whether to skip the TLB flush
on remap of the PTE.

The TLB flush is global as we don't have guarantees from caller
that the set of folios is contiguous, or to add complexity in
composing a list of kVAs to flush.

Modified by Mike Kravetz to perform TLB flush on single folio if an
error is encountered.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb_vmemmap.c | 49 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 38 insertions(+), 11 deletions(-)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 10739e4285d5..9df350372046 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -40,6 +40,8 @@ struct vmemmap_remap_walk {
 
 /* Skip the TLB flush when we split the PMD */
 #define VMEMMAP_SPLIT_NO_TLB_FLUSH	BIT(0)
+/* Skip the TLB flush when we remap the PTE */
+#define VMEMMAP_REMAP_NO_TLB_FLUSH	BIT(1)
 	unsigned long		flags;
 };
 
@@ -214,7 +216,7 @@ static int vmemmap_remap_range(unsigned long start, unsigned long end,
 			return ret;
 	} while (pgd++, addr = next, addr != end);
 
-	if (walk->remap_pte)
+	if (walk->remap_pte && !(walk->flags & VMEMMAP_REMAP_NO_TLB_FLUSH))
 		flush_tlb_kernel_range(start, end);
 
 	return 0;
@@ -355,19 +357,21 @@ static int vmemmap_remap_split(unsigned long start, unsigned long end,
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
 	struct vmemmap_remap_walk walk = {
 		.remap_pte	= vmemmap_remap_pte,
 		.reuse_addr	= reuse,
 		.vmemmap_pages	= vmemmap_pages,
-		.flags		= 0,
+		.flags		= flags,
 	};
 	int nid = page_to_nid((struct page *)reuse);
 	gfp_t gfp_mask = GFP_KERNEL | __GFP_NORETRY | __GFP_NOWARN;
@@ -629,7 +633,8 @@ static bool vmemmap_should_optimize(const struct hstate *h, const struct page *h
 
 static int __hugetlb_vmemmap_optimize(const struct hstate *h,
 					struct page *head,
-					struct list_head *vmemmap_pages)
+					struct list_head *vmemmap_pages,
+					unsigned long flags)
 {
 	int ret = 0;
 	unsigned long vmemmap_start = (unsigned long)head, vmemmap_end;
@@ -640,6 +645,18 @@ static int __hugetlb_vmemmap_optimize(const struct hstate *h,
 		return ret;
 
 	static_branch_inc(&hugetlb_optimize_vmemmap_key);
+	/*
+	 * Very Subtle
+	 * If VMEMMAP_REMAP_NO_TLB_FLUSH is set, TLB flushing is not performed
+	 * immediately after remapping.  As a result, subsequent accesses
+	 * and modifications to struct pages associated with the hugetlb
+	 * page could be to the OLD struct pages.  Set the vmemmap optimized
+	 * flag here so that it is copied to the new head page.  This keeps
+	 * the old and new struct pages in sync.
+	 * If there is an error during optimization, we will immediately FLUSH
+	 * the TLB and clear the flag below.
+	 */
+	SetHPageVmemmapOptimized(head);
 
 	vmemmap_end	= vmemmap_start + hugetlb_vmemmap_size(h);
 	vmemmap_reuse	= vmemmap_start;
@@ -651,11 +668,12 @@ static int __hugetlb_vmemmap_optimize(const struct hstate *h,
 	 * mapping the range to vmemmap_pages list so that they can be freed by
 	 * the caller.
 	 */
-	ret = vmemmap_remap_free(vmemmap_start, vmemmap_end, vmemmap_reuse, vmemmap_pages);
-	if (ret)
+	ret = vmemmap_remap_free(vmemmap_start, vmemmap_end, vmemmap_reuse,
+							vmemmap_pages, flags);
+	if (ret) {
 		static_branch_dec(&hugetlb_optimize_vmemmap_key);
-	else
-		SetHPageVmemmapOptimized(head);
+		ClearHPageVmemmapOptimized(head);
+	}
 
 	return ret;
 }
@@ -674,7 +692,7 @@ void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head)
 {
 	LIST_HEAD(vmemmap_pages);
 
-	__hugetlb_vmemmap_optimize(h, head, &vmemmap_pages);
+	__hugetlb_vmemmap_optimize(h, head, &vmemmap_pages, 0);
 	free_vmemmap_page_list(&vmemmap_pages);
 }
 
@@ -719,19 +737,28 @@ void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_l
 
 	list_for_each_entry(folio, folio_list, lru) {
 		int ret = __hugetlb_vmemmap_optimize(h, &folio->page,
-								&vmemmap_pages);
+						&vmemmap_pages,
+						VMEMMAP_REMAP_NO_TLB_FLUSH);
 
 		/*
 		 * Pages to be freed may have been accumulated.  If we
 		 * encounter an ENOMEM,  free what we have and try again.
+		 * This can occur in the case that both spliting fails
+		 * halfway and head page allocation also failed. In this
+		 * case __hugetlb_vmemmap_optimize() would free memory
+		 * allowing more vmemmap remaps to occur.
 		 */
 		if (ret == -ENOMEM && !list_empty(&vmemmap_pages)) {
+			flush_tlb_all();
 			free_vmemmap_page_list(&vmemmap_pages);
 			INIT_LIST_HEAD(&vmemmap_pages);
-			__hugetlb_vmemmap_optimize(h, &folio->page, &vmemmap_pages);
+			__hugetlb_vmemmap_optimize(h, &folio->page,
+						&vmemmap_pages,
+						VMEMMAP_REMAP_NO_TLB_FLUSH);
 		}
 	}
 
+	flush_tlb_all();
 	free_vmemmap_page_list(&vmemmap_pages);
 }
 
-- 
2.41.0

