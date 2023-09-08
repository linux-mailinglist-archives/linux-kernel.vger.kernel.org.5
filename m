Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43E5979918D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 23:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235303AbjIHVfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 17:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjIHVfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 17:35:18 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8C1E46
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 14:35:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J2X7j9EbPPyEvl0NX6ceYK3kx7Wz3YBN4IZI/U/fAbIE6Pva56oqe7wT9FpmVchSSfwP1PLsxETG45ArTQfvSWOKrxD7Hsf1uZcs3fYVmx91vq+h6wYscqf6oBpK5+Rj3LsrSBKVNyz+93QgtDSRJxMdRPDBrEbWWLZcKMObR//OHTy7CVVJpJ6D2u0pwYbWW6tCnP9gHcNqgQdYo/agTSNdZdnG1TdJwPgWqlL6YRJCLyLZ7n4LfApiODapXa32177frIILxdaS9Y/TKjvqfozBtqDKry3pfxaJFUnNle0fmCqwgTmw/1eulUXo1hqSOAxWUdjAZX8XbAw86Vo5bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rtz/oQ8J/UEsdIE/20EYKVzr0cYI17afJUtuAkyBiMM=;
 b=e3eP7a8RMMtAO2bf+W+hv16Z7/spAOpgfYzrBQCDUnfLozKRVieMqWCIbn0OrKSdsd+pc55MHpvKCChU7xq99S18tGaw9enL9Nk1Ev7ISRVAAj7aCFNZorW1QdWNFlWwaCChsd1RSN0NfW7K2y2E7Eb4rlQncddtgMT2MFgHONzohx6f6M38hdibMKEAiqMYqEQ0RdyTg1RE/KNmKxusEF+jD9+PsRMIOFEXTQ6mrk6SwpuO3aI0ifr4DDlEk/FGptJ93dZeyQIExLhIgi+crDB4JtXTWns8xxyyQCQsfOn0Ovwuchf2EUX+/MxVd159jvUq2zhDXFapdyo9i8AnQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rtz/oQ8J/UEsdIE/20EYKVzr0cYI17afJUtuAkyBiMM=;
 b=U9pD75frzGL6mm/g6cqJJCfVjBYDYhCJwaretxacFJhRxWE6HP7NA5oIYoJfDvYK393Rs28vGV/5m06EzqREPlZ+dHLC0DdSGMQYJ5CMFAGNdGcYqoL3xsHxJAnw2F6pRG/ohCONG47vyUietzjNJyP4Y4AojEV8ril/3z+40KQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DM4PR12MB5055.namprd12.prod.outlook.com (2603:10b6:5:39a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 8 Sep
 2023 21:35:09 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::fbfe:ec9c:b106:437e]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::fbfe:ec9c:b106:437e%5]) with mapi id 15.20.6768.029; Fri, 8 Sep 2023
 21:35:09 +0000
Message-ID: <09e2894e-eb2b-12a0-c4a2-5000b27bbded@amd.com>
Date:   Fri, 8 Sep 2023 16:35:05 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: resctrl2 - status
Content-Language: en-US
To:     "Luck, Tony" <tony.luck@intel.com>,
        "babu.moger@amd.com" <babu.moger@amd.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>
Cc:     Amit Singh Tomar <amitsinght@marvell.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        George Cherian <gcherian@marvell.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "peternewman@google.com" <peternewman@google.com>,
        Drew Fustini <dfustini@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <DS7PR11MB6077FE180B11A9138D8E7ED7FC1DA@DS7PR11MB6077.namprd11.prod.outlook.com>
 <35f05064-a412-ad29-5352-277fb147bbc4@intel.com>
 <SJ1PR11MB6083BC6B330FA7B7DFD3E76AFCE3A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <dc4cd365-2a02-32a3-da78-7ba745877e97@intel.com>
 <SJ1PR11MB6083C0ED50E9B644F4AF8E4BFCE3A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <fb9499b9-c445-01e8-8427-6b05256abdb5@intel.com>
 <ZOkU+d4AsLGSAG+y@agluck-desk3>
 <b48fe955-c1b4-4aeb-1ab0-bf26e56e1f0e@intel.com>
 <ZOlRNTq3lE7VNHjU@agluck-desk3>
 <9742f177-a0ce-c5d3-5d92-90dda32f5d07@intel.com>
 <ZPjDHN0nvHz9kWFn@agluck-desk3>
 <18f3a209-8dbf-4837-6bcb-a71a1ee1abb3@amd.com>
 <SJ1PR11MB6083849D1AEF44806C4D669AFCEDA@SJ1PR11MB6083.namprd11.prod.outlook.com>
