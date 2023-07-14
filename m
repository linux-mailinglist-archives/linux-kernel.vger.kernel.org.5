Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574A475450F
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 00:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjGNWmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 18:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjGNWmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 18:42:38 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C99E30FC;
        Fri, 14 Jul 2023 15:42:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CsBGBXjSfdNpMBAOb8lOI5n/ixs/ESZXM5m1U9YhlNQuxXuiE53ci9IQ6VTHuGgqjgeznhozhXNDpcnB42DSkDgP9VlM9Xfn+KU5pbTmq3M815DFhwabg1wYA1rQV20WwdB+0dCHpIYEOmtLPk3KYhy19O7M3m3NBKx4+UrMVNE9bZl4lBK1FVPAGIyWwdEJQvcZnKngN4yv/vrhJ/YyE4hi84gp0LOWr7yNk9WJah/zEfal07EEsY16EbfmQq9FglwrAoadznL6DjiYrVuBe+soCZd0RtKkzCu9R4hFFCj42qIdzPBC5AIL5D9m0JWHdMU3U1tZqHHAVpvaI7NLcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HU9+XSoWCfkdEcLpENY5BqpsAa4VvbsECpdhmtmbr0Y=;
 b=EtAfHeoutClIH3KQFt8fqQHUToibljXT48soCj2w5k3/2yE0hpi790Xb56ChMvhJI7X9p4w7YMXfUYB2c6oGBcux1rOUPJZZnqxcbP9adDAgz1QJr6k3F/80EkqcR6bWzQ6OSir0FH7W6s96yDd9W2bQ7/sP4vy6m/YmOsj3vTTcrtJAYmdUqd9c18/IYsAgq3cyctt0FR0lkmqeuQVgdEI/3mGVQnwE7IH9vl1N88huToE/0BTA8k52LL0wakvDiHf5ei8qx7RtVoJ2+XEDFdwnSnTqZb78MEXPKUVYrRn+OoLKog+mPAXNFuq6dZWo0CaIhvXBUVIeeJooGOj66g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HU9+XSoWCfkdEcLpENY5BqpsAa4VvbsECpdhmtmbr0Y=;
 b=s2Ybc2waXvo0UWuRnS/drS/lLlB7idpl/pkDb/gXkILA4Ffi8ErlahcPSO2Kst0/XV0pk9Y+3NDxPfTh9sWm+yH7b1IlokdKm+wANeGKe85nkFOS0Mp0YClqhZOEDrB1bKvhzCkXHu6Rznw0pP996qqJ3beL18aC19Pbl0Js8is=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SA3PR12MB9178.namprd12.prod.outlook.com (2603:10b6:806:396::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Fri, 14 Jul
 2023 22:42:32 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::f870:5325:36eb:e741]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::f870:5325:36eb:e741%2]) with mapi id 15.20.6588.028; Fri, 14 Jul 2023
 22:42:31 +0000
