Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 453D177FF0B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 22:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354898AbjHQU37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 16:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354888AbjHQU3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 16:29:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82FB2A6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 13:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692304189; x=1723840189;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pMhUZF4S1aOJpv2OImfPyQIV8j2Os3QNRCru87xeUME=;
  b=VUZIlbhPh6fZ2pRwGUL5CAcTOaR+019T9wZo3/x+WTzFyQ5L5te4y4LT
   gDB5AOrjsvfshGgFYIM8sDWcER3pIJUw9MER3gfPIvKp9wuMJVqBqeojk
   OfsuQptSdZHAtyLvZqdJmIuYqzVjDo3lUlfKOEKbUJqnLxC3QgKzc5rme
   El4f1YvLFiUpDs7ZcClsnty/5zvb0G66kdtAH4U+QFuBTLIUtj6z7joJN
   pFyZAoVmtVjcCGLMSYCQe24E2wgI2j7UHfYfTMbbD+MwchD3Igkm6ed+N
   UO1oO5nGoNMebD0MvUbnScbBFO7PjDqO5+bkmdj1Fw1b7/UaYWD41quPQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="403904377"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="403904377"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 13:29:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="737851349"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="737851349"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP; 17 Aug 2023 13:29:48 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 17 Aug 2023 13:29:47 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 17 Aug 2023 13:29:47 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 17 Aug 2023 13:29:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HL9VtgLXWhYRE1PIcwcdIsU3iUMm+oJmUMbyANOypG8VZYPBUIb3ls7FBbcgjcGoahLWQNUsJvRkpeQl1Z1TYYyW/hDzJMRxYXoVzekUqzCjCnA+hac78mSW4VOl8e+3rmseVySbfpYRRMm0k+2s1vr8ArA33jy0ARZSKHfsLlVdg1ILLePcncLwfPs/xrHj7EwdgWjahRK1cllTnuH41zrVtWEch5EJXc2kwjzcdIRSL8Tuvr8IkXur1IqWfZwUJ8x7U8Ntizud7GgiQ8Uz35LW0pzvzY692UjxvEtw7A3P/Fw+V4NSDwJkRctC6uz5/VpH6iPhGRhuiNTFmThZ1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GTMKvZ86FQTraYCH8PzlKEfTTBMVeBe5C+g3Sjlonx4=;
 b=kMBx6lPrVhA+qZgz50gp12yKu0ML/WdgRbW+Ch1KRKAtcmNH2sLQ6fMJJCinQYLwU4GDkmEYbUAUmOHiXVKeqex4Pc7O9FgDAae9ophDS0+nPjWOLXH/dFdHqn6iw9AP0tk6mbU5uXYxe2+LGOZWWKsjjDJFTn3DEvz4SMkYIjZUVxxB8q7MEctbDOMU8qD2RCBXS0tQHIoYJzeM96RBz4AFHG25BIExxpg1nMEfug0iJ5vRTCoJdMXne9j5Iqe9v8UaNrmg9ZKfIhRKfcLIHPYqAMFRQvp7pJ2R7Xmd1u3XkG7KN44t6Nuz71HL0MUfkSDc98LfDH1fVUCbTs33VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH0PR11MB5112.namprd11.prod.outlook.com (2603:10b6:510:3b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Thu, 17 Aug
 2023 20:29:42 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0%3]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 20:29:42 +0000
Message-ID: <ddbc280a-1a53-b6ce-ea83-5b08eb1f5c6f@intel.com>
Date:   Thu, 17 Aug 2023 13:29:37 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [RFC 00/12] ARM: MPAM: add support for priority partitioning
 control
Content-Language: en-US
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     Amit Singh Tomar <amitsinght@marvell.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <fenghua.yu@intel.com>, <james.morse@arm.com>,
        <gcherian@marvell.com>, <robh@kernel.org>,
        <peternewman@google.com>, "Luck, Tony" <tony.luck@intel.com>
References: <20230815152712.1760046-1-amitsinght@marvell.com>
 <f0e10f31-8571-baf6-6665-b077af067777@intel.com>
