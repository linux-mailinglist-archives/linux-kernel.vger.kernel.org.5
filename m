Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5777A5C5B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 10:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbjISITj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 04:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbjISITb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 04:19:31 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3465183
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 01:19:25 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38J6TAtL015480;
        Tue, 19 Sep 2023 08:18:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Sd7akLWuaxhH4WVIymwikxVVHM5P8uJS4Y/fAU00UCQ=;
 b=Z5i1F9iZzYdF2fKzfkTAOi7DiHYR/P0NvsQ3j3Jw8X1Qlwx8CI9TElsHo2oVDHUOsKBD
 wYJ5HSG86BYUyAPNepozJeJS55FpFJzE9X/ErLBQ83thqN7e0DzA2JBpgHUTBvLySxzl
 vvr2llVKkVLal6IAYwaLH39mDrnDuivDrxLhbCbOIysmXG3AHtcOOst5i0XpJUvv+rYw
 +WIEcQHBBuY+ke/AwSFbJSD36eXnPiRSf1LZtcTy+AEwExq3LrdP8QENsz4ODnvS1Dm6
 fSY+DyH029bRxuoqopwfMpEPvHGuNVNMxo4gGJXs0OYF40/S8MfShuhW8LROBzx5HCW6 Mw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t52sdvbgv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Sep 2023 08:18:37 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38J6W2Cg012033;
        Tue, 19 Sep 2023 08:18:36 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2048.outbound.protection.outlook.com [104.47.74.48])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t52t5kb44-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Sep 2023 08:18:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iRUh9kTQ/dUSR0IaUCuKT1atWEPwz65Z2KtOqzIWQMN1jd79K3GUghfWFEqEQphTuwYwFTpDf/Q1r1WgUESHFrZYWqPC2NSi+qSt5uQeu/1vLQzvE1ltyBUxU7wm4pLbg+mpW0QFs3xJRI+CV/dfEYaWJG3ZM4ep0tc4Mlv+ofoYMh+ubQ/tS60enNhhqAA/7EKF6Jz7nwifMXL0OHkeNClbfNrXsNuHdO1aSLaIlUSjeR+WeoIGmLP2spHOENPEVpK8aOFj253BS0lWovNxSbT/ypDAUfJwFir0R7MEiyP3FjFBry6GNSBalRxUAdPNhUAez6axb5xRVkHJzt7EaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sd7akLWuaxhH4WVIymwikxVVHM5P8uJS4Y/fAU00UCQ=;
 b=YcfLDKNaAErS/Xibl8slDiLrK35aIossqrmpldK2WvtE/aXtaWclMC8KR2Dt9KZoCEt6H43++voEw9NGunvAyqVfn0Czd3jscgYNAkRJdpvAr67NOz6rajJNCe+eUJUX6RaCrvyNMepHMFkNTfkvvbJHvIBBp3TUznjqMBrBYIp9MnC8poP/CT3HS7gLSZWkWY7SO7gADm7n/qMm0+/L8VAJBjyQNVqUrfXlltawfdC5osZSI75GgoLZRu9xjq28Wa7f/lMDezP54Dh5rqZsLUbGVzTVzlonTeThbGTPSo8lXC9Y2QM54bXXV8Hc+LWazHcrFZJ4bp27M7NTVKJeug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sd7akLWuaxhH4WVIymwikxVVHM5P8uJS4Y/fAU00UCQ=;
 b=uWispD+gLigX02WtD6CtOdlopXv/JnbR6mrh1JrSQCsZmITwJ7/Af890i14QBSgf2UDkJRZfjZA0nt1adJzVnS8kvcI5vepUA9kscfUDc4DvVQAFQtpxVyZSjiLSxLNsl9wplAuUrZVArYtlWMiQfrLNuvx5I9wtOilxvEY2VFY=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by DM4PR10MB6063.namprd10.prod.outlook.com (2603:10b6:8:b9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 08:18:28 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::8adc:498c:8369:f518]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::8adc:498c:8369:f518%3]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 08:18:28 +0000
Message-ID: <4aa875a0-fb11-4ac4-aa4a-9a4a500e50db@oracle.com>
Date:   Tue, 19 Sep 2023 09:18:21 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/8] hugetlb: batch PMD split for bulk vmemmap dedup
To:     Muchun Song <muchun.song@linux.dev>,
        Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Rientjes <rientjes@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Barry Song <21cnbao@gmail.com>, Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <20230918230202.254631-1-mike.kravetz@oracle.com>
 <20230918230202.254631-7-mike.kravetz@oracle.com>
 <7d0129fb-551f-e37a-f6cd-8fd96c896851@linux.dev>
