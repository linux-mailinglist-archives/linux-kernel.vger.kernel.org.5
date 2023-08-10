Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37DCC776FDA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 07:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233223AbjHJFx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 01:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjHJFx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 01:53:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6FCDC
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 22:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691646836; x=1723182836;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ybJ+iI8NTy4v1Pu680PK3wg1P2Y2+XCOg6JjCLAf4iI=;
  b=cetlkSkIOnUB0WrIQRW5jMZV2xNIgHqNXEcufqPDVZ8Y/Wi1KjkcMQTw
   QbDEeMhy6jHguu8A4/HoZPF36XD5ieibbjK6UNdL2W6PtUOtJEdZUkicS
   NMSWd89YLxvYm9MdOVIrqEaX99BAJiJgsA1bSc+rWE8y4tP5MoqiNjnOX
   eCIjZgqCW74QtMDaYGie87Byz8zvpW1zkjnRsL/QtpWJwmY70UWj7c+3O
   8XYPE4JZbLRHwoy4k1+WPsR4+8K02pEP0d2UV/NVwpk/N2WJBDC9r1hqP
   oI6R5XVtz2+a9kEC+jqABrpxHh/bpChC0KCE1DOtSShVsElGWCX/4Wy+8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="371299535"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="371299535"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 22:53:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="846240080"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="846240080"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP; 09 Aug 2023 22:53:56 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 9 Aug 2023 22:53:56 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 9 Aug 2023 22:53:56 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.42) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 9 Aug 2023 22:53:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JozOCSfpeKspkifvXeefUcQC0f6iPAVFGJ5JpQsDcIovjcyWEc6njNTigRGz+zLHUlRl8KKhjxgmXib2XMyBtYwDsnq+SVWfOqO0AxhLMAgWY07ZXvHw/YyI0q621qLd910E1jy22ATSbd49oWb1+Pgmqbapb20pilFaBMw0eUQid5JeOyYzgjB2GjM7j/3T0x/tuToIinRCSXY/V0UzznB4UIVyuppCWm8CNoddJETbkK7vjuCKozjOalZjd1Q1TMi/zKORFRZckAQEG/0pFMrRYYH/95U0xbHXTHzxeHJB/DLvM2B3cxZOuDEL+hvIeDcvhkEeJxqO4KoKqtLGqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ApJ14FvK4pbyp4DKWpLk70fIxiRTWO6Odg0WG2fGNaI=;
 b=N3ERiq2n8GKgHZwIufFOcuqYD7y6/a8kVKMFgGh0n5pD69wOrqDIAf+XJk6CFh23oqWHi8Om3gPKaK4ujts4DHj1Oe+OP6XMXaEeUVqpwa4Ptm4erOe9k1Kvbr3EkxSR6Gp4de6jIuhhp834VJjsMTaLoC6jIhBXgUAYv2kCVmG0oDNlUK1rBhEy6qPFuJ7vWerc6hhxxzeifPQe3T/LxdTRA3IZIbzAM6IhZ35BO0iAkPqQfBKnkwLe7KfMDDSKWTMaotGV62MJZUz9PHOhSqZlfI0XSuCqVEcizZYJxC1tJKV5g5x1Ke3D06hGpKrAAefXBYQp47ZTOXB1QPCSqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by CYYPR11MB8431.namprd11.prod.outlook.com (2603:10b6:930:c7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 05:53:47 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6%3]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 05:53:47 +0000
Message-ID: <9b76b489-141e-272f-33c1-c6729776f074@intel.com>
Date:   Thu, 10 Aug 2023 13:52:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: hardening and other opts in kernel config used for benchmarking?
Content-Language: en-US
To:     Mateusz Guzik <mjguzik@gmail.com>, <ying.huang@intel.com>,
        <feng.tang@intel.com>, kernel test robot <oliver.sang@intel.com>,
        Yujie Liu <yujie.liu@intel.com>,
        "Li, Philip" <philip.li@intel.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>
