Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81DE07DC20A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 22:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbjJ3Vow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 17:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232049AbjJ3Vou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 17:44:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A52F7;
        Mon, 30 Oct 2023 14:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698702288; x=1730238288;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xojSoYfBD3QBEDkKaHBxM0G2L3UT0WMb3t4U4bZVd1w=;
  b=RS48tr5L1eGT1Bjhd+qCAOJ1Yt6MMpuZF3A/SBiU2oGm5EWK6AFvKU4s
   5x+su9s83r5lU05Szods0ah8bsHMk7z6QQRIDVYY4Xdu25pijhqc9ATih
   j9oh/bs827MrQW0EDU3IPo2CXiVof1ZOFYTmVma1dfS+CTU2EDo6vaYaL
   GJagnfrpe7MPl8vSQzM3X5oRKxkXbf4+4NfI77/3Tq0u9NQemcO8WwxNC
   bb67zeNGia+1pBdooHFDqaUoXlsYIT9/NrkG3Hb28PEHX38t8B3rFkLxx
   X8pupyjQ5RIglIi/sKs8BUDC/kvJh24aUBRZ4fVuzFFL0xzTRGjUyGXx2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="373218334"
X-IronPort-AV: E=Sophos;i="6.03,264,1694761200"; 
   d="scan'208";a="373218334"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 14:44:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="760420383"
X-IronPort-AV: E=Sophos;i="6.03,264,1694761200"; 
   d="scan'208";a="760420383"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Oct 2023 14:44:47 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 30 Oct 2023 14:44:47 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 30 Oct 2023 14:44:47 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 30 Oct 2023 14:44:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hSGq3SO8NTR+hpt3ktZOhs9x20Yuk/6IIZkwIlJfRNj6fQbRD6vbn/zZ0ntLbg6oMkNYsmRnTJs0ZdMPJwPfEGunOLx0r732wNHvgBsw0nEGAJhIdQM+f55zT07KjljVnDkNnJoqT6gZZWeOXwhbqaQD34qvIIIo/jUJotRJ8geo6V+zWH0oXsOIQjtSIaXn6WNvvXjtoIn0aPYvCviXCkj4iMvWr5LoicO0fX+Ro4/vu272NOYVJV+TT31vrgOmOfQfa7YEqJDLreZzhjeATgKyVKfjd8/OaOG/s1UDT+ZB/4ivVVHP3morsHxNmUFBTTT0Tf7HDF+iy7ihYKp+pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OCwLKjyPn8q0ADNIP2LnmBEXd7+93G0ECiNxScswLbY=;
 b=PyYScSopPCI+U9NWRhm1o+oxeiwIEIMONTMWfgzW5dxzOeeWZih+J8AidB23dG0d5U34sFYUE2Qn5771uPWfKNJUjfQ79S0yzcvckp7n3Oq6zMRQzfCnMpcd1X3CbZq/c1HYfjLymRDyswXfWlNl0rRLYH2pQjRQ8eyN08A7n+eZfYsoweDn4QGJ7ZSsZWvdC5shyCukGfrjaAFIE9Pfx+Rrl90YD9TgdCFdty4wdlwwxGdaT7axWRXAwKDCzrIuKrUfi5dCEMbEmYofztolD5fUEV0DQRazziN3ruMD+LDRDwKjvfnvzF9zgPMNs8rj/fl5bKY/OdNr8I9NGAS4oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5095.namprd11.prod.outlook.com (2603:10b6:510:3b::14)
 by SN7PR11MB6728.namprd11.prod.outlook.com (2603:10b6:806:264::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.27; Mon, 30 Oct
 2023 21:44:45 +0000
Received: from PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::f815:7804:d9a8:fdce]) by PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::f815:7804:d9a8:fdce%6]) with mapi id 15.20.6933.028; Mon, 30 Oct 2023
 21:44:45 +0000
Message-ID: <72d0fdeb-b08b-45f2-8a24-d20db69c4a02@intel.com>
Date:   Mon, 30 Oct 2023 14:44:39 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] net: r8169: Disable multicast filter for RTL8168H and
 RTL8107E
