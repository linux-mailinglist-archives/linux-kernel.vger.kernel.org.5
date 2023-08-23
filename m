Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E38A478634B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 00:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238595AbjHWWUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 18:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238660AbjHWWUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 18:20:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879B6CF3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 15:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692829232; x=1724365232;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AmF8ADMNGIVW0tZ6BwztlYAzuKjU21Oziinli6N5iLc=;
  b=EVs2w8b9cDHVI2Y70HEkiu79jvOyvcM/Dij3GJ6RQqGl/otvl52HSfA1
   JWn8Ez4f/uTk9GyxGnbSnxWZ9XRC3itOWeB29h3M0F2DI/v6QUi94tytz
   L4JJ90CrBYSutP+3y4HoNxoUV9Zs/SHU22K7tpGxACHXG9oA3bhr0WQ+8
   ly1gThaSAVfeMYCPYgXREUd7HqOaOVXEwPOO62koUNMadWBTtLRuJnlqd
   M+foazS8srfEgBr/jxTvFxuQz3xPyWQ2coL2rrltMl1cjlQ2hBKiQjoL4
   msPJLjOoKG9EOeHj2mLvocDjgzrn5Fu/ep4jc7nHLSigKcyYx/N7O/WZc
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="371696842"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="371696842"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 15:20:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="826893829"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="826893829"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Aug 2023 15:20:31 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 23 Aug 2023 15:20:31 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 23 Aug 2023 15:20:31 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 23 Aug 2023 15:20:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iWeugkt21H/hBP0L/PWL3tSdOqBXXylBn2/g/HiVYnlL+AZ/RFtJsKhGCkQuz52NxDhLQCZOO8GqD6BDuz6Ul0jy3YcSAuRMwc5NqEN+nnOCKg0t6osoV7wZdCMm5yIMoyHTO45G76GjMiLviwp4l1GXRLQky8Z/Vq2IH14gRDAGb1iG9MLgSzJsTPT9I90a8kNe8xMXEv2QO+3Q3oQ+tRW/wIDYlLsaBFn9bMnBbmLOz7p/9eYj5LDpNTMpUdXFlUlnPfoMu1v/unAldBWLL+iRnNDMEuO0xQURUGraywsZslZhPftfcxuvhHTiyIbNHT4ujVTA5R4C1NMLR+mSUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6PEf3hUSlHdQ+8fVjv1zKXe1mkufGzghud7nX9DrxOQ=;
 b=CZ1ZAL4kcSPd0jTeAYZ4DjbFo+Y5o+nlCKlsG9vgvFEu6XZesFF+4j/dxJpEpTc0PSJw4k1pVWciPwVXEovUs4lxi+4O+W4kOE384U9DKDIQ8gfPkx2yjX+DStZFmxZB9KkDoCPBNjskclQi5gJscqEBgiPhENYDgsOisTJTNcQE037AcSloo2P47JrzMjeCnK7fzCThCuPu3WEF36sQlWR6smh5BoylY9qekYich9p24vphvpxLooP6Tm+Z5zBkG1bSjyFlg7Ir71TSOdCTDmnp98WNoTGvUk5AgpIf69I5jy0p+M9mnp+0GGnqX8rwQQKnYq+o6WN6rgkacoAM/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MW4PR11MB6935.namprd11.prod.outlook.com (2603:10b6:303:228::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26; Wed, 23 Aug
 2023 22:20:28 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0%3]) with mapi id 15.20.6699.026; Wed, 23 Aug 2023
 22:20:27 +0000
Message-ID: <be51596e-2e62-2fb9-4176-b0b2a2abb1d3@intel.com>
Date:   Wed, 23 Aug 2023 15:20:22 -0700
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
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <MW4PR18MB50847032F3ACFDBDBCA6D57AC61CA@MW4PR18MB5084.namprd18.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0095.namprd04.prod.outlook.com
 (2603:10b6:303:83::10) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MW4PR11MB6935:EE_
