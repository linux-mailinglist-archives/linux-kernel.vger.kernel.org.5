Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2E7575ADBC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 14:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbjGTMDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 08:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjGTMDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 08:03:18 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56EFF10FC
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 05:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689854597; x=1721390597;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1NfDnurmnp1vJs7pgjo6LJ5BVs2LZgQUbf6Z+DRNeos=;
  b=mpjSxwiXenCeRiucgLwgph+drwFmVffyEKBI3Iq2S/b+7m6CEl3VVgiz
   8fe1iYCIIkmQ7z/j+J+ZGLernep8iKk+yvGvIrOCEM8sPzNpTdNnfnJM/
   XEVxd99k6rJMLs3TwO23tn/kfu/5cgciuaRpyNVPmnSHFgKGwiVcxd4ZL
   nq2Eji6+1mLVAocjbftCkmH74PUJ2+Bjw8oOXfMyXdnYjYI/ndqWx4cIs
   dh8fEEK3tq7HfArNaMqFFpaOc9C4hSNQQ3ER71+MholKmz+GFwmAolf8M
   1LWj7FuiOuVRbgmP9uUXB0tXmGKkTUjH0u3nwekjAhigZFreaXegqZiCg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="397586398"
X-IronPort-AV: E=Sophos;i="6.01,218,1684825200"; 
   d="scan'208";a="397586398"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 05:02:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="789773756"
X-IronPort-AV: E=Sophos;i="6.01,218,1684825200"; 
   d="scan'208";a="789773756"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga008.fm.intel.com with ESMTP; 20 Jul 2023 05:02:24 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 20 Jul 2023 05:02:24 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 20 Jul 2023 05:02:24 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 20 Jul 2023 05:02:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YEPS2THM0w5v4OXWXuKrTY6o2OJcwqveRGzYGQUXnbUmpyQp+8/0gqsx8cgHB/uEfUq7KbrsuT9bA04lyN7OpPeiaXHrLs412F3aBkCXhbmAiVKn5nC1t+gYzSkXK0TYMK5evZqSsdm+FKIGsznP1cjOBl6pQ0oFLa/Cs0aSfW/ffZMnhihZ/TQNMlW66nK+A/vYtKybqSCz2DPOvuWq1Fbe9xx71hc6gF8yadE5nZpKUo7R2L+z1/LqyC5tRwsoIsvrnlDMy7oBpYe5cZOjH5F6wu+JX8RtAa5nXE46N6BbJ/FfZxsozh9rOxaLbD/smymodidFLHbL2F7Z7S88Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2e/Dm0rpYjpm+JBk7BYPVLeKlq1k8zQO/96NjdcznTI=;
 b=fGiouIMl9JzMGjyQe5it6/1p036F10MSdH24rRpxMd+2TST4sbx6pZdZbrwNCc5Work8sUpdKG8svI2LqB8TV6Nk80a2BF1ty6Fhlqa9a2/Dl1AgJrK8pji1TPzAS7Vm0NM2OGXzeBa0LNw32CABu2gnQNNyXSyeOBV8LIV/wqDTMCod4iJx+h/VppWgBGKxnj164PmnL7Q4vju/wCZwihHYIbmV5h12EKxN2WpXmvh8GIO9y97GqRxdymIGmzoBKFiskhnLVgIw3qV+r344CZO7CXKgH+A530db7p8VmepYfwfvjpOJuki92WGEnR/x6/taPGl6IxB/2Lt2GSHoBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by DM6PR11MB4610.namprd11.prod.outlook.com (2603:10b6:5:2ab::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Thu, 20 Jul
 2023 12:02:21 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::f4df:c85c:6300:880e]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::f4df:c85c:6300:880e%5]) with mapi id 15.20.6609.025; Thu, 20 Jul 2023
 12:02:21 +0000
Message-ID: <d2ae87ee-8ee3-0758-a433-8c937e5e3fb5@intel.com>
Date:   Thu, 20 Jul 2023 20:02:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [RFC PATCH v2 3/3] mm: mlock: update mlock_pte_range to handle
 large folio
