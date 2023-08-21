Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 908DE782FD2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 20:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237052AbjHUSAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 14:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233032AbjHUSAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 14:00:36 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654BD10D;
        Mon, 21 Aug 2023 11:00:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jbr4aghhdi9pkQOXtkh9a2/1VRL9T98+EV2GhGuQHWKfy4+7iMa/1B5R8JzBE0qX9zfhmp4tcyFMrzG2kCgvW/hsOf5SWDiARPj+36w5Nr6GHgcFgFLCW9PWdQmEibBw6ZjzALLazhRhgeVfdTZmEghqaqjNUTgs49Klb1ISvyUoIGJcgB2H8gSqlS0GU0xB9vL+zvdU9UlT/NgAk099xFMES7PRN4sU4RW8DaOvJhsuNVlJtHC1U42Zkdd8XJto6vOigoW109VoqE2oPFjEAq/A1oMI/l1EzwiKq8UMm88CSVbLxjQOOQ9ZUNZj+ZHQXwE/XFrzTOPkGne1Qhy5Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wU62UHzXU3f5Sy7h9QBX+gB6jPx5sZhT0ERqo9yKtvc=;
 b=jPZeRdQzHDq+BJLQG1G46dJm6vsdCHBdCU97l1pe70zaW1eligVwVCVC+zi0ICP0nwbYV23MDQyrEWxvtiG3T5rhYOp3v6HcaMeMjJ1A44gflCc/6Sd0rnrhL5cKbMgFSTKpP7m6Z79LZDTSYkObAspo/VbwCp8SIm3OQOA1AFtPRXugOMc7V+e1zLLlxa3fhFTzx6OSCLcCjhtqKoNm8KwSEgwE2bqiYXBV8DO6twhrRBtGwb+VhrxribidOboehOZACbHI91P+JJqSBwIi4NAGewI7xTxXlocfH+mOlS6ZhxovSxbOMrzRZdZmfLJ2HtbDBVl1NAwMAqZz7l4pNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wU62UHzXU3f5Sy7h9QBX+gB6jPx5sZhT0ERqo9yKtvc=;
 b=EaTmeniB3oZl0R/VF36DecKgWqgAnP7SCioZ5vlRRAm2Zp4tqh9g5FdbIYPdiFMAB3Z//l/Z5fGP4L3q6J+Io5WFaZ7Ntha626oWw8J5SjzMXrN0VJJDf3CZ1F628Z/gIS+UF25xWZntn89rXqJdnrAa2497a+Lw+ewgkFjRnmQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ1PR12MB6194.namprd12.prod.outlook.com (2603:10b6:a03:458::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Mon, 21 Aug
 2023 18:00:25 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 18:00:25 +0000
Message-ID: <3b2ff277-c310-4fa7-96e3-e2962477663d@amd.com>
Date:   Mon, 21 Aug 2023 13:00:22 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: PHAT: Add Platform Health Assessment Table support
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Avadhut Naik <avadnaik@amd.com>,
        "Wilczynski, Michal" <michal.wilczynski@intel.com>,
        Avadhut Naik <avadhut.naik@amd.com>, lenb@kernel.org,
        linux-acpi@vger.kernel.org, yazen.ghannam@amd.com,
        linux-kernel@vger.kernel.org
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
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <CAJZ5v0g+uVZwoOr-2W19Ux9u-D=WiY=-dtcQZwYU0Ov_GE5d=w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR06CA0004.namprd06.prod.outlook.com
 (2603:10b6:8:2a::19) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ1PR12MB6194:EE_