From:   "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <SJ1PR11MB6083849D1AEF44806C4D669AFCEDA@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR05CA0017.namprd05.prod.outlook.com
 (2603:10b6:805:de::30) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DM4PR12MB5055:EE_
X-MS-Office365-Filtering-Correlation-Id: cb72571c-1bd5-4d96-5ba4-08dbb0b379b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3SK2z+ZUVar1v34GMSRVCOHKZbWJYeQXL5hELu0lP47XtMTEfJOOFOzex4FfRt5+S3KO47+xGnf9RpAhvs228msNKw8ud7jz3MPGL9uNPlullVm9w5EAK/bdpGsEo6Y/CC4wmh8Esz3ZETaAFyxVhfqMdGCmdtFlNqFk4Xw+Ylsn588uIK00eeOZfVBZATn2LYRYJZXuu01cVrG+tjcXvYeeszf6L2hCqIZT8lO5KTFu541XJe+oiiCP6r3jz/nIfzcbbFwm0x1t6Lx0UI8Mr6hWJQRRQdQHMS3Bk2hixAcq5bVww5hj5DYCPi5n2sbPkkHslz47nxfQa8XYjtp0CncCGHBlQ2us1Z/X1IAcmb/KOgL70eFgRwnf9/iRVyr10aASleilRq8/V3ToiGCtQqTWD8go5xvw8MGhF+986oc5TLD2z2C5CuIkbQyBvy0JaALRKnxT0V+qSog3QqhybEVTbAWscdbBCJ8TSfFxW8PSUGhltqg6wJgo5nPBcfusY0rng+kLfp2c35eHLSavNwPv/B+DRM9DplADwxQsfK8G0mD9nLOYsmzq+kPb5Ew/taPogAZt0AOMcQLBNGipNy82Gu6poYLUuTr/TvKn0Ax1Qxn/M2SJ59OvIh5HpetNw+B4Q1PmNkQRC12j+ikpZw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(39860400002)(366004)(396003)(1800799009)(186009)(451199024)(2906002)(38100700002)(36756003)(31696002)(7416002)(6512007)(316002)(41300700001)(53546011)(66556008)(6486002)(6506007)(66476007)(54906003)(8676002)(110136005)(2616005)(4326008)(8936002)(478600001)(6666004)(31686004)(66946007)(83380400001)(5660300002)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGQ4TnhkdzRoS01EUUFsZjVaWmtHZWM1YVNvQnFYakM2RkNSaDRDWU56cnp6?=
 =?utf-8?B?Y1pBUC9adStiQkh1YWVqdkVmMG5naGFQOGJ2VWRQckNTYVJrQ0FuWDdEZUQ1?=
 =?utf-8?B?YnI1ZVQ1UXlKUkhFUGw1UGtHdGVSOUM0M1pOajhiSU40anlSUjA5MG04bVd4?=
 =?utf-8?B?YzRNajZ4d3FMcHlJZVh4QS9xNGozSzBuRTBZMnRIcGFKeVVjdmhKSDdYeVBS?=
 =?utf-8?B?LzJldXpsQ3VtVE9wNFhmV0pSQ2VDVEVRK2srbXBNcFVmaDUrRHJ3MmNTOHY3?=
 =?utf-8?B?RVNHVmprdkJ1RU91dXV2d1lCV0xsRnViajBtQWpyYU10NEJJQi8zakw1ZU1I?=
 =?utf-8?B?QkZoZDVwRzRsTUFIS08vaUozSVJtb0hybWZrUlhWWitkVTNVeUxaRG96M2ln?=
 =?utf-8?B?UTYrY0FrQkdIeC9va01QQk9WdEtEa1JNS2tCckxudzBpTWlFTzV2QkJiaFZS?=
 =?utf-8?B?bms2WWsyOVlFbWpkakM4ZWpMYlp3RlhnYy8yMTFQVDFFRzhMSWVLbzAwa3ZE?=
 =?utf-8?B?VDdqbkNtVy8xZXg2M252cWpBbW9nSS9kMDdBT0xyeWpTWlRhY21Gc0RJVito?=
 =?utf-8?B?YkRLby9GT3JLT3pqeExRNTZQSlhROVV0RG9ralBrZDBsbVVTc1YzalNWL0Y2?=
 =?utf-8?B?dmp6WVd3dHNNdWk2QVlBaFNLUTBLdVpXcmxoS01nM1c5ZnAxRXBnelBPVEF6?=
 =?utf-8?B?TUY4VTVEd0V2dkY4VzQremtWYVZNN21FaDdjUFhXR1lzRUpuV0FpaFdUelZW?=
 =?utf-8?B?QmF3a1BqdytkdjVtVGZNZnlNbHl0RXh0d3lsWkYwYmltTzNHRkw4S0Qra1hN?=
 =?utf-8?B?UWlIVlNSMWV0NE9qOFdnUFdLRXUwOXA3YWxxTHYxcnEvZFdmU3o3dldTZXln?=
 =?utf-8?B?TU9CdE56WWpIYzg4dmJYYXNFUjBLdHV3aHp5UmdlL0JodUR4V1k0S0FvYU5l?=
 =?utf-8?B?VGthM2NhVEJrZG1VZzZwWFRrTVhGeWZ5bjZDUWwvTUU1OGd5dG9Yby91VXV1?=
 =?utf-8?B?a0VrZkJXZmRZY2oxeG1FNVRua0lvNEFsaVpQZ2ZrT1c5VVZQWWJDM013SmI5?=
 =?utf-8?B?MWd5SFlzVFRyZzBzakpOZW1vNzhFaW5DMGxwajBNY1k3Y0U5d3NUTmlGUDJx?=
 =?utf-8?B?ZTJwR1BsSmE4RHlCSkFCb202NnlrWGM4KzZXQm1lK2p2WTd4dU9pTTg3dXVE?=
 =?utf-8?B?K1BBdW5SNFQ2eitTRS9Ca0s4dWpCSDFUdTJJUVl1eGtKNHVoUEJTOWNHYXow?=
 =?utf-8?B?SUtRTHFhN3BxNDhIK3dWbnpxWjgybGFiTEh4VTQ2RTBOamoreGlRNHprbktu?=
 =?utf-8?B?S2JFUkhuQnE4WmJxOTN5Rzh2WUlnelVEbVpPZWZmb1dyaVRSdTZmOC9LdGFM?=
 =?utf-8?B?d2txdUY0RXNlYXNOVmNGeHljUUQ0UlJOMEtMTU1NTC8wWWVib3RPK1JjcFBn?=
 =?utf-8?B?alFRNmNHMThWdzNMVU1WQXBwSmNMTHFvTysrdzNZRG9BZlVYNWc4RVRjR0lQ?=
 =?utf-8?B?SERVbFNkbkNGZmtOTmlibWdXSHBTNDVoR2RQcGM0djQ4OXF6YkNWYTZOdW91?=
 =?utf-8?B?d2pLOG5BTnlIWnZyNW1uSXdjQjNIZnc0Ujk0ZHdia2EzUkZkcVJEMndLZUgr?=
 =?utf-8?B?Rk8zcXhLb25RZmRERzZsYkY4STN4eEgrQXhsTFhnRDJQSU51RUxnVkowSWpr?=
 =?utf-8?B?Vmhxamc2NEZtSmxpbGZCWnFVT2pLODk2UzZkTDdCS1c4b3dtN0d4L0toWG9N?=
 =?utf-8?B?S1hZeFVNc3BnZzVNWnoyMFJhTWxZYi9YcUxTbTJ2V3R4ZVdESHdtWjRrc3BP?=
 =?utf-8?B?Y2c0dGg1am82dEVDTTRVbzM4YmRFaCtzekpmUGZtUVNYUkRKTDQzemxKYlJP?=
 =?utf-8?B?ZkMraTlIOW4rc0daZ2I2N1NiV1lGM1BHd1MyZVkxRTFhOWRQdE9lZ3gwZE1N?=
 =?utf-8?B?amlKVFdkaHh4amlIMms1bE4xTU4wSGIzcnRNODcvcVRtbGZzUUtWMWNhUFk4?=
 =?utf-8?B?L0dTQlkxR0lsanVHUFhPT2d3QmFGU245R2hxeFI3SFpyaHQ0bmlOR2RGZXpC?=
 =?utf-8?B?bktpSGcxdVBTOEo0R2s1OTJZMzFsMlgyeVE5Z1BrZlRBUjNEdlJJRkpJQVZC?=
 =?utf-8?Q?WOfcCNHdoFgA5/r72n5h106Q9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb72571c-1bd5-4d96-5ba4-08dbb0b379b8
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 21:35:09.2902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qg/3g6Y5lt4dOOtNf7CstCExFj1NMQ/OkjigG1IzfW1ColUFQ6uI+H5aImt2pF0E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5055
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,


