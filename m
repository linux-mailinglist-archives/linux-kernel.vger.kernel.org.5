Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E46007A700A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 03:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjITB3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 21:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjITB3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 21:29:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61CFB3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 18:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695173370; x=1726709370;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=E6wkjrVzOixPQGeWFIBC6QanyAAhVUERR3Ey5F2aXvw=;
  b=MSuMR9Qo8Ntq7HkEX7cLk9vuwdc5xiM0tjNX+PZvD/R3NbQlltXJ+N3B
   0O06bzImzUI6HWoqlR2/9n/VoWnqpcPHO9HBN20NvX3R841KJsbC9lTvY
   FUUZqsxekcJCeDrOen5/VRcdedbLiHPhvlob9cJTPDSD+l6q3A/soz4XG
   A2RNhaAEmSzoGF731uSHiZn6wU3LFjih4WG6SaCaFcszApy1F50pqZnQv
   TTTZZhmSX2mKsrQ+L0TF/wXSWPyFm+8WEClDR3iy52+lX3KE1kvylIo+X
   cYbqIMM5uRzo78s+C7AF7BCLFzyM80E6qsZmfB8SFXqLD0Qmn5WXwuTo2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="466413300"
X-IronPort-AV: E=Sophos;i="6.02,160,1688454000"; 
   d="scan'208";a="466413300"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 18:29:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="739981329"
X-IronPort-AV: E=Sophos;i="6.02,160,1688454000"; 
   d="scan'208";a="739981329"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Sep 2023 18:29:29 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 19 Sep 2023 18:29:29 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 19 Sep 2023 18:29:28 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 19 Sep 2023 18:29:28 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 19 Sep 2023 18:29:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QaEtXnZoxShDEdGd6VDN7AIo3E9V+rNi0/p8j5e2T1Ip6nvflosn/lRjRNDbLUQdk6Ek5iMRRUv1bHtO8di8VBRBr/aMdo9xsXgTWOVHTAb/bt3JddXNv7zKM9qfBADFDdZpapf8BnSHzgxw5VjNA3G8ZJ1eDtZT7ZyFhWCz65pxN9/YN4yCLbZrQP5u+mzGBPcb22ODvc0Smh5sgf3/2kNYOx0YT1+fj3/dyPx4biVgbqzxFjVWhur01DKInHJ1HYBmT/jUDhBilWeZEU2gpbGoo/B836vTsLw3PQKrQlZAqGkO+bbz/005dBWgCo89jaURrspmBBjTCfHjoaF7+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RuVBUOVGbom2lMqB5Abyv92i811LiAeZDWqijjvUeJ8=;
 b=QLmRfhasgegNv1MV0jVlu/HMW/TLvX6uOMiE8BYk+HDEmaEsdfnAqs9nHypGX9iT/BzDxaBAB+vtpYLr6THRczcLkz7UW/zCeJ6GfBVn0WHX5qEre958cM7o42mnOYeGd1A/IE8xPO5W4Lu2Cvgv/Vh33P5iNdNFmxDhxADH4+7IEkNnCIE53RuYc8XrW0OBgOKUHLNkPXbEHbyaDTBS2w14crCvcFpYf9Ui5Qb+OzKY6+DyYE1SkotLQY05b2JgJrCPWoeADUxB30TvIol+XetSGFigEnQ2kYe87ODaDzdsWOCLi6kiflGVnYWQkoKHxu1eccq4/XzTwyckFq3CTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by MW5PR11MB5883.namprd11.prod.outlook.com (2603:10b6:303:19f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Wed, 20 Sep
 2023 01:29:26 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::2846:e5f8:b2e8:1da6]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::2846:e5f8:b2e8:1da6%4]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 01:29:26 +0000
Message-ID: <2897a87d-ce56-fa40-8195-6e9c1a9de6a4@intel.com>
Date:   Wed, 20 Sep 2023 09:29:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [syzbot] [mm?] BUG: Bad page map (7)
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>,
        Matthew Wilcox <willy@infradead.org>
CC:     syzbot <syzbot+55cc72f8cc3a549119df@syzkaller.appspotmail.com>,
        <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <syzkaller-bugs@googlegroups.com>
References: <000000000000d099fa0604f03351@google.com>
 <0465d13d-83b6-163d-438d-065d03e9ba76@intel.com>
 <ZP8VcUIXTjvR3z54@casper.infradead.org>
 <f3379aeb-f394-8c99-5143-f93e82400320@intel.com>
 <ZP9D0q5MSVFobNbZ@casper.infradead.org>
 <fb936bdb-6473-a956-8431-fe95f5940acc@intel.com>
 <ZP9mla26MWqKKUZ7@casper.infradead.org>
 <092a9bb2-727e-5849-fa4f-18535b998efc@intel.com>
 <ZP/wLVg1JCvhaEKm@casper.infradead.org>
 <97e59c09-30c8-038a-a6f9-3d862a0d3ede@intel.com>
 <381e4ccd-47ee-955b-f7af-fe192bea0cd4@intel.com>
 <f40677ee-8b8e-b719-24ed-662c219c6989@intel.com>
