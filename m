Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A22750EBD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 18:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbjGLQkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 12:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbjGLQkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 12:40:33 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943E310C7;
        Wed, 12 Jul 2023 09:40:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X1i1Z5bShi5KkbQTRleztWQWsTsTAaUzAw0+fdyCk8A9IRV+kqfFdezbjYca9BWV3Mus7SxtBu0tERIamDX4sM1TYVzOpxH5T8ZCpYTC1Yd4p075o7rc3fx4qqGu9f3AZxJ2Xz7lon8z3Iw07SFUFWYPiO32BF0NAyG0YXcs+yIo08coV1oKSUPcCRyjUf+0r65swgUl1NBmWQy5+qPU9AXUAUIMR2ZZo04AAVWAzIYIoBloU2flyTZOfCs2Ngxjyu7CiZSw3yHTGUpiKudQ0xBVRioCcvVLPSduEEb11zpQRtYX5PXNjh0P839P2EL+YUqnIWeLnKp9K+B6qzMGoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lOlG9xj8zFZXw/RdvwwgYlkyUS18i2haZ6z57v2+qVU=;
 b=OHzml7G9WDjkKjjQf8zVG9WddD99ABwXh4V/87jDNvMzePFniVPYcCjrV7GYzGNDN7aFJa+6CWCNx2YsLAruVenXGjJTQlxGesjVGkVEpnuzI+zlXiehylZH0GR+Y1374IAMlBbd6tnDBN1niRNPjxwAbuwjrgWqcBkTozLi7m4EETdzurMrolRIiLzw5SdraoswilJbM/1JSUrDDl4GoBhqOzPD0BsdqXBbYoNY/9tuv0aDxBPBWB9pmwZ7a9t/4PBvyeKB3iIXU6iwiQXIn2vk4hQTNslPzFZ4qn5EpjI8PFdwsA7mD/tyTBrHkl4/mqJAV+rGlrSStInFxzdrWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lOlG9xj8zFZXw/RdvwwgYlkyUS18i2haZ6z57v2+qVU=;
 b=q+crvjneVRxiWRCBPLj7WLKB1strovNTXJ7jPMhFoBMVfeZw3RZv0NdJSSV5f+FQlwkuFvXesmlNrThxsKfzt+f7VYTdcsqadncA+82QZMbDgGAUPetrcTlyDzfBeHzUFf59l8S/QSZeJ7SBrGNhQmFNQ0gniMfbFW5xMqQkVpg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CY5PR12MB6132.namprd12.prod.outlook.com (2603:10b6:930:24::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Wed, 12 Jul
 2023 16:40:23 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::f870:5325:36eb:e741]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::f870:5325:36eb:e741%2]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 16:40:23 +0000
Message-ID: <cc6ef418-3f7a-1bf7-b286-e3c534781740@amd.com>
Date:   Wed, 12 Jul 2023 11:40:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v5 5/8] x86/resctrl: Introduce "-o debug" mount option
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
References: <168564586603.527584.10518315376465080920.stgit@bmoger-ubuntu>
 <168564610093.527584.3413729327027786408.stgit@bmoger-ubuntu>
 <9821c0d4-4b4a-9720-52a9-b993f1118a91@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <9821c0d4-4b4a-9720-52a9-b993f1118a91@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0044.namprd12.prod.outlook.com
 (2603:10b6:802:20::15) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|CY5PR12MB6132:EE_
