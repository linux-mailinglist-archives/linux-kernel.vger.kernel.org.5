Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B43DF7D149F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 19:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjJTRNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 13:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjJTRNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 13:13:31 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F54D68
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 10:13:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NaK3uWCkvmLBb2nCAHQSN8O+eFHoCu/+lEv66YQtMSUy3knZTOrdI0xrucT/VgDcpLa12dISvmEP2q84vwJDHhiRgi0wBTLf16MCB2293hqqJ6ZlJl1s3D//Tx0UfPWM2C9r05WCjYaUXlH/9jsUXoE4djq8DW68+t9aglVtGhxRQvMRnkFxuk/Lx+LS1pnMHHDpy/ZUhLDlTgYX7ersl4ZnCJqhwyPibp0rMS2r2t7/4OP4t2PE3XSTkKgv947XSZGDMoFzQFaccqsoVsu2zz839hMx6JKxYFqspMWBZUrwXzZ7XzmA0jA1MZnkdJPgOw4AD3BGdXxj3thHCtf/Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cLFaoaTeuhnsZtIKDNNVtBg5dAicT4LsE6dsNmR+WQk=;
 b=ZiIW+j+ZesdLioSsoFFTvD6nClVpm7+mOV64I5ix93EFxve2ZqP3UnNDjH2Rbhcb6drKN0yyHLY2nbeoXkMmN1KRWkOu1CKkUz8O57UmRpxKqSsQLOHZny6yyYzhwXIHR3bEWl5l3zUUFbaehRjvZmzjxrPIB6/YedPHmgOlUtluq7DHaYH4VxKhzRKqnB2hF4xCS4s/ww3w9dQ1emHFIkAIRuAO/8eNmc9PDzoysfRbObRuBHrFDUMXbHgiPZDmL6mu5/FIaGxjRJ5hdYv0h6FfxWUIDhHUoB/mt6JfVwy3Hnw+sku8+E2j7PKZ/KRL5p5TGe/jOu47XhqrHh3dnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cLFaoaTeuhnsZtIKDNNVtBg5dAicT4LsE6dsNmR+WQk=;
 b=1pPxvy0LidH2HhG87OXlDwJU8tpoirMYRh2pKXvYr1bNAAMKsHjSm3xgz+rqO0hH+H5srr8/DIc41xo4nT26JMcoN7BF9Ee0iqtOeguf3dfKJkEoKGIEYbuREELi/2DGcSutoV86UuZAEB8SYhQEpEngLl6LWgMh0WYDzKbC0cA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MW4PR12MB7482.namprd12.prod.outlook.com (2603:10b6:303:212::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 20 Oct
 2023 17:13:22 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%4]) with mapi id 15.20.6907.022; Fri, 20 Oct 2023
 17:13:22 +0000
Message-ID: <47ee8f0e-1a50-4284-b33f-115f898fedcf@amd.com>
Date:   Fri, 20 Oct 2023 12:13:18 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: PIC probing code from e179f6914152 failing
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, kys@microsoft.com,
        hpa@linux.intel.com
Cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>
References: <c8d43894-7e66-4a01-88fc-10708dc53b6b@amd.com>
 <878r7z4kb4.ffs@tglx> <e79dea49-0c07-4ca2-b359-97dd1bc579c8@amd.com>
 <789ff693-a4f0-eef7-7991-59c031fefe49@redhat.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <789ff693-a4f0-eef7-7991-59c031fefe49@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR06CA0015.namprd06.prod.outlook.com
 (2603:10b6:8:2a::26) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MW4PR12MB7482:EE_
