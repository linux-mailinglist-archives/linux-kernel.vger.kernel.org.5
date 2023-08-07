Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E601772A68
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 18:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbjHGQTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 12:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbjHGQTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 12:19:30 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4812D171E;
        Mon,  7 Aug 2023 09:19:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kJfHELfIl0rWnG2JIj6MwS5S49OO8HAMc2uPSH+HibrKBzRhJ2hvu2SGoMbHbXydzgGs04C2UBN9URVpFwWFcO1SqdRv0qwKdhof7D0gzUR/OfW9kP28/79xNdytMmIRMybDkdbHSFagMBxFTtlguBV0UnqoMfw0RfAaXrHJhzroaf0CZTuXISPnrOGzb4mLpRZVD85lHueCFKWzNYDdV63cjM1uQNtRmxSJFoDHcQVVYcsHn9vC3KRCtSWko2/R60xYGQBp4alp+mn7Hj83tvV429rKilVMwXyrRKqUL0PuQG3B2hEdFFFHRGynKKHibMJnIwQgZwXqpG9JKwGoGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dyuCoYj8aa1WJtqqdBooRvy3Xn5kTyvGlnIXqR6LQlo=;
 b=KH5NaNf9MYA1oDVFRfLa9gFFkOi/5eHwnU/FCv1/KPTr2aGIdClmbWz2FCTZR7XOmPfFkONYX1NrqZ92yWUdXN6sSJtUviPVaaUWbEp6QBr+fXzMvojJsv2fTUM6BA5Fh8MYxsgzOACtO5hJ670W6DOdCmGTRxf1HEV1AOP7L0TaVgE11LxHtDr1wrngXy0GUz5R0/dIdA5KzrnButRp2ZopV+SE/U8/fgfWYIREcQJR1yr/i6zJvARbxLcfrH26tJdjA0LiV8x5JcTECL7C19IJZXqGuuLHlUx2YQc5Sdnq/8oZVLOqxySWcfDI/GCbPl4CTiJTUFm1cddphNnY/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dyuCoYj8aa1WJtqqdBooRvy3Xn5kTyvGlnIXqR6LQlo=;
 b=TAVBJ2CanluNiQAYFmi4jFDC2JzWqb8vRrwTMNfazb6ciA5Wg8TsDI7cltKJaK7TP4CVgKr/fhQ5xvS+UBEKGYPp4WtL0bmEJfVz/awx1z+HjESvSs2x/8iVStgu2lwkICrUxdsclrmkcbHC2p6Kb54y+vd10a90aY6Y+w1t0Qw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by IA1PR12MB7520.namprd12.prod.outlook.com (2603:10b6:208:42f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.25; Mon, 7 Aug
 2023 16:19:25 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::ae3b:f153:4d30:73a8]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::ae3b:f153:4d30:73a8%7]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 16:19:21 +0000
Message-ID: <ef509f34-954d-61c0-f730-2cbc93eae4b8@amd.com>
Date:   Mon, 7 Aug 2023 11:19:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v6 5/8] x86/resctrl: Unwind the errors inside
 rdt_enable_ctx
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
References: <168980872063.1619861.420806535295905172.stgit@bmoger-ubuntu>
 <168980892326.1619861.2405779251348138586.stgit@bmoger-ubuntu>
 <9fd70ef3-ca90-65e3-4746-7d574bdd159b@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <9fd70ef3-ca90-65e3-4746-7d574bdd159b@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0129.namprd11.prod.outlook.com
 (2603:10b6:806:131::14) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|IA1PR12MB7520:EE_
