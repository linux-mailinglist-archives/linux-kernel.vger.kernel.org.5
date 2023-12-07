Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98B95807E7D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 03:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442009AbjLGC3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 21:29:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbjLGC3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 21:29:24 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F49D4B;
        Wed,  6 Dec 2023 18:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701916170; x=1733452170;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ViLjkX2nNHj3Mj7/K5tNJyoRp8YWd8P65jUFEXs9QSk=;
  b=jzN0c9dmIWBxsloZNZ9bMKiGEPLXvGRiNFX4FU1gWa5/4OkgwWOZTljQ
   pUKLlZvYF9W/Ggqc6gQoijD1wqgVU6nRRf1myjT8YtH1Rm40OWgu7R2sq
   e9dXGDq7tjtExMrvD13sn9ttQfO5RxqMfA5QiHDNjlR+22yqm79IoC2Dt
   COC87+BKcUuUp1vCL9mOkL+T2c3UQE6kSHKhRCEmwQIQtOioUbEVZeFss
   y/Cs8OyR5iJbP+R7/EV7Bqw4Bmn0hgmn0ec09fLM0PAP6BKwTmJIW3b/m
   AJX8f0IiKuUS74AAGmuiwtbMkjoRLw/DzH9apyq80lyvuhqyGLu3+kulS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="391331706"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="391331706"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 18:29:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="764941021"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="764941021"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Dec 2023 18:29:30 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Dec 2023 18:29:29 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Dec 2023 18:29:28 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 6 Dec 2023 18:29:28 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 6 Dec 2023 18:29:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ztve31G73E9NLIvyFI2iXzYprmDtnBi//kqmmi4c+TR+LbKbPiy550XiSux+tZEQZZbS03QRU4HpKZM8t7qQj06frok4A7B9kKqnt92AQ1mqIfLjqnQhSC1Unb93dZ+51xiqiLIyZCaboYbxbWpwBgIpePVOfBPyPfl6HycxHMWoxbgLCpvsQep0zDmko2soPAKalJhFl+ujstviukzc5WT699+ak8YVI4a4ZJSyMlqN+k1oraJvbukv72RzWFNaAgRsMpjlD7xgUV4JMn+copzO/FMnnEnoxc0WyDCOkNhu9Fk+x2qBiDxGzDpW/UxUUmSJjJsZr1EQZfw3Asxmzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XLZsiBZyez3g9Xk8kWMZQnNh9uDI4fhs8RX52ZdCPzE=;
 b=H5txRTjH+50ncZ8WxMZDU/FfCPXUzmtcp34Y4RyFrW6fiiJRTBkrpeH1JgsXtR+Y+zKzsMRvfaBSKTIOtWvZ8uXu16bIK8D5j17QBMDWMogT+BpkawCb1Px+Jq1SjrPRM1tDludVnyx08FlmWViNXP5yN7lJz5VIKkzEWokMT30BX5pR9drlYzh8ssIGsCtNJoaTFVsYNb65XZ7NSKfI0AjFZTOlrBXKJIcgqVfhf9gZci53eg/F/FBdsc0SEtYAZ/8hv8F6rvbAblkP5zNu6rFyHT0VC2HeFvorliY75DjaFAg9ujiP9mi0gEOo5xmi3GDcxfrX4gw2pgg5YglvSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB7461.namprd11.prod.outlook.com (2603:10b6:806:319::17)
 by PH0PR11MB5128.namprd11.prod.outlook.com (2603:10b6:510:39::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Thu, 7 Dec
 2023 02:29:26 +0000
Received: from SA3PR11MB7461.namprd11.prod.outlook.com
 ([fe80::8174:5130:242a:a6d7]) by SA3PR11MB7461.namprd11.prod.outlook.com
 ([fe80::8174:5130:242a:a6d7%6]) with mapi id 15.20.7046.034; Thu, 7 Dec 2023
 02:29:26 +0000
Message-ID: <5fed153a-6668-c980-c573-3a31077c52ac@intel.com>
Date:   Thu, 7 Dec 2023 10:29:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] cxl/core/mbox: get next_persistent_bytes by
 next_persistent_cap
Content-Language: en-US
To:     Ira Weiny <ira.weiny@intel.com>, <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <pei.p.jia@intel.com>
References: <20231201164005.135912-1-huaisheng.ye@intel.com>
 <656f9a94d9b48_18297729452@iweiny-mobl.notmuch>
