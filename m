Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0FA78E154
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 23:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbjH3VUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 17:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241091AbjH3VUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 17:20:43 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on20603.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e89::603])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEACE1B2;
        Wed, 30 Aug 2023 14:20:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JMu9EanyucArc4WA/r4t+0xJ0Ho/DegB/2QWGNDBFUp/vOeAuwRwJ9twsOXmpH5l9jckGLvsndIE9mE5qGnAGQsBpBRgFUKjjftvZiB+9F8Ofqote0PU3jpSLaJTgFY/0/IDPYpQEC/HjybVnnktg9Zv684UQXoLrW/Nb9mgJPps3hynH0pxiZwQZrvrpRJS4wLTmXULnr/BqoeIswNYPFKA76oko8RrP0K+EXEK5ZIsUv1zwZF8OjWBvxs8Zt3OhOavQ2palhKkug73TU9IeMz0LFMvzPpSlb20vYzJxanWf/El7Mq0P+dqXQaDaDQLyx9XFB18cgMWgDM8zGeH5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tiAtgLIffFEj2CJNYwCzQtjD8bssEcJwGsip7fB78P0=;
 b=DaCFVYQU2KVRRm7uL0OxPHDnLICZ7L3hq/Naof+VOp4C/uHdtXpG7SwIopFWcGtUWUJ2k1vbt+EFEChP6A+N5xB1GLMoyKxR13JfQeQEa0T7TTS9QiR8OJ0NJHxKPxosoRpjXlrDe6qy09n2DqcBMYv31v/PY7N+hG6rwpitCiFhEUMjbfq3Jt8Z7Ps2vGSoeXh8peYiBPYJ2D3pSd+jf4Uxig6KokpfYIXclO7U9N2fzM/fGLJPuT12ZQQoWydF1DlJcUKHgp25vhcJ7qJTh5dzMzVegVmjT7FrfauntxF5XaBS6WMBtE3KWTI9xmJQBx51uG6aQbC/qQIFeIs4oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tiAtgLIffFEj2CJNYwCzQtjD8bssEcJwGsip7fB78P0=;
 b=cnluwpWzQC5E494gTVfY+K5uusAg4wzXRU0WeglV+GVZB4UQQq+okU9JcvQUZELGy8wYbGszFoJHrEJQvNdWxWFBB2F9hRxVnPmlinCY5aw79BGYzJbaR+xmVJOz4TgYmmjG2T6NA0/SPYRYBCkB7CXGTQPsKXEfsyF1RgbYKsE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by IA0PR12MB8713.namprd12.prod.outlook.com (2603:10b6:208:48e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Wed, 30 Aug
 2023 21:18:50 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::fbfe:ec9c:b106:437e]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::fbfe:ec9c:b106:437e%5]) with mapi id 15.20.6745.015; Wed, 30 Aug 2023
 21:18:50 +0000
Message-ID: <674d9d94-28a1-2468-b2d8-1bf784933d6e@amd.com>
Date:   Wed, 30 Aug 2023 16:18:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v8 6/8] x86/resctrl: Move default group file creation to
 mount
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
 <20230821233048.434531-7-babu.moger@amd.com>
 <972db626-1d74-679d-72f2-3e122f95c314@intel.com>
 <5e1c084a-e224-a798-65c1-60f827634ee4@amd.com>
 <05b312d1-9873-f006-cf40-1db695b4603f@intel.com>
Content-Language: en-US
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <05b312d1-9873-f006-cf40-1db695b4603f@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR01CA0005.prod.exchangelabs.com (2603:10b6:805:b6::18)
 To MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|IA0PR12MB8713:EE_