X-MS-Office365-Filtering-Correlation-Id: 4803ea83-743e-4bbf-7f56-08dba4272738
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nplskS/rhozgfYpWF7FDcMdUv+36CiJ6x2OdnrsWMQ66RVeaE/2DPdny02QSImXCNNPuEFpfH6AQ7rLlkuq7T/Ig0BjPHeFIOMK1fSqG4k+Hingk8LPJdyKBmAALWnUrhPfQ2Dq6yx2YVdLqFvRwgBdkdcM06Ud130/WDC7TdY0DGn0dSIsuNdw6f7G63wWtEfAgPBkF+JJYpVQ6CIYOuy6fBDwgJQ79ZJJUPQ6xZwbzIstU/nn0S4IYK7m6P9BtjfwX2qSfhAHYvXiSjZXxpikKAEY8s0NuZROQ6gQyDu7XXbqtNNIV/GW4FbEMpsq746K7Cqqneo5HUowCQhaQTFE//BqWwsXFQIvf89gTMXNQ4tSB9uA7lWnPTPjya04FPSIl63Z1N5zEj+jWSAjfoOtYK/1mWPc27aLohTt+zieraJ8Kt/HodtmTbcECL1gtUg3PDQiDVizmnCKafVDErbGCLbMn0SuFGHIHO7Ab+KZsRNPOuYJ67LS3sNaI21gYSSDqE5jRKMKO3emg69lZpnOwjIfFHSuCnWFXznQ4jeWcm7jzEFCsvjd89y75ul257idhR9PJxGwJhvSnb2q4CZ7RT3BPE050PbC5QPw+O9brKuTjMe4TInDympPQXxaE4D0kXdjBEkTkx3AUPYurLQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(346002)(39860400002)(136003)(451199024)(1800799009)(186009)(66556008)(66946007)(66476007)(54906003)(110136005)(5660300002)(44832011)(107886003)(2616005)(41300700001)(316002)(2906002)(31696002)(966005)(478600001)(86362001)(31686004)(8936002)(4326008)(8676002)(38100700002)(6666004)(6512007)(6506007)(53546011)(82960400001)(6486002)(36756003)(83380400001)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2syeStYd0grT29hVmhoZWRDS2NKajAzdVR0b0RWamV0dVpMTG84dEdoNitY?=
 =?utf-8?B?cWF5UHBmQUhUSFlKd0hqaHlXNkNIbEdWaFZzRm9YdldpUUZBampTV1d1Ry96?=
 =?utf-8?B?SGw2K1VCMmRjaU00SVJML1ZOZkwxS3JpSWJBaDhjZ1VRRmZUZkUzQzB5Z1dH?=
 =?utf-8?B?d1o1T2lncXMweEZmdzNwaGVOalB5aUFiSjBCSTM5a1AxUW1MTVJ6d1RpWDdm?=
 =?utf-8?B?eGdFa21KT29UczNnR1N5L3ordmk5LzhUNnA0Q2tJZVpBK0NGSFJscHJIalRq?=
 =?utf-8?B?a1NHaFNOdmE1REN1b1plVGcwMjZENksxK2MxOVYxVWtLVjRPSktGK0dST2tJ?=
 =?utf-8?B?VGVaalQzWmRSTGRIdWtxRTQ1Z3ZEWS90MkZlWm02RnZscmtyTFpDMEsrN0N1?=
 =?utf-8?B?N2pZSUpNSHlhUzUvQ3NVYTZwcXJRbjBEZzRuU2Z2N25rSkU2aTVGWFdhcStS?=
 =?utf-8?B?TlVmbFBXRkRpVHJpRmExVCtDb0c2SnZmREJ3NFpsYTRFZWlwcTFsL29vdlBO?=
 =?utf-8?B?MHFoSW1IWWpLKzhLalJPZEQvK0NuZE1NRnpVdGJSNGZLY0N5RWhYUW9LaGVj?=
 =?utf-8?B?Z1lZNjFzZjFKaWl3aXltbW5TQytWMVZQUkFrSzhtOTJleUtPZTR0RjVCUXgz?=
 =?utf-8?B?ZXJHcUJ4SS9DbkdBWHUwc1diQXIxcitWbEYvVkJTL0xVdFhTell5YzBWSTNi?=
 =?utf-8?B?VUIxdHBXKytHeHEzTEJnSGRNZGFBNUFkSHI4eUd3dzRoTEhKZGJhTGd1U0NW?=
 =?utf-8?B?cFlWcjBicElhSVdUdlF1ZFNZOGdlcUZ5cVJVK2pRbUp5KzBMS3F5R3R0WGVQ?=
 =?utf-8?B?YTIvZ3lKWngrTzcvQnA2ZHZ4S21kVDYxTFlQNjRyWUhaMjFFbGFEOGcwNXVF?=
 =?utf-8?B?WG1VbUh2T2ZXM0h3UDJiRUhRY1hNMnV4VzdsMGFYWVBhQ3pVQWRJQ3dVOTk3?=
 =?utf-8?B?OUY0Y3FOeXRNVDNDN1E2enBTK3RhTU5yWU9vSnAwNEJIQ1paUlFIdHVDRElM?=
 =?utf-8?B?SSt1eWVlSmd4WEJkRTQrd3pmbkhzMGlhWmJrbWR0S0ZkT1Z2SmF4Q2dXd0hT?=
 =?utf-8?B?bmFGc05JVzRhbzNVb1pMeXFBRGJvb09kNldBeUp1MThFRUJ2eUh4OG1kNFB1?=
 =?utf-8?B?SnRxdHBITXp6R3c3RlhmSGFuL2QxTklaR3BMakNhWGRSUFpTV2Fvd0NBUHZu?=
 =?utf-8?B?Vy94c29GaytJbXVTUVphVVVIS2NVb0src2tyUGpmQnY0OStuWkpXOCtiTklI?=
 =?utf-8?B?MEFFbTY3Ky8zU3RKOVlxSVlkQ0lNMFJhRko0dmZVTXV4V2dQb3hGOEpLaUc2?=
 =?utf-8?B?SmZjanN2ZGhhdDBOTVR5d1hSQTZJaElFOVVGZjd1dTJ4V0JRL2lsNXk1WmlO?=
 =?utf-8?B?RjdEK01PZHZlMDE5V0ErOWdRaTlMM2k1VUNKMFdseHpyYk5KNlFabWl6bHBX?=
 =?utf-8?B?SWhTMG9Jek43TisvWmgwMWwxcmhCU2REK2NNL29iaVJrOTlqZGQremJUc2FS?=
 =?utf-8?B?N1VkMjFHbytBclpObklBc0NhUmdVZzZ0NmxhWldqYVdFYktTYWZZeWJtZkZy?=
 =?utf-8?B?UTFCRysvZmlEWThNaWhkYlNCQlg3ejJRN3pWUGZLa0ZjQVNCVVA4MUgzOWtW?=
 =?utf-8?B?V1hZaDVwcjJRa2UyZkpRUExmY0xCQm1PN2N5UDNJQjBrUEg2YUx0ZmVHR3ZS?=
 =?utf-8?B?M0xJTW5qZE95MGhIcVl5c3BxcEJJajFOUGU4bHFmb1A2eWIvb1BOOU03aGNh?=
 =?utf-8?B?RTZnSmo3ZlBnQlFpekFTQ24zdmlORmlqV0t3eVZVZml5WGI1QjBxZDRnZ0Jx?=
 =?utf-8?B?enlhNE9qSjhqU2x6QmNHdjE2N3RHdlB5QmM3TXdldUw4dkN1dFd1RytsdUtB?=
 =?utf-8?B?T0ZCbUEwNmhyQ09lbHlDZkZBZHBxZE1KUi83Y2NsTzBPUWtVUndhZi9SczFZ?=
 =?utf-8?B?OUhzSkRpc203S1pnU1BBdTVXZlJmTnkzdk5PdHhYTlRseHMzaklRSzhmTUQ3?=
 =?utf-8?B?eGxQL2NUN3lHOGszNEc4czJycGpGSE16dmpBWjFrOXltZ0o1NGxXbmlZMHEw?=
 =?utf-8?B?RUhqTkgvUVVtU29MKzhuZlVHVy9LMjVkZVpsbHZjb3V0aVVxMnY0MkJ3TjlE?=
 =?utf-8?B?LzE1cldIRGJPNGNVMzZMN3YwbzViUDl4ODBVQm9yKzZoUzFDc08zazNYMktw?=
 =?utf-8?B?R2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4803ea83-743e-4bbf-7f56-08dba4272738
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 22:20:27.4835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZA1df5KxgYvnv4deG8YdlWE5nDAmuj9Cw0VJVYCwYAE0vAcy9itswXe1yLpdt8k2jgFB0fB2gJx4Yj3AheuZZtuDokr7HzJ8SyZiOQ1LZSg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6935
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Amit,