Message-ID: <1fcf1463-7d4c-ae6a-0c05-2e1bbf081846@amd.com>
Date:   Fri, 14 Jul 2023 17:42:26 -0500
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
 <c10643f9-ac6b-7912-1fe1-c9446c79b931@amd.com>
 <8f68ace7-e05b-ad6d-fa74-5ff8e179aec9@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <8f68ace7-e05b-ad6d-fa74-5ff8e179aec9@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0027.namprd04.prod.outlook.com
 (2603:10b6:806:f2::32) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SA3PR12MB9178:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bad5ab2-ee16-491c-4e0b-08db84bb9be8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KXmfuPEkGkdcjOd0xh4/N/P5kico8RkJ0I45jMv1t03lYkFZzdovCWmYVFYa4RXqm2WI8X6/hGT9cgcf9oa8nyEl0a0x9PPZBuncAGJ7hwAUWg0YNplyh2YdITTbK6cCbSp0w7jJdvnmdopWbpEFzlEjgYa7bneOBTpGeNMICf513OLYasmyCxD5Cg7hNoapNYhGPNoWlUk/VeDUHcgLuSzta/SLpYqAnjmCxk+SvcIPE/WYn8UjGu0C8Kn/G1ijd/nqx6veW0JURYlmrtTNRO0jCp0jvSUAfKuCkGcC6zNFrqssx5wmalMLa+V5if6g2w9x/PmBjnYn65kremQEIhfNvAwdup36mhgHSN5O1HiAy0MqnlTBzoJ/YHjE1etHXZBsclicd102aMQJkD9ULuKfbKGD/865WNheLJgQgpyUx5n7uJAhpU51cg5fh2vbXthh+cB0fNg4dB3xP5/u5fbpKtNUfN6+Y1XH4i19yQQWT8QeHbz6OrJQ+Lt4ngAVOnBxHVgegVjeeeGw9mvmgEq9Xha2ls2PRiUpygBFv+0/DHZY04G1Fb/xzpSnNDJd7HzmTqHGPZENh+mkmQwaXcfNjkQn2E0Jby0ffdSN+iAf1DKwYC1BJHs8J3tjLQRi7qmtHhZTE7QTzeUbspPwxg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(136003)(39860400002)(346002)(396003)(451199021)(5660300002)(31686004)(8936002)(8676002)(478600001)(186003)(83380400001)(7406005)(31696002)(6506007)(7416002)(86362001)(26005)(41300700001)(53546011)(2616005)(6666004)(6486002)(316002)(6512007)(66556008)(36756003)(66946007)(2906002)(66476007)(3450700001)(4326008)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkxPd2dSQXIxTlh2MGk1STFTd2V1NnpFUjg1NG4veHVnTmpTVEJjME94UFhS?=
 =?utf-8?B?MnFuSmw3U3I4OXZaNlk2d0ZCdGNMekYrS1A3aXFqRDhlNDQ2UkpFclZwNk9G?=
 =?utf-8?B?YWlpd045YnBTeDhCblZNd3JFcEg5dEhmVDdLWHJGN1Nqa1VxeFdlaTJ6bWVU?=
 =?utf-8?B?STYwNmZPTk8rSGtPZnYydTAwcnBxT2dBV2NIWlpxak1FYVpSMGhUSEdWWGcv?=
 =?utf-8?B?bEtJWXM1TEE5U0dROHMzdGdTckpDOXpBQkowODNBdDJVdXpkRjY1eHhsZEU4?=
 =?utf-8?B?Sm83cFY4ejZ6UlFuOUZNQ3pjMDBPanFNR003L1JpbTdXTytyZDVjWlR1YVEy?=
 =?utf-8?B?dXJaOTlnZmdBRlpLaUQ2RXBiWXFvSk5IdnRnNS9VNlhIMVVLNXF1ZGU2MkhJ?=
 =?utf-8?B?RzRKdHRhT1pCVUNVWkk5bm5yeVRJazlLWHo1WmxQTUgyUXlIQjRFdlBWbGlC?=
 =?utf-8?B?eVJIbjlvdzE3ci9FYTRMMW9WR1hFWVkzTHlZOXVzWmRGTWVqOGFheHE2b2Vj?=
 =?utf-8?B?UTVJdG56dW9TSlJURHgvdVFSc3JHcVk2YmtITitEbHdQOUxUemI3bEh5Z3g5?=
 =?utf-8?B?c2h5aWhjVHZTVHBZN0Vmazk1cG5GS0tITE1DMjVpTy84SEp5b2ViTlE0bWFn?=
 =?utf-8?B?M3hiKy8xTldjVGdnT2tOTk9mUk9kS3JIRnFpV2ZnOThyd296cGFBZGxPTFJq?=
 =?utf-8?B?SExtdXdydm1LNEgveDhXMEVicHpmYklJOGpMTDFyN08wODZmOXRWVlZ2Vmhm?=
 =?utf-8?B?czhjTUlaSjIyQy9wUG9FQ3FaSkNxWHpvdmZwcExieHlGemNrdVlvN0lUZFVO?=
 =?utf-8?B?YzFwV3FqaFpBdmxDVXlLWE9VUDgyejd6MCtIbEZwZWlNamtmTTZXc3crT2M1?=
 =?utf-8?B?UmJtTDVrdDZldGs0TnlZUWVlS09ETkhVV1BWdVpUeHFIUHU0dkFMeGlaRWVy?=
 =?utf-8?B?OVpINjJ5cFlQWjhRWkxpWjNvVFBYemRRZ0RCL3BUV3lZanhHaSs2MXRTYmFE?=
 =?utf-8?B?ZGVSa3ZaUTFycjU0WUxnSHpod203ZERrVThkWTVtTmdwaWJPVUorWHlFM0w5?=
 =?utf-8?B?bnJyb0s2T3ROcFNSMFhYUWdxVmxvb2NJSUNUdVFFSEtvSDN1Q0xmMVRFMS93?=
 =?utf-8?B?RWxnMmNZYWo1Mis4dkpwWTVhbDdjMnowVEFWMlpYMXVJSzY4Z05YdG1ra1Zs?=
 =?utf-8?B?aW93L3lNaDVhSXA1MTZIZ29JR0h2Uy9zZEJpS0NOcHRYODkvUzYvcUJjUDdU?=
 =?utf-8?B?NEtXRjZOVkZKRWVPQmxicjRLV1J4eEdUakU2cmhNUnFzSmdQdE5XV3ErVWNi?=
 =?utf-8?B?NElnd3dycnduZlNYMHd0WktacDViNUlxdWtFb3FmZzArekV2ejYzRkZLVFdN?=
 =?utf-8?B?WHg2dlVJdXR0SVVnOWxhR0QrQU51ZFIwdDFrNnkrbEZ5VXQ1TnE5MDdUTzB0?=
 =?utf-8?B?a0RqYW1jZm8yN3RUbGY1bTExOHBidWhrZ0Y2dE4zS08yWkEyM2dnbTBscFVX?=
 =?utf-8?B?Z05GNTNIWFJvWnJ2VDFIdXdIRkJxV0FIUVNieVRaaHRSbnJsbDhrdnM2TjIv?=
 =?utf-8?B?VkRSWkNnSWNoQXZsRk9MajRMVDUyVUdUUGtnY3BTSlAyL0V3djJEK3VVTUx6?=
 =?utf-8?B?K0VhNkIzbFRDVXBkVmQvR1NZa21MbHViTTZxdDZyc2xwYVg0NnpnTXM2bWx0?=
 =?utf-8?B?YTJLcE14SElLQXd1Wm52c05lQVJrczUwWjZyV2VZeVA4WkRkOWk5Y0cvSkNr?=
 =?utf-8?B?WmpSYmR0dEFXSDJoaklFU1F6U1J3V204QTc2di9DeFArb09XVDgrRDNqSkpy?=
 =?utf-8?B?WGRsYnAvKytDM051NWxIUjh4UEtFT0ZzNTlWWHpyNGJUZ0ZDRW1sK01uWC9t?=
 =?utf-8?B?Mm84V0s5UFdmbVFvS0NNUFRscEF2NHk2ZjFPcEpZVFQzZXVPZGw5ZUhHYnZv?=
 =?utf-8?B?WnVZM0hDUG1xbkhzdmorMGNnWS9wcThCVDlRWGtoeTJHNWdiUXZtR21QNVRw?=
 =?utf-8?B?Q2kvd29tVzJNNEloN2w0WUtoNXRRNk44dThjbEt1K1lKTUFxQTJTVy9xYlkv?=
 =?utf-8?B?MFNkWHhET0dGUWlMc1F5aWtRd3grcFplUHBKZnhEOGxLYmRSZG1ycm5FNEdB?=
 =?utf-8?Q?tgpw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bad5ab2-ee16-491c-4e0b-08db84bb9be8
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 22:42:31.5208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aAboJ5MP5wpobRnKSAQvqPxxdqBi6E4alsFdnIhZb7h2D0XXu76OA0szbYc+VDbU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9178
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

