Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 041C07642E2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 02:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbjG0ARg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 20:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjG0ARe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 20:17:34 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542001724
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 17:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690417052; x=1721953052;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AvtGdEOmHCn6rU44l0vVQ+PgrDdIVU2Mn+oqcYxPM/o=;
  b=QQbzP3xDq8pn3k4RLA2zFFC641wxt2HA6oQH3OQmasMDRX1DHWaxXPVt
   Wju+bLlKgeAMvSMuYPvyvPj0pscBz6PRlTrcnc0xwOqzAB4sLcF3WGBf6
   FP3JrUvfUOnP/pN7hF7r/RmSs3j0SFj19EkRSglrvCcVxa9r55+Ko2+lD
   bsBJdDxyY21YCT4+LW9Ik3Fcl63cbJWOqVG4HDaQIiQsEVVwWPRA7kGVK
   YvEy1gOD9qrPRjE7zxtnXpR+7BtIZGKdaj/+JDZ7ICBGl6WH1uSV/7Rx9
   g+DUNG7rdA8U/qvx1/rVSV/hd8qAj5zq5obOR98iuDp61+FRYOiOM4FSZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="365625876"
X-IronPort-AV: E=Sophos;i="6.01,233,1684825200"; 
   d="scan'208";a="365625876"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 17:17:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="726729071"
X-IronPort-AV: E=Sophos;i="6.01,233,1684825200"; 
   d="scan'208";a="726729071"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP; 26 Jul 2023 17:17:31 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 26 Jul 2023 17:17:30 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 26 Jul 2023 17:17:30 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 26 Jul 2023 17:17:30 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 26 Jul 2023 17:17:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cjzkihzXA9qOOV3rM2OTWqbgR9+nlOasuTor9bbW1BU1t+rSfCVJqjdkqzQMsHNNceWGBCx65kI5vsxwoXoLiGpSS7AlSQAWSVc+8eJYUJLUDOnMTgEOOaDWvYKEBl6kA3pdfNGhUwf7aQ166/SJhzFnvUSpT8zxjL76If+XnrNTMSiT7JBwz9ZTEcD5h2G7eECR9bXxi2dJ9hhy0lL2N1+XWBVctXxxtupKH9EFC2JDqlwvl1xe531B9Je68PhSiwkrE1j10qnCuuD7FBDXVpGtjEOo6xti0GuUhPC91zvY5Jq34FPqSa2B1hFn9BTF03bhK22lqPVNMBMXXzChtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YmTn0rMPuOGF4L79zGKy2vWAz9ZDxHhxe3H6Gp0gS0A=;
 b=T1Bm316Xwdgxqyq0rOXnvTd4OCB/gphY5mVOScY9icYFJwCPUlyqQ8ZDmzcbAO8HkqMYn8VNmW1/hk4HS7QYIw1thVFS0KL2sGIL/NIR8s7ymYZ3cC4oIqK055tdUNil/N2elD+ab9gc3NgA+LhjIMRg0fa2dwf1LbqfxMp7DOByQ9HpnX+6TzxjP03yJMwrlEPAijLYCCFa0sic2dNgwZRnuzFa9i5UlSHpBJnwhkjY317nPdwpIuK25z1AIMnAEWR3py+RLf8rOGhDxgTzCZUAJm1aPJ3F+1M791eqv2W/c9XGLINafMLIp867oO6dtwwVdTMqi1/on2mMnE71rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by PH0PR11MB4984.namprd11.prod.outlook.com (2603:10b6:510:34::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 00:17:28 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::f4df:c85c:6300:880e]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::f4df:c85c:6300:880e%5]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 00:17:28 +0000
Message-ID: <9fab7476-6ec8-cc6f-dd24-e8e52b200f08@intel.com>
Date:   Thu, 27 Jul 2023 08:15:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [RFC PATCH v2 3/3] mm: mlock: update mlock_pte_range to handle
 large folio
To:     Yu Zhao <yuzhao@google.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <akpm@linux-foundation.org>, <willy@infradead.org>,
        <david@redhat.com>, <ryan.roberts@arm.com>, <shy828301@gmail.com>
