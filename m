Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B111E7783F3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 01:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232789AbjHJXJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 19:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjHJXJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 19:09:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC352694
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 16:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691708983; x=1723244983;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=o+GNW8/NrUUHcfiu16LUGEycjMWoVSRGWnL5JHbMPeM=;
  b=XXyyN16azULMtYHRYLfnRpUmHD4e9RlzVfPEGsmeCUheiK21BoXAEg7P
   cYM7KyEpVq2jRrwq+eTYSSr54lUuOjBmU49gflz4zwp34QTys2HM8looB
   u4m5kfEEgRXXgydF0ZWs+Q7LaT52X1AQ/lbkJzn2ZDI0Rgf1SgH2V2h+3
   nwyGvQu4RUYl8hGnlG+YNKEwP0i4iC80DtbN4hnco0oxXY1N7YV7w1nZM
   kwukaq3btAJlBf2PVhReukNOnwgryY2I5wmZCja5aC6Gh+oiPjmzHl4Du
   PVybTtu/9SzjKTCEQLP4LvRWOHVPEeiscWWcoifo7JcL3jI2dWeQOoul6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="457916326"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="457916326"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 16:09:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="761970031"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="761970031"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP; 10 Aug 2023 16:09:43 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 10 Aug 2023 16:09:42 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 10 Aug 2023 16:09:42 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.103)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 10 Aug 2023 16:09:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KPPUq0cQecPX2Aw0TUUR8H2Zr4Jr+GUGhxgRmeZUlcx9AL/voKjDkWFr6wKHdQ/HLmrpbFbERi++vnJ+ZhxHg0KdFOkwMf6o84DDSU5pxVoxDlfqIl9lf+svGr1zAJa5TpNWtN1Gvx2R35TuSfkU4TKc+Qmi/DJ/C4Kus6km6nIArJoehXybbcmGQTvLdgxuv65z6VWc1RhpmpueVPFSh4jbIYL1p2h9xjf4lx0wRHaH5F2BxJd3HilNjkd8trNYEnaJ9DSD+KmWSSEPA1z1uvq7so1su9RLd6b5EoL05/ZaJrxDeJ0sK4NDnT3flvopKOujMPKsBcU7bkSGiKtmsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=azoLZD1Tv68ZHD4Qua9aNRLBbJ7Ejhj5z++riCD4HVk=;
 b=EJpcQBEhkPimtIa95fPUWlDAUwga932/EjWoN6VjZUtn7iTlkd6865wwUtqAmtynWoqztYQHSCitQzpKaU16iXETJi5zgh+lWn052AzszPSI4JpcigX4zFQdWOq3orjtSsj17tN/OQo0PKXQRKLyy1u3xyVsQjwY5eOfttuFCOm/eU7rfE4DF++4NM+mTZY4/3jw0olqFkoKjpTUYiifZwArfg1zI0Ftm54y6VhAcIPN5CRF+PGAycT9yhBVJB3vPOaOfstlqjLiGGZAhmCYKxTX/6+UmIyEzw9X6ZMbbijSZwuOja0g6IU8+dpJGarmptuKij3U2HKOqqO7LT/71A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by CY8PR11MB7244.namprd11.prod.outlook.com (2603:10b6:930:97::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 23:09:40 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6%3]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 23:09:40 +0000
Message-ID: <26949c92-95a0-414f-918a-8b8cc11e3e9c@intel.com>
Date:   Fri, 11 Aug 2023 07:09:33 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] zswap: don't warn if none swapcache folio is passed to
 zswap_load
To:     Yu Zhao <yuzhao@google.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <akpm@linux-foundation.org>, <willy@infradead.org>,
        <hannes@cmpxchg.org>
References: <20230810095652.3905184-1-fengwei.yin@intel.com>
 <CAOUHufYb2LiZYqhyk7GZ2roUbHUEUf3iKkvmSThHBS21EewHiw@mail.gmail.com>
