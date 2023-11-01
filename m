Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 655EF7DE735
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 22:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346455AbjKAUms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 16:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234278AbjKAUmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 16:42:46 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C065010C
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 13:42:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MjgPOoNC7Oh8GKpJeipBGEV/tVPRTsxBUmc+z0nrqZaTNoRT7/aGQ9x0ZROfwZRaBIlNZcW9FIDBMPMpjB4bqjh9D6i76Jp4gGvIaTAauz9XkeinQuVx6dZqRzF1nbihjTFqtgbY44W/Twbc08Myftk9IVWhtoo6KGV77cPglue3erXgezIY3zRCHliKq354QdPxFOgbqAF9At1OAdP6/RT8xKgi98GJIT+/uZZ33PyeVcOi3GThocQ4NUhekBATwTl5dLpyYDbtlSlQgknulX2cSqeIjomU3sjXqOcgtZI61ba2W6ObGGGKGsp5dBtwdub1s7/GaNhAxSQnNUWpfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PyThgpM1/ZfqcnydQlilVngAdJZtUJK87OPUS2UUxj8=;
 b=F5gaSCoMl6LFDvG+yJRtYqaDb6ptQDqAS0GresDZkgx+GkjCn43z4fAIVEN4FZadiQuOlmuz4hJKMO73AHWjJ8q5/WwJXXEgizB1aytZOIpuTB+fNJgqFilDroxl4TBYKOIPEqkZMG4RV3TnbiYa5LF4r9/Hxo3iZBBrnUDqD1zss1BcPxCy4RUnSLjGjzzIX41MlA9oFzGT2k5xEfau2FDDIjwoNzc8Wnv19gE/vBEe+Ef4eww4Zj5E9dDD7nP3CTt/kbQenFL3nYK0Sz+eKTb9g+qbqgJfQK8sib3CGH4XHCbaIPjCOC9HBFz7r99Jjwuw40Y193xYRR2ckLRXkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PyThgpM1/ZfqcnydQlilVngAdJZtUJK87OPUS2UUxj8=;
 b=4bIdhvn7lVBI/HeJNE9MMhei5XiLyCDexnuhDqk+SK+6DieivgEJyK0Sr92rO1IrftyagfxSIsdj4FlLp/lLE3OVtw0ATtB+Z+uveqBKQ9gp5DbviTO59OFCd59zdjL0rZhTwkr/yocU5CIgFTeOunAiXfx0WIj62qcTUbeBBc8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DM4PR12MB6565.namprd12.prod.outlook.com (2603:10b6:8:8c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Wed, 1 Nov
 2023 20:42:38 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::2ba5:fd62:f75e:cf66]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::2ba5:fd62:f75e:cf66%4]) with mapi id 15.20.6954.019; Wed, 1 Nov 2023
 20:42:38 +0000
Message-ID: <9e6a979a-48db-4b25-884f-ac8d4c2bb078@amd.com>
Date:   Wed, 1 Nov 2023 15:42:36 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH] x86/resctrl: Fix unused variable warning in
 cache_alloc_hsw_probe()
Content-Language: en-US
To:     "Luck, Tony" <tony.luck@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        Peter Newman <peternewman@google.com>,
        "x86@kernel.org" <x86@kernel.org>
Cc:     Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
References: <20231031220534.37730-1-tony.luck@intel.com>
 <d47235e0-7ecd-483e-82c3-78f13c77df67@amd.com>
 <SJ1PR11MB6083C14236AC0AFCB49DFB15FCA7A@SJ1PR11MB6083.namprd11.prod.outlook.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <SJ1PR11MB6083C14236AC0AFCB49DFB15FCA7A@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR13CA0025.namprd13.prod.outlook.com
 (2603:10b6:806:130::30) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DM4PR12MB6565:EE_
