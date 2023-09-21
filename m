Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 452A77A9063
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 03:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjIUBNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 21:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjIUBNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 21:13:16 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285B8DD
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 18:13:09 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38KKJ0SG003965;
        Thu, 21 Sep 2023 01:12:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=Rdq/+vKEusFvsO7xI8TBk9CkMegvysRC+TNTG17bPIs=;
 b=Ko2Rjvs0V3DSyZsymwUp6DDMpvXXYroidYQggprpCA1h6IlW9HmB2htpBMd7DvTWLmyQ
 L0rYiOmHPTvfh5tz7p32ydnjmxT9Re4lHICKeLl9QhnweF354t6VjNyG2BPt4Ou+uC3s
 7ajfLXj8qOY6t+fxFifKyk+TZN2S/DaQAKAJBb71oFVG5d82f68chMBIjYMWwgUFjeB8
 UJdpJpf0o3dmwKUb+CWBwcOV+C0Vob1F6gLoPYnwExxQqarlGLtBAM/mINSn9xFsw9cG
 LEGgE7f5g/rp+Utuy+Tgnyt2t2X//kHnLUky8DvnjMEL4Gi+hkeT/8ADfw3quA49xz3S AQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t53530pnv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Sep 2023 01:12:30 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38KMcv01012032;
        Thu, 21 Sep 2023 01:12:29 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t52t847kr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Sep 2023 01:12:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GOUsHaINs3RIDUqoryf9hD3xjWBob8K6hqDuG4DHd8vga0mubgac4bUK9E27+qCkifo/cBTyElnzxmWkSmRNvjabMRm22lxZJGSOnu93Zuj2H8MV24sLqVwadFQ//KRRv+NaAmU4IKc2t8pAAJN6+nkb8Vpm2IXLCFFkgau7tuZVgdC4XofS/SkldOBFGmjU6C0/aMotbQF/95pSwlRGlPRfxlL5SktQYt2W44+Bl30L/3uj/k6l1Rqk0Rt2QrRb+rd7G66c6jVZLJboTQvg7RCTA+jZ2gVE1TJ4wdBqRbe0wiwUYCvViqb6eW+TMPa2feC1x6GLbJyK6K9nUJTmlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rdq/+vKEusFvsO7xI8TBk9CkMegvysRC+TNTG17bPIs=;
 b=hvYprcHS74BoJ0U01FUgHBImzCFNbikX6CTlMUUT9oT5TGghfZL/IFSgCol5C5MImgkXcdwA0xOh0Fcekb0eOko8DDxrizRCyL1KO71Uz0cLv7XSO374behNAEtuyubBxJTUEnNNDdXid/fDJXrEMMDElNuZDu3PdRkTsFjpG2Gok34ZwjSEq27gn5kR0rfz+STpqbNekLYpkHfUiFDM5tJwreY4OaiECL6rNzesbfKSr3BosKoJ0I3zhScH15/ICn4iM8im5uSYGsr1JEU+o67FE9kAQ2cSa9o/VbOb/uIaRs9K0dTrbAW5ZJSmJWBlbil2EVA441je63X2iqD7nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rdq/+vKEusFvsO7xI8TBk9CkMegvysRC+TNTG17bPIs=;
 b=S7oLrxUyfgj/wW4e7QFdouooU3Qp8LF/OATpkU1huaLmhrvLHRbk8WYFsHCqA9CeCkbzsgEoTlkiuYReEQyhksYJSRIgvkuqWVqFSG921zulSZPcm66F8W331NZGaZ9SNrPhkYbpeZF8wTTVqJiF+PhQ1xhzO6fFQFN/AW2j4hM=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SA2PR10MB4601.namprd10.prod.outlook.com (2603:10b6:806:f9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Thu, 21 Sep
 2023 01:12:27 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054%5]) with mapi id 15.20.6792.026; Thu, 21 Sep 2023
 01:12:27 +0000
Date:   Wed, 20 Sep 2023 18:12:23 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Muchun Song <muchun.song@linux.dev>
Cc:     Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
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
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v4 4/8] hugetlb: perform vmemmap restoration on a list of
 pages
