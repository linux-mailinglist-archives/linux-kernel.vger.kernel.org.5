Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E599D7F330B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 17:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234866AbjKUQBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 11:01:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234507AbjKUQBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 11:01:31 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963BC139;
        Tue, 21 Nov 2023 08:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700582489; x=1732118489;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NwfLgIUEByt32YXeIHorNQ+rG57UYeDHaEg3UFLQlI4=;
  b=GwbI14aaXEkM1ZHXb4AISorL0oESI+FNjPVB1bxnTTLDyXQzWXJNPGPw
   Hv6Q78fhTOsjHGT+OzprHJcEbXkNzDrMAdwW14WYFMlZj9R5qNLVXmkVV
   j6Vcs+b0PMiqRU0x3vgGpUls2sbu38Gru8wNz99RZA6UKRC0VTuhZptL8
   0RWzy81974UifQES4bR8rKx3Tmksq6isYykziIs030QOvhC+wDV5nuhv4
   pbnpfbDc/9z7XPNd709BPIPO55ujWP7SGU+NsYZoaXnANM/wDjgTKVrIz
   XFqe8Wh4BcjDDm3b7VGrsrfwmyNKpm8YuG8h0DzR3B9Fqe4bSYdr4b8ck
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="5063781"
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; 
   d="scan'208";a="5063781"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 08:01:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="890287571"
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; 
   d="scan'208";a="890287571"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Nov 2023 08:01:27 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 21 Nov 2023 08:01:27 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 21 Nov 2023 08:01:26 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 21 Nov 2023 08:01:26 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 21 Nov 2023 08:01:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RM0ZZfTEWr2syxqhESwjynCz1UmMZ4z833g9cvJw4UL/acQJL+F0MmPYiJ4xp/SzsH9p7/rcQtwmrjuGg+eRpYQQO/VBLUBdOZBVgicQTiyuTECbljGMuJmEHzMCo6QrfsE+J/ZarPU7uUcZVGm+EAfSYymIzYkL77lnQTad/CsZLxLU2PZjc+f14VUsFjoO+7qGHQ8E14ZOGjbQ3PVrp/izkv7MNlRKkhvefTBc2U+HEix0RFl0U03eBAVxptx6fY6KU5jiB1eZx4q6/HqBntzKsl6SCUBqcF5SwdHCUd8K+ayDGJ57Q4bGmHCjGd0yP2bSp4coG209A+cP4d2QSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6faMDCxXzs9myphiHwM8wcVrapjaqeLDD6gmn4/owGs=;
 b=F2c8JUkiiPCqvmoVdu1NwvqcBpobRIixFADRTco4RLicdO+GR3u55fQ8BALNUeBcMToDKw7k/c8rKBvXs/7WOEEItyRAmFZCyxVuzgptnCoVORfVybWQMiYo4UnxaJUxpK5oxYfnoHA3dNaj/iKY0oB2YtiO0f5rW+dQMrxS4JMhwOfzrFy2Qu1n+qA0gtG33wavO5hxmX4udnxfF1m92IGPXfBg3ZaneFOvQdsIFIRYI7R3yIFeQ3v3B8pic5PIX8tElZfMP006twmTy3kv72X3XfIbxETHvZ8yJPCJJMeJbuTWeu9uVfdqXBJ3jrRb72XbORvz0P+bK45dxlkvdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by MW4PR11MB6740.namprd11.prod.outlook.com (2603:10b6:303:209::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Tue, 21 Nov
 2023 16:01:23 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1%4]) with mapi id 15.20.7002.028; Tue, 21 Nov 2023
 16:01:23 +0000
Message-ID: <36a3693c-0dae-4ea2-8b7d-f1a0f5148202@intel.com>
Date:   Tue, 21 Nov 2023 09:01:19 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH] ACPI: acenv: Permit compilation from within the kernel
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Sam Edwards <cfsworks@gmail.com>, Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
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
 <736fcad7-f440-4bcd-86fb-4cc73d1b8f37@intel.com>
 <CACRpkdbz=a7yoJdBOrgJXth53d=F7+eQCu7KofUW8s1rBY=Veg@mail.gmail.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <CACRpkdbz=a7yoJdBOrgJXth53d=F7+eQCu7KofUW8s1rBY=Veg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0134.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::19) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|MW4PR11MB6740:EE_