X-MS-Office365-Filtering-Correlation-Id: b6857d78-49c2-4a92-36f3-08dbdb1b15fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CzoRaGdGEfTrRuTZjBXt4uDyW4Y8aJ0y5h8NBdLdtC3SqSOpwk5VP3CF2mQYeSivftS75axni+BkFXWnusdlqppvgVAz/1dS1wPaPQ2VmYRTLiXYRsPZxAVQZmjBLt+9BEqCbeNo+3D/pPN87rEaSrPSgmvMcl3lvqLxx00vr5ej+AaZAfCFPbqpPG3AtKIYP01ZGYxknWyMqd8kGMFCFMuErVjqS3FUbBPYad0+BXvrGPpuoZTi8ix1P7k55jJupY3GAzUO17Pz1f/skkFn9Bvmij693IHxvgf9cuVsqTB+YwTS6QOGgpC9IWaP0f4+Ckq1pYtXKmr+DzU/eyFvUE9sUxEszmq6JS1lnmCK/cg5qZrwpSxaiOfBsw/wpMtHhjA7T/YQfxEwhTsKcZKZKuo4AEVYEh+kT6EqQHQkiaD/vP8Z3CS7k5sUwX5gSaLJEzrpKnDNXuFnsDPffOl9Tf+pIeJ6dA8atR9MfLxz4HzZs8xMWIczl42UvrfA0j9W/a9hVDF9PDqZmTAl3kFkTyF4NHcxiIPiO6NMBSY3k+d56QhRmsFvGGKuzU7Hm1SKfZb/n04FzZ69/mJ6sTcR0057CMsH1QHyLWAZyzTgNev+rI2nQGhsIQnednV+qZ78nds0rfG3XWixhkWwd461jg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(346002)(136003)(376002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(38100700002)(478600001)(41300700001)(6506007)(53546011)(36756003)(6512007)(66556008)(66946007)(110136005)(7416002)(5660300002)(6486002)(4326008)(8936002)(8676002)(31686004)(31696002)(86362001)(4744005)(2616005)(3450700001)(316002)(26005)(54906003)(2906002)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmtxTkhkVmFBZUFFZUQ3ZjhnMEF4eDhpaUdEK3k4MUx0ZUhLOThRVVp6VHE0?=
 =?utf-8?B?Q2k2Vm5UK1pPdzh0N3FVaGIyU0NTSnpMMWljVlFzS2tkaUlMYkxmS1lydmRh?=
 =?utf-8?B?L1Jqb2xEb0lQTzFVSFBKWU5OeUVpRktxVDRxVXdOZGdsS3NNckRNRXBCczV1?=
 =?utf-8?B?WFJpTlJQUkJ0MEdIWngxcUxCS2RlTG00a3gxMHFySiswczZGN3dpdXVDZVJ0?=
 =?utf-8?B?YkJ3dWhwSUdYdXo4UzF5eXh2aDRwQktKT25QWW5zS2FnQXVtZThITXJsQitx?=
 =?utf-8?B?eE94bDJjZU1SVU5yTVNvMjdhZ3NMQ0wwUzB1ck9RVXVJUERFOG5tQXJhTUFr?=
 =?utf-8?B?NllwdUNJZUx6eENNRmttZUMwZ1U3MWo1NDlHSmwrNzdOay9nZ283NGlPVHNV?=
 =?utf-8?B?bEk1c05pZXVEeXRtSlBLeFB3VCsyampiSjJmTDBmMDhFZmpqZ2dxbW9kbEQr?=
 =?utf-8?B?L2JOK01pb3FoNDM3dXFXMVNtS09zbHp5T0daV29BeTk1L0t5WUhyaEFoU0NN?=
 =?utf-8?B?SFM2aTJtZzBRMUwyeE4veHd1MzNCNmYwR1RDSDRCbVpqUkJuSUR3ZjFxTWRH?=
 =?utf-8?B?UXg5dDRhRGdmZGMvZzRFc2t1bktWVzJCVFpMY3BPdDIramluU1JXVXNVUHJE?=
 =?utf-8?B?NU53OTFzMDJqdFFWQUw4YXZ0bjJ3VzdLUVU5SjZNM0JlRGV2Z3djOWVoODRH?=
 =?utf-8?B?aWZGSUZPN0RSbmVEdjJ4ZHJzeExRZlpLak93b1B0UVVGOVVLd3dhZzI3VGRJ?=
 =?utf-8?B?aWYyWjdnZ2lab3QrN2ExcFRMVVp2ZzJvclB4N3c5VnNpek4wdHBWQXJ0cGt0?=
 =?utf-8?B?TlorR3lGMzV4MUowNkxsZDhRblQxdXBZMDVYc3F5ckJhSGptT2RKbWM2OEVF?=
 =?utf-8?B?d2pNdXZYZU9TVElQSi8rWUtHQ3dnNnBNRUVkTHBqSWp1RGhCUE1hQlNLWjdk?=
 =?utf-8?B?Ymx1MXJFZ2M3dDkvYVFkOHZsL0Zzd1FJemxWT2UzdUN4cTBYeWlsM3paemtw?=
 =?utf-8?B?dTdETlQrdnl2ajhNT0QvYWZBWG9QM2lNd1RoV2pJUjltY1lwdnhYc2NKeHNC?=
 =?utf-8?B?RmQ4Yzkwa0pndHVzRnRQb21TOFFWQ094Y0JGeHpvT1F4ZnpoQThBMHNWLzZx?=
 =?utf-8?B?MVVvOUQwL1BnSkVDMHpxNWxTNnZPcjZOZWF2Tzk1NFhlWVhOQWlvb2lQRFht?=
 =?utf-8?B?VGxFREdNRnNYd1BnZ1FhMWpYYnloOGdMdCtSMVd2dDdQOUlEN09ZS09xQXhw?=
 =?utf-8?B?T1V4OGhiaGJjb3JhRUlOWXBDZVhDSnZVNzhlUzRjUzdxU1hmMTRQeWNGYmkv?=
 =?utf-8?B?SE5kNmJwS2tHUVE3SVljODRmZWM4VE1RbGNCTHNlQ1hjVUVDU1ptVmZQSmV3?=
 =?utf-8?B?NXpQVVRBaDh0UDIwV3d3SGdVNkNVQ2hkWlVQOU1tZTBrWFpWUDcwWVNCSmdY?=
 =?utf-8?B?WHFlaEJ1R1ZKaFlMTTFReXRjVnR2Mm1mcDRnTXVCZEZRMnRydE1UR0FRcFls?=
 =?utf-8?B?UFkyZWl5VW9McmpmaTlvQWxOQXlaejZ3Yndxc3VHQ2tZdFdBYkNENW1Odk8v?=
 =?utf-8?B?NEh4ZFZjaHZ3b1ViemlTTmZ2R0VsZFkrUy9nRG1Ha2xSUUEvc2tuQmkzN0lI?=
 =?utf-8?B?TDFHU1FXS3ZIcmZWMDVEaEdEOGYrRkhYNThycml4L0tHQm1PN2wwTDdkZExR?=
 =?utf-8?B?ZTJZNHdtM0xsMkUrS2tLNVR3czZOaTNNb24yd3ZzcGVKWFg1MHQ4bjlWaHFm?=
 =?utf-8?B?aHFJNGxmME56WXBJWkZsNHEwVW50ZzcrT0JRUEhkUDNpT3owaWVSSWZZZnJv?=
 =?utf-8?B?LzltUU4yNUNUeHowVUhjelJDSjRRNjVwNmltNzVnakZtUDloWVVPMVFIS3Nj?=
 =?utf-8?B?eDZpUVhqRzU1Mk4vcGN4b0tVVUVhWGFFRnVZdGZsV1NScndjNlVtU3ZyNG03?=
 =?utf-8?B?allhS3pJaGh3MmRmT3RuLzRna243TkZydFlzclNJd0Z5bEV5dGZzYnhOdWRh?=
 =?utf-8?B?NWFlNjAyM2FnRU43NlpscFFOa2hNYXIvRDNlQjV2ZEN1aTlCNzg3anpFTDA5?=
 =?utf-8?B?TnJhbzBycGJ2NkJMVUpGUTlxRlU3UTlLRVZUcS96MmdzR3NjU3Ric0p6dzZa?=
 =?utf-8?Q?ADwM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6857d78-49c2-4a92-36f3-08dbdb1b15fc
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 20:42:38.3783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yG2li5ONqa03yQxABQXk56405m/aNz/fyn19D7QipB4ZMWzCPyP7Hb1hKrpSbrBQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6565
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/1/23 15:33, Luck, Tony wrote:
>>>     if (wrmsr_safe(MSR_IA32_L3_CBM_BASE, max_cbm, 0))
>>>             return;
>>>
>>> -   rdmsr(MSR_IA32_L3_CBM_BASE, l, h);
>>> +   rdmsrl(MSR_IA32_L3_CBM_BASE, l3_cbm_0);
>>
>> You are writing 32 bit and reading 64 bit. Why don't you change both to 64
>> bit?
> 
> wrmsr_safe() writes all 64-bits ... just gets those bits as a pair
> of 32-bit arguments for the low and high halves.
> 
> I could switch that to wrmsrl_safe() and change max_cbm to be "u64"
> to make write & read match. Would that be better?

Yes. That is better.
-- 
Thanks
Babu Moger
