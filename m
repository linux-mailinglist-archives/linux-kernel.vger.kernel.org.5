Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 674E8774359
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbjHHSCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 14:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234151AbjHHSBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:01:55 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on20609.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaa::609])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1528C2D497;
        Tue,  8 Aug 2023 09:28:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R/rPO11/uSE1WlEWycvQ6Evr48mRvwqFbZYiqJ3veXGi8pl30bjIJ09kSDQbAy+qhkW0ZAbvjT3FfT5aZcpfZNVAUC6pUC8wZ+XefXuJnNeJCqR9TNTqFAPD1nDvhpOxcmVe1oDZXn/m1fdUzrjpla2VkDvsLf3yFbQfAkMc/yeabrvjyFVl70PLjRPgBTwljKRLbLClBJ7uzyt9cagavbmoK+otPRdulk/sryQ1qI5bVc82Uv/9+VMlQ68Q+8zUsPFtg0n3x02M1Z8z2JJVizwllKTPfbyKT+awmr1dc8Di0qDoepa8rM562Wv1aR99hfPCF8NyHEEWIWu57y972A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I+RA5YmOmhmV9/RkAmYftrjv6SV7B2qjgzZOJGJ8O5w=;
 b=Shlg8KmYfCAaZBgKNM+Uefm2hhdTPMbelHB/mHL8ce3YnzJow4wZNwn5g3OResSXkD2ROhI7EfwxCiGFN+zUAkXd7oUA8wUSMRidc+m7AsnG8+7oTp4xf9zP+/EfKobhWKzFn5Ws81oa791Lj2RrTVO3fZMSHkzl92A/uCTrT3ZsqRsni2rNMXX+l/kyZ5xFvevG/ESgI6lX24dQBjwBiEgvVK8SYNVS2hE7ktFi9oXUvtrZ+pqMMLMXygjL9i9C0J3w30Awvzm2OIQaVAFLD58LvI1ZIljDZXIREHxAbkeQepJIYd/5Svr51+N33zX+wDt996YLA6rrhF8c0IL6+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I+RA5YmOmhmV9/RkAmYftrjv6SV7B2qjgzZOJGJ8O5w=;
 b=CmOW0szhB4cJC2XuR/cHhejAeDV3OxxSPSwpPZ4NEca7eK2UZs3wRxkRMeT8OztTKmHnBU7sivUILuVQMxEQGnkGGNAZZ6S/W9t7BFZoN3XLgQy6YarhZm8kiqzKBD2AzmaFMTecXqtd77lhXHI4jNkiW/q+pcAcL28850wbzjY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MN2PR12MB4334.namprd12.prod.outlook.com (2603:10b6:208:1d1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Tue, 8 Aug
 2023 16:22:07 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::ae3b:f153:4d30:73a8]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::ae3b:f153:4d30:73a8%7]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 16:22:06 +0000
Message-ID: <5173245a-ea63-a75f-0563-38a16d0bae4d@amd.com>
Date:   Tue, 8 Aug 2023 11:22:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v6 6/8] x86/resctrl: Move default control group creation
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
References: <168980872063.1619861.420806535295905172.stgit@bmoger-ubuntu>
 <168980893158.1619861.8945141367681744527.stgit@bmoger-ubuntu>
 <2a48c57a-ff8f-b657-8138-a5da6c7806db@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <2a48c57a-ff8f-b657-8138-a5da6c7806db@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0065.namprd03.prod.outlook.com
 (2603:10b6:5:3bb::10) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|MN2PR12MB4334:EE_