Content-Language: en-US
To:     Yosry Ahmed <yosryahmed@google.com>,
        Hugh Dickins <hughd@google.com>
CC:     Yu Zhao <yuzhao@google.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>,
        <willy@infradead.org>, <david@redhat.com>, <ryan.roberts@arm.com>,
        <shy828301@gmail.com>
References: <20230712060144.3006358-1-fengwei.yin@intel.com>
 <CAOUHufZ6=9P_=CAOQyw0xw-3q707q-1FVV09dBNDC-hpcpj2Pg@mail.gmail.com>
 <40cbc39e-5179-c2f4-3cea-0a98395aaff1@intel.com>
 <CAOUHufZHyEvU-c2O6B6stM_QVMxc22zV4Szn52myYqjdZvptUA@mail.gmail.com>
 <16844254-7248-f557-b1eb-b8b102c877a2@intel.com>
 <CAJD7tkYAkVOE2caqEj_hTmm47Kex451prBQ1wKTRUiOwnDcwNA@mail.gmail.com>
 <b995e802-1500-6930-79d0-8cc4bfe89589@intel.com>
 <CAJD7tkZtHku-kaK02MAdgaxNzr9hQkPty=cw44R_9HdTS+Pd5w@mail.gmail.com>
 <CAJD7tkZWXdHwpW5AeKqmn6TVCXm1wmKr-2RN2baRJ7c4ciTJng@mail.gmail.com>
 <208aff10-8a32-6ab8-f03a-7f3c9d3ca0f7@intel.com>
 <CAJD7tkYT6EZMwit8C9MTftUxMmuWtn2YpZ+NSVhy0xVCYuafsg@mail.gmail.com>
 <438d6f6d-2571-69d9-844e-9af9e6b4f820@intel.com>
 <CAJD7tkYWH8umBFgmxPmeOkRF=pauVW=MvyyN+z17XMHN+q8JKg@mail.gmail.com>
 <e3044d46-3b38-dc2e-b8d2-8ec1033f85e7@intel.com>
 <79f6822-f2f8-aba4-b517-b661d07e2d@google.com>
 <CAJD7tkaMycnAaY-8Gu=kUwbYqDzihP4BQDzCC2M4BTYAKgG6Qg@mail.gmail.com>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <CAJD7tkaMycnAaY-8Gu=kUwbYqDzihP4BQDzCC2M4BTYAKgG6Qg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::13) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|DM6PR11MB4610:EE_
