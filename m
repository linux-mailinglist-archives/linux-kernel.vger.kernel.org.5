Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37BF37BC0D6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 23:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233608AbjJFVBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 17:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233541AbjJFVBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 17:01:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF40BD;
        Fri,  6 Oct 2023 14:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696626088; x=1728162088;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=P8jOgNmYB86NnX2rdzdkz881jB4O3uo16F36uWci9lk=;
  b=MCIRgjZlVDbyKg/9ZMHD8ST19Jk3Y2ojpduO6rKmwlC4TOb5Gi9zoCEk
   LaX2gRHfsqOSvC4/hY7Bj2IBtzcSs7Tb9rx7MHKnxPMFQuRlMrLmMUWvB
   quxQEdjVAiJnkkNhwhZG0qCWjUyW8kEb1ZcW7m9Vo8r4ao5ioMc3mq6o7
   pKp0EnpuFyoLp77jPx8DHCEztcl2d2ASPpu6NLXu8W2G9UtIrQQDS/IAf
   v/jl/4VTrCwY5obOu+XUsm6eQ6ldq11RsoMfbjl4aCPcjx3422GA0XZWU
   rws0wdtTEmo0ZsVUYJs8S1smlYpF4wCCptcqpQL7k7ANhaIMNHcWsTDQ9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="387710145"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="387710145"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 14:01:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="896017659"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="896017659"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Oct 2023 13:59:54 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 6 Oct 2023 14:01:26 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 6 Oct 2023 14:01:25 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 6 Oct 2023 14:01:25 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 6 Oct 2023 14:01:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UlrTBcruW6JBJQx1feiBQXvSar5cxUX2tihfW3dHC4k0YnhjDMDcMZFgsyXuSMcCLX2qDgyLk6bqeAzopW4rVvYkdXHGkaQjPpfRx1pbbRZ9tdL8aU3uo2Jt0d9Bxct7nGUxo7MD2Z6KbxSgvot98xCk4XYkfd1Yh7+ahO6FEHLHmf59ZnJsiuBQm9O3RMDqqe5V7DfTShY/5b/KTrrmM7N6Ik5jZwWHLFNx601QLHtIHDj+p/+3H2U/lQqSYjawAfyr9EwB3XsAshh9KoyR9VB/pjQa/LyGwi5Dce1qFIBo2sczWnWPpUHjO+uCRLhT81DL9Q3dyYjhQ3Auvtl1UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J/HJKPI7K5MR0uzH3/O+edqnl7Nzu3c6syJss6YFdVA=;
 b=ZEvzJcRXDByrU30amTYbAwHrsZ/IOW39GQ0NFU/2gwAu57RRO+9yIZXBd4Sa937kt/1T8j921LI3D3K3W95EDE8gOf86XcgkloXVdofYo7Bb7qpUSudfmXwWml0gZDvXJxuzt3xswDVsTbbnLJFNNYhpEyqkmQRnFExAPLK/+6T5zzu0fU/DhYKzXizFTR8104GLd/tPSMBOJRGdE9zCs+clbPC0BhcI2l5ZI5CorEawr2PFGZplyPo83TBQbX7Itw8J1kcWiJLQVYkNOgxnJSM1Rt3hP2iZVZv0VuXSui75HgCF0ri0p/FdnYKVETQqBky0Mp6uqVzvjqfLLCinmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SN7PR11MB6773.namprd11.prod.outlook.com (2603:10b6:806:266::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Fri, 6 Oct
 2023 21:01:22 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6838.033; Fri, 6 Oct 2023
 21:01:22 +0000
Message-ID: <c5700cca-1764-4094-b927-fe6f61ee101a@intel.com>
Date:   Fri, 6 Oct 2023 14:01:17 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 09/10] x86/resctrl: Add support for the files for MON
 groups only
