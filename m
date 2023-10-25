Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9DF57D6F60
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 16:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343880AbjJYOlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 10:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235020AbjJYOl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 10:41:29 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD4510F2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 07:41:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=leQMMQ9Vejl4Y5deOFiy97OcxaR34K5++/0ZlPS3T89BVCyN6KzAlei6T5kmCOkhM200Hp8zhT53Am08ARuZU7TSjPD3gg1aPAPwapgT5bU5gYqCnYvqf9LFh+d7n7E9K8lIsJSCOk6VZyoj3sKQYjgWurmIIaR+abwh/mfg9kpHf3t2EOH2n8LKcPYACJ2BkE2UYI0kjFawpUv05OORfH+yDIyMwpZjY51PsFgbMqQZ448UyAY1bacq6Y2GnfEn6OXv3ffcakTwqrOgwrNZmjynrU2l/JzLxDw5uk0AqouXy3Q3uRwFev7OlFc6jo5dJ4Dxjis6WbpQpL7TW43YfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7NJ3xuULQNMGAjaQcQOV3ILEQCB56CrGOHafwg9urkU=;
 b=gKfoJlLXZt0mi78sbsmJnPQllYc5YdUI0wJHquJF+GPIaGVAF3lqR9Gu3Wc1Vo/6MHwMcqXZrMUPzfNI7/8aszlsNyIJC+hQpN5pwrW9teGT2W1aRXKqc4FHbrOmz+Kz/8dH1tYU77RpLihPRRmUqepdP8oIMo1oQZydh+kSq9AyvYLgqU6WCYmCsTQX9s0GtX88RAhXNyUC5vbMBR1w8zHU3AP4asyyGo6WR/I3w4wzAOXPX6X6HQi8YvtaS+Uz06fkh5C+nLCIWjXa9w76lidVRx39u4pA+GlWN1n7NeT/XGKL9Q4Wf8Xv45nc77lmNRT5HeeAzgk5/grm9Da3OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7NJ3xuULQNMGAjaQcQOV3ILEQCB56CrGOHafwg9urkU=;
 b=17/SfDlgPtOfvEdgymqq+YTM4Wyh6iRbsb/9JimHoIAWz4lgy6OsRLyD+CWj70eqlXbki9/8RX6X9r4DGKaouXotUdgl02/LjKLQl3BWHk4KSJfQQoZ4VY1YprSrTspK1EZgRNMAb4ayORbsV5annwqN0YeI66nEzCP35CSVcyI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MW4PR12MB6874.namprd12.prod.outlook.com (2603:10b6:303:20b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Wed, 25 Oct
 2023 14:41:09 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%4]) with mapi id 15.20.6907.022; Wed, 25 Oct 2023
 14:41:08 +0000
Message-ID: <32bcaa8a-0413-4aa4-97a0-189830da8654@amd.com>
Date:   Wed, 25 Oct 2023 09:41:06 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: PIC probing code from e179f6914152 failing
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        Hans de Goede <hdegoede@redhat.com>, kys@microsoft.com,
        hpa@linux.intel.com, dlazar@gmail.com
Cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <c8d43894-7e66-4a01-88fc-10708dc53b6b@amd.com>
 <878r7z4kb4.ffs@tglx> <e79dea49-0c07-4ca2-b359-97dd1bc579c8@amd.com>
 <87ttqhcotn.ffs@tglx> <87v8avawe0.ffs@tglx>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <87v8avawe0.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::10) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MW4PR12MB6874:EE_
