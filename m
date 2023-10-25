Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBF597D7794
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 00:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbjJYWHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 18:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjJYWHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 18:07:03 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2061.outbound.protection.outlook.com [40.107.95.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0F4137;
        Wed, 25 Oct 2023 15:07:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XSgy4Q9yW/Lv7I6IyA5gbpJPd3L56SWbc0KlRyiwDaKOy9GnNef8A/RSMDDSfWLtPYB5ukBBqNooLwhCXH+KLcGH2hnM3eKg8lNt7mFWkez1AlNW9NhzHEK8b8CIi6lVnCQFWqrBBkYB+EPd7EGDAkimI7I14wDHXxqAILM1qtol1tUWeL89bVLo5no1ZxqGhL2yTmYmX/Xwu349V/gGVnqLpvaX96Ixv7Knl/+T1SZ83U9bwVAC38ar74VgVvV5u15OLZo60mBMKkZiInZrxxapNdNIwjKk7AbntRg1/0CzNHHm78Gak7Bm3OwpzQ57l4tHFLLBuUYOrcXgx8pxiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RR8771V5HUxx4mB7f8enPjM0fciwsZRBQcub5cleT4g=;
 b=TGeChJDlKVwXpKrPNKbNOtcdEDoHIq1tnklUNmv4jHFzXolO76jgbKAwV9swxInVEvDLHeDfaZwogTm7zgl/5Hq6C1hs/ekPLxRFpCiEbdI2aL+5yNm+5q7ubNApy8lFYY0EXm2lBS+63u56ZAHvbEGyyVpAwz4Gbxv1VpbvqjZWH1l/4Y+u7JmphEfUQ3FdlOK3sDjeKMGoq6ZdP5KfD1yqSszdym1TvBoL7H4rBToojnZsVVnFyD+lRxeur8aLsIAokLbmrmc4kOZHNdeG2Xgq1bDE76Cru0za+sPOKc4M+JnPDHd4yenUCcfVEnEMQmsW0mSuaxcUuAQQtC61fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RR8771V5HUxx4mB7f8enPjM0fciwsZRBQcub5cleT4g=;
 b=DHT19dt0wrYdk2GDmDxW1OS1L0vS1ueWQJyMS1K0U3P+5LOosT4F1JXBP0zCnwA3klLgNgkL89BYwjiVX+bc4rN09s4RGXjPl5hlKd+a60Ln0hJHmWEJD5XNfmqQYCtVuVo2iLgCPYvDBCDcMTvfYNCoV/C/eTK6UJmnVfK6SCY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM4PR12MB6542.namprd12.prod.outlook.com (2603:10b6:8:89::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.26; Wed, 25 Oct 2023 22:06:58 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%4]) with mapi id 15.20.6907.022; Wed, 25 Oct 2023
 22:06:58 +0000
