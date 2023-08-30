Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DAFB78E005
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240739AbjH3TYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344208AbjH3S22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 14:28:28 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6765AA3;
        Wed, 30 Aug 2023 11:28:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=clUVz4YiSKdLVr6F6Nk3b6hmKUM0yyjn9cnZLBTPwT0Je9/5k/mWo9BC5P6bl2DkDUNy60AKo6UfNfFbHUb/P6+xp6MaRhTE1ZnP9BzZEFGv9t25Ack1/7AQ0XZjKyq/H8gww3ryb+V/V3EeY4I+FpB73nyPMkmYbtTF8jh2BREnjroVOJaKKo8fO47bpddXo+lR9X5ccQZ3y9A/a0mxoUHjYOeYy4fI4gVrzPnT8e8ShONFMpJBRJCMzSa6/t05Adfk9t0rMPDUOms0jF3t7OIAhMgU7Al1tM3/a6kLjWv4xcTWGpTMm0U0LP9BorSCC6YriWis3zj1us+0etU6/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4j6s3Q0qzKJMrKh3Ya3fdIZlzRc4gu3Q8AkVnKc6FPM=;
 b=EDwRTvzatVDqOyUF+v+GW8KQtUycnh79yBWZnLItw76B80NRVAV5WZWX/xGhP+s0e/+mxGnnIfglYCvaTmAfK0u5khTfmd0E72LgylH/BqEs1vz7Ad9PpqA6g+cHttaRuNKFMOqJ10zWPNub88AeqxnpnzlBG5D67XrOFnQNmAWoGrtvcV5yS8M7kkpMaGSpOaV5DkoTGP23Vr+bVaW9tLX4z6awIn560kQoDra8wvJB3gWNkMNuqahcv3nqpxy8zdQnqvR13AuagHmmeNQnOQnZHlMgmX1bXLJClwoCVoV7/Kz/t772WPzqfHHebBq1WHhiRYI42jRRBnMbkh5MXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4j6s3Q0qzKJMrKh3Ya3fdIZlzRc4gu3Q8AkVnKc6FPM=;
 b=Oo5pPHaFUFekAUkXClDjtnIQXwMD9cDp6PNS8ZUwSCLDegy9+J2oIEy+H+ygcKUXYomWBBOnQBkEXJoiaf8DM58b/+klYp8jCXRZZJGYqFjDuSWtTCz/bmMKW4TSsCT/Ari/R49JjG/16tsUykryOXBlV1oLiRWoQh8SpRE1pgA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SA1PR12MB7343.namprd12.prod.outlook.com (2603:10b6:806:2b5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Wed, 30 Aug
 2023 18:28:19 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::fbfe:ec9c:b106:437e]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::fbfe:ec9c:b106:437e%5]) with mapi id 15.20.6745.015; Wed, 30 Aug 2023
 18:28:19 +0000
Message-ID: <5d2911fb-e706-1009-aa8d-71b4d8e456b7@amd.com>
Date:   Wed, 30 Aug 2023 13:28:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v8 5/8] x86/resctrl: Unwind the errors inside
 rdt_enable_ctx()
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
 <54236122-55d8-fd4a-1791-e6f96a61e3f0@amd.com>
 <b48d2489-a5af-d9af-08e6-cbc2d5d8194f@intel.com>