From:   Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <f40677ee-8b8e-b719-24ed-662c219c6989@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0138.apcprd02.prod.outlook.com
 (2603:1096:4:188::12) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|MW5PR11MB5883:EE_
X-MS-Office365-Filtering-Correlation-Id: 46e4fc0b-21a9-442c-f8c5-08dbb97906f6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Eyo0qedQZumMmNRA26Y1T7X8fezw/cF4pd7SPtZ4Cry9qI1MQpS9tx9yoVl5E/NS5ELqrpGtsVHw5Z7B/2gRbHJA6O1OV3xcTsmN3MV6qEJe6qxilH+BQ47rt5ulVrYRCSeLnHghLWYxbD5Jld8Bqpg1i2jeCqpO+tCi4NRhuKGBdPU3U5fTp4eMCv/NSKwB0vG5bLPciXXDzIiNdaLSAY0L43tjaeKKue8lNnBu2tu9cEvxlS2Hp//fS9acBUopPakLji73AKcn7Pjwu/4rAw8j4DlHrxUEoX5tWCQqIx7hgq+rG/Co0fI11RflSXm/0PX9yWv36t5KoR+4GwxA6qMBawkuQ916ED2FDFtZr0RYROKEnjcSxcG+UnSdQDKWBS0w5f1Wxu4AxaU60t6yiltO/V43FxZEAnDfOLGmlo9WSNtWGJj6SV4bX3i1CaAnEHDowz7e2xLHZ7EFhAntMi/k75DkK6g4BjBNARnL/PYcqdVmxJ3sCu3PuIMDNiDX2LQKn9yfr5JrQg2PJcCr6e2c92MFBUxvb4/OvA0egdtYrgqMZf6Unf4XPT3Ov8jY1kukPftQueYDD32EaVoZW+2WQG5kkpTMG1zoVsB2t6RN0t0sWfujJl0mmAnPUqZl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(366004)(346002)(376002)(451199024)(1800799009)(186009)(6512007)(53546011)(6506007)(6486002)(6666004)(38100700002)(83380400001)(86362001)(82960400001)(31696002)(2616005)(36756003)(26005)(110136005)(316002)(66946007)(66556008)(66476007)(41300700001)(2906002)(5660300002)(8936002)(8676002)(4326008)(31686004)(478600001)(966005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnBmZERXbVdEWjE3NzBGSzRGZXp1eXgzbUV5Q0FqZHNDWTlWZ2U2dEtadDZL?=
 =?utf-8?B?OTNCVnZLNGJSOHJsSTZvZ25SbjRiQUd5TGQ4YWxRQ29XRG1DaUZXbHRncW5n?=
 =?utf-8?B?eDZ3VU1lVmFEbzFMUUNlNHZpUk5PUmlsYkUxVUNQemhUK3VWck02N3VmaUQx?=
 =?utf-8?B?WmF4Q2ltUTlTRzh1WnFnZjAvK2FVay83UFdDbHFINytBQzluNUpyUlROQWtV?=
 =?utf-8?B?azRBdEE3LzNPT3NGUklWZzdDaUc3YmF1NlUxL2l1NXZpUXl3U1VDTmNrWkdE?=
 =?utf-8?B?aVVFNTQxM0xVWDhEVHZhNmVNV2ZCUE9ORWhvRWNQcWtBSzhjUS9RODIyNDdG?=
 =?utf-8?B?eXNhZXZFVVN1Tkp1VkF5d1pORlN1b3F2Q3FpRTgrY2UxRXZQUDM4bmdLUHVU?=
 =?utf-8?B?QmxDM3Q5UG5sVVY4SktqOGIxVDhDUFhvdlNRYS9ydTNLMEhjaW8vZEZROS9N?=
 =?utf-8?B?NzFoSElCMGdYSXNXNDd5SXRFZVh5Y0JtNzJWTnpCOUgvbmQvejNkSjFuaDZK?=
 =?utf-8?B?Wmx6QnJ3dWZSOVo0RUpTYzEySWV5M0FDYkZhRjArYlNNL0Z1cU8yL1VZZXJP?=
 =?utf-8?B?bTAwcEJPN3lqWkI2b1RKcG5rN2t4NW9WMThCMnp4ZkhFbVFsUnN0TmYyOXBX?=
 =?utf-8?B?cmRhc1ZhMHdobXVJZlJ2ZTNyL0U0S2FGbmVCNGdpeDVPSnlmU05qSTJNSUZ5?=
 =?utf-8?B?aHh4WEtyYWptbzFvMUV1N1JKUXdIMXZybVAzK05DUWYydlMzR2xMUkU4OGJ1?=
 =?utf-8?B?UlkrUjdHdWFubURkMHdDS05xWVQxbWVZZDVDRVlCUEhLQjQrNlV3Yy9UTXVy?=
 =?utf-8?B?bFA5ajBDeG5KclpsU051YnBSS3p4Qnc2SUVBL2xzMHBTb0hsVUFUVDVmRW9s?=
 =?utf-8?B?VEF2QVlYdjRhZ2tGa1ZoTEwxNGhMdUtKUGp2Vk1NWXJHYWZiVmFsZS9KNVVR?=
 =?utf-8?B?L2xtZ3VSTVpRVEZKdkw1V3pyR1kzaXYzMDFaT0hZNlJ2eUFXNmtKa1ZiOEJP?=
 =?utf-8?B?RVJiSDh6dTNjVGpaMEN2WHRXNXdBTmJ4cW00cmJJMDBoQ2pmNHBLN2N1TllD?=
 =?utf-8?B?QldTNTJwd1Zoc3V3VjB1bXpMQUhCWUQzaDg4M2ZrQjY3bHFPYS9Qa1U0dU4y?=
 =?utf-8?B?WmZLQXlHN2JWSVBzSGhLL2VLdkU4TjNQaytvWmpjZ0taWnkxazFpZlZwUEha?=
 =?utf-8?B?MTE2QmZoS01PWEh6RVFPL0wxZzd0NE13aEpKejZnZGpsZUlBUStQdWZtSWhS?=
 =?utf-8?B?YnEvTlZwNXRFYkZhVFBDNVZ6NlBPUG91NGRzSFB1V0x2WFY4WDltd0pLb2NU?=
 =?utf-8?B?WnE5ZFFqeVNOdHhGZVlQZ1hERUVkdzBTTEdxZnF5bTZFV3B5ZjJXYTNCRklW?=
 =?utf-8?B?QkgvMkNVemFMTEFXTFJvSjZUenJIaWVzWjhsMmoyNTBFZDlOdldWYkZPYm5u?=
 =?utf-8?B?OHBTMkJzSXlEMXhjeEUwVG5zUzU0NmFQMHF6UUhDaFVuMlZod1FUVzg0M1Nz?=
 =?utf-8?B?WGVrMW5VV01xc3pOc2RmaVV4d0lHMDVSeUlNbEZtaHlZeVlSYnRSWThudDU1?=
 =?utf-8?B?WFJJc0NNeFNRK2QzRTV1cnlDdlh3TTZHT3ByZUZhbGdTQU9zeDZWQVd6aUY1?=
 =?utf-8?B?RjN6TE85aHRIR0JHRDJTNmJkQkJTdlRzaHNPY0pZU3FYYlpJSS9lN2sxTDZs?=
 =?utf-8?B?enlRRkZ0NTBrOEZVbUh6NWQrN1JDUi9hVjZFeElrNHVONGJhMlNxWmxGS0Fk?=
 =?utf-8?B?OUEzS0taSVRFb0d0YjRPaHNzVmNTMGRnOTl5R3BZb2NaUHR0U0o3eDRrWnh3?=
 =?utf-8?B?MVVJYmtQZ2lWMXI3dmROUnZYRTg3REJTb0Y5NXdQSTEyS2lOODVtYWRoRHp6?=
 =?utf-8?B?RmFybjdQWDgweXBSclhpbXp2UCsyOXJuOW1mMDh3bUJiNnp4RWJkQnRpc2ww?=
 =?utf-8?B?dmRKc2JYTml1MDUwVmEzcEk4OWo3a0hFZE1FNk1IZ05qRnF6MFZZRVZqQUpo?=
 =?utf-8?B?emVDUGhTV2wwMmROQXEwRGVOMGNMVk9icWErMmdycnlMTXV5L0xmYTczbG02?=
 =?utf-8?B?VW9PMXMrM01TOEVlYjhzeVNDMUpSa0hBS2Vpd1Brd2Z1ZHNDS2x5WmR1eE1s?=
 =?utf-8?Q?3vzO8kjCXOvbORHGpUgRtSEnL?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 46e4fc0b-21a9-442c-f8c5-08dbb97906f6
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 01:29:26.5058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jhuuE6y+wlns4GahGkZejyyhUVIoj1MmhYA7iW+55ORzAqC1DAYl9IyBa7qUz3GnzxDhMRDXgYvZj7vRvSAIGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5883
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/20/23 00:11, Dave Hansen wrote:
> On 9/18/23 18:11, Yin Fengwei wrote:
>>> I will find a test machine to measure the performance difference of these two
>>> versions by using xfs + will-it-scale. Will keep you guys updated.
>> I'd like to move this bug fixing forward. Based on the test result here:
>> https://lore.kernel.org/linux-mm/124631ab-eb4c-6584-12d4-f3c91e69c873@intel.com/
>> There is very small performance delta between your version and Dave's.
>>
>> What do you think if we propose to merge Dave's version? Or do I need collect
>> more data? Thanks.
> 
> I honestly don't feel that strongly about my version versus Matthew's.
> I like mine, but I'll happily ack either approach.
> 
> The thing I care about the most is getting the bug fixed ... quickly. :)
Same in my side.

Regarding the performance delta is very small, I thought we should follow the
commit message of 6b28baca9b1f0d4a42b865da7a05b1c81424bd5c:
    The invert is done by pte/pmd_modify and pfn/pmd/pud_pte for PROTNONE and
    pte/pmd/pud_pfn undo it.
    
    This assume that no code path touches the PFN part of a PTE directly
    without using these primitives.


Regards
Yin, Fengwei