On 9/8/2023 1:51 PM, Luck, Tony wrote:
>>> Can you try this out on an AMD system. I think I covered most of the
>>> existing AMD resctrl features, but I have no machine to test the code
>>> on, so very likely there are bugs in these code paths.
>>>
>>> I'd like to make any needed changes now, before I start breaking this
>>> into reviewable bite-sized patches to avoid too much churn.
>> I tried your latest code briefly on my system.  Unfortunately, I could
>> not get it to work on my AMD system.
>>
>> # git branch -a
>>     next
>> * resctrl2_v65
>> # ]# uname -r
>> 6.5.0+
>> #lsmod |grep rdt
>> rdt_show_ids           12288  0
>> rdt_mbm_local_bytes    12288  0
>> rdt_mbm_total_bytes    12288  0
>> rdt_llc_occupancy      12288  0
>> rdt_l3_cat             16384  0
>>
>> # lsmod |grep mbe
>> amd_mbec               16384  0
>>
>> I could not get  rdt_l3_mba
>>
>> # modprobe rdt_l3_mba
>> modprobe: ERROR: could not insert 'rdt_l3_mba': No such device
>>
>> I don't see any data for the default group either.
>>
>> mount  -t resctrl resctrl /sys/fs/resctrl/
>>
>> cd /sys/fs/resctrl/mon_data/mon_L3_00
>>
>> cat mbm_summary
>>        n/a      n/a /
> Babu,
>
> Thank a bunch for taking this for a quick spin. There's several bits of
> good news there. Several modules automatically loaded as expected.
> Nothing went "OOPS" and crashed the system.
>
> Here’s the code that the rdt_l3_mba module runs that can cause failure
> to load with "No such device"
>
>          if (!boot_cpu_has(X86_FEATURE_RDT_A)) {
>                  pr_debug("No RDT allocation support\n");
>                  return -ENODEV;
>          }

