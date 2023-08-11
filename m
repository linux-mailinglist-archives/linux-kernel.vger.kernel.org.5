Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54A667786F5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 07:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbjHKFXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 01:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjHKFXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 01:23:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C702D44
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 22:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691731386; x=1723267386;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NIkFCDG82Qd+6gVnwmShdECoC9/dZBwvgLcBxI7qAA0=;
  b=ayWj43lPKBnxhAqtH9d6JpnBcMHn2QdedzVg/nE3AnkZRVOqudZBeGr0
   OU1XNtATsSwaK8qzcxLe6T7QV0FCEO6gKzj8zvo5Ns9W3a5wzkJUnXqOo
   drIpBpMxMGs4XCLIK3V67qZ7iLROZ6qLDm8lblKGMmBfMthixGmt9for/
   MkJtNRi6Z6h61bvk2IGu3euHPsfD8H2q4/h0gUzyZUeRb3yAxDpMtfx4h
   UIcuU4mMv6mBHE7U5tCHubFd8pUA48KAksYZIRuZGHOMc7agKXwow5sWb
   cnPmmr1o5oMY0m2ZHzUYgKcGfBWpr2G1tNnpBLOhBtVBjaIuw7Np05cXS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="361736438"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; 
   d="scan'208";a="361736438"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 22:21:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="846674410"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; 
   d="scan'208";a="846674410"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP; 10 Aug 2023 22:21:31 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 10 Aug 2023 22:21:30 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 10 Aug 2023 22:21:30 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 10 Aug 2023 22:21:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LvNisTMFrYP8sUc+s2vvhqZWPjCdQdrAP6u7FdLdEkHIRfidXeHp8w79n8XDE1jBDUBd8FPZ2+EPX/0tH/HD4T7AnUF2xf/+tw0K86BRLzgqJpumwwSUjVTbVDMXFir0PHAtpt+l/H1BXn8SfJdHqQzz7CtcNGE5WTOOLGyovZkysqqVmdcKMSWnlSfelhWgSKeteULPnrVX1RZQriiIh23L5ri5X8tGwA1LjVsLR+YlzBDHqzUwOB2De24FaaC9eu4CIJS4ksVjDFV6aJSlKxz8ereE/L05/WeO+GzvGZJX4bjpEUxJXFwoOa2g8GH9xh1YcfD4EkC8NV8JuY0l/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XbYfNqrawAmF7TACyQLGkNqUkZyraENW6qP9KWM7EOk=;
 b=d1j6M9I31zePHc0Dcxo7/bo0dgCV61MJcVvq4XOH9x6N5oC+p2a/iAnyNRFYCuPqeMbRPyUuqCG98z8GykxHD+9WR2UQqymh1fZU7N3MOWbzbao9vWzfTi5GOn7GmgdXEi5vD3aYFxLWauMB340cknKsc3L7d3KqJcsgWsuGIXsnsgWMx6PDG7CjjCekWuzet+yUd6uWhwwk3fPIWwELpzv9r0dNIepqEn8fLKImoWfWScGXLh8F0SxhId5fFQdekxEHRQlW7goso8I7lhMhFzexOL4Xq/kmb6B1Yi+5108iVeYybqbvc/grkmqBwBwOsvD5n3bBiiYuYOIH13ZPbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by DS0PR11MB8717.namprd11.prod.outlook.com (2603:10b6:8:1ab::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 05:21:24 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6%3]) with mapi id 15.20.6678.020; Fri, 11 Aug 2023
 05:21:24 +0000
Message-ID: <c98b1c02-4a3e-4b69-ad36-e07100a67398@intel.com>
Date:   Fri, 11 Aug 2023 13:21:21 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] zswap: don't warn if none swapcache folio is passed to
 zswap_load
Content-Language: en-US
To:     Yosry Ahmed <yosryahmed@google.com>, Yu Zhao <yuzhao@google.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <akpm@linux-foundation.org>, <willy@infradead.org>,
        <hannes@cmpxchg.org>
