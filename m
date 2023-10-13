Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAB987C8BE6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 19:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjJMRAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 13:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjJMRAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 13:00:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888EABB;
        Fri, 13 Oct 2023 10:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697216448; x=1728752448;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eD0we1NQ42J/x+3AYJe9RteN+Ved9lsxMsG1gSQSf6I=;
  b=dcSkxLFNlPr3WKilzY992wP6c3hFqZBFWu6jTei55ry8G93rvKPMBh2x
   vJG5Jc/ZXhQ/P4Jg8bjzAGnYja2dwdP1ljUb1lgIFfWLXfmsRewqPwetQ
   orpkaTWBOkPdqm2UjYT4qQFlvSBmifqmNjkc+gB70WSSERl6/FJDGOfvn
   NwI0SJ9qtpbxepIT6qprbxrp2mIFBj1c2DXKLdwKzub9mh0TdSCX4SE9Q
   tJsf8n+hQzyNICOS1moA0X6lrb6uvYtqxBllWVzO/UuPnlGD8YLGd7amT
   aCPHkTx6RfL9k6S7h+JXPtkoUT62t48kGHLXyMWlBFcArbTi3xWy606of
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="388071364"
X-IronPort-AV: E=Sophos;i="6.03,222,1694761200"; 
   d="scan'208";a="388071364"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 10:00:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="754762839"
X-IronPort-AV: E=Sophos;i="6.03,222,1694761200"; 
   d="scan'208";a="754762839"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Oct 2023 10:00:46 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 13 Oct 2023 10:00:47 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 13 Oct 2023 10:00:47 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 13 Oct 2023 10:00:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IOCuLpQ6vd59Cx3okg7bmO3HQrS1oKjJvDF52DJsAC+fZwWIPMNYCFx/NdkeqH5e+h/E3xJtsqPr//iOjatr0rIt++HxxeH+g3eF1UnE1P2d15MVvWo2gnT+DxHtpQvyQkEBMi30SHMz4I2Ng0L1q1/30qsfh0eFIWXOxP1AwXLNR3m3gmgEN8nPjG8t+t2/4py49oXUBFNLF8GOjmrsxihfPV65yVTYfxbk0KMR2SbxhexGLpB8t2s1XUly3FCjrvlFSvWxbNwE29Okh4mXdux3NCYF/u+0Z4NFnISnonHa08zGavnRbGHVReEfSOuXzSll0qkFx82HTO3e252IIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KTZGrDV8FTKoZOp0FGNBqDF/w/fnmqqbIzCSWVgG/6g=;
 b=GwXLrJV2jc4OsFdxsuUKeY+69SL+7cICEcsyz1MXZ6ppeGg1cepwlWiu0+kZ7fJO6Ew5UloOH+CSZnkTT1ZuGJFrHsXhlbCjFBiXS7QYkb7amLixfS/e2Abf+WimOQQpUE+Ben+C/fZD4eX+FYRWz85un2zEJbJats/4I2qS/5/XvORZxxj5saKa/QDXNeK9C0u4M6SOM+/dxkNKYEwajQs6A/KASsOA4eSZPaUiukvoeD3fTAC4QGeB3X+ifYPRLL06/wqusDV/FyyxBPVdM4MzVOI3h9bz7vDBoOBLKCu/ei9ylACjNHs/Tm0YDIFMW+tw7z9XI0+4460lSWNVzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5603.namprd11.prod.outlook.com (2603:10b6:5:35c::12)
 by IA1PR11MB7365.namprd11.prod.outlook.com (2603:10b6:208:423::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Fri, 13 Oct
 2023 17:00:44 +0000
Received: from CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::dbe4:218c:1bdd:510]) by CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::dbe4:218c:1bdd:510%4]) with mapi id 15.20.6863.046; Fri, 13 Oct 2023
 17:00:44 +0000
Message-ID: <f7441bb4-c2c9-4eee-9fed-ad8b28de4788@intel.com>
Date:   Fri, 13 Oct 2023 19:00:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ACPI: NFIT: Fix local use of devm_*()
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>, <nvdimm@lists.linux.dev>,
        <linux-acpi@vger.kernel.org>
CC:     <rafael@kernel.org>, <vishal.l.verma@intel.com>, <lenb@kernel.org>,
        <dave.jiang@intel.com>, <ira.weiny@intel.com>,
        <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20231013085722.3031537-1-michal.wilczynski@intel.com>
 <6529727e18964_f879294ea@dwillia2-mobl3.amr.corp.intel.com.notmuch>
