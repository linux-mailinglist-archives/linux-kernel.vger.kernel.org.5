Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2777A7972
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 12:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233376AbjITKkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 06:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbjITKk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 06:40:29 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4BC6AC
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 03:40:23 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38K9swRo000751;
        Wed, 20 Sep 2023 10:39:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=/mZZZp5hpX3TmJwuBtdb/7Gvqk5Xwe8uQg50lx+hPiI=;
 b=Yv9yA6DBHYxyve6Cygp4tzjwKoItYbb6RVncALtkX4nfmu33svqirej5ZrO/hVeqogRG
 /TmWuDZQBuBJznD3IfhP42P4AR1oEYX1tkXn/jqaF9UGJI7PpiYyDfKORhKr0zs85fCW
 W3oNeLu2tkNv8JhzmOhO1Jni46itMYAo4zJ0c1OI2kNvcqoF407QZ7Ae9QCq+kFGAlnW
 j0r82dqevd+SgX4MFP/IkSmshgCEMl1z2BgML4mJ8sw/Q1ttarY0ruQIFYap9LnJ3Pfo
 TmW+UagbRw+aB4FwqRIqrKIRPa6Mhm/fueKEUPKqg5ocZYn7cfoZ2b4OkIbNA9IU2mnU oQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t548bex35-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Sep 2023 10:39:25 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38K9Dn5e016039;
        Wed, 20 Sep 2023 10:39:24 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t52t6nk8f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Sep 2023 10:39:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OHp2S6ZsvA2qYItBxcU21pzjheDB5tl1OQ5ZUUeHD2RTFSktIMJ90UT+DypqU5hCYLAhoKp9XmpvJSYMBMIAz8fXyTwO1oHwD+uA3fRDsSRqbrJs+41BJ7PZp0iSH6x01hkAHoh6XoBKub3PXzwYgSNC/KWEeMMV0v0qUoAcl/4IVlVX8JxgAQC0uY1I/bnePyjb1KZv9GUvFdDZCixdQ+C1Ha/Hz9yOSojwLvCDDcXTs2UyqaEJg/14E8XduVJB2Ph6P3UtO143FnmmB5TJ+XOVvcAEBu15ALPqSbNT7HCM29hJNlWZSHgr2qh2lV4T4jCDwMl+AwwdXIKWxK8ARg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/mZZZp5hpX3TmJwuBtdb/7Gvqk5Xwe8uQg50lx+hPiI=;
 b=Q2naNXs//VmQldxWHFsw6LBMuXB+jaEiDqf0Z1UVljR8HkQcu4Zr61qkBOth3MzDcWC8HtVY1FamreqyBs61A5b0FPV0xS9HjkXtg+Dld1ZtLZF2jJR0i9/3Pjl8TxGVdCtO+R7rOQn5k/KLxOHApyIcD27V1JRLnAVf7nfxB4jaAXrx/xLAincYOytMUKPV3Kdmsd8x0vgS3tANH/Vzsxrc2Wx2PWoWfcWZLudnbleSFJFMnqje85XjEMwXHfeoan/9oKCZDjy7Wur1yDmvVi1dTAqUfxAcWBHxrOXAvi3rS8LdijHKCbD1QCBj3I6P2XDFW6gERsm2ZyWt4ZbBRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/mZZZp5hpX3TmJwuBtdb/7Gvqk5Xwe8uQg50lx+hPiI=;
 b=rjLoJ5ZOP011C4QhIAII3m+8+1nAZRYGToQBUS+U6I3c0GDx2tUkFXKbg5hVzhnWD2xxMcIcWWRoHvMuscn27bfNEbGfkG8P8qMqalYaC9ndhSJMmhB5hAJQaQd01UWGeIOKxZmIffvvpkX+aWuSCdxEVSA6fC9KNNSXUyJTWTA=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by SJ2PR10MB7560.namprd10.prod.outlook.com (2603:10b6:a03:537::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Wed, 20 Sep
 2023 10:39:20 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::8adc:498c:8369:f518]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::8adc:498c:8369:f518%3]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 10:39:20 +0000