Content-Language: en-US
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <b48d2489-a5af-d9af-08e6-cbc2d5d8194f@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0180.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::17) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SA1PR12MB7343:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a3f9b5b-859e-4cf6-00fd-08dba986e261
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0xXLqHBqSgI710lN4Sk9IE4FFoL64yK46faVgAsIrxJIvboWssfr4DoQS0l96LbhZ2sq9WfLyCc8yJZZ+7jZYRbXv+TOBDTX1u1oZ/M3s8SWK/u/XZ+Lbe65KPyFAz4zWY9jIQgMLh6rw86hZbUT8WE9gtihQ9dKDVqRij5WSu9y4SIzxJXH0RN/ntE0u+oDZpdIBsd0U9DFL7MW9sbT6nGeICj/OiW32hu+3cEPGs6kactFsq6ZkKNhqpnfLrCV7EOFbq6WlZXMDb73lvXUJeuqnmx/CGNcnXR2TATk7iIIhmUYIJbseevI0T+BupLKrE5BsN+WBUUCcakH9Q2/YefieDMIiBGDyE/5gbMe8zFE1hHlnxSSn+SRbX4ME9MgCC9qoIezOBLxei5v/vd+aUKpsaGd+m4GsRkr8SW3vZ18fRH2W2kSBaxe/PnAM7tO+soLGPLTmHYz8Xs1VVX0L9PImStJpQe/O5ynvpuxM/nq4aXknxad5q8GvXArCvmzUjsGGLa0+VMEph1gMe71VRgizPzmQdU8IxktPnTVeX0qM8XqG8cTvVKo/j07Ub8rjCFtGjrApKXlwtPSY986ZbnjXBE3jLuOh0bkRRvt4N1qrstmdJb5n8IG4mge/vHQd9qMmet65Vej+Gklvchgcw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(136003)(39860400002)(376002)(186009)(1800799009)(451199024)(31686004)(3450700001)(2906002)(38100700002)(36756003)(5660300002)(7416002)(7406005)(86362001)(31696002)(8676002)(4326008)(66556008)(41300700001)(8936002)(26005)(316002)(2616005)(6506007)(6512007)(6486002)(53546011)(6666004)(66476007)(478600001)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUh2NUdOZHM3NWF1WFAya0hvczhKQUZ1ZjRHQVpXZHpCZ0E0ejIyS0E4d2dk?=
 =?utf-8?B?OGpUSnE1ckQ0Z1dRRnM5V2dhVnBjSDNXeUFSbGtZWGY2Q0R1RGVlc2NNa2xh?=
 =?utf-8?B?cFBOdjJtcW0wbDlWMi9TMmZFQjFScFdvMUovTzdTQnNsdkpHUGJHUHVUOHBZ?=
 =?utf-8?B?M1JFWjFVbWxJZDlTdjdxb3V0TW9JQlRWc3lDY2h4RG9MSjJnbnoyNnBSR2oz?=
 =?utf-8?B?aTJFOTFVUWl0ZWpaRXUzQTg2TTdwU1FKcVlHTUhVZ3Nac2VUdXpabHYzOEta?=
 =?utf-8?B?WnVEUGIvQTRxRUpXMlVKdTYvOTR5WlBZL21TT2pCeTJKblprbWd4azFTWDM1?=
 =?utf-8?B?SmtXczNzWHY0Ry9lbDl3T0JVRjN1RTJJVjQ2NGdlcU9zQkFhSEtrYjd2c0VI?=
 =?utf-8?B?dTgvYmIzcGtQcW41Yy9heHhWT0FFWU1sd2tydGRseTVwU0psZ0tFTUpwUFE5?=
 =?utf-8?B?RUVVNkVTcEltOVFWd2txMkNCd3hac0VpM3VDM25oWU5IVjJUR1JWZnU5UmQv?=
 =?utf-8?B?YndLTFVqKzcvUkpUODdrMWs0YXFKWkg5eGxRelRDTEg0Y1Fzc2VTeWFXZXds?=
 =?utf-8?B?VEphVVNvc1VveVBTYTBabndna2ZmbGhoLzFxYVl2MHNWcU83Ykc4dUpFbDha?=
 =?utf-8?B?VzZwWndyL2hXbzBrRVdxT3g3Sy9ObVhncFhWWjhoZWdsOThqV0V3ZDRuK0xV?=
 =?utf-8?B?dmRtOGVCUkJ5SktkUW9pYVVJRndtZWtNUitrcE02dDBJa0s0NGl6R2cvZmcw?=
 =?utf-8?B?VTRHbER5R0FKS21ROFgxQysrS0Y0OTQ0bVFSZW4rc2crQzAvbEpZSkZVTnV6?=
 =?utf-8?B?VFFuZ2dESzJEbE9qSTZkVTJ2T054NEwyZGtIUDVoU0dnbkYvOEloNGFyRDgz?=
 =?utf-8?B?MlNYOTdZc0pGVEh6RWRXZEgvWVJ1WEdFYk81bGFwU2o0cWpkU25oeElWVXN3?=
 =?utf-8?B?U0lSUmhlQVN5MngvbFhMeXErN3hnVWZoZ0FOQ25EWHRpOFpiNmNwbXpzVmFV?=
 =?utf-8?B?TjhKOVd1c3pRUDNHWnd4anlFYlZtL2tUdWFKdU84T1BnZXBFVzFSL1FtVlN4?=
 =?utf-8?B?NlRtV3BPVWJNOVhybDY5WnVPdGsrQlNGbDROSDhRQXkrUlBqb3RxUVJjVUxT?=
 =?utf-8?B?dytPd0QybDExU3ptZkV6a2gyQW5VUWp1RXNXWG9IMTRXRlJZdnFvYXg5M255?=
 =?utf-8?B?VWk0MjZaa1ZoSkJjellXcGhuaDRjN3hPRkNuNnYvT0YwU05jaEhGWXNCaHpk?=
 =?utf-8?B?VkhrcnpSbFUwcGd6ZjI2Sk50TmoxTG1tMXlVQTBxdEtjS1A5Njc5M2RReG5V?=
 =?utf-8?B?SCtCdGR0Q1Q2anROUDM2Q0RlUGJqZTNZNTRMa0p5ZUxrc2Zob2piZklLRXhs?=
 =?utf-8?B?WFl0cGFVNjk5OGx6NEZBM21oRUdFODEyMDZhTEZlbDVteWpGTlJvMXQ4WStG?=
 =?utf-8?B?SkNSSWJBVVhZSkFkZjZ5dURPelhMVmpiKy8rRzlWN0M3U1ZVWjY4djdwKzlX?=
 =?utf-8?B?TklsWW5kcEpDUldxWWVYNE9SYy81OEROOFFUR09CTHA4cVRCYUQ2RkNCWFVz?=
 =?utf-8?B?ZlVGTTZqUStqSUJ4cVR1b0xFeXlZRllVemFZUWZpbzhQQWlVVU5PL1dzdXpR?=
 =?utf-8?B?Q2M0UHNybXFBWVFHNGkyQ0J4dXI2S0tneVE0ZGhYZ3BpNldOVEVDQlNGeGkx?=
 =?utf-8?B?ZExKN25RYUIycEFpRkRYWnUxMHZCcDRCWitQQUZNUHNUbU5uc1h5eWd5OWZm?=
 =?utf-8?B?MzNQWUpyU2ZKNENWY0tHWVo1RjZvSHFVR1A5aUVLUXIrN09hRmZ4akNpd2Ur?=
 =?utf-8?B?OTJwdjk4cnp1VWFJNGlmQjhobndZektrRE43Q0tLNFBuVG5GdVEzT2l4eUlH?=
 =?utf-8?B?TmpQWFRPdmVFQ0ZIS2g2a1J3QzFxUkNhKzM3aVRyQzcvdWtrL1FRZmJYWGli?=
 =?utf-8?B?MmgwVldGQkkxV1ArUUJ1NlZFK2YrMEwyaGpiUUhaWFU0M0NRbzd2d3I5V0ZH?=
 =?utf-8?B?Z1RMQWUzZmRwUmo2TjNCVERUSWRsbGVFdmUwRlZjMlhTYWpndXN3dkJycGxt?=
 =?utf-8?B?N2tUdC9PQUpocFJrRXpObUt1Nm50MDRETjJGMXhjVC8vQkZ1VHhnWGZyTDZQ?=
 =?utf-8?Q?Hk80=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a3f9b5b-859e-4cf6-00fd-08dba986e261
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 18:28:19.3824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QAY7ElIcpBxAGTRhYBu2edFQgJSKQZBd4y3RmlqBGGVi0Zz0IltMqU6BDxHnl9o3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7343
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

