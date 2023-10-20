Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5557D073E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 06:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376270AbjJTDnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 23:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233448AbjJTDnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 23:43:43 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2086.outbound.protection.outlook.com [40.107.102.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F1E5D51
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 20:43:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EvrZbAkzXSlxRKR00KcgVo6yiRrZlZeMnnloqCLvexMB/zUaDA5GHajghKmyKFMjv1aKZbK+CBtl2qiFvucyrghrZ4rxgd9n1pw/ux5tiWJUcGjKRkGhq0EEPhD3PJ+keAiEmXu0Q8EQ8MtBYRnErDU0M5AQU7TlEZiQnsTLaITJtL++lDcjuR1ReIDeL82kbIH/OJafwsFknR18uAhOh6vR2kI8tH5ZzUDoDwhSkGVgt7zLRnY5UicTP4k9ezejM9lBtyA1+QGwZbioQHH5NIvHB6qcH4Xf01nXv/3gzQDq5m1v0dt7KC8fuw0Mq0e40rWegyS/CETFJuCPpetYew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wj8em7/RtK6BV30rYKgSQhDlIJmnWjixghtDflJ3Vxk=;
 b=hy8ixd7xINUQ4zEvfXhN+9eHzHvaPmqrtyyY5xBlLU38PH+thRAFJfPRaPzyXEh7yOJ8SfjVvCLq8WOoG3QYu1JCr9ToL0MinS+Z2XkCD0MPsdetmr48Zc5zMgVZK5XpFsH0RjX0XkoRZBOK1U5WhTYM8ZsnWhCf+tX8bvJiONYBJaJlanqkTtkLz/p2h/HnzevxIM+cJYOWjOGeKLXnzqxL8PD6maW7DAfUPnmWyH5QhMSVsnmz1FPctiMbRvQw806om2cOomGvuDNVQgQoVrjG1O0lFJLIMGaWO/GQy9Y/UvU4g1pd8gKeIdUTE6B6aEE/70k1I68yBeYqqcHHpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wj8em7/RtK6BV30rYKgSQhDlIJmnWjixghtDflJ3Vxk=;
 b=xx4LX+fIGld4RpgwlIYbU1fwnxao6DKTKmFmHZlVLxOQKlvSsJOUOQcJoDb/ocP0wXYUYDRuSCXGu4XEGLP5FP9bzO8TQ3d5yIwRnJ1OVORzMccgKVIADGRaV2+8lKn6Yi0YsZqY6WdfoP2LQMUTgAqrKLVelmSGoE9YMJ3NvPo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA1PR12MB7197.namprd12.prod.outlook.com (2603:10b6:806:2bd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Fri, 20 Oct
 2023 03:43:28 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%4]) with mapi id 15.20.6907.022; Fri, 20 Oct 2023
 03:43:28 +0000
Message-ID: <d22d9ed1-25a6-4b65-bda6-8266665a3f70@amd.com>
Date:   Thu, 19 Oct 2023 22:43:25 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: PIC probing code from e179f6914152 failing
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Hans de Goede <hdegoede@redhat.com>, kys@microsoft.com,
        hpa@linux.intel.com, dlazar@gmail.com
Cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>
References: <c8d43894-7e66-4a01-88fc-10708dc53b6b@amd.com>
 <878r7z4kb4.ffs@tglx> <e79dea49-0c07-4ca2-b359-97dd1bc579c8@amd.com>
Content-Language: en-US
In-Reply-To: <e79dea49-0c07-4ca2-b359-97dd1bc579c8@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0081.namprd11.prod.outlook.com
 (2603:10b6:806:d2::26) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA1PR12MB7197:EE_
