Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A96257D8C31
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 01:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbjJZXXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 19:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbjJZXXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 19:23:52 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59F6187;
        Thu, 26 Oct 2023 16:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698362629; x=1729898629;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iWayPrseRYPwoc4OBoo8bay8GCAMskqRFg4n5x3Vh5w=;
  b=OyTP48v5TUtKNGFO+p3obkkYgDcpPtA3O5fH8mbSodHJRI3U+uQ04Wl0
   LjODJGICC4x1cGX7FwaCSeMO1w9v+kaDIIWMM9HKXbEiklLLd9JoLNIfQ
   x4L4FA4Cdd5fotq5lmwjICEjH5mvfGPCK3oi6G7O/RrcPex4nr8Bj5KcK
   xIpV/tVBpnOgqj2x2SDI4XIcXUkdN252v2ceaVl+2rrW59oUalU+gGmYo
   ztlyICvxDBCbdsHk+crh5t2ooMdNA7bq/M1NP8EgmX8TH5kBejcCes1IA
   Cge8PIO45/pO50yaua3xz58mVT9BcPMi+urqHllRODKW1+icdTOesgWsR
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="372721387"
X-IronPort-AV: E=Sophos;i="6.03,254,1694761200"; 
   d="scan'208";a="372721387"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 16:23:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="735910633"
X-IronPort-AV: E=Sophos;i="6.03,254,1694761200"; 
   d="scan'208";a="735910633"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Oct 2023 16:23:48 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 26 Oct 2023 16:23:48 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 26 Oct 2023 16:23:48 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 26 Oct 2023 16:23:48 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 26 Oct 2023 16:23:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E53Z8TVGY+OpsPmMOvb80uKvAlYbxZvacfk3UQt+pV1K/Ivzyxp9Zj+Fi+6nqVXJkexpwoXfk1zd/2oCcaAMKmMPaJ3sguJfkqR3ds8FOMwKc421XYAml6zQ8n9xNgoOPF8Iwu30XXgxN8TvSdQoDCZR6ys5+/vIHy0YPBEbGZ8hvW8P6SnZ3FJy/MqXxhmfHv5d04IRTddQmmh8S8z5p7l/hEX0CUNJK3a7ITeN9oDke16/2ILZtBze13+LudBLH2pxX+1I5eTQbXYE5EXT75guCLaMEZvOyMzxzQi1w2Nl1aT/VhXH9nivRFA9ycCIj1yiLj3u6gG3EJ6H2UC2nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3B4sQuqPUUWcPx51UJxJMossfTruszgUE71ib41A76I=;
 b=IWaeJSIfCYYkHXgjqD2GNcUcgvLMrVcrodPjFWkVjh2y2R2tmQEbo8dcQPafw4Gcs9SEAGk3gDfDiti6bWtHJU+9OTVzH35BJ0M3HvSVWhbGMKo7NvwyStmPLI8nx7F96bgHeXg/h9YFbJut+4h/0YIOoO6zOYCOaxhdgL8IMLlEJUWs8lvGVLmtaLU1BSBylKshZfjubXVLIRxtr4MQz+eJ5DB9dqlkWmWoDIv4y70v0HwRA3K5xPFhSLI+c16tpFo/1Z4ZpAyZHOrddXxuuVzRWCN86iIykpwoNPEbFHr2wgRy+QFfliK0X70EBbL/u5DGukrwFV99EfaWYKvUxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by BL1PR11MB5463.namprd11.prod.outlook.com (2603:10b6:208:315::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Thu, 26 Oct
 2023 23:23:45 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::f216:6b2b:3af0:35c1]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::f216:6b2b:3af0:35c1%4]) with mapi id 15.20.6907.032; Thu, 26 Oct 2023
 23:23:45 +0000
Message-ID: <0a164b9b-4f9b-4886-b19e-48298cdcff8d@intel.com>
Date:   Thu, 26 Oct 2023 16:23:44 -0700
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
From:   Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20231026224509.112353-6-florian.fainelli@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR2101CA0017.namprd21.prod.outlook.com
 (2603:10b6:302:1::30) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|BL1PR11MB5463:EE_