X-MS-Office365-Filtering-Correlation-Id: 54417a61-0455-4154-7527-08db97620ede
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lmzQeq0css0azGeYCdZnEWwvVPWPOOS9b9oJgj77Sl228+zJ1x4ctnbeb+mtKW956aoPpXM1wNUw16sdvhQttMTtRpbfOkGvs7tx2WssmiHQWsYgm8/zh6vWanyoMlHl3qNfaofq3pmHICzX4xO6pAHacAicETM2DqhQgGQe82cT2ikUCPOQzRyx5bbdvZdd5C3DljQkm3Yl5MDMsD9AfDqDpTTPIP3ZjrjuIOseGxgeAedt4hsTk3J8nUDUSW0IvU09aGfZsCIWlRp8DlWTqvEZsmmyP/GP2P+izKPWZwFdAnvrzhcBFE2ExlUIKqxr0SVmV2g/IIpCXmSRgmoY/iojp6e3mu5Sk9HG04URt52TV6b8AQU2/N2wkHmfVzpd0aK39pctVWhKhpLCJkjRujBervY312kQM4FnAvP0Ph06IOeKlBWyRbpk4Gg5DJjIcMGANGEC3Zo6gJn9EUa5inR154rNxvOSXvkpzkiwVXOuk1XP52yeSVYzzNmwarmR4VwYR6cw+Ju+sp5XqoneeHCZyhYWvdwhq0TRxlAKkbaB2DO3LgRgsDP49HGmAYm24M7ljR8FXEc3GlLf6MsRUdw6T1efmg7xd6wCWwXUBhXqci8GJxeyppB9D7N9zxJrBf8Qmrja8BCNNtvXO+9yRw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(346002)(366004)(136003)(451199021)(1800799003)(186006)(2616005)(6486002)(6512007)(478600001)(86362001)(31696002)(26005)(36756003)(6506007)(53546011)(41300700001)(316002)(7416002)(3450700001)(5660300002)(8676002)(8936002)(7406005)(38100700002)(4326008)(2906002)(66556008)(66476007)(66946007)(83380400001)(31686004)(66899021)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anhUM0ZoaWJ4dit4ZlNTMGp2QVpVUUZ1amRvUGgxYzU5cktJbGc3OFVib21C?=
 =?utf-8?B?K2V3L0tJWE45ZkxTQXZsaWV0VGJrNVFNTmlSZTg0SGJickxVbzlxSGZKTStz?=
 =?utf-8?B?RmNZL0xEQWdPY1dKZnBpZExCRjZJd0l0N2MycFk3Z0UwWlRJVFdFNlFLNHdK?=
 =?utf-8?B?MENuZWJyOG5PZEdNMEdhNk0zZ0FaYUZyakgweGZvVTlENUhpZk50WHMwRU1C?=
 =?utf-8?B?ZkdFNE1Pc3FaVW92a1U1VXZoc2Y2KzFiWFpXek1EM0ZTYXVObnRhb0dJZHB3?=
 =?utf-8?B?TWg0TUZPZGk5NDk1Nmk1UlVMWHpnVG0zWTVRaDR3T3U2QkJiM1BTLzR0MFcz?=
 =?utf-8?B?WVFXdG1CaGVrZVVWd2lNY2ZQcmlOS3ZtQzBnWGNINkVWcTQwVzFnODF6UnpQ?=
 =?utf-8?B?NkpreWNzTGhCbUF5QjZqT3JNZDk4Ly96eW9WKzFMMXZkY0FKcDVoU2JmMm9E?=
 =?utf-8?B?d0F3RlNib2N5Z3k4NndDbnJMSDhSSkFuM044UVMweEErdHNRTlBTNmRiUDRV?=
 =?utf-8?B?aTN3SWFWUlNkK1BjaUV3cUx4ODg1SnhoWjJVN3JsRGFzY3F5OUtnM1dhY251?=
 =?utf-8?B?Rk0wTEVWc2EwZ2lqODRrMVdVbUw4bFIyUWk2SWR0YzU0SVFweEdNeDVsc3p3?=
 =?utf-8?B?VDNNbmZQT1QxajlDeWFCbDhCSHVTVUswRVRGRUlkQXRYUXVnMnNLSEJxajN2?=
 =?utf-8?B?K0k3djFwZ1FwQ010STdydnN5Zk51cTd1OVNNcW5kWVI4bHBKOVN4WWJTSFhM?=
 =?utf-8?B?UFRjKzA1Q0xaZkdPMzdLTDRHL1F1R0YzdlJWbWdIM2g3cTMvSjVPL0I2Q2Fa?=
 =?utf-8?B?OCtUTEVxRSs2ZFZjWTVqWHJWR1JMdzRzb3FWOHptOGdQbjhrekhWT2xtVzRq?=
 =?utf-8?B?YllvRzBZK1VsOU9rM3ljbFdwTTJ2NEtZQTBvS0V4OW9SM3UxZUtCSnNHeDFJ?=
 =?utf-8?B?b0Fab3Q2NkpNejBVdHY0QU9DZU50RWNud3BIMWZBWEc1MitDZXpNN1puWGxa?=
 =?utf-8?B?SXVmdW00Mzc5TlBSUTk0Nk1HOXd6M1MyRUxtN3NDSm9xMnVLZnlnTFpkWHVa?=
 =?utf-8?B?RmZpZzlzRHRBVHhuZnlRd1UvV3F1TGVzUXNYRXpmaGVFUmFlU3drRXVUVFBL?=
 =?utf-8?B?Y1hLR24yYjdtN0RuUUxUWmhyVU9oekJ0MnJRWmM4TzVadWhHMklaeHd0SVo4?=
 =?utf-8?B?TXRZU2JyQnhzbkNaQUYrbGFtKy80b1JMQkRHUWt1WnpDZURMRkM3T3cydGZw?=
 =?utf-8?B?OGRPZDhNc01JNFlkZTU0SzQ4SEFHMU04TWErbDBYNVRLYzNCbUtRQi9SdG5X?=
 =?utf-8?B?Nk42d29IbDNWMnYxOTlKY2Jlc1hBRWhQK2JtWHJiemtiOVd1SGlmdytUdndZ?=
 =?utf-8?B?a2Y5aTBoR3o4UVIvVGwzMnB4WmNFVGF4ZlBZclJXdnZoYlIrZ3A1VWpoK1pB?=
 =?utf-8?B?a2xyNS9XVGxueEliSGhHVjZVamluclVWMmZ5Ty80MzFLN0g0R3VZRW5HMm1i?=
 =?utf-8?B?V1JVOG8xOXdDZDdpQXlMZTI0RDZFdy9RUzBHaDgwdlFQRWtwNk5UT2ZMWHhR?=
 =?utf-8?B?WHBObGdFL3paTDlaYTBGL1BiRWZMdnZUakQ3OGZyQzVVTmxkYkhvWUZ3NER2?=
 =?utf-8?B?bnRnbVpSSC8zcGtsYUsyUUNGd2ZrZE52NEJZazlNMkxuck9lZ2V5NVpKRzNM?=
 =?utf-8?B?Z1JqUEtaSVB5eWhUYVh3cVlmbjNOMlNpSGpwWlJBeklmKzZ4V1QzNlJnSzRu?=
 =?utf-8?B?eEV2ak9LNS9Qdi9qZzZGamxiZk9ueTQxVWszS1VlWTZPZDB5QWZPZ0pDbk5k?=
 =?utf-8?B?SktmK0J5bEJ6SUdFNHd6c0dDNGdUQkJjdExESWFYN002WERPbGI5T1M4SG5R?=
 =?utf-8?B?NDZCRmsrUUpaeHFUT1huSVFhUGhiUVRqckpLZS9vTzJMM3UxMzFDL3dYaHNI?=
 =?utf-8?B?d0MxL1E0cmt6OGVTWjFnNytSQm5GREk1cE1CZ1R2UHVDa1hhV0NtU0Y1aXZS?=
 =?utf-8?B?M1JpWlF5aXZLU2s2SnFabzdEZFR5QnN0a28xaDhjdUoyWDVCWklpVFBmUG1q?=
 =?utf-8?B?cXhwWWFDVEJCcnhMME5Jdm4zelpXNmkxV2VwSFN3SG1WZzE5MFEyRFB4WXd0?=
 =?utf-8?Q?E4Xk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54417a61-0455-4154-7527-08db97620ede
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 16:19:21.7370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YkrTSv+AsZDz92DynA7qRWRn/3IuLDr8w9kMqeSNckCW1bft79dvonRPVCIGqU+E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7520
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 8/4/23 15:41, Reinette Chatre wrote:
> Hi Babu,
> 
> On 7/19/2023 4:22 PM, Babu Moger wrote:
>> rdt_enable_ctx() takes care of enabling the features provided during
> 
> "rdt_enable_ctx() takes care of enabling" can just be "rdt_enable_ctx()
> enables"

