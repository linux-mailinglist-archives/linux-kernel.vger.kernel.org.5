Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA8A78CD66
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 22:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238330AbjH2UNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 16:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240489AbjH2UNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 16:13:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D87139;
        Tue, 29 Aug 2023 13:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693339992; x=1724875992;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gMpjh4Lidl0TyXJDgBtLNFn74PHVParQsngM/fneWCo=;
  b=ZmjLJ5nSD57zaXFHrKV37O1gPqX5Wkji6BcJgDhQr5/oATbf8wGt4hCW
   Uj8NxW49ReeLyZ8TJQrKR9df4lEyrr1nkk+H336HG8ogKci1TarxsPTpk
   OdKwvErgHzuNdXcjk/JIv5brBAa92524Q//J/IZL+aJ8tMLkFRgjRyGMy
   HdXeW0GkM39QPPYjelNK+VcFbapF3Tu0lMlc+AYgK7LLE11wFVfqKNJMy
   2AFg/+/diKEL8T4I4NErET7IiW/byX2o+frHJyhWQzObHlMWixJ0rwSX5
   atKhOVgQRCwm+ejHLcU9d3tAVUoRT3kkmnmEwEwWo9Jb0xMzKAYYR6qrI
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="461843492"
X-IronPort-AV: E=Sophos;i="6.02,211,1688454000"; 
   d="scan'208";a="461843492"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 13:12:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="853422404"
X-IronPort-AV: E=Sophos;i="6.02,211,1688454000"; 
   d="scan'208";a="853422404"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga002.fm.intel.com with ESMTP; 29 Aug 2023 13:12:30 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 29 Aug 2023 13:12:29 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 29 Aug 2023 13:12:29 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 29 Aug 2023 13:12:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mw20OBFUUGBn5iFHNwqY0tchlUbRZSIbvAqpO4FwG/2uBScGTLOT5k0k6rKAmnfoET/5OaDWhpOKCaIB9IAq1PrLKan9Skwf+Eqo0elvTtAHFs1zQIEDWdyflIB0MgWTqbA/k//Z0UORWFzqT/3tzKYurldJ8kpdc81MM+g8klpFJR8t/QqDWsnaG7epam4txzjmQ0rBOSE6QP/YrvzmRgKO+XMkZQDuTo/ZKElQCFKOZF53Wf12OOIgl57idwYHfWA97sg2yr4TQwsw315lfAarwDjqFtKWok0f2ByRoFWdV0p2ujhHX0Ag6EFZmUzzwBnNp4NdLzXtl3bpnC3R7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kwUlAwnyIvVGtyC39MfZWQrMTGcqX+EOKEr88nLLng4=;
 b=ckcCHM0nQ9v2w+AsA1bZhzubnTqz1T2wbj6ZHeD2kzJ+5LO9hhM9wYcHhAPeYpb9fZckqcTFnXibxyKq09C5MXf3hmME21TCwaGPi8T2aIs4ab5bHoy4bkhGK3iHry6UqajEbOh4GYYhf5il5209WZ91itNII19zD2gr6zBTKC6vMDRPx7IFz4wTi21z6mevnfVwivWZ4iTz2gM/RVpfetZ+rs6JqoXp8hdRu0tahZ2UAOqU7+YhTTPBY539vXiwYbZK7jlOeDwGJ1mrPnbaVWNdOq3yBT1xs88CrJ+U733dwIYprmVDGSNwx7ct22jeihIqLRYxc3eI1+TjLr/Rhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB7002.namprd11.prod.outlook.com (2603:10b6:510:209::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.18; Tue, 29 Aug
 2023 20:12:24 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0%3]) with mapi id 15.20.6699.034; Tue, 29 Aug 2023
 20:12:23 +0000
Message-ID: <c2372a14-0de5-f1fe-bf2b-66272b960e2b@intel.com>
Date:   Tue, 29 Aug 2023 13:12:18 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH v8 7/8] x86/resctrl: Introduce "-o debug" mount option
Content-Language: en-US
To:     Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <fenghua.yu@intel.com>, <dave.hansen@linux.intel.com>,
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
References: <20230821233048.434531-1-babu.moger@amd.com>
 <20230821233048.434531-8-babu.moger@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230821233048.434531-8-babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0377.namprd04.prod.outlook.com
 (2603:10b6:303:81::22) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB7002:EE_