On 8/30/23 12:56, Reinette Chatre wrote:
> Hi Babu,
> 
> On 8/30/2023 9:38 AM, Moger, Babu wrote:
>> On 8/29/23 15:10, Reinette Chatre wrote:
>>> On 8/21/2023 4:30 PM, Babu Moger wrote:
>>>>  static int rdt_enable_ctx(struct rdt_fs_context *ctx)
>>>>  {
>>>>  	int ret = 0;
>>>>  
>>>> -	if (ctx->enable_cdpl2)
>>>> +	if (ctx->enable_cdpl2) {
>>>>  		ret = resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L2, true);
>>>> +		if (ret)
>>>> +			goto out_done;
>>>> +	}
>>>>  
>>>> -	if (!ret && ctx->enable_cdpl3)
>>>> +	if (ctx->enable_cdpl3) {
>>>>  		ret = resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L3, true);
>>>> +		if (ret)
>>>> +			goto out_cdpl2;
>>>> +	}
>>>>  
>>>> -	if (!ret && ctx->enable_mba_mbps)
>>>> +	if (ctx->enable_mba_mbps) {
>>>>  		ret = set_mba_sc(true);
>>>> +		if (ret)
>>>> +			goto out_cdpl3;
>>>
>>> An error may be encountered here without CDP ever enabled or just
>>> enabled for L2 or L3. I think that the error unwinding should
>>> take care to not unwind an action that was not done. Considering
>>> the information available I think checking either ctx->enable_...
>>> or the checks used in rdt_disable_ctx() would be ok but for consistency
>>> the resctrl_arch_get_cdp_enabled() checks may be most appropriate.
>>>
>>>> +	}
>>>> +
>>>> +	return 0;
>>>>  
>>>> +out_cdpl3:
>>>
>>> So here I think there should be a check. 
>>> 	if (resctrl_arch_get_cdp_enabled(RDT_RESOURCE_L3))
>>>
>>>> +	resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L3, false);
>>>> +out_cdpl2:
>>>
>>> ... and here a check:
>>> 	if (resctrl_arch_get_cdp_enabled(RDT_RESOURCE_L2))
>>
>>
>> I know it does not hurt to add these checks.  But, it may be unnecessary
>> considering  cdp_disable() has the check "if (r_hw->cdp_enabled)" already.
>> Both are same checks. What do you think?
> 
> Yes, good point. Thank you for checking. Considering this it looks like
> rdt_disable_ctx() can be simplified also by removing those CDP
> enabled checks from it? Also looks like rdt_disable_ctx()-> set_mba_sc(false)
> can be called unconditionally.

Yes. We can do that.
-- 
Thanks
Babu Moger
