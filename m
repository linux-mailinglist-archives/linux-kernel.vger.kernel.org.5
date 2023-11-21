Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A30B87F3902
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 23:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234536AbjKUWL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 17:11:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234371AbjKUWLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 17:11:23 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E6910DD;
        Tue, 21 Nov 2023 14:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700604677; x=1732140677;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vUmyMV0u5QmWgu48jZpKzbis9yTuzRipz9s2vGB5XdM=;
  b=N4D2MO3fCsEMeSWl/Et4Ty20IciDLBEbYhtfLJhK/p2Wea78/WrorFnp
   4SCtQ6J6FQZ+a/wFs7UE09QhUepqXziQzcl2PbNQisWia5WEfkN4gHMFS
   S8lsUz0LeVZOm5FNchUGUhF826WhJEa8LUDHv0gW5umBBCfbPs3Tn0Fv+
   Ga9rwd34X78Fm6sxeyUfNiJlBbIsDx/ffeb0P0RBTuZfSA25A9HN3WmKo
   UWzh5gy5CHRdz9X8RO7K+AatHfIMLnvH9VCHWECti5qXlk7tTt1GV9+cG
   R8VavYGAaRPePCz1sOAyvpv78pX8ITUXWMKc2jcYFwco8j6Q+6TFP3QxJ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="478143181"
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; 
   d="scan'208";a="478143181"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 14:11:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="1014044482"
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; 
   d="scan'208";a="1014044482"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Nov 2023 14:11:16 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 21 Nov 2023 14:11:16 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 21 Nov 2023 14:11:16 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 21 Nov 2023 14:11:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QOc7rkzogVBBlHz1BeMSJHgE4+8rn5/PvpeBANWAVL3+4h7OpjWlA3RNAI9dXgz0cvsxqbMTwVifFvXthAkrqGaUUvv9cAtHc4UYJT94TL2BR/IZyy3uwWr45BPL3hGcmdWWxkD6Jv/oJ0Q+yoOljGbdXXpgC/NFVzDcMTtKrSygjiGWnkpHb7KQeiHaZjiFaxpBnk+aEPCDvvRw/2s2J04ht+/0r+JrXq/dCpx5DIvV1H7QaI6UvMsj0GTT2vGzMyQ8wLUenMcwQvO9TXaYTT5B0sIG698Z4p8OqC7WdIcpFYGVRnBv1/etSTIu0kLgS9oMk4vYCKcYR9WWdfhjiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ocP2nY6QCuwJRnHL/hmkoDo+1Ls/LvRKKuW/Pk/e0aM=;
 b=K1BGx04YMAzSWsb+XTBvXtTVjkOOXpUtFM+pEB8rvLY6eKvVtFlRfiIe3iOCao5744f+CRsayA+MpPSZpRv0rVcNkhbHnjdi3hpV7odGbA7ieQ3qyK8GyvBr5LHPxsyWjUae3jHnUqvlHp0PlStpxu5dEBbhFs+oXRl1dMAc/GOs9YkamVGxprOGvvWV5OaucONcaPzhn+Skpid1uRJBLvLKOL1WHt7ThLHiHMFSdz3ygS4ck0+5lXXsjZMYwAEsORrQjo0nMnLY7Urtpzr9WvJCQ2LhT57b1U9u4snaK01PWX8tXlShkyfAzYTex14xF7ms4M6qKaEexzTeMC/WCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by PH0PR11MB5015.namprd11.prod.outlook.com (2603:10b6:510:39::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Tue, 21 Nov
 2023 22:11:12 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1%4]) with mapi id 15.20.7002.028; Tue, 21 Nov 2023
 22:11:12 +0000
Message-ID: <316f9176-54b6-429b-9e81-6ac1598a531e@intel.com>
Date:   Tue, 21 Nov 2023 15:11:07 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH] acpi: Fix ARM32 platforms compile issue introduced by
 fw_table changes
To:     Sam Edwards <cfsworks@gmail.com>, <linus.walleij@linaro.org>,
        <rafael@kernel.org>
CC:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        <lenb@kernel.org>, <robert.moore@intel.com>,
        <Jonathan.Cameron@huawei.com>, <dan.j.williams@intel.com>,
        <guohanjun@huawei.com>, <arnd@arndb.de>,
        <linux-acpi@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <170058229266.2356592.11579977558324549374.stgit@djiang5-mobl3>
 <7e4038d8-ef60-f943-a7ba-db59ce9a2aa7@gmail.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <7e4038d8-ef60-f943-a7ba-db59ce9a2aa7@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0062.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::7) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|PH0PR11MB5015:EE_
