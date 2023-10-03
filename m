Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D97527B733B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 23:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241211AbjJCVUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 17:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232084AbjJCVUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 17:20:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B878183
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 14:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696368017; x=1727904017;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RE3AEKeh4Da7wbGkP1XzXxE7OU5uO0R8dLjEUOv/UxU=;
  b=hVa1tlCNfqZjwudqiA3JknlwHz9LRZpsmRb9U3MRWV7asjP1nqiz2XZN
   2NEa6nLwdldb/lWWm+fZ1ouZQE3xERkR9ewlv7agg3hS1mSrzX0EFqWGl
   sfp1YsUtfDZMrciAqiP3L25sxs0rEsfCeaLCGK2/Hz+0knA58ZzNbZBa0
   XyghSeLiiE4HWgRXBswWYDSxIT4xraUmu15pn93oSZxSu/+B2Cj0JvOu/
   5XeO04HeCBqqNC2FvIGFlfv3RERKfXKo9PPDb84yHTeSWmmP7BQGBwVMl
   2zKEgWhVVvZ7wIFhE6SUcUCbcyP74TQywaxjv/sVXNnFRZwNCa0E0ocqG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="385800392"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="385800392"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 14:20:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="786238721"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="786238721"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Oct 2023 14:20:18 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 3 Oct 2023 14:20:16 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 3 Oct 2023 14:20:16 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 3 Oct 2023 14:20:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lup2UDcUI+c76Cphfk2tIiYNnLFZZP8X5h1ThAwpdJWY9nWPCHh/6gtJbQ7CTXXLgV8715No+myciXIPHV7nrl1yEuvn4B05ghUvi3Q7gno6ieEEGvtoeDBpZfTMFC2AgdcJ+oD3ECnEhJS6LcpZDwx7nAXa6q8knmqz8tKUlD8y9wp28W2KW0ZYu53JHkbyWToVu1RDZKElM+dqGkj1l4ND16FwMcFsDhkeM+Ubbt6jmHgtpOJ4MxctfuhMEsibDQH3zCYLnASp7e9bixItpP8AJbM64HyUl5x8FuG9HZTWdNfa//gTpkXvfaMr4K/5DAPvvLVLF5k0oiKfb6Lhaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R1JlixceGM7skXaXFKfb3Rn5KGSTS+FgO3W+AfJyKX0=;
 b=WPKT4TB9sytPERRjW89hYLyqzEOZCwP3B8aPlTP2bylHgl5U/Bn62qERtEBZ5lWrPdnmqEAnhMy2fnatzAzNO9lSe2tdLidWwGkBjqlZYXm0pzNIHy4EMnAQKiE4OV6hxe0vdYbYmd17ZSszU43BxEwMNGCdMQadWPl5ZYsr67V4iLIkDpFk5EG+Be0G84WhIAILsrV0Rm2kq7Ca4O1s35Rg7/DB06aiPzb40NySEwTEdNauKUBijA8a1GJKpAivvStHhr526XBAz6Ot/0oui1ncJy7Bo42DmcvV8hhd0xZqDIqEy/RN1d6UtrhHCcZz38X/HU9bJqXzWvw/h2BKUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SN7PR11MB7603.namprd11.prod.outlook.com (2603:10b6:806:32b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.32; Tue, 3 Oct
 2023 21:20:13 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6838.033; Tue, 3 Oct 2023
 21:20:13 +0000
Message-ID: <13b1ecb3-39fb-3762-9ef6-2d70d39a90ed@intel.com>
Date:   Tue, 3 Oct 2023 14:20:11 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH v6 20/24] x86/resctrl: Add CPU online callback for resctrl
 work
Content-Language: en-US
To:     James Morse <james.morse@arm.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        <carl@os.amperecomputing.com>, <lcherian@marvell.com>,
        <bobo.shaobowang@huawei.com>, <tan.shaopeng@fujitsu.com>,
        <xingxin.hx@openanolis.org>, <baolin.wang@linux.alibaba.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, <peternewman@google.com>,
        <dfustini@baylibre.com>, <amitsinght@marvell.com>
