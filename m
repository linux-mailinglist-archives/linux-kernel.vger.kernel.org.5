Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8B07D9EEF
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 19:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbjJ0RgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 13:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbjJ0RgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 13:36:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C837E5;
        Fri, 27 Oct 2023 10:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698428178; x=1729964178;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rR4bKYKyDVEbt+DkgJKPL8+Sp4HIEcgVN944diibFKU=;
  b=VIQv8fWA5Oha+wy8LVPg1Z0kH/r02EUxXMWr3q7xaYVpIgaPBs7IpRMk
   dk9+JC1NrhxPI8CwRiGh3v8bWQRa1w0KJv8CMMuPtqoyjmEXb3jmWpgFl
   aTszbLrD9a9acIkt7FItbT7lyyZOuxmWHCPD4SKYu6c1j99iykbizjl/q
   MV4ICosOln0MfZsedLq70NM0fqqP8sUmf/sdsK0MSRQ7D9IizBx+Y44DJ
   363EIzu/DZ0/sUUjPYB1XL8UM3PCenfNT/cVm7Lq3GH8uOKo8N8GpwOqB
   NKy0vEm8e/mrLWODEMtkZCEkbZVIYXHQCPHxtz008GNGNroCWnDp/PQ8J
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="378188150"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="378188150"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 10:36:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="794642003"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="794642003"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Oct 2023 10:36:16 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 27 Oct 2023 10:36:16 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 27 Oct 2023 10:36:16 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 27 Oct 2023 10:36:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JSVLNIT7pcGQLt7lgrlI+x/VidNHoBMRjKQs1Pirvc7rc4xGkaomUMJETFfr1GMiU0LN5hIRMgLa78Q2z3LNE5HIVTPRG2PyLVNi+E0H/MMl4mKYg5KxsBDXVW8RLfNYjEOtCVU3g1WwFzoVuclbN1kpbuLi7Wc9K0sSTDAWT51zXzH0MOgW14AIGcSj+ByL+fk70TeQGdXz10S4Ugtk0lsWHn3MSuCqjtL/WWvtgmvYVkWvqPy8pIFAMj/HOHf7yfSs5izjsY5MWY+1/2ZjgVCbEYHsLgjcJLm2Teioc8evJq+7Dr0WrKjYx29v8theJsR20dcXcOrrogvCzkrM1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=esjXQ9FiO/5SdiP1++xqhLFlmkuJLBHm0R0nxnb6Fow=;
 b=WjFudu2VAJdcJtFmQLYc4MXqCSN8PqOUrZLXZbzWUua/Xo7ZUreiYKkrJoruyuQ7wcB0pdjLdaK7WovnJTVe0jDl06UtydgZjilCqw0GzFYKgbQj1z0MAS9AD7bexBb6ZMMR1ij66qkEQTEZVPbiUHwQQ4mgQkzX3deagjug6m5DOaOTh4Bi1T14VsIzyNAf5ZG27Xs/Qk9aQUGe3Pz5mvuQZCrAkSuiUiQAQQaT6OM4u1C6i3G6aU5My3HLmDZ1TWpYi1SF8xJlkk+pHSv+bjrwWJOV31KShBtf6HHuiOm1QRP8Lducj1ntW17q7eVBkEy99EdRMaf0u6qwIhLrHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CH3PR11MB7915.namprd11.prod.outlook.com (2603:10b6:610:12f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.23; Fri, 27 Oct
 2023 17:36:08 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::2724:db16:fe7b:2ffa]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::2724:db16:fe7b:2ffa%6]) with mapi id 15.20.6933.024; Fri, 27 Oct 2023
 17:36:08 +0000
Message-ID: <2ad82651-8e52-47ea-a567-2382b26f3c71@intel.com>
Date:   Fri, 27 Oct 2023 10:36:05 -0700
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
 <6456509b-9df7-47e3-b941-c307594a80d2@intel.com>
 <93abb8d0-40c6-4758-a8de-c79d7acce6bc@broadcom.com>
