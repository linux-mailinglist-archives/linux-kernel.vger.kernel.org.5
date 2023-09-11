Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE7C79AFE5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238389AbjIKWmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357372AbjIKWF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 18:05:26 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A6640F4F
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 14:55:27 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38BJiFf1030218;
        Mon, 11 Sep 2023 21:53:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=WWkcEej4/AeipgrcBl5XvGkIvrDG+jhHc6aj892xC3g=;
 b=zazI92OxEW7M0qdHvNSqvx4UO2Bg29tLD4avYpDQrRq4zfa3v4foE2TKm0wl3SzMJCGC
 Z9NBF0kgGA5Ju/wnC/8uz2aQm6BHxm3cCSXZSjO7FjRnGD85CSce+WtPAMp0WUl0WULS
 DxYFe5A6KQ/TaNGGpV4+0QgGRr1WAHy/UsM8TksLEzpv9CCLHLDaq1KBJQhr9QOkrtKW
 IFL0YC3i/pymkHHhs8G/sQQ5ajHt0l3KX1sKWGxcCOqNkp1jmIT+rtWOsk0rBGfZUqkJ
 Vvs5FQhBn2FUV+KmQH6JoOnIIRRQhaujSAifIk0cBsFBr38mipBcNTXb52bSueXtmIP4 EQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t1jpatkgk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Sep 2023 21:53:33 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38BL0sRL007726;
        Mon, 11 Sep 2023 21:53:32 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f54uvpb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Sep 2023 21:53:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FpaFIY9GQm48demnOJ2mz9j5WDyZ8PI4HaM7dBNnAeXyj2vJJUr6XSO9vkCAwKFgm25RQyemgOIYbjZyxzxwtUZstSdDwjTGVIajBUzgeOR4x0d+5cPJISRhApjbAh2UANSsPBqXvNc5W3EKZzEjuHikcfTgpbMpOyx/sksrAr275UYP7uk0/oLNbnKWxClYqL459BARwUZCYr5OEmUuqbVh+4Qo247o4ydTtUO9bOpkldm4blabNwUxM9qL6TdJ2gvdAByX7BnUf4CwJDTG+zeWssOG9Ia1guHpEV8bRhPN6XF5nKAkMNIVJjkwE5ZYD6mNGYbacl9ydjebED4V8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WWkcEej4/AeipgrcBl5XvGkIvrDG+jhHc6aj892xC3g=;
 b=oCtif1K2ylZPknDmOGlSNgDeHjg4zaBwFoJP8M6cnC7I58bELG7SxU5nfrwyoI+xwIgdyPcuZKl9S+AXvhhFOhsWQYNh0ISveWiS32wAt27K4ICCFsBTN2TB/da9ipPLhbST20UDPLnAPwNWEA8z3Q+gNN06O4r/T+WBJqMFxCXI20cgsGKruj+nzRwmYkXBaWCC6tiFhYLVQiT4d/qCMZ5xQooUEt65/EZhWEoZrfhaQ5iHpqEnXiedIIT5jpeuG39NrGyycVpehJMNN6Dk+Pgrs6WIHyw5O1gd8vtxdy5u9mQysEGjAVrQ/Y4SzX76n+I0iWI8Swm2awSvz139hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WWkcEej4/AeipgrcBl5XvGkIvrDG+jhHc6aj892xC3g=;
 b=ggON0Nf6T0NYmkfkIczC6Gj6dwn8XC0K91TMLAXdpFe+cg9GyeCS5Xexmdyy7Xs3/fYDVE+fMK5hrNHvFziZkWZCIkXUUni33PCJtyVmuaKjYQIXzHpLtOS1ljUM+z/Jk5fLm5q/l7mV/SSOLHUtSNJzQOlb9NxhYACynfeE0rY=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by MW4PR10MB6439.namprd10.prod.outlook.com (2603:10b6:303:218::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.34; Mon, 11 Sep
 2023 21:53:24 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::924c:4cd2:a7db:f9ba]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::924c:4cd2:a7db:f9ba%6]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 21:53:24 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v7] mm/filemap: remove hugetlb special casing in filemap.c
