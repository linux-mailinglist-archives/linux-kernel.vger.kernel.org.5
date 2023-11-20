Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 698107F1871
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 17:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233688AbjKTQT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 11:19:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233746AbjKTQT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 11:19:27 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22193114;
        Mon, 20 Nov 2023 08:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700497163; x=1732033163;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QGX9kkwUXh+Lf2yr+FN8IB6F0C2kV/2gtYyMk+ukscI=;
  b=f9RfOcwevv5NjRi2LQrEfD0JUYmd4pK70DPh7YN4hqJl1XQn+VpkR3Hi
   ccP4gVoxpunsRa6PON1Qw2bLRX3VjQBrpEbCFwhYNkfDwnmfAuNysXo6s
   a3bW6SlytzBHM1s2dQjxYqLuUKAUjLQo1FkCAKzZOQ9px902GUhg+Su03
   wkVBAxSlekf/Xv2rWAAXTIzK923E2Q4IOTSab7qw8q3/J9XbN7JiuxVkr
   zgmM1Hio5wePmxfYXLMsDixuaUdOxn2WEM99JI2oQOGPYZtFd2GR/JAyq
   sB8wXa4qzsP67hb+/8gyxeZG1GSgMeovyfOGVw/Awyk8pnh+ikN37Decb
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="4765633"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="4765633"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 08:19:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="832320054"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="832320054"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Nov 2023 08:19:20 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 20 Nov 2023 08:19:20 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 20 Nov 2023 08:19:20 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 20 Nov 2023 08:19:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DdEFELpes42bJBS8dnwTPpBQ04PfiVKvybU39LhLDJ1ZMJzdYKlt+J48BlbHB7qxmlxheFf5v8ph576jWd1trLaybQvHhACw3AP5GUuodBeYPJ2DZea9/FedwTz4akDtnJ9JEYIs5ZKSO0TcR4ruUl5PahBCItdpB0lYodlB7va3SG47eDtCjT1zyMYdIM2PRGQyEbOGtkiyDw3A3SQpL3fJNPD76ZIkxZPYQWJZmNWH0L4J1JJt44Pj7wFUHBIw/Zi2QhRy66yp9jBF4dR3m0x7jbxv4x76FqDjZwbUPP0Af2UTeFrQZDNYCto4upCFdDVYuQjBSbEVUXple8ZPWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kVE+MUXH9swNznaT0IxyJ7VRpPUQzaCB4hkhnUNvoKM=;
 b=Ikenk01qILzZhPvi4LWOiJ3+c4l7fp5gruJqtvWYCHUb78lyIKUsOp2HMEqL7yf+h3DRc8jSneW9SZ7fSgLIOaxKtisqPxjNAQTTfaOl9uBTCGXyyduJ/QJYdOxZadeJxHIAxvyRBN7sFvMrdbRYdLgvkFE3GckJOJotshPLZZ70NRVfYggpDBRA8eJiHoS3GIR7YfhBTLALYHX2NVe7+Nsg9E+6SGQ48zA38AZBREvvgc3FMQxxx+UUQtzPPIXTNexzhi/FdN2apqxldQy+oNaUH/KLAhPgft1x9V/auxwqdNvLvl8Ud9b8c3EwyGu+POKzTI3vKmVBWmdOJLv7Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by PH0PR11MB4917.namprd11.prod.outlook.com (2603:10b6:510:32::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Mon, 20 Nov
 2023 16:19:17 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1%4]) with mapi id 15.20.7002.026; Mon, 20 Nov 2023
 16:19:17 +0000
Message-ID: <41160dbf-d8c8-4dc0-9fda-42cc97df5b77@intel.com>
Date:   Mon, 20 Nov 2023 09:19:14 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH] ACPI: acenv: Permit compilation from within the kernel
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Sam Edwards <cfsworks@gmail.com>
CC:     Linus Walleij <linus.walleij@linaro.org>,
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
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <CAJZ5v0idWdJq3JSqQWLG5q+b+b=zkEdWR55rGYEoxh7R6N8kFQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR10CA0021.namprd10.prod.outlook.com
 (2603:10b6:a03:255::26) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|PH0PR11MB4917:EE_
