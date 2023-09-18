Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CACDF7A5604
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 01:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjIRXDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 19:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjIRXDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 19:03:16 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0748F
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 16:03:11 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38IK3olX005656;
        Mon, 18 Sep 2023 23:02:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=o88C+/1Bq84z9T8MC/ceJWbxnd4tBQq1TxgeUuB9kNU=;
 b=oVsF/U9VZwtP3lYbcqVRXFsQz9sbzqkjy9z2+/JhsGBnYcfh85rXSHCKA5b31bGuK4Yk
 984//fQ3DCAXVgAxnu2T500GOwKmmsHDqWFZl/f448gQa8OwjC3vnRv/Etw0JUXmFpbY
 cZDLrMwF17Pmz2BCwpuPYjqES51v7hijv54+YxzQtT2viZlq8NuADQzyMyr1rK0W/Qya
 MrRiQmHSGPI3jQMWaO4LfSjYdqDToKhPghTqOGBjMBYnyhSAy9+zJr3Oj0x49sH7wlf/
 B3LsX0e99AiBE0z45rBYEx35RZ3KqxyTqGkprIYugIJeusLINqJt+GGwotXpx8bmPDAk gQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t54dd3mu8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Sep 2023 23:02:32 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38ILxwTM027003;
        Mon, 18 Sep 2023 23:02:31 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t52t55y5g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Sep 2023 23:02:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FR3O223Wy0xQadkDrR2S0eRwZvkqwGD35YQnQJk6dMocWiGZOub3yloN3aGRiPrgtOcjbMYMox3l1SKv5EgB+zbIMXh24VzqnDXZwqkfB6xBk1LNmEgJw7WR+qfHfjgjUVGI+OnDdfyLbye5eHa5DSexvFmw5zaBI/DjNrue9ETO+6eo0ldmup0qNrCvNl5E8cZFnq3X68RPmrnhYOWg48gLh4nVJC4YTJSpePytFzzTTl8gMFuFSscQ8VbSdzAYXRUPimMdgBVgvXizRKltxQGGCyXEimH1SGgkCQoQDRV/nxQIO7K127t0GXFN1TM+wbBUsso28Hx+jfKn5+CDVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o88C+/1Bq84z9T8MC/ceJWbxnd4tBQq1TxgeUuB9kNU=;
 b=L0/o6iMuhgyeaZZhenEdDLUvb8m0+nh9kSsQLAMnPHgOO++1vPdR36N96//B2WDQsVhyydPmgE1fC+WLUwpduP+oEhpRpp99yie2BniK7+ZaMFRam6VF0qZCkb+PHB98EWnDpP+G9absf0qJGHqGVMpuNrJv6QPiWy8tE2MADQ2CgXdDmRj6TxnUo7tU38JfIuo9z0qC6cES9ItaGkqCDOFgWpob/vKdys5ypJBoKfe1LyNhZIBc9NHLuCVNiVjOMPujNVea+cbIughnZpUDXEmPLHf9A63QVdlQ0B0oAIFDAEJ9qKFh1mHKIyxC3ZenWTAmkcDafT4rgBHgkt+1Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o88C+/1Bq84z9T8MC/ceJWbxnd4tBQq1TxgeUuB9kNU=;
 b=kuWXSbhyPvoer7Iv6GndCuyfQch6RUQ9d+s6RY9gsqJdns9/kDsWaQV7tgCyIpl93dS9nuRbDFEXl+TVD0Wwc79B+owqI/Kn1hhRRcDoCFFVqbjR1cprK/XebKhGLCOATx+PCWu1T7CsN2y1NmFL6Bd1FUeBDF+OwLKYeDFndz4=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CH3PR10MB7494.namprd10.prod.outlook.com (2603:10b6:610:163::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 18 Sep
 2023 23:02:27 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054%5]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 23:02:27 +0000
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
Subject: [PATCH v4 7/8] hugetlb: batch TLB flushes when freeing vmemmap
Date:   Mon, 18 Sep 2023 16:01:59 -0700
Message-ID: <20230918230202.254631-8-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230918230202.254631-1-mike.kravetz@oracle.com>
References: <20230918230202.254631-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0114.namprd03.prod.outlook.com
 (2603:10b6:303:b7::29) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CH3PR10MB7494:EE_