Content-Language: en-US
From:   Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <7d0129fb-551f-e37a-f6cd-8fd96c896851@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MR1P264CA0190.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:57::13) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|DM4PR10MB6063:EE_
X-MS-Office365-Filtering-Correlation-Id: 92817783-e4fa-4b39-b07f-08dbb8e900d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wRzTJzelGU0buzEPPi5wA+iXXs+M6KIEOdzaZkks76VUDZmuCn49l1XWRXtxE58nkLziY/SvbDRXTB/esIP3ydIQTD14vK/vBJpwQ6jD3XfuJjC72KQr8jDLJJ29ENWgtlH5ipG4VeFw83aKhzvwVBOnbUkX7ySAmBA3qlQxp5FfgpnO4MMCl2pP2Wc19xuCh43HfH2AVwfFlqPEclbM3oShelUUHtiOBnTwJIF0h4e/YYRKs+i6Bhuz/hworaTxCj1adrdnwud3cypMdUXSFpIgJwycnKstv5ii49mfLoAXS6TKIdLkIal668sQdOajrIdSP0bFVlXqDXiP6zDaltedmmiwCFoEfnrvi2N0gQluyQF7YPuh0CwagWJnxvhE4xC4lBRpsekEkiQYX3uxjxqfLI0VKCTRKEqjg8f9f4+3HPcVsyAsLUEMntiACd95kMITX+N86aZKeV4lxfAJO/qLq76lJau6xDwxuk4El+KGDzUVC3z+hGBP8xIBACMLV42gcHq7/jz3Sc+bSrfZk6IyI1O4nwFtK842YQv7i+G9baYMvctwlsZK1BP93PmMMM3BSi0qnMANlaga88UFYGq4oosP5TgIniMyG4zbwkJsnFUclqE4QzAR0UU+EismSfr4OxrCiNqr83XBvsrKhQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB4835.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(366004)(376002)(136003)(186009)(1800799009)(451199024)(2616005)(26005)(6506007)(6486002)(53546011)(6512007)(31696002)(36756003)(86362001)(38100700002)(83380400001)(5660300002)(478600001)(7416002)(41300700001)(31686004)(66476007)(66556008)(8676002)(66946007)(110136005)(6636002)(8936002)(4326008)(54906003)(6666004)(2906002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2ZxR1Z1RVhaNDdneGxUODFjVkw5cTVveS9jNTJSa0M5d2I0bXgxaGV1YkMw?=
 =?utf-8?B?MGhOQVFRVStxcGJETnBUanN6YjJxcFBjWnJhZ1R3Q3FxZXM0bmZGYk5ZNHpV?=
 =?utf-8?B?b0hZY094aWVobms0ajB0QzVDQVdleVZXdTEzZkdBeGpqeElBaU5PUndZbmp4?=
 =?utf-8?B?NkRsT0s1alRGTHBhb0VHSE5CZFNlTjJkaDVBYndOT2dMMHUvMCsxejQ0aG1p?=
 =?utf-8?B?V3dGUjJnZDQyOE9uNnljMVFXUXlRNGtNdkJXRnE4K1BDV3QvbW5Xd1JrbEZa?=
 =?utf-8?B?YUVoZWtYNDhWRG9sMkdTam9yTTB4UlZEOXk2Yjd1aHhhU1FwMHdqWkdTaFE2?=
 =?utf-8?B?ZlFaMXJlMUl2dTA3ZG1EMmdKV2xUMzNHdnBaUjJTZHRSb1E1dXVtaGJRQjNo?=
 =?utf-8?B?TnFQVEVsQUNrcHppZndYa3NRdjhMWUxqK2VDRVZaeHhHSjUxTkpucVBzUFZ5?=
 =?utf-8?B?VTRreUswU0Voa2kyYUZGQit0eVFpMFBuRkZKZ2hwSTB4OHlyakNYZnV5RVpm?=
 =?utf-8?B?V1lldXRkanV3WmFlT0ZGUTJXNjRWOU13ZEkxNjJ2bE5xZUxSQVhJSTAwQjR6?=
 =?utf-8?B?ZGlWNlE0YnZoTkRCb0lsSVZyZk9SNkY2Y3lvaHU5Y2ZwL1BIVXpZRnJRM2do?=
 =?utf-8?B?MmJlRlZoZHhIV0htZ01obGQ1elVIR240Y1YyOU1kaGlLNG41YmgyVTdjZEZY?=
 =?utf-8?B?alFia0MzMURaZllXV01WSlcvRjB0MENMQyt5Tnd5NFFBbk5QYWRHZU1NT3Ar?=
 =?utf-8?B?clhtRTBqT1ZWcXcxblRNckNYcWJBcGFjaDdKZEF5RnZTaWNiTGIyMlFKWWcw?=
 =?utf-8?B?cjI1eGMxME9hdUIrdzNQWXlObGFoOU4wakJnd1B5bkpkdTV2Z2ovZW0xSWpM?=
 =?utf-8?B?TTdLS1RCeUowMDI5L0NxUm0wSi9VUjhwbWFvM0ZKQXFXc2Eyb21sa0dtdEFz?=
 =?utf-8?B?RmNuVDBod0lkd05zN2hZdjgrYlQyLzRUazhrbHRJWkJRSkNGOVhiUGVCTkxw?=
 =?utf-8?B?Y0RRZzB6aEpBQTNZaFFwaExPN2lwMkpkSko4a1lTd0h6Z0V5cVRWYmh5Ukhy?=
 =?utf-8?B?YURVZk1rSy96RDNsZDdVZlRyWXcrWlVGeHlGNXFLWDJCUFVMQkxmdVdBb1Vw?=
 =?utf-8?B?RlNscVZyenczUkgrcW5EY0F2aHo4N202SERlREhDUHJlZytrU0JEZFBRSTMx?=
 =?utf-8?B?OHhHRDhrbEt2MnNwSmpWL1MzM3VMTm9lOWxlYXE3SHpOUVV6TmRkMjdqWGRB?=
 =?utf-8?B?QVhsVzZpVG42UDNaeHEvVitPdWYwMmkvZm85OStMZDJZNGVwVXRnMVF5YTEz?=
 =?utf-8?B?L0pTdm1HNjBmSWExUVF6cm9qVnFpdkMxbVBNV28xazdNaUFXZkxPYWJ3T2hL?=
 =?utf-8?B?azBpQlhCeXFYYUZuMFF1d3hPdGZSUkExanpOZ0x2SERTemt6VlJUeDEwUWZw?=
 =?utf-8?B?WDRrWG9YRyt0T2hUamVlSUV6aS9uK3lFRnMyMk1sMDFsYzlwQWR0RjFCUUkw?=
 =?utf-8?B?cmNrT256a3drN0QxMDVaa2psYU9Xd3FLOVhMeDR1NG50b0hrb0ZaTHk0WFQy?=
 =?utf-8?B?MFRORUxyYjhKSHhycHRHbnlXK2tGTGlnTDNnczAvRnlQSkZnL1lvTmxxL2pi?=
 =?utf-8?B?cVhlN1phNTVCTVJicU9KbUZ2MGhyUnVHclUwNzA5Sld3YW1JcU02clB6NHNE?=
 =?utf-8?B?QzQvdGZpWWJhWUs0L0hYQW5HdllKcW9Gb0VCaWRKRlZmZDA1SFdnTFB5c0NV?=
 =?utf-8?B?Y1ZFeUhtbmtwYlhiclcxQjRySUZUUGpob1JkK3I0MzBZdTdHM0hIcU5majcy?=
 =?utf-8?B?K3VvVW5HV1IwSnpxdTJEOU0wMExyZlovSXVXdy8yMlhYR2tIeTNMMnZUbFRU?=
 =?utf-8?B?ay9kS2FhdGRyQnYxUy9sV2dPaHJWQkF1RytjYzdwREJXdkZsL3F0NVJndUV3?=
 =?utf-8?B?VWlyTUJBMVc0WnZQQmh3NW91ODR3QWh2dGRJZHljVzNYU0dkZkVaRVl6cldI?=
 =?utf-8?B?dTVrazBoK0tyeHp1V3hDaGJQQXBmL0pIbmw3VkFleloxUkhwS290ZC9haGlK?=
 =?utf-8?B?NWNhU2R3ckt0ZUxpaTZEeGFEN2dPMTdaTmdwODZTeU1nd0lIM09FUDU0cEN0?=
 =?utf-8?B?T1ZteEt3cUlSQnBWVUFVVmZiNytBUjB0Q3VhNFEweUN2djQzM1orWnd4V1Zr?=
 =?utf-8?B?eUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?QUZqSmprUVFxbTBkbEFmK3RkQWZGUDNKQi9FMXYzeDFvTjlRaWpDN0hGMk9R?=
 =?utf-8?B?TmxNVXdZdXR6amtjYUJhMHBENXpDbm8yUWl1YnBvTVhjQ1NGSVc1b1lJMmQ0?=
 =?utf-8?B?ZWRBVFoxS2gvYXFXWEdOeFNQL3VYUXVTdXJNWjlKVlJhZjJvSDdHdzNyWDNU?=
 =?utf-8?B?QWd2NEFLT2RRbkV2YTFPSlZzNVozV09EVnp0MzFKOUVaVG5xWi8ydTZaaXZq?=
 =?utf-8?B?Wkp5ODZGWjZoK1pzQ3k2R0xwTjR5WGE1ZGxQWWxkb2NTWFNIU0R4NTJNVjhK?=
 =?utf-8?B?Y3pLTlBMc1JwQTFhTElmNFkyYW9zeW9OUjR5R2NMZXFTd3B5TnJ4cTVqU25J?=
 =?utf-8?B?NEg4Y3hlZno5OGRVK21HeHhJRW9GSGI3NWFoS3ZteTYweEllYVp1dXJFZmRE?=
 =?utf-8?B?aWRDcnBUQktBRmlKQi9IcDlTUWhkSkxGckFVVmpIS2k3QVpJcHRRQkNHZHFR?=
 =?utf-8?B?QXJRblNRSDBMQ2c1OWZ1V3JaUG0rajdHbHFVMXFFbkp3dEcvR1lrRkYzMXBN?=
 =?utf-8?B?VXJJRDc5Wjl0dXlXS1lUZGNyT2pWckNLdXpwT1BOU2oyOXZkUHYwbytQYVli?=
 =?utf-8?B?WEJtU3BaQWN6NVV4UTJuKytWVHVQdG9EZGQ4cVNmYVB4dnZ3bHc4bDhhUEdn?=
 =?utf-8?B?MC9sOE5YVS9MNzBLczEzSTAvWC9HTGJJY0hUOHRGaCttUHVMNnBnSGovdXFB?=
 =?utf-8?B?ajNYc0JzM2NIbXl4Z0dzYjlIR0QxTWNYaWdqd0xyVlZGZTg1Y0ZnRllEcFNQ?=
 =?utf-8?B?NGx4NGVKODhPbTQxRXdaMjI5VkRlTTdMZytMNUh4ZmFiNDY5OS9UamNSK3Ft?=
 =?utf-8?B?NFF5MW5zeVpKQzExNjUxaERKbHh4Ky84TXh6dTRPU2hkZTJzbDZSYm4yb3NX?=
 =?utf-8?B?Tmp0WVk0ZEpNSUk2d00ycjNVcS9PZ3d5VmUwQWpmWGMzMStjTUtMQnlBQWVL?=
 =?utf-8?B?MktWMlRRQ3hzeUpheFQzaU5VZ2pEZXJlMFl0b3FwaEdQOE9kdzRXYmkyYis4?=
 =?utf-8?B?YXhyM2FnSGFXamwvaDlJbGdwZ0wvUVdvU0JSeXpIRllhM3EyNkhmc1ZSTHdU?=
 =?utf-8?B?bC9NVCtHd0RrZlZnaDlQalA0aDB1OElOQk5sbkQ3ZUloWGpwYUZIWUNEUkgy?=
 =?utf-8?B?TmVZSHBLZFRVRHBvZzhmV2JDaVZMbFlyeDUxT01nSWhSNzdmNTMxNmtTcVFO?=
 =?utf-8?B?OGkvdFBaY2IvdGhFeDM0N1A3UXZMLzVRdE0vdVZ6Wm5MTDBnSHIvNitjanRF?=
 =?utf-8?B?VWJQMUVibTBpeXBuN05jVG05M1F6VjBRNVhLVDI0K2diczkySjY4YlJ3VU9Y?=
 =?utf-8?B?Tmk2UHJEVmNiRnFVRDlPdVBqL2VYMHZWeUVlUG9EZ0l4WWR5ODFyRlJQR0Nw?=
 =?utf-8?B?T3lseS9FbExDTjFaK3BPRXRJOS9EL1hyOXB3SnNtcDBQb0VTVFVJOUJYQzNC?=
 =?utf-8?B?cmdOMmpsbFRJZExtWmVIalFyamZMbHZNc3VuRlZzeFlpUFJzSDRvTVhrSUE4?=
 =?utf-8?Q?tIS7oHpGYc+QhN8cJfQVCClsJDf?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92817783-e4fa-4b39-b07f-08dbb8e900d0
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 08:18:28.5644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jVnfT8RdARV0i0wQJC4VjK27k3rhHhroH1ZeiwOW+CaFTASRHI1+ImbLtkran6tyNKdr7Irl8O+hy5z2Y+xi84K3B6XbNuEpAF/i1lJkeFE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6063
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-19_03,2023-09-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 malwarescore=0
 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309190069
X-Proofpoint-GUID: qqq1V5VrkD3yaydbfc6EH2ReR-2ryiTl
X-Proofpoint-ORIG-GUID: qqq1V5VrkD3yaydbfc6EH2ReR-2ryiTl
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/09/2023 07:27, Muchun Song wrote:
> On 2023/9/19 07:01, Mike Kravetz wrote:
>> From: Joao Martins <joao.m.martins@oracle.com>
>>
>> In an effort to minimize amount of TLB flushes, batch all PMD splits
>> belonging to a range of pages in order to perform only 1 (global) TLB
>> flush.
>>
>> Add a flags field to the walker and pass whether it's a bulk allocation
>> or just a single page to decide to remap. First value
>> (VMEMMAP_SPLIT_NO_TLB_FLUSH) designates the request to not do the TLB
>> flush when we split the PMD.
>>
>> Rebased and updated by Mike Kravetz
>>
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
>> ---
>>   mm/hugetlb_vmemmap.c | 79 +++++++++++++++++++++++++++++++++++++++++---
>>   1 file changed, 75 insertions(+), 4 deletions(-)
>>
>> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
>> index 147ed15bcae4..e8bc2f7567db 100644
>> --- a/mm/hugetlb_vmemmap.c
>> +++ b/mm/hugetlb_vmemmap.c
>> @@ -27,6 +27,7 @@
>>    * @reuse_addr:        the virtual address of the @reuse_page page.
>>    * @vmemmap_pages:    the list head of the vmemmap pages that can be freed
>>    *            or is mapped from.
>> + * @flags:        used to modify behavior in bulk operations
>>    */
>>   struct vmemmap_remap_walk {
>>       void            (*remap_pte)(pte_t *pte, unsigned long addr,
>> @@ -35,9 +36,11 @@ struct vmemmap_remap_walk {
>>       struct page        *reuse_page;
>>       unsigned long        reuse_addr;
>>       struct list_head    *vmemmap_pages;
>> +#define VMEMMAP_SPLIT_NO_TLB_FLUSH    BIT(0)
> 
> Please add a brief comment following this macro to explain what's the
> behavior.
> 

/* Skip the TLB flush when we split the PMD */

And will also do it in the next patch with:

/* Skip the TLB flush when we remap the PTE */

>> +    unsigned long        flags;
>>   };
>>   -static int split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start)
>> +static int split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start, bool flush)
>>   {
>>       pmd_t __pmd;
>>       int i;
>> @@ -80,7 +83,8 @@ static int split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long
>> start)
>>           /* Make pte visible before pmd. See comment in pmd_install(). */
>>           smp_wmb();
>>           pmd_populate_kernel(&init_mm, pmd, pgtable);
>> -        flush_tlb_kernel_range(start, start + PMD_SIZE);
>> +        if (flush)
>> +            flush_tlb_kernel_range(start, start + PMD_SIZE);
>>       } else {
>>           pte_free_kernel(&init_mm, pgtable);
>>       }
>> @@ -127,11 +131,20 @@ static int vmemmap_pmd_range(pud_t *pud, unsigned long
>> addr,
>>       do {
>>           int ret;
>>   -        ret = split_vmemmap_huge_pmd(pmd, addr & PMD_MASK);
>> +        ret = split_vmemmap_huge_pmd(pmd, addr & PMD_MASK,
>> +                walk->flags & VMEMMAP_SPLIT_NO_TLB_FLUSH);
> 
> !(walk->flags & VMEMMAP_SPLIT_NO_TLB_FLUSH)?
> 
Yeah -- Gah, I must be very distracted.

Thanks