Content-Language: en-US
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <CAOUHufYb2LiZYqhyk7GZ2roUbHUEUf3iKkvmSThHBS21EewHiw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0181.apcprd04.prod.outlook.com
 (2603:1096:4:14::19) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|CY8PR11MB7244:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dc4a14a-6424-4eed-2fb1-08db99f6e027
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HTT5rfrT1TgKf/hjRLFLyZXUuaV54IgVVKsZkS616cZZLnUy2hlW75TSHQNc5G974xojH/0THxSdhwnbEXRojTMcaC3XySj3EcNZ6W1JDyxWbrZ7MOd+fla/Qnf+3w9dbWakaAIMU2Q0NAF8VXTzrroVe7DVLfW41H/4GgwtTX2TvtU/ToH0kvdpE6zMPuHCz9bGKhozyV/6xe+eAwGDLI+HJVf8Q4N3HKFkVblqe1dl7AramCfFMoNQLfGEj5BCJNunuB5MfJAymoszTck4Hr51u1B/MOUgqKM2wpnEspqTe8S6dfvlZ24hn+PreWHAPT41mR+YpILE6RnFOrHiQUcjRdrmRPCQjSWPYZhJNg66loa/xfr4cl1CwPwo3WThc3HleAWpK8Ck2fhapHAnZl6+eJQLkEx9oew+Sr15QHg0QRflCEBqZfUluARxmBu8o4v8U6eXAg66QYZw0BOp9Xl/xGqvTdCoOWmrtErf6aBbpGYGTwT7M46IBlAu16P6NfH5QlMpUakg9TJDpbaU3IClv2AOkHCqSWXc760RJpHlp6Dq9TiR0M+/0m2Tfa0wKj/YUo/SZx3K/O7Un/b9tApzmn7tsyqTfAW3sFyNhB/tbhGxa60dnR1XVgjyvzXEwgWNONuS40Bc/nzCVdK43g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(366004)(376002)(39860400002)(396003)(451199021)(1800799006)(186006)(26005)(6506007)(8676002)(8936002)(53546011)(41300700001)(36756003)(83380400001)(2616005)(2906002)(38100700002)(31696002)(86362001)(82960400001)(5660300002)(66476007)(66946007)(6916009)(66556008)(31686004)(6512007)(6666004)(6486002)(316002)(4326008)(478600001)(45080400002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGhlaVJOdXQvd2gzcHVxZndzVE10YTlnSDV6K2pEQ3BPUTVFQ25ZaTlYeDBF?=
 =?utf-8?B?Z0NQdU9XbVgxZWdEN0JRN3VPZXJ0c0pRUG84VHQ0Z0RtU2ZqbUovbFIzS0pw?=
 =?utf-8?B?Y1BqS1l4UFdhc0R5ckhpQ3cwaGpITjlQbXUvV2dBUCttT00xb2JrMmdlOEVy?=
 =?utf-8?B?Skk1MTdoazZZakp2UVFzbnljcnZvdlF4Ly81OU55ckV0ajFkOXM3cnZhTk5P?=
 =?utf-8?B?RzVWczRBbXB0SlNMdjlHYnM0bWp1bTlWQUhHaVZZSm5iZ1lKTndJOEtsRG45?=
 =?utf-8?B?aTkzWllnbmpJUGk2Qi9tRTU0NExUUDVFakkwaU5sTU9IY2xyRmxoRW9pOEZa?=
 =?utf-8?B?dENnVFhUWVMyQ0xJM3VUNDIwK3VOdlNOWDVsaHhDbnJwK2pvazVVRUd0N09C?=
 =?utf-8?B?SFRkRWhFWUFwZG1TbER0N1VEalFKYjFtTnU3b2tnVVpwM1RvUmFMeWswTjl5?=
 =?utf-8?B?Y01nNlNYMnRBV2ROMVlJWUE2ekpaZmR6eFloR0NoOGRVQ1ljUm5aYmpENmh4?=
 =?utf-8?B?QUFYcHk0aG9QSVhYbTRjNkRwbkYwRDVjRXdERVhWRXUvVXprWFRvTWE2SWFr?=
 =?utf-8?B?TmNiOEhKSlVMcHIvaTNMeURleUdkc0Q0bmV6YmZjdms2cnJSMWlwT3FBcDQy?=
 =?utf-8?B?MjBQbkxMS1Z1V0xqRHF6UEJBYUlDR2tBYkZNVG5Zd2hqMG9aRmZ2NmZoNG94?=
 =?utf-8?B?d2hlS3FCL2ROcmk3M1NKdmV0M2NEemhaTnlQMCtlM0trclR3WFI0UlR5T0xs?=
 =?utf-8?B?Uk5LQ3hINnNXLzBTb1J4NjQ0b2hiYzRCVm04ZERkRG9HWkd4NVJHZGtmU2h4?=
 =?utf-8?B?U05VRFNZQ0JNNnRLSXNNMlFlbWZiQXhhSTUrZ2s1Y1U4Uy9CTHFEelo1Z1p4?=
 =?utf-8?B?SHJqKzQvZXNETjhkSlo3K3hKTEZFSDRSY1BrZWVKRjV2czhtcm1rNGJhOWFT?=
 =?utf-8?B?cGRQL0pnSlkxZ09GRUl4NW1EcngxUUNlMm8rYjBPMjhnZWRDUEVYZHM1L0NB?=
 =?utf-8?B?dk5SeS9SRGc3NXZPa2lhMkRFZ3ZIN2NGdm01b0VQOXQzbUQ4NEJWcHMzN0tx?=
 =?utf-8?B?bjFYRitmNTNFa0ZqVkI3bi8zcjQ1U0pUODljbHpVYW1LRTNoYXVuOVM2Rm1x?=
 =?utf-8?B?NUFITUVqeTVOVEZhajIyUWV0Qm1YZ2NZMkxoanJzVXRFcHFFNXNacjl6ZTdB?=
 =?utf-8?B?eTZvVDhSYThXdjR4OWd1NUMyM1VKUnhCbTZpeFZuNnpaakFpMDhTR3pvdXQr?=
 =?utf-8?B?VERLbHdjWnE1dFF5b3FsQmpPczYvUS95N09KV0xNQ004Q1hJV1F6Q05sazV5?=
 =?utf-8?B?UnRiRmRzODZTa01abFltOHQxK0I4bHo0UWJBTWF6MEpBNWFiZzVZUFAzR3Nw?=
 =?utf-8?B?YU1QQ2E0eWhIdTJzK0F3SWJiMlhFcjJDbnRPanlZQzdHUDNLb0NSMFJ2YWhs?=
 =?utf-8?B?cUMvNzk4YnZtMWMza0NFaXNSR0RVaWpLMkNBVGwxTTZPd3JuVFRZQzM1OFh3?=
 =?utf-8?B?a1B4aU1lNlZBQng5V0F2c3lZK1lhSTBEcFdpbjVmdGg0ZnEvUXduRDU4RlZo?=
 =?utf-8?B?WFVzWEpWVnJ6dktncWl1MnZsWUFOSS9TclUwN3pZUVVJMCswQ2poRkZpU2Fl?=
 =?utf-8?B?Y0M1d2pwK2JyeGJTTTdZNHZOQ3V0WGU3bGVJL0FoTjgwcFNUSGpKUWtrdzdF?=
 =?utf-8?B?TWFGZndxc2dseFVOa0xydTFreXFoUlJvcVVnSndLaFkyMlhKYzl5OExXbkFK?=
 =?utf-8?B?b1VETHZpWEtXc25RN3dENWtTNW11dHRKa1VrU00zbUtRWFN0Yk90YjVUNWQ1?=
 =?utf-8?B?UFpEbVZ4VDIwZTU1YkxTR0VNcXI1WlRnUFdnL3ovN3pydkU0OFlqcVoweHYz?=
 =?utf-8?B?Y1JWSWV5czA2SUJnbFlJNytxN1FDWUxmSEkwVFNtVGk0RGU0MDFlLzZsL3p1?=
 =?utf-8?B?QWg2VXpRT0M4OEllZUpqbHVLc3UyOE9oekNGRmFoT1dQRkpGUW41ckErd0J1?=
 =?utf-8?B?WlhWQkFvUDZxazNEczg3dnYxMmthTVQzWVFyZ0g1bTJGTUpoZTZHSGdtY3l1?=
 =?utf-8?B?b2NKL1BhVEhPTXhSUXp5bmx3ZHJ4cU1TbkZTc0ttb1NuY1dUa1BldmQxSUts?=
 =?utf-8?B?SHQxUkFHTWV3ZDM2TXFkc1R6Rzh3d1VFWkFQWW1iLzJJTzM1K25teWtiSG1w?=
 =?utf-8?B?S2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dc4a14a-6424-4eed-2fb1-08db99f6e027
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 23:09:40.8019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I1jlxSvUWVj+bzUozT/PMm/D7/b/UIuqU18bBZDOqfT0Qp6fVIJh/2sJv89JkpS2FYc75GN9Ma+ePAxVsG1+7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7244
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/11/2023 2:44 AM, Yu Zhao wrote:
> On Thu, Aug 10, 2023 at 3:58 AM Yin Fengwei <fengwei.yin@intel.com> wrote:
>>
>> With mm-unstable branch, if trigger swap activity and it's possible
>> see following warning:
>> [  178.093511][  T651] WARNING: CPU: 2 PID: 651 at mm/zswap.c:1387 zswap_load+0x67/0x570
>> [  178.095155][  T651] Modules linked in:
>> [  178.096103][  T651] CPU: 2 PID: 651 Comm: gmain Not tainted 6.5.0-rc4-00492-gad3232df3e41 #148
>> [  178.098372][  T651] Hardware name: QEMU Standard PC (i440FX + PIIX,1996), BIOS 1.14.0-2 04/01/2014
>> [  178.101114][  T651] RIP: 0010:zswap_load+0x67/0x570
>> [  178.102359][  T651] Code: a0 78 4b 85 e8 ea db ff ff 48 8b 00 a8 01 0f 84 84 04 00 00 48 89 df e8 d7 db ff ff 48 8b 00 a9 00 00 08 00 0f 85 c4
>> [  178.106376][  T651] RSP: 0018:ffffc900011b3760 EFLAGS: 00010246
>> [  178.107675][  T651] RAX: 0017ffffc0080001 RBX: ffffea0004a991c0 RCX:ffffc900011b37dc
>> [  178.109242][  T651] RDX: 0000000000000000 RSI: 0000000000000001 RDI:ffffea0004a991c0
>> [  178.110916][  T651] RBP: ffffea0004a991c0 R08: 0000000000000243 R09:00000000c9a1aafc
>> [  178.112377][  T651] R10: 00000000c9657db3 R11: 000000003c9657db R12:0000000000014b9c
>> [  178.113698][  T651] R13: ffff88813501e710 R14: ffff88810d591000 R15:0000000000000000
>> [  178.115008][  T651] FS:  00007fb21a9ff700(0000) GS:ffff88813bc80000(0000) knlGS:0000000000000000
>> [  178.116423][  T651] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [  178.117421][  T651] CR2: 00005632cbfc81f6 CR3: 0000000131450002 CR4:0000000000370ee0
>> [  178.118683][  T651] DR0: 0000000000000000 DR1: 0000000000000000 DR2:0000000000000000
>> [  178.119894][  T651] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:0000000000000400
>> [  178.121087][  T651] Call Trace:
>> [  178.121654][  T651]  <TASK>
>> [  178.122109][  T651]  ? zswap_load+0x67/0x570
>> [  178.122658][  T651]  ? __warn+0x81/0x170
>> [  178.123119][  T651]  ? zswap_load+0x67/0x570
>> [  178.123608][  T651]  ? report_bug+0x167/0x190
>> [  178.124150][  T651]  ? handle_bug+0x3c/0x70
>> [  178.124615][  T651]  ? exc_invalid_op+0x13/0x60
>> [  178.125192][  T651]  ? asm_exc_invalid_op+0x16/0x20
>> [  178.125753][  T651]  ? zswap_load+0x67/0x570
>> [  178.126231][  T651]  ? lock_acquire+0xbb/0x290
>> [  178.126745][  T651]  ? folio_add_lru+0x40/0x1c0
>> [  178.127261][  T651]  ? find_held_lock+0x2b/0x80
>> [  178.127776][  T651]  swap_readpage+0xc7/0x5c0
>> [  178.128273][  T651]  do_swap_page+0x86d/0xf50
>> [  178.128770][  T651]  ? __pte_offset_map+0x3e/0x290
>> [  178.129321][  T651]  ? __pte_offset_map+0x1c4/0x290
>> [  178.129883][  T651]  __handle_mm_fault+0x6ad/0xca0
>> [  178.130419][  T651]  handle_mm_fault+0x18b/0x410
>> [  178.130992][  T651]  do_user_addr_fault+0x1f1/0x820
>> [  178.132076][  T651]  exc_page_fault+0x63/0x1a0
>> [  178.132599][  T651]  asm_exc_page_fault+0x22/0x30
>>
>> It's possible that swap_readpage() is called with none swapcache folio
>> in do_swap_page() and trigger this warning. So we shouldn't assume
>> zswap_load() always takes swapcache folio.
> 
> Did you use a bdev with QUEUE_FLAG_SYNCHRONOUS? Otherwise it sounds
> like a bug to me.
I hit this warning with zram which has QUEUE_FLAG_SYNCHRONOUS set. Thanks.


Regards
Yin, Fengwei

