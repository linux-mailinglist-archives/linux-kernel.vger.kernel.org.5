Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7CA79E907
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 15:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240852AbjIMNTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 09:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbjIMNTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 09:19:51 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB9F19B1;
        Wed, 13 Sep 2023 06:19:47 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38DD55kE005588;
        Wed, 13 Sep 2023 13:18:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=23rlc4WMNMS7EngHipUSbTTuwMzXa338GiqkhNi2ZKw=;
 b=oZcA5Xpt13K+3fFGCZbLamRKHEMEelLAXtC1flYBkpjvvJ5xzK7aKY+4hO0b3oII298N
 PhwrdVQalkBhCI+QJouCpw7uwaKrvnDHeX8aa3hc1DgTMxGg5alvNM8911ZonqTqIqrh
 PAn/2LCGU+aC15qKR0cY/oN3prP9PFkBJODerzWAj17VI01vIp9QZLWzJ5Zhhgb/DY8N
 NRxd3USX0L1CJYxAd8nyg33eSLCc5GclmWHOLk9BvLvCUNqMdiFHc85gUdAgAo+wOawZ
 ImeIY14eNzxCLXjjmm1G9KqSENdms2Os02vdcRI4f+UVt53CO6VlMHPEVjvA1vtNXD0/ Nw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t2y9ksuh5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Sep 2023 13:18:38 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38DBbic2033088;
        Wed, 13 Sep 2023 13:18:36 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t0wkggd4u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Sep 2023 13:18:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vo/DNNOST8dvx5Zn+6vfB0DGEfgXiU6DOd73t0Lj1koGOEwl5I1fx4h8FbWSj+lHnFoP/5ExKMrwSSuYbb6MVEeuH3l0fkdA5eZcBRtc7ZN/o1HuzGd+V7i1CeNMejGZbB7J82P051qSLdAGZjkwUkLFRsNz88poZ9YwEZikMFbnULI91ziWa3e1i2pf6jaNSND4Jxw9vopJiFMpJGYKhc8ibWNvHZebn1vz9nYaZtnWOilIRWe2CrkvYG8amzn0xtzM8y1LNRXUv3P7Oek5DhKZynXjarprLCVUiw2yUlgdFl+8MLQ1SIz24Xtu2GxFciA6v1QxkXkUI1Mp0HT5OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=23rlc4WMNMS7EngHipUSbTTuwMzXa338GiqkhNi2ZKw=;
 b=iGuPp7ynsrQRnOPZNtezHNmxRNwBMk3uUgpoMhbecRUWLsoDSLzswQ42P+6VJ6/AL8XHdfqi48s1acaP8WuBUJVfjTiNx5Vf32TB5Uii9bT7difLQprjb4/aWU9BFcKdN2RIlLOde0lWzZUQHsMv8nalJC0xwKJESHUGwj71+Cw1sHmQPSy4HdvFroxvAEZZn/u/z3De56qQa6wVIkAPznpWydmo1KpC6Gay75J/vrHezxDcafZDbXfMSB0ngB0Z2xZnbs3P3Z4L/vtN9+NI1//lWZCOPNMuKBzOq/WtbY1NmFOuIXcFiyxZ++PHvq60U7RgJWzgWlyTe4yrr76Wng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=23rlc4WMNMS7EngHipUSbTTuwMzXa338GiqkhNi2ZKw=;
 b=Zf0jnZmNZ0DrV7t8RtSlSh6x3inH90Fpcz+Wb+RLr5Jsc8fhj+KI8TCy2TzvzgVC5sL25UVxlejWLHPXg+nmex+15q7nb5zkEK4T5yz1+b4ay25nUHg/QSOBkRxhRjr3+lkvDMik0vH89XqVVFa/KRfQ4Iob4FJxuPA9xbGO6lM=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS0PR10MB7522.namprd10.prod.outlook.com (2603:10b6:8:15e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Wed, 13 Sep
 2023 13:18:32 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6768.036; Wed, 13 Sep 2023
 13:18:32 +0000
Date:   Wed, 13 Sep 2023 09:18:28 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Matthew Wilcox <willy@infradead.org>,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] init/main: Clear boot task idle flag
Message-ID: <20230913131828.xl7y7lriwyn4fdi4@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Matthew Wilcox <willy@infradead.org>,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>
References: <20230913005647.1534747-1-Liam.Howlett@oracle.com>
 <20230913110139.GE692@noisy.programming.kicks-ass.net>
 <14620af6-7315-4de3-ac7f-5bb51f773397@paulmck-laptop>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14620af6-7315-4de3-ac7f-5bb51f773397@paulmck-laptop>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0285.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:109::23) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DS0PR10MB7522:EE_
