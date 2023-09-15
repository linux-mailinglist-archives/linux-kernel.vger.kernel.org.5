Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54CCA7A2A5F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 00:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238090AbjIOWRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 18:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237945AbjIOWRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 18:17:04 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963F583
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 15:16:58 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38FLxYgm007900;
        Fri, 15 Sep 2023 22:16:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=i7fwZVFpbWQwFa0ZuX0bGyigYcZrLBRp0FddpocwtE0=;
 b=A7BjxVX84mtGamQPYAdWr/fSLgiivgO9lgcMX3tj7vM+XWzaMwSackgQMX5h8NgHAipk
 Wc6Mnq4kGFIIXetCANWRqJ40qW6/h0WpvQmqKdPfudls+71INbjmGYLQD/RdPyQ9qtVG
 6dxxledYOa9WnD02QPhn5D7s49PkNqoCQvaQtIYJurKrFlNdnRrZuE7jNTns/2+Q24sl
 uq6u5xwgrqvlfxy1uHFDdrGRrlh+eI4I5EllboN+E830wqSQ2smCipGT1l11x3jBvqMC
 HyB/aVvDBEdyexP5xcoSsi9X5XF4OBmWZ4LGmuoJv2jofcx871pfIZEplKmTNNSjHau0 NA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t2y7hgsw7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Sep 2023 22:16:23 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38FLT2W6030436;
        Fri, 15 Sep 2023 22:16:23 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t0wkky7bg-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Sep 2023 22:16:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DoAJ7T9CcPyCNGrhpHLb5UQgyUonfGeo9Sj1CDdsQxK7iDzywDFjknRvHrkTg+UGAQQIdQ985wryxriioTOU89F3tIueiWcxtbfTyTa4fSW6xkvC2cnU7yzrNzs9V0QfxIC4kfS9w142qerkHKNGJw3rDy/cYh2db3byYStmxIUYt1xq/zAAUx9pTbn719+mJi+YMPMusZhJB/fsjgQHHVAE7TLoHmf/aZT0+PvzXp3cfsjshQt9hFRuT16VzvqbLS6gM1a+kc4CEvmF1cH+tQgw5OyF0BJkCp2nlXXU82kgvJTocZ2a/huhFrY05KVXWho6667O3xDETTww0uM9aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i7fwZVFpbWQwFa0ZuX0bGyigYcZrLBRp0FddpocwtE0=;
 b=BnzzgRRJMfe2HYtAphmEhWidmSGhwDSKYDxVE2Jb5C4wMRDZ1I9AFStG+Qwyu+aCf8mJxxVxwFU0Y7ZT8f4M0/SGC30PU7Rgd2q+11xRrVUe9DqkAY2Oz8o4gz7N9MOlquSkPjQJOKdccLdJbclR5cc8gSvCIa05dPDiGNV9VtmXBwQBWfg3jUc+Q0lE1uP6C5LWRS9MwQyDLu7gHtNJjRPL2l+P6rNtf9iplncfxCZ4rfpct1nkW9LJ85EZiTrv8Haca7GVNUMjdJwQm8RvNGOmjN57g2DRn3O1noCNSX33p3A6ahurZoduHmUJATCWHNtkPMTK6e77OEh1qPbsZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i7fwZVFpbWQwFa0ZuX0bGyigYcZrLBRp0FddpocwtE0=;
 b=hekVPJiq3PNVpaYka1ea+OkS/95a+PRwnDEj11aAVso5UyVV4mHvWRyl4IEDxyavSEIZAKaiSHax32kcDfYyxFC76BR5gu+1MrkQ14K1NwjP+20m1JU5FyqJyaIqUXC33C9owIONZlO0TFAmsoH+NOHVa2byqmw2Pgcve3cPFzg=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MW4PR10MB5861.namprd10.prod.outlook.com (2603:10b6:303:180::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.34; Fri, 15 Sep
 2023 22:16:20 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054%5]) with mapi id 15.20.6792.021; Fri, 15 Sep 2023
 22:16:20 +0000
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
Subject: [PATCH v3 10/12] hugetlb: batch PMD split for bulk vmemmap dedup
Date:   Fri, 15 Sep 2023 15:15:43 -0700
Message-ID: <20230915221548.552084-11-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230915221548.552084-1-mike.kravetz@oracle.com>
References: <20230915221548.552084-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:303:8f::20) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|MW4PR10MB5861:EE_
X-MS-Office365-Filtering-Correlation-Id: 83779850-a1f4-4c4c-577a-08dbb6396361
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4FYJdwDnKtduyUk9VDhYRSzya2gG/SN7La5w3Nwmq+l0ITUDSkKsrFRBUYcTM9TWk5hi0LBnx1CKzEwS95fpumZvJZzIp84YhP1lgJSsh+TZmVYpMFOkgwEEaJr7txEtA9PPbtgT66EiEMfLI/jvM/Sq3641aWakGYfetkA2yseR+1aQK7rHUXgGIBdBwLUOY4iXDal/d653okPLyR8crhcEGI8aZYKIxPFiOBNHfYuk72jpzvnzH8c8avd9rku7hvW0ntUm1uuzRlURnxyGOFFk0okPOKt9h1B2Gon8+jcig6+EjWhPzYqaZU/bVulyyjArtmQaJIHT1xp2m/SCSWQqS9zkcVnjPFJq4iazqROe5fFsfGNATGtNrEMPNV/HqPAzYQZdcbZV2UmG74Y9K2tt+yMMAxJOmeZU7glBUMChviRLG1QJLBiVtPLthtg9ipHY1SRv23VwafUEZ0TYK6B7uYTaYZ9IpoGVhPMc2aXs0bZpV+DPq/8OJysC4FyLlTj2MPrav02aFVx1yeuevm7tWyptJ5A4vd8L/GOXaWq8iq44UXGMGp2jl300NlLp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(366004)(376002)(136003)(451199024)(186009)(1800799009)(44832011)(86362001)(36756003)(83380400001)(2906002)(38100700002)(478600001)(1076003)(2616005)(26005)(107886003)(4326008)(6512007)(41300700001)(5660300002)(6506007)(6486002)(8676002)(6666004)(66556008)(316002)(66946007)(8936002)(7416002)(66476007)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?//J4X2tl3RBtZ4X5hGZ56j9TFYAm2xMwRlkCea5yrQwPP4mHsRr8whc+Ojhi?=
 =?us-ascii?Q?fNeEHrD5DBc5Xm0nVctYyP4ynCIOxzUMkcKb4J1Dcb3VwCFXG25/lP/tP2VF?=
 =?us-ascii?Q?0ckSMsnjjB/m1aB078l8vBP9270RnU0tALo/EV8ygV4mrjfLEPVe+68cz68l?=
 =?us-ascii?Q?nOStd0CF17kLOcHReTjGPm2G+mnjZexNRr9QnYvw6Jg4tzVuE5VK7rxQf5TT?=
 =?us-ascii?Q?OLPMazCcIDTbuc5SnSsqpqZINPCAsEVPV6+GIP4yqPYXs+R64JvQREA3+89i?=
 =?us-ascii?Q?HbtCyzf5XnBbqd9f4faQ6ckTayesqaqOkUCAVXClbAkAqQgQpNQBIGkCbp+A?=
 =?us-ascii?Q?kIS5lj+u7vpuj0d+uVEV1Sn4s5pt1gu/gw/7JE2U+/d1gTuy1A7zKOI2bpS7?=
 =?us-ascii?Q?7daq0tDcOJTfzm/jyyjAbdoCRSltkKEvvwrJjtSYustJUnp3rB2y6NDl143w?=
 =?us-ascii?Q?diWhtIRijrDaQdL5KwNC6nAH1SS7tpeu0tqtY9iX2uDoz6UP9nhwl+NuFNoe?=
 =?us-ascii?Q?Xj+gCqDUyE431CvssRHc93Lpwu8H1iRtT1Ss1PAgJO+Q2eEqp0bX4gSOQbWl?=
 =?us-ascii?Q?Krsb2IGSXSZLAGdoApJw7jBSZuzVZ/ZBhZWggcgxuRGRNJUrQbt6r/lxnQIQ?=
 =?us-ascii?Q?M21lCUOYgt2XBSbnVy4jKJK5J5cDsZCDEOrDTXjBhvAMaEs8Je9ZjVz9UXFw?=
 =?us-ascii?Q?tv2yWTNZWJlCEru3OK6XEAYCJZoP2UBRZlFQiYnu0A6q453ix+/2lYgUTtSX?=
 =?us-ascii?Q?LWi1AmlHN0LumUnSzxV8cIvcrCmScZ9lKAgnJMisgGex39IubGW5no+uIsDl?=
 =?us-ascii?Q?jhDMleieqQxHGHq/2SbD1/eDxYgxqcs+btT8LnXv1ZpHcV3p+Jy/mPT1HJpn?=
 =?us-ascii?Q?S5fJ1r6jDhxp59yvXNc6Z/RIs2ui+dRjYo/GX5BBJXfG1rr+zoWiO8rYcjHN?=
 =?us-ascii?Q?O6rYE+DjXNIYqwl2cpHPWcLjSmONzgTTRW/1Z53f8U6ZvFPvAu5QIxIktRra?=
 =?us-ascii?Q?z9m3ZL6fRooTiatO7/33CeZGJApIyoPJBgrlZzqJIIMftyCkO4bNrCw1QNp8?=
 =?us-ascii?Q?X+jfhFQOvTZOe+fhh7EDjhTjS6amjQ3728WYzdiGETgeZjrPt+jGf6L1PsSD?=
 =?us-ascii?Q?hhXPSr0ZukWa+UbBxWe2i+L+nsZgx7MKAL2/ufBl4M5cXh1BAUx2eIwfKrAl?=
 =?us-ascii?Q?SUMIyj06asenX89jYGBnZBX4onPLfWEFqRup61hHamSV+FlYrXAIZ5ioAuhG?=
 =?us-ascii?Q?ALZDgr7jrFDTvP1is//fLvHHIs5acDVWHsf5GmsFkPE/hfkEHrt7Iwzb8/Ev?=
 =?us-ascii?Q?RKBC077Gi4/6IQVqMRCsrWOsvDDTjg6KeV4kBBgKHHmHSK8Yv+xbH/GDb6UB?=
 =?us-ascii?Q?Ej8JFZ4YYdTWWLBB/3jGJbDgSV5TeJHzMKVOe0u5Sa+3UcKNrUAzVyfNedtG?=
 =?us-ascii?Q?QINOh/A6QxUX9RiUI2NL1j4Q/wL84ndC2utqNpCkbzc0R9IEsWA72DlJG2np?=
 =?us-ascii?Q?XU08u9zikN8omKOsJNvIvi/+zNGNweR3k1hrYSsyupQ17n8T4mkVxQdefdlT?=
 =?us-ascii?Q?RVMAnSRWctfuDJ4NT7R4UMGjZcwPMWHhMAt2fJJ/TZ+ah1HLlL6ZJhMgXHI8?=
 =?us-ascii?Q?iw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?pjTQymCEGuf2VPI3AuQgZtjpfeOhmdbpvTlGPQq/2a1aU0m5FwH/L0/RuPBZ?=
 =?us-ascii?Q?xQBIchVrDxNF9iX1Y39GFgQw7JJ947opYwVYfutyx2nRtUrFUAFmQlLYi/nT?=
 =?us-ascii?Q?R7rym3Z3H1J7xVWXqqPIU6eepZ0Am/e4n/X+F8cNQtOfGSBMYYSYuVwXtPyt?=
 =?us-ascii?Q?j5thx1mxkie8xxRDYU2SbNkT1KBrA8opWbqxHxtaXll74xUuC7L9y7iaBslq?=
 =?us-ascii?Q?lWONI/vRAwfC8mTJIsZ7GBaoBL7QQlbVGxjJFrVk2XvaKz1XMw/hwxAX1j+k?=
 =?us-ascii?Q?KiW+cilhIIy5bMCauShWcZ75CBqu+wCII0w6PYAbH5az+368Y46ovQwLbRal?=
 =?us-ascii?Q?aQAUOFtJTFnKvnsUaxaJyhNNGS+tENrv8gecktT5JAKN4tJ8GETzK60hIhET?=
 =?us-ascii?Q?TgNyGzlO7gzlvJAPXCJK1chIieYtJCGmOIbMw6xUjsAq/9r8m/PE0Cb+5Ipl?=
 =?us-ascii?Q?hvDV6ui5hRJHrISWl9VwoaeIYyhgOyS9c/cPWXEJncaNlJwIq3URhgbvq1vt?=
 =?us-ascii?Q?r4wph8NlBh+CVRd/ujVm7x4uZax3frxE16tN6pIZ9cUpswHNrb/6hla1TqCY?=
 =?us-ascii?Q?iLxjTHqdIyXsokXrx7SljwMcL8uh+eo092hPFruVieqt4V45aSzIxVtJBJJP?=
 =?us-ascii?Q?y/poUa4dy6WSgGfbGy5rRhmP1E+zvUZp3soeKQFCmy236CA2WWFHq+dE8SQz?=
 =?us-ascii?Q?Lfxux69NdJaQ8w3ScZ/lpceaTPCUjgpL5H1IZPIp4YkT+Ora6Se7e2gilsJT?=
 =?us-ascii?Q?4McFjItTqHNJrBLqVXGf5OdkUUNWmRXDSw1NiK1D6RZHieSFUm6jiWLzppjg?=
 =?us-ascii?Q?xV4XZm51pF4OhIDWjaNTXBqIpq7kuJrJlv24QiT8GAXQfat7SeEKcnDwMjBx?=
 =?us-ascii?Q?bXfs8Lv3zBxusJTwMcLgMlE7T636obMiGx/v9mN/PV3Rl9UeJ8jnj7oKNi1E?=
 =?us-ascii?Q?V/tFtsz4DtMrvzmtPoXXeMEKp7LqS2XjsRWuSTPYfhInWlSerH5M+SEIEGnB?=
 =?us-ascii?Q?gQzAbXS259U5afF2pdzV3GhG95mfHL16ZZQDyagiKwdSkhdTjK/qELN59lSB?=
 =?us-ascii?Q?PA5O3VqhaeNmoqtYd39sjngjZW8hDjm7Z9OBD3u3eHiu7TpWf8IB5CIyY1EX?=
 =?us-ascii?Q?tQgsidKFUC0U?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83779850-a1f4-4c4c-577a-08dbb6396361
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 22:16:20.1263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qEQa972aHiADMUJ74b3mxrCowS/6u2UmJPGdchF7RHLsEpjugpMMJ/mitw6Izzl7CjqhHFmpOxc4QLcswcYXXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5861
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_19,2023-09-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309150200
X-Proofpoint-ORIG-GUID: KuDrkyMSSY7FmhcBC3uRDuUOa8b8d87G
X-Proofpoint-GUID: KuDrkyMSSY7FmhcBC3uRDuUOa8b8d87G
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
---
 mm/hugetlb_vmemmap.c | 79 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 75 insertions(+), 4 deletions(-)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 8f8a559ff6ac..c952e95a829c 100644
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
@@ -35,9 +36,11 @@ struct vmemmap_remap_walk {
 	struct page		*reuse_page;
 	unsigned long		reuse_addr;
 	struct list_head	*vmemmap_pages;
+#define VMEMMAP_SPLIT_NO_TLB_FLUSH	BIT(0)
+	unsigned long		flags;
 };
 