X-MS-Office365-Filtering-Correlation-Id: 2738a781-1050-4c33-79f3-08dbe9e471bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: twOIxh+EEgSDfyDoR3bbZrhDolS3WxrzoBZ89edRpqyIRviJeQ6D9lTipQZPjHD0M5FVqBG95dTeIMHGq7yAGm0Sjh51VXhXJMvuZiAeALXrIKdFTvqTkqJnfVgacmiTOGmvtOG54lEqqywVaov5soG0CZl135xdyWuMb3C0L3FOT2ux1+eWnfqX30ChbLHbAucx3aD2uwFYJrXoWlk3NonbhFFkUNFoV5/g+9yqOWQSeK0aNTR/KfW92aAm5vzBnED5QgcDaoIC8995xDwqlymaCr9s44JWnQ5tufrKcK2NBK3kOq70LpH4+Hquhzr6OPDGrZCQ9vHf21VrwjeLYd3K/SM6oJqtCuj+n8XDIYDvSoTgLTtZLp/Vzu087fRtIRbEbWrud16HO6lNxs40vQ5A0R3n3cWS4KA8zH1Hhe/mU/yqJLxHm0Lx163jcJQCYDBIwTrTHwhgNm+stC/HWeee/2J/OsXRHYCzM9f+hIAsgny84wuswlIaxDI9vyEMuY8HOICFy4WxRANVXNmX0tvIYBSsDQTMk9MNwlDEbPvWF2qJt99d/0eTH/rFCU9TGAjYN2xogSgptE9Dl8cU6odqFDm9TiESCXPX4WwkbFy1glGyoD/m0Go4vwyHWZDc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(346002)(376002)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(66556008)(66946007)(110136005)(66476007)(54906003)(316002)(478600001)(6486002)(6666004)(7416002)(5660300002)(86362001)(41300700001)(36756003)(2906002)(8936002)(8676002)(4326008)(31696002)(2616005)(44832011)(31686004)(26005)(38100700002)(82960400001)(53546011)(6512007)(6506007)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejVWUm1IMy9hZWw0a3ZxaGpVdzNLWHBrWWhxNTdCcElna2VtOVdaeG8vZnl0?=
 =?utf-8?B?RDlmL3FsYXZNemZiNHU3MmdKcSt2NUp3dkFNQXQrMkdSWE42WFpwYU1TZ09H?=
 =?utf-8?B?bkE1UVBvbW9hVkcwa1Y2alZWUllXUGIrTWZpVnRUMHpzVGNEWUUvTlJvZEhU?=
 =?utf-8?B?d3ZuVmpTUlRRbkZKZkwvU2dJM2x1blpXL01udWpMNjVaWElaOWdOUjdXTjh3?=
 =?utf-8?B?eGRCbGdmRXJLcHBDM2J1QWxLaklvUERUTHppSW5aZEk3Yk1ndXVjMEhWU2hL?=
 =?utf-8?B?Ukg4YkZQNER3Z0hYRlRQV0R3YkwwK09WZHVCdXdGMFNidldzT3dVVGdVNVpC?=
 =?utf-8?B?eVpTKzFaZ09ZdzJJTVZ4ZG81bmV6UHFnSVhlenc5amI5bllNRjhNYitLeHEz?=
 =?utf-8?B?VnVPcjNmbWxQcGxPZC9RM1dKUEE0NTNmK2lKOFNNOENpZnpDb1NPNnM5QlVE?=
 =?utf-8?B?amozcjBrNVAvTzlkRGp4ZjZHb21nSHI2ditvaTJHclYvelNleVo2TFBCUklP?=
 =?utf-8?B?U2hyemlLa3NyKy9IQ1VhdTRWRS9xd1lWSXpURG15Yy9mNXFEYVdkRHI1R056?=
 =?utf-8?B?MUpZajQ0VHRWZDVCYUF3dXA5WUp5SWU3YzhUYTVOQVVIcGVIblFKN1RmMkdE?=
 =?utf-8?B?dDNvcmtQaHorMkJXcjB2UmZJZjhpS3JaODFzbUdGT1FTQlJOY2tVeUlVaWxI?=
 =?utf-8?B?aG5jdFhVY0JxN3dyR3NqVTV5eVFVbnhZYVNBRTdzRlNFNEFsU3pCUVU4Vzdy?=
 =?utf-8?B?L2Vlbjk1M1BCVVRNMFMvM05UcGg3S0wrMU9ST0FoR3NtbHp2cDV3UEdteWp0?=
 =?utf-8?B?MXlKZkg5Z1BJSy9VQWlEeDNiT1Rxa296UG1qWXIzSzZKcnRGK24rWG8va05v?=
 =?utf-8?B?L2xzek45cmd0RzRtTm1TSFVNT3ZieTNzMmo2Z2YzbVRBZXFwZGI2dmdlLzNX?=
 =?utf-8?B?QlFHWFlienFnOEU3RXJBQXh5RmRCa3htbUpsdVNTY0FYbFRkcTRtVWJsSStY?=
 =?utf-8?B?cUdDTmNsSFhuZExlcmZKZ1RlMktYcUl6eGp0aGsrMDlQejFBQm5taU01dkV3?=
 =?utf-8?B?cVpRblY5U2FLQytnUVNPWUROT01ZRldsTVhpQm1hcGNIcFUycFRBYUlOOGU5?=
 =?utf-8?B?MG1aMDN2c0ljNTJMZVliWW9OMnVuclRoTk02VldpMnlxT2VNRXM3MHJ3TWk3?=
 =?utf-8?B?b0Excm93ZGRNOHlrbUkya2tsTy9BRU5YVW5jZ0JRSVR4ZGw2NzB1eURKVGRC?=
 =?utf-8?B?cDZtT2duY01aT0FjK3FMUk41cCtpVElOVlBQTGwycnYyV0wxRDZGWDQ3c3FM?=
 =?utf-8?B?WFRDWmpLSTZDb0M5d0ZyNVcrbmRsSVNVc25ZQTdEZkJodjVqa1l4WnlUR2Fa?=
 =?utf-8?B?TUE5V2tGbEt5RTkwU1Vhd2FyR21DdmlBR0tkcnJ4aldXYjBrei9rOWl4Q2ln?=
 =?utf-8?B?NW5Xd0VqNjVFaGlhYmtHOVZ3QVdSalc1Y2VDWm9kdDlGLzhCczdCWEg5VVdB?=
 =?utf-8?B?V3pzY2tpaXNEL1pQcFY3akt2dWI2UGxLZFJ2Lzd4L0htd2toWU5YY2tpS1Bu?=
 =?utf-8?B?bmVTQUFYQTZaRTdMbVZJOVY0cEFBRlJQeE43VmhEeFA4N1lCeGh3cEdQUnRS?=
 =?utf-8?B?YVdMTDRFNTZqbVdLZy9FSnRKOW1SN0xqbGhmaFgrWFl3N1BpWjNXTExPcWIr?=
 =?utf-8?B?UU9JdS9hR1JtMVBEaTlQRXFuSGk3a2pab1UyN3NkSG1GVTBrc1NWMmNpZWM1?=
 =?utf-8?B?ZG5jdlNndVMvUm9ta0lKS1M4QmVMYXI5WnNIcm85OEw2YkhIKzBMZDAreWtC?=
 =?utf-8?B?SWNJNjIxelBhRWJKVGdVd25SZndhM3ZBRnRGUG5CczZVaW1EdUorbzFHQlNH?=
 =?utf-8?B?UFBUc01hR3YxaWxYeU1zd2pjMzFXQUNYaDVVQ1gyUVoxcE0ySEVBNit1UjNW?=
 =?utf-8?B?RWpOZVpWNFprd3BiMzZobERyZlNlNFpwK0tkb1RpTWRSOHFmcHBQTVFQa1Rq?=
 =?utf-8?B?OXQrSHNUdnY4aWhjN3QyeDQ2OERXbXRldm5iempzeWtXZlo4Qy9WRlFWcS9R?=
 =?utf-8?B?TnNSR2VOUnBEcDBzVUdFcFFzTVV0N25INTJPVVVmL2FXanRMSjJBYnNtdjRv?=
 =?utf-8?Q?SgHd5502g41kENUZ6ZTAlHsh3?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2738a781-1050-4c33-79f3-08dbe9e471bb
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 16:19:17.4627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qkXNoJDgXXrcZxyXHAfbQln6NDE/0NXALwlb2qBPrJp4HoCXKW22hU7n3skaW5YNgazXigwz31QoryLIz7c0uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4917
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



