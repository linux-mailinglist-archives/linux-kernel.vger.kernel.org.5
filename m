Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7850079BD59
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345469AbjIKVUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243832AbjIKR4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 13:56:14 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F885DE;
        Mon, 11 Sep 2023 10:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694454969; x=1725990969;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hU+qcC2jq8aNwRq8upuTlMWm++75Pey4SdCcua0Az6o=;
  b=CwPyprlVxLtJSuRygbOs+MLwUEOib/3KPltsTHv9QczO4X05TM7mlo2j
   K6FiPYfk7vfJ1n2UKN/e9BTWAQi9ijiWqQGUVPkGdWws728tY6LWPstLq
   jYpgmInnvy3/y2mhYCt4O2EmpKFW0Pxm/nxdpPM5J5yKQ8avv70P3DklS
   ioZtZJu0ov6+mtNHix15H4Sd9ctlModE8zCkYuWWjitTh6Ghf2ISL9Ztr
   b8SwgLwFU6PnwBiiFfgJcQgZyfSIr3KfQQwa5+9TzmYinmZP3TNiEFH9d
   ksbcaw7pAaFWeLJpu26ELXbis7RqTOHDCY3VJfhGUrUUFyPSNLsYqg6+e
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="444591919"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="444591919"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 10:56:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="813480357"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="813480357"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Sep 2023 10:56:07 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 11 Sep 2023 10:56:07 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 11 Sep 2023 10:56:07 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.45) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 11 Sep 2023 10:56:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nwvVLgJvNs7mSGEZ5UckmLPbkrS/HbkEmLJVKpd/Cb4K/O8lRSbAIdviEDAH9V9m+27253TqpT73ewIWkB6sJvmAZOK5x/SwY+jV3l8kYp2oA3HdjmSyhFJp3G7wHSOV2wbn01gCY4KKCjodzL/oIV1XLOHNZ4zFAMuVEJ4HhMBacxJi22o3evEnxWd0jIQn2781MhXPVBwRwjNwbuc6mdZxEweCe2q4fp0p+3yIrjrVlV4UvOYsKk6oT8jeXnO0Az7tcg0nx78ec/gWt0Dv+AoG53AUcWzrCujUmQrgO3GBLe8O94RyDqZ/PV7E23UX1HuSRGHktlaSGIzQmAPzuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k/Pk0EWltXvwF2+8ClNJETaCMNRtN2Tc7M+zomKmt1I=;
 b=G8ZiUX0YKx5ZCODKicgzdCco2qY9SX+6bku85dr5jIrS4AuZP9owekhyoG+JHYyJg1iageHjhZq+Rb6uqkH9qGgXF/UxkDW96Z9oBdTLsw2CMttR1rzLXGduKVvwvcnCiSKNaznJGTi5V9+mrm4QiBXINnm26QoYUDNXvC7JyFZPrUaYNW0ONlf4tVDbY2OVOA+SMxxbuSIcE6EXYWdiJTtbsAfvehexi5kpUMLVV3QKTZmKqs1awQKuj2ZH1McbALoObo3Y8l/1q3Q3Hz6O3Pro8ffQXdIWYDmdMmQhkFh7AE1AOh3yoBuznScUJpRkTOLZOyn38xBq7ksV/Fa5AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by SA0PR11MB4766.namprd11.prod.outlook.com (2603:10b6:806:92::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Mon, 11 Sep
 2023 17:56:03 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::7109:4aa5:6a6d:c3d4]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::7109:4aa5:6a6d:c3d4%5]) with mapi id 15.20.6768.036; Mon, 11 Sep 2023
 17:56:03 +0000
Message-ID: <e9b0c4fd-8e88-8bc3-a14f-8d3a93a1e446@intel.com>
Date:   Mon, 11 Sep 2023 10:56:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v9 4/9] x86/resctrl: Add comments on RFTYPE flags
 hierarchy
Content-Language: en-US
To:     Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>,
        <reinette.chatre@intel.com>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>
CC:     <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <paulmck@kernel.org>, <akpm@linux-foundation.org>,
        <quic_neeraju@quicinc.com>, <rdunlap@infradead.org>,
        <damien.lemoal@opensource.wdc.com>, <songmuchun@bytedance.com>,
        <peterz@infradead.org>, <jpoimboe@kernel.org>,
        <pbonzini@redhat.com>, <chang.seok.bae@intel.com>,
        <pawan.kumar.gupta@linux.intel.com>, <jmattson@google.com>,
        <daniel.sneddon@linux.intel.com>, <sandipan.das@amd.com>,
        <tony.luck@intel.com>, <james.morse@arm.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bagasdotme@gmail.com>, <eranian@google.com>,
        <christophe.leroy@csgroup.eu>, <jarkko@kernel.org>,
        <adrian.hunter@intel.com>, <quic_jiles@quicinc.com>,
        <peternewman@google.com>
