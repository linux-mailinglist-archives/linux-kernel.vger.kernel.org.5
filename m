Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB0E7F13D1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 13:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbjKTMyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 07:54:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231961AbjKTMyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 07:54:03 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2065.outbound.protection.outlook.com [40.107.21.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998BCC4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 04:53:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hZuHdhyYwN9eAl/VrFAOl20E6XJILjscddMUjGoy1ctTzI1GFck/RHR6gy4//jFeRpb+onHtI5+wmbHR2fGErpKavAPY9hpl+K3IUIdrclfAFR8RWOex5wab9UFf6uhdOTQxmxm5BZMurgwm0jcN2n4AO5rYHzLaPEErvHjwKX9uEI2KE93LTojHje1pbIl6zPKv1kXpSrOUsGQCiw/V47cQ62PvCyAHdRGyglfq8tw+SgVEdAcFi1iktMz9KK2tCgezRMB3DvFSxfKH6myhbIs9MIpUbQcA7X70l3IsYVsMMVTJTPap2kluG8Zof5zSTeEGNfc9X7bYZbqrA0b7mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GQMXGjjPtnw4fyY6ofZ0JvR0I/iVmv92Z2J4X43+tYY=;
 b=fD6oPUnSzCQqnUNSa57csNwxQT31eweyvwCmAuTGasLEOQChcefCgSKdrkcSRWMKEcqGx9rYg/nrQOr0uzsNMU1CYAqCu8mDVlHTsy0Wsw9y5gsRulRMigY2l21LrTKrPuMakCwd2D6tRGPz7gwWNpndMSiJgfvZ5xMXxMf97QwV46L8O6+0swlwT5GLk4lmNMZduGCmE+U3/4ENtq2NKv8qAntR3JFF8gqvE9b9sYxCwzQRRF3radnS0ATYEZ77a8XEtSccM5blXqoM3XvrM6jJwxT2TrWejlyQ9NEBzqDeEVX4jBqFHOh1mjDWj/aJJSHZcvDz5N9yOGubyF7tTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GQMXGjjPtnw4fyY6ofZ0JvR0I/iVmv92Z2J4X43+tYY=;
 b=GJgMPI3+tMXJLRsUm4uMWCmx8YoCPKigx8pYaSde+SgSNipPU5nUhR+64Wk1BvJ8cEDHPVToibFZkcpNHCZxQGN0ByJk2tQ0e0q6JA67u/QjwYtvRZaMFVmtziF94YSyFOeAynyyZd2eNT8D0mMXf62kGdPvuDuhWz9SadS3i9eZ7bjgaqTrdHAsyRTqSSKN5ioSBCGH+xxvMuIQ4Aj5wn0rZUuLIJpqyp/2yIhAIGld04/B2YHteo1m4ErYfR6w4AawMam0KQZOwXlPylE8ySTTn7MsUq499HYAHrUAD2pNINQHZYj2dcUAroqJNdQDhcXkD0k2a0Q/IgEq0Cm5RA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com (2603:10a6:102:cc::8)
 by AS8PR04MB7912.eurprd04.prod.outlook.com (2603:10a6:20b:2ae::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.16; Mon, 20 Nov
 2023 12:53:57 +0000
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::e665:a062:c68b:dd17]) by PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::e665:a062:c68b:dd17%3]) with mapi id 15.20.7025.015; Mon, 20 Nov 2023
 12:53:56 +0000
Message-ID: <bae4d27d-5882-468d-a5bd-80b34c10dd80@suse.com>
Date:   Mon, 20 Nov 2023 14:53:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/13] x86/CPU/AMD: Move Zenbleed check to the Zen2 init
 function
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <20231120104152.13740-1-bp@alien8.de>
 <20231120104152.13740-8-bp@alien8.de>