On 11/20/23 08:46, Rafael J. Wysocki wrote:
> On Tue, Nov 14, 2023 at 7:09 PM Sam Edwards <cfsworks@gmail.com> wrote:
>>
>> On 11/13/23 16:08, Linus Walleij wrote:
>>> After commit a103f46633fd the kernel stopped compiling for
>>> several ARM32 platforms that I am building with a bare metal
>>> compiler. Bare metal compilers (arm-none-eabi-) don't
>>> define __linux__.
>>
>> Hi Linus,
>>
>> I saw the same baremetal-compiler error here on the ARM64 side of the
>> fence, and narrowed the problem to the same commit as you.
>>
>>>
>>> This is because the header <acpi/platform/acenv.h> is now
>>> in the include path for <linux/irq.h>:
>>
>> More generally, I think it's because of this addition to linux/acpi.h:
>> +#include <linux/fw_table.h>
>>
>> linux/acpi.h is supposed to ensure _LINUX is defined (if it isn't
>> already done by a non-baremetal compiler) before we start pulling in
>> ACPICA includes, so that ACPICA knows the platform. But because
>> fw_table.h contains:
>> #include <linux/acpi.h>
>> #include <acpi/acpi.h>
>>
>> ...the circular include does nothing (linux/acpi.h's include guard stops
>> the include before _LINUX is defined) and we end up pulling in
>> acpi/acpi.h before we're ready.