Content-Language: en-US
To:     Patrick Thompson <ptf@google.com>, <netdev@vger.kernel.org>
CC:     Chun-Hao Lin <hau@realtek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        <linux-kernel@vger.kernel.org>, <nic_swsd@realtek.com>
References: <20231030205031.177855-1-ptf@google.com>
From:   Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20231030205031.177855-1-ptf@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0194.namprd03.prod.outlook.com
 (2603:10b6:303:b8::19) To PH0PR11MB5095.namprd11.prod.outlook.com
 (2603:10b6:510:3b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5095:EE_|SN7PR11MB6728:EE_
X-MS-Office365-Filtering-Correlation-Id: 664b33df-eb68-414c-3fd9-08dbd9916eaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: idLTfvI0KkUYUtrVVuEx48SmeG0eCGQJgrhpnoZNISbtMdUXk1xAFJ/SHhVQMcyMP5fxQiOaFjcZo3owPFGsoMnlhXT2Ia98oVrgal7aU5/7R2BLv3+wvZs5Y6a3J4ETc0K+em9rxAqaO+z1J2t8k/RjqlCX/R/7ePQTL7vnh7t/QkmBvG5ifrqLQYnE7StIa5n5WuVCnKh56AqkH251eNVOR21kWX9Fb2jYKwPbfL8NgvLQlUhfqy43UX77D294d00PrTZcEZ8Zwa9XEcfKyorC2XePjIVHchgasgGtXIOK2Rxhp2ptWedZ5VpOJYYoks5KXlzzMtJ4GeOlrD2kBql7+te+zDqD91NRLDKdBZhxcUtiyQhbJ4BW0AOBqjPBe1YckkBl6Kar6nh6epXPmGfLpJON3hOxE7xXfy4GKcybttSIfCvU//Eeg/L+ofdCq8wgAzXL4oXITklQ4Neu/G/eci16ga8PYPyyGeL9BzzexqMtknefgKaZWqzwfpfPrNkLrivdMQF/fbXwsVpLLz2sFepzwKVNyWCIFeC9DIws5MHRL7yki6rTtxXdTloYhZUrDTd+KLyLSET/JcxgdANGHiqgzVQZO9Luaz8gh0c6/xTrOrEED8SUjnYk1zyaLSoG3t7IgTaGhY91Ni598w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5095.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(39860400002)(396003)(366004)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(36756003)(86362001)(31696002)(31686004)(4744005)(6486002)(2906002)(6512007)(478600001)(8936002)(4326008)(8676002)(6666004)(41300700001)(6506007)(53546011)(83380400001)(66476007)(54906003)(66556008)(26005)(5660300002)(2616005)(7416002)(66946007)(316002)(82960400001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0dyY0RBclp1bnk0RjZNOUJVMkRGOEx6WVFQWG1hVk9nVWh6RnUyR0ZDbzdL?=
 =?utf-8?B?dmIwVndqK0xMa2gyT1BtU1FoS0UrczYzWmdQT2RneWVEcGZpdGVsY0hMajFO?=
 =?utf-8?B?SXBpL05wVWpGSVh3YzMyV0JqbGhMRHV6ZHIrcnh4cGFnK0tFOU5QM0MvZ2N2?=
 =?utf-8?B?aGh0U3pLWW1sOTdzK1lNZzVUZ3l5clRsUnM1Q2FRL2dIM3g1N1V0djZpTTZI?=
 =?utf-8?B?SnFKTXdNd3pIaytWaEJYS092cGdnNDRxZnZJd1cwR2lnTHdrNmxFQjNFc2Np?=
 =?utf-8?B?Z21BYVVueWsrQkZ5RDhlSEh6NktDZFlISE8yRzNUMlFwbnUyd2dPY3Nwb0N4?=
 =?utf-8?B?TzdjN1djZlI2WHlFRVNLRXRmKzg1Z2FNdllQejlid3JVUTVSbEpaeVVhek5z?=
 =?utf-8?B?QjZsb2ZyRnZNTjVoU1BLNkRQd1h5V0JwQVF6RkNKVmVPK3kwekdHcEE2OG5I?=
 =?utf-8?B?VHdON2lyZ09ZYWE1ZTJsSHJqZ3hOQkU3TUdIMks3bUZncUt6MXYydEVPZDY5?=
 =?utf-8?B?dVlId1BTY2VucWFRZmNwbDZHOHVwKzRWbTQvbFh1ekFmeHpUZXFiUWNJMFNm?=
 =?utf-8?B?Nm80Z0ZKT1V0Y3hJRk43encwaU1HSlUyMjl6U0tUMlpPQytYVHBsaTdBUXNU?=
 =?utf-8?B?ZThNQ0VCcEJybnJBZzZPUTlkRUlrbnBTazVKQWgxS1NVRHdiaDdiQnBVaTY3?=
 =?utf-8?B?REM1OGJGRXpvQlVkaWE5N2J0OFYwcmM4OUdxVmJnVVlwWHpnb1hkdFNMRk9x?=
 =?utf-8?B?cXFHTmNSK0hHOUkxQXBkOXo2c0hyV3cwWCs1Rkw1alBocVRZRFNMc3ViMU5E?=
 =?utf-8?B?WjQ4eG9rdTRPRkcrbUMzbHljdDE5L2FUQllucHFEWTBBWmNSbVYybEthclpM?=
 =?utf-8?B?REl0Sithb25xOEo3UmtJVVJjbHdQT1UwOE1qU1Z6ckNrQ0MrOUhoOGZYcXFF?=
 =?utf-8?B?dWJ4blJzYjZwZHJYcU9zYkxmV1NsMG5VNVdjR0dGczl6UGVFbTU3cW4xN25z?=
 =?utf-8?B?MzdUalNSaUVOSThaWE5WcEhHNVNDSVZrQ0pSU2tPUnJaeWRSM3pSNmhSMU9M?=
 =?utf-8?B?MThzNStyb1E2aTVtS2ZvRVcxY0NqVmVGM002ekJYdmtCaUFGWUNzUSs4TEJz?=
 =?utf-8?B?U25jOXh5U3pCc0tic1I5TjU3YVJjNTcra3JKUzFWazUwRVhkcEIxV2luRUFs?=
 =?utf-8?B?bDk2WklTSFpjN1p1ZHJzVEdFdVFWUlY4akVGaEFTVUxKbWh3dmRmM2Z0N004?=
 =?utf-8?B?SFR0di9ZalRNMjhEZFI1b2I0NzlVWFF0L0ZFQTk5dmt0SXk2VngxU3JZWG4v?=
 =?utf-8?B?S2VYR3dJQm9UNDkzeWJhUTl1WlFrTmV5SVVUcWpUeGREWmhZRGNGMGl2Vmlz?=
 =?utf-8?B?b3A1YWpVTXM0UzRvNVN4bXhKSDA0dmxrVnozYjhUSEUxc2Y4eUFDanZHZTVD?=
 =?utf-8?B?Z1B5aytLUjd2N3pGaDlyVThjNmtLNTdET2JmSWxzZ1ZGdUhMWXl2SThpSDBB?=
 =?utf-8?B?Q2FJalZJRGp5cUN1NElQaURVdWVKamhncDAzanIxbWJ4WExUc0doNWhOeHF1?=
 =?utf-8?B?d2hJY2N0NC93RTdpbS9idzJnVkVKZ2NlSEU1ZzZqeTloZFJObHZtc2hQc0h3?=
 =?utf-8?B?QnRESXNiaUZyazNPWnQrRlV6WU10Y2c0cldlZVFmcXg2dDVCNis1eUovQW81?=
 =?utf-8?B?eHFMWmdkM0xlRnFoUUlBTk84aUlEVXFiZDVrS2I0SnR5SHhrZ0ZJWWl3U1gx?=
 =?utf-8?B?SDFhaGYrbmUrdUhLV2RXSk1aRVJtdDdZUmk5cnZLZUMvVDBQbTJjUkdISk9x?=
 =?utf-8?B?WTAxUTRMYm54QnAzT3dPcU15b3F1UGtXMkt5eVZ6WFpFRFpqdGVkcjFTaEFG?=
 =?utf-8?B?S2RlekVJbm1uNjFjR2JYSGVIREcyVnhMTXpmc1pURGh4bDJvUWxrTGgzMXA0?=
 =?utf-8?B?SE1MYTNQc1BkZUdqRW92SFRaUXdJbkhka1EyUHQrZkUxTlkvMHNYUW5jN1Qx?=
 =?utf-8?B?QTZIZTF0dFpEV2JLYjdUOXRSaXJSUGc3dmptYzJpbmJ0WDNmb2lTNU4xZUNm?=
 =?utf-8?B?NkZzUmU0aTJFSDd6MGVXbXRKaXczYjRFUVkra1pEZkRaaEMxTUlmbWMvQ3FT?=
 =?utf-8?B?UkREYlp0a1VKVlFpYW5pMndFZ0ZyQmcwRmh4eXBjQ1lPbFB6TWp1Nzg5SzdI?=
 =?utf-8?B?U3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 664b33df-eb68-414c-3fd9-08dbd9916eaf
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5095.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 21:44:45.5438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Eg5NJqiwdRRznAjdxDrxp/kqdJGcIiV1veTZMUmTvubTXlgpZndI4wVh9oxLvLF57BhHgDzczyLi+mKJunVUpxi4xQ7Dz+npsJjPt1nYVzA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6728
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/30/2023 1:50 PM, Patrick Thompson wrote:
> RTL8168H and RTL8107E ethernet adapters erroneously filter unicast
> eapol packets unless allmulti is enabled. These devices correspond to
> RTL_GIGA_MAC_VER_46 and VER_48. Add an exception for VER_46 and VER_48
> in the same way that VER_35 has an exception.
> 
> Fixes: 6e1d0b898818 ("r8169:add support for RTL8168H and RTL8107E")
> Signed-off-by: Patrick Thompson <ptf@google.com>
> ---
> 
> Changes in v3:
> - disable mc filter for VER_48
> - update description
> 
> Changes in v2:
> - add Fixes tag
> - add net annotation
> - update description
> 

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
