Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED7D788C28
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 17:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbjHYPJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 11:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234753AbjHYPJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 11:09:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983AE212C;
        Fri, 25 Aug 2023 08:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692976184; x=1724512184;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SdUeDsWk/R+1thUuyxbSfAZ8QhhTE7IUOWW7+9/55WI=;
  b=Kki4jb/WyYVqrtEyUfqM3inepCNxOTi5BHHO22g3V1FPpWLpFWxRfarw
   poKTaP0BsFryzh6EpZKmZtF8HdM+h1NxCaYwKZ4AKZMruvc5LkoJk/kZy
   UhUZ0wetFfoME0s9mg3ORuR+AZmSFO3tHqEjeSFPv7s3gEnSdEGSFXkv4
   SJSybkz/1QfG9mgJIPz6bzSJaTR8+pdFUJiO1y1jWfy3buKCTwr4bFqZM
   kMvQOTIXpw70Ir106KUf8NdRxtaUO5xrhOqxByyRuADDl0s7cmZRZxE+X
   Z3mDX/QEc57Npd7tpAxTdNQ52tXyRjdZBz0rEZ73Lhs/q9h5yuXCXuNpW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="372128088"
X-IronPort-AV: E=Sophos;i="6.02,201,1688454000"; 
   d="scan'208";a="372128088"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 08:09:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="807562916"
X-IronPort-AV: E=Sophos;i="6.02,201,1688454000"; 
   d="scan'208";a="807562916"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP; 25 Aug 2023 08:09:43 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 25 Aug 2023 08:09:43 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 25 Aug 2023 08:09:43 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 25 Aug 2023 08:09:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YNdlN1muBMLSgQ0J6WFBd1o79lD0NZgjYLnx0opzHD+xWADgHcn7M/htSSG6sm33rXGfDKd0KFL6QEDedoQa4FBTYWgJcGzrB/vLwYkHVIMzCInyuMWmI3OVqjmIxuB58Zls9yeJUrP0QWQdnliDGBDPQGyYl33retCmSMVeHaTPCCkgdxHlLKXf3h/01md/YaZGEQXuPQWMdxddiBbuTrsYEQ0woNhEdx0yhjqiDTC/cBOUbqWMrSlDg4IyLrA9oWexdWmmXbJHFyEg4EJ3aebFUiFqodSvAfHwP8+GYqqN6pRA4fPiw9MeXVIQd+u4A5Z8QB/XStLvu5eNybSt4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ind3BLQtTiGw2EfFpAW5grJZBtkIEc7/9DZVMg9ceLo=;
 b=lmPN5M7Yw70/KZtDpv5OVWdO3Neo3cWx6IA1Aoa2/FCS0Au5heP2FqQvZCWZvLQXlSb70WTe5zNWsR4aLed9kZi7f69wMTDtcUPS82QVGwUI7OypFR/u2s4/JmJ69SmuzvxCvgYGAqheiMS0aaZ44SWeqJ/B0iHZJvKfGXrrP67TjkiQuKRPOHQ0CQnlKxTlcKvXp+KS+4IKK0GHmT9HkJuuTjgRIazyJEasSCLolG/RW7BNuPsj5FK0cOG6VJgJWQfLRlUVL0aJ7SSdVk7JeccKQsyHbcJiBImjUP0GW3VY4ClX2k7S6fFdnPUNmhhWmOO/rGt5BDCK7NDMNuep2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by CO1PR11MB4786.namprd11.prod.outlook.com (2603:10b6:303:94::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.29; Fri, 25 Aug
 2023 15:09:36 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::406a:8bd7:8d67:7efb]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::406a:8bd7:8d67:7efb%7]) with mapi id 15.20.6699.027; Fri, 25 Aug 2023
 15:09:36 +0000
Message-ID: <789c18d7-8227-4dfc-438a-2959448f9547@intel.com>
Date:   Fri, 25 Aug 2023 08:09:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.13.0
Subject: Re: [PATCH 1/2] ACPI: NFIT: Fix incorrect calculation of idt size
To:     Yu Liao <liaoyu15@huawei.com>, <dan.j.williams@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <rafael@kernel.org>
CC:     <liwei391@huawei.com>, <lenb@kernel.org>, <robert.moore@intel.com>,
        <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230817091124.915407-1-liaoyu15@huawei.com>
 <a29d4ef5-fba2-b1f4-9c48-5c125dbe0e27@huawei.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <a29d4ef5-fba2-b1f4-9c48-5c125dbe0e27@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0084.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::29) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|CO1PR11MB4786:EE_