X-MS-Office365-Filtering-Correlation-Id: ce47fd11-44f3-48ca-8af7-08dbd18fdce0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nUByDcYeyAn110UUPV8DXdxjEZTEjgojORwKGmQj7wQEkmIi1sSO6UuYLNaDyUAJVBQMHakynNodYQC7l/hlBx1WqMb9aV3neLeYJJmebRvXXL/jcK32KVYFF9a22GwtfiiyjCces6J+bKhE993X4FNg5A1tSjDCdU7dLI2A8Ujq9F+v/bg81QFfLyTlpvWPsYSGQXUbIBArvz4Yso1ayLtHxtNrOuWwMiOIn5wCRdmHRYhPI7VVM+jkgaRIo4eFL+Ad9e95F5RWwYlazQz06/PGaZBEddnDm585xzV5xQZYcT/GMIodEDi6f9Yu9EIzSYnFWSXhk/J/fYd/hDBEVd+b7YIq+1u6UQR2Ro4/kq1YomXeQoJtpjwU90R+u/BSJ6U2HGvhCjsqqCXoSvnSl+Ho2tbIxwiUzmW6KNzAr54IKGfTU+/Fg03686ZMbFFf3gOzQiI+gWIKdg9SYJry0GUOdJkd6mw18AJFCRaK8KAynJbRC+duRwkIZEbcip4QAQEp3bNcvCP4gXSRzV4xxRI7PPmN0A54OlvhX5vdGf9BUh6kMPXGtqE4L0gK0PP2MzQ5BuEC5pjLSufB8DIhVPsL5LhLDNsxixNHdhrpbvZTumft0br0UkgJmGAR7DP1SjDT7q6rdRpxNyPhGv7alAuIdxEGs1gMGYqM0k76nHqKkskOmymvOUXRuaey5HND
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(39860400002)(396003)(346002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(36756003)(41300700001)(44832011)(8936002)(8676002)(4326008)(5660300002)(31696002)(2906002)(86362001)(31686004)(6506007)(53546011)(966005)(6486002)(83380400001)(6512007)(478600001)(38100700002)(2616005)(316002)(6666004)(26005)(54906003)(66946007)(66556008)(66476007)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTlNeWxtU2x3ZTVQMnRVVEp6dkRMcjJLMFgvVi8vRkp6Q1JnaWVmRkltNFVu?=
 =?utf-8?B?b1pEWXRBdk9XVkFtbGNxMjczVmRCMzY5QjFIZHM5TDF0OUhkMXowVGFGelNF?=
 =?utf-8?B?R2lEUW8rMVYrMWJZMEdwOWlXTXdBNUhscTBCMUhwQmh1bWhYOHQ5Tk93WUVS?=
 =?utf-8?B?S2V3TDI0ZmpjZDhqc0YrM0tpd2cyMW1DRHZlNWI0blhtZ3k5c3VncSs1OHF4?=
 =?utf-8?B?ZjR6MUNsNVJxTGdXZXFkcTZ3VUtrWWh3K3c1SlY3MUJteGovemMwN1lENE1n?=
 =?utf-8?B?VkVZbVhmQ2RCWW9qTUZnT1J1dlF0M2JqLzBxMDhMbTNHS0JORTlEZGtubGhD?=
 =?utf-8?B?K2JxQnQ5UW9ESXRaUzVJRUx4WlRnekYzNWJxOGdrZXpTRXlVNS81OWNNc0dK?=
 =?utf-8?B?Vy9IZnNSR1BGUCtFcU1qY3VjTFZLNEQxdVBYanpuSzVBTmpYQ0xjaWVJSVk2?=
 =?utf-8?B?Y3krcXZnWWQ1MWZadVpwVWRtVldrRXI0U3BLOTg1RzlqMXVBS0FGRGF4Zi9K?=
 =?utf-8?B?bFZlVDk2YUExbVd3QWFRcTdaQ0JxT3F2QkYvdzFTUUdIK1l2RWtLa2sxcFI5?=
 =?utf-8?B?Yms1K3BvSVlpcnVhYy9nYzZVWEhUMDNSbWYzNXF6RUVTYUNnTnFJc3FBaTFt?=
 =?utf-8?B?NHVRZnVaM3BMcXBuc1FETVRhNUMvTzdFaHRYQnhTb1ZqN1RES0gxdXhqdSsx?=
 =?utf-8?B?ZnpUd3FOUCsxbHJOSGE4bUtUUHBNblNrU1dBYWdtTnVCR0NtOUZFT05kNDA5?=
 =?utf-8?B?UWlLakxBbE91dGQ5SG05MjAzM0lteU55Q1RTOGVhTVo3VjViYlJnQjg4bVhv?=
 =?utf-8?B?QXdGWVhoM3VKMEZmMnk3QUE4amZDN3NPRHZIb3ZOSWlmUE1TV2FHTFU4dFV3?=
 =?utf-8?B?Uk1GZVpNWi96NndqRHdJdklqYUZPWmNJazgrMzRBUEpmYVVubUhKV1dER2Fr?=
 =?utf-8?B?L1VrLzNYUEFEVEZKdFJlOEZ5ZkRtYlVKWXJsK3pLcmF5emp2Rm8yaFBwalYv?=
 =?utf-8?B?Qms1aGs3TktqVVRDR3FJT2p4ZFZ6OFdDeE9GRm41eGl5dU9CUzFseVNNc2V2?=
 =?utf-8?B?ZkxpTnhwMkZXcVA4TWdUYlVOQjdKQXo0dVpQdndCQVZTSDh4WC9UMEZpUXB3?=
 =?utf-8?B?ekpjOS9oRTJrUWxmU2xuWjJIZTV5SHZVcStrcFJrN3grTkVIK0pjVGNCUGV5?=
 =?utf-8?B?RU1uYWVmL3ZsSmZqaUtETDJxUHQvZ3BNaFNLaFRrVkJGMWdrbWpHbTFGV0NJ?=
 =?utf-8?B?aHlCbVpYVkRteXg2T21HYWVVcFMvc0NnaVZJd09PcTlVV21JYlJOUFpmSllx?=
 =?utf-8?B?MW9HM2I4NWtTTWdUVHV2M3R0UVNyRHV2WXIvVHNORFhlUHQyVGk3WkxWSDdU?=
 =?utf-8?B?NVQ2YVlDNEJXYXMzSkE1TTVNckp6a1FhWUFFRU5hbnhlWmRSWEQ1c20wOTFU?=
 =?utf-8?B?QzVVNjFrMVRPWVBoREYzdDVBYitBQ2krb01XbjBIekdXS0VsWFhHOXRrbGRK?=
 =?utf-8?B?MVUwRVBUV3NkajN4dm8rdlN6b2t3MmpOU2YzaFFnZ3hkd1VnR0xmbkhRZXVB?=
 =?utf-8?B?VTNqVmU2Mm53OFhxS01zb0xzbm1zZTdaaW5RNkp4SGo5NWRadWxMVFNsM2I5?=
 =?utf-8?B?VVhhdjNLMUVVZjd4dlIwM0NYWENrRStMeGxPT2RCWkpkMkc5ZmVJUWRMYW95?=
 =?utf-8?B?NEN6cGsvY0wrRGF3Mlkwa2ZaNElvV3k4MkxsMFdvLzl3K2xvVDRDUVhrVjN6?=
 =?utf-8?B?NjF0R1cyVUF4RVM0bW9DMUxBQlphQmVzbDkwamZGUGtONmU2dFA3U2ZQVDFn?=
 =?utf-8?B?WHZQTFZIWGVrQ0xWODNKZnJZaDRZMnZXOTZWdHdjL3VXcXh3Ykp4NXQ4U21G?=
 =?utf-8?B?b1FidndiSktrSnFmaDlJRlowaVhwODNJZTFmNFdBOVd4aWN2RDFJdHBaTEht?=
 =?utf-8?B?OGNqaWFEZ1pCaFVQK1ppRXZXUUFGTklENFE2RFF0UzIzc3h0WU5EL3ZWUHRX?=
 =?utf-8?B?bXVBSVl5NjFRUW5Cd0NvS1hHVjVyUDIrT2ZpYTF1NlJQR2E5VFdMOEZUWHhP?=
 =?utf-8?B?ZFFDZUhVK2p3VDcvNlFHd0t0MXFRczZXallPTTd3VGdtc09rczZZLy94OW1S?=
 =?utf-8?Q?2ITxWyKDbzp3VO5YlR5HQLFlv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce47fd11-44f3-48ca-8af7-08dbd18fdce0
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 17:13:22.0993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jw0Q/3838afgKDw3olMhGGvmA73PhkqZvCI1UvUoWZyTrOqCx2VzwAWFYQf8p5VX5K6vaKOGW+rww0t6Oy0jTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7482
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/20/2023 10:16, Hans de Goede wrote:
> Hi Mario,
> 
> On 10/19/23 23:20, Mario Limonciello wrote:
>> On 10/18/2023 17:50, Thomas Gleixner wrote:
> 
> <snip>
> 
>>> But that brings up an interesting question. How are those affected
>>> machines even reaching a state where the user notices that just the
>>> keyboard and the GPIO are not working? Why?
>>
>> So the GPIO controller driver (pinctrl-amd) uses platform_get_irq() to try to discover the IRQ to use.
>>
>> This calls acpi_irq_get() which isn't implemented on x86 (hardcodes -EINVAL).
>>
>> I can "work around it" by:
>>
>> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
>> index 76bfcba25003..2b4b436c65d8 100644
>> --- a/drivers/base/platform.c
>> +++ b/drivers/base/platform.c
>> @@ -187,7 +187,8 @@ int platform_get_irq_optional(struct platform_device *dev, unsigned int num)
>>          }
>>
>>          r = platform_get_resource(dev, IORESOURCE_IRQ, num);
>> -       if (has_acpi_companion(&dev->dev)) {
>> +       if (IS_ENABLED(CONFIG_ACPI_GENERIC_GSI) &&
>> +            has_acpi_companion(&dev->dev)) {
>>                  if (r && r->flags & IORESOURCE_DISABLED) {
>>                          ret = acpi_irq_get(ACPI_HANDLE(&dev->dev), num, r);
>>                          if (ret)
>>
>> but the resource that is returned from the next hunk has the resource flags set wrong in the NULL pic case:
>>
>> NULL case:
>> r: AMDI0030:00 flags: 0x30000418
>> PIC case:
>> r: AMDI0030:00 flags: 0x418
>>
>> IOW NULL pic case has IORESOURCE_DISABLED / IORESOURCE_UNSET
>>
>> This then later the GPIO controller interrupts are not actually working.
>> For example the attn pin for my I2C touchpad doesn't work.
> 
> Right the issue is that with the legacy-pic path disabled /
> with nr_legacy_irqs() returning 0 them there is no mapping
> added for the Legacy ISA IRQs which causes this problem.
> 
> My hack to set nr_legacy_irqs to 16 also for the NULL PIC from:
> https://bugzilla.kernel.org/show_bug.cgi?id=218003
> 
> Does cause the Legacy ISA IRQ mappings to get added and makes
> the GPIO controller actually work, as can be seen from:
> 
> https://bugzilla.kernel.org/attachment.cgi?id=305241&action=edit
> 
> Which is a dmesg with that hack and it does NOT have this error:
> 
> [    0.276113] amd_gpio AMDI0030:00: error -EINVAL: IRQ index 0 not found
> [    0.278464] amd_gpio: probe of AMDI0030:00 failed with error -22
> 
> and the reporter also reports the touchpad works with this patch.
> 
> As Thomas already said the legayc PIC really is not necessary,
> but what is still necessary on these laptops with the legacy PIC
> not initialized is to have the Legacy ISA IRQ mappings added
> by the kernel itself since these are missing from the MADT
> (if I have my ACPI/IOAPIC terminology correct).

They're not missing, the problem is that the ioapic code doesn't
let it get updated because of what I see as an extra nr_legacy_irqs()
check.

The series I posted I believe fixes this issue.

> 
> This quick hack (which is the one from the working dmesg)
> does this:
> 
> --- a/arch/x86/kernel/i8259.c	
> +++ a/arch/x86/kernel/i8259.c	
> @@ -394,7 +394,7 @@ static int legacy_pic_probe(void)
>   }
>   
>   struct legacy_pic null_legacy_pic = {
> -	.nr_legacy_irqs = 0,
> +	.nr_legacy_irqs = NR_IRQS_LEGACY,
>   	.chip = &dummy_irq_chip,
>   	.mask = legacy_pic_uint_noop,
>   	.unmask = legacy_pic_uint_noop,
> 
> But I believe this will break things when there are actually
> non legacy ISA IRQs / GSI-s using GSI numbers < NR_IRQS_LEGACY
> 
> Thomas, I'm not at all familiar with this area of the kernel,
> but would checking if the MADT defines any non ISA GSIs under
> 16 and if NOT use nr_legacy_irqs = NR_IRQS_LEGACY for the
> NULL PIC be an option?
> 
> Or maybe some sort of DMI (sys_vendor == Lenovo) quirk to
> set nr_legacy_irqs = NR_IRQS_LEGACY for the NULL PIC ?
> 

I'd prefer we don't do this.
As tglx pointed out there is an underlying bug and we shouldn't paper 
over it with quirks.

My guess at what he doesn't see this issue on his system is that the 
default preconfigured IOAPIC mappings (polarity and triggering) happen 
to match the values that would have been programmed from _CRS.

That's not the case here.