-static int split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start)
+static int split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start, bool flush)
 {
 	pmd_t __pmd;
 	int i;
@@ -80,7 +83,8 @@ static int split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start)
 		/* Make pte visible before pmd. See comment in pmd_install(). */
 		smp_wmb();
 		pmd_populate_kernel(&init_mm, pmd, pgtable);
-		flush_tlb_kernel_range(start, start + PMD_SIZE);
+		if (flush)
+			flush_tlb_kernel_range(start, start + PMD_SIZE);
 	} else {
 		pte_free_kernel(&init_mm, pgtable);
 	}
@@ -127,11 +131,20 @@ static int vmemmap_pmd_range(pud_t *pud, unsigned long addr,
 	do {
 		int ret;
 
-		ret = split_vmemmap_huge_pmd(pmd, addr & PMD_MASK);
+		ret = split_vmemmap_huge_pmd(pmd, addr & PMD_MASK,
+				walk->flags & VMEMMAP_SPLIT_NO_TLB_FLUSH);
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
 
@@ -198,7 +211,8 @@ static int vmemmap_remap_range(unsigned long start, unsigned long end,
 			return ret;
 	} while (pgd++, addr = next, addr != end);
 
-	flush_tlb_kernel_range(start, end);
+	if (walk->remap_pte)
+		flush_tlb_kernel_range(start, end);
 
 	return 0;
 }
@@ -300,6 +314,36 @@ static void vmemmap_restore_pte(pte_t *pte, unsigned long addr,
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
@@ -323,6 +367,7 @@ static int vmemmap_remap_free(unsigned long start, unsigned long end,
 		.remap_pte	= vmemmap_remap_pte,
 		.reuse_addr	= reuse,
 		.vmemmap_pages	= vmemmap_pages,
+		.flags		= 0,
 	};
 	int nid = page_to_nid((struct page *)start);
 	gfp_t gfp_mask = GFP_KERNEL | __GFP_NORETRY | __GFP_NOWARN;
@@ -371,6 +416,7 @@ static int vmemmap_remap_free(unsigned long start, unsigned long end,
 			.remap_pte	= vmemmap_restore_pte,
 			.reuse_addr	= reuse,
 			.vmemmap_pages	= vmemmap_pages,
+			.flags		= 0,
 		};
 
 		vmemmap_remap_range(reuse, end, &walk);
@@ -422,6 +468,7 @@ static int vmemmap_remap_alloc(unsigned long start, unsigned long end,
 		.remap_pte	= vmemmap_restore_pte,
 		.reuse_addr	= reuse,
 		.vmemmap_pages	= &vmemmap_pages,
+		.flags		= 0,
 	};
 
 	/* See the comment in the vmemmap_remap_free(). */
@@ -630,11 +677,35 @@ void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head)
 	free_vmemmap_page_list(&vmemmap_pages);
 }
 
+static void hugetlb_vmemmap_split(const struct hstate *h, struct page *head)
+{
+	unsigned long vmemmap_start = (unsigned long)head, vmemmap_end;
+	unsigned long vmemmap_reuse;
+
+	if (!vmemmap_should_optimize(h, head))
+		return;
+
+	vmemmap_end	= vmemmap_start + hugetlb_vmemmap_size(h);
+	vmemmap_reuse	= vmemmap_start;
+	vmemmap_start	+= HUGETLB_VMEMMAP_RESERVE_SIZE;
+
+	/*
+	 * Split PMDs on the vmemmap virtual address range [@vmemmap_start,
+	 * @vmemmap_end]
+	 */
+	vmemmap_remap_split(vmemmap_start, vmemmap_end, vmemmap_reuse);
+}
+
 void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_list)
 {
 	struct folio *folio;
 	LIST_HEAD(vmemmap_pages);
 
+	list_for_each_entry(folio, folio_list, lru)
+		hugetlb_vmemmap_split(h, &folio->page);
+
+	flush_tlb_all();
+
 	list_for_each_entry(folio, folio_list, lru) {
 		int ret = __hugetlb_vmemmap_optimize(h, &folio->page,
 								&vmemmap_pages);
-- 
2.41.0