References: <20230907235128.19120-1-babu.moger@amd.com>
 <20230907235128.19120-5-babu.moger@amd.com>
From:   Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <20230907235128.19120-5-babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0123.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::8) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|SA0PR11MB4766:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f46d8ea-1b5d-4970-3155-08dbb2f05d54
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jQhOdYfSACMSZxFgwYJpAgXiQuqdeX8rQF6rpAYDsmOItVW2Q2r5cJLsEhlH0gIOLY7FNWaKPQ5TzkUreHwb1DKgDHvizGaC7g9NBbGxBEfCFoqwZ/PRx4VYvaDxmqoYd3uJZ8e9hRue+bjAUhTcmmvdc9OuwJgAM0/+a95kc68ZP6NNJHfq8sfSAaecn08jmjEPEeV2M6b1twI9PaEJ5kZQc/5QE25Ru+PKWxE0l9Fx6TMWSqdiz35H0gOm8o/KTGpxtVZQLB/wqEJVxFweHt9okpLd5S+IZHuTedlQzFgUtQCzDcrVnurvxghLIT0YGn8fK3viU1yilNGu6i6rYneGjI8CSYn+Rgk6j2ZB+o411xUd7my+8k05RU/viiIG5q8rCLzpBmyGlDiAxhoJSX3+9JNmqyuC2EfGy/zlJwrVEEJk1453040wwwe5Aezfd6ZFb3ObBVCZ5sfGsYlH6RZmOzF+tJ9DTSZro+K65Ii0yTj7HRk2dSgK6j7t1TWPPMEx1mwvUUqkvO6wMkT/5pxpxKE+y9QeNmznDXJ/XuMv0kGv+lxTJQlHsLChGu0wOJHb6khEuAHGgK1dRksYwPg4fVrvt1utekMGubih9Y9qJYGUEPGdfop51wZMqAlCyfiC197O9tavEJM//wtGvw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(39860400002)(366004)(376002)(1800799009)(186009)(451199024)(6506007)(53546011)(6486002)(6512007)(478600001)(2616005)(26005)(4744005)(2906002)(7406005)(7416002)(44832011)(66946007)(66476007)(66556008)(4326008)(316002)(41300700001)(5660300002)(8936002)(8676002)(31696002)(86362001)(82960400001)(36756003)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnRvWERoOXZSRE1BZ04vRmgwTVo2MG9qYjZPWlVnK3h5T3BTK1JkUjM3RWhw?=
 =?utf-8?B?TXN0dVVoaXFXSkNWQU9WU3k2VVJYd1JRamxMTFk1a21lZWxvRHZpR3dpakFM?=
 =?utf-8?B?a1BlQmZIS01ncStVNVltOVc1Z2xIYXltNThIOTdPUGovMkNvbjhzVDVjV05G?=
 =?utf-8?B?RTJkYWZmUUI4UFozWWlBVExqTDQyR0NYMVIzUHlXL1FkWTNUNEtmeXo2Rmd4?=
 =?utf-8?B?MHZ0ZUFpOWV0ZnRjVkE1M2V6NTVMdjVNanY5b2tIdjZxUnkzM1hGQkgxOEtr?=
 =?utf-8?B?OEV2aWlwMHpvYkl5TEszRFdpRHNYbUYvRm1UM3VnUmdKY0dGUCtBbmRNSDVo?=
 =?utf-8?B?d3poRkZGTlM4Vitqdk8zaHNoMlltYWpadWFDNTluUzgxVlRtVkVWSDBFVXJn?=
 =?utf-8?B?VHMzTGlVYjBsRXJrS0R0S3liemhmYmlOS0syVEhyeHQ1T1F3V0k5ZFVRRnZy?=
 =?utf-8?B?Ty9kV25idmxzZ1VhSHdVcGpZaksvK1pQWGVJdCtOdEI3TzY5VUtwaFVwUkt5?=
 =?utf-8?B?TEFpT0NTNGJCdUMvNUpPZ3V3a2VrS0MrZjBSRC9OY3VXYW9FR2Z3VTgwdXky?=
 =?utf-8?B?SkpNazhkZWYzZ2lHM1BOM2UzUVpNMXgvQ0lCREUwcWZmWllzejNaMW81MUlo?=
 =?utf-8?B?SnRmMzNOSjJqcVVYbnVhbm94VVBmT0VzSFl0MWNwNFExSWk1SGFPVnpyRzZ6?=
 =?utf-8?B?bi9yUnVJY2tBNWdNbVJhSHp0WEZGbWhBSmpjVndPYVZZeSs5TEl0ODlYKzlF?=
 =?utf-8?B?M1VPR1JhQjhGL2hkeDA3S3RsU2xxOW85ZFd2ckYxZVJSaUJkTndzbWwxL3d2?=
 =?utf-8?B?dndjbjJRSzZ6WWdrZkJDTjV1cDJmYkY0YW9QMmdXcHozbnYwN09sOWpMd2Rs?=
 =?utf-8?B?RU45clYzeS9vVUtkRzROUmIzOFZqKys1eW83L0hRSVJpdFNuODduNlAyMmo2?=
 =?utf-8?B?c2dQbTNneGx4THpVY2YrTHFSUm1sSXdSUGdhTzZIYjZVa2hzclM4aldLa0xu?=
 =?utf-8?B?NTNveCtxZVR5VU9tSUIzSXlCWG9TZ0xmakRWMlpnMTZuSkQxcUhkZkR6TzYy?=
 =?utf-8?B?RHM3VjNRYTd3aytSU2srWWYxbDJSNFNPVnZVdVQyNU5Fa01CUC8yWmx3R3Vy?=
 =?utf-8?B?WHFRWkU1T1o2N2duamtBaGN1VElqRU9GeHJvMkR1aDhtYzB4R1cydktyb2pH?=
 =?utf-8?B?TGQ2aHVqdzBLOVJoc2lmTVBzblgvQk1oWWUwd0ljK28zVVJkMTkzTTl1Wmhl?=
 =?utf-8?B?QUNCNlpYc3RpTHhBalptejJFeE5naENLaVVaTTZUd1lTY2hXeUk2azk4MTg2?=
 =?utf-8?B?YndvNngwaGdNb2FVZHh0UzBLbDRmUjdDMnRPYVJsU0xncXJ5QjdxMzVTMmJm?=
 =?utf-8?B?N2lsejAyYjc2eGtSNFR1bVVBZ1M4Rm9CdGhVMFBVNGtVaFhPSzVZT2l2Tldr?=
 =?utf-8?B?S01rR2tNUmJQOFBveUZKNDJLcVhiZ0w2ai9icnBNd0o0ZVFFdVdQWFBqWkQx?=
 =?utf-8?B?Uk1LVm8zaGxmSmkzYnhta3Z2cFRiclQyRGNoU3ExMHNZbDVNc0p5N09neThv?=
 =?utf-8?B?aERCa0wxSTFJam5vWm44YnRORGs3em1MSmRpNnNOY0wra2tmbEZSL2tyQ1A0?=
 =?utf-8?B?QzZkWVJCNktsbmlmU2YvNjhkT0FOeVRWblNjQ0F4M3ZRbnBDdklISmZRQ0Nh?=
 =?utf-8?B?QXk1WjRBb0NvdWNCTjJ0eFFFbVlpOXgybnJuQ0ozVmZHSG5MeEdtODZ4YnFH?=
 =?utf-8?B?bTk1eHFRcWd2TzVoOTFCOWt3UjRyYlZwa3Q4Y1VsRnBFREhBNjhHN3FMN2Q5?=
 =?utf-8?B?cEVmcWNqSXpibVJRdHF1WHY4eG9oZ3gzSEt5d1AxOWhuWlFXM0RlNTRadzJU?=
 =?utf-8?B?V1YrMEpFeitLZHArSW0rcG9IR1dYUXlHRWhuNzJEMnJzWGpmaHBTZ1E2Ylpt?=
 =?utf-8?B?ZklIMndSeW03R2N6MUw1S24wMGhBT3RKRGdMM1MrckgrRWtQT1VrWUVnTnR0?=
 =?utf-8?B?S2JHd1pNUUVjT21HbFYySXNyVFdGVitpVlVvMjdFLzRuOVl2U3o0VWZnN3JM?=
 =?utf-8?B?dnJQNlRzbEZCVXJ5ckNVaWo5K1ZMcU56RU43U2VtWUw3c0VTNXBEb2ZTT2Rh?=
 =?utf-8?Q?aKfmLqdG1mGucN8cnHuJ6iG6c?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f46d8ea-1b5d-4970-3155-08dbb2f05d54
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 17:56:03.3141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vqpii72z1dFpmcmAu5rwFuYb7D89FugraZBWFnugmXvmPS4zqXrGXaxhIzUp/sT2emW0qx2b/ZrbXi8wpVDjgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4766
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/7/23 16:51, Babu Moger wrote:
> resctrl uses RFTYPE flags for creating resctrl directory structure.
> 
> Definitions and directory structures are not documented. Add
> comments to improve the readability and help future additions.
> 
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: Babu Moger <babu.moger@amd.com>

Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>

Thanks.

-Fenghua