On 8/23/2023 2:33 PM, Amit Singh Tomar wrote:
> Hi Reinette,
> 
> (Kindly follow the responses in a top-to-bottom sequence).
> 
> -----Original Message-----
> From: Reinette Chatre <reinette.chatre@intel.com> 
> Sent: Thursday, August 24, 2023 12:37 AM
> To: Amit Singh Tomar <amitsinght@marvell.com>; linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Cc: fenghua.yu@intel.com; james.morse@arm.com; George Cherian <gcherian@marvell.com>; robh@kernel.org; peternewman@google.com; Luck, Tony <tony.luck@intel.com>
> Subject: Re: [EXT] Re: [RFC 00/12] ARM: MPAM: add support for priority partitioning control
> 
> Hi Amit,
> 
> On 8/22/2023 5:44 AM, Amit Singh Tomar wrote:
>> Hi Reinette,
>>
>> Thanks for having a look!
>>
>> -----Original Message-----
>> From: Reinette Chatre <reinette.chatre@intel.com>
>> Sent: Friday, August 18, 2023 12:41 AM
>> To: Amit Singh Tomar <amitsinght@marvell.com>; 
>> linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org
>> Cc: fenghua.yu@intel.com; james.morse@arm.com; George Cherian 
>> <gcherian@marvell.com>; robh@kernel.org; peternewman@google.com; Luck, 
>> Tony <tony.luck@intel.com>
>> Subject: [EXT] Re: [RFC 00/12] ARM: MPAM: add support for priority 
>> partitioning control
>>
>> External Email
>>
>> ----------------------------------------------------------------------
>> (+Tony)
>>
>> Hi Amit,
>>
>> On 8/15/2023 8:27 AM, Amit Singh Tomar wrote:
>>> Arm Memory System Resource Partitioning and Monitoring (MPAM) 
>>> supports different controls that can be applied to different 
>>> resources in the system For instance, an optional priority 
>>> partitioning control where priority value is generated from one MSC, 
>>> propagates over interconnect to other MSC (known as downstream 
>>> priority), or can be applied within an MSC for internal operations.
>>>
>>> Marvell implementation of ARM MPAM supports priority partitioning 
>>> control that allows LLC MSC to generate priority values that gets 
>>> propagated (along with read/write request from upstream) to DDR Block.
>>> Within the DDR block the priority values is mapped to different traffic class under DDR QoS strategy.
>>> The link[1] gives some idea about DDR QoS strategy, and terms like 
>>> LPR, VPR and HPR.
>>>
>>> Setup priority partitioning control under Resource control
>>> ----------------------------------------------------------
>>> At present, resource control (resctrl) provides basic interface to 
>>> configure/set-up CAT (Cache Allocation Technology) and MBA (Memory Bandwidth Allocation) capabilities.
>>> ARM MPAM uses it to support controls like Cache portion partition 
>>> (CPOR), and MPAM bandwidth partitioning.
>>>
>>> As an example, "schemata" file under resource control group contains 
>>> information about cache portion bitmaps, and memory bandwidth 
>>> allocation, and these are used to configure Cache portion partition (CPOR), and MPAM bandwidth partitioning controls.
>>>
>>> MB:0=0100
>>> L3:0=ffff
>>>
>>> But resctrl doesn't provide a way to set-up other control that ARM 
>>> MPAM provides (For instance, Priority partitioning control as 
>>> mentioned above). To support this, James has suggested to use already 
>>> existing schemata to be compatible with portable software, and this 
>>> is the main idea behind this RFC is to have some kind of discussion on how resctrl can be extended to support priority partitioning control.
>>>
>>> To support Priority partitioning control, "schemata" file is updated 
>>> to accommodate priority field (upon priority partitioning capability 
>>> detection), separated from CPBM using delimiter ",".
>>>
>>> L3:0=ffff,f where f indicates downstream priority max value.
>>>
>>> These dspri value gets programmed per partition, that can be used to 
>>> override QoS value coming from upstream (CPU).
>>>
>>> RFC patch-set[2] is based on James Morse's MPAM snapshot[3] for 6.2, 
>>> and ACPI table is based on DEN0065A_MPAM_ACPI_2.0.
>>>
>>
>> There are some aspects of this that I think we should be cautious 
>> about. First, there may inevitably be more properties in the future 
>> that need to be associated with a resource allocation, these may 
>> indeed be different between architectures and individual platforms.
>> Second, user space need a way to know which properties are supported 
>> and what valid parameters may be.
>>
>> On a high level I thus understand the goal be to add support for 
>> assigning a property to a resource allocation with "Priority 
>> partitioning control" being the first property.
> 
>> To that end, I have a few questions:
>> * How can this interface be expanded to support more properties with the
>>   expectation that a system/architecture may not support all resctrl supported
>>   properties?
>> [>>] All these new controls ("Priority partitioning is one of them) detected as resource capabilities (via Features Identification Register), and these control will not be probed, if system/architecture
>>         doesn't support it. From resource control side, this means that users will never get to know about the controls from schemata file. For instance, the platform that supports Priority partitioning control
>>         schemata file looks like:
>>
>>        # cat schemata 
>>            L3:1=ffff
>>
>>         As oppose to when system has Priority partitioning control
>>         # cat schemata 
>>            L3:1=ffff,f
>>
> 
> Right, but my question is "How can this interface be expanded ...".
> Consider a future L3 resource that has a new and different property
> ("new_property") that is independent from "Priority partitioning". 
> If "L3:1=ffff,f" means "Priority partitioning" == 0xf, how can a value be assigned to "new_property" if the system's L3 supports it but not "Priority partitioning"?
> If I understand correctly the proposed interface is a positional interface and "Priority partitioning" is always in second field ...
> 
> [>>] Yes, "Priority partitioning" will always be the second field.
> 
> but a system may or may not support this property so does it require an empty second field to be able to use other properties?
> 
> [>>] Yes, in the absence of this control ("Priority partitioning"), second field will be taken by other control (if supported).
> 
> So, for example, if L3 resource is equipped with two controls, .i.e. CPOR and PPART, schemata will look like:
> 
>          L3:0=XXXX,PPART=X
> 
> and, if same resource is equipped with another set of controls, .i.e. CPOR and CCAP (cache capacity partitioning), schemata will look like:
> 
>          L3:0=XXXX,CCAP=X
> 
> and, in case resource is equipped with all three controls, schemata will look like:
> 
>         L3:0=XXXX,PPART=X,CCAP=X
> 
> Each of these combinations, features its own format specifier.
>     

I see. I do have a similar concern as Peter regarding the impact of
this change on parsing of the schemata file. I peeked at intel-cmt-cat's
implementation [1] and if I understand it correctly these changes will
break it. This is just one example but I do think this will have
significant impact on user space that should be avoided.

Apart from this this discussion focused on the display of properties when
user views the schemata file. We also need to consider
how the user will provide new data by writing to the schemata file.
For example, I do not think it is convenient for the user to
have to provide the allocation bitmask every time the
"Priority partitioning" value needs to be changed for a resource
instance. This may also be solved when considering Peter's idea but
since this work depends on other work that is not upstream it
is difficult to envision the impact of any suggestions.

Reinette

[1] https://github.com/intel/intel-cmt-cat/blob/master/lib/resctrl_schemata.c#L495