Message-ID: <257b5833-5aaf-4748-a576-7610bd36e632@oracle.com>
Date:   Wed, 20 Sep 2023 11:39:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/8] hugetlb: batch PMD split for bulk vmemmap dedup
Content-Language: en-US
To:     Muchun Song <muchun.song@linux.dev>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Rientjes <rientjes@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Barry Song <21cnbao@gmail.com>, Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20230918230202.254631-1-mike.kravetz@oracle.com>
 <20230918230202.254631-7-mike.kravetz@oracle.com>
 <9c627733-e6a2-833b-b0f9-d59552f6ab0d@linux.dev>
 <d8ca9ff5-3160-49a1-947a-de4998887dce@oracle.com>
 <07192BE2-C66E-4F74-8F76-05F57777C6B7@linux.dev>
 <d1c4ee80-2096-4949-af9f-d55dcac071cb@oracle.com>
 <83B874B6-FF22-4588-90A9-31644D598032@linux.dev>
 <5bd9c4f5-3411-4327-a495-ce6672150977@oracle.com>
 <A8712DC1-7A22-4A59-BB2C-F7089D8FCC16@linux.dev>
From:   Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <A8712DC1-7A22-4A59-BB2C-F7089D8FCC16@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0393.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::21) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|SJ2PR10MB7560:EE_
X-MS-Office365-Filtering-Correlation-Id: 96c5b0f9-1f13-4d39-132c-08dbb9c5d8d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fPrkPSRW/mXducC/GfPIavxJJfCaUeeOvjQTeZuwepK8Mjm2K0mty8WcZHYDb2ZmatMuAM0O3mrcQTDZegYvD1oUM4ZMRK5QGsGxDuazccMuQzyCZd++r0gyP5PvABgEeMdNmHfqJ4vuc5N+izsX4DOBnXPTUIGYLBOZUpo76YC/ZFmrqweQ42yDgsXCxsJTcna3hBaE3f1uYvmdUXJhEkbiyF4mTroWYPy9/swrX41flFWLHIz4gS9C+MjExictlZdJ4T8SQyCMfGgvjx9j6EG5lsYQIBh5ape5sy6TbuQ3LCtulsEeHrQ1pKKU2YfTbK6j5p4im7WcccsAf/or1Z6VKP6hDXhV7iYEch1WGoFF2SMkT8E+vJsUYsdCkSCZ8LrC4evhEUw7KfEPK1FjReCWeZNQ2lQ5Q5zEvUACtFWE/OGt4+EVybHcMfGGKlXCHJw/hIlxZACe88zplgGtm1RlmyXR8PFwqvxIdAYDbOI8NJiNdT/Tg11DFFqMfJyjueQRbVUD/KcZnMmYmho6v9mAFDN0TmuswEAIaNTS+ss6hHT0ZEsASGvvuZB50YjALml0t88qxWrWmS7PdcB79/fiAH1I7XEKRl6MKJ8Pz0FZudy19GGDkpxmjVGjk9F9DTHYfxb8cRLTiQAjcNlaPg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB4835.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(396003)(39860400002)(136003)(451199024)(1800799009)(186009)(31686004)(36756003)(7416002)(6506007)(31696002)(86362001)(41300700001)(8676002)(8936002)(4326008)(6486002)(53546011)(26005)(2616005)(6666004)(6512007)(5660300002)(66946007)(478600001)(38100700002)(2906002)(6916009)(66476007)(54906003)(316002)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUhhSWlkS2xTcUVaK2xoajRnWDNCNllpZmlXYVhjSE8rM1A0OTM5RnBGMEJv?=
 =?utf-8?B?b2FDcXRGNGhPZi8rVUxQREFsVHpRWGdmdnVUM3JpYXgzQ3piRnkxVzhpTHZj?=
 =?utf-8?B?Tm1wSmtYei9GQXpvZE5HSHBPQU5iWG40TkthSEFDWlZ0OG1XdGZnUkp2dks1?=
 =?utf-8?B?VjZUSEtSa25LcEZ4dTNnTVVYQk1idlZrS2lBcStCV21Kd1NjY3lsQy9TbEFl?=
 =?utf-8?B?VGFST0l2a3lMUXdycktIVzU4Y0d4cGVGbDQxeVhYTElPZEdEcDJOQjk5RTJ0?=
 =?utf-8?B?eEU5TXZUUWFRdVVJZnJ0UFVBK1JQd3I0UkNITG1BYTFudHJJdS93dXg0UFdr?=
 =?utf-8?B?UUN0YUdTRGpYeU1UQ0FMaGM0bGRnYzUrSTcwS3FQT2dlNVZCUFBVT1N4K0hC?=
 =?utf-8?B?RnZuZlliOGtTdGNhaEZGWFJGa3luOEtYVEg3dUlxaUhLNUJmUVowRnRWd1k5?=
 =?utf-8?B?a2RmYTFoMVE0Z2RqT0NLZ29sclBaeGRkR0JBcjNHNlo0MFBCd0l5MzJkWWZH?=
 =?utf-8?B?anh1Y216T1JnVmdtUmxaVEtHMjNRSTh2YUxlQTkxU1JkSWRNeWs2NnFOcjYy?=
 =?utf-8?B?LytZdjVnKzQwb214YUZmTHZ3Wnc4TXJGbFBKK2dGSmkya3ViYVpiRDY3TlRr?=
 =?utf-8?B?Yi8rMXd5Yk0yclJuRVNyMll0NC84NkE5bzVOZjNHbTlDdW9JbzczaE5JVENH?=
 =?utf-8?B?Si82bkthN3RwdWVyZCtFZFN3b2RacjE2bWFKSTNjaFdocExzQmZ2U0tReEda?=
 =?utf-8?B?cVdHSjUyVTQ2cEE1Y2dHbmpWRGw4TEJseGpSbnBCTWt0RTFmczAya0hOSEtF?=
 =?utf-8?B?TWl0THQ1K1Z6eGxncDc4ZDZBcVQ0Mk1DaFZoOU1uWEZHRENxWDJjVE5IN2pW?=
 =?utf-8?B?eWtTN1daenM4bmo2Ri9VQVRmYjRPRmdJT3VDT29BQkgrVFJ0QzZyRTVUazd6?=
 =?utf-8?B?aU1KODdsbkcreVlQTWVOYlNESy9nd1JmTys3Z3V0WTJMOE5YN0s5eTh3YkxS?=
 =?utf-8?B?N1ZLY08xeWlpa0JNVE5nRGJDNTcvOWdkRDVrOFR3Z1ZQWFFnRVdOZFpKOENF?=
 =?utf-8?B?UlRZU0xJKzZrQ3h4cjRKZ1Y0bTRvMzQvNGNMbjcwWmdBeDVPWWJRNkxad2hm?=
 =?utf-8?B?ckxFSG9zYUpmTWtSZG9VbkJFbjVvcncyVGJyWWN0UWgxanNtc3JFcmxGM2RT?=
 =?utf-8?B?YmNIK0QyVHJORmFjK1BtQi9QVitaOEgrb3NPVlpBK21ablc2Qm5hdGtyTENL?=
 =?utf-8?B?bW1RNFVlV2tuNW5MZkVJNWN5VGlQbWFZQ003L1FMVW1qdjZwaG8yOHZ4TzhS?=
 =?utf-8?B?UHFUSnByWmFqV2JjZjJZcno1czRmdmVyemVjNkQzbWhJaS82Z1JiRFlZTjNa?=
 =?utf-8?B?TjdFTlRWQzNaVkEwQlRjeDBhc2wyQk9PYS9nRHlxamx2N0RtZ1JHazlWdW9s?=
 =?utf-8?B?V25KQ3JKaVlkejRtMmkwOWtXQ1k5anQ4QkFjOUZ5NUF4OEZQVVM5MEVNUVZ0?=
 =?utf-8?B?MVJZYzg2UTBnVzR0dEZ0RnY0R3R6a21WMCtJSGE1by9GQkxFRHJacm1zR0g3?=
 =?utf-8?B?MnA4QnpKRm1NWUtJU3RBK1k3TkhaamtqM2ppQ0hQU0NKVkFZSTAwNWo2TkFZ?=
 =?utf-8?B?T3F0UllOdG1HK2VveXBMek5RNCtTWE5zbllmejVpQlUvZHAwMUhWQmF5eE5Z?=
 =?utf-8?B?QjZhUXNoZFA1NjdDYmZJdUp0YXVlZS9HcVhCQnhWK0RZaFFubWlGZUNjTHFR?=
 =?utf-8?B?ZDM5NXBGUk5COU05RjdXZ1JrMGJqVU5venRhQzdHZUpMVHBlMGZiRU9KS3Zv?=
 =?utf-8?B?N1BJSHcwTDBaVEJTeVdsSWpISjkzSTdiZmdYT2tNS21EZDNDbTRvZXl3MHhV?=
 =?utf-8?B?a3diWHBrU0FUZ0thNDJoMzFScWtPTlRhRzRtcHNJNmVScCtwUklxTFVDZ0VN?=
 =?utf-8?B?clFuU3ZNMUJRNnZSMjBZNndoUkc5d3RNU2JBd1dtVlEydmNmcktjOTJiWm1D?=
 =?utf-8?B?ZEVXUHJGRGk0dklnUVZoMFFhb3c4TlJtbXRkZWhjdnlPVjVhcnpqMkdHMHhP?=
 =?utf-8?B?YlJ3VE9nekVnWUxOWTA4Lzl3amE0TDl2eWxqeFNDamFYZUlqcE9rR2M5YjJq?=
 =?utf-8?B?QjM5VlF0UlVOcmZNRWFLckk0MEtiZVNRMldYazhrWmtWWjZjS2tBMTdVL2wy?=
 =?utf-8?B?dVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?YjE5VlVodzhDK0hxcE5XTUNVNjUzMUw4M1pEYjd2K1R2UWRST29BY1JsMWc2?=
 =?utf-8?B?K0pDbkhxdys1Uk9wb1lvZURVS21GYzdFbDNvVXRPcC9BaEthT1h1N282WGll?=
 =?utf-8?B?eGFqUzRBYW5oOWJSZCtwSUJUMnUvVGt6c3RBcDJUZkt4WHdrRFZ2dithOVkv?=
 =?utf-8?B?VlpSYXYxYnhVMGVwZ0NZRS9JcW9mOTcveVBSUmIxQ1B5ZjEweWFpRFI0S09M?=
 =?utf-8?B?bW45WFFWbXphSFl0UVVTUnZWZzlibEs4RlA1L1lhUXBvV2xWaHZ3Sm53dkxy?=
 =?utf-8?B?bE1QYzBJSEJVNy9pS0ltWG5QZUZwVjAwUUZWU252NEgvS01SejR5YkFQeTd3?=
 =?utf-8?B?cnB6cEdvcitFY2tKN3ltRExXM0lMMmcySW5QMFdydlZKWEpJSlcrV2d5SENx?=
 =?utf-8?B?cmFzbHh2M0lRZXFTb1ZRNVFKdVgzWk5XRmZlUnBrK2tIYlYvcldCM0QxaVpM?=
 =?utf-8?B?Q25keDBUM1JrZHN2akdPYzYrbWxkY3hZdzUrZWxVM0FVUk9mK0luZmRhck5w?=
 =?utf-8?B?aFA4T0J0OG9oVWFGc1ZxSjh3QnJmU3ZMcUFYQktFU1NHSkxkcWN4bmZseSta?=
 =?utf-8?B?bUVIdlo3dHlDUUIrMFR5bDRMZlRoM0tkSlV1b1JVaXNzZEw2WU9scFdveXZH?=
 =?utf-8?B?bkM3ZHVSaWhmZlNUbnlheCtEUkRnQ1QxTTBHU1ZSQWRUQ3ZwR091SVFXNDdU?=
 =?utf-8?B?elpCMFYyRDhMdHlyeXIzVnFmSExZNHEyelI4bWdRb2NEM0xBZFR6MUFkb0F5?=
 =?utf-8?B?RHhzUi9nWjVoU2pOYlNYdUs0NitTTE5UWjJJYkQ0TGFKQjV5Zyt0K1FmUTBw?=
 =?utf-8?B?aGt0bkcxeXZFcTVMTm54VFV6ZDBkZXBiMzBtMTl6SWZDcWErVzV0NG5lQ1I3?=
 =?utf-8?B?ZndPenV1UXFaWFlscDc4VlpMaFdxOGNaVDJDZEdReHVDemtsUW1pT1loRWNq?=
 =?utf-8?B?TkxJb0RrVGs1TVlzTUpXU0ZrVDBKZURwMXBWNnlGQ0dpUml1amNXWWdpbWFr?=
 =?utf-8?B?b0hFYTR6akpNZmozUzZUY3Q4KzNjRE5jSThJTXA4dDkyRXQ5NEtKQi9WdDl0?=
 =?utf-8?B?WnVVSkdDVGRnVTdEdEVFSFVoUFdTVmovSVdFaWNvRlc5c3BJM0pwQ3ZBK2RM?=
 =?utf-8?B?Qmp5U3gwblZDaE5BSTlzd3h2OWVHZUVTUmFXL0FIODhEOEV5RUJLVjVtd1hQ?=
 =?utf-8?B?ZlpxNVQyTHpFdkwwaCtDZGRZL0JJUStSWU8yeHh3SUh0QWRzTjV4bDRRdXpz?=
 =?utf-8?B?eDBnY0M5djVMdjNXcUFOaENBNVhsNGJOM2tZeXYybko5b0lnZUllbWtCeVpu?=
 =?utf-8?B?aElsQTVGRGZCQXpzTzhLemFqRDF5Rm5Eb2dUSEJ2WVJKTVkzcjJiRk54NW4x?=
 =?utf-8?B?WXZGZitGS1ova05Ycm9DTXZ5Q2cxY3l4bnRDOG9CbUFzaElVRzA5QU4yYzY4?=
 =?utf-8?B?RXJZMmRlcE9YbHhQcWtEWFNBamFiQlE0Ri9qSkRNYllwVTZzSmtQVVFNTGY4?=
 =?utf-8?Q?i9Ae4XCjZXOntQ8d1UaVEcvfRXy?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96c5b0f9-1f13-4d39-132c-08dbb9c5d8d7
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 10:39:20.3165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ym3D/CrcpQ7QoESADldrapK3GFxOxRzBz9BEnnu9EGRh4dAK4H3z61+cjClUksrx14BV8K/eS2PgnCiNK0D1cvmJhFAPNNsS/Rv8O4M7Gdg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7560
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-20_05,2023-09-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309200084
X-Proofpoint-GUID: x5wNMXqrUE5wD--aGOWiGzWBGjLuWhsW
X-Proofpoint-ORIG-GUID: x5wNMXqrUE5wD--aGOWiGzWBGjLuWhsW
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/2023 03:47, Muchun Song wrote:
>> On Sep 19, 2023, at 23:09, Joao Martins <joao.m.martins@oracle.com> wrote:
>> On 19/09/2023 09:57, Muchun Song wrote:
>>>> On Sep 19, 2023, at 16:55, Joao Martins <joao.m.martins@oracle.com> wrote:
>>>> On 19/09/2023 09:41, Muchun Song wrote:
>>>>>> On Sep 19, 2023, at 16:26, Joao Martins <joao.m.martins@oracle.com> wrote:
>>>>>> On 19/09/2023 07:42, Muchun Song wrote:
>>>>>>> On 2023/9/19 07:01, Mike Kravetz wrote:
>>>>>>>>    list_for_each_entry(folio, folio_list, lru) {
>>>>>>>>        int ret = __hugetlb_vmemmap_optimize(h, &folio->page,
>>>>>>>>                                &vmemmap_pages);
>>>>>>>
>>>>>>> This is unlikely to be failed since the page table allocation
>>>>>>> is moved to the above 
>>>>>>
>>>>>>> (Note that the head vmemmap page allocation
>>>>>>> is not mandatory). 
>>>>>>
>>>>>> Good point that I almost forgot
>>>>>>
>>>>>>> So we should handle the error case in the above
>>>>>>> splitting operation.
>>>>>>
>>>>>> But back to the previous discussion in v2... the thinking was that /some/ PMDs
>>>>>> got split, and say could allow some PTE remapping to occur and free some pages
>>>>>> back (each page allows 6 more splits worst case). Then the next
>>>>>> __hugetlb_vmemmap_optimize() will have to split PMD pages again for those
>>>>>> hugepages that failed the batch PMD split (as we only defer the PTE remap tlb
>>>>>> flush in this stage).
>>>>>
>>>>> Oh, yes. Maybe we could break the above traversal as early as possible
>>>>> once we enter an ENOMEM?
>>>>>
>>>>
>>>> Sounds good -- no point in keep trying to split if we are failing with OOM.
>>>>
>>>> Perhaps a comment in both of these clauses (the early break on split and the OOM
>>>> handling in batch optimize) could help make this clear.
>>>
>>> Make sense.
>>
>> These are the changes I have so far for this patch based on the discussion so
>> far. For next one it's at the end:
> 
> Code looks good to me. One nit below.
> 
Thanks

>>
>> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
>> index e8bc2f7567db..d9c6f2cf698c 100644
>> --- a/mm/hugetlb_vmemmap.c
>> +++ b/mm/hugetlb_vmemmap.c
>> @@ -27,7 +27,8 @@
>>  * @reuse_addr:                the virtual address of the @reuse_page page.
>>  * @vmemmap_pages:     the list head of the vmemmap pages that can be freed
>>  *                     or is mapped from.
>> - * @flags:             used to modify behavior in bulk operations
>> + * @flags:             used to modify behavior in vmemmap page table walking
>> + *                     operations.
>>  */
>> struct vmemmap_remap_walk {
>>        void                    (*remap_pte)(pte_t *pte, unsigned long addr,
>> @@ -36,6 +37,8 @@ struct vmemmap_remap_walk {
>>        struct page             *reuse_page;
>>        unsigned long           reuse_addr;
>>        struct list_head        *vmemmap_pages;
>> +
>> +/* Skip the TLB flush when we split the PMD */
>> #define VMEMMAP_SPLIT_NO_TLB_FLUSH     BIT(0)
>>        unsigned long           flags;
>> };
>> @@ -132,7 +135,7 @@ static int vmemmap_pmd_range(pud_t *pud, unsigned long addr,
>>                int ret;
>>
>>                ret = split_vmemmap_huge_pmd(pmd, addr & PMD_MASK,
>> -                               walk->flags & VMEMMAP_SPLIT_NO_TLB_FLUSH);
>> +                               !(walk->flags & VMEMMAP_SPLIT_NO_TLB_FLUSH));
>>                if (ret)
>>                        return ret;
>>
>> @@ -677,13 +680,13 @@ void hugetlb_vmemmap_optimize(const struct hstate *h,
>> struct page *head)
>>        free_vmemmap_page_list(&vmemmap_pages);
>> }
>>
>> -static void hugetlb_vmemmap_split(const struct hstate *h, struct page *head)
>> +static int hugetlb_vmemmap_split(const struct hstate *h, struct page *head)
>> {
>>        unsigned long vmemmap_start = (unsigned long)head, vmemmap_end;
>>        unsigned long vmemmap_reuse;
>>
>>        if (!vmemmap_should_optimize(h, head))
>> -               return;
>> +               return 0;
>>
>>        vmemmap_end     = vmemmap_start + hugetlb_vmemmap_size(h);
>>        vmemmap_reuse   = vmemmap_start;
>> @@ -693,7 +696,7 @@ static void hugetlb_vmemmap_split(const struct hstate *h,
>> struct page *head)
>>         * Split PMDs on the vmemmap virtual address range [@vmemmap_start,
>>         * @vmemmap_end]
>>         */
>> -       vmemmap_remap_split(vmemmap_start, vmemmap_end, vmemmap_reuse);
>> +       return vmemmap_remap_split(vmemmap_start, vmemmap_end, vmemmap_reuse);
>> }
>>
>> void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head
>> *folio_list)
>> @@ -701,8 +704,18 @@ void hugetlb_vmemmap_optimize_folios(struct hstate *h,
>> struct list_head *folio_l
>>        struct folio *folio;
>>        LIST_HEAD(vmemmap_pages);
>>
>> -       list_for_each_entry(folio, folio_list, lru)
>> -               hugetlb_vmemmap_split(h, &folio->page);
>> +       list_for_each_entry(folio, folio_list, lru) {
>> +               int ret = hugetlb_vmemmap_split(h, &folio->page);
>> +
>> +               /*
>> +                * Spliting the PMD requires allocating a page, thus lets fail
>                       ^^^^                                 ^^^
>                     Splitting                           page table page
> 
> I'd like to specify the functionality of the allocated page.
> 
OK

>> +                * early once we encounter the first OOM. No point in retrying
>> +                * as it can be dynamically done on remap with the memory
>> +                * we get back from the vmemmap deduplication.
>> +                */
>> +               if (ret == -ENOMEM)
>> +                       break;
>> +       }
>>
>>        flush_tlb_all();
>>
>> For patch 7, I only have commentary added derived from this earlier discussion
>> above:
>>
>> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
>> index d9c6f2cf698c..f6a1020a4b6a 100644
>> --- a/mm/hugetlb_vmemmap.c
>> +++ b/mm/hugetlb_vmemmap.c
>> @@ -40,6 +40,8 @@ struct vmemmap_remap_walk {
>>
>> /* Skip the TLB flush when we split the PMD */
>> #define VMEMMAP_SPLIT_NO_TLB_FLUSH     BIT(0)
>> +/* Skip the TLB flush when we remap the PTE */
>> #define VMEMMAP_REMAP_NO_TLB_FLUSH     BIT(1)
>>        unsigned long           flags;
>> };
>>
>> @@ -721,19 +739,28 @@ void hugetlb_vmemmap_optimize_folios(struct hstate *h,
>> struct list_head *folio_l
>>
>>        list_for_each_entry(folio, folio_list, lru) {
>>                int ret = __hugetlb_vmemmap_optimize(h, &folio->page,
>>                                               &vmemmap_pages,
>>                                               VMEMMAP_REMAP_NO_TLB_FLUSH);
>>
>>                /*
>>                 * Pages to be freed may have been accumulated.  If we
>>                 * encounter an ENOMEM,  free what we have and try again.
>> +                * This can occur in the case that both spliting fails
>                                                             ^^^
>                                                          splitting
> 

ok

>> +                * halfway and head page allocation also failed. In this
>                                  ^^^^^^^
>                             head vmemmap page
> 
ok

> Otherwise:
> 
> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
> 

Thanks, I assume that's for both patches?

> Thanks.
> 
>> +                * case __hugetlb_vmemmap_optimize() would free memory
>> +                * allowing more vmemmap remaps to occur.
>>                 */
>>                if (ret == -ENOMEM && !list_empty(&vmemmap_pages)) {
>>
> 
> 
