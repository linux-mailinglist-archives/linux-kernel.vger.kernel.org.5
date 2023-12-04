Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1EF8036F1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 15:36:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345379AbjLDOgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 09:36:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233871AbjLDOgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 09:36:03 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2076.outbound.protection.outlook.com [40.107.100.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C7D100
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 06:36:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QJJh5rWUIqR7piilQAhFhx8HwTkkYp00U85R1hndvLVuhDYHSITTds0iKKubjgEV04WTItEbXfcqB/a/P/rV7O1/hQa5T0JC1As3sNI6F5MAaof1lkNoaXLv5HWxywTg7ZWs7CIGSHUEBCte3WHGi++QcDuj1LGlz/VLfosvMTBMacKlZAvFpBqr4Ez2ycotM583rFfH1UeYZSDtkhkO0VJprkZIl3qqwOhlc6GVEgpdZmjbQki4TpyipjqFTOpxQsaeyTrJZPZX7fIv510Hi7RoH1DUtfVtn5BCuKMb51ajDoUYgKtCtvSZxQTT7Bz9Rf2+RxgpmWfwsK9As/8wIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kHq5OgFbkMAs38xbjKe7ntU2JZkwIAd2QmaPUO8mCjE=;
 b=PrBjfkJ4rlIfXkiQ7g0v7qhuK6mh2dujSfYW5fUOoAGj+8Gk0ESP3RHvAcss3Hg6Y04/0I4qHLYPetCkSJzTRkZ7DevzlS/vR8D8FkLAIqzNZDQPNR9p5F6RwcNkYAwBsjhodHVYTECdbg+iHkgdzchKZ+59oi+Gx5WLmI2CYu/mnwDgztQ613c5q42urKy119+r3x7lFKxx8oj1FWeOF3JHTv14rzlGXri3XdSH+vJ6WReNTFY122feyFtibsuKnE/anQLSQWsFbaFJKOjPOx77/CmP25C8c+oW/4Vy1iiD3aXEHnOrPPkcqGt0/gMcvuBm/hW0HG4I/u4sl7aRxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kHq5OgFbkMAs38xbjKe7ntU2JZkwIAd2QmaPUO8mCjE=;
 b=sqmhOiULZdeGIDq7LC9hgyVumNLkiL3tRi+NcuRjzOc2xZp2SivLChg16IVwhA5AHNTX/YYRzZEUeeXk/JVj6n6i9t4P9fK6//eSYjcaAfKtmx+DmqSP/hNebkicd1jX+lEunVW80plo3zZYM5ePe6ShzOy2Dqqxuxk4piDU/h0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by SN7PR12MB8435.namprd12.prod.outlook.com (2603:10b6:806:2e2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 14:36:06 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::1d68:1eb8:d7dc:4b43]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::1d68:1eb8:d7dc:4b43%6]) with mapi id 15.20.7046.034; Mon, 4 Dec 2023
 14:36:06 +0000
Message-ID: <255f23c8-5c89-47cd-ad97-7f5f0b07d645@amd.com>
Date:   Mon, 4 Dec 2023 08:36:04 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/CPU/AMD: Add X86_FEATURE_ZEN1
To:     Borislav Petkov <bp@alien8.de>, Brian Gerst <brgerst@gmail.com>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <20231120104152.13740-1-bp@alien8.de>
 <20231120104152.13740-2-bp@alien8.de>
 <dc3835e3-0731-4230-bbb9-336bbe3d042b@amd.com>
 <20231130171316.GLZWjCrHGHl+VVp724@fat_crate.local>
 <16400d3d-8264-4f3f-96ca-168064944462@amd.com>
 <20231130185048.GMZWjZiIjhpjrv4rPf@fat_crate.local>
 <20231202124901.GBZWsnvQct4PxsUsXK@fat_crate.local>
Content-Language: en-US
From:   Tom Lendacky <thomas.lendacky@amd.com>
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 1NhFSLKvfA==
In-Reply-To: <20231202124901.GBZWsnvQct4PxsUsXK@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR04CA0014.namprd04.prod.outlook.com
 (2603:10b6:806:2ce::20) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|SN7PR12MB8435:EE_
X-MS-Office365-Filtering-Correlation-Id: 747577cd-bb88-4c6a-716e-08dbf4d65953
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sBDqBm65CM9CKMj3mhbQ4ZpOG/OhRLgAzs91uSDc5B5xGLiMhuB4rnlp9g9Gr9Xc836AQFm9fD2YTONZMIHoWrGo6TCZIK1+zt4zLRHv7FD3rSIBJmE2OY/0BkucXC7XH8SFWIA5i5cQAZoQKtYTw7FRu8q82oI9qzFvfLpBxeuIp9Vk0HB+CbdXw/Qf9ZGveg2mGSIZYN8fLr3VcbIY/GVYYwX7vVpWZDeRhHRBYJb4T//ogHIBITmqm1AOo+PPaiOpql62We3Ie48GnMukw3vefRffb4QIOPJvLWeaHQFtXunICQM7ujb5cXnrr7KllpKXT7tWOBkpdnPZSaEqybzgK5ctImBFvTrKwHD+emey959scX2onFign7S1jr8jRy8YFi/nKqDMUQrlugzKQTIv3IySrQoxX+YO9D5B+jpaCIQowSJaoPhndOsWxRgNOKSm/IDlElWxaX/cCpORiztnmhv+U78GpeE6TpfcrikRnpCIwGd1+fY8NNUT5cgrqN4D75ggyOA28QrJMGr5xk+N56yR+6FSwYv97jzCUZ7CVe/oc4rqW0q6QE5XMBTBbv87wBc75lPm36imvPbfl686RMCxYEHM9dfPLPuU+/ikgHwSvm+XwfmcN2egguiJ+LSqtSMv5HBVZxFDxe73cQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(396003)(136003)(366004)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(26005)(478600001)(966005)(6486002)(6512007)(6506007)(53546011)(36756003)(2616005)(316002)(110136005)(66476007)(54906003)(66946007)(66556008)(31686004)(38100700002)(5660300002)(4326008)(86362001)(2906002)(8936002)(8676002)(4744005)(31696002)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2RwcFZjLzNBeVVsOGY3c1RsY3J4RnZYVVg4dHgxdWJWU2FaUnpHNGhyc3g2?=
 =?utf-8?B?bnRSS3lhUXpPK1lZdWUwME1ZdkFvdGFTTkx4VUt0dzZpSmhiQXE0MFNmb3py?=
 =?utf-8?B?SUt5Nm5MeVVEK1ZEV0Y5UkdLNVFoQjZaeHpGa2JSZW85VmZ4UG5GaTZ2UlRV?=
 =?utf-8?B?L2c1YThiUDNrcERONUY0d21MMUNnMVQxSHRvRG8rejZTNkZSejJlem12Qkds?=
 =?utf-8?B?V1dUZVhmVVZvbTVDTWpZMU1nT2dGa1o4VGlDV2lmNElkak9SeDAyTWRoV0hL?=
 =?utf-8?B?RHpWeXYxWTNqandXN2ZxM1ZlOGNJSXFzV3p1QmV3ZzMwanJRN3F1MUU5cEZK?=
 =?utf-8?B?R0IrQlVjQ1FNVEJEQ2dmRXEzckpuNlRJS2JITnBVTFcrV3J0d1FNYkhWTkE1?=
 =?utf-8?B?MVN3aU5HNWtBNTIyYWZiSnh3QWRkRTNKaHh5TTgwVEFKbmlZQ3RjTUl6SkNW?=
 =?utf-8?B?emVVNVZNV25SeWJmR0JtYUJWbXk2VDJmWm5vMTllNzF5QWJiTk1DQ2ZWMFov?=
 =?utf-8?B?YXVtbWRQQTRvbEQxMmNGaVRzYmhhTDZNdll3QWNHTU54ZzdJOHp1cWROUzBt?=
 =?utf-8?B?SHZwWkd4OXNzVVdTaFQ4UW5XRy9rd3lBTVRrYUp2ZG1RU1REK1pEc3dLdDNU?=
 =?utf-8?B?VnltazNxNUxaaWlZYlV0bEZxV1UzbTh6QlVaeUhqVDdFdVZyVjFzbkd6UTUy?=
 =?utf-8?B?QWZZbE9OV2o2Q09ld1F6RlIvcXhjUENTVGdyMjFjRU4vSTBja1RlSjVWTHFD?=
 =?utf-8?B?YStNQ045QUZwNkVac3R3UEZNNkdLanRnbHVIYVVTNEI2ckw5N3ZNeTRPR3FP?=
 =?utf-8?B?ajR0aGhVTG94TVpvK1lhcEFHWEsxSjgvOFFReHphZkg4Vy9hQWJPREl6T3oy?=
 =?utf-8?B?TC9KQVpjRHNEYW5kL2FHSFFVTnZqdUJSOTZFSzFCN3FEbDBMMGJ6dTVIb05Q?=
 =?utf-8?B?RksyVEtBRUNSYk9oNDFIam1xRDdwM3pCWFlEbzkxcXUzNDdEQW1Wd1l5Ry9S?=
 =?utf-8?B?NTRub0JXdGZkZ2pCY3VTZTlIWm9jYW83S2tkeG9xZGNOeGIwd3h1MThFTWRS?=
 =?utf-8?B?Tzh5UUlzTmJHTEZqVTFMbFoxNGwveDN6b09XZk1xZ1gyNDNvNFgwOTlLZmpK?=
 =?utf-8?B?ek1CWjdzdDQvNUVoMVJlY2I4Qy9rKzQ3aFAzN0tlU2l4TmtGNGVSR3dsV1Rh?=
 =?utf-8?B?MFpPZnI3ODRRQm5ucGcrb2o2YlFHeGl4eUZ2aUloTkFNSjFhSVZjS3hQQWhl?=
 =?utf-8?B?d3NvYVJ0a3VENDJkaGYvTkVXOU5LSTVUMFlySWRvMFNUQWRlOXZzdE9rYTln?=
 =?utf-8?B?OXFkVnl3OTVIaU1nNkgrNUJpQlZhRHlmY0VDR0tzNjNHeEdRZkt5Umc3emlB?=
 =?utf-8?B?bjJQMkVwLzNDNXNUUDF1ZmsxUkk2RVBySlcxVkdxcW1ZMnVXWUNxU2owR1dI?=
 =?utf-8?B?QXJnNEFzc3VqbjRBS1F3cXJhcS8rMnVhZU1BSG9GanZjK3NUS093L0h3ekFF?=
 =?utf-8?B?dVZSMkZPenJhZ0F0SXJqTkFKWk9GN3NISVBxa2JEMktPSFN4alh5OVZBQ3Ji?=
 =?utf-8?B?LzdkOWlQVmRqbWJIcUx3d3hBYmgyZ3h5SU1zUFVyNmhlQ0IweDZndkRTanV5?=
 =?utf-8?B?MTBhaTYwNHNVdjljOWhzZnlPSnR1NmJPWkRJQXBvREVZRjJSWVYrUjRadlVQ?=
 =?utf-8?B?Ly9rb2VhRXlIN0pzVmhjbk1jMEZaY3kvQlVLQWFrbHJHNjNVMm53eDhqazB2?=
 =?utf-8?B?NHNKTEdUQURlem1EN1BCVzRvK0o1aWQwcTNjZkRBNkpUMy9pMUx5blV6Y2J0?=
 =?utf-8?B?MVNKNjgrVklEZlJXS3dDNEVnd29KdHJDSmhJczAwNUxDREhRMmtWRVl3MDky?=
 =?utf-8?B?SmNQS3BTM0RPR0xPYnFpV05WSDZ4TEdnZUt6OW9KYTkwYkI2SVBrWVhPWkNW?=
 =?utf-8?B?RkVFQWpRRHhkb2ErbmZFOEFwSE9FMjd0SWpxZDFKNVJnZ0kzTVZaSFRwUEJM?=
 =?utf-8?B?a0N4SDdCN3lTRFAzRjJwU2xKd2QvOHczaTBpVlpsUVI2ME9kbHVjamk4ZHJR?=
 =?utf-8?B?c0lLcDJ4NFZtUVFDR0k3SXBKZXgwTDQvTlNRQ2ZFVVhFZnJuam5BRDhEQU1E?=
 =?utf-8?Q?dJ3GAJZjprKIc7vDn9sFFqW6u?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 747577cd-bb88-4c6a-716e-08dbf4d65953
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 14:36:06.3128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SMJNDzV92Rb7a8XVTRw5T1g8s8yfn471ILqC79yfMUDuqttTDOlKmW8tINCiL0PNq7rPVhnQUjvoGEIaPIsnAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8435
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/2/23 06:49, Borislav Petkov wrote:
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> Date: Sat, 2 Dec 2023 12:50:23 +0100
> 
> Add a synthetic feature flag specifically for first generation Zen
> machines. There's need to have a generic flag for all Zen generations so
> make X86_FEATURE_ZEN be that flag.
> 
> Fixes: 30fa92832f40 ("x86/CPU/AMD: Add ZenX generations flags")
> Suggested-by: Brian Gerst <brgerst@gmail.com>
> Suggested-by: Tom Lendacky <thomas.lendacky@amd.com>
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> Link: https://lore.kernel.org/r/dc3835e3-0731-4230-bbb9-336bbe3d042b@amd.com
> ---

>   
> -	if (boot_cpu_has(X86_FEATURE_ZEN))
> +	if (boot_cpu_has(X86_FEATURE_ZEN1))
>   		init_amd_zen(c);

Should this be renamed to init_amd_zen1(), just to avoid confusion?

Thanks,
Tom


>   	else if (boot_cpu_has(X86_FEATURE_ZEN2))
>   		init_amd_zen2(c);
