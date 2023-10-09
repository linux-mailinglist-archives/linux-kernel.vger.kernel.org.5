Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77CFC7BE8C9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 19:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377241AbjJIR7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 13:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345624AbjJIR7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 13:59:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C7CA3;
        Mon,  9 Oct 2023 10:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696874384; x=1728410384;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AUFlxMgi2tBXa3UYWA8FusSgomNdHZN+Q7ijX4SmBLI=;
  b=OuIMvy17O1MSsPuxPG1M/47cn8W2O8ml32o2cMrlE9Wh4XcMmQCGN8JC
   ZDwpdHLKo9KxX2y4+soFFTFuKYkgGKSdkyVgLSfMA0EYO8HT41EYfCBFA
   Hv4xWH6PLD52lRo/2XLlDQXGfnM+siJIvcNd5hYNEzzCQ/cFYlOm9JuCv
   W6BefxJ6vRvYDXYCvThc1FaeQ+8gneF4ylo7ULEjGmymAP+IJJfTWnwRH
   AFaDpfg1wYIbrJzaxVRub9Xg+K7423yx3idSx04qee0nxcsbfHTyKXrk8
   ZRS/bBSd2iu77NDCBz5MtI9Z/egsMPsr1LJQOFUNUXdtkKKZQ8wnLLVwn
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="364500712"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="364500712"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 10:59:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="823416687"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="823416687"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Oct 2023 10:59:42 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 9 Oct 2023 10:59:42 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 9 Oct 2023 10:59:36 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 9 Oct 2023 10:59:36 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 9 Oct 2023 10:59:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AtQ5du3/sWJCND89bBzrr4NpeRa2zmFsch5iYLdKprlNZ33CvVU3noDVWaYExTffegOu1QlchH/QZLhqt96aUsX0h/ohHEK9xiV4qw8C/N0qdgkyLN0SDQr2weKhxYK00Lfs4sjv2NV2uu0aUf7o3aGjtKjvr07fGxWsFOtZo1/La5KxOdJ8kUgeQIkSgF3pK7oJXbE3Bj2kxZ9OQkxsOuR+wp2vR52BoO/kkF69+BSBYFcGFi1GUiCV64cAw2f7XzsOnXGJtJ5FEVRUuxx9oF9nR9liBoshUgWkdwk+U/NPu66vqsAyW0VEMl/3ZY2I/w+I/kMOfGr25kiLNxWMIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eZ4EwD5bn+MQh5RamWYQeDWjK1QIQYz87EZGidiyvaw=;
 b=Qx5D/7QiklbSIsrdUI3xourSMGSIA33Wv9+3COgFC6Jhb015VB0EgGNkXMfAtqsD2umDtqAOTaSIlMybSYMe1bn0mu4igxhtgy0UIUBnH/HDEzI3qWBfi16cIpb7zNdHfECSwcmcRBul2Dw7UfHrEJ6kq0T011jVVUiAEL9leJX8c+qsOnTI/vqow5ca6gkGvUh9YDIacImaEqNsmNiI4NU0Amig9WTbeYoO6EamMs4OLVd5mpFBjRZYAatpI7otBu8ekAzIMWOwYAh0W7xd4juJlugCPapcpES7cwhGrJzS2M81RzwTSjzPthavMKGHqKnh+zy3hBq4rldY7HcD5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CO1PR11MB5090.namprd11.prod.outlook.com (2603:10b6:303:96::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Mon, 9 Oct
 2023 17:59:31 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6863.032; Mon, 9 Oct 2023
 17:59:31 +0000
Message-ID: <51277249-2351-4933-98d5-2cb74a14c7dd@intel.com>
Date:   Mon, 9 Oct 2023 10:59:27 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 05/10] x86/resctrl: Unwind the errors inside
 rdt_enable_ctx()
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>, Babu Moger <babu.moger@amd.com>
CC:     <corbet@lwn.net>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <fenghua.yu@intel.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
        <akpm@linux-foundation.org>, <quic_neeraju@quicinc.com>,
        <rdunlap@infradead.org>, <damien.lemoal@opensource.wdc.com>,
        <songmuchun@bytedance.com>, <peterz@infradead.org>,
        <jpoimboe@kernel.org>, <pbonzini@redhat.com>,
        <chang.seok.bae@intel.com>, <pawan.kumar.gupta@linux.intel.com>,
        <jmattson@google.com>, <daniel.sneddon@linux.intel.com>,
        <sandipan.das@amd.com>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bagasdotme@gmail.com>,
        <eranian@google.com>, <christophe.leroy@csgroup.eu>,
        <jarkko@kernel.org>, <adrian.hunter@intel.com>,
        <quic_jiles@quicinc.com>, <peternewman@google.com>