From:   Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <93abb8d0-40c6-4758-a8de-c79d7acce6bc@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0282.namprd03.prod.outlook.com
 (2603:10b6:303:b5::17) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CH3PR11MB7915:EE_
X-MS-Office365-Filtering-Correlation-Id: e28bb0e5-e458-4ab5-6c2b-08dbd7133444
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dU6k8bF6gQUlcVQX/Rv3IFoRLMt7M8fJaSuO+QCPEgaDFPd2fKNFeF4Cac+qtJlxCHzuoIbg2XBHKbgkl5PeS9ejTpH5qo1QpC2ki+LVsyg5ryDipVlliM9rPkg6oi/lUB66qSuQNdKX7dopCoISZAJTW6FcBK3hniYvxuB7QkkRvMNNd0SiZGz2Fl0aS9zgPaKXsJRnMCPUpqSCZKqoGB51gCjzuLLY3mjW6P/lrrFYUGKC5G3JmGxvSdPk+tOftpfHiSW1RmH9N9aAlz3hRsUcShOvMJWeRCiPFSoZstlQ5rikH1mWt64W3z/1b18/P9GGm6FEHfQA6n4+ro95k+kPPsN88EWrjHwEZXP0HigeARAFXk+tGtAjnYs8XFvZ7DKOx5rl1d+GvZHBuRW6b6T50nSlJCwD1sNKYxKUfE1rGKko9dAqMQbje9hzK8JbAOpmFuU8FBp2PDY18qt0aANat8+sqwBU4FxLHnMTjdQacO+P4SBiqESYCzbR1I2IxqhG1370lMbyuogwwKOLeLRB1etkiAws49JDW2xRrqNUDnVFoaCNe2W+AtMKMaHVdctz4uBWJ2DeBM1UljUs61wR3JYG6Vt54yNo44MAIi6Zp4mUZc/F4OdOY6HEBxUqLvMMWAvD3nwJ3N1P8vR5sA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(366004)(39860400002)(136003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(31686004)(82960400001)(26005)(38100700002)(66899024)(83380400001)(4326008)(41300700001)(31696002)(8676002)(66556008)(2906002)(5660300002)(66946007)(8936002)(7416002)(86362001)(66476007)(316002)(54906003)(478600001)(6506007)(36756003)(53546011)(6666004)(966005)(6486002)(2616005)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3IzSlE0eitCWHVYNEhYZDFSeXVVdnVISFFLaVJ5aTRjbmtEcjZmNmUrT1hL?=
 =?utf-8?B?NmlyZ29LVGR1YzBacFV0ckZjbkxLcEVKU2Zad1hSVFZQc1czbHQ2cS91MFpE?=
 =?utf-8?B?Q0NTNFNaRXVpTi9VVU5tcnBueGtXSDVzMEJtd3MydlZ3L1ZLN1czKzMvbXFG?=
 =?utf-8?B?eWkzZmVEbUxacU15UUNWRzNadDZBUm5temFYcjJOemlUV2JOSHZ6eGhHeFM5?=
 =?utf-8?B?VTZENFNWOEZZaTZka3BDTGVsajFzSHJOTlZiNHdCbmJ4YThUWmJXbW9JTXBz?=
 =?utf-8?B?TER3SFZHRW0zSnc0VzhwUlE3aGJoYkJUZDU5SmlRUGJGaUV2TzNQNjFESVh3?=
 =?utf-8?B?cUtQY0FQZXpERCsxZmg3TDZTdnlFY2RoWitLQ2czTzkrYUp6WEM3clVGTEdw?=
 =?utf-8?B?eWZpRExkWDQzdVBiK1VEV3greFVReUZDL25QZ3Ryc1hwaUpqTGRLY3pPbkw5?=
 =?utf-8?B?djdDY2R2ZTdHMVFqQ1l4bTJmSWdKTFdBTFAvdkRScHV5ZkNoUWNWYU9aMUtK?=
 =?utf-8?B?Z1JpbWZVeGZSdmV6aUhFM2NIbWx2YWI3Qm5xNktxMkVLZ3J0ZXVWYmVOS1M4?=
 =?utf-8?B?WU1jdVFMcERTTVNoL0xLL1Q3Y2VocnNrU2E0ZFFSdFRTS2FwQ01hMm83Y3hQ?=
 =?utf-8?B?a2xKMWdCUGNQUGtJdTdtSG1WaFZDemd5RkVCTU14TzM2VXcwNCtkdGhCKzlJ?=
 =?utf-8?B?N3ZBb1hNL1FHTDlZbDJNWHg5WkJIaWZvc1VRd3czeXZOM1RvbGpGZzVSOFNU?=
 =?utf-8?B?c0JCbXpLcmR2YzU4RXlWRWZxYUV1alQzZ2Z3cGVFSzBhU21QRG1FVUsyN21N?=
 =?utf-8?B?SE41NE8rWlRreE9hL2dpVG9LQjZPdElaUjhqQzhwZFJ1N3loN1RCSFl3RDd5?=
 =?utf-8?B?T3hzRnBNVjVaTFU4N1kvQWZxM1lBZ1pvZ1MyOTE2UUl1eHN5TlVmREh4ZUow?=
 =?utf-8?B?eVMzNDdJR3dJQkIzNmF0WUpkcnZPVHJ1d2ZSWEFqcUtGU2N2bVM5MnEvVVd6?=
 =?utf-8?B?SVBHVndxeGNrNFhDVmZyM2U4THpiZzdNN1hMeTM3NXpzS2pzU21heGxiZ1kz?=
 =?utf-8?B?SDZMY2x6ZDk3R1dRSDZXRDRUQk5CbVExTXlCVSt2VzUvTXlqMGRkMGUwRFBM?=
 =?utf-8?B?czFXNlhtUmE0SWhvTnV3ZXlwWW5uTjNhdG1DSHBCSnpDRFhoQ0VNaUNCQW9k?=
 =?utf-8?B?Z0lwbEVTUjNkTmZPelJ1WndvRktoMVhPTGVFR1k4T2ZIaUlhejFUdTlpRDJB?=
 =?utf-8?B?ZUFUSmc2UnI1eURxdTVYQWJSV2FpS3BVUmVFTHlCTzUxb3A2S2VmdkhSNURV?=
 =?utf-8?B?ZHlVVXB3czVoQTV6Q0tsVEJOekVZT2hHanlNdGc1dWM4bXh5SkQyOVM5dmNz?=
 =?utf-8?B?MHQ4ZDB3SFBCcldxOEt6aElvWXp2aXJDZW42SUEvZ3RhR3dySHIrb1ZjNXFt?=
 =?utf-8?B?eDFNdTg5d1ZqZ3VWNG9qanBhUFhaZkgvM0NmYm12NGI1VjBvV3dqaFM0VWpv?=
 =?utf-8?B?OG9UOGFvVkRrZjV1UjBNaVFRbDBGVnRYbTQ2eGtlT2hKNnVmVDVqbktNTlJT?=
 =?utf-8?B?eURsRkVoenZwSVhaOTM5bm8yeERZWVVnUmhYSGRPL3F2L0ZDTm5PdjNmRlcx?=
 =?utf-8?B?Um1BanFCdXJiMnlDMFhOVkQ2YWZBQVBRTGdsd2ZHWWZqcWFSMkR5dmI3bDd5?=
 =?utf-8?B?RHd2OVE2NlUvTUJoK3F1K1djNWhPZzUwU2lEZjhJS3g5bzNodVpaTzUzUzZj?=
 =?utf-8?B?ZWtYVWJGRlQwb2VCNk9NS1FTaUpGWm5lVk5OelFwRlkzQ0IrTjZ2LzFacEpi?=
 =?utf-8?B?NXNtdkQ1bE5mT09lb2Yyd2hBYTQxYkY5Nk9GVjFubEo3UGVBdEdBTjRhYmlF?=
 =?utf-8?B?aE1LYWErMGRucGF5aTZsMjZmSi9pWThBYXpFMEcvNmUvRGdoODRiTy9EZDla?=
 =?utf-8?B?Qzk0S0lFeFFwTSt0M1MrSzY3ZDFIbWhBdGhCT25SSDhrTkhuRUNoRzI3dnlw?=
 =?utf-8?B?SVlEQ1pYRlBZbnpiUEhacER2Z0g3NU9pWG9DT0ZuZFRCQkZwQlhIbjhFSkpK?=
 =?utf-8?B?bTJMSlBnSGVET0UrVG5OZWZ3alhYeWZTQytBY1h1TXp5L3JuOXpyTHpzYUdZ?=
 =?utf-8?B?MFUzM1o1SVZ2OEIzbkVieTJhTmk3OFVmdjlha3p5WWc5TDFZcFpwRUJCazZ3?=
 =?utf-8?B?Nmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e28bb0e5-e458-4ab5-6c2b-08dbd7133444
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 17:36:08.5189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WJGpcATwI6kuJcLLiI0hJ2zEEu6ovi/iOMFjAZ1P/UvlG6gjbFT3LLseTU5eqRJzTL+7s0DzMv+E5UPl2CKK9p/h5tgRET+34ETHZacaJV4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7915
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/27/2023 10:15 AM, Florian Fainelli wrote:
> On 10/27/23 09:55, Jacob Keller wrote:
>>
>>
>> On 10/26/2023 4:52 PM, Florian Fainelli wrote:
>>> On 10/26/23 16:23, Jacob Keller wrote:
>>>>
>>>>
>>>> On 10/26/2023 3:45 PM, Florian Fainelli wrote:
>>>>> Determine whether the PHY can support waking up from the user programmed
>>>>> network filter, and if it can utilize it.
>>>>>
>>>>
>>>> Here, you're passing through to phy_ethtool_set_rxnfc, basically
>>>> allowing the lower device to program the wakeup filter if its supported. Ok.
>>>>
>>>> This almost feels like it would belong generally in the higher level
>>>> ethtool code rather than in the driver?
>>>
>>> Agreed, as Doug just pointed out to me, there is still an open question
>>> about reconciling the PHY and the MAC RXNFC spaces into a single
>>> ethtool_rxnfc structure.
>>>
>>> An ideal goal is to have zero modifications to neither the MAC or the
>>> PHY drivers such that they can both work in their own spaces as if they
>>> were alone, or combined.
>>>
>>> I suppose that if we get the number of supported rules from the MAC
>>> first, and then get the supported number of rules from the PHY next, we
>>> could do something like this:
>>>
>>> rule index
>>> | 0|
>>> | .| -> MAC rules
>>> |15|
>>> |16| -> PHY rule
>>>
>>> and each of the MAC or the PHY {get,set}_rxnfc() operate within a base
>>> rule number which is relative to their own space. So the MAC driver
>>> would continue to care about its (max..first) - base (0) range, and the
>>> PHY would care about (max..first) - base (16).
>>>
>>> Though then the issue is discoverability, how do you know which rule
>>> location is backed by which hardware block. We could create an
>>> intermediate and inert rule at index 16 for instance that acts as a
>>> delimiter?
>>>
>>> Or we could create yet another RX_CLS_LOC_* value that is "special" and
>>> can denote whether of the MAC or the PHY we should be targeting
>>> whichever is supported, but that does not usually lend itself to being
>>> logically ORed with the existing RX_CLS_LOC_* values. WDYT?
>>>
>>> pw-bot: cr
>>
>> Ah, yea there is a lot of complexity to consider here.
> 
> Yes this is only the tip of iceberg! Here is hopefully a better 
> description of our particular system where this is being requested (the 
> fact there is a single one also makes me question the entire effort, but 
> anyway). We have 2 distinct system sleep modes:
> 
> - akin to ACPI S2 where the Ethernet PHY and MAC remain enabled and both 
> can be used for Wake-on-LAN filtering, with the MAC being more capable 
> than the PHY. System power consumption is just around 500mW at the wall. 
> In that case it would make sense to leverage the MAC's capability 
> because it is better and would lead to fewer false wake-ups
> 
> - akin to ACPI S3 where the Ethernet PHY only remains enabled, the MAC 
> is powered off (as is most of the SoC), but we have limited Wake-on-LAN 
> capability in the form of network filter as we can only match on a 
> custom MAC DA + mask. System power consumption is closer to 350mW at the 
> wall.
> 
> My users are not really willing to use the broad WAKE_MCAST because they 
> want to match specifically on mDNS over IPv4 (or IPv6), so they prefer 
> to program an exact match to limit the amount of false wake-ups. 
> Arguably there will already be quite a lot in home network due to 
> phones, IoT devices, and whatnot.
> 
>  From an user perspective they would know which system standby state is 
> being entered so one could imagine that ahead of entry, we could 
> configure either the MAC, or the PHY when targeting S2, or just the PHY 
> when targeting S3. This implies that we can selectively target one 
> entity, or the other.
> 
> For the current time being, and knowing the use case of my users, 
> directing all of the Wake-on-LAN configuration towards the PHY would be 
> enough IMHO, even if that means we stop leveraging the MAC capabilities, 
> hence this patch series.
> 

Right.

>>
>> I'm not entirely sure what we should do here. What about extending with
>> another attribute entirely instead of another bit in RX_CLS_LOC?
> 
> Yes possibly, or we just target different objects, right now we have 
> visibility into the MACs via the net_device, it seems like we ought to 
> be able to target some ethtool APIs towards PHY objects, which currently 
> have no netlink representation. There is on-going work to bridge that gap:
> 
> https://lore.kernel.org/netdev/ffc6ff4a-d1af-4643-a538-fd13e6be9e06@lunn.ch/T/
> 
> but I am not sure we will reach an agreement any time soon. Maybe I can 
> convince my masters to wait for that to land and use WAKE_MCAST in the 
> meantime.
> 

Sure, but this obviously costs a potentially significant amount of extra
power, and it would be better to avoid that.

> I would not necessary want to invent a new set of ethtool commands and 
> kernel APIs such that we could do the below examples, though maybe this 
> is not incompatible with the work being done by Maxime:
> 
> # Target the Ethernet MAC
> ethtool -N eth0 flow-type ether dst 01:00:5e:00:00:fb loc 0 action -2 # 
> Assumes MAC by default
> ethtool -N eth0 flow-type ether dst 01:00:5e:00:00:fb loc 0 action -2 
> target mac
> 
> # Target the Ethernet PHY, if capable
> ethtool -N eth0 flow-type ether dst 01:00:5e:00:00:fb loc 0 action -2 
> target phy
> 
> # Enable WAKE_FILTER at the MAC level
> ethtool -s eth0 wol f # assumes MAC by default
> ethtool -s eth0 wol f target mac
> 
> # Enable WAKE_FILTER at the PHY level, if capable
> ethtool -s eth0 wol f target phy
> 
> though maybe this is the much needed addition to ethtool so we can be 
> more selective.
> 
> After a bunch of candies on Tuesday I might reach a state of trance and 
> figure which way to proceed :D

It does seem like an acceptable compromise here, and perhaps being
driver specific is ok, since this does depend a lot on the individual
device support, thus broadly applying this across all drivers could be
problematic.

I like the idea of being able to more precisely target the rules so that
its clear to userspace what is being done... but I also understand the
challenge of wanting to deliver what feels like a small win and being
asked to do something much larger.
