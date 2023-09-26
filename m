Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA10F7AF77D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 02:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233200AbjI0AkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 20:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232852AbjI0AiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 20:38:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA068A6C;
        Tue, 26 Sep 2023 16:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695772102; x=1727308102;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RXG/RzU2X9ZXKxoqxmKyYVkgtkV2smMCVRkXzh9P92A=;
  b=kP28Me7ARBW8Ydj0/+hvCqDkyeMwdiFvAs0h4uo+YZgtgRD0FvTYUmIn
   3XCyZI8qP54rjnK8OmyJ0ru0uJLTcOfBFe3Ie58Gk6VybDlaumquBqDg4
   ZrbGkR4PmyeiUgSL5If0b95kaE+nfOKAz8tbQZhVPVbxFx1tXVZwOrYHU
   5DmEMjaQHMKKgyMk20BVoJHqOV+20lv2fuB6O9qZC6CvRqq/Cjs4JvUiR
   Ji7rYP2HjhwBsJMcQM8lj6wCpeh8VVDjPk8GvNp3KxuOndyCz1BBhc10/
   /rmHdDje1VyPcT8gHKne078bnaKu/3f2dSkAv4e9eRyotbbRS5zD4fjk/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="448187088"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="448187088"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 16:48:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="1079907166"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="1079907166"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Sep 2023 16:48:21 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 26 Sep 2023 16:48:21 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 26 Sep 2023 16:48:20 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 26 Sep 2023 16:48:20 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 26 Sep 2023 16:48:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ExdcEdGSu2UCUmh0bsqPScaWSK1jKqypPP/sZ97qaAmdH76QPNWivxNDSmd4vznwcSW4LMDl0TLojovG9h0dpU97SOYK5NY/pA3ydZQIu9pnh3ztpV900sRGgEaFT16MR17l4Udwm12dTC1Ygl2kBqQq789Kh3gTcZYqdSxu+mdc/snTs+6sd9Eovc47MOITZZTYnQQm3cyhm3BsPlnzErVMpH7coNbimvSxT65bRcoaW9n4Jys4Jc2RtkWka5Od4Xa7zIZLjT4fx5VUfwn1b/YfbMXXPdBiBh+HfzSdhlAAkBS5171qRTM7zvotJYXTwiveG7XpOIXZ00MLr4vz5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=88C8KCxnBxHjEQGCMNXaul05ttgAG44rbPXNT/Tfvc8=;
 b=gYY2n+EkhCg/g+N6kzWa9GpG68rySdRnQy5s51d7gc62QpBmHZ5K2lJLCtqyt2B74shBx6HB74mZoFscTgXSC0h9IJl/DIeStht3tzkJyaZ6Gbqam0XNKsJrydH5UioKwIzGClPsI3cdNCKDvGbc2usBgOAyOman92ckaXX2lgHpMempQ2XCurLmYRF6Ji6lUSvK2VFx9ezsFJcnJMfp4ggtCYXKKPSI614fDs01aHuRodHxdUlwC2RV3CyzsH7Qhcn+ZXF+bLRdQbX2M0ibCobx4BAWa8IaUPTj0JXrbwP/8csc6xOwsyrmPrq5gwRFVH0I5ucuMKt3iNjDwqB2UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CH3PR11MB7274.namprd11.prod.outlook.com (2603:10b6:610:140::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Tue, 26 Sep
 2023 23:48:19 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::9654:610d:227a:104f]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::9654:610d:227a:104f%4]) with mapi id 15.20.6813.018; Tue, 26 Sep 2023
 23:48:18 +0000
Message-ID: <daf48f7c-e3e4-a23a-0422-a98c409ff0eb@intel.com>
Date:   Tue, 26 Sep 2023 16:48:16 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH net-next] net: microchip: lan743x: improve throughput with
 rx timestamp config
