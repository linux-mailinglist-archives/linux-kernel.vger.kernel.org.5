Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29AEC7FB7DD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 11:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344309AbjK1KbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 05:31:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234926AbjK1Kas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 05:30:48 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C8A13A88;
        Tue, 28 Nov 2023 02:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701167224; x=1732703224;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sX9CZb2J1tZ9gU0FByM4qZfFQlsRDLGB61h1oRxrXCs=;
  b=bO0k2nPhi4nnQ5TNHzUBj7LSXBmdNHwD3k7Q+nlSWLBueekhfaDmx+fA
   l7vhhWEoHkT/eM28axliP0h2lKvKrPh812cvINOkFw3lIKSj4Rd7thRzb
   2BydGKFtD3E0Chg+UYS18HU52B5tCt4tjl8PqbhR2VYTjkZbuEWomsTYy
   Zn7EYmbiveJRXFwFOccYqQ7ZI0pam6uvLvR16hM8+etpvy2XgnuKZlCGU
   wCeRkQ8zAdWQkrv0u8+siDS7sUACKycgKxGQkfABPiiFlIeohGMk60pGd
   Sq2MAhNhCqXQ+58n+CVqlYK9rLfDzt8/6MgLc3j9CRP3kKYCgRmGvjPYx
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="396799541"
X-IronPort-AV: E=Sophos;i="6.04,233,1695711600"; 
   d="scan'208";a="396799541"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 02:27:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="802929661"
X-IronPort-AV: E=Sophos;i="6.04,233,1695711600"; 
   d="scan'208";a="802929661"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Nov 2023 02:27:04 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 28 Nov 2023 02:27:03 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 28 Nov 2023 02:27:03 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 28 Nov 2023 02:27:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=by0+wjQO4EsnLuqACc7XvbU1RoLnPa5F5DyEp8B0jRjBvZecHRJa+gsEr7NNLcK4aVx4jsL4xAAoUag/UeHwAcMgwkgPzBI0tS1kDRtafJPbIDFvPJJD93+Ucuacr9s/nmSVZNfltQ212yYwUk3Na5W+UjOKtObiezHXyE9OCpMI8uoCrpXiAfKXQihKbrb8eEGe6gaJX0uWk6VUTIOjp/0jGZbAP/nQ7pKbQz8TBwFu4mnEoTvuH0d3skcpHx2kABK09usjEXFd4bg+J826wIrOkeIezSqSnmYuX+D7wrSa2yo/22W3S95SIGyJhmhfpgxqXtF9q0zwNjyHTbkt4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1hqnTyfbdXbgXXAOs1pptlst8+X6ZHNSiCHRQljUKgQ=;
 b=EqkGfo1V2751NfCEO2EafCqL2qKcZmAqQOVTDXRSlLUFM206DNqF1UDZGDIN5+6Gu3Mga2hqQ/yNqrrK0kTgqfQFdY7K24DPylmT7w+l+3uQuKaiKt0y6yOTxKVHX/DAXudCXVnCBhmXxJOV7cQHdmjzl0CtZQayWKuJpu7TqbLKKPHBJb6o+cbLsiMPJPlG46FFbkUWcX4zpJJX2YOdaNzmP8KjsZ1mCn0B2dQqLdct7ibGuN31tM2/6phVGWjWP6tUEv2hIWHLiOsDCox5kHJBATgZfYkiLlT1SG/ecRo8XDEIaoU486vd6LazcNAjh6fpDpsxg2gNPoJ38NCXQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3672.namprd11.prod.outlook.com (2603:10b6:a03:fa::30)
 by SA3PR11MB7612.namprd11.prod.outlook.com (2603:10b6:806:31b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Tue, 28 Nov
 2023 10:27:00 +0000
Received: from BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::5112:5e76:3f72:38f7]) by BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::5112:5e76:3f72:38f7%5]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 10:27:00 +0000
Message-ID: <344baee8-16ce-88ce-ad51-609fc70f38ed@intel.com>
Date:   Tue, 28 Nov 2023 11:26:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH iwl-net v4] ice: Block PF reinit if attached to bond
Content-Language: en-US
To:     Jiri Pirko <jiri@resnulli.us>,
        "Bahadur, Sachin" <sachin.bahadur@intel.com>
CC:     "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20231127060512.1283336-1-sachin.bahadur@intel.com>
 <ZWRkN12fhENyN4PY@nanopsycho>
 <BY5PR11MB42574D2A64F2C4E42400213A96BDA@BY5PR11MB4257.namprd11.prod.outlook.com>
 <ZWWYx18w2BnLyAZL@nanopsycho>