References: <CAGudoHGyo4WPjXLfhzCOn1gK6nvx2U1Z=Dh4xcBw6yXZ30p-AA@mail.gmail.com>
From:   Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <CAGudoHGyo4WPjXLfhzCOn1gK6nvx2U1Z=Dh4xcBw6yXZ30p-AA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:4:194::13) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|CYYPR11MB8431:EE_
X-MS-Office365-Filtering-Correlation-Id: cc34368e-dbc3-498f-fcad-08db99662a06
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oTxnK2S9/bWeM6fXkr+d1kTrZXfU4eDMddlC2g1NyWdASQLrvbsIfD//gOrjETT4MbN5mJm7NhsGC/qv2XhHSPerp/BxPA29W7b7r7VtCmN95YDBXCKpKYgtOJzd0FPvepEkDnxMi5FuZ9XWGqySPmQTBX+6J/1TG3juDuM8w5W9Uyr7mWeyso/1H8rTnQAGoHi81bZ4nrnTcOjwgDt0EhoQwT8WAoij/qyF73LyvoPnremIQ4s1WG5OXFMZZLbxtSM+vw6ccXAs0F38UNljd3a9bRfVeSnPOr9AZ4EqE++kYL3lt+eXP66ZhNdyTQ7nHlZvplC3Jb8VgtLSvzrsz8b0VikiRtXpLH33EDQ1JjUTNjX3wZ8nMJwgBHpoo+vnF3PeiG5VlWCKVMqO9iFCb/s2F/HC8kj8MkDHB8w3dfhgwaJz/1u4KvyVdEOticRyatOW1rFFUUv2X1afUFYphYwAXqczTRk6y7TRoWvINv1pT//v4ZU8KVERUUpPzB3J5q6Oj4VlYHkleykYf5so80B788pF8TxYi33gJYRgD35wdILP/m+qar38HCSDMmxLrRo7b9oT4Z7My9/5B6Zxt4hyaKgg6tD0FcNjtnc5GmrVJRbkg2d7luAlT11LnvueeWCLD/MDrwZ1VfQkeafE8Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(136003)(396003)(366004)(346002)(451199021)(186006)(1800799006)(31696002)(36756003)(53546011)(26005)(6506007)(8936002)(8676002)(82960400001)(316002)(86362001)(2616005)(478600001)(41300700001)(6486002)(5660300002)(66556008)(66476007)(66946007)(6512007)(966005)(4326008)(6636002)(2906002)(31686004)(83380400001)(6666004)(54906003)(110136005)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NSsrWXNFV2hleE1wNGROMzRRVU9VeFF5MmtEVm1lT1pOV054R2txdFc4Mnds?=
 =?utf-8?B?bFVwNlY5NjRza2lBQ21vNExia25NNzRHVVlnY0hyaitXYTVTYnE2R2NVRlp5?=
 =?utf-8?B?RHhPZTcySHZsOU5hRitId3FNZ3ZUaVFJcUQvVnI1Rlo0Z3pLSFVnTFZyL25Y?=
 =?utf-8?B?clYwUjZLZDlDUjltaWtuVVpHYUpyMk9Sc2hMdFVmYzBxQ002Yk5lMmdWcUJ5?=
 =?utf-8?B?STBLR1ZGVHFuK053OXNEelRsdHIySmJTUXpTS1BQRzN4U0RZS1cvNERXWGFr?=
 =?utf-8?B?T0V0d2JNWDMrWHVIVzROOGxmL1JpRUJpVllXbCt1R0U3MjNnZUFsbjVhbkZa?=
 =?utf-8?B?OG8rUEVsVXgxdndPeGJnU1k4VnZ1d3d4blZKS1JJanc3N1cyUGZFcmF4RG5G?=
 =?utf-8?B?c1BjTldNaDduUEdSMVpSMWVBZnhjY1FDc0FvVVR4anc2SU9KSW5GUlVpVStU?=
 =?utf-8?B?MWZsb3piVjhXZUUweGRCMEdHQTE1UndqK29Eb2RoUzhNa0ZaWUhmeklrL2sv?=
 =?utf-8?B?VWZTVmxxZWExQjB6QTBhNGZ1V0JLcDF1c3VFQlNSSkNOajUzbEUydTlPeWxa?=
 =?utf-8?B?Zkc1bE9Mdmo5Z3pjcVpsdEo3MS9yVlRxbnBQb2VQdFpIWlJGaU45SCtYUDdt?=
 =?utf-8?B?OU1hSnBzSjQwQWRKYmNiZlJXSGpVZENwZWpLZzZMOXQvOVNmRTkzVld6YU9H?=
 =?utf-8?B?c2JRK1V2OWsxR0VZb3RPd1VpV01Wd1paNVBxenpvZjVEb3ZtMzVzNkVsbVR5?=
 =?utf-8?B?b0dCaXB2Q3UwdEtTdHRYWVcwZ0thd0VJeEt2R3BhUkptWFFRa1RvN29NTWZh?=
 =?utf-8?B?bjRGeVErVFEvWEdQc0I4ajh3R2xPSll2anpaMytNOVZWOUREVjhZdlAxN0dK?=
 =?utf-8?B?V2dyNGIwOTh3dWRBYzY5RXVMeVhYamM1WEJpemlQYUZnVXc4RzFiYUEzK3Rz?=
 =?utf-8?B?Uk9YK2FRYVU5YUluQjNaS3F4bCswd05IT3lGbmtvWlFaMjd6U1JIaHhnc2V1?=
 =?utf-8?B?b3RGMG9JcTl0Zy9UQzRPSnRXL0EzTzBPc2tPKy81MTdnWklTNmJGSWZrRlNn?=
 =?utf-8?B?aWxHUnU0T3ZTa3hSWkJPa2tOVjNtUzNqK0RVVDJIR2kwOTlINms2Q3V2S3VJ?=
 =?utf-8?B?dXAybUkyZmowMUxXQVgyQzRGQ28rMG91OHo3eHFRSi9VVVFWY3NLVThTMURn?=
 =?utf-8?B?NFpDa2N0Y29jK2tUZVEvSUtZNUtKaDhDMUIzYURyUzlRUGlEVGVnTitEU216?=
 =?utf-8?B?WXNJQ0k2RWJDLzVYTVdQYlR4N3BYQWc5TDdmQlo5R1E2dkNFc2k5Vll5cnF0?=
 =?utf-8?B?NG1iWW52RGllQ3FFVjduRisxdXBQcHNBbnZYZnQzRXhFclpBZXVwYlhaNDNE?=
 =?utf-8?B?a3h2T0QwWCtYblNxSktGbjI0ZTY2b0RFRXJYd1dWWm81dHBhdjdSbloybGNz?=
 =?utf-8?B?VnVaVTRoQ0lXR0VQdVlqeHdLK0JsbnJ6Q0o4TFRQVldPN1Y2aHQrTUFLRUFu?=
 =?utf-8?B?VTRMUUxVUVRLdG1EVm5rRkkrbnAyay93a2ZrMG1oV2dFZytyRzkrNFV4czNr?=
 =?utf-8?B?M0ErMUkzYWVvNU52M3VvTlViNUo1OGFBYWh0QlRRUjlvclFFcEdTanNwcUs5?=
 =?utf-8?B?bm45OTRjQ2w5OFpjU3J1OGFqVGlTaDY2MzNZQ3RRS0ZKOENHNFRYS3hlaFZG?=
 =?utf-8?B?Y0xEMjF6QTQyekxwR1BqWm9DdXEvWVVOcjg4MG91Um4yWTVVaDZDNkl1a1k3?=
 =?utf-8?B?UUh3WHJKL1c3MjFpaWFxbVJqb1dhekJJekFzVkgraVJmUEJ2RlZSNFFOT3BU?=
 =?utf-8?B?UkdIbHlnb05ZWmloNUhmUVg0U1BxWDk3aVJZVDM1Q2xmd2d4ZlhnL0tUWE5S?=
 =?utf-8?B?TmNoL0dOcnM1NE83bGNkM3dNRndEdkZFZUVzQ3h4aEc1UU1nWjlnelNyaTVv?=
 =?utf-8?B?aW1ISTRBSyttdktWeGtGRUlNUDd3VytjWlZpT0dTNXRHYzBXN0hGOStvS21l?=
 =?utf-8?B?LzA0RDRJNExmN0tQWi8yaVgrRk96VURLNkNGQXBaNVkvK0xZaGFDbEJDbUs0?=
 =?utf-8?B?OXNmeDhtekNCWWRsTFBROGc2ektoUzlaMExDTENLRTQwSG1mNng0RGVwOHR1?=
 =?utf-8?B?Vi9SWmtkWkE5d1hzWjNNbEQxWjlDbG5BSnUxWUEzdHVmMG84Q05EQjFaVFdP?=
 =?utf-8?B?M3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cc34368e-dbc3-498f-fcad-08db99662a06
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 05:53:47.7071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G/Sn85XjR58YsJD6ESQnzHXHbxq+2woKhnt9cZVjiMoF/7UC2WZFQomnRW77bmuUQB4dhxYmP25lw4D3myj7pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8431
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add more LKP people.