Content-Language: en-US
To:     Vishvambar Panth S <vishvambarpanth.s@microchip.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     <bryan.whitehead@microchip.com>, <unglinuxdriver@microchip.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <richardcochran@gmail.com>
References: <20230926155658.159184-1-vishvambarpanth.s@microchip.com>
From:   Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20230926155658.159184-1-vishvambarpanth.s@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P220CA0006.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::11) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CH3PR11MB7274:EE_
X-MS-Office365-Filtering-Correlation-Id: 62ba2979-1f91-4aef-e267-08dbbeeb0f65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yPoF0Kn3FqP2IkVNFOACDJUAtO1JwEM05ob9Etx90B1gtUtE2Imc1VbUNdd4ukCQ8vlxA5vssmrxtFxVp1Yu4ivPeJVesHARb6pURfDCRCfTmB2rGVDAIu6kcEYwXIpZnF2pwuNxjw+SXyenX260+gYAoNx7Lnco1GfRJAAb+9zKWmdJHI/C9/FubzRjUmtvsE40ow1yBxq53und1nbnMbQiQ0xf81HWP2ySJs34IEBlm92B5bK5A5RZmKO+xK5XVqgpo755vIG474Gbo7+DAGMkgGj6PQRtkWKH5nchHZUjxK3ywju4qJdeZFpqmuDL7nvPxh7UqLy/9GZrBNjGS6WO7/p4s+aw/INibQd35lBaMjBFKFk2b9PQ658YfLWabjb1lw6YHseOKb42NqU71zCLypeMTwdUO0orNwRl5Jab56aI0vcZGy0N8Rr3mqKomJCyEKzVQlAqMvAB121UT/sqtxFa6VrT7x7cijFLSXQZIqU71+vX/FGGcdscxEsJjNUOX7XBeVZ03dGGBCmmMcJjTX5q0GubfdOsHlAnhMG2P7+NsxmnLjwjFJGUU+0nK9Cp8yxwxj9BhHm9Z+PI3SKKZkKTQuJ07Jr0RFSJLrePwV+MHcTZtNdTNW5NCML5ZCXHTAo7OF3Zl38d4Df1hQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(376002)(136003)(39860400002)(230922051799003)(451199024)(1800799009)(186009)(86362001)(38100700002)(36756003)(31686004)(8676002)(83380400001)(31696002)(8936002)(82960400001)(4326008)(316002)(2616005)(966005)(478600001)(7416002)(6486002)(6506007)(5660300002)(6512007)(26005)(66556008)(41300700001)(2906002)(66476007)(66946007)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UTBLYnZoRFRLbGoxQ2Fpc3Jzb1FoSVFQWFRoUm51R0RYUy9mY051Q2dCbUVL?=
 =?utf-8?B?YXFvT244Rm9uVmlacUEzMTlkajNkRHo3VUZVTzU2YUVrTUVPN0RVRDN0NW5a?=
 =?utf-8?B?VjRhcmFKd1Zwb0ttQVBqVDVGUDlxNk14TWlmSEdja3JDK0g2YVZWcWpKVlNW?=
 =?utf-8?B?d0JISmNoRThFMzlUNWs0bTBxZ0szNzdld256RVpodWROMnpDL3ZqQTliMFRx?=
 =?utf-8?B?WTVBWmFZWnBuM2lkME1UYTZCOFBCV2swUlNnTzJ5TWFvL0szZ2hjOU9LNUNj?=
 =?utf-8?B?ZlVsTVZCb1J0V3NHMGE3cnp2b0FLNUY1V29DSFpYdzNoY3RDQTVDRkRkbmhG?=
 =?utf-8?B?MWpSZjk4TWxjSnpHMndqUjkzUzFZNXJrZXp1ajZKVWUwNFk0NU1POHlyLy90?=
 =?utf-8?B?RzRadXZTcmNnZDZRMUhSN0liUStSNHJuVWNOZXpPdVVlRU00OG9Ja09DVTNV?=
 =?utf-8?B?cDR3R1RxVGdPanhlK3FncXNHNzBub3NHWUp5NHhPMzVOdlJLQnpqTHFzZWFx?=
 =?utf-8?B?bExtNGZtQTlrTjFLeThldG1YY2l5Q2U4T2N4Y2xWUnl2SnFYVnMzMHg2QXFE?=
 =?utf-8?B?L0hhSFZMWGtqNms0YnB1L0s2d3R4SzNPMmJsV05uQzBSRklCbkphYTljdWl2?=
 =?utf-8?B?akdLMkZ1R1poUG16U2Z2ZG1TUUYrOTBTbUR4blZONnJuMGpYbmRmemNzSGgv?=
 =?utf-8?B?L0M5RUQ5T3N1ZU1JbUVqRDNqZDB5aFNMYlFHdVkraWpCWDMrbUtpcDNRWEpY?=
 =?utf-8?B?d2tKZDVya0xXdUZMcUVLYmQxdXFpU3M2M09sbmhvKzJ6dGR5QWlIZVBvWXFk?=
 =?utf-8?B?S09UbVhmSmkyWXJWNmNjbVlad2RNWWFkUFBoVXJ1eGxLZmo3eXZCcU9nb1lj?=
 =?utf-8?B?UzdZcFVjcER2eUFHSVJxcVliY2RBTlMwa3p0cS8xcVhzV2RVdzFIa2FIRXVN?=
 =?utf-8?B?NUVSQmNsVU8rdWZnOXgxT2FPZTdpWUQyVXdHeHR6WGVFUlkrQndtM1hnV0xC?=
 =?utf-8?B?ODJ6dDd6cFpMSUtBWlFFN3dmU0FpaUgrTzFENmZZK08yVnlORmo0bEp2bENj?=
 =?utf-8?B?ZW40QXdzRzBrTU0ybWkybkhManVYdTIwOVBvN3V3VWNnRThBbFBNZW1SZnZX?=
 =?utf-8?B?TkR2MC9LdjJEa1lQZkdiblhnbzloeFRZUVd0R3c4UE9TY2FaQWI2L1YxdGdW?=
 =?utf-8?B?eFQzVHVWYlBBaEIzT0ZzVW1Wbk9OaDF0OTZkT0RqbnQrMkY1NXpCUEs4OGhs?=
 =?utf-8?B?RGcwZGdzTkJpbkQrSmQ4aFhuZm9GYU5RNUI4SWZGamFnUVUxMFl6OGhlN2Nr?=
 =?utf-8?B?T3BtNCthRWp6dHhGQ2JpNTVhZStnUld5UysxeHh3bGd1bEJVa05WcExOTnJ2?=
 =?utf-8?B?RTJ0L0JkUHM0c3h6cTQ0NWJxQmZYekdJZllZWHBGZFIxd3BOQTZBYW83WDJB?=
 =?utf-8?B?MkVEeU8ybG91NTExaXNxcVBQZzBIVElGSFJRRk54aG12QUtYNEtMQi9Eb3dO?=
 =?utf-8?B?MkZESHlFckVLVDd5cng4cHIyRWF6eXczd3FTRG02VUQwU2tJc2hrL1FqalQy?=
 =?utf-8?B?WjUwYXk3OUl2and2RjdrSUJvMkw0QzBVWjllL3NNNDUydUo2ODRmeUZyYlV2?=
 =?utf-8?B?SVNYbHZkOUNNeGVhbkEyZXhVYk9vMkFtQWhsZXB0emxjQXVSaDdtSVA5eFZz?=
 =?utf-8?B?dlowQjNHTjNBRmZFS0FidTlETXFqczRxOVZLYkpRSjFJeWhBa2wwdW1BTVUy?=
 =?utf-8?B?ZWpQK3FxelpVMktobG1XeVFzLzNyNDBrWE1DbWdlNmliUFNJeXpYNW5QVGNo?=
 =?utf-8?B?M1doaWFZYktieUlRdFpzSlRSalQ3YnBlU3BzMlQ4S1pCeGF6RjVPZGFzdEQr?=
 =?utf-8?B?Q05Ra3BwSEdDa0NBZkF1SHlibmsrY1JjblhyRzlzK3ZHOTE2YldkNmg0cXc1?=
 =?utf-8?B?RnJ5c2w2NitGU2pvSm4wUmhVSmpPenhaVnY0ajNKTjhZUnBGNDZnd1l4Z1JV?=
 =?utf-8?B?QW0xaW5aNGdJQWxzMFdXcFVTT2NZMXJTU1A4RjU5Z1pUKzdQTm5hbGlJaEZU?=
 =?utf-8?B?endLdmVpajFoOEhqM2RhS1lwUXNEaFh5R3VDc3o2SHBMbzNCMXRkaTRuRGdy?=
 =?utf-8?B?ZjN1U3AvUDZGdG8yOHVRaEt2WHNGUGh2Mk9KUTJCSTl5OEJudklzV290ZTR0?=
 =?utf-8?B?TUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 62ba2979-1f91-4aef-e267-08dbbeeb0f65
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 23:48:18.9541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4hXtkBT8yiX1JZjCRTpq8UMVQnoxNuP62xHXFi01U+7yxRASgeAbXdCGI4s3/JosentpmVM1CEnmXP01CKyeR8DsqhymcUcsB+/FuZWZY7s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7274
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



