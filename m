Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE8C79375F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 10:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235769AbjIFIsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 04:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233257AbjIFIsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 04:48:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA47CFD
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 01:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693990072; x=1725526072;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=lwoQ4x12WMaU81lmWoA8g5pxfb+IlweWeHt8rCMJU78=;
  b=jPQJuM+BxayfYcLDxynR8CzmCilw/21IWI8XSn2jYWJtaxG24EMYRVPV
   vePsWt3sxjL4awxxcW1U3FxgwvRAoL00PuhZh2qxXK+yhDPSBNoOReB6i
   zlisMe75A8Uu8BF/T+0cACJ9dy8yHacd5x+iQQia0BU92HQPjnhp6Qbdx
   SH21IaSFlkC7Q3pw3jTQ2wpDlvTQTyAuD18/qQqymAnbPuN27bHVcxVXQ
   2SxKls8MowOF1AwVFsqOGiCSxL0IMAs/of9hKNwqK1mzYIaiDgZy335hX
   CM1G1BmMGXeKJ2XbL5e82PVAbs0KkLqqTKUyoDrP8OLBK12l8yDqW4blR
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="463391326"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="463391326"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 01:47:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="915186085"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="915186085"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Sep 2023 01:47:50 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 6 Sep 2023 01:47:49 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 6 Sep 2023 01:47:49 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 6 Sep 2023 01:47:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JQ1tTAnxGxGizNzQ8OJ6Uvruj1nRhQCvNspAT90YZaa/1wLn16sma+sEDmwkH0zOkWCcsp/oR2k9ulf53r13b5VcpG3hc/cMg28+VW3SJZKjV5GJvND2LyChrgdbGDo/jzmbHh213HcJSxWLdoJ5pmfwjmH1Fk+5KAjWA1ILV9MItz5Sq0W7BbyAa3u/hFvtYofi755xwsXl8EDagkIt98Fyu5nTksOva1u370qB9oAs19YeXWsg6NH/W7CFPHjIIRkO1QuwszPu+eTqot8OH7WA0eMKQMFOuDGRBKoFYfUC1Vpx/v3pEmetF7RNzDrnAC33f8Eh2TWWkxgTh8WR+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LP6zNIhHuyAIMOYnAbVelZjjmIGovXwksBspqPSQ6XE=;
 b=GtpjwemMDFBUj8HbQ44XimbXNuMBNtqaU7152pSYCLSIQTnGwl9Lu7pD4SAQ9j4ZolEVAOF5Ae2YVO2fvARQqcx7PYER453BwH9P/ImLKnbQJ4valZoEaAEODd9FyPkxnoZMTKriUTj8ZWXNDdSJnfgsuLFlrNjlk3K+MjhATvSP+alxbUR/6i5K1L+jICAwE5l8C+xMt93eBS141r5+8QezujEjVwbdY9lF7RKcIv8FVaC/R80h9cxIBIk5uw9M1r3MNXK8k9YeMn1An9V6K3AGbsApqYAR6omtTNE3HcSBKw6aHKPdav0PlgRsDNL5ZKBqgXTAXwXmWK7cldViuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3094.namprd11.prod.outlook.com (2603:10b6:a03:87::25)
 by IA1PR11MB6171.namprd11.prod.outlook.com (2603:10b6:208:3e9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Wed, 6 Sep
 2023 08:47:47 +0000
Received: from BYAPR11MB3094.namprd11.prod.outlook.com
 ([fe80::5e3:67e1:e213:c87]) by BYAPR11MB3094.namprd11.prod.outlook.com
 ([fe80::5e3:67e1:e213:c87%5]) with mapi id 15.20.6745.034; Wed, 6 Sep 2023
 08:47:47 +0000
Date:   Wed, 6 Sep 2023 16:47:32 +0800
From:   Yi Sun <yi.sun@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
CC:     <dave.hansen@intel.com>, <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <sohil.mehta@intel.com>, <ak@linux.intel.com>,
        <ilpo.jarvinen@linux.intel.com>, <heng.su@intel.com>,
        <tony.luck@intel.com>, <dave.hansen@linux.intel.com>,
        <yi.sun@intel.intel.com>
Subject: Re: [PATCH v6 1/3] x86/fpu: Measure the Latency of XSAVES and XRSTORS
Message-ID: <ZPg8pJR55pmEZ4vQ@ysun46-mobl.ccr.corp.intel.com>
References: <20230901143414.1664368-1-yi.sun@intel.com>
 <20230901143414.1664368-2-yi.sun@intel.com>
 <ZPMTVNM2oBCdSYjJ@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Disposition: inline
In-Reply-To: <ZPMTVNM2oBCdSYjJ@gmail.com>
X-ClientProxiedBy: SI1PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::20) To BYAPR11MB3094.namprd11.prod.outlook.com
 (2603:10b6:a03:87::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3094:EE_|IA1PR11MB6171:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c9dc76a-ef30-49e6-fad3-08dbaeb5f18c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MeRvnbltvB3LJV7xixZjtFMRoMUYuzk/yLaT9twJoSnsqW6woquidhzPBYuWGGUvb0cxn0HWVNI21Ii2wvmDVqM+QllS6t5dpovZYWYtQii4cQeOvL3GxpWU+abNFf6FZvKeE+yibJYG+YmwbDGun4z5BvPqPABss1hHeZo+OieJ9v48SQVtK0aLWDUIO8xHHkOjR/IPXn82KNMK/1kp8nBWajfCzfKFa492BMOiMcKrl2i/nHw8pO6fLPdLAGeoXzrfI+8zXEPyWZeXJqHTZzL13yxJKrhTFXjQsasT/p4rxjWkVTWiNkCJZfqCpLkClUFe8RqlJmIVeZ4yxUfKdxQopQp4ePz462H2rAlffSUIk1Ko+exDLweyM7Z+4j99zSqO7vmgRct6pBSrxoFlMJ68WM4BkYndS9frS7VEf1eY9j3lMpg77uOxF9ksdI33wzvsXEU+N8V3bf6PUmCvJJujof5apnWOnKXbc4liIydM4llwaLe8CzUT3yK4L/cyAlTNLCwbMy6zR3NhSARAPle+o9QchW8qS99Yyy2tyS2HvUf+NsnbCrlI7n9t/DbE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3094.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(346002)(39860400002)(376002)(366004)(186009)(1800799009)(451199024)(41300700001)(6666004)(86362001)(478600001)(82960400001)(38100700002)(83380400001)(26005)(53546011)(6512007)(6506007)(6486002)(66946007)(8676002)(66556008)(2906002)(316002)(6916009)(66476007)(8936002)(5660300002)(44832011)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aCtNbnBtVTdDS0U0akkwWCtkcWRGNlEzU0VhWkwrQVhRTWQySDFOL1I3UTZF?=
 =?utf-8?B?eHZVdmF2WlFxYnB2NFNHNUw0K3REQzNBS1lCK0NTYVAzcHl4cGZkSGZWUmQ4?=
 =?utf-8?B?Z1NIWGFKYVp2QVlqZTQrdWJmdUg4NWNWMStIdWJlRTJoU3Q3bDIwWFpFR0Z2?=
 =?utf-8?B?Nk5HWXUxQ281TkFwUTJqNkk5UTdzbzNOWVh6UFpEZTNmMy8yRmlJS1pKM0s2?=
 =?utf-8?B?SVB6TktuTkUyUksyM1dsdG1zR28wUnI0V0pnTVhRWkhaNHErSlhSWFlhTW5Y?=
 =?utf-8?B?dG9DVGNhREE2eVJ1UnNWTG0wOFJJUlpKdFd5Q3BZTWtCTWl1ZnFJSXZ2c1NW?=
 =?utf-8?B?cTIweHJGQnFkVVFEK0MvRXVHalBCTUF4TUNudmdLNXdyRXlxN1pUenQ5RjNM?=
 =?utf-8?B?NlpmejVkQzJBTFcwNXI4MWpVam1Jd3lmenc4RUorNEhxMnA2Wk8yOFRKMVZz?=
 =?utf-8?B?KzRKSDV0UVQyQzVBU1pSUGVZSys3NERjY09DVXNna3A0OXJJamdyRFNtb1Ra?=
 =?utf-8?B?RkE4MStOMzR5cjQxUFQwMlBqZjduTWNnNzE0WVpZTVhyQ3JTeE0zeTNWZ0Fp?=
 =?utf-8?B?UWtRUUFZS2VtekYyNWtKL2JjbXNPWmVyd2ZtbjJKakNpK2dtbWZiMW5kcGZ3?=
 =?utf-8?B?WHhtUmxYUnRXTXF5VzBrYTRKQVNSeUVESnZiVWo2N3FaYTE2THJ1NTEwTEJk?=
 =?utf-8?B?a0hodGdlYnlCUDh3bCs1L1VKOFVpWW1MUnRGMWJ2R3ZscnE0Q293M25nUisx?=
 =?utf-8?B?UTBZZnBrVXBJWnA4eGdWcXliMFFDaFovSWdPTUtEdnk4Tm5nK2FqclJSUnFI?=
 =?utf-8?B?bWNTaVhZTFpTZVoyL0lSL3lYcExyY09jYXMybWgxZ21FNC9SNm5WM2lUa2du?=
 =?utf-8?B?SS9PR0FSMCsvNUxvNGc3SHZFeDlqNUNMVW9zcDRhM3dzakgvY2RERkRTb2JX?=
 =?utf-8?B?djFLQ05YVlZEZ2JFZ1NGVFhCbWdKWnE4MW9xUW9UUU1SNkd2emRpQm9YdUFs?=
 =?utf-8?B?VVp1WUtMQ1BwNEFVeGNqU3RuMGZXa1cyR2gzU2Q3dnFpd2lWQzBCbDg3TVhl?=
 =?utf-8?B?NUkrNlBpMi9sNEQ3ZDJnZE9rczJ5MGVwOVUycDlXTEc3RmhpYjB5WW1NUk8z?=
 =?utf-8?B?L25BWVFqN2QwZXduandUN2FZeEk1bkxWR1dJcW9BeEw3Z0xQTXYrRDQ2ZFpJ?=
 =?utf-8?B?c0xKcEp5TzV1OEthblNNS1dEeDFwUjJvZFBpeVdiYmxZNm8xTm5BTkt2Y1Y4?=
 =?utf-8?B?ajhONnVDM1d5bTRJdUozazN1YjhVRHBRbmp2RnRUNDJZaEw5WHdFUVlGTWV1?=
 =?utf-8?B?Y0xHTFBldWszdE5lTWdYUDNmN1BPdXMyWE5kWDV5a1ZhSnBLWFJjMkhSM3A4?=
 =?utf-8?B?cDYrbC9WTUxzMytRK1JLY3c5amhhZ2tTN2RGdWdocWtsT1hDU1VUOTZ6a21O?=
 =?utf-8?B?QUtiM0hYZHJzSTMveFYxZitoOGczV3ZnRE9BY1ExOHdUZmZQZHlpdnlBRHo4?=
 =?utf-8?B?RUhBYk9QVGFJZDU0ZktiQzNrRiszVEpmanZoVVZna0g2elEwbkM3ZlhWNFlZ?=
 =?utf-8?B?WExhMi9lekVlRnZHdlA4T0tiWG84N0Vrem1BT0hFZ2YrVUJoTUhoS0RkTUxN?=
 =?utf-8?B?VmVaTklLVVBUTmt3UmU5RzZLRWFYaGF0WDN4Nks1cXVUVjJDcmlSbDRUZ2k2?=
 =?utf-8?B?bWdUamREZFJQdGxaMTBqQ0pVeXRwaHBVRFhHQTZmd3BoekV5YmxSNkJGNEpl?=
 =?utf-8?B?aVBpWVhkRUFLdzRlQU4rNTluNVI2bEhDdEM3QzJSQ2NCb3drUUZiT3ZBeEt6?=
 =?utf-8?B?cUtqQjkwUmdCYzgvT2hyUStQUjM3ZzI0d0dJVklQNDVGN2gyUDRpdUlSNUFl?=
 =?utf-8?B?RGRXajJkb25nQmlnekhnenV4NEFpOUpzLzUrc1h3MG8vWG9oSG0zZEJqT0dw?=
 =?utf-8?B?cDllWU56QXBOc1h5UWZOYXNBeTBpOHdlVktxUkh2RDhRVVBpNVF1RW90STFh?=
 =?utf-8?B?dWNrNUhZRmVUR0dKaFF6Tlk1YVp5aUpkcklJK0FtRUNmTnZxaGJJejN4SEVi?=
 =?utf-8?B?Ni9nN3VtRDJSSDVVeE10THROVm50YlExNUJDaE0zUW1GaGFWKy9nc0pkbmRn?=
 =?utf-8?Q?+c1dNFFnAWDUd/0hqQ6k9cLbo?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c9dc76a-ef30-49e6-fad3-08dbaeb5f18c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3094.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 08:47:47.0143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qyI0D2/ESQm2PEqQ7JoZxbKqj9ntXEUqEe0eOLjgZJGQJnQvYU3RACP3Ok7w+tq8SpzscaV34FW9zpVeOBjChA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6171
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.09.2023 12:49, Ingo Molnar wrote:
>
>* Yi Sun <yi.sun@intel.com> wrote:
>
>> +#define XSTATE_XSAVE(fps, lmask, hmask, err)				\
>> +	do {								\
>> +		struct fpstate *f = fps;				\
>> +		u64 tc = -1;						\
>> +		if (xsave_tracing_enabled())				\
>> +			tc = trace_clock();				\
>> +		__XSTATE_XSAVE(&f->regs.xsave, lmask, hmask, err);	\
>> +		if (xsave_tracing_enabled())				\
>> +			trace_x86_fpu_latency_xsave(f, trace_clock() - tc);\
>> +	} while (0)
>> +
>>  /*
>>   * Use XRSTORS to restore context if it is enabled. XRSTORS supports compact
>>   * XSAVE area format.
>>   */
>> -#define XSTATE_XRESTORE(st, lmask, hmask)				\
>> +#define __XSTATE_XRESTORE(st, lmask, hmask)				\
>>  	asm volatile(ALTERNATIVE(XRSTOR,				\
>>  				 XRSTORS, X86_FEATURE_XSAVES)		\
>>  		     "\n"						\
>> @@ -140,6 +168,17 @@ static inline u64 xfeatures_mask_independent(void)
>>  		     : "D" (st), "m" (*st), "a" (lmask), "d" (hmask)	\
>>  		     : "memory")
>>
>> +#define XSTATE_XRESTORE(fps, lmask, hmask)				\
>> +	do {								\
>> +		struct fpstate *f = fps;				\
>> +		u64 tc = -1;						\
>> +		if (xrstor_tracing_enabled())				\
>> +			tc = trace_clock();				\
>> +		__XSTATE_XRESTORE(&f->regs.xsave, lmask, hmask);	\
>> +		if (xrstor_tracing_enabled())				\
>> +			trace_x86_fpu_latency_xrstor(f, trace_clock() - tc);\
>> +	} while (0)
>> +
>>  #if defined(CONFIG_X86_64) && defined(CONFIG_X86_DEBUG_FPU)
>>  extern void xfd_validate_state(struct fpstate *fpstate, u64 mask, bool rstor);
>>  #else
>> @@ -184,7 +223,7 @@ static inline void os_xsave(struct fpstate *fpstate)
>>  	WARN_ON_FPU(!alternatives_patched);
>>  	xfd_validate_state(fpstate, mask, false);
>>
>> -	XSTATE_XSAVE(&fpstate->regs.xsave, lmask, hmask, err);
>> +	XSTATE_XSAVE(fpstate, lmask, hmask, err);
>>
>>  	/* We should never fault when copying to a kernel buffer: */
>>  	WARN_ON_FPU(err);
>> @@ -201,7 +240,7 @@ static inline void os_xrstor(struct fpstate *fpstate, u64 mask)
>>  	u32 hmask = mask >> 32;
>>
>>  	xfd_validate_state(fpstate, mask, true);
>> -	XSTATE_XRESTORE(&fpstate->regs.xsave, lmask, hmask);
>> +	XSTATE_XRESTORE(fpstate, lmask, hmask);
>>  }
>
>Instead of adding overhead to the regular FPU context saving/restoring code
>paths, could you add a helper function that has tracing code included, but
>which isn't otherwise used - and leave the regular code with no tracing
>overhead?
>
>This puts a bit of a long-term maintenance focus on making sure that the
>traced functionality won't bitrot, but I'd say that's preferable to adding
>tracing overhead.
>
Hi Ingo,
It is actually a helper function, and I have renamed the original function
to __XSTATE_XSAVE. This function is only used in this particular context.

Furthermore, according doc static-keys.txt, the condition
xrstor_tracing_enabled() would introduce only a minimal overhead when the
trace is disabled. I believe it is a negligible impact on the performance
when the trace is disabled.

Please let me know if you have any questions or concerns about this function.

Thanks
   --Sun, Yi
