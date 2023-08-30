Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F26CA78E12A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 23:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240287AbjH3VI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 17:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240139AbjH3VI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 17:08:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A5C19A;
        Wed, 30 Aug 2023 14:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693429676; x=1724965676;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tsS9bIzJcxJb50adGhYHX9rnG7+/pisE2wdkcB1UCOw=;
  b=nNsKhA6/oWkLuQwDqbST8MzDEvmvt4H1dUZp86eNrk0x4LEdWQDVddnf
   vO3HlEKJhbD8750Q4My2vM/MUEjCW0A3RqC3dp2HI+DwMDKu6yjf8eHIf
   nSGMie3IJy1xGJCQwZhFz/wqB5THE0qXlJN9EhsVt5ChQ/6V9IafFQ7Pu
   pd/dR4TBY7GeDWbnxxXj78CIL6d1MSulcFYnRfcquIk7fDaDJe+L0PoEe
   mE8/UjjD1DgTewycmt+pP524uWJdH/9vihMJsfojs3htKd4e5boXIK+/i
   2/pQuhdBnI4wctUe5I1VIiGBlA33Vg/am19kKQjNMOwPobk7vX2u8J//4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="442105639"
X-IronPort-AV: E=Sophos;i="6.02,214,1688454000"; 
   d="scan'208";a="442105639"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 13:33:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="1069958991"
X-IronPort-AV: E=Sophos;i="6.02,214,1688454000"; 
   d="scan'208";a="1069958991"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP; 30 Aug 2023 13:33:42 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 30 Aug 2023 13:33:41 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 30 Aug 2023 13:33:41 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 30 Aug 2023 13:33:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DO1cREI9YgtUjhWmCC8mAzs9XBimh0nTHcQ4typ3fcn7eEfVuoObeNm6kzq9qw7cH2XaEV+q+qn7kWlATQdBSKX1uel9ne2UaH7i9VG+c4hGFM5nox+JUgMsq1miBeraeAtvdFYhpqXwS7N6uUug14LZsvwlJF5yYlAfvH35rhy2Vtul0e4/sNvlk9YuTDlT32eHOSEwRXtlFVi9NAUtP4Zx8xM37oBoh6zrY4wenrfplyg+7q4YF3QGsok4bOQsmLZZ8H7q/fyrKQlJVn/UrKjnX87KoX7Fyr5FkHdL0FuSXdxKw5drWwhu6Tg5WAw02CF343QyWZ6lyPwSGwJQ+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Qw8XKYBOj/45MMUgsgvr7sGtQVX9ZNK2+izjLrSypA=;
 b=K+1KhEj0FOLZPEowvtI1BaB02lLepfQR9cPqlNqEDFKvMN+fwaGm0vm/41N9OmA4G/Je7bH/8p6/ybFcidJMA3Si6N+Dh33kSr5oeE+FUAV7dfDNVWstBiMHErzhMtyY8/7eU5I1viwyQdHrdxNBWt6Bn8tQMGp96+Hv3QR3NcFGAHY6JHgufwbzFT+d2RmNHzRjQjL6t0vk5MqtgiED+tr3ME47QYnggXscTAkRXIxn4obwNcG2EiJm+kQenCxjs3rOk3qjbCnFI8oaGanpN6Pz2wGac6gr9/BObGMVJ4zKSItxaIX1wrwCvz/6wdPYalAUtg23rmiPixzpdJgTrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by PH8PR11MB8015.namprd11.prod.outlook.com (2603:10b6:510:23b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.30; Wed, 30 Aug
 2023 20:33:40 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::9563:9642:bbde:293f]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::9563:9642:bbde:293f%7]) with mapi id 15.20.6699.034; Wed, 30 Aug 2023
 20:33:40 +0000