On 9/26/2023 8:56 AM, Vishvambar Panth S wrote:
> Currently all RX frames are timestamped which results in a performance
> penalty when timestamping is not needed.  The default is now being
> changed to not timestamp any Rx frames (HWTSTAMP_FILTER_NONE), but
> support has been added to allow changing the desired RX timestamping
> mode (HWTSTAMP_FILTER_ALL -  which was the previous setting,
> HWTSTAMP_FILTER_PTP_V2_EVENT, HWTSTAMP_FILTER_PTP_V2_SYNC and
> HWTSTAMP_FILTER_PTP_V2_DELAY_REQ are the supported options) using
> SIOCSHWTSTAMP. All settings were tested using the hwstamp_ctl application.
> It is also noted that ptp4l, when started, preconfigures the device to
> timestamp using HWTSTAMP_FILTER_PTP_V2_EVENT, so this driver continues
> to work properly "out of the box".
> 
> Test setup:  x64 PC with LAN7430 ---> x64 PC as partner
> 

I don't think I would bother to support HWTSTAMP_FILTER_PTP_V2_DELAY_REQ
or HWTSTAMP_FILTER_PTP_V2_SYNC as these are pretty historic and only
useful for hardware which can't do HWTSTAMP_FILTER_PTP_V2_EVENT.