X-MS-Office365-Filtering-Correlation-Id: 95d31fae-0595-47a8-52ce-08db982b9bb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2rgLoQphKja98/wq0phQ6FnZo/M/JzX+/NWCS+Y4wpOexnWptvEa4xK5qcb5y7EeXUhJyceY6fPlB0qfXfQfGn6A3/fiM2+NBvl55fq9JdkowVFhasPlu1kEW6pRdBD9kE6ozTJvE5fcGnBygVVP8NI8FzUjdbyklQ+nwQCPSnG9zVk6NhOAL8vp9zaKtkkqKcJ1yvLj/87Az2YMpx/JIEU03Zj78Yw+fp+np04csOoN7gel2RlPNK9uQUXq0RIxVMkmsy26RQpJmMFvtWoHqE1euIiD6rYkoUqRLyQeV7aUtssDCINHtVGqaF/In/eM3mVWRnNqRplpr+4HWs8QuCNIQM7gS7S3BlqGNRwGri58TUJeUVHa/9eLvmGtx3S98TPXkZeIE+Az2i0lJqyrATjaELrx7oQONPLfOWqlKPk8f6iwellrfzJpXWXEknpU7iwfo0hEqcTPohuZr8nZviXrzEMwmqcBUY87WjMpFTiitCXPgv4lU70ijw1qVfdOejDZ5X0jiAq3Fo7Qdq02GSzm6T65dBAXKpbLcPqK5zkXLJpx3s5browByDtsoNhC7XLpuo4kXM6k4zjLlRVi8Pzhhk1iy93w3hS+Q5U2WXZnHCosN9ApsRX0mOTIkhvynkYxL9FrVsVzA32XRb3TNA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(39860400002)(376002)(366004)(451199021)(186006)(1800799003)(2906002)(83380400001)(36756003)(5660300002)(2616005)(3450700001)(6666004)(6486002)(66946007)(66476007)(66556008)(4326008)(6512007)(38100700002)(316002)(31686004)(41300700001)(86362001)(31696002)(8676002)(26005)(8936002)(6506007)(7416002)(478600001)(53546011)(7406005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlUxR09FY2l3dHJITStmNmt0V3JxRkYyVUdXalRHbEI5dUpRNTNFUzdBajZT?=
 =?utf-8?B?NmY4N2NDSVdWVzJIMFZJZnNpZlpBVXRWZC8zVkRSYmpJVWhyeExnZHhaV2tE?=
 =?utf-8?B?VFc0N2JIU1IzWnY1Q3dTTXk3blVPU25EZzZOK25WVkoxU3RwRnBScjJVS0FW?=
 =?utf-8?B?eDU4ZFhxR3R0VUlBWnZjbzh1NmxCUFBPZ0Q4NEM1Y3dPaWF2TURBZnZHY01Y?=
 =?utf-8?B?TGVEVFdoYi95WVl1U09MN25pd25lLytVY1dYVE9lbmtBNUJuenlRMGc1d1NW?=
 =?utf-8?B?U05lQzhGTnR1M2ExZndaNDhYY2NVQWJGSXVGVHk5Rk5TVjZka3hreVZDNVpN?=
 =?utf-8?B?K3VPditJQWdwVWFuelp0K1d1aW5sSkErT0ZnK3VxbkFMQVdPZzdwYUY1cXF1?=
 =?utf-8?B?U1hwdGFTdDY5MnZyR3ZkdW5JbVZGNkFCMkJ3WElya3J3UkdzV0NuSERXSkhq?=
 =?utf-8?B?WFBEOE1zVFQ1Z1VpWnBsZ0JRaFJyOWt4L3ptd2dlclliOFl0MHFKWmNlSTdt?=
 =?utf-8?B?VmtVS0F6NUlzR0RlWVkwbXhNckFpdG5OcWhFRDZJNWJ4M3hqNDhLK0ZqZ2Yw?=
 =?utf-8?B?Zm1yWjJzZ2RjNlAxRHZkaG9NK3R1a2Z3d0ZYTVBlL3drVmR1SFJmeDYvUnl1?=
 =?utf-8?B?cVVnNGM1K2VZUUZjaHJvRWF0SzZhZHc1MWJtTUZzZXNxTjZTeCtuTVBRSStN?=
 =?utf-8?B?eVdObjVQRzZ4SzNIMkdURUJLamJ6Zk9mYnR6dDd5OUpCY05maWlieTNmbnN6?=
 =?utf-8?B?eS95UjJLcnlYMENVYU5KNWwyNWxJOVBMRXpKa0dlalFrcTY5THdSanBLaG1s?=
 =?utf-8?B?cWczQ0NIRTFLV09NWi9yMkhqSlZUVWlsa2JpM2xzQ2xWUms0TXgrZllVdTM1?=
 =?utf-8?B?SFdqcnd0OXEzYzFIYWwxenVFSTJpazhsYmhvR0NURW0yZ2N5WHdDQWlmWC9E?=
 =?utf-8?B?eWdPNkxZNU5zTEJvNjJzUlE4SGF2T2hubEwyRTkyQ2NuSjdKM3hISm1IOHhP?=
 =?utf-8?B?Z08vdHBSYlYvRklhc3hvZXdXdmJnQ3FMWEVMQ0g3cHRtVXZZeUpVN2FZNW5w?=
 =?utf-8?B?NWIyS2IwelJXZlZQZXRlZ1lvWUhNTG9mQ3NabkFYQThxalRPZDBHVGRaR0NG?=
 =?utf-8?B?L2tmcUU5Z2loRUpXUkJEa0I3S3VCM0d1NUY3K2Y5ZFVndjN4bWpLQzRoRFBx?=
 =?utf-8?B?dWhGUU44SGtyMXdTVTlneU40WXlXdUsxWUV0azc5UU5xVWtjUWVDdDNKdEk5?=
 =?utf-8?B?YzF2MFp3dWt3Sk82VXF5R1JITjVaYms3bUUyTGJteXdDbkVISkthYnFFUms1?=
 =?utf-8?B?VTcydFZZVVZySEpEZDhIY28xZGhCbHdEUDlwVTdCQ01xWFFvNWdjVk9nZjZW?=
 =?utf-8?B?MjJvTXJ4Qlo5VFdJdjU2Q0wvQmtHTXRsQTByZE9KS1FyajZEbmZtUkJxWjZU?=
 =?utf-8?B?czV2c1pXNW9BMzVHYnROeTdqMXdDV0dZNnAySkJyTVcxMDNsa05XRnJQYit6?=
 =?utf-8?B?VkVvYzlzVDJVbXUxVVVMc2NXVzNkSnBFdkhYSWk5MEQ1V3QwcFd4N2JNc2Jh?=
 =?utf-8?B?M0FDQ1lQNnlKVTlaYVlOY1R2NGVpSjY0ajdJOTZmdytQdnlLd011TDJUdDNZ?=
 =?utf-8?B?TFM0WkRpb2ZGazJsK3NwV3hRZGRtclh6bUYxZ0xwbWx3S2V2MnFuZkw4K3hO?=
 =?utf-8?B?L2c1NzgvbG5vWXZhY3Q5N1hDcVg5SSs2b243ZFEra3RJSy8xajIwK2NraHJt?=
 =?utf-8?B?bG5jL0R1NTRMajhnRmF2U3o1V0Z1dnFHZ2trNkhNak04YXNyY2JlbHZ2aVR4?=
 =?utf-8?B?Q3JXN3ZrV3Z6d2g4ajU0dkhLem12TmpFRU1PV2t1ZURySWVDbzVGaFNYSyty?=
 =?utf-8?B?WklGajNzOUlEWXphRkQ5TVZBRHRCL0NDbFQrVU85aEowZzhXWnFYeTIra1JF?=
 =?utf-8?B?SURodVhpNE9vb0Y4dUNONzlqVVBTNnR2d0Z5V0RkdUZwemRQaDNnaU5zcnp6?=
 =?utf-8?B?blZmUTZXWEViOGd1REh1NkEvSTE3UUhpNmhHWDM4Z3dnK3crT0hyYmFNbE5M?=
 =?utf-8?B?d2pkM2VpNGhUcVFUSWk5SDNVRExCcXVFdzkzZGU3UTBtSEphRDBhY2c4elpR?=
 =?utf-8?Q?G4+o=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95d31fae-0595-47a8-52ce-08db982b9bb6
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 16:22:06.8336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0noV5I06M8jS6vP9ELNj4L3VFZvJMJ73bu+gnOOXDz2HhHlLMbdiNrWG0L96XvKl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4334
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 8/4/23 15:42, Reinette Chatre wrote:
> Hi Babu,
> 
> On 7/19/2023 4:22 PM, Babu Moger wrote:
>> The resctrl default control group is created during kernel init time. If
>> the new files are to be added to the default group during the mount based
>> on the mount option, then each file needs to be created separately and
>> call kernfs_activate.
>>
>> This can avoided if all the files are created during the mount and
>> destroyed during the umount. Move the root and default group creation
>> in rdt_get_tree and removal in rdt_kill_sb.
> 
> Please use () to indicate function names.

Sure.

> 
>>
>> Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
> 
> ...
> 
>> @@ -3704,10 +3720,8 @@ static struct kernfs_syscall_ops rdtgroup_kf_syscall_ops = {
>>  	.show_options	= rdtgroup_show_options,
>>  };
>>  
>> -static int __init rdtgroup_setup_root(void)
>> +int rdtgroup_setup_root(void)
>>  {
>> -	int ret;
>> -
>>  	rdt_root = kernfs_create_root(&rdtgroup_kf_syscall_ops,
>>  				      KERNFS_ROOT_CREATE_DEACTIVATED |
>>  				      KERNFS_ROOT_EXTRA_OPEN_PERM_CHECK,
>> @@ -3715,28 +3729,17 @@ static int __init rdtgroup_setup_root(void)
>>  	if (IS_ERR(rdt_root))
>>  		return PTR_ERR(rdt_root);
>>  
>> -	mutex_lock(&rdtgroup_mutex);
>> -
>>  	rdtgroup_default.closid = 0;
>>  	rdtgroup_default.mon.rmid = 0;
>>  	rdtgroup_default.type = RDTCTRL_GROUP;
>> +	rdtgroup_default.mode = RDT_MODE_SHAREABLE;
>>  	INIT_LIST_HEAD(&rdtgroup_default.mon.crdtgrp_list);
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
>> -	mutex_unlock(&rdtgroup_mutex);
>> -
>> -	return ret;
>> +	return 0;
>>  }
> 
> I am missing something here. Why is it now needed to re-initialize
> and add default resource group on every mount of resctrl? I expected
> only the kernfs related changes to move.

Yes. We can do that. I think I started with the previous version and went
that route. We dont have to change the default group initialization.
Will send new version soon.
Thanks
Babu Moger