On 7/14/23 16:54, Reinette Chatre wrote:
> Hi Babu,
> 
> On 7/14/2023 9:26 AM, Moger, Babu wrote:
>> Hi Reinette,
>> Sorry.. Took a while to respond. I had to recreate the issue to refresh my
>> memory.
> 
> No problem!
> 
>> On 7/7/23 16:46, Reinette Chatre wrote:
>>> Hi Babu,
>>>
>>> On 6/1/2023 12:02 PM, Babu Moger wrote:
> 
> 
>>>>  	ctx = kzalloc(sizeof(struct rdt_fs_context), GFP_KERNEL);
>>>> -	if (!ctx)
>>>> +	if (!ctx) {
>>>> +		kernfs_destroy_root(rdt_root);
>>>>  		return -ENOMEM;
>>>> +	}
>>>>  
>>>>  	ctx->kfc.root = rdt_root;
>>>>  	ctx->kfc.magic = RDTGROUP_SUPER_MAGIC;
>>>> @@ -2845,6 +2860,9 @@ static void rdt_kill_sb(struct super_block *sb)
>>>>  	static_branch_disable_cpuslocked(&rdt_alloc_enable_key);
>>>>  	static_branch_disable_cpuslocked(&rdt_mon_enable_key);
>>>>  	static_branch_disable_cpuslocked(&rdt_enable_key);
>>>> +	/* Remove the default group and cleanup the root */
>>>> +	list_del(&rdtgroup_default.rdtgroup_list);
>>>> +	kernfs_destroy_root(rdt_root);
>>>
>>> Why not just add kernfs_remove(rdtgroup_default.kn) to rmdir_all_sub()?
>>
>> List rdtgroup_default.rdtgroup_list is added during the mount and had to
>> be removed during umount and rdt_root is destroyed here.
> 
> I do not think it is required for default resource group management to
> be tied with the resctrl files associated with default resource group.
> 
> I think rdtgroup_setup_root can be split in two, one for all the
> resctrl files that should be done at mount/unmount and one for the
> default group init done at __init.