X-MS-Office365-Filtering-Correlation-Id: e37e3813-1ee5-48a6-6458-08dba57d4b78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OJw+UbTSfAmVYAGF/M9bI/nM0i6jkiNBEQt6POCkyqjlhhUBUA3IFRZ/c7iF04oR5l/u9Gr8HHkL+ptK6CCSuWstoEhIO/jb7xFfybZct4wpTr5kCRTFt8lR7/PWRd9gEuYTqRtKJhHqvsYms4M0JdEMmCwUcwnWIUlzKAwLi+ViwoQx4QqQYFoBjkT8ukLA9iCFoMF/ZBs1jKBS6rIKirIbVR8jNRjorvVRovkdMYMaxjpOQGTaHVeoDkwCYanw53wWBQTCS+bV6xughvLdF00QBbJc+FydqZitI3oJ1WDf67nOWSlnQpX0f1Fx52GpzQ/5x66dSNM6TZSb/bOI2AlIOSODnbqbtgihyUuYtprIhcb00txaLe6UfRocJKidc83FQbvmWRSU5nCPDTO3jVuLHBNqSkgZgjOWkDxzkHmy1tMFOcPvBLZeQHon1FyhbvMqVtLnwfNh5WRrBERirDpegtoRajS8cTSXlvl+ZSAFxlYtd8EKrapfu/EFwIZlCWGUsy8EWImpBGKdfm2YWM/F/ccxTXXsnE14W/S9FIlcIF0vmTdArrNSYYDsQgijXJzReaYwKwDoPuBmHQgnofPpMrn82ySr2LePOUR4jYUZp3WDPEFi7Dt4jaehuFdFUhGOXoDowWDRAvFIvWw+lA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(346002)(366004)(39860400002)(376002)(1800799009)(451199024)(186009)(44832011)(83380400001)(6512007)(478600001)(26005)(2616005)(5660300002)(31686004)(2906002)(966005)(8676002)(8936002)(4326008)(82960400001)(38100700002)(66556008)(66946007)(66476007)(86362001)(41300700001)(31696002)(53546011)(6486002)(36756003)(6666004)(316002)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajRLbUpZQ0VzTHNMV3NucStmZG5RNWI2eEQvamFjcWhBVGgvbjZrRkZDUWNC?=
 =?utf-8?B?RE95czRaUXBkUWJRNkZOZU5GZjRvd1hBbmtzR0x6emxBMnpQYTZqUUdjb2o1?=
 =?utf-8?B?SDFwTTVXMFBpRW1FMDRuTDlnQW83TW54WXBmaXlTRVVtcGJ4aWpGclFuV1A1?=
 =?utf-8?B?dnJ5UnMwREJka0pyK0hkb1ZzZUIyMWVhSmVSVTRITTRpZHJqMzdYM3pOTjNp?=
 =?utf-8?B?NThqR016TDZjTXgwYWc5cjZRSGdvWjlxNnZaK0VNUXNBaysxNHhwbUpOREhQ?=
 =?utf-8?B?eEtid1dqeTl6amsrRHdmU3BNWW91b3VpbmZKNWU0VkowS1kza2dPVEs3L3VR?=
 =?utf-8?B?UzF2ZHFHeVQ0UXNRMVRmVm5TTzZjUFZYSDNFd2Z4S1AyTnpKVll1UDdGejE3?=
 =?utf-8?B?T25CSktyZDVUQm1jSUNIQXdJRm9jMS80UnZQdkxKWFFSMnM2R1pRMllsQVNi?=
 =?utf-8?B?RGtoYjhpMGhmY3VjTUNwV2tMMmtLL040NE5rdmRMNWoyTDMrTmFiUUZrS2t1?=
 =?utf-8?B?SFVPdU5LOTlvUFFsSEtJUUhNWTJqT0RKRTNvdTg1OGtMR2kwcFkyMVErNFpF?=
 =?utf-8?B?KzZCMGQ2N09ZOGhWMDNYRm9aTXdwTG9tdkR3a0xlcndoNDBLOGdYTzh6Vnlq?=
 =?utf-8?B?UUV1VjZVR0VzUmh2Mm1INjg2OG84MXNmQVQvaUxhZmYrd0FJMzlVMlVjK1hJ?=
 =?utf-8?B?T2p5V0M2L0lVblVPenlGL1N2eUNuOGR1ZVhtTWsvaFU1M0dldzJYLzMvVVlI?=
 =?utf-8?B?T09GR3RPU0pscjBIYWRWRkttWC9nNWZReEFaazJGc3pVTTVNb3IwWW5PTkRJ?=
 =?utf-8?B?L3NEU0hQRkRkME5Oa3RrbmVxSHUrSVduZ0kzQTg5NVJxclAxNDFoTUpOakla?=
 =?utf-8?B?bzh6SkdYaDFrUS9FQXNJWXQ3dTBNVG1na3pqaXVocHhDWE1TOVIvVzljZzND?=
 =?utf-8?B?NnhnWFFaL2FwczZCWlNsSE9jQTVheXdyNXYvQVJlL2RYUFVJbWJMcFM1Zm5j?=
 =?utf-8?B?MTJIcmtnR1pnSzRUa2dHY1RXQ3czV1JkMVJpY0p1L3AwSEZYcmJibS9qMWZC?=
 =?utf-8?B?anV5WURaUjBnbnZvUDErZHVlVjJLOC9seEJjVkJwVEdxLzFKTnVFQkUvbHAz?=
 =?utf-8?B?MEluVEpCV2U1MlU3UytqZFdWaW9QOW84dUhEQWhYaG9wZFJ2Z2FwS0cyRmlt?=
 =?utf-8?B?NjBDRUdiS0pHcC8wckFsWnJONWsxRm1HUEdCbTJRblRaaFRtR2dZOEZhVVVr?=
 =?utf-8?B?WHRIRTV6L094UG1OVkczOXpOOWphMVY3ZkJPSnVTRnd2UGZxZklacDNPQzFF?=
 =?utf-8?B?K3hObDRCcjYxTXJSTFBGdnQ5MXp4a3BTVXl3WUVzMm1HTUdhZzEwUXBnMktm?=
 =?utf-8?B?ME1LTVFVZ095a0t5YW5PUEFJMGlheWw4eHo4Z3U0WXJQRGpzanN2RXd4QUkv?=
 =?utf-8?B?V3VIUmkveXhEYzY0TmgxWTcxY2pIYmZJR0t2ZWRQWVBHS1lVM1g4YWQxd0RX?=
 =?utf-8?B?VUx4S1FpelQvaGNpbGV0QUQzL1ZRczhyc01ITXNSUTBDdTZCdjRHQklvMndz?=
 =?utf-8?B?NGxTMXc1R0xPZmJ0SmhRWkh6azBVTWpLMUdYZWFJYThvd3ZQcWJXUUZid0ZE?=
 =?utf-8?B?dGZDQ09Xa05ncmFQZlUrSWxER2dWZWdRT1VUbWx4Z1JwMzJqZEtpaHUvY3lh?=
 =?utf-8?B?aHV6bFNEUUc3VUhPdkRwUHlkVGE0WGVYQXJxTDFiellmRk9ZYmU5c01IYUJz?=
 =?utf-8?B?bmp5UGM2a0dZdVUzYWlRRTZuSkl5SjJiYTNoZ0Eyd0poZE5ncXpFZVFjU2Ez?=
 =?utf-8?B?Q1AyM2NMV21Dc0o1dys4M2wrc2JmRlBPa1FVM2l2UXRUbHFiMXorREszMi8r?=
 =?utf-8?B?THZDL2l1ZENVZk8rS21SVzZwZVg2ekV2TTNKQTZjbExTN1B1MFE0WHZ3Nk9U?=
 =?utf-8?B?MzZkaEpGdkMvZkpQeFNESzJpT3VINjFlN1VUdXhEL2c2enNBVys0SFYyMU14?=
 =?utf-8?B?eDRXWHJ3b1phMnlreTBkdnFmY1lsdG1Rb0F3dXJUNUhKV0E2UFdZSDV6QUZz?=
 =?utf-8?B?a25wSGw4dExxaEhMZEVIek1hYk4wZEZBSThNcVZwMlk0dVRUcGk4eStYQ3JL?=
 =?utf-8?Q?QDflGclEIRw9j88Sg25s9kgmk?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e37e3813-1ee5-48a6-6458-08dba57d4b78
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 15:09:36.1070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V+O11bWngIEWGf8ash0TfUt1UqlJXTT/P10hz+pYEfcYCrlMVSF4ABE2OwQHQy8M1WbzWNCCBDDRGi95+rXzkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4786
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/24/23 20:59, Yu Liao wrote:
> Hi,
> 
> A kindly ping, any comment on this?