X-MS-Office365-Filtering-Correlation-Id: 20b28df5-edc0-4926-63b5-08db82f6afe2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BNjcAxLa1s/Bqn9TdKunG+2hD2fdxrl+Rv7oAektHxrPgQLA4GaO6II2dJQjQR8j+1tAJREJAfe7XAnGsEM+BJvtC0YLndEOFb/VkT8m6msukVZKhR9t0c3v3Jgm3UfOx1xAT3EHDqN69mn4m84zNdrqb//P9gzq9qIz496Nm5UJDvmvdzJZPaFN2AXKraBC0c/4fjE9hit5smraGPl3UWUKigXW7pgu/2iVp8rSZEJGoPmr4CznrOhbt2AY+ltwEdGayLldWMgGAc/bpVDTNaRkclg7DKN5TphYZlCuRgtFMQ5BYECE5SSOowIPt1G5/vxT277/vcfEk/MXCWyt2NBkiEqJzKPCuosiHmZ+LLmyIAfLW7MsN4gPrmbUnokHEq2T/QlX1EHUPeO9mGGtkgsi5z0ZAE0QhCwyuEI5agdXDkjPwqFlYV40AAFxKTidTT3HHg8hGT6FR57uzN8X8Ul1t3QAfB3ofFpJn0NE3miHph/HwWH59YJp/whHP+c1qa+HE7SXp4MhHbokOL12+EerOGfZP/NJDvJzr2xoKqGdkwgCA36AdHzhHK12Hhmvwpd2P3EWnQQFwT2icPwcQIErnsoO6sAgkKRMqz71HxHAdD2SNPCGieMFY5P0nLmJVVv8qwUq5bAt6tOEZcS46w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(366004)(39860400002)(396003)(346002)(451199021)(6666004)(6486002)(478600001)(186003)(26005)(53546011)(6506007)(6512007)(3450700001)(2906002)(41300700001)(66946007)(4326008)(66476007)(66556008)(316002)(5660300002)(7406005)(7416002)(8936002)(8676002)(38100700002)(31696002)(86362001)(36756003)(2616005)(83380400001)(31686004)(66899021)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTUxNlBWajJpaWZ5cDV1R2JBdTl4c0IvMzNiR0lHTHArQ1BsR0YrdDl5d3kr?=
 =?utf-8?B?MDM4eDdYbnpnK1JqYUJuTlVGbTdQWWs3VWpDZmJGREw0VGpZeFJiQ3NqTU1z?=
 =?utf-8?B?VElPVnN3b3BQekoyajBkZmFoMER5aG5rb1ZuOGpEaE9BU1VSSFN1bWpUL0xK?=
 =?utf-8?B?ZEZaK29XK3RQMFlWa3BMS2NQUko0SVl6K1NZN2NnbDFkTm1LSEZhODNvMU5K?=
 =?utf-8?B?TUw3M3BjdVRZaE45NGhZMUV4OUJ3YkJCa09lM2s4VjljM01qdHlMcVNXem5m?=
 =?utf-8?B?VW9xWkdnblJtZVJkcXVoWUxjMXZZQVJGZ3JzOEt3eldNSTZXRHZOODd4V09P?=
 =?utf-8?B?Q215ZitEYTlDZUVVZHl1NVpHOFM5SkdGcDJxMy9MK3BSRXBjV3ZQVXl0cTQ0?=
 =?utf-8?B?Qm51cWtvaURZT0gzN2o3VkR5SGNtVFZCTVExb2tMRUt2OU10ck93K1VhdmM1?=
 =?utf-8?B?ajZSR0VBYnlTVGN4c05TTFhpcWcxUWVrcTVoVW5LMUFySzNmb3lpWGpsSTRa?=
 =?utf-8?B?a1pxaGpXSHcxUE12Uk1Bc0hUYlVsNG9QU1B4MVlpNFVDNDV1Y2ZWL0JZRzNY?=
 =?utf-8?B?amQvaGJObFBSYzRIb0d3UUk0R0daLzRadUNyY0ZyeThzV3R1SmNmd3NFZ2p5?=
 =?utf-8?B?dURJWGJYVmRLNHlUK2szTmVlOGZySW5WYjY4bzQyNmNHQXhCZVZpVjF1UkR3?=
 =?utf-8?B?NmJqRUZjUytuZi9nRWNiekNYSnhDUFVaL25VL0doRkplcDE5YzJjSlNTcVht?=
 =?utf-8?B?aTNVQ0h4eHZ0bWNjL1N1VE53azFKb0NGSTVqb3pqVkwxcFZvK2wvWjhBeHJ3?=
 =?utf-8?B?SkFIWjdkZEY5UXVrZWE1bHA5SjdrZ3hzTWJ4MUJ0T1JYdnc1alhKYmJ3Tlkz?=
 =?utf-8?B?UFVtZjVrTG5ubEE3NHNqWEl3cTY2Vjg3eDJjczg0d0JjaWJRc3FiSUUzQmU2?=
 =?utf-8?B?UWdUYlJ2ZWVsWmZRQzJDR0dUOWcydWlXbnBkTEpJN2EzK3EzVGRkczY1OTli?=
 =?utf-8?B?RW5YbE9RTlc1QWMzS3ZKNkxjaitWZDltWmp5Z0lhMytNeDlyTlROWFZpNHVj?=
 =?utf-8?B?Sm56QkpuYURDRGtUZDRBMDJhT3VqTDNQVlBsdC83MHN2Z2FhQzlvSmtvTkFn?=
 =?utf-8?B?ZHZ4YXBuem9pOXFIR3k5R0cwK1lWZTl1SVJZVU5JZFdlcVdPc0lZVlFvNHVu?=
 =?utf-8?B?L1RScGhHajhpb3VZZ201OFVqS0d0Mk5TVG4vKzBzeDJhMGlzZWIrOHV1eCto?=
 =?utf-8?B?cVA2bVJlY0tTNkg3cFl0WExIRHpJWHE3VXJtMjlwZnFQWnE2VVh5Uzg4Rklu?=
 =?utf-8?B?KzlPN08vR2wza0JUWXhtZmxIUVl6MHBZbmVWUy9ObTFRN2ZvZjJKekVqcVBq?=
 =?utf-8?B?dGpKZTkyRURxTUFLZjlxZ1Q2enI2L0JVVmtSRWpEN2JMK0pFQ2hDM2ttdUsx?=
 =?utf-8?B?K1gzbTZFR0JWQ0kwVFdMejhINGZlMC9PM2NXczZOWmowS3BsRkpOMzJaNllB?=
 =?utf-8?B?SkhaQ0Q2aURBUEd2ZU11d3pZLzV6RmVkWVhTMTZLV3FhdVhtb1VJQzRiM0Q5?=
 =?utf-8?B?RUh1WHF3MWZWYUR3UXJwemk0TmxzbEdVWGRRWjlMdGRoaHdORFRHckFNU253?=
 =?utf-8?B?RGZlb1ArMHcyY3o4aVBpTDRaWFRlRVlqaGlDOG5Fa1JGbEdCNmlLMHhmNmJj?=
 =?utf-8?B?M0ZPS056SHR4UlBLbFg2dnVRM1k4ODRIa01idTZMR3U4enEzVWFDcDY4NGlL?=
 =?utf-8?B?WUlEaXlyVHk2QzZObDUwRDg2dkVIeFNXQjQweHg4d00vWmxIUGhzUzZ5eWVN?=
 =?utf-8?B?VXE1NTZDYkZibFRiOEd2d28wbzRFbmkyR0VuSENZUDJaQlR2TFFRM2JkN1RU?=
 =?utf-8?B?L2k4Uk1EdlEwQTEyREczK0kxMW1kaGdHUyttOEdhaisvODQveWVMTnJkLzlN?=
 =?utf-8?B?WVBzT0FrVjBnRzJEV1NpSEQ1bmFuQ3ZQVXdDYzA3ajB3SVplUEtjK1hsaExv?=
 =?utf-8?B?LzBsRnBydkkzRkRWRE9qYlQvNWhFOWxQZjZmRXhJT1JWV213RzJvNkN1MVVj?=
 =?utf-8?B?SnRORkhJaEhraVVCY1kyTkEwdUJ4R012MW1xcGFlY25hdjJHamFrTE01cFg5?=
 =?utf-8?Q?T6N0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20b28df5-edc0-4926-63b5-08db82f6afe2
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 16:40:23.0308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VRXPb3hWKNqKcEglwsEQfQa+eqL5Rrjlw3IR32hampgoRgTCXhxvce/C4IA8lIUu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6132
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 7/7/23 16:42, Reinette Chatre wrote:
> Hi Babu,
> 
> On 6/1/2023 12:01 PM, Babu Moger wrote:
>> Add "-o debug" option to mount resctrl filesystem in debug mode.
>> This option can be used for adding extra files to help debug
>> resctrl issues.
> 
> Please avoid uncertainty in the changelog (re. "can be used"). I