From:   "Wilczynski, Michal" <michal.wilczynski@intel.com>
In-Reply-To: <6529727e18964_f879294ea@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0159.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::19) To CO6PR11MB5603.namprd11.prod.outlook.com
 (2603:10b6:5:35c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5603:EE_|IA1PR11MB7365:EE_
X-MS-Office365-Filtering-Correlation-Id: f584e2b6-7e7d-4334-d535-08dbcc0df096
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Auis/pnisKkip0EDRswAiGAEcJ4wQuFnqP3LkJrtBTZstfS52Dm3c47nZMFWa0EBjRZrFfzTlr86xAev6ZEfWZUYlrE3ydNtTXm5PbTWe0bE3oEJBtjjw6r5o3sdB+3FN5gCvsE2WI10dnmjWXf7cs3LY0nlPvSlnhsC0b5TpPm09qH7EBjY7v062807VwgrRO8Ai66zcxiJg4ML6POSBhRRYdbFAScdXTvO0UOrO1O1iAvG8eFAUhJAt1cSjSKuV5R5kEIeuPQ9KxVGgAzcmzNf8BLksg4VQhj7J38BiDu9i+pFM6M06wv1Vymt5jDCN6u/KFybbygiiTTX6OqXZNhbaLg1tX80dDnYRdDDBI+NtAhqHhS93ph1vpKAvohGjNtOmkSfBPOrlQEaQh0k0MCeyztzLDdOwKpeLQwX6T1DIQ/IqCntk3CsOYNmrZQxC3AaGCG25Tbf+mlYexEUe5ce8aB6P+qslwXb4l/ZDiBESTpGYlFp6YxFwAbOylvinfSqcDvbAgaTxqR+zz8pK7cXHzXoxCJfAYeV/HGVlwqZ547NQ0R7HFSfuQFmDyINYuMXgcZWJM5yC/0xUeJ5Wg3jFyh4kkG8q5HhOIfkc8X3WMQgUMzSjgzvikOgCxyYfWOwoogl+LLrY6/xiRGpfw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(366004)(136003)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(2906002)(36756003)(316002)(41300700001)(66476007)(66556008)(66946007)(5660300002)(4326008)(8676002)(8936002)(38100700002)(53546011)(86362001)(2616005)(26005)(31696002)(478600001)(31686004)(82960400001)(6486002)(83380400001)(6506007)(6666004)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N09PVFdvNXBsME9hSjJhM0JQRFBZUjByS1NrOU9wcThyWk9IQWhFdnMxNERK?=
 =?utf-8?B?enVUVGRTVXhzRXNlMVdPcmMrcC9JV3ROaVY1Y0F4V2JxaEpjRWsydStQcms3?=
 =?utf-8?B?MEhzZXczSDRwd1RrWXVaRms2UVNvZVBsQ1NTWll1dStoVy92ZjJtSldTOU5C?=
 =?utf-8?B?SUlIODdTOWVPaWczeXZOYWZhZ2xlYkp2V2VJdWlvekdlbnZMRUJyV0VNM0sy?=
 =?utf-8?B?Qnk0K1JadGxqVUZhQzJPUjVGSDlFbzRXcS9MbFlHc2k1M1kzMWtaNmQ1Rnpr?=
 =?utf-8?B?RzdQbjRkYW1KdFFMSVdjY0xCRG9nVUtBZWVQVGJHZXJxaVhVbE1uVHZZNnp0?=
 =?utf-8?B?RS8zMldrN0dJUWErY1pSNEZoNkxBb0Q4NzVjZ2hkaEVnS0VXZGRmVk9qSE9T?=
 =?utf-8?B?bHQ4cTVrMjRyQ3NIQXNGQXFmVFZxR3ArZ0NSK2hqRVFoMlRVZmZwZnpCQTJS?=
 =?utf-8?B?SzIzSktVcjNUeGdaVUdEMXg4MzZWNmVUWlhaMGRpNnRkTTlDMzBXN0hXcnpJ?=
 =?utf-8?B?RmxFdWpJQXhiUGRpeDU5VXA4WjRhWFUyd2ZvVDRsSDh4c0ZCbTVLbnhvTVJt?=
 =?utf-8?B?Qm1ZSFlXR1lrUi96Z1dNaFlvRWJWUTFncjE5Y0JqQ0JWWWZDTXc4SFZieHp0?=
 =?utf-8?B?TktHdm1FZkd2SndmOUdzWnZwNGF0emZzbk9BaERlVWFDQkcwNUdBcDBlYlRq?=
 =?utf-8?B?ZHB0WmNxdzNoRVQ3RlNmdlRzNnUxejkrRGxVZnpMaitlQXNhNXV6NUl3cEZZ?=
 =?utf-8?B?cmh5U0IvT2owS243OUJOREt5ZHROVGFWUHAzVjBOVGpWY2UxWDBqaFVvQ2sz?=
 =?utf-8?B?WHcxM0tNZXo0ZmNjM0FrdUFHc3RWK2VnUXJVNGt3bjBlNFhtT0djM0VZMnNO?=
 =?utf-8?B?ekRBV1dTTjhkdlJnZjd1RWFyTU9xOVlSOXJtWVd6Vy95aU1FQmgvOEFGZ1c5?=
 =?utf-8?B?TzU1QTJEQWs5bkRKSHRmUnNxZDRsOEYxQ2NnWmtzdy8vZDFrQzVQOUlzWmd6?=
 =?utf-8?B?U3B3V3pTMDErNXNGS2R2eml5NHAvYmF6VFN5VHN0bmtyNVpXTHA3cGZxMXRS?=
 =?utf-8?B?aDAvUVYyZWJRbC9FVXJnVTlidFN3dkxyTUYwUk9GZGNEd2Z6d1BUTEkxOGFP?=
 =?utf-8?B?Wk05T0cvcURkbjJVZ2lkdXEvN2FHcXBlVEV0cC9ocWhOZ1lrTFNEYU9pL2dO?=
 =?utf-8?B?c2RGOWgyS3B4UWxGeGhUV29DR0NBTktBaUN5UTljbSswTTRTc0VqWWNXUGlE?=
 =?utf-8?B?R21TWDYrMndKUWw0N0VvUEJQUnVXcDVHUmg5QUFoWEh3T2JTbTZYUXJyckVr?=
 =?utf-8?B?aUdoZThpWjQxalNVUjBEaWI3OWNqMlBSVW1zR0pxMXVNemZLWnA2ODdhY1RJ?=
 =?utf-8?B?QjhUMkhtMnRBOUJkSWZSMnBoa2dwNWthdWJuK0NiMWg4THgrMFdWaVI0ZFhD?=
 =?utf-8?B?U0tPZ2NaYVFxZ25oalU4ZGk4OXppM3dtUnlFcnZHUXlQMEJVWEZGUWVzRGN4?=
 =?utf-8?B?V0JGQVpkMk9vTVU2WkJ6aVNTMXR6djc0V21wSmJrUkROcnEvdUNVL3ZoSEph?=
 =?utf-8?B?eU5VUTlIZXJhQ0Q4clVNYnNMTzBDcVJHM2tmZWZ5dERSMW5EZ0VWcUhLa2Vt?=
 =?utf-8?B?d1ZMUDRESXFxbjVWNUxjYWJzeXQyV3AxbmExRVNmV21zaks4L1FlYXRIUzU5?=
 =?utf-8?B?MkJVeEFJVjNCWEZkd2xWZUtzaHNBMlFTMXpnOGQ1Y2lnU293bVRORkpKZWto?=
 =?utf-8?B?RkFGZ0Y2NHlGdkh1RFg1KzJoTEd3NmE5cGhLb1BGRUlncHQwVUpJYXZ6MndR?=
 =?utf-8?B?UlJEZkR2cURSbnVFUjZRQ0dwaFIvek1FVFZncGRrWTgyS1JHN0xZd2ZqYVQ0?=
 =?utf-8?B?VlNTY3pTTDdsR21weXYvMzZMempQVDR2U25sYVNLc3oxY3FCYmhkVFZRV3Zj?=
 =?utf-8?B?UTd4WUJoajFra0dLN1VxUjl3dGNDNjRnWVBkSFpPRFlJVE5FMHQ0MDJDem13?=
 =?utf-8?B?TzU1OGx1QTdHQjJLZDlXYmI2cTlLVk11TmY3eUMwS2JhSjhqWE5nNnU3TnRR?=
 =?utf-8?B?OXRLUFBrN2E2VzBQVktXMWUxWjEvVmdpM25vMEpnVmF1RzNFRnMzRzhTMWlX?=
 =?utf-8?B?SVhmZ2xqWDFpbSs4K0pDWEhtcUhwZzBvc0lkU0tEVWs1cGFpaWc1cjkrYWZn?=
 =?utf-8?B?N1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f584e2b6-7e7d-4334-d535-08dbcc0df096
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 17:00:44.8430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tg39R9NBy4Nk6rO+HP4mJeeLRac4PJiyLZbPp2QV84ly5d2n0+E9QMxx/0pF3+DLij7BH9sbVvbO7bZRj+QSVlMoz/dqMZoowVmP4BLJwo0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7365
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/13/2023 6:38 PM, Dan Williams wrote:
> Michal Wilczynski wrote:
>> devm_*() family of functions purpose is managing memory attached to a
>> device. So in general it should only be used for allocations that should
>> last for the whole lifecycle of the device. 
> No, this assertion is not accurate, if it were strictly true then
> devm_kfree() should be deleted. This patch is only a cleanup to switch
> the automatic cleanup pattern from devm to the new cleanup.h helpers.

The memory in question is only used locally in a function, so there is no reason
to use devm_*() family of functions. I think devm_kfree() is more for special
cases where the memory is meant to be used for the whole lifecycle of device,
but some special case occurs and it's not and it needs to be freed.

This is an incorrect API usage. Would you propose to change all memory
allocations currently being done to devm_*() family simply because devm_kfree()
exists ? Why introduce extra overhead if you don't have to ?

>
> I am all for modernizing code over time, but patches that make
> assertions of "memory leaks" and "incorrect API usage" in code that has
> been untouched for almost a decade demand more scrutiny than what
> transpired here.

I understand that it's not necessarily a big problem, and the code works
perfectly, I can change the phrasing if you don't like it, but still the
cleanup.h helpers don't really care that much what functions they call
to allocate/free. They are meant to care about the scope - like constructor
destructor in C++ - you can call anything there.

So this commit changes 2 things:

- change family of function to allocate from
   devm_kcalloc() to kcalloc()
- use scope based mechanism to call those functions


Thanks a lot for your review !
Michał

