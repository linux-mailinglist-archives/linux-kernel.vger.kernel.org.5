Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5FE679EDD0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 17:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjIMP7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 11:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbjIMP7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 11:59:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14FCD1990
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 08:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694620755; x=1726156755;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=T10S48YoTxfyoFrO7hy5J7fpjmX86dCjcM4GfeaLTAI=;
  b=GJy6sDvmwK1A6dVfFTUKBO+uqSXaiDy5iYw+2n499B9mS74tsUgmahaY
   Eo0IiuoY1HsKo1vscZwyOqT1FGdmCYMmm4UEPU+PaSB7mqrP7L1xFyMYX
   xF4VCGY4drCTaVh3EiO61B/oxteIDttcwig8lbJqyU0/ApqgJogVRXTLn
   4b3NDKv42dMcF4yHpJD/g6MJRSYtsSAswymHfTUgzpQtU9vFFH2r/L0rQ
   NPGqRQozBOIWsohzVoUTT2idbErM2pWngyd8oQqNEj8DPgnlZecmJNYS9
   U+NFtslEFSXIX0pzWDPrph0DsC2YfWqUL7d+lHInTdya5x9dwO/tBOiol
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="465076330"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="465076330"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 08:59:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="693881935"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="693881935"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Sep 2023 08:59:07 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 13 Sep 2023 08:59:06 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 13 Sep 2023 08:59:06 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 13 Sep 2023 08:59:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZMC/OJ9GMg/mw7ebFJwv80Yr9lkezO56NC46wOyCvSW7EQfoSZfKHnzvKOsqmUMYnZhL+Cs4RgHufDIHmDeSoVpFXW2EaBQWRfE2zZPxQ1N7ETpt+iyuD/NA24cap3qEybSbs44L7mKZB3Baati3+mNw6mbEBMQRdDArZ9NC5W6PiXDVeRSr/GNLRuuNoPlj7/pRoZIc0XO3if4GttQWmXtzd3aWXMuvPNWAb9gB4qcZ98hZdcibNmG6V6M4SiEH7CqZerL7ju1FyN16UXF60BzmEKyfQPi03M1XJ6j1AXP/tKjANITBiabrtyurwuV3lA6WexVg2zhLdKJa36K2Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=txn1ZSEksv8Y5OjUtbBaFAOD+IaO/9Br9JJS71Fp4hs=;
 b=H26ZDUgrjTSrB32YsMEfUg5lfi9H6HSoKQ68b/h/yNEZZrmfh2PPawKGx/rhHMWXhf95+KDtO3kgOI8xb9/vTk5NOjZel+hWhIaYYS9PHO+SAeD1qzL/3xlDAxPcVe1hKGCjcVNEayLoUFM/ts8i6IPPWwiJH5zZsy/MIQHKYhi+k1s2f9PVF/aSbXr1bv8mqF5RasmxyYRDKUVR3V6WOcOx3Mm9SXg1LbZz2DrjdzE6xnFOt3fUzIvhWUOdxBh/L2d6ANdYj+hrCKp+Gc0zAoiO89IcRZ3vnyzuE+d+VSoyGIQkO6ktmRSrU2ukHa+o7gZNeqzHUP7xh+O3wI1Nlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB7605.namprd11.prod.outlook.com (2603:10b6:510:277::5)
 by MN0PR11MB5964.namprd11.prod.outlook.com (2603:10b6:208:373::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Wed, 13 Sep
 2023 15:59:03 +0000
Received: from PH7PR11MB7605.namprd11.prod.outlook.com
 ([fe80::4b20:e34:71f:139f]) by PH7PR11MB7605.namprd11.prod.outlook.com
 ([fe80::4b20:e34:71f:139f%4]) with mapi id 15.20.6768.029; Wed, 13 Sep 2023
 15:59:03 +0000
Message-ID: <cf99d227-4fee-483a-ac51-fe8fc4acf579@intel.com>
Date:   Wed, 13 Sep 2023 08:59:00 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] drm/xe/gsc: add gsc device support
Content-Language: en-US
To:     "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "De Marchi, Lucas" <lucas.demarchi@intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>
CC:     "Winkler, Tomas" <tomas.winkler@intel.com>,
        "Lubart, Vitaly" <vitaly.lubart@intel.com>,
        "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230912130835.2488728-1-alexander.usyskin@intel.com>
 <20230912130835.2488728-4-alexander.usyskin@intel.com>
 <5521adaf-724e-4de8-ae56-74dc349b66c8@intel.com>
 <CY5PR11MB6366B470B6B6A72F32F2EB18EDF0A@CY5PR11MB6366.namprd11.prod.outlook.com>
