Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8A4C7F192A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 17:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233627AbjKTQxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 11:53:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233443AbjKTQxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 11:53:35 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6CE0F5;
        Mon, 20 Nov 2023 08:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700499210; x=1732035210;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0onWQwTJwyAMwyWUAbwn8nVcfv2Dsk5p8dy9fS+uoCs=;
  b=ORpjSfANOfE918I1ZpOzvUfm66PKDaeuPoRXwfpCPCSNPk4aMmRmTMBI
   rViR4QIV93NukOfBTasDteIhrANJX0aXlXZq0ejnFkQLmnaR6UWfo4Ku9
   PzUZPVa2DHOsE6EeZ/TZocS1T83A2aZ9+XCCauUnqp1Qv0O//G+xZFvTx
   SvF1uCddONmu8VYd+wmk5eAX8/ktO22Et2+71eoc836arSPVqcAnBntng
   9fo5SxMrFUBKYMednaPHaZHR57bygZFyUZX/nh3uyDQA4rWVZKPJNVhI4
   Ui7DAmWD9bOXeuoVbSIxzwIs9Y8AmgI2H8EjNDQI8RCeyuUQp6D5N6qrY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="388802091"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="388802091"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 08:53:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="801238577"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="801238577"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Nov 2023 08:53:29 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 20 Nov 2023 08:53:28 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 20 Nov 2023 08:53:28 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 20 Nov 2023 08:53:28 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 20 Nov 2023 08:53:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UvQvicZ6AI9q8FiMfnWmJrK/QzMtLqy0lLrvOvz/cE953thEjmp6Ca8lyAdvF+CfmNmCDoaOoIB3pjQOAB5MEih90NNa0xrOjH0CaRdKzCgbFH/uceE65+pwELL3DzgIQSj7X/pjNVau1eSo6ziPHNDaUkQOaHNHABLc35Qj8j8zvSo9cEG4+JkJWibicNuIP72l86rbsJfY/ItvaOdn9zW2Mo5bFPe+6P701uWijPYrBNgCsFUdgl/lwYKXP6rADuvb150aWCPpoMTHGsc/p3iYHPoTZu3aUnKqpBwjc1mxxxjurFSPBgUss32LW31nsZsFIKf2WxergyOh/wD7yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3hJ+n2M6xUzr4oDabB+YLHxBpmNVmB5cAv4QEFo9VAY=;
 b=HUjl8cJKf4bBvcs3Ia3s0R7v7U3VDMhHEmDxKB/uEFXCHukgsDGGUcgu4AwY9/ex5Ug9KYn8sGV0mXNuXJyUciTd+PGmF5VRbA/Sp5BMbqjDpAk0SiIYAGP7lnheD4bBrzbJPyi108RP5FOhNyM4hag3Ga8pmHhJ8pVwl2pbH+kW2h3b/903+lXqwt4TCWam+v6ylXdSBqkteoHZHmNDshe/nlrtyu5AnSi5oMDHeRIKaDY6Gc7mHPkB++PfI6ZgSx2OurTZCkKXV+7IBaN5zAIH0OCZmE3hhCs7r6hhOqB3tKl/bG3JUvfzkobwK/DcUL0pCMtEyMMv8xzU1Gbfzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by PH7PR11MB6548.namprd11.prod.outlook.com (2603:10b6:510:210::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Mon, 20 Nov
 2023 16:53:26 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1%4]) with mapi id 15.20.7002.026; Mon, 20 Nov 2023
 16:53:26 +0000
Message-ID: <736fcad7-f440-4bcd-86fb-4cc73d1b8f37@intel.com>
Date:   Mon, 20 Nov 2023 09:53:22 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH] ACPI: acenv: Permit compilation from within the kernel
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Sam Edwards <cfsworks@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20231114-arm-build-bug-v1-1-458745fe32a4@linaro.org>
 <b2354c21-3a1a-c446-fee0-db0c78d05c71@gmail.com>
 <CAJZ5v0idWdJq3JSqQWLG5q+b+b=zkEdWR55rGYEoxh7R6N8kFQ@mail.gmail.com>
 <41160dbf-d8c8-4dc0-9fda-42cc97df5b77@intel.com>
 <CAJZ5v0jNOXKv2fHNGUDjDvvg6FGbXuahhH9dBhWiAwiPv3fH8A@mail.gmail.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <CAJZ5v0jNOXKv2fHNGUDjDvvg6FGbXuahhH9dBhWiAwiPv3fH8A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0P220CA0017.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::27) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|PH7PR11MB6548:EE_
