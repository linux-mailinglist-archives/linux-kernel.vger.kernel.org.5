Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3302479315E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 23:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244635AbjIEVxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 17:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236698AbjIEVwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 17:52:53 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C3AE8
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 14:52:48 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 385L9wGu006968;
        Tue, 5 Sep 2023 21:52:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=FIBN6YhPsvUwRzPH0L9SXh5tL8FY8pkar6teks6b5sk=;
 b=kmyImPswIIXavrg9A7ckMlZ4unYskU8NbtNdPSV4R2GQMy/6v4VZLtboVx8yseJCuWsz
 lihOxGy609ciu4KfFEVEFNniIyf31L0N6VwJVCxcjtpyBe5PGRbtXmv84AaXgbdW3WSz
 S9tRk2E1NNGNjUqGP/0HFJbRndrfX8yI0HrrH3pdOtfjIeIZNJ8TD75qu9g9o8BKU9Ho
 AT8YuZMnjKar8wBEHCqlGQ6NcbRr51Vo7pqbUEY0V2ugK4VSkEWCiX+Fv+78jhq/d8ef
 zqc5DvyrTj1cvTsZ9CR7V/qZj7DbgLn3ORwCcjr6NwNSIddVoY6I7o+rYkKWfYb6IIY6 fQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sxc0g83vr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Sep 2023 21:52:11 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 385KA9Hf037099;
        Tue, 5 Sep 2023 21:44:22 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3suugbkmr4-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Sep 2023 21:44:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ST5G7kN1J1M43yFRzSZhnxF0odlMqK5i+ADW9AfnLUkLW/bK1vrkjpzyfV+FcFOBMhsimRABsJZuZsyKduLhOIJWWTOl+39d+BZFQ808XP5vmo06Jrc/By6/8swWx8ribFk9BsF11ITdn0Pcqu4YWY4hIJA5WDqKW+M/SAwYwsLcfCKEwyLDrLIRr5v6j7t7HtqIPLZPD2vgX+C6FYgNrXB5vb8ubPdChKHKqsWCWUarAfIqqdRuVx3wKppWUvAw3OwP5KJbRmEptYmGYh/kRR0+OamsK4mcRTkFrDtDc22xFxum90UiMKQC9clLgySDFPyIO8kObPEYtlJXJVM38w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FIBN6YhPsvUwRzPH0L9SXh5tL8FY8pkar6teks6b5sk=;
 b=bPghD+J2LtFKubKXF94BYeMy5Lwlqzo55ifZ+lhFiE2L9iwGE7B2SHJD6x21//CWdq1KRPa4mrwn+Fiib0S4vaaN55ftz2mwSYUhP2QYkyojPdtorq3No8hbq1n/o5gTlFg234ybdBk3UN0CA/Q4gTcFAchOJtPOV/i/4/ouS4uipSkcDZqr9VfU2h2etHlGPRSRp/4nHeYLjuVfFMsNpxj31VtpjqkZbBHRAgrEVdHsBfn92pLfm5ZgO28Bk8/c1Ku9pvjHVG8//8oCLfpUO5QLuNvg5zYDlNQMZXoibQ3DqSgzteeCthD47hcLBwGHZNiqjvB+IZKtZo5QujupQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FIBN6YhPsvUwRzPH0L9SXh5tL8FY8pkar6teks6b5sk=;
 b=Eb+qcFrMUrFUtj5iJJLd9/CVb4+cmYL1izF4IDuB/JEn2LpQJjCIhpfdFokBnCTXQ8FNmdSkzfQv5De39wbT4wQSqxxW1BDTl3GYqjL1Dqum8TiKXFtUasX0i+7fp2YNGCxnqT1u3SanqioaiWYz9i5El8ScYEBptn4KqPZug1I=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MW4PR10MB6395.namprd10.prod.outlook.com (2603:10b6:303:1ea::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 21:44:20 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::58d8:cf97:ae4b:1715]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::58d8:cf97:ae4b:1715%3]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 21:44:20 +0000
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
Subject: [PATCH v2 01/11] hugetlb: set hugetlb page flag before optimizing vmemmap
Date:   Tue,  5 Sep 2023 14:44:00 -0700
Message-ID: <20230905214412.89152-2-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230905214412.89152-1-mike.kravetz@oracle.com>
References: <20230905214412.89152-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW3PR05CA0024.namprd05.prod.outlook.com
 (2603:10b6:303:2b::29) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|MW4PR10MB6395:EE_
