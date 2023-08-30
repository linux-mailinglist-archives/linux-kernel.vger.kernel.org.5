Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9070C78DE78
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 21:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237475AbjH3TDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343706AbjH3Qi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 12:38:58 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7215F19A;
        Wed, 30 Aug 2023 09:38:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oHAH9R2v6Y+0S6Mu5jtYtCyM64XUcDKODSchbqzD8qUlZZaWMBDQFh5pNXpnrXwmVTK+7k15+O9SyxxLeydKUUMPWGxC/ttWEr8NjjQnMwzKKuMmQ2/C6ZYAtYLPvP0/v+L/hzSkiaBIq4Osx/tey1js/4DtwQ+lhHPkeXNoEgXMS7Rm0SZpHdaMESHrojRGK0vAwYNiKGwZMg9NuLA3J0d5HEFEOSegoJmbv6/C83jPuQhytcw2Ut8pIP70riRGG+WVTyEoWsKYVKQ4u8CRZliPkgAZ0LI5O7cRXndtSUizF/bDsUlRgWcEf1t4dgYANISzn2iQ8wRZmYWGnH4mRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ikBdIrPjbNXdMPwYk5nIroh28SFohaTGUBrQi2BQWHk=;
 b=iNT60jPx6IQPV3KcMJtuKjIdHXnIOAl6ETKg3/rvsVnGBclX4QGjXowMp/0YodDtnYbRur4X7qRWcx7GyDxlGnW7DzPYxYtGslOn5gnvdQ2O23tWAicfSXVO8/d2Mt0DLrDzFQkGEO/cZS07C8mhYI0KUBYIg9z2O8i1+eM4sfq/BLYIQmcEA/Gt2KNjzNhNwFcYEEWd4Jehose+uAXhI0f9sVsXC8k2lbgVxdt306BVN0hkk5fnUOBiVaCZ808Lqdm6hyt9TrJNaCI496z5kvVGH22dnVEzdi8Beh9JrPHfn2DmUOUOroLiaXf8BeM6cg0NSVIurqHmxZizJooZyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ikBdIrPjbNXdMPwYk5nIroh28SFohaTGUBrQi2BQWHk=;
 b=XZNy01gn1w7Rt0yDl1dEghnfpGIqO0F4PzX1ttA7ruc1/Z7ZD8pDiFdNDQGcMYPTLTawqIEWnSbI8Tq853KF/crN7CdLclfBTJHuq2nzAeudLMh4McUDExh6tBXiq4QZcbS/hXSC427tubE62ua10n6TxYPPmUroDOi5wjdVBcw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by IA1PR12MB7686.namprd12.prod.outlook.com (2603:10b6:208:422::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Wed, 30 Aug
 2023 16:38:50 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::fbfe:ec9c:b106:437e]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::fbfe:ec9c:b106:437e%5]) with mapi id 15.20.6745.015; Wed, 30 Aug 2023
 16:38:49 +0000
Message-ID: <54236122-55d8-fd4a-1791-e6f96a61e3f0@amd.com>
Date:   Wed, 30 Aug 2023 11:38:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v8 5/8] x86/resctrl: Unwind the errors inside
 rdt_enable_ctx()
Content-Language: en-US
To:     Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     fenghua.yu@intel.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, paulmck@kernel.org, akpm@linux-foundation.org,
        quic_neeraju@quicinc.com, rdunlap@infradead.org,
        damien.lemoal@opensource.wdc.com, songmuchun@bytedance.com,
        peterz@infradead.org, jpoimboe@kernel.org, pbonzini@redhat.com,
        chang.seok.bae@intel.com, pawan.kumar.gupta@linux.intel.com,
        jmattson@google.com, daniel.sneddon@linux.intel.com,
        sandipan.das@amd.com, tony.luck@intel.com, james.morse@arm.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bagasdotme@gmail.com, eranian@google.com,
        christophe.leroy@csgroup.eu, jarkko@kernel.org,
        adrian.hunter@intel.com, quic_jiles@quicinc.com,
        peternewman@google.com
References: <20230821233048.434531-1-babu.moger@amd.com>
 <20230821233048.434531-6-babu.moger@amd.com>
 <343d12e8-9934-9194-cadd-7d133567396c@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <343d12e8-9934-9194-cadd-7d133567396c@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR13CA0001.namprd13.prod.outlook.com
 (2603:10b6:5:bc::14) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|IA1PR12MB7686:EE_
