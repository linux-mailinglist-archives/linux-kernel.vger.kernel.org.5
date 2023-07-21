Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF46775BBB9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 03:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjGUBMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 21:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjGUBMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 21:12:32 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E62E75
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 18:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689901950; x=1721437950;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MjLuxPdcE5/k3TXHWCGeT9rLcip0ogncecCXI/gstKg=;
  b=gHmj+LoT5UrlZJJalu3k47bOrfLEqmLXA6keBl8Tkzjl5iXMT6e5qwEf
   jQGFSPKFaMRSbvI6mb/Tf8Xs8tCVefKn4OWeNcF5U5XMttLsXQ65qPytU
   9lKppIN43xv67HTpMuG9twcZPjH3uHPvB1DFkYnF8csefaaxJ+aRUzhw1
   aHn6rsZMP6Fq6yHGzEvLMSdDPPX4fz1+8OOhoVk2vN7poLEYkjfhOf9YO
   bXKM29ZOP26O7u8PjwCu/ucNy9PLsxFrygjURrxRCn22VF07AXpN8LdZD
   wYr7lEjPJ+uiSOYUDWVR08Kuj2Nat8JxDfLD/FaiOS8kowb9sVPYMa7GQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="351790302"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="351790302"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 18:12:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="718647422"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="718647422"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga007.jf.intel.com with ESMTP; 20 Jul 2023 18:12:29 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 20 Jul 2023 18:12:29 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 20 Jul 2023 18:12:28 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 20 Jul 2023 18:12:28 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 20 Jul 2023 18:12:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hebTHi4S5nGg6LCP8mNxZfy8n5hxX1Q848St1O1ZWlfGuHX2Vf6wJJTDd27kos1O2DF9VQ5WIPRqHilCFphDxSwYgX5WjZw0RHw3LA+ecHi2QDa2U23gvk9lh0fuKJKnihndgfqy4WfwsY+9OoyP/kHxEDXCpydyzCptquW7NUkSnvaOtjJS2Bq11UMcIAcH/lxvsB1AC+h6W1DQ5c5NpLlDULCK0Ig0a5RFgVBN3hfjV7S2O/IJRm8FC9Esg3hApFkLe979zMvXKX6R33zWaDESN8E2OB0x/w9SXZPG7Czd4RMrZl44NQQ/xNyG+p/cvvQrGwxrm7jAOem+8RkW2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rVNcri8OzhIaJi/nEFeZr9h3b2/aQ+kpNX6U9DxULVU=;
 b=c15b4qU0U+FfxbcWBtoULRoeQwqrf92zO+6QZQ7GgiKEjVmzw7SY6MtCGuFrFxCf8hto2jMVaCYiHuCYFYsxwZsj9J4Vhj0gvZOETp6xuNjkkI0xXL41F7AdG+p0iAD5RGOokIMj7GWvYmdCTtqhh1+X9qxNzzdKCJBAcknbnED75AWCw2H1HxhEo+DCeIXV+6N8h1oRlHZo0HS3a4vtRCnU/+RbGm8OfK6Li9S5oehAbkmGWVthCkag7o4o1e/IrK7w5ntx5HTydxiIYTbycKaJauxaY3aZtD+xGqFCVQDJ7wUMuqCz5pO9ek0GPQq9QiwxBTHeBkpQaEmsj9MRwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by CO1PR11MB5106.namprd11.prod.outlook.com (2603:10b6:303:93::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Fri, 21 Jul
 2023 01:12:26 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::f4df:c85c:6300:880e]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::f4df:c85c:6300:880e%5]) with mapi id 15.20.6609.025; Fri, 21 Jul 2023
 01:12:26 +0000
Message-ID: <c8ea2617-df48-a1cf-e910-71eeba353d67@intel.com>
Date:   Fri, 21 Jul 2023 09:12:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [RFC PATCH v2 3/3] mm: mlock: update mlock_pte_range to handle
 large folio
Content-Language: en-US
To:     Yosry Ahmed <yosryahmed@google.com>
CC:     Hugh Dickins <hughd@google.com>, Yu Zhao <yuzhao@google.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <akpm@linux-foundation.org>, <willy@infradead.org>,
        <david@redhat.com>, <ryan.roberts@arm.com>, <shy828301@gmail.com>