X-MS-Office365-Filtering-Correlation-Id: 14a0bc4c-dabf-4f58-5005-08dbd67a9971
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GZ9aHnndxlEBijoZYOvDlg83hQIQAO8X+q3z5hHjT2b4rJYMd0n0gjdFVQim/6lGhQE6l0scltupxDkAqkoY/4Rg0O+a67O74XNMmVmJGYTr4xbkBhCm+Qw7OyTkvfLMzLqGZm0EwhD1KLhyziXmMRXu5UP/gCkFIUKhHY7MN3MofWLmVVP/s1MkNMw94pKGNvXHixJyHBcvM8GNcHfbi6OMY9yPnXaMGsbsy9/3jimPLDBgUC6gnSnQm1OVAw6ljJZ8wBcEqljzcZyUGKc56NvmCREzy1qXhMjWkG42NwOddPzai3i7ghie/0s2LUJi9f1CEyfYDMoZnprWh9hkTGNsHQgfwjhXEKrEQJaDWOryIMvIPRENtYaLNxJ6LZKhaNmCbqsZ8XunH2oS3Tym5vRTtEgwvy/OHbdmvG7dltwfbicJ1m4Oumyyim1H8kcZgVowhyqcyqgnwmCICnNfQRq+dZaOV2aqyB3yManBA9BCB9dC36NYtfQYRtZ5PyU1ieyu5pwXh7kPatMNVO2zHB3F90GFtZL5iOPvLzh3BtAgJnagmTd8VEzEqeUTQjOfNHagMQyTu6CYM257W23AvA9XTTn5R+tORtXX1hOkyUxloGKOUGqQtK5qMu46tR07NIdGlVj/0yUZxXVKXfawxQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(346002)(136003)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(36756003)(316002)(31686004)(2906002)(4744005)(7416002)(5660300002)(8936002)(38100700002)(41300700001)(4326008)(66556008)(8676002)(66946007)(2616005)(66476007)(6512007)(54906003)(6506007)(53546011)(478600001)(82960400001)(31696002)(26005)(6486002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDRvVWlhd0VMN3hkQVV0YkUyZmUwMUxreDZwS2RReWUwWFkzeGthQytUSGdN?=
 =?utf-8?B?TzAzMVRHZGlWcVQ2WSsxT0JIZEVReEJkdVJUVmhTeVg5aCtFRUxmUmc3a0JF?=
 =?utf-8?B?NlVQVnVjS0NxMkt1MHpsTWlBTm9uV1ZuR0VuVnppdGIyaWpxRy8zUk9IdVZx?=
 =?utf-8?B?ZlBWOHNsOE05aUVla3loTFdNdE9nOWlqWFRmL1BtWEFJaTJPRnhZU3VDbUxL?=
 =?utf-8?B?Q2ZjbHBlOVNGUW1YdExpTGJJOXQzUU1JNHlZemVQMDF6K1NPOHhnUGxJWkFv?=
 =?utf-8?B?cW5MZVM4VnhtZGlXU3F6RFo3TFdYaWQzZnBQZDZKVGp3VjduM2k0UTM2NEIy?=
 =?utf-8?B?ZnFMSFl0clRnMEhTMjI4cWdYekJwQk95S2hjMkN1blFIU2w5d0FhN1FtMGFn?=
 =?utf-8?B?djRKSXVMMWRiUTA2bWg1ZXh1NmlMcE0xcTFTVExmbjFKbENUdEVXdE5tZFJy?=
 =?utf-8?B?ZElZYmxCRzExczZKK1JpQnhvM2dWQm03SFFlQ0hjMWJiYlhwRDVFY043NEhi?=
 =?utf-8?B?bjNRbHh5NnNZUlpFaGt2RngzdnZFYk8xSzFwMnVjdS9Sc2xBd3pRbUVsZlk2?=
 =?utf-8?B?c3ExSm1ZUFVYN3U4bzQ5bWZGMThyME5zUU1SWkhaUXpNcGpIcUZEZW9ZbmxT?=
 =?utf-8?B?eE1UUmVFa1pWZ1FmcEpWc3p6YzdaK1NWcTBmZi9HSHY3REVJYmRqcDZWNjNG?=
 =?utf-8?B?YTl1UE0xTFczQy9CTFdvaVZ4MmU3TXJLVnFrYlpLT0FDcnVqeHo1K3pKL0Iv?=
 =?utf-8?B?RVloR1c0TkpuTFErdWNXM2x3QktNY052eG5GK2JmS2d3RjU3cWFCS2hVUmxp?=
 =?utf-8?B?MUJ3STBoL2QyYVF5Q3hZL2JOVVFoWkpvbG9LRDhESEl6b001T0lOSFRlL2ZF?=
 =?utf-8?B?eURNV1NmRW15L3NuK0RqeGZ3dm5EVWJ0bENNc0xqbmplNkhsS0dwTnRvNGtr?=
 =?utf-8?B?dytUK1poU3EvNGdUTzEyaGpNeWZJMGFqZnJnaDV0VFBSREcrTzBRdzlPVGNH?=
 =?utf-8?B?TXNqL3l4UnB5dFZGOFl0T2xzQ0tmdGt0anY2azYvN0YzOG5qSGx6UW0yUG81?=
 =?utf-8?B?OVp3d0xNYmZhQ3dLMUVZaUJyUElwMy9sVzNLQnNzSG45cW1qb2piTWJaR2pQ?=
 =?utf-8?B?d2phYW8vcmxIbWY0SURHQy9wOGlFeEUxNysrbE1xK3NyOFBpdDNydlI3d3ho?=
 =?utf-8?B?NmhUekh2ckxkV3plVURkVk1uazhuUFk0WXRYSHVXZ1FvUXVSVXFpckJmZTk0?=
 =?utf-8?B?QThiZmJOaUNnTG5VeFFOTTk5ejMxTUtuMkxQRTdWWWphclRUMk42cWRkWSti?=
 =?utf-8?B?cHlnakxzZjNOSXNkd2JXbXpzZENGU09ZQXRwRFBHYklDNC82cGZYTHhIKzlm?=
 =?utf-8?B?bE9rOGh6YmQyYU5OeGVqK0xwdkhmOUViU0JPUEt1MkxMNXJCT0dQWTFSNzZB?=
 =?utf-8?B?MWhJRjh4bitvN3VCMjJxdFdoRDJON1FPYzV0WmZ1aDBPcFpnU3k4ZkJFekFz?=
 =?utf-8?B?djlWb1lLb0dJZ0ozclBwQzJkTXByRnp4cXRPbkd6MURJdjRrQ1pSQmczdXRl?=
 =?utf-8?B?ZFI3WmxxajBHSmxnRERIWFR2c1EycExTVTIrc3RGMldnSURxMFFkdzVPZytj?=
 =?utf-8?B?TGgyVVArMFVmN1labXFiRllZc2tmbXlkUWtyYVJhUy8vcURKakJvbE1VT1RB?=
 =?utf-8?B?SDBRNTdjQkhjaC9VOFNVUmxyMjE5Z0JmYXg1dDJXYmo4NENKQWdybFBvQ0JQ?=
 =?utf-8?B?WGRPblhpZkhTZFJzR0Z3RHI0TlFhTEJxMXNqRWZ4UjVwdmZRU2d5N3NQd2x3?=
 =?utf-8?B?MExqamlwZ3BIRVBQOVErR2VLNG5aQ2YvdFJoMTdhckQzcGJWZFhvR0hOMkhQ?=
 =?utf-8?B?STJRM0F2Q2ZvUmc0aGJNUElQbXd3aEluUjM1OFl0UFN6VHFuQjluYk1DeUQz?=
 =?utf-8?B?QXpFMnBWUW5vZlNrc3AyL1VXMDhqNlNPcmpPR29SaUdCR2xzREk2L2dBcDBm?=
 =?utf-8?B?QnBvMFo5dy9qYk5FR3FDMGhsS1laaXQ5UW1ZWkxQaTJZelgrbzJwd0owd0hB?=
 =?utf-8?B?cHBHcTBYNjJKR3Z6UVhHczNXWVFDQkdmSnZiUnJ4WnkrcC9aMWQ0SDU4a3cy?=
 =?utf-8?B?cnhyWlpEcWtmN2lmZTRreDBXV0l3OGZLWnZacExiSFdmZW5uQVIyWUg2Und5?=
 =?utf-8?B?TXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 14a0bc4c-dabf-4f58-5005-08dbd67a9971
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 23:23:45.2643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8XFGXqpb4YY93lcoyGEoby5ZE8KCfrm8JsbUdOgtTlint+tNRR+LFZobUsOptUJzo4rifZdZJDa/+SBjcP2cjzGuMmiYTwc62cAS05+gsUE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5463
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/26/2023 3:45 PM, Florian Fainelli wrote:
> Determine whether the PHY can support waking up from the user programmed
> network filter, and if it can utilize it.
> 

Here, you're passing through to phy_ethtool_set_rxnfc, basically
allowing the lower device to program the wakeup filter if its supported. Ok.

This almost feels like it would belong generally in the higher level
ethtool code rather than in the driver?

Thanks,
Jake