Message-ID: <20230921011223.GC4065@monkey>
References: <20230918230202.254631-1-mike.kravetz@oracle.com>
 <20230918230202.254631-5-mike.kravetz@oracle.com>
 <b9d03e01-7582-8ec9-d219-941184166835@linux.dev>
 <20230919205756.GB425719@monkey>
 <CED64A95-00E8-4B52-A77A-8B13D2795507@linux.dev>
 <2FDB2018-74AE-4514-9B43-01664A8E5DBF@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2FDB2018-74AE-4514-9B43-01664A8E5DBF@linux.dev>
X-ClientProxiedBy: MW4PR03CA0225.namprd03.prod.outlook.com
 (2603:10b6:303:b9::20) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SA2PR10MB4601:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e744162-a3a6-4c25-cf64-08dbba3fd205
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3xHmjxuGwTsrvlmDiqpR0Btb4A9tMD1t2i2BZRFbOx08SjAshg1MCBnsZNd1cvLsqM53O6A12QTDNAbNSvZFngjTdmUE0atpLXh5E7SXbnFgDjSjdY1ud66yDs7dlgFjNcTG+k1oph0wk6OKyZD+iy+SgPlTYjUAMQvGgKhsNtGJoohZJqcW0kilhbJpHSlBwhwZIqah2yVmD7Hi3xEw50bx3YlRz8mizeQg3nsyTrOJaT/lYjwTPrDg9hG4kwFktaTogYMraonGWAjcajyU/vjNImK2/vyf2I1fS3iIdZMPZTtDIa6XVEZMBl8xsiXJyFq+zVkwIGE9xMuLPfM6uAbzC2JKHjZ/r/rnyFlRwCzP1LKvesV/t7aT7LIHp2FuNlz8WxWmBzKTL/yoRBMIC8Ctj+S9eaS6aSFQFYNyc5bNrmwcEn0Gbf59lEbnfiksvALL5fYvHrNl/O9ICH0e8EaLwPnhzE06jralvKs7SF2KLiDcBR/t3RNjEWjcWPt+Inr4tWz/09DKpP00eMgIgLyBCdfXDomCvdd+HZcjzXLywpwLovi6D2NsriQPHQcq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(136003)(366004)(346002)(376002)(39860400002)(186009)(1800799009)(451199024)(6512007)(53546011)(9686003)(6486002)(6506007)(6666004)(83380400001)(86362001)(33656002)(33716001)(38100700002)(1076003)(316002)(26005)(66476007)(54906003)(6916009)(66946007)(66556008)(41300700001)(2906002)(44832011)(7416002)(5660300002)(8936002)(4326008)(8676002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fjFrxUXbHk52Y+UGgR2IQv1caA9a3WPVDDbEdNzdYa2twOV5z+cR/EEMhJ3v?=
 =?us-ascii?Q?DHVZJpQBidz+vS+sT8tUY0tjb2J99so7PepONoL1Y5KFu+twGh6uTRQsPBro?=
 =?us-ascii?Q?zmdkxbFGEWYIW9QlYOpBD7vjr5LaV1M2mn/nXxaFPcTl9sFmo4BHftI7Ln4u?=
 =?us-ascii?Q?tVddff5infrVFdlARs2Yxtdbu1B0d/wQPyJJc9H1ovkJ0PaFJKx0+FDgbK2W?=
 =?us-ascii?Q?Dc21wMCh1oefaN2swbEeX+EIh+43jUyyy2ORt7O7ZIU2BO68UVLcp9MYvgsi?=
 =?us-ascii?Q?Ggb0MZaC4fhTI4JxaCUCrBAmi6mY9GguxRo4EXjdYvvme6T91K4HVEtHdeIX?=
 =?us-ascii?Q?7Bd3VYvW90xggAdm9Qb+SphBfCa1e207OOHdIuJXV0gdglJ8oE85vWHMUC6y?=
 =?us-ascii?Q?BdvZCcmN1st4pouedvelCEEtgpCjiSe1zIixsksYlxEHFhHgZNcBTDiA3qlx?=
 =?us-ascii?Q?psS+hcoOqzeVW5IlqmhCmTWfG2bDHhIIMzc3yU1bGR4w63WKV26z+xjc+hOZ?=
 =?us-ascii?Q?5WMnLPn87hSox37BfzX4cAG9gkSDSvGHV3i9Gnh2pLUKGNhLmXV4G6UUWp7A?=
 =?us-ascii?Q?DQMsG9bSSiuf0WefNiDNkqaQeAxe+2XWUjFWmFCCfOS03FezoKOkrbwFertA?=
 =?us-ascii?Q?EczyM4GCGN8vpb7wuFyvPMERXC4OHO63Yw0CeoVNvAtwhFQCYDvI7gzgfU0o?=
 =?us-ascii?Q?7uafSX9jUUYk0dWhoWloLW4mIl4AotMH0YB891isBKuDwzOGCQYJNGDkyGbt?=
 =?us-ascii?Q?f0Vz2B4R3QGbRD2JOY/r0gMx68Bnjkp5rP55N7m5CeyWpHxP1s3GImoCM51Q?=
 =?us-ascii?Q?BwBWfVLZVTw6U0YWdxQgI/YeQHTuHjfdpGcJqTd7hhskx6BrWAsGK624EPWk?=
 =?us-ascii?Q?1MnR3d16gQZ9iUpnTbRzLqHQ9tS0Z7aRYhxsWJ29yOhaVyp3LvZjVSkb2K7a?=
 =?us-ascii?Q?/eIOtsWGaPvmJpOcaqnIUlTOwl/KP/pigbMhR8+sbZx6HtYtaq6lF9g28Dy2?=
 =?us-ascii?Q?vbv4hgWAgX52UVUhDJaT5hcXmP3D09Gib+LReVBFGsoxDF8JAu2A+/f8vc++?=
 =?us-ascii?Q?D9ereibmVDsZFkHYtFSE+NM7CGt8DiIRP0Rf69FOR197kGyC8Sxducg7jCle?=
 =?us-ascii?Q?zwVa8OIR8iE3Y2JUUNE12yPtQDnooL3IP2xM3DR61iqFocm1VE9Hrq2M3q6M?=
 =?us-ascii?Q?b82ar8O6aHy3t440OhnhvUoXwHlmrZ4jKmNT+CCFpdY3Z9/ABmiyWg3A6XLj?=
 =?us-ascii?Q?UryoChSglLAohusoZuRXZi4th4EFZ8/SnU424rb7lmJmUPBHLySfxBLIQJi9?=
 =?us-ascii?Q?SHm2O5JPh1WvH+oQ5SB2oodecpusYagz/uUW4ovrFlKcw4wmrQEOOji70nSs?=
 =?us-ascii?Q?VmGCLyHg/PxcR8asmG1xID33ZpFjWb340u/wmdIFopRdlSUfqJyp0ySOobFs?=
 =?us-ascii?Q?V3q37PQEjR3BU+UZJJ/pDC3za/TaAYDR7OwBiu5ye9Gc03qJ+sC8B+72qY4y?=
 =?us-ascii?Q?XwgzQLq8/1SyroiryMfSsdHJmKAkFOWoKrZkDe0/YnZrCxkBXhDBZb4weLoU?=
 =?us-ascii?Q?EMRAJO9w2iT7uMXNBatC4yCRe9K2LOjxyXGVRXkk?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?HZrVpaZU4JDczgvs9tF5K6sw6Dyiwv9fuU+zBVys1aFPyJpUWIfui/o5cMcR?=
 =?us-ascii?Q?unvLJLIDkgK/nvr+Qs59E5370O7srtcLAOYkBjXYc0a5ARNsc0ptAK0yEXim?=
 =?us-ascii?Q?2vTwghwoB6c9MgB4TcIFZquQyGGZSnYELYnukBDjW28EO9BA1dd6xQF+Iyxq?=
 =?us-ascii?Q?ZO9046OjhPuIGQd1K/KAapv0GCLHvj9CStmTuLRa9RoFJvPca4IexyWHOpdD?=
 =?us-ascii?Q?iabmg36GGb6LcaZAsd+uqxzxXCidrQ5/FEe1rITCJHRMnp+nBgbKnAHiPgd7?=
 =?us-ascii?Q?i2we9kJ3y06zR9us+7lFBL0D3F6XWgF1bDnDYoQ6MptF90vnAPo2E15ABcnq?=
 =?us-ascii?Q?mGCs0uGo/0AQCKOUTfMUrOqkmsNSeJtmFULkQkhAVXTz4FQeWXz7I9aad4Rg?=
 =?us-ascii?Q?TXoAmbGtg9FW5Z1HuMJYjuiJWLyIaSHOTYBUE5KyejmfU/7mP/BMwHDaHHlC?=
 =?us-ascii?Q?rmPVgiBqz6RFzLipiqK4twUZhpPfbw54H7gbNq0prkrS7Q+vA50Zydz1uqku?=
 =?us-ascii?Q?Uu3vrpZDhVZu5agLJpqau6nyhZdX30LAnCC4FZMcxVfxOTKfB4in6pcPFvaa?=
 =?us-ascii?Q?WoRO2Rvg5xSCfEmEx2oGf9fl0lkZ23Wu3TmYixhujyC3XkSz1DfQvLK0JE1X?=
 =?us-ascii?Q?eCas3Iwh8b8PQvNLADNFuwXUZ611/1dL3NzktjhpM3L9goyzaycW8KEdcmk4?=
 =?us-ascii?Q?yLDmCUJlFBPt+6c562YP4nazomTVlTHS8ix1r1lyqQAWHMqCHg4hrQZaYqm0?=
 =?us-ascii?Q?pY3/SRe4KVO2znCMypufWDoY6cFSuAeO1mCjliCpmP2HNNBJnANd6PXob9QQ?=
 =?us-ascii?Q?hoSsbdE3RWOEwtL1yZfHfClS9YHlbUyGgeHmSBNEAczJL2B9W4b6HE9Ghpi4?=
 =?us-ascii?Q?j5bdNTTP7NRWigsGsvbttvT96hrIL+4U3abmXWdpHIVgF0jfFaix1aBpJSl8?=
 =?us-ascii?Q?g5Krao2hRKHxLh60C5pdEa1oNgpw5hEXLwVkKFUFnDa6u6snl/khEIYWD4sw?=
 =?us-ascii?Q?Hb7H6GBq0ZWChlVmVLi9v1LIM4F3ZdRyPijAcwvWtkzvD/31Htx8nxnxhpQA?=
 =?us-ascii?Q?J/N29CNFpshHHGLsDyDgf3+hIAj0gz3A6/hOBF5CH8B9RvWu2a5Rz0Oa98ag?=
 =?us-ascii?Q?yt0wRz/DO6JI?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e744162-a3a6-4c25-cf64-08dbba3fd205
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 01:12:27.5543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YKnpyHkcf408DCz/Rd884bBGt+jorH9lON5Aza4fMDu6xymyP83C3T6jvTWXWrZWfeuuDWyuowNnXZ5hLFyu/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4601
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-20_14,2023-09-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 malwarescore=0
 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309210008
X-Proofpoint-ORIG-GUID: AVOOTy0fEe6vSTGZE3kaR9rvuqg4yIS8
X-Proofpoint-GUID: AVOOTy0fEe6vSTGZE3kaR9rvuqg4yIS8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/20/23 11:03, Muchun Song wrote:
> > On Sep 20, 2023, at 10:56, Muchun Song <muchun.song@linux.dev> wrote:
> >> On Sep 20, 2023, at 04:57, Mike Kravetz <mike.kravetz@oracle.com> wrote:
> >> On 09/19/23 17:52, Muchun Song wrote:
> >>> On 2023/9/19 07:01, Mike Kravetz wrote:
> >>> 
> >>> I still think we should free a non-optimized HugeTLB page if we
> >>> encounter an OOM situation instead of continue to restore
> >>> vemmmap pages. Restoring vmemmmap pages will only aggravate
> >>> the OOM situation. The suitable appraoch is to free a non-optimized
> >>> HugeTLB page to satisfy our allocation of vmemmap pages, what's
> >>> your opinion, Mike?
> >> 
> >> I agree.
> >> 
> >> As you mentioned previously, this may complicate this code path a bit.
> >> I will rewrite to make this happen.
> > 
> > Maybe we could introduced two list passed to update_and_free_pages_bulk (this
> > will be easy for the callers of it), one is for non-optimized huge page,
> > another is optimized one. In update_and_free_pages_bulk, we could first
> > free those non-optimized huge page, and then restore vemmmap pages for
> > those optimized ones, in which case, the code could be simple.
> > hugetlb_vmemmap_restore_folios() dose not need to add complexity, which
> > still continue to restore vmemmap pages and will stop once we encounter
> > an OOM situation.

I am not sure if passing in optimized and non-optimized lists to
update_and_free_pages_bulk will help much.  IIUC, it will almost always
be the case where only one list has entries.  Is that mostly accurate?

> BTW, maybe we should try again iff there are some non-optimized huge page
> whose vmemmap pages are restored successfully previously and could be freed
> first, then continue to restore the vmemmap pages of the remaining huge pages.
> I think the retry code could be done in update_and_free_pages_bulk() as well.

I came up with a new routine to handle these ENOMEM returns from
hugetlb_vmemmap_restore_folios.  I 'think' it handles these situations.
Here is an updated version of this patch.  Sorry, diff makes it a bit
hard to read.

From b13bdccb01730f995191944769f87d0725c289ad Mon Sep 17 00:00:00 2001
From: Mike Kravetz <mike.kravetz@oracle.com>
Date: Sun, 10 Sep 2023 16:14:50 -0700
Subject: [PATCH] hugetlb: perform vmemmap restoration on a list of pages

The routine update_and_free_pages_bulk already performs vmemmap
restoration on the list of hugetlb pages in a separate step.  In
preparation for more functionality to be added in this step, create a
new routine hugetlb_vmemmap_restore_folios() that will restore
vmemmap for a list of folios.

This new routine must provide sufficient feedback about errors and
actual restoration performed so that update_and_free_pages_bulk can
perform optimally.

Special care must be taken when encountering a ENOMEM error from
hugetlb_vmemmap_restore_folios.  We want to continue making as much
forward progress as possible.  A new routine bulk_vmemmap_restore_enomem
handles this specific situation.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c         | 83 ++++++++++++++++++++++++++++++++++----------
 mm/hugetlb_vmemmap.c | 39 +++++++++++++++++++++
 mm/hugetlb_vmemmap.h | 11 ++++++
 3 files changed, 115 insertions(+), 18 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 70fedf8682c4..52abe56cf38a 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1834,38 +1834,85 @@ static void update_and_free_hugetlb_folio(struct hstate *h, struct folio *folio,
 		schedule_work(&free_hpage_work);
 }
 
-static void update_and_free_pages_bulk(struct hstate *h, struct list_head *list)
+static void bulk_vmemmap_restore_enomem(struct hstate *h,
+						struct list_head *list,
+						unsigned long restored)
 {
 	struct folio *folio, *t_folio;
-	bool clear_dtor = false;
 
-	/*
-	 * First allocate required vmemmmap (if necessary) for all folios on
-	 * list.  If vmemmap can not be allocated, we can not free folio to
-	 * lower level allocator, so add back as hugetlb surplus page.
-	 * add_hugetlb_folio() removes the page from THIS list.
-	 * Use clear_dtor to note if vmemmap was successfully allocated for
-	 * ANY page on the list.
-	 */
-	list_for_each_entry_safe(folio, t_folio, list, lru) {
-		if (folio_test_hugetlb_vmemmap_optimized(folio)) {
+	if (restored) {
+		/*
+		 * On ENOMEM error, free any restored hugetlb pages so that
+		 * restore of the entire list can be retried.
+		 * The idea is that by freeing hugetlb pages with vmemmap
+		 * (those previously restored) we will free up memory so that
+		 * we can allocate vmemmap for more hugetlb pages.
+		 * We must examine and possibly free EVERY hugetlb page on list
+		 * in order to call hugetlb_vmemmap_restore_folios again.
+		 * This is not optimal, but is an error case that should not
+		 * happen frequently.
+		 */
+		list_for_each_entry_safe(folio, t_folio, list, lru)
+			if (!folio_test_hugetlb_vmemmap_optimized(folio)) {
+				list_del(&folio->lru);
+				spin_lock_irq(&hugetlb_lock);
+				__clear_hugetlb_destructor(h, folio);
+				spin_unlock_irq(&hugetlb_lock);
+				update_and_free_hugetlb_folio(h, folio, false);
+				cond_resched();
+			}
+	} else {
+		/*
+		 * In the case where vmemmap was not restored for ANY folios,
+		 * we loop through them trying to restore individually in the
+		 * hope that someone elsewhere may free enough memory.
+		 * If unable to restore a page, the hugetlb page is made a
+		 * surplus page and removed from the list.
+		 * If are able to restore vmemmap for one hugetlb page, we free
+		 * it and quit processing the list to retry the bulk operation.
+		 */
+		list_for_each_entry_safe(folio, t_folio, list, lru)
 			if (hugetlb_vmemmap_restore(h, &folio->page)) {
 				spin_lock_irq(&hugetlb_lock);
 				add_hugetlb_folio(h, folio, true);
 				spin_unlock_irq(&hugetlb_lock);
-			} else
-				clear_dtor = true;
-		}
+			} else {
+				list_del(&folio->lru);
+				spin_lock_irq(&hugetlb_lock);
+				__clear_hugetlb_destructor(h, folio);
+				spin_unlock_irq(&hugetlb_lock);
+				update_and_free_hugetlb_folio(h, folio, false);
+				break;
+			}
 	}
+}
+
+static void update_and_free_pages_bulk(struct hstate *h, struct list_head *list)
+{
+	int ret;
+	unsigned long restored;
+	struct folio *folio, *t_folio;
 
 	/*
-	 * If vmemmmap allocation was performed on any folio above, take lock
-	 * to clear destructor of all folios on list.  This avoids the need to
+	 * First allocate required vmemmmap (if necessary) for all folios.
+	 * Carefully handle ENOMEM errors and free up any available hugetlb
+	 * pages in order to make forward progress.
+	 */
+retry:
+	ret = hugetlb_vmemmap_restore_folios(h, list, &restored);
+	if (ret == -ENOMEM) {
+		bulk_vmemmap_restore_enomem(h, list, restored);
+		goto retry;
+	}
+
+	/*
+	 * If vmemmmap allocation was performed on ANY folio , take lock to
+	 * clear destructor of all folios on list.  This avoids the need to
 	 * lock/unlock for each individual folio.
 	 * The assumption is vmemmap allocation was performed on all or none
 	 * of the folios on the list.  This is true expect in VERY rare cases.
 	 */
-	if (clear_dtor) {
+	if (restored) {
 		spin_lock_irq(&hugetlb_lock);
 		list_for_each_entry(folio, list, lru)
 			__clear_hugetlb_destructor(h, folio);
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 4558b814ffab..cc91edbfb68b 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -480,6 +480,45 @@ int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head)
 	return ret;
 }
 
+/**
+ * hugetlb_vmemmap_restore_folios - restore vmemmap for every folio on the list.
+ * @h:		struct hstate.
+ * @folio_list:	list of folios.
+ * @restored:	Set to number of folios for which vmemmap was restored
+ *		successfully if caller passes a non-NULL pointer.
+ *
+ * Return: %0 if vmemmap exists for all folios on the list.  If an error is
+ *		encountered restoring vmemmap for ANY folio, an error code
+ *		will be returned to the caller.  It is then the responsibility
+ *		of the caller to check the hugetlb vmemmap optimized flag of
+ *		each folio to determine if vmemmap was actually restored.
+ *		Note that processing is stopped when first error is encountered.
+ */
+int hugetlb_vmemmap_restore_folios(const struct hstate *h,
+					struct list_head *folio_list,
+					unsigned long *restored)
+{
+	unsigned long num_restored;
+	struct folio *folio;
+	int ret = 0;
+
+	num_restored = 0;
+	list_for_each_entry(folio, folio_list, lru) {
+		if (folio_test_hugetlb_vmemmap_optimized(folio)) {
+			ret = hugetlb_vmemmap_restore(h, &folio->page);
+			if (ret)
+				goto out;
+			else
+				num_restored++;
+		}
+	}
+
+out:
+	if (*restored)
+		*restored = num_restored;
+	return ret;
+}
+
 /* Return true iff a HugeTLB whose vmemmap should and can be optimized. */
 static bool vmemmap_should_optimize(const struct hstate *h, const struct page *head)
 {
diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
index c512e388dbb4..bb58453c3cc0 100644
--- a/mm/hugetlb_vmemmap.h
+++ b/mm/hugetlb_vmemmap.h
@@ -19,6 +19,8 @@
 
 #ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
 int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head);
+int hugetlb_vmemmap_restore_folios(const struct hstate *h,
+			struct list_head *folio_list, unsigned long *restored);
 void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head);
 void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_list);
 
@@ -45,6 +47,15 @@ static inline int hugetlb_vmemmap_restore(const struct hstate *h, struct page *h
 	return 0;
 }
 
+static inline int hugetlb_vmemmap_restore_folios(const struct hstate *h,
+					struct list_head *folio_list,
+					unsigned long *restored)
+{
+	if (restored)
+		*restored = 0;
+	return 0;
+}
+
 static inline void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head)
 {
 }
-- 
2.41.0

