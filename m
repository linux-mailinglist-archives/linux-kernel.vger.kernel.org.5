Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0676752C68
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 23:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232681AbjGMVus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 17:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232227AbjGMVuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 17:50:46 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9065172C;
        Thu, 13 Jul 2023 14:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689285044; x=1720821044;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bJVPZPGLV2pmUKa1s9GwfTgvaB3YGueuE32sMSd5PXc=;
  b=YF8HvdZiDK/vHJLvm2SRzo3v/XztdnTtO+IPXqonJqfg+SaW1TrWxFp3
   9kn4u2U/q2+uFLk7XoMdZ1qDV1DkE/6T39cYCYtgM0WoSBQOccQoXAuMY
   UgMeRASqreHfDum5UVXVdK0ZekE5KfKDiCqx39DNKLogXCuoOoG+MwY6v
   efXZl5FP58mxrQ8mREIoEu5392J9IH4dETmWJNTEoFvqfZgHjduH16zG5
   69jzFwEntkaPpn9gVItjdP1j7i3TOkbyXjKqAdEY/GtL+rKpEA/+TwoYm
   DFDriuH4Ic8efCnNIAyW5x6MPaEx1KobC0CnGhhTHh9Kor8EVMXF2mj5u
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="431493497"
X-IronPort-AV: E=Sophos;i="6.01,203,1684825200"; 
   d="scan'208";a="431493497"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 14:50:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="846234184"
X-IronPort-AV: E=Sophos;i="6.01,203,1684825200"; 
   d="scan'208";a="846234184"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP; 13 Jul 2023 14:50:44 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 13 Jul 2023 14:50:43 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 13 Jul 2023 14:50:43 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 13 Jul 2023 14:50:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g8SzJga8VAOv/gB8+9bkwdMSFkOfzcRPLLQAVc6bAIi7l7IlcLtg81P0eWE1E+bfJ8RFIFqAYqHSQ1eoWWsiyRj+8yvFvrGL9QjfOUOabCxxvgBT6cHINDT4/P7b4flQ12UGGpmpAaPDNBxiWhkSr2weD1J6XjQypUjAQp2Edhngs4m3kGvfWWnVtgTjsLz16OO1kHen/qTM088JXS5Eu56GxwaX3ikrErZpnAIPZ3fFoTM1Z4fCrm1QY5JrcJ+UAZ4HNvWo4m+iEYj85fSBFfEFh2DGbXOu+Ohl8v9ffU3xfAkDfh/9adI1SL1S+bFreT+ZI34f16XAlJn+BN5aGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oWltGadklxLBx++jr2xSxBf9C7dZVETXxfi5LPmfPjk=;
 b=MsGAyRLJsjqVHfaI67QZ9IwdOlVlBWikZUmal1nBysDckQFdOKkoisqmFu4m54NqwevgYTWPUxvDcRptCNnVX1N1E3Q8xMaI49GzrsAwqhkGJF4caYeQ1qIOMROoOUSi1j8rm60NnHK9wgqbrayxH3ygDUcqrl17oQHBg+KiMyUkMGh8NYV/6Mga4bSw0yjIqXW/vxHJxBs+6xX7ZSXWm/YDebtJHYSxnoNRlJlLyF7kWiq8qkcSEyml2XHUd1dpTd26leNnu44x/w3St0+1QLwIBvVjIH0N89EA2t4mV1EICKsQQE8XRiuhJgzufFlTh5ZG41rugEWRJ+zY4wlwjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DM8PR11MB5701.namprd11.prod.outlook.com (2603:10b6:8:20::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24; Thu, 13 Jul
 2023 21:50:41 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::4e5a:e4d6:5676:b0ab]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::4e5a:e4d6:5676:b0ab%5]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 21:50:41 +0000
Message-ID: <f4193401-8f61-8f8d-a85c-e513e64e90fa@intel.com>
Date:   Thu, 13 Jul 2023 14:50:39 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v7 net-next 00/10] Introduce ndo_hwtstamp_get() and
 ndo_hwtstamp_set()
