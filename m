Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F15A7D3803
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 15:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbjJWN1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 09:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbjJWN1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 09:27:40 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0809510C3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 06:27:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MOJEc/LqU2pH5meoNDXLt0v+/1HjiFg05xpF66+kRhhdUAHwxjWYyhG3YIe41Er343dElI0IZVusDCsxhnsWxwCVQzFLfZnF9kWgIjJFl/lf0r9Fm8kxrDSjp+ryBbbV1EjJn3e71EgdAZQJBFcFD+8uJ5g7+VQN8LhH0RCy65jfhp3xCk1gbbhZArPMZMQpsJRWVhYKIbtfm0y2hW6cYRd7gVrB9OD4COMuW2QWoGrsMRD5xaS10c9fqQI7ZaV7iSOMUVYQlCwn0DplFBRrseotmAjPbdCwXrZYnoAWHz0QUmp3SqcTjJOAZCpqtO1bEkicsrqEETRlD1gHHEoV2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m/cQGtvctcgUvRfVlC41aH24sK8DNdg13HSLJWdlRI8=;
 b=P8RFdv5qwfv71au/t+hPq7KEnCR890uumiQG2mXV8QmNPYDkU4HNK3a7X0Pfa7J6LXbW0/B4wBaO6olabI7+/VZGHq7ritRG2+D+sJ0XjZU134AY7kAHr3Cvzf5E5VMFQJpay0iJjj1zL/P55NZS3kAqLCPZ7WmiG1ftjALIEyS4q+igYE+yfQRciUBUHAL783eo9t0VKnvSHbOaGy7yfZIbEIW2AfKlygX/MfsU12Y2UlZD+J4sSgK9lsQa81wGG9KCUppE4J/GPHUNux0Q5jOQE+K6oiNSprJey43Ym9B4qbgX8Yytrt1sZGUt3eTTOKH1yC1H71Kf+lGg3qJO+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m/cQGtvctcgUvRfVlC41aH24sK8DNdg13HSLJWdlRI8=;
 b=dZkF6cmXnhOuM+2u/Mwo287XKC7evFalQmYrWx1xpbPrniej9f64jRZs0uNi6gWsAQuAOdogmxaTjuIxIWCFz3QKasvsX/SNBr4GtfBGYzWrvfGl7vBUeg9bL/dfV9u0Dnn6oRDCIQT1NXVXZXuc1C9iYI50OZVsS8s1nc8RrKk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CY8PR12MB8215.namprd12.prod.outlook.com (2603:10b6:930:77::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Mon, 23 Oct
 2023 13:27:00 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%4]) with mapi id 15.20.6907.022; Mon, 23 Oct 2023
 13:27:00 +0000
Message-ID: <89a51be4-38f9-4a9e-85fb-52c48a8fd433@amd.com>
Date:   Mon, 23 Oct 2023 08:26:58 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] x86/apic: Allow reprogramming IOAPIC pins the first
 time for non-legacy IRQs
Content-Language: en-US
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com
Cc:     x86@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
        dlazar@gmail.com, hdegoede@redhat.com
References: <20231020033806.88063-1-mario.limonciello@amd.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20231020033806.88063-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR18CA0001.namprd18.prod.outlook.com
 (2603:10b6:806:f3::15) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CY8PR12MB8215:EE_
