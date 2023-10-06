Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9BF7BBDBC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 19:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbjJFR31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 13:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjJFR30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 13:29:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1ABCAD;
        Fri,  6 Oct 2023 10:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696613364; x=1728149364;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+bAMcBswfU7qNU2f3C4o8rriXS0sq1j4PstsWwXO8EE=;
  b=NyjW1m6A8E0ak0Uf08+r9vEa/38oDESRrOpd0TO8v0LHnCFDJMsFrVyT
   g3hGx7j2DE6CSInkjUyq3j4Lji+1xpEoPqsNLd9KWdE3lPMHdvKupSz1p
   zcVrZ5rVIjwVCL6LzIp7ANDNzEGzQ23uyiyuGEvcTeF1HFXR3J6J2JwIg
   /zWJTyb9wqbXS1awFdmdaD/wQwppjZtTODuGiVJdJXXfeD3fE0JPr6GZu
   sV2KATXoQL3mdTeg+myyIlTE+YVFrMtInvldugBo+oi2MWfqc70YvEe7n
   7+kMhm+7/4KN69rKlLnsHzkUKIhanAyztZUl8BbHajLgXM2An/5uBBT5b
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="414789836"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="414789836"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 10:29:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="818078174"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="818078174"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Oct 2023 10:29:24 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 6 Oct 2023 10:29:23 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 6 Oct 2023 10:29:23 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.48) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 6 Oct 2023 10:29:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O6PGJGipi2oImQETkT3KMNfHCXLFUvE71TMgQwuE+dhsTl4qYYZEq01bO58hEEglbiPRrovwetwuaRHpflOXvuBNEsLiAjIfRxlU7DTMU/0Z2UkcX1to7dVG4ZqRvHXAUsP7QSieWztyLDzSU//jnVrg+huTwIk68TLFNanDZCky2VhROBB8SukeRo8Lo0zrIO6kEyKLpj1Rg3zNL46R0AuhHQbp5W1rCgL9L6cPhp+M9glWHdcLmQ4G3wpofv6hkriF6ge07wBMcWx6o1+pUaENpGeGwCtRY5p77h/qEXXocQNRWivYT9DfMM4eo4jHy+eOYhX9uVttZduYKDDaiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hfmYKRXRRfbQ9DV663B9gzwu4PFR/RBJEiA2Ues2vIw=;
 b=DbKexfiDFNgdIKEfN1CKBviilbppluWv9W0pGO9qWTdCvIQlmYtRAwQjjQEEj0QEzZo+auhk73IU4j9+/ntT4YI4oVugdF8/qcuc+DfL0qLYdqpDcDkGYvzTgvNNC05aVUmor2752ANZVcCagCRqSYIbgi7OdcBEGb7JXlirdVfNZkrJt3dG/eHsxEFI7xB/sZAY2+a5OCw4uYrC+xrlc4mHVjXpNUgEQHVHppIWh1izt1OwjBmKQoOX/fSFFfs/BpHxAvqlurb9jl/hOBixuLbilLixXyAafqZPzNMAV1achNDS0GJ4yGAUQglpR/scpdBL2Kkp96tnt/z9FLJT6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5603.namprd11.prod.outlook.com (2603:10b6:5:35c::12)
 by LV3PR11MB8696.namprd11.prod.outlook.com (2603:10b6:408:216::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.34; Fri, 6 Oct
 2023 17:29:16 +0000
Received: from CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::dbe4:218c:1bdd:510]) by CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::dbe4:218c:1bdd:510%4]) with mapi id 15.20.6838.033; Fri, 6 Oct 2023
 17:29:15 +0000
Message-ID: <065980bb-5890-48ba-b75b-86b3632fd826@intel.com>
Date:   Fri, 6 Oct 2023 19:29:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/9] docs: firmware-guide: ACPI: Clarify ACPI bus
 concepts
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <rafael.j.wysocki@intel.com>,
        <andriy.shevchenko@intel.com>, <lenb@kernel.org>,
        <dan.j.williams@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <rui.zhang@intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>
