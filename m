Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CEF7787760
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 20:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242934AbjHXSBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 14:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242977AbjHXSA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 14:00:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B54198
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 11:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692900054; x=1724436054;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ov8UPr17SysXoZSWilBRO6n3dTBCxN/5BBOJh39z+w8=;
  b=jmnBVOn3kBYRZthLa0XJixZ2L05e1gu7mo3WkFRoSDukkz/LNT97BsiC
   HNnlW7+adFo7SHJ+Lle0Lhrtq8buclhxGL/pgCF6OwFUmXpdAm2+YhaNr
   qhbRbAubz7fAkDKgiW5DUu6esbr99aMXJa0rJ/d44lUGifomTs/SGXb8Z
   j7hDyW3EkzrHafSBYoCpidnySN/zA50+VPoNqcxBQ8OnZgTSuS73sHdJh
   c7TfRnQrkWPBCNxlOCajQIpCeKZI6eQ1wnl63V0S7wiJ2d+NEmwWnY8zr
   2B1tsaCJxa/ZFrLierABtginUaJGlz2jrl2nrGXVgHvPd+hakLPlz7v9z
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="374494787"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="374494787"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 11:00:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="737141666"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="737141666"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP; 24 Aug 2023 11:00:44 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 24 Aug 2023 11:00:43 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 24 Aug 2023 11:00:43 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 24 Aug 2023 11:00:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FL+18okAh6Vtc6azbDZHca7+k6wMBUsTMQ4QaoVeS4CHwXrJ88njs9TiSa3hv0c5/sEmuB1KthEnlHtJ2ma+xIWhRgMSVaS0Ky51QWvLNfgF8DmEb9jmDaUssYlujvNzU9RivO4ph53QfkWxZZV4+4dxkgCzYqzNfMGAH0VMXWzAsSmnUoQfFNlKrtMADhuTIqvTHkGwU0BhdrTbfwmSMPOY2qCOYq9n8YxKajhTbaZ0DhOuf+QhuTAvtQpboc1qVNGSQ+v5FZabAy7JbTe69J9xKE6zAjPjjq9STEOLQqqrjafFHIOJSqRZkP+X86XQ0j4pEEeSaxbf2mKn+hDofw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q/UM9uMvdXGxWUXbEwvvTcLRtvcYAK8MSIY+qWB05oo=;
 b=PvOdKwyuchmmnnbdmLlxv+fGVB4AP6HT7sQYHMbN8IszPzkXzRTV0/gCSGURKF37owhfimUQRW9JnaAfCmBHFeIrE7+cAflMf1vDzCCJlwUKnyXOHsY77BnHgRMPGi8VqAliM5lIkK4EZJ2vzccuZLnj1slQQpmYonvezHsnvAFvkoPNy54Ke88MoXh0QgZp6BbAnVkxwaF4OY4CuQJiOEW2u7Gw6HY4WN+HrERRegg5EK2AISJpK/QQfHGKPP2fm86l89HfxmuxI6ZiEiBuJbPA+3uRTS6ZwQsSEC/ZplXKabsCXZQLQ5W9oTVUi12KaXIRIh+K/ZSyZoPU6ZK/mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH0PR11MB4998.namprd11.prod.outlook.com (2603:10b6:510:32::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 18:00:41 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0%3]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 18:00:41 +0000
Message-ID: <8b70ba5a-5519-365c-f1f9-babe2b573e28@intel.com>
Date:   Thu, 24 Aug 2023 11:00:37 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [EXT] Re: [RFC 00/12] ARM: MPAM: add support for priority
 partitioning control
Content-Language: en-US
To:     Amit Singh Tomar <amitsinght@marvell.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        George Cherian <gcherian@marvell.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "peternewman@google.com" <peternewman@google.com>,
        "Luck, Tony" <tony.luck@intel.com>
