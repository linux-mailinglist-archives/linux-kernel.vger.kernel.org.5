Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 424E17BE8A7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 19:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377467AbjJIRtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 13:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377097AbjJIRsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 13:48:52 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE5494;
        Mon,  9 Oct 2023 10:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696873731; x=1728409731;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uCXJ04EA3FkZkjdCy+K0F/UB2aaZWB4AqFTzREBgbDg=;
  b=RvIAmjHrF8crK4wDZW1G7FhRzRvKHbAh9ICyo3qDUb5op6rHjkmc2Vi8
   vuO+kqbTygMOknPWTxSGjg4Swkkk9BR4bU19GCR/sDYNDDXD627kLAkNw
   2tul3wSuQnvMJX3puGiQ3dOwwbBgMH5ORbXMSUc1oCA+hfCaAsQWd4B0+
   dQesWhzcBwF+bwB2aCeNBFgLz0LNuRtti22ziRht01MvgVHUAmu0UrsGn
   aYs2MQr6kS/DMs3V3Ve/0Fl3IbpmRL0gSwriwRaC/jcg4faFdyr07jSkD
   yEzgUjPEjs3HvncV4pi1GYABdDKTq/7iciQ4DVKzJp42z+Q/9Yk5VjzTg
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="364498518"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="364498518"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 10:48:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="788252527"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="788252527"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Oct 2023 10:48:45 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 9 Oct 2023 10:48:44 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 9 Oct 2023 10:48:44 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 9 Oct 2023 10:48:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cz9lQUxMcM+p8NhKfv42/jpmHLm220AL4JWk6HH5u5DFFHOd3H0NYqGOehP20GalCOBM50LkPAx4EwqLKFlzXJZCGlzcAq0+7i732WyC60/WKKNycYk1d9u9Jo4bBmgQ/GYVSyjv7m8J/r5R6L+xFOmyZftxaa9ujIOWVIbTg7qUd753IEcf99OE3WUgy9te1gg3ZMZ+iABiQgnbquNNg1wuJdIQgUWX75iZqvItR41EO8bz5e2NZRKEcy+udAdaINaM4XQe9GRmTKKIk8u2oGDyieUCneb8eAO/L81IdDSp+WhkkIk+MCdqSTz+YQkndWf9TOnwSUasclYv2WRYxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pj3BCl/XiJslu1E0x56rr3CVm7AXZu4t9vtQMBKfwPs=;
 b=YtkzzcKqY7THPzTuL6VnsrIFzs/8deVhnk4FMXdhrU4L/KvnQl4su/6NcgXiEvkeXBIKf5vFJWcEVknpc7mu/gcRQYT9BF4ibNwwPoUO5hbhpYX2OQVyUX736ou5qRqns268tpz80gfPLZyxneHqpVEdrhe0zahk6308OVNgsnAwpRL70EP9D7vJFAD9x8fHbxXtNrQT4DATkAMe70ySFZ01h6EyVvEkz93P0DSrnVhGhNgV/IY+Yw8snVlOzofV17UdMOnCGiQjikz0PJdm3FjalTKPxWn/7VWM9hvPaJKMEE9KGaAo1u15rPYwDXLhY3xmHxCordz1t4fDiCIHoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH0PR11MB7709.namprd11.prod.outlook.com (2603:10b6:510:296::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Mon, 9 Oct
 2023 17:48:41 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6863.032; Mon, 9 Oct 2023
 17:48:41 +0000
Message-ID: <1f571145-90ac-45be-9da1-681dc200051e@intel.com>
Date:   Mon, 9 Oct 2023 10:48:38 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 03/10] x86/resctrl: Rename rftype flags for
 consistency
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>, Babu Moger <babu.moger@amd.com>
CC:     <corbet@lwn.net>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <fenghua.yu@intel.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
        <akpm@linux-foundation.org>, <quic_neeraju@quicinc.com>,
        <rdunlap@infradead.org>, <damien.lemoal@opensource.wdc.com>,
        <songmuchun@bytedance.com>, <peterz@infradead.org>,
        <jpoimboe@kernel.org>, <pbonzini@redhat.com>,
        <chang.seok.bae@intel.com>, <pawan.kumar.gupta@linux.intel.com>,
        <jmattson@google.com>, <daniel.sneddon@linux.intel.com>,
        <sandipan.das@amd.com>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bagasdotme@gmail.com>,
        <eranian@google.com>, <christophe.leroy@csgroup.eu>,
        <jarkko@kernel.org>, <adrian.hunter@intel.com>,
        <quic_jiles@quicinc.com>, <peternewman@google.com>