X-MS-Office365-Filtering-Correlation-Id: af88345e-6e59-4f2f-ad19-08dbe9e936b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lJwsr3eN8w6eIrzwq2kWz+B9DH9BIDnQJxRcaYCcA8JFfjbcKkJJh0Au5FTAxG23wKk94u/zSGz2iTZjB/ghcHA2DE/tDxKM+RL8M6Em4BMFPH/tLQQ7k26CDVHbhO/ndFglae7CQB+yUhbWSkA/Vr/UlVb0DzgJYB5OUUoXo0gp5FDV9zFx2jq9iYC3412gUfNI62V+siQThXU6+VDFVdL8/b2nsAjCZJ0r8vun+Uhodoc1XP7T+d2syTXHHq7DvdNEIigEBs2zsWEJu6j0hd9DjtV/Rmaksywpz5Cd5tUxwfWzOWF7fvrcT+KWgQ+6/Y2vyttq2IAvvjugwXUD1FOFV+CuEtYk9vmlg9xuPMbM+eXF2s19XqtIIS7MJMfnieQkGiMBHvAtc4LeiXgtvNRwbTQqQz0oGZ5P89spNztHQJpOqeAlbagr0bkgdIZmRwtS2gq8W3sicisXgDaWnkNbA3Sg5ForvSECwqa7IfxmV5EpkFr1fNdSnH3tDZc24pykil6uPgQ80QsjqOOLRguIiSssWVthLipTyFY9IdxTKm4TvDWPYDoOu0P7FgVXH3oF6wLdwra9GNA3KMVahU8KtMW7sZvyhfHDI9Lb/+1/itISI1+cRKbUCn3lzC1p
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39860400002)(396003)(136003)(346002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(83380400001)(478600001)(6506007)(26005)(53546011)(6486002)(6512007)(6666004)(82960400001)(316002)(66476007)(66556008)(31686004)(6916009)(66946007)(54906003)(2616005)(8936002)(38100700002)(4326008)(8676002)(2906002)(44832011)(31696002)(5660300002)(7416002)(41300700001)(86362001)(36756003)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enkyTEpsaW5EdDJpVmJYME9lQ2YwdXlOV1Bvem1uRXRzNWxKU00xL3hDWXBs?=
 =?utf-8?B?Njk5c2pxVlQ5REgrbHVpNFBQVnIzc0Q1NUZBOFdYT3V5MU9xQWIyTGVsSTlO?=
 =?utf-8?B?MCtMQUJqRWt2dWZSQVdpQkRIMmlLSlFkaTdLelBSaWpPMVVVUzBvV0wva0M2?=
 =?utf-8?B?Mk5lSURsU0o5QWFhUzNoeDVWRzJGVitLNHk1eTNJNE1MaysxOUVaZVZHTU54?=
 =?utf-8?B?SWtDSEMyZUV3Q0E1dDVtV1dkOER5RzFyNnJWSzdBRThnQ3hFSzVGdGVHNlNB?=
 =?utf-8?B?Z3FyNmhkaHpPU2JlY0tjWFpoKytsd0VqYUhjRlFGb0lEa2h2UHdLUG5QVU02?=
 =?utf-8?B?NlVzUHYrcVdVTzhBWnA0Smh2dkkxb1Y4Z1ljSEZ1WWNGYjZWWFhMUW04bVE3?=
 =?utf-8?B?aUtjRXZZVk9HRHJxbFl4dERJcUVLZ3hBWWowV2JiYTR3djBlYUhJWW1YOEI2?=
 =?utf-8?B?MENUYm9PZTh1QlNFbzliT1prRUptWG0vVDFvVTUweUZZMndzTU1JbVJvbkMr?=
 =?utf-8?B?NlVycTFwWTllSitvalo4RmVOa1dQd095VStyaE9nTkpzQ2RzS0JQVThqK2pj?=
 =?utf-8?B?ZFdUQnJnTEZvVmtDSnRpSTBIWUVUc3VHTnlmMEc1WEhSdys4ZTU0b0FhcnMv?=
 =?utf-8?B?SDh6V0NrazJyL2dWQnN0N203WGp4RFNzbzJMZVIzY2xZYmVmOUlxZFI2Q3Qz?=
 =?utf-8?B?SEFyL1R5SmRuOVd3djBtQjl0ZzhDcEcrREpBUGQrRGVEZ1VsbjlNYUVHY2kv?=
 =?utf-8?B?Tm9jTktWUGlDanVhSGlWMldpWW1uUlA4Yk9JTzlWS3lUV3lkRElLZ0VjTlpJ?=
 =?utf-8?B?eFc5aUlvTE9YOTg4YWhtbVMyRlJYQk5JN2NKTER5bUV6bVFpdml4cWlXUUdz?=
 =?utf-8?B?SlUyZHIyQUJIR0x0ZDFieUZOOEhzRStRa1lCdnVtRXFBWkErOWd6VGNmMkZm?=
 =?utf-8?B?NnNjbWlzcDkwSGh3YXlNMjRvQ3ZiN2p3NENRREh5cVBnTThUMlAyaFFJS044?=
 =?utf-8?B?NkxYb3VvbEZBYm0rR2Fxa0R0TlZSRE9WazZWUnlWUDJnOHdhY2JCckFZYTFH?=
 =?utf-8?B?Z2gxTFlNVFh6RjM4THVHOE1Kb1JZRFJnWTdQTTVrT0hkTkplN292eTllckZr?=
 =?utf-8?B?SVlXUzhlS0N2VnVtTWErSHhKbDU3TmRZRUttSlVtVWJKUS9JVlRZWE9DdlAv?=
 =?utf-8?B?T0poUGIxM1RGQmdYbDdHTGlxb21HcFFlN1FnMzVyMmlDZFlaUWFLekNuUEow?=
 =?utf-8?B?NE03dXo1WWJ3R25KODAwUHJvczhVaWVQQkZTejlhbXV5NlNKeTkwVU9RTGJr?=
 =?utf-8?B?VU5xNytGRGpMVENpVG9rTTJLWUw4YUgvbENPcGtsUDRWdGFpMG43UmVSdzlJ?=
 =?utf-8?B?TjdjVU5DUmc2UlhZUnpFM21IRHhFbHBTMm1jbWY1WVRqNWdVSlVQSUZvcGYw?=
 =?utf-8?B?MTk1NHoycnNxcTl2L3lpL0hlTnlvcnlQM0ZWVDFmOXVXVzRUc1duSEU2Ui9W?=
 =?utf-8?B?bjhqWHpXTUVDaHdENFFjUzJQcHVwaGJ1UFcvdGlMWStCdVR4Y0JKcGFMYzBs?=
 =?utf-8?B?VGx2U25pNXZrRGl0NFhtQlIrMHNxeVQwOWNWUFVXSzFWMmFvZytsWWQ3M1pK?=
 =?utf-8?B?MWFTbTV1RkYxNVVSMjJTVkIwaFlTdEFWMVYwT2twZmFBb2U4enEyOC9GVjBW?=
 =?utf-8?B?Q3RITmpkZTBMUDFxSlB5bzlWMCtiSXBXY2ZhQmJaZVF5QjhsT2VZb0RTWUVQ?=
 =?utf-8?B?YU4zbnhnOW54Z2htMlh6ZHV6N2ZzekMzRVVWWnpMVXRoRENxdXdERmtSTFlZ?=
 =?utf-8?B?bHhtaFU3ZEw2V3lNUS9hNEk3bzd5RzliUnJ1L3ZjWEpxaVMzWEZ2L1JNcUQ4?=
 =?utf-8?B?cEdUNzBwSDdGY3VMR04zTDREelRwV2M2Vkg1cTNDYlhPNjkxWDBEdy9FdFNF?=
 =?utf-8?B?VVJNaXlma3kwYjZBQUZYQXk2Vzd0ZUN2QnpCYWNScGhBTk1mb0NLMmJpTSt2?=
 =?utf-8?B?TVJ5bWd4NUtYNGk0SDFLWUJjUGtVU3lZMnhUMzUwTzdWNnZ6VjRFSFhmNkJZ?=
 =?utf-8?B?SDNWaDkrRGtocGd2cHkzRkxxMXh1MEFzWGhwUTJ4ZnNoV2ZZSmYxVVozTlZB?=
 =?utf-8?Q?h93aN3V6LeoxKE8jjs4eD6TFP?=
X-MS-Exchange-CrossTenant-Network-Message-Id: af88345e-6e59-4f2f-ad19-08dbe9e936b2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 16:53:25.9345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a35HG7c5MgJcYRTv/OsriR5qtk6tJ6hKO5qliGqdXjbyhXZKVkz1O5QiJDAEjIdY91uT7eseV7NYX+/pxqd0vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6548
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



On 11/20/23 09:38, Rafael J. Wysocki wrote:
> On Mon, Nov 20, 2023 at 5:19 PM Dave Jiang <dave.jiang@intel.com> wrote:
>>
>>
>>
>> On 11/20/23 08:46, Rafael J. Wysocki wrote:
>>> On Tue, Nov 14, 2023 at 7:09 PM Sam Edwards <cfsworks@gmail.com> wrote:
>>>>
>>>> On 11/13/23 16:08, Linus Walleij wrote:
>>>>> After commit a103f46633fd the kernel stopped compiling for
>>>>> several ARM32 platforms that I am building with a bare metal
>>>>> compiler. Bare metal compilers (arm-none-eabi-) don't
>>>>> define __linux__.
>>>>
>>>> Hi Linus,
>>>>
>>>> I saw the same baremetal-compiler error here on the ARM64 side of the
>>>> fence, and narrowed the problem to the same commit as you.
>>>>
>>>>>
>>>>> This is because the header <acpi/platform/acenv.h> is now
>>>>> in the include path for <linux/irq.h>:
>>>>
>>>> More generally, I think it's because of this addition to linux/acpi.h:
>>>> +#include <linux/fw_table.h>
>>>>
>>>> linux/acpi.h is supposed to ensure _LINUX is defined (if it isn't
>>>> already done by a non-baremetal compiler) before we start pulling in
>>>> ACPICA includes, so that ACPICA knows the platform. But because
>>>> fw_table.h contains:
>>>> #include <linux/acpi.h>
>>>> #include <acpi/acpi.h>
>>>>
>>>> ...the circular include does nothing (linux/acpi.h's include guard stops
>>>> the include before _LINUX is defined) and we end up pulling in
>>>> acpi/acpi.h before we're ready.
>>
>> Not including either causes compile errors for me.
> 
> Interesting.  What errors do you get if you include linux/acpi.h only?
> 
> It should not be necessary to include acpi/acpi.h in addition to
> linux/acpi.h, because the latter is expected to include the former.
> If it doesn't do that, something is amiss.
> 


  CC      arch/x86/video/fbdev.o
In file included from ./include/linux/acpi.h:18,
                 from ./include/linux/tpm.h:21,
                 from ./include/keys/trusted-type.h:12,
                 from security/keys/encrypted-keys/encrypted.c:22:
./include/linux/fw_table.h:32:37: error: field ‘common’ has incomplete type
   32 |         struct acpi_subtable_header common;
      |                                     ^~~~~~
./include/linux/fw_table.h:33:36: error: field ‘hmat’ has incomplete type
   33 |         struct acpi_hmat_structure hmat;
      |                                    ^~~~
./include/linux/fw_table.h:34:40: error: field ‘prmt’ has incomplete type
   34 |         struct acpi_prmt_module_header prmt;
      |                                        ^~~~
./include/linux/fw_table.h:35:33: error: field ‘cedt’ has incomplete type
   35 |         struct acpi_cedt_header cedt;
      |                                 ^~~~


However, if I move fw_table.h in linux/acpi.h below include of asm/acpi.h, then we can build successfully w/o including acpi/acpi.h in fw_table.h.


diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 54189e0e5f41..2789beb26138 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -15,7 +15,6 @@
 #include <linux/mod_devicetable.h>
 #include <linux/property.h>
 #include <linux/uuid.h>
-#include <linux/fw_table.h>
 
 struct irq_domain;
 struct irq_domain_ops;
@@ -25,16 +24,6 @@ struct irq_domain_ops;
 #endif
 #include <acpi/acpi.h>
 
-#ifdef CONFIG_ACPI_TABLE_LIB
-#define EXPORT_SYMBOL_ACPI_LIB(x) EXPORT_SYMBOL_NS_GPL(x, ACPI)
-#define __init_or_acpilib
-#define __initdata_or_acpilib
-#else
-#define EXPORT_SYMBOL_ACPI_LIB(x)
-#define __init_or_acpilib __init
-#define __initdata_or_acpilib __initdata
-#endif
-
 #ifdef CONFIG_ACPI
 
 #include <linux/list.h>
@@ -48,6 +37,18 @@ struct irq_domain_ops;
 #include <acpi/acpi_io.h>
 #include <asm/acpi.h>
 
+#include <linux/fw_table.h>
+
+#ifdef CONFIG_ACPI_TABLE_LIB
+#define EXPORT_SYMBOL_ACPI_LIB(x) EXPORT_SYMBOL_NS_GPL(x, ACPI)
+#define __init_or_acpilib
+#define __initdata_or_acpilib
+#else
+#define EXPORT_SYMBOL_ACPI_LIB(x)
+#define __init_or_acpilib __init
+#define __initdata_or_acpilib __initdata
+#endif
+
 static inline acpi_handle acpi_device_handle(struct acpi_device *adev)
 {
        return adev ? adev->handle : NULL;
diff --git a/include/linux/fw_table.h b/include/linux/fw_table.h
index ff8fa58d5818..a722300c215b 100644
--- a/include/linux/fw_table.h
+++ b/include/linux/fw_table.h
@@ -26,7 +26,6 @@ struct acpi_subtable_proc {
 };
 
 #include <linux/acpi.h>
-#include <acpi/acpi.h>
 
 union acpi_subtable_headers {
        struct acpi_subtable_header common;



>> And directly including acpi/acpi.h w/o linux/acpi.h causes triggering the #error and some other stuff:
>>
>> ./include/acpi/platform/aclinux.h:18:2: error: #error "Please don't include <acpi/acpi.h> directly, include <linux/acpi.h> instead."
>>    18 | #error "Please don't include <acpi/acpi.h> directly, include <linux/acpi.h> instead."
>>       |  ^~~~~
>>
>>
>> Only including linux/acpi.h:
>> In file included from ./include/linux/acpi.h:18,
>>                  from init/main.c:30:
>> ./include/linux/fw_table.h:32:37: error: field ‘common’ has incomplete type
>>    32 |         struct acpi_subtable_header common;
>>       |                                     ^~~~~~
>> ./include/linux/fw_table.h:33:36: error: field ‘hmat’ has incomplete type
>>    33 |         struct acpi_hmat_structure hmat;
>>       |                                    ^~~~
>> ./include/linux/fw_table.h:34:40: error: field ‘prmt’ has incomplete type
>>    34 |         struct acpi_prmt_module_header prmt;
>>       |                                        ^~~~
>> ./include/linux/fw_table.h:35:33: error: field ‘cedt’ has incomplete type
>>    35 |         struct acpi_cedt_header cedt;
>>       |                                 ^~~~
>>
>>
>>>
>>> Yes, that's the problem AFAICS.  Dave?
>>>
>>> What about moving the fw_table.h include in linux/acpi.h below the
>>> mutex.h one, along with the EXPORT_SYMBOL_ACPI_LIB-related
>>> definitions?
>>
>> This builds cleanly for me.
> 
> OK, so I'm wondering if this also helps the other people in this thread.
