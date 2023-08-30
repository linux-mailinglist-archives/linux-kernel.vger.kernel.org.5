Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8D6A78E0C8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239995AbjH3Ufk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 16:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239840AbjH3Uff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 16:35:35 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A639D59ED;
        Wed, 30 Aug 2023 13:35:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rh3G6wCPm6HM7BHZUw9BZhvkBPr6DJHQmaCB4pFOs/JtVh/cVitTvmHX3pxgQxmZCO8DhNf8Lq9nlZjXJ+u5O3fg1UywsJ6NhizSwgMCPEYrwpIeku5HgAffq2SV0M1VSccC2PrL6Bq1GcCsNdGHNS971dM2Y78W0JvFQ83LLFpNzOMcBoAWI3WFdfI1+lx+BlVpgrxYrkrDYuZZqC9DuNjLZhPl/gkLlK4ovUhnjzW24AdZsN5z5/TdnsgQIIcBgwHexq3N+eHWfQj1N46byzZ4QMNiBL1qC8Y5ITGRbQCtu1+W/ILtalMv//eLgetzN3OxdjUatoLc4+lI0dcmYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QZ9k1ihcB1wjnvYfrjd891ILEi/thLSapJZgRf6i1WY=;
 b=b95zRa8AJOS1tKV4fwg4dTWUVtEfxPs1nzwcZSfNKOEcWg6zblCiq7VrmLynqJ5LBBWKDBuhR/+JLhzA9m8oZyUPS7BSDSRmmgx1nGsLojCeb7eFUPqPfybcNjqPZWTnr45m2TLmU32ek9RIiVTGuOxclO3vAQvH1C/7TkCTypxzDjybxpmg8NcSZbH/EZiDIXnr25mGLzeyi8yxlXXrM7OCvvQuPm5g0F3FjBfr7YN7oonhP8MPzPZ2vXn4eZrpJLN7Oyei3qCm2vdNSC9Os5f/+6yIOT3P60nl/o2JCEpPCSAUuAjniDUwdGN4omT8ZfjaoS4kS28L2IUFYG2gwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZ9k1ihcB1wjnvYfrjd891ILEi/thLSapJZgRf6i1WY=;
 b=Hx2XgJbyJwQaRStbZgRRzkn9VQR+umDK/T7EE58tVhjpVuuGujUrP82NqyJr2N5uoAOmNr9BGhh6pmORzHz1JI/2GE2OkSK2fH10JFjA7M7gZTS3hBMNNNxvKLe2jyHi/i2vMyWAOsrJPsx9rjSk2iizYA31zCCI2fluo2KLPyQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by BL3PR12MB6450.namprd12.prod.outlook.com (2603:10b6:208:3b9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Wed, 30 Aug
 2023 19:50:25 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::fbfe:ec9c:b106:437e]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::fbfe:ec9c:b106:437e%5]) with mapi id 15.20.6745.015; Wed, 30 Aug 2023
 19:50:25 +0000
Message-ID: <5e1c084a-e224-a798-65c1-60f827634ee4@amd.com>
Date:   Wed, 30 Aug 2023 14:50:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v8 6/8] x86/resctrl: Move default group file creation to
 mount
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
 <20230821233048.434531-7-babu.moger@amd.com>
 <972db626-1d74-679d-72f2-3e122f95c314@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <972db626-1d74-679d-72f2-3e122f95c314@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0106.namprd03.prod.outlook.com
 (2603:10b6:5:3b7::21) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|BL3PR12MB6450:EE_