X-MS-Office365-Filtering-Correlation-Id: 526fecdb-34ea-46b1-aea0-08dbd11eb88a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h2JCista5bnIJGCAv38XYYjxCufBnTcqPH1fqX/Ceyho+nCsgfIQyG5pObO0g7gWuWpIsA4OjfBHB7xvEYxi2QVsVoK/6f/wg/G/YRb2uEzgV7dWx1E0f3D/HIgiuf01KdN+DppnN7f/FXb6ak1y0/CXJzuH5o66/rlFVS3w06bNAuD7OzkpsvZPJT7B8qN/Ko57m17Dk4mZj6fzdCAdwP+Vugp8uWz3RU090ss+TJK9gIpkqcweHONszFMMJV0yTjVAD63V36B9DyLFuWpSrNHPWb26vn37l8q41R8LR7oFTRYvdR81Lvogoi2hYt2eWUnteyrJ1sy/D3RqiG6MeYSJE749BNbYI9bIux1hzAC74GidYHjXPayyPXuZ4oyBP5vuyC2aA5VxmGZdxLHH5+XYkd9rvvWlIu8CjY0NVyCawDyZVTrjQMzKBVQDsctQGqXX4gDfvHqkQKyw4Ts5bn1Ht4ajt/StYchfhsNDU9YtJ9I6AbJfdT6fzXU2UhgAIIcOqyLCQRaEP5yqllR7i0XlQQJ7pmRKRfFLxxcumHzrgL/NOELEO7U/Sf3iJMo+AEWZyBRAnrfxorM/391Z5aXfJCzV8VtKwesf9FRazustNj5mXj2GF1F5W76vuKPpBoIbsA5uj9n+9k4lLTDPhw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(39860400002)(136003)(346002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(2906002)(4326008)(86362001)(110136005)(31696002)(36756003)(316002)(66556008)(66946007)(66476007)(54906003)(478600001)(8936002)(6666004)(8676002)(41300700001)(6486002)(966005)(44832011)(5660300002)(38100700002)(6506007)(2616005)(53546011)(6512007)(83380400001)(26005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUV0VHJDMkFPVXc5ak5FeHJkVWRKZjV3amM4YXpMVFBXaEVxblcycWx6cW9p?=
 =?utf-8?B?SEdLWDN4by90eEZWWk1UYWVxcHlzU1JxbkVRMHFCRHByYm0rZmFCNk8yNTlV?=
 =?utf-8?B?eXd4WXNId1JOWUpNaTdSWVdPN3NMMjFFbXYvN0ZyczdDZFBNbFZPbFlNUE5I?=
 =?utf-8?B?NEkrTktlSGYxVHpmTG1xbGJUZ3NueUorcFgvbG5Ib0N6RlBKaUVVeDNpTG9Z?=
 =?utf-8?B?b1BtZHBRdGNWd3ljaCtDZjZJSVRmaHlGMDZRNXpSZ1dLenJhZ09qMUdBZUJs?=
 =?utf-8?B?STR4bFNTZlF1N2FBczR4TC9tMzNLeTZTV3FDS2JQTFNTZG1BeURuOStJL0ZJ?=
 =?utf-8?B?Z0ZCRkllM0Q3b0FUdFowOVJMVTgxcWdhZThKYmRPOWlNNzJjZk1GUy9BVlN3?=
 =?utf-8?B?VFR2aUZUeHRzaVFsU0hLYVhvcXRGSElDYldsaTVjT0tjM2x4MWk3OVpGZHMw?=
 =?utf-8?B?MkpQejlGVkE1aGdsNkhnbXVCQ0NZT05LMjQzc1hGcFYvUll6Vm15QnZnT096?=
 =?utf-8?B?Yk5KSU8vTW9HdWFzSHVPM2xLcTQ3WWlaVXNuekZZS1d0Rjh5YnpIZWlxQnNO?=
 =?utf-8?B?OFB6b3Y1WUR0VWttRGxVTk1KL0xLNW5makU5OGQ1V2EwN3ZRUHU4TndrcDVX?=
 =?utf-8?B?YWUraXFvWFViQlB3QXg5V2dDUHZwVDJEU1B1M3F0SitYQ042T0pCNDdiakxR?=
 =?utf-8?B?L0FWQ1piOWppZ3FUOUxNSWNuR3lXTU5FV0tPUDkvaE1tN0g5MGlKN3VZKzI5?=
 =?utf-8?B?QXdRU3hRK1AwdGoyaU12d3ZOVkg0Z1lFQ043VjZZTm5wa0JrTWxBMS8ybXNp?=
 =?utf-8?B?My9ya2FjaFNCYVEwZkNtZVdjaWpEUk1zT3NyNTRqdjhHeVo0OUk3bDRINUhw?=
 =?utf-8?B?OHE2VzV1S0FxSGpCdFR0VmRKNjZsOFlzNjdwdFI3OEhLTzJpY3pWalhCbjd4?=
 =?utf-8?B?TStVbDg5MmFtUm9WVkxvMElTZFordXVPMWVqZFFRYk9tbWM3UkpNUWZYTTgz?=
 =?utf-8?B?dmNYV0VQQWpIWU1kK0tNTmptbWpuN2hmYWNFbk83ZTJPcEJFOWhma0srYkJp?=
 =?utf-8?B?dWdJRDh1NDJaNUNLVFlZdE1RZ0E5dWY2RXFCYzhkSzJWZzNVaDRTREtrcDMr?=
 =?utf-8?B?RXpyOXh5NVlKVkZ5QTBDcklRK2NYdjVaK2RYWnN1djFoOHVqeG5qeCt4OTIw?=
 =?utf-8?B?Mlcrc3FkNFY3emt2QVh4NlRPa3JuWmhWR0thMzlVNVpBK096Z2pXOU1nMlg3?=
 =?utf-8?B?MUFzSjdsdm5iQ2xqMDMwL1Z1RnJaTjQvTFNhWWpTb0xYSXV1WGE5TUoyb25W?=
 =?utf-8?B?MnV1MkV5Y0VKejRTRFB1dUowaXFWTDlkK1RGbXE5ZEE1dHZCZ0R5ZXlQY3p6?=
 =?utf-8?B?dTlzSFA5ODZyNVl4NFlFckUwSHFsVWs5NjRlWk5DVHd6cjJZNi9UaTJuck03?=
 =?utf-8?B?dWNSSEw1SVcyM0Rxd0NlK3dONVNpRVUvWHNrcmJGbE9raGZoM0grRC96MEZo?=
 =?utf-8?B?Y25QVmdKOUEvNGFHQU1lUXZ6bXd2aFBPWVpZN3FmSlhzUTZkMldSbHYzOEp5?=
 =?utf-8?B?VGtOWndVV1AxVjcrRWRWUGkxZzd4eGhQY0I3R3FFNnhscDFtQkdtY084QVc0?=
 =?utf-8?B?alh2L2JwREE0SVk5M2dsOVU5SEY4Zk15WFV5SjBzWEdKNUxMREhaYUc3VERm?=
 =?utf-8?B?djA0VHBrelRtVzBLWFFqNmp6QWhWWTFtNzFKZWU2NFpYOEpIRVc1Zi9YelNS?=
 =?utf-8?B?RGY5YTNyM3J1ektYTFlHZHYyc01ndDdMWDNoRnlMVnkzUEdVZFoxc3dYdTY1?=
 =?utf-8?B?QzlDK0NKQXA5SFUzeUtZb093QklDVFA2MmxrY2xJaGxqYmFZQlFyWWdVRys0?=
 =?utf-8?B?YTVqc1JCM25vbm0yRStwUFNmZmtTekJ0VWQ5TmJTMlJNVXN4N3d2TnVmOEQ2?=
 =?utf-8?B?a2tJM2VvWldGejhzQnBHSGRheUJNeEZvSTBDdnRPNGNaSmtIWmtockRjQjds?=
 =?utf-8?B?NjBEZldUaHdmWnJoSVlGUjd3QzEycWlOajAwckJDRDVMMm1mVDNnRm5UMWVF?=
 =?utf-8?B?RHZVRVp0UGVFMUJjcjB3TjdFeng2UDFkL1lnMkNNZVpnRnd4eWhZdVVVQStZ?=
 =?utf-8?Q?EcnuZD1pw3dRE+QyUVxRyvzEp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 526fecdb-34ea-46b1-aea0-08dbd11eb88a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 03:43:28.0795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OnKCC5g9fwf8GY9ry4erPUZu39fhDypnKW6WPUXmpMVD+sLOLF4bo5Po3VEBiDDXmuohsW68zsfdJkEbnfdKQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7197
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/19/2023 16:20, Mario Limonciello wrote:
> On 10/18/2023 17:50, Thomas Gleixner wrote:
>> On Wed, Oct 18 2023 at 13:50, Mario Limonciello wrote:
>>> Recently an issue was reported to Bugzilla [1] that the Keyboard (IRQ 1)
>>> and GPIO controller (IRQ 7) weren't working properly on two separate
>>> Lenovo machines.  The issues are unique to Linux.
>>>
>>> In digging through them, they happen because Lenovo didn't set up the
>>> PIC in the BIOS.
>>> Specifically the PIC probing code introduced by e179f6914152 ("x86, irq,
>>> pic: Probe for legacy PIC and set legacy_pic appropriately") expects
>>> that the BIOS sets up the PIC and uses that assertion to let Linux set
>>> it up.
>>>
>>> One of the reporters confirmed that reverting e179f6914152 fixes the
>>> issue.  Keyboard and GPIO controller both work properly.
>>>
>>> I wanted to ask if we can please revert that and come up with a
>>> different solution for kexec with HyperV.
>>> Can guests instead perhaps detect in early boot code they're running in
>>> an EFI based hypervisor and explicitly set 'legacy_pic = 
>>> &null_legacy_pic;'?
>>
>> No. This detection mechanism prevents PIC usage also in other
>> scenarios.
>>
>> It's perfectly valid code and the assumption that you can read back what
>> you wrote to the master IMR is entirely correct. If that's not the case
>> then there is no PIC, the BIOS has disabled some parts of the legacy
>> block or did not initialize it.
>>
>> Letting the kernel blindly assume that there is always a PIC is just
>> wrong. Worse, it puts the burden on everyone else to sprinkle
>> "legacy_pic = null_pic;" all over the place with dubious
>> conditions. That's exactly what the commit in question avoided.
>>
>> So no, we are not going back there.
>>
>> We could obviously change the probe() function to issue a full PIC
>> initialization sequence before reading a known written value
>> back. That's basically what the revert causes to happen via
>> legacy_pic->init().
>>
>> But I fundamentally hate to do that because forcing the init sequence
>> just to make presumably broken code which has some dubious dependencies
>> on the PIC or on nr_legacy_irqs > 0 happy is not really a solution when
>> the PIC is actually not needed at all. For anything modern where all
>> legacy interrupts are routed to the IO/APIC the PIC does not make any
>> sense whatsoever.
>>
>> We rather go and fix the real underlying problem.
> 
> Looking at the logs from David and also trying to mock up the failure on 
> my side I have a few findings I'll share, please agree or disagree with 
> them.
> 
>>
>> The kernel can handle the legacy interrupts perfectly fine through the
>> IOAPIC. There is no hard requirement for the PIC at all except for
>> really old systems which had the timer interrupt wired to the PIC and
>> therefore required to route the timer interrupt through the PIC instead
>> of the IO/APIC or did not provide routing entries for the IO/APIC. See
>> the horrible hackery in check_timer() and the grossly misnomed
>> init_IO_APIC_traps().
>>
>> I just took a random machine, forced the NULL PIC and added
>> 'apic=verbose' to the kernel command line and magically all the legacy
>> interrupts are set up via IO/APIC despite the NULL PIC and therefore 0
>> preallocated legacy interrupts.
>>
>>    apic 0 pin 0 not connected
>>   IOAPIC[0]: Preconfigured routing entry (0-1 -> IRQ 1 Level:0 
>> ActiveLow:0)
>>   IOAPIC[0]: Preconfigured routing entry (0-2 -> IRQ 2 Level:0 
>> ActiveLow:0)
>>   IOAPIC[0]: Preconfigured routing entry (0-3 -> IRQ 3 Level:0 
>> ActiveLow:0)
>>   ...
>>
>> which is identical to the output with PIC enabled. That debug message is
>> emitted from mp_irqdomain_alloc() which is invoked via the PNP resource
>> management code.
>>
>> Now /proc/interrupts:
>>
>>             CPU0       CPU1       CPU2       CPU3
>>    1:          0         56          0          0    IO-APIC   
>> 1-edge      i8042
>>    4:        442          0          0          0    IO-APIC   
>> 4-edge      ttyS0
>>    8:          0          0          0          0    IO-APIC   
>> 8-edge      rtc0
>>    9:          0          0          0          0    IO-APIC   
>> 9-fasteoi   acpi
>>   12:          0          0        122          0    IO-APIC  
>> 12-edge      i8042
>>
>> Keyboard and serial are working, see?
>>
>> The only interrupt which does not work is interrupt 0 because nothing
>> allocates interrupt 0 due to nr_legacy_irqs == 0, but that's a trivially
>> solvable problem.
> 
>  From David's logs I can see that the timer interrupt gets wired up to 
> IRQ2 instead of IRQ0.
> 
> IOAPIC[0]: Preconfigured routing entry (33-2 -> IRQ 2 Level:0 ActiveLow:0)
> 
> In my hacked up forcing NULL pic case this fixes that:
> 
> diff --git a/arch/x86/kernel/i8259.c b/arch/x86/kernel/i8259.c
> index 43c1c24e934b..885687e64e4e 100644
> --- a/arch/x86/kernel/i8259.c
> +++ b/arch/x86/kernel/i8259.c
> @@ -424,7 +424,7 @@ static int legacy_pic_probe(void)
>   }
> 
>   struct legacy_pic null_legacy_pic = {
> -       .nr_legacy_irqs = 0,
> +       .nr_legacy_irqs = 1,
>          .chip = &dummy_irq_chip,
>          .mask = legacy_pic_uint_noop,
>          .unmask = legacy_pic_uint_noop,
> 
> I think it's cleaner than changing all the places that use 
> nr_legacy_irqs().  On my side this makes:
> 
> IOAPIC[0]: Preconfigured routing entry (33-2 -> IRQ 0 Level:0 ActiveLow:0)
> 
>>
>> That machine does not even need the timer interrupt because it has a
>> usable APIC and TSC deadline timer, so no APIC timer calibration
>> required. The same is true for CPUs which do not have a TSC deadline
>> timer, but enumerate the APIC frequency via CPUID or MSRs.
> 
> Don't you need it for things like rtcwake to be able to work?
> 
>>
>> But that brings up an interesting question. How are those affected
>> machines even reaching a state where the user notices that just the
>> keyboard and the GPIO are not working? Why?
> 
> So the GPIO controller driver (pinctrl-amd) uses platform_get_irq() to 
> try to discover the IRQ to use.
> 
> This calls acpi_irq_get() which isn't implemented on x86 (hardcodes 
> -EINVAL).
> 
> I can "work around it" by:
> 
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 76bfcba25003..2b4b436c65d8 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -187,7 +187,8 @@ int platform_get_irq_optional(struct platform_device 
> *dev, unsigned int num)
>          }
> 
>          r = platform_get_resource(dev, IORESOURCE_IRQ, num);
> -       if (has_acpi_companion(&dev->dev)) {
> +       if (IS_ENABLED(CONFIG_ACPI_GENERIC_GSI) &&
> +            has_acpi_companion(&dev->dev)) {
>                  if (r && r->flags & IORESOURCE_DISABLED) {
>                          ret = acpi_irq_get(ACPI_HANDLE(&dev->dev), num, 
> r);
>                          if (ret)
> 
> but the resource that is returned from the next hunk has the resource 
> flags set wrong in the NULL pic case:
> 
> NULL case:
> r: AMDI0030:00 flags: 0x30000418
> PIC case:
> r: AMDI0030:00 flags: 0x418
> 
> IOW NULL pic case has IORESOURCE_DISABLED / IORESOURCE_UNSET
> 
> This then later the GPIO controller interrupts are not actually working.
> For example the attn pin for my I2C touchpad doesn't work.
> 
> Checking the debugfs with my "work around" in place I can see a few 
> things set up differently:
> 
> NULL case:
> handler:  handle_edge_irq
> dstate:   0x3740c208
>              IRQ_TYPE_LEVEL_LOW
>              IRQD_ACTIVATED
>              IRQD_IRQ_STARTED
>              IRQD_SINGLE_TARGET
>              IRQD_MOVE_PCNTXT
>              IRQD_AFFINITY_ON_ACTIVATE
>              IRQD_CAN_RESERVE
>              IRQD_WAKEUP_STATE
>              IRQD_DEFAULT_TRIGGER_SET
>              IRQD_HANDLE_ENFORCE_IRQCTX
> 
> PIC case:
> handler:  handle_fasteoi_irq
> dstate:   0x3740e208
>              IRQ_TYPE_LEVEL_LOW
>              IRQD_LEVEL
>              IRQD_ACTIVATED
>              IRQD_IRQ_STARTED
>              IRQD_SINGLE_TARGET
>              IRQD_MOVE_PCNTXT
>              IRQD_AFFINITY_ON_ACTIVATE
>              IRQD_CAN_RESERVE
>              IRQD_WAKEUP_STATE
>              IRQD_DEFAULT_TRIGGER_SET
>              IRQD_HANDLE_ENFORCE_IRQCTX
> 
> I guess something related to the callpath for mp_register_handler().
> 
> Maybe this is the same reason for the keyboard not working right.
> 
>>
>> The CPUID/MSR APIC frequency enumeration is Intel specific and
>> everything else depends on a working timer interrupt to calibrate the
>> APIC timer frequency. So AMD CPUs require the timer interrupt to
>> work. The only explanation why this "works" in that null PIC case is
>> that the PIT/HPET interrupt is actually wired to pin 0, but that's
>> something to be determined...
>>
>> Can I please get the following information from an affected machine:
>>
>>    1) dmesg with 'apic=verbose' on the command line
>>    2) /proc/interrupts
>>    3) /sys/kernel/debug/irq/irqs/{0..15}
>>
>>    #3 requires CONFIG_GENERIC_IRQ_DEBUGFS to be set.
>>
>> Two versions of that please:
>>
>>    1) Unpatched kernel
>>    2) Patched kernel
>>
>> Thanks,
>>
>>          tglx
> 

At least on my system with forcing NULL PIC I've come up with this 
series to make everything work.

David, can you please have a try with it on your system?

https://lore.kernel.org/linux-kernel/20231020033806.88063-1-mario.limonciello@amd.com/#t

Thanks,
