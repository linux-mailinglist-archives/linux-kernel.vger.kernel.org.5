Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7E5C782F48
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 19:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236165AbjHURRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 13:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234823AbjHURRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 13:17:54 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 467FDF7;
        Mon, 21 Aug 2023 10:17:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=avp+33UCqsTeRDnQbHOVdRECCS7uyZd7N2dWyD1kx71oRxQpU5MeIUOaEXlzyzuiUh7sCXjVAkfZ9fmYUf3FY2bSdocyfMBtBJPi6wFzCv21nJzGEVZqAe7vG8HOXu6YPwdScxx5+gjKu4cUuswRWlvUXBpubSn4GgZcuG5fyjrXfu5ephDywTP1pF1vnYv3wxGo75nMVOvlbpRVZrifdcJIdnvxTmjr8Ul5hDKiMyNpFxxFoKCy6RcnsOu7X7qkYZSa6veC4EElJxDSLhrhAbZ3og4et+FKzx9UaYk+QrsYD7TWwCAYlGsX+VND0dD+JdihuPc2smgnMh9sqXi3mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ObvFWugpHVKBJ/a0vAEZ7qKggkQVrCiHfDoqucFxOJU=;
 b=CRVKAI0oaLkwnH053dhKW2/c0tVNte2mlTRUOz/isM0Ld0/9AOJ4z1OGIjOPWMp1ROlL9aG8ckAtm71qaSOTaN6h4rnJTMiRtDSr1VEiEwqZv/wIrs5aM/STW1xifEcVoJlreNprzg2l7+m1NC2koCKiOifBmzbdkX7i+n8p4uxmnAn2PJV5juuHQ0XalEJ+nUnTHQkiHm8+mel33yuucFAoD+MZ0qIGoPMzCcJDJTCY8/Uo1KmA/KoQyvNR+1dVoOXlp4qf5a/+eYeXrpp9w+gthjxDNp6n+6vOxUMxV5X7hWGag87Iv4sD3GjYkEKdzmPEF5VWudqHAXImWRfIuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ObvFWugpHVKBJ/a0vAEZ7qKggkQVrCiHfDoqucFxOJU=;
 b=qlKUvhaxY4bF9f3CP0RDEdFJXUgjSb7Z8peol+VHEPpebXRtfEkdduFD4Le/Qf9pb7Kz0R/QVFvyq01dAtpVkkLhyLxrVmcKYJvR8fN0cm/t4l6F7Z3Vg2fTozwZKhg0atWXlQaBvQdUyF7ipIQRlH8RjA66xk2rL5UXL6GYeKA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SN7PR12MB7180.namprd12.prod.outlook.com (2603:10b6:806:2a8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Mon, 21 Aug
 2023 17:17:49 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 17:17:49 +0000
Message-ID: <6bc15195-aa26-4e29-b625-74fca84f7a6f@amd.com>
Date:   Mon, 21 Aug 2023 12:17:46 -0500
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
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <CAJZ5v0iPRCJLH5bkKyhjUq_tmjmR6R73fhUm3JnKptcm1cn9fQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR11CA0044.namprd11.prod.outlook.com
 (2603:10b6:5:14c::21) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SN7PR12MB7180:EE_
X-MS-Office365-Filtering-Correlation-Id: c2d5475e-2dee-4e72-b11f-08dba26a8b62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: prO2MmFwlaHO0Ql+h+XrjDgdv2CJVG6DTZrgivWM7G6aEKZ5ANVyhzYiSFBK/z4KK0bcGG/+yvzm9EG8rICBsnpZ79ujGY+rwbkAEvpiGs1Ibb4ols+CSkY7HuE0yA6MGTvypoxJd62lvAs960ndbHqkKDZu36HLSmgRBzJdXWNjcycu75sBTta4jKa/wfiZWLVI9OoTY4xk8xFcs5gQMRz/CIvyz0RCMIxvxYGOWGv21JxP0Ckl6ueyxWfOoQtZQ8akHJZskA8LpQqE9qZukEGVERp0dQwS9qlzgNl8WU//mJJaiDEX1aWIrCelUFRSxA3kggtWFVau1owmBbmUIQyPRt8RXyvwtNJfLCV8Cm3EwG5+F0i7iwPOxpj01eMGu6cs8vY9DLCDfFML9u55x8nORIGJJQhyYFKQ/YeKMAEKvxfUrqLHUVa+30DOpE1BepUW9YVuWqDzk029jmIyx1C/aO1Q1zseJwEUw87u4ME32C0xN7SBc0U4ja1fVyWrXBju4cSjDQ9O8NoupwGpgATsZABVAStSS3hRAeBAowGuE/m/KhvtiTiYQAENA5hn4y2vsMg+bWbHZtR0/x86DlJDzkUWSk4k9+Lxh6y2AAkeRn3o8mVMZ8oPdXgVxDVrg0PW0wmcDmsKl+1lEHH0XA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(346002)(39860400002)(366004)(186009)(1800799009)(451199024)(54906003)(6916009)(66476007)(66556008)(316002)(66946007)(6512007)(8676002)(8936002)(2616005)(4326008)(36756003)(41300700001)(478600001)(6666004)(38100700002)(53546011)(6506007)(6486002)(83380400001)(2906002)(86362001)(31686004)(31696002)(5660300002)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3lYMkJ6QjgwemhzczNjTURqSXNDZllvVjZEVklpMWs4TTljajJmZEprVnQ3?=
 =?utf-8?B?TlF4SUkwbmNza29wRFA5WjZ3Z0pmS2luZzZQSGNUSm8vKzJ0Zm9uR0tiUnhY?=
 =?utf-8?B?d0RPM1FwY2VDclVMTzJTbmZ2M3JwNjR4S1c2QzVzVGhZVVhadmR1dW1XTWNk?=
 =?utf-8?B?VUtYL0JIYWxVS2thcFhROGplZXZYbkhVQTQ4a2VUc0hpQ3N6TldNdEw2bXNm?=
 =?utf-8?B?djhyMEoxdGIxd0RjZUR5ODR1eHhKOXZ6UlNwZVdLSWZIYkJZMDR2Rm5mQzkz?=
 =?utf-8?B?VVNkV1JWd3Y5cjZSRmc2ZmRsdE5ObUI0b09TY2grS0xJdVZ4MVV4dC8zSmdj?=
 =?utf-8?B?TS9JNkNFZWdwM0xUYzh4NlNVUjBhM1liT1dQbUFBWGlPVkhvVHIxd1pXNVF2?=
 =?utf-8?B?Z3B0OXhvRzJTOEhNRUJkNlo1UE41TjU2UXRaWCtMcm5Call2TjI5L2pCTGRi?=
 =?utf-8?B?cE1jaVgvRkkrKzZFNlFLUzNtd2E5STdxcm8zRGJFai9qOHJtUGZJUTlIVDZR?=
 =?utf-8?B?WE9UUWJjb05yQjU3TVdoY0oydjl2RlN1ME91N1NRY2c3emhpZllUdkVNVGJp?=
 =?utf-8?B?ZzkyWEhGNzYxdUFRWXpCdk1kemhLK1BtUFprVGMwUnRXMHpPNFpvSSt0VjI1?=
 =?utf-8?B?NkxhVkpnYzdTazN4ZHFlVWZvVmNvYjloMmlhNkUvL2RDZ3plNVB5T3o1cDM1?=
 =?utf-8?B?UkVPV0FwWWVFVHhzL2J5V1FlVkRhelRJcEczYjFrQVMrSkdwRkFIR09CemdD?=
 =?utf-8?B?YWFQRmkrSkx3RFBEaDIyUnNFdlVlRnpJelNtenJ6ZGN1cDFETGprNWF4aTA1?=
 =?utf-8?B?ZW9zY1pzZ1dTUXhNbFJlNXRkUk4vemRZdk01UkMxZ3h5eEI1emhlbTFORis4?=
 =?utf-8?B?NFNQVjNVK0o1WVAxY1JQYmJ2LzU0UGlKTkxTc1Z1cEZGeDNCYS84c0ltQ3hS?=
 =?utf-8?B?MkpqYXd0RE0wRG5sV2tHeGpwUUpSL2Y4eGlOUCtVVWpNWm9MMnl5NERQQy9I?=
 =?utf-8?B?bEhSWWo1L3Z0NHZYNFFOVzVpRjZCM1ZWTWprbkR2NDgzVDBvWlZXK3NEMXpY?=
 =?utf-8?B?ZWk1cldQZ0lhaDNtRjJpaWxPSy96QkpqZVRUOGlIMVlJR3VFUTJmM2s0RTFH?=
 =?utf-8?B?Szh3OEExdmdaeHI2cGt3M1FUVGgxTG9YTDFzenB5YXBvVnRSS1YwRzVlalhO?=
 =?utf-8?B?YUhuVFk4L0dTVS8xMXVVdFBRNXhpVkNydEhadXpzVW1KZWJsMmM2dFgwTGwz?=
 =?utf-8?B?N21WQyt0SURJWjNSbWFQU1ZIMzh0R0h4NU0rTkQwRUFyVkxKNUF1RTgrb0g1?=
 =?utf-8?B?Y3J0Y01Wd1QxZmxRZGpKQWs2OU9iNzI4OHVYbGJkYVp2aGhsSE93Ukg4U25D?=
 =?utf-8?B?RWRvcTFIdWs2cUc3dEdCeVNmMktFOXNBNXJ4cXY0TnU1dm1vVTFsUWdTOGdI?=
 =?utf-8?B?dUF4OE5XbHFYeDAvUTkvSmJlemkxakh3K3VwRm1HcXpYMVdMUjljeFdPMnFa?=
 =?utf-8?B?U0JpVmZlRWwrK1BpZVpMN2NJQjY0QjNHMzJFVGVmbVpPTTRoeXYwWmdRVjlT?=
 =?utf-8?B?MlhPOHdPM29LMFVnd2hWVXRsUFVXR0pIRmJpRTIwNzNMcU1sdnF1SklQWUhu?=
 =?utf-8?B?OEdnOXhQbUR0L2trUHRCR1diL1ZUeHE0NWlZWjBhWWhhR3Y2d1VxemE2TTk0?=
 =?utf-8?B?Tnk5czRXeEFPb2dDZjdNZTB1WDRCbWUxa3FYOFVzazNlZm1YRmZORURReFVr?=
 =?utf-8?B?KzhDVTIycHV3bmtzYUg2eCtQR01Wbk44OTFsVkFsMFZPbG9NdFhNU0s4eE9I?=
 =?utf-8?B?alF2c1RDQVRibkZ1eWxuQkViRFpmRkVLTWFKaUdKMjdIN0pVQnhGenFadlFq?=
 =?utf-8?B?d3RjNlZZQzIzT1FEMGJYbjVSeFVtYkpqZkFQYnJNT2QxVUhoMnJIckE2bUJ1?=
 =?utf-8?B?WS9YRXNkNEZ4TmVGR2U1NURyMERKWERMdjVyLzY5eXpiRGFHK3lmQ3VqbXdi?=
 =?utf-8?B?dEFTbVFSbWxXTlg0V2trR0tQV0JaMm9HVzNOOTFEM2hkOHVQWktneHN4aEhj?=
 =?utf-8?B?MG9wVzVzV2U0d1o3elRPZmwxdStueHNiczNaVGJGdi9haVhjd2VwVjVpSDhw?=
 =?utf-8?Q?uM0OFRRiC32X00XtmSt51FjGl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2d5475e-2dee-4e72-b11f-08dba26a8b62
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 17:17:49.3321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SLifyCILDQ4FXKHVNXhOiTdTgzatvcPxcpthzO4wjfqH1KmtnoPEI4jLnpcREzzssPAK9kEuDl4yBnIv+pXCpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7180
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/21/2023 12:12 PM, Rafael J. Wysocki wrote:
<snip>
>> I was just talking to some colleagues about PHAT recently as well.
>>
>> The use case that jumps out is "system randomly rebooted while I was
>> doing XYZ".  You don't know what happened, but you keep using your
>> system.  Then it happens again.
>>
>> If the reason for the random reboot is captured to dmesg you can cross
>> reference your journal from the next boot after any random reboot and
>> get the reason for it.  If a user reports this to a Gitlab issue tracker
>> or Bugzilla it can be helpful in establishing a pattern.
>>
>>>> The below location may be appropriate in that case:
>>>> /sys/firmware/acpi/
>>>
>>> Yes, it may. >
>>>> We already have FPDT and BGRT being exported from there.
>>>
>>> In fact, all of the ACPI tables can be retrieved verbatim from
>>> /sys/firmware/acpi/tables/ already, so why exactly do you want the
>>> kernel to parse PHAT in particular?
>>>
>>
>> It's not to say that /sys/firmware/acpi/PHAT isn't useful, but having
>> something internal to the kernel "automatically" parsing it and saving
>> information to a place like the kernel log that is already captured by
>> existing userspace tools I think is "more" useful.
> 
> What existing user space tools do you mean?  Is there anything already
> making use of the kernel's PHAT output?
> 

I was meaning things like systemd already capture the kernel long 
ringbuffer.  If you save stuff like this into the kernel log, it's going 
to be indexed and easier to grep for boots that had it.

> And why can't user space simply parse PHAT by itself?
>  > There are multiple ACPI tables that could be dumped into the kernel
> log, but they aren't.  Guess why.

Right; there's not reason it can't be done by userspace directly.

Another way to approach this problem could be to modify tools that 
excavate records from a reboot to also get PHAT.  For example 
systemd-pstore will get any kernel panics from the previous boot from 
the EFI pstore and put them into /var/lib/systemd/pstore.

No reason that couldn't be done automatically for PHAT too.