Content-Language: en-US
To:     <babu.moger@amd.com>, <corbet@lwn.net>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>
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
References: <20231003235430.1231238-1-babu.moger@amd.com>
 <20231003235430.1231238-10-babu.moger@amd.com>
 <b08ebaf3-6fe1-4677-a4d7-2c0e530153fa@intel.com>
 <76eb259e-f2ae-b41b-9501-40c9a99e2433@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <76eb259e-f2ae-b41b-9501-40c9a99e2433@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P221CA0006.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::11) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SN7PR11MB6773:EE_
X-MS-Office365-Filtering-Correlation-Id: 1034e068-d702-4724-0b23-08dbc6af650a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2m0G0+Y+SYrrtVTz0LjyxtR34UDLfdDl1RGV+uzsAA0/HJUaw51FONoGSpWJJFefbCK6aWu5BJz/KvXEakpsf+CXf1luLCJsFYRlA6coMbqSxafesyU3F7c/egG+mjE8Ctf4982pgbwvpUNocC9Inp3NJY2h5VMc8KGxNqKdc/fwM6KUbh4tATAJ5tomjv7/gW9jMME0FzCpwy9zFnegmuUYsxFf5BfVLx+Q+TV2BolSlU2fHg8c3w5cuGyyvZVxTJlUNQEtmoB0oFg6tZPOr3WjhNe5QKqthHI/FNbwgvq6kI5Ai0w1NtjkNOuk+f3ljUoHzbK5cxJJG4fH91pdy9eQVUCWv5Ll0sgtPG4+ejXjEy4IzmcN3gvY4Gu9rar1ZTOoF5HAwFzXw9pjNU7J5FUVSjH9pOLqua3JPT0KUHnS/9hNMI53gHdUKJZ4a/0Kw2N4XjD/F4NVzauLMGj/bUNPI9BP9XWy5OO2vmfnooEX3b2p71zhuworf9qYfMDxS5TwGfAyf20zwOZ20UmhucnGZRX/8RMjqCX+HtNBuYCmeV+NHyTY7CZs4saeHeJTPQ8T0vkJEUvwTZa/JKvOMCeyvBnkIX+fV+K8BXtbcSLIN9RHOFnwgxjam5Ormbcu3JqpqRE55i/ZYOod8OMUkA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(366004)(396003)(136003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(966005)(6486002)(6506007)(6512007)(2616005)(53546011)(7416002)(4326008)(26005)(316002)(66476007)(478600001)(2906002)(66946007)(31696002)(8936002)(5660300002)(44832011)(66574015)(66556008)(7406005)(86362001)(36756003)(38100700002)(41300700001)(82960400001)(8676002)(6666004)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bi9GeWVwQzNCTlAzbytYeTcvb04yaE9RWXVaaHFJUm1GcUY1RkhVUWdtcG16?=
 =?utf-8?B?K1NUYzdQSEpHcFlyNGNJbERJdndLdW1qa1J4VTBVdm00a3dtZVgvY3d3K3k0?=
 =?utf-8?B?WGZOKzM1VHp2eDdaOFJvMTczOCsrTHA5MGM1YUIzQmY5a2dZUGI4KzVhRG1E?=
 =?utf-8?B?MDFwN0pnZ0ZUbDYvbzZPd1ZFUFQ2SThhc0VxekJBL2hHL0VrUllUV0ZkQXVn?=
 =?utf-8?B?TUxFQUEydnFXT2lQYmE0RHA5WEJGRHI1Mm1aanJxeENRMDB4YTRzd3hxRlVm?=
 =?utf-8?B?OWl3VXlPYmcxNlFTbk1GVk5hT3RFS3lDbU9BZVU3SitoakZGU3RyajlwK3BE?=
 =?utf-8?B?dk5zeHh2QjRXMW41ZG9xNmp5Tm1nTzViR0g4bWhwL3VPTDNsdFYyWktyTUdS?=
 =?utf-8?B?RW1rMWhZMURNcTBKVEF1OGdNenNRSjA1RlpydW5OVDA0akpvTk92aS9lUWoy?=
 =?utf-8?B?OE1tL2VLMlRvdHY4RjV2UTNTYVVUVzNhdGh3eG5Oamtxa1BHOXFNMjdDa1dh?=
 =?utf-8?B?TEFDOSs0K0txcDVjbndldTUwWngzQ2dnTmtFK2M5SHpVbE95NGFnMWVVNFRv?=
 =?utf-8?B?YVY2TytTM0JNbllITjZwKzlTcjNZdVlpYlFBL0RBTVJub0pBZFNUVnJzcWFx?=
 =?utf-8?B?OHFIeEkwMHVqbHFIM2hVWnRVYmR2cEZOYmhwaGd3b2tDRFlUQkNuM3ZHVVRD?=
 =?utf-8?B?SGhRUDhyaGpOdTNuN2lEZGNtdkF6K1o0aEhvVmFYM0JpditoMlpvQlIxK1Q0?=
 =?utf-8?B?bVBPMnlYMjNvZS9sRVdEZVV5V0FBMnZheWNvcVErUjlpaCtwSUNaMkMwcUJL?=
 =?utf-8?B?Z0hnamprd3IxeGZ1dWdRZXhpbGoycU9qOU9qaWlQSk9oRUV4QTNKSjUvZExV?=
 =?utf-8?B?SnBaajZZbWZLbDEvbFBuSkdjaU1UYmdtK0xFa1ViTjdZeDAzQ1hpb1FRaEp5?=
 =?utf-8?B?ckkyZXVjMEdpbWFMVlJTbTN0Y2lNRnRXamJqK1BpS3NaNXphaEU0L3ZHNVdO?=
 =?utf-8?B?c2MzQ0l3MisxRHEwRWdjeW1uWUdMbFFTUDlCQTJRaS95R3VzYVhmWnZHQ0tH?=
 =?utf-8?B?dUlqNkVUTFhZY25vMVc4aGErNHp5RjM0dE1hT0FneUJlUkljZ0ZDQU9nYWV1?=
 =?utf-8?B?TStvME9mOGljSzJsOEJwYXJGamVCby9INnB2Rm9SRHBUbFhDTnd4S0NWeDEv?=
 =?utf-8?B?N3ZhZTJmSzFJazVsRWhqV01ndGhLaU1adFh3L2UrQkhTbXM2bjR0TUNpbkhU?=
 =?utf-8?B?WkcyL0pOY1M2dmo0OEMrMEZPS0R2ZG80WDdyL1ErWTRYYTNDdG1pMjhzS1JH?=
 =?utf-8?B?RktoejVVNkRYVWo1RURkMkZoZUdSOFF5UXUvc1ZEZEcvU1c1ZnQ0MXc1amkx?=
 =?utf-8?B?eW4rUm9jY1Z2UmdnS3V2cDVadVM4dkN2MXE2ek5MQVNCSWtXZzlQMGhRczNJ?=
 =?utf-8?B?SzMxVDFjZThBczJVczE5VDczdXR4alJpMWtwRXgrd2J5NHFsWS9zZmhyRDg0?=
 =?utf-8?B?YUVCZEVUSWNPWGM2V0dudlpNTDN0Zm1hR2ROUlFTTGk4MTJ1eWJ0U1pIc2pt?=
 =?utf-8?B?RmRsNzlIcDRSbS9WaEpTeWlUdU4zYjJkajFiRk1neGVISUZ5OHFKbmZjR1Ay?=
 =?utf-8?B?aEExODRtb0hlb0RldlNXM3ptL1ZZZlVxbHgzM1JjSzlnOVRLR2NqZURVL1V6?=
 =?utf-8?B?aENJQS8xMlVabVRDQzNFSHRZMm16cWROWVhQNHRBQW1QQ010SDV6ajh5RWdh?=
 =?utf-8?B?ZHNGd1QzTmhNN3lhZ2xMZjZzSVpQUi9mNlN3REdRQkt0UnhyUVlSWVY2ei9v?=
 =?utf-8?B?b05xV1VrQjAvQmZRMHRRdW9kYWUzTFBONVdUSk5oSWw0UmJsR0c3Z004RDE3?=
 =?utf-8?B?c1djK2dhUVNFRnNTRElVN0FzWjQzUjY3NXorM25mVlRiakVYWUpwUFNEcGJ4?=
 =?utf-8?B?UE9DdnhyTE9Xd21HdWFic3BUaGJsdGxiL25rc2FlUW5peFFGU2l3SXA0SUJt?=
 =?utf-8?B?QUtyS2tDN1hZMm56cXdCQWI4N0dXbTVVT0h4Tm9nZzdhU2VhaDhJMjAwejA2?=
 =?utf-8?B?cFJVWHByNkZiVHlXS3JCL2JzRzBFSXd1bm9GWUxGSG9OcXVaQWk5Ky9zZmtO?=
 =?utf-8?B?Sit5WmszUDNlQy96d3Y0dmVKODdyaVRuUXNwWmRhUWhoSHhBZ005b3BaTERy?=
 =?utf-8?B?YkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1034e068-d702-4724-0b23-08dbc6af650a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 21:01:22.1649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8jiNzMw+kcEc5FuVzTm+BU+IlWUz9cNfuslemH1C6rDkLNA0/AHUeB5xPO5bpUFmMKlOosfDMvujp/9ds1bRrXoak9q34VhNi8jKhx0BAKo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6773
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 10/6/2023 1:49 PM, Moger, Babu wrote:
> Hi Reinette,
> 
> On 10/6/2023 12:53 PM, Reinette Chatre wrote:
>> Hi Babu,
>>
>> On 10/3/2023 4:54 PM, Babu Moger wrote:
>>> Files unique to monitoring groups have the RFTYPE_MON flag. When a new
>>> monitoring group is created the resctrl files with flags RFTYPE_BASE
>>> (files common to all resource groups) and RFTYPE_MON (files unique to
>>> monitoring groups) are created to support interacting with the new
>>> monitoring group.
>>>
>>> A resource group can support both monitoring and control, also termed
>>> a CTRL_MON resource group. CTRL_MON groups should get both monitoring
>>> and control resctrl files but that is not the case. Only the
>>> RFTYPE_BASE and RFTYPE_CTRL files are created for CTRL_MON groups.
>>> This is not a problem because there are no monitoring specific files
>>> with the RFTYPE_MON flag associated with resource groups.
>>>
>>> A later patch introduces the first monitoring specific (RFTYPE_MON)
>>> file for resource groups. Ensure that files with the RFTYPE_MON
>>> flag are created for CTRL_MON groups.
>>>
>>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>>> Tested-by: Peter Newman <peternewman@google.com>
>>> Reviewed-by: Peter Newman <peternewman@google.com>
>>> Tested-by: Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>
>>> Reviewed-by: Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>
>>> Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
>>> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>>> ---
>> Thank you.
>>
>> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
>>
>> I believe this series is ready for inclusion. There is a conflict between
>> this series and Maciej's non-contiguous work [1] that is also ready for
>> inclusion. We could wait for outcome of next level review to determine
>> who will need to rebase. It may help to provide a snippet of the conflict
>> resolution in anticipation of Maciej's series being merged first (I will
>> propose the same to Maciej for the scenario of this work merged first).
> 
> I had a minor comment on Maciej's patch.
> 
> https://lore.kernel.org/lkml/fd2309d5-ea56-abed-5c3e-a8a038b07d9e@amd.com/

ok, thank you for reviewing that work.

> I will respond to his patch 3 with the conflict resolution.
> 
Thank you. We'll wait for next level of review to learn how best
to approach this. We do not know which series will be considered/merged
first. 

Reinette
