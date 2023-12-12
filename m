Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94FD980F505
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 18:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377034AbjLLRyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 12:54:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232358AbjLLRyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 12:54:38 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC968AF;
        Tue, 12 Dec 2023 09:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702403684; x=1733939684;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=S/aAN354RdqTaQCyODeTi40YS0uBp2HUHdIsLBKpC50=;
  b=P4ecB+h6prN8F3UzhtVxGSNfey/o73jBcJx0rgt2/AXIDS57ts46Pq9G
   oqPvEvr9qKkd1JAgmEdHj5A0PmfvrYZug8ZNcUUpg1MReYozWKh6ucPcV
   wJYE3arJRQxZJv/lg49MuOJ6FhKMWap8HEnlb24+JH1MT+gOhUa84TTQr
   fRQG58dhrjPLB/lOa5nTL3DgLeWokmBws9RvH/AUXNfcBrFSfLhWmAgbt
   IQytF5mTae1omqsUHk4Cnp3TGyNgDHjqq4mpdD9AeTKn6Ej9+ECQMzAlg
   CbOvSrty9eZsZR5yrU6ZSUuZWoJz66t8t8I4bbRN3ZXKpGufJXSstraL2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="1661985"
X-IronPort-AV: E=Sophos;i="6.04,270,1695711600"; 
   d="scan'208";a="1661985"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 09:54:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="1104988032"
X-IronPort-AV: E=Sophos;i="6.04,270,1695711600"; 
   d="scan'208";a="1104988032"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Dec 2023 09:54:43 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Dec 2023 09:54:42 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 12 Dec 2023 09:54:42 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 12 Dec 2023 09:54:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QQdhrpOUux1V0o+zsAN6/IWIA3UwB3WT491NtCUuekDpLuiH5Jo+GAm/m/2DrAImp0xVJcEysogE4uOxeotkrj/DwTQiwKwi3CJJgTR7QxKNJ7/0ZFi1EE2eBsdUhHVUllBNyRi+QBUcDCBXC9Woaea9q0tCU4qvv4zfr2tSTY4Zu8fZYj/Xz5QQaTTYNUt/+VOrmh8v3X+5C84kgsaLEsHHYOjJz7FJWWgLj4X0r5sNUjGPASJFcJ/546B3iHy3l04CSli2gc8nVtkR2LmOln3I3PtMV0PmH+F74k5fjOBTOlNXCcKIGDfGvd1JDD/AS4jPi8Ii0X+87IUXehBf1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=07YVFAHu5KHldJoJv6OROpr61t2QM25S2J+s7xP/+W0=;
 b=mtUHEp4aUXWZNn3t53+cJ4t19ePf0CweSAt3eHQGKxGUFlXPVxI9+xDho8KQuZQ79YZqjKgpVEaWO890fqbgS+3IRlXl0BnoWdwmzO+PR9CY5tnYqEBgzneRF9m2NHKu0jYHUjOKb1MEd5/0X0VSBdobxFVHQoorvMKl0h0yeZvhT2KpXFlB4PUXcce9wSJjnlPgeDKoSOVUXO7BXXnBYvLbacHVl+AZGSHi21fhVs61klkYkZzW7hRQpgjWK9zU27/FEsuu+tUk1tNEWUl5kaC+8YFajGV2o5vVlIs0O2xpt8d+9d20aZB81g1sz3Vhe+4Jl9pb9+iuiPG+A4yaSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CYXPR11MB8712.namprd11.prod.outlook.com (2603:10b6:930:df::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 17:54:40 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.7068.025; Tue, 12 Dec 2023
 17:54:40 +0000
Message-ID: <2377bfb8-00bc-4863-8d70-425cb70c9c0b@intel.com>
Date:   Tue, 12 Dec 2023 09:54:38 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/3] x86/resctrl: Add mount option "mba_MBps_event"
Content-Language: en-US
To:     Peter Newman <peternewman@google.com>,
        Tony Luck <tony.luck@intel.com>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Shuah Khan" <skhan@linuxfoundation.org>, <x86@kernel.org>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <patches@lists.linux.dev>