X-MS-Office365-Filtering-Correlation-Id: b2e4eb51-c3b0-4302-8f57-08dbae594302
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aQqduTujRkMeFk15PIjXX7+QdwifXw8/Ue/iYvtas74zlZVmxkZjkiMa57oYQa7eOfvjgs6U9aWweUwqwZ+nADvHDa5iDHRXHnPRa1JKutLqB4CbVnTbfKVEOOsvE0bvVC534+5Lp83zvAzGl06pMJuNPk5xtocPVebGokzsznEWAYJR3yap8Unn+nyCGtJV03cGy9lVS59rABYe4jvrpe7EHcnlGd+RdnZ6dwQeF943ljubDVGPwQVm8nWQZC9EQboEIj5aSlCqkE/kleuVYme3rrUZc9lCskSPqTbEJ+1NFoHG58mzzh2KxSlULSfj7hOUl1szdE1nBF1HSO4P3Y+a7bNNcUsGbqPmKn3A480lP5cAa/85SdnsW2QHOacvifzuhhO5lUWVwDXK0kw/zDhYRwGWO2pAC95xg+CPbGBe8neUDwdrGBDiR3AOY0qH5iIEKaP53cE4k2tJ9j9YJHwSvECajLz2dNaLZHiv9I0VyvNTbGewoEByZDABayXwHpaghZbebwRho6r9PTWbg8wrEsWUjuRGrm87UcwJC7XgngWAEXumhgwWvNEAw69N
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(39860400002)(396003)(136003)(186009)(1800799009)(451199024)(6666004)(6486002)(6512007)(6506007)(478600001)(38100700002)(2906002)(7416002)(107886003)(1076003)(2616005)(26005)(83380400001)(86362001)(36756003)(66946007)(5660300002)(54906003)(66476007)(66556008)(316002)(44832011)(8936002)(8676002)(4326008)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7X7LLAtLrXRTHmKLbKC7/EsYnUtPO01VfWjWFFjD0r63JETud0YLz6B08ZRj?=
 =?us-ascii?Q?DTc9dy7v4fgDXNjYEYvxjVHOLuy3TsXZ09AR+318PDlqzJKvkBte5xMXVKo+?=
 =?us-ascii?Q?huawRFUn//VZKz14SlQnkECUavgrxNeoKN1wG1SXGysLBo174j5TzGijDk0K?=
 =?us-ascii?Q?Esq444xbui/0wPW2qNpKzSKvMKHF+SGeqSeKFpaNC0wdS7A82a2PPTDO4rds?=
 =?us-ascii?Q?w8qB1zGNAXwN5TmxwOWUJ8a02VADxtBAkt7tFo1R1g9LUR/pI6TdD8+7eP/H?=
 =?us-ascii?Q?c+pT2cGOkKWWn0LrpObGdMOEjoKZAWRP/qdscGsp1RX2pJ+f6EB2i1EUIIMe?=
 =?us-ascii?Q?gzhclERsAOUtIJAuVA/lARDQ8UIKJaVKUO7Tp9037iW6NJgm+9YBhegiJXrc?=
 =?us-ascii?Q?EAN1Rln4YJLNCqpLkMNo+cxwQNU8Hi5nQfv605nBV36mHb3w0pMXeDMyE7dQ?=
 =?us-ascii?Q?yYIj8tWG9UBA9U2LVJBA9JMexhP43ybBOwKlkgnjA+xwz3Vnv9xDB3Qe1xAi?=
 =?us-ascii?Q?tvGBPDgwCtRdvhMzrxtN+W+Nkmsr8kbVed5pc/tjTOMOKJ8q2VuSki5Vtxst?=
 =?us-ascii?Q?PyGJO0d+oziCcklXe1RIDKqr8Mp78hQiKm0p7eCMyznjeAS5+fjemTwDH9JW?=
 =?us-ascii?Q?4VeXF9eeKWT/AEQLvILhjqzhywmuqsYVGPlcwCicOhgyVOcKztz2KPOJSpJh?=
 =?us-ascii?Q?MI0sSFw8dcOR+R5FywAKQ67O8IcgtQriHTVle8ijlciR5wxeZ3+NDmURnToD?=
 =?us-ascii?Q?Jfy/aK/xx6q9SGtyPlrgkyOM5vn+o5RY0FqcbWRdc8Nt8YklT5HraOnHN63S?=
 =?us-ascii?Q?bEVygvE4j0rXVMs1KLgs/H+n+R9ps4NeBcfT+gtqp2Wn/KBTzlMDtrVN3e4u?=
 =?us-ascii?Q?wje/TsIxG3NUDti3BFw/+2Mx4uByWOtftFnOpfmZ/NrxjK7gACt6THmEtsNN?=
 =?us-ascii?Q?P23sbRohQLSTfqCChH7aW1G/Ubi8IulP5/es5RkamuDNWz1UdOjcbnt9ay7x?=
 =?us-ascii?Q?+xCbfE+l8odfoUWRfhLXLdlRhiaD58qt+4PBGRm8V5+ggQRrNQIrr7OVQRjw?=
 =?us-ascii?Q?5SMLwFpS5YZLCN7gqpCbpmQgwU7zOXj/t1VKnQJ6kJX2nkvuVQhuemJsxxIe?=
 =?us-ascii?Q?iqLeWN9NgpfaY7pF7O20Cvufb/UTl0mGZbiWBRT0vTfA1Sb1CsaRLi2EOSjp?=
 =?us-ascii?Q?i98vBJbBZKzPL4c96Fudv65jHO8jpfgd0U963ZbY6wgERty5klODBH5blGVc?=
 =?us-ascii?Q?aJCtLbSQznqmc9jfOXvmDOKMO8wEOEi2C6oh9vKoW8NerNIj9v2M385RXPKv?=
 =?us-ascii?Q?UHTguajJAz8ebcz5crVYyp2noHl/81jPvp/3iOiHJRcA1Q4z/SiYmPsjqKy/?=
 =?us-ascii?Q?z/X16zeJqKZ4Lvfj2HzYUxCTZN+E37wLR0CJFu3ldipXJXZ9l8ID2/c8o+aw?=
 =?us-ascii?Q?YWbX9xobAC5eeWPJJiT6Fm9JFTwVPDjbTwNTZXJVOfaXTNfkHdIJJbKrnktR?=
 =?us-ascii?Q?cwmcEPKImnDU0g5d4sWci8v+X+6r4Y/p2IrG97GzLjnOa5M+xq6FiKRN+qNL?=
 =?us-ascii?Q?+ntAej4/HTrgu2aUh4GEi5QWcI5qSzvluAH0jaYYALe9uFHjalrM8xRrKwcz?=
 =?us-ascii?Q?mQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Jq0d5iaXsCM1VUTzfpx4qKr0pbEFY2IGb8ndvC1T1vdddOJGdGBDmAI3fv01?=
 =?us-ascii?Q?zWg8MMZCJBlLWcX6v+AFWhId3AGfm5j/X9Q7Ro8yg7c8lKt1iu75D2Ve9PXY?=
 =?us-ascii?Q?HyxJtdwIJ5npaRELFNLpw80L7JB9iq8+gXA/eo++71oU/s01scKyIroy50Jx?=
 =?us-ascii?Q?EDgby+hiIN8mcrakyK+JLmznzb1nglkhYall4o1Nerr/oaRV5hE9Te55mRbw?=
 =?us-ascii?Q?QKY9EX6Uj+XM577iS9uQj73D9t1Rfrki5tJk135F16iTrMRWSvaDlh+ix6rH?=
 =?us-ascii?Q?RjzkKdXfiZ2tTzRwnWO6ED+fFcaWuna3eb62dFPFtlQaoibUzFgzZ7Z2ea4v?=
 =?us-ascii?Q?6RyD9XwPmgX5rzY06UFr/GwA6Bw6N1lNZojBMMOSsvbIfn61f/RWQZEcexY1?=
 =?us-ascii?Q?5gbZc1qH4uEFeRVUj9zpDpcAn44oFve+/YYb6cUnrtW/+1IyiRs9RwPgBcL/?=
 =?us-ascii?Q?aePq19/UN1q0IemoiCNaZRuROr6PR8TWUEhWkfvn4Pc1FtbTtxzVsM+HEJGh?=
 =?us-ascii?Q?C8OWYqg+xHLZm8VKRkC5ILF9MMahW2r5cXlTYEmc+3ZgHzIwzJ7rjF6/5GtK?=
 =?us-ascii?Q?k+wY4dDjdI97IASp/Af8Hl6FlEoS6zvFCBJQ/JLGn1oNX8fdzKRvQwi2wIQ2?=
 =?us-ascii?Q?T5G12+IETjR0/R9DddDztiiw1IywW9/0ks9Ux+hcPIo3sVo3OU3Ltyj/IywP?=
 =?us-ascii?Q?Jai8PddyBg+WqR0yYOFv2qJjNeCijunpi/ccOaA/0YCFMDL7XNpuYNlJsc0Y?=
 =?us-ascii?Q?22DOKE2LnNxuVziGG4pg4f1ah8c1gEHZOcBzPiBLFw8xWOFIEsg6p7NZk+AR?=
 =?us-ascii?Q?Zt01r5B/sveGjhk04sTwg2pdNOMofLxPqIcdQop1hpcVfxJ0Mwc7ESWmXhVP?=
 =?us-ascii?Q?9D6II5GRjXNEz39+tIWJfhPw0WDocYQ6X757ck0cozn+SEYqKNEYa9geWhSQ?=
 =?us-ascii?Q?R9w9X7OZpPJXSfr84J/HKbGjauG2o5sulTd3KFlkHMEqzDoA6ZolGuutipOw?=
 =?us-ascii?Q?bNJUd1I1X8e4A0jGiXd9W11HRDq6Yhtli7qI0sbLiXstKOgaZV6Bf6bWX4oN?=
 =?us-ascii?Q?jJKlMVrglvvXOEbS9SfJw2PYDB1pidKd0KtgSOxhO8EPWfM8bMyj520aZwud?=
 =?us-ascii?Q?GUtZb22zqZpw?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2e4eb51-c3b0-4302-8f57-08dbae594302
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 21:44:20.3786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hxjtT/BJ+eb27xxv5YEprnQzSWgCQO1mNymvpXcUawwyDhSqpsshRNnQkmlOM/WhAaB/nqERWcAZJqcAGRAmYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6395
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_13,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309050189
X-Proofpoint-GUID: jMekqK1luzh1A4vhH0HMzfgFUmQxBFYn
X-Proofpoint-ORIG-GUID: jMekqK1luzh1A4vhH0HMzfgFUmQxBFYn
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, vmemmap optimization of hugetlb pages is performed before the
hugetlb flag (previously hugetlb destructor) is set identifying it as a
hugetlb folio.  This means there is a window of time where an ordinary
folio does not have all associated vmemmap present.  The core mm only
expects vmemmap to be potentially optimized for hugetlb  and device dax.
This can cause problems in code such as memory error handling that may
want to write to tail struct pages.