Date:   Mon, 11 Sep 2023 14:53:19 -0700
Message-ID: <20230911215319.644224-1-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::31) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|MW4PR10MB6439:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bf96ae4-f7eb-43f9-50e9-08dbb3118582
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rT3/lricsLLTOh9FAEWeoZeJGr3MufEZEk8fqpSilwHIuM6AHFlTqBEWYtA9TNd/1n7nTcV/+jeANVLg+K7eJPXRg0GA+L11FEnVQztP+N1VpNeryDaTKceqB7cHtN2/PmOdEuoiTamueOVhU4vSgqiZqfHhY6jlMfno7dHvUjp8JaWD6agaTUP716+HUUYJXSmZ16Zfk6ByGuQg8ZhHgXN3KlDCzhwgRPlsR989FoH89qaOn0mJBRCd/iEiioKCOQwy/6j5/P1dYDqktlHzGKnEgvM6ptJhtrK7Hg0biVZtmxVXlJScEtAPXmBCSe++M3VLwKj5IVgPuy7KYd11XINmcX5rXReEU1ztZSHoGdBLeW/OebLbsyVk4e6ckLZmc+BHoJf2PleqtpwNqmmqA3RW3QksqP+FV+MmOCE7XBklP8OiT1gf9KQ+YFJm8Jjtt6F3hdBlqdk8HqJdMBL+rxyuMs9UolTT4pdhYrg5Pi9wIzkAeve0r9dZSbmmixKsxKXhd0aQq6YLGv+AJQvn7O0JvAY9gcGxlUyBWzCg357+pvvL86Ntwflqorh485JxFm6+EiytBZ/mt48r6Sd+nQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(136003)(376002)(366004)(186009)(1800799009)(451199024)(41300700001)(6666004)(6506007)(6486002)(83380400001)(6512007)(478600001)(966005)(2906002)(2616005)(30864003)(66556008)(66476007)(66946007)(44832011)(8936002)(4326008)(8676002)(107886003)(36756003)(1076003)(38100700002)(86362001)(5660300002)(316002)(66899024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NBH1cFRXANiG3h0PVnKbkcAU0sNv6eZ+OC1seThysetMJX4MtckHDsekC/kf?=
 =?us-ascii?Q?YO4DCmcXIfZRXvWBxk8TCp2X98siD/dou7iR5yeCU1Fdh3D2c0LB83z6BDGU?=
 =?us-ascii?Q?VZUIQez7ffJr/mwNeYTMsfqoHsSdmu5L/rJO0U7Va2vhZKXE4AP5nuD0sIJt?=
 =?us-ascii?Q?mneSr1i/7WKoaCkrmD1MPzzBg5ahHdg8C9HZtv9ak6kaexAScqtFggDSrmzm?=
 =?us-ascii?Q?gDYIpX4tcHvHO2g7eTRQSnuk9eUTwYpBLYkg7pV4wCR7RAeCaOp6H1yOmOTO?=
 =?us-ascii?Q?AUl8c1Do8E9U5d1pgeKYOjOmKA3oEmG3ss0VbX5u8K67/WTVUawy+XTYE+SR?=
 =?us-ascii?Q?IevIEb95xjyqNNlP3HD3NwpNfXxpRtxvREZljGVpiceZ7FPCuiL2TBEru1Xf?=
 =?us-ascii?Q?8hyJ4+89hFQCJQkH73mQO1owfPD0HRfcRZFXuKKsLDaXvGY1n2YSd6cGODfF?=
 =?us-ascii?Q?mx71oPfPnnHZgh0OD4nF0x2ZEemwW3QZn7Sq6McmSy9D+GvKW93ToTZRCBAT?=
 =?us-ascii?Q?mzf9MthK2+7UI+1kM1tPyy7yAhnQ9TKloR3HGIsov/AYutf3G3qIghYQE81N?=
 =?us-ascii?Q?6KMB06qKf0NkutvPd5VZbeNDFhWeF4uxj1g5mk5+48c9OnqoOWjElAm7c0mH?=
 =?us-ascii?Q?OqmN87W639G2VWdr09etD7vT1gi3T0lWX9EtZg6XpBZfq6epK68oANfYK+sK?=
 =?us-ascii?Q?GjlWLFqUzwtZ9Vwnei//Bb0mE4LQndZT80OwFFcObE9BRrA0vpWKMUcporaC?=
 =?us-ascii?Q?CHRMmBdjSatJUGOaBV9qopRhioIziGDFkKuQL3O17hPBPYA2e8uVa+bObylX?=
 =?us-ascii?Q?J959hhb/kk6tOcVXStCkXSWC+hy5BmuZL/Aa0ehoKiAeOY2p/oQhCtoZo2mw?=
 =?us-ascii?Q?5VsRFb2xwvCdvP6T2n0Cy5KyW1xmBcITPhNH3Ws2wYvCfO8i+F/Qa4wmgvPY?=
 =?us-ascii?Q?C0RiHxYGilej5TKLTN7MWaamJon8sayoFT29sL7LTH2jCheIwayx48YiO3/D?=
 =?us-ascii?Q?SJsh2hDwSa3Gb7AK9hKwf+XQ/H3pg11wLM6de98au4cbpD3x/45681IxcwwE?=
 =?us-ascii?Q?LAfU81be+p0ZumxuGPanELskSx7VDRIIkicJ1UArynMRyIZU77DgB/Guq5C7?=
 =?us-ascii?Q?jDTjIEDh1PtgqWQOFdErnq2B3TiINzWYwZKG5Na7RLgSCCPXA2G6erkJWR2K?=
 =?us-ascii?Q?tu3S6N2R0v/aPagsCCbw+5yXWSMswv1ErCydAeHVYtr89akM6NgZ4oahWV9q?=
 =?us-ascii?Q?iaCQa3LxmRsam2dTgbhRw5cVsdmdhzkcj2totu6h9RH3CnJOEGWSbYG+q/vd?=
 =?us-ascii?Q?RMRNAxIcLIFfk3cipsQ3hIFa4ooM7aSwh+QHuLNQI3WlobuKsOaei2RKQvCU?=
 =?us-ascii?Q?h6snf3PLeHsw/uaKM/SYYXogT4qUrL8GR+OA4ZWfKL4IRF5XFVxgUdpWSkSb?=
 =?us-ascii?Q?HMx1fnPR47Sh501jPu5JiOOI/tli/bKrFfrh7ruiWhJzC0XtA/3P5VXLNzPA?=
 =?us-ascii?Q?ilDe36zcivxn7oy37cMC3G/Id9UB4nJUDoxLRv+qjDAP+xaDOrT/vvZ+SwxI?=
 =?us-ascii?Q?c30MhJrnWzSko/y8P9IB5+UUyqTr3f67l4eZUyKorEYzgdyq5Wsxk/qFFFf6?=
 =?us-ascii?Q?hJVyfZNb2KIOGC7btigFjAA=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: iMij1N3Yhv+Itl3AsdHjRE6mO+iGKTtQZva929p8EsuNF3M3UhvX+4wqManhANV2t5nwem467RjcZLJCypMOSrtJDrtUQBfdcj/xGNO46lavpuRd93m0MgPDr88Ra/YuYUM0FocJ23vu/kQvxJK3Qg9imo6LF1jykTqd6Eg1BJVuOmnzyJY130btp6qX/Knl4AD4G6pz5M2hHf4f9U52mYycgygKVUebUHw6LptyCl1uLZg+VPoGli0zFEcND/zIdaBi2WYovTdsYUeEKyCu/nWitTiw39Mg9Dau43SWSI644s2kgsxaOrIk5o4frTSAQ/ZGDmrN2rzP+dbKMlT75Gjpul5nH2iul+IJKhJKUB3LZ96NKTrIfC9fD3mJnWcAAgQw8vMIj7HMqABVcUw9K2iCH7NRrg07Ka8BlZekEFTcYvB+OJBcYEIfwuyrQ1Bu7J9WvCBCkBIOt7jL1TnaHdp8HrH16IYTec2jDjvYf/W0abdV9G0ZUogxy4MQ1e/1P2t3r0WbUkSthoobEB8dF0eP2GGNF6D3AEWClXBj7AMzv1yPKNVYYtVl2088ThV0wDLZQJ1wTaQOa8MWP1nan8QWcDDRqHG/EWIDkY7lNcy5iAOK2OKo+i1Lqr2Jzd+qwJTO4YbGS1o5446XWMFcTF6X6vg7W3td9UVOS0TqeuHk9GS088HhUVPIAzu2F9VPJFgq6WeeIFcJMcaZcgCuU0GeUhSn3fWD+2fBS38QgoXN+b+DEoS+Nh72+nFztf7hcvJ1ibiZDi1J9TO3ATEmi/dbVPGHaqFWm6jeJPoEFMh3/MeBsjputKREd0hP6coryUhd338BaLdzLych4gj7IodL+J/FT6FpPppVR2qR/LVu2zcmF65K4TY8RlM4kAQscKFktblxxdJ8sV3l4YbW9mngDo4soZ/yPebrU1h2Rnc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bf96ae4-f7eb-43f9-50e9-08dbb3118582
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 21:53:24.0532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tLSuB5v5XDqKNCKObH5GhBbRU9RQXgSXO6ed6T6BOCgsBjLeemQEJd5GGpFjpNjty8ctUp5svm1d0To3fJwZaCPWEfPBmdBxWC/GLC8pwTc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6439
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_17,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309110202
X-Proofpoint-GUID: Nl3XCpb1LrXWCU57npcXS4gC1vrFcQju
X-Proofpoint-ORIG-GUID: Nl3XCpb1LrXWCU57npcXS4gC1vrFcQju
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove special cased hugetlb handling code within the page cache by
changing the granularity of ->index to the base page size rather than the
huge page size. The motivation of this patch is to reduce complexity
within the filemap code while also increasing performance by removing
branches that are evaluated on every page cache lookup.

To support the change in index, new wrappers for hugetlb page cache
interactions are added. These wrappers perform the conversion to a linear
index which is now expected by the page cache for huge pages.

========================= PERFORMANCE ======================================

Perf was used to check the performance differences after the patch. Overall
the performance is similar to mainline with a very small larger overhead that
occurs in __filemap_add_folio() and hugetlb_add_to_page_cache(). This is because
of the larger overhead that occurs in xa_load() and xa_store() as the
xarray is now using more entries to store hugetlb folios in the page cache.

Timing

aarch64
    2MB Page Size
        6.5-rc3 + this patch:
            [root@sidhakum-ol9-1 hugepages]# time fallocate -l 700GB test.txt
            real    1m49.568s
            user    0m0.000s
            sys     1m49.461s

        6.5-rc3:
            [root]# time fallocate -l 700GB test.txt
            real    1m47.495s
            user    0m0.000s
            sys     1m47.370s  
    1GB Page Size
        6.5-rc3 + this patch:
            [root@sidhakum-ol9-1 hugepages1G]# time fallocate -l 700GB test.txt
            real    1m47.024s
            user    0m0.000s
            sys     1m46.921s

        6.5-rc3:
            [root@sidhakum-ol9-1 hugepages1G]# time fallocate -l 700GB test.txt
            real    1m44.551s
            user    0m0.000s
            sys     1m44.438s

x86
    2MB Page Size
        6.5-rc3 + this patch:
            [root@sidhakum-ol9-2 hugepages]# time fallocate -l 100GB test.txt
            real    0m22.383s
            user    0m0.000s
            sys     0m22.255s

        6.5-rc3:
            [opc@sidhakum-ol9-2 hugepages]$ time sudo fallocate -l 100GB /dev/hugepages/test.txt
            real    0m22.735s
            user    0m0.038s
            sys     0m22.567s

    1GB Page Size
        6.5-rc3 + this patch:
            [root@sidhakum-ol9-2 hugepages1GB]# time fallocate -l 100GB test.txt
            real    0m25.786s
            user    0m0.001s
            sys     0m25.589s

        6.5-rc3:
            [root@sidhakum-ol9-2 hugepages1G]# time fallocate -l 100GB test.txt
            real    0m33.454s
            user    0m0.001s
            sys     0m33.193s


aarch64:
    workload - fallocate a 700GB file backed by huge pages 
    
    6.5-rc3 + this patch:
        2MB Page Size:
            --100.00%--__arm64_sys_fallocate
                          ksys_fallocate
                          vfs_fallocate
                          hugetlbfs_fallocate
                          |          
                          |--95.04%--__pi_clear_page
                          |          
                          |--3.57%--clear_huge_page
                          |          |          
                          |          |--2.63%--rcu_all_qs
                          |          |          
                          |           --0.91%--__cond_resched
                          |          
                           --0.67%--__cond_resched
            0.17%     0.00%             0  fallocate  [kernel.vmlinux]       [k] hugetlb_add_to_page_cache
            0.14%     0.10%            11  fallocate  [kernel.vmlinux]       [k] __filemap_add_folio

    6.5-rc3
        2MB Page Size:
                --100.00%--__arm64_sys_fallocate
                          ksys_fallocate
                          vfs_fallocate
                          hugetlbfs_fallocate
                          |          
                          |--94.91%--__pi_clear_page
                          |          
                          |--4.11%--clear_huge_page
                          |          |          
                          |          |--3.00%--rcu_all_qs
                          |          |          
                          |           --1.10%--__cond_resched
                          |          
                           --0.59%--__cond_resched
            0.08%     0.01%             1  fallocate  [kernel.kallsyms]  [k] hugetlb_add_to_page_cache
            0.05%     0.03%             3  fallocate  [kernel.kallsyms]  [k] __filemap_add_folio

x86
    workload - fallocate a 100GB file backed by huge pages 
    
    6.5-rc3 + this patch:
        2MB Page Size:
            hugetlbfs_fallocate
            |          
            --99.57%--clear_huge_page
                |          
                --98.47%--clear_page_erms
                    |          
                    --0.53%--asm_sysvec_apic_timer_interrupt
                
            0.04%     0.04%             1  fallocate  [kernel.kallsyms]     [k] xa_load
            0.04%     0.00%             0  fallocate  [kernel.kallsyms]     [k] hugetlb_add_to_page_cache
            0.04%     0.00%             0  fallocate  [kernel.kallsyms]     [k] __filemap_add_folio
            0.04%     0.00%             0  fallocate  [kernel.kallsyms]     [k] xas_store

    6.5-rc3
        2MB Page Size:
                --99.93%--__x64_sys_fallocate
                          vfs_fallocate
                          hugetlbfs_fallocate
                          |          
                           --99.38%--clear_huge_page
                                     |          
                                     |--98.40%--clear_page_erms
                                     |          
                                      --0.59%--__cond_resched
            0.03%     0.03%             1  fallocate  [kernel.kallsyms]  [k] __filemap_add_folio

========================= TESTING ======================================

This patch passes libhugetlbfs tests and LTP hugetlb tests

********** TEST SUMMARY                                                                                                                                                                                                                    
*                      2M                                                                                                                                                                                                                  
*                      32-bit 64-bit                                                                                                                                                                                                       
*     Total testcases:   110    113                                                                                                                                                                                                        
*             Skipped:     0      0                                                                                                                                                                                                        
*                PASS:   107    113                                                                                                                                                                                                        
*                FAIL:     0      0                                                                                                                                                                                                        
*    Killed by signal:     3      0                                                                                                                                                                                                        
*   Bad configuration:     0      0                                                                                                                                                                                                        
*       Expected FAIL:     0      0                                                                                                                                                                                                        
*     Unexpected PASS:     0      0                                                                                                                                                                                                        
*    Test not present:     0      0                                                                                                                                                                                                        
* Strange test result:     0      0                                                                                                                                                                                                        
**********

###############################################################                                                                                                                                                                                                                                                                                                                                                                                                           
    Done executing testcases.                                                                                                                                                                                                      
    LTP Version:  20220527-178-g2761a81c4                                                                                                                                                                                          
###############################################################

page migration was also tested using Mike Kravetz's test program.[8]

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---

rebased on mm-unstable 09/11/23

RFC v2[1] -> v1[2]
    -change direction of series to maintain both huge and base page size index
     rather than try to get rid of all references to a huge page sized index.

v1 -> v2[3]
    - squash seperate filemap and hugetlb changes into one patch to allow
      for bisection per Matthew
    - get rid of page_to_index()
    - fix errors in hugetlb_fallocate() and remove_inode_hugepages()

v2 -> v3[4]
    - gather performance data per Mike Kravetz
    - remove start variable in remove_inode_hugepages() per Mike Kravetz
    - remove hugetlb special case within folio_file_page()

v3 -> v4[5]
    - rebase to current mm-unstable
    - include time data per Mike Kravetz

v4 -> v5[6]
	- fix build issue by removing hugetlb_basepage_index() definition 
	   per intel test robot

v5 -> v6[7]
	- remove folio_more_pages() from result of incorrect rebase

v6 -> v7:
    - clarify commit message to demonstrate the benefits of this patch.
    - fix error in hugepage migration by using folio_expected_refs() rather
	  than 2 in migrate_huge_page_move_mapping() and increase the dst folio
	  ref count by folio_nr_pages().
        - this error is due to __filemap_add_folio() increasing the ref
		  count of the huge folio by folio_nr_pages() which
		  migrate_huge_page_move_mapping() did not handle
    - remove linear_hugepage_index() as it is no longer used per Matthew Wilcox.

[1]: https://lore.kernel.org/linux-mm/20230519220142.212051-1-sidhartha.kumar@oracle.com/T/
[2]: https://lore.kernel.org/lkml/20230609194947.37196-1-sidhartha.kumar@oracle.com/
[3]: https://lore.kernel.org/lkml/ZLtVlJA+V2+2yjxc@casper.infradead.org/T/
[4]: https://lore.kernel.org/lkml/20230811233939.GA105247@monkey/T/
[5]: https://lore.kernel.org/linux-mm/202308151231.L2pfzOmu-lkp@intel.com/T/#t
[6]: https://lore.kernel.org/linux-mm/20230815191932.273054-1-sidhartha.kumar@oracle.com/T/
[7]: https://lore.kernel.org/linux-mm/ZOTtK1Kfa5gCS3Gb@casper.infradead.org/T/
[8]: https://lore.kernel.org/linux-mm/20230907001832.GA63356@monkey/T/#m35ed80fc2bb21d613bc4cc8771159d6ae0b5a264


 fs/hugetlbfs/inode.c    | 15 ++++++++-------
 include/linux/hugetlb.h | 12 ++++++++++++
 include/linux/pagemap.h | 32 ++------------------------------
 mm/filemap.c            | 34 ++++++++++------------------------
 mm/hugetlb.c            | 32 ++++++--------------------------
 mm/migrate.c            |  6 +++---
 6 files changed, 41 insertions(+), 90 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 316c4cebd3f3..7083fa0caaab 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -661,21 +661,20 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
 {
 	struct hstate *h = hstate_inode(inode);
 	struct address_space *mapping = &inode->i_data;
-	const pgoff_t start = lstart >> huge_page_shift(h);
-	const pgoff_t end = lend >> huge_page_shift(h);
+	const pgoff_t end = lend >> PAGE_SHIFT;
 	struct folio_batch fbatch;
 	pgoff_t next, index;
 	int i, freed = 0;
 	bool truncate_op = (lend == LLONG_MAX);
 
 	folio_batch_init(&fbatch);
-	next = start;
+	next = lstart >> PAGE_SHIFT;
 	while (filemap_get_folios(mapping, &next, end - 1, &fbatch)) {
 		for (i = 0; i < folio_batch_count(&fbatch); ++i) {
 			struct folio *folio = fbatch.folios[i];
 			u32 hash = 0;
 
-			index = folio->index;
+			index = folio->index >> huge_page_order(h);
 			hash = hugetlb_fault_mutex_hash(mapping, index);
 			mutex_lock(&hugetlb_fault_mutex_table[hash]);
 
@@ -693,7 +692,9 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
 	}
 
 	if (truncate_op)
-		(void)hugetlb_unreserve_pages(inode, start, LONG_MAX, freed);
+		(void)hugetlb_unreserve_pages(inode,
+				lstart >> huge_page_shift(h),
+				LONG_MAX, freed);
 }
 
 static void hugetlbfs_evict_inode(struct inode *inode)
@@ -741,7 +742,7 @@ static void hugetlbfs_zero_partial_page(struct hstate *h,
 	pgoff_t idx = start >> huge_page_shift(h);
 	struct folio *folio;
 
-	folio = filemap_lock_folio(mapping, idx);
+	folio = filemap_lock_hugetlb_folio(h, mapping, idx);
 	if (IS_ERR(folio))
 		return;
 
@@ -886,7 +887,7 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
 		mutex_lock(&hugetlb_fault_mutex_table[hash]);
 
 		/* See if already present in mapping to avoid alloc/free */
-		folio = filemap_get_folio(mapping, index);
+		folio = filemap_get_folio(mapping, index << huge_page_order(h));
 		if (!IS_ERR(folio)) {
 			folio_put(folio);
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 5b2626063f4f..976d970bfe0d 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -812,6 +812,12 @@ static inline unsigned int blocks_per_huge_page(struct hstate *h)
 	return huge_page_size(h) / 512;
 }
 
+static inline struct folio *filemap_lock_hugetlb_folio(struct hstate *h,
+				struct address_space *mapping, pgoff_t idx)
+{
+	return filemap_lock_folio(mapping, idx << huge_page_order(h));
+}
+
 #include <asm/hugetlb.h>
 
 #ifndef is_hugepage_only_range
@@ -1006,6 +1012,12 @@ static inline struct hugepage_subpool *hugetlb_folio_subpool(struct folio *folio
 	return NULL;
 }
 
+static inline struct folio *filemap_lock_hugetlb_folio(struct hstate *h,
+				struct address_space *mapping, pgoff_t idx)
+{
+	return NULL;
+}
+
 static inline int isolate_or_dissolve_huge_page(struct page *page,
 						struct list_head *list)
 {
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 351c3b7f93a1..759b29d9a69a 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -789,9 +789,6 @@ static inline pgoff_t folio_next_index(struct folio *folio)
  */
 static inline struct page *folio_file_page(struct folio *folio, pgoff_t index)
 {
-	/* HugeTLBfs indexes the page cache in units of hpage_size */
-	if (folio_test_hugetlb(folio))
-		return &folio->page;
 	return folio_page(folio, index & (folio_nr_pages(folio) - 1));
 }
 
@@ -807,9 +804,6 @@ static inline struct page *folio_file_page(struct folio *folio, pgoff_t index)
  */
 static inline bool folio_contains(struct folio *folio, pgoff_t index)
 {
-	/* HugeTLBfs indexes the page cache in units of hpage_size */
-	if (folio_test_hugetlb(folio))
-		return folio->index == index;
 	return index - folio_index(folio) < folio_nr_pages(folio);
 }
 
@@ -867,10 +861,9 @@ static inline struct folio *read_mapping_folio(struct address_space *mapping,
 }
 
 /*
- * Get index of the page within radix-tree (but not for hugetlb pages).
- * (TODO: remove once hugetlb pages will have ->index in PAGE_SIZE)
+ * Get the offset in PAGE_SIZE (even for hugetlb pages).
  */
-static inline pgoff_t page_to_index(struct page *page)
+static inline pgoff_t page_to_pgoff(struct page *page)
 {
 	struct page *head;
 
@@ -885,19 +878,6 @@ static inline pgoff_t page_to_index(struct page *page)
 	return head->index + page - head;
 }
 
-extern pgoff_t hugetlb_basepage_index(struct page *page);
-
-/*
- * Get the offset in PAGE_SIZE (even for hugetlb pages).
- * (TODO: hugetlb pages should have ->index in PAGE_SIZE)
- */
-static inline pgoff_t page_to_pgoff(struct page *page)
-{
-	if (unlikely(PageHuge(page)))
-		return hugetlb_basepage_index(page);
-	return page_to_index(page);
-}
-
 /*
  * Return byte-offset into filesystem object for page.
  */
@@ -934,24 +914,16 @@ static inline loff_t folio_file_pos(struct folio *folio)
 
 /*
  * Get the offset in PAGE_SIZE (even for hugetlb folios).
- * (TODO: hugetlb folios should have ->index in PAGE_SIZE)
  */
 static inline pgoff_t folio_pgoff(struct folio *folio)
 {
-	if (unlikely(folio_test_hugetlb(folio)))
-		return hugetlb_basepage_index(&folio->page);
 	return folio->index;
 }
 
-extern pgoff_t linear_hugepage_index(struct vm_area_struct *vma,
-				     unsigned long address);
-
 static inline pgoff_t linear_page_index(struct vm_area_struct *vma,
 					unsigned long address)
 {
 	pgoff_t pgoff;
-	if (unlikely(is_vm_hugetlb_page(vma)))
-		return linear_hugepage_index(vma, address);
 	pgoff = (address - vma->vm_start) >> PAGE_SHIFT;
 	pgoff += vma->vm_pgoff;
 	return pgoff;
diff --git a/mm/filemap.c b/mm/filemap.c
index 582f5317ff71..8962d1255905 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -131,11 +131,8 @@ static void page_cache_delete(struct address_space *mapping,
 
 	mapping_set_update(&xas, mapping);
 
-	/* hugetlb pages are represented by a single entry in the xarray */
-	if (!folio_test_hugetlb(folio)) {
-		xas_set_order(&xas, folio->index, folio_order(folio));
-		nr = folio_nr_pages(folio);
-	}
+	xas_set_order(&xas, folio->index, folio_order(folio));
+	nr = folio_nr_pages(folio);
 
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
 
@@ -234,7 +231,7 @@ void filemap_free_folio(struct address_space *mapping, struct folio *folio)
 	if (free_folio)
 		free_folio(folio);
 
-	if (folio_test_large(folio) && !folio_test_hugetlb(folio))
+	if (folio_test_large(folio))
 		refs = folio_nr_pages(folio);
 	folio_put_refs(folio, refs);
 }
@@ -855,14 +852,15 @@ noinline int __filemap_add_folio(struct address_space *mapping,
 
 	if (!huge) {
 		int error = mem_cgroup_charge(folio, NULL, gfp);
-		VM_BUG_ON_FOLIO(index & (folio_nr_pages(folio) - 1), folio);
 		if (error)
 			return error;
 		charged = true;
-		xas_set_order(&xas, index, folio_order(folio));
-		nr = folio_nr_pages(folio);
 	}
 
+	VM_BUG_ON_FOLIO(index & (folio_nr_pages(folio) - 1), folio);
+	xas_set_order(&xas, index, folio_order(folio));
+	nr = folio_nr_pages(folio);
+
 	gfp &= GFP_RECLAIM_MASK;
 	folio_ref_add(folio, nr);
 	folio->mapping = mapping;
@@ -2040,7 +2038,7 @@ unsigned find_get_entries(struct address_space *mapping, pgoff_t *start,
 		int idx = folio_batch_count(fbatch) - 1;
 
 		folio = fbatch->folios[idx];
-		if (!xa_is_value(folio) && !folio_test_hugetlb(folio))
+		if (!xa_is_value(folio))
 			nr = folio_nr_pages(folio);
 		*start = indices[idx] + nr;
 	}
@@ -2104,7 +2102,7 @@ unsigned find_lock_entries(struct address_space *mapping, pgoff_t *start,
 		int idx = folio_batch_count(fbatch) - 1;
 
 		folio = fbatch->folios[idx];
-		if (!xa_is_value(folio) && !folio_test_hugetlb(folio))
+		if (!xa_is_value(folio))
 			nr = folio_nr_pages(folio);
 		*start = indices[idx] + nr;
 	}
@@ -2145,9 +2143,6 @@ unsigned filemap_get_folios(struct address_space *mapping, pgoff_t *start,
 			continue;
 		if (!folio_batch_add(fbatch, folio)) {
 			unsigned long nr = folio_nr_pages(folio);
-
-			if (folio_test_hugetlb(folio))
-				nr = 1;
 			*start = folio->index + nr;
 			goto out;
 		}
@@ -2213,9 +2208,6 @@ unsigned filemap_get_folios_contig(struct address_space *mapping,
 
 		if (!folio_batch_add(fbatch, folio)) {
 			nr = folio_nr_pages(folio);
-
-			if (folio_test_hugetlb(folio))
-				nr = 1;
 			*start = folio->index + nr;
 			goto out;
 		}
@@ -2232,10 +2224,7 @@ unsigned filemap_get_folios_contig(struct address_space *mapping,
 
 	if (nr) {
 		folio = fbatch->folios[nr - 1];
-		if (folio_test_hugetlb(folio))
-			*start = folio->index + 1;
-		else
-			*start = folio_next_index(folio);
+		*start = folio->index + folio_nr_pages(folio);
 	}
 out:
 	rcu_read_unlock();
@@ -2273,9 +2262,6 @@ unsigned filemap_get_folios_tag(struct address_space *mapping, pgoff_t *start,
 			continue;
 		if (!folio_batch_add(fbatch, folio)) {
 			unsigned long nr = folio_nr_pages(folio);
-
-			if (folio_test_hugetlb(folio))
-				nr = 1;
 			*start = folio->index + nr;
 			goto out;
 		}
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 2e7188876672..af74e83d92aa 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -952,7 +952,7 @@ static long region_count(struct resv_map *resv, long f, long t)
 
 /*
  * Convert the address within this vma to the page offset within
- * the mapping, in pagecache page units; huge pages here.
+ * the mapping, huge page units here.
  */
 static pgoff_t vma_hugecache_offset(struct hstate *h,
 			struct vm_area_struct *vma, unsigned long address)
@@ -961,13 +961,6 @@ static pgoff_t vma_hugecache_offset(struct hstate *h,
 			(vma->vm_pgoff >> huge_page_order(h));
 }
 
-pgoff_t linear_hugepage_index(struct vm_area_struct *vma,
-				     unsigned long address)
-{
-	return vma_hugecache_offset(hstate_vma(vma), vma, address);
-}
-EXPORT_SYMBOL_GPL(linear_hugepage_index);
-
 /**
  * vma_kernel_pagesize - Page size granularity for this VMA.
  * @vma: The user mapping.
@@ -2076,20 +2069,6 @@ struct address_space *hugetlb_page_mapping_lock_write(struct page *hpage)
 	return NULL;
 }
 
-pgoff_t hugetlb_basepage_index(struct page *page)
-{
-	struct page *page_head = compound_head(page);
-	pgoff_t index = page_index(page_head);
-	unsigned long compound_idx;
-
-	if (compound_order(page_head) > MAX_ORDER)
-		compound_idx = page_to_pfn(page) - page_to_pfn(page_head);
-	else
-		compound_idx = page - page_head;
-
-	return (index << compound_order(page_head)) + compound_idx;
-}
-
 static struct folio *alloc_buddy_hugetlb_folio(struct hstate *h,
 		gfp_t gfp_mask, int nid, nodemask_t *nmask,
 		nodemask_t *node_alloc_noretry)
@@ -5722,7 +5701,7 @@ static bool hugetlbfs_pagecache_present(struct hstate *h,
 			struct vm_area_struct *vma, unsigned long address)
 {
 	struct address_space *mapping = vma->vm_file->f_mapping;
-	pgoff_t idx = vma_hugecache_offset(h, vma, address);
+	pgoff_t idx = linear_page_index(vma, address);
 	struct folio *folio;
 
 	folio = filemap_get_folio(mapping, idx);
@@ -5739,6 +5718,7 @@ int hugetlb_add_to_page_cache(struct folio *folio, struct address_space *mapping
 	struct hstate *h = hstate_inode(inode);
 	int err;
 
+	idx <<= huge_page_order(h);
 	__folio_set_locked(folio);
 	err = __filemap_add_folio(mapping, folio, idx, GFP_KERNEL, NULL);
 
@@ -5846,7 +5826,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	 * before we get page_table_lock.
 	 */
 	new_folio = false;
-	folio = filemap_lock_folio(mapping, idx);
+	folio = filemap_lock_hugetlb_folio(h, mapping, idx);
 	if (IS_ERR(folio)) {
 		size = i_size_read(mapping->host) >> huge_page_shift(h);
 		if (idx >= size)
@@ -6155,7 +6135,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 		/* Just decrements count, does not deallocate */
 		vma_end_reservation(h, vma, haddr);
 
-		pagecache_folio = filemap_lock_folio(mapping, idx);
+		pagecache_folio = filemap_lock_hugetlb_folio(h, mapping, idx);
 		if (IS_ERR(pagecache_folio))
 			pagecache_folio = NULL;
 	}
@@ -6287,7 +6267,7 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 
 	if (is_continue) {
 		ret = -EFAULT;
-		folio = filemap_lock_folio(mapping, idx);
+		folio = filemap_lock_hugetlb_folio(h, mapping, idx);
 		if (IS_ERR(folio))
 			goto out;
 		folio_in_pagecache = true;
diff --git a/mm/migrate.c b/mm/migrate.c
index b7fa020003f3..123fc4dc0bc4 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -521,7 +521,7 @@ int migrate_huge_page_move_mapping(struct address_space *mapping,
 	int expected_count;
 
 	xas_lock_irq(&xas);
-	expected_count = 2 + folio_has_private(src);
+	expected_count = folio_expected_refs(mapping, src);
 	if (!folio_ref_freeze(src, expected_count)) {
 		xas_unlock_irq(&xas);
 		return -EAGAIN;
@@ -530,11 +530,11 @@ int migrate_huge_page_move_mapping(struct address_space *mapping,
 	dst->index = src->index;
 	dst->mapping = src->mapping;
 
-	folio_get(dst);
+	folio_ref_add(dst, folio_nr_pages(dst));
 
 	xas_store(&xas, dst);
 
-	folio_ref_unfreeze(src, expected_count - 1);
+	folio_ref_unfreeze(src, expected_count - folio_nr_pages(src));
 
 	xas_unlock_irq(&xas);
 
-- 
2.41.0

