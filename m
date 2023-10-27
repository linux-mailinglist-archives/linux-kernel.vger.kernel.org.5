Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0D47D9E3F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 18:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbjJ0Q5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 12:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231995AbjJ0Q5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 12:57:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65CDC128;
        Fri, 27 Oct 2023 09:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698425833; x=1729961833;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/MHDkrwWcKVx62jjsaUUldjTZCiQr9Lv3RPaUtnH0YA=;
  b=awAnV6ZCHQ0sqmpnwnh7TrQjk9BbKdNgPtdCFlzgqPSHTw7AvZJT5Hbk
   N9YAuzCVK2rvFJi5hLNigpnCHCXKN6aiVIgRaDcP3i0EsRapfBDDGhJGI
   QCa+M18+ILO/OYTx20YBCR79X9f2wXHUmsANd3DdNQuwuKdneSqxOMsHU
   wKyLtwGP7jQm1EcEoQUFDesWze67mXX7gcxSWF4mDK0pApyaId8KkGl55
   cKIHKPUHn+G9dJq9eg49YtUMt0eono0TPMqZ7kE4H0jdBYtpY4FEQUNKV
   Hx972sdmZdCQDlpxh5uThXHBxhIHafiWZEfPPc1HQGpBX+PG0hhcv1DJE
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="418923014"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="418923014"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 09:57:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="825403480"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="825403480"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Oct 2023 09:57:12 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 27 Oct 2023 09:57:12 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 27 Oct 2023 09:57:12 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 27 Oct 2023 09:57:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cIl/AOSde2hmkO7QZe3sgt/3Xw3S1zTUcMTWoeTog+R0SjDOMjrnTUX5/B4NJpYUJDtmKCcjq79g4YZuNoSPGaaPyYGF+BqkUYco1QNG52QR3aXGk27n7taUhbEkoW34yjuzH2HD2D6IIVeE3sFLwoZkl1WOtlIPNsN7BG9NX4u5RrCfJgKcXrWU+K73ydCTrPXqdtNS2CBCDx3npcXWR7TjuRZLcB8gbZVLuth6/S0MN/4O6RiRTs8kaE8xQwTgxeFHpZbl4Y/Rfd7tqbOoEsvxea9HWCmNtvOD+MulQFv7/XJJRDLb1LO4op6NMlznDDlLHZip8GIRtjX3zYlogg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e820IZRv1WTu2YwMdxb2m4ORFbIpDkh/eT8dCzL99oc=;
 b=FI33vAsJ+PWFetI7eP0op+nT6wH0T+ElBvLlGIo/1PdwTx7s+cuVXkbYRewLXJR03McTYEFkC298nvIrUnqsjTgvPhsD3+N7EgJ/HrNAiAD9oqUl8oAmPBnLSGtsosqxbuujzEgD5ggP3T8/+ge2bW6ol3E2sbXASIsKRf6QBRhW5Nnj9urdkXsT9N39/yiC1vlS5smf+0PjIjmloV4cwCJOUH0pSiQyvMFUwPbuUay/156B2U+i3TrW+FJGxbvA5R6DWswnTkqS9TTpS+y+9mpZxIo0/m+/+dpeENVGjP5MkSzt0R/coaLkY1c/7unkBaJQULC9JyQSBmGXq0Yq7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH0PR11MB7657.namprd11.prod.outlook.com (2603:10b6:510:26c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.29; Fri, 27 Oct
 2023 16:57:10 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::2724:db16:fe7b:2ffa]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::2724:db16:fe7b:2ffa%6]) with mapi id 15.20.6933.024; Fri, 27 Oct 2023
 16:57:09 +0000
Message-ID: <0746c819-b44d-4096-81f4-8946e2f5f7a2@intel.com>
Date:   Fri, 27 Oct 2023 09:57:07 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 3/5] net: phy: Add pluming for
 ethtool_{get,set}_rxnfc
Content-Language: en-US
To:     Florian Fainelli <florian.fainelli@broadcom.com>,
        <netdev@vger.kernel.org>