From:   Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <ZWWYx18w2BnLyAZL@nanopsycho>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0151.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::14) To BYAPR11MB3672.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3672:EE_|SA3PR11MB7612:EE_
X-MS-Office365-Filtering-Correlation-Id: f2d1ac2b-6e2a-4daf-a1a2-08dbeffc8ea1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vUxqK2IIJHi2CyW/GG7zQsnT2dhdjoh/mDR9SvPdEbZCO+fxrtdIMSJtT3qRlWBgRGBEeH4tT0Prl9MvFN21IxWLEWOafsTz9C8/URTB0QgLhxlTs+ZcHmS9pA8IX2rcNmPkYAs5Lvh8yj1vJhrI2i76qbo1BU9Ek9Allu7P3KMR0hjJcj6R4j7knJ0nQW5Jpez0EkCfeWVlSFJFoOWWHezgBvTZ4FothKR7lozNoWGO5s454JU634uajnkIL0gGAuATKAELcRGb6dUTOxoys3JSiSFedQ8o5fNbOHgRxQaS3pno8poS17DoL/Brf6g7Oin+fQ7dzheaSbbtGiRhWH3UZqHLEXGGi3ZXv6/uZubOm1ekvFC6wyamNh65gTJx7LDJo3u+CrmBoh3bzbOAfe82Q2V06BVjm+rZt/UMuT31wytKUZ6bg7vxlk2ks5kspsaZHwXRJ4RV8Jsi9q+6VCvu/fDAkGOJRQv/gHjmBfN5nbf+BOa7w/lQrRPz8UwyCJQVFiMGW4yZNNQHKWNyra5k90pLV3C94gqXsFDUAhfStxim7dd5pAdBB+J6zRkGa2glYJNlJCNVyVK/u98gn/dFDMHqDRc+aU6YmVwjSszUTRNrh2+RxXrj5I2Doy2Krz4IvcDZMZ664ArAB6Tmpg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3672.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39860400002)(136003)(396003)(346002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(38100700002)(41300700001)(36756003)(31686004)(4744005)(83380400001)(5660300002)(82960400001)(26005)(86362001)(2616005)(2906002)(66476007)(6512007)(53546011)(6506007)(8936002)(31696002)(6666004)(8676002)(4326008)(6486002)(478600001)(6636002)(66556008)(110136005)(54906003)(66946007)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUhQZzQ2K1ZzQmJmcmhpL2FoWW9KMW5TeGZoYWtoQ3BNenArWjRZN2o0T2Ni?=
 =?utf-8?B?YlI2dzAzQmMyWGUzYU9yOUJ3bHlkUEd4ZFZFUmR3NkxVVThBdmFQbm1QOUF0?=
 =?utf-8?B?c3Rndnk0YUdYOEYvTFpVMTB4Nmtra1dxZlc3dXJxUms3QVRnK2ZQRE03L1M5?=
 =?utf-8?B?eFZnSUtabkl2MHhGNTFlajh6UGY4MEUzd2F5Qk9BeFErM2hyOHZSRzM4QUI0?=
 =?utf-8?B?MkpRaE1xVCtVSmZSM0FsWG5hNHhva0tFMDErNzRlV2Z5NnRFdnpCL0ZmbCt2?=
 =?utf-8?B?Q0doNUx0ZU1aRFJDNjJsNC81YnlWeUV4dHEwdjNqakZSL09jWTQ1Q3VKbDVi?=
 =?utf-8?B?UTE4bWRsdHk0R1pIZ0ZMRyt3ek1RWmFaeTdOTXJib05VMUFCb2xyc2o5b2E0?=
 =?utf-8?B?M2pLdXRSd1l6UzI0K25tL21Gb2kySnl0d05TTUpUQnNSNGZhWEF4RGl1b0FF?=
 =?utf-8?B?YVExc1piczArTjdvSk5kYnlnK3JEZkZnZ3Nab0h0VHdBdjJwOTRZM2xHeC82?=
 =?utf-8?B?MWlwUFh6aEYzTEVhZzljdUt5bGJDamJXaVRveDZQQ3lyWG5Da0p0aS9FS0J4?=
 =?utf-8?B?SlJqZzhEcE5CejdNaS9xaVgwNlkvOGNlQ2hrYlRzWXJGVkZwMU9DdmZHNnhZ?=
 =?utf-8?B?YWdxeTh5OG40amhTaFZQcllBc1NndHM2TS9HNnAwVjg0c3VoeVVjRHl4aEd2?=
 =?utf-8?B?Mkx1MlArVERwemF5UmtFQ0NTbUdZNGMxSGlQTVRNWTNGbW5aZW5xUlRPSzgw?=
 =?utf-8?B?cXhmb1kxYnZudXdoQ1c0UEtzTVliaWNtU1ZMY3BsUzg3SUpNb3ptTUc1V2ZG?=
 =?utf-8?B?cjhuRG5hR1VhdWhzRGNpM1V2ZnpUMWlTejZidE9RQmd0N0V0eFYwb1AzOHFj?=
 =?utf-8?B?aEZaaFROcGFUd2N0ckhPNy9heXdUekRaUHFaRE12bXRTcndMUVM0b0xTSnp6?=
 =?utf-8?B?Z2ZpMjBUSnllaVI2NlpsSlRQTU9PNm1hMEhwRTQ2Q2thZEN0QjFqOTNqSU1R?=
 =?utf-8?B?SjVZQmw1eWgwME9oY1JmbGR2cG9EU0VIYTJ2MTdmQmgvVUxRZFdpRFN1bjJH?=
 =?utf-8?B?QnZzbnBjUGY0RmpEeTZOMW5lTUFVVHp2d3NXdlNaNjl4ZTVYd2lPSWpMWkJK?=
 =?utf-8?B?ZXozSDhuOVRxYUxORE9kNERSZXhBZFNJNXpTdU4zU2ZoZWEvNHRWUzZMeTZs?=
 =?utf-8?B?dHJVejhUQ2FINVJTQ0VsUGJZcWJDamJkTnZ4eFNJdUJ4M3dvNWw0cE1NUGFJ?=
 =?utf-8?B?UUtnWFEvODJxcjhldTZxdXVBakFhY2R5Mi83SHVKVitrb1Y0akJXZlhja3NN?=
 =?utf-8?B?ZjR2bWxuNWVQV0RGRzYwOHhLUUJvbE5jZUxpTHRBMkQrd2dPbXF6V2lBd2Vk?=
 =?utf-8?B?V0xyekNONXJ2eEhvbC83dmlNL05PNkZYcEs4aHJrb1diWkJnd1h6ZWdodlJO?=
 =?utf-8?B?NTRLMFVqMU41UGtoYzBIQWVEeGhWTkVvOEhQM2pKaXhNU1ZsQVMxSHNnVHRJ?=
 =?utf-8?B?d3BPNkhFZWU2SGxVMHp2dzUwcS9rWmVlSk1DdGFCUWp3U2gwMEtGQW5EQmxW?=
 =?utf-8?B?ZDFISHFSMUQrUC9weXhYNy8xa2lFcGJ2clQxNy9heUZHWDlORHNDdUlsdTNT?=
 =?utf-8?B?NmFTU3V5UHNBNXQxUTVZSkJGN0VUdlZjT0FzcXZXRjJFR0dBZVVtclBoY2ta?=
 =?utf-8?B?aWhYNHlpK1Z3YUhJb1ZSVGwxV3NMQWN2aDlFSUF0S0t6OW5IV2x2eWUrTkRB?=
 =?utf-8?B?azFXUGhwNW5NeW5UeEdFS0R4VGxpQ3lyR3VKM3JtYUVWdmdKbFZQN2RuQWdz?=
 =?utf-8?B?QzA2ZGs4aGh5Qi9QSlVrSWkveUVCK0tKZVpyL21waVd2dFB2RkNkc1ZqVjBi?=
 =?utf-8?B?YTdWc29Kam11eldteG5hTGdHcHQxQ09DV0VLTU1nNWJVM0VwSHpCYU05MzdK?=
 =?utf-8?B?VlBLQ0htbnEzZVYzZlFxVzlZVHloWU84Q28rODVxTDdyZmJ3RGZzUjRLbzhJ?=
 =?utf-8?B?Y1BIZzhPVlptdHRuWVA5WWRnczg5cG9odUNPTjFCRWlhTkw2M3ZrbmpsRnFM?=
 =?utf-8?B?Y2pYaE9aUUpuV3EzUmhudXVzNVNTSTJCTGUwVjRlZ3FQTGZSNlN4b0VYS2w1?=
 =?utf-8?B?RXRuUC8yWUJLZkhDUE51V21qYUlJNk1uS1MzbWtTNy9IdmZ3YmtGMmZSak0z?=
 =?utf-8?B?d2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f2d1ac2b-6e2a-4daf-a1a2-08dbeffc8ea1
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3672.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 10:27:00.8043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OWeWaNlUzOezj25IOHwiwwx229s0sns3pgS8VrlBkiCJuytbbHmFx8A6QGXsZZaqpap4j6Bd8T9o5D+CifjWW6KYoLJwDngNTArBvXYEYpc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7612
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/28/23 08:37, Jiri Pirko wrote:
> Mon, Nov 27, 2023 at 05:23:55PM CET, sachin.bahadur@intel.com wrote:
>>
>>> Nack. Remove the netdev during re-init, that would solve your issue.
>>> Looks like some checks are needed to be added in devlink code to make sure
>>> drivers behave properly. I'm on in.
>>
>> Sure. This fix should apply to all drivers. Adding it in devlink makes more
>> sense. I am not a devlink expert, so I hope you or someone else can
>> help with it.
> 
> No, you misunderstood. I'll just add a check-warn in devlink for case
> when port exists during reload. You need to fix it in your driver.

Having a message in log that reminds devs would be useful, thanks!

> 
>>
>>>
>>>
>>>> +			return -EBUSY;
>>>> +		}
>>>> 		ice_unload(pf);
>>>> 		return 0;
>>>> 	case DEVLINK_RELOAD_ACTION_FW_ACTIVATE:
>>>> --
>>>> 2.25.1
>>>>
>>>>
> 