References: <20230810095652.3905184-1-fengwei.yin@intel.com>
 <CAOUHufYb2LiZYqhyk7GZ2roUbHUEUf3iKkvmSThHBS21EewHiw@mail.gmail.com>
 <26949c92-95a0-414f-918a-8b8cc11e3e9c@intel.com>
 <CAJD7tkZRjSKrGBhBQmFsc+45TNAcii2QRMwwhnsgP3_3o8Jxug@mail.gmail.com>
 <3732dd16-148d-4ac6-8295-86a12f89365b@intel.com>
 <CAOUHufZWReio1bwzLFeJhi1YVko=kjxcfHo1sS8cfnBZuPaHFQ@mail.gmail.com>
 <CAJD7tka17GHTgu9JZNW8-CCsH2OR67oj31h53oa-oPTTVnkQQQ@mail.gmail.com>
 <CAOUHufYk7ZV=YPk6uGE1+ysgTKRXdwV8T3s7qvEkpGYbGNKwEw@mail.gmail.com>
 <CAJD7tkZoE5is2_pBHs5w7-4Am8HuWdbkBn89OYoHfbRv5rSKsQ@mail.gmail.com>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <CAJD7tkZoE5is2_pBHs5w7-4Am8HuWdbkBn89OYoHfbRv5rSKsQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KU1PR03CA0020.apcprd03.prod.outlook.com
 (2603:1096:802:18::32) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|DS0PR11MB8717:EE_