References: <20231003235430.1231238-1-babu.moger@amd.com>
 <20231003235430.1231238-4-babu.moger@amd.com>
 <20231009171918.GPZSQ2Frs/qp129wsP@fat_crate.local>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231009171918.GPZSQ2Frs/qp129wsP@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0360.namprd04.prod.outlook.com
 (2603:10b6:303:8a::35) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH0PR11MB7709:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d7b19c9-edad-45eb-5092-08dbc8eff9a9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rJsK7WBskDY4KfANutGY8Wrht0/sUD2KcpI3fS8mRtFO4Zl5B/wEyjcZivguijnZb+zsfsXMejx4HLZQ1w3Rx7+TyrnSYaPbxpcYC5AgJy/2qQ2KdjVl0t5zv7/WLRx0Q+ozeKq56t0/d0aNZYUbn8bV3iUJa68RGnb10t5TXVY30VWnbbOqStGtXc0cf1qBgzgyn/H0HmXxkq02S55c4y2Jnnq819VqdJBgo/SbsIRrAjDy+8lV4YOv2IU9EFfWjVME+PWN6qNBu3Wbwed+XpjbLDZRHhztL3pLM27KG1x0AJlJJU7F6S7VBxril5TMt69G7il4Wjmvf/DDigR4ggVtSnSbi+c75CweYweUmfA2qb6QvUyuBrovbRIAxF8nn2FmQuthcjWY9HsK2glcKb5oUvqf4fXys31GZgB3T4VdmG2P8e31JQSacvymmyCByUAK8C5Uw6rCFonRe4pVcYLSQc0/otzH6eQjYQGRYq8Nb28Y5IvmjdEFq2UfExLpcITWOt+S88pk7VjtTQBJRKR97O8QklAKBaaktJqxeF3A574yc5B2hXiqZXEyLnWOnY+msdUbWFgl3OF4pzo0Nqd5cZ/yfoOFCg8eTk/hleh+kJAqZE2xw4+9d7oz7dxoaPbqdnCwW/DqOzdKZCWAqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(376002)(366004)(346002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(53546011)(6512007)(2616005)(6506007)(478600001)(41300700001)(66476007)(4744005)(2906002)(44832011)(83380400001)(7406005)(7416002)(6486002)(316002)(110136005)(5660300002)(66946007)(66556008)(4326008)(26005)(8676002)(8936002)(36756003)(82960400001)(38100700002)(86362001)(31696002)(6666004)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTVkeEtZVSsyVktoN0RwNzRZWklRVmFpRGp4RUFoM3VaZ3d3Z2x5b0xpVENo?=
 =?utf-8?B?ZXl3ejRnRWZ6UUNDRkhRS1EzZzlqVS9GeUlvaXhFVkZxSzVmY1dLcEVoUk4y?=
 =?utf-8?B?WHdrWXJ3V2NOUjEyQlRWTzZRTHprbzlKOWdJU2xGaXVBMVhyWTZET0FxUEJs?=
 =?utf-8?B?UEk4alJ0SGxGVVFPaGZibFJFSHRDMUdTajBtZ0VHOHdmVXd2VENhUHA1Z2Ey?=
 =?utf-8?B?WmdWM0hmdnA0cUVtYW8vaXZXRzlHU3JWSkZzMkE5VW5rZjI4UWhHY3FUbDRH?=
 =?utf-8?B?UVRWY2lTQnJtMVZFMzJuelV0ckFTY2x0bXR5c1pMOUFZQ3Bidm4zWm1vYlM3?=
 =?utf-8?B?bmswb2VodXVBUk10Y3N6cGxUYTJTWHBZUUdNdXNlMkhHVCtCb3Jpd1FycnZz?=
 =?utf-8?B?RG43WEdzbzZyUHlrc1VNVnNyYlNhTXU1ZTJHc1UwSEFGZTF6NFlUOGpnMzlt?=
 =?utf-8?B?bWFqT09WcXJzTVllZklENEFmUTIvTVh1SkpPQmhBdDR2UHM4WnJiVTZsK3VL?=
 =?utf-8?B?bDlnR09rYW50UWdBOTRuTys0UzIvc1FMVVB6eEVKWUNYSzVZdERBRWFtUmg3?=
 =?utf-8?B?ZHFHbHV6UVpDVWdwTDhJTmdDMGo4SWlBdVZ6SDd1cnpWVGJnUlZpRG1uZmFC?=
 =?utf-8?B?VXA0T0pxTE01dGo0T0xZYkY5NkhpcC81b0dyOWc5eUZYVkEyQ29td0RKSy85?=
 =?utf-8?B?NzMzWGYwRWc2ditXTTFLcjY2MzFjUysxMGRmeHhvWWtEN1N5ZExWYXQ5WGQv?=
 =?utf-8?B?dlBnMkFrZTNtN0U5M2FZSWlHS0xjNTkyVjJtalFtbHVOb290K2NNSmJyME9Q?=
 =?utf-8?B?Mkl5bFdjWmdWbi9SczNWZzVERHRKdXFpT3ZSN0RNa0dDUjdIR0dQYkVQODVl?=
 =?utf-8?B?L0xaKzFwck9TMFQ1WXNjMDE5L3BEMHFLYnlzdFNnaWJHMmVaZkNDdkVLMkFO?=
 =?utf-8?B?TzlldHBsaHJUalZIdGRSU2lkdHB4QUt1MUQ2U0N6RjhyeklYeVZrQzlESmNs?=
 =?utf-8?B?b2oxaitSSFY2RjJiUGVWVVkyQU10dzA2b3hXcXBrZFlhTU9CQzJIUEw3SDJX?=
 =?utf-8?B?djQ2ajczMXgza0IxZ1grWXVnN1c0SHJ0eXNFcXh2aDJXM2ZwK0JvdTZVMUht?=
 =?utf-8?B?cWtQakppQVJFRE5XbU1xeUM0dkZBS01zMlV0dTNiVUExS21vNUlRbmZPQTJQ?=
 =?utf-8?B?aFJkQVFBUGplaDBpYUxoYnFMaVliN3N1SDVVK1hRVDN3eUEwaFl2TytXcytT?=
 =?utf-8?B?TGRlN1RRaUEya0lGYVBKSU03Tm9qRXFNV2tDK2V0TXRmWlBsSkZkdm9tZ2h1?=
 =?utf-8?B?MVpMUndrWmE5cHFTcWZOMWlUVDR4b2x0OFRkUFk4QkhUT0oyN1d4dU42d0dh?=
 =?utf-8?B?ZlIvNFFjZEdhOW9GZ3lxMVVJeFRXSUZvNElwNFlFc0h1Y1llbnBTRUNmbXBG?=
 =?utf-8?B?d2wvMXVrb282L0NyU0ZDS3hSS2YrMUlPTXVaWDJQOXE4Nmd2enlNdEN4NzdO?=
 =?utf-8?B?SHhHODRxWk55bEhFeDU0bEgreTZPQUlrbXd1OHJjTjk1eVQrdFhzVnA2REls?=
 =?utf-8?B?RTRyQ3Y2ZEM5aGJsd2Q1QTMyTWtXdXFrbHdWSnAwT3BEMEZpbzlQU1prSVB4?=
 =?utf-8?B?dUhodFpFUVFvalhjOVd1S0IwUGdGQjlmU1JTWUZob2UrcERFc2RPUWZ3aVZk?=
 =?utf-8?B?R1ZHaVpDM3IyNzIxc3RNUDlvN2FUb2xWbzlZS2QyVGVlektteTlSYVpZaE9F?=
 =?utf-8?B?OWJTK2hIZjJ0aDltUjMza0tpUmhLWEw5dC9VWXNyOHZlRkhZRVJPVEZ3Znlx?=
 =?utf-8?B?ZHFYT0N6TkRaK3dNVDdKbE5lMm04OGRybUpqUWlXYWN6UEs3dmptM2V0QXAx?=
 =?utf-8?B?bnNNM05zdVRzOVcxaTNuRFFlS2FXUi9UNVh1RlB1L0VpTGNaQy9RQUZ2WDNx?=
 =?utf-8?B?TnhqT2RvaENhL2lJaHVDMW84cXZMWHZIRjFUWFdMdU5RRGpCbGtkSjl0N0lY?=
 =?utf-8?B?cnVrcXkwNlUzWDBXMHk4N2E1ZXc5enhrSDVNVVJlbjhTOUhsZ1FWQWpORzZR?=
 =?utf-8?B?SFJHcGxrVzNpU2l2UW9RWHJtbTZ1ODdWSWFpbHlpdEhjamc1c0g1WkdHMHQ0?=
 =?utf-8?B?VnVtSzJRclgzYlJrUmRkVXVJRGdkWVZwa3A5ZW5vbm9OWGYzZEp0UCtIWExT?=
 =?utf-8?B?Rnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d7b19c9-edad-45eb-5092-08dbc8eff9a9
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 17:48:41.6484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dN1a7LAGCXzUSZScszLGKtd9TASv5L6AWCjGHgfbid8uCs8oTWMfOLYi/IPnTZ2lPZFcrXRbKfTSh6h74p5gi84HF4VUe+PCJGQdn6PAOTg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7709
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On 10/9/2023 10:19 AM, Borislav Petkov wrote:
> On Tue, Oct 03, 2023 at 06:54:23PM -0500, Babu Moger wrote:
>> resctrl associates rftype flags with its files so that files can be chosen
>> based on the resource, whether it is info or base, and if it is control
>> or monitor type file. These flags use the RF_ as well as RFTYPE_ prefixes.
>>
>> Change the prefix to RFTYPE_ for all these flags to be consistent.
>>
>> Add RFTYPE_MON_BASE that will be used in a later patch. RFTYPE_MON_BASE
>> complements existing RFTYPE_CTRL_BASE and represents files
>> belonging to monitoring groups.
> 
> First of all, the concept of "later patch" has no meaning when the
> patches go into git, depending on the listing order.
> 
> Second, why isn't this define added in the patch that's using it?
> 
> A patch needs to be a logically separate, possibly self-contained
> change - remember that.

My apologies here. Babu was following my guidance on this. 

Reinette