Sure.

> 
>> resctrl mount. The error unwinding of rdt_enable_ctx is done from the
>> caller rdt_get_tree. This is not ideal and can cause some error unwinding
>> to be omitted.
>>
> 
> Please consistently use () to indicate function names (in
> changelog and subject).

Sure.

> 
> "This is not ideal and can cause some error unwinding to be omitted."
> is a bit vague. How about (in a new paragraph):
> "Additions to rdt_enable_ctx() are required to also modify error paths
> of rdt_enable_ctx() callers to ensure correct unwinding if errors
> are encountered after calling rdt_enable_ctx(). This is error prone."

Sure.

> 
>> Fix this by moving all the error unwinding inside rdt_enable_ctx.
> 
> "Fix" creates expectation for a "fixes" tag which is not needed here. This
> refactors code to simplify future additions.

Sure.
> 
> Even so, I do not think this solution addresses the stated problem (more
> below).
> 
>>
>> Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>>  arch/x86/kernel/cpu/resctrl/rdtgroup.c |   31 +++++++++++++++++++++++--------
>>  1 file changed, 23 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 3010e3a1394d..9a7204f71d2d 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -2381,15 +2381,31 @@ static int rdt_enable_ctx(struct rdt_fs_context *ctx)
>>  {
>>  	int ret = 0;
>>  
>> -	if (ctx->enable_cdpl2)
>> +	if (ctx->enable_cdpl2) {
>>  		ret = resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L2, true);
>> +		if (ret)
>> +			goto out;
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
>> +	}
>>  
>> +	return 0;
>> +
>> +out_cdpl3:
>> +	resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L3, false);
>> +out_cdpl2:
>> +	resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L2, false);
> 
> Be careful here. There is no dependency between L3 and L2 CDP ...
> if L3 CDP was enabled it does not mean that L2 CDP was enabled also.
> Similarly, if the software controller was enabled it does not mean that
> CDP was also enabled.
> Since resctrl_arch_set_cdp_enabled() does much more than just change
> a flag value I think these should first check if it was enabled
> before disabling the feature.