X-MS-Office365-Filtering-Correlation-Id: 383834bf-f96a-4bb9-6ef2-08dbd5686d13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HGOwl92mC/doJzr1rZ6jiLIYAG0RA+9kWDOXlb2G/KIouBCDZJsKAVyOZynKTyiJrIUx6N38uFRyChKGV2pqGQMltW5TwJ8w3Y7XrvcZuxLZ782tJt3joYSS73unIXR0D3tK/ilD7qwcMr1hbPMfuEVstqAPt00MkYgPZnGlDje2tinjqYXZ1isryiU4002kOeKwEElqWvKamWiQ3GqFF7SiVC61a2rMWvkOXimLm6dLcGm0qYHRH6OaXa1OS8oc+786rpKkbMCIr972Q2JplsSUPkrTso8pqDGHPHlNm/LSxtjXDRFHSOh1x937j7r2U2xhSA++M2vxbNaFhpVMpwO+Ric2U31W1k/Nv4hoCc0JJAoswGla0N1DZcPh+/wmsq7CSiPl6MZ+++Nh2dfNqj1RES4x5foRtXgIsXy1foLf8QuykpiweSZ6LtQWYZVGD68zmSBdJmhk162WQKpq7eFaWxFEByzqPfDsh78qdub7+PueIxI/4OAOs4Tek5y/gSz5EvqraDzXgKXiXzNrTo2J3g/cinCM/opEjhSGXoWZZJVuCRI78bMN+yNYhgniWmIX/cYfVNeigTPVVVd64F6KHisy5tc6iMXNx+K0LVxl9kv8mIPdpD/VeUcAqglvk+eRNbl8/AXxLrYG0Z4UiA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(376002)(366004)(39860400002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(44832011)(83380400001)(5660300002)(6506007)(53546011)(6512007)(2616005)(31686004)(54906003)(478600001)(66946007)(66476007)(6486002)(66556008)(316002)(110136005)(38100700002)(26005)(36756003)(86362001)(31696002)(4326008)(8676002)(8936002)(2906002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckNad2MwZ1pHeFJOU2g3Y1o3WFJ6L0EvOVoxN1ZLWFZOMm84VGhXOHk3Z1JC?=
 =?utf-8?B?dXBtRC9pY0FtV01OTUt4aDdlV2kyODgzMWY2NURRRElnTVBBZnB1MDNQZlNo?=
 =?utf-8?B?R0UyV0xWYVpxZC9ZR25uMmxvc2tXYlVBblZFV09BckZBeXBsS3Q1aVZ4SFI0?=
 =?utf-8?B?aW1VOTZGbEdGL2IydS80VU13bmM4MDllQUlLdk9KK2xBNGkzaThVUHVIRExQ?=
 =?utf-8?B?dHhqUlR3QXUwNHliNm9IRDI4SW5YSWxxaVFSbHJMSFdDZG9sdEFMd2tsd2d1?=
 =?utf-8?B?ektGMWpHUUxVM1JMaHZVQzE2Vng1NytNVU5YUTJuVDB6azNuM21MNnIza1hx?=
 =?utf-8?B?aDR2M2JoaUdoazBwR2F4eHZXVWE3eVBuclBEOUVFNlErZDhrOFZNRzNGYkxk?=
 =?utf-8?B?ZEpXVFhoZjhyMHFBV2xydE8vOWdxNTJiR3JPQ05NQ1daL3E5SU8wSUFRR21m?=
 =?utf-8?B?a25LRjVTL04wKzJ3cHJHeVZ5U3Z4Ukk2N0dMczBwNGhScmtRT2pKNXN5U0Rk?=
 =?utf-8?B?ZmN6Wm5IMHhXbitiVFQ5enRJTUV4RlZhTy9xbU16dGlpL1J6K0RiTS9LcVBK?=
 =?utf-8?B?clZhMHo4MXhhcVhLYXdwS29DZkpzQlBPK01KT0V5djYxYTFNbTY1dHJKUUxq?=
 =?utf-8?B?K2xFbHNSVTBYanNqY2w3QXdHLzN1SHBjMjZYZFhWQWcxbGpEOHl0U3dMdVNO?=
 =?utf-8?B?QjRwSE9NZzZaMzRZUmh6VmdYay8zNkkxOXJob0tiY1llajE0TkVoMmdyZUZm?=
 =?utf-8?B?VWMzNnlOajJVWXpKZDcyNldkeCs3dE9QVDVWa0VqeGVjeUxaRGJaTVFydDJQ?=
 =?utf-8?B?MWNOd3EzZEdjVWZMSldiWHFsdWFCM3lzcmZZSG5YUlVmUjR3ajE3aExwakVu?=
 =?utf-8?B?anBUdExQVEpCQjFGNm1mcWFRWWs4TlFsdG1tL2w0all0YVZYOTB5QlAvSXIw?=
 =?utf-8?B?NDNMSGNTTGhIdlkydkp6emE4Z3R2YS9nYU42c2M4SWxxNHVVaHVoQndpZTBi?=
 =?utf-8?B?QjZscU9pMUF1TjFuekNiRDBNaURFSG8ySlh1enRpMjV2VXF3ajJGM1BrRGwx?=
 =?utf-8?B?R3lKNjE5SkhFRG9iMkhNeHo2WFIwQWhyT3RLTDFoZ0ZkSFFCZDdpblB5cEFN?=
 =?utf-8?B?bE8xb011VWFFQXB2QlB4Uzh6b1BaR3NHMkxpa25kUHY3NTBPV0huTnlEVTNl?=
 =?utf-8?B?NDRleW5rZVl2blY1N0FUOEIyUEUrcHJxZ1BGUkFhaUdOend0ZXVTQ0ZOOFFq?=
 =?utf-8?B?WDlSNXpnb09NMzhPWGdGc3BHU3hTNDFpQzNkTTdUVDcvbVFWaUxnbGl2Qjh3?=
 =?utf-8?B?d3Iwd3FsMmFKZUNUVmc2WGw1VTIxaEMybWVQUk9DNnJNVHZLaHc1bnJWNkx2?=
 =?utf-8?B?V00rOHN4TzNxZ0gwb0pWS3hYNkZLUUNYcW4wMlh5VFRRMlRHWllyUHpTVzRF?=
 =?utf-8?B?ZncxWERuNkJJVllWekg5RW1FT0RWTUgzYk1MTWpZWStteVF4VTRhRnFIU0xj?=
 =?utf-8?B?TUk1VEQxSTF3aWtMZzBVeTdLK3pKNlBjNTlXMHhHOWdnUWlhMkliOGNHSVEr?=
 =?utf-8?B?aHFyZzJzOUQ2VHRobUVIV2dsM0RWeEkyK1FodmlsWHpkelJrVW9GZU1YK1ln?=
 =?utf-8?B?bzRaQzAxK3hzRTJnZy9WTGNQSC9zRk9qYlNUSjBuckZscjRwaDl3RngxREFa?=
 =?utf-8?B?NnVBV1NtMXJwMHQzQzBqQzJqamVpcVpBOUNFY3AreVYrVWhzVEZNUEVRYVU0?=
 =?utf-8?B?L3JON1NXdnczZzQya2pwY2xZaVhhMXo5aFBYYVVKYWM4NUpDR0NyM0FHU1cv?=
 =?utf-8?B?bWNGSEhVaTRGVFV6dGhUVENkak9DeVVVQXFmRitpVDNNaFhKVkx4b0cwb1li?=
 =?utf-8?B?M2tnY0xpc2ZnKzcrVE04WCtoRWNzUDJEbDZiZUNOYXNNR0VSWjV6Zm82UDJu?=
 =?utf-8?B?dGZ4Q3A3YkhvZjR2NXFJOWl6b0FuMFdSMUpCRGV3SUJHSW9Pd0JmYXptMkhs?=
 =?utf-8?B?SkFjeHN5a1YrNitkL3RuZm9tRDl3TTIrcklBVy9zMDRXYURUNU5lYXBXbm5X?=
 =?utf-8?B?MFYyRVlvYXN4S3Z3QkFleWh6OXJYVWV1cnNyWWI2QkJYSkRNM1h6MzJxbnZo?=
 =?utf-8?Q?8TiSMzv3cTgIW3gRHX4u9GPgp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 383834bf-f96a-4bb9-6ef2-08dbd5686d13
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 14:41:08.8236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OhlTZDnT+sO3gAokl1yNu+uqhHnEX3RS/3HUYU/DAV4nnm1RkutOPFcK/iR0OLjQkYW1O5anHfZ765g5H/Dypw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6874
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/2023 04:23, Thomas Gleixner wrote:
> On Mon, Oct 23 2023 at 17:59, Thomas Gleixner wrote:
>> On Thu, Oct 19 2023 at 16:20, Mario Limonciello wrote:
>>>    struct legacy_pic null_legacy_pic = {
>>> -       .nr_legacy_irqs = 0,
>>> +       .nr_legacy_irqs = 1,
>>>           .chip = &dummy_irq_chip,
>>>           .mask = legacy_pic_uint_noop,
>>>           .unmask = legacy_pic_uint_noop,
>>>
>>> I think it's cleaner than changing all the places that use
>>> nr_legacy_irqs().
>>
>> No. It's not cleaner. It's a hack and you still need to audit all places
>> which depend on nr_legacy_irqs(). Also why '1'? You could as well use
>> '16', no?
> 
> So I sat down and did a thorough analysis of legacy PIC dependencies.
> 
> Unfortunately this is an unholy mess and sprinkled all over the place,
> so there is no trivial way to resolve this quickly. This needs a proper
> overhaul to decouple the actual PIC driver selection from the fact that
> the kernel runs on a i8259 equipped hardware and therefore needs to
> honour the legacy PNP overrides etc.
> 
> The probing itself is to stay in order to avoid sprinkling weird
> conditions and NULL PIC selections all over the place.
> 
> It could be argued that the probe function should try to initialize the
> PIC, but that's overkill for scenarios where the PIC does not exist.
> 
> Though it turns out that ACPI/MADT is helpful here because the MADT
> header has a flags field which denotes in bit 0, whether the system has
> a 8259 setup or not.
> 
> This allows to override the probe for now until we actually resolved the
> dependency problems in a clean way.
> 
> Untested patch below.

+David from the bugzilla.

I checked his acpidump and I do think this will work for him.

[024h 0036   4]           Local Apic Address : FEE00000
[028h 0040   4]        Flags (decoded below) : 00000001
                          PC-AT Compatibility : 1


David - can you see if the below helps your hardware?

> 
> Thanks,
> 
>          tglx
> ---
> --- a/arch/x86/include/asm/i8259.h
> +++ b/arch/x86/include/asm/i8259.h
> @@ -69,6 +69,8 @@ struct legacy_pic {
>   	void (*make_irq)(unsigned int irq);
>   };
>   
> +void legacy_pic_pcat_compat(void);
> +
>   extern struct legacy_pic *legacy_pic;
>   extern struct legacy_pic null_legacy_pic;
>   
> --- a/arch/x86/kernel/acpi/boot.c
> +++ b/arch/x86/kernel/acpi/boot.c
> @@ -148,6 +148,9 @@ static int __init acpi_parse_madt(struct
>   		pr_debug("Local APIC address 0x%08x\n", madt->address);
>   	}
>   
> +	if (madt->flags & ACPI_MADT_PCAT_COMPAT)
> +		legacy_pic_pcat_compat();
> +
>   	/* ACPI 6.3 and newer support the online capable bit. */
>   	if (acpi_gbl_FADT.header.revision > 6 ||
>   	    (acpi_gbl_FADT.header.revision == 6 &&
> --- a/arch/x86/kernel/i8259.c
> +++ b/arch/x86/kernel/i8259.c
> @@ -32,6 +32,7 @@
>    */
>   static void init_8259A(int auto_eoi);
>   
> +static bool pcat_compat __ro_after_init;
>   static int i8259A_auto_eoi;
>   DEFINE_RAW_SPINLOCK(i8259A_lock);
>   
> @@ -299,15 +300,32 @@ static void unmask_8259A(void)
>   
>   static int probe_8259A(void)
>   {
> +	unsigned char new_val, probe_val = ~(1 << PIC_CASCADE_IR);
>   	unsigned long flags;
> -	unsigned char probe_val = ~(1 << PIC_CASCADE_IR);
> -	unsigned char new_val;
> +
> +	/*
> +	 * If MADT has the PCAT_COMPAT flag set, then do not bother probing
> +	 * for the PIC. Some BIOSes leave the PIC uninitialized and probing
> +	 * fails.
> +	 *
> +	 * Right now this causes problems as quite some code depends on
> +	 * nr_legacy_irqs() > 0 or has_legacy_pic() == true. This is silly
> +	 * when the system has an IO/APIC because then PIC is not required
> +	 * at all, except for really old machines where the timer interrupt
> +	 * must be routed through the PIC. So just pretend that the PIC is
> +	 * there and let legacy_pic->init() initialize it for nothing.
> +	 *
> +	 * Alternatively this could just try to initialize the PIC and
> +	 * repeat the probe, but for cases where there is no PIC that's
> +	 * just pointless.
> +	 */
> +	if (pcat_compat)
> +		return nr_legacy_irqs();
> +
>   	/*
> -	 * Check to see if we have a PIC.
> -	 * Mask all except the cascade and read
> -	 * back the value we just wrote. If we don't
> -	 * have a PIC, we will read 0xff as opposed to the
> -	 * value we wrote.
> +	 * Check to see if we have a PIC.  Mask all except the cascade and
> +	 * read back the value we just wrote. If we don't have a PIC, we
> +	 * will read 0xff as opposed to the value we wrote.
>   	 */
>   	raw_spin_lock_irqsave(&i8259A_lock, flags);
>   
> @@ -429,5 +447,9 @@ static int __init i8259A_init_ops(void)
>   
>   	return 0;
>   }
> -
>   device_initcall(i8259A_init_ops);
> +
> +void __init legacy_pic_pcat_compat(void)
> +{
> +	pcat_compat = true;
> +}
> 

