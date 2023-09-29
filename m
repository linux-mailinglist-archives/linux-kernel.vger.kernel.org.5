Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0327B35E4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 16:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbjI2Oka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 10:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233085AbjI2Ok2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 10:40:28 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D991B7;
        Fri, 29 Sep 2023 07:40:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=noSLYqd+/Fxv4NEwVar0+yQP4uj/GTpZ/S0zKsCrA1mSR01mcsdJPYy+QWPxrOTdS/s73ocPan3jDko91BzywNbsuWOMm95JUOLb6aEYxTazBGorhsF3hvcvJfzPmi+SqnSZ3cKJTw4Y0esjuVnXA1CvlkSd2gw2tWGN6waXq0qJ1hYlAwqIUsR210yqR3+ISlPz/TJEJjl2aD00SoNHtdnwKEWltMBqW0HguQWlvcnymB+rt3inAS2VwZk0GyXKvVa/CFfd17mkIotmKZsV2OjEDVJbW966ufu0qMQYLToHRMBryDIwrIMKurh5WXT36p4pORkp8Xx9HxQ731G5Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8pbZoM1J4q4p1hHZkwaiqWDGVI6fTnKXw7W7UwwBZ3k=;
 b=Hf3OnizLf7nNAb3D2KIKRK/k1qwV0fYGH05870Sofe4VHhG5Ev3dbO2cnNWBaWqs4BqZR5Ty8Z8iH78el/c1X4/D1Cve4Pmzohiaz3+19SA8uW+ybBVfVQUShokciXnXN5tL6kDGcwsIvIB7SlHJABsgUhxZidIZAmZfHfStGFfhrPMi5ouvMiTX1xdQ0rmdMxgzOAAYnl8GIkV2/8o85wd8OSqXKw5VCBwL1UvA9xnbLZcUgBjr0T5RYtvw20SUfEaJhVetVg2TSIwOp16DKEmX0KiraBlMOfx6TUSE7BWkGZhklue+MP8c5tOR3BZBepQYozpV6fvE1980F0YnRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8pbZoM1J4q4p1hHZkwaiqWDGVI6fTnKXw7W7UwwBZ3k=;
 b=1lqG7M+bf4zm+1NygQZaEbKGbmiUN3Z9D7nnHyot2gV1YwshHmpan+g1j5V0mMHNBGFvw71c5raJINQ/m1INKY/fYEAbilzLm0LuvC5IgD30b2izwPVamjnGLwvTzNVHac7b2F9swTVZh+u3eVX39H1oX/vF6VfP85yaf0zloXI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by LV3PR12MB9439.namprd12.prod.outlook.com (2603:10b6:408:20e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Fri, 29 Sep
 2023 14:40:21 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::3043:e5d2:42f4:a231]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::3043:e5d2:42f4:a231%7]) with mapi id 15.20.6838.024; Fri, 29 Sep 2023
 14:40:21 +0000
Message-ID: <b88e1f4f-1e85-46ca-b317-d8e10fe894a3@amd.com>
Date:   Fri, 29 Sep 2023 10:40:19 -0400
User-Agent: Mozilla Thunderbird
Cc:     yazen.ghannam@amd.com, linux-kernel@vger.kernel.org,
        avadnaik@amd.com
Subject: Re: [PATCH] ACPI: APEI: Skip initialization of GHES_ASSIST structures
 for Machine Check Architecture
To:     Avadhut Naik <avadhut.naik@amd.com>, rafael@kernel.org,
        lenb@kernel.org, linux-acpi@vger.kernel.org
References: <20230928184204.1511111-1-avadhut.naik@amd.com>
Content-Language: en-US
From:   Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20230928184204.1511111-1-avadhut.naik@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN1PR13CA0018.namprd13.prod.outlook.com
 (2603:10b6:408:e2::23) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|LV3PR12MB9439:EE_