X-MS-Office365-Filtering-Correlation-Id: b313d6b6-1f46-409f-31b4-08dbeadec5a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ls45jXE0ER5BrPiknv284oOz6S7PGKhSzO/3VdXC8Kfr24QduPPAm6rfTPh2whpnq7PhqOqKeeRayCM6PuxxWSpCvYRItTrH8Lbep0V6TDNnClYG3zdl+tMkNQP0J/BcjZz25P5uwGPSEJsb0+3uS/0nX4OZemm7/5vdRgJZKtRHcysCuI3B0de9ZJF5fjmoJzPbJyrZOymAZ1aElZbZ3ugj9AlAz1GU3pZcTg8FRCwdkiwTjqfDKZ25iN1JvsduvQygu5PLMZGJm+XFnD+w1OROKzTVNH3t1Op+Dm0QxM9wJLh5h7p2vfLgl0gNdSs3ld+MplPRAkmqfXPjP0kNjCf2RanGATVR0kaa1jOI8Y0HjhhsOJEIc3OS+zjhg5xe8mcayoxO47oPIPBLOOATIYnqxISZNChntkUhWDQyz40chbjdWZJyQcMTZ0FJmNVt1j2+roP1xdENGx28zW6/2rBZTyRRf6k5OctRUgTX8/cKwyWR1VRgQwFSytMUjlsEJ9wwGXK+vaCi76gqJyuWF1dX8BvEjh6e5+QRwUSv2FQmo8TQR2nQAwNnxnXSpIvN+nj6TuEHhY1tlPVyTXE+ZO9RmkxJ5cydqtrVf40OVysYfcg0EcIaFqRgm468Y0+l
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(366004)(376002)(39860400002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(41300700001)(36756003)(86362001)(31696002)(5660300002)(7416002)(44832011)(2906002)(6486002)(82960400001)(26005)(83380400001)(53546011)(478600001)(6666004)(2616005)(6506007)(6512007)(38100700002)(8676002)(4326008)(8936002)(316002)(66476007)(66556008)(66946007)(31686004)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2VjVDhBVmh3RXdwbXdzY3pLVkNkcHhYTUZGcjRxU1BqbStIVVhFRVRqRXU0?=
 =?utf-8?B?VHp2WERxQ1JIbDFmWEtmOCtycUtpTm00bjMzYkI2MG5RU25xbWJkdFF1UWhE?=
 =?utf-8?B?Vy9YSlRRMDE0aXFEUVhEenNFZ2tvTzNzUUhHaHBiZjBXZ21QMmxXeEEyT3F5?=
 =?utf-8?B?NmlaMmxvT0tYR1ZvTHU3RE50ME1hTnE5dHNHRUlCeDBZaXdORjRRVjE2ODZ2?=
 =?utf-8?B?Q1RyWTJaMGFxVUFmTDhpQ2dvVjNJUzdwOUM3SlB5VW40ckdLU242Rm12QTNS?=
 =?utf-8?B?NW1UWjhHTzg3RUJiS2RWS3RQUDdpcEZmRWVPSDFLN1VsU1MxdEk0YVp4Z0wr?=
 =?utf-8?B?OGQyNzExSTAxbVhIaTBad1N4dThZdEFvdXJnc1FMQW85cW1FOFg2WlJwaHlH?=
 =?utf-8?B?bXdnT2hyWFBsV2duUUJxQTUxSjZ5ZDMySGdBbEluRndoKzZaR0U4eU9wTzBI?=
 =?utf-8?B?VitYQmZ3L0ZIbkZEb1RuZFl1bTdEdDNQMVVsbisvbzVjZGpqMVJQeUFzZ3Vu?=
 =?utf-8?B?ZUl0N3laeVY5VUNXb2J1Q3V0OC9icUYvekhrbyt3QlZaS3NWMjhLWTdaNkcw?=
 =?utf-8?B?K1owK2NKZ2RJaVVxVG5ZRUtoSzNPU2ZDQk5MZi85U1lJOERLYWRmMUtUYnR3?=
 =?utf-8?B?WGVOQUtiM0VWWVpEdDF2R05yVk5rbmNrM2hlcHRpbmd0RkR6bWh4b3pFZ05v?=
 =?utf-8?B?TU9zSnVtQ0IreHdFN3lxNkdaN2RkN2M2QUo4aE5RZFEwaFJacGhFellyS1VL?=
 =?utf-8?B?d296WDZGWnBBYnJFMkwvQW5YdmJPZUYwZGxMVnc0OXRzRitEaHhaT29hUkx3?=
 =?utf-8?B?SGQrdzVuZS9GZUJyd3psbU5OUGVwQkhvTFdTdUlQNjEvTE0zampVS3J2UnZv?=
 =?utf-8?B?b1FtN0Q2aGZVa2RTSjl3U1dBbHJYTGtNcHpjTk40NHFmTFdGQis4UDVQUCtr?=
 =?utf-8?B?QUU3NmtiakdKenRDdnFzTU1qTHhiWXp0TldNbFpKenVvOCtwY3ZVL3dNa1ha?=
 =?utf-8?B?Z29zR1dCRUdGaGlOOWFocDVid1B0aTlXVlJGRHJqdlJydnFzd0RoRlplWmU5?=
 =?utf-8?B?dGRqazd5WFVOOHAwV2FIeXF3ZWNWRXUxYjFuQy81UGcyOGpiaE9JalBSNSt2?=
 =?utf-8?B?OEVYRlEzNmdjSm83TElxM1FJaFkwSk0wZ0hUT1ZvenBDOEY4NjlPUmtoYk50?=
 =?utf-8?B?OElIUjQyRzNjYVN3SXVnRUk0OGg1WitnKzJpT3NaSTYxYkNmQ3F2cVh6WUcw?=
 =?utf-8?B?N3Mrb1c3OHBsQUg0b2k4SkZsYmVnU1JpY0lZTWxzQW4yZ1BidWZQRW9yUWRn?=
 =?utf-8?B?NFFNZ3hIdHR4c1U4TzlvRWNMbjZ1dFVjNVlXeklWcWxsVzUxVS9XejBWRTVF?=
 =?utf-8?B?K2pGamtQbGV3dU5aY25Oalh3TFU1aFd6RVdrUHVyYVd2RGduekgwY2ZGNlNi?=
 =?utf-8?B?eDA5Y2s5ODNacG1kQ1RtS012d1JkRHN3Nm01ckJJSmRsZDFKTDkyK0VwS3Fk?=
 =?utf-8?B?Qk1hZkcrNVk5Y0ZiWlhkVWlORFdyYlJac3Fxd1Z6aExUQTlNYVkvRkhyc2JI?=
 =?utf-8?B?L0lucTFoejNiWjhIbXpQR0JXdGNCT0VySkdGUTdQSHdXN2EvbWpPaGVJYjdx?=
 =?utf-8?B?QlQ3djEzMGEycE84UDc2c1lhM3FyZnQ5MldFMUp6azRCQlVoaE0rYys4WEx2?=
 =?utf-8?B?VVBQd09jL2lOS0pyUDdDSklyVVE1WE4vNVY5T3B3VVZzMGhKMzc1WnU3SUxx?=
 =?utf-8?B?ZHc5MTVVRDJveTVhTkJ3azZPN1hwZ0pscTNrajZ1cFl5UmgvNnBiWkozbVBV?=
 =?utf-8?B?Y1dhU3cyWkdLWkhHcFVBTVg0Q0tML2Z6dVo4cTBCRUJIQ1JXelVDWFEzRVVM?=
 =?utf-8?B?cHBzTmYwaXdDcTdZMmZ0S1hxbU0wUWdpREV5V2FCTzdlK0RKWUpUa0pYRXRN?=
 =?utf-8?B?T0NWZXBEYnp6QXcyWHBMM0ZLcFJlZzM1U1Fabkx0cVl2MjI1amhSQ29tMDNv?=
 =?utf-8?B?NGtwYWprNFVkcmVxbkc0Ni9LcFVLbzM5TDIyeHY1QVl1bk16a1o0VlRtV25F?=
 =?utf-8?B?NHBqSzhRcTFiVW1MdmVYcEhRa0p3ZlhDRUY4T0RrQm90RmFDTVQ1a0NhUmxw?=
 =?utf-8?Q?ffJA/EUi1UQE4eRIErwXYbo/w?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b313d6b6-1f46-409f-31b4-08dbeadec5a6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 22:11:12.4549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OiqQb7HO7gtvsKwHqrNjc1z/cwwWBW7ZyKGu49SSceiOchgTAP8Vw5/ahRx/Mxt6oX1rf7kUMFa8Wy0glNLlyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5015
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/21/23 14:49, Sam Edwards wrote:
> 
> 
> On 11/21/23 07:58, Dave Jiang wrote:
>> Linus reported that:
>> After commit a103f46633fd the kernel stopped compiling for
>> several ARM32 platforms that I am building with a bare metal
>> compiler. Bare metal compilers (arm-none-eabi-) don't
>> define __linux__.
>>
>> This is because the header <acpi/platform/acenv.h> is now
>> in the include path for <linux/irq.h>:
>>
>>    CC      arch/arm/kernel/irq.o
>>    CC      kernel/sysctl.o
>>    CC      crypto/api.o
>> In file included from ../include/acpi/acpi.h:22,
>>                   from ../include/linux/fw_table.h:29,
>>                   from ../include/linux/acpi.h:18,
>>                   from ../include/linux/irqchip.h:14,
>>                   from ../arch/arm/kernel/irq.c:25:
>> ../include/acpi/platform/acenv.h:218:2: error: #error Unknown target environment
>>    218 | #error Unknown target environment
>>        |  ^~~~~
>>
>> The issue is caused by the introducing of splitting out the ACPI code to
>> support the new generic fw_table code.
>>
>> Rafael suggested moving the fw_table.h include in linux/acpi.h to below
>> the asm/acpi.h. The move also helped with eliminating the inclusion of
>> acpi/acpi.h in fw_table.h. The unfortunate circular inclusion of
>> linux/acpi.h is needed for fw_table.h due fw_table code needing the
>> defined acpi structs in order to build.
>>
>> Fixes: a103f46633fd ("acpi: Move common tables helper functions to common lib")
>> Reported-by: Linus Walleij <linus.walleij@linaro.org>
>> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>   include/linux/acpi.h     |   23 ++++++++++++-----------
>>   include/linux/fw_table.h |    1 -
>>   2 files changed, 12 insertions(+), 12 deletions(-)
>>
>> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
>> index 54189e0e5f41..2789beb26138 100644
>> --- a/include/linux/acpi.h
>> +++ b/include/linux/acpi.h
>> @@ -15,7 +15,6 @@
>>   #include <linux/mod_devicetable.h>
>>   #include <linux/property.h>
>>   #include <linux/uuid.h>
>> -#include <linux/fw_table.h>
>>     struct irq_domain;
>>   struct irq_domain_ops;
>> @@ -25,16 +24,6 @@ struct irq_domain_ops;
>>   #endif
>>   #include <acpi/acpi.h>
>>   -#ifdef CONFIG_ACPI_TABLE_LIB
>> -#define EXPORT_SYMBOL_ACPI_LIB(x) EXPORT_SYMBOL_NS_GPL(x, ACPI)
>> -#define __init_or_acpilib
>> -#define __initdata_or_acpilib
>> -#else
>> -#define EXPORT_SYMBOL_ACPI_LIB(x)
>> -#define __init_or_acpilib __init
>> -#define __initdata_or_acpilib __initdata
>> -#endif
>> -
>>   #ifdef    CONFIG_ACPI
>>     #include <linux/list.h>
>> @@ -48,6 +37,18 @@ struct irq_domain_ops;
>>   #include <acpi/acpi_io.h>
>>   #include <asm/acpi.h>
>>   +#include <linux/fw_table.h>
>> +
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
>>   static inline acpi_handle acpi_device_handle(struct acpi_device *adev)
>>   {
>>       return adev ? adev->handle : NULL;
>> diff --git a/include/linux/fw_table.h b/include/linux/fw_table.h
>> index ff8fa58d5818..a722300c215b 100644
>> --- a/include/linux/fw_table.h
>> +++ b/include/linux/fw_table.h
>> @@ -26,7 +26,6 @@ struct acpi_subtable_proc {
>>   };
>>     #include <linux/acpi.h>
>> -#include <acpi/acpi.h>
> 
> Hi Dave,
> 
> Seems to me that the #include <linux/acpi.h> should go too, to break the circular including cycle. If it remains, I fear that there could be subtle problems in the future depending on which header is included first in a compilation unit. It sounds now like the only correct way to get fw_table.h included is transitively via linux/acpi.h (of note: lib/fw_table.c will have to be updated; it's the only file that currently breaks this rule) so that removal will just help enforce this. Plus, includes in the middle of non-preprocessor declarations are a (sometimes necessary, definitely not here) code smell, in my view.
> 
> If this include must remain for some reason, perhaps a comment should be added to call attention to the circular situation and provide justification?

If I remove linux/acpi.h as well in fw_table.h and place linux/acpi.h in fw_table.c before fw_table.h inclusion, it now seems to solve my build issue. Will that work? I'll send a v2.  
> 
> Cheers,
> Sam
> 
>>     union acpi_subtable_headers {
>>       struct acpi_subtable_header common;
>>
>>
>>
>>