References: <20231003235430.1231238-1-babu.moger@amd.com>
 <20231003235430.1231238-6-babu.moger@amd.com>
 <20231009172517.GRZSQ3fT05LGgpcW35@fat_crate.local>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231009172517.GRZSQ3fT05LGgpcW35@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0048.namprd03.prod.outlook.com
 (2603:10b6:303:8e::23) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CO1PR11MB5090:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e84da31-24d7-4ede-61a9-08dbc8f17cb6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hv/YVdOusbvBn7fQOJMh8wyyl96CWmygUiENDW3xg4A/y+nR6fpn2ft1B9oIO1rDYg3KqpYI8sKKKtP1AkUFJAtGyrrzMMPvetD3kE2FEduxwx0MMgz+ErdJM4rktObCbCcN8ZNRQSvp7wVByFvceK81zivNv2ktUHf6SZDTEKh2ikQwuqyvrXZfGPgBOyz+UMHfb9u33cLRIJmED3VY+vGSdbUpYP/Mn3DbN6na8tGi72x9qMFLY7V4T6l1UkG69RNDibeDBVb9vg18pVRgp8RVP5PPNUNu+TSlZeu2Fs88WJwNr3HkuK0t+rBrmWqIjKWWtMu1eHTnUHCs3Wu8AHqPpgoJ4BvDyECi2Mh9Ix2XcJXqNkz2nK5EKEyUWKLwY7MNeYGgdFXul1zU6GAjUM4UydklSc9hG3blbqBGpHhrcv/e00vtiXQtAOSggD8j9sdmWPjDXz/7gIkZefHOn5eNO7lhOLXcUd/rz3th1uzoFYfmGIYf9n6haxtlF7Z8zKqjLvxKobke5nPRGAGKKCmT1Z0JQzoGquAm3+s24+POD0cvuy6oDdzGomOqaD175lt3bBxoNqDxOosqZ3GgVEIhQaevyM5G+b8ZPWbXNgo6m/2lnoGDuvNJblrvn78hbIPPGjRgPDcs5swl3dhjDQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(366004)(346002)(396003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(5660300002)(8936002)(41300700001)(2906002)(6506007)(53546011)(6512007)(316002)(2616005)(66476007)(66946007)(66556008)(82960400001)(110136005)(4326008)(36756003)(31696002)(8676002)(86362001)(6486002)(7416002)(478600001)(26005)(44832011)(31686004)(6666004)(7406005)(83380400001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0xnK0JvRzA4YytOM0NTaERJakdncWw5WkhVUnJCNGpwMTNVVFNReGw3Rjdq?=
 =?utf-8?B?MU1HdTFXdHNkNFd6bUtPaTBobXB6UUxVdjN0Q2RaVWs4UDB1UVU3WFJoYlA0?=
 =?utf-8?B?TmZtam0rUXpadU9heXQ1RHpiWEpmRU1ydExUbFo3amFTS0VEdCtQMVBtRE96?=
 =?utf-8?B?Qy9pUFpmVXc0TlVpTGtyb3AwMUxVV3daaDBSUDA3VXQwRlEvZXpKSi82Nk5C?=
 =?utf-8?B?d29TeXlpMWpQR2NlMFBraWNBNzhYWEt5THNLQ2dNRm1XRFcxUkZMaXBraGtz?=
 =?utf-8?B?a2Q4eHlUdjhrN0xNY2l6emlOYmFYUXl5ZElTQmw4MjJYb1pSY05UWUtrcFdq?=
 =?utf-8?B?dzFuRWFSQWdGaGhsS0RCTUIzbXJzQWlwZVpwdGhWRTUxVzM0MFNDNVF0V1lF?=
 =?utf-8?B?QWVPWlBQSS9Id3FERGY1OTZ6VzUxSTlwdzAwUTFwSGlXVS9lcjFVVnVib1B4?=
 =?utf-8?B?czE2YWVwZG55UWRjRklOY0ZWNVdwRm02Nit6WmJYd2YySENZa2xwWVFkdjhx?=
 =?utf-8?B?bW9mK2pSaDlrT09ZVVU1dXQvRHlGYVV6SjZpdktWN1hYZW9IclVIc05qaGg2?=
 =?utf-8?B?c29CY21Wemk1ZU9UTHY1T1ZWWnQ4WHhPbGF2YlhwQ2l3eDNxaFpkZDZDRExI?=
 =?utf-8?B?U3NNbmJ6dFhObkg1Z0p2aTdVZEtGMW5yTEE2Ny81aWtDeXllcm5XZnVrcE9D?=
 =?utf-8?B?SWRyRENDWUk3SFo1cVBhZzhJK3BDTHh5WTFYbG9VdUpYN1YvZkU4Rlc5bXFD?=
 =?utf-8?B?Rm9hSGpMSHBMR1lITG1iN2RSOXRBOGdjbzB1ekFwYW90MUxsYUVyNTRzQ0lB?=
 =?utf-8?B?ZHlzeFVDWCtHdXhhY1BVUUl6SW1XNy92bHJQakR6SjRmaUpDSElwUmd0R0E1?=
 =?utf-8?B?VjZFbnhwZ1lKTFNoNHJESFhrNkFULzB3MFMzdzJ1RWNIM25PQnZxUm95QlZz?=
 =?utf-8?B?MFRFWStsbFM2SDlyWEVqNE1COXZ1UDBzR0kzZlVqbmdINktTS2RiblBtM2tJ?=
 =?utf-8?B?LzFodGlGQm45MncvRlJHMUI3T2h6UURBY0lUYUwrc1NjNUFNcnVGSjlKRVJS?=
 =?utf-8?B?RldlbmV3cHlwa0xjOGFDUWp6QkpQT1huVEdXVTBxTkdwTHFsL2o5ZmdDNVhJ?=
 =?utf-8?B?a2dlNzlNSnI5SVFzZitlb2NHeGhQbDVpWGYwUlc0dEw1dTVXeUtXS1ZFMFZu?=
 =?utf-8?B?dzNPZnJvZGhFVzZIM1orSnliOWF2aXJzbWliVVhQVGlzQVJwWlNlK3BnTXZi?=
 =?utf-8?B?N0o3eERWRlRoSEpTbVFyeFAyZjNsOUl0NTQ3cEJVWVFHdXdSNjVpd1hOa2lz?=
 =?utf-8?B?eTYzZHdEZjhjYWJlN3p1MitxZ2JHRkxBaGZjZWlNMVhVUGtHM3pCUktPbm5o?=
 =?utf-8?B?SmgzTzBoQUkzcHZ6VWtCNkxJTFQrL1VwL1dyTzVBRHg3b2lZdU9zVldXd1V1?=
 =?utf-8?B?V1BlTk9ZczRVSkIvVnlPSWhtemt6YnRrdWk5R09OZGhGakJBckRkb3JmUzlL?=
 =?utf-8?B?SGQzelJNb0VJeDZYMlQvMm82YzFwOU5KeUdTYXhjZ2prb2dxdXhOcmxGOFlp?=
 =?utf-8?B?bGJteFJyVXFPOUdUVUtUWDdhWkU4UVh3dlE4RW1YQktkaHo4dVgzQlYrRGcr?=
 =?utf-8?B?NGRLMzNYTlZqbmxxbkZGNWRWbnZTZnU1a1RJOUFZb0tJNmRYeGhESldPakRZ?=
 =?utf-8?B?QXBLdmpCRG1tTjUrNDhzWDB6K3hOUS9Mem16WGRJc1FnTVF4VGFpZ1NyWGhO?=
 =?utf-8?B?WVZlNkhlc3JnRGh0NGxWcjJtMWhmYUFQTkV2RkJqdWpMVm5UOEJ1VXBxSksz?=
 =?utf-8?B?RmlvQ2NTWUNRY3ZCWjd4dkdobHQzclY3VjFBNGJBcUYyWlhlNVV2UU4xOFBP?=
 =?utf-8?B?YWZiVHo0b05sMUs4dXNHa2xXVjFpOHRBQXRxcU5ScFZjalN2Z0ovTXp2OWx6?=
 =?utf-8?B?RzRiY2RGY2taUTBlOHpEQ0NrMmljNVNkV3IyemQ5SkFBcUJtKy93cmlCZzA3?=
 =?utf-8?B?UHAxL3NJZGxLd1hxdTUzRGlCTjQzUndKRkZKbUY4eWhkRVRkNjlNZDRzeW1W?=
 =?utf-8?B?Vk9vdjZIS0pEV01kRTR1Qk4rTjBMNXdwTkFuWlAyRDh0bDBLWmlERlhHZWZ1?=
 =?utf-8?B?MWFwZWJUYXpLZUs2MVdpOU1vN1l0WHFzN2tjSDZZNGcyY21GV0FCZGsrWnZq?=
 =?utf-8?B?eGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e84da31-24d7-4ede-61a9-08dbc8f17cb6
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 17:59:31.3121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sWeJE2lvBrMAIWY2Q1lNhM+ERitt6Hrt5X4uMIKrLQjjdCPjQAdWaLuo7Wt5zbQn5FYXMsTr7gUTd0AdcLOnOh1NyNjUdj4/qtJDZRrL7vs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5090
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On 10/9/2023 10:25 AM, Borislav Petkov wrote:
> On Tue, Oct 03, 2023 at 06:54:25PM -0500, Babu Moger wrote:
>> rdt_enable_ctx() enables the features provided during resctrl mount.
>>
>> Additions to rdt_enable_ctx() are required to also modify error paths
>> of rdt_enable_ctx() callers to ensure correct unwinding if errors
>> are encountered after calling rdt_enable_ctx(). This is error prone.
>>
>> Introduce rdt_disable_ctx() to refactor the error unwinding of
>> rdt_enable_ctx() to simplify future additions. This also simplifies
>> cleanup in rdt_kill_sb().
>>
>> Remove cdp_disable_all() as it is not used anymore after the refactor.
> 
> Do not talk about *what* the patch is doing in the commit message - that
> should be obvious from the diff itself. Rather, concentrate on the *why*
> it needs to be done.

I worked with Babu on this commit message and would appreciate guidance to
get this (and others) right. The second paragraph intends to explain the
current problem with rdt_enable_ctx() with the third paragraph providing an
overview of how the problem will be fixed and why (future code needs to touch
this area).

Is it the fourth paragraph (mentioning cdp_disable_all()) that is annoying? I
can see that it is redundant. Would it be more palatable if the fourth paragraph
is just dropped?

> 
> Check your whole series.
> 

Reinette