Not including either causes compile errors for me. And directly including acpi/acpi.h w/o linux/acpi.h causes triggering the #error and some other stuff:

./include/acpi/platform/aclinux.h:18:2: error: #error "Please don't include <acpi/acpi.h> directly, include <linux/acpi.h> instead."
   18 | #error "Please don't include <acpi/acpi.h> directly, include <linux/acpi.h> instead."
      |  ^~~~~


Only including linux/acpi.h:
In file included from ./include/linux/acpi.h:18,
                 from init/main.c:30:
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


> 
> Yes, that's the problem AFAICS.  Dave?
> 
> What about moving the fw_table.h include in linux/acpi.h below the
> mutex.h one, along with the EXPORT_SYMBOL_ACPI_LIB-related
> definitions?

This builds cleanly for me.

> 
> BTW, I'm not really sure why fw_table.h needs to include both
> linux/acpi.h and acpi/acpi.h, because it should get the latter through
> the former anyway.
> 
>>>
>>>    CC      arch/arm/kernel/irq.o
>>>    CC      kernel/sysctl.o
>>>    CC      crypto/api.o
>>> In file included from ../include/acpi/acpi.h:22,
>>>                   from ../include/linux/fw_table.h:29,
>>>                   from ../include/linux/acpi.h:18,
>>>                   from ../include/linux/irqchip.h:14,
>>>                   from ../arch/arm/kernel/irq.c:25:
>>> ../include/acpi/platform/acenv.h:218:2: error: #error Unknown target environment
>>>    218 | #error Unknown target environment
>>>        |  ^~~~~
>>>
>>> One solution to make compilation with a bare metal compiler
>>> work again is to say the file is used with Linux from within
>>> the kernel if __KERNEL__ is defined so I did that.
>>
>> I am not an ACPI subsystem maintainer, but my understanding is that the
>> files in include/acpi/ are copied verbatim from ACPICA, so any change to
>> those files will have to be sent to the ACPICA project and wouldn't be
>> accepted here.
> 
> There are exceptions, but generally you are right.
> 
>> More likely, we'd want to do something about the circular-include
>> situation between linux/fw_table.h<->linux/acpi.h. That may have further
>> consequences down the road than just our problem here. Perhaps just
>> dropping both #includes from fw_table.h, and lowering the fw_table.h
>> include from within linux/acpi.h to be below <acpi/acpi.h>, is the way
>> to go?
> 
> Something like that.