Shouldn't this be ?(or similar)

if (!rdt_cpu_has(X86_FEATURE_MBA))
                 return false;

>          mba_features = cpuid_ebx(0x10);
>
>          if (!(mba_features & BIT(3))) {
>                  pr_debug("No RDT MBA allocation\n");
>                  return -ENODEV;
>          }
>
> I assume the first test must have succeeded (same code in rdt_l3_cat, and
> that loaded OK). So must be the second. How does AMD enumerate MBA
> support?
>
> Less obvious what is the root cause of the mbm_summary file to fail to
> show any data. rdt_mbm_local_bytes  and rdt_mbm_total_bytes  modules
> loaded OK. So I'm looking for the right CPUID bits to detect memory bandwidth
> monitoring.

I am still not sure if resctrl2 will address all the current gaps in 
resctrl1. We should probably list all issues on the table before we go 
that route.

One of the main issue for AMD is coupling of LLC domains.

For example, AMD hardware supports 16 CLOSids per LLC domain. But Linux 
design assumes that there are globally 16 total CLOSIDs for the whole 
systems. We can only create 16 CLOSID now irrespective of how many 
domains are there.

In reality, we should be able to create "16 x number of LLC domains" 
CLOSIDS in the systems.  This is more evident in AMD. But, same problem 
applies to Intel with multiple sockets.

My 02 cents. Hope to discuss more in our upcoming meeting.

thanks


