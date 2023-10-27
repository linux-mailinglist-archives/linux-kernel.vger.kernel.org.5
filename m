Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 481117D9E37
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 18:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbjJ0QzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 12:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjJ0QzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 12:55:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13AB111B;
        Fri, 27 Oct 2023 09:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698425713; x=1729961713;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eGPvpRnqEimKBxep+obSPCPB7W5zA0FO0YXhJGf+d0A=;
  b=YxbnokCCppPAfwdgs3exNOBiR3gObySOTj6aCuXoxlrafo5eEaFPe9LT
   PnhLoVScfSpNYxf3aTv5aZB4BCR7Um+SS0BlVV5p4v/H/pmUbtjabz3Dx
   p218qCotZHRremRep787koU4Mkpu6tG2D7ftEsusMPLt8Z8PFosqg2uaS
   5qvY77BMedZDhY3ajI+uEJiDtYloNDFtBg3NBBzboxUWF4Lhmd2EA7gVv
   IP87WBmgtU+b0uMmi60DN6srzEApmDM4TzP9Jdps8qtTsv3/nMNI8BfOX
   pQoBqEpcxzPL4BV4hbS2EqpmlRk/kQwZSLXmb3LxGjZ+CWve6ZnXu3TjP
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="368028313"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="368028313"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 09:55:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="933143993"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="933143993"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Oct 2023 09:55:11 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 27 Oct 2023 09:55:11 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 27 Oct 2023 09:55:11 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 27 Oct 2023 09:55:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gYBp4Xly8PB+ooKOrmDUx/pWPvzhIR2w8zd+z993j7hn/DEUmMYU3bf0WUX3atQdSTbSuo5K42JlM7/aQfiSc+FlsIURjYl5FRnrQnHTX4A0cwyy3wX9Mta3HHv3uoXxYcgJDgvdXWHnDUu/SuhsFplcywI9YKjcclsm0FY/QZKuPRCg59XFKKHAI/0SkNQo07OpYosPJlA0a2M7lZGjX0UlHgHkYouop/i//eb/bhuO6bDsUsZ+5cFxJhqU7IqQ5IoJVyrgx2La0gidp+yvjwokWpDhWI6t1bBr1Hx5dDdfnFXt0Q2AkVVKyMNcn+nklYo6fKI3GqOHgDcjmGESOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7n8lhoyX7FAv97mzKUK3Z+XHx16YobYUwRODSbP4LMw=;
 b=aTtMqQKdfsavL+9Ghz+oSvmBG4wkJK3aQcrLMbVVvKCna6ggmVNWb2VPLhYu8mnEt/hmqvmLB72uoOu93JP89TTRHNdUZD0UDcCrM8n55s/a9gNoGyk5Og9bJIyUWKtLsEuFWccqwqMk7qqoxQdzcwKwZlpV0o6+FLRVVAk/DEThWHiY7drFCGEuZCWEEyMTFlkAIukHQfizLtenMLXtgxS0oSzLJ08ybOWvNYnRuSI+qN2M+XtGe+KRAmgExsj6sKCqwkug+graC9dyM9KmsMSj3uHnfiyOc21JwBm4njiC1HYqSwOfVn/dL5WoANXPkqT1rGrAkWLIxLfX2ihjPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH0PR11MB7657.namprd11.prod.outlook.com (2603:10b6:510:26c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.29; Fri, 27 Oct
 2023 16:55:09 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::2724:db16:fe7b:2ffa]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::2724:db16:fe7b:2ffa%6]) with mapi id 15.20.6933.024; Fri, 27 Oct 2023
 16:55:09 +0000
Message-ID: <6456509b-9df7-47e3-b941-c307594a80d2@intel.com>
Date:   Fri, 27 Oct 2023 09:55:04 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 5/5] net: bcmgenet: Interrogate PHY for
 WAKE_FILTER programming
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
 <20231026224509.112353-6-florian.fainelli@broadcom.com>
 <0a164b9b-4f9b-4886-b19e-48298cdcff8d@intel.com>
 <2eeb8e24-4122-450b-adf5-8c8a746db518@broadcom.com>
From:   Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <2eeb8e24-4122-450b-adf5-8c8a746db518@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0079.namprd03.prod.outlook.com
 (2603:10b6:303:b6::24) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH0PR11MB7657:EE_
