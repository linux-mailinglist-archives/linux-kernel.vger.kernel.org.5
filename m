Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EAAC752D14
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 00:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232763AbjGMWgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 18:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjGMWgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 18:36:14 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0AF51BF4;
        Thu, 13 Jul 2023 15:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689287773; x=1720823773;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0CVlU46ffwzVA65XyYHkqQC8g6MOLsdfoR3RZPAF5To=;
  b=kql6QzW3uAClBlN8PxXDk5ic82mxRE9zmsxtkQ8LxVRb57HnHBC1j2Hb
   uYVQiw8nJ5HWuZ2CTggNIYVKE5583NQtI4L9nHafSOZWb6V4ad3ifYnuI
   Jnm7WV2itGuK5GQi7QUIUJgBylxYmvn9g1vzhXsI63BgRZMfp3M6VI+2j
   bP7dzyNWWy+A2KPwmL3H9LjXzktXhxKUKNzFvNDhvjUB22faWtAbhFOUN
   PqlpfpzybqBqCWnIc0K7ofiJ6qckYkKCkXMHUlu4NtdbpdQl2lIxOESj8
   Xor6qv1Oh51XYLiBjLRblUQPUIV19zUHRWyJiFVQ1dgK3HPqb4tmCHAMH
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="350202585"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="350202585"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 15:36:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="812195432"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="812195432"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Jul 2023 15:36:11 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 13 Jul 2023 15:36:11 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 13 Jul 2023 15:36:11 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 13 Jul 2023 15:36:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bz2Hg4o/tkEB8TtAQtKL6FQWFo/r1gQvzhEduvdz5U1RbWtkXQ2/9z3sWSVicLV1WP3e8rqh6MGuMXXa8YBEuS1N440kw7cD1YObR1doxQp4l1gn5mYS5PaSVVbRnPrOGc4lkSFq8Y8raRV+hLQJoyHvhP/J4bwW2+hwv8amh8UNdtqEmqK4n2tIy6Q9lyL7bML53gj/SZUOf65Nj17ODJ/YyMYrlvh3K/6tDmQ8SOuavqmz7BBKVIEwZjHhQ4ESVqOLqkUkwFPR0/8Gn0/hg/E7r21UqGZP5Dz0Kjwsdhgyqz1NmB6ZJI2SfPuCS8EQONJxl1LJ9DFl0AYzehHagg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=76D32IhIorprYnhUYXgaRbdXXEpqjJWMw8tFfrHfRXA=;
 b=f5PRDk2Yl9G1PhzuVS3P+41GNXGUjVfATrbCzUOQWbOeH5hGKc7ksrqAYJb/eQzT1kkRx7zt9fHvqGNEDnSfYRJ7Zl+fndljPkZ/epmdtUjQ5Vw1hQP+OndAqxlGiZ9UdPD8aUTl3w7qMvbAMeGUcf3Jpgu6/t/zNXYFZNtZlnojhWjMpEzjqeWBhpLz2h7PL0dENb60gY0bvj0956IpC+/wrS6N0PgXJcOo962k6mDm6jEDO4rXVcrK0wCbra/ig3L181eMrI8ngt2TiqafuCTVfxqb6FJon9JdbjdjfrNUlq+Z/HmJOz/EExcfhvlprBTGHvpaEGbR5MnnZzaGiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH0PR11MB5096.namprd11.prod.outlook.com (2603:10b6:510:3c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Thu, 13 Jul
 2023 22:36:09 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::4e5a:e4d6:5676:b0ab]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::4e5a:e4d6:5676:b0ab%5]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 22:36:09 +0000
Message-ID: <51511be4-2b74-0d21-e029-97e7c5335d21@intel.com>
Date:   Thu, 13 Jul 2023 15:36:07 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v7 net-next 00/10] Introduce ndo_hwtstamp_get() and
 ndo_hwtstamp_set()
Content-Language: en-US
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
CC:     <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Maxim Georgiev <glipus@gmail.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        =?UTF-8?Q?K=c3=b6ry_Maincent?= <kory.maincent@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Gerhard Engleder <gerhard@engleder-embedded.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        "Russell King" <linux@armlinux.org.uk>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "Jay Vosburgh" <j.vosburgh@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "Wei Fang" <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        <UNGLinuxDriver@microchip.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        Simon Horman <simon.horman@corigine.com>,
        Casper Andersson <casper.casan@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230713121907.3249291-1-vladimir.oltean@nxp.com>
 <f4193401-8f61-8f8d-a85c-e513e64e90fa@intel.com>
 <20230713223353.wfo4xarh4jpfynjp@skbuf>