X-MS-Office365-Filtering-Correlation-Id: 28c6b9bf-78ea-4422-91d7-08dbc0fa024f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tnzminP1+y1k+tBtUAdELHHmg6mMRNOnsMyhfJcg+D0oW8dMGrzdMJ1AQzLLj3/aQsYB9weKf4hJBAUEkQnpyyu9dkJ8Lgvdfe3V8K+F3lm7PHkiK+pYjhEMCEKjhwSROMNQ8Mu8/T2p77sx0/+1lzujDJFBlUZ8/QjDvD7nIEvrnpgi+wbMCGJKPotejNZ5yiCD47uuhs1Q7M4zHR8n/up4tKsVyj+6uFTJJncXIZdu7ueoQdbIz4sRmUETYsogK3+zBbX6QFgvYyxMwJE0XdySPHCfcF4gKVFTBfRG5hi6keE4mGNRFrpE6rTcFNXNN/VvAlzI2vSBkN6COn5QqikR6WaVFWziOVs9+CkyOOaEESeHCVPjI1epbLUaMwRThoaaobyBrXCP0HhtjFA+LtzgHQU9KOZ5d9ZZwvybeEFhvoowCxlT8mA+Fbtmi8YXBeQ87Zhmid+iATWXxszJ0342x6I/W0JgNIkHePVco8r2iI1JGRFkh3HhijtrUUV2w+/w5rLxqIOhRDfWz5/Glph1/92Sz1BeU0eB9grokatzgb/m/7W6Q00JsS1qnYQzwU7MIyMFaRbeOXVcQoGQmy8oZLZdHsChIPdueVbvbnG/E663aiF9aQhkiK6IHKjQ9G+gxqhKt/rL9BwobTA42Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(366004)(39860400002)(396003)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(316002)(66476007)(66946007)(66556008)(4326008)(8936002)(8676002)(41300700001)(26005)(36756003)(2616005)(83380400001)(6486002)(478600001)(53546011)(6506007)(31696002)(6512007)(86362001)(38100700002)(2906002)(31686004)(5660300002)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUVheHc1QUM2LzRTUW1VMHhoZ0xQWmcrRkptQmU2MkJ5czhYRUl5MGJicDNh?=
 =?utf-8?B?VDBDNHVPcEZkbFFCOWE5NzZSSDNZNHE3bjRFUFBDSkhjcHZ4QStmb2lRNCty?=
 =?utf-8?B?SjlBRm5rSDEwU3d5emRIVWtvRUNoUVRqTG1wMzBKM2JZQTl3Mjg1WWhwTjR5?=
 =?utf-8?B?c2tGM0kzNWY2aXBmR0VSOUYvaWpiRTZETGtqektLTVc4YlZMcVBlM1VXbVVY?=
 =?utf-8?B?ajloaWlVVlc5OXYwNDRTNkRxQkdqS0FZenF4Mms2TWVxVlhuTmowVXYrQjFi?=
 =?utf-8?B?RHBPRWZNY1ByRkFOOE14RGZSNjNMRThoNmorcDZLYXBBSzQ4V1lnRG4wV0No?=
 =?utf-8?B?bFNvMnFHM0NOb0xNTmJxUlkycjhYcFY5MnU4Q0R2UnJsL05EWWpUWDYrQVEx?=
 =?utf-8?B?QmVKRm0vQWFqa0lXWjNEcnpDUFRrZmNXZzN3d2ZLSnBGaUtYckcyWmt6VEZy?=
 =?utf-8?B?VldBaWh6LzJSbWpqTnRUTmNGV0JZRDJFVUlGTDhGTmtiNk9raHg5T0NKOTh5?=
 =?utf-8?B?YVFIMkZWSmVjUGJFREpockdIckxkQ0FEUGkxdjZjSXMwdmlBKzZQZlRhbU1W?=
 =?utf-8?B?UHhHbE14RFplSzQzU0VSNjB3dmU5cXZ2Zlh3a3R0SElYN2c4U0NjM0xUejBm?=
 =?utf-8?B?VVFvbFRsczBvaElrblJMNWJXUUx1dGpodWFCaTRoSWMzUVduUEYzYklqZ0lS?=
 =?utf-8?B?LzArSU90U1A5dGFKbDRaNUdiSnFvVWZyK3VtUC9lanJGMnlMK3FVbFF1QmZ0?=
 =?utf-8?B?UWExczMvQ3JjdmR2SkFOMEtoOXozeVF3d1NSL2Jpa0lhTzY5VTVGZGtzeGRF?=
 =?utf-8?B?WnR6c1I0ZEhHMTFGS0c3bnpFTVFwMHZxcTY0amhZVm5qV214ODdjNkxQc0x1?=
 =?utf-8?B?WTduS3RJeVpWQ0xaYUE0bWRrTmkxMlZFdHg0LzdYYWdrWFl3VnQrYTM0c0pC?=
 =?utf-8?B?VHBnb0R3L0d4V3dsNFNLY01aYVV3Ykk4dUdjeG9sdmpDdER0VGVxcmtkTjJN?=
 =?utf-8?B?biszU3RSY0srUy9DV3RHTGFpU3FaWlE1UVV0UG5WYkNiTERGTDYxcTRZMEpZ?=
 =?utf-8?B?OWIxVWsxL202WVQ5aVpPblVGbmpxWXVKaXMvY1l2c0IzY0JnQTRmVHRoTytI?=
 =?utf-8?B?MDZpVmt3UXM2UnlxUkxyU1ZUSDY3eDNJbklEVm0wQ0tsaFNhbUcySTdPVUk0?=
 =?utf-8?B?eWc3MU9lUEtFNURWRmV6UXY2Ukt5NXg2b0dyWVB1eXhIeG1CTWZYeDVjcU9M?=
 =?utf-8?B?SE5XMkt5VDl3bGhvM0FHcGxYUWIwUXdqRXJyc1BEUnc0ZzJKRzQ3VStuUHlG?=
 =?utf-8?B?Q0ZNTmhmNW5wVVdZQjBXTGZRWUdyY25IYUFHbGtrQVR3TXBVWkViNHV1WmJF?=
 =?utf-8?B?Z2ZRTUpsNTNrY21GSnRkdFlINW1CYzFIanB0TUoxeTgxSGt1STdqcXBTcXEw?=
 =?utf-8?B?UFB4TUVjUjdSd3FVYmh6QURFU1BXcStkZ2NFK2MrVVNicnoyUWpJMlhyU2lj?=
 =?utf-8?B?MktHR1dHSHJHRlpMLzh4cjJjb0dVV0VWMW5SY1lMbGJCalRNeVdTVWI0V20y?=
 =?utf-8?B?VlRYRXpVV2wzWDFRUzhMc1V4aWZHNHFESVdiTlg4MlJDN04vMktaVm0wMGJK?=
 =?utf-8?B?NEVDV2MzNmhjM3VLRFhKSjJxYlVlNjVkTFU3bFQyS1lUZlZ6dUFCVUdJT3Bl?=
 =?utf-8?B?bFNDVWxkVDZMYW51MXJ3T0VyRmRDWnl1dUFudVpzL3pvSFZmSWdHTTNlUDNO?=
 =?utf-8?B?MnM2Sm05SGJ6VGZRbmRIZlRZK3ZyZjRVenZ0YlArQUpCQ3cxRkZ1WjBjVEpN?=
 =?utf-8?B?ZDNWZWlveVhsUVVKM0RtWmxXbWV1VW1IbDRlU1A5ZTl5dy9hbm4zTWQrakt4?=
 =?utf-8?B?MFV3WEdqZFdRMjNqalR2OE1idFRkOHc5Uzlkb3lMeXZsMlVHWHRLMlI2YURo?=
 =?utf-8?B?SzR2TUxQUGowdGRRUHgzeHJ3QlEvMFhlanZaOXgvaU5ndS9LL0xpV3ZHSXVE?=
 =?utf-8?B?SFZ4Wm1EaDVFUnNGVG9qb2JxeFRLMWtjcG81a05nQ3RzRzZEMUtQVWEzR05U?=
 =?utf-8?B?blJhNG9KcGJEaVRULzVwUE41WG5wUkVKSkRmaFpQbGF6SHluSy9HZ29vV2o0?=
 =?utf-8?Q?1GCsdtWPLFG5oyzCZ5P0wTxpc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28c6b9bf-78ea-4422-91d7-08dbc0fa024f
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 14:40:21.7909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EokJdzqeJobvjkxVpJRXJ/KRmWbdLY/fJ6gOrMjqT5vZmx573qTNSsb8OTitkcCVKPK+PsEhpaUper8wrBovdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9439
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/23 2:42 PM, Avadhut Naik wrote:
> To support GHES_ASSIST on Machine Check Architecture (MCA) error sources,
> a set of GHES structures is provided by the system firmware for each MCA
> error source. Each of these sets consists of a GHES structure for each MCA
> bank on each logical CPU, with all structures of a set sharing a common
> Related Source ID, equal to the Source ID of one of the MCA error source
> structures.[1] On SOCs with large core counts, this typically equates to
> tens of thousands of GHES_ASSIST structures for MCA under
> "/sys/bus/platform/drivers/GHES".
> 
> Support for GHES_ASSIST however, hasn't been implemented in the kernel. As
> such, the information provided through these structures is not consumed by
> Linux. Moreover, these GHES_ASSIST structures for MCA, which are supposed
> to provide supplemental information in context of an error reported by
> hardware, are setup as independent error sources by the kernel during HEST
> initialization.
> 
> Additionally, if the Type field of the Notification structure, associated
> with these GHES_ASSIST structures for MCA, is set to Polled, the kernel
> sets up a timer for each individual structure. The duration of the timer
> is derived from the Poll Interval field of the Notification structure. On
> SOCs with high core counts, this will result in tens of thousands of
> timers expiring periodically causing unnecessary preemptions and wastage
> of CPU cycles. The problem will particularly intensify if Poll Interval
> duration is not sufficiently high.
> 
> Since GHES_ASSIST support is not present in kernel, skip initialization
> of GHES_ASSIST structures for MCA to eliminate their performance impact.
> 
> [1] ACPI specification 6.5, section 18.7
> 
> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
> ---
>  drivers/acpi/apei/hest.c | 49 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
> 
> diff --git a/drivers/acpi/apei/hest.c b/drivers/acpi/apei/hest.c
> index 6aef1ee5e1bd..03cb0ece4235 100644
> --- a/drivers/acpi/apei/hest.c
> +++ b/drivers/acpi/apei/hest.c
> @@ -37,6 +37,20 @@ EXPORT_SYMBOL_GPL(hest_disable);
>  
>  static struct acpi_table_hest *__read_mostly hest_tab;
>  
> +/*
> + * Since GHES_ASSIST is not supported, skip initialization
> + * of GHES_ASSIST structures for MCA.
> + * During HEST parsing, detected MCA error sources are cached.
> + * Flags and Source Id fields from these cached values are
> + * then referred to determine if the encountered GHES_ASSIST
> + * structure should be initialized.
> + */
> +static struct {
> +	struct acpi_hest_ia_corrected *cmc;
> +	struct acpi_hest_ia_machine_check *mc;
> +	struct acpi_hest_ia_deferred_check *dmc;
> +} mces;
> +
>  static const int hest_esrc_len_tab[ACPI_HEST_TYPE_RESERVED] = {
>  	[ACPI_HEST_TYPE_IA32_CHECK] = -1,	/* need further calculation */
>  	[ACPI_HEST_TYPE_IA32_CORRECTED_CHECK] = -1,
> @@ -70,22 +84,53 @@ static int hest_esrc_len(struct acpi_hest_header *hest_hdr)
>  		cmc = (struct acpi_hest_ia_corrected *)hest_hdr;
>  		len = sizeof(*cmc) + cmc->num_hardware_banks *
>  			sizeof(struct acpi_hest_ia_error_bank);
> +		mces.cmc = cmc;
>  	} else if (hest_type == ACPI_HEST_TYPE_IA32_CHECK) {
>  		struct acpi_hest_ia_machine_check *mc;
>  		mc = (struct acpi_hest_ia_machine_check *)hest_hdr;
>  		len = sizeof(*mc) + mc->num_hardware_banks *
>  			sizeof(struct acpi_hest_ia_error_bank);
> +		mces.mc = mc;
>  	} else if (hest_type == ACPI_HEST_TYPE_IA32_DEFERRED_CHECK) {
>  		struct acpi_hest_ia_deferred_check *mc;
>  		mc = (struct acpi_hest_ia_deferred_check *)hest_hdr;
>  		len = sizeof(*mc) + mc->num_hardware_banks *
>  			sizeof(struct acpi_hest_ia_error_bank);
> +		mces.dmc = mc;
>  	}
>  	BUG_ON(len == -1);
>  
>  	return len;
>  };
>  
> +/* GHES and GHESv2 structures share the same format, starting from

Please follow the general kernel multi-line comment style here.

> + * Source Id and ending in Error Status Block Length (inclusive).
> + */
> +static bool is_ghes_assist_struct(struct acpi_hest_header *hest_hdr)
> +{
> +	struct acpi_hest_generic *ghes;
> +	u16 related_source_id;
> +
> +	if (hest_hdr->type != ACPI_HEST_TYPE_GENERIC_ERROR &&
> +	    hest_hdr->type != ACPI_HEST_TYPE_GENERIC_ERROR_V2)
> +		return false;
> +
> +	ghes = (struct acpi_hest_generic *)hest_hdr;
> +	related_source_id = ghes->related_source_id;
> +
> +	if (mces.cmc && mces.cmc->flags & ACPI_HEST_GHES_ASSIST &&
> +	    related_source_id == mces.cmc->header.source_id)

IMO, there should be parentheses around statements with multiple terms
to improve clarity.

	if (mces.cmc && (mces.cmc->flags & ACPI_HEST_GHES_ASSIST) &&
	    (related_source_id == mces.cmc->header.source_id))

> +		return true;
> +	else if (mces.dmc && mces.dmc->flags & ACPI_HEST_GHES_ASSIST &&

The "else" is not needed, because of the return.

IOW, use "else if" when you want to skip a check if the previous "if"
was true. Here the check is already skipped if the previous "if" was
true and did a return.

Also, the order of the types is "cmc, mc, dmc" in the struct definition
and hest_esrc_len(). But here it is "cmc, dmc, mc". This is just a minor
nit about consistency in ordering.

> +		 related_source_id == mces.dmc->header.source_id)
> +		return true;
> +	else if (mces.mc && mces.mc->flags & ACPI_HEST_GHES_ASSIST &&
> +		 related_source_id == mces.mc->header.source_id)
> +		return true;
> +
> +	return false;
> +}
> +
>  typedef int (*apei_hest_func_t)(struct acpi_hest_header *hest_hdr, void *data);
>  
>  static int apei_hest_parse(apei_hest_func_t func, void *data)
> @@ -113,6 +158,10 @@ static int apei_hest_parse(apei_hest_func_t func, void *data)
>  				hest_hdr->source_id);
>  			return -EINVAL;
>  		}

Newline here please.

> +		if (is_ghes_assist_struct(hest_hdr)) {
> +			hest_hdr = (void *)hest_hdr + len;
> +			continue;
> +		}
>  
>  		rc = func(hest_hdr, data);
>  		if (rc)

Besides the minor formatting comments, this looks good to me.

Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>

Thanks,
Yazen
