Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51CBB783837
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 04:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbjHVCyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 22:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232402AbjHVCyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 22:54:13 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFAF5CCA;
        Mon, 21 Aug 2023 19:54:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ehCAEF4DnxLYXk8hGW04V8ZtODthys9nysrvKKirOfYn+jgDAfH//wiItEEZb44al9lRiJhgYyWQ1XbqeHAiKtzwxXqXml6Lg5CiBXa+zDC15ZvlB8T3ZoNmeSMrB1Tp3ukxZVG1v4xzmyHNmwEqRY9TjTQVSfBwnIRehZWskPLQPfqXdApmvzBP8kI/uWFpBWyIOQh+Fhn3QIMCTMezMJUPpLj8I/Gs1SN3S6B5hS/cchCYYhWxtinfKsJbZExqrFyg7p6QesoLDXtYd3j/cfg0K/VQSco+ybwDaP1Jw9ZNNsYp2rSn9HmWLRUq2f8b1U8igHzK2P0g+okoBjpjKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kPCJE0THL9Zf7IiDKy8FG5EXXy3a86r+MVaWKFMGRhE=;
 b=Mb9VyyOWaZv3cqOX4RW26jTS/QZA9+cyM43C0qxmBtI/Np8Lux1YlK1hEYQSD9NFixCrWysxMKpCVqiKeipbVPtmhOckGo5QrD9l5T2Z0xwhdiBR5LeAoW1FtMjWK/9SsebZVfr+4Gf6FPwt14AafMaApCNOiqlWkNURbKrBhuHyvWyUSiidq2+PdClGXymAZaDXMMKvuvr4gid7VVOkNeEuhHDbTdZPSM1CDm7ec5hi5weL7kX7XmfZ3+iW5x4P2aw0iRyJhTe/1Z5POTnLjVVXr8HkrNUG1UC0YDVXCHFBeWb/jW3y5KQ9SmYyu/CVn+LjzxswWCGj4xQXsMxf0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kPCJE0THL9Zf7IiDKy8FG5EXXy3a86r+MVaWKFMGRhE=;
 b=EOexNP+fO47upCSpqQr8ZAQ28Z9hDnlsPw+Vg3ADkopBXVhKNFHdR8/H06MzOg2/I5nlH/9EehVdjk+fq/vbR2UkU8pfNXXwolHp2abpmgzQ6EMsD65QRWDa2hXFDDIxnokMdRMz58p1VTTUHgfmkPcGVe2J1Fm0c1OYXJ0HLIE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA3PR12MB7808.namprd12.prod.outlook.com (2603:10b6:806:31b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 02:54:02 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6699.022; Tue, 22 Aug 2023
 02:54:02 +0000
Message-ID: <aa7a6b97-fed2-41cb-9ea4-0f42acaaeaba@amd.com>
Date:   Mon, 21 Aug 2023 21:53:58 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: PHAT: Add Platform Health Assessment Table support
Content-Language: en-US
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     Avadhut Naik <avadnaik@amd.com>,
        "Wilczynski, Michal" <michal.wilczynski@intel.com>,
        Avadhut Naik <avadhut.naik@amd.com>, lenb@kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <20230810234856.2580143-1-avadhut.naik@amd.com>
 <a0ab4d07-fb73-418b-b88d-c3ad6aa4cf49@intel.com>
 <655c916e-356c-03e3-6c67-aa40886dd5e2@amd.com>
 <CAJZ5v0j0R1GK=0z+LJd_PSh4zDv9Ydw2YA7HWm1R5wjCUsbbYQ@mail.gmail.com>
 <1c579c96-5010-4e5b-aa27-afb4f4f6746a@amd.com>
 <CAJZ5v0iPRCJLH5bkKyhjUq_tmjmR6R73fhUm3JnKptcm1cn9fQ@mail.gmail.com>
 <6bc15195-aa26-4e29-b625-74fca84f7a6f@amd.com>
 <CAJZ5v0jEcD_1+jHfAk9eN0YYJFbDZN2rZ97KHyH2-w6EqRN9+g@mail.gmail.com>
 <43b65307-bc3f-4014-9bf8-a96c6ed15d9b@amd.com>
 <CAJZ5v0g+uVZwoOr-2W19Ux9u-D=WiY=-dtcQZwYU0Ov_GE5d=w@mail.gmail.com>
 <CAJZ5v0g_DyQAnSuigBc-f0UNmW0mo=0yMadES+0NhphJs_k+cw@mail.gmail.com>
 <9d491dfe-13d8-4072-a90b-5f68107fcf95@amd.com>
 <CAJZ5v0jxKwtHM3vhtw44TW5=J916XvXSeP3DyNLcJDo+eTSRHw@mail.gmail.com>
 <fbc0b21d-33e6-4c32-bc34-3fbfe5e99b1f@amd.com>
 <CAJZ5v0i-=kfBPp2oW-40mNSAFnOzTEeey0EhDUsN6qNU+QY4Ug@mail.gmail.com>
 <0c1fcac6-5497-4a0d-9038-9eebf988268e@amd.com>
 <e608bda7-aadf-438f-bb51-2db599418634@amd.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <e608bda7-aadf-438f-bb51-2db599418634@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0077.namprd11.prod.outlook.com
 (2603:10b6:806:d2::22) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA3PR12MB7808:EE_
X-MS-Office365-Filtering-Correlation-Id: b806e337-68d7-4387-de85-08dba2bb0a67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ywK2B5ipDCR5sylHoP8Nfiuw52hJ1BUoAAnB9HMfbJaZRWBYMmh5/IBIvjJTFcbGqPXBAj41zvUcxnnocEJJpdhBEL//PY9v9cu/F4QYwDVN3fVkPLjBzQo2/FjmNa7zH3x3aNjxg+yX1B8toSgq1n2YPCzwd172Hw+6tdbQb4eVwMpZUrXn7MRGF1c2uZ+WlhMwySajWhpfUk85Xl638tQCMEvuOOl6qja/Yx5GW3wOK21Lovnj7QzHfzucwAWXRS5JbtFaBXSwrQJjC6KIltRO3FBhkJlJKk77s3zT4qZesMGxqrRGrU42MQ5ebSxQleJWdFa/v4dfd7KDWT8VLeddFMn3J298KR98FxnHt2gtfygXk0RNAq5N4qlKTupGR0rt3FyIyq2dlRQoXVks6i9xRrQbqcNbjMmiKy/sADXDGZOJkdfSUb7mIMUikJJzNW33jxbBB3mcHJbYsDOf/jhTAY6jWOWcVQZFGCY6E3CkgDrKf+JEzsboIHq+rhLrPwRQxbtVQb2+JJfUiQJFQMuNDjwziaemBT4xy1a31/8IQg6dVRlhf4X7FmXx60eGLgiBphz3EBxizr5JRmZZ77Ius9LnizLGzfu1rQeb5hJKFEYJG3pp2Iqba7EHCjM1/SSpS9EIX+f+mDWYl6wEcQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(376002)(346002)(366004)(1800799009)(186009)(451199024)(54906003)(6636002)(66476007)(37006003)(66556008)(316002)(66946007)(6512007)(8676002)(8936002)(2616005)(6862004)(4326008)(41300700001)(36756003)(478600001)(6666004)(38100700002)(53546011)(6506007)(6486002)(83380400001)(2906002)(86362001)(31686004)(31696002)(5660300002)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cENObDR3OWUxNDA1TGNJQnczN2x3Y3pGUTRmdnBVTkl5MmRyNEI0R2tNWmNp?=
 =?utf-8?B?VEoyWFJGUWEyb3VTMWlGY2RJdWpLb1hjOSs2YkxXQ1ZPY3FZUW9iWVROV0Z4?=
 =?utf-8?B?MWEydlhrRTNLMkNmanRjYllYN3lmQmlCZE5DK09Dems1b0VvUXpnY2s0YXFP?=
 =?utf-8?B?Y1FjcE9xQ1RXR1p1MmEzSnJwVFV1cHpYUVNxalpCanR6cnNNNFMzR3dGRE9z?=
 =?utf-8?B?MlFvZ3UvRWVVRDcvQ1YxaDdpbHQ4d3g3M2RaTEh6M3NhNFU5Mk5mMUtCd2VV?=
 =?utf-8?B?WGZ1ZDU0TlBvTmdwSEgramhaYyttSWUwQ1JDcE9TVFhzSmFUODZabnNsRzRk?=
 =?utf-8?B?dGhhbmhYd1dTS1BnYitLcmNRVXhvdFlhWkRtMFdENEErS3pZY3QzUHdhbUJV?=
 =?utf-8?B?RWVYYlRub2pQRmhlSERnQm1nU3dGK3FWZm15d3l1aVEwUmRja01kRm02MkFM?=
 =?utf-8?B?Z0ZlZWF1MEpPUVY3cUQ3SC9BRDM0SkhsMG4rNURwZzN0dURmdTV1WXJZWG82?=
 =?utf-8?B?dk80QWoxQzdOTUZJOW81dGlBUWJQb241RVhZeDBGbDVqb0t4V0pNNEh0Sk9E?=
 =?utf-8?B?d28xUDhObWluVkEwT3kwUEVZaGNQRW0zWnZYUlBEa2xzYmYyWmhsT3FEem1j?=
 =?utf-8?B?S1dnRDh3YTQ4ampsTU5wMUVDS0VONzVxL0ZYTmRVRzZya1U5UWcrMWRwUXRm?=
 =?utf-8?B?bzI4WW5vd0J4ZG1KZFZXa1RxcWtkdDNFTW5qbjVWUDhqZXZ1TlNLV2VVUHlr?=
 =?utf-8?B?UjJMQUh0Rlp6V3Rqa1lJblhUMXFjZFUwbWhWODRIUWFsa0xHa0lNUmRyZ2tE?=
 =?utf-8?B?TFJLd3FaVldESlpQTDd4UENhUlhDb21hMWtDYW9WUnp4aUk3eWxmVllIN05q?=
 =?utf-8?B?VUJ2cFdKWFdMdFZ0c1ZKNC9rWE1yOEVMZjZZYWxlUGNFSEw3dzdqaFlxM0VT?=
 =?utf-8?B?TXE1bDcyLzZRNmlpanEzTnhSK0RQNDdQZXdwM0ExZW9Uc0xydTh3SE04dWJq?=
 =?utf-8?B?WXhNT0FndVN0TXdOYWlPQXpjWng0bGZXUXF4cG1zSkxVRmN3SUxzUFNFbWFR?=
 =?utf-8?B?TXdaN3BHQ1Y5RDI0cDh4eFdsenBNeUEyOENsbGUwWTBQMjNDNkNFSTRoTzZj?=
 =?utf-8?B?ZmFEVXVXRlBQREI0bDhBN0JnS1FjV1FaMHRmemV1ak54aVhrckJ6QUk5dmpM?=
 =?utf-8?B?Tk45UldNQmx6bk5PWEk2YTE3ell4L1pqeVppSEVaTUpweTExRTNWZFJYL3Av?=
 =?utf-8?B?djJ6ZzZoL0o4L1Rsc3duQ1pCclIydlZIbTFyWFA5ZXUzazc2MnJkcHhKdXY5?=
 =?utf-8?B?clgzanlGd3pBUTk1YnltTm1pTytaZlJXTTF1aHZrVWZtVzRLeE54b0lBcmJN?=
 =?utf-8?B?K21zd0JUL2hQdFNGdnFIZysvQkJHeFBiYkdldU4yTXBSSE5RdlJGOWZMY2VH?=
 =?utf-8?B?TFQyUjZrRUZ6ajF1L3Avek5uTjEwMk51YW8wUUxGcXkvUTRvemZ6UlRoSmRE?=
 =?utf-8?B?OENBSjIyOHlXcnVERDZHaWtjMHBPWkR0UGJpS2ZRWXJyME9NaTF4OTRnOW9n?=
 =?utf-8?B?Zno2ZWRCdkozcHAxcmo2TUplcmljRTVaRHlLKzdKUWxHZ1pmVFVBSTdJMml5?=
 =?utf-8?B?Q2d0SUNHSHo4YmVuV3lXVjNSd2V5bFBtUmx6L3R6REFhMElkTzNGZ3BVVWVH?=
 =?utf-8?B?Y1JjYnpRN2dpb3huUGNPVjRkTGtXQktUNTlQa041TVBpQUc5Ry9BRGt2enM4?=
 =?utf-8?B?YmU3TUxsMWNVczdndVpsUWFuang3dkM0emh5YU1VcVQ1TXNoUm8zbGFxdjJi?=
 =?utf-8?B?YjRjSGJrL2F4NzBoN2JodnFteG1uMjdxdWx2M2VYbFpmNVAyQ2I2bGhJM2pC?=
 =?utf-8?B?TDdCSGw1YmxqZzZHbnFpVVRzRkxCMVNlNDY2SitydHl3ZE1xVG9hUmswRFlS?=
 =?utf-8?B?eHo1SVI4ZG9qRi81aWlQTk9xVys5QmtjWWxsaEJrZWJlWUk2UFd1OEg1aXlL?=
 =?utf-8?B?Rm92WUN5VVZsTFJqWU1CQUJ5Z09FUkd6cmVZV2ZrbnJLdTMvb09uSkJmWG5B?=
 =?utf-8?B?d0hoeHBMK0VjQnVzVG14dUJ6YXZZbmUrNENxTTBRMm5HMDJxZmFud0dZMkkv?=
 =?utf-8?Q?G5ke/lS6YC7qHBRcWGELLAeCT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b806e337-68d7-4387-de85-08dba2bb0a67
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 02:54:02.2535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6fd8v7E+yXSovdvIZKTOKbv44ljQHM48V54e4NfChZrmhWzn6L2mjmAWSBtY8jp8LZGQFyUuhDCHLNAvmjrp/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7808
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/21/2023 6:33 PM, Yazen Ghannam wrote:
> On 8/21/23 3:23 PM, Limonciello, Mario wrote:
>>
>>
>> On 8/21/2023 2:16 PM, Rafael J. Wysocki wrote:
>> <snip>
>>>>>> Is there a preferred set of tools that can be updated?
>>>>>
>>>>> I think you need to talk to distro people about this.
>>>>>
>>>>>> If not, would it make sense to develop a set of common kernel tools for
>>>>>> this?
>>>>>
>>>>> Yes, it would, but please see above in the first place.
>>>>>
>>>>>> In my experience, it seems many folks use tools from their vendors or
>>>>>> custom tools.
>>>>>
>>>>> This observation matches my own experience.
>>>>
>>>> For the sake of discussion, and from a kernel developer's point of view,
>>>> should the tools be part of a separate project? Or should the tools be
>>>> part of the kernel tree like perf, etc.? Assuming that this needs to
>>>> start from scratch and not extending an existing project.
>>>
>>> It can be both in principle, but from the practical standpoint it is
>>> more likely to get all of the people to use the same set of tools if
>>> they are included into the kernel source tree.
>>
>> Yazen,
>>
>> You generally envision tools like this to only be used when there is a problem, and not something that's run critical path on every boot right?
>>
> 
> Hi Mario,
> 
> Generally, I think yes. But you summarized one issue earlier, and that
> is the case where a user doesn't explicitly fetch the information and it
> gets lost. This can be especially painful if the issue is difficult to
> reproduce or has a long time to failure. Of course, this is new and
> supplemental info, but every clue helps during debug.
> 
> Some highlights from the ACPI spec...
> 
> The PHAT is not urgent nor actionable by the OS:
> "It is not expected that the OSPM would act on the data being exposed."
> 
> The info may be useful on each boot regardless of any problems:
> "The Reset Reason Health Record defines a mechanism to describe the
> cause of the last system reset or boot. The record will be created as a
> Health Record in the PHAT table. This provides a standard way for system
> firmware to inform the operating system of the cause of the last reset.
> This includes both expected and unexpected events to support insights
> across a fleet of systems by way of collecting the reset reason records
> on each boot."
> 
> Note that it says "last reset", so it doesn't seem intended to keep a
> running log to be fetched later.
> 
>> If so, how about doing it in a high level language with easily importable libraries like Python?
>>
> 
> This sounds good to me. Anything that can handle binary files.
> 
>> Then the tools can still be stored "in kernel tree" and distributed with distro "kernel tools" packages but you can more easily use them on random old kernels too since the binary via /sys/firmware/acpi/tables should be widely available.
> 
> Yes, I agree. And I think we should give examples for running the tools
> as services at boot. And documentation is needed, of course.
> 
> I don't exactly follow your last statement. Do you mean that new ACPI
> tables will be exposed in sysfs even without explicit kernel updates?

Yeah that's what I was meaning.  For example look at other tables the 
kernel doesn't parse like SLIC or MSDM.  These don't have any changes to 
show up there.