X-MS-Office365-Filtering-Correlation-Id: a86d2e01-7a70-41b0-f71a-08db89192c65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IpKyiw9uqM57eeIQuIUaMWEpDfbFjj/cDiXwHhYCvQ9m1cN72k/3uwzv7FaMhrXWCX2IRfEAU+w3Uk3hd6lAToB2CnUJ0Dl9bKxB6Rx7H8S7dlvCRwoSjb/MWB4RdDwcv4PsHpSmYI7A4whzgqSz590sFZ2IdT18qNjS6GnS0UZmx5ci6unB9PQgDFzgSm4Y06ZHxwpWMhpt2DHAP3EYxn0ujuzNY8ubjun7JWJ9y2yfk8PO7vJbA0dCAFKEueZ3N8jrBp6DsDUiyVW0IJt7OYZ09Fhe/094kHvHxbDdGutVTSfopKM6hFRQDFc2w7fzcjzwKjMPse+8XnKnSKzjcdmsyWJi6ustY5r613YpBMYtWGzCwabrumVGMz0H7P6OsOHgKX+pDjz+ip+W597WQWJXCOrf2UaISh+4nHTSxLCvQBLL2LvgvojsclHe2yCY+2t3Eh72p+s/9NS0NadYdz4ydDI5U4ae2LlatmhIiyEyoY1HAs4nnI1HKV6MKJgzqA11PSqdBv6k3txp1U2GvNhB5ma+pvxo/6D0wOCviQe8WfLzLdnzYJiW8Tzs0ZM12a79wbpNM+OuXgY24O202aiMwExHU8xvPtuzazA+v9DN+GeP1UO87p/BC35bl0Fxuzh3LdW3GZaITSdhTpNMKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(39860400002)(366004)(396003)(136003)(451199021)(186003)(26005)(6506007)(31686004)(66476007)(66556008)(316002)(66946007)(478600001)(4326008)(53546011)(41300700001)(7416002)(6666004)(86362001)(8676002)(8936002)(31696002)(110136005)(6512007)(6486002)(5660300002)(36756003)(2616005)(2906002)(83380400001)(82960400001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUZBaGsyOXo1MDB2Q2l2Q1ZEV1FhcCtQVXdnc0FuM2pKQTl2bjlybVE4LzRS?=
 =?utf-8?B?TnIzYm5Xcm1XaGJzc2cxR3hEcm8vV1gydkhnYk5mdzdhaVpzMGdmM3NVWnY3?=
 =?utf-8?B?dGVnUFdBWDVZRnZQeUJrSHZoNlQ0RTZMMy9wejB6b0RvWERIWWRBRVlpQjAv?=
 =?utf-8?B?L2VQbEhoMEx6VTlTYzVobldaV1NkbTZVczluKzZjcHZRaUZBdktZNnVPQlA2?=
 =?utf-8?B?d1p3dGNHU2g1Q2V5VTJ6ODRnTHE2NzJGOVhPSUN0bTlpK3h6K3hrVFY1SHV5?=
 =?utf-8?B?aFhjOWIrT2YwRWJLWE41SGRibk9yQzlwVXJXVjA4ZVlLTlArTGlZdy91c0tp?=
 =?utf-8?B?dDB2OEgvVzkrRE4zdDkvRmtVK1pZbThWWGNnY0E5UXBZUGNkTld2RDQxQTlL?=
 =?utf-8?B?eDQyUm9SNUlNV2F4V3ZEME5QR0ZERXlycXBsYjh3cDhaWkJnTlA2Z25mUkhG?=
 =?utf-8?B?TXNBYWx4Rld4N1QvUFdXTkM0Rk5wVkJhM1pUT3dwZTN4YWVKcmZGNUxSTjJ3?=
 =?utf-8?B?YWZJUlpuRi80cHVkd0prQ1FhSWk4aHNiVUMyZHFjM054YVVGeEtjVVhGV3dy?=
 =?utf-8?B?WUlTODhrNlNpWEsrN1dEU0xkdmhudnRHbWRBRXZYY0U1YlJaSU5LYWZEaU9P?=
 =?utf-8?B?bm83Y1FnR3V5dFVBNGswelRTa2lRbzlycVo1cDJjSmJkdDBkTnJCSldoemN5?=
 =?utf-8?B?dG1BRjU3SEV2M2M1Z3hJeGpaWEdramxROFBEY0dPS283My8zUjM5NmgrVitB?=
 =?utf-8?B?OTl2UWZxdEtrSVNSMTV6b3RkQXZXY3RkRkZ4dzMzQTRtSE8ySGdFdklvRkZ1?=
 =?utf-8?B?MS9sRHMvMk5uZ1V0S1c0OVVVWEVNRk9qVExNMjlSN05yNHYxU0NjdXZLcXNm?=
 =?utf-8?B?bXo4djM3M3Y2M3JnR2x1MkZSS3lEM2twcTBPSXdKODRZVFpLa3JBRUFKanYy?=
 =?utf-8?B?UnM2SzR4eXdNWVVRSFZBTkMxZVBBdlRpb09xOXc3UjJnVWZzYzc3dVZuWjl3?=
 =?utf-8?B?VnZFS0cxUkdZNmdDSVRuZytHdjBMOXNYMnhORGtDYTZuL0lmM3JscyswdW9S?=
 =?utf-8?B?c1dwSWN6WVZKU1lmTWZIYnltMTFwcnFCSEhnTkFKckZCa0o5RkZXSlhDV2M4?=
 =?utf-8?B?c1dzNjY3enpwaFpyTXdwZiswbWEwMHNCUDBlQ09yYnc1akkzVWc1SUExL0ww?=
 =?utf-8?B?S0hRd1BDNHFvRExOemNBTzdzbHlNQ0tPeVRZeSt0R1ZFTkhWSUwySXlNdGpn?=
 =?utf-8?B?QVNCVjVXM0FUNDVNZ0h0eWNhb2R1R0Z4dXFBQ2oxWGpzdFJPam15b1R1eWpB?=
 =?utf-8?B?NHNWSEJvbi9sV0lLY3RFUjA4alJRNkJHdTlMdTFjbDVYOHR6VUpXZ3ppNDJG?=
 =?utf-8?B?NFlJQmNXZm8rTTJyVmtNYXNXSjVjbklsbkttTmJHbCtyOCtvd3hFbFN0azR6?=
 =?utf-8?B?b2l6WUQvQ3gxb1l0ZWF4c2VQS2h4empoRjdVMEVFUjFaWFdmcXRuTy9jQllh?=
 =?utf-8?B?bjM5VTRKZy9VSVZCY0diWTc4UmpCb0RHRk04UFB4U0NNcHpLZWN2ZkhsL1Fw?=
 =?utf-8?B?SlpKOHFxUVdhd0ZDaTZXNEtpMGZhZmdERFpFbWFGazFJTGQ4VXU3VUpZV1hp?=
 =?utf-8?B?dElITUJJL1hRU0ppYW5EOXNhWGpmemE1WE1vZlB6VStQZjdPK2tLVlRYek0x?=
 =?utf-8?B?ajJXWmdoVlVoNW5UUDJjQS9JSmFLdGZoMmZ3TFBKbFdoTndNNjl2SVpucHRt?=
 =?utf-8?B?TU10OFZhTjNzOWtkMUQ1TTEzQ0x2WUZBQ3I3UDVFWURMdk5Jbk8zZGRIRFA1?=
 =?utf-8?B?Y1h3bGJrVDFyV0FZcGNxc08wRDhmbzBqbFRLWmtnUXdrRWV3QVNEK0tmVFpr?=
 =?utf-8?B?ZVNaakVyQ0JLZmh5Zkt3K2hzVmRjNXFqYndZNGZjbW8wcjFNTEpvcXZrQStU?=
 =?utf-8?B?QkpCeWRDR09qeVBNdzBXTzdJT0N5Z1pqcHAxVm5tT2xkaEZmelJLYWxDVktM?=
 =?utf-8?B?TXY5bEhVdnU3dUUwZ0c4dllIb2pRSUhpSXR4RElPcjJuRG04L3YwU1JJREsz?=
 =?utf-8?B?TEZMTlBsT2prVzBOMlRSUGVQMUNlVjdWMW4xU0QwV1cyOCt1bDMrMnUvNmVj?=
 =?utf-8?Q?Y8uj8nQhXfU73VgG6AptMUqGE?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a86d2e01-7a70-41b0-f71a-08db89192c65
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 12:02:21.6433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H0n+wRapADhBPhma3BL3etd2OztBn0o4oKuFukDpJYxDgF26rcwEMEtS+WGHbhRSmNUFusKAtZ3wdYKbJlP5Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4610
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/19/2023 11:44 PM, Yosry Ahmed wrote:
> On Wed, Jul 19, 2023 at 7:26 AM Hugh Dickins <hughd@google.com> wrote:
>>
>> On Wed, 19 Jul 2023, Yin Fengwei wrote:
>>>>>>>>>>>> Could this also happen against normal 4K page? I mean when user try to munlock
>>>>>>>>>>>> a normal 4K page and this 4K page is isolated. So it become unevictable page?
>>>>>>>>>>> Looks like it can be possible. If cpu 1 is in __munlock_folio() and
>>>>>>>>>>> cpu 2 is isolating the folio for any purpose:
>>>>>>>>>>>
>>>>>>>>>>> cpu1                        cpu2
>>>>>>>>>>>                             isolate folio
>>>>>>>>>>> folio_test_clear_lru() // 0
>>>>>>>>>>>                             putback folio // add to unevictable list
>>>>>>>>>>> folio_test_clear_mlocked()
>>>>>>>>                                folio_set_lru()
>>> Let's wait the response from Huge and Yu. :).
>>
>> I haven't been able to give it enough thought, but I suspect you are right:
>> that the current __munlock_folio() is deficient when folio_test_clear_lru()
>> fails.
>>
>> (Though it has not been reported as a problem in practice: perhaps because
>> so few places try to isolate from the unevictable "list".)
>>
>> I forget what my order of development was, but it's likely that I first
>> wrote the version for our own internal kernel - which used our original
>> lruvec locking, which did not depend on getting PG_lru first (having got
>> lru_lock, it checked memcg, then tried again if that had changed).
> 
> Right. Just holding the lruvec lock without clearing PG_lru would not
> protect against memcg movement in this case.
> 
>>
>> I was uneasy with the PG_lru aspect of upstream lru_lock implementation,
>> but it turned out to work okay - elsewhere; but it looks as if I missed
>> its implication when adapting __munlock_page() for upstream.
>>
>> If I were trying to fix this __munlock_folio() race myself (sorry, I'm
>> not), I would first look at that aspect: instead of folio_test_clear_lru()
>> behaving always like a trylock, could "folio_wait_clear_lru()" or whatever
>> spin waiting for PG_lru here?
> 
> +Matthew Wilcox
> 
> It seems to me that before 70dea5346ea3 ("mm/swap: convert lru_add to
> a folio_batch"), __pagevec_lru_add_fn() (aka lru_add_fn()) used to do
> folio_set_lru() before checking folio_evictable(). While this is
> probably extraneous since folio_batch_move_lru() will set it again
> afterwards, it's probably harmless given that the lruvec lock is held
> throughout (so no one can complete the folio isolation anyway), and
> given that there were no problems introduced by this extra
> folio_set_lru() as far as I can tell.
After checking related code, Yes. Looks fine if we move folio_set_lru()
before if (folio_evictable(folio)) in lru_add_fn() because of holding
lru lock.

> 
> If we restore folio_set_lru() to lru_add_fn(), and revert 2262ace60713
> ("mm/munlock:
> delete smp_mb() from __pagevec_lru_add_fn()") to restore the strict
> ordering between manipulating PG_lru and PG_mlocked, I suppose we can
> get away without having to spin. Again, that would only be possible if
> reworking mlock_count [1] is acceptable. Otherwise, we can't clear
> PG_mlocked before PG_lru in __munlock_folio().
What about following change to move mlocked operation before check lru
in __munlock_folio()?

diff --git a/mm/mlock.c b/mm/mlock.c
index 0a0c996c5c21..514f0d5bfbfd 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -122,7 +122,9 @@ static struct lruvec *__mlock_new_folio(struct folio *folio, struct lruvec *lruv
 static struct lruvec *__munlock_folio(struct folio *folio, struct lruvec *lruvec)
 {
        int nr_pages = folio_nr_pages(folio);
-       bool isolated = false;
+       bool isolated = false, mlocked = true;
+
+       mlocked = folio_test_clear_mlocked(folio);

        if (!folio_test_clear_lru(folio))
                goto munlock;
@@ -134,13 +136,17 @@ static struct lruvec *__munlock_folio(struct folio *folio, struct lruvec *lruvec
                /* Then mlock_count is maintained, but might undercount */
                if (folio->mlock_count)
                        folio->mlock_count--;
-               if (folio->mlock_count)
+               if (folio->mlock_count) {
+                       if (mlocked)
+                               folio_set_mlocked(folio);
                        goto out;
+               }
        }
        /* else assume that was the last mlock: reclaim will fix it if not */

 munlock:
-       if (folio_test_clear_mlocked(folio)) {
+       if (mlocked) {
                __zone_stat_mod_folio(folio, NR_MLOCK, -nr_pages);
                if (isolated || !folio_test_unevictable(folio))
                        __count_vm_events(UNEVICTABLE_PGMUNLOCKED, nr_pages);


> 
> I am not saying this is necessarily better than spinning, just a note
> (and perhaps selfishly making [1] more appealing ;)).
> 
> [1]https://lore.kernel.org/lkml/20230618065719.1363271-1-yosryahmed@google.com/
> 
>>
>> Hugh