In-Reply-To: <f0e10f31-8571-baf6-6665-b077af067777@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0134.namprd03.prod.outlook.com
 (2603:10b6:303:8c::19) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH0PR11MB5112:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c3c6816-5f80-4fde-dddc-08db9f60aff3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HwZRO7GDNnJt62zKI497wTEgVJhTghZ93qhnckQvzOJTvKDa430H2tPM43M/Vz+j8nNeJc1//lRUKMZtHxKvyf+ZrT11lxINiJ4jloEdBl+6J50308f2Zxz2mqO4GKwwI5eqafpnjKtW3D0KYqrZgOh7tdjqGbg2j8vLspIGvF9o8NA2ElmkxFVRNxpD4GNdQRs0VHxhFOa/AL2/wFagS357PaN6Z+qxAP+Y+bhnMpnpFQBtsXxhrS4Q4hukqd+S0PNLlqgQ9XJaKpZ2SnzicIbAbvA5HygCHwzexRk1e993VHDofpw7F2hAZI7qXRy2LrXefw7sgVVcfB7CEJxcAAX8YHeHv6CmmqvsAQ97YU027jfu6B0giuf08Hfo6XhImN6DUt95udW5aGHSoPV4hiE2OJ/kCMqicOka9F5JBYRVcIQr9xCDIqyMrU1xueJIsCRK2QvvnfdLZPctfgrJzkK65HnUMfyE1IehF3AWJq0NSy94K5hz9pGodFZ/ehOY6zC9mRZQcI/tWLl3O+uPKow58MHbeTYVB+tXzPVBur/AdOWHs6cHDVbLezKkgnyi0CxbW1qwacug9QH7wPFfwJ0SDQ63RsKzzamDZE1ZK9kun4+6BbEo90kRkcWkLKvZdPLOsuUilQp9W3UN0lfnHA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(376002)(39860400002)(366004)(451199024)(1800799009)(186009)(31686004)(36756003)(86362001)(31696002)(38100700002)(82960400001)(478600001)(2616005)(5660300002)(44832011)(107886003)(66556008)(66476007)(6666004)(53546011)(316002)(6506007)(6486002)(66946007)(6512007)(26005)(41300700001)(4326008)(8936002)(8676002)(2906002)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGZ1RVpuNjVTUkFIa1JESGJ0K3JPUVBHQWFlWHVUenJtRER5c1lVc2JpYmxu?=
 =?utf-8?B?cWxONmlZMkUrVWViZEk4VlYwdXl5M3JJejloNG5nNEFZamRMWXp4eXRqTDJo?=
 =?utf-8?B?V1VDMFJjVnYrUS9vOVlxcUU4bW93TXdRbHpBbUZVWlorZ08vZTZNVzFuVloy?=
 =?utf-8?B?SDd2M0FERHZhVWkyZHRCYlQvUlZhaHZxYTR1UDltbkV2YVFUbDcyaW9WL3RJ?=
 =?utf-8?B?KzNFTzZnZ2tDckNUMGZuMkRsNlE0Ync4WWlyRktvSVo2aEkvVnJZU0IzZXdC?=
 =?utf-8?B?aWYyZ0h6OVJ6SDlQVkloV1A2V3Y1L3Q1aDhIL1Z5K2RZcFNvQTVuRU5QUXlq?=
 =?utf-8?B?cElTMmR1TE9PazkrU2NYR0Nsc2dHZGs3cXNwTXhqajluVzNsZXZDTjJMamY2?=
 =?utf-8?B?SG5MdHQrQnVyc0x5aG01RHQ5bEZtT2ovRWp1UDdFNUxaOWdhTzI0Mk1acFlU?=
 =?utf-8?B?MTZjdmtJNXFRaWtsR0FkVW5yNXFzdjJSSUNEWXJBR3RMaS81VGRyb0tJQW1i?=
 =?utf-8?B?eXVORnllMUJ0cTY1SmZURW9zaUlJdWJ2VC9nVENGVGpLRzNHT0tDWndGOUxU?=
 =?utf-8?B?MjA1b2FWdXZwb0RLTjA2UDZnQ2dPeE96bjNPZFA0QnMwRmJwY1BkeU9HcWxt?=
 =?utf-8?B?NHdUVVZXUmFmRy9jN3lJNlFEN1dWY3I4ZElQbEQrd2U4VEdoK0JlY2JWUWpq?=
 =?utf-8?B?NTNpVWZFTWJaTm42Z1kwYzFiOHFRL2d1dHNrSTFhcUNiWHdOU2RHNlJxem9s?=
 =?utf-8?B?MTJPWUpGeHpEOUVtQUhQSVlhUDFWTWR4TzNzWDlwZGtEZGMxaWlvTHc5WFMw?=
 =?utf-8?B?WkhFR1JvM2c4YS96Q3dPK1VCUlNZTUkraU9pUUdPdTlEeW5OdWNFUFAwY243?=
 =?utf-8?B?UHBRY0hNV0NMRkRLbkRsS0RSdXUyaDFqMjl5UGFnS2tDbFY2ZlYyNmJYNHhC?=
 =?utf-8?B?SkNPZDY5YUZDL0FsaVlJVWU2TFpmbC8wMEphNVR2Z0Vob3A1NlBpZUwyYXox?=
 =?utf-8?B?Y2pkdUpkdzJGdVJVSkExbnZHRFNBM1VmUFR5MW43dkdMQTlWNzViU0ZaTHNQ?=
 =?utf-8?B?OU90U2pkZmZ3ZEluTlUzZE9sUWhoTCtFOUFFaTAvWm1JaEFVbXVKbjhFdTRI?=
 =?utf-8?B?ckNldzd2ZXN2SU5iNVdpeDhFZEpaSDZFNHRRNnptK0dhZlJ0WGFNZ01YRFlw?=
 =?utf-8?B?dE5QQ09IYmlNVjBrVmIzSklHMUl4N2JuRVVuVnNXc3QxU3NQRG9LSVpKMDM1?=
 =?utf-8?B?ZVRmM0Fqd1dmaDZlWDE1MzFHUUtIZXRCRGR6ejY5ZTQ1bm5BU1U3ekFmZUw5?=
 =?utf-8?B?aVNrYlpub2VWU3cwTEJJT3RkME1tMW9jWWFlN3UrQnE3cTAwQXVodGN2c2xT?=
 =?utf-8?B?U3VveGxvQkN4bjc4ajVZK2Y5YVF1SkIvZVFXTHNLMHdPbitIbzBYdkI5Y0RO?=
 =?utf-8?B?bGpJNzlEaDRXTzRuU0pIeFNnWkJCUzlaYXpSWjhLM0hwSEtlV2JIRjhFdUln?=
 =?utf-8?B?WmNGK1pRd2NZYkhoakNTODFoYXFIVm40UXRiTjNBcVRWWmMrNDl4RkNhakhp?=
 =?utf-8?B?MFZKSk15YzF4MWExWC8yMVMxdGF3dHF1UDhpZzNNZWhYNW9ucUpnSGJ0UEJP?=
 =?utf-8?B?VURpdllvbzhDNnJ6eWdra2ZZRi9hTXNGZjkwU2JySlJoMExQMi9melZFU2k3?=
 =?utf-8?B?U3lWTTJtRFVPbEwxb0pXRElxemVldThTbE4zTlRFVzJxblNFSXdYSUxRL0xL?=
 =?utf-8?B?NXJEM0pvSkZ2Nm9MZUxnMzNUSG9PVFVvcWpoVWxTZ21WcUU2dFp3TVZFYzdF?=
 =?utf-8?B?OE00QWNLYzN3R1EyY1dWUnFXT1ltUUhDVjZDNVFLWjErUHhKU1RuTVNCWG1v?=
 =?utf-8?B?emtIVWZlVmEvaXZ0b05mK1VwekdEazRuM0ltZ0VkRTN1UmlKUW9mUi84Sk10?=
 =?utf-8?B?QXpwWGQybTE5OE93cEJsUHZzNEFiL1VKVWd0SVdnSDNvK3lmdWV6VXhaUDlK?=
 =?utf-8?B?cTFGWkFJakNxendJYnd4b29vdHZaMXhEbnVYZlhpYkRwN3JNd0lSa0xXRUJs?=
 =?utf-8?B?M3hJTzVxZjhlS3FVL0NHbVV3c0p0MXhWZ0pKZW5Xb0daYnc5VjlJRW5pRHZC?=
 =?utf-8?B?MW5GY2NZVmRWbjJyTW5QVjMrYkovNnd6REdyWHNGbVpWNE85UXM0dFZ2QnNW?=
 =?utf-8?B?Z3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c3c6816-5f80-4fde-dddc-08db9f60aff3
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 20:29:42.2407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iEgizRQUTzjiRr1+L8aZzOdZ/jdD1K7NlUB0NiD5p6vDVXUtDBAwno94lWYEC1ekDJCdPMMKaxn8qLUm9RLOUDli5L2Of9ZiyfiCl9Z4CL0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5112
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Amit,