X-MS-Office365-Filtering-Correlation-Id: ada4afe7-6972-4476-73dc-08dbd70d7a52
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PIerIUmN83hDoH0Ky1ZuzuXdEUtnObB/W2UozrbiRGX3bNYJ7QEMHSFEINwAgCvYcF2/lpS+mzshSEhddV620JKQvMCOEviR5WsHA7Q0Sklv0J1o6C/AowjmaWSGyKu26gpbTjqQUgguOdAU3zOD+jOfBN7oK4hupkz7l/yBjR7O9VsHoE0ssfNONDNcbJa9Df/etX7TzuHBi/BFRWqHd1MgyGq/BBsTC/CEJ7fcuMfxBvYhAQ5UR2ew8mXSWgiXFO/ORCa874LZS8ZfkINtzd3YL0YcbHfw6ldkjz7U6qFVXFLwSag5aIKHJ1DH5UEl5Lf57mfNrT2I6doXSrvG+QO7H7VG2WJKAHoXFnW2aCJtF8IDKdkTnW7baFKts4EI1Fq9UwDR2MLtcwrSJPzZHCIRI+i/N+hUxCqErogrcfsYWmR1FM6InnVyg157rv6+eOD3jxHCy0N8kr84AUbKau2Us7SXUFPeEnPYM4YAkkccyVPwcAp8gV0FB03twPFzcZPJJ97dK0MbWd1DKROk5aVQep+9PeVJlkcxQZ553g6XuSUQ04uUpPNNTZ1jIqqljo7yWghlbce40T0qHQhsOt1cFvtStdsFTDJiFKpJn+7AK07DpwSpo0+vXv2sZ/lm7uem9OJMxcbGmDcfihriAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(136003)(396003)(346002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(41300700001)(2906002)(38100700002)(86362001)(54906003)(66946007)(82960400001)(6666004)(66476007)(66556008)(6512007)(6486002)(316002)(53546011)(83380400001)(31696002)(7416002)(5660300002)(478600001)(2616005)(4326008)(36756003)(8676002)(8936002)(6506007)(26005)(31686004)(66899024)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEFDbU5qbGZmZk9hS09iN2t4cGlyZjE5VU9WVUFoKy8za2hPMlJLaVVPVUc3?=
 =?utf-8?B?b0lDU1ZJeWRoUVZXRnJpZ1JYaTY5QW5HRnh6dkRVT3pGT1BacmxhTDQzZUV4?=
 =?utf-8?B?NmtCMTM5MjRTbkxvRGNTOGpvTWdYcVZnajM1NUE5ekwyZVhXcVJhZVk3V2Ri?=
 =?utf-8?B?eHFVVEN3OEs5blpzY0pKMEdIL0JOSUpTN0tUL1Z2MGx5aEdIcENOVUM1Y2J0?=
 =?utf-8?B?cy96UnNKTWNEckZPbWkwcTc1MnpsWEF4cU9nRjRSTXBGSk9CL2NFS2JLVWhw?=
 =?utf-8?B?RmoxQXFoTjFBZlNlamE4TXY2YTVRL2EzZ0Rid2laNVozcVpsK0hhZm5TNG9R?=
 =?utf-8?B?YnBRNTdkcHFLVkpCb2JBWXM5YU9EaXZ0R0dhNTIrcENjeWpWREh0cEJBV3pU?=
 =?utf-8?B?eWpSOXhoRzFBMzB0VGdxQ0hyODR0UDNMS0M5Zk9acHVUMk91Z1BYRFdPSWJ4?=
 =?utf-8?B?VVRBMithSEJsVGxUT1FFUXJPU2RDWVBmNmI1eVZ3eHpUKzRqSzlFdnJSQ2cz?=
 =?utf-8?B?ajhxRFlVVFNtQXo0UGYxbEZ0VzdUamZsSS9kQklxbE1KdHRSbWE3NzA1cmcz?=
 =?utf-8?B?aWhDdHAydzRaZzcrZ0lvOGVldDg3b1pQQTdJekQ0TzFqK1N3TnoweUE2K0hp?=
 =?utf-8?B?d3VqSGJzZ2JjSEk4Ymw5OVh1RDk3NDBlRDcrRHY0Wnk1Mk8veHRQNUtLSG9M?=
 =?utf-8?B?NmpPNzRCV1RndVFkcURHaWkrNHEySk5KaFM1VnpoMXpURlpZbHp4OVJoOUlX?=
 =?utf-8?B?YU4xWDNseEVtSmlmSTBMT2w4M3J4MXR2ODhpRVRyQzhjV3FDQkxnN1hETXpU?=
 =?utf-8?B?b1k1dXVBZ3h3WElDbHN5d1FGQXFIZk9tTjRMMXdaYTM3eU1EVURoNnVIamZq?=
 =?utf-8?B?QlNKM2lGY1FhN3VoV3UrdWZ2bjA5S2FBTHkwdXN4WGRxbmN5NCtIWHE0REUr?=
 =?utf-8?B?SHVQQm1NUzhXdk9FWk52LzF1VmEzWWp2WmR5RHJDWkdFTXFqeGJlVlNITjBI?=
 =?utf-8?B?MWtCM2FIQmx6dXovY2d3SE11eDluZFlQV0pnVUp3TUw0N01QaVJTUzE5eS9P?=
 =?utf-8?B?K3FhVktLckwwTGFoNnY0Ymk4WTRuZFZwaEhEeWdEWXRMdyszNU5oSGpKOU8r?=
 =?utf-8?B?RHlrdE96dy9nNHhTMDRaeWpXYy85UzduUGV4L2pvMXRkWi92SjRUYkZDKzFz?=
 =?utf-8?B?NkNzalJZWnRTNEJpNTJjQWdIUEpsZ29JSzk2RjJBUytIQm9JQ2UzNVRjRkY3?=
 =?utf-8?B?NXNHS1BxcU85Nnl2UFRDWTNsWXljNExocGlUand5NDVSK1h1V1lod3VzZ0Fh?=
 =?utf-8?B?TEVLQ0VYcWVtbTNxVVhneDlsS29PUVo4eTZnTXVXVEhDMjc3WGZDK0pVTGJM?=
 =?utf-8?B?YVFQNTF5ZmVHY1pCS1drbzFITS9NcktNSVhRdW4wdm5ZRjFRblB2SVhMaXMv?=
 =?utf-8?B?UjE3ZVc5Z090SjcxRVp1djRXd2F1SDE2R0d1RU40cTFJSWNqNlIxUTJ1Q1Uy?=
 =?utf-8?B?RlVrVUYwU3E1ZFJVOUsxUE5aMExnK0w1aXRxRVRSbWpJR01pQSs3eldnZWdp?=
 =?utf-8?B?bS8wT052VUhZNHFVdU51cXJ5VzB1M2h1dkRxeXRqSldDajJJN05Yb2Rpa2pl?=
 =?utf-8?B?UkZ4c0hSY3NDeFI2Smt2a1Y5OFB1NWh3OWNwRTJJaEg1clFPbFFPT1ZNaStq?=
 =?utf-8?B?Tk5HU1J4aWVVcEZBQlU4bmIwWFU5bnVOZisyUU13cnNpTlJqdFlpamFHQk9T?=
 =?utf-8?B?U2dNaVdMaElNSUZia3d3ejdubnRobjNWcTRXMWZGdXoweE05NzVrQm95bG03?=
 =?utf-8?B?OGtoRFBQQWF4NjBUYXhsL05BWmRXYVZFSEdqMWpPM3J1aEgzejc4eE9Dd0d1?=
 =?utf-8?B?MDNibmRRWmhpUGg3MGVwelZGVm5wakEyRW0veEVUTmRZNjB1K0tEMmhsOFlC?=
 =?utf-8?B?VVhVanppeS80K2s0SDJvSW5Db3o5blc0VE9lQVF3THJjczNwdGVXdUloWHd1?=
 =?utf-8?B?Tmhpbm0wWThHcm5pNC9rMzNXMGYvRU9YMmtVQkd1MXVIOW9rdWdZTUpxMHc3?=
 =?utf-8?B?NURlQnN3MjFiaG9PRDE2cmd1RWRqdWtGUHpwV2hNbHVqampDZEw0MEtnTDh3?=
 =?utf-8?B?V004eW83czNDT2QzVUZqeG1HUkp5cjhOdThic3o5ZjZoZTkxUkNZcmpSck94?=
 =?utf-8?B?blE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ada4afe7-6972-4476-73dc-08dbd70d7a52
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 16:55:09.0710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hBGrTRDiB0zax0WLKU8rhdUyOnUTU2yDA6vXZEDKeOJ2elXmB1+coXT8D92ytfe86DIf8pOaFbpq1hZkTXRUH3bS75O38s78NvUexyDpaMg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7657
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/26/2023 4:52 PM, Florian Fainelli wrote:
> On 10/26/23 16:23, Jacob Keller wrote:
>>
>>
>> On 10/26/2023 3:45 PM, Florian Fainelli wrote:
>>> Determine whether the PHY can support waking up from the user programmed
>>> network filter, and if it can utilize it.
>>>
>>
>> Here, you're passing through to phy_ethtool_set_rxnfc, basically
>> allowing the lower device to program the wakeup filter if its supported. Ok.
>>
>> This almost feels like it would belong generally in the higher level
>> ethtool code rather than in the driver?
> 
> Agreed, as Doug just pointed out to me, there is still an open question 
> about reconciling the PHY and the MAC RXNFC spaces into a single 
> ethtool_rxnfc structure.
> 
> An ideal goal is to have zero modifications to neither the MAC or the 
> PHY drivers such that they can both work in their own spaces as if they 
> were alone, or combined.
> 
> I suppose that if we get the number of supported rules from the MAC 
> first, and then get the supported number of rules from the PHY next, we 
> could do something like this:
> 
> rule index
> | 0|
> | .| -> MAC rules
> |15|
> |16| -> PHY rule
> 
> and each of the MAC or the PHY {get,set}_rxnfc() operate within a base 
> rule number which is relative to their own space. So the MAC driver 
> would continue to care about its (max..first) - base (0) range, and the 
> PHY would care about (max..first) - base (16).
> 
> Though then the issue is discoverability, how do you know which rule 
> location is backed by which hardware block. We could create an 
> intermediate and inert rule at index 16 for instance that acts as a 
> delimiter?
> 
> Or we could create yet another RX_CLS_LOC_* value that is "special" and 
> can denote whether of the MAC or the PHY we should be targeting 
> whichever is supported, but that does not usually lend itself to being 
> logically ORed with the existing RX_CLS_LOC_* values. WDYT?
> 
> pw-bot: cr

Ah, yea there is a lot of complexity to consider here.

I'm not entirely sure what we should do here. What about extending with
another attribute entirely instead of another bit in RX_CLS_LOC?