Yes. Agree.
> 
>> +out:
>>  	return ret;
>>  }
>>  
>> @@ -2497,13 +2513,13 @@ static int rdt_get_tree(struct fs_context *fc)
>>  	}
>>  
>>  	ret = rdt_enable_ctx(ctx);
>> -	if (ret < 0)
>> -		goto out_cdp;
>> +	if (ret)
>> +		goto out;
>>  
>>  	ret = schemata_list_create();
>>  	if (ret) {
>>  		schemata_list_destroy();
>> -		goto out_mba;
>> +		goto out_ctx;
>>  	}
>>  
>>  	closid_init();
>> @@ -2562,10 +2578,9 @@ static int rdt_get_tree(struct fs_context *fc)
>>  	kernfs_remove(kn_info);
>>  out_schemata_free:
>>  	schemata_list_destroy();
>> -out_mba:
>> +out_ctx:
>>  	if (ctx->enable_mba_mbps)
>>  		set_mba_sc(false);
>> -out_cdp:
>>  	cdp_disable_all();
>>  out:
>>  	rdt_last_cmd_clear();
>>
> 
> The problem statement in the changelog was that rdt_get_tree() is
> doing error unwinding of rdt_enable_ctx(). Looking at the above it
> seems that the problem remains ... callers of rdt_enable_ctx()
> still need to know all internals of that function to do error
> unwind correctly. Could it perhaps be made simpler with a new
> rdt_disable_ctx() that undoes rdt_enable_ctx()? New additions
> to rdt_enable_ctx() would have more clarity where changes are
> needed and callers only need to call a single rdt_disable_ctx().
> 

Yes. We can do that.
-- 
Thanks
Babu Moger
