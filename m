Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC577F4B53
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 16:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344458AbjKVPob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 10:44:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235284AbjKVPoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 10:44:20 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B44D44;
        Wed, 22 Nov 2023 07:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700667701; x=1732203701;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/q6Q4PmrOVS1ASyyP+sVyD6k5JNQQUzIbpg4c4+ZHi4=;
  b=HweryssW7NYnVVQPNRZa5py+TqSp6/CFpVSnQ2PRcrXxekQEgAqlwq0B
   pHxRR/jfZXGPaMjcIQG04XZzMpYs3nr6SKYQjE03kjMU+vt7AWocxanA/
   lgOmbnR1wB+ZLxId9ynnm50lZGx4jQt0DRCr9Uah87oWDDVKJ11/Mjryw
   iLYwdzTRHIQoTcFSPfdb7Gs5EAdW9ntUjkD07WlVjrnPik7lt6tNg8p0X
   m7UgRvbmOlCaPASO4tFA1NGD1kG/GHmOLji0kJJfxFmqDwTmPaXJ97hsL
   mdz2RdePRsLPWEANUChPDoI77FdldGFuy0QtklRiqzpb4ttEvTfNAANQa
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="5277543"
X-IronPort-AV: E=Sophos;i="6.04,219,1695711600"; 
   d="scan'208";a="5277543"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 07:41:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="1098459969"
X-IronPort-AV: E=Sophos;i="6.04,219,1695711600"; 
   d="scan'208";a="1098459969"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Nov 2023 07:41:40 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 22 Nov 2023 07:41:39 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 22 Nov 2023 07:41:39 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 22 Nov 2023 07:41:39 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 22 Nov 2023 07:41:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oftBAyZHrBir5i1l/wO9DHLIqjNHKbvEk7BIvEaj+s8Pyzz9TFIuxgLjnCToDnITYfwII8JLjxZGec5jau28w4xe4KTvg2OGrzh0Rknq2x9GNip3r9St32e/SRUghWHqXlmJ5lO1EgenNbt72RvslcJtwJw1WN7L8lFMWQLS4HySTv9TkdZ4hx5BEGHCQJ+Z33RReEu1psoo35LW06oFEN3H3Qfj2Zvox3ZhVGA1ikJVBHG0qJmuVrE4Vq0/Netkf6x+UIH1hFLc1Lgt8IAixNzfur0hB9wE78GAxK80I0Jv4cxAbPaPynHlB79YRr70zmVnYmOdM11W2bDk0eLycg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WaOwZQOa/geNQxcOJQo6Vdtr45GugC5Y4YuBFrSAPCw=;
 b=B3S9ZtEw0sQ6r7bg31YvsKmnxa1yfYSinBMHyxe1emMZbIXNW3mofJW02nDxhg3li5WQz8JEBTGyshTVirdr5m9yrtA5RUZhYKuVAFyha7IxWXoq1xrnvxMF55Z1mW24Mh4+7mlfoKY/W6/0emV6y3kXxvbxWXuyGnCqYC6FcXQNNUR9aotr+d4UgjWAi6hH6X+RyyhrT0zV7qnsPQhSNi4InRVp7KrbeC3jIG50dKujEuLb1MUQMJ+/MPm3ufeQp9hCSN6d8j2I+Fhucw9gUD9USyZz6+MLT5yFX/ur8jNYnLM4w5CzAlrn4ohPQVXUfY1RdvEu4vLwb4lsrt/NNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by PH7PR11MB7074.namprd11.prod.outlook.com (2603:10b6:510:20d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Wed, 22 Nov
 2023 15:41:36 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1%4]) with mapi id 15.20.7002.028; Wed, 22 Nov 2023
 15:41:36 +0000
