Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC6AA7B5440
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 15:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237501AbjJBNrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 09:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237495AbjJBNra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 09:47:30 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2081.outbound.protection.outlook.com [40.107.101.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C60B7;
        Mon,  2 Oct 2023 06:47:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Orj40+mc9Q8rZsLXAaEQYuCfZ1jimUnctzFTq7j3OdqxCbNvwXuJy4CW4v2iHg+TrkvaC/Otim8j6PpXLbakFJWptCY4XgNkt1a8wflVmjmdE3Qqe+7tuxPgTP0h3D7AJm2Bx7JTDfTTqXM9uwR8G+9e+35zkEttlGNacGr7FHSShHlEefsVgvvfnHTeZwxmPv0kDGa7QBxmw7uv4B4I/gCJI67YBwYH+C4KFgUawo3IYPE5OZT+ukHpq9CpVwj8AApbg5vXJ8WiPbwLia6AaBQt3Z6MQwu+AMtw+54nv6nZQwtgtYAlwY3zgBIyOlAkNlKTk3yF7LXMPbiwd9Yodw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NjfcfwP7o9AZWhDq73lUO1V/1i2L8La70slx70gFnoE=;
 b=eh/fE2UCYWcjmu6+qp1c0QfRdYJTECq447KZ4+ujVuQWta74IRlDJT3ps5ub5m2WbE4qd5lAz9NC9Wy8sBOe8Bhp8K7XG8aHLKuSpy8sUjBx3CdERniEJU8qNWi/JsJwtVJe+RtBz3AJAhEy3G2L7vkU7FLXMJ+2Tn81r6QYaHBIsbDTyY7Ixl8x3d0bP8KnRnkHmQrd6p+konqlFYkoLf5rUxC1IdgNHPdWBsBZ9u3sA2E1W7c7LO5YyPfS8jbD7iZ1R5MHYLLmDlNnFlRRii8byhZVVr+mDW3Nu5n3iGwcH1u4TRhs4b0wWilVw50uLlx6c14WNxC+HDqasFABmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NjfcfwP7o9AZWhDq73lUO1V/1i2L8La70slx70gFnoE=;
 b=tiQ74cYRonJZpVLbyrzw5wX5LCfNZpRbKfVUjQNBgoUqtNky7tSPetq6pcBxcXTYwvDA3/9Tb3Xrno6JLHwZvEOG2E0PBM78X928DKuh2sMmENV7jkrtKsH8U7iQfa9ZLlf6gu3wAz7qGbFFG9BctIcvFqfk+/ROXQrWZz+UHvI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Mon, 2 Oct
 2023 13:47:24 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4%3]) with mapi id 15.20.6838.028; Mon, 2 Oct 2023
 13:47:24 +0000
Message-ID: <0a3feafc-b843-420a-9b04-c835f8210c1a@amd.com>
Date:   Mon, 2 Oct 2023 08:47:21 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] ASoC: amd: yc: Fix non-functional mic on Lenovo 82YM
To:     Mark Brown <broonie@kernel.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Sven Frotscher <sven.frotscher@gmail.com>, git@augustwikerfors.se,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>
References: <20230927223758.18870-1-sven.frotscher@gmail.com>
 <46560887-0b6e-42ac-96c3-b4dbc1d7cb61@leemhuis.info>
 <4fa7d39d-dc34-4550-97fa-2b089f364cca@sirena.org.uk>
Content-Language: en-US
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <4fa7d39d-dc34-4550-97fa-2b089f364cca@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0099.namprd13.prod.outlook.com
 (2603:10b6:806:24::14) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MW4PR12MB5667:EE_