ok Sure.

> think it will help to be more specific if the first and last
> hunks of patch 8 is merged into this patch, making it clear
> that the debug mount option is in support of debug files with
> this changelog written to support that.

Sure. Will do that.

> 
>> For example, hardware uses CLOSID and RMIDs to control and monitor
>> resctrl resources. These numbers are not visible to the user. These
>> details can help to debug issues. Debug option provides a method to
>> add these files to resctrl.
> 
> With the debug file support added here this extra motivation should
> not be necessary (remaining hunks of patch 8 can be moved to where
> these files are introduced).

Sure.

>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>>  Documentation/arch/x86/resctrl.rst     |    3 +++
>>  arch/x86/kernel/cpu/resctrl/internal.h |    1 +
>>  arch/x86/kernel/cpu/resctrl/rdtgroup.c |   15 +++++++++++++++
>>  3 files changed, 19 insertions(+)
>>
>> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
>> index 290f01aa3002..afdee4d1f691 100644
>> --- a/Documentation/arch/x86/resctrl.rst
>> +++ b/Documentation/arch/x86/resctrl.rst
>> @@ -46,6 +46,9 @@ mount options are:
>>  "mba_MBps":
>>  	Enable the MBA Software Controller(mba_sc) to specify MBA
>>  	bandwidth in MBps
>> +"debug":
>> +	Make debug files accessible. Available debug files are annotated with
>> +	"Available only with debug option".
>>  
> 
> At the risk of becoming unreadable, the earlier documentation of the mount
> command should also change.