Ok.
> 
>>>>  	kernfs_kill_sb(sb);
>>>>  	mutex_unlock(&rdtgroup_mutex);
>>>>  	cpus_read_unlock();
>>>> @@ -3598,10 +3616,8 @@ static struct kernfs_syscall_ops rdtgroup_kf_syscall_ops = {
>>>>  	.show_options	= rdtgroup_show_options,
>>>>  };
>>>>  
>>>> -static int __init rdtgroup_setup_root(void)
>>>> +static int rdtgroup_setup_root(void)
>>>>  {
>>>> -	int ret;
>>>> -
>>>>  	rdt_root = kernfs_create_root(&rdtgroup_kf_syscall_ops,
>>>>  				      KERNFS_ROOT_CREATE_DEACTIVATED |
>>>>  				      KERNFS_ROOT_EXTRA_OPEN_PERM_CHECK,
>>>> @@ -3618,19 +3634,11 @@ static int __init rdtgroup_setup_root(void)
>>>>  
>>>>  	list_add(&rdtgroup_default.rdtgroup_list, &rdt_all_groups);
>>>>  
>>>> -	ret = rdtgroup_add_files(kernfs_root_to_node(rdt_root), RFTYPE_CTRL_BASE);
>>>> -	if (ret) {
>>>> -		kernfs_destroy_root(rdt_root);
>>>> -		goto out;
>>>> -	}
>>>> -
>>>>  	rdtgroup_default.kn = kernfs_root_to_node(rdt_root);
>>>> -	kernfs_activate(rdtgroup_default.kn);
>>>>  
>>>> -out:
>>>>  	mutex_unlock(&rdtgroup_mutex);
>>>>  
>>>> -	return ret;
>>>> +	return 0;
>>>>  }
>>>>  
>>>>  static void domain_destroy_mon_state(struct rdt_domain *d)
>>>> @@ -3752,13 +3760,9 @@ int __init rdtgroup_init(void)
>>>>  	seq_buf_init(&last_cmd_status, last_cmd_status_buf,
>>>>  		     sizeof(last_cmd_status_buf));
>>>>  
>>>> -	ret = rdtgroup_setup_root();
>>>> -	if (ret)
>>>> -		return ret;
>>>> -
>>>>  	ret = sysfs_create_mount_point(fs_kobj, "resctrl");
>>>>  	if (ret)
>>>> -		goto cleanup_root;
>>>> +		return ret;
>>>>  
>>>
>>> It is not clear to me why this change is required, could you
>>> please elaborate? It seems that all that is needed is for 
>>> rdtgroup_add_files() to move to rdt_get_tree() (which you have done)
>>> and then an additional call to kernfs_remove() in rmdir_all_sub().
>>> I must be missing something, could you please help me understand?
>>>
>>
>> Yes. I started with that approach. But there are issues with that approach.
>>
>> Currently, rdt_root(which is rdtgroup_default.kn) is created during
>> rdtgroup_init. At the same time the root files are created. Also, default
>> group is added to rdt_all_groups. Basically, the root files and
>> rdtgroup_default group is always there even though filesystem is never
>> mounted. Also mbm_over and cqm_limbo workqueues are always running even
>> though filesystem is not mounted.
>>
>> I changed rdtgroup_add_files() to move to rdt_get_tree() and added
>> kernfs_remove() in rmdir_all_sub(). This caused problems. The
>> kernfs_remove(rdtgroup_default.kn) removes all the reference counts and
>> releases the root. When we mount again, we hit this this problem below.
>>
>> [  404.558461] ------------[ cut here ]------------
>> [  404.563631] WARNING: CPU: 35 PID: 7728 at fs/kernfs/dir.c:522
>> kernfs_new_node+0x63/0x70
>>
>> 404.778793]  ? __warn+0x81/0x140
>> [  404.782535]  ? kernfs_new_node+0x63/0x70
>> [  404.787036]  ? report_bug+0x102/0x200
>> [  404.791247]  ? handle_bug+0x3f/0x70
>> [  404.795269]  ? exc_invalid_op+0x13/0x60
>> [  404.799671]  ? asm_exc_invalid_op+0x16/0x20
>> [  404.804461]  ? kernfs_new_node+0x63/0x70
>> [  404.808954]  ? snprintf+0x49/0x70
>> [  404.812762]  __kernfs_create_file+0x30/0xc0
>> [  404.817534]  rdtgroup_add_files+0x6c/0x100
>>
>> Basically kernel says your rdt_root is not initialized. That is the reason
>> I had to move everything to mount time. The rdt_root is created and
>> initialized during the mount and also destroyed during the umount.
>> And I had to move rdt_enable_key check during rdt_root creation.
>>
> 
> ok, thank you for the additional details. I see now how this patch evolved.
> I understand how rdt_root needs to be created/destroyed
> during mount/unmount. If I understand correctly the changes to
> rdt_init_fs_context() was motivated by this line:
> 
> 	ctx->kfc.root = rdt_root;
> 
> ... that prompted you to move rdt_root creation there in order to have
> it present for this assignment and that prompted the
> rdt_enable_key check to follow. Is this correct?

That is correct.

> 
> I am concerned about the changes to rdt_init_fs_context() since it further
> separates the resctrl file management, it breaks the symmetry of the
> key checked and set, and finally these new actions seem unrelated to a function
> named "init_fs_context". I looked at other examples and from what I can tell
> it is not required that ctx->kfc.root be initialized within
> rdt_init_fs_context(). Looks like the value is required by kernfs_get_tree()
> that is called from rdt_get_tree(). For comparison I found cgroup_do_get_tree().
> Note how cgroup_do_get_tree(), within the .get_tree callback,
> initializes kernfs_fs_context.root and then call kernfs_get_tree()? 

Yes. I see that. Thanks for pointing.

> 
> It thus looks to me as though things can be simplified significantly
> if the kernfs_fs_context.root assignment is moved from rdt_init_fs_context()
> to rdt_get_tree(). rdt_get_tree() can then create rdt_root (and add all needed
> files), assign it to kernfs_fs_context.root and call kernfs_get_tree().
> 
> What do you think?

Yes. I think we can do that. Let me try it. Will let you know how it goes.
Thanks for the suggestion.
-- 
Thanks
Babu Moger