X-MS-Office365-Filtering-Correlation-Id: 80eb2bb6-f4e3-4305-e939-08dbb45bed62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5rOsidFijMDR9MiSWt8/6XuIe2U5m4Fw6S33D6EvT5M4g7L0RtzZBgayeOlUEhIcW87bSHVrC8B2eROSbVYB6eoJZWCukZSQ6m2FmzpU1/uFqiK0g+hZTPNur93L2j1KJdxmGthvD9K7elv5r9ThUumZmGfZmKSweNsOqk2zx7Gf2AbYOCE3qdz7TSFAo1frEil036YJsS+ZQc7AxAfuS8CZEoA0y0fBiVylqoWMCiLt7JMt+OMdaqiEmSJCg2JIsvKcjJrcVz7EK9IHpIQPsFilNUZU5koBFM6v6isTMJFIgrajH75+5MsoYEnZR20JCAZT2BQq3kQviKsk3KNDpnbNutLP8KRTfVR4EBVdQOEdtVwuNSpAw+M11mGadST0ePKpdYazCHsMwpydzaqmxwlnqQgtYs9NfytKuY+85g3ahOLLslaQhwUhvyyyUxPf6pCSKYeOVE1ti1vgc4oo3i1VwowscKm0zF/N1qCF8Cr7LrBcEJUriXL7I6gp1+nYIzewI3eWDDp/BmWnoR9hbGCnIyb5vrxPALDdQJwyRTJQk01+zd+j2fmaCdPCKJP3Dk5bYpMhadvSnvTdsjxBTw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(346002)(39860400002)(376002)(366004)(396003)(451199024)(1800799009)(186009)(4326008)(966005)(66946007)(6916009)(8676002)(54906003)(66476007)(5660300002)(8936002)(41300700001)(316002)(66556008)(38100700002)(86362001)(26005)(6506007)(1076003)(6666004)(6486002)(478600001)(83380400001)(7416002)(9686003)(2906002)(33716001)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RtSADSZjbtBB5KMJnmzmqEkQAXAuuBFiiVBT861XKmpivnSe+087Rf0nCLvd?=
 =?us-ascii?Q?Dc9UdZV1dQk4dChI2NgtwGvpSDWolYFI9nAs1SbFZtat4kEXkm9346+WleA3?=
 =?us-ascii?Q?X78DplHlYm6AARy58mEIrAF/XKbwLlvOIdjf+SgwqVHq75MGKjvwLNfxaSb0?=
 =?us-ascii?Q?B/tDslXxmR9k9WFM4UiLknAMZNCK2cze68/2GrdHRTaSjcMaxpDoaMONkNBF?=
 =?us-ascii?Q?CUv9dsR/6c4/r6Moru3rkjayYvKZWcxxatVI8M7sf0kGVTPxGQj48uexL+Ly?=
 =?us-ascii?Q?Bz8sUsld/sK2GfEjrPY5W+KhINf8QHsm8E0TtQDYfyWcVAoxaS2iOTYvUswM?=
 =?us-ascii?Q?mkZ9syZ+8BoLFSkJqvkao27ZNqJ2oXAZRbIzlD35FQATDHobv3schF04kPGa?=
 =?us-ascii?Q?ofnyblCf4LcEdp01eQHMOxxstx4z5a6dUubXFfabfhbP2cqBqccDuHwmsFRp?=
 =?us-ascii?Q?xddO+PND+6D1bFCLx3gl3hk50GC7jnhSqPab9I4+3NThEtk9plyVNbJMLMGe?=
 =?us-ascii?Q?rtQzolvM1O/xqssBCYOkTE8JzLMgr4UhnbQyoaVnA7rJdQ2ggipE/ltL+o7y?=
 =?us-ascii?Q?+dhjmq46XP43RvDWOJkaswqEVHo7LT/uiQNaXE4uELf2e/iRfyj1rd93oTV6?=
 =?us-ascii?Q?iGvthfpGm171DWvGXal3wP05RrzRCbkumdzulbbECyM6a/jk7FHocrLUdD86?=
 =?us-ascii?Q?OoHq+7PBIk6cmbXqamzJ8zmC6OCpUIA4WgK8U8o7TuLfYfd9UT1ppeEjzB0W?=
 =?us-ascii?Q?mB16JB84hd6T95UCt1KFszK2lCMpAH5fBmqX4Fz/fZKe68ltXxoprQVvoWdS?=
 =?us-ascii?Q?nHMhnJlpFqBeLYz+XvFhCENWmzf6/8gimhVLcae8lgyuxzIUmB2T2Dv4r56b?=
 =?us-ascii?Q?XYRwl2oQI/Zlx+pGQiE2yBRFBHhSMYgBsUoFOgXxxiOR1p0KUn5BA9jlVRiW?=
 =?us-ascii?Q?UrzH/y3l03Ukm1ld5L6GoSPATGUjIxTdacKAf/8JFcx6Uv9PWHelPFEF8Ozs?=
 =?us-ascii?Q?x2VQG+Bjk+Yi0c0nORoS2QMjQTPsJg63csX93IZsAURBd3WQwmFRt/V9Wtc4?=
 =?us-ascii?Q?F3RkS5zfcuI20FGGawwDdR/6MKufK8K0XiWDQ76f451LEbiCk1Dn+W4vlPmF?=
 =?us-ascii?Q?l10LUgRyj/jtC+FKpLv4tc/BjrBlR7QRjZm3A8Pztmo3pSYQCK/ebAPiZgO6?=
 =?us-ascii?Q?zbYl6hOcLqEU94+7jJDP7C5finM150CkFVDvB8Y4bP6IQZc6W2E3dt8THgAt?=
 =?us-ascii?Q?v2vsX/9f8+GIY1V3tsnH+5CCbE1mpRWlNnpYmIMsHAJ+tHmk7JNLebAdw/VH?=
 =?us-ascii?Q?e1RxX4zhy1q3moWVrc9KrprNjg6pZb8oaRhg87m+cJKSMkD8u0n4J1wSEah9?=
 =?us-ascii?Q?kwF3j1ZqsbnMuaikNhaU2y/FjyLPgGORvsLO/uPodhwhVsRM7mvsyLL4zLR4?=
 =?us-ascii?Q?8PR88BGpNKxgHcBpDrIz/+daC26PMsaN3DQ/nnZp3wBXgBCJ+ljooDYtGKba?=
 =?us-ascii?Q?kDJbTYLZKmD/1U2R5yclTIL6HuhX3Bd8/G+k5HjKJd3CA/VRzxx2HAuIhaJS?=
 =?us-ascii?Q?FMkssmHJu1T7fjq/fxfHpJLgJFVOCrtLTwWqfWIN?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Q++3NJhZt9iWnWlLX1Qw1lzQSk4U+oTH0QVuoURGS1Se5Y8WNlIDloAYi524?=
 =?us-ascii?Q?jxTuJos6oEMg1Sq7DTbPg38RWNRnlCXOLqi8Xg+xy9tBFkdmc5F2m46V+b53?=
 =?us-ascii?Q?4g86JNWOCYTT6FuzDGfpDGL7X5nm3J6Ua63IyS5WyFPpOPlooMMQ743IAv5/?=
 =?us-ascii?Q?hIX8nux8QJf5O+bWS7WPXmpqYCVXpKoI0vgn565BS7ki8bGqqKpTpJPaGCLC?=
 =?us-ascii?Q?NRf2FV/r61QpWXfgxPNvryLwewWkKz3vWF8eBWtifs2f9gKfQEmPGPiqGniM?=
 =?us-ascii?Q?g953LGS7WOA/4zvfXQZ5i5dW8mBaa9dnvXa/FfyueyQQq2mgXLfaX0OBVU45?=
 =?us-ascii?Q?CmYO3Mj7LCo+ZJgb2UPgr/f3mAPng1SNlNqstZvolw/nxgkk6p1ZuH+FVXqH?=
 =?us-ascii?Q?1nTizz+8SOC8pIPUyGy8yQhMtYUIYkTdonQFe/CYE2w8QghpC7JyDiTYis49?=
 =?us-ascii?Q?aI7EcOj99cY7SiD8iBnuRgCdwvDWIWOep4I40DtdLHwi+WpG2Fo1st5SUQ5k?=
 =?us-ascii?Q?G3CywZkZxQysOjMqHgwwnQn/ORS4ToFY5nQ4+sQofz3rt495Q5oEe5z/UtXT?=
 =?us-ascii?Q?jmXn6fDk3+mS78tavBsEQ1fE1dr2eICN1on9szw9bro+IGqYJrZBfoOgGbou?=
 =?us-ascii?Q?t2G73Qn/XCsDVXSJcueV9UCHwDcD3L2b6BRgnuirAtkoy7dMTeuKj9OLf2Mz?=
 =?us-ascii?Q?MpUCQX+vkRgx8Lo9nGFDHPafXEyhaWGrQkmR6ovTj7Bhl0kt54xg8CR93rUp?=
 =?us-ascii?Q?Aaf4g+l67V+dBr4DyamGBoM2BWHjVAn1WeEvb0DtPwQFvC4A34LXnS1KMnjw?=
 =?us-ascii?Q?/EK5Z8iha8H1KhCc/44FZ7HvxcOPf6hOQAZ7A5wGP/3yp4RTXnGnLyQ8XC1j?=
 =?us-ascii?Q?k9aiRymIzxPBip/0+AGAWrqt/uuem5wssLhVqxIjUpAhf1NaP/VljsbnJh8N?=
 =?us-ascii?Q?FnKD9OKJ1MKG/cf9rDa9oTefG6/5kEgLQHF0G9rP2qqohIDTh1kOzrbi7fwO?=
 =?us-ascii?Q?D/nHMaOAdBVjjVu+gSkviB4Y1uHv6iGyUyKMYaTb/WEW22ULgyV9QFTTvtaM?=
 =?us-ascii?Q?1jq4atGa1vygD6PXhH8re9In7OmecPTgHd+IBkJukLB4/VWxxH2QbauFo0/K?=
 =?us-ascii?Q?bAL+1CB1JTA8PbsglzZ2/qlgSotlscXMAg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80eb2bb6-f4e3-4305-e939-08dbb45bed62
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 13:18:32.2187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TWCPGY9kOYVtngsEkPVYaY+TN+vrhWMtbkF2Vu8uwEuJBzidAKL6n7Vk0hhZlRVxcuVZ9H2fCtKo3ufbZXCtzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7522
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-13_07,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309130108
X-Proofpoint-GUID: 3ejg_IPU9crQgtDsUfL3tx7PvKNoAtG9
X-Proofpoint-ORIG-GUID: 3ejg_IPU9crQgtDsUfL3tx7PvKNoAtG9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Paul E. McKenney <paulmck@kernel.org> [230913 07:28]:
> On Wed, Sep 13, 2023 at 01:01:39PM +0200, Peter Zijlstra wrote:
> > On Tue, Sep 12, 2023 at 08:56:47PM -0400, Liam R. Howlett wrote:
> > > Initial booting is setting the task flag to idle (PF_IDLE) by the call
> > > path sched_init() -> init_idle().  Having the task idle and calling
> > > call_rcu() in kernel/rcu/tiny.c means that TIF_NEED_RESCHED will be
> > > set.  Subsequent calls to any cond_resched() will enable IRQs,
> > > potentially earlier than the IRQ setup has completed.  Recent changes
> > > have caused just this scenario and IRQs have been enabled early.
> > > 
> > > This causes a warning later in start_kernel() as interrupts are enabled
> > > before they are fully set up.
> > > 
> > > Fix this issue by clearing the PF_IDLE flag on return from sched_init()
> > > and restore the flag in rest_init().  Although the boot task was marked
> > > as idle since (at least) d80e4fda576d, I am not sure that it is wrong to
> > > do so.  The forced context-switch on idle task was introduced in the
> > > tiny_rcu update, so I'm going to claim this fixes 5f6130fa52ee.
> > > 
> > > Link: https://lore.kernel.org/linux-mm/87v8cv22jh.fsf@mail.lhotse/
> > > Link: https://lore.kernel.org/linux-mm/CAMuHMdWpvpWoDa=Ox-do92czYRvkok6_x6pYUH+ZouMcJbXy+Q@mail.gmail.com/
> > > Fixes: 5f6130fa52ee ("tiny_rcu: Directly force QS when call_rcu_[bh|sched]() on idle_task")
> > > Cc: stable@vger.kernel.org
> > > Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> > > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > > Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> > > Cc: Andreas Schwab <schwab@linux-m68k.org>
> > > Cc: Matthew Wilcox <willy@infradead.org>
> > > Cc: Peng Zhang <zhangpeng.00@bytedance.com>
> > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > Cc: Ingo Molnar <mingo@redhat.com>
> > > Cc: Juri Lelli <juri.lelli@redhat.com>
> > > Cc: Vincent Guittot <vincent.guittot@linaro.org>
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > Cc: "Mike Rapoport (IBM)" <rppt@kernel.org>
> > > Cc: Vlastimil Babka <vbabka@suse.cz>
> > > Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> > > ---
> > >  init/main.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/init/main.c b/init/main.c
> > > index ad920fac325c..f74772acf612 100644
> > > --- a/init/main.c
> > > +++ b/init/main.c
> > > @@ -696,7 +696,7 @@ noinline void __ref __noreturn rest_init(void)
> > >  	 */
> > >  	rcu_read_lock();
> > >  	tsk = find_task_by_pid_ns(pid, &init_pid_ns);
> > > -	tsk->flags |= PF_NO_SETAFFINITY;
> > > +	tsk->flags |= PF_NO_SETAFFINITY | PF_IDLE;
> > >  	set_cpus_allowed_ptr(tsk, cpumask_of(smp_processor_id()));
> > >  	rcu_read_unlock();
> > >  
> > > @@ -938,6 +938,8 @@ void start_kernel(void)
> > >  	 * time - but meanwhile we still have a functioning scheduler.
> > >  	 */
> > >  	sched_init();
> > > +	/* Avoid early context switch, rest_init() restores PF_IDLE */
> > > +	current->flags &= ~PF_IDLE;
> > >  
> > >  	if (WARN(!irqs_disabled(),
> > >  		 "Interrupts were enabled *very* early, fixing it\n"))
> > 
> > Hurmph... so since this is about IRQs, would it not make sense to have
> > the | PF_IDLE near 'early_boot_irqs_disabled = false' ?

I was thinking that this isn't an idle thread until the end of boot, so
leave it set as not idle until the end.

> > 
> > Or, alternatively, make the tinyrcu thing check that variable?
> 
> We could do that, but do we really the decidedly non-idle early boot
> sequence designated as idle?

call_rcu() tiny is called more than this code, so unless there is
another reason we want to check the IRQ status it seemed best to change
the boot task flag.  I mean, I think the is_idle_task() check is valid
in every other context, right?

> 
> What surprises me is that this is just now showing up.  The ingredients
> for this one have been in place for almost 10 years.
> 

Am I just that lucky?

Cheers,
Liam