There is only one call to perform hugetlb vmemmap optimization today.
To fix this issue, simply set the hugetlb flag before that call.

There was a similar issue in the free hugetlb path that was previously
addressed.  The two routines that optimize or restore hugetlb vmemmap
should only be passed hugetlb folios/pages.  To catch any callers not
following this rule, add VM_WARN_ON calls to the routines.  In the
hugetlb free code paths, some calls could be made to restore vmemmap
after clearing the hugetlb flag.  This was 'safe' as in these cases
vmemmap was already present and the call was a NOOP.  However, for
consistency these calls where eliminated so that we can add the
VM_WARN_ON checks.

Fixes: f41f2ed43ca5 ("mm: hugetlb: free the vmemmap pages associated with each HugeTLB page")
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c         | 31 ++++++++++++++++++++++---------
 mm/hugetlb_vmemmap.c |  3 +++
 2 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index ba6d39b71cb1..c32ca241df4b 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1720,7 +1720,12 @@ static void __update_and_free_hugetlb_folio(struct hstate *h,
 	if (folio_test_hugetlb_raw_hwp_unreliable(folio))
 		return;
 
-	if (hugetlb_vmemmap_restore(h, &folio->page)) {
+	/*
+	 * If folio is not vmemmap optimized (!clear_dtor), then the folio
+	 * is no longer identified as a hugetlb page.  hugetlb_vmemmap_restore
+	 * can only be passed hugetlb pages and will BUG otherwise.
+	 */
+	if (clear_dtor && hugetlb_vmemmap_restore(h, &folio->page)) {
 		spin_lock_irq(&hugetlb_lock);
 		/*
 		 * If we cannot allocate vmemmap pages, just refuse to free the
@@ -1930,9 +1935,9 @@ static void __prep_account_new_huge_page(struct hstate *h, int nid)
 
 static void __prep_new_hugetlb_folio(struct hstate *h, struct folio *folio)
 {
+	folio_set_hugetlb(folio);
 	hugetlb_vmemmap_optimize(h, &folio->page);
 	INIT_LIST_HEAD(&folio->lru);
-	folio_set_hugetlb(folio);
 	hugetlb_set_folio_subpool(folio, NULL);
 	set_hugetlb_cgroup(folio, NULL);
 	set_hugetlb_cgroup_rsvd(folio, NULL);
@@ -3580,13 +3585,21 @@ static int demote_free_hugetlb_folio(struct hstate *h, struct folio *folio)
 	remove_hugetlb_folio_for_demote(h, folio, false);
 	spin_unlock_irq(&hugetlb_lock);
 
-	rc = hugetlb_vmemmap_restore(h, &folio->page);
-	if (rc) {
-		/* Allocation of vmemmmap failed, we can not demote folio */
-		spin_lock_irq(&hugetlb_lock);
-		folio_ref_unfreeze(folio, 1);
-		add_hugetlb_folio(h, folio, false);
-		return rc;
+	/*
+	 * If vmemmap already existed for folio, the remove routine above would
+	 * have cleared the hugetlb folio flag.  Hence the folio is technically
+	 * no longer a hugetlb folio.  hugetlb_vmemmap_restore can only be
+	 * passed hugetlb folios and will BUG otherwise.
+	 */
+	if (folio_test_hugetlb(folio)) {
+		rc = hugetlb_vmemmap_restore(h, &folio->page);
+		if (rc) {
+			/* Allocation of vmemmmap failed, we can not demote folio */
+			spin_lock_irq(&hugetlb_lock);
+			folio_ref_unfreeze(folio, 1);
+			add_hugetlb_folio(h, folio, false);
+			return rc;
+		}
 	}
 
 	/*
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 4b9734777f69..aeb7dd889eee 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -13,6 +13,7 @@
 #include <linux/pgtable.h>
 #include <linux/moduleparam.h>
 #include <linux/bootmem_info.h>
+#include <linux/mmdebug.h>
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
 #include "hugetlb_vmemmap.h"
@@ -456,6 +457,7 @@ int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head)
 	unsigned long vmemmap_start = (unsigned long)head, vmemmap_end;
 	unsigned long vmemmap_reuse;
 
+	VM_WARN_ON_ONCE(!PageHuge(head));
 	if (!HPageVmemmapOptimized(head))
 		return 0;
 
@@ -550,6 +552,7 @@ void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head)
 	unsigned long vmemmap_start = (unsigned long)head, vmemmap_end;
 	unsigned long vmemmap_reuse;
 
+	VM_WARN_ON_ONCE(!PageHuge(head));
 	if (!vmemmap_should_optimize(h, head))
 		return;
 
-- 
2.41.0