On 8/17/2023 12:11 PM, Reinette Chatre wrote:
> On 8/15/2023 8:27 AM, Amit Singh Tomar wrote:

>>
>> Within the DDR QoS traffic class.
>>
>> 0--5 ----> Low priority value
>> 6-10 ----> Medium priority value
>> 11-15 ----> High priority value
>>
>> Benchmark[4] used is multichase.
>>
>> Two partition P1 and P2:
>>
>> Partition P1:
>> -------------
>> Assigned core 0
>> 100% BW assignment
>>
>> Partition P2:
>> -------------
>> Assigned cores 1-79
>> 100% BW assignment
>>
>> Test Script:
>> -----------
>> mkdir p1
>> cd p1
>> echo 1 > cpus
>> echo L3:1=8000,5 > schemata   ##### DSPRI set as 5 (lpr)
>> echo "MB:0=100" > schemata

I peeked at the next commit and I am missing something. 

It looks like indeed resource instances need to
support different controls, so that seems to answer my earlier
question. How to let user know what is supported where
remains an open, now with understanding that the information
is required to be per resource instance.

The first commit mentions that #0 has the Priority
partitioning feature but in these examples the schemata
of #1 is updated to modify the priority. Also, if I
understand correctly CPOR and priority partitioning
are mutually exclusive so I find it confusing to
see a bitmap and a priority written to a single resource.


Reinette