X-MS-Office365-Filtering-Correlation-Id: c01e0f96-e21a-4317-41d4-08dba8cc41cf
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dUBcimTDjNYWlR7g+xURGQ2pKLdcxe1kOkqWJ4ncH42Z5MrUII3S6ZiV6QI7uBRPXfMJj6ahoVNDflRz1e7AWDp8BVzS52/e5o0IV2Egh2ySAQahMyz07Ws0CfZsrLDT+yAgblFlsIsYSt9DubgXclk6UCKtIfPyVznuTAHWZjR3bQDWlm2NoybyZ7NOzWgjqPQTQWrln/GcGdzgx8SuRvWNIAloRqTr22lT9FNSUuPc7O2MKol5tMXEeLgv7YvRKPkuWZBCou73Uh9FM/RexC5ylQNwZ0o0dYBZRH3iohjyraZeM2qeXZFLCWnxjReMQZ7oNag58OMJ7mAJDVgq0MuLBvy1eKwkMzp3YrfVvB1Ea2tyxSfPRG7d+4/R+p4vYY1ZlBihRrjjSH5mfrtH7N2t7UJIcCZfFcsLMVyDy2cNPB6cCsgqwLgYKtv3qFvu1hDkvTrBCcFlEc++WRL57m1Z4OPHKnFqBxw8THdTOakaX3+0YUMzG+nyLerVoU+HVYIZNHG+kLzwe5MBm6FuyuzWb3A1V+iSR7gbMeKHyuqQxgwQCy5X3YuBysrMOaP8P7Kt8IRyrHML4BX8JgsL/7fU0Qf3YniRCzxlmNbOB6ILGR9RHlQ8wjWxCsM8A+ChMWDKpGQMvpRqgL1tLrxt4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(136003)(366004)(39860400002)(1800799009)(186009)(451199024)(8936002)(6666004)(53546011)(478600001)(31686004)(6506007)(66556008)(66946007)(66476007)(6486002)(316002)(38100700002)(41300700001)(82960400001)(6512007)(36756003)(26005)(44832011)(8676002)(5660300002)(2906002)(31696002)(2616005)(86362001)(4744005)(7416002)(7406005)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXhCQ0l2RVl2T2FMNGE0YmJ4SEVQWFZCVVRXRUN0UTBsL3pxWm1jMm0wNjZy?=
 =?utf-8?B?ZlovT1N2cTI3aHhsY0VHU0hEbWJONjZFMHlyVmdLS1RKb0Z6Rjg1V0VKbXVy?=
 =?utf-8?B?Wm1NUlhtWTQ3WitRejdEdlNiRGlMQ2lyQmNkTFhNdGNDeXI2ZW5rMUdnZHdI?=
 =?utf-8?B?d2E4b0loV1hwSGRqVTBLakpQTDVDdG9mblhQS2NpVWc2d1drMm50VzZDKzRE?=
 =?utf-8?B?V0lMUi9lbHlOUDBlQWVlQVJINlJPbkwzQ2JvSnlZM3R0djRkQ2tJdVBrRk1k?=
 =?utf-8?B?NGJ2SDl6TTMvZmwyMTcrL0hheEtYcTduV25XVytFQzllTVVtTU9RbWNwcjBn?=
 =?utf-8?B?enlDOTdESzRHZUpDMzFhRTczMThIQVpjME5QaWpWWjhKMFhRM25MMUpsMDBr?=
 =?utf-8?B?clFJbXNqSmRBRVk1NE9HSDVoeHhTaTN0N1ovcU9QQWYwYjFiR3FJRlFyZkpL?=
 =?utf-8?B?eWIwdUdqU0VkdXY3cERJQU9iaWxNWmdtdUpmSm41ZzFvWE1NUDlQOSt6c05s?=
 =?utf-8?B?bDROTjJIaGhKb2FXb2dIVjllOGR4NXR5UlIwM29WLzJUNnFnbDQ5NXpoMUZn?=
 =?utf-8?B?cXhCQk01QWdERUxGUlhaczZEWXFQNUU2SGNIOGlFeDVnbW56c21JK3VNc29H?=
 =?utf-8?B?ZlRIWUZGSnN5aStxeHFoODFySjcxQktseXIxU3c3K3dBOUFtN2M1c1FjbWgx?=
 =?utf-8?B?VHJISWVyUDlZTnRiSmZ1N2ppK1BVN1d1NUZId0VCVmpLTXFYTExBeG1Dbndt?=
 =?utf-8?B?dWR4ZlBUc3B6L2pHUTRJcW02QlVKUUoyTEtxcXZzQ245TGttcm5uSE5HMkdB?=
 =?utf-8?B?ODl5SDRLQTRjK3lXcGtmRVRMdUtqUUhLQW5JZkdFK0c2c1p6VGZZZlRIWDZI?=
 =?utf-8?B?N0F2cGU5WlF2V1Y1cnVxNWV5STNYSjc5bGtnVjJwT2szSWJ6bnF6c1gra1dD?=
 =?utf-8?B?SFFqVWQ1ckRORUlaaW9YSFZycWt5TVZ1WE1BMHI2S0lYajQ5Q2o0RXhKZC93?=
 =?utf-8?B?SzJ3VHVOZ01tc3RTckZsNStRdmF5TjM3TjM3emxhUnBpYWdWVmJvcC9sdUZW?=
 =?utf-8?B?S2VaVFBleml0cWtlVGJ3ZEFocGNIT0hpRHJHSm13cFhJMnVtUHRRaDFaS3JZ?=
 =?utf-8?B?eWZqSmE4RFJlellKWHZyNG1SMjg3YzVCSnVYRmdjWHYrUlF1YTdRWHY5UVFq?=
 =?utf-8?B?elZ1ZFJZbExuVFIwMlJmeE5Wc05BMGw1Wlh6bGVTRWFJRU1SQUNDQVBhRFJB?=
 =?utf-8?B?Z2J5QXpWaktNTDZPazBMSUlnTHpHNWNoYi9UNkZRajErTmN3U3JkSXYvaU5C?=
 =?utf-8?B?M0hGaGx2S2xrcTI1QTdSYlRrU1hzc2JCazhQaGxwYzY2VkdETktGbXNYNUlV?=
 =?utf-8?B?ZkZNWDN6RlJCOERpNlVSWUpKd2VmTUd6MldRbnJ6L0dZSlJBRG12YUJoVkQr?=
 =?utf-8?B?WEVHMDVqODArOHBPaHJGWWIrYmRpeGVRZUFSaHVjb0JQS0FKSW5kajhPbTVi?=
 =?utf-8?B?dGdxM0p2NERaOU1uTTkyMW1TRDFDNXlSZXlhMTM2MHRZeCtWQ1pOK0tMWFZB?=
 =?utf-8?B?MThsY3psZEtiYTFFa0xvL2NxWHhuYm9qRElxRWhFRmQxYjdDakk1Q1RESWsy?=
 =?utf-8?B?NnE5dmtQNjFiTlV1NUdnZHUvY0VaWi90ZGgzYUExeVhHNkg4MWtnNGVoVzNl?=
 =?utf-8?B?cEs5bWZQM2tHYUorMDJ2QUdVRFExOXl4TzRsN0xMMkd3QTlaQ3o3akQwcnMy?=
 =?utf-8?B?ZFBkSTk0RWNnbU9OdS9rTVQ2Zk13OWt4YU9zWDRGcDFIeHpRTmlVVUFwWXJN?=
 =?utf-8?B?RCt4Rkh1emxSRDgyMlJicG5Ga21JUVRKU0FweDJuN09wMzY1T1NtcHBkVzhG?=
 =?utf-8?B?clE5U2J5N1h1MlY5UUU0QzVGK1VYWFZwU0ZqRmZ3MkI2UmxrT0JZNHVZeFlZ?=
 =?utf-8?B?U3RuOXVpdEoyWHhqdzhwSjllV2pPQkljdndkTmExdHhhQjgyd2hWbzZwQmlD?=
 =?utf-8?B?Y3BQN0NvZjRlaUFZV2pnQmNiVTJLR2lzNnU3S1UxR1RZVFNTMHJGOUJpRW9G?=
 =?utf-8?B?K2pWKzk4S1RBdVFCYW1SRUlaTXJKR0ZxRHMycFFoSXpmSS9OT3FYLzNMYlhN?=
 =?utf-8?B?Sm00RmRzamNIMnl5RVkzR0xLWkZSOHlycDkwSTc3eVJVR3ErK3FqUVg2cERr?=
 =?utf-8?B?UFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c01e0f96-e21a-4317-41d4-08dba8cc41cf
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 20:12:23.6127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RaDurm2QBqKLKguH/wKFVNWgDROBDBDBrpoDk/mYuOHRuueF7Bg/+BQH+1dAJIhXOYb1/hkkm1SvGCM2Op/oiRI68B0WptWDWgxP14OZes0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7002
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 8/21/2023 4:30 PM, Babu Moger wrote:
> Add "-o debug" option to mount resctrl filesystem in debug mode. This
> option is used for adding extra files to help resctrl debugging.
> 

I think it would help to highlight the new RFTYPE_DEBUG flag.

	Add "-o debug" option to mount resctrl filesystem in debug mode.
	When in debug mode resctrl displays files that have the new
	RFTYPE_DEBUG flag to help resctrl debugging.

Feel free to improve.

> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