References: <20230914172138.11977-1-james.morse@arm.com>
 <20230914172138.11977-21-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230914172138.11977-21-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0038.namprd04.prod.outlook.com
 (2603:10b6:303:6a::13) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SN7PR11MB7603:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bb8bb49-85e1-4849-900c-08dbc456881f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 00JLDfzb19ThrXeQbRW//0Jm4vJ0I+Y3b5DUighoselPoY9kxAYUBxQAQ8N6rqNukIDCWsrP5OrvKUhjTfS/+VVMAUumfbHVCfnATuhYYJITN+nGOvwWXatLczXinUJG03LUVnuTt1nvYzoDuk/t+EL0ojWuet/AGdctxt5rC9dP7sIrEVgFw8amwAp+W0fnYpqyNHqCrcO9J4lVC1GaZid45h/y/gHaunhdcfSWlhqot4fBfrhbbBvcnbc2WNzjuUmNOA5on5DsCF+plJHRTZSExv590WnBMXvP25XDeHRW2C2iSfImECNtfrxRZOthJanOYVshXI2YKG9uDJL+E/uohoV5q2jjAQL4z305Wj0srRXBMYHfOP0HZ4mLmEcyi3EK8C9+88AiFgAUusK4EwsYonnPRasiyKua6tUN9FV59okLFk3OH1cXWEAmOsrzyp1iQJHuOgvXKWdx3uh12iQZHJrvj6It7njIFIspxU7Kgv9cRn91E+KVrnaqqwbOsSia/rOvuEfiTFeWUnH0cIy5WmXEKb+dn+CAKHNGzHitweJUD/y6fAidyygZMHLIkY1/1fiHa/EX1bOhptwwmUB5faPP0HeYVp5g+SQFKVen7JjVVFK/bi5Vkscen+iCnVLrO1I547q0TlLxs5+jxw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(396003)(376002)(136003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(31686004)(6486002)(6512007)(6506007)(53546011)(2616005)(83380400001)(38100700002)(36756003)(82960400001)(86362001)(31696002)(2906002)(7416002)(26005)(4326008)(5660300002)(66946007)(41300700001)(478600001)(8936002)(66476007)(66556008)(44832011)(54906003)(316002)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zmh5dTBKMkM2Y1pUbTc0MVI4MEZQQ2QyS0poWWNPazdVdHdRZnM4aWx3Vjk1?=
 =?utf-8?B?ejNsaEpWRUZZV1ZLaTJ1WW5RWERpdzBCd01HLzdOenhwSXVCZlhrOEc2WWJk?=
 =?utf-8?B?enF2ZW95eWVsNDhxeVpIVzJXY2ZMekVmdVBxWTNBcnF1cFpEZEg3aCs5WjUv?=
 =?utf-8?B?bHAwdFYxVXpaUW50TkJSYlpjdHBDVDhyaG5iYy9nc2lLUC9uRTVZaHZTSXY4?=
 =?utf-8?B?NW4zczVtUm1uMC9nWnpvb0FnaXZCUHJYSk9VNXFoZHVVeFdGWFM5L2hpWnln?=
 =?utf-8?B?cWgrbWc0MXJ2enA3amxkT2d5OWJtTEtzRXFQZUZwU2RURDN6VzI3Z09xUVNR?=
 =?utf-8?B?akx3L0szUEpQalFqUGZvOWtYMGUrbHZRODRFREJYQXpEeWhXbUd4V3hORXJK?=
 =?utf-8?B?K2xJQ3lrcHBwK3NiZDBFMDhzR0xVUndOOEZidjZvNDNtQnhmOHhUc2J3eEt3?=
 =?utf-8?B?dEFiYnI1cVdOaFI4WEtHd2krcSsvSG55QXdLM0t3Qzk4d0hmejhtdVl3WVRT?=
 =?utf-8?B?TTcwaUI2TTFMVXRmWk1ma3EzWDhZVFA1OHNnWTRZc2gvaTJZWWMvQnZBRTRm?=
 =?utf-8?B?YjRQYWc4bzVBdnBRMCtQWUhyYzM1Tlc3aVBBaFRoQjFFcndwTjFCMlhHVUJN?=
 =?utf-8?B?NFFpejhqWERsOHgxMzVGN1ZYYWRDRHFxL09LK3p6bk05Y1Z2cUU3WUovV0FI?=
 =?utf-8?B?c3JNSWZiWk92QU1TNlpLRnMvM3NtNjBzMmd3bVNJYzZmeHkzVkwzSktiTkRO?=
 =?utf-8?B?TDhtYktiUnNYVXFTa0VFS1dJS3o3amE2dnppTTFHMFJGUW9rSmlZYy9uckRz?=
 =?utf-8?B?Nlk2Nk1CQ0NvUnFqRWFJblYzRzNmVWdRbXAxNUY4OThpQml0VnhrVUdKNDNR?=
 =?utf-8?B?c3JJNHQxZk5EMWE1aFlCOG1kRmh4b3JDckE4L0JVZTBZOHBJa0YzRi9aeDR6?=
 =?utf-8?B?TEhNdGxvQzRzNDhsYXhQNGdyUHlQQ1VnZzl5c3RQTXdHUExLWDhGaEkyYXAx?=
 =?utf-8?B?WURZdVJzWnh1NDBKTGNhODNOYkxSRTNlR3dqdmtjN1Rjb1AvaFhSKzFwdGw5?=
 =?utf-8?B?RUZKcWh6bjVaSmM2SllTRHIvUWVaTGhBTVl0UjhvSFZ1SHFkMTZYb0lvYm15?=
 =?utf-8?B?VjFkdmFuWUJUb1VpTEZxUFk0RVRvZ3ZabjAzUUErUkl3UUg5eVhPOEFrNDg0?=
 =?utf-8?B?dGhIbXlkSDlnUFUwQ0RmYWwyTE1tMDRaTHk4K25FdGVvQVppTnYvcThGSTJL?=
 =?utf-8?B?YW1rUm5QejQ3cGlnS2xRQ05nVEdQRE1wbDZKOGEzaXZFaHhHMThuU3AyaVl3?=
 =?utf-8?B?dENmU2VjUG5BamtqNmRHREUvellrN1E2aGJYeWJSUDhMdEk2RngvRzJidDdY?=
 =?utf-8?B?anRCMkpHQittWG9QV24vclkraTdObFQzc0Ryb3p1QTUyS3dRUFZnOGgrOXRZ?=
 =?utf-8?B?elBsdDBsRFExK2tQblhSc3AxVHpkaEJuQ2FYVDN1Z0NsM3JGcFJ4eDQzY0NP?=
 =?utf-8?B?OHh1KzJoWDlnT2F0MXhxSHYxMUE1TVZ0MEFncEJNeHNWUzlCRW9ZVWVxdFU5?=
 =?utf-8?B?cXZUVFlkUklGeE1qZU5vall5dXdvREJMOVoyMFY1Rm1tVy9BSFJuelZnbndR?=
 =?utf-8?B?WHovcTdxRS9WWi81a00zZ3dzanJrcjl4SDQ0N0FMQ21FVk53SlBXeVdOS1FZ?=
 =?utf-8?B?NXI5Rkpwck8vb09KQzVNSmUzSzAzZ0tOZTBKUjkxOW1MRXpmWWNESkVYaEJa?=
 =?utf-8?B?RGxpQ0FVVTcxWkYzckY4ZjYrUk9jNUsya1BJWkNZaEZJMmdIRmwzRC90TXVN?=
 =?utf-8?B?NmJ3VjJvelAwTmhVdzN3WDNmZXBsT0IxL2RSM1RpY3pPRm13TjJmazFpSVh6?=
 =?utf-8?B?YWFtMjFoZFhVd1g1bHJpOExyMFJ3ZnR4TWh5NWcyUGNNVFdQUFFzTk5jVGs4?=
 =?utf-8?B?ZURUZzAzSWpEU0cxNWJIZ0NQS3FTMXpSYnRnNlU5c2NvNjB2WGNJMjNIQUpJ?=
 =?utf-8?B?Q3B4YmthYzdDUEZYZlNmT0YvQnppY2ZxZE9wZGlwejc3SXRrTkp5dmpQZWIr?=
 =?utf-8?B?RDhXRWJDdFVPbGx2d2tXdGRvTnNFdGY1Szk5aUtNQ3pBQ2JnUEI1Q0lhMXlx?=
 =?utf-8?B?L0g4YWpsd1Z4anUvWW1BL3hEWTQ2bStlWms0UzNNeHZQcklZOGhPUjBwMUJF?=
 =?utf-8?B?NGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bb8bb49-85e1-4849-900c-08dbc456881f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 21:20:13.4245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QU+7NsLUagECZdSkXtqf9wRlSswR6GRz4LnR4osLJszDK3EEvU6gCU1ZqxviyF93rFSz3PLkkldKRrRMVlYrvbgmoq6ZnNWhywtXBJGABLw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7603
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 9/14/2023 10:21 AM, James Morse wrote:
> The resctrl architecture specific code may need to create a domain when
> a CPU comes online, it also needs to reset the CPUs PQR_ASSOC register.
> The resctrl filesystem code needs to update the rdtgroup_default CPU
> mask when CPUs are brought online.
> 
> Currently this is all done in one function, resctrl_online_cpu().
> This will need to be split into architecture and filesystem parts
> before resctrl can be moved to /fs/.
> 
> Pull the rdtgroup_default update work out as a filesystem specific
> cpu_online helper. resctrl_online_cpu() is the obvious name for this,
> which means the version in core.c needs renaming.
> 
> resctrl_online_cpu() is called by the arch code once it has done the
> work to add the new CPU to any domains.
> 
> In future patches, resctrl_online_cpu() will take the rdtgroup_mutex
> itself.
> 
> Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Tested-By: Peter Newman <peternewman@google.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