References: <20231201214737.104444-1-tony.luck@intel.com>
 <20231207195613.153980-1-tony.luck@intel.com>
 <20231207195613.153980-2-tony.luck@intel.com>
 <CALPaoCji1yzfkA=tms3LhYMvRB+wSJQM3qzPKrHNEa7a+KduTA@mail.gmail.com>
 <ZXORTTIUKWXOsd9p@agluck-desk3>
 <CALPaoCj_OvMzD8W9+jEORewwDquM6F-sOW32Ngcy+Gm6A1+OcQ@mail.gmail.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <CALPaoCj_OvMzD8W9+jEORewwDquM6F-sOW32Ngcy+Gm6A1+OcQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0220.namprd03.prod.outlook.com
 (2603:10b6:303:b9::15) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CYXPR11MB8712:EE_
X-MS-Office365-Filtering-Correlation-Id: e685784a-4033-454b-ae4e-08dbfb3b69f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z86l1rppDJC8FPaoklhjg+2uFYk4nQ6fVRi1WgdPQsa4cyZtNKQ0tvyCssAKYNq0al+gmNaBmzYD8jjVYGP37YfpRmLpRAxWaBoL53RmC0UpUkrVRso2a5EAHbBoUhddHs5qD9dYXjRLd8Ejw2i+WpVMYjqRh1RPkXhwRZA9rxlJn89xWWGMOiUjJfhZ8zq5wYRKKUpYcWNuX8TPKv5VbYT9R8PE6E/iz9nXPVOF6sFp/7ykNE+5F71urgVbsgho1u4FtaK48Er08tUGkqi8LIn4O/2FiQDD7fsc+8zjuj7EE+q9u9kgL4uOiy5o0fdtcBPj41hk0nBpIfLF1KdXgGgt3RuAJXimOJweqMe0YnoIYC1mQIMFKN1gXRzOsgZXSMPMY5KX8+5WiTlMGujojpMwIdmgVZn+wgD+KPt3PGpLy0irT0zzphMXC3yk8UX4LanAomjWNSoJZMV9if9+YRc1R6KfOpU5/uoqd2lQwkonbERad9lYi0zrgKKxYcRmz48QO5kVcBsXkvUPgzsE52Q256rgAFCH80fKtVTuPbdARErg0hTZT3w3uk8qCID5oEYZotFAah3VpjoPPEBAzu7GI5R+85iVk9nZeUk233oHb1+r16SBU5ZdWGtr4NrgIBN80w4Jx0ycR+V51e3KpQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(376002)(396003)(39860400002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(31686004)(66556008)(6636002)(66946007)(66476007)(54906003)(82960400001)(36756003)(31696002)(86362001)(478600001)(26005)(2616005)(6512007)(6506007)(53546011)(6486002)(2906002)(316002)(38100700002)(110136005)(4326008)(5660300002)(8676002)(8936002)(44832011)(7416002)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejVIZHVSVEc1UTBZNTQ0dU8zMWlIUlVudG1OVU8xSk9UcmJyRjdmNzBsem1B?=
 =?utf-8?B?V2llNFp2UzhlL2wrbC9ZVzh6Q093eUpJWjFWMk9KRG5VazRxRzRsVjYwOWZQ?=
 =?utf-8?B?MnE4U1lnMXFmNmR5cmtCdC9vNExYZXI3Z2hjRUVCRjR4Z29OT0Vob0N0TytS?=
 =?utf-8?B?S29qWHJ4cmxBTGp6d0VPZGZDUWc2MHRqdVRqTVFWcUt4dWRHMHQ2WlpJZFE5?=
 =?utf-8?B?TFBGSkx6R0lTRWdRbzFPSWE2b0ZpVitTUHFzaG93WTFuckpScEV0c1lOZlpM?=
 =?utf-8?B?QnNyWlZQdG5wQWgrS1FPcFlPYmtSeWlhSDVsdlhoT3c4YnI4S3Z5OEk4VGd0?=
 =?utf-8?B?cEpTNHo1bHc3ZjdONE5ZcFpqWGRTT0pVOW02UThMV3dUUXUrY0xBY3gvSXZq?=
 =?utf-8?B?UUdFeXMzaUNESzRWRzhZUzRzYzJNUXlGVkNJeEw3Tk45Rll5WldoQmlTZTRp?=
 =?utf-8?B?NnFFaGNtd0UxeC9NYnVMUVRUaWZVZHJKZTBBb0JyMG12a2w4OFBvTGFoa0lB?=
 =?utf-8?B?Y0c2MCtqMzVtVzlsenZzbzc0dlJrSlBoKys3ekU5OXJzcWNzK3pnSDlFU3l3?=
 =?utf-8?B?SjQ0TW5EZVREVVYvYU5TNDI0UXJyaXhGeXI1d3phZzhhdi9VQUl2UVVMYS9J?=
 =?utf-8?B?dXZ3R1A3clNZZS8zQWpqWnJwS0xwY0lWaVp2Y2M3Vzd4OFZ6cnRLVmpNQ2x2?=
 =?utf-8?B?Q0xVMnYvaW9hVzNnZFlqbFpmb2F0S3ZsLzdVNFc4aXBKN216M0xuc1VSZGlr?=
 =?utf-8?B?VUJUVWdQNHprRDlzZEJNM1dybG9hZE1mZkhhc3ZyM0pIRW8xZDlFSU5kd2Zw?=
 =?utf-8?B?SmQ0L3NuS1Rybi92Z1E3YXRVWHcyOUVpNmU4d3F0cUtDOUord3lReU5nTVY1?=
 =?utf-8?B?WWQrTzByaWFFdGNTZ3BFNVRjNWVweXA2T01zZ2FvN2ZUVUpjRW5HTGhVZFF2?=
 =?utf-8?B?bDNOVXU4Y2xuNUk4ZWxNS3paQzMwUDJ5TXo3SnJVeTZJWlBtMHJycGxXV0RS?=
 =?utf-8?B?Ujc3Tm15NjU4YTEzV1hrcDlkcHdHL29PckJEL3R1blZYQnhObnFwcU1KRkVl?=
 =?utf-8?B?RUJvOFhiWldYdFl1Q3FtZ3hDL1Zkc0FtZE11WDdzT3ZMbmFsRTE1cUgwbWNR?=
 =?utf-8?B?YlNJdVFLdy9JaC9aU01rU2pMVERyV3pjWXM4L3lBblhjVGxtMmZ6bXovalFo?=
 =?utf-8?B?b09GSmx3bDZzWGMwZGZGN3FFRE9ha3FJbCtXL3IvRTNmbW9pTkluaS80OUUx?=
 =?utf-8?B?b0hjR2VrN0VmbVhGSnhEemhCYmo1VmlRVVRzcmxlU0VmSFd6bFlSV3BjQ25B?=
 =?utf-8?B?YTBXTEJHcHZ2WE95OXhRNkpOUzlpWUV2N0ovNmFXaTdDcnFEYTVRV2tTbWNS?=
 =?utf-8?B?SlVDelNNNW9lV3hOc3Fwdnp5cnJZSUlSYkdLWDNra1NyV2I0VXlQSnRoTnFt?=
 =?utf-8?B?ZFRKNnN3alo5RC9iMHI0TW5nNnA5R0R1MjFFaWhyZGhaa3pQa0c5d0ZGakJs?=
 =?utf-8?B?cmFaaUErNU9FeVpvbnNBS3A1UTFYU2xBYVJIWllkVHhXMHI5V2VnSkZEVW03?=
 =?utf-8?B?Z3huNGgyd0VaTVJmUGExNTFxTDdhU2RsazhRcnlWQ1VlQ2xrcWhuejNUYTdT?=
 =?utf-8?B?YjFVSjZtL25DSnBhL0RoakF5VzBuMUV5WWJieWt6cjZkcVByU1Z2QnJiWE9C?=
 =?utf-8?B?RkpDZ3ZOQms4bFFkOUpMQXo1enRHbFd6cmE4bndJaTBmQVB6OHBYRHJyUmtJ?=
 =?utf-8?B?d1p0L2pLLzhiQXI1dGdHRFdRWVpsaGZNaGo2VnRxSUxtY1pwMk9remdPMjk5?=
 =?utf-8?B?c2UxZkRoR1hGNU9ZMkVLUnBSMVA2OVRxK3M0RjRxckFENWxvZ3ZLNERuSnFG?=
 =?utf-8?B?TVFSb3BBd1MzclhtR3NGUkpTWEZpNU0wV0wzS1h6NXdYV3UzUnJSZmtvRk9V?=
 =?utf-8?B?SytWczFDNjZLYWdYUzBtNlU2d3BFaTlkaFFjUHpiWk90ZWRCQy9NckhkWm5N?=
 =?utf-8?B?eFkxMWV5b1hXUGpzckMxRmtsekF4eXpTWVVRQ05pcmFpVTR4UjV0SUg4Yktp?=
 =?utf-8?B?MTk4T3RpQ1E5TGVPNFJMMVgxYUtBcEplZkgvdWZ0TzNweGpDQmxOWGtZYnFw?=
 =?utf-8?B?WFBpM1NWREdhOXg3YzFaZVpRdUFXQ3pwZlhkdEg0VUdZb0hKVC9iTHEzVWIr?=
 =?utf-8?B?a2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e685784a-4033-454b-ae4e-08dbfb3b69f7
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 17:54:40.3993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /MPvLj1YyFn5vpcOwlFBhW2aONa8GD1/hldRPj95Gg/GS3tfo/Nbg39rNa0Z9DzMPSOLRSvPHmWtH2NX6pCn/zLcM4wPB5y2P7PeafPP2fU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8712
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/8/2023 2:09 PM, Peter Newman wrote:
> On Fri, Dec 8, 2023 at 1:57 PM Tony Luck <tony.luck@intel.com> wrote:
>>
>> On Fri, Dec 08, 2023 at 10:17:08AM -0800, Peter Newman wrote:
>>> Hi Tony,
>>>
>>> On Thu, Dec 7, 2023 at 11:56 AM Tony Luck <tony.luck@intel.com> wrote:
>>>> @@ -2715,7 +2723,25 @@ static int rdt_parse_param(struct fs_context *fc, struct fs_parameter *param)
>>>>         case Opt_mba_mbps:
>>>>                 if (!supports_mba_mbps())
>>>>                         return -EINVAL;
>>>> -               ctx->enable_mba_mbps = true;
>>>> +               if (is_mbm_local_enabled())
>>>> +                       ctx->enable_mba_mbps_local = true;
>>>> +               else
>>>> +                       return -EINVAL;
>>>> +               return 0;
>>>> +       case Opt_mba_mbps_event:
>>>> +               if (!supports_mba_mbps())
>>>> +                       return -EINVAL;
>>>> +               if (!strcmp("mbm_local_bytes", param->string)) {
>>>> +                       if (!is_mbm_local_enabled())
>>>> +                               return -EINVAL;
>>>> +                       ctx->enable_mba_mbps_local = true;
>>>> +               } else if (!strcmp("mbm_total_bytes", param->string)) {
>>>> +                       if (!is_mbm_total_enabled())
>>>> +                               return -EINVAL;
>>>> +                       ctx->enable_mba_mbps_total = true;
>>>> +               } else {
>>>> +                       return -EINVAL;
>>>
>>> It looks like if I pass
>>> "mba_MBps_event=mbm_total_bytes,mba_MBps_event=mbm_local_bytes" I can
>>> set both flags true.
>>
>> That's going to be confusing. I'll add code to stop the user from
>> passing both options.
> 
> Also kind of confusing, after reading the second patch, I realized
> "mba_MBps_event=mbm_total_bytes,mba_MBps" also results in both being
> set. If you're able to fail the mount operation if both flags somehow
> get set, that would address this one too.

Are two separate flags required? All existing options within struct rdt_fs_context
are of type bool but that does not imply that it is the required type for
all. 

Reinette

