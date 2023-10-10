Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 921F17BFF29
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 16:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233094AbjJJOZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 10:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233053AbjJJOZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 10:25:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3CEBB6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 07:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696947951; x=1728483951;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZG1CI1BsHzHwm3InhUmenCHVhAeMcbcPAtyVwhmLx9k=;
  b=mn/d0m0pFSf7nQGzGMqfQwgH+7/uSkowautQ7+mgbKzngHIUesW+nVbX
   obZEquq6XxNi9PvjSmTdU+hWTkt0RV8gAs6yqtDVAJlAxE85YarPnsSjt
   fzU0mQ87skldCl39dzjdg94a12Ni5yFE7Fj34MnO5zpRHD33zXb35dNNA
   yusw+rm7u5yV4ViMK94iTy3taV86P6dYzd3ws9SkWSvk6x6AyYRQGy4ed
   zNXOBgeRb+b8MknzLanG0t3ChrTj7PXK6QQkzeS/v7HeY4liEJazBWg9T
   xnZSnaI3LewTyeHZ4MTtqD9/GKZMohyE6apWcte7kffmAkfMBlByD1dMu
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="384265157"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="384265157"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 07:25:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="927157854"
X-IronPort-AV: E=Sophos;i="6.03,213,1694761200"; 
   d="scan'208";a="927157854"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Oct 2023 07:25:50 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 10 Oct 2023 07:25:49 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 10 Oct 2023 07:25:49 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 10 Oct 2023 07:25:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ALYqofj/OXbe86snOQoo1QPjh+rtUfojC+xliANK4CyDuNBlCDjuLSoX2kJA5GiW+oDRWZSC1lEE4RSBeamCLcaRFACCsCEx1n/Iyrg4USfJkvPBguqyPubkEb0RNURJdyqo9dc+KsPHVV2Ro2+y4h07Oy6haHTfSrv9tyjYDvOg5XWaPBroXZjnE/BRC0xWw2mgB6CD8SY+3WN1q4G/cvaGmvtLeaUReeoYqLKEGYvTARV5hcuiQGusmKAvEmlu4/SaxehmPY6p/7zgq669AqtKnqnvXW+ugFwCbNZNBye7iIsCygP3piPR4rTv+naCzRyylGPJ5PeJoeobHvT6Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y7bgd0gzJtaxU//1R53aEvUa6I8Z63c1WySzrOWX4nQ=;
 b=PjKFenC3IGH0NC442/GIsCVVxlIVVmG50GWmZ4Jytsnh5eqtMUS5qk7HCXBwwM7b80R4PrvOn1jgWhHZg04jQBPNvPCQbFgd54yTrgsIT5zYB1CvzWRTFXrnIQcuk+v0GcfDXaDz4v/XOGYHrVo4Rf8lzaWpE5EC0vLzDMyaBWCjUOgv4z1Y5Wsann4t/Isn1W1efJbgwJ8YrCStpGfIklgCUOLJeLLL0hsMhmbfHhndkznXvqnOWNwEyl5y2YuwadXHWRse1UvOK3IxGSI0e0/rabOxrxKL7XGOc8tVNyeSNOOnD+5W2jhtJ6o3GkXFHdVC19AXrkRe1r7yBNSvPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CO6PR11MB5633.namprd11.prod.outlook.com (2603:10b6:303:13c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 14:25:47 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 14:25:47 +0000
Message-ID: <24af5965-3fe9-4aca-83e0-5981f721253f@intel.com>
Date:   Tue, 10 Oct 2023 07:25:44 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/intel_rdt/cqm: fix kernel-doc warnings
Content-Language: en-US
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     kernel test robot <lkp@intel.com>,
        Vikas Shivappa <vikas.shivappa@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>
References: <20231006235132.16227-1-rdunlap@infradead.org>
 <5589e93d-9a9c-4199-a187-ab60fb127236@intel.com>
In-Reply-To: <5589e93d-9a9c-4199-a187-ab60fb127236@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0329.namprd04.prod.outlook.com
 (2603:10b6:303:82::34) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CO6PR11MB5633:EE_
X-MS-Office365-Filtering-Correlation-Id: cb79785a-8356-44ab-c54b-08dbc99ccb99
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5mscYv9sAFDO/pKuca2Kw+NtOPaNPoT5rVE3QoFS0tS1vFe3Xqku3eZ6ocur11yybslsH4kc5jQf+8XEEfipkAwH8+kqnHyXedS8clyB6Xoy8ARtbvxm47+9BEghd5yFMXeEqfmk6jfEQlJCdOiDOhfrfWzgvdT80cyj3gz9yhBxNd87JoIve8uXvCzVxVu2rX6pcABspdHzq0DIbSR9wbzKp+8jERmRj73dM4n9KPjWYuUPGNvycAjevQ6IWQursHzegUMiJXxpO0U62+OMnqUBPdY0BqXpCZWrCcGOSh/gdq1GgYW8dkpGHlDbcOHrCJPx2IUefIHcyYzOijH7FOQ+DocjIJ2Bzl7HGivLunQ+j//0X0TEqeEguBKpBZbV9ASx1mR/9ZwJc64k1VzHGq+C6ux833EPP9Ntp1RF6G5fSsqTpTYp0ydk059GU9ePor1dpiW09gd153J0U6b1qIV/PhqvQ2wLZ6OwOgfBGBwd8P2UoiOzmqm8YxPEB4u0OKjHWbCIbqGhwjy72WaU59LU2INdUYFC04FHfluAc7XBELFZMLI4YjT0XrbGkyhjnYZxrcEDGHZY5ct/3WnVnDfxIooE2LDF6TKSQQQl47Q46ufWDMexqD+eWL9AmIDoRmBVhe5Vy8XEmn+HKh+AFQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(39860400002)(346002)(376002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(6506007)(66476007)(2616005)(316002)(26005)(66556008)(54906003)(66946007)(8676002)(8936002)(41300700001)(5660300002)(6486002)(478600001)(4744005)(6512007)(4326008)(44832011)(53546011)(6666004)(83380400001)(2906002)(36756003)(38100700002)(82960400001)(31696002)(86362001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEQ5UnAvaittdEI3UzdOaWY4TENJV0pVcDJwbWszOUFyY0RydkY3NlNMd3Bi?=
 =?utf-8?B?dHFQQTBhdk1YelNmekFvakhUZEp3cGZJYVBiTGhsTXkyTUpwNzlYbi9oaTky?=
 =?utf-8?B?bzJLOWhFZWY3M3BDSnFiNTdzM0xlN0lIRDY2bzNya05uRHlCY3dmNWpGUzRm?=
 =?utf-8?B?T3NJOGI0b01WSzNkVGpqdGxjRzNhU2JXSm5MMmdqbCsvQmdHVzBlVU9nMHNG?=
 =?utf-8?B?eWJScDhYNEFWNXN4SzdIZ25kMVBqZVNXQzVDOWt0T0RUSWJvaVkzb2JJenRX?=
 =?utf-8?B?bnRyUU5jR2tNTmxoK0grUXdJMEhNMWN1ampwM2VkbnhHaWJncnpPQzdaQ3lT?=
 =?utf-8?B?V0FJNkF0NlRiRUJtM1V1cEVmL0Y2Szd4Nmlqekw5cEU0QWh6OUtxTDlpZTlx?=
 =?utf-8?B?clc2cVZOV2R6Z2hDNDR3a3R6OWN3UjBmNURQVlNNVHREZE40OFFnYzZtY0c1?=
 =?utf-8?B?eEpjVUJQTWJmZ0dPUFRlcWZQSytyK2lxMGY5VVpWMWVUS1doRDlCa0JHeHJq?=
 =?utf-8?B?am4xYy83Mm1aWlBzTzVJeWxtcVYyYmtPcFFlYmJrQ0ExZTdwWGt5UXZCcmZh?=
 =?utf-8?B?NTJjZkFYY1FFZ3o0NjM5NFFmUmxUcjRCY0c3QVRFa2dwYTJuMktWaUFGRnZ0?=
 =?utf-8?B?V3h2b2JRK01WR2l3TnNoTnN6Qmd4SGREZDJDU1VLQjdLdmt0S1JqWWxoZGFC?=
 =?utf-8?B?MFYyRUhFYVdWTWdweExPaWwvZ0N1c2JrODdUYVQrMzZaQWszbXdVYlZnZXlr?=
 =?utf-8?B?YnVCZi9NdFA0azRyN0MzRUJSYTlOeE52cEdjbjV5UVRQTm9FSjdud3VXYU9W?=
 =?utf-8?B?NVV5amFHdGRXQlgrVzNJeElBaklmazdBUEVoL3g1VTFZVTB0RUZNR1hXOTl3?=
 =?utf-8?B?ZW5vRzB5MTkycGEvNnRQUVdYaXRpckZubnZkcS8vSUpMbkFzSUh0Z3BxTUJk?=
 =?utf-8?B?UlFwRGtLVE5GQzRXZnhEM1g2b0JjbThHdytleWNKOGc2UGorckRGVVBuQTJB?=
 =?utf-8?B?VHE1TjBDOXgrek5uS2h4ZHEwdVlDbXRxOHpybUpUZDFuZ3RNeEhOczZHWXc0?=
 =?utf-8?B?Y1c1SGViS01SZ0NXRG9JOS9CUnBUTU4xM3VQcjBFN1dzY1dWMzZxendlNXVk?=
 =?utf-8?B?b25wZW1qd01hVERjai83dEpiaFpLQ0FCSklTTXZHNlVNSktETnFqU3NidDBL?=
 =?utf-8?B?RGFPSFJtTEdsdFZVMGljR0xVYVBrSHEwVG9MNkkvNFg2OU5IdHdmTUpPbTNm?=
 =?utf-8?B?NUpKc2djSkMycDU1YjhwY053QzNoK3NOaWxzOWVsRWVMZDJkeS96TDhkQ1Ur?=
 =?utf-8?B?ajl1NG1jaURGTkVQKzBHcmdNR0EzNHZtZUJWM015cFYzUUd4LzBUQjdDQm1X?=
 =?utf-8?B?UEd1NDdvTFRmYys0TzFaZHpUR3ZUSDJnR3lWNjU4OGIwWGIwQnhvNW8xQ2VE?=
 =?utf-8?B?Mnh1VTVwRVJiSkNOendUbGdMU285aFZ2OWE0VkYzTnpKU00zYUdGNHdJNnJW?=
 =?utf-8?B?NFp1N214MnJCS3FTZTZoQkVxMDA3MWtBa3NPL0I5QUYvM0FPb2N3YzdJMk0x?=
 =?utf-8?B?TTBneVZuUFk3MElaT0lIbzFCY2xMR0dlT0gvcVVKVk0rWDZsY1dYMVpuWmZE?=
 =?utf-8?B?U2pXdkQ4eGh5cUxBZGIvUHFjWmF6NHpHQ2VRS0FUWGxDUkxJaXVkeUFKL0Ra?=
 =?utf-8?B?TW5LQU5LRU1rRTZMMEtFUUdXUnF5TWg1SzNJSTVuaC9TQU5Ma2hLeWxKWXg3?=
 =?utf-8?B?UHBWNWRUZDlSTHBNSWYxRk51bjRUTXBYWU4vcFdLUUZ4akoraCtZM1ltQUhZ?=
 =?utf-8?B?MjI4QVJVWldXUEx3QjEyVVI4WXRwbG5NQUlKTldqQkd4T0pKbUFkc3g1UzZD?=
 =?utf-8?B?SC8wbEFpNk9RaWhBOG1vM0pRWTlDYjJTenVTd2owTWdGWEg0UFdjUXNZTGdZ?=
 =?utf-8?B?MG9MWGZqMWcwUkNxMU0ybUdCYnJ2M1hVbUl3d2E3Y2xCVTRpdXAwN254MTVj?=
 =?utf-8?B?UjVnUnA1eU91Z2QvTTZaeExEVG1vZ3BLM0w4VkhRUkZNZFgyWFhxUDJCK1Nz?=
 =?utf-8?B?eDRCbDBUSldwbG02VDhVUU9SZWFpdmRaM2hNS0tFNTVoemJ2UWxLbklRMHZI?=
 =?utf-8?B?SGo5eUR5OE9xVllUdmZ2WTgwK3dJWHdjV0NUbTlyZXN5OTBtaDlHTmljTnMv?=
 =?utf-8?B?V3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cb79785a-8356-44ab-c54b-08dbc99ccb99
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 14:25:47.2557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cn1RRYytffNwhonxpBRUmX0Z5VTibhQiP5oCEz+NrBFf5FmCB6RwGDjvmOCo2DNJlaevLYxpThGklXdEvA/mpJB+DBzS7m6eFkVVLkhVMQA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5633
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On 10/9/2023 10:07 AM, Reinette Chatre wrote:
> On 10/6/2023 4:51 PM, Randy Dunlap wrote:
>>
>> We don't have a syntax for documenting individual data items via
>> kernel-doc, so remove the "/**" kernel-doc markers and add a hyphen
>> for consistency.
>>

I've been thinking more about this change and I would also
like to propose that you do not use "We" in the commit message.
I understand that you are not impersonating code but I think it
would be simpler to avoid any potential controversy by not using
"We". Perhaps something like "There is no syntax for documenting ...".

Reinette 