On 8/8/23 23:25, Mateusz Guzik wrote:
> Hello,
> 
> I have no idea who should be in To: or Cc:, I grabbed names from an
> e-mail I got regarding one of previous changes.
> 
> Recently I benchmarked a change which added unconditional file
> position locking and found a minor regression from it (with profiler
> output to justify it):
> https://lore.kernel.org/linux-fsdevel/CAHk-=whJtLkYwEFTS9LcRiMjSqq_xswDeXo7hYNWT0Em6nL4Sw@mail.gmail.com/T/#m7c0cd6e913c6295732daea3c88f502bd4724ffb3
> 
> However, according to Christian the change was benchmarked by your
> machinery and no difference was found.
> 
> I briefly poked around and found that used configs have:
> CONFIG_RANDOMIZE_KSTACK_OFFSET=y
> 
> This is an optional and very expensive hardening feature, my question
> is if it was enabled on purpose. The cost comes from adding rdtsc to
> every syscall.
> 
> Looking at the rest of the config you have a mixed bag (e.g., hardened
> usercopy but *no* init_on_alloc) so I genuinely don't know.
We used a kernel config from Redhat Enterprise Linux distribution as
base config (it was from redhat kernel-4.18.0-187). And then use the
default value of new configs.


> 
> Given the high cost of the opt I would suggest removing it, as it
From arch/Kconfig:

config RANDOMIZE_KSTACK_OFFSET                                                  
        bool "Support for randomizing kernel stack offset on syscall entry" if EXPERT
        default y                                                               
        depends on HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET                            
        depends on INIT_STACK_NONE || !CC_IS_CLANG || CLANG_VERSION >= 140000   
        help                                                                    
          The kernel stack offset can be randomized (after pt_regs) by          
          roughly 5 bits of entropy, frustrating memory corruption              
          attacks that depend on stack address determinism or                   
          cross-syscall address exposures.                                      
                                                                                
          The feature is controlled via the "randomize_kstack_offset=on/off"    
          kernel boot param, and if turned off has zero overhead due to its use 
          of static branches (see JUMP_LABEL).                                  
                                                                                
          If unsure, say Y.                                                  

I don't think we want to disable this kernel config in LKP.


> avoidably muddles the waters for single-threaded changes (one way or
> the other -- slowdowns can hide and speed ups go unnoticed).
> 
> I did not review the whole config.
> 
> Any comments? :)
IMHO, LKP cares more about the possible performance downgrade users could
observe and assume users are using distribution. So LKP sticks to a distribution
config and using the default value for new configs.


I did test the will-it-scale.read1 against the commit
   20ea1e7d13c1b544fe67c4a8dc3943bb1ab33e6f
and its parent commit:
   9e0ee0c7545c7ec012a53878e7687e05b87abc75
by using "read1_process -s 4 -t 1" on a IceLake platform with 48C/96T + 192G
memory. I don't have available Sapphire Rapid to run same test.

The config is with the CONFIG_RANDOMIZE_KSTACK_OFFSET and CONFIG_HARDENED_USERCOPY
disabled/enabled.


I found the result is not stable. stddev is around 7% ~ 8%. larger or close
the the performance difference. For average: there is no regression with
these two kernel configs disabled. Around 9% regression with these two kernel
configs enabled.

But from LKP perspective (Oliver, Yujie and Philip, correct me if I am wrong
here), this test result is not reported as regression because the stddev is
very close to the regression.


The specific result is as following:
parent without random/hardened_usercopy:      child without random/hardened_usercopy:
	4050865                                	3570609
	3732989                                	3971604
	4043509                                	3577899
	3644475                                	4106721
	4156399                                	3432816
	3633719                                	4207917
	3508474                                	3581210
	3363729                                	3548164
	3794146                                	3490865
	3449113                                	4088112
	
avg:	3737741                                avg:	3757591
stddev:	7%                                     stddev:	7%


parent with random/hardened_usercopy:         child with random/hardened_usercopy:
	3770330                               	4279949
	3824055                               	3377960
	3497524                               	3359246
	4244985                               	3462981
	3442711                               	3520535
	4418889                               	3436251
	4255512                               	3884103
	3605148                               	3480065
	3965194                               	3230780
	3654892                               	3372904

avg:	3867924                               avg:	3540477     9% regression. But with 8.7% stddev
stddev:	8.8%                                  stddev:	8.7%


Regards
Yin, Fengwei

> 
> Thanks,