X-MS-Office365-Filtering-Correlation-Id: f3d776e2-74f9-4162-9b4b-08dba99eb434
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tZFAdmOnQAj1BaT1l1w5bVgjL8Vn+LXAfPoydufMQ6OvPwkf+TeG6z/pDP1axp7Osvies2QYMJ9Wan7CYYtYPh077vT8pwQjq6pU3eMRgOxg6QObjI8QhkheKIhSs8NDvzfA9raDW1zMT7xYtqYRlZDHJ0x0LAAvFAS/uwWqSUKHnaX1qLi0Fn7QL57CbO5VO+ZS/gi1JGFn/QoIkoILHpUtv6psKXMd4VSCVd4xOJNGU8Or/qp2VMtFl5nSJQsOx1yid24Nm3OOEXqEIRe8p1dkOpxItgs27WuaviE9OjwXgkXJKQQUW4z8Ac35IvYLsbb+CMkuyXWOVvcGWvPsk/su/Yul2f+ypFhYwJy0qBcLRO6Dp6n4A2LH1woG5j3LTFpGnSk77Ws0fhCIWcltQweDBlyEg1BjVnu0YKXg54lpzmjsOpS7pviWKvdxIPtlUwrQWVpmhzCa0sx+lbyOW3gy5Bt7B3jAxt6QBh5WC08BVYSpW7Sv29MJkelfe7D3LiRUJmpJ3EUB6Dv49mRyFEBa/via3fV3gEvAfUw3kuOLIle4UrhgArsQLmd2csemOGSDUdy1320QCQL2BJkcmPiiwXYyX3MYbZNnLax09tzAeWf38gwcDkmUbp4/HBYxmNUnkDbI2fEhYXOYUBXK2w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(39860400002)(396003)(366004)(1800799009)(451199024)(186009)(31686004)(6512007)(6666004)(6486002)(6506007)(86362001)(36756003)(38100700002)(31696002)(2616005)(478600001)(3450700001)(83380400001)(53546011)(26005)(4326008)(8936002)(5660300002)(66476007)(66946007)(2906002)(7406005)(7416002)(41300700001)(66556008)(8676002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0JSVWxuekg2MmwvMzg1Y0t3ekFSTWRoSFRnVmx1eE5aTUthUlRLM2xRd3ZJ?=
 =?utf-8?B?dG9kWmhUSDlISjN1Mk8wV0U5UFNTOVc4bE5EOUtzMzBJaUJQdHRMT2t3VnlS?=
 =?utf-8?B?ODdGaVM2U2EyM0ZlOFAzTjFWdFQxMGFQbVU5SWRmQ2RPYi84T3R6bUFVWnNN?=
 =?utf-8?B?THBYTFBYN0FwK2lOQUxlQkhTL0pRQ1EvYXRSR20yVkRsWUZZNHp0OXNNbFJw?=
 =?utf-8?B?V1JzZ3lvUGY5SUVTek5Lb2NTeVhhTmZkdEF4YkRvaWV4YTNWcmFrTWdVdnFz?=
 =?utf-8?B?c2Y1bWxBV3FHd1pKUldnM1MwL2ZTR0JCZmdraFhvcnV2TEF0QloxbllrSUc0?=
 =?utf-8?B?SldTQTFsSEpvRElRNDFvTzR5RS9waDNZTnpJVUxOV0tlZFdkWUFHK0xOUnIw?=
 =?utf-8?B?M1ZKSzdSWE4xb3BqRXExSWxJaVB0bzV0MnowOFhqQ0s3TGNRU245M2tlM1c2?=
 =?utf-8?B?QW4rdU5oSjkvN3BmdEpoSHRpeXpkTE1LNHVNeXFIRW9STFZQYVhsQ3MxL0ds?=
 =?utf-8?B?akpuM3FTOUFVZ2luMTQ1Rlk2eXZiV1dGamttcFFIZUFrMXEyem9hWjdNS2xx?=
 =?utf-8?B?K3V3T2ZFQTZwSTE0QVg4Skd2ZFFOTENpdldJWGNUbjc2ZU5CR1dNVWNWRnJC?=
 =?utf-8?B?TGRyTDEzSnd2K1Y3NG8yQWRQZngvVW5zM25jUlQ3VFFnbWFDQUpDdXU3eXBr?=
 =?utf-8?B?dkxXd29KZktjazNxb3J0bUh4TVByWGxFUi9QcGdxTGtsUlFoZWtsUDlVdHpJ?=
 =?utf-8?B?UXZuUG1XUENlNExEdytnWDRRMDd6UDdqT3k0cEl3NFZKUkVOOWlJMXh2ZCs5?=
 =?utf-8?B?NmcxcXNPUXR1QjBOcUdwYmJnMWg4a0oyV1R3QnJYSkdtOEZSYWpOMVlNN0RW?=
 =?utf-8?B?czhrOUJhMzJJM2srQVkydDVrZFp3bG5Da2JBNjZCbGJTL21SajNYTU81bm4y?=
 =?utf-8?B?Y2hYM2Z4WURXUlpkQWdzdUlpQ2pWU1ZkOU1YUFpRVmdhajQ3S1dKQXpzdjlW?=
 =?utf-8?B?K3RFZVNaMDNicnRFbFI4NUU5NVFXbHVoME9QRXJ6b0k3c2hyZXJzZHM3UzRu?=
 =?utf-8?B?QXVJWEthbVVhR2xKVXdZNXVaYTVZSEplU1FnK04vMjQvLzVMb3B4MjFZa0w0?=
 =?utf-8?B?a2xiOWVwUWVpc1NBbWlZRnEwbVFaS0drT0plUUJhdDdFSFYxZ0JMMGhFQkpJ?=
 =?utf-8?B?OTBucWRhVEl0TW92T1p5U2htYU1ONEFKVzlsN2pGblYxbFpPY3ZxdjdZMjBF?=
 =?utf-8?B?RlRvSXRrbGZ4QzByOWRGOHpkQndPYjBtSjVncEZFMXd2d2NxT3ROQWROdm42?=
 =?utf-8?B?SVg3RGdEVXlvS1pvYlNEdWJJZlJMRzFYUURHM1BFNTJRWnFWK29VZVZrWHdL?=
 =?utf-8?B?WWY5YlIyRTJUZW1IZVZWVElkUmV5clRiSDdZZkQ2dUl3TTdHMFlmRUszMnlL?=
 =?utf-8?B?MU0vcjNDdUV6eGpBN1JrZkZ2QS95eitVaGNCaW1LVlh3ajJoQjNFYnRhREJX?=
 =?utf-8?B?cUpWcW13aEF3M0VUM0hwRndRMlZNZTBOaWdwUG9xUVJURmlleXoweW15eE9k?=
 =?utf-8?B?d2ZuUWVvSTBWS3VZYzFYL1FqOTUzVDhzSTB1blRNWER0ZUtHSHlrbW1pblVF?=
 =?utf-8?B?N2dBM0czSFk5bWVLaGEyNndKM2pZUzRsZlhjZkJyTW9XV2tXcWxJbXN2WXRj?=
 =?utf-8?B?bWY3emgxVzJTVEpNZmxkM0VIOHFEZkpvZVQwR2RuQjJKbFdzTjBuZ252U1pO?=
 =?utf-8?B?KzB3b21FWmV3WE9keGN0UkJMaXpQUE9LdEkrcWl6aS9YUUc5a2htS1cwQ0lY?=
 =?utf-8?B?RGZiM0FVcnlDeEowK1FKMEpoc1NTQ2x3YnZUdjljUXdYZUFOWEhjdTJCL3BS?=
 =?utf-8?B?MXRzWDVKbVp6MzVXL2JxQytwTW5ia1QzQ3p4R2xhMG1EVlVLZ2YrczJoczNv?=
 =?utf-8?B?V25ZK1MvNEpjcldsTzFDMDlaM0xMS1JkRE5jNnRaNUpaSVJNNUVwUXBrOXRN?=
 =?utf-8?B?K2ZoSkVQalgxS1lhdHhRNktFTmNGZGpjaFk0NjFmT2ZzVmFzUUI5eHBzck1t?=
 =?utf-8?B?aFh3TTlDUlRFcnFYVnFSaGtLUXBFeWl5ejRpc1V4TE1XdFp5WDd1RXluTVg1?=
 =?utf-8?Q?hlfw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3d776e2-74f9-4162-9b4b-08dba99eb434
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 21:18:49.9039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3OwZnTwIZ/fYYoE4tscQkeT/fxsz61HpLQo8bon2N1pVYbO4iuoVEjUqFkX8D0ZL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8713
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 8/30/23 15:00, Reinette Chatre wrote:
> Hi Babu,
> 
> On 8/30/2023 12:50 PM, Moger, Babu wrote:
>> Hi Reinette,
>>
>> On 8/29/23 15:11, Reinette Chatre wrote:
>>> Hi Babu,
>>>
>>> On 8/21/2023 4:30 PM, Babu Moger wrote:
>>>> The default resource group and its files are created during kernel
>>>> init time. Upcoming changes will make some resctrl files optional
>>>> based on a mount parameter. If optional files are to be added to the
>>>> default group based on the mount option, then each new file needs to
>>>> be created separately and call kernfs_activate() again.
>>>>
>>>> Create all files of the default resource group during resctrl
>>>> mount, destroyed during unmount, to avoid scattering resctrl
>>>> file addition across two separate code flows.
>>>>
>>>> Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
>>>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>>>> ---
>>>>  arch/x86/kernel/cpu/resctrl/internal.h |  2 +
>>>>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 55 +++++++++++++++-----------
>>>>  2 files changed, 33 insertions(+), 24 deletions(-)
>>>>
>>>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
>>>> index b09e7abd1299..44ad98f8c7af 100644
>>>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>>>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>>>> @@ -611,5 +611,7 @@ void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
>>>>  void __init thread_throttle_mode_init(void);
>>>>  void __init mbm_config_rftype_init(const char *config);
>>>>  void rdt_staged_configs_clear(void);
>>>> +int rdtgroup_setup_root(struct rdt_fs_context *ctx);
>>>> +void rdtgroup_destroy_root(void);
>>>>  
>>>
>>> From what I can tell these functions are only used in rdtgroup.c.
>>> Can this export be avoided by just moving these functions within
>>> rdtgroup.c and making them static?
>>
>> Yes. It is used only in rdtgroup.c. We can make this static by adding the
>> prototypes of these function in the beginning of rdtgroup.c file to avoid
>> implicit declaration compiler errors.
> 
> Why not just place the functions earlier in rdtgroup.c so that they are
> located before all callers? 

Couple of problems with that.
1.  rdtgroup_setup_root needs the the definition of
rdtgroup_kf_syscall_ops which is defined later in the file.

Static struct kernfs_syscall_ops rdtgroup_kf_syscall_ops = {
         .mkdir          = rdtgroup_mkdir,
         .rmdir          = rdtgroup_rmdir,
         .rename         = rdtgroup_rename,
         .show_options   = rdtgroup_show_options,
};

2. rdtgroup_setup_root is called in rdt_get_tree which is defined earlier
in the file.

So, this needs re-arrange of all these functions. That is reason I made
these functions global. Thought it may be too much a change for this purpose.
-- 
Thanks
Babu Moger
