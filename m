Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63A6E8041DD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 23:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234311AbjLDWv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 17:51:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234279AbjLDWv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 17:51:56 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C13C6;
        Mon,  4 Dec 2023 14:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701730322; x=1733266322;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Rad0+D+r2hmBsMux47RIXPt364aUdNokmQBEQzRYzqE=;
  b=fDF6K50OoGFV7sA+N0wN50dm2ZMX4vrZdSsWndcXMy5kHm412TymRQFr
   FjzzbviiechYpPX91D7nfaiohpNMuHAtBODR3QPzQ9KTsvAtlpQT69DH6
   HBHmod2ekaPOQNLZS3epT3I9+mvxex2glWPKtyCJE02f/eZEpdBhxUF/g
   iENpSywavsFpkhMkNQ2l59qa/1gSV58fM5A9OxgcTyyYTnsHusfj7HxS1
   PJ2NpWy/YPqsttczo6vM8Q2l9i7nSUXHviS/yjtOL2z8OSgRbMkNQlVHG
   ivGtvT3BjAOEYxHkCZDT/hJZCQcPPXEYII/CTvpRrVZllcMvseYN/bX7Z
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="373990945"
X-IronPort-AV: E=Sophos;i="6.04,250,1695711600"; 
   d="scan'208";a="373990945"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 14:52:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="764117854"
X-IronPort-AV: E=Sophos;i="6.04,250,1695711600"; 
   d="scan'208";a="764117854"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Dec 2023 14:52:01 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Dec 2023 14:52:01 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 4 Dec 2023 14:52:01 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 4 Dec 2023 14:52:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ud/91YwIfj/MQO8YYCoBdvSgF/rjGR+a+31d9u5hOh5JgTj0NzkjZk2sHMZRNREpBI5iGgxHyXWXLgZuu4zUyKiNoLqzsMw63m+bpjarvTuP5LC0lu0QZFPhhtuis5zgUN1rapQyZRqtOK53FzzopXwhyyrfxN/KDj1BjVcqCexjcfTdr0JZgRuT6jtEgUNrfFAAgK7scqTOqe6UO1T2sZ5KF5N+2+CkW7uuTqZ6JWSXrNnP6/MLMjKONP3iErT0L1H5X0szBpDsHhsZheKRLlu1JTehgPRQHmHf0Fw9laRFpCHGdvt6Wkk97RcCK+ebrskoCyt7xmlGWQQBizwtpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=25g68BEgYg8/hxv48JCYOdupSjkFSnYnB98r6VVtL2s=;
 b=oSezlVP4FBc4VMyx+pmHVL1U4/WVy13LxK/LSxRBKjtzcw1t0sxKuYURNrrzPC04V/jbFRWCQd8cPIvTS4z3/4zSUTzulMaS/KyvJ4dSWgQLD1exTp5TakglyoXsafUkec2G34lOPJBaySocpNlzCoA5dk1X9Z3aZhj6tCPprtPfo8f3nLixpQ9f1Jimp2pNHO+ksE1On6uCRtdPSNYkBgpDb3D1VUyay9Y3iHL0GXaP+60GGGvSz8atigGqSsZiJrRNMEylLkffNNfkRrYkZuoBcnfO4ApJhQzAvvX78LOx8QcqAHszGHtKblOAiLg0n6lC4TY9Sx2DypuQ9/mDrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 22:51:58 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.7046.034; Mon, 4 Dec 2023
 22:51:58 +0000
Message-ID: <52df445f-c2cf-44da-aa6b-995a6beeffc6@intel.com>
Date:   Mon, 4 Dec 2023 14:51:55 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] x86/resctrl: Add event choices for mba_MBps
Content-Language: en-US
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     Tony Luck <tony.luck@intel.com>
CC:     "babu.moger@amd.com" <babu.moger@amd.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Peter Newman <peternewman@google.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
References: <20231128231439.81691-1-tony.luck@intel.com>
 <20231201214737.104444-1-tony.luck@intel.com>
 <fd8a44a1-9001-4e3e-a1a9-63e7f737e6e1@amd.com>
 <ZW4XjqxfYBFZId6H@agluck-desk3>
 <660935b2-93bf-4ca0-836a-7aba46009c5c@amd.com>
 <SJ1PR11MB60839F92B1C15A659CD32478FC86A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <0285bbec-7152-4f54-94a3-45ce265a3ebe@intel.com>
 <ZW4/sE4Af0p3jl07@agluck-desk3>
 <0c2beb97-437c-4315-9aff-14c650297565@intel.com>