From:   Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <20231120104152.13740-8-bp@alien8.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR0502CA0015.eurprd05.prod.outlook.com
 (2603:10a6:803:1::28) To PA4PR04MB7790.eurprd04.prod.outlook.com
 (2603:10a6:102:cc::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7790:EE_|AS8PR04MB7912:EE_
X-MS-Office365-Filtering-Correlation-Id: c09740d5-d51a-4f84-34ed-08dbe9c7c200
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xy3kpgo5u7sSzaulFMHJE6uKVe6jaeFrFo8m0W7Go/ba5XlJiyQbUBiJN0N9JJDZZvuep0wViNGOePo2kttrQG7kJcn9pDGNOokD50801NSwqcfGm+SagKk+5DTrlJmkfPTL7u5piQ5WjDrQFYRDaZsTBOLTrw61x+37rRyEBtA4hwLVCrizFwn3PZnPY/gM4uodl8x4s+xOhhZRNfKSupZJgt0CYxLYyUtVgfTtS7ZCscJYSFg7ZMyME6gHecF0j+sjvG08xIZFqmgwz+iz8WZTHjYRUNmi84O6BuWveh6oGUlv9MJcK51E7Ayh7HSYkPtSKoQ5f+Efl3n17wKZ5nKnp5XMt8a/c8HHwjhRFOH74ASyCoZ0nX7B5eqRI7lvcZ1MXve2t7AJ2JLVV8y7bVOOWgX+qKQPKgBGmoB33VLshmbaEDHqEtbJEMT2G6tP1Kz3olrHIwEsUYxJDESbz9yAW2D3s+WhGIDjch9YT3XV9OX7+uTvkeDm5mt+64Nt4YU6Q+CUu65Hgbsj1zXrhS2srO/2SX1EeUG8iMHE+Y0zNZbt8lQMQ0/JccpjmviPlYdVNfypW65MvTq/eT0dCPdtHj5fhsVYcowjhAMOE0yIvEOxesix2zI9CTQjHYhzeXEgtvrzFn5s1NqUIJ0HWw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7790.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(396003)(39860400002)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(66899024)(86362001)(31696002)(2906002)(5660300002)(66476007)(66946007)(66556008)(316002)(110136005)(4326008)(8676002)(8936002)(36756003)(41300700001)(6486002)(478600001)(6506007)(2616005)(6512007)(83380400001)(66574015)(38100700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OE45S2F6RE1mbTVIRjhMZTFObmJGMjFFaU03dGRxUG9ITE1KNkhleGZyR3cv?=
 =?utf-8?B?eW5hSzJIRnU5L1VxRis0QWc0NE1GcWRtK3dQODVTYUZQYkJleDhXOGdYdzlB?=
 =?utf-8?B?RGZ3ZHRYTzd0M1VhQS9tSk9ibldrajZ6ektEUnJwUE0zMlJPelo4R00yL0tE?=
 =?utf-8?B?MnUwY0d4TDJHcmlMYkMxUlJlOFp1VVplZGFJQ3dIVGJQYWc1TU9nT0l2UG8z?=
 =?utf-8?B?QTFJQ1pVSUhGelRwRXcyZ1pBUjhodWJ1VXducTM5bFEvQis3RFJJSDZEb3B4?=
 =?utf-8?B?MU41cXcxZkE0L0RVNCtKSG51TThZUkNoTTVGRzQrQkFnSTA4Mlo4RmtYVGEz?=
 =?utf-8?B?ZFBpWmR3aWVVdW9wNWZBZFRWaDZ0dVpnbUp4Q1cyTzZsVXh2dUVWU25yeEY5?=
 =?utf-8?B?VjZJTFNHdTRVeGY2bm0vZExHdGFNSjBlYWE3U201UnNkTldlMVRKdE5TOVRQ?=
 =?utf-8?B?c0lSanV3YkJkT2M2VnB5YTlsSFBnbzlxT2hBNUFLYm9mVlpVU0RZaWdadUtn?=
 =?utf-8?B?TkdpVkRBZXpUbjZnUmJUMjR4WEZ6M0tnK2xZdW1xR3Y4RjlrQWxTMHFlajJ4?=
 =?utf-8?B?T1VWYVpCWWFTTS9MQUpIaDZlZDh3YURicGN0RGc1cWhMVUY5M3JVYStiRlFV?=
 =?utf-8?B?dlBzVmROQmJPOHdETkUzZE54Njl3Q2lSVDB2MmZPV2NUVVY5UGFGd1RqQmlx?=
 =?utf-8?B?dnp5YzZtL3JmbnJ1RXA0aEFtcjNtLzFwNU9LVUlTdHZPOEpjVzI2VWFieFUw?=
 =?utf-8?B?cm5US2pqdE9HR1R3THJvMDJYaGZoTnplMThGUk93bjV2N3FzTkFjOWFCYkJr?=
 =?utf-8?B?ZUx0YlVrMW53VUdvc29JdzdpeXlVU3BycVozRzB3SmJxdGpwYUpGQ0ptYStm?=
 =?utf-8?B?TytoeFdscStmS2hsbVE0bDlyOXhiVFhNTlI0S3FHb3l4elR0RkRXOTJlR0V5?=
 =?utf-8?B?WkFNOHVVRTg1K0twR1ZLa1A0L1g4dW5uWVVWMityUUlxR0xaTzdZbWpsNG8x?=
 =?utf-8?B?bHNxdHRDaHhOeFA4dDQ3RWh4eXpMUENoa3FVTEFRRlhNMStKaUsrSEpGUW5t?=
 =?utf-8?B?WStQekpkMnVkRStsTHdUdWw2QlRFODdUL1JUZXpBN0w3TDhNQWtxckVDeUp1?=
 =?utf-8?B?Nk1QOEZuM3Z4dkJSd0owS05KeWxBeC85clV3SXRia05FRGNoaTcrNjRPRDQ3?=
 =?utf-8?B?R3hYU0JlYTNGK0Y2SVYrMW1yeHR4MXM1M2lla2hUSHZ5ZkhMT3FVMU1SNUcy?=
 =?utf-8?B?NzREM0F0S2NvcWZFd3pDZ0dqcWk5UXBKYXJQMUNlQnB3T1IyTElxVTJOUVVv?=
 =?utf-8?B?WU1xTDRZMTR0MFdDWnQwZDUrOGJCL1FPOVliQnFsVFMraEhvaXdBdm1STTZv?=
 =?utf-8?B?RGRweU1nY2krMkJKNHArU3pHK2xWYkxST2V0eVhSNWVaaUFiM0pHeGUxRlZa?=
 =?utf-8?B?TWJmWFkrdG9ZSEZkWm1ETFFIN1lLQTlibm0yRHVHNldQZ3p2VFdUWFY5bmVB?=
 =?utf-8?B?Mzg3WHEwYytIc2V4OFlkU3IyN3JyMEkzemtNeUQ3UG03SVY1U01HbWswb0o0?=
 =?utf-8?B?QjZMOWlRZUsyeTRPLzhRS3NQenE0cjJIV2RpV01OQlRQOFZWeEhWTUZFUWtR?=
 =?utf-8?B?NUx0MUtJelhLdmFzbUZ5WDBqQjlUYnVsc1pULytNeUMyYWNxcWR5UVBSOGwx?=
 =?utf-8?B?a1k3ZnF0ejh6THd2WlozOW9md0s5aGp4NWpMNkt0L0tyUzZiRm9YUE5CQ040?=
 =?utf-8?B?cEhleURLaXBBZG1kNUNsVUtDNkdKcElBL1dzTzZyVHlNRkNOeEtadVlwYXh5?=
 =?utf-8?B?OXFIMWtlS3F3QzFCak0xa0w3QVExeWhBSG9GN3BiUThkOEZMeW5lWEpyOXha?=
 =?utf-8?B?cmRJRU1pMzhBeEJDeHZzaGo5V0ZWS2xTZVZTTUo5bVFHcGxOZmNOT0hWcU1X?=
 =?utf-8?B?UFFaODg1aXhDTEpWb0Voanlkb3NtREdsaFVCWUFEbmxUTjJSMnQweU4yMlNa?=
 =?utf-8?B?OXBnZXREWEU2ek5wTWZKMXZkQ3laUW1kazZoNGxZZjVDMjJtVTUwanFSWDJo?=
 =?utf-8?B?YytJZlNJR0JxSmd4R3FKMEtZd0lpOUJTZnRWNU9yUkltaUZiT3pKam5VK0pw?=
 =?utf-8?B?NmVIVmVHQ3kvL2tzSEg3clJJZm1UemlpM0E4MkoyRFl1UGcybC9OTFRyVnR0?=
 =?utf-8?Q?qfnDWaGQ/MnLzCEwKMekNRKAOuRyIUNOW32jt0ZZmp3E?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c09740d5-d51a-4f84-34ed-08dbe9c7c200
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 12:53:56.7656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jZpxdqNV/6AArIzhdMj0pTcmche9rSfdCxQUoUsmxCppGZteQNtv6aPtuBwGVrBQLMe0DJvw7h5xeIl6oiQRWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7912
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20.11.23 г. 12:41 ч., Borislav Petkov wrote:
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> 
> Prefix it properly so that it is clear which generation it is dealing
> with.
> 
> No functional changes.
> 
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> ---
>   arch/x86/kernel/cpu/amd.c | 70 +++++++++++++++++----------------------
>   1 file changed, 30 insertions(+), 40 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
> index 8d90f5f6b0d9..7cbb108afaf4 100644
> --- a/arch/x86/kernel/cpu/amd.c
> +++ b/arch/x86/kernel/cpu/amd.c
> @@ -70,12 +70,6 @@ static const int amd_erratum_383[] =
>   static const int amd_erratum_1054[] =
>   	AMD_LEGACY_ERRATUM(AMD_MODEL_RANGE(0x17, 0, 0, 0x2f, 0xf));
>   
> -static const int amd_zenbleed[] =
> -	AMD_LEGACY_ERRATUM(AMD_MODEL_RANGE(0x17, 0x30, 0x0, 0x4f, 0xf),
> -			   AMD_MODEL_RANGE(0x17, 0x60, 0x0, 0x7f, 0xf),
> -			   AMD_MODEL_RANGE(0x17, 0x90, 0x0, 0x91, 0xf),
> -			   AMD_MODEL_RANGE(0x17, 0xa0, 0x0, 0xaf, 0xf));
> -
>   static const int amd_div0[] =
>   	AMD_LEGACY_ERRATUM(AMD_MODEL_RANGE(0x17, 0x00, 0x0, 0x2f, 0xf),
>   			   AMD_MODEL_RANGE(0x17, 0x50, 0x0, 0x5f, 0xf));
> @@ -1039,33 +1033,6 @@ static void init_amd_zen(struct cpuinfo_x86 *c)
>   
>   }
>   
> -static void init_amd_zen2(struct cpuinfo_x86 *c)
> -{
> -	init_amd_zen_common();
> -	init_spectral_chicken(c);
> -	fix_erratum_1386(c);
> -}
> -
> -static void init_amd_zen3(struct cpuinfo_x86 *c)
> -{
> -	init_amd_zen_common();
> -
> -	if (!cpu_has(c, X86_FEATURE_HYPERVISOR)) {
> -		/*
> -		 * Zen3 (Fam19 model < 0x10) parts are not susceptible to
> -		 * Branch Type Confusion, but predate the allocation of the
> -		 * BTC_NO bit.
> -		 */
> -		if (!cpu_has(c, X86_FEATURE_BTC_NO))
> -			set_cpu_cap(c, X86_FEATURE_BTC_NO);
> -	}
> -}
> -
> -static void init_amd_zen4(struct cpuinfo_x86 *c)
> -{
> -	init_amd_zen_common();
> -}

nit:  If you initially introduced the zen-specific functions right after 
zenbleed_check you would have avoided the function move in this patch 
which would have reduced the overall diff.

<snip>