Message-ID: <226c2ec0-ddd3-b3e1-c178-896216f95d24@intel.com>
Date:   Wed, 30 Aug 2023 13:33:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.13.0
Subject: Re: [PATCH RFC v2 02/18] cxl/mbox: Flag support for Dynamic Capacity
 Devices (DCD)
To:     Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Navneet Singh <navneet.singh@intel.com>,
        Fan Ni <fan.ni@samsung.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Alison Schofield <alison.schofield@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230604-dcd-type2-upstream-v2-0-f740c47e7916@intel.com>
 <20230604-dcd-type2-upstream-v2-2-f740c47e7916@intel.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230604-dcd-type2-upstream-v2-2-f740c47e7916@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0035.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::10) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|PH8PR11MB8015:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bd65272-2736-4bea-e093-08dba9986517
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /v+Lczkf9Wjpd6AOmGEScPPtkykMMA/WsPWxNQeh2SeUiMmu02PePYX4SCYe/m1cWWndnjUBqT8rSAAkCiTvQH0ie19xC8abA3JWgD0O1d19ohipwlMREXDWRuQqkbsm7PAjrdMlclGA9p4Bban7A3ouNPANe8uo2yaLLFCu0ofDRkxpSOqY87w9asukK6vtJJgjvJavczEPbbXcoEPD6ddiqIydTDYqBQto/1BtVaaOXEJcaTB3L+zx92P6LNllY9syJAynySQGJxV7231X86z7MeNZfCwCHiJEp8r8sgcbTiGj63ymNSP0kICBQxsWi0QxC4wabI4+fwqj1pjQlZQXH2cGH7Ue81YAYgr8OiFi432kvcjh+f/r9DcMtE+Wa2bXxS8/K6Sp+X9U3BOHE5A+7T3yE5YAu4svsUK0RU2bSBjzVn822yGrhqs3DjBjeZr/S6oGe4HLK/Sbgm+eeLKaI57EHojg+mD0Vt1QpAnOOFHMKL12dRodpHv9+S7qIs6koQgy2i0wVzufxmmJmV2b+dHyWTfcN47NyZnWS+xMVQiw19moq/+UK0wZxTkwfcdEDCy1jV+mbG0SC72XmNH7d5F+0tSitK0R58SDBLav6VEHai2KhK/oYvVUEkyx5LJdwDumNx/7jHecUI/NzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(346002)(136003)(39860400002)(186009)(1800799009)(451199024)(8936002)(6666004)(66946007)(31686004)(478600001)(110136005)(53546011)(66476007)(6506007)(54906003)(66556008)(6486002)(6636002)(38100700002)(316002)(82960400001)(41300700001)(6512007)(26005)(44832011)(5660300002)(36756003)(2616005)(8676002)(31696002)(2906002)(86362001)(83380400001)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3Z0b1RmQzdIeHMrbXdDQTFDTHlZSkxld2xxSVpOTjVydzRCUXBXZjhVNlBB?=
 =?utf-8?B?MDRLbVRUNU9UMEhwV0VWUE9wb3BHZ01POXRuRVBobSs4Tlc2VHFEUzl2TWI1?=
 =?utf-8?B?allocDNqaWV4TUlYRjJaLysrRXg3ZW8xYUF5VmVSTUJQMVBsdS9zQ1UvMXJ3?=
 =?utf-8?B?KzRuMU5SUEFhclRoaEdvR2lsUFRFckR2dDgyajlRNllIRjV4aTc5TktVSENM?=
 =?utf-8?B?c3N0TW4rQ2xzR1JEZWpHd0lCaFgvblVmSHdqY01uTmlPeXMyMVBzNVNOMElI?=
 =?utf-8?B?NEtZS1ZXdVVDNmxFREEvVU5pS3pRSVRWeFp3SCtSclhHNnNORERTa1Y1RHFl?=
 =?utf-8?B?bGlqMDVydkNXOVVrd25MWDd3OW9TdTRXeWdVZ3pBQ2ExWk5tVzJ6dmRwN0Ur?=
 =?utf-8?B?UjFHNHpESHByTjlLMVFZc0ZUM1RTR2xLTDcxYi9Eby82TThVU0RhQ0VUMlRp?=
 =?utf-8?B?alhuL0cyOTFsK2xreFhudW9WeHZKQm5oSzBNMUFRUlFCY0dLS0t1SkdKUm56?=
 =?utf-8?B?dVAwcWI2Uk01UU9Tak9CVDZ0ZDhRWGhad016ZUhPRmE2MmZNQWF0cndybVdw?=
 =?utf-8?B?V3JvblQ2Y3RqVlVJUFRIdG85UDRXKzlka2FpRXF2ZXVHMUFaRzd6VWlyekJY?=
 =?utf-8?B?Z1pPbGRyT3plZ2F1L2ZEWFBpbG9GcXc2dURtWFpodHFNNjVKbUZuQlBqcE1X?=
 =?utf-8?B?cVppQi94dm1jS0hOUnk5VjZYUlBBREdvMjBUSGdoc1BleG05bElTdU9pZmxZ?=
 =?utf-8?B?bTNXS0YxMmFBNC9FQzJHeHBNcWhLNVJ1cnJTUmh1TG5QYk9VWXpudE1nYTBu?=
 =?utf-8?B?S0lrSE5UKzhPUnNZdXBVTWZWenBFU01zNmJEb25oV2VGQ25vajB5b1hzWFl1?=
 =?utf-8?B?aittQkxHUkkxR2thck9rQm5OZ25EWFVJV1haOTZDRzdWVXJYalUzS29SNTdT?=
 =?utf-8?B?dVJ5TmhIeHRraUpKTjl2V1IyWmE0M2FCK3hqdERZV0kvN1lNRU9jeHROd3R1?=
 =?utf-8?B?UzJlTjlWaTNDR3VRa2lUNnQvTXZmMTI4VjZqVmxUbWRFNmg3bGJEMUVvYy9U?=
 =?utf-8?B?VEwyK2JldEJZNzRTY0xGejdDT1UvV1dvSzI4QVJqU2lSaUxDNjlkOGNtQzFh?=
 =?utf-8?B?eHJYZEJZTysvU24xVUlHSFk5cjRjTkVONndiZ2pUYUFoL0NFOUhmNHNIVXJH?=
 =?utf-8?B?YUU1ZzFLdEhkRXh6dmJyYzNjNEtQNzVYSHVDaHppTDdCd2VLSzlKb3dhWU53?=
 =?utf-8?B?dW5odFZKM3dkanZIbXU3WmZIRlpubW5KNnBja1JwQk50eW5UeDk1Y3RnUlIz?=
 =?utf-8?B?eDVFRWQ3bUlSeTVIaUpoSVNkY3E0T3dlWmhxU2h2d2lhOVlVMGl1d041QmdJ?=
 =?utf-8?B?Qm52KzczcTNPMzZxMmFXUnlBajJTNmhESjFFNUh5T3lkT0dmblNoTHppTGp4?=
 =?utf-8?B?M3pSamFpSG9tWmlFb3MxZ0hZcm56eDcwWmQ5cTBlTk1DZ1JpT0tuOEh4WEZG?=
 =?utf-8?B?OUFrU0ladjgwZXgrMXdjNWw3cDEyQkhhR241M3p3WHFtd0FxYjZydU1JMFpH?=
 =?utf-8?B?c01OMUVJSXZ3ZWw5TTROc0hiQzYvQmhIeEdzK3Q0Mmh0TWtWMjhFMFM0RHlR?=
 =?utf-8?B?SWJrOW5Zc0p5Vld0MFBTd1FUUXg2Q0g2RW9WUFJIMkJIZnk0TE9pblpoRzVm?=
 =?utf-8?B?ZnZEbGNpTkJtWUtsQnRpblNDOFR3YVdUaGFVZ2pidXo4K1NLZndQK2FrSzEy?=
 =?utf-8?B?YzArcmN0NFFOU2M2NUZzdmlOYkl0bXpObTUxMGQwY2YrUnpXUGczNUR5clFC?=
 =?utf-8?B?SWFvdndEemlPdDBmcGVIVkRra1d3UlZyM25sckVndG9takx1TXVXRnpDMkh3?=
 =?utf-8?B?TFpHN1FrU2Jqa0tpUzJ2MFdubUtuV1FsejNsa3NoVGFucUcvMzN3OCtFem8y?=
 =?utf-8?B?WTRPd1ptOTE4K1g5SU9hRmMrdGZDWlVrempSVnZFRUdyNENOTTZ2OGl3SXZG?=
 =?utf-8?B?UE9vNU9mcU13QVl3aXNMVzkybVkxaUZWeEhQaVUvYUxkdWxNRTViaHpmZUpM?=
 =?utf-8?B?bUZkenFJdDhDRVQ0L0l4SXc0SCtoMTkyc1FraDluRnB2VWZzOFcwTGhIL2I3?=
 =?utf-8?B?VDhYZkZ4WUxFbm5EcXMzTms5aHVQZm93NDlDd1N3NHlXc2JCd2I0Y1R1TTFh?=
 =?utf-8?B?Snc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bd65272-2736-4bea-e093-08dba9986517
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 20:33:40.0358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MVNEACqxDltRR3yQGcF3clluKmPq3KiaWQlzqWTNc25rjRkeODzVB/Sd+twpcWzg1vmsK8elRZh9wl+PaNaB1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8015
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/28/23 22:20, Ira Weiny wrote:
> Per the CXL 3.0 specification software must check the Command Effects
> Log (CEL) to know if a device supports DC.  If the device does support
> DC the specifics of the DC Regions (0-7) are read through the mailbox.
> 
> Flag DC Device (DCD) commands in a device if they are supported.
> Subsequent patches will key off these bits to configure a DCD.
> 
> Co-developed-by: Navneet Singh <navneet.singh@intel.com>
> Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> 
> ---
> Changes for v2
> [iweiny: new patch]
> ---
>   drivers/cxl/core/mbox.c | 38 +++++++++++++++++++++++++++++++++++---
>   drivers/cxl/cxlmem.h    | 15 +++++++++++++++
>   2 files changed, 50 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index f052d5f174ee..554ec97a7c39 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -111,6 +111,34 @@ static u8 security_command_sets[] = {
>   	0x46, /* Security Passthrough */
>   };
>   
> +static bool cxl_is_dcd_command(u16 opcode)
> +{
> +#define CXL_MBOX_OP_DCD_CMDS 0x48
> +
> +	return (opcode >> 8) == CXL_MBOX_OP_DCD_CMDS;
> +}
> +
> +static void cxl_set_dcd_cmd_enabled(struct cxl_memdev_state *mds,
> +					u16 opcode)
> +{
> +	switch (opcode) {
> +	case CXL_MBOX_OP_GET_DC_CONFIG:
> +		set_bit(CXL_DCD_ENABLED_GET_CONFIG, mds->dcd_cmds);
> +		break;
> +	case CXL_MBOX_OP_GET_DC_EXTENT_LIST:
> +		set_bit(CXL_DCD_ENABLED_GET_EXTENT_LIST, mds->dcd_cmds);
> +		break;
> +	case CXL_MBOX_OP_ADD_DC_RESPONSE:
> +		set_bit(CXL_DCD_ENABLED_ADD_RESPONSE, mds->dcd_cmds);
> +		break;
> +	case CXL_MBOX_OP_RELEASE_DC:
> +		set_bit(CXL_DCD_ENABLED_RELEASE, mds->dcd_cmds);
> +		break;
> +	default:
> +		break;
> +	}
> +}
> +
>   static bool cxl_is_security_command(u16 opcode)
>   {
>   	int i;
> @@ -677,9 +705,10 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
>   		u16 opcode = le16_to_cpu(cel_entry[i].opcode);
>   		struct cxl_mem_command *cmd = cxl_mem_find_command(opcode);
>   
> -		if (!cmd && !cxl_is_poison_command(opcode)) {
> -			dev_dbg(dev,
> -				"Opcode 0x%04x unsupported by driver\n", opcode);
> +		if (!cmd && !cxl_is_poison_command(opcode) &&
> +		    !cxl_is_dcd_command(opcode)) {
> +			dev_dbg(dev, "Opcode 0x%04x unsupported by driver\n",
> +				opcode);
>   			continue;
>   		}
>   
> @@ -689,6 +718,9 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
>   		if (cxl_is_poison_command(opcode))
>   			cxl_set_poison_cmd_enabled(&mds->poison, opcode);
>   
> +		if (cxl_is_dcd_command(opcode))
> +			cxl_set_dcd_cmd_enabled(mds, opcode);
> +
>   		dev_dbg(dev, "Opcode 0x%04x enabled\n", opcode);
>   	}
>   }
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index adfba72445fc..5f2e65204bf9 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -247,6 +247,15 @@ struct cxl_event_state {
>   	struct mutex log_lock;
>   };
>   
> +/* Device enabled DCD commands */
> +enum dcd_cmd_enabled_bits {
> +	CXL_DCD_ENABLED_GET_CONFIG,
> +	CXL_DCD_ENABLED_GET_EXTENT_LIST,
> +	CXL_DCD_ENABLED_ADD_RESPONSE,
> +	CXL_DCD_ENABLED_RELEASE,
> +	CXL_DCD_ENABLED_MAX
> +};
> +
>   /* Device enabled poison commands */
>   enum poison_cmd_enabled_bits {
>   	CXL_POISON_ENABLED_LIST,
> @@ -436,6 +445,7 @@ struct cxl_dev_state {
>    *                (CXL 2.0 8.2.9.5.1.1 Identify Memory Device)
>    * @mbox_mutex: Mutex to synchronize mailbox access.
>    * @firmware_version: Firmware version for the memory device.
> + * @dcd_cmds: List of DCD commands implemented by memory device
>    * @enabled_cmds: Hardware commands found enabled in CEL.
>    * @exclusive_cmds: Commands that are kernel-internal only
>    * @total_bytes: sum of all possible capacities
> @@ -460,6 +470,7 @@ struct cxl_memdev_state {
>   	size_t lsa_size;
>   	struct mutex mbox_mutex; /* Protects device mailbox and firmware */
>   	char firmware_version[0x10];
> +	DECLARE_BITMAP(dcd_cmds, CXL_DCD_ENABLED_MAX);
>   	DECLARE_BITMAP(enabled_cmds, CXL_MEM_COMMAND_ID_MAX);
>   	DECLARE_BITMAP(exclusive_cmds, CXL_MEM_COMMAND_ID_MAX);
>   	u64 total_bytes;
> @@ -525,6 +536,10 @@ enum cxl_opcode {
>   	CXL_MBOX_OP_UNLOCK		= 0x4503,
>   	CXL_MBOX_OP_FREEZE_SECURITY	= 0x4504,
>   	CXL_MBOX_OP_PASSPHRASE_SECURE_ERASE	= 0x4505,
> +	CXL_MBOX_OP_GET_DC_CONFIG	= 0x4800,
> +	CXL_MBOX_OP_GET_DC_EXTENT_LIST	= 0x4801,
> +	CXL_MBOX_OP_ADD_DC_RESPONSE	= 0x4802,
> +	CXL_MBOX_OP_RELEASE_DC		= 0x4803,
>   	CXL_MBOX_OP_MAX			= 0x10000
>   };
>   
> 