References: <20230815152712.1760046-1-amitsinght@marvell.com>
 <f0e10f31-8571-baf6-6665-b077af067777@intel.com>
 <MW4PR18MB5084D5EEBC450BD66E8063E3C61FA@MW4PR18MB5084.namprd18.prod.outlook.com>
 <6114c8d0-97a1-be54-3e43-30348be38683@intel.com>
 <MW4PR18MB50847032F3ACFDBDBCA6D57AC61CA@MW4PR18MB5084.namprd18.prod.outlook.com>
 <be51596e-2e62-2fb9-4176-b0b2a2abb1d3@intel.com>
 <MW4PR18MB5084EB7DBE4985D981FE84F2C61DA@MW4PR18MB5084.namprd18.prod.outlook.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <MW4PR18MB5084EB7DBE4985D981FE84F2C61DA@MW4PR18MB5084.namprd18.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0007.namprd16.prod.outlook.com (2603:10b6:907::20)
 To SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH0PR11MB4998:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ff0822a-3049-402a-ec56-08dba4cc0781
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /iYbXwrEq32DzHC0A9AF/hbo/lhJ2iPIJn0pvlR0MCqXnOlJTZlOCKpu6nU4E0NBh6kkkC63WvLtRIJhAL0eC+c08yRqnfQQriL37rqWRpRPDv2ekEPUhTHRtR5CR1rJOUjv70Vc3/vFFwtxIOt0isd1+eHDLk4+KhzG+dINKG7sBQJK2vnJrM21gB1Ch9EwUd8UyvPSuuutvHAIURZVonn8plDKbbV2n8or0g8Pc2ZH7NNJ44LghZRH4CC4GvT2YzAOcuKijRhgaUq0Z9MAxEEpsrPEpe1EGhohausV4MDj/S/67PjCaZOcGGJ7PVKdd+en1/crZsQEVJ7ToU2QVWwnqSJth2PI5y/I4yAdXkBj4xbHFA4AUDoWaQiWcswoYVAoVX/Gswu1a5Y/db7Oe2d6RwYwbHLcXpx5pXhK2zLmKq196d/60xsFQHAC5xh9f3UrzkIPX2obvGN+SROmdEf8JWfVMUDzGagb2f578gqS54zodMm9Lb4Kbsc9A37+Mp+Yta2mg4Z3LpbHJox+diYkHco1jlsL3zz+6shKpk8aojGeas3HYP3uaZ4JKsSxsKB+cJ5pOLBIJ5mxZkc4rRp1kunNvU/pXmeZ2d+PNMU9Ss0r2cQ8ENCOV1gvfuTXFLxw7+nP7b+lhRBaHGI/cg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(39860400002)(376002)(366004)(451199024)(186009)(1800799009)(54906003)(6506007)(66556008)(66946007)(66476007)(316002)(82960400001)(478600001)(110136005)(26005)(44832011)(38100700002)(6666004)(41300700001)(86362001)(31696002)(6486002)(6512007)(2906002)(53546011)(31686004)(8936002)(8676002)(4326008)(2616005)(107886003)(5660300002)(83380400001)(36756003)(30864003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGJvZkpnbUFHTnB4N1F3MkY1VzUrbGVvUndwQXJPMUs1UUEweVVWRFMweW1F?=
 =?utf-8?B?UG5yNkF4ODQxL2w2SjMvd3QyV0YzV1cwOXJ3THNoM1hKdjVXR3pxcmhSM3dW?=
 =?utf-8?B?Unl3Yzd4R0p4MWJPQjRQTFZVVEd5eEpPT2lzSldPYzArQnBOekxURlJPSUJL?=
 =?utf-8?B?dHYwL2J0VmFiUy8rUFNzaWR6dGh6N2lNblBIR1dZZ0kyWHFDTmlrWHQrTlBw?=
 =?utf-8?B?VkQwZFBpTm1hbmxibE9RaG5oMHVXeER1SnJpNGlpTndlUWVpZkpocUtYWk8x?=
 =?utf-8?B?dTE5cDRXZFV4TWRKR29hTGxxbkZlTlh5NWpoTGwrV2U2aGNrTUREUXhKdGha?=
 =?utf-8?B?WWNnWXJtY3hsam1PWEg0TGJEeUhkdVFLZzZKblBDSSs0Vks5NVNoUitrVUVx?=
 =?utf-8?B?cmNvaW56dmY0SmlNTE1TajlLK01MZlBRMDZGZ3BLL1R3V3krNTF1SzZHT2VS?=
 =?utf-8?B?UEZXcmdrV0w5RGkwc3pscC9mMTJUdVF1TjhrSGxJWGlYUmtyMkc5UGRSc1lx?=
 =?utf-8?B?bTY0SE5pU29YTE5hczZDNkRaaGhsakF1bWQwUzFxRkV3dWZSTVRrT1paT2hT?=
 =?utf-8?B?cFBXOFVsWjA3ZG1Vd2xXaHNqZTlZV1p2NFZJZTRienJsYVgrQzRnNHAvUldm?=
 =?utf-8?B?UjBEV3lCb281Uk1BdTVaVnFEWXhlRTBTeU16WEE3cldpMjNtM2p3UHI0WUNm?=
 =?utf-8?B?bjV3a1ZTR3ZaeFhNM1phWHNEL01vc0YvRi8zdFVGOWl2S0VEUmExOHdXM3FI?=
 =?utf-8?B?L09tektRMzdVdXpaSzkvNVZuTUtrR1o3bzV4azRvR2VLejM3THRZZnIwWUpQ?=
 =?utf-8?B?bzFVUDdtS1U3Zy9VUFpYMXY5OWF6UU9IQ1dyczhyaUtueTg3S0V1Mi9PK1Na?=
 =?utf-8?B?NTRRZUViOXhhZ2pEb0p4Y2pzMVh5S0VDclE4VWsrRzg0ZktjTWhucFV5WXYr?=
 =?utf-8?B?Nkg5RFI4ZnIzUlZIWVNJeUxHaElpQzluV2pVcnV5cHRXaktTcFhucEt6WGs1?=
 =?utf-8?B?M1FxaFJVR0RCdUpEVTBuckloVHBxSTRtbWpDVGdYS2dGTWhsUFg0bTJMUWI5?=
 =?utf-8?B?eENiVFRwNFFQQktCTE5idi9na01oL3IwSG1jQ21yc1VNLzFLaHcxYk02Q0oy?=
 =?utf-8?B?eFZJaktQVHVJeWZNNXVmZFNJeFVpN04xQjBkczliMzZxWFVqdVF1QUk5OWZD?=
 =?utf-8?B?QkRVeFdMakhqZ2ZKOFltR2ZjL1pKOUdjMGMwY0pJZnI4YWtYZWcrQ05TSEsr?=
 =?utf-8?B?am1QMHJTSlA1b3l0cXAwbUhOWHV0KzB4eEVOenJVSExDcDM0bXJ6d2ZPSldC?=
 =?utf-8?B?c3F0Ykhod2NwZktmc2dYWlU5TGJkSTdjb3RzR21hZEFEVnlvdWNLNlFuelh2?=
 =?utf-8?B?SDk2R1JrNEtmRWx4R3Z6V1dKOFZxWURWcVE0OVpwS2hmMUJObXl2V2VLVVlG?=
 =?utf-8?B?NElqeGhuWkcrdGtQak5hRys2V1ZrVjVKVjd1cWE2OVBSZ1JJL2lGQ21sRFBY?=
 =?utf-8?B?a2hIZ3N6cXF2SVFPeFZJcFptb1hUQlo1VEI0eWl3K0hBdWdrbDRLdUtrMExB?=
 =?utf-8?B?NitlMnM5eDZEblE1SGljUUxOWVY1alNvR05uYUtRTjg3U0M2WnNLN1ppMTNW?=
 =?utf-8?B?UlgyQzByYXVqK29xSmdwV3JWZStiR28wZHc0cFZCTGxMczRUdDBPeEY3VTU2?=
 =?utf-8?B?dlVTSVlydERYbmY2MmFQZTR0YVV6SExkU2YyMnJralplV25sbklrY3hwRFAw?=
 =?utf-8?B?RkNPN2Y0VHFTcFBYcDlNZGpnWHRUOTJIRlUraThNSnFPMTlCLzM0WUJ2dGJY?=
 =?utf-8?B?TlZEc2RnZ2NVNUJnblRtZUV1ajFLS0ZmREZkVnRwRk9aNGJUOXQrSXBOUmdv?=
 =?utf-8?B?OUs0WUhiWkcvVUNwZzJQellTS3VMeno2dUlDTzgyK0tyTWRNdHZadEpuV1Vh?=
 =?utf-8?B?djAzb3dTWGhuc04rdXZ4VXVNQWZHNEMzQm1tajhnSnZYKzN1MDZ1d09GcVV0?=
 =?utf-8?B?N2FLRmdjNHRBV0Y2d0Qxa204RS90NkRRR0hHOFl0VnFYVjNESExaN0xkM1RP?=
 =?utf-8?B?aCtITmxxM0oyRUg2MjE3Tk9va2FPaFZyd3NQSTNZMFhUSzBNdEk0MTF0aGxB?=
 =?utf-8?B?WWJ1NzNBaWR0NmJMcEhtQ0l3WkwwNE02VGxFVThjOU5XNm50VXhhWU9KSDY0?=
 =?utf-8?B?RGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ff0822a-3049-402a-ec56-08dba4cc0781
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 18:00:41.1562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5+MoX8/xuxxT9vziCGsdG3VAkrEGF8mtbZczy3dZC5TAp4WUEvurOmLuWz7qz03qWKKSQp7kHFoM5/kG6InEbDnCSYfojZKXNxbja+9JDqI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4998
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Amit,

On 8/24/2023 1:52 AM, Amit Singh Tomar wrote:
> Hi Reinette,
> 
> Thanks for your prompt response.
> 
> -----Original Message-----
> From: Reinette Chatre <reinette.chatre@intel.com> 
> Sent: Thursday, August 24, 2023 3:50 AM
> To: Amit Singh Tomar <amitsinght@marvell.com>; linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Cc: fenghua.yu@intel.com; james.morse@arm.com; George Cherian <gcherian@marvell.com>; robh@kernel.org; peternewman@google.com; Luck, Tony <tony.luck@intel.com>
> Subject: Re: [EXT] Re: [RFC 00/12] ARM: MPAM: add support for priority partitioning control
> 
> Hi Amit,
> 
> On 8/23/2023 2:33 PM, Amit Singh Tomar wrote:
>> Hi Reinette,
>>
>> (Kindly follow the responses in a top-to-bottom sequence).
>>
>> -----Original Message-----
>> From: Reinette Chatre <reinette.chatre@intel.com>
>> Sent: Thursday, August 24, 2023 12:37 AM
>> To: Amit Singh Tomar <amitsinght@marvell.com>; 
>> linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org
>> Cc: fenghua.yu@intel.com; james.morse@arm.com; George Cherian 
>> <gcherian@marvell.com>; robh@kernel.org; peternewman@google.com; Luck, 
>> Tony <tony.luck@intel.com>
>> Subject: Re: [EXT] Re: [RFC 00/12] ARM: MPAM: add support for priority 
>> partitioning control
>>
>> Hi Amit,
>>
>> On 8/22/2023 5:44 AM, Amit Singh Tomar wrote:
>>> Hi Reinette,
>>>
>>> Thanks for having a look!
>>>
>>> -----Original Message-----
>>> From: Reinette Chatre <reinette.chatre@intel.com>
>>> Sent: Friday, August 18, 2023 12:41 AM
>>> To: Amit Singh Tomar <amitsinght@marvell.com>; 
>>> linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org
>>> Cc: fenghua.yu@intel.com; james.morse@arm.com; George Cherian 
>>> <gcherian@marvell.com>; robh@kernel.org; peternewman@google.com; 
>>> Luck, Tony <tony.luck@intel.com>
>>> Subject: [EXT] Re: [RFC 00/12] ARM: MPAM: add support for priority 
>>> partitioning control
>>>
>>> External Email
>>>
>>> ---------------------------------------------------------------------
>>> -
>>> (+Tony)
>>>
>>> Hi Amit,
>>>
>>> On 8/15/2023 8:27 AM, Amit Singh Tomar wrote:
>>>> Arm Memory System Resource Partitioning and Monitoring (MPAM) 
>>>> supports different controls that can be applied to different 
>>>> resources in the system For instance, an optional priority 
>>>> partitioning control where priority value is generated from one MSC, 
>>>> propagates over interconnect to other MSC (known as downstream 
>>>> priority), or can be applied within an MSC for internal operations.
>>>>
>>>> Marvell implementation of ARM MPAM supports priority partitioning 
>>>> control that allows LLC MSC to generate priority values that gets 
>>>> propagated (along with read/write request from upstream) to DDR Block.
>>>> Within the DDR block the priority values is mapped to different traffic class under DDR QoS strategy.
>>>> The link[1] gives some idea about DDR QoS strategy, and terms like 
>>>> LPR, VPR and HPR.
>>>>
>>>> Setup priority partitioning control under Resource control
>>>> ----------------------------------------------------------
>>>> At present, resource control (resctrl) provides basic interface to 
>>>> configure/set-up CAT (Cache Allocation Technology) and MBA (Memory Bandwidth Allocation) capabilities.
>>>> ARM MPAM uses it to support controls like Cache portion partition 
>>>> (CPOR), and MPAM bandwidth partitioning.
>>>>
>>>> As an example, "schemata" file under resource control group contains 
>>>> information about cache portion bitmaps, and memory bandwidth 
>>>> allocation, and these are used to configure Cache portion partition (CPOR), and MPAM bandwidth partitioning controls.
>>>>
>>>> MB:0=0100
>>>> L3:0=ffff
>>>>
>>>> But resctrl doesn't provide a way to set-up other control that ARM 
>>>> MPAM provides (For instance, Priority partitioning control as 
>>>> mentioned above). To support this, James has suggested to use 
>>>> already existing schemata to be compatible with portable software, 
>>>> and this is the main idea behind this RFC is to have some kind of discussion on how resctrl can be extended to support priority partitioning control.
>>>>
>>>> To support Priority partitioning control, "schemata" file is updated 
>>>> to accommodate priority field (upon priority partitioning capability 
>>>> detection), separated from CPBM using delimiter ",".
>>>>
>>>> L3:0=ffff,f where f indicates downstream priority max value.
>>>>
>>>> These dspri value gets programmed per partition, that can be used to 
>>>> override QoS value coming from upstream (CPU).
>>>>
>>>> RFC patch-set[2] is based on James Morse's MPAM snapshot[3] for 6.2, 
>>>> and ACPI table is based on DEN0065A_MPAM_ACPI_2.0.
>>>>
>>>
>>> There are some aspects of this that I think we should be cautious 
>>> about. First, there may inevitably be more properties in the future 
>>> that need to be associated with a resource allocation, these may 
>>> indeed be different between architectures and individual platforms.
>>> Second, user space need a way to know which properties are supported 
>>> and what valid parameters may be.
>>>
>>> On a high level I thus understand the goal be to add support for 
>>> assigning a property to a resource allocation with "Priority 
>>> partitioning control" being the first property.
>>
>>> To that end, I have a few questions:
>>> * How can this interface be expanded to support more properties with the
>>>   expectation that a system/architecture may not support all resctrl supported
>>>   properties?
>>> [>>] All these new controls ("Priority partitioning is one of them) detected as resource capabilities (via Features Identification Register), and these control will not be probed, if system/architecture
>>>         doesn't support it. From resource control side, this means that users will never get to know about the controls from schemata file. For instance, the platform that supports Priority partitioning control
>>>         schemata file looks like:
>>>
>>>        # cat schemata 
>>>            L3:1=ffff
>>>
>>>         As oppose to when system has Priority partitioning control
>>>         # cat schemata 
>>>            L3:1=ffff,f
>>>
>>
>> Right, but my question is "How can this interface be expanded ...".
>> Consider a future L3 resource that has a new and different property
>> ("new_property") that is independent from "Priority partitioning". 
>> If "L3:1=ffff,f" means "Priority partitioning" == 0xf, how can a value be assigned to "new_property" if the system's L3 supports it but not "Priority partitioning"?
>> If I understand correctly the proposed interface is a positional interface and "Priority partitioning" is always in second field ...
>>
>> [>>] Yes, "Priority partitioning" will always be the second field.
>>
>> but a system may or may not support this property so does it require an empty second field to be able to use other properties?
>>
>> [>>] Yes, in the absence of this control ("Priority partitioning"), second field will be taken by other control (if supported).
>>
>> So, for example, if L3 resource is equipped with two controls, .i.e. CPOR and PPART, schemata will look like:
>>
>>          L3:0=XXXX,PPART=X
>>
>> and, if same resource is equipped with another set of controls, .i.e. CPOR and CCAP (cache capacity partitioning), schemata will look like:
>>
>>          L3:0=XXXX,CCAP=X
>>
>> and, in case resource is equipped with all three controls, schemata will look like:
>>
>>         L3:0=XXXX,PPART=X,CCAP=X
>>
>> Each of these combinations, features its own format specifier.
>>     
> 
> I see. I do have a similar concern as Peter regarding the impact of this change on parsing of the schemata file. I peeked at intel-cmt-cat's implementation [1] and if I understand it correctly these changes will break it. This is just one example but I do think this will have significant impact on user space that should be avoided.[>>] 
> 
> [>>] To be honest, I don't see how it breaks things on x86 side. None of these new controls (PPART, or CCAP) exist for intel platform, and in absence of these control, schemata file remains the same, .i.e.
>         L3:0=ffff
> 
>        Or you're talking about the situation when intel may have similar control, and this proposed approach would break intel-cmt-cat then?

There are indeed two parts to this. First, I still consider
this as breaking user space because user space interacts with
"resctrl" that should be a generic interface. Second, yes, any
"resctrl" interface is available to every vendor. It is not expected
that all systems support all features but resctrl is the interface
with which user space can query what features are supported in
order to interact with the features.

> Apart from this this discussion focused on the display of properties when user views the schemata file. We also need to consider how the user will provide new data by writing to the schemata file.
> For example, I do not think it is convenient for the user to have to provide the allocation bitmask every time the "Priority partitioning" value needs to be changed for a resource instance. 
> 
> [>>] This is something, I was pondering about, not to provide allocation bitmask while changing "Priority partitioning" values or vice-versa but ARM MPAM device driver
> run through all the resource instances (learned from ACPI table) and program the ris_idx (along with partid) into MPAMCFG_PART_SEL_NS[RIS].
> After that, programs the portion bit map (related to CPOR), or Priority value (depends on the ris_idx) into MPAMCFG_CPBM_NS or MPAMCFG_PRI_NS[dspri].
> 
> As example, for resource index 0 (MPAMCFG_PART_SEL_NS[0]), it programs Priority value, and for resource index 1 ( MPAMCFG_PART_SEL_NS[1]), it programs portion bitmap value. In a way, Driver[1]
> Expects both these values to be supplied. May be James can correct me here.

I see obtaining the data from user space as separate from
writing the data to the hardware. resctrl maintains the
hardware configuration internally so it is possible to
have user space modify a portion of the configuration
while still being able to write the entire configuration
to hardware if that is required.


> This may also be solved when considering Peter's idea but since this work depends on other work that is not upstream it is difficult to envision the impact of any suggestions.
> 
> [>>] Initially, we have thought about these three approaches:
> 
> 1) Populate the resource control filesystem[2] with a new file that corresponds to new control. It requires Priority value to be encoded around portion bitmaps, and James has suggested we should go via
>    "schemata" file approach.
> 
>    I think, this is something Tony has pointed out in other thread.

Synchronizing writes to hardware with updates to separate
files may be a challenge.

> 
> 2) Second approach that we discussed internally is to have schemata for CPOR, and PPART separated by new line as mentioned/suggested by Peter, But it may require to tweak
>    the ARM MPAM device driver a bit. It was kind of toss-up between 2nd and 3nd approach :), and we went with the 3rd one.
> 
>    L3:0=XXXX
>    L3:0=PPART=X
> 
>    Will look into it again.

Tony has suggestions here. I think it would be a good exercise to
write a user space client to explore how the interface
can be made most convenient.

Reinette