X-MS-Office365-Filtering-Correlation-Id: 3543b702-dd57-417b-856b-08dbd3cbbcf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8R6vUgV/X2Im6DB+lz84zRe8t4fqemKelzhjp3t+4FUHF35BXv1xz22Yz+PvDFICPPnjAu2ddW1HweY4l+xMLl+LJur/z5qp7PUYbuDJsOM5le7wHTsMaxODctTPaOKGmeyeJL10bc5t9u6W9H0MF9u36LW3khXvSilJ1aioTi5fKCF8xDkpmUlK+q8tamHDWa8RubhPelFQ721mEpI02Kk1LsXdew43z5xZ+Ggf0w+SpRTg0dpqv8SH1wJ8YWDMl7aJzJL7bWV7OYvXvNWA+2trhIWyDDhGK87K+EnbmXGbPYXGQS86tsPGgSu6VPtf0jzke9Xb9CZDVHuDheQ/Ny+kCAEpWgzn5hgTzzD5w7DulVo8DIUmMDJYk3LHYI6+WMeZLWle4Eqwii1RsmGCKy2oTgmAP1xZgljT72WpLXmzuDH3mh5yzbehVuiHP6Yexkkp3cnJdeMs34h6n9XcLGCqUMrPvP/H7CRNZhHGPyU0hk1ucoGv/O80gPSGiigypsG+7XE38DoduhzikZlzx1glljfphTh87DUd7QzFcNB0njPHKtw8YFqqHbrEUHz+53csVDyDYXqdFH3PObUVGe1qXAs8CcRU9uLagvi5mNTdqzAduCMZnp5T7czc+JUhbny5Om+OmTPapNKdyx+w0w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(376002)(366004)(39860400002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(26005)(31686004)(38100700002)(2906002)(41300700001)(86362001)(31696002)(5660300002)(36756003)(4326008)(8676002)(8936002)(2616005)(6506007)(478600001)(66476007)(66556008)(316002)(66946007)(83380400001)(44832011)(6486002)(966005)(53546011)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tnc1cXVJeWY3MEo1a2YveWd5b0Vld3JNN01tc0JlaW9leE9DM1lxN3k2VkZl?=
 =?utf-8?B?K0xyN3Z1bWFBcitUczVlajRzTVhLc3Y5ZndCOFBBL0VzYlV3RE40dmcrb055?=
 =?utf-8?B?aFJTZGV1YnJUWUhhQXpoSm8xMTdTZzQ5U2tCeUFlSGxuKzRTTkJKRXJKbHlT?=
 =?utf-8?B?RURURkY3VHUzZFRXY3cyWlg2RnBXNEo2dDNjS1d0T2plS2lpbjAycFY2cm9H?=
 =?utf-8?B?eGVzOUE1WS9oVEtnUDZCK0NqTFVJUWlTUnZjcFlVVUFjVnl0cHhlc0Y3K1Jp?=
 =?utf-8?B?aWowRkJIZTJzai9UNXhsY2ZDTWFvSVZTc1JLSGV5djNzTXViNWxSMHJKRGdR?=
 =?utf-8?B?NFlvN3crR05MNUgrUzRMMU52SENldDl6UXlTcEs1UTNhRUNyWkw4eVVzVTI4?=
 =?utf-8?B?QjgrMzFxV0NFRHpFQzQ3SXBpTkJ0UVVLcTJQOXdNOFZjTWkxKzRmQk1LMW9C?=
 =?utf-8?B?ZVJmc3MwTTNkSFdyVVVlOVJuVDdNREhXSGhKb0hCZUdhLzhiM1U5cW9Cbkp6?=
 =?utf-8?B?cjRjTmYxZDIrRFJoN3NuU3J1Uk05U043SGsrZVNBckJlN0NCYXJxS0xWUFBl?=
 =?utf-8?B?SGdKRDZWUkxKaVJTVFgzVUV6Z3VrM2REQmRhMVBYUUhzNTdYdjNISkl0NTlu?=
 =?utf-8?B?N2FMUHZXWmV1UXpGaDZjaUNNTmxFVCtRQTgrRXRmSkJVTTVIckhVTExadkNv?=
 =?utf-8?B?MS9EKzFKa1lRdUZ0ZzBRWVB6WTZFaXJTQytwbjA5UVNYaFdaZmQ4RkhGN3BR?=
 =?utf-8?B?aW5nNmVxQk15K3U2cGpyaW5OanJpajlFbEQrZi9ZbGhYcm5oaGNBbmxTTkdQ?=
 =?utf-8?B?UFBuK2FRY0dZMkpYQ2F5QTIvTVhmMEZXSExFa2hkcVUrazh2QjI5b0ExYkpT?=
 =?utf-8?B?cGtxNVV3WWJ5WTUrT3AyR2t0ZkhsQUVUVFplOFZzck5HMzRlcU5scXQxcTl1?=
 =?utf-8?B?SGdYZi95TSt0MXdzR3h0STRLSUMyVlhBUkwzd3VvYzc4aVl2OWhBN3VVaUIx?=
 =?utf-8?B?d2VxaWlnakM0NjNRMjd5TXRiNVEzSy9KOW9HeUtkcjM4clMwRjEvN0p2TjVX?=
 =?utf-8?B?ODRPSThqVVU2THc0QmVXY3QvRHBDVmxVaWNZamhVc1VPRUlNOGY0ckJBUkdl?=
 =?utf-8?B?TjBBTStUbHVlMU5JZWZVZXlEc01GTDNRbWdDL08yaFZnTFE2dWU3WmZ0ZFlZ?=
 =?utf-8?B?ZkJ1VnhLY0hxODhZUm5aL2F3U1IxZ1ZpaUcyNGp6R3QwcFY2RlF4WHROdURp?=
 =?utf-8?B?MGFGSVVPc0NyRHB3aENMT0FZeFk0em1taU56ZTlGYTNpMG01VVZ0NmlTTzBy?=
 =?utf-8?B?QVV1VDNUbW0rRFF6WHIyeHA2MDlHQWZaeW8rWi9QL3VTbis0Z1JCUUtINGJO?=
 =?utf-8?B?QkNYUlhNTzI2eTZuZjdQeDJmakJ2aSswcVliRVR1UVJRY3JKZXA5bTRHanpG?=
 =?utf-8?B?TDR5akR0QlZsK29TOWw0eG1RcFdlWVVwRUdLZWFLcDFTTTE4YWJTMHc1YjNj?=
 =?utf-8?B?ZWEzNmlMdnpHYk5Uek8wMFpJdlgyOFpyU2lxYjg2b2pJQUdaWWFvVU9CNy9j?=
 =?utf-8?B?VlB3R3VVWThRUzZwbVpkTzM0cTU3czRjYlozcWczbjBha2J3L20vOTN2dkJS?=
 =?utf-8?B?SWp2Mk1qQzNsZDV1QkNOalJ1MjJ3QkRTM0oxZUNyYWFZMkNoNXp4UzlkMW1T?=
 =?utf-8?B?OWdhWXpRWlVaK2lMc084ZkxKYmdac21ZTlh5ejUzNm5YMHV2eTQwRi8xVTB4?=
 =?utf-8?B?dE1BakVsWFJaOEdvSzlma2lxcHpMdXlqZlVqZ3J5aHd6SFFic2tuaFZEYTM1?=
 =?utf-8?B?Q1hMalQ1WVY1UUFmUXBhS09yMjhsRWhBRU5oVkFZWGlTakNWVWNBMWdVeFRo?=
 =?utf-8?B?NytGMnkzYjlYVEhoUEIvMW5SQ0RvWk9US3Uxd1dwU2pOYzdmdVpuYlV1aFNG?=
 =?utf-8?B?K3EwSFV2OW1ESTRIQURoQ3YrbTNZcm50Z3diRnk2ZWhjbjZsN0tJQysxenZE?=
 =?utf-8?B?OFdIdlBuVUtHZXo4Y21uZW5kNm1BSGhXdFQvcTdFVkFMV2trOERMNGVHSjFG?=
 =?utf-8?B?UU13Wjk0SGtzT21rY2RGeHllN3lHZlBERDhWeW5HSTV3cEZyVzlvY1BMK21V?=
 =?utf-8?Q?R7aawDLzL068MWmNzCo3gNmfr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3543b702-dd57-417b-856b-08dbd3cbbcf1
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 13:27:00.7601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6tLEPbUI7bbpni76rd1bf9N2rBSsjVOn7qaICciSQOi+Lqwn3QDA1sMpDgHLZEYp6Ia+k9Aa/r5EAwnfHTZv5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8215
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/19/2023 22:38, Mario Limonciello wrote:
> If the system is set up without legacy IRQs configured
> acpi_register_gsi_ioapic() still needs to be able to program the IOAPIC
> to match the values from _CRS which might not match what is already
> programmed to the IOAPIC.
> 
> Reported-by: dlazar@gmail.com
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218003
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   arch/x86/kernel/apic/io_apic.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
> index 00da6cf6b07d..27dd279dcc7b 100644
> --- a/arch/x86/kernel/apic/io_apic.c
> +++ b/arch/x86/kernel/apic/io_apic.c
> @@ -928,12 +928,8 @@ static bool mp_check_pin_attr(int irq, struct irq_alloc_info *info)
>   {
>   	struct mp_chip_data *data = irq_get_chip_data(irq);
>   
> -	/*
> -	 * setup_IO_APIC_irqs() programs all legacy IRQs with default trigger
> -	 * and polarity attributes. So allow the first user to reprogram the
> -	 * pin with real trigger and polarity attributes.
> -	 */
> -	if (irq < nr_legacy_irqs() && data->count == 1) {
> +	/* allow the first user to reprogram the pin with real trigger and polarity */
> +	if (data->count == 1) {
>   		if (info->ioapic.is_level != data->is_level)
>   			mp_register_handler(irq, info->ioapic.is_level);
>   		data->entry.is_level = data->is_level = info->ioapic.is_level;

David mentioned it on the Bugzilla, but for the benefit of those not 
looking there, this series is confirmed to fix the problem.