X-MS-Office365-Filtering-Correlation-Id: a4acd229-76ec-49f1-d5f9-08dba2707eeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N6++Tiw+d496/d4LXc30N8JTf9/N9II0dCm+TEYVli1JsBUbubY6/Z3aDJ3RkNUgPX2WgMZ5msz8oDybJDr8+gGDuGbmIkrzc8HIy1eNOfmg3RPVzbC/86ilVfQ7rjqEG9XXqvTrWAmtgeIDdQ7jKc4Tww7k1ZhlR8zUWP+fo3uw9JPrGcRnaNuTAQLvMZLZ0npdWGSJ7+TJRQe0eGny001gLZ9liB1MFnDhtwJJfegTQtWfoVVg0TwyVUHm9Rd0KZKMl3fvtfzbSWZd4UpPFokxuuZvuWcXjvYf/G/n2I4O92tfn6wu6Pn/dhpLDKP7QtuAhTtR6Cq8/qqJ84Bu516DuZIgyS9IADcWnZ60A0SpoXcd0bqXXjNSsPgVz1DydduXf3PGRHWmeVOOFaMBTdZmmnALSoiorEfV2mkx/jt0OebMtYeaIcLAXhIs3PQdw8pEJK9Ymzjs4ZQd+9YZ3qNN7mW2LbWrEriU05gHvsnFb8wVgXf/HyvyP517H99PBc3F0vPepfcWFb6oGz+2DVFjHsn7bSCsHJyOmDPh86bmQM0AjPeR8z05tSWXd6g98dD9YmQHhUZKgFdv8OJkJI7ibY0p4kDjXjgtMkyhibeGVOGcAjwilhpe+tdeGULFe9P3ZcLPZm7bxZ+TkzG6BA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(396003)(136003)(346002)(451199024)(1800799009)(186009)(86362001)(5660300002)(2616005)(41300700001)(66556008)(66476007)(316002)(2906002)(66946007)(6916009)(54906003)(31686004)(8676002)(478600001)(4326008)(8936002)(31696002)(6666004)(6486002)(53546011)(6506007)(38100700002)(6512007)(26005)(36756003)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVZ5UXZKYVJlNTlSUHZhK0dnSk9TZ0dqUzVqZjdhTDJNOWIyNE5LL2dTVTFu?=
 =?utf-8?B?QWlXWVozTkVKWW1yZGFERTdGRW9SZ29zZHhTZWY1eTdCblZKUGhERlNOMDBp?=
 =?utf-8?B?NW5WR1RGS21GQUMzWXZINWg4U0lsdW5WYjBKeHdMQWZYS1VMRmNTWmlBSUJr?=
 =?utf-8?B?ZWVJY0xPRGVKQnBXNmFyU0lIMzV4VDlXVEJZRjZock1wVmFkZkFkc0FERG5i?=
 =?utf-8?B?dnNVV1k2R2xkYlZEMDRZTWdlUnZkQzZ1SHB1SXEveFM2a1hFZ0o4TzNWMHVN?=
 =?utf-8?B?ZCtyUFhqTnFGMGdCSW5wT3lQSlEwQThQUFBxUVpmaUVlU0I0RkxkZ0dDeHI3?=
 =?utf-8?B?QndNTTlqRHVqMGVuK2hEbEtSTHNET2hqS2FuL0tGVmxBbWJhK3VJZ3hOZ3g3?=
 =?utf-8?B?SGNvVHdtTTdTckdwaUJYN01DelpMT0tHeSs4ZE1JV2hzSGlFdHY2VnVNNmxy?=
 =?utf-8?B?TnJ0ZTBnbjIzblBTMWRITzlzK0cwYnVaaTFObVl3QVF4bVJrRjRZdHBORFVC?=
 =?utf-8?B?UGpob1FpWmZoNHZKNmlDWlZIRnZZWThpMWVxQlRpaUptUkF0WmpYUEN1RFdm?=
 =?utf-8?B?aFFTd09XeXJseGZldXhaKzlOTHBxQmw1cUhxSXdwZlgzcHRtaUNHMWFQNXJF?=
 =?utf-8?B?RDk4NFk2ckRaUTdSMU1ocmZFaUdvRmJYS3JmMzRvY2I4b3Ayc0pwaVo5MlNs?=
 =?utf-8?B?Q0dGOG4xcU84VFJpbmRyeElKTHRMSStFU09vdGhBZWZxVmRDVUxqNC9oZ1B3?=
 =?utf-8?B?UnRTRitYeWp1ejJtRmZWZjVMMXpaM21DbEM0QnI3YUN4QUtIUVNDdEF4QmVQ?=
 =?utf-8?B?SGNpaGJ0bGlVbEx6YlMvZnB4d1dGNHRrbFRlbitEUVRIM0g4TUZQcTNVVFpG?=
 =?utf-8?B?V1JYSmZidXBOdlRJamQraTVCNjc0REc5T3BJcWVmUHFHYXhLLzg4cUpKQmhK?=
 =?utf-8?B?R2hJU0tUL2RCZi9meFBCbmExMlNZSGF5SDNUVEd6V0R6b2hScmFtQStQZ3JL?=
 =?utf-8?B?WC9BK083d0IrR2M5ZVFmRjdLYlZoOTl1MFIxc3dOS3VseVo4MUdmN21yUUdL?=
 =?utf-8?B?ZktYVU9MUy9nUUFUZnNBclJ4dkhhRGV0Sy9TWE1pdXFjdjljUWtVejJOQnVm?=
 =?utf-8?B?b0k2aUlEQkJveTRZbTA1UEdVWlk4UjRCYWkybWduRll5eHB2RUhqc3lUZmxl?=
 =?utf-8?B?cEpuVFdWL2NtazV4VERRS09adkxPUGRlb1FiMkFicGFUYkFMKzV0UWNYbUg0?=
 =?utf-8?B?ck5CSHVSYWdJUHA4WTRSVGI3c0hZQlg4NGNkZmJITkVReUlLMm01K0tubG82?=
 =?utf-8?B?U1JkYkVxTEJIS3ZERVNSMllIbTNoV3pYaysxSE5LVXEzaTdMaTBLd09qQkJU?=
 =?utf-8?B?am9aaVowcVRMOEc0Q3RybFkyTk0rejhSdmJwMVF4WVZ4bEJUTElHdXdySGV5?=
 =?utf-8?B?cmlPUUExdjgwa2laek5mRzRwYVRxU1E1cDUvZDA1VXNBUHpUaFFWZUZBVzA3?=
 =?utf-8?B?L012UDBrbndJMWtJWm9YVThmaXRta2xQbHFmaDBMSUJRQysvNi90Y0J0dm8x?=
 =?utf-8?B?N3lqZXdMVlVsSFlVbnZ6YWNOV0ZSK3dmbFhpWGhWekRVNkduM3BFTUxjak8x?=
 =?utf-8?B?eTNjZHVQNzRYV05qQmxNNHNKMzVueFkyeTZFT1djUWEwYTRTR3FwTkIvQTly?=
 =?utf-8?B?MGRrSE5mUUI4TDIvTEZBdndqMlpJTGcwc2pXdmlUUlRHU3NVN2trT2s3N3Fh?=
 =?utf-8?B?MzdHYitvbWdGWkxqMVdQVUVycFFQbndhdEdDN2puV1paR1ZjZHQ2SktNYy9X?=
 =?utf-8?B?ZnBxU2MwZzRzcTNqRmVYaWFOdWp1Mm56WDRaOE1nR0dpbzkwYmN5Y0wzR21K?=
 =?utf-8?B?VWdEanA5KzdHeVBTSmhBVTRlNFBDMjlOZ0JwZ0JJTFlYanVnaERDZjg1WGpn?=
 =?utf-8?B?azh0Mjc4TU9CVzY1YURvZ1ZVby9wOFo0NTljeVpIZG9TSnMwazZ3Uko0ZlJZ?=
 =?utf-8?B?TnlwR2pTTGdCcGtmQk53OWJrM1dUM0hlRmZtcmhKTXNRdW52ZFh0VE5qUnhW?=
 =?utf-8?B?ODdBSFdGa0NYNG90OUlBanh4aWVRWFVkeFF0MEhoRC8vYTUxWVhrT0o3cnFK?=
 =?utf-8?Q?Drnkj916tn9i4KJOcDdNK9HPL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4acd229-76ec-49f1-d5f9-08dba2707eeb
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 18:00:25.4161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dx80C98tJzf0/dVHze9ukXAugdmY/M4HcOMuTwNVQ0ljDJtSsRnhnoJrOU/WCghcRip5l3fb8BTl2WUnYqkJBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6194
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/21/2023 12:52 PM, Rafael J. Wysocki wrote:
> On Mon, Aug 21, 2023 at 7:35 PM Limonciello, Mario
> <mario.limonciello@amd.com> wrote:
>>
>>
>>
>> On 8/21/2023 12:29 PM, Rafael J. Wysocki wrote:
>>> On Mon, Aug 21, 2023 at 7:17 PM Limonciello, Mario
>>> <mario.limonciello@amd.com> wrote:
>>>>
>>>> On 8/21/2023 12:12 PM, Rafael J. Wysocki wrote:
>>>> <snip>
>>>>>> I was just talking to some colleagues about PHAT recently as well.
>>>>>>
>>>>>> The use case that jumps out is "system randomly rebooted while I was
>>>>>> doing XYZ".  You don't know what happened, but you keep using your
>>>>>> system.  Then it happens again.
>>>>>>
>>>>>> If the reason for the random reboot is captured to dmesg you can cross
>>>>>> reference your journal from the next boot after any random reboot and
>>>>>> get the reason for it.  If a user reports this to a Gitlab issue tracker
>>>>>> or Bugzilla it can be helpful in establishing a pattern.
>>>>>>
>>>>>>>> The below location may be appropriate in that case:
>>>>>>>> /sys/firmware/acpi/
>>>>>>>
>>>>>>> Yes, it may. >
>>>>>>>> We already have FPDT and BGRT being exported from there.
>>>>>>>
>>>>>>> In fact, all of the ACPI tables can be retrieved verbatim from
>>>>>>> /sys/firmware/acpi/tables/ already, so why exactly do you want the
>>>>>>> kernel to parse PHAT in particular?
>>>>>>>
>>>>>>
>>>>>> It's not to say that /sys/firmware/acpi/PHAT isn't useful, but having
>>>>>> something internal to the kernel "automatically" parsing it and saving
>>>>>> information to a place like the kernel log that is already captured by
>>>>>> existing userspace tools I think is "more" useful.
>>>>>
>>>>> What existing user space tools do you mean?  Is there anything already
>>>>> making use of the kernel's PHAT output?
>>>>>
>>>>
>>>> I was meaning things like systemd already capture the kernel long
>>>> ringbuffer.  If you save stuff like this into the kernel log, it's going
>>>> to be indexed and easier to grep for boots that had it.
>>>>
>>>>> And why can't user space simply parse PHAT by itself?
>>>>>    > There are multiple ACPI tables that could be dumped into the kernel
>>>>> log, but they aren't.  Guess why.
>>>>
>>>> Right; there's not reason it can't be done by userspace directly.
>>>>
>>>> Another way to approach this problem could be to modify tools that
>>>> excavate records from a reboot to also get PHAT.  For example
>>>> systemd-pstore will get any kernel panics from the previous boot from
>>>> the EFI pstore and put them into /var/lib/systemd/pstore.
>>>>
>>>> No reason that couldn't be done automatically for PHAT too.
>>>
>>> I'm not sure about the connection between the PHAT dump in the kernel
>>> log and pstore.
>>>
>>> The PHAT dump would be from the time before the failure, so it is
>>> unclear to me how useful it can be for diagnosing it.  However, after
>>> a reboot one should be able to retrieve PHAT data from the table
>>> directly and that may include some information regarding the failure.
>>
>> Right so the thought is that at bootup you get the last entry from PHAT
>> and save that into the log.
>>
>> Let's say you have 3 boots:
>> X - Triggered a random reboot
>> Y - Cleanly shut down
>> Z - Boot after a clean shut down
>>
>> So on boot Y you would have in your logs the reason that boot X rebooted.
> 
> Yes, and the same can be retrieved from the PHAT directly from user
> space at that time, can't it?

Yes it can.

> 
>> On boot Z you would see something about how boot Y's reason.
>>
>>>
>>> With pstore, the assumption is that there will be some information
>>> relevant for diagnosing the failure in the kernel buffer, but I'm not
>>> sure how the PHAT dump from before the failure can help here?
>>
>> Alone it's not useful.
>> I had figured if you can put it together with other data it's useful.
>> For example if you had some thermal data in the logs showing which
>> component overheated or if you looked at pstore and found a NULL pointer
>> dereference.
> 
> IIUC, the current PHAT content can be useful.  The PHAT content from
> boot X (before the failure) which is what will be there in pstore
> after the random reboot, is of limited value AFAICS.

Right, you would need to have the pstore logs from your bad boot and 
then the dmesg from your current (good) boot to get the info.  And 
you're right at that point you could just run a userspace tool that gets 
the info instead.

I don't think any of this is necessary in the kernel, I just am 
describing the use case.

FWIW on the patch series IMO I think that the boots that don't show 
useful unexpected things (power button, cold boot, warm boot, cold 
reset) shouldn't be INFO either.  I think these should default to debug, 
and just the unexpected ones should show up.\