Ok. Sure

> 
>>  L2 and L3 CDP are controlled separately.
>>  
>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
>> index c20cd6acb7a3..c07c6517d856 100644
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -59,6 +59,7 @@ struct rdt_fs_context {
>>  	bool				enable_cdpl2;
>>  	bool				enable_cdpl3;
>>  	bool				enable_mba_mbps;
>> +	bool				enable_debug;
>>  };
>>  
>>  static inline struct rdt_fs_context *rdt_fc2context(struct fs_context *fc)
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index baed20b2d788..be91dea5f927 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -56,6 +56,8 @@ static char last_cmd_status_buf[512];
>>  
>>  struct dentry *debugfs_resctrl;
>>  
>> +static bool resctrl_debug;
>> +
>>  void rdt_last_cmd_clear(void)
>>  {
>>  	lockdep_assert_held(&rdtgroup_mutex);
>> @@ -2368,6 +2370,9 @@ static int rdt_enable_ctx(struct rdt_fs_context *ctx)
>>  	if (!ret && ctx->enable_mba_mbps)
>>  		ret = set_mba_sc(true);
>>  
>> +	if (!ret && ctx->enable_debug)
>> +		resctrl_debug = true;
>> +
>>  	return ret;
>>  }
> 
> Looks like unwinding of rdt_enable_ctx() errors is done in the caller, this is
> not ideal and additions like above cause some error unwinding to be omitted.
> I cannot see why rdt_enable_ctx() cannot do its own error unwinding. This
> may be better as a separate patch.
> 

Sure. Will do error unwinding of rdt_enable_ctx as a separate patch before
this patch. That seems more appropriate.
-- 
Thanks
Babu Moger