Message-ID: <4f6181c8-07f1-471e-a186-6a129a2f0b2b@amd.com>
Date:   Wed, 25 Oct 2023 17:06:56 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: Add s2idle quirk for more Lenovo laptops
Content-Language: en-US
To:     David Lazar <dlazar@gmail.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Pearson <mpearson-lenovo@squebb.ca>
References: <ZTlsyOaFucF2pWrL@localhost>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <ZTlsyOaFucF2pWrL@localhost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0002.namprd05.prod.outlook.com
 (2603:10b6:803:40::15) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM4PR12MB6542:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e17a30f-4f62-4b63-83d3-08dbd5a6b541
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XiGnh5ARERIMPDt1EEkT0YA94irX3w8WBX9EJ2IL89JF+3Xeiog03G/HlyxHpHWFoMgvKU07sR4K3Fapbk6wCh5slBZo8KqDolynsKgFO7fm60gRaKySy7RARvDehxWRw4EX+itMq4WfkkKHNmcQ5/KV/6HA8pAmlEkV/GkEUTTp69qTmlpmneAXKmP5c1oEaiKMMtEv46DmHEaLQOtiCYbzhXx6n1mro/1dqzuKvhyP+qq1QeLrKxmCw6vminuzpeNN+qC01Ek5dqfiKMOLFCP2TjmpL6UOlS+ra8HTVeI1HTzSZ/8lRPwA18R2DOyS+yMgDDbzriWHXmedtPCOff6ovww2ibeEBnhsFPVicbaH4MBZGBpU5fMW0U9b9qB/9+/9l6PetLEmGpniujy56rpLimlfoSPjb5LN51h8KBxQVFqn0l/yLwbU/ZaokreHirfGD2aPOEP7m3hDjUuph+1MJIi2kN8X83IMMdIl1/09oGlqYFgXG2TYXkgYzGmGLR8/x0b2/2sn+k6f93Gefhj+9vTq8fNeSy34gYmWyFBzXN4AV3xrNI7UojgwdNUS/AlOdLCuy77HxCqVkCDrJkspwja8JtROHNERQ7HwhFnqgWGnTVRTY4GwuhcRzuRGU5cvaHREyywWyX2ASb6ntkVlcmtgd84g6kjvh2MxbSM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(136003)(366004)(39860400002)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(36756003)(31686004)(110136005)(66476007)(66946007)(2616005)(316002)(66556008)(31696002)(38100700002)(86362001)(6512007)(83380400001)(2906002)(26005)(6506007)(966005)(8936002)(6486002)(53546011)(44832011)(41300700001)(4326008)(478600001)(8676002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGhDcTluUnp1K3JORjZlQUQ5bDRQMDF5aGc1S2JidjNkcUZRb3lrei9EOGFY?=
 =?utf-8?B?MzROQXZrdlRLbnc5OXVvUWNNeGVtN0tpaUE1V29ONDV1S0wxdDFsTmZkOUtl?=
 =?utf-8?B?N3hhbXhiY0xJc1Z4NytCOXZMbE02QkhERVh6KzJqTE5PakdOVVpQUGZjbTVG?=
 =?utf-8?B?cVFoZWpUWFNtUENaODNBRGwveEdxL3NxVm9YSW9PUUtnMWI5d0tLVXlNRTFt?=
 =?utf-8?B?cHdzK0h2WlRWUGJyZUk2TzlDY2RBdFZzbzhLd2VIUWp2Vk5SWmRWdzFrM3Fj?=
 =?utf-8?B?cmJvVERJY1RkOStsQmpWMm0xUXdxUU12cEFHY0U2RXk5Mm9Ed3EwcWxBZGhy?=
 =?utf-8?B?VlZRQU9EdXdPR28waWlrcHdZV2o1MFpwTTV4REJ3bHV0aE95MU9vbFR6MTVL?=
 =?utf-8?B?VlpFcExmMGRmRy90ZVhKR243VDllbGhIWTFGSlVETDVvdWdCQ3lrckdXbisx?=
 =?utf-8?B?N3puZlk2ZUtoemVWMS80cm1HVkR3Q05GZFg0aDFzMFJldE80RXFLWnc2VFdO?=
 =?utf-8?B?Mng1c25Kcmt3T0xNNFF2UUV3eEdDeGF0N2dUSHRzZEluZ2NDQWhISElRZmRq?=
 =?utf-8?B?Vnk5NjlaYTNPNXliNWNKZ3lyZ3dzR0c1N3p5VUZ1YTJPeVRaUGU0L2tWa2gr?=
 =?utf-8?B?UkZsempORmw4aExlZnhQcjlIdmNGMGF4US9nMitlaHlneHVOVklvaG9OYm5B?=
 =?utf-8?B?dFZxdGxWL3NZMUpjYUNhQXEycmV6Qm5KbURsR3FpU0pYRkpMOHM5V2ZSclM4?=
 =?utf-8?B?dWVFZTlrS2VDMWVCZmF4M2pVYlNLcTFobzQ5eTBZYWh3RkNSSzNycXVyeElt?=
 =?utf-8?B?SXczbG5hT3cyUWZJblUzV0FjZ09VOGMvUXdUZWdYUUJia2x5Z1BKdjhmSGo4?=
 =?utf-8?B?YkNBSlhYU0JDMWY4VFJuTmthT1BUTlR1UUZrTDAxc2lUcCtvTWhIUEdoL0tr?=
 =?utf-8?B?ZHNpLzAxV1IvMVUvdnVkblpaUDR4bTI0elRuUEptK3RoLzFUMnU2bWhBNUZQ?=
 =?utf-8?B?YzZkd3ZsQXZ6TnZSdnFrNzF6OVp6MVJzbTJTTVhZMWQ4QU1wTnRDVXdIMnlp?=
 =?utf-8?B?ZG1oTFpVVmR1YU9XMGI2Y1RlU3lCTDc4S1RBNlhkQ2ZnTDVPb0U4YTEwMVBV?=
 =?utf-8?B?Q1pWam83T2M3S0xwU3hBR2taUkc0UWszZTJxeWlkRTdacGk2SVA2VW41am9o?=
 =?utf-8?B?cTdNa3pjT2dPcmVzZHR5YnJ6ZmZVZzQ0K09mdEVUL2JjSGV0R2R6dnJTN1FH?=
 =?utf-8?B?SURya0ZTc1htYmFHdnJBdEpVQlNzc2FOQzJXVjV1bUg2b3piNTFoOTEvN0No?=
 =?utf-8?B?enVFRENHZVhwUnFoNGdEZnRRR3BGdnFqNHVrN1F5Si9zUDh2bDUycGEyYm9M?=
 =?utf-8?B?RXphRVpjOGdYL2lLL2hTVDBPeU5kckFQU1p2ZFBjZmVUTFJuYW5kS0trRmJp?=
 =?utf-8?B?dFZvaXdVRkV5Ykg1OFBUSExUR1FjWHAvMkFUVFJqY1ZVa0k5cHV1cGNCOW9F?=
 =?utf-8?B?a2NDYTVxYWtqSERJVHZZRXVEL0dKOHZEdkp3OVdzc2lVamRia0VjV1BRRmJu?=
 =?utf-8?B?TFdIcGNmc3J5Sk4ycGdPd1I0QnBrdUMvNDRSdVdIaThGdHI5K0ZYdU1reFpt?=
 =?utf-8?B?c0Z5a1VOWFNwZVFyTFByOE9DRytYbnVqTUo2NGtNZWoxWEZsL0o0eUlXYUxY?=
 =?utf-8?B?UDVEemNoNmd4bXJLamtiUHFReTh4Y25iMFRsUzMxaG13RjhrSC8yNXdtS2Jr?=
 =?utf-8?B?YUxncFhoeGoxeUc4ZUkzTmhYZTVHcm5xVXNjeXUwTzJwNzEvU3FneGFqYTE1?=
 =?utf-8?B?WnYyQXZacm9XTFpCUFBHbzhFbWVOOHRXTWxjN05iSDd6V1hGb3V4bXVWZnRQ?=
 =?utf-8?B?bGdlK2NrOFJrQ2c2d1IyZ2lmT3JueGpFZzdCb1VrMWI4bWFlQzAxenBrUGJX?=
 =?utf-8?B?YW5nd1M3ZG9HSSs5cTE3Z09RL2lyNFRjYWlUbFhHalZKRDVUNkRNUGowQjQ4?=
 =?utf-8?B?TlZDSC81bGNZbXU5QnBDQjBHRW9WZlpNZEJRcmNqYzVoMEZiOHJ2SjFseE9l?=
 =?utf-8?B?SmJka29CWGE2RTNtN2xPd3NxUW4xejRaWWd3Mi82ajJKUEk3Y005eXVsamR1?=
 =?utf-8?Q?IAr/TcwqV/s8M+F0vYCj8KJko?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e17a30f-4f62-4b63-83d3-08dbd5a6b541
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 22:06:58.7911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cWne7krd6HcUVjJIUu3jKMpuQvLG13s6tHawHtwcsCMGtgPvnMoiNU8Kc8q4WJmu8aKw4BqBxnUboVdeEB34Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6542
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/2023 14:30, David Lazar wrote:
> When suspending to idle and resuming on some Lenovo laptops using the
> Mendocino APU, multiple NVME IOMMU page faults occur, showing up in
> dmesg as repeated errors:
> 
> nvme 0000:01:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x000b
> address=0xb6674000 flags=0x0000]
> 
> The system is unstable afterwards.
> 
> Applying the s2idle quirk introduced by commit 455cd867b85b5
> ("platform/x86: thinkpad_acpi: Add a s2idle resume quirk for a number of
> laptops") allows these systems to work with the IOMMU enabled and s2idle
> resume to work.
> 
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218024
> Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
> Suggested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Signed-off-by: David Lazar <dlazar@gmail.com>
> ---

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

>   drivers/platform/x86/amd/pmc/pmc-quirks.c | 73 +++++++++++++++++++++++
>   1 file changed, 73 insertions(+)
> 
> diff --git a/drivers/platform/x86/amd/pmc/pmc-quirks.c b/drivers/platform/x86/amd/pmc/pmc-quirks.c
> index ad702463a65d..6bbffb081053 100644
> --- a/drivers/platform/x86/amd/pmc/pmc-quirks.c
> +++ b/drivers/platform/x86/amd/pmc/pmc-quirks.c
> @@ -111,6 +111,79 @@ static const struct dmi_system_id fwbug_list[] = {
>   			DMI_MATCH(DMI_PRODUCT_NAME, "21A1"),
>   		}
>   	},
> +	/* https://bugzilla.kernel.org/show_bug.cgi?id=218024 */
> +	{
> +		.ident = "V14 G4 AMN",
> +		.driver_data = &quirk_s2idle_bug,
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "82YT"),
> +		}
> +	},
> +	{
> +		.ident = "V14 G4 AMN",
> +		.driver_data = &quirk_s2idle_bug,
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "83GE"),
> +		}
> +	},
> +	{
> +		.ident = "V15 G4 AMN",
> +		.driver_data = &quirk_s2idle_bug,
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "82YU"),
> +		}
> +	},
> +	{
> +		.ident = "V15 G4 AMN",
> +		.driver_data = &quirk_s2idle_bug,
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "83CQ"),
> +		}
> +	},
> +	{
> +		.ident = "IdeaPad 1 14AMN7",
> +		.driver_data = &quirk_s2idle_bug,
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "82VF"),
> +		}
> +	},
> +	{
> +		.ident = "IdeaPad 1 15AMN7",
> +		.driver_data = &quirk_s2idle_bug,
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "82VG"),
> +		}
> +	},
> +	{
> +		.ident = "IdeaPad 1 15AMN7",
> +		.driver_data = &quirk_s2idle_bug,
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "82X5"),
> +		}
> +	},
> +	{
> +		.ident = "IdeaPad Slim 3 14AMN8",
> +		.driver_data = &quirk_s2idle_bug,
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "82XN"),
> +		}
> +	},
> +	{
> +		.ident = "IdeaPad Slim 3 15AMN8",
> +		.driver_data = &quirk_s2idle_bug,
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "82XQ"),
> +		}
> +	},
>   	/* https://gitlab.freedesktop.org/drm/amd/-/issues/2684 */
>   	{
>   		.ident = "HP Laptop 15s-eq2xxx",

