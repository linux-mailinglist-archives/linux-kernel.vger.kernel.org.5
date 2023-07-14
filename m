Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B14D753FD3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 18:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235970AbjGNQ1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 12:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235360AbjGNQ07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 12:26:59 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D105271C;
        Fri, 14 Jul 2023 09:26:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FaLp1TUDt8wcasVzH3aWL3+9A4LMF7y3X/j24HvU590pndxJxA0deQmgoXPfBy7XeRexR8+gZC907khQddkcGeDsMEObYKJ5Czfo5/60G2BNfbKrxg/XMlWg0dW4iPG+p8QWpVh1uIJFYh3iHtPwB9a1Jj2HSA7khmMKzXWcQ7BGz450MgtTHsWGXM6xzVp3gM8lZBLizGA8H36vkaRua5uduJ1pEBngWxTyqmCEhSIYdNkm/O9iCMGNhAlNh9b9MbBRgIR74hz5RLQigiuJHkrflNuAYyyJYD9BE1oWotGaIFVmsUtwS3o6fkDenyb+/C39n7ts/auJ+gG/iU/8Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4fbcfgRXqAY/mUby17UmTLK9Ol5I8ZEKIzp9BO/pKgQ=;
 b=Evnz+MG8FFRhtuTkb4pXzmTCoNNnlaTq9JLVcwfnv2Ki83qOnmUOpEiQpfDK32Jng16t7IjsB4k3K3Tj4DZ7JTSHfzrBdorXYbGJxRAaAxok4+DpfFHgzxCi/prDV4IGNQ4pxzGJoze9zHzVxngK1HWC6nAYX7+knlTjj7tLvfQ6Vup+stFChcsO1JVPLF3jvtYLXMq+5um2I+HgpPI9h2CHSUVOVc63RcRswtq4+7W0HAIxXpDhswUD0PcyEZru++9ikyV17MmPB24hL/mEtFlqOcSZWvr+6JmTR9MMO8wiKE2ue8a2UKZ1FkUo3cdYlEKLm5Us7A3K0PZvj34pGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4fbcfgRXqAY/mUby17UmTLK9Ol5I8ZEKIzp9BO/pKgQ=;
 b=IeukDYiEDNHN0RacEm5mpr7kLKsmm3r3VTNXlxhYUzgSf5ni8jD/QnOsnEzvk/RAKaCMBSOYecmIffShwWXJxBub29ZMw1Yt6SnCE+18KqOihjD8QlVTQQOuzMIS9l7y7Vs4LrINBxIbqmASJETCKL1VSbBbmrffNxoLnwm79eM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SJ1PR12MB6340.namprd12.prod.outlook.com (2603:10b6:a03:453::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27; Fri, 14 Jul
 2023 16:26:55 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::f870:5325:36eb:e741]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::f870:5325:36eb:e741%2]) with mapi id 15.20.6588.027; Fri, 14 Jul 2023
 16:26:55 +0000