X-MS-Office365-Filtering-Correlation-Id: f550d5fa-b0d1-4619-2cd6-08dbc34e1bda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7cR67oG+Ti6EwHm133HGvusFuYq64WoWypkCHTA4u5yuFsUBzbm+ka7JiwXuIyJAovPH9RVXVnWPIg9hTReeUGXw5C20QrPn0IhhrZVGb66T1JpIqcx646mN03bwC41EaaiDzrV+s3KUkqAh98gasq9pcTU+gS6LS3h1AkyaDdIp34EsQQ6ub2Sv20Qhd8TBKwQthJFMmQv/V23I2cwKid3F3McenxpOsKxuihq+w8HYriNTAJs15vmlV/gaizfzDAcY2Kyuu3zH6q+oy0qH0hiXjhEChls6Mu14pRaZauy6R2jNcETU8VUuKoZdE88bvAQ1OxqlJWZtr7vSMOtZSNeGdtCjlylRRLvXOE5O3HHvhD5moKou2/EfgLP6WsywrbMEAJMfvhLGdNXwZsNI+CPJen4oXI1hovUf0t442XbFvzc+gUdw7x3kplNGwRP6QxGDhgGactPHUUgXkFbqs6Iyl/xXmPeFtFjfreJQlEb6ep7peH0BiS1HH/GaQRUzaVG0ONZ56jdYg+ra6j6fHGhYCbSjFNiu8NvRIVf3Sv5mcaZ/5+RXvWAuNLSZ5qPboXrkw+7pWgBPJk/6qWhgNRvjjbzaTk6J+E99/xqn4y35Ins5n2VcR2WCZ0E1lIPZldf4jCW/PdB4Ofi+U811Mg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(39860400002)(136003)(376002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(36756003)(31686004)(110136005)(316002)(54906003)(478600001)(66556008)(66476007)(41300700001)(86362001)(38100700002)(6666004)(6512007)(6486002)(6506007)(53546011)(66946007)(26005)(2616005)(8676002)(8936002)(31696002)(4326008)(5660300002)(2906002)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTFHR000cVRsa0crOE4ySjVybzhkVW9aenZYQnJTTjBoK05IUnNva01IblhG?=
 =?utf-8?B?VVNTcDV2bkNVUStRbGREMW9lRFNVaVlwakFtaGxXUHBuRHB3VDBDeFRFMkor?=
 =?utf-8?B?ZmdpVzJUZnZMM0U1cWMxbW15M3hkYytaYTFCTjhHMDNadnBCOEtVS1JNcjN6?=
 =?utf-8?B?Z09sQmtFajRmUWxDMW1rWHJIR2FyaHRxaTV2OGtocWZiZFk3dE9EY0hTM1Z1?=
 =?utf-8?B?SStNTzhzbmVDbWF4M3RYMTVmMWpuT1FIQ2hmT1lZMCs3WVQzRGJRU1lETlQz?=
 =?utf-8?B?S2IyR0FwRjA2N0R3QnpvbW9aeUZGVDNiRXZRY3RUNHpHbEVhSDEzWEl2VnJu?=
 =?utf-8?B?blpCeVBGc0NyVHM4clF6ckJ3eFJrYUI3bzF4bVF6NDhjazMyODRZVnI1U0ta?=
 =?utf-8?B?NzJZUU12L3J1WG1BTnlSR2czb09wSU1UMWYvd3N2M1g2NVY2UXdSdEk5MFNC?=
 =?utf-8?B?QklCZ0Yyd05rQzNqYUlMT3BKZGgrZ3V5NDN2Q2lsemNIbGR3eTVNRGJXN3Yy?=
 =?utf-8?B?ejJFRW1zdjFBK2NHVkw0cVhrV2VHd2VuUEx2SlZOYmFONVRMd3pvK3EwaGtn?=
 =?utf-8?B?d3JGQ2xscUJZZUdIdjhBMkoxaG92NWh5YmlJOENDR2YwNkFMYVdZd2hZYlpG?=
 =?utf-8?B?b3k4UVZnRXlaeDlBL25qcDRuU1RGdVdHdmhpblhoK3B6eUtvbTNtWE9lakRu?=
 =?utf-8?B?aTlobzVWRWZQVzAvUmhFNm05RlZDR0xXMzdxeXRrSFhLdnp6ekY0cjFTZE9r?=
 =?utf-8?B?QVBLbkNKaSt2VUJQaC81bktGdlpXRk81RVA4bEN6M2NCN2RLR2liTDhDZnIy?=
 =?utf-8?B?TWUvWUVjZlRBTExNQlVGRThNWHQzWTZlTDdxbjVXZGs0Y2FOZ3hzbTJVcUM2?=
 =?utf-8?B?N3NkdUxwRlRGTDZ0QlZqUE92d3VoQjhPUDF4RWszZjRGUTUzejlwdUw0REdU?=
 =?utf-8?B?R3J0Tkp3c3duZGV2NWFISFpUcEU2Wmh4NkxUbDY4MFkvaHJLSmsyNGtzUWpn?=
 =?utf-8?B?Q0UvdnMyMmNJSTlQTVMxUGhFQzRaRmllZ2tZbEV1WDFrYVlQQmVPUml6bStk?=
 =?utf-8?B?aVF0YnQxWjR2d0M3UzlmZGZWaU5WRkw2aFpVSCtGR25wbjZSbnFZSmRVQ1JN?=
 =?utf-8?B?bjdnWWVpTHNYRStUa0pqUkxYdVQ4QmFxTTM1ZnFEVmhmTC9BTThZb0I1a2Qz?=
 =?utf-8?B?OXg1Mi90bkN1SmpFaDVwbnQ5bnlwK3RtdlZlZm9idUhQa2FYaG5yaSs2aHBW?=
 =?utf-8?B?MGNtZnlnZ0QwZDNvcU1tWlIxU2pKUFBNb0dPV05uM2p4bVVsejJQRHVCTHJk?=
 =?utf-8?B?WVUwRG9VWXVYeGVTS0tLblFURHF2SWprSjFSaE9GMDNMdUFJbGtYS2FqUXda?=
 =?utf-8?B?QU5yQ2NQUVlub0RnRGxlNkN3K1BCVXk3aXlHSit6VjdVOEtNSGpVQnlsd2Zu?=
 =?utf-8?B?LzZONm9Nbm9JVnNwMEVwRVV0KzVQTjdLVjYrL0huMVpFS1N3aWFmc0Q5M0k2?=
 =?utf-8?B?ZkFZQ05uL01ZUDErUjhlUWppaGVRL2lEUEZLbk1HekNTcUNQTjdsbkEyckhx?=
 =?utf-8?B?ZWowMzlseUNxL1Y3ZUwyWm1xcDJ3emFFR0o3dUNqbTNsMXpwR1kra3VKL1dW?=
 =?utf-8?B?T3MxQ0tEVlZTdWY4UWt0cXRuL01aeFlUaXVyYUQzR1IyVHM3a0gySlVvb3VD?=
 =?utf-8?B?TVZSMWF1Wml5QzhEbGRVNU5ndk5CdzZUYmhHa0U4UlZpUVpmNjgrQ2I3eWxi?=
 =?utf-8?B?U2dweU1hekN6Z1hoanB4SGVNYkJzQUt6WGhnRVlZSFVyajBkbW1ZTWl1aXNL?=
 =?utf-8?B?aDhOaTdnZ1NZZmVBemhGdDZKZkJMNTNkdjJmZTY2V2dONkhwZHFvTDYzbFNQ?=
 =?utf-8?B?Mzdzakt1RGhJZDdqVVNtUXc3T2FVTTIrcDg1c0R5K2xIcW01SnMrVjhBWG16?=
 =?utf-8?B?bXdYVzVpQmVpSVVDdW54d1cwY0NPWFh5WExyVUZlSmFKK3IzNVpsR3NEWXRO?=
 =?utf-8?B?b1Q3UUgxdDNKNGRDaGtjV2crVStOSTVRd0VuVnI3QzZER3BXU1JvR2JLdDlM?=
 =?utf-8?B?Z3VWSTBqRlRSV0xTREtsZFEycXZHZlFmWHIraXg0OFJJbis2dTlMOHc0c1pk?=
 =?utf-8?Q?9rcOxaFsR7KULQKWRp8sxrmJB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f550d5fa-b0d1-4619-2cd6-08dbc34e1bda
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 13:47:24.7079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LGfhbfOQWwZKQBPe9Owzk0ayCPbQ7tTH/GBnV1suRgSV9TKxIzwpTw6gHcknjA2x4PSIfND5E/JQw6MFo23cKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5667
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/2/2023 06:52, Mark Brown wrote:
> On Mon, Oct 02, 2023 at 11:32:48AM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
> 
>> Makes me wonder: How many more such quirk entries will be needed? Will
>> we have all machines listed soon, or do we expect that future Lenovo
>> hardware will need entries as well? If it's the latter: are quirks
>> really the right solution here, or do they just hide some bug or then
>> need for code that automatically handles things?
> 
> x86 firmware descriptions are terrible, it's just an endless procession
> of quirks.  The model for ACPI is not to describe key information in the
> kernel and instead on Windows load device specific information from
> separately supplied tables.  On Linux that translates into these endless
> quirks, on Windows it's platform specific drivers for otherwise generic
> audio hardware.

I knew there was a TON of "82" prefix systems from Lenovo so it was an 
educated guess that all of them needed DMIC support.  This was incorrect 
because one of them didn't have DMIC and that caused a no mic support 
problem on that system.

So in the case of this seemingly endless list of systems being added to 
enable DMIC support Mark is right, Windows does it differently.

With the "next" generation of hardware (Phoenix) both Windows and Linux 
*should* be using the same _DSD, so hopefully we don't need more quirks 
like this for those.