In-Reply-To: <0c2beb97-437c-4315-9aff-14c650297565@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWH0EPF00056D18.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:19) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA1PR11MB8278:EE_
X-MS-Office365-Filtering-Correlation-Id: f769d2fb-f4d7-4f01-0a01-08dbf51b9eed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OFagApjRxhtiDOs63NMMx40bTMBRp5NYcj2jRwM+SBvtYFeND0ohRKgW/eF8fiFJJIYIA7vvMzJTlXqYN+lIqHz/r2sdlHyxvKm3ljZi8wzSuyzTFiVUcMDnPVg01JR/FvwvtjJgVro+I76ndl3lsOMHZSTJQOMU6yAvNvLCNdOOp4TWvXItddlGhnhyL9fBsSTBRXJjl/MY4CQsGtIT0lwSXfzUBr/hhJ9NdcmE/GMz9pzLex+LiUShZcSsMAmZz5czZirbutFICnPKZg3xn70rKU1yCvzogYt9i1tBMxlTg1QEo5PHcstNNeJeDsNUmQQO7JMmK1L0NgvfQNzSLPmn3xhU574VCtSVYYbvOqYCRtFIUne6xUsAvQH/tENv4YkUpLY1GkZhVixzopo8vE2phzKg8J5wXnxkzlwg7Mv6u9G95pPTOxO1eqBhsvLxViz5NxXinzcqgTRiRuNnBWEELfGxmQY4C06PbuN6EsDVHYkhJA85LcH8DhJlGwQ556tgpJ4a+tMFwsyOGCaBciki482aPumHKX91PuhfD8I5jcf6/LQ7UjfpY/YM7IYrBikOtRiNoAubgGuaIVu/FvMMx2Y3OVFTEjVkUJaY9Nz85762rZLKG1BUmNnraCy9/y8TRaRACvETysqU/55V8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(346002)(376002)(136003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(6486002)(7416002)(4744005)(6506007)(6512007)(53546011)(36756003)(26005)(2616005)(41300700001)(82960400001)(38100700002)(86362001)(31696002)(6666004)(2906002)(478600001)(6636002)(44832011)(316002)(66946007)(37006003)(54906003)(66476007)(66556008)(8676002)(4326008)(8936002)(31686004)(6862004)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUNDQnRaU3poTmI0ZVkwL1htTk9HUHpRT1BSeU53V2hSYkRIemJHSVN4a21K?=
 =?utf-8?B?eUtIMkdzdVB0OU5vWVc5Ly9teER2b3Fhd0lISm9XRU95NlJScmhOUTUvRXdH?=
 =?utf-8?B?ZHBsZkNiekxCYU1QNmJTUjhVRlRCYThlY0NMdE9hdHI1WlpGSSsyTXlJcW1H?=
 =?utf-8?B?THdabENGMk9qWVdHWit2aXFVU0c5S0RDUVYvY0xMUkwwY2Jpd28rVVI4Y0Fp?=
 =?utf-8?B?N1pqMkNzMjhFU1pTRE4rSGd5TmdNOWpMRE5NY0p1bFR6Vmg0YS9MTFpCUzM4?=
 =?utf-8?B?dlhyVFErVmUrdi9SMnFGKzNZa0hNcHJESkE1anVyKzZlUTgxRVRLRHFnUEJR?=
 =?utf-8?B?WHFyQVJqMjRBU1gyc1Q2ek9zR3lLYnQzMVo4TStTRGRPdld2WWxoVmZ5TWV2?=
 =?utf-8?B?enRUWkR2M3lFZjVFb2tPRVoxeVlDbXlNMnlQNlUzM2s4enlHbzRteFhqbWlD?=
 =?utf-8?B?dEkrU3FVMTVIMDJUUWlnZlk0b1lycU5nUzZ1d2NLT1BDL0hqSjFuRHpNOGpX?=
 =?utf-8?B?ZmpWeUNXRG5iaFZnMVQ5czliQ1FHaVdtV0RpbVpIc2NBbW9TQzZCcUZYUHhZ?=
 =?utf-8?B?Z0hKMHAyK3NYQTJsSXhQNlpRZlZid0F3M2R5d2hrc1luMTREazNZRG9BTUxP?=
 =?utf-8?B?OExuNURkc0RsVkwxQ2JSck5uQk1MQmdIYkxZYWhIY1ZSTSs1OUhnV2p0OFIy?=
 =?utf-8?B?d204ZGVqMUJ6MmdKVWtYZ3A2bGpaVmRaaTkxMy83QkFRd2VDbE92TGdyd0RB?=
 =?utf-8?B?ejd6alZuYTdrdFkvcUNleEsydnZxaythMnZaL0NVZTgvNGJNdW9IZlJhenl0?=
 =?utf-8?B?d2lNVENiZFJYLy9ub1lhbzRpcnU3SktFTVg5OFY1WklYMGp6aUhsaVBBQ0Zl?=
 =?utf-8?B?ODF6QVhlZGk4blpDM0dlbzlKY0xWTzd6VGhBdzRmQm0wRCswMEdFeDhxS05N?=
 =?utf-8?B?L0dMZ2hlRVd6WmgwUUZLSll1TS9yTUR0cWdIWDQxUGgrb1ZzaG9DQTJjeGhB?=
 =?utf-8?B?SWtodmxNd3Bjd0RhSGEvbVZ1K1FnMUFsa21uSThWeXJleGlQamJTdUtSWXh4?=
 =?utf-8?B?UjVVRHVPRnVzZk1GaFVUMHVrREI4emxEekZITU45RnJCUWpmVk1YWnJjU1I4?=
 =?utf-8?B?N0ljU0xjT3V5STVBTG5rcTJFd3Q4eWcwamViUGRqWW1nYkMyMW9XUWFuaGV3?=
 =?utf-8?B?T2tBWEU1cFlVa0k0eXMvd2U5elBUY3FRYStyZ1FqVENMTVhSb3c0Zkx2eWp2?=
 =?utf-8?B?OE9hMFo2SDRTSUlBSGtiRUdDU0IrY29mNE41NUZab1VncDVjTVhzczVXN25O?=
 =?utf-8?B?a0VDOUQ3cyt2dzRvWlkycm5tVmk2dnNxK2dYaEZUczhFQzhqemoxc1hxOWV6?=
 =?utf-8?B?d0E4UERUY0Jwd1pxWDRoalNUeC9vSUwrYjZnZDZ6QVhNRCtXTGpuKzlMRFNh?=
 =?utf-8?B?SlBiYlFTOEtxUTdaTDJ6Y2h0T2VteURBR0h0ZldMaDYwWUh0Q05CVmpJc1FU?=
 =?utf-8?B?ZnRFU1h0Ri9OczQxZXdpL1hvRkgzMklncjI3enFlYmgyVVdIQ3d1Zm1IS2Vv?=
 =?utf-8?B?RlJLOWN6OE9XUlNlN000cmw5OGlua3dnanhpbkNGNms0MnM4Nkg0Z1pmNzd3?=
 =?utf-8?B?cUJzUkFkWjNzRXpFdDg4cDRZamhrNFRpZ2JCd3hvL3VXTURpeW9FZnQ2R0Mr?=
 =?utf-8?B?L05FYnhsU004K1FVc2pMbFdGLzBscmJ6TWp4NnkvUy9MQWNwYUZGRFI5Zmo2?=
 =?utf-8?B?WFBvY3JhcWhnQjBFNFRXQWdBMFEzbWFxRFgvQ2luRitsek81Ui9zY1A0TGov?=
 =?utf-8?B?aUhINFZWUnBBZmtXYWJub0Z3aXMzYjBRN3FpRzBpR3dWL0RHZ3dEOWZiL2hU?=
 =?utf-8?B?blRRREZNUW5aczgxd0RUcmZCcUlFNGdUVEZYUHY3V1RGREU1UmZDWVpUd2Vq?=
 =?utf-8?B?OE9NWlh6SlpiR3NsVDI5Z2gxMVZzeW5Xc3JEaEo3ZDNZb3NKMnNBSmlMWXlL?=
 =?utf-8?B?UkJPWVNEblR1aW1ySTBzbzdrNWlndzkvMDBVTDVJZmpTaTl5WTMwQjA1WEtG?=
 =?utf-8?B?MXNhTDFoOEhRaVVPYnJmc1ZHM2txOVVpdmlNWUVnV3hEQ3FGYUwrWDJ6RW4x?=
 =?utf-8?B?VGFDaEI2bW1ndGxsVlFYNy81M3VFYUF5aW5TUzV6RzcxYXBWYno0WlBEa3JZ?=
 =?utf-8?B?T0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f769d2fb-f4d7-4f01-0a01-08dbf51b9eed
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 22:51:58.3878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v4QB5KSeFDnF4TPkMt2IpLfoGqXRT7HjwtEj63/Ip8LDVF/uYSVaTkxgDr21NTmZXizh8ZDyLSIKj04NORDHF49v/WlWKpSWiHQBKb70XKY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8278
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



On 12/4/2023 2:15 PM, Reinette Chatre wrote:
> On 12/4/2023 1:08 PM, Tony Luck wrote:

>>
>> B) "mba_MBps={local|total)" forces use of chosen event, fails if event
>> is unavailable.
> 
> I assume you mean "mba_MBps_event={local|total}". This is my preference but
> I would like to learn more about Babu's "overkill" argument. I do believe that
> (B) is well motivated in [1] and has no impact on AMD.
> My uncertainty here (considering one motivation is to future proof it against
> adding more events) is the generic "local" and "total" names. Even so, all
> I could come up with are "local_bw" and "total_bw", which I do not think are
> improvements.

Thinking about this more the existing names in resctrl may help here
... "mbm_total_bytes" and "mbm_local_bytes"? Any new event would need to
integrate with these names.

Reinette