Message-ID: <c10643f9-ac6b-7912-1fe1-c9446c79b931@amd.com>
Date:   Fri, 14 Jul 2023 11:26:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v5 7/8] x86/resctrl: Move default control group creation
 during mount
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
 <168564612103.527584.4866621411469438225.stgit@bmoger-ubuntu>
 <9cb1a07b-0e17-d930-263e-5433952cf241@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <9cb1a07b-0e17-d930-263e-5433952cf241@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0196.namprd04.prod.outlook.com
 (2603:10b6:806:126::21) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SJ1PR12MB6340:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d3c2d56-1057-4547-3f51-08db84872334
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uT34BL8UYdf7NQtEoWD8exLotTdpMoGm2w03+cY8yzxoijUu6F5SoFw8A03WYxzjjESBFBEZ1CiM+c4UDXTDAY6LNZENi6bdcrCBWh3SEPA/OWsQGqxrrKaYi5l+GPINuhAlxiN0+azdDcgnatHBgO2hSj23ytwglsG4SDoEbGpVDz4JYBY5ukfERyUabsJNAwWbkQyBGkvrjLwPQHYM9O+gH4gP9dFbzBAUCvLR7qkeh5e2oAjSE1oJmwGhTHthjdCz60OTMcqqALLM84H7/wpJhYaj2wbTj/garWSKnHPpXuNjHYoXcIPnbrYCbrIlrSJjl0mcZYWcAmF95Jh4+D1cIsdKvnUQ2ow6XqkPkg45KjZVXb9b+1mgZL9i7NmK3+UGcizzJhZT4qQdhFxcuOa6KZFuCuQEyS2iJCP2DeXqrxX3dTIKGjPB6UpWTl2Iko+qjmOzDkZ4rpD6H17EE9XzwHHIZa0Kx9PrsUW4yf6HuMcZ/4Wc/vv648SK7nIyURvRdBFS7UxgVfdBstJgLvw/NmaqwXhGJrOWtNFKC7FEunbg6y5t9YYpyk4ZcThyrblwlvec718L6GiUzZJz0MA1C3vQPanG7XFtEG+w6WOyoeeXuiazRtqSYtmABhFQqZq1XNH3arpV8LIphYaeLA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(396003)(136003)(39860400002)(376002)(451199021)(7416002)(7406005)(66946007)(4326008)(66556008)(66476007)(41300700001)(2906002)(316002)(478600001)(5660300002)(8936002)(8676002)(3450700001)(31686004)(6666004)(6486002)(6512007)(26005)(186003)(53546011)(36756003)(6506007)(83380400001)(38100700002)(31696002)(2616005)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0NoNWl1WThzL1dubzhkUmlGN2hSMEE0UjRYb2F4eTlua3NQa2I2Mnk1ZkVo?=
 =?utf-8?B?R1EzbGRGVFVWTEtkamJxZWhPRkJ5UUdKQnBzb0hldjBsSi9XYlNFV3dWaXdO?=
 =?utf-8?B?VUZvMkZJOHI4MHpjNXN4THdaQTBIRlZFTWtYMmZaU2hlbUNTSjg3dElCL0tm?=
 =?utf-8?B?djZKZEJHSnkxMFJHaVY4V0IyeFRkeTN3bGNTb0lGTm85dEppOTU1TEJBTXg4?=
 =?utf-8?B?cTkxM1FMWDJXSDVLQkVJa3BiTW9IWkIrWCtkanByTTg5WjBaK1J5RGN6WG5w?=
 =?utf-8?B?T2VOa2xIcENCZmFncm9TQnZqazlENmszSjZoZ3pydE1LZE1mYjlDWTJQN3RF?=
 =?utf-8?B?OGNkdDRFT2tGWVo4T0dBbVViK1BlbnVsNHZlZnlLWmdXZktnejVQTUlDWTlW?=
 =?utf-8?B?NnZxbkVHRGdLUlpHcUZvcnNlWVhGSTBRQzdjSjBFRnBZVzc3eGNSMGhtNnNX?=
 =?utf-8?B?NHhVNGhSd29lNitNbGpUZ3Job2EyVTl1NnUyLzhuWm9MZnh0TUx2NmZXdmNa?=
 =?utf-8?B?NW9pT1lzOUIzVGQyTEFyVFBNRTE2UmVVdW9Sdy9HTzl4UmQwRTgxbkdsYXZx?=
 =?utf-8?B?blJoTFF1clJReC9DdkJqQTFmQ3MwY0FLbHpYeE9OeUkxUE4wWjVNUlZlVVg4?=
 =?utf-8?B?Vmp3ZlJmUFJvVlhHVlF6OExLY3IxN2llQ29VcXN4UVJzaUpVZitoeHFqZTBp?=
 =?utf-8?B?SWk4U2VYdmtwS0g2QUFvdkpEY1hDKy95SSt4YStPdlQxS0QwYkgwYVBvaXdZ?=
 =?utf-8?B?ZVZ5L01vczdvZ1JJWlR6M0xUYm9HWHJwcVJ1WnRVSGp1N3kwMGd2dDNnM2xS?=
 =?utf-8?B?OUVrNjhtaWw5bFc5U3FEcTNxaG16dUFiL1ZEZGtva1JhelRxa21SWUhpOGx6?=
 =?utf-8?B?d3FGSjNoWkhlTVd0V0xydzhOeTZQM1lucDg5KytaQWRQOUgrQW4yV0NCQ1BR?=
 =?utf-8?B?YVB3akxkWmFFaGJ3YXY1a1c2dERNdFk2Z1IzZ0hGb0tXd2hJYVFiMjE1cWhv?=
 =?utf-8?B?WVZlSVMxUHlNbk9OVjJRVXhhS3Y0eGNNcjBEbjR1d0lUNnZYMEtHclFUMGNH?=
 =?utf-8?B?Q2tWb3R6OW9YNFdPeHR4UUpqZ1RzQnA5RHpWcEd2MEFnSXNXbWkvT1R6Rit6?=
 =?utf-8?B?NklqcURrUFJzaEt4RVNreGhMV2hlWExpd3FwTlUvQXRocVpVT2FsOVpmVWpw?=
 =?utf-8?B?OTI3blZUOXVsK0dXN2hIZWRJYzlGMHpEaGZJbVd5djJhYnVmVDcwV0pmYktK?=
 =?utf-8?B?aFI4MVBqNG8zN0Q5OVBTcTlWR2tlUkZXZjFUSHhOMHI3Mmo0b3dYWWxNNjFz?=
 =?utf-8?B?S0pORUdRdWV0b2k5dnRISXhIYlZ1RzRndkFOVTArWHVTQURDb0RFcmw4SU83?=
 =?utf-8?B?N0MvakdLZGhIOWd1MTd2Ly9FVmZKR09TUkFmSmZHa2JNL05kbmZJbGFYQy9B?=
 =?utf-8?B?dmNkSGVRdHRWOHZaQ3dtYlhXUjdiMGQzc0xiMDBadHBvVUhqVzgrbXFLRmMv?=
 =?utf-8?B?MklLOW9XcmZmSGJCTXpzM1BxdUI0V3hlWG13WWYyVnlWQm4rcFpjSGkwY09M?=
 =?utf-8?B?cTBTT0I4aXFvNE8zOW5ObTFRRUMyblJ1RyttZXBKUjlDWmVDTm9SYVJQWnEx?=
 =?utf-8?B?MXVlTllxZlNGdngvWU9TZ1M4ZWdabXR6T2ROL1pRRlJiTWlWK1VpVVRlc005?=
 =?utf-8?B?RTJBaUxSczRjQ0I2bmgrT1Y1dFhoWlVYVkEvLzZBelFoUk1UYVIvdktDSU1W?=
 =?utf-8?B?NlBXcVdxUmdyU0M1WWlpdjRDbjljclBaSkEvZXZLRWdrdVNYUld5NDlVY2Jh?=
 =?utf-8?B?Q0lZbXVTMXdJaGtzL3JocWRhYytVd0VVWkpjTVBWOUMvZnBjT1BTSHN6d3lz?=
 =?utf-8?B?WmRkbUlUc2g3YnUzYmN6UWQ4bFI1WEtteHY4WjIwYVc0WkFRL3p3Z2o2NmMr?=
 =?utf-8?B?bk90aG1CRmFRNWxYV0oxTi9kWHhoTXQ1RVJXQlYyUUdKV1MyQ1F5dWZnS1Nt?=
 =?utf-8?B?ZUlVT2dPU1pUYWpDNTE4WGMyczl2SzNjVGF4T1lIR1NGQ0hCSEp2anFlbzNE?=
 =?utf-8?B?SkhLLzdzV3VnL241ajdsSmRsSjJWUWJsbjNvUEtibEw2SkNRSy85amtEL3Rx?=
 =?utf-8?Q?NAqA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d3c2d56-1057-4547-3f51-08db84872334
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 16:26:55.1126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZAWZBWc8JU3gqVaSku0S5Y2nl/tl+YURVcdlbUsLRxAA3bQ5bm1B661zKx4GN5/V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6340
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
Sorry.. Took a while to respond. I had to recreate the issue to refresh my
memory.

