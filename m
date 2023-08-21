Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6FA782F87
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 19:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236627AbjHURfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 13:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236672AbjHURfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 13:35:31 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78ECF11D;
        Mon, 21 Aug 2023 10:35:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JkyHGqgLF2MlqJ2uFpTPFSPVqZXLY0DtIHsUQjjwGcOYll1ZnBmPZ2VePoqoTy/j8W2mTk5ugqMdrw+LUbuB31V/MLh/MBcFd70+zIyteTVmrJxjYgzyWok+Rx+N26sZX4ZgLIBgvek39eCNZO92yGhGsXbnOdQSZzc2OLBkpll2dmxwRopiyhYay6xUcR8ak89DGoK9ZVJiyNnnp/4oSkGYSumWF7EUPALbiWgb40VZ5khfemnNv5lGnvlXJXZYu811XF+iPVSr0oIcjEMKRZepmj+BSVZZ/+6aY8qiSP6NBOX/WRHxTWWFO0I12GPQMtRQ7iAjMu+Cis5HqAxSBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xhPu8azxM9d4psctgR9+ZdOYLYB6nbfxfsA9Ad5V+s4=;
 b=j1G1hfQYgZFYFHUflgAlfN6IHEvFTXSsZn8WlooJ8SVqvmrERkZ0JSFGO87eheRpvnJYFizyKomOH+puaSP7+E5B7DJbdu8Yo5wjVW8Ua3xfoE84SiQ8iC6w3c3RiewJhgQDUcKIJm+rLhWudI08Ie6g6PTdjwOHhUQ4asYdsj57BITa42u/odhfVEc1cugCmEfCwhp8BexCmCp+3ipzc6RIM5bXa88FcS/NPLpmCy6T8yHXhPrSDNUkdrnnaXhzfxP/hQUNew7MTwo65kv04Vv7IW7OE5aykZlqoG4ftvA+RD4RzuqPdSc2NVfnWj60jbVNpa2FJCEn9jEHRUB9DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xhPu8azxM9d4psctgR9+ZdOYLYB6nbfxfsA9Ad5V+s4=;
 b=sFKnZywLOLHjXbU3IMCpRMECxQ5XBo7cL3Oz44TTlx6nUWyypuRMnyTmmCcfsbOY/3FdNWRn5R6alGQXjj7yeBMqksMiZ4qcG8xSTjsHY83Ib3u38m6SDBbkD3/BOEmc7PM5lGrUfd4RFQTn3F/DOP+ce2TbnGrb1DDaJy0t9v8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SN7PR12MB6837.namprd12.prod.outlook.com (2603:10b6:806:267::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Mon, 21 Aug
 2023 17:35:26 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 17:35:24 +0000
Message-ID: <43b65307-bc3f-4014-9bf8-a96c6ed15d9b@amd.com>
Date:   Mon, 21 Aug 2023 12:35:20 -0500
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
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <CAJZ5v0jEcD_1+jHfAk9eN0YYJFbDZN2rZ97KHyH2-w6EqRN9+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR07CA0048.namprd07.prod.outlook.com
 (2603:10b6:5:74::25) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SN7PR12MB6837:EE_
X-MS-Office365-Filtering-Correlation-Id: 80c25ce5-46e7-47ec-f530-08dba26d0019
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: twuq3PaKLXnL2EbVhwNPuoizbj/Nv68jZRPiP+BGMLtWKj8UOSxYs4jzpJb0d/QwbotFj5Ku0SijOvPPrsjGM9CCnkvgN78H7pfQnJlx6SPsjpxvJoC68veXiNZXemmbhcPMeYmJqaUNAZKbPzmq8d7mvzVYItkMehgXRsoWxfPHQ6s/cd60BCSLj6Jy6yYe9z+9YuMQIA9dRejxMYpOOl9LqwDgL5NTuUWsbBg1TC3wVecFP6eM+E0B40YkWcYjEKqnZeAktSNP9EX3IJGutdDFc1fMFM4dOIvJlxKn+vdrUiJWZOwoo2w2oRYvXMmemjvAAH5NyleLJw5OwtKbwMgcRKtnfAj8f3cgyEVpJrbfOCRS0J8tFF/iPoYM/mbHwOMwgdLB1BSjiBuCFA6lOL75EnykXYIET8OV0vw0iM4J4BFr3/+54qYKbnf2iHIihEvySpT3B13sibT0do5i1DW+vdOW6YEGlqcE4GI7t7nsWeDKfM+VMj/9ajVbhbGNT6hlfIWI+UDyUrTHoMEqp3Of1+pS8UqqtTF3fO4Tz1v2MlFdMpJ/aG5Dox+4G5yAusxfEjDtNUtLshdtXWavk390nrtDg06uNBtJU2sHNPD+m6RxDpop8p5+y3a8lZkxGVkpLtQfiUmYQ+o7sD/dBg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(136003)(376002)(396003)(1800799009)(451199024)(186009)(2906002)(83380400001)(6486002)(53546011)(38100700002)(6506007)(5660300002)(26005)(31696002)(86362001)(31686004)(8676002)(8936002)(2616005)(4326008)(316002)(6512007)(66476007)(6916009)(54906003)(66946007)(66556008)(478600001)(6666004)(36756003)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlJwanp2Y2JMZlJJNFlFZTNpSFBjc2N4NW9odFNpMGVNNjVBUzh1dzVBQ0lQ?=
 =?utf-8?B?YWhxYXhvY3c0V0wwVzNHbnNFSS95Q0lrc04vamhyU2tJOUxoWG1ZeW90NTM2?=
 =?utf-8?B?MjI2SnZLSTNKY1pyQmpNaksxSEs1ZGxmNzN4S1VQZzQvZXVBYW1vMkV4OHAz?=
 =?utf-8?B?Zk01OGxaZG54dGtRKzNxU0FKQWxITzVXb1ppWkVCdVozakNVdEhqSisrRGxu?=
 =?utf-8?B?T3p1Qk1JM1NKR3NhZHlvS093TndsbjBEN0lxYm85UUdFbEJjbC9oZHJJYlFl?=
 =?utf-8?B?VC9PV3JOVktLSENzUWxnSEdmc2hjNzVPSEdGdnNwVnhnbE52aTVTdUIxcTd1?=
 =?utf-8?B?Sk9JMDZSVTUzV3NkcTBQZ1JYdThTeDhnbTUxTVZYUXZjUzdTWUZrUE1ldG5q?=
 =?utf-8?B?dlhqWUVFRUVxY2N6b0pJOHhFWEVoSDgrMkp5Z2VjanBFUnkwRXZ1dU5EcGxZ?=
 =?utf-8?B?TUxqaU9jVG5vaDlLYXEvWVRVL2xuRTZYTWpZMkthelJZaTdEbnp6YlhWZ254?=
 =?utf-8?B?R2pMM0V5eU5ML1dwVFIwbUVsbDBOVG9wdE5HekhtRVZ6L2pPRWNwZWEwaE9h?=
 =?utf-8?B?MXl0dzBRTnN6MUFjYjl3TUJaMmJHTDFGcnZQeWp1ZlRuSks1YURXaEUvdXh4?=
 =?utf-8?B?RmxXUWZ6L1ZsdUkySWkvSEdrL3lUbmVKRXYyLzBjeHNXZWh4UEZVU1dZSld2?=
 =?utf-8?B?bmJ0ZWF2RnN2UlNLODJFd3IwNm1YNWI5QjlxMEhXSGhodnEySVpDREpsVWxF?=
 =?utf-8?B?Q0RCc1RQcERCOE9RM1Z5elQyWk94ZUJBMWhTaDhza3ZQRERWNGpnb1h6L0g0?=
 =?utf-8?B?R0I2WElOWS81aWhMd0lOcHdqZnpkUCtpbVdyUTFPQ0pwOWErWUtiTzB2aTFH?=
 =?utf-8?B?WGE3RXlXWkRyVC9YV09TRE55ZG5KaWlncnJlaXpLdUxORTc4dXN5M3haY1hm?=
 =?utf-8?B?Tk9LU0NmQzJDb2VEQ0l5OXUxNWFNaHB5TlFtZ1lxSFNCZ0RXcjlrL2c4emU2?=
 =?utf-8?B?ODdHeXpoc0o4emlBbjVDRGZLWHpTTlk5TmlNWEo4TjNxdUY2MldTQm4wUEpv?=
 =?utf-8?B?d3FqemE3MzBUTFFpalZrVVcvdms0YnkxcTVDY3BjL0FyVWpZZXc5M2xya003?=
 =?utf-8?B?VnI1NGJDYWE3eTBGY3gvbVJ6NXJrS3FDZ2cxM2Y1OFpxMzdGN2FXM2xIYUxv?=
 =?utf-8?B?NWFYWTNUdkxKMk5GZ1JCTXRKVnAwa0Fwcm1JdDlDcW9OM1pmS05kQ3diWU5q?=
 =?utf-8?B?NmJ3azBPL2V6ckFmbjJubVBEWENlS1lYWDg5WXEwZzF5RXIxd0VNdGFWeDdr?=
 =?utf-8?B?SlRJWjllRldhSkJscFY1U0VaclRnYlN5WTNkSG00TFBQTHVjbWQ2RVc5K0tj?=
 =?utf-8?B?WExteDRGVHJFcDdkSzUvZHlhenFkYW9xSlQ1bE5PZm4vUkJSY1dyL0w0NlQ0?=
 =?utf-8?B?ZDhIYlRCTEZaM2dScktIUnRKMDZ4VHVJT0lKMXhsWjNQaVdQb0RiQkh0b01l?=
 =?utf-8?B?UFBJMnEzL0hRVG83ZTFWcjhpUjl0eWtSTGFSV2ZBREZweGpQRlBUOFZyTFdR?=
 =?utf-8?B?c2hzaTIxZ0gzYVZrSTRIRkxaemdyWjZLS1ArelBWUE52UnpHQ2ZPNnJjQUNS?=
 =?utf-8?B?cXI1a2NYUzQ1S2dkN3N5TmNDVFducDJrcXhhTmF0ampzVmZVcGd3WmNGeG0y?=
 =?utf-8?B?RXpWRE0xbGRKSDBIZTZ6MU5EUlY3Z3VqUGxTSmRGTGxLcHdBaGNPVWplWVRQ?=
 =?utf-8?B?b2RjSGh6Mmw2ZmQyV01JRlRMZExEWkt2ZUFyVlZPengxc1Nmb2tWN0ltZk5C?=
 =?utf-8?B?bjdPRzNoQW5KdEs5dkJZZ3ZpajRRSnZrSmZpai9ISmVId0NTZXVvRGhuSm9r?=
 =?utf-8?B?NTQyQm1FQlVwRldPZEtqT2gvQUpZT0ptMEVMdFFOcXl4TkFTUEkycFVXcmVI?=
 =?utf-8?B?bzJHL0ZMNkd4RCtCUUt1cDZWeXVyckh5L3hVZHdZS1JFTXlvK1o4M1ltL0ty?=
 =?utf-8?B?SjFTMHk4U2ZWSEJudloya1I5eDJBTEdkV1U0cnFKNTUwdE1sVmh2VHMxR2I1?=
 =?utf-8?B?aEdsSVhuRExqU2hDcWF6VUhHZ3NobW5Rd2FUdjBUTnl4RFFXSVB4L3RiNUVO?=
 =?utf-8?Q?3RxD0AJEZ0iWbJ4v1Zgji27Pq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80c25ce5-46e7-47ec-f530-08dba26d0019
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 17:35:24.1677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ylE0d9HK8MeDA0hX9XrxqQvOhldr9pOtqaMQnh0ssKLdqMhdNwKBgbxUPSGnRafBnaPLEyZu0/gNlha9FmjVKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6837
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/21/2023 12:29 PM, Rafael J. Wysocki wrote:
> On Mon, Aug 21, 2023 at 7:17 PM Limonciello, Mario
> <mario.limonciello@amd.com> wrote:
>>
>> On 8/21/2023 12:12 PM, Rafael J. Wysocki wrote:
>> <snip>
>>>> I was just talking to some colleagues about PHAT recently as well.
>>>>
>>>> The use case that jumps out is "system randomly rebooted while I was
>>>> doing XYZ".  You don't know what happened, but you keep using your
>>>> system.  Then it happens again.
>>>>
>>>> If the reason for the random reboot is captured to dmesg you can cross
>>>> reference your journal from the next boot after any random reboot and
>>>> get the reason for it.  If a user reports this to a Gitlab issue tracker
>>>> or Bugzilla it can be helpful in establishing a pattern.
>>>>
>>>>>> The below location may be appropriate in that case:
>>>>>> /sys/firmware/acpi/
>>>>>
>>>>> Yes, it may. >
>>>>>> We already have FPDT and BGRT being exported from there.
>>>>>
>>>>> In fact, all of the ACPI tables can be retrieved verbatim from
>>>>> /sys/firmware/acpi/tables/ already, so why exactly do you want the
>>>>> kernel to parse PHAT in particular?
>>>>>
>>>>
>>>> It's not to say that /sys/firmware/acpi/PHAT isn't useful, but having
>>>> something internal to the kernel "automatically" parsing it and saving
>>>> information to a place like the kernel log that is already captured by
>>>> existing userspace tools I think is "more" useful.
>>>
>>> What existing user space tools do you mean?  Is there anything already
>>> making use of the kernel's PHAT output?
>>>
>>
>> I was meaning things like systemd already capture the kernel long
>> ringbuffer.  If you save stuff like this into the kernel log, it's going
>> to be indexed and easier to grep for boots that had it.
>>
>>> And why can't user space simply parse PHAT by itself?
>>>   > There are multiple ACPI tables that could be dumped into the kernel
>>> log, but they aren't.  Guess why.
>>
>> Right; there's not reason it can't be done by userspace directly.
>>
>> Another way to approach this problem could be to modify tools that
>> excavate records from a reboot to also get PHAT.  For example
>> systemd-pstore will get any kernel panics from the previous boot from
>> the EFI pstore and put them into /var/lib/systemd/pstore.
>>
>> No reason that couldn't be done automatically for PHAT too.
> 
> I'm not sure about the connection between the PHAT dump in the kernel
> log and pstore.
> 
> The PHAT dump would be from the time before the failure, so it is
> unclear to me how useful it can be for diagnosing it.  However, after
> a reboot one should be able to retrieve PHAT data from the table
> directly and that may include some information regarding the failure.

Right so the thought is that at bootup you get the last entry from PHAT
and save that into the log.

Let's say you have 3 boots:
X - Triggered a random reboot
Y - Cleanly shut down
Z - Boot after a clean shut down

So on boot Y you would have in your logs the reason that boot X rebooted.
On boot Z you would see something about how boot Y's reason.

> 
> With pstore, the assumption is that there will be some information
> relevant for diagnosing the failure in the kernel buffer, but I'm not
> sure how the PHAT dump from before the failure can help here?

Alone it's not useful.
I had figured if you can put it together with other data it's useful. 
For example if you had some thermal data in the logs showing which 
component overheated or if you looked at pstore and found a NULL pointer 
dereference.