X-MS-Office365-Filtering-Correlation-Id: bde818dd-f5a7-4881-8dff-08db9a2acdf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z2lFTg2sbTRFIigrm/Whq77cq8EgOvravElU27L+jLwYBFUmsk7oapMmhR/rC8K6rjn5PKn6tUjDXS4uoQIy/lFZ263xiiu2Za4SM7BxSSfGVqolasO+b5piv0Pw131fC3r/aaoauCPvtMYxXj/rDsdkXwDTxJXiMJacnbQTW9TMIA0ycYYwSRn5QwpV+5FrsqTal7dm8IuB7LAPH9awco3nvZCcYfVC1VGiQNsX8oxykDTYXVDzlyy1lzp4FEznHXxZHPjVIjYKrP7TDqmQQW+uLuLIUsdoX3Z4aWlbpSLq0kzHQF+NFZQlyF9fC4rI5/uI8tdENKDqP8CfefWZQJARc/woRUFssl4s71WbhODGAQiw2WrdqXq3WR+gyjEK9l8UaeCCuck+qgT/jhgNt6gkJDwsZJJQk+zdcMfEb3yabb97qGsr2Nk4cs2TmRT8a/OF+WWctykLg2G/a6liuOQJ/goGxhi1baXNNEScrMnxII1aoX6Osm0B1ItURhdnfC1h2qjTql52YhYHXYIT97oOgNMOKuxDWINfTvcJRFuUDnDzJF5xJ8Syb+7SWSnUVFuuk3WpN1anvUYLazhge/MZGu/OtMAM79rfMsTNfz0tP+qA4U3+9yFuSCuj3A3oy2B5DgUJ9hUGtfyYv3PVIA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(366004)(136003)(39860400002)(396003)(451199021)(1800799006)(186006)(31686004)(8676002)(66946007)(110136005)(41300700001)(45080400002)(4326008)(316002)(6512007)(66476007)(6486002)(6666004)(5660300002)(66556008)(8936002)(26005)(83380400001)(6506007)(53546011)(478600001)(2616005)(38100700002)(82960400001)(31696002)(86362001)(36756003)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkUydndidHhMVnRhdk1Vb1Q3YWhVekFqcFJtcFFlVHFVbm1ER2VWb3JlK2ZW?=
 =?utf-8?B?Q3laRmNSWVRvR0dkNkhveW16eFg2a0RwbEQ2VWVFam93UHQ3Rkp2WUdxOGg3?=
 =?utf-8?B?VVBJaExCYVRCdk02aXY0Y3l4N2hsekN2MlY3Tk90L2VIU05pbkVuWURnemdC?=
 =?utf-8?B?cENaSjR6VVJJb1VHYUZLSERkTTB3Q1NyLzFHZVpJWXhUWFNvRUxDRlhhSGNs?=
 =?utf-8?B?N0ZRaHBYaGRoNldKUlBQRmpZWGJjanEzQ1dPQTl3YUZUZ0VUNnlsYytDQVZ0?=
 =?utf-8?B?QVVpbkxja1IzVEVsQk0rSGlBY0hUREk0RnM1KzIvVy83TFJ2WThjN0IxVjU2?=
 =?utf-8?B?eVdsYnRzMmFpcU44Qzl4ZzFpOU9ML0FoMDZDV0d2SjlDZG90R3lkZU5BS3Z4?=
 =?utf-8?B?b0VwTHVmc1ZSY3I2bjhZRFM5NEVyMkxURk90WEZQbmc0ZytxOVFZV0VRWlIw?=
 =?utf-8?B?bWNKY3daYzFuQmRoZUVteEptSTNsMHIvcnJCUGVyODhJY1ZyNWsrWGNYWkNX?=
 =?utf-8?B?NzFEa0V6N2hTdk8vK3B6S0xmTUtENW8zN3p2ckNONWVxYUFPanM3VUFkVlN4?=
 =?utf-8?B?MVZaMjRKZDQxZEtRUGZNSFV4N1BiRDliUGszRlFTOUhUMkJSZmxtOHJZU1E5?=
 =?utf-8?B?S1dQR21SUytkbEsxUkRxTm5jYW14b3NNMDFJaGNQSE5XZ2R1S1BqSXVlcWhy?=
 =?utf-8?B?c0UzeDFJZCtxKzRVYkw5TVhLano2T2ZVS0poUWw1Y05FSlNoWGRlYzJpNDE2?=
 =?utf-8?B?YnovYVB3TERsVDdQUTZqKzZhWW9QQVc5WWxTYXVFMVNCMFdIOWZBd2RsR3Ex?=
 =?utf-8?B?L0pBTCtMdGdQS09aUnhiemV0NFhTVXdKN1N5L3RsOUxtVVp0Z0w3eklXaTlV?=
 =?utf-8?B?TkxzbmIyQTh6KzBjZHFrY1VnYnEwZjhyVFRrd3ZydGduRU1KVVFVeTVGTm1P?=
 =?utf-8?B?T3g2VHV4N1ZCMVYrNnkzS2o1dXNBWFdKNzJpbFpEdnRMeHFDcWF0eERaOFpW?=
 =?utf-8?B?V0hkSlBxbkdoVWFhNE9qTUtKdTkxaVhvS3cyeFc4SS9ZTEh5U1p5YjNudDZI?=
 =?utf-8?B?UnBDa2pkWmpIaVdpQUNvT2JDUjZlSWd6S3lVcXRRcFlNMnBQMjJLZlZzQzU4?=
 =?utf-8?B?QmFVZDdFTmZkSFZYdlNGdUtWVkpDNUI2TmhuZnZiOFZtV3o4RHpDZCthQ3pG?=
 =?utf-8?B?enRIM0ZqY2VtS2FpMHd6d01RY3R0MlF0b1d1YWpCK3NURHEyOVl5M2FwTXR6?=
 =?utf-8?B?RWZoVnJmNi9qZnZJbmRidmtwVHRndzlZalgwRnBaUXpoNSt3bk5rb0J0WVdu?=
 =?utf-8?B?aGZ3T1htai82UW4zdnh5WlZCMEY1dFRBQ1pWYjRGQktiZ0ZmUkJVZkgxZEhu?=
 =?utf-8?B?WEkxSUlvOWVCa203am05Zmd4UmFER3Q2SGNhNWVRTlQ2R2Q1MCtCY2wzK1Ji?=
 =?utf-8?B?R21YcXBoNGp4NmVPNFBMZjhQTkF3Z2tUSWUzazN6eE4wVmcvM0ZuSi82c2dQ?=
 =?utf-8?B?aXhWUnEweGovZDcxaHRTb2pGVXJBdVVmTEorWXMrZjVkenFxbXpYZFhlWEx4?=
 =?utf-8?B?dzhabitZMXk0VmJPcU45MDBqWVZ6S1p6eUhVK3BqSXhGRmkvSHRSeWJXTU5T?=
 =?utf-8?B?SnZBV21DMmExZUJDbCtNK0Q0UzhhR3ZjbWwwZjYwSGVtYndMaXVoYmFQcW9X?=
 =?utf-8?B?THladXBQOXIxY1pGaWNlU2pncFo1Vkg1VlRsZ250VTA5citzaUNDbHdTQjYy?=
 =?utf-8?B?Z21ySjdKcmhvdE9tU2tjRURyQkNNNzlsdGRQUzBPU0haVi9tNGRuY1liazN1?=
 =?utf-8?B?Sk5aTkUyMitZZ1FEZUhNUFJzYmtHV0sxeDBRZkVNZkFGMTJvRzZ4R1AwWUpR?=
 =?utf-8?B?NjVSZ0ZKRmZWZVp1Uk5JZHdPWEpsbytjTm1kM3RzTk50U1M1akxJWld6WTQ2?=
 =?utf-8?B?Vm1sQnpEUzU0RlhMbjRiZDZYS3NDLzNWb1BBTFdnY1hSRVFRMjBMakVFNkJF?=
 =?utf-8?B?aFZvYUk0WVhzZnhpcU9uNG9CdElzbnB5dkNRWUF4enVBVWtaQWdlMS9zTzF6?=
 =?utf-8?B?MGNrWDNBc3BqZ2JnTEZzMGgwZis4VFN5NWhreGVHNkR6dlZRR0RhdDc2SkVB?=
 =?utf-8?B?MVpraS9tYTE1YXEvTzVDb0gzcklscVBkSlZ0Z0VsZ1RJL3JWWk94QVdrdDNo?=
 =?utf-8?B?K0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bde818dd-f5a7-4881-8dff-08db9a2acdf6
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 05:21:24.0850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ij0DA5BbmfgiihYC7S4sZYf465a7pmhWn3BNDlTqc7su9+JPiZTEL/bE8lpm5GaM+CCdbwuDEPgc/HpyRS5XXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8717
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/11/2023 11:21 AM, Yosry Ahmed wrote:
> On Thu, Aug 10, 2023 at 8:12 PM Yu Zhao <yuzhao@google.com> wrote:
>>
>> On Thu, Aug 10, 2023 at 5:46 PM Yosry Ahmed <yosryahmed@google.com> wrote:
>>>
>>> On Thu, Aug 10, 2023 at 4:44 PM Yu Zhao <yuzhao@google.com> wrote:
>>>>
>>>> On Thu, Aug 10, 2023 at 5:31 PM Yin, Fengwei <fengwei.yin@intel.com> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 8/11/2023 7:15 AM, Yosry Ahmed wrote:
>>>>>> On Thu, Aug 10, 2023 at 4:09 PM Yin, Fengwei <fengwei.yin@intel.com> wrote:
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> On 8/11/2023 2:44 AM, Yu Zhao wrote:
>>>>>>>> On Thu, Aug 10, 2023 at 3:58 AM Yin Fengwei <fengwei.yin@intel.com> wrote:
>>>>>>>>>
>>>>>>>>> With mm-unstable branch, if trigger swap activity and it's possible
>>>>>>>>> see following warning:
>>>>>>>>> [  178.093511][  T651] WARNING: CPU: 2 PID: 651 at mm/zswap.c:1387 zswap_load+0x67/0x570
>>>>>>>>> [  178.095155][  T651] Modules linked in:
>>>>>>>>> [  178.096103][  T651] CPU: 2 PID: 651 Comm: gmain Not tainted 6.5.0-rc4-00492-gad3232df3e41 #148
>>>>>>>>> [  178.098372][  T651] Hardware name: QEMU Standard PC (i440FX + PIIX,1996), BIOS 1.14.0-2 04/01/2014
>>>>>>>>> [  178.101114][  T651] RIP: 0010:zswap_load+0x67/0x570
>>>>>>>>> [  178.102359][  T651] Code: a0 78 4b 85 e8 ea db ff ff 48 8b 00 a8 01 0f 84 84 04 00 00 48 89 df e8 d7 db ff ff 48 8b 00 a9 00 00 08 00 0f 85 c4
>>>>>>>>> [  178.106376][  T651] RSP: 0018:ffffc900011b3760 EFLAGS: 00010246
>>>>>>>>> [  178.107675][  T651] RAX: 0017ffffc0080001 RBX: ffffea0004a991c0 RCX:ffffc900011b37dc
>>>>>>>>> [  178.109242][  T651] RDX: 0000000000000000 RSI: 0000000000000001 RDI:ffffea0004a991c0
>>>>>>>>> [  178.110916][  T651] RBP: ffffea0004a991c0 R08: 0000000000000243 R09:00000000c9a1aafc
>>>>>>>>> [  178.112377][  T651] R10: 00000000c9657db3 R11: 000000003c9657db R12:0000000000014b9c
>>>>>>>>> [  178.113698][  T651] R13: ffff88813501e710 R14: ffff88810d591000 R15:0000000000000000
>>>>>>>>> [  178.115008][  T651] FS:  00007fb21a9ff700(0000) GS:ffff88813bc80000(0000) knlGS:0000000000000000
>>>>>>>>> [  178.116423][  T651] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>>>>>> [  178.117421][  T651] CR2: 00005632cbfc81f6 CR3: 0000000131450002 CR4:0000000000370ee0
>>>>>>>>> [  178.118683][  T651] DR0: 0000000000000000 DR1: 0000000000000000 DR2:0000000000000000
>>>>>>>>> [  178.119894][  T651] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:0000000000000400
>>>>>>>>> [  178.121087][  T651] Call Trace:
>>>>>>>>> [  178.121654][  T651]  <TASK>
>>>>>>>>> [  178.122109][  T651]  ? zswap_load+0x67/0x570
>>>>>>>>> [  178.122658][  T651]  ? __warn+0x81/0x170
>>>>>>>>> [  178.123119][  T651]  ? zswap_load+0x67/0x570
>>>>>>>>> [  178.123608][  T651]  ? report_bug+0x167/0x190
>>>>>>>>> [  178.124150][  T651]  ? handle_bug+0x3c/0x70
>>>>>>>>> [  178.124615][  T651]  ? exc_invalid_op+0x13/0x60
>>>>>>>>> [  178.125192][  T651]  ? asm_exc_invalid_op+0x16/0x20
>>>>>>>>> [  178.125753][  T651]  ? zswap_load+0x67/0x570
>>>>>>>>> [  178.126231][  T651]  ? lock_acquire+0xbb/0x290
>>>>>>>>> [  178.126745][  T651]  ? folio_add_lru+0x40/0x1c0
>>>>>>>>> [  178.127261][  T651]  ? find_held_lock+0x2b/0x80
>>>>>>>>> [  178.127776][  T651]  swap_readpage+0xc7/0x5c0
>>>>>>>>> [  178.128273][  T651]  do_swap_page+0x86d/0xf50
>>>>>>>>> [  178.128770][  T651]  ? __pte_offset_map+0x3e/0x290
>>>>>>>>> [  178.129321][  T651]  ? __pte_offset_map+0x1c4/0x290
>>>>>>>>> [  178.129883][  T651]  __handle_mm_fault+0x6ad/0xca0
>>>>>>>>> [  178.130419][  T651]  handle_mm_fault+0x18b/0x410
>>>>>>>>> [  178.130992][  T651]  do_user_addr_fault+0x1f1/0x820
>>>>>>>>> [  178.132076][  T651]  exc_page_fault+0x63/0x1a0
>>>>>>>>> [  178.132599][  T651]  asm_exc_page_fault+0x22/0x30
>>>>>>>>>
>>>>>>>>> It's possible that swap_readpage() is called with none swapcache folio
>>>>>>>>> in do_swap_page() and trigger this warning. So we shouldn't assume
>>>>>>>>> zswap_load() always takes swapcache folio.
>>>>>>>>
>>>>>>>> Did you use a bdev with QUEUE_FLAG_SYNCHRONOUS? Otherwise it sounds
>>>>>>>> like a bug to me.
>>>>>>> I hit this warning with zram which has QUEUE_FLAG_SYNCHRONOUS set. Thanks.
>>>>>>
>>>>>> Does it make sense to keep the warning and instead change it to check
>>>>>> SWP_SYNCHRONOUS_IO as well? Something like:
>>>>>>
>>>>>> VM_WARN_ON_ONCE(!folio_test_swapcache(folio) &&
>>>>>> !swap_type_to_swap_info(type)->flags && SWP_SYNCHRONOUS_IO);
>>>>>>
>>>>>> Of course this is too ugly, so perhaps we want a helper to check if a
>>>>>> swapfile is synchronous.
>>>>> My understanding was that the WARN here is zswap_load() doesn't expect
>>>>> a folio not in swapcache. With zram, swap_readpage() must accept the
>>>>> folio not in swapcache. So this warn should not be there.
>>>>>
>>>>> But your comment make more sense to me. I will update the patch not
>>>>> to remove this WARN. Thanks.
>>>>
>>>> That can cause another warning.
>>>>
>>>> Please don't overegineer.
>>>
>>> How so?
>>>
>>> Using zswap with zram is a weird combination
>>
>> Not at all -- it can achieve tiering between different compressors:
>> fast but low compression ratio for zswap but the opposite for zram.
> 
> That's definitely an interesting use case, thanks for pointing this out.
> 
> I would prefer creating a helper and using it in both do_swap_fault()
> and zswap_load() in the WARN_ON (with data_race()), but I am not
> against just removing the WARN_ON either. I will leave it up to you
> and Yin :)
OK. I will stick to the current patch.

Regards
Yin, Fengwei

> 
>>
>>> if anything I would
>>> prefer leaving the warning as-is than removing it to be honest.