X-MS-Office365-Filtering-Correlation-Id: 15a2ebce-c413-47d4-5779-08dba9925a9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sAt2sFm5HCZfG11LsF58DU5rQv4ncyrbryn9yf+ov1sZDfNfkbTSRbs2QmDSiFRz68sjkLVkzISmVFiX5tV3g7jioHiqPXJgf37cubJu4XoPq4PYGQXw0BFQVjFvg7iv8sCal+YvOr5IOW/P51uTahAnbhh2h+BjpyyqfyvXcWFfv111Ytld4VP8foo8FEBmEjLxDN1wppXjK0gtHVyla5srXWk+e0FU92f8xKdZcX+CgeqfBvz859J4CYT5eff5enpIrPUTDOhSCN7C1y3VF2eEUyeB3YwpoGCrBQXkjVM0DwsJKnTGu5T2cidYaaNBAeL0TjBPntR8pMZUBU53Dnw1z4p8WWoeA44knggBu+aqkWm0RWkTYEbYN8LC4KJlJoZHIc2UBeBu32d/Hkfz5LWL0AkM1Nkq98n54rHe/DlqOZhJG5+t42YOGFjZVghX4ni7m4CFAb8jAwQEqBo0PZ6Z8vET0cIFiSTzMIZXP47VkKxR2TxIcUQRM8c+Vh+EWhlqRr8EeM4vZq4W/XWY22RTrpRz5kH2iVwjg8IEKj6HCo24r6q+JnAX0cjbVVRDFlSs6qRxGhb6NwO1eu0q1khstMHh56Bd1urSthnVTL2gIl3/HhdAyu2c2HQzYOoW/8QzFXwLeTshbzFRVV1bbA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(346002)(136003)(376002)(1800799009)(186009)(451199024)(66476007)(6486002)(6512007)(6666004)(6506007)(83380400001)(53546011)(8676002)(26005)(478600001)(2906002)(3450700001)(7406005)(41300700001)(316002)(7416002)(4326008)(5660300002)(66556008)(2616005)(66946007)(8936002)(36756003)(31696002)(38100700002)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U25aMEhMODdMZTAyK1RPQjhudVZWc3pwSFNjTG55aGl2bVZyM1JBbEJ2STNQ?=
 =?utf-8?B?a21iZkxoWXRCS3dZRzZVQTBORFM1dmxWcXhpeXRhalJQeUJZV2MxZUFZWXZr?=
 =?utf-8?B?ZnAzb05oVlVNWXVPZDdSTERWYUE0RWVGSlZxWElsbkVCWEE2M0tGcDd1NmhI?=
 =?utf-8?B?aTFpMzd5UTRoQmw2WktUMi9QSWFSUWtQSXBIWEJzUnZWLysvM2hWaU8rZFFW?=
 =?utf-8?B?aUtrTUh2aEZZTFAzMld6SGNaKzVBK3lnR28vZGVXbFBWQWxiNmlGeFJIVDVN?=
 =?utf-8?B?UXRSdDBXUmtNUTZlS0Q1NmRESjQxS3ErKyt1OHNBaUt1V3hwSlZrZm9qVDJF?=
 =?utf-8?B?dWtOQi85d3F4RVNJS3BTcTQ5RE56LzN5UDhZNkFNUHJzYVd0RDJSczFiNmtK?=
 =?utf-8?B?eGtZN2Nuai92ci9SYkNHQ2trUmdPaWxjeXdiekZJencxQ0xVWmwvRVFhbzgy?=
 =?utf-8?B?ZW1qM0lpWkpudCtKZ1JPdlc0ZksrYjdxQVNnYk5qZTZuTUlacmNTV0srY1I2?=
 =?utf-8?B?enJabEVPU3R0UVo0OVlZWHVNNmozZlpidlNKY2VmRHUxck0rVlgxK3RZVTJS?=
 =?utf-8?B?cEFvSVJxYzYzTFhXMjRTY1N6UDljbDlsamRzaHZHR0U2VVpzR2VYM1JqSmxW?=
 =?utf-8?B?L2M0cHdQNjZ5Z3N3RDNVOWdKUkw5akh6TXJ3UDlBb01rU0hPQUdkVlBPNnRI?=
 =?utf-8?B?ME5hTlJtSEtIdnhlNXBFd2hWYk1RQmx0R2dJUUVxL0RuK01nTDFSc3BucjZR?=
 =?utf-8?B?Vkt2ZmFma0ZZN0xYME9NNFluWnRtWDRsUTlEVW4yMjVXQ1p2QkFKMHo5Lzc4?=
 =?utf-8?B?clRHZGdEQ21uMU0rdU9kS3kwUXpRQ05HNnhIc2h4dEorbGk0OUdFRFc2eDJH?=
 =?utf-8?B?RGdGcHRQdFdnS3ZETi9hWkZ2VFh1MzRmU0tnZlljUFYrSEJ1emJyeUViemJn?=
 =?utf-8?B?OXFiRFBhT29yaDJkSUtsNXVCMXg4UU5XN1B3VkxkMVZJY2JVOHBNbEV3QU5L?=
 =?utf-8?B?T2dmTnN0bys4eGQzSEhEWVhSOTBLSGZlMnVpRE0zNHo3OEhtb0xVYy94OVlE?=
 =?utf-8?B?cEhNNGZrQlhxeXJwL1A1bXNHdUlRQ2Y4WlA1L21Lb2t4Z0IrMWdUdE96Wlk3?=
 =?utf-8?B?MGZEbWMrVzdLaU9Lc09zYWR5V0FESkNObUU0WEszU2lKTjVTQU9idlFNMzNa?=
 =?utf-8?B?VWpObGFLNG02dmhWRXRUWk5mSEFEOG1sbVQvR01jSzVhcElTTTVZVi8yZUVo?=
 =?utf-8?B?OE5xdFpkTllmSzRNTG9qaFJzVS9kZnhUNFFzMHJzeGMveXArU0VOdkVWSlcv?=
 =?utf-8?B?K1VnWVhocS9zeEh1Wk5UdWxJMWNiV0VJL2wzSTNtaDgxK25Eb1RzYXc1enRt?=
 =?utf-8?B?dEQxTndYUkZmbVVlYXg3a1RwaVN6S1hjc3lSdU5renFLbmJmQjhPMnVaemN1?=
 =?utf-8?B?NVpPSnc4ellWNW9iN0FWWGlTUk02SmhjT3o4MEZxbTRmTEpqTDcrd2xrS2pF?=
 =?utf-8?B?U0hJNUF4QnZsQzZBUm9CdlYyN2s0a3ZnMGFBNmJ0YTYzRlZtSXlKMEpqbDhT?=
 =?utf-8?B?SEEwNFJCcjNWS3k5U1p0NnJ2UXhLbkRFUVBFSGRGQ1BBT2ZXVjZHcERtTjF0?=
 =?utf-8?B?ZTRhb1d5ckNBSHNVMmZVRENHZHRvREhxMmM3VEUrN1RRalp6VHdSZzRXZFNp?=
 =?utf-8?B?QTFQcFp4c1h4QjgzcFZOcitDaTJHcktCQVhvdkk5MnNVcERqSzRzelFjWFFV?=
 =?utf-8?B?Ukdka0RVeFVZZjFrQnlzK0QxTmNPRnkzWkFlNkNtSzl3UjV1RjhpY00vNGlZ?=
 =?utf-8?B?YlZkbWxEWHFSVncwNHppWkpwd29ZZHZjb3FwOTRLRkxGMmIyM05vcW1sQmtI?=
 =?utf-8?B?SUZtTTgzbHhmMEh2MGRNMWhpSXRSK2ZPSmtYclN3cHc3eDB2dUhHSWdqU3p2?=
 =?utf-8?B?enRKdjBNM1I4QzVwMU45UDlNTnJJOUhwTGpCRVJ1aEh6S1U2dTcwMmRvQlRo?=
 =?utf-8?B?QW9iMUhTNmYrcmt6NlAwSFk2eVRkek5FU1RFQTlRbkZhYmZ0eVFMKzhNTkl6?=
 =?utf-8?B?Z2JOdHY0d2lObS9xWUZab2RUd3J1M0I5d1NPMnl0QllZaFNOL1FKRm1zSFg0?=
 =?utf-8?Q?blH4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15a2ebce-c413-47d4-5779-08dba9925a9b
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 19:50:25.5553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dm5srEYl4YTN84s161ozZcAVXSshQo9HjRdlO3yos2pLgfqFt7i+/yuvBQXhrTj6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6450
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 8/29/23 15:11, Reinette Chatre wrote:
> Hi Babu,
> 
> On 8/21/2023 4:30 PM, Babu Moger wrote:
>> The default resource group and its files are created during kernel
>> init time. Upcoming changes will make some resctrl files optional
>> based on a mount parameter. If optional files are to be added to the
>> default group based on the mount option, then each new file needs to
>> be created separately and call kernfs_activate() again.
>>
>> Create all files of the default resource group during resctrl
>> mount, destroyed during unmount, to avoid scattering resctrl
>> file addition across two separate code flows.
>>
>> Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>>  arch/x86/kernel/cpu/resctrl/internal.h |  2 +
>>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 55 +++++++++++++++-----------
>>  2 files changed, 33 insertions(+), 24 deletions(-)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
>> index b09e7abd1299..44ad98f8c7af 100644
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -611,5 +611,7 @@ void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
>>  void __init thread_throttle_mode_init(void);
>>  void __init mbm_config_rftype_init(const char *config);
>>  void rdt_staged_configs_clear(void);
>> +int rdtgroup_setup_root(struct rdt_fs_context *ctx);
>> +void rdtgroup_destroy_root(void);
>>  
> 
> From what I can tell these functions are only used in rdtgroup.c.
> Can this export be avoided by just moving these functions within
> rdtgroup.c and making them static?