References: <20230925144842.586829-1-michal.wilczynski@intel.com>
 <20230925144842.586829-3-michal.wilczynski@intel.com>
 <2725050.mvXUDI8C0e@kreacher>
 <edb1d4bc-a484-42ea-9a5c-4c77a860645a@intel.com>
 <04972447-91b5-4392-acf0-c942e02403c2@intel.com>
 <CAJZ5v0h3ZggWKAuKDbFnPbhWpcwnDVk+OrBPRsahM87_H=ob1A@mail.gmail.com>
From:   "Wilczynski, Michal" <michal.wilczynski@intel.com>
In-Reply-To: <CAJZ5v0h3ZggWKAuKDbFnPbhWpcwnDVk+OrBPRsahM87_H=ob1A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR07CA0293.eurprd07.prod.outlook.com
 (2603:10a6:800:130::21) To CO6PR11MB5603.namprd11.prod.outlook.com
 (2603:10b6:5:35c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5603:EE_|LV3PR11MB8696:EE_
X-MS-Office365-Filtering-Correlation-Id: 49999138-5bc5-4c10-e4e4-08dbc691c2f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XlLX2kG/MJlmA+UjgBgS2UFuqMVeEt0xGrBNqgtKqYdZooTFqJK0p68eDflgbU14Ow34rmUmff8R66dfuOKpfkJOT1RbxZ3bETouy7CXNTZWAl8etno4EpmNazO9P//fuSMahnpR9MwcVSInnkMZ8VrWqPq/ENRG0KybZ0T1oU3aDyZ8mMDCqABTKgcIfbQvnJmUWRTEbCv5AL4MSnskXxs79ZAyhyHVsA1RijAlIAqc13IBqwlqeHR1fZlPdBIHEzikGhvJc9XZT9cPdIP4rncI4U1WmCjdP8LhZ7Ypg7q+GAW35empsxPWM+UsjXO3RAPyL88C0VMOAffzOqqwraEV4DPrR9ZupwFxONpAOzoSlufaa3N13WSPmN7gPve/7vU593OV9YNgGAxvY6q4Yt5DLwBENRm45+9diNL6I6lNLUCqjIsYkfZ/5FJFw2zqmk6XBRv55uoLCuS0VH85iAkwQnUQltPD1Z3bnCMxSLj6fzU9Y1RbNQSA9aUTEA23W592at45WDjOTbx92J0ROcIhhZFY3NdDeJ0CQYUGh2ZYg32+PUvppT5GwDODtsuGsOiu9Zsk4aaFnsI/nhI76K+3BWo5dxykzZ2SQRnEyIPTy7Dp2oPZLS6H/Khh+yu4a8NDJgspRRSrcEhphauECw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(396003)(39860400002)(136003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(6666004)(107886003)(6512007)(26005)(53546011)(6506007)(6486002)(2616005)(36756003)(82960400001)(8936002)(83380400001)(31696002)(8676002)(4326008)(86362001)(84970400001)(2906002)(5660300002)(41300700001)(478600001)(316002)(66946007)(66556008)(54906003)(66476007)(6916009)(31686004)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVJNNFdaeUl6QllkVHNDRTB5SVIyaVBOMUFodllkYzVDWlpCQkQyeEpMWVRa?=
 =?utf-8?B?K2d3UzByN2tvcmcvTTI3UWRkK0xtaHFJM3l3WHZxbHVDWHB6N0dkVkpZOEV3?=
 =?utf-8?B?bUM2Vm9qNmFSeUtISVNXeS95ZTRuM2RvTEp6VG5vMlc3aDZXWjdORHVIYkZU?=
 =?utf-8?B?RE9ZV3NoK3BkbGE5NHp3UHpiSkdxckxGSEFFOHpINDYzYUZHRXlBUElmNlZB?=
 =?utf-8?B?QWM0bkdSOUNBU3JUWEx2KzRkTkFSVkZMT2RZUzN5NkN1blViUllLdGx0QXFx?=
 =?utf-8?B?SDBmaDU1c3RuMzRRUDZmVTlkcDIxNnN4SDhlMUJTcU1lalFiNjV5VHNwdU1U?=
 =?utf-8?B?Q0JxTmZHMDBUWTVQYzFoSkdJcmpWOTIreDRXcWY2a1Z1YzBubXFjOC9QT3Uv?=
 =?utf-8?B?K25zN2s4NzlTMmlHeHVhSjAvVjZnY2NZZThwVzlRZDZsY3VrY1JwdVJOMWE4?=
 =?utf-8?B?QWIvT3FTMkZaMkZGVk96MUxIZVlkOEpKY0hCN3d4N3FDQWNmamVYZVFPbVFz?=
 =?utf-8?B?aml0bU9PajF6WWc1VnQvdFBCNlNJL0dLWEwxYkpjUnI0RlMyMHhFNlRUNEVr?=
 =?utf-8?B?VUdINXFpOTBHUDRuUlZwYzJqR2ZVNytnRmRZSFVzeGNtNGlpTFZ5QXJFb1ky?=
 =?utf-8?B?UW9RVk5Cek1ZVm9FWW9lcCtIeFJTcU8wWU1xQkhnNXZHUHNDWnZ5YlY0bkd0?=
 =?utf-8?B?S3BmK2hUWVRNcnk4UDhKb0xsOFZVZ3Axc2FWSGQvVE9VRHhWbGw4VkE0QVhz?=
 =?utf-8?B?VGFya0JyQTd3V0pTQm43RStnNjVKdVRKc2RhRWFzbUJFZjJGYlpOcUx2cTdX?=
 =?utf-8?B?WldZeXZvTHlZZ21oYzJDSkU2alg0bkdXdU14aHFsNjRZVUdvZWhaVWdmK0Fy?=
 =?utf-8?B?eXJRTDVyM1A3M1kyVWE5R2o2dFFoWWU1WnpOUXhqd3Bqc3gwK2dvRXE2U3pI?=
 =?utf-8?B?SmRjOXluSDIzNDhhVGhJeU8vS0FwSjZnZEp5Mk8xN1FoUW1Gek5TVmMyQ0ZI?=
 =?utf-8?B?clUrU0tldGJiVG1DN01YMm1Jc1pFRzJOQ1Q3am1iemZ6WnFWem5INGlIOW5S?=
 =?utf-8?B?dFpiVjYxTm9UN3N1NndneXYydFY3OGNTdjBmczFjSS8yOFVyeFkwOUxtNU9P?=
 =?utf-8?B?WHlvd3IrSmhRWGJYeHZRdnEvTW5QRW1acTFTUDN1VlJ6WkVxN05xNmhIVGVZ?=
 =?utf-8?B?WktSbDM2emxHNHBqcEJrelppbG1VQ0RkbGlTQzRIbU9WQi9yMG5MRzVDM3F2?=
 =?utf-8?B?cjBHcFY3ZHJVK2NveCtyRGtHaUR1UlRwRjg1L0J1UTlYK2NtRFRuazY3M2tS?=
 =?utf-8?B?TXh0VnZZeU9memJLODF6Wm5YSzZUYytCY2RTa3FsUWlWN2JBajJTTWt5T3U2?=
 =?utf-8?B?cTZhaXcvYUZ0MVI4a3J4bmxVYTZmVnpucW5EZUNrcWdRSDh2L2EvMHV6UzRK?=
 =?utf-8?B?YzRCa3Q2YlpuR3pYSnJiTGtEbVZsTUsxUG5Cb2w3dzBJMzRuOUFRUSs0WEJv?=
 =?utf-8?B?WDQyQnFqSFpqZjlzRk5UenNGcHgzU0d5SHk4cklldDh0MHNtc05xLzhySW1S?=
 =?utf-8?B?SldTK2tXdGNlTENhMzg4N0tlZ045dGFiWDNGYS9rZDB5UlpoREZkMXJwNVFW?=
 =?utf-8?B?U2ttNzN3c09oWkpzcUlnMzFoOE9mUE9abklISmwrN0RiZEliZmNQWUpocEsz?=
 =?utf-8?B?NUl4VlZYR0pYaWNuYVZLc1lwL0dKdU5YemhIblRoR0VtZ0I5MFhuM2hqWVRX?=
 =?utf-8?B?VFMraHpnQ3BWb2tScEhhLy9hVnV6a2IyVXEzNjRjNGdGSDk3dGlDYTk5b3Q4?=
 =?utf-8?B?MG1nKzFMMitTOGQvbFJpd3lveVBwL3Y0cU1lU3dPMXA4ZmFnWHdoemtRSEti?=
 =?utf-8?B?NmZtWEJ1Q2o5YUdqWU1HUzJrWTluUjVydThaVVYwUUhnRTY2UEtodm1ScUhZ?=
 =?utf-8?B?emEyaVZ4L1RKcThFWVV3cVZYMjU4eCt4eVJ3WTBSQkFoVnVnMEhiRWhMd2Rq?=
 =?utf-8?B?OWt0TzVSM2ljUVYxYzZCbDlIVmNwcHQvL01hd1dZZStWZFRCczNKaVZXWFVx?=
 =?utf-8?B?Qkp3VnlvRGVxTU5QNE9KdGJjZCtLOEFRaGVzNTBmRkRrZEFOUTRheldLZEpm?=
 =?utf-8?B?TTJhREE4WjBNbVBpanl1NUpOOXFRSSszSE9rYTcwRlBGYWZVNlU1RkVSSEd0?=
 =?utf-8?B?Tmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 49999138-5bc5-4c10-e4e4-08dbc691c2f4
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 17:29:14.9654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LMiiqoafAaoMiWM8TshP2LtEUC2YQVmjQ1AWsTtyeZ+TTcii+B4xZGkSNtnvcho9PA9iSzsYd++Fe6QwxQ8pfqC74wV6GHquXjV1DxFS51M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8696
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/6/2023 5:36 PM, Rafael J. Wysocki wrote:
> On Thu, Oct 5, 2023 at 10:39 PM Wilczynski, Michal
> <michal.wilczynski@intel.com> wrote:
>>
>>
>> On 10/5/2023 8:28 PM, Wilczynski, Michal wrote:
>>> On 10/5/2023 7:57 PM, Rafael J. Wysocki wrote:
>>>> On Monday, September 25, 2023 4:48:35 PM CEST Michal Wilczynski wrote:
>>>>> Some devices implement ACPI driver as a way to manage devices
>>>>> enumerated by the ACPI. This might be confusing as a preferred way to
>>>>> implement a driver for devices not connected to any bus is a platform
>>>>> driver, as stated in the documentation. Clarify relationships between
>>>>> ACPI device, platform device and ACPI entries.
>>>>>
>>>>> Suggested-by: Elena Reshetova <elena.reshetova@intel.com>
>>>>> Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
>>>>> ---
>>>>>  Documentation/firmware-guide/acpi/enumeration.rst | 13 +++++++++++++
>>>>>  1 file changed, 13 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/firmware-guide/acpi/enumeration.rst b/Documentation/firmware-guide/acpi/enumeration.rst
>>>>> index 56d9913a3370..f56cc79a9e83 100644
>>>>> --- a/Documentation/firmware-guide/acpi/enumeration.rst
>>>>> +++ b/Documentation/firmware-guide/acpi/enumeration.rst
>>>>> @@ -64,6 +64,19 @@ If the driver needs to perform more complex initialization like getting and
>>>>>  configuring GPIOs it can get its ACPI handle and extract this information
>>>>>  from ACPI tables.
>>>>>
>>>>> +ACPI bus
>>>>> +====================
>>>>> +
>>>>> +Historically some devices not connected to any bus were represented as ACPI
>>>>> +devices, and had to implement ACPI driver. This is not a preferred way for new
>>>>> +drivers. As explained above devices not connected to any bus should implement
>>>>> +platform driver. ACPI device would be created during enumeration nonetheless,
>>>>> +and would be accessible through ACPI_COMPANION() macro, and the ACPI handle would
>>>>> +be accessible through ACPI_HANDLE() macro. ACPI device is meant to describe
>>>>> +information related to ACPI entry e.g. handle of the ACPI entry. Think -
>>>>> +ACPI device interfaces with the FW, and the platform device with the rest of
>>>>> +the system.
>>>>> +
>>>>>  DMA support
>>>>>  ===========
>>>> I rewrote the above entirely, so here's a new patch to replace this one:
>>>>
>>>> ---
>>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>> Subject: [PATCH v2 2/9] ACPI: docs: enumeration: Clarify ACPI bus concepts
>>>>
>>>> In some cases, ACPI drivers are implemented as a way to manage devices
>>>> enumerated with the help of the platform firmware through ACPI.
>>>>
>>>> This might be confusing, since the preferred way to implement a driver
>>>> for a device that cannot be enumerated natively, is a platform
>>>> driver, as stated in the documentation.
>>>>
>>>> Clarify relationships between ACPI device objects, platform devices and
>>>> ACPI Namespace entries.
>>>>
>>>> Suggested-by: Elena Reshetova <elena.reshetova@intel.com>
>>>> Co-developed-by: Michal Wilczynski <michal.wilczynski@intel.com>
>>>> Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
>>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>> ---
>>>>  Documentation/firmware-guide/acpi/enumeration.rst |   43 ++++++++++++++++++++++
>>>>  1 file changed, 43 insertions(+)
>>>>
>>>> Index: linux-pm/Documentation/firmware-guide/acpi/enumeration.rst
>>>> ===================================================================
>>>> --- linux-pm.orig/Documentation/firmware-guide/acpi/enumeration.rst
>>>> +++ linux-pm/Documentation/firmware-guide/acpi/enumeration.rst
>>>> @@ -64,6 +64,49 @@ If the driver needs to perform more comp
>>>>  configuring GPIOs it can get its ACPI handle and extract this information
>>>>  from ACPI tables.
>>>>
>>>> +ACPI device objects
>>>> +===================
>>>> +
>>>> +Generally speaking, there are two categories of devices in a system in which
>>>> +ACPI is used as an interface between the platform firmware and the OS: Devices
>>>> +that can be discovered and enumerated natively, through a protocol defined for
>>>> +the specific bus that they are on (for example, configuration space in PCI),
>>>> +without the platform firmware assistance, and devices that need to be described
>>>> +by the platform firmware so that they can be discovered.  Still, for any device
>>>> +known to the platform firmware, regardless of which category it falls into,
>>>> +there can be a corresponding ACPI device object in the ACPI Namespace in which
>>>> +case the Linux kernel will create a struct acpi_device object based on it for
>>>> +that device.
>>>> +
>>>> +Those struct acpi_device objects are never used for binding drivers to natively
>>>> +discoverable devices, because they are represented by other types of device
>>>> +objects (for example, struct pci_dev for PCI devices) that are bound to by
>>>> +device drivers (the corresponding struct acpi_device object is then used as
>>>> +an additional source of information on the configuration of the given device).
>>>> +Moreover, the core ACPI device enumeration code creates struct platform_device
>>>> +objects for the majority of devices that are discovered and enumerated with the
>>>> +help of the platform firmware and those platform device objects can be bound to
>>>> +by platform drivers in direct analogy with the natively enumerable devices
>>>> +case.  Therefore it is logically inconsistent and so generally invalid to bind
>>>> +drivers to struct acpi_device objects, including drivers for devices that are
>>>> +discovered with the help of the platform firmware.
>>>> +
>>>> +Historically, ACPI drivers that bound directly to struct acpi_device objects
>>>> +were implemented for some devices enumerated with the help of the platform
>>>> +firmware, but this is not recommended for any new drivers.  As explained above,
>>>> +platform device objects are created for those devices as a rule (with a few
>>>> +exceptions that are not relevant here) and so platform drivers should be used
>>>> +for handling them, even though the corresponding ACPI device objects are the
>>>> +only source of device configuration information in that case.
>>>> +
>>>> +For every device having a corresponding struct acpi_device object, the pointer
>>>> +to it is returned by the ACPI_COMPANION() macro, so it is always possible to
>>>> +get to the device configuration information stored in the ACPI device object
>>>> +this way.  Accordingly, struct acpi_device can be regarded as a part of the
>>>> +interface between the kernel and the ACPI Namespace, whereas device objects of
>>>> +other types (for example, struct pci_dev or struct platform_device) are used
>>>> +for interacting with the rest of the system.
>>>> +
>>>>  DMA support
>>>>  ===========
>>> Thanks a lot !
>>> Looks very good, will include this in next revision.
>>>
>>> Michał
>> Aww, forgot that you can also just apply it yourself, so I can just fetch and
>> rebase. Whichever version you prefer is fine with me :-)
> So I went ahead and queued up my versions of patches [1-2/9].  They
> are present in the acpi-bus branch in linux-pm.git (based on 6.6-rc4)
> and in the bleeding-edge branch (I'll merge acpi-bus into linux-next
> next week if all goes well).

Thanks, great !
Will re-send the rest of the patchset.

Michał

>