X-MS-Office365-Filtering-Correlation-Id: 04ea902f-4a80-4c99-4014-08dba9779690
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DUrwbpKi9H4EbYGUfbL3rpaLVzZdvgwZtYxNaF8j88TxH+Az7UOIejBd6EEVhGV/MYTdoEPDW3HORNbeP698tA5WqrY3i87f8oKtwwbClbBuOy0ST0L7lHdCkBER+4JWBLiY/EXkOER3iZNKVBIORHicHaOdFECNSxRE3Xh4Emfc2WZh7EG4xko6jgk3o5M5KwTjIvwHpGkzpq099jDluLsH58DbsMlsxRp2klzGwgUp7lk2+0WqEFS39ZvKQI9CTcHu2RawMmEyZSw/B2DIxag+uiA4zS38dQS6PX2TwQWQRB/X20YSuN4wpO6kAXObevgs8bgN6PZo9JbQViD6OA9Lb8G53F69NBTACDx/eN16K03o1I38ISL++zSDaY8NCc31zd/bS1Ac7jYnEeDnXugiSY0QjUsU3RGY8U/m59VIL9WgorsCPSs+n9jnFyrOpcPwL1r8+fUQKUp2MnP91XfhsidKF1MzW4QhBZVUyWk2tTa+fmJ4usblEU62JX6d3ewlOCZzX11xGMs5tluIFSZeJkGjra4A/dqk0HMtlVkMQjQRAfypSliOEM4VI21cblDBbZjD4HDbKc69+7BgCpLXJVwInA+apKu63FS30RcGtOxFTDGr2HQLzWrRwx6khL7L2zGrbAW/JrsOZN/klQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(366004)(39860400002)(346002)(451199024)(186009)(1800799009)(31686004)(3450700001)(2906002)(7416002)(7406005)(5660300002)(36756003)(86362001)(31696002)(38100700002)(8676002)(4326008)(41300700001)(8936002)(66556008)(26005)(316002)(2616005)(6512007)(6506007)(53546011)(6486002)(6666004)(478600001)(66476007)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlZneHRTOG91aXEwOFVLMVQ0N0xrVFIwSXl5TWJZSWlDOUtlWlptV3l4ejlW?=
 =?utf-8?B?ajgxYnpJQlRKWjErLytuR0cyVzVSTkphWUxrVGJ4RUdBSE5WWWZ6S2p2akh0?=
 =?utf-8?B?Y0wvOGtzbytTZjRkaUhlMXRxbkdTMXVjRjhGcXJWVG81UWpHUjgvUGtyRVJt?=
 =?utf-8?B?UVhuc214TU9Ock9CVm4xMXlwRDNSY21yTlJJaDc5RWFPRTBFVU9tTDZiaE94?=
 =?utf-8?B?ci9TckNDdUZickE1VWJMcDRLYXFwOWdQRCt0bExKTzFJckdRQk8vUnZrbklH?=
 =?utf-8?B?OEJ0TGJsVHJySGZFdVhwWEVyYi9mKytTM3lZVmYvOXhBckV6Q3h2b0F2RTJL?=
 =?utf-8?B?TkhxMzNwdXExaXVDVTI3TXRFUVZXang1dkN2MzhmY0FlcHBPVkFuV0pSTzU2?=
 =?utf-8?B?Q2I3UkFzUExsOS90TkJteUVNemNtZERKVVFac3NnNnVuRHBucXlWTlljbWta?=
 =?utf-8?B?V2plTEk1NU5lSlFuRWFGNDhZMmVkUWdxNjFySXZKRHJ0RTdZM0hJREFFSG9h?=
 =?utf-8?B?dmxaN3hkeGRXdmpYT1hKUzZUTUdZU0gzTVhka1BzMDUzOXg1YVluS0cybkM2?=
 =?utf-8?B?L2RkdFFCZmYwSWplM3dzQTM5emxMb3NsVmVhNWcveWNJRm04Y2N6aXdiZDNG?=
 =?utf-8?B?RnpFYU1YV0krWUZucWxvNXZCRi9XZkFIcDB2dENnTGIwc1grdzZ5ak8xMngy?=
 =?utf-8?B?TG81RnJMbEtucElvNkxVS1AvYkRIdit5bmlyNitYRTJVaDVsSkF5eXljSlIr?=
 =?utf-8?B?U1ovVTN6TmhwRzF0djVCd3pHRUEvcGNKOXRpMFRHQTIrSmN0K2VDayt5b1Ur?=
 =?utf-8?B?N0VUdXhXeVp0bjY1NVUzdk0yQ25FbWNXZ1pXeUVnZklpYlF1OVdKN1NjaEIx?=
 =?utf-8?B?ZnRvaFlDaUhWbi9lanlrYmx1dVhxWkdmYlhLOUpwS1U1bXA4ZGFPODkvVW5n?=
 =?utf-8?B?MXBsaUprcWtxdW1McjVXSURUWVJoWHB5SmgwOWJOUkdDL0pUMWViOUtvaVA2?=
 =?utf-8?B?dkN2UzkxMEVoL20yeHdEeGJEUU1WVDVvOGZKeDRLQVdheHE5WWRBRnB2SXUv?=
 =?utf-8?B?WEU2bTZpS2ZNeGZCeWt4YnM3U0JDV2hhMXIvLzVMYXNrTVUzOWJMTmtyVk9S?=
 =?utf-8?B?b1FuVHFZNWpnVm9YUWNNdUtQOVc2dzhTcEx5ZDNBQ0lMaEJlNVlJNnA1MmtM?=
 =?utf-8?B?dWJlcjhnRE1OWVdNYkY3QzZtQmRTaEhSYlB6Yk9Sb1RKQlRSTktGYVkvcmho?=
 =?utf-8?B?NTREQmdUUVA0TlRMTllBUmRkS2NXZlVVQldYcmlMWXNOaHdLOG9sNVdTaTZ6?=
 =?utf-8?B?MlF2YWhqSmFwT3Q4SkEzODF1ejFwSGl4SGdzZ0Z5ak5UcWE5TjdJOWlVUHdH?=
 =?utf-8?B?aHZXSmFQNHRNREU4NndqSS9yMk9RdTF2eVVWMlV2eUsxMFdFYUpRY1dqeGs5?=
 =?utf-8?B?RTZDVldQZVpLMlJHbWJnZEtWQlNVVEFhcnJ5bXR6YUlLVXBzN2FHMGtaNHh5?=
 =?utf-8?B?ODZ2TEl3WUxTQzRkdG5qdVF5dmRBR2lpVlUwSWgvVUFSOU5IS3Yzbk5nOEFQ?=
 =?utf-8?B?dGxhWDVIREQxWmxqcGJJQWxMUnNZTzRHZCsyMHI0c2l6YVpSSTJJeUdlUC9x?=
 =?utf-8?B?enF3Q3F6TGZMSkNLYjJEU1RmM0pMRlVLWml1QUk2QjNSaWkyUmx5aDkrV0xU?=
 =?utf-8?B?R0NyaWdzbXlRVmxXU0g0azZtbGg4VTFRc0tjMUhTdnppbFBkTEd1dlFubzVD?=
 =?utf-8?B?TFpRd2ZxcWlZdzlRd1FrcTdFUUxWenVyLzBvSnBBbjNqaFZYZ1dpT3FtRmlq?=
 =?utf-8?B?eWtZZHhUeHVMZ25FTXRUYis3QWorc3J4M1liaGx1NlpMcGpaSWVVbkJRMnk2?=
 =?utf-8?B?TFF4R0tDNWVSbkJCWlJCcHlBdmZkQTdOM2pVK0VNeno4RjNicVowVlpjSzB1?=
 =?utf-8?B?REs3SXQza3dGRWNyZFBTWHp3cnRkaDRNcmJyNmZqcEkrMzNOU2tyTEZiVTVw?=
 =?utf-8?B?RlhwQ3orZy9tSFcvanNhRGppZGVhZ25tUU5zNFRTbEJuTjdZT3hMVGFCV3dr?=
 =?utf-8?B?OXQzR2hpak9mcHorYmZxZ0lvdG12MGVvUmZTR0VaZk8vc082Rm1pVzdCZzdZ?=
 =?utf-8?Q?FW0Q=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04ea902f-4a80-4c99-4014-08dba9779690
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 16:38:49.7478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iLf068FzBoejEmk7GpTRcuKd07MWOyNIkyDUHC7WfFho6ah54KCaZM/8lXC2sdPG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7686
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 8/29/23 15:10, Reinette Chatre wrote:
> Hi Babu,
> 
> On 8/21/2023 4:30 PM, Babu Moger wrote:
>>  static int rdt_enable_ctx(struct rdt_fs_context *ctx)
>>  {
>>  	int ret = 0;
>>  
>> -	if (ctx->enable_cdpl2)
>> +	if (ctx->enable_cdpl2) {
>>  		ret = resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L2, true);
>> +		if (ret)
>> +			goto out_done;
>> +	}
>>  
>> -	if (!ret && ctx->enable_cdpl3)
>> +	if (ctx->enable_cdpl3) {
>>  		ret = resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L3, true);
>> +		if (ret)
>> +			goto out_cdpl2;
>> +	}
>>  
>> -	if (!ret && ctx->enable_mba_mbps)
>> +	if (ctx->enable_mba_mbps) {
>>  		ret = set_mba_sc(true);
>> +		if (ret)
>> +			goto out_cdpl3;
> 
> An error may be encountered here without CDP ever enabled or just
> enabled for L2 or L3. I think that the error unwinding should
> take care to not unwind an action that was not done. Considering
> the information available I think checking either ctx->enable_...
> or the checks used in rdt_disable_ctx() would be ok but for consistency
> the resctrl_arch_get_cdp_enabled() checks may be most appropriate.
> 
>> +	}
>> +
>> +	return 0;
>>  
>> +out_cdpl3:
> 
> So here I think there should be a check. 
> 	if (resctrl_arch_get_cdp_enabled(RDT_RESOURCE_L3))
> 
>> +	resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L3, false);
>> +out_cdpl2:
> 
> ... and here a check:
> 	if (resctrl_arch_get_cdp_enabled(RDT_RESOURCE_L2))


I know it does not hurt to add these checks.  But, it may be unnecessary
considering  cdp_disable() has the check "if (r_hw->cdp_enabled)" already.
Both are same checks. What do you think?
-- 
Thanks
Babu Moger