References: <20230712060144.3006358-1-fengwei.yin@intel.com>
 <20230712060144.3006358-4-fengwei.yin@intel.com>
 <CAOUHufYef--8MxFettL6fOGjVx2vyZHZQU6EEaTCoW0XBvuC8Q@mail.gmail.com>
 <CAOUHufZ6=9P_=CAOQyw0xw-3q707q-1FVV09dBNDC-hpcpj2Pg@mail.gmail.com>
 <3bd7b290-91ad-347f-b1b5-5d45ac566f69@intel.com>
 <CAOUHufY_b2skiEXSukpOLnpbzrifFiwxY8HA0W_z9aZbVome4Q@mail.gmail.com>
Content-Language: en-US
From:   Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <CAOUHufY_b2skiEXSukpOLnpbzrifFiwxY8HA0W_z9aZbVome4Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0053.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::8) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|PH0PR11MB4984:EE_
X-MS-Office365-Filtering-Correlation-Id: 600545e7-e56d-4f03-d1ac-08db8e36dbf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ByqW0XZ1HOScFi/efMUjHdh25AmumYpZOI/ZNVnmYRGqwYflaFHGfgxswBgUN/KWSNMFG5WL3vKDAHJMzmZrtd63NScA/ylNHUyUJ2Ehz/lqdCMVqRcFBz814F68igvj36CcAFmNhM5ikI1E2RpqOt+R5B1Ep/XeQ5E9/PACb4IM9oz+GI84qgDTSAD2x29i36dH4z4Wa5iz8OCYiQJRBX1vZr8Lbwaj/r7Pjs6H0anyRJ6Ep3aGUIFyPig5Vgb+NdLBHOSHLr9LVeqexVAVVr4HESfP6vdRWBB0gLp4CPQW93Bt6isnbNwZLjX0m5q6Ys1VwJ3p48dAFbe3RAyX78nYrAN7PtywqGXudgnRUvYhTH2xMSKKwRy/VLcJ/4vg++nnyybhwgGaoozZ0LCl4aa+eAhCuireABlCNDi1Z0NmDnkZFMT6JwEi55FnkFIQR/QXglPMXFu4p+WGBtuMBst3pMInIl/OT+7mf6VzHJmMC4GzYKlg5dQZ3ALvKy82xNfd3sprAmLKSmOWQU9TnhVuHR4HGGmhqp6XIy0UgwZhiyjLBUzo/Wc4aN/NeAMGsjLTuMT0nBGJ7goBJUL4xdaLgx89W3FvRW6Fky2M7fxjqEYlvSxqDjVADXlQK2nbDf98jCoKP5U2BLcpqk9KuQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(136003)(376002)(396003)(346002)(451199021)(15650500001)(2906002)(6506007)(186003)(26005)(316002)(38100700002)(2616005)(53546011)(83380400001)(41300700001)(5660300002)(66476007)(66946007)(66556008)(4326008)(8676002)(8936002)(36756003)(31696002)(86362001)(6916009)(82960400001)(6486002)(6666004)(6512007)(478600001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGd2R2orc1Y0WjkzS08rcnlzdTBsS1JwbjdjdkJvRU5QMC85UkdzaUd1Q0Vw?=
 =?utf-8?B?aFMzbHVnMjVUM00wT0JNQmkxRHFsVUF3QlFzK1NlYmI5Wk43b1p0SmlaYnc5?=
 =?utf-8?B?NkpiVlBrUHIwYmFTSnlaTTJHUEdQRzdqRkJJd0dkdk81YnpBWVdiMW1HUEN0?=
 =?utf-8?B?ejU5U0hQbDhXUC9oTkNkdGFIK3FQbEhVSUZWN3Aybi8xK09MVC81Y1kzY0w3?=
 =?utf-8?B?QnpXSU5ZS0tIbllBVklmKzdJWGkrOWkvRDFXNERxM1E4R3NwVjFnVStRcXZa?=
 =?utf-8?B?Y0ZrUHBlZEg0MkpXS1k4ekVpL2lWWVVlSGZmeXJaaG15UHFkTE9Vei9SQk9I?=
 =?utf-8?B?STZqQXhCL2tFTk5aQXlKbnFycURUdW0rMlB0clpaQytKV2lKWEZ1WVcvOXBz?=
 =?utf-8?B?YUsxcTYrZTYvaTF4aE9QODJlSmpVczhvOW0vYUJ5VnYrK0QyN0lXWTh2N3Fz?=
 =?utf-8?B?bVFUVksrN3N5U3lwdlYyellSWDJ6LzJDaEh5U0VKdnp4SXRQNStmVFUzMkk3?=
 =?utf-8?B?aVB2M01xMTBwZWVBSEFUT0l2aFRrdWpiWE9FTHlOenVnL3lrYUREMnZ0YUx2?=
 =?utf-8?B?UmJoME5sUlcyelNLOU02TmVuZ0JXS2lLN2xvUVpNRGJwNTFrSDdIcGhVVGZO?=
 =?utf-8?B?SjkzaXV0ajRDUDFiNERXZU14R3hUTWZPak5jQTVJWDY4VEt5eDFIa2JpMGNE?=
 =?utf-8?B?VVFOUGQwN0RkeFpDUW9ncGtZQTZFc0J3TEhBMnFCNEIvRHUyd2FCTmFQaGVi?=
 =?utf-8?B?OEp6VjdQcU9vN09vTGlzM1NwZnlKbkliNm9oOFVROGlTZlJXWU5id2FJRkMw?=
 =?utf-8?B?VmVNTThoZXBNZHJiYmo5K090YXl1MTNLWjBMUEVqSzhqaVcwRzFqMVU3cEF6?=
 =?utf-8?B?d1gwbUw1dGliR1hFVTJabXlNUy9SUC9hSlR1SVoyT3d1ZnVxdk56eUljT2Fr?=
 =?utf-8?B?WVJGdUhHbmN4K3VZK1BjZVM0RWlpbThzT1E4d1ZnYjl1ck5qaFBYMVZzL3Ru?=
 =?utf-8?B?cHF4SUF6Qk9Nd21zM1dqMzEwdlc0aXVUbzBLSHhqTDdmQWc5MEVHNUorUVFh?=
 =?utf-8?B?SXc2NWtaY0ppVmZlVDdCdUVOa1NTditzaDlKTldZQ2w5K2hiamMzd2JDNWFm?=
 =?utf-8?B?Nmo5NGUrbW1FN2NjZUg1S2RvTWEwMktaL1FFVk9WWk9yWk1SM2w2MHJQdEpQ?=
 =?utf-8?B?TTZldXVSaThVY0EwSHlxOFlNWUNUcmZscno4TklHNnFuVnpicXo3bXlCRVVR?=
 =?utf-8?B?RTlqREhkWlhHWXV1TWYvWE9RcW5weDN3STh6Tkp6UlhRK2ZNY0ZPMnVaaGdy?=
 =?utf-8?B?bi9OcHVzWHkrU3k1QS9qNHozMFB0b3REWUpWbFZRYzBCUUJwOVhkMzBOWUN1?=
 =?utf-8?B?Tk9tbVpxcEFPblczajVnbDJ0Ly8wMHAvTSs1Ni9sT1M1MVpBVm5lV0NqUHps?=
 =?utf-8?B?K3dmRlMwUEQ0TFhHMzFWaDdMaHozTk9nd2x1cjBqL09qV0JnMFlZdEJrZUJ2?=
 =?utf-8?B?dU4yNDZSeDN6a1AyR3BzenA5U0wrRzlrSnFhUWg1QjVnYWZ2ZXdoSVBjRmor?=
 =?utf-8?B?Nk1BQ2JqZUJrQmhYRGQvRTdKMkRtSnFiYWErUzlzWkhiOGZ4ak85aERpWlBU?=
 =?utf-8?B?bGxFMXUvbWZVU09aaEdndWgybnMvTEo2N04zV3FJVitEQ2VoNnlGdmhaSFpk?=
 =?utf-8?B?aG9KeEZHUWtpSmIvSUR2Szk0ZWxJdzFJMFk3cmxjdU56YnV1aDJBNzNzNVlF?=
 =?utf-8?B?QmZuOEpxeDRPS2hDOFhOMk1TcDRWTGdKb09WMW5JSnZxMExiZGZyRzVJZER6?=
 =?utf-8?B?M1pmWmtsSG9GTm9QbVJqa1JGUnYrZ3dvQ1J6L0VVS2dOYkJyNmRUemxvczVv?=
 =?utf-8?B?RGxnUkc5bDNSdUNrUkRZZmZta3JrM3VOT2pSaW8xektCcEJDbndEVHpTaURl?=
 =?utf-8?B?Q2hsMGxBQ3kxc2N5STNRMGN0ZGxuZXhjblkvWUFjWmZPNDFaK0NwTm9YVGdM?=
 =?utf-8?B?VTJZaXJEMnh1c1pDNFB6YkpQUHJmTDJWeE1tWXA1Yk9jS2RmL2pPLzNKdzZs?=
 =?utf-8?B?Y3pxU1V5M09PZm50YzkrakNqbDdOL2p0K3EwVHZhN0pVTm1VUU5YcklrL0di?=
 =?utf-8?B?T2tPcVJ1REZ0dzYwOCtqNFRxbmFtbHhkUGZmdnJMWjlaZ3FTdVZvdzQxb1Q3?=
 =?utf-8?B?Wnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 600545e7-e56d-4f03-d1ac-08db8e36dbf7
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 00:17:27.9366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fjeFX4DIp9dgcjZZgDdiclAt5sNscls67ERy2s+QNfiP0xD3XJptWYTsmm18YijiAU0Bhkdtxs+RzSGNp3j86g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4984
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/27/23 00:57, Yu Zhao wrote:
> On Wed, Jul 26, 2023 at 6:49 AM Yin Fengwei <fengwei.yin@intel.com> wrote:
>>
>>
>>
>> On 7/15/23 14:06, Yu Zhao wrote:
>>> On Wed, Jul 12, 2023 at 12:31 AM Yu Zhao <yuzhao@google.com> wrote:
>>>>
>>>> On Wed, Jul 12, 2023 at 12:02 AM Yin Fengwei <fengwei.yin@intel.com> wrote:
>>>>>
>>>>> Current kernel only lock base size folio during mlock syscall.
>>>>> Add large folio support with following rules:
>>>>>   - Only mlock large folio when it's in VM_LOCKED VMA range
>>>>>
>>>>>   - If there is cow folio, mlock the cow folio as cow folio
>>>>>     is also in VM_LOCKED VMA range.
>>>>>
>>>>>   - munlock will apply to the large folio which is in VMA range
>>>>>     or cross the VMA boundary.
>>>>>
>>>>> The last rule is used to handle the case that the large folio is
>>>>> mlocked, later the VMA is split in the middle of large folio
>>>>> and this large folio become cross VMA boundary.
>>>>>
>>>>> Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
>>>>> ---
>>>>>  mm/mlock.c | 104 ++++++++++++++++++++++++++++++++++++++++++++++++++---
>>>>>  1 file changed, 99 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/mm/mlock.c b/mm/mlock.c
>>>>> index 0a0c996c5c214..f49e079066870 100644
>>>>> --- a/mm/mlock.c
>>>>> +++ b/mm/mlock.c
>>>>> @@ -305,6 +305,95 @@ void munlock_folio(struct folio *folio)
>>>>>         local_unlock(&mlock_fbatch.lock);
>>>>>  }
>>>>>
>>>>> +static inline bool should_mlock_folio(struct folio *folio,
>>>>> +                                       struct vm_area_struct *vma)
>>>>> +{
>>>>> +       if (vma->vm_flags & VM_LOCKED)
>>>>> +               return (!folio_test_large(folio) ||
>>>>> +                               folio_within_vma(folio, vma));
>>>>> +
>>>>> +       /*
>>>>> +        * For unlock, allow munlock large folio which is partially
>>>>> +        * mapped to VMA. As it's possible that large folio is
>>>>> +        * mlocked and VMA is split later.
>>>>> +        *
>>>>> +        * During memory pressure, such kind of large folio can
>>>>> +        * be split. And the pages are not in VM_LOCKed VMA
>>>>> +        * can be reclaimed.
>>>>> +        */
>>>>> +
>>>>> +       return true;
>>>>
>>>> Looks good, or just
>>>>
>>>> should_mlock_folio() // or whatever name you see fit, can_mlock_folio()?
>>>> {
>>>>   return !(vma->vm_flags & VM_LOCKED) || folio_within_vma();
>>>> }
>>>>
>>>>> +}
>>>>> +
>>>>> +static inline unsigned int get_folio_mlock_step(struct folio *folio,
>>>>> +                       pte_t pte, unsigned long addr, unsigned long end)
>>>>> +{
>>>>> +       unsigned int nr;
>>>>> +
>>>>> +       nr = folio_pfn(folio) + folio_nr_pages(folio) - pte_pfn(pte);
>>>>> +       return min_t(unsigned int, nr, (end - addr) >> PAGE_SHIFT);
>>>>> +}
>>>>> +
>>>>> +void mlock_folio_range(struct folio *folio, struct vm_area_struct *vma,
>>>>> +               pte_t *pte, unsigned long addr, unsigned int nr)
>>>>> +{
>>>>> +       struct folio *cow_folio;
>>>>> +       unsigned int step = 1;
>>>>> +
>>>>> +       mlock_folio(folio);
>>>>> +       if (nr == 1)
>>>>> +               return;
>>>>> +
>>>>> +       for (; nr > 0; pte += step, addr += (step << PAGE_SHIFT), nr -= step) {
>>>>> +               pte_t ptent;
>>>>> +
>>>>> +               step = 1;
>>>>> +               ptent = ptep_get(pte);
>>>>> +
>>>>> +               if (!pte_present(ptent))
>>>>> +                       continue;
>>>>> +
>>>>> +               cow_folio = vm_normal_folio(vma, addr, ptent);
>>>>> +               if (!cow_folio || cow_folio == folio) {
>>>>> +                       continue;
>>>>> +               }
>>>>> +
>>>>> +               mlock_folio(cow_folio);
>>>>> +               step = get_folio_mlock_step(folio, ptent,
>>>>> +                               addr, addr + (nr << PAGE_SHIFT));
>>>>> +       }
>>>>> +}
>>>>> +
>>>>> +void munlock_folio_range(struct folio *folio, struct vm_area_struct *vma,
>>>>> +               pte_t *pte, unsigned long addr, unsigned int nr)
>>>>> +{
>>>>> +       struct folio *cow_folio;
>>>>> +       unsigned int step = 1;
>>>>> +
>>>>> +       munlock_folio(folio);
>>>>> +       if (nr == 1)
>>>>> +               return;
>>>>> +
>>>>> +       for (; nr > 0; pte += step, addr += (step << PAGE_SHIFT), nr -= step) {
>>>>> +               pte_t ptent;
>>>>> +
>>>>> +               step = 1;
>>>>> +               ptent = ptep_get(pte);
>>>>> +
>>>>> +               if (!pte_present(ptent))
>>>>> +                       continue;
>>>>> +
>>>>> +               cow_folio = vm_normal_folio(vma, addr, ptent);
>>>>> +               if (!cow_folio || cow_folio == folio) {
>>>>> +                       continue;
>>>>> +               }
>>>>> +
>>>>> +               munlock_folio(cow_folio);
>>>>> +               step = get_folio_mlock_step(folio, ptent,
>>>>> +                               addr, addr + (nr << PAGE_SHIFT));
>>>>> +       }
>>>>> +}
>>>>
>>>> I'll finish the above later.
>>>
>>> There is a problem here that I didn't have the time to elaborate: we
>>> can't mlock() a folio that is within the range but not fully mapped
>>> because this folio can be on the deferred split queue. When the split
>>> happens, those unmapped folios (not mapped by this vma but are mapped
>>> into other vmas) will be stranded on the unevictable lru.
>> Checked remap case in past few days, I agree we shouldn't treat a folio
>> in the range but not fully mapped as in_range folio.
>>
>> As for remap case, it's possible that the folio is not in deferred split
>> queue. But part of folio is mapped to VM_LOCKED vma and other part of
>> folio is mapped to none VM_LOCKED vma. In this case, page can't be split
>> as it's not in deferred split queue. So page reclaim should be allowed to
>> pick this folio up, split it and reclaim the pages in none VM_LOCKED vma.
>> So we can't mlock such kind of folio.
>>
>> The same thing can happen with madvise_cold_or_pageout_pte_range().
>> I will update folio_in_vma() to check the PTE also.
> 
> Thanks, and I think we should move forward with this series and fix
> the potential mlock race problem separately since it's not caused by
> this series.
> 
> WDYT?

Yes. Agree. Will send v3 with remap case covered.


Regards
Yin, Fengwei

