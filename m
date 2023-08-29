Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA71578CCE1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 21:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234709AbjH2TZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 15:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231992AbjH2TZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 15:25:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A4EEA;
        Tue, 29 Aug 2023 12:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693337119; x=1724873119;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MN/BgKaH/yR9Iaa2sBLZZJUAI0KbG379Thfda3VIN4s=;
  b=gfP03Kl7rIUaJ+YY1+4ys2rYxnckEIjmJh1nqOE+MMSPA1TPG05jZmZp
   V8wRa4DnxopEcglOqldPwO17/3AzRS0CXcNVOOsa0UNkhoxBMjpeAMfbj
   wn4cr2t8hHjuzJWgjLkEefkInGFp4OlGlNkwvod74n0eB5y5xgCPO3I64
   pqrXfdfqDSUejOmEsS0AHzsrNhO7aVj8cJzmadaMvcQJ6qJ/5fBbbBjfU
   8CtIAQdVa+JO7nMlVgzq6YUSHJdT5kHZYNl+rccIKjva2dqHZr5wIXVjl
   BwktYHNxSynk/zIo8WND8EyvUG9E/XexJLiHoCO5O+4vc1wdRVswODGpS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="365663347"
X-IronPort-AV: E=Sophos;i="6.02,211,1688454000"; 
   d="scan'208";a="365663347"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 12:25:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="853412375"
X-IronPort-AV: E=Sophos;i="6.02,211,1688454000"; 
   d="scan'208";a="853412375"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP; 29 Aug 2023 12:25:18 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 29 Aug 2023 12:25:17 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 29 Aug 2023 12:25:17 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 29 Aug 2023 12:25:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TQVj24IeZuXcpn6Ex3jXXUd4lHIii5UoPZDWZBT3hDlIGtO1+Re3fsRmDf+xtzRTBZUbE8UJaOkQC9fOaTMb1BKjcY2BQ1pzutAcGpQ6hHBRLhxmliNHcHlW3HbD06xzS0dvhwuMNn6vYXhSongfVdOD7Mg6d2DUjXHzEYWxS7baUb+z1kz/hk/Wap3YoIZz6ucYQZLI3ezGFiB2rHq11r5si90EOsaPg9HCYKBkY/zO0VNFHOUtGyx7Cdq7wzReC6dqUFHYEUnadd3vb+ICcEgsxEiTGgTyZjJauFo9BQISoup2GSHzc01Lyq/he/XRgZd27KDnPt5PgdmNqZbldQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PRGrm3Qh4osShWKw4anglvdxIsF+HNw62jDT1zm+1Qs=;
 b=HAJ1JDliZKogIQJHMPg4dvAYrw12m+2f6807FYXji/Fr2Nmh7olBwI6etNi7DtGsjJzVu3OLhRG4KoZ/9fBFBd0O5ZWv3xUwTXBYriktDC9O1hOEsWptAzsSjYOjZRUzBFez+3r5dFqnU3nvWj3GGxTkzR3NZ9noA8Mc6B3ZC/2wV3azBa9975w3TLCQ/4wVRRaief/EU3SUqnbMN4skjWfMXe5spfVw+/zny5aRiG8A1Bv7hradU84wR49kdyp6Cm1/W36gaPMlCUy7vXR7I56R3hVcpqzUsLBFuhCl7eaxY4JYEIizNfN/kTJ8N1ZTX4DSDfLpA38bwO34bU5v8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CH0PR11MB5491.namprd11.prod.outlook.com (2603:10b6:610:d6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Tue, 29 Aug
 2023 19:25:06 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::6a23:786d:65f7:ef0b]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::6a23:786d:65f7:ef0b%6]) with mapi id 15.20.6699.035; Tue, 29 Aug 2023
 19:25:06 +0000
Message-ID: <a61b7923-fc3f-c96d-ea84-0ae4fa176eac@intel.com>
Date:   Tue, 29 Aug 2023 12:25:04 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] coccinelle: semantic patch to check for potential
 struct_size calls
To:     Kees Cook <keescook@chromium.org>
CC:     Julia Lawall <Julia.Lawall@lip6.fr>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        <cocci@systeme.lip6.fr>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>
References: <20230227202428.3657443-1-jacob.e.keller@intel.com>
 <202308261813.A26FA1A@keescook>
Content-Language: en-US
From:   Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <202308261813.A26FA1A@keescook>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0330.namprd04.prod.outlook.com
 (2603:10b6:303:82::35) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CH0PR11MB5491:EE_