X-MS-Office365-Filtering-Correlation-Id: 86db7df5-098c-4ad4-d851-08dbeaab1bda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sM+QVdGNzqnb+by7TuZBWFRW68bD4lXZT35oM3aQLCrhM4ICampGNgrBebG/s8kkQlQgVhwY8PEJnodfFNa/EcdQ3XsKD+oE9Z8Kn+zNWBeQFbx967pV4hjUQR5p4Q7jPh/KJKk3/KUOlDBiOZLP5nHTrVAdKIbzwnw1Twe3RelPGWHTyaOFkJY/WZzQkkUx8ZknPxkWO9YSmZwswkM41oMyijcwCMKO8P6490t5quZgzL81vhC1IucMP0raF7A5rxI+kCSFeUNVMrYE3ajb65Oo5tpu14olZwWIV4lkO80YIj0KcLC19PsBIJw98n6nZdDhkA3UVHuX/AwgbTHuwhPcAWI2juKgXC6uh5jfo/RLYUYUgJFBih8HPsJ8yQM5vZFEDNAur3mXUhNr6wGIXOErtEA6Sb26N0bm8bzC89S3AWZhJ01aQfzpBjHO/m/BdOWzZ+Q3WbjRcnieBGuDI6YnA9zUulFGV0PUL3vmRN2R7S09Z58Ha8rg5TxlLvOthjIdS133OeoJTo7/kSBIeuZbVv0PzTgJG4z5EA7ASNZ0EnzBlXcrhIlQ5E/hcR2asL6wj/k9bXzrNW7KYHQX5zx9/DLdX2/Ko5cCETuyeJk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(376002)(136003)(39860400002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(41300700001)(36756003)(86362001)(5660300002)(7416002)(31696002)(4744005)(44832011)(2906002)(6486002)(966005)(82960400001)(26005)(53546011)(6666004)(478600001)(6506007)(2616005)(6512007)(38100700002)(8676002)(8936002)(4326008)(316002)(54906003)(66946007)(66556008)(66476007)(6916009)(31686004)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OE1hS2F1bGs1Y213MGVtblZaR1F1L1docWVEdFJiU1Jsdnc4TGRJSjRnNE1l?=
 =?utf-8?B?K1kzWEoyRmVVaU1Wc3dmRGNhbWV4ZC9ESDhpUERsRkw5SVR0L0sxRXNUQVU3?=
 =?utf-8?B?U1paUk1wa0dEdnc2ajJ2M3J6QW9mNFNkMmZRYmo2WGtXeVJKb0lRL3lLOWhu?=
 =?utf-8?B?Mmhub2UzWUZwUWNjbm9RR0ZwelA4a2syMUhudW9WZXMrTm94dzhQR1N3d2Er?=
 =?utf-8?B?TVZXMHBxcFRkZGJUSGlVZ1dxQ3N5eWxJOFBackEyMmhzblhrSVdRVWUwbXdu?=
 =?utf-8?B?eXZjRHpMUjZTVjdEWUpmYy83c2FLMVhaeVVncWZqUU1jRjFjYmJGT2Zrd1FQ?=
 =?utf-8?B?dm1jSnNoMjdkOVdtakhNa3FHNy9GOGNITkZ3VXI4K2dvZXh4bFNxbms3akdB?=
 =?utf-8?B?aUdsQzJkTTZEYUJFR0dTdUNCRks2clQ3eUZWTXBkZ3p6RERyaDlvQ0Y0b3cw?=
 =?utf-8?B?NUMyZXU4U294VWxVMHNncVZBT2M2KzhXUERwUlE2ODUwaFNxSHp5S3JHSFkw?=
 =?utf-8?B?NjVWOG45MnRDRWx6RDBnQzN2Z0UyOXBXZWJkaElzQ203RWtJNVdSR2J2TkpY?=
 =?utf-8?B?TU44S1NTTEYzUkRKNlZOdjFuVWhESHliL3dpenNhdWhpb3RnVXR0N3dRbmZY?=
 =?utf-8?B?TzlnWmJZWlVhMXV4dUR4akoyTnIzcFFKaktsY1lLM1FvYW9kV0VQTThZN3o1?=
 =?utf-8?B?clNqek8za092ZnhRRHVkcWxaVEdHeVJGVGVGNXF4b3Rha2lReXErQ2JYMlRG?=
 =?utf-8?B?TDQ3b3dVK0o3YXdPeFVmR1RyZ2FkaFZKeWVURHBCVmxreWFKellKNWpPcWs0?=
 =?utf-8?B?UnFKSWtpUkJqWEdqRDd5d2xYdm5pUnZvWmFaSkp6NDhXVGNsTFk0RWdHWTdO?=
 =?utf-8?B?RjhnYkczYWYxTjN5UkhhMUllSTEvSmZEMnUxNlZ6UnB1Rm1LV0lkZGRnSEly?=
 =?utf-8?B?VDJ6bDRTV3p1dUJTSGRVOStLOE1MMnRqWS9wNy9naHBERm16Vm91dTRrYm1J?=
 =?utf-8?B?Q2tzd1R2SW82amhtMUZ0djBRdWVET0FOQ2VoWXVRM0U2a2lmY1pBWWxnS0xD?=
 =?utf-8?B?aUFVVmJJOXVnenJCTWlKMkZmcGtiU29MMW9BdG8yQmV3clkwUUttaENHMkl6?=
 =?utf-8?B?NUtPczdHdmNkQTJ4ZDBaRDJuY2ZZK3FKL0p5UVlEOEF0WFBwSEJqMEEwTmFR?=
 =?utf-8?B?Y1ZtOUJiOGxWNldrS2J1QkJzT2ljdUNBWGRoV0Z3UG1zaXA3WFpTcEU0T0E4?=
 =?utf-8?B?TXMyMFRRMjQzZnJmS2FaZTBEc0ZDWHIrMGVvMW9JL0xQRWxTUmlEUXJTUDAv?=
 =?utf-8?B?QUw5SnZEWXNVY2lyaDZaamFyeXlWZ3pyREZ4b1J0VlV2NUdZN0c0ZDdOb0wz?=
 =?utf-8?B?Vi9JdnFtbi9Kb2tJUjBHM3Z4ZGFEZVBGZFpQUXFHQ0hiUXd0WUxrMnRXMHF6?=
 =?utf-8?B?RStUeDE3Mm9QbVpSL0pMb2JSMTNEQ1kyYUlLMGk1UjFFTm9ESjVxb1VUNHpN?=
 =?utf-8?B?Zkd0SXFDVUQ4d2VIcythWERZak1RL1pQOFY5NVRmTExya0pSSEgvWUQrVEND?=
 =?utf-8?B?dWE4cys4ZXBJSXU5YmZVdkxQazY1SlppT2tFV2hwbE9sMXdrM3gwekxnRTU1?=
 =?utf-8?B?M25HVm11Kzl0cE01Nkg4cXUzaDk3Wis1Y282V1Qvam5yMldTY1pORXNVcnRo?=
 =?utf-8?B?c2UwYmtOL3lQS3ZSaUVUZWttM3dUTThsR01CakJhejBSNEphYUZoUHhMamN5?=
 =?utf-8?B?RUJQcU5Pekg3eHV0WGp0YUZSUitrL2dod2REQ2dveUNRN0RFMzQ3K1pDMlVC?=
 =?utf-8?B?ZUpFZEhmTVB6a0c0dmRvVnE2a1U3MFlweUlDdmpRUlJ4QUVsa2FoN0kvMTJT?=
 =?utf-8?B?QTFpVzNXbU1PT0JtQzZLUm5HN00zUTZGRlIyWjVnV2l2czJrQVZMWUxsUmFx?=
 =?utf-8?B?N0F1SlVPaDU3a0ttUTh3WkJQaElGWUlwZnYrZWhTZElQZU9FY0o1WnZIQml1?=
 =?utf-8?B?b3dyOGNnNkVJclJJME1WUytUUmpoVk9pbnRQQ0MrQzZDUXhIUEdkZVoxSnlN?=
 =?utf-8?B?RmlaVTFCaHk0anRxVyt2Z0tKcFBMNnRwVk83eWhyaiszcEErNGJoUEZjYWVy?=
 =?utf-8?Q?K6rvoqOfvBYKdBpwIzE8s5P8j?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 86db7df5-098c-4ad4-d851-08dbeaab1bda
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 16:01:23.3563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T00ViX21HrbheH1N/nIYVMUpMsUvO/vDT7GuNfFEpBLrBbgzrMLuY8lrNriwPeYhgVwMxvb6Sml7o6C3Ll9xYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6740
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



On 11/21/23 06:32, Linus Walleij wrote:
> On Mon, Nov 20, 2023 at 5:53 PM Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> However, if I move fw_table.h in linux/acpi.h below include of asm/acpi.h, then we
>> can build successfully w/o including acpi/acpi.h in fw_table.h.
> 
> This looks reasonable to me, can you send a formal patch so I can test?

https://lore.kernel.org/linux-acpi/170058229266.2356592.11579977558324549374.stgit@djiang5-mobl3/

Thanks!

> 
> Yours,
> Linus Walleij