On 7/7/23 16:46, Reinette Chatre wrote:
> Hi Babu,
> 
> On 6/1/2023 12:02 PM, Babu Moger wrote:
>> Currently, the resctrl default control group is created during kernel
>> init time and rest of the files are added during mount. If the new
> 
> Please drop the word "Currently"

Sure
> 
>> files are to be added to the default group during the mount then it
>> has to be done separately again.
>>
>> This can avoided if all the files are created during the mount and
>> destroyed during the umount. Move the default group creation in
> 
> "creation in" -> "creation to"?

Sure
> 
>> rdt_get_tree and removal in rdt_kill_sb.
> 
> I think it would be simpler if this patch is moved earlier in series
> then patch 8 can more easily be squashed where appropriate.

Yes, I was thinking about that.
> 
>>
>> Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>>  arch/x86/kernel/cpu/resctrl/rdtgroup.c |   59 ++++++++++++++++----------------
>>  1 file changed, 30 insertions(+), 29 deletions(-)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 2f5cdc638607..e03cb01c4742 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -57,6 +57,7 @@ static char last_cmd_status_buf[512];
>>  struct dentry *debugfs_resctrl;
>>  
>>  static bool resctrl_debug;
>> +static int rdtgroup_setup_root(void);
>>  
>>  void rdt_last_cmd_clear(void)
>>  {
>> @@ -2515,13 +2516,6 @@ static int rdt_get_tree(struct fs_context *fc)
>>  
>>  	cpus_read_lock();
>>  	mutex_lock(&rdtgroup_mutex);
>> -	/*
>> -	 * resctrl file system can only be mounted once.
>> -	 */
>> -	if (static_branch_unlikely(&rdt_enable_key)) {
>> -		ret = -EBUSY;
>> -		goto out;
>> -	}
>>  
> 
> This change is unexpected.

Please see my comments below.

> 
>>  	ret = rdt_enable_ctx(ctx);
>>  	if (ret < 0)
>> @@ -2535,9 +2529,15 @@ static int rdt_get_tree(struct fs_context *fc)
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
>> -		goto out_schemata_free;
>> +		goto out_default;
>>  
>>  	if (rdt_mon_capable) {
>>  		ret = mongroup_create_dir(rdtgroup_default.kn,
>> @@ -2587,6 +2587,8 @@ static int rdt_get_tree(struct fs_context *fc)
>>  		kernfs_remove(kn_mongrp);
>>  out_info:
>>  	kernfs_remove(kn_info);
>> +out_default:
>> +	kernfs_remove(rdtgroup_default.kn);
>>  out_schemata_free:
>>  	schemata_list_destroy();
>>  out_mba:
>> @@ -2664,10 +2666,23 @@ static const struct fs_context_operations rdt_fs_context_ops = {
>>  static int rdt_init_fs_context(struct fs_context *fc)
>>  {
>>  	struct rdt_fs_context *ctx;
>> +	int ret;
>> +
>> +	/*
>> +	 * resctrl file system can only be mounted once.
>> +	 */
>> +	if (static_branch_unlikely(&rdt_enable_key))
>> +		return -EBUSY;
>> +
>> +	ret = rdtgroup_setup_root();
>> +	if (ret)
>> +		return ret;
>>  
> 
> Why was it necessary to move this code?

Please see my comments below..
> 
>>  	ctx = kzalloc(sizeof(struct rdt_fs_context), GFP_KERNEL);
>> -	if (!ctx)
>> +	if (!ctx) {
>> +		kernfs_destroy_root(rdt_root);
>>  		return -ENOMEM;
>> +	}
>>  
>>  	ctx->kfc.root = rdt_root;
>>  	ctx->kfc.magic = RDTGROUP_SUPER_MAGIC;
>> @@ -2845,6 +2860,9 @@ static void rdt_kill_sb(struct super_block *sb)
>>  	static_branch_disable_cpuslocked(&rdt_alloc_enable_key);
>>  	static_branch_disable_cpuslocked(&rdt_mon_enable_key);
>>  	static_branch_disable_cpuslocked(&rdt_enable_key);
>> +	/* Remove the default group and cleanup the root */
>> +	list_del(&rdtgroup_default.rdtgroup_list);
>> +	kernfs_destroy_root(rdt_root);
> 
> Why not just add kernfs_remove(rdtgroup_default.kn) to rmdir_all_sub()?

List rdtgroup_default.rdtgroup_list is added during the mount and had to
be removed during umount and rdt_root is destroyed here.
Please see more comments below.

> 
>>  	kernfs_kill_sb(sb);
>>  	mutex_unlock(&rdtgroup_mutex);
>>  	cpus_read_unlock();
>> @@ -3598,10 +3616,8 @@ static struct kernfs_syscall_ops rdtgroup_kf_syscall_ops = {
>>  	.show_options	= rdtgroup_show_options,
>>  };
>>  
>> -static int __init rdtgroup_setup_root(void)
>> +static int rdtgroup_setup_root(void)
>>  {
>> -	int ret;
>> -
>>  	rdt_root = kernfs_create_root(&rdtgroup_kf_syscall_ops,
>>  				      KERNFS_ROOT_CREATE_DEACTIVATED |
>>  				      KERNFS_ROOT_EXTRA_OPEN_PERM_CHECK,
>> @@ -3618,19 +3634,11 @@ static int __init rdtgroup_setup_root(void)
>>  
>>  	list_add(&rdtgroup_default.rdtgroup_list, &rdt_all_groups);
>>  
>> -	ret = rdtgroup_add_files(kernfs_root_to_node(rdt_root), RFTYPE_CTRL_BASE);
>> -	if (ret) {
>> -		kernfs_destroy_root(rdt_root);
>> -		goto out;
>> -	}
>> -
>>  	rdtgroup_default.kn = kernfs_root_to_node(rdt_root);
>> -	kernfs_activate(rdtgroup_default.kn);
>>  
>> -out:
>>  	mutex_unlock(&rdtgroup_mutex);
>>  
>> -	return ret;
>> +	return 0;
>>  }
>>  
>>  static void domain_destroy_mon_state(struct rdt_domain *d)
>> @@ -3752,13 +3760,9 @@ int __init rdtgroup_init(void)
>>  	seq_buf_init(&last_cmd_status, last_cmd_status_buf,
>>  		     sizeof(last_cmd_status_buf));
>>  
>> -	ret = rdtgroup_setup_root();
>> -	if (ret)
>> -		return ret;
>> -
>>  	ret = sysfs_create_mount_point(fs_kobj, "resctrl");
>>  	if (ret)
>> -		goto cleanup_root;
>> +		return ret;
>>  
> 
> It is not clear to me why this change is required, could you
> please elaborate? It seems that all that is needed is for 
> rdtgroup_add_files() to move to rdt_get_tree() (which you have done)
> and then an additional call to kernfs_remove() in rmdir_all_sub().
> I must be missing something, could you please help me understand?
> 

Yes. I started with that approach. But there are issues with that approach.

Currently, rdt_root(which is rdtgroup_default.kn) is created during
rdtgroup_init. At the same time the root files are created. Also, default
group is added to rdt_all_groups. Basically, the root files and
rdtgroup_default group is always there even though filesystem is never
mounted. Also mbm_over and cqm_limbo workqueues are always running even
though filesystem is not mounted.

I changed rdtgroup_add_files() to move to rdt_get_tree() and added
kernfs_remove() in rmdir_all_sub(). This caused problems. The
kernfs_remove(rdtgroup_default.kn) removes all the reference counts and
releases the root. When we mount again, we hit this this problem below.

[  404.558461] ------------[ cut here ]------------
[  404.563631] WARNING: CPU: 35 PID: 7728 at fs/kernfs/dir.c:522
kernfs_new_node+0x63/0x70

404.778793]  ? __warn+0x81/0x140
[  404.782535]  ? kernfs_new_node+0x63/0x70
[  404.787036]  ? report_bug+0x102/0x200
[  404.791247]  ? handle_bug+0x3f/0x70
[  404.795269]  ? exc_invalid_op+0x13/0x60
[  404.799671]  ? asm_exc_invalid_op+0x16/0x20
[  404.804461]  ? kernfs_new_node+0x63/0x70
[  404.808954]  ? snprintf+0x49/0x70
[  404.812762]  __kernfs_create_file+0x30/0xc0
[  404.817534]  rdtgroup_add_files+0x6c/0x100

Basically kernel says your rdt_root is not initialized. That is the reason
I had to move everything to mount time. The rdt_root is created and
initialized during the mount and also destroyed during the umount.
And I had to move rdt_enable_key check during rdt_root creation.

-- 
Thanks
Babu Moger