X-MS-Office365-Filtering-Correlation-Id: 48da7248-8697-406e-9b1d-08dba8c5a684
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IMHPdkt1C+pryjGY7RtgsuwGkc03vlIgruCSlUCL2/iG6VzddfPuCcZAfttm2roxHh5GGJS7yQu3BQv05IPQiZXsaGKgivixq4fqHyXzogxo3/pY6fhIa+7OScXG8i1Zx25VIWx18VT7EMk3za/HDphJAE9nNOOnCd1AdQhX/n4txPhxG0QG0HYjdoIsi+gvCLaVcwBI0xFa3yOBRzCef6QfaWqatN9nN6IxOgh8fLXPrlfiUr18sWCZ3qE2tm5yz8QBYy+9EW8OZvGMoLGWoCITbPc57z8VwdesmWHw/CiNTrPuFDQUZGaJg/5bBiEzvuqeEo7tSnN9L7Kg1JPksP7/SSg40vp+xvKj0FVzHjJOopeStfxa3VaHYwP/2hNlN1por51RNECFxPcj+Mecx/72LVC1PAcEYA0bDiBfZkI3dBoKWa7ehF6gs7skmaxnujZ9J1ha9Op6qPP4zww/Fg/iv5KpQDHOvCdAEy+NUBbIgV2VWxIaVRiYiL87IvI2nxsQZWNyLrDLbxbIu63gIAwsLnPzRiXCJdNRPVbQdJG8f/A6PWP9P5tZO3SzrTKA+wyqOk2vutZr3ab/OWJLqFMGDhhUEfKGXmRczCxnJBVEBs6TJJPo//mycuQFUTTnOqkOnfdSMN83ZY/+QRNHoazX17Fa1LWEcOau2bfDHdLA7LAQhlcEY0wYukhP0OIx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(136003)(366004)(39860400002)(1800799009)(186009)(451199024)(8936002)(66946007)(478600001)(53546011)(31686004)(966005)(6506007)(66556008)(54906003)(6486002)(66476007)(6916009)(38100700002)(316002)(82960400001)(41300700001)(6512007)(26005)(8676002)(36756003)(5660300002)(31696002)(2906002)(86362001)(2616005)(83380400001)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VG1MU0ViQ2w2cjV1WjlEeFN1RVQyQXIzNlcrcTVQWnZDWWdOOWdrbFF2OWpC?=
 =?utf-8?B?Z0FuZHVBOUxJQVNoa0I2VlRiN1dsRi9YMmlpS3dVNkxkRXcvdjAxWmN5T1FZ?=
 =?utf-8?B?OEEvVkxIREtsN2hNYjhWbTJKVURvcU9UTmR1eFg5cmhmZVRSZzl0QTFDK0VT?=
 =?utf-8?B?RVZEb3RkQjNCdTdpaWlSMStpRDRKZzdsOHRFcGpiMFBOYjJYZDRKWHpDV0w3?=
 =?utf-8?B?RklzdG9paFpoZEZFeEN2eEluOGNyM3R5dVYyTytkYmNFVVhSbXdCbmZQZmdp?=
 =?utf-8?B?OXBhT0EzcTI4RGVqWFJEWUJvRy9OcStxaXM3aXF1aTZ0WTBha2p6V2VLaFVK?=
 =?utf-8?B?UW9ad25qb1Z5Y3dHdFBZVi9SNFVvOUM5WWk4YkdtSkRiK0hzaUJjMmhweGhV?=
 =?utf-8?B?Y1A0ZG8rM2N3dmdiVnRpYUI2M1BrVkVQWVpzSlNIMHR4RDgrd3Jld2tmbHN4?=
 =?utf-8?B?RG1FeXgxcnBDamRSUVBEbnRXVGpPWXRHK1k1RWZXUW1GTGJhWFJhRDlnQlZv?=
 =?utf-8?B?K3UrdDdZcjhEN1J2TjNRZjdxd2RqV0dxdnRqNTNSR0ZkV1FFUnFMVTVLYStO?=
 =?utf-8?B?QXNOV2UzSmtFdjd2VS9Pby9zdU1rN3V1aHNBWlNJcGdTMkZPZjFoV3M5aStu?=
 =?utf-8?B?RU83MHdtUzZkVDU0YlJtRlROTEgwRzhxeUlKeHovVUxoS0xwanMrMWlER0xY?=
 =?utf-8?B?VjEvYllSTE13Rkk3V3VZZ2dJWnlObFBiTldKT2VXVTBHU2VCZDIyZlV1QVgx?=
 =?utf-8?B?RklqS20yU3V2WnE5VjVhR0NDZlBiWmhFMGFISFl5SFV4QXZNNHJVZEpaenhN?=
 =?utf-8?B?Vm9CRkc5UXhiNFNZQUZTZ3lTenZQMUtXYjl1VzFwZjh6ZHB6V0prQkJPcElU?=
 =?utf-8?B?NFR3T2tZOEZ1YUVOU2tQajF2ekV0OW9Vdlh3Rjg4MGFaRHo3N3BsUmJtdHpw?=
 =?utf-8?B?TWZzRUhNcjQrSGxROWtQKzBTRGpSU1pIL2R3TkcxWm5VOVhPZVFnK0NDQTFI?=
 =?utf-8?B?aWVHVGU2VzdteXdsVzRyOWtydFFyc2dXU1NZTURabDJ5c0JTZG9FNTZkNlpW?=
 =?utf-8?B?ODRIWUNKdzNidGRhSGd4OUJEcDBLbzJ3UUtSY280dVBERVRrMkZ0WHNmTDBL?=
 =?utf-8?B?S1ZRZ0hPd05Ua3U5Tk5uNnBLWGlsV0RHeGFkU2xVbnc0ajM1WCs0L1lIcjVh?=
 =?utf-8?B?S29ScHY5YjZ6QndESzRxcmhheDM2R1JoN0NXK0ErWXBVdUxnUUhMR2JUL3U3?=
 =?utf-8?B?V1RpVmswUXhTNjl3b1JBWGZ5bytXWUQ4TmtmTWR5cjJWRUR5QU1JOHk4QjlY?=
 =?utf-8?B?SUlDUmd5cVZ6T1l0b0dYbHRraEVOZko0Nm41aVlLQkRxNStaTTQ2UHFrNXNq?=
 =?utf-8?B?Zyt1N3lRbU0xdEc4Y0pNRFA4aFNkY0xEMW0vMnRvRlRKSjBPY3Y4ZVZhTjVJ?=
 =?utf-8?B?UXptQjhEOU5nOHM4VU5oUWwxSHkvTjh5Z2dVbTBjbE9EajJjVXpBOStUeUsx?=
 =?utf-8?B?V0pVTUtkOG5uNWxwV2ZSa1kzUGtBMlR5eG15ZFZBdlRhYTl5eU5FOUtvNjFV?=
 =?utf-8?B?eUlieVVEeTY3WWN3UjFrU1k3REh2cDg4clBGNEJuUVNBM3dqNG5HNlI5bFR0?=
 =?utf-8?B?dG1xanhjeWNYRmNCalZGSDg3dndnY0dobjA5Y25nTG4yOHpjVzBFQ3F3Q2JX?=
 =?utf-8?B?a2g2K1prZ1BkSWpUbW9rdDNsQjhVWE02SVMvWDdjWlN1bnFORWVXQkJRV1VG?=
 =?utf-8?B?S29BR1pxVi81VElMUXZNaCtNU2JYdndBMm13cmlDZi8zTSsxVnZkWS9pQWdW?=
 =?utf-8?B?V3I5VmtqZjVJTW9iMExieExxOHEzblB2Y3V0ZzY3a1RPUjdoOHUrVnNuOTcx?=
 =?utf-8?B?Y0tndzNvbndaSDU1WFZ0S1RCaFBXbXJvV2kvUkxacWE2dkhSczBCcmZNdG1G?=
 =?utf-8?B?UUE1TTFwbWhFRFNVYzhyd0MvUktoc1hqbXRDK3BwV1RSd1B5dCtILytTQnI3?=
 =?utf-8?B?ekdQNHlKUlErNXVGNk9OVGRTT0FsVXVtaDFIVE1pWlNpaXozd1QyR2pxQXM2?=
 =?utf-8?B?MXhGcWNVSTVLU3lPUjhVZHdqRGt5a29FdUhsQ0UvS3hKWkhVZXBVdU5qMHA1?=
 =?utf-8?B?RzloWFJGbmoyOXJiOTlzNHVmNFFpcXl4K3B4R2ZMR0U3NHZBWnRiTktaZUcv?=
 =?utf-8?B?ZHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 48da7248-8697-406e-9b1d-08dba8c5a684
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 19:25:06.0687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N+7PVpA/H8ZTESLFm/PsatEXgHtoq4i7eVEvA4V4ocTM4UzuhFhDDbFChucy9oBsSTU8yyJG9mdqo3kuoyNvcSwf1P1GgyDqteaa/cJimMM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5491
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/26/2023 6:19 PM, Kees Cook wrote:
> Hi!
> 
> I'm sorry I lost this email! I just found it while trying to clean up
> my inbox.
> 
> On Mon, Feb 27, 2023 at 12:24:28PM -0800, Jacob Keller wrote:
>> include/linux/overflow.h includes helper macros intended for calculating
>> sizes of allocations. These macros prevent accidental overflow by
>> saturating at SIZE_MAX.
>>
>> In general when calculating such sizes use of the macros is preferred. Add
>> a semantic patch which can detect code patterns which can be replaced by
>> struct_size.
>>
>> Note that I set the confidence to medium because this patch doesn't make an
>> attempt to ensure that the relevant array is actually a flexible array. The
>> struct_size macro does specifically require a flexible array. In many cases
>> the detected code could be refactored to a flexible array, but this is not
>> always possible (such as if there are multiple over-allocations).
>>
>> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
>> Cc: Julia Lawall <Julia.Lawall@lip6.fr>
>> Cc: Kees Cook <keescook@chromium.org>
>> Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
>> Cc: cocci@systeme.lip6.fr
>> Cc: linux-kernel@vger.kernel.org
>>
>>  scripts/coccinelle/misc/struct_size.cocci | 74 +++++++++++++++++++++++
>>  1 file changed, 74 insertions(+)
>>  create mode 100644 scripts/coccinelle/misc/struct_size.cocci
> 
> Yes! I'd really like to get something like this into the Coccinelle
> scripts.
> 
>> diff --git a/scripts/coccinelle/misc/struct_size.cocci b/scripts/coccinelle/misc/struct_size.cocci
>> new file mode 100644
>> index 000000000000..4ede9586e3c6
>> --- /dev/null
>> +++ b/scripts/coccinelle/misc/struct_size.cocci
>> @@ -0,0 +1,74 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +///
>> +/// Check for code that could use struct_size().
>> +///
>> +// Confidence: Medium
>> +// Author: Jacob Keller <jacob.e.keller@intel.com>
>> +// Copyright: (C) 2023 Intel Corporation
>> +// Options: --no-includes --include-headers
>> +
>> +virtual patch
>> +virtual context
>> +virtual org
>> +virtual report
>> +
>> +// the overflow Kunit tests have some code which intentionally does not use
>> +// the macros, so we want to ignore this code when reporting potential
>> +// issues.
>> +@overflow_tests@
>> +identifier f = overflow_size_helpers_test;
>> +@@
>> +
>> +f
>> +
>> +//----------------------------------------------------------
>> +//  For context mode
>> +//----------------------------------------------------------
>> +
>> +@depends on !overflow_tests && context@
>> +expression E1, E2;
>> +identifier m;
>> +@@
>> +(
>> +* (sizeof(*E1) + (E2 * sizeof(*E1->m)))
>> +)
>> +
>> +//----------------------------------------------------------
>> +//  For patch mode
>> +//----------------------------------------------------------
>> +
>> +@depends on !overflow_tests && patch@
>> +expression E1, E2;
>> +identifier m;
>> +@@
>> +(
>> +- (sizeof(*E1) + (E2 * sizeof(*E1->m)))
>> ++ struct_size(E1, m, E2)
>> +)
> 
> Two notes:
> 
> This can lead to false positives (like for struct mux_chip) which
> doesn't use a flexible array member, which means struct_size() will
> actually fail to build (it requires the 2nd arg to be an array).
> 

I actually sent a fix for mux chip to refactor it to struct_size too :)

https://lore.kernel.org/all/20230223014221.1710307-1-jacob.e.keller@intel.com/

> This can miss cases that have more than a single struct depth (which is
> uncommon but happens). I don't know how to match only "substruct.member"
> from "ptr->substruct.member". (I know how to match the whole thing[1],
> though.)
> 
Yea I couldn't figure out how to get it to handle both cases here but I
actually prefer reporting cases like mux_chip, since they can usually be
refactored to use struct size properly.

> That isn't reason not to take this patch, though. It's a good start!
> 

Right. Both cases like this are why I set the confidence to only medium,
and mentioned it in the commit :D


> Thanks for writing this up!
> 
> -Kees
> 

Thanks for reviewing. I also sent some struct_size cleanups that look to
have stalled and could use some review or a re-send if necessary at this
point.

I think the full list can be found with this lore.kernel.org search:

https://lore.kernel.org/all/?q=f%3Ajacob.e.keller+AND+%28+s%3Astruct_size+OR+s%3A%22flexible+array%22+%29