X-MS-Office365-Filtering-Correlation-Id: ad7cb897-318a-42b1-2ef6-08dbb89b53d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dw8EuLiUp0MY0HbtlBI+E6qxsmQAMY4+s10eSYSi55ZM5bJ0NNdsiXjyGGcFPPI909PTaiNu06BUxVmP1N9AK4c9euhWRrNgI/CNoMAKoiHgiP6kjbhY4sGpxb61EFSI+yMmN5axcX6ixTgo+nrFsqtcVzvJVYA2YcOOVscDwhAd2mrnho2CwkBTgZAEflLcYHFHLgg//nGsCd55oYdyXNcFMN0Gj3m9CdKacV25oBHFHFsMkTiZm/iLjU/48tUyNX6DB7t2KSgdcXMvm1ck9kmZ26knK878HB4B/8cwtLuyvffyJhUs4A27RaYxqQUHF//afUnz1Bmcjq+5cS0vRUGe4eqEFtaYngCD8LKK4MEENhvvbZhBswgrhUD3OgXe33VTXOE6JHwU/9zR82A8FBWC+hLNIqueyXTvPLOnR0PEygySb7MKRTbQMNYA2c5fd40tlWp9O8Kk/NdIU32tephsTUJ/7NWCQQXdLACNKSFbraIrD8ThWXgHqfq30eLRCwtBG6Jvp4Li5Lv8MLV4pLAC7gyvaJhFWpZrlFnuKWIiwpFKQUZUvfNEpJY0nhaU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(376002)(39860400002)(136003)(451199024)(186009)(1800799009)(41300700001)(316002)(66476007)(66556008)(54906003)(66946007)(478600001)(6666004)(38100700002)(7416002)(2906002)(86362001)(36756003)(44832011)(5660300002)(8676002)(4326008)(8936002)(83380400001)(107886003)(2616005)(26005)(1076003)(6512007)(6506007)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AksU8VoJRZg9lzQp8HLUAlsXIoWwp+aVgZLPK000GU0MUq4RgQOlxDc+u+xD?=
 =?us-ascii?Q?2hMneEuyGwSxL0VI15pDBLoeJJWJ921roKBA/RvdB8ViVLhEsTpQw9IhPzXP?=
 =?us-ascii?Q?48885egdr5UYSecTs71uyjsdJNqS7Yea/iJuWku7cRKGegsl6wFAn282NU6S?=
 =?us-ascii?Q?fFUccniAzwPYX8hMq0d08CLhrfveMjtwgxZaLvqvaLNl0gpya3/rSjwi6lqV?=
 =?us-ascii?Q?eI/VCEnrwaFg5riGdqphXqOgVhSQhzDkjUax9jsG3v3HIU+2lFbMLnWxZQZW?=
 =?us-ascii?Q?yjKAJWOkgbLQ9dziZ2qoKmZlm9Cok0Cy52MHFtmWhmlbb6kwJL8Vfn6/be1h?=
 =?us-ascii?Q?MGlp+L6vr5Uut82Pu7MYIJKk6q1YAVJh+8+L16t9kQw03o/bU9nJlEaXIVzh?=
 =?us-ascii?Q?QqPfOgTSOoJKydhn9SG17OzxFJskyra2Al2SstFKKVMMFmVs06sqCR+JEbDk?=
 =?us-ascii?Q?wGlekiQXGd6nIOEEyuoiO/SXcWpHCNxKh3U7FNIx/pVNtFkAqNzncMmMMuPS?=
 =?us-ascii?Q?K0YqbOmL15SrJkFKYSsKo6eZ7RwW0L047aJcmQuIztGWfwdChAm2YmOfolDS?=
 =?us-ascii?Q?WLVx8eOGhKmiUdAZYG8m3Aog5PHoeGLEF4PGCIvYqow/xajcprSPO9zLXheb?=
 =?us-ascii?Q?s3nwUWWvnpXUptoxSAEkp/VJB5oJGitc0LRWt9XTHVySczzRiSrO4J1nk1lW?=
 =?us-ascii?Q?aj9CQxoLAWtnM+22gGwzUvKKl65ZDvAz41HC2bTMv64yLAELmEzAjPlQ3irG?=
 =?us-ascii?Q?wKWiLwuA44YXUYeJJ9zblyJHgJsGn5jP8kmBpkGdsYmQBBtOioIdSmrsUkhg?=
 =?us-ascii?Q?W/3QuqRlfRF++aW5RefflNyOl/PsToUnNX0sxQrgtGxW9JjAnRrg1Pn+wrRW?=
 =?us-ascii?Q?LGIah5mpIEduiyr9TMX6F75nXdxGmIbIRGqgbqpjLPppgVPKB6DYGkV25En5?=
 =?us-ascii?Q?TcNVF150H3trXpNRWXaLUAkwgJUibch0iPsvnEI7Yr1xP3f/6GuaIppohokn?=
 =?us-ascii?Q?RBPWZsmKR+JB1I38+S7vUO7oy0sw6Jg8ezlzLjl1K3U1T11kJUWjwgydCaBC?=
 =?us-ascii?Q?2QGhqV+Q4izXcAVoE0ZTewAOxO30b6zT3uLNU3zQbTTVPnAtDH2b3rBhR6YS?=
 =?us-ascii?Q?DaZPJZdQXEHq7d5yhPA4xbXqS6xFyVTTpFmt1Mr94UrezsmQ304zR9DeRxUx?=
 =?us-ascii?Q?QC+njM0JyL/9UUVdkIfEG/PNFvLg+H+gi0oqHTLuQGzpmBlEIjNrVtxwguVT?=
 =?us-ascii?Q?7vtop3GnX8YlSYYIhcjjd7KmZ+kJxFYb0lHD2j+3znHG15m5andI79OTxViX?=
 =?us-ascii?Q?Mke1FO0xQmhjY9V0w8G+uSybE/2hoULEX3tXdt6F4XSShd6WK1iSbbViokXT?=
 =?us-ascii?Q?EtFK5iVYO1cO5/9cyR2i5lCN7dFf4Qlfr6hyG57nlT8jbSbstNHyYXk3kRzH?=
 =?us-ascii?Q?Hql/yUV0jgPhbeDqpSBeFG4FJ39z+4ntxXOspnWYeN3dg5vJulf9WkXBc1uJ?=
 =?us-ascii?Q?kC9luhk9CBEPDqAQcQDPzWy4Oz4+9BOC1Gu6A7/b2SWaBRCh4cDZ74zEt8NS?=
 =?us-ascii?Q?+OqkBJVsvfIXIFH3WSPeMQ4ipbo/tLb84l86Z32v?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?YjJqHFpPrtg2YzbqyJ2RvCeyMuqjyXOKlhXvgQcd6zh3tov8xcx9eq4qW73R?=
 =?us-ascii?Q?cJwmnAALwr3coTL38Du77jlU+36ZwfXCD+RlF3C8RhDwviSGfLGG5gkQ9iUT?=
 =?us-ascii?Q?qPzB9MKfULXhO9XoXM6FoaXMtLFvKv63nvjzNSHEcu2Jh7ZU+YmriLGB8dh8?=
 =?us-ascii?Q?BX9f9wVguhaLSYAtLeNjaflRdx6UaAUoecJX4YpCkLVJKeyX429YHmtEmHKx?=
 =?us-ascii?Q?vyAcJXjiicHH8tTn6yLspHsEiPeFeo7zUW2qnQzML4SX1mWu0ijsCiE+lTOv?=
 =?us-ascii?Q?x0HsxzhzIZf+c3wgYBdkPfxNvccj4WM0XTlMrYWguImUCgofkLxBYQJ6jl0Q?=
 =?us-ascii?Q?HW+ysO92iKxweB6Ju89iAD/EQAs/xMO8gH04kFQRPA8u8zfGsqvhlynwQME2?=
 =?us-ascii?Q?sMLYjLNFOwfzHXPm6LsLVGnzDWcnjQ0oIxrMOrRRwUp9gzQmcw2O30sC6Oqx?=
 =?us-ascii?Q?2KNlXvJ6s2cbv4KB+asif26GiL7M9OkcxmD6LZwtn5CH/OqTeHB3aBQ/aZFu?=
 =?us-ascii?Q?rNOze061OFKhGO15J9Dz22HsNJ2mgJBkZK+7Wca/4Oj/oBNIXDCyQnsZKiSt?=
 =?us-ascii?Q?NE7I70lxfPq78ZMxwkLj3NIR0KU8CmVF3RWMqrUVclkG033vm+JuCk906jHk?=
 =?us-ascii?Q?QENmkZi5eeWfagiDtmNmb119toPGPqKsf0/LFTSt2eFxjQREmsUBE3wLgmIs?=
 =?us-ascii?Q?H47l0GURWA9HUPnNHDJV40sEsN4AgSUREYjEaYQiqGr6rIOY/7FZ2hZu3CE3?=
 =?us-ascii?Q?Qo0gwOL2YBMeYbcp/qb+cKAaVDxWOjj+u94eeFgRYPp7j9/hAn+ullnMFmJ6?=
 =?us-ascii?Q?v6zFSiKQodA2Y1l5mZU5NEURgmC9+DNWl0Jr/RilcUCpDzGwJbA27HRIktT8?=
 =?us-ascii?Q?2xLC1QL3VJB6ZBD+ogybGvEYolKJTBa1K3G/e9My5MGLK+AY28BJGc3Uc3ep?=
 =?us-ascii?Q?1gEB2D4hb/tPoIGLJOqoRAvti0Q0fzJ509Ay7cg5g2ty5TlSnK283yisK06E?=
 =?us-ascii?Q?rdwRiCnw8hIPjqJwGZeyUQstVNTb1VixZyjXCpkp5kzhGrsWgJM70FTRVrfF?=
 =?us-ascii?Q?esoBfaDXtFJi6mOK/HZPawG0JuU31vAEIQhb8AbDBkYlCbNjMlwhf2XZ2CuK?=
 =?us-ascii?Q?ngV+h4DASqhe?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad7cb897-318a-42b1-2ef6-08dbb89b53d3
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 23:02:27.0168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fiqL7LWeeH9/lWKXM1bWewOjrLC5sWM77ZNGNwk6CJEy4kT9Kw1LS1PYw9VFkzX7OHSnE+BJ11t7yErU9k1PMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7494
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-18_11,2023-09-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309180199
X-Proofpoint-GUID: Gv-dJngzIin-_69pFzeyd21BP5yeilt9
X-Proofpoint-ORIG-GUID: Gv-dJngzIin-_69pFzeyd21BP5yeilt9
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
---
 mm/hugetlb_vmemmap.c | 44 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 33 insertions(+), 11 deletions(-)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index e8bc2f7567db..a6c356acb1fc 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -37,6 +37,7 @@ struct vmemmap_remap_walk {
 	unsigned long		reuse_addr;
 	struct list_head	*vmemmap_pages;
 #define VMEMMAP_SPLIT_NO_TLB_FLUSH	BIT(0)
+#define VMEMMAP_REMAP_NO_TLB_FLUSH	BIT(1)
 	unsigned long		flags;
 };
 