CC:     Doug Berger <opendmb@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        "Tariq Toukan" <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
        Willem de Bruijn <willemb@google.com>,
        Daniil Tatianin <d-tatianin@yandex-team.ru>,
        "Simon Horman" <horms@kernel.org>,
        Justin Chen <justin.chen@broadcom.com>,
        "Ratheesh Kannoth" <rkannoth@marvell.com>,
        Joe Damato <jdamato@fastly.com>,
        "Vincent Mailhol" <mailhol.vincent@wanadoo.fr>,
        Jiri Pirko <jiri@resnulli.us>,
        "open list" <linux-kernel@vger.kernel.org>
References: <20231026224509.112353-1-florian.fainelli@broadcom.com>
 <20231026224509.112353-4-florian.fainelli@broadcom.com>
 <0e64566f-6dfe-49a7-aeac-21ed9e66bd75@intel.com>
 <6bf05528-0d82-4b7b-b584-5c1d32b25ea0@broadcom.com>
From:   Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <6bf05528-0d82-4b7b-b584-5c1d32b25ea0@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0059.namprd03.prod.outlook.com
 (2603:10b6:303:8e::34) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH0PR11MB7657:EE_
X-MS-Office365-Filtering-Correlation-Id: 277a6bda-dbc6-4ab6-ad12-08dbd70dc25a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nYrq7tZ4SJ2ekyEPmK/dDpaOGyOzMTju1qiK/4yw4CCZVOnxygmECpuIPWUO+ZppZC4oTjWQptdUDfETLOtt4fUNB1/kR08tOLd9FvWkTxi8eV6ABSJ5QM6BHE8WNRxAZiL5ELcipsQHUgsNAeUdpc6/U3SyJNSwn7/ilgAxLhuKgfXOFUKlZs0va9CHb9eoRMnH5wVhHUGrH8eFXTLrZ2ueq1b9G4Vv/7FeRRt6WfDpam17ZMd9/dDVt8c5H0cW6OO615lx8jj90ymHIMVwu+2ip6sXetEozRpex07SKakS3GrpfP9rZF5T40LiMBaGkuYnVYR1rbYUupS6Fs80HSnS1Ooz2h0A6hfG8tObh4n2YqWzGNXkndRB5LjTm7jZmkvZnmvltE6KdviV3lvbkMZoOzdp7sxCcs31qGKBEArxXyE/0ZESL2lKQ9UikrECAWOWyWyZQKpIyYCwYmN/IjONLbi2SIa44hCTw2QlfUAnKMIRVhFUIc8iULBjusOZ1lQGEJF4i9pJS8I+vxSZ5yrjLg67pT2Ud5kzifYP8KNZHEepHuARYRQYlOeduQP19kQ54r0f0kNWphar4vQUmVTOWIgSzj5F8aneYxih8FQ5HA0JW7YdTdjDHh8PdscOlp90t2RPHtgcLYNF4Ld9Yw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(136003)(396003)(346002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(41300700001)(2906002)(38100700002)(86362001)(54906003)(66946007)(82960400001)(66476007)(66556008)(6512007)(6486002)(316002)(53546011)(31696002)(7416002)(5660300002)(478600001)(2616005)(4326008)(36756003)(8676002)(8936002)(6506007)(26005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ym5meXpzc1ZNNldOSmhCYlBsdFREVm1NTmU0MHZDNG83Ymg5MWhIN1UwRERY?=
 =?utf-8?B?YlF4cTdBQ3pwQk8yaGlteWFYTUY4OEVRcHVNaGNETUN2Wk5ocEROU1FxQlpr?=
 =?utf-8?B?Q0dkUkd5a2s2VzBmdWMrTXZ1TEgwdWVuZVdxQ3FMKzZyd0x4bTVlTnR3MFAx?=
 =?utf-8?B?amlqTXhFMUJxNzFGTWE5a3V2SzZhaE9ucjhha3NLTENDN3d2dTAyeUxSK3Ux?=
 =?utf-8?B?R2liOTlseU1aazZ4dGVsM01mVnRZMkkyT2RWNXpPdUMvZ1Q2MEtvellLd1lw?=
 =?utf-8?B?REFPdERJNGhya2Jxc1I2bEdheFowMDRvNDM5Q0JoR3B6TlV3UVIvdVIvYnI0?=
 =?utf-8?B?RE5QNmd4YzhWaThsTndKY2k0Q3VXODV5eXliZ01XSzJ1MG9pdGhmQmpONVVM?=
 =?utf-8?B?blpycEVReGllb29OZWk1TFhvNUU2R2dLem5KZHhTMUVZL3NwY3pEZGRTaG1Z?=
 =?utf-8?B?SkNWNVF2czRHUlpSWFEyWTNTbTNzZlMrSitBc29BSUFwMlJ4Rzk5eHFFMWZs?=
 =?utf-8?B?U21JMC9yZHE3aWJtZ1BoNVYxT25PcmNzT2Y5NUdOT0svYnBKN3YzdUh1UEIz?=
 =?utf-8?B?a2s0Q0RiT3VTMlc5eEJDRDhGNTk1cHVwRktqbmg4TmVkZHE1eWZrM1dBdTMr?=
 =?utf-8?B?alZhMzFRc0pvUy8vTkNvdjdhVHN0SXpnN3YwYk8zRWxBSHlDcUZ6Q3pnMWZ2?=
 =?utf-8?B?VVl6WWNFcjFBa09rQllGRERLOUZtRFdLa3lpYUlFNGNBeUVpbWVtZ29LSGFy?=
 =?utf-8?B?cm1ySGZhcW8vY0RQbFl4MHAzWWk4SGtZWUFxbVBtRStNT2NMei9Ya2M5di8w?=
 =?utf-8?B?L3JLM1BhYnduei9UdU9uaHd1dXBpbzVsQjE4czZnc2RYcW4wcDRGb1lyTkdI?=
 =?utf-8?B?bkxOVzlWSGZtdk9id2QyU3dVVlMrcHMxVWVHeGRnamRwTTZOZkRHWElSUG5T?=
 =?utf-8?B?b2U0TjlwT2ZEZ1dFRDBncjNEN2dJZGVFditnZTVHVm5zUjFXVzJaSjZZeUlk?=
 =?utf-8?B?M05NSEVlek5Yd2pxZk5xZUtING5LTUROeTZxU3FXZmFDSmY2TW9jamViTmJ0?=
 =?utf-8?B?NS9wdFViOXRIa0QraFNCQzJDOWI4OTE4OS9VNG1odEdBTEdzVnZaaWtud1lM?=
 =?utf-8?B?TC9HSnNkNG5va2MxSVZqdDZpY2t5bWFqaUtRL3NFZ3ovaGZjRTJ2ZWZRdFR1?=
 =?utf-8?B?Rk1iVUJVeWw1ajJ1Zzl3Q1F5YzBzS3lISStGdVhLdG0wSU1VZGJWUkhyTEpL?=
 =?utf-8?B?eGlzdllIdEdyVHd0RUszNzVRNzZBNDRUTEh1TkFvdFRTRzdocVB0ZTJjWmgz?=
 =?utf-8?B?MFJmaHl4WWg2UmU3eHByYzBRQUg1TFF4NjJDQitQYStweFg0UTVyTnRjVHFu?=
 =?utf-8?B?MUMrRFBHY3FqaW4xL3BZdElidjhINlp6YjVWWktZaUxqYm1MVFFmbGtnVFB3?=
 =?utf-8?B?RW9uZVpkQnJNMk1IOGdYS3lHYklVWUpKNXJCd3lhR1RGWlo1QUEwa1JkMEZx?=
 =?utf-8?B?Nm9TenB1QXFDMjVOV0FjUmtlMzFQZWpFNUd1UUgwYjlBYStObzJmMGRvb0o3?=
 =?utf-8?B?U1E5UEZjMnpka0o2Q3BBN0lBNzV3VTRPdnpXKzVUU1o3OXZ0M3hTT2c3b1BT?=
 =?utf-8?B?TkoyQ3JpY2VuVWVIOWZTek5jWXhhLzB6M1U4cXhTbExENVJWa29mUWdBMzdt?=
 =?utf-8?B?VFgzT0JPSGN0aTV0OTRKYXg0VTM2dllkaVAvMDF0UkdSQWl4cWt1enJwZXZy?=
 =?utf-8?B?Y2JKMWFaa0dRUDdUYTlOU3BBVkx0OUJ3alM3VXFyWEttL3JmajNob25mcmEx?=
 =?utf-8?B?elVXQVZJbzVnRGxXSWZNVGJNUWhMUW91QmhKQ3FNWDNTdk9oNzZubXFmSzJu?=
 =?utf-8?B?TUJia2FNM1BQMnJsRlNwN2JLUWlFZEcyWXd6RUI3ZXR1VmE2VzdjWnZ4aE5T?=
 =?utf-8?B?aGdJL1k4bTV2UE5IWmFzblVuaFdkUHptN1BtZEdBa1N3TWhwWVA2KzM0TkhH?=
 =?utf-8?B?ZDVPR1Q1SHAvN2lrQVZjbmJQekVCcDl1cFd5M1IreVBzQkF2WFZ5Vm54Ty8w?=
 =?utf-8?B?bkZZd0MwRU5CMlVsUjBMR0MvdEpmb2hZWG5BRkZqVjlxWGs5T1M0Y1JPZ3lv?=
 =?utf-8?B?ZGNjK3EwQjFRODNxRXFWYWlneVIyRXVQcEdDTWwzTlVRb1BCUlZWZ2FPUitW?=
 =?utf-8?B?REE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 277a6bda-dbc6-4ab6-ad12-08dbd70dc25a
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 16:57:09.9187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nkewSfGvUCsJQ1u6dbwWMhK6JpsgeREvIKDGRR64Zf5gN+qEHvSoLPAfFoajrgGmUV/n8JxBfZw5xyL997kr0yUX9D+KILd4s5R9Y3fT2L4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7657
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/26/2023 4:32 PM, Florian Fainelli wrote:
> On 10/26/23 16:20, Jacob Keller wrote:
>>
>>
>> On 10/26/2023 3:45 PM, Florian Fainelli wrote:
>>> +EXPORT_SYMBOL(phy_ethtool_set_rxnfc);
>>> diff --git a/include/linux/phy.h b/include/linux/phy.h
>>> index 3cc52826f18e..03e7c6352aef 100644
>>> --- a/include/linux/phy.h
>>> +++ b/include/linux/phy.h
>>> @@ -1077,6 +1077,10 @@ struct phy_driver {
>>>   	int (*get_sqi)(struct phy_device *dev);
>>>   	/** @get_sqi_max: Get the maximum signal quality indication */
>>>   	int (*get_sqi_max)(struct phy_device *dev);
>>> +	/* Used for WAKE_FILTER programming only */
>>
>> Any particular reason this comment is required? I don't see it enforced
>> above so I'm curious.
> 
> The comment is not required, though I put it in there to help readers 
> understand that this is purely for use by Wake-on-LAN, since unlike a 
> MACs, PHYs are not capable of redirecting certain flows to certain 
> queues, too low in the packet processing that there is not a notion of a 
> queue at that point (FIFO yes, but not queue as in what the networking 
> stack wants to use).

Ah, right that makes sense. Thanks for the clarification.

Perhaps we could enforce that in the interface so that if something does
try to pass a different kind of filter to the phy_rxnfc it would fail or
complain somehow? Because that seems like it would be a programming mistake.

I guess with the current implementation you effectively rely on
returning -EOPNOTSUP for non-wake filters since the driver forwards the
filter to the PHY to check whether it can support it.

Thanks,
Jake