> iperf3 with - Timestamp all incoming packets:
> - - - - - - - - - - - - - - - - - - - - - - - - -
> [ ID] Interval           Transfer     Bitrate         Retr
> [  5]   0.00-5.05   sec   517 MBytes   859 Mbits/sec    0    sender
> [  5]   0.00-5.00   sec   515 MBytes   864 Mbits/sec         receiver
> 
> iperf Done.
> 
> iperf3 with - Timestamp only PTP packets:
> - - - - - - - - - - - - - - - - - - - - - - - - -
> [ ID] Interval           Transfer     Bitrate         Retr
> [  5]   0.00-5.04   sec   563 MBytes   937 Mbits/sec    0    sender
> [  5]   0.00-5.00   sec   561 MBytes   941 Mbits/sec         receiver
> 
> 

Pretty significant cost here for the timestamping all frames. Makes
sense to leave the default to NONE unless requested.

Please find the earlier conversation at the link below
> Link: https://lore.kernel.org/all/20230731125418.75140-1-vishvambarpanth.s@microchip.com/
> 
> Signed-off-by: Vishvambar Panth S <vishvambarpanth.s@microchip.com>
> ---
>  .../net/ethernet/microchip/lan743x_ethtool.c  |  5 +-
>  drivers/net/ethernet/microchip/lan743x_main.c | 58 ++++++++++++++++++-
>  drivers/net/ethernet/microchip/lan743x_main.h |  8 +++
>  drivers/net/ethernet/microchip/lan743x_ptp.c  |  9 +++
>  4 files changed, 78 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microchip/lan743x_ethtool.c b/drivers/net/ethernet/microchip/lan743x_ethtool.c
> index 2db5949b4c7e..855844df5ea1 100644
> --- a/drivers/net/ethernet/microchip/lan743x_ethtool.c
> +++ b/drivers/net/ethernet/microchip/lan743x_ethtool.c
> @@ -1047,7 +1047,10 @@ static int lan743x_ethtool_get_ts_info(struct net_device *netdev,
>  			    BIT(HWTSTAMP_TX_ON) |
>  			    BIT(HWTSTAMP_TX_ONESTEP_SYNC);
>  	ts_info->rx_filters = BIT(HWTSTAMP_FILTER_NONE) |
> -			      BIT(HWTSTAMP_FILTER_ALL);
> +			      BIT(HWTSTAMP_FILTER_ALL) |
> +			      BIT(HWTSTAMP_FILTER_PTP_V2_EVENT) |
> +			      BIT(HWTSTAMP_FILTER_PTP_V2_SYNC) |
> +			      BIT(HWTSTAMP_FILTER_PTP_V2_DELAY_REQ);
>  	return 0;
>  }
>  
> diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
> index f940895b14e8..0389bc7cf603 100644
> --- a/drivers/net/ethernet/microchip/lan743x_main.c
> +++ b/drivers/net/ethernet/microchip/lan743x_main.c
> @@ -1870,6 +1870,63 @@ static int lan743x_tx_get_avail_desc(struct lan743x_tx *tx)
>  		return last_head - last_tail - 1;
>  }
>  
> +int lan743x_rx_set_tstamp_mode(struct lan743x_adapter *adapter,
> +			       int rx_filter)
> +{
> +	int channel_number;
> +	int index;
> +	u32 data;
> +
> +	switch (rx_filter) {
> +	case HWTSTAMP_FILTER_PTP_V2_SYNC:
> +			data = lan743x_csr_read(adapter, PTP_RX_TS_CFG);
> +			data &= ~PTP_RX_TS_CFG_EVENT_MSGS_;
> +			data |= PTP_RX_TS_CFG_SYNC_MSG_;
> +			lan743x_csr_write(adapter, PTP_RX_TS_CFG, data);
> +			break;
> +	case HWTSTAMP_FILTER_PTP_V2_DELAY_REQ:
> +			data = lan743x_csr_read(adapter, PTP_RX_TS_CFG);
> +			data &= ~PTP_RX_TS_CFG_EVENT_MSGS_;
> +			data |= PTP_RX_TS_CFG_DELAY_REQ_MSG_;
> +			lan743x_csr_write(adapter, PTP_RX_TS_CFG, data);
> +			break;
> +	case HWTSTAMP_FILTER_PTP_V2_EVENT:
> +			data = lan743x_csr_read(adapter, PTP_RX_TS_CFG);
> +			data |= PTP_RX_TS_CFG_EVENT_MSGS_;
> +			lan743x_csr_write(adapter, PTP_RX_TS_CFG, data);
> +			break;
> +	case HWTSTAMP_FILTER_NONE:
> +	case HWTSTAMP_FILTER_ALL:
> +			break;

At first this break was a bit confusing to me, since nothing is set here.

> +	default:
> +			netif_warn(adapter, drv, adapter->netdev,
> +				   "rx timestamp = %d is not supported\n",
> +				   rx_filter);
> +			return -EINVAL;
> +	}
> +
> +	for (index = 0; index < LAN743X_USED_RX_CHANNELS; index++) {
> +		channel_number = adapter->rx[index].channel_number;
> +		data = lan743x_csr_read(adapter, RX_CFG_B(channel_number));
> +		if (rx_filter == HWTSTAMP_FILTER_NONE) {
> +			data &= ~(RX_CFG_B_TS_ALL_RX_ |
> +				  RX_CFG_B_TS_DESCR_EN_);
> +		} else if (rx_filter == HWTSTAMP_FILTER_ALL) {
> +			data |= RX_CFG_B_TS_ALL_RX_;
> +		} else {
> +			/* enable storing timestamping in extension descriptor
> +			 * instead of timestamping all the packets
> +			 */
> +			data &= ~RX_CFG_B_TS_ALL_RX_;
> +			data |= RX_CFG_B_TS_DESCR_EN_;
> +		}

I might have made the decision of what to program in the switch case
above and then done the write here with "data &= ~MASK; data |= setting"
rather than having two separate decision points.

> +		lan743x_csr_write(adapter, RX_CFG_B(channel_number),
> +				  data);
> +	}
> +
> +	return 0;
> +}
> +

Rest of the code seems fine, and the implementation looks ok.

I'd suggest dropping the not so useful timestamp filters for only sync
or only delay request, keeping only V2_EVENT, but either way:

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