From:   Huaisheng Ye <huaisheng.ye@intel.com>
In-Reply-To: <656f9a94d9b48_18297729452@iweiny-mobl.notmuch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0189.apcprd04.prod.outlook.com
 (2603:1096:4:14::27) To SA3PR11MB7461.namprd11.prod.outlook.com
 (2603:10b6:806:319::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB7461:EE_|PH0PR11MB5128:EE_
X-MS-Office365-Filtering-Correlation-Id: 87f864da-9b93-47b4-79c7-08dbf6cc54cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wa4NM+pa1XeNa1yk3T2TW2wueMFt+krxkt7foxbnCZCo8XpL3esCugPw9wDX/mLc43IUteYTJaWjaUfnZlMNNzkj6esEuPt9G9Cj5rhIYiCTRIVXWJNojmvH0EMXz7Fbpky4tkKfLvisHdHk1/Qr23tU8vQ4v6d3E9xOvFu/W/95q8wOlWeGtxlItoGHUziyuO+MJjBHZeteN3IpAoHbZngyGkEvGj1T/bRKheqQrHpNh8CqVzY0hupIU8OmOt45nY3/ZlAiE2K2gqbVw/qhlS/ePa00JyeCtbaDjHtbVrJVI/VN1oMfMocSe0sU05RzOfXb3kHJ+xnMaKbAPM3kPADZYgCTnOcwryriM5yka7aRzj6y9zW3LV6znCtA2j5etdDr+w2MRpBO+HSonDn6kCEIk3y/L9lHarrlSd4OHVQL5jWt9dHvf/9anczZ3e6LKRH1DcFxaItzVrQP6DNeQaXwAxIM5GRlnICRkohnnIuwvh/YUUY1fWuP0caHmWCaUNGKuiV7vtrDwZquEli9fhHjQZNJXHKJ9CIYw1yRN5m+aiZHC6c5Awi88ALC4o0h5yFVB+48rzGPQo9bD4wLg4u5FnaaWa3y5LjM+Nwg5SVl7RyrPy7+HYleoiezB3vElIhoaoHoYrIk1QO3Uc3ykA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB7461.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(376002)(136003)(39860400002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(38100700002)(31686004)(8936002)(82960400001)(8676002)(31696002)(4326008)(86362001)(316002)(6666004)(6636002)(66476007)(66556008)(66946007)(6486002)(450100002)(4744005)(5660300002)(53546011)(44832011)(6506007)(6512007)(478600001)(107886003)(2906002)(2616005)(41300700001)(36756003)(26005)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzhGNTBqNGhBZWFzY0U0WHBqQXNLVDIvcUMxTW1jKzlVUHRtVVc3bU11ek5H?=
 =?utf-8?B?KzhuZm9BVWpRdEUvSFBWZGJjVnkzWXZ5VERBNU1KbTVadjdKZG5lQ3ZhRmJS?=
 =?utf-8?B?QWhITDN3eWJ6U3dSUHloaHRITmtGRW1vc092RDF5SWtpeTRvZ25aVG54TnRG?=
 =?utf-8?B?ZTZvZS9GOXJweDVob1VXNWN0amZIcmNuM2tjbldad251WHdDS3ZZWVZ3QUZP?=
 =?utf-8?B?aGZ0bnJMeWR1YktJSzN4ckpDUFFsQm42aThmcm9jN1dPK1JDQzVsaTAyaURv?=
 =?utf-8?B?MFFlUkNUcHh3Y09GbDVtWkdOaUZTUExsYTZSWnoyMDdtU21XK2lncG9jdXRC?=
 =?utf-8?B?dytVMHdHWVgwSjdwQm1qT2NtNUVGTVFHUDl2OEZha2hTS1p1Nm8wOWQxYVlU?=
 =?utf-8?B?Ymo2cVZha2hRNEhHY0x3YWF2SFM5ZFM3SHVVWXBlSWJPVXNBNnNvWUxqMXUw?=
 =?utf-8?B?bzU5c25EVm9MUE52b1hjMTZ4b1Bid3N3M0xpY1ZuM21pQ1BOelBiOXNNV0p4?=
 =?utf-8?B?YVZ4a1ErQlRud2NKVUF3Yk9XaGUyZGtOWS91MGV0TkNRWHlycWdRd3Z3Y3A4?=
 =?utf-8?B?MmRPK3ovNWJMcWpKWW5Ic2N0K1JlTmxmaFVINlovR2lEbnc5VHo2cGZobU94?=
 =?utf-8?B?VVBwTmR5SjRLc3V0bjhXaHZzL0RTNnlJWTRRWm1oQzVGeER4L014ak1XUUo4?=
 =?utf-8?B?TEJpUWRKOTlvMWl2Y3FlUUVWNDVVcTlVaVM1djZES2poMGRXVTdCQk94VUw1?=
 =?utf-8?B?bHdKWlBxNGJGTFJodm5Xcjh4b3I5d0REOEF5c29iL3J5emdhL3Z5ODRqL3Zw?=
 =?utf-8?B?VThNMFNsWCs0L2taUXhHUnZHMHl6NExDOHBiL3lLb1JUWXN5VDQ2SUhCVEdN?=
 =?utf-8?B?bkNXTHVWUk5EVlZIdjgzMlFlczRMcHlRR1ZxQklnanZ4Y2tCRmsrM1p2Znlr?=
 =?utf-8?B?Qm9KV2JjKzBTUmhSK1RuKy82YUtUUlBrbnpidncrdE9HWVV1R3hGK3FhVXd5?=
 =?utf-8?B?RW1PRmh4dmx4OUcxSzZkdm83ZlhvNXV2Q0lJZXIxZnZmbFE2UStSMkVSWHB4?=
 =?utf-8?B?RG4zTWxjVU93SzgwS3RKY0hDSkJRaENRWVRaRTZYRW4rL29yYTl0Q1dxK3E1?=
 =?utf-8?B?UFpWdFp3ZTZ2WGUweEY2RUY4cWp4QVdUR2k2TFNUd0EwSUp3UG82V1NtZnJL?=
 =?utf-8?B?VjRrdW51ejUrVEY4YUF6WGl2TXFmaE05ZTA3RFFNRnVIUFB5amxyb2JmdldP?=
 =?utf-8?B?RzZvQXhSU0pscnhmdmpnQlRqRGNSeDRTbDV0TFRUN0FydFc4UUJYNDZVaGhu?=
 =?utf-8?B?blJvS3hYT2VCWUNucUUxUkt3Y0wyeEZPN1BpNjRRWEpiZGZlbXlRRjM3Z2wy?=
 =?utf-8?B?N2ZnOTdvN1lIYkhERDlTdzR5WXBmUjVnSVo0TVZ2T0xBNUJxbzh3VXloR2lE?=
 =?utf-8?B?eVI5WXlzSmtObDUvZStobk85Mk5LSmRMSHBHMVJPc2Z4L2x5VmxPSkFhMnV3?=
 =?utf-8?B?T0ZsSW5tTW96eThwNG9wcE92cG1yYXRSaGVqMnlRR2pwSVY3b3E1aEx3K1NE?=
 =?utf-8?B?SzZ2NUlxVkdHV3Y2cGVMaFFEZ0ZWakZTWjlLR25Gc05WU2ZqRHNJS2p5R0ZJ?=
 =?utf-8?B?N2M2aFlyc3lCRFdBNGZpdm9LTHVJUllKR2tPRDJhR0VNZHhtSEc2b0xpS1cy?=
 =?utf-8?B?akpqOGNZMzlKcERmbXRLV0xyWE5BRFgvb0hpUzNxNTVqbDlWdGNNWXkyenUr?=
 =?utf-8?B?TjBkSWhSdkduN0RUeWxoSENIc2pLMGNzOWd4dEhKSW1jMVZSMEljUWp3enpG?=
 =?utf-8?B?TW43azBOck5jVCtnUTdNY2Rja2NoS2c1MkxoV3BnMGhkYmdvcWw5N0RnSExh?=
 =?utf-8?B?ZEVQSk1QY1RpTU52Z2RmdHlIZkJwTkd2VkxSb0pHdFdvVWNndyt0ZnhUQnFm?=
 =?utf-8?B?b2RoZjZlNGMyb1ZqSkRPU09GQk5TTktnOUZEL1BrZjl5RkVFN1JwY0I2TTFG?=
 =?utf-8?B?Sk5qTVIyWDRaakJWNWxIL2FMZVFHNzR3a2NKR3g0Q3NYQWp3NUpPckVFblZr?=
 =?utf-8?B?MW5zMm9tRzV2ajZKcGNVK0VENTNuVmx1dDRhbXRiYVdZL2FuT0VCaVZxU0FD?=
 =?utf-8?B?WmtmT2tNMEEzTmF1YTVVK0lncXFTTng5VjhqckpOZ3FoSjg0U05ld1RicnNB?=
 =?utf-8?B?dEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 87f864da-9b93-47b4-79c7-08dbf6cc54cb
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB7461.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 02:29:26.2593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /kIqwctwXoo3fSFYgnssi32lPlX5QypYjskMIaTc9Xhsj11vC/Oss5+DOHxSn7axTSv1YFm09P/bqoaikR1zFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5128
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-12-06 05:48, Ira Weiny wrote:
> Huaisheng Ye wrote:
>> According to CXL 2.0 8.2.9.5.2.1 table 176, the next Persistent
>> Bytes should be calculated by next Persistent Capacity.
>>
>> Signed-off-by: Huaisheng Ye <huaisheng.ye@intel.com>
> Do we have a fixes tag for this?  Was there a bug associated with this
> find?
>
> Ira

Hi Ira,

This bug could be found in cxl-next branch.
It looks like just cxl-pci would calculate next_persistent_bytes during
probe. Afterwards, it will no longer be accessed by current cxl drivers.

For v78 ndctl, cxl_cmd_partition_get_next_persistent_size is calculated from
next_persistent, which is correct.

May I have your Reviewed-by?

Huaisheng