References: <20230712060144.3006358-1-fengwei.yin@intel.com>
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
 <d2ae87ee-8ee3-0758-a433-8c937e5e3fb5@intel.com>
 <CAJD7tkbuU9Op_TmUET9N+Mug=AS7N3S16tZifVajVBL0yaYv4w@mail.gmail.com>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <CAJD7tkbuU9Op_TmUET9N+Mug=AS7N3S16tZifVajVBL0yaYv4w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::16) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|CO1PR11MB5106:EE_
X-MS-Office365-Filtering-Correlation-Id: 65117426-e1a6-4a0d-5e84-08db89878bf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jG57DzcAcA9izSowCyfSMndILYakRfL47+G0NVzcO3Neo1YyQbbAFIYM9lxyZ8KDEVsEjwclIWVnfez1VDKcpzkpbQlmh3nkxKEoCt/0VlLt3iZH8LBDymfjbCdTsA2bWUH/b4+LeXJdUakQ2m+yr59Utlolkapqk+sp9ZGfSNlXq2HLwjoCE4h7BHcgwEXXJvoCP21m2kGGCdVKHhWdJVJWDEn/SLn+/HARZCzvnqZjgI/X5cFXgL4IkyrxXNfUZa43pwk19iXwhfOWCniyPSjzo+mG3zWHme8GE94kEI6UHff4j7pnWoldvgq2hue0Cqk2KOGw5/Ah5snS+Gf84kPvpDErJ3x/OWVFChndF13/0fXAKl+8ZkNoSanopRTwBlFiDR7CrhsYOEgmbfE/80RzDSUTtuY54Yc+TXtLdxMKU0flevN9rO3FHZpoySCz1Yi7nLXSwK9O2XeszUOsdaKiCD2hC1WY/N3lBIVy6462s0v9BUDsrPBUbsi0HliTceYEw9PPSpVvbxVi+Pap2RBZQDdqiRiTcnk4hVOiBrqeqVv6kXA77GBHcaWvCvtk6kkr4J0tboxrZbYGhJL9/KotEG4l0wmC21cV09Q591/96A887Hgs95a2DAac7ZjrLPWZOf/B3POFjJlvbT8TfA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(346002)(376002)(396003)(136003)(451199021)(83380400001)(36756003)(2906002)(2616005)(478600001)(8676002)(7416002)(8936002)(41300700001)(66556008)(66946007)(66476007)(316002)(6916009)(54906003)(4326008)(5660300002)(186003)(26005)(53546011)(6506007)(15650500001)(6486002)(6512007)(6666004)(31686004)(31696002)(86362001)(82960400001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEpoVVVLeWg1S3BzTXBxMTVnMFhlenpCdk9pQXBic3VNdEppV0VtY0R3cGkx?=
 =?utf-8?B?RStxaE1tRndRL3BqMk5CaDNraTROQkhwYm5YOUQ5MEw0MmFYQXNWTFJZSnlY?=
 =?utf-8?B?VGJpck5ldXd6QTZtNVYyVGcyZUEzSEticGJVeGFoN2dHcVREYmlsYlZJa0VN?=
 =?utf-8?B?TC9OME16cjY1NDBnM05BcmJDdmdIWVgwRmxyNlJUb2x6bEgvUnNHZ1lqSTVq?=
 =?utf-8?B?RHhCWEZxa01rcm1EQXowdEgxbGlEYk9FempsVFZ6VWQ3UjZ6cDJJMSt6MWNP?=
 =?utf-8?B?NWJPc2tqUksybXNQQlhUOFA4VWdtVUJLYUh4bEN4Q2NDcXRoYk5URTU5Mnc3?=
 =?utf-8?B?a1NVYnpBS2VoRExNdmJ5OG5ZOGdxRlVnM1psSVZ1b0tMdzVwTkg1bGsvZWdl?=
 =?utf-8?B?ekx1S1FCY3FZZkN3c2dtNWtRSCs5M3IwdG81T3B5MUl5Skp6V1NoY1BMdGRz?=
 =?utf-8?B?M1E2eEV4RncvYkx4UXY5QWZGVCtuQVYzM0VBUndRcE8vVkFmdzUwOGwyU09Z?=
 =?utf-8?B?UHhCSjZVOWQ3cGU4T2IrOFhmL2dPNDk5aEw2dmpBS3h4Y1JMMS9ia2o4cGdz?=
 =?utf-8?B?SEtBZ2NueFlOdG9SL2pBMXc4TFZ4V3hjT2ZYWjZkaGxxT2RnYmFpbmNqL1pC?=
 =?utf-8?B?ZWRMN25XcU5pb3pWZENSaTcwQVBJQjBaWndGUWlhS1hWMm5BQndmWmY3eFdt?=
 =?utf-8?B?K24yNk5yQ21pSHRGL09NZ01mMVlldEpTL0ZocGNBYzdlZnFuanFqUDdndzlv?=
 =?utf-8?B?eVpsZGowWGdhMmhQV3E5WXZHMjhyZ05raGZHMEZOT1lvZnZiOEhCRGpMWkVZ?=
 =?utf-8?B?UFlzdithcFRxZEIwdjJJaXhiR3FkRFJPN2krdEczalB2SmJ6b3o1R3dsQUtH?=
 =?utf-8?B?KzZ0RkYyZmVGTTI4amdDOHhRdDB5THM0bC94a3hYdW8vZGZTWHYvcldoazlm?=
 =?utf-8?B?SHlWaTVYMm5GM2FuclRtUzBkMTNKWHdFNU9MTlBmdzdUbERWTWY2NmROYXds?=
 =?utf-8?B?ZXNMMDNCaHl2YlZDMStnZEN5MVpLWWM5YmFhM0NrVHNvVXpDb25HSHQ0b0hz?=
 =?utf-8?B?a01BZjNQZlRwbUpPanhFaHV4Ymg3ejFpVDlNLzNkc0lobi9USXZUeEdaSDdD?=
 =?utf-8?B?UkpWSG5nMlpJdGZZcEYxdGdyak1qVEpiS2NjaWhwcXdtNWRCMDdlVGpLYk1k?=
 =?utf-8?B?Ry9OZ2FKNUpPa1J4UzlpNlhkck1ac2hDOHdXSHEyZlloM1lta0YyQmU0VjdH?=
 =?utf-8?B?Y3lCa1pRZExDUnpjSXVIYkxQa3RvNlZncTZnbmVJWFdGZEN5YmdlTzc1OGZU?=
 =?utf-8?B?S2lGUzJHMFRrUkFrWnQ3WmY5TDgzZG5iNFlFUTVIVG9FRVliNHJqWFBHS1ky?=
 =?utf-8?B?bDh5WlhHeTk2N0lHT1lsb01IQS9GaUp3RWVBQ0VaODFYeCtRM01mMnBEUitY?=
 =?utf-8?B?Zk5xbVM3QlRqcDNUQ09sZzhxK0lZaVJSeUY4ZHI5M0tUU0NjSXBtQ0hGZkcy?=
 =?utf-8?B?QVRqZkJ5ZDg1NGJzTFV6MEVlamQ5ZWdsaEhkLzAxak45V1MwNWpGM1RxOE1B?=
 =?utf-8?B?RXloVk5WbVBxb0liRjFkbm1COHFZQWk4aEh4eXpsTE9GQ2hQWThYMXJzVEYx?=
 =?utf-8?B?VExuWE80Ync4YlorWGFPWTh6M3JodzJMT0hVMUZDdWYvZGE4MkVRWGE3ZDgx?=
 =?utf-8?B?RDEvN2F0dklVcTRUeE1CRHRXbUcxdjJaa25rWUorWUlLWGdIQU9TSlIyaHZv?=
 =?utf-8?B?OWF5QmxFVVJkQ0NXcE5KVkZBbG15WDBCZi9WaTRvbXpBUEViR0xFamc3eit1?=
 =?utf-8?B?Wm1jL01RdGZQeXNCVjVrWFdibktMUEc4MklMNGpiT1BhRkNnT25TMzFpMEtv?=
 =?utf-8?B?TlltdkdjbWxKa2pMNnFTeDQrRktwM2ZVUUxzRmdaRGJyWEJuM01zUnhJYTNy?=
 =?utf-8?B?WDYxMy92NFBRV3VQUnkyYVZEelZ0MUl3OUZtYUVwZjgraS9uSFpKbjRwbkhU?=
 =?utf-8?B?OFFyWW5BdC9ib0xYeHc5aHhKWjVQemhHNm5WdElsSGpKckRHeUZ2NGR6RnAx?=
 =?utf-8?B?Z21oa0p3NnI4eUEzTXpWYjBWUUpGVEZuYWx3WVBsS1JHZGVEZlpLNTFiWnVh?=
 =?utf-8?Q?CKTKneJ/rNpdkAX2QEd27qR8Y?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 65117426-e1a6-4a0d-5e84-08db89878bf2
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 01:12:26.5571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WYM7GTiBI5jEndkbX5Jed5tePc65HhaeQj06Zl22VhBt0lyruWhpgJN8bawCBI5ek9A1FZMS49ek0XSbV3uUIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5106
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/21/2023 4:51 AM, Yosry Ahmed wrote:
> On Thu, Jul 20, 2023 at 5:03 AM Yin, Fengwei <fengwei.yin@intel.com> wrote:
>>
>>
>>
>> On 7/19/2023 11:44 PM, Yosry Ahmed wrote:
>>> On Wed, Jul 19, 2023 at 7:26 AM Hugh Dickins <hughd@google.com> wrote:
>>>>
>>>> On Wed, 19 Jul 2023, Yin Fengwei wrote:
>>>>>>>>>>>>>> Could this also happen against normal 4K page? I mean when user try to munlock
>>>>>>>>>>>>>> a normal 4K page and this 4K page is isolated. So it become unevictable page?
>>>>>>>>>>>>> Looks like it can be possible. If cpu 1 is in __munlock_folio() and
>>>>>>>>>>>>> cpu 2 is isolating the folio for any purpose:
>>>>>>>>>>>>>
>>>>>>>>>>>>> cpu1                        cpu2
>>>>>>>>>>>>>                             isolate folio
>>>>>>>>>>>>> folio_test_clear_lru() // 0
>>>>>>>>>>>>>                             putback folio // add to unevictable list
>>>>>>>>>>>>> folio_test_clear_mlocked()
>>>>>>>>>>                                folio_set_lru()
>>>>> Let's wait the response from Huge and Yu. :).
>>>>
>>>> I haven't been able to give it enough thought, but I suspect you are right:
>>>> that the current __munlock_folio() is deficient when folio_test_clear_lru()
>>>> fails.
>>>>
>>>> (Though it has not been reported as a problem in practice: perhaps because
>>>> so few places try to isolate from the unevictable "list".)
>>>>
>>>> I forget what my order of development was, but it's likely that I first
>>>> wrote the version for our own internal kernel - which used our original
>>>> lruvec locking, which did not depend on getting PG_lru first (having got
>>>> lru_lock, it checked memcg, then tried again if that had changed).
>>>
>>> Right. Just holding the lruvec lock without clearing PG_lru would not
>>> protect against memcg movement in this case.
>>>
>>>>
>>>> I was uneasy with the PG_lru aspect of upstream lru_lock implementation,
>>>> but it turned out to work okay - elsewhere; but it looks as if I missed
>>>> its implication when adapting __munlock_page() for upstream.
>>>>
>>>> If I were trying to fix this __munlock_folio() race myself (sorry, I'm
>>>> not), I would first look at that aspect: instead of folio_test_clear_lru()
>>>> behaving always like a trylock, could "folio_wait_clear_lru()" or whatever
>>>> spin waiting for PG_lru here?
>>>
>>> +Matthew Wilcox
>>>
>>> It seems to me that before 70dea5346ea3 ("mm/swap: convert lru_add to
>>> a folio_batch"), __pagevec_lru_add_fn() (aka lru_add_fn()) used to do
>>> folio_set_lru() before checking folio_evictable(). While this is
>>> probably extraneous since folio_batch_move_lru() will set it again
>>> afterwards, it's probably harmless given that the lruvec lock is held
>>> throughout (so no one can complete the folio isolation anyway), and
>>> given that there were no problems introduced by this extra
>>> folio_set_lru() as far as I can tell.
>> After checking related code, Yes. Looks fine if we move folio_set_lru()
>> before if (folio_evictable(folio)) in lru_add_fn() because of holding
>> lru lock.
>>
>>>
>>> If we restore folio_set_lru() to lru_add_fn(), and revert 2262ace60713
>>> ("mm/munlock:
>>> delete smp_mb() from __pagevec_lru_add_fn()") to restore the strict
>>> ordering between manipulating PG_lru and PG_mlocked, I suppose we can
>>> get away without having to spin. Again, that would only be possible if
>>> reworking mlock_count [1] is acceptable. Otherwise, we can't clear
>>> PG_mlocked before PG_lru in __munlock_folio().
>> What about following change to move mlocked operation before check lru
>> in __munlock_folio()?
> 
> It seems correct to me on a high level, but I think there is a subtle problem:
> 
> We clear PG_mlocked before trying to isolate to make sure that if
> someone already has the folio isolated they will put it back on an
> evictable list, then if we are able to isolate the folio ourselves and
> find that the mlock_count is > 0, we set PG_mlocked again.
> 
> There is a small window where PG_mlocked might be temporarily cleared
> but the folio is not actually munlocked (i.e we don't update the
> NR_MLOCK stat). In that window, a racing reclaimer on a different cpu
> may find VM_LOCKED from in a different vma, and call mlock_folio(). In
> mlock_folio(), we will call folio_test_set_mlocked(folio) and see that
> PG_mlocked is clear, so we will increment the MLOCK stats, even though
> the folio was already mlocked. This can cause MLOCK stats to be
> unbalanced (increments more than decrements), no?
Looks like NR_MLOCK is always connected to PG_mlocked bit. Not possible
to be unbalanced.

Let's say:
  mlock_folio()  NR_MLOCK increase and set mlocked
  mlock_folio()  NR_MLOCK NO change as folio is already mlocked

  __munlock_folio() with isolated folio. NR_MLOCK decrease (0) and
                                         clear mlocked

  folio_putback_lru()
  reclaimed mlock_folio()  NR_MLOCK increase and set mlocked

  munlock_folio()  NR_MLOCK decrease (0) and clear mlocked
  munlock_folio()  NR_MLOCK NO change as folio has no mlocked set


Regards
Yin, Fengwei

> 
>>
>> diff --git a/mm/mlock.c b/mm/mlock.c
>> index 0a0c996c5c21..514f0d5bfbfd 100644
>> --- a/mm/mlock.c
>> +++ b/mm/mlock.c
>> @@ -122,7 +122,9 @@ static struct lruvec *__mlock_new_folio(struct folio *folio, struct lruvec *lruv
>>  static struct lruvec *__munlock_folio(struct folio *folio, struct lruvec *lruvec)
>>  {
>>         int nr_pages = folio_nr_pages(folio);
>> -       bool isolated = false;
>> +       bool isolated = false, mlocked = true;
>> +
>> +       mlocked = folio_test_clear_mlocked(folio);
>>
>>         if (!folio_test_clear_lru(folio))
>>                 goto munlock;
>> @@ -134,13 +136,17 @@ static struct lruvec *__munlock_folio(struct folio *folio, struct lruvec *lruvec
>>                 /* Then mlock_count is maintained, but might undercount */
>>                 if (folio->mlock_count)
>>                         folio->mlock_count--;
>> -               if (folio->mlock_count)
>> +               if (folio->mlock_count) {
>> +                       if (mlocked)
>> +                               folio_set_mlocked(folio);
>>                         goto out;
>> +               }
>>         }
>>         /* else assume that was the last mlock: reclaim will fix it if not */
>>
>>  munlock:
>> -       if (folio_test_clear_mlocked(folio)) {
>> +       if (mlocked) {
>>                 __zone_stat_mod_folio(folio, NR_MLOCK, -nr_pages);
>>                 if (isolated || !folio_test_unevictable(folio))
>>                         __count_vm_events(UNEVICTABLE_PGMUNLOCKED, nr_pages);
>>
>>
>>>
>>> I am not saying this is necessarily better than spinning, just a note
>>> (and perhaps selfishly making [1] more appealing ;)).
>>>
>>> [1]https://lore.kernel.org/lkml/20230618065719.1363271-1-yosryahmed@google.com/
>>>
>>>>
>>>> Hugh