Message-ID: <55523a34-cd9b-4324-b012-cdea24c4b810@intel.com>
Date:   Wed, 22 Nov 2023 08:41:32 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH v3] acpi: Fix ARM32 platforms compile issue introduced by
 fw_table changes
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     <linus.walleij@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        <lenb@kernel.org>, <robert.moore@intel.com>,
        <Jonathan.Cameron@huawei.com>, <dan.j.williams@intel.com>,
        <guohanjun@huawei.com>, <arnd@arndb.de>,
        <linux-acpi@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <cfsworks@gmail.com>
References: <170066723324.2477261.2506149141979712937.stgit@djiang5-mobl3>
 <CAJZ5v0giyyhZdkXW7AvZtZZHFNaFxrYKtdZkvthtuB_bXGqt1A@mail.gmail.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <CAJZ5v0giyyhZdkXW7AvZtZZHFNaFxrYKtdZkvthtuB_bXGqt1A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR07CA0097.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::38) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|PH7PR11MB7074:EE_
X-MS-Office365-Filtering-Correlation-Id: e015263d-6ae5-4baf-0a84-08dbeb7182cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HTUT08+pseAn3mYZohhaNP+lNjsU8dy747pK/yctpdgkzlpmfCcAtqJHU04UXVuLsr7kaxRHDjbaCrSGmRt4EEIzaZpRBY16vuj2bI9X346GXNIt89bPOPyK6mBD6egnCAp50YrJtCU6RzMTERCJzeT8nsU5l5uV5FQIftU8w22tRXBwtnpfeGuNvnBx804v2nryzWpNl31nfnVvlsC0fmbMOSN45zKup7kX6qtMQec/hBDVI5KRD4ZazVUjbwSsVe+QoEVIoUQaVPrI+fFm0MN5qoz2bvsuu+fYMeMv4tys2k+7rURBevIFS3b+yw7x6FKrXrIWtJBaI0mO4fdAWpkAqeaaMIWAYcP+3RZyv1WvyRXCYUqGQ8paMpyT5Ovha0OaN3JGxaKCQOFG/js9MFkcemd1T4QaDsOM7yrcNZP9T++Q5d0jYLby363JQopqjtwIerh3T9A+mFSV7/LMtvqf3EjtI+7Y4WZw70PeqI+Ja8SqsomyGxPszvcuxe6Bkl5dC3mhMnCH1zFN0s5zlpryoiz224S9OZwWxDjQZMokQpT+/0LGPhOnhTLJ9bJqH1KBGyps5GDBoQIJKeTJ7FMxBYEdl5qz7hHkwZBYCLejHFCn6FI9Ct22MjJelQvSaDtLzOG08/RkhILzpZtDrg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(396003)(136003)(39860400002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(5660300002)(41300700001)(7416002)(2906002)(44832011)(966005)(6486002)(82960400001)(6512007)(26005)(6506007)(31696002)(36756003)(83380400001)(86362001)(53546011)(2616005)(8676002)(478600001)(6666004)(8936002)(4326008)(66946007)(66556008)(6916009)(31686004)(38100700002)(66476007)(316002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFlmMFMzL00rMEdrYTBCOXUzUlYzYkhkZVRZd3VjRFdsYjYwOU5GWjhCVGE1?=
 =?utf-8?B?TlNLWDZpNWR3cklPd3dYWWRTcU9NcmZ2SkdhK3JJaGZKNjNEQUVKWFd6REtp?=
 =?utf-8?B?M3dJd2R5dmJReGpMbXpiN2RkWXFmaklvemNsOFlHMEVqWnN4dU5BU0JuM3VY?=
 =?utf-8?B?TVowSVJ0a3ZTKzZFNktJWXJ6RU45WlRrOEY0WDd2VzRqbkk1eXNIeHo4WkVG?=
 =?utf-8?B?M09KR0ozYmxuT3UrU1FhdS95ZGF4a0RlZWx4NERwR1lmM0dKbktFUm1PNDRY?=
 =?utf-8?B?Y0FsOEpGbFdNMCsyU3lJYWk4Y3E0d1RzZyt6Y1o0N3RMT3FaUVpmNXhTOVFP?=
 =?utf-8?B?czhHblhNVTJjNjJ3YUhWTVJGaFBZLzlNOXpBTG1oY3YzUzBPUU14amxuUkYx?=
 =?utf-8?B?SDRDK3diVGQyaGltN0dCampidDNXSGJzOEpJdWNRaStINUc2dUJxNWhRZk9D?=
 =?utf-8?B?V0tHbG9pMm1vMTN6UlRFd2IzQ1ZjRzE3ZGM0ZlRWTFRLNVFjS2VMdElSY1Ux?=
 =?utf-8?B?YkswM2pQNlNoSXh5aUVTQy85eVVOZExaWnhMME9EQ3Z4d3ZERWNwU0ttakY5?=
 =?utf-8?B?OVN5VUJRTENDVkFKbnM4T054Mmw2dFo0SXlaSGdKRkwxcnJvcXlnR09QRGpY?=
 =?utf-8?B?Z0l5dUtnNUV6M2ZXampGV3RSUFkrNW1YWFlRRERadXV0YTh1RHlEVDVpNHJN?=
 =?utf-8?B?RlZ6VW13WlYwa1Ixem9IZ05CdkJxOWVBQTA1LzRWZnlVY3YyQnpNQ253UmZz?=
 =?utf-8?B?UXhPM2dsWkZjNU43UUFQYm5nTlRPK0p4WEVPaDNYNHQweThmTk5acmRua3A5?=
 =?utf-8?B?NkEzNjdpakdQdkM4azJRT2xyWmk4eCtwczRLRStzb1o3QjBObkxQYlpnT0JS?=
 =?utf-8?B?bHVaSTRrK2RreFFpY0k2OEFhazZWTHhpYUVVRzltYlF0KzJqZEJLbUVocTNs?=
 =?utf-8?B?VGF5RHJadXl1ckVpNEtiQmcxaDZZeU4wS1RaaHdOUXBMbkpwcmtQRlFEVytl?=
 =?utf-8?B?OWdrR0ZUOStJR1NoSGMrb1lRVVpSZXJheWpSc1l5NXRyRzVYcDZFMEh1SzJz?=
 =?utf-8?B?TGdNNFBLVTBDcUExaG9lVjhCS1JyWi9wdFVjOEp1ZWxJaGlWd1NNVVEyaFlm?=
 =?utf-8?B?NDE1dXcxN1VZT2lURnRmUDdKVDlxcVRTbU9lSEROOHBOZ0ZPWCt6ejFaVmlX?=
 =?utf-8?B?b21jaWR5MzBSZkllS1A0S1VTUTFpc0lMWloyMDZDeDh0KytsUjBERTZMNTlj?=
 =?utf-8?B?T2F0eFRxaGx1R1lBMlpLRGM5MFN5bUVKY0tqMEpPUk1Gemo1VnVuaDA1R1dC?=
 =?utf-8?B?NElZUmd5bDNHWS9wOFh3c1lJNDlIa0huZnE4aU12ZC8xMWVsUHFyVWRYTXl4?=
 =?utf-8?B?OFQ0c1RxY2FxWFlUVFJvTjc2SVN2ZWpLby84SXkxNmRwUEZsMmMvaEhMRWRC?=
 =?utf-8?B?eXoxcEF2RGhJeUloV282aS9TeHlFakd5aFdwYmQ2WnpreFlJMXcyN0FyUWow?=
 =?utf-8?B?dXhoWnFCNStwb1Fxc3huK2RZVFN6ZkJFdXFDakQvbzU1U1VQaFlmTXZsNVZa?=
 =?utf-8?B?aVpWeWJXQy9qd2p4U05XYVYyczJzbnh6dTdtTndWSnJJMWVEdURvMW45bHNN?=
 =?utf-8?B?Y0tOL0tJOXNQLzVLeUR3MTBKdUo5QitzVU0ySUY1K2M5K2haUXZzVUJRUzBu?=
 =?utf-8?B?T0kzdk9nS2FXS1Zud2hwYWRWZ21oMks4anpaeGlLMUpBVWpJdXVxU2JYQ1lZ?=
 =?utf-8?B?dGNReWd2NlVTK2hld1pSS2V1b2JZcFIxSFJwT0RxeVRZb2FENHhoaHcxdlNl?=
 =?utf-8?B?Mm43cm9pYXI3TU9QdzI4cTN1QXRGN3BpV3FCWVRSVDNBQUJnaFhBaUQ1MXdD?=
 =?utf-8?B?dHpsbTNCaCtWczJ3dE1HQnpncWd4bHlFOFFaZEU5TVZDUjBCdGFJZXJtTVB4?=
 =?utf-8?B?eE1KRWVBWTFyWTl3NVBsUE0yb3JiY1dHNVNtOU41ZG80aUhjaS94TGtJTnZr?=
 =?utf-8?B?aEJkVEgzR3YxS0MwVDBITDhxSGEyYzN0R2s4S2hROThlYmwvSHpLK1F3TnlJ?=
 =?utf-8?B?RS9DeVhEZGhGTVhoNkZ4Qzc1SHJ0TUJuUk40YkFYbUVsajhnS3BtVTN5SFpZ?=
 =?utf-8?Q?wrSbd/YE9G8xket9J5pLS61jE?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e015263d-6ae5-4baf-0a84-08dbeb7182cc
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 15:41:36.2703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q9xZyp0PeO/12OzMIgrTboXCaEifGLP1JWFwBF6IuQMYsy52+CH3AVK3Lk27fIvUJzUn51ES3mBUd3YIU8/tmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7074
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/22/23 08:37, Rafael J. Wysocki wrote:
> On Wed, Nov 22, 2023 at 4:34 PM Dave Jiang <dave.jiang@intel.com> wrote:
>>
>> Linus reported that:
>> After commit a103f46633fd the kernel stopped compiling for
>> several ARM32 platforms that I am building with a bare metal
>> compiler. Bare metal compilers (arm-none-eabi-) don't
>> define __linux__.
>>
>> This is because the header <acpi/platform/acenv.h> is now
>> in the include path for <linux/irq.h>:
>>
>>   CC      arch/arm/kernel/irq.o
>>   CC      kernel/sysctl.o
>>   CC      crypto/api.o
>> In file included from ../include/acpi/acpi.h:22,
>>                  from ../include/linux/fw_table.h:29,
>>                  from ../include/linux/acpi.h:18,
>>                  from ../include/linux/irqchip.h:14,
>>                  from ../arch/arm/kernel/irq.c:25:
>> ../include/acpi/platform/acenv.h:218:2: error: #error Unknown target environment
>>   218 | #error Unknown target environment
>>       |  ^~~~~
>>
>> The issue is caused by the introducing of splitting out the ACPI code to
>> support the new generic fw_table code.
>>
>> Rafael suggested [1] moving the fw_table.h include in linux/acpi.h to below
>> the linux/mutex.h. Remove the two includes in fw_table.h. Replace
>> linux/fw_table.h include in fw_table.c with linux/acpi.h.
>>
>> Link: https://lore.kernel.org/linux-acpi/CAJZ5v0idWdJq3JSqQWLG5q+b+b=zkEdWR55rGYEoxh7R6N8kFQ@mail.gmail.com/
>> Fixes: a103f46633fd ("acpi: Move common tables helper functions to common lib")
>> Closes: https://lore.kernel.org/linux-acpi/20231114-arm-build-bug-v1-1-458745fe32a4@linaro.org/
>> Reported-by: Linus Walleij <linus.walleij@linaro.org>
>> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> Tested-by: Linus Walleij <linus.walleij@linaro.org>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>> v3:
>> - Drop fw_table.h in fw_table.c since acpi.h already included. (Rafael)
> 
> Do you want me to apply this, or do you prefer to route it in a different way?

Please apply it. Thank you!

> 
> In the latter case, please feel free to add
> 
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> to it.
> 
>> v2:
>> - Remove linux/acpi.h include as well in fw_table.h. (Sam)
>> ---
>>  include/linux/acpi.h     |   22 +++++++++++-----------
>>  include/linux/fw_table.h |    3 ---
>>  lib/fw_table.c           |    2 +-
>>  3 files changed, 12 insertions(+), 15 deletions(-)
>>
>> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
>> index 54189e0e5f41..4db54e928b36 100644
>> --- a/include/linux/acpi.h
>> +++ b/include/linux/acpi.h
>> @@ -15,7 +15,6 @@
>>  #include <linux/mod_devicetable.h>
>>  #include <linux/property.h>
>>  #include <linux/uuid.h>
>> -#include <linux/fw_table.h>
>>
>>  struct irq_domain;
>>  struct irq_domain_ops;
>> @@ -25,22 +24,13 @@ struct irq_domain_ops;
>>  #endif
>>  #include <acpi/acpi.h>
>>
>> -#ifdef CONFIG_ACPI_TABLE_LIB
>> -#define EXPORT_SYMBOL_ACPI_LIB(x) EXPORT_SYMBOL_NS_GPL(x, ACPI)
>> -#define __init_or_acpilib
>> -#define __initdata_or_acpilib
>> -#else
>> -#define EXPORT_SYMBOL_ACPI_LIB(x)
>> -#define __init_or_acpilib __init
>> -#define __initdata_or_acpilib __initdata
>> -#endif
>> -
>>  #ifdef CONFIG_ACPI
>>
>>  #include <linux/list.h>
>>  #include <linux/dynamic_debug.h>
>>  #include <linux/module.h>
>>  #include <linux/mutex.h>
>> +#include <linux/fw_table.h>
>>
>>  #include <acpi/acpi_bus.h>
>>  #include <acpi/acpi_drivers.h>
>> @@ -48,6 +38,16 @@ struct irq_domain_ops;
>>  #include <acpi/acpi_io.h>
>>  #include <asm/acpi.h>
>>
>> +#ifdef CONFIG_ACPI_TABLE_LIB
>> +#define EXPORT_SYMBOL_ACPI_LIB(x) EXPORT_SYMBOL_NS_GPL(x, ACPI)
>> +#define __init_or_acpilib
>> +#define __initdata_or_acpilib
>> +#else
>> +#define EXPORT_SYMBOL_ACPI_LIB(x)
>> +#define __init_or_acpilib __init
>> +#define __initdata_or_acpilib __initdata
>> +#endif
>> +
>>  static inline acpi_handle acpi_device_handle(struct acpi_device *adev)
>>  {
>>         return adev ? adev->handle : NULL;
>> diff --git a/include/linux/fw_table.h b/include/linux/fw_table.h
>> index ff8fa58d5818..ca49947f0a77 100644
>> --- a/include/linux/fw_table.h
>> +++ b/include/linux/fw_table.h
>> @@ -25,9 +25,6 @@ struct acpi_subtable_proc {
>>         int count;
>>  };
>>
>> -#include <linux/acpi.h>
>> -#include <acpi/acpi.h>
>> -
>>  union acpi_subtable_headers {
>>         struct acpi_subtable_header common;
>>         struct acpi_hmat_structure hmat;
>> diff --git a/lib/fw_table.c b/lib/fw_table.c
>> index b51f30a28e47..294df54e33b6 100644
>> --- a/lib/fw_table.c
>> +++ b/lib/fw_table.c
>> @@ -7,7 +7,7 @@
>>   *  Copyright (C) 2023 Intel Corp.
>>   */
>>  #include <linux/errno.h>
>> -#include <linux/fw_table.h>
>> +#include <linux/acpi.h>
>>  #include <linux/init.h>
>>  #include <linux/kernel.h>
>>  #include <linux/string.h>
>>
>>
>>