@@ -211,7 +212,7 @@ static int vmemmap_remap_range(unsigned long start, unsigned long end,
 			return ret;
 	} while (pgd++, addr = next, addr != end);
 
-	if (walk->remap_pte)
+	if (walk->remap_pte && !(walk->flags & VMEMMAP_REMAP_NO_TLB_FLUSH))
 		flush_tlb_kernel_range(start, end);
 
 	return 0;
@@ -355,19 +356,21 @@ static int vmemmap_remap_split(unsigned long start, unsigned long end,
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
@@ -628,7 +631,8 @@ static bool vmemmap_should_optimize(const struct hstate *h, const struct page *h
 
 static int __hugetlb_vmemmap_optimize(const struct hstate *h,
 					struct page *head,
-					struct list_head *vmemmap_pages)
+					struct list_head *vmemmap_pages,
+					unsigned long flags)
 {
 	int ret = 0;
 	unsigned long vmemmap_start = (unsigned long)head, vmemmap_end;
@@ -639,6 +643,18 @@ static int __hugetlb_vmemmap_optimize(const struct hstate *h,
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
@@ -650,11 +666,12 @@ static int __hugetlb_vmemmap_optimize(const struct hstate *h,
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
@@ -673,7 +690,7 @@ void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head)
 {
 	LIST_HEAD(vmemmap_pages);
 
-	__hugetlb_vmemmap_optimize(h, head, &vmemmap_pages);
+	__hugetlb_vmemmap_optimize(h, head, &vmemmap_pages, 0);
 	free_vmemmap_page_list(&vmemmap_pages);
 }
 
@@ -708,19 +725,24 @@ void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_l
 
 	list_for_each_entry(folio, folio_list, lru) {
 		int ret = __hugetlb_vmemmap_optimize(h, &folio->page,
-								&vmemmap_pages);
+						&vmemmap_pages,
+						VMEMMAP_REMAP_NO_TLB_FLUSH);
 
 		/*
 		 * Pages to be freed may have been accumulated.  If we
 		 * encounter an ENOMEM,  free what we have and try again.
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

