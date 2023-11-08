Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F44A7E5B57
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 17:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbjKHQhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 11:37:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjKHQhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 11:37:23 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491321FCF;
        Wed,  8 Nov 2023 08:37:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bSBaHv0nLG5FExZ5erMTsOl6y8UNf75WOvobcRZR0rwM/uAq786GK2INdKuVCyG6vlqcml6235Ef7pnrFMIuUFFRMmCEGoCw8E3csbbUD8EmZZ75dn/i4rjWLbmUixHlibxOGEGfyHVcs2uwaMSok8VqKsfNLtZtL9P/vKrLwy290gmBfWakRVSN11DVMv3DSvjsj5VevmDqeh7AimPe00cO5nPp9OkbA/ST1X/EbMPNY38bK55u9EovRmshRe/b3YM5s+QHhqI2UjHRNOSKGfSgEw7M3mYFikewdo/Z3VsbFPOTvyUIExEVM7EDX7DQ0Fp+GbHPYONDkrwAh7NjkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uFgYkix3kzEBUGk8p9+9eP7k5GjL3g9OzhKxFkVHZP0=;
 b=JephHjt33VdusecPAr0JDPVmePRtScu/enE6vYbD7tS7ruY4tneygT7wTaEGcH+vaDGU2aC+mS7qvbyhVO6bsTcg/qWlOmvXTFUMZ6gKbybVERFWcZH0VK1sDtTTKWPJqoaSLKfKXVNBCpLVOm/zaBoCRRQlkkPycKXXoN13DxRtpfqRReAhDTYbiulQa0obYm4XyQyNMc89Ys5UVPauNLxkyr1Ur80d9ZL4p4zvmjn3pWz8DfQ9bTYBW0wU01wZ9YpZ2gqXUReVGFWqG8Xz4k/KMs8N5V2VAh/MhYEVmhDXJNLS/GTzLDgv0ahl3DwXX+QLtcSyldgPlYpr8nCW7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uFgYkix3kzEBUGk8p9+9eP7k5GjL3g9OzhKxFkVHZP0=;
 b=JrFA600iNxxeiwUxhLoQIA+2p/WqHfhdXSF153LmRlGzG4Wo/hh7LDQnMwz+bHsgevirYcUQKZFHCtv0PYuQungI15n4vF3hWP7MAvotX0RtA8MZQ8W9k4Iy99tT+8b3QaTzzb9Ui3fu62tehqeh/Je0VneaCZtsHe0fOMTsP9U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3407.namprd12.prod.outlook.com (2603:10b6:208:c5::18)
 by PH0PR12MB7470.namprd12.prod.outlook.com (2603:10b6:510:1e9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Wed, 8 Nov
 2023 16:37:15 +0000
Received: from MN2PR12MB3407.namprd12.prod.outlook.com
 ([fe80::8b27:b871:419:2466]) by MN2PR12MB3407.namprd12.prod.outlook.com
 ([fe80::8b27:b871:419:2466%4]) with mapi id 15.20.6954.028; Wed, 8 Nov 2023
 16:37:14 +0000
Message-ID: <52270fa5-4a7d-4894-9142-9b7697f0335a@amd.com>
Date:   Wed, 8 Nov 2023 09:37:10 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: w1: Add YAML DT schema for AMD AXI w1
 host and MAINTAINERS entry
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Cc:     thomas.delev@amd.com, michal.simek@amd.com, conor+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        git@amd.com, Conor Dooley <conor.dooley@microchip.com>
References: <20231107180814.615933-1-kris.chaplin@amd.com>
 <20231107180814.615933-2-kris.chaplin@amd.com>
 <20231108155905.GA2198732-robh@kernel.org>
 <7f547afe-74a2-49f9-8547-3c315d982018@linaro.org>
Content-Language: en-GB
From:   Kris Chaplin <kris.chaplin@amd.com>
In-Reply-To: <7f547afe-74a2-49f9-8547-3c315d982018@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0010.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::15) To MN2PR12MB3407.namprd12.prod.outlook.com
 (2603:10b6:208:c5::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3407:EE_|PH0PR12MB7470:EE_
X-MS-Office365-Filtering-Correlation-Id: d22b4e98-c9af-409a-0afc-08dbe078f67f
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0sVGF3Ti0JYZr0I2jW4Vf34BaE/tinxewAktFboqeS9e4Z0lurLvft1EUKDvUBZd5+JXSnnjwO5zjiT8NqpPTFOkw40qXC5PBsj1Kuj7AmIhIsLOtyGe4IS0Ln47qO1rtQdypCqz1sBjs/QsZej3/ZhULfKGhQpcCo7kNd00DLvkSvPm23It07gvNwHqRIKYj3rdsy7UtevLkpdCUT0mnrWl3gdJW2aRB4Uc9rXGyFQbtZwHhgS5D4jcpqrbl1veQjkGXlb2pMMV688uJ2lYohV/tOmZV3VDZv4ODhw8TsQUbPby2iuBf6XEGc48Gua7skz8h4GhwtTu6LqGKRdPQ9o5O75RHg1kKTkSBxfPM9oWHrBupLfeJCZdBW+suxUf4ALcOJ00d9h6Cw6J2LEF4NvJ1tnYa7x7FEebjzo0GgKdr8Y/kqVmsl87HDyGRyPBuyVptBmHOEzSLFgw9O3pDthRAM/PkL1PqVnHBgSooGfam1Q+mITZ38lnd+ledsGV+N2CqGHQqQo+fW/RVIfmx5DajQJ3eZptRq04vsk+eIiWHIKnbTJTcsZbr+6/8v3gnB3TsJV/1+oz6D1W2+Gz6StI0RdJEXHz6ldXAqkGTrCu5tEzw1S2brWa7DF0hCXJ/BRZbPF5ScmFvnx+bKuU4A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3407.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(346002)(376002)(136003)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(4744005)(2906002)(41300700001)(478600001)(316002)(66946007)(66476007)(38100700002)(8676002)(4326008)(36756003)(66556008)(110136005)(8936002)(6486002)(31686004)(86362001)(5660300002)(44832011)(31696002)(2616005)(6506007)(6666004)(26005)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVR6dXpySWZMNFMva1A5UHRXYTV2ekpnbW9XMm00M3F6Skw2Zmc0V0ZicW9t?=
 =?utf-8?B?K2dYM2FxbEZvejVQSDd2dGxOc0ZobEtrQzlPcnJ6YzF0Z1VhR1dIcXZlZVRG?=
 =?utf-8?B?UjYyRFBjSXdhUjIrd2wxUzV5ckg4WG1yaHBtYU9ieW1hR2FNdkI3aU12eXFW?=
 =?utf-8?B?RHZJckkzdUZuVjVlTFYrakUvMU16cVNrMm5VKytVNHNFTURLMjNidmh2SWFR?=
 =?utf-8?B?VVhaSENQTnJjWUhnQTByczZXaVVZQnhYQ3RWTjBNQnR2QlRtY1JOamhBT2NV?=
 =?utf-8?B?bENLLytVNkltQ1FNRUp2REQwOXhSVWt1M3VnSXdLdFJaSnlpMHUzYWhiMEZj?=
 =?utf-8?B?bkVWZWZ4eGVZeTlNeXRlaFdxb0lkTSs2d2t2TFNrVFM4Z01SWGhRZTFDQ3Iy?=
 =?utf-8?B?SjlSbkR6ZWxkYnpUSjhqSDhLT2s3OHZTWmlwNURHOUZJZ0x3bUNDazJIM0I3?=
 =?utf-8?B?VzA5UU9LbVFJK2RjM0JBak9rYW5xK2NoNHJTVkVEcTNTaGZLZmRDbThwLzd5?=
 =?utf-8?B?TFhyQ2MyQXNGUzREbVJyUWQ3SUpTdDU4cjNMR1N3WVhyQzQ4WEZ3MmZ0VGRG?=
 =?utf-8?B?dFJ4YnpGbnVwNzBFZkVmbXpLeW5qY1ZrbXU2MVNUM0QwVXp3M29zelBIRXpz?=
 =?utf-8?B?ZDU0L3A0SmtzRHpJaDlNcDhJNXl3TlFrNmwvaEl5WmtkeTlxamp2UnRUWFJM?=
 =?utf-8?B?a1BtdUcwaGN0WitQLys0N1BZa3F0Zy9MUmgxWDVEa0s4VC9Xd2gzejV0VXc2?=
 =?utf-8?B?MFJHT3NZR3RXSnFYVVpPL0krdVhWQU5zTXIyTkd5TWRBZDdIcm90NmFGaU02?=
 =?utf-8?B?Y2UxUitoSFlIeEgybXYveFlwT0lxQnBrd0dqY1Z1MmE2bFlkR1UzOHNYU0ZI?=
 =?utf-8?B?ckhOWU50ejV5ZGlLT2RxUjJ4d0NGc0JlVzlWcXZGMXZMRVhvRStNQk8xM3Fi?=
 =?utf-8?B?ZzgyZGRtL3hRMTRUTEF6QUx0d2hYUjF2aUtWODUvdmw4QW11QWV2aHVYemUy?=
 =?utf-8?B?NEsrWENJaDZLem0vYm1ycUM3N1JUTnFPVXJnZGhXRGZpbXRmQmJkTFZGNmdF?=
 =?utf-8?B?YlpjQk1BMTFlQy94RC84ejJ3YjZBdXlmYmZsNXpWNmYrZXY5TXp5QS9obldq?=
 =?utf-8?B?ZXpSS1BBU3pWTlc5Z2Zza2FRL1plNXRhL3F2Z0VRNVJKMjh2VWxOWUo1cVpN?=
 =?utf-8?B?TVFnZWJLSk9BbTJQelp3MkI0ZXFOMkZkRUFFTW9YMHEvenlUT3hwOTU1RzVX?=
 =?utf-8?B?YVVHeStFRWFZb2tLVTRNb2xlVU9Ccmh4SGlTQ004MVpiVW5VaDZyMHVpNGRI?=
 =?utf-8?B?a2RlT2hvRlZoRXhVNzlCN0d4ZzhvcGd1Q2c3RFRidTZyc0ZVL0VJa0ZwN3JL?=
 =?utf-8?B?TjloMlJlSDRZQTdsdk1ONEhoVWdzY3ZyRWtacTNuV0dMSlAxNFBua1U0VHlS?=
 =?utf-8?B?MDNRcUIvcThrMXhyYUtUTFZMRVdQb0lwWkZMQk5SK05zc2d1RWFkYkw1UkxQ?=
 =?utf-8?B?ck9SMzI1QTdMQlprd1RydUFXenBDV3k0cFB5Slk3bGhmRHZJMDhwVFJodlJa?=
 =?utf-8?B?TTZNRzZxY3lRYUJwbHlNM2tMOVBoaFJsZVRFaUV6YVBqQURQUjRsamxCT01u?=
 =?utf-8?B?WlkyS05rd0ZUVkRmVEUxcE5vRVhjVE54TFFQUXVnNEFSQW94K25JcFd3VUp2?=
 =?utf-8?B?UTRCclNQbDNndmhRY0FqUFNUcENHb2hreWQvVVFLdTZQdFFCb1AvcVRPeEps?=
 =?utf-8?B?K2RHSHFHS2VWMlo0Q2laS0c4L1Z4ZnMzTnVmSHJGWVAyRSthNU8vbDFDKzN4?=
 =?utf-8?B?bC9qVTBaT3ZBeGxnWWdFc2JrdUlIL2dmaldlcWNrcmlGU3FoZVFqQXBObGRL?=
 =?utf-8?B?UzFPNGhHVjNlSW1ISVRwdU01VkNYOFRWa1pzQXpEaUhsbXVXbWdzL2VxaXhh?=
 =?utf-8?B?dTd0SCtWaXdMMnFNRitDbmp4OWtGLzFmTC8rRjBDL2s4aEtXYWh5MGlmOHoy?=
 =?utf-8?B?TUpaMjFKY2dJTEhLUjRMeUszNDJqRzU4VGZNbERUOVJrTHhUblZaR2JJdEYw?=
 =?utf-8?B?TzlEVjFTR3FHbTVxVXh5YS96QVFqUk1pVzdnMzRQVTI4U1F3ZUJ6S1BpZi9Z?=
 =?utf-8?Q?8ijE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d22b4e98-c9af-409a-0afc-08dbe078f67f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3407.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 16:37:14.1787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /uduTIr9Zcx/smlBjmDipyuBOEZb0doQZaNHkKyMmLFzbaxhGamYRXnM0wGt0e5u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7470
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>
>> Sorry for not noticing earlier, but if there's another spin, drop 'YAML
>> DT schema for ' from the subject. You already said that with
>> 'dt-bindings'.
>>
>> Acked-by: Rob Herring <robh@kernel.org>
> 
> I can fix it while applying. No need to resend, unless there will be
> more things to fix.

Thank you Krzysztof and Rob.  I'll amend locally and if we have any 
other fixes re-send otherwise hold off.

Regards
Kris