From:   Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
In-Reply-To: <CY5PR11MB6366B470B6B6A72F32F2EB18EDF0A@CY5PR11MB6366.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW2PR2101CA0034.namprd21.prod.outlook.com
 (2603:10b6:302:1::47) To PH7PR11MB7605.namprd11.prod.outlook.com
 (2603:10b6:510:277::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB7605:EE_|MN0PR11MB5964:EE_
X-MS-Office365-Filtering-Correlation-Id: 69593730-baf5-4ea9-ad7a-08dbb4725a30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YCD2DC/UCGyb5IXUeRlDZ/DRDQW0EUiyQNDKN7anS4zPFZ5foDv4UlfzaQ7JlW1nUbOUDZRqDW6PBrnnK+QcGJuDDA5cPP6IPRP9njYZql5kmq1CAaqEzVgfzISfAZ2mJoWF1ntiGLf48Q1GIqfoQkDoAy0Krk/sVoMoBEr+jyoVXzIZrDGmfozKHg2bVR/ZK3f6Uobu8HEI8epCDPEmdJQ5UN/eHliMrc7uHomkPruO1J1uUc2OaJgIA3JaNDF7/Ba13Cx6tsuIaS8bS7RmomRfFJu4HemnX5RJhRwgTH24wuSTknHCWg386cpzJ9V/BVB+UyyxzAV6DiJE/92VOZJCOHmXjbJSQqkM/hlNuwIDB9OS5Z7V7QSDY5ESaQED8mtm9IqzcJg5ExJ1nsFOVEhEMPmHqVlSBix9elDRGvBLIXvkUXyOrIBkR5TYYia9am/HuQjsHkKbNVAJPe153BJXBvNRPUysJ//g6BdXgIL8HgGGenSpll0yZeFrTnZuqU9ICFe4TLE0hbX5qPnRXNbz+Dk/ufGKP+Ux6rtPMuvHTjctXs1T07De/FHZJ956xfD3a7RdxVhYsjo3f7DQKcoz9Pj/WaZOWfCuExLP5lZ7r9R70R4IsmxlJaOHDYcW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(396003)(39860400002)(376002)(451199024)(1800799009)(186009)(110136005)(4326008)(31686004)(6486002)(6506007)(86362001)(31696002)(36756003)(38100700002)(82960400001)(5660300002)(66946007)(26005)(6512007)(478600001)(53546011)(8936002)(6636002)(8676002)(2906002)(2616005)(41300700001)(54906003)(66476007)(316002)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkhjUHlLeUxEY28yblh6all2cjczQnVVRGx1aW5yTzhVU0kvWWtSRTBhZUZw?=
 =?utf-8?B?cTMvQlRYM0VQbGoycTVUVmRWa1hPbFR1cTV1VkFrNnZxZ21IZkNKRnYwTXIz?=
 =?utf-8?B?dnczNHJpaDNKcmNVM0piQUk4cjBIcWpDRnpXbUhxbFpDdjVsSU1ER1NucTdY?=
 =?utf-8?B?TDFlUDVPUVF6MUg2ZHdaSzhQMGVHY2lmbW9DakU0SmY4TVJTUlh3YTRHY3Jj?=
 =?utf-8?B?NVJsbjB5UjlXSHlZaDVLVlNJd3JuazNQclFGT0F2UFd3bVFhdVcyOHhDTE1k?=
 =?utf-8?B?UmZSRWYwY3BXMyt6aGxDWUF3ZDAyVGlRODdnREFyZXpYRVZxcmp5Q2xzMURo?=
 =?utf-8?B?dmZzWlBwQzNqZTVsMHpLRTZKSy9qRk16QnRSaW5vMUV3djRPcFRQN0xRc1Nv?=
 =?utf-8?B?M3ZVYTZGckxYZDFIRVNYTDEvajFaQW5wR3ByVWdxbXRhZGtOdEZhb1BYNHpI?=
 =?utf-8?B?c0JXUDdCa3p2Vkg4TDJiYXhiUUFGMDlMN21ZanppbUpENlkzVmJ6elhFeEJV?=
 =?utf-8?B?b2VkVkNzTUNoMVVaaCszaDN0UU15T3pqaitWdDlYVThsKzJzaU5aR092Q2VV?=
 =?utf-8?B?R1RHNDhKWlRVcnhZNVdXVG1aNlF3ekdtanNveHBnYnQybG15VW5aU21GRkd1?=
 =?utf-8?B?L0VLcXlJdWl0aXVpTlRoWHRweU50TFpvS3JnbTB6UnlQTVFZYnJUYm5GbUY2?=
 =?utf-8?B?M2NzUDc2eUFxYk85TkZnYXlLNlVNd21PS3VkRm81aWdFNDFLMzNWdUVVMDJv?=
 =?utf-8?B?ZjNCV3MrV0NSVS94UFNaMWJ2Z1k4dWFCT1hmb3BsdUpzbEZacDdUSHUrT0w3?=
 =?utf-8?B?Y0M5UjY4WG1LWDlKZy9ONVZJSnYrMlRjbEU5Wk5PeUM4QURRdWg3ajJiSzRH?=
 =?utf-8?B?bVZveUJFYmxVdFdNdEJlcncxU01lMW93R0JXUDBEVlM5d05PVTFuTmZwbGlS?=
 =?utf-8?B?d3FscXJ2d1ZEQ28xY2s5d3lMVkg5MlZoQytWWXRNR3l6WThURUtrcFhqb3Jm?=
 =?utf-8?B?QkY5b254V3FTRmlBMWRIaUthRXJMb2ZKVkFOOWVpYWtKd3dLWU9OYlVpOFZm?=
 =?utf-8?B?aVdMcTdBS21vMGFmcmNXbE9RYTRhejZTUFRUWWRoSUNtOGlyemJUNkp1WTND?=
 =?utf-8?B?eWtsV2Njc2JQejNmbXJtUG9XS09Na3lQUURPaVoxaUw4am9XK0tKOGJPV0Nv?=
 =?utf-8?B?eU5yVEZ2eWdjV3ExZjdFcnhvK1ZIMUxBNlp1RkdCVThzTVFXc3NiaWtaQS96?=
 =?utf-8?B?S2daL25rN09WejRrNnRZZWJjcnNRdzA0aTZqQWd5ZHZhSzFIREVGSEN3M3A4?=
 =?utf-8?B?T1JhWmJPaHNHVG1IbXVMZVQ3c1UyUVJkaTQ1QlVQTnlQbjZQeW9jYlNCd29R?=
 =?utf-8?B?UXgycENYdHdsMGhMTmxnd1c2ZE9tQnRMaXcwck1Zb3BaWWdIUC9EcXFhRzV4?=
 =?utf-8?B?SkFvVE94S2VILytLNGpKbG9JUjJyeDhSckE1QTh3bi9vQ2pXbHZPWHlYRmYv?=
 =?utf-8?B?TldHS3IxVC9hT0tyYU0vSExxMGV3Z1dpd2JNTXh0S3NXa1dhemVqZkMxWDlx?=
 =?utf-8?B?Y2hPL2gyU0cvdTVSc2Q1c0NvS2ZQbjJKV1p5VU10R0gxV0ZDMGVrZ2hlckNy?=
 =?utf-8?B?bG03eUFVTEQ1Ukt2elk3ejE3eWdUUzZLZ25CSXo0NzF0aUZLMGozTHRNU3Zp?=
 =?utf-8?B?NmVQMTkwL3MwSXkwYnErZlA5eDZWak80YS8zS01tTHh4OVhFQlJobzdTcHNX?=
 =?utf-8?B?c0krVU1CNHlHM3ZrcEY4eGc2S1lNMUQ4MDE0RmNkUXlKNk1qOHZPUHZDeUN3?=
 =?utf-8?B?VU5xZXVPU0I4K1lxaVhCb0RpUVRVZ2V4TVZHVjdPOVpESS9mT3FxTDloak1B?=
 =?utf-8?B?ZFVwck8wb3JZMnU4V1RIUTVqd0ZCaUVWRmNEUzBHQ2tDeFU1L1NzVitWKzAw?=
 =?utf-8?B?dUM2aSt2SmNRSmt0dmJmaDU5VC9aQUFjWVBIMFE5azR6clM2cnNqdCtKeUhj?=
 =?utf-8?B?akxYcUx0RFZZck5JZ0p3NzZuQVFJcUJ3dUlIcU53bG5Jb2xUb0o4a0JvSU5H?=
 =?utf-8?B?aFlrY0tobGhyT3ZSdDVRN1h5NS9PcVB0YnJWcGRHTlRKRjJVeThRckFjaGdr?=
 =?utf-8?B?NU5ab3ZqaTBjQkNORWRwMXhjekRzc282Q3BHbEkvTzFRcVRSaG9IT0E2dkkz?=
 =?utf-8?Q?D4PHuuiO+XTV6wkdLhDDVM0=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 69593730-baf5-4ea9-ad7a-08dbb4725a30
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 15:59:03.7095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HauQI6qWoAXp06wfh+tAf6T9Q8tMDOoer3XaBd+pc0x5GK1JCb6e+HkcnFGhDGVqxhPu3DBEmCc8chxj3lDgzuuk6fdKyocWFAS4Suj1Td4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB5964
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/13/2023 5:48 AM, Usyskin, Alexander wrote:
>>> +struct xe_gsc {
>> Please use a different name for this instead of just xe_gsc. In Xe we're
>> likely never going to fully use the GSC via HECI, only the GSCFI/CSC
>> part. In MTL and newer we also have the actual GSC part being split off
>> and placed inside GT (behind the GSCCS), so if we call this just xe_gsc
>> as well it'll be confusing. I suggest calling this something like
>> xe_heci_gsc, xe_heci_interface or something like that. I had actually
>> suggested this for i915 as well
>> (https://patchwork.freedesktop.org/patch/509653/) but Tomas was
>> concerned it might make backporting fixes difficult, so I dropped it;
>> this is not a concern for Xe right now.
>>
>> Note that this means renaming all the exposed functions as well.
>>
>> Daniele
>>
> Sure, will rename it xe_heci_gsc and move to xe_device.
>
>>> diff --git a/drivers/gpu/drm/xe/xe_irq.c b/drivers/gpu/drm/xe/xe_irq.c
>>> index 1dee3e832eb5..1ae4cc9f1522 100644
>>> --- a/drivers/gpu/drm/xe/xe_irq.c
>>> +++ b/drivers/gpu/drm/xe/xe_irq.c
>>> @@ -128,6 +128,7 @@ void xe_irq_enable_hwe(struct xe_gt *gt)
>>>    	struct xe_device *xe = gt_to_xe(gt);
>>>    	u32 ccs_mask, bcs_mask;
>>>    	u32 irqs, dmask, smask;
>>> +	u32 gsc_mask = GSC_IRQ_INTF(1);
>>>
>>>    	if (xe_device_guc_submission_enabled(xe)) {
>>>    		irqs = GT_RENDER_USER_INTERRUPT |
>>> @@ -180,6 +181,9 @@ void xe_irq_enable_hwe(struct xe_gt *gt)
>>>    		if (xe_hw_engine_mask_per_class(gt,
>> XE_ENGINE_CLASS_OTHER)) {
>>>    			xe_mmio_write32(gt, GUNIT_GSC_INTR_ENABLE,
>> irqs);
>>>    			xe_mmio_write32(gt, GUNIT_GSC_INTR_MASK,
>> ~irqs);
>>> +		} else if (HAS_HECI_GSCFI(xe)) {
>>> +			xe_mmio_write32(gt, GUNIT_GSC_INTR_ENABLE,
>> gsc_mask);
>>> +			xe_mmio_write32(gt, GUNIT_GSC_INTR_MASK,
>> ~gsc_mask);
> Danielle, how this enablement should look when gsc_heci is not gt related?
> I'm somewhat confused here.

This one you should be able to leave as-is, and your check in 
HAS_HECI_GSCFI is already at the xe device level and not at the gt 
level. Unfortunately the mmio writes functions only allow a gt parameter 
for now, so we need to stick with that (I believe there is a plan to 
change it at some point).

What will need to change is xe_gsc_irq_handler(), but you can change 
that to take the heci_gsc as a parameter and then do:

     xe_gsc_irq_handler(&gt_to_xe(gt)->heci_gsc, iir);

Daniele

>