Yes. It is used only in rdtgroup.c. We can make this static by adding the
prototypes of these function in the beginning of rdtgroup.c file to avoid
implicit declaration compiler errors.

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 189c51c479d3..a97118b6f9f0 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -54,6 +54,9 @@ static struct kernfs_node *kn_mondata;
 static struct seq_buf last_cmd_status;
 static char last_cmd_status_buf[512];

+static int rdtgroup_setup_root(struct rdt_fs_context *ctx);
+static void rdtgroup_destroy_root(void);
+
 struct dentry *debugfs_resctrl;

 void rdt_last_cmd_clear(void)


> 
>>  #endif /* _ASM_X86_RESCTRL_INTERNAL_H */
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 80a4f76bc34b..98f9f880c30b 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -2516,10 +2516,14 @@ static int rdt_get_tree(struct fs_context *fc)
>>  		goto out;
>>  	}
>>  
>> -	ret = rdt_enable_ctx(ctx);
>> +	ret = rdtgroup_setup_root(ctx);
>>  	if (ret)
>>  		goto out;
>>  
>> +	ret = rdt_enable_ctx(ctx);
>> +	if (ret)
>> +		goto out_root;
>> +
>>  	ret = schemata_list_create();
>>  	if (ret) {
>>  		schemata_list_destroy();
>> @@ -2528,6 +2532,12 @@ static int rdt_get_tree(struct fs_context *fc)
>>  
>>  	closid_init();
>>  
>> +	ret = rdtgroup_add_files(rdtgroup_default.kn, RFTYPE_CTRL_BASE);
>> +	if (ret)
>> +		goto out_schemata_free;
>> +
>> +	kernfs_activate(rdtgroup_default.kn);
>> +
>>  	ret = rdtgroup_create_info_dir(rdtgroup_default.kn);
>>  	if (ret < 0)
>>  		goto out_schemata_free;
>> @@ -2584,6 +2594,8 @@ static int rdt_get_tree(struct fs_context *fc)
>>  	schemata_list_destroy();
>>  out_ctx:
>>  	rdt_disable_ctx();
>> +out_root:
>> +	rdtgroup_destroy_root();
>>  out:
>>  	rdt_last_cmd_clear();
>>  	mutex_unlock(&rdtgroup_mutex);
>> @@ -2654,7 +2666,6 @@ static int rdt_init_fs_context(struct fs_context *fc)
>>  	if (!ctx)
>>  		return -ENOMEM;
>>  
>> -	ctx->kfc.root = rdt_root;
>>  	ctx->kfc.magic = RDTGROUP_SUPER_MAGIC;
>>  	fc->fs_private = &ctx->kfc;
>>  	fc->ops = &rdt_fs_context_ops;
>> @@ -2824,6 +2835,7 @@ static void rdt_kill_sb(struct super_block *sb)
>>  	rdt_pseudo_lock_release();
>>  	rdtgroup_default.mode = RDT_MODE_SHAREABLE;
>>  	schemata_list_destroy();
>> +	rdtgroup_destroy_root();
>>  	static_branch_disable_cpuslocked(&rdt_alloc_enable_key);
>>  	static_branch_disable_cpuslocked(&rdt_mon_enable_key);
>>  	static_branch_disable_cpuslocked(&rdt_enable_key);
>> @@ -3705,10 +3717,8 @@ static struct kernfs_syscall_ops rdtgroup_kf_syscall_ops = {
>>  	.show_options	= rdtgroup_show_options,
>>  };
>>  
>> -static int __init rdtgroup_setup_root(void)
>> +int rdtgroup_setup_root(struct rdt_fs_context *ctx)
>>  {
>> -	int ret;
>> -
>>  	rdt_root = kernfs_create_root(&rdtgroup_kf_syscall_ops,
>>  				      KERNFS_ROOT_CREATE_DEACTIVATED |
>>  				      KERNFS_ROOT_EXTRA_OPEN_PERM_CHECK,
>> @@ -3716,6 +3726,20 @@ static int __init rdtgroup_setup_root(void)
>>  	if (IS_ERR(rdt_root))
>>  		return PTR_ERR(rdt_root);
>>  
>> +	ctx->kfc.root = rdt_root;
>> +	rdtgroup_default.kn = kernfs_root_to_node(rdt_root);
>> +
>> +	return 0;
>> +}
>> +
>> +void rdtgroup_destroy_root(void)
>> +{
>> +	kernfs_destroy_root(rdt_root);
>> +	rdtgroup_default.kn = NULL;
>> +}
>> +
>> +static void __init rdtgroup_setup_default(void)
>> +{
>>  	mutex_lock(&rdtgroup_mutex);
>>  
>>  	rdtgroup_default.closid = 0;
>> @@ -3725,19 +3749,7 @@ static int __init rdtgroup_setup_root(void)
>>  
>>  	list_add(&rdtgroup_default.rdtgroup_list, &rdt_all_groups);
>>  
>> -	ret = rdtgroup_add_files(kernfs_root_to_node(rdt_root), RFTYPE_CTRL_BASE);
>> -	if (ret) {
>> -		kernfs_destroy_root(rdt_root);
>> -		goto out;
>> -	}
>> -
>> -	rdtgroup_default.kn = kernfs_root_to_node(rdt_root);
>> -	kernfs_activate(rdtgroup_default.kn);
>> -
>> -out:
>>  	mutex_unlock(&rdtgroup_mutex);
>> -
>> -	return ret;
>>  }
>>  
>>  static void domain_destroy_mon_state(struct rdt_domain *d)
>> @@ -3859,13 +3871,11 @@ int __init rdtgroup_init(void)
>>  	seq_buf_init(&last_cmd_status, last_cmd_status_buf,
>>  		     sizeof(last_cmd_status_buf));
>>  
>> -	ret = rdtgroup_setup_root();
>> -	if (ret)
>> -		return ret;
>> +	rdtgroup_setup_default();
>>  
>>  	ret = sysfs_create_mount_point(fs_kobj, "resctrl");
>>  	if (ret)
>> -		goto cleanup_root;
>> +		return ret;
>>  
>>  	ret = register_filesystem(&rdt_fs_type);
>>  	if (ret)
>> @@ -3898,8 +3908,6 @@ int __init rdtgroup_init(void)
>>  
>>  cleanup_mountpoint:
>>  	sysfs_remove_mount_point(fs_kobj, "resctrl");
>> -cleanup_root:
>> -	kernfs_destroy_root(rdt_root);
>>  
>>  	return ret;
>>  }
>> @@ -3909,5 +3917,4 @@ void __exit rdtgroup_exit(void)
>>  	debugfs_remove_recursive(debugfs_resctrl);
>>  	unregister_filesystem(&rdt_fs_type);
>>  	sysfs_remove_mount_point(fs_kobj, "resctrl");
>> -	kernfs_destroy_root(rdt_root);
>>  }
> 
> 
> The rest of this patch looks good to me.-- 
Thanks
Babu Moger