To:     Vladimir Oltean <vladimir.oltean@nxp.com>, <netdev@vger.kernel.org>
CC:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
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
Content-Language: en-US
From:   Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20230713121907.3249291-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0297.namprd03.prod.outlook.com
 (2603:10b6:303:b5::32) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DM8PR11MB5701:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ca8c6a3-7520-4491-36cf-08db83eb33e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z1lfDmFbd9t7jFeNS/F2ZzN/++b1USb6TGr8XfTyC3wT1yHtRDieBvDRbSRbzqmU7KM2qUoIvk9+Fu3K+fmqSXo/YGaatrVnLkqBrnPDmQGXiroeV0xT7Z16Txj3+kWVXeadAkFpzn7t4HNB0xAce1xy+ULk20hGglmcUuiGlfz/23Ml9LFqSJ6hS7BFZGgKPxaVJUcr0/xX6yLsWDpFIOKqjoxqLQLNbn68L8HxRb9JkslAYAUnj8OVThrxnEL7mimdFSQzormf3TvTUh2JoRKRd2cO42Y03zqbRAkRlbPDtSx+4WOIr/RIjsl4rRxQjc07JwIp9fcfFDozo0aSnMSpkBODONGfz8jaag00Uc42kEBpEh5+ytrBCBzd+qQan2h8bSK99qEYJSJuSMcHeu/lNzVyWueLTm2GvEEePIAMGafNu4E6oOa99nmdvFIyDHewVeN3+rxUDdVmDIwWivbWwTXY3Du/Ei01YN1YthoyzECgOu/Yz3wAfqajSSBlH38syjjn0Y8GlRpdGlk2v0GIx+vgAHVbAtDvY0hc5gMysOF6piyRJTCUJG3WS3a2U8z4ELtCtwPJ1Z1s768dNSU0i5KNn5NtSI1bPwsj0xWInkTlZgCHCEFzAK4Gk3nLtOKLhi/KD2UFlzOlYcBM8KKq2x9iR66HCOGUCmHC20U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(366004)(136003)(396003)(376002)(451199021)(7416002)(7406005)(5660300002)(66556008)(8676002)(4326008)(8936002)(31686004)(41300700001)(316002)(66476007)(2906002)(66946007)(54906003)(6486002)(6512007)(966005)(26005)(6506007)(186003)(66574015)(53546011)(83380400001)(2616005)(36756003)(86362001)(38100700002)(31696002)(478600001)(82960400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cURtdEgxYTRmUVowQXJzTXVwck5jZFJ3eldiL25zazFWczdadXNwVUErWWVa?=
 =?utf-8?B?VEUycjR4KzdzTk12U1M0ZzlTbE1CWWhTNWxvdnFUZFUwSlJKM1BuMVZpT1Zn?=
 =?utf-8?B?aVZUYW9RUjkwNDJwcmZ4Vkk0SE40UzVKNm5LWkZPYlFVU2NMNjMyWnJBR0R3?=
 =?utf-8?B?VVd0NUliUHRWV0Z4SjlXelV6cS9mbzI1RkpaQ2VMN0dGNlpCNlZGNGlkMm9y?=
 =?utf-8?B?Sm5VY2tsTjNFdmlhVG9QTXAwMlRTMjFUNFhYQW1zS2Nub056alltUzlMSm1n?=
 =?utf-8?B?Y0dqL1Y4Mk0zQ0VuL3R5M3lNRFl4MUZaZ1hXb2UrdDdpS2VqbHlNWGx6V09S?=
 =?utf-8?B?RDVYS1J1TjlpRlJnWVE5cEdvTVdqbktnUXRKc05BNEczVUMrNTF0UkdDQTMv?=
 =?utf-8?B?blQrMHhJRC8zYTV5UnJzOXZjbUMzQU9La2JaVUc2WmM3RnNJQ1VneVZTTEQ0?=
 =?utf-8?B?TXd2SlFCMjRDRU56SEpvUTdWdlNxYmRNdjIyeGJWOXVucEpzY21FRmE4Z01l?=
 =?utf-8?B?M2RzRC9zcHdhYzIweGkvTEdPSHNhWkpJQU94NklRWWtuakZFMU5FNzRNKzN1?=
 =?utf-8?B?aSt2bU9GYWhLT2tSMUtFc1lSRWNhZXNFdTdCN0RSNEk0T0VXcGxlUzVwMy9X?=
 =?utf-8?B?Z0hJa1FHSmtodWRqSHR0N3RBYXpjb1NZMlpOaGd1elk2Vk1rdXJpdm5Xb0xZ?=
 =?utf-8?B?azNyWm5na1ZjS2w3VDFKSVBzS2ZEY0VKcU9Sd1hRQWZyc2w3Nkw3M1JidXd6?=
 =?utf-8?B?Njl3ckZOWCtQYndCRk1wY3QzK1ZNR0JWVythaDN1VkxaRmJTYkp4M1dJWS93?=
 =?utf-8?B?cWNmbVlIQlZTa1BRSkVWODBOWG0zS3RxeXdybDZoZzYraGVHNjl3Y01BSEg0?=
 =?utf-8?B?Nzh4czRidTRqSVM1V2UwY2lNZ0ZXb0VGM0ZOUHlsaXhoWHgrdlA5RnM0TkZw?=
 =?utf-8?B?ck5abFgxbTlYejVJMFhtcVlXbFJBZXN4dGNrSk5Bb0VHOGplOTV6c0lHK2dL?=
 =?utf-8?B?VFRaS0VLS3ZDRGtRbHdzTUUxcUx3R1dsWmM2UHlEYUxJMkJnRFBBdUFDeFVC?=
 =?utf-8?B?TGd3enM0QnEveTFYSWlOUjQvVFJaNUk3eWFZY3NuVE43YnpBdlBqUFoxWXJr?=
 =?utf-8?B?NXdFWlRNNC90eWhZNUsrVUxIc3lSWnUra2Z6K3RNTUJzSngrTDNIOTRQWnhI?=
 =?utf-8?B?M2draldyZzlYcDFFOWpZTURtblV3dWJsMjdVQXlYUWlSb3hIdDE2dFRyOEMw?=
 =?utf-8?B?YU4za0k2ZVpEMUl1UlN4RnlQUml4N3BxWHFiSDA3TXB3U2ptQi84dy83Mml2?=
 =?utf-8?B?MjJKTDlsclBjTmEveHVGbldIM1FPWUFSMzJ4Skx5cXlVZjl5NVg2aGFLdEl0?=
 =?utf-8?B?d0lVbzJ4L1dDUUVBTURSUU01R25GdldSOHlLbW4vMUJDSXhFanpVZUxpYWhB?=
 =?utf-8?B?UmVMaVFPdjhNY0NmWmtUK2V2aEpZZWtUUm9Zb2JodkQyM0ltWXBKbTlFYzk2?=
 =?utf-8?B?NFY3U3oyQjlvQkxlNGZ6YjU2dzNiRmRQSUVOVnBONlhneUlpdmZ5ZGxRTGdh?=
 =?utf-8?B?UEg0a2d0VFhUT1ZlWUtNdFErVjZqY2FtN1N2WnhTZVBBL2FFNWxzWG1nQzdU?=
 =?utf-8?B?eTdxQ2J1L1BQQWE1WXlRZVZiVXprUVBnOUJCQUdIazhiRXE2cCsvek5ibUVG?=
 =?utf-8?B?NzhNZ3dVMmxWV0o0dmZNMC9Zekt1L1l0TmltR21lci9nbGMxMTdTTjBzcEtE?=
 =?utf-8?B?dHNFMW1lczBSb3dUU21Gak9rSXByZ0JYUVVwNlJlbHBkQzhDMDA1ZGlGQnRl?=
 =?utf-8?B?c29yK3RYejd1c2U2QlFiUUdoZ1E3WENDR2lrMmZpekMxZnBUSDRtU09RVHVt?=
 =?utf-8?B?Z3d2Y0ZZQTcyQXg5eDJhbnNFMW5EQU5tT24vVzBpeDlRWWlCRXNsUTBpQzJU?=
 =?utf-8?B?VmUwejhMeU1yRVNlQk5kNHY3d0ZpRzV6UGo2MWZXSUpZY1FTVC9oMURxN04w?=
 =?utf-8?B?YzJYei9OVjNyWG1pRHBJbTlKVGV5MnFiQzBLdGxUbGp2dlVpaXpjYTB2b2lu?=
 =?utf-8?B?M0JvODdvaVZ2d1hnOUVuVW5kalhPSjlvcUVnaGd5bkZRcjloTnB1Q0t5QzJV?=
 =?utf-8?B?cjJFVElFZFJIZ3d6MDhHV29ReXpKOC9OQlJHdDlhc0FPVTZWdnJieHlFajNj?=
 =?utf-8?B?Y3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ca8c6a3-7520-4491-36cf-08db83eb33e4
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 21:50:41.5348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zgujhc8dw1nqlZP9rlxEehgDuMO8E0+x2XKGf+igv/3JocE/exanU2d8TYiYcLthISefuADHMH5YoyoN/MsDZ0X8ILL3Vdv2TW3YYET3U7g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5701
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/13/2023 5:18 AM, Vladimir Oltean wrote:
> Based on previous RFCs from Maxim Georgiev:
> https://lore.kernel.org/netdev/20230502043150.17097-1-glipus@gmail.com/
> 
> this series attempts to introduce new API for the hardware timestamping
> control path (SIOCGHWTSTAMP and SIOCSHWTSTAMP handling).
> 
> I don't have any board with phylib hardware timestamping, so I would
> appreciate testing (especially on lan966x, the most intricate
> conversion). I was, however, able to test netdev level timestamping,
> because I also have some more unsubmitted conversions in progress:
> 
> https://github.com/vladimiroltean/linux/commits/ndo-hwtstamp-v7
> 
> I hope that the concerns expressed in the comments of previous series
> were addressed, and that Köry Maincent's series:
> https://lore.kernel.org/netdev/20230406173308.401924-1-kory.maincent@bootlin.com/
> can make progress in parallel with the conversion of the rest of drivers.
> 

This series looks good to me, nice cleanup and reducing some boiler
plate code is excellent.

I'd like to convert the Intel drivers too, but I am not sure when I can
commit to doing that as I have a lot on my plate presently.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

> Maxim Georgiev (5):
>   net: add NDOs for configuring hardware timestamping
>   net: add hwtstamping helpers for stackable net devices
>   net: vlan: convert to ndo_hwtstamp_get() / ndo_hwtstamp_set()
>   net: macvlan: convert to ndo_hwtstamp_get() / ndo_hwtstamp_set()
>   net: bonding: convert to ndo_hwtstamp_get() / ndo_hwtstamp_set()
> 
> Vladimir Oltean (5):
>   net: fec: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
>   net: fec: delete fec_ptp_disable_hwts()
>   net: sparx5: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
>   net: lan966x: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
>   net: remove phy_has_hwtstamp() -> phy_mii_ioctl() decision from
>     converted drivers
> 
>  drivers/net/bonding/bond_main.c               | 105 ++++++----
>  drivers/net/ethernet/freescale/fec.h          |   6 +-
>  drivers/net/ethernet/freescale/fec_main.c     |  41 ++--
>  drivers/net/ethernet/freescale/fec_ptp.c      |  43 ++--
>  .../ethernet/microchip/lan966x/lan966x_main.c |  61 ++++--
>  .../ethernet/microchip/lan966x/lan966x_main.h |  12 +-
>  .../ethernet/microchip/lan966x/lan966x_ptp.c  |  34 ++--
>  .../ethernet/microchip/sparx5/sparx5_main.h   |   9 +-
>  .../ethernet/microchip/sparx5/sparx5_netdev.c |  35 +++-
>  .../ethernet/microchip/sparx5/sparx5_ptp.c    |  24 ++-
>  drivers/net/macvlan.c                         |  34 ++--
>  include/linux/net_tstamp.h                    |  28 +++
>  include/linux/netdevice.h                     |  25 +++
>  net/8021q/vlan_dev.c                          |  27 ++-
>  net/core/dev_ioctl.c                          | 183 +++++++++++++++++-
>  15 files changed, 480 insertions(+), 187 deletions(-)
> 