You can add my review tag to both of your patches in the series. Please 
cc nvdimm@lists.linux.dev next time as well for nfit. Thanks!

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> 
> Best regards,
> Yu
> 
> 
> On 2023/8/17 17:11, Yu Liao wrote:
>> acpi_nfit_interleave's field 'line_offset' is switched to flexible array [1],
>> but sizeof_idt() still calculates the size in the form of 1-element array.
>>
>> Therefore, fix incorrect calculation in sizeof_idt().
>>
>> [1] https://lore.kernel.org/lkml/2652195.BddDVKsqQX@kreacher/
>>
>> Fixes: 2a5ab99847bd ("ACPICA: struct acpi_nfit_interleave: Replace 1-element array with flexible array")
>> Cc: stable@vger.kernel.org # v6.4+
>> Signed-off-by: Yu Liao <liaoyu15@huawei.com>
>> ---
>>   drivers/acpi/nfit/core.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
>> index 07204d482968..305f590c54a8 100644
>> --- a/drivers/acpi/nfit/core.c
>> +++ b/drivers/acpi/nfit/core.c
>> @@ -855,7 +855,7 @@ static size_t sizeof_idt(struct acpi_nfit_interleave *idt)
>>   {
>>   	if (idt->header.length < sizeof(*idt))
>>   		return 0;
>> -	return sizeof(*idt) + sizeof(u32) * (idt->line_count - 1);
>> +	return sizeof(*idt) + sizeof(u32) * idt->line_count;
>>   }
>>   
>>   static bool add_idt(struct acpi_nfit_desc *acpi_desc,
> 