From:   Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20230713223353.wfo4xarh4jpfynjp@skbuf>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0164.namprd03.prod.outlook.com
 (2603:10b6:303:8d::19) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH0PR11MB5096:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d6ffe9e-091a-4dc0-7b7f-08db83f18db5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YrsjE+I9XGAdbJtQq6HioqkfrQZo75jrWZOSPF+qttsfA/sXyaZkBGI10ZkklThmC/0vwuvDRD7uYSHMGrcPx3i+aUEMuazcd2i+Zn2cBoLdQRARtggJR6GTH8eWB5SbrtXVnPF370nm/Uwg+WrNx91oYBm4o4tHzrSiwSQDgnaCWpQAmv0Q7HAaEKPfkKD9bWyrzY+jHxiXGNo98K+IBxeqneyuglshbS8ptysYKfgApctpALEQd3LHrrZGtBwqvCY7YJ6+UU8EzbhEzpooNeabrdK+gRBkXMz0y9BhAW69VBreHC6KbHp1CKeJ36fEpTh4V4ZTMWdOKLSnKK10dpi84xHc9DrmwRq7MKYhryezfmngBwxG3tPzvYcBzYY1A1pmeOka6eJAU39ovHOijOXMJVl3/ZaQU9IAX2CG9oS0JwJu/hhe9efEjeqdhYl7ky0Aiuh6wd7sXgR6uumdaSjo5xq/dMJmzUlcRm1SBGMdoAiVFZeiSQL7G8NjIWvMm/nkM2s511V0gnbC3OVTdXzAkegwSNBv4SAyh3HKmZrJ3FoM7sTqRX8P/JTwHR9XcnklWRKgB5MTia5Lp+vLNfINb0iSJBZkJ4gkzqKDKyOgCv3hfztOdyKXxt4hW1TSDH2Bh0P8X2SJZqOQXti7BDJlrlp0QqQec4PXtJSm7WA8CZ0JxverwEvIb+d0u5Hm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(376002)(366004)(136003)(396003)(451199021)(38100700002)(31696002)(86362001)(82960400001)(31686004)(7406005)(54906003)(6486002)(66946007)(36756003)(2616005)(53546011)(26005)(966005)(186003)(6512007)(6506007)(5660300002)(7416002)(6916009)(2906002)(478600001)(8936002)(4326008)(66556008)(66476007)(8676002)(316002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3NTUVdFQndQMEpCUWdSUFBSRUcrbE1zTncwNGVtamszS0pqYnpTODhYTGpq?=
 =?utf-8?B?Y2tRNG1qT094ZXNIa1RDZCthNjNqcENqV0JKL3U5T0R4OEJ3czVwRG0vOUxu?=
 =?utf-8?B?bTF1MmFWTDRsNFVza1hxOVpRUWM2c01id2NrcGtoaC8wR2VvSCt0bGt3ajBv?=
 =?utf-8?B?ZDgxbzU0MlBtTWpsdnVZY1RpTENRMGNCV3ArNXcycVM3TkVnWTVPN1Z2aUw1?=
 =?utf-8?B?MWx1RXRQMzM4Vk8wS1F5Yk0yS2VWMldnY1dXUVdxRWU4U0w3cEg5UXp2Qjcx?=
 =?utf-8?B?L2xyN0NkbGtZNlpBNmZHdGYzYTJycVFIV2MvZllvL0FzRHpTMndnY0dvZHla?=
 =?utf-8?B?K0FoQmV2Q3VYSHRieDRSTURubjN1RElqM2xLRXZNaXpGS3oxQVAxL3Fjd015?=
 =?utf-8?B?dHlnL0Jkb013ZHJkNmMrVFM3UGlVWVNqNTVsS2JkbkRoTVhKcVkxTE80SEph?=
 =?utf-8?B?L1l5QmZXU1UvYk94Wmhyb3ZDcnJJR2NIRWtPdFVvMjVBY0RJNDFua2xJZms2?=
 =?utf-8?B?T1BEaUtoRVNtcWlqYkdXYUpLcmRSSXlDWHVudm80eVNTU29GU1U3V1o5Z3lN?=
 =?utf-8?B?SDdRSGxJV1A5U2IzYUxtaE82ZVlSK3duU3BUNlZVUnRSNFNmMnJpSXpiSEFT?=
 =?utf-8?B?Y0E3azAvM1FJNS9EcU1qVXpyYVlxRm56Wi9UNlI3ank0aWV4T2hPTmZvRG9p?=
 =?utf-8?B?UW1xcDRvb0ZSck5nRHJPVGdMWmFKMExGRk9KRnNoelRYcXB5ME5GaktrWVRq?=
 =?utf-8?B?amVhcFRDczR3bmtCbW4rZ3dRNE1wYXFlNkRxWTUvZ2pkeTJTNVlxRUFEY2Nn?=
 =?utf-8?B?Z1BjRllkSG05UHdPaHQ1UTFGclRvR3pOb1RvemFhVlV4c2lWMHB6WmJVdHRr?=
 =?utf-8?B?NEpubjllNXhzNlFTWlBMTldGOEJHNjl1b3lyU05lbW94dS92cSt2clNCazBS?=
 =?utf-8?B?b3pKR0lJdEtJUGNIMWFxQ3VSVHZITENUMTFNK3VFbVpIZEhyU1pqOG9oR1k1?=
 =?utf-8?B?bHlhZDVaTkRpVFlkZFliMkpKeXVLS1ladkU1Nm40alkwbHFBVzkxaVZneEht?=
 =?utf-8?B?cVFDN3J4Nk8xWEJ1QWhYVXdJeHlLbllmeHRxUXVTME5VYmVnVlVNcjhSbXMr?=
 =?utf-8?B?ZTdQSGhUYnkwbDl1NDdpeHRkeWdZZXFrdGxuRi8raTh2aHJ4bzc0aWZPanlY?=
 =?utf-8?B?STFoay9JMG8vZ1JEdThZOTlES3dTdVNhMkpobGZTSndQSFZ4UW5MQzZiWjZz?=
 =?utf-8?B?a3IwRGMzaHdmSFJpSDlRR1NUd3psRHdMOTYxb2pWTGZ1aVlFakFna2NRcm8v?=
 =?utf-8?B?ZWcvNW41aTJ2WkdpYVVublVLZ205UGhHbkJhNUJTbmNqUUNiNDdQdzlZWFln?=
 =?utf-8?B?cUtpOGYrd3h1bURmVDVhR0ZJeG13RUhSbHZJdTI1NktvMVRXTnRhYnpNYkNp?=
 =?utf-8?B?TGVxbXJlRWRBK0JETUFHdkhZYi9RcUdHbWtkVU51djBIODlaNzk2Vk15TzUz?=
 =?utf-8?B?THN4dXhLYmlJK1JsWEFlVXByZDZMb2JBTk5ZdTh0Sm9teDlVZFRTL09aMk1T?=
 =?utf-8?B?Q3FkVzZSK2VPSkdGcEw5T3BMbXd6TzJDSzBBV2M3eGRrWTR3MmZ0eUNMVmRR?=
 =?utf-8?B?dUhOaTdRTzk4d2JVUVRwL0JsbTJuYTdjUUdKSUwyanU4bUs4eVNEeXJjMXhM?=
 =?utf-8?B?WDZ4MXdzQm5rblR0TU1oUUw2T2FzY3ZDR2JueXhrcGZkclJxVFRQOTdPak5x?=
 =?utf-8?B?aGw3VXE3QUVrRW5Ua3RXN2hSSEY3OXZWbitNSlZqblNFbno2Ulg4elQ3czhD?=
 =?utf-8?B?Q091NFcybGVCeWhhckR5SUJXNThlM244cm4vMmVBV1NKZlMvc1E4T2JEUUo0?=
 =?utf-8?B?cGZHdGxZQm9salJZY1AvL1ZNYnFDVTVpT0JPM1FJY0ovWkRjd01uT2F6dCtS?=
 =?utf-8?B?QVA1UUVhRk0wdXlRdWRJaFVkRTZqeng2K1Q2R3pHQUpQWlpuNzArZ01FYW4x?=
 =?utf-8?B?Y3JmTElkcWhLWVdYVUFCNGRnY2h3QnhWWGRCVHBoclJoUldwQVR4ZFFrdnFI?=
 =?utf-8?B?R0pUdGxadmlsS2tCYm15QXMzSWswWDFTdFowT3Z0YXM1UGYxQzR5M1V6Yk9C?=
 =?utf-8?B?NTFOV0xzTit4cFBQMm9ROFpRZTd3UDhLVm1ob09MVDRLQ3lldldpTURWdnVR?=
 =?utf-8?B?b2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d6ffe9e-091a-4dc0-7b7f-08db83f18db5
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 22:36:09.1988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FSG4zpyrRetgfgllOMhqeE0vRwk/NkmARPnhpwJWFsGX0G+Kugei357DfJODCHnDs6vSp1uEgylr0Oj09Swds2BmfG8/uhTdhvQznxzkYcY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5096
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/13/2023 3:33 PM, Vladimir Oltean wrote:
> On Thu, Jul 13, 2023 at 02:50:39PM -0700, Jacob Keller wrote:
>> On 7/13/2023 5:18 AM, Vladimir Oltean wrote:
>>> Based on previous RFCs from Maxim Georgiev:
>>> https://lore.kernel.org/netdev/20230502043150.17097-1-glipus@gmail.com/
>>>
>>> this series attempts to introduce new API for the hardware timestamping
>>> control path (SIOCGHWTSTAMP and SIOCSHWTSTAMP handling).
>>>
>>> I don't have any board with phylib hardware timestamping, so I would
>>> appreciate testing (especially on lan966x, the most intricate
>>> conversion). I was, however, able to test netdev level timestamping,
>>> because I also have some more unsubmitted conversions in progress:
>>>
>>> https://github.com/vladimiroltean/linux/commits/ndo-hwtstamp-v7
>>>
>>> I hope that the concerns expressed in the comments of previous series
>>> were addressed, and that Köry Maincent's series:
>>> https://lore.kernel.org/netdev/20230406173308.401924-1-kory.maincent@bootlin.com/
>>> can make progress in parallel with the conversion of the rest of drivers.
>>>
>>
>> This series looks good to me, nice cleanup and reducing some boiler
>> plate code is excellent.
>>
>> I'd like to convert the Intel drivers too, but I am not sure when I can
>> commit to doing that as I have a lot on my plate presently.
>>
>> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> 
> Thanks for the review. The conversion of Intel drivers is in the Github
> link I had posted.

Oh nice!
