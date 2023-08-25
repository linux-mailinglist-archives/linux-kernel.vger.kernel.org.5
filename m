Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54814788E93
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 20:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbjHYSWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 14:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231933AbjHYSWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 14:22:25 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2076.outbound.protection.outlook.com [40.107.20.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1854B271D
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 11:22:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WHVNoiN6opNy8kWhvOTTn6rW79REoUFee6Ssfo8/jzkvVyoz2rdoRrUXLZJJnxW70WzoP/ve2E9e3F4L23C9yCaHsNuuFqtxSTCjpQoC8V2J7hSXNqcfi+bvCswmlh/pYFoFGpg4Cf2tEawTOSoKZWZKmerYH7nhckdSHJDPZSQyjnGwXbNvLhuc/dlQI5DBAoy6BfaGsvn5Tda9IM16tlEs/cS/baobotQeC0BLjm/xRHc783/4KyDoaS/c2+a4ndVfEvTzSsWcWdnVpHocXYz47NW7kJ3v/JZaCqA91mcZfjoliawl3RLctbWxjo7YUVjLJPzvw6EXGHol/0JuJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4NQqcVOy9e6ahOPtMQ6EEtIjv8+0GzmF1+iFCe3paqI=;
 b=NtVFa36gAkI7Y3c1n6oXYYiZodzy6t01TNqRMdo5BMo//k5zC9vk/awEQMBk21bnIz/m0QCaGSOjj47AhROPR+5cQzKWLKWF8rUEBEliSTUr9X9w7u6a1YpBl2DEFuRVEEj8pgYoUkOqVw8dmys9cE8zKHLTbTqNgpcoKJD+WugRev3WQck4dtDKkpJbRdQEIG4yhNadRBrtQFGhjWXJnifr6ebHd9OGhYk4wgO2JCIsmRn4Q2FtAWZmwN3cLHTKPLH+W690WiW+ZI7K6mKu7hsByZzMFPhA89AvDN4a2OoLJSbe/U0IPvDUixBcnn5IlZmXMwM6DmoNvoZf32A1EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4NQqcVOy9e6ahOPtMQ6EEtIjv8+0GzmF1+iFCe3paqI=;
 b=t9Hw2QT4piR0FEPQSs/feWXxWfj81PdbWT0Gncj4pxAyqYh1I9+HCI6bHjQ0N8Kq0tuVr+JYddE+a+h//ZVg1YYdRD0oibqiqrRZAUqL4/R5Itl/DnfvlWZZtEdOrsV5jtHmzsZqCNGbdVQt81lqUMiJSEVpHS6UHyIcdXe2MNWPnTMlhSvYTBO+jwW/mUZCHhsLCIsmijrEXaFOnbwbhWf+p297mfUg5qS7TDoP+psEH/ltjEXqyRXVV80hlNQdMYQK0Mdbw+jCDdYRj7zOvfl1zEpCmMb+Ip4s3N/ce90ffOqpSvB3FbaGwUHUgZpW4KRanTk8Jj60+SwW08XKgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com (2603:10a6:102:cc::8)
 by VI1PR04MB6910.eurprd04.prod.outlook.com (2603:10a6:803:135::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Fri, 25 Aug
 2023 18:22:13 +0000
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::274c:c30b:ac8c:2361]) by PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::274c:c30b:ac8c:2361%2]) with mapi id 15.20.6699.027; Fri, 25 Aug 2023
 18:22:13 +0000
Message-ID: <4f9ea97a-7023-f2b5-8dc8-3ce208197b28@suse.com>
Date:   Fri, 25 Aug 2023 21:22:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 22/23] x86/nospec: Refactor UNTRAIN_RET[_*]
To:     Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Babu Moger <babu.moger@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>, David.Kaplan@amd.com,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        gregkh@linuxfoundation.org, Thomas Gleixner <tglx@linutronix.de>
References: <cover.1692919072.git.jpoimboe@kernel.org>
 <d9ad341e6ce84ccdbd3924615f4a47b3d7b19942.1692919072.git.jpoimboe@kernel.org>
Content-Language: en-US
From:   Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <d9ad341e6ce84ccdbd3924615f4a47b3d7b19942.1692919072.git.jpoimboe@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0175.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::9) To PA4PR04MB7790.eurprd04.prod.outlook.com
 (2603:10a6:102:cc::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7790:EE_|VI1PR04MB6910:EE_
X-MS-Office365-Filtering-Correlation-Id: 04657690-d9f4-4463-9f57-08dba59833d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fLmO65+k1AGEnHFoEtNhaoe0N4m6zQcghtETYMy3DxV5SB3oWoTkYgUTsBzonjkrUuR7wrKARkBB1zmHxHH1T4r+VEVM+v2VKYPn1/V7OYLFe86irejs2vJOyYVxmfPfgYof3cKaLG/m7iqEnJn0x4/zoNKo622LJqxS+kvG/uoJOXDL/tvImI6GadaXzzVJMp1Vi/0zBFE/NjoCuEsT7UqCJZm7VrK0U0WyzaEB4SGNBankrQhsPnnDXZdQeTYZxYUXPHoV/1rpgsQhffVibaBX+8Dc1qx7jZy7VOAlDLjlthifJNDRzrEZFDQ4+gQ0hDQGnITPResnO5S/64C7tDTd8TjZDDHYh9YjWjP0Xs3b/fgO/XDvT/+xhWDqi8Z4XgbFnfvaTHNoNnwNtR8uHkH3LPKnuNR/6Wmf4sW8yo4gKMNPjBoxWObDvf6xXxIoyaqzF9AhVVd2rt318nIsWkCcXcKLxXEwalFpN20zBT+hsq6r5JVYmbJB6zIVhDq1VzmOLiasceaTj6ByNy3qrL9icKdfh3F9bFgaIm6AsxhJCsl0Tv4/qDN66KcrREyxT4ItkJAxl41Cesbsrqz1swi0cHf2fraor7Cpa9eAtdlkOUyPQ3c9yioS6iLhJm195ctOSF3TetqsixXBQ4QGAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7790.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(376002)(39850400004)(136003)(451199024)(186009)(1800799009)(38100700002)(2906002)(7416002)(6486002)(5660300002)(83380400001)(26005)(6506007)(31686004)(31696002)(86362001)(8676002)(8936002)(4326008)(2616005)(66946007)(316002)(6512007)(66556008)(54906003)(66476007)(478600001)(36756003)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHZHUktTMVRFaTN5YW8vMERLeG5Sa2ZUczBIYk1pSWhhQ3BCbUx5bWliY0gw?=
 =?utf-8?B?VC8rajdzbFVwYi9iM0dXTENhTGFwOFFGOU9wWk5SaU1WS1o1dnAvR254bzFp?=
 =?utf-8?B?aFYyalM3NE9DQ3A3ditQWjBRZEhiSzJTQTd1VkpKczlXcUxPRlJKOVBBOUZI?=
 =?utf-8?B?THdNK29rOSs4V2hOaTBWMEpMckNRaXpCREhjNk02N1ZoR0ZuaXdtQkhRdURa?=
 =?utf-8?B?S2ZQVCtQUyt6NGNUZW05T0YxMTlsMEFjSjc3cG0vYlh2UWV6WVVQMGlUN2VK?=
 =?utf-8?B?OVhndWZiYkFpc2hGeWVHZVp5TlRkbHhVTDJmYkM4cnEvR1RwZ2x5RVd6Z01o?=
 =?utf-8?B?Rm03NHE3TVlNUWZpTzQrOVVLK1czT2pzTXdtZlMrWGdjWTVVYUZpRHU0N2xk?=
 =?utf-8?B?R3BVVXNNa1ZlVW8rSDdzaG1iUFNEQ2UzRkl4ZnlHTjMrLzBPNXRRY0dSMlp5?=
 =?utf-8?B?ZUQvK0x1RktzVytnQkU3b2J0SkZNU1NxbUxBSXlrR2V2ZGRLWXdwZ3pwRHpH?=
 =?utf-8?B?cnBuZDBud3QxSWtnelNXenpoZVdBSEgwbDFqVDl3S2ZYckF3ZXhhYkgySHNH?=
 =?utf-8?B?WmgxcHBnSXRma3hWaFdMQWdXaERML0w2c292VlI1MzNDdTBWdS9JS2dDVVVJ?=
 =?utf-8?B?RHpBRnhzZVcxT1QwQWRjajFTZkNIaGRUY3hPUjBPZjJjMmJZZUdHQlloWXIz?=
 =?utf-8?B?S0hkQWVJaW45bTd0Wm9tUGl3VTQ3KytYVzFDOGZCSDZkVlNLdEVxSFNaRjJt?=
 =?utf-8?B?cjVEUHM3V3l4V0ovUjFVMG9nZVY0S1MzdWZWZGtYaTgxamdrNWtNQVNwa0Zu?=
 =?utf-8?B?Sk0ybS9Nd1VwR0Nob2hEcGZHWHdZaEhkSUNnZzRHRlBOcEs1QkNQeDZGR0l3?=
 =?utf-8?B?b2RBOW5ZVzdFNUdZMlJtU3VrY0tHaE9VamNIS3lMaUkvb21kVllnODhhVW01?=
 =?utf-8?B?amJ4eCs2TXg4QnZBcTBFUG81MmdndWVLREJKUElIa2t1TjlKcmlRZEFPK2xt?=
 =?utf-8?B?N0h2bjZ4K3lmaERCRkJaR1g1R3hYUGt4VEpKSGNaaHJzV005c2hkK3NteDE1?=
 =?utf-8?B?RE9wT2hrbExpT2IybCtUZ2tpWEpjekIxSll5T2ZNTnFFdlNZL2Q0dUc0Y3FM?=
 =?utf-8?B?ZUQzU1daUlpVYWVEMlZPK0xSczQ0L2hHWlNmbkNJQytuQTE2Y2tCUDlsN1RE?=
 =?utf-8?B?eUhvUDBmSVpocVdTdjRraEdNbXhnSTh5SDdwK2pxNFZkd1h5ZEZZU1lEN2Qw?=
 =?utf-8?B?dUxoblAwM1o1cTVLamtZQlVxQmhWNEEzNVhwOUdtbjRVZ2N3YllSTGkzNG4z?=
 =?utf-8?B?MW9oY2hMa0cwUlVXSlg0Z1F0bTF4TzgrVVJ2K0RtWXNGK2JtUENEQys5V0l2?=
 =?utf-8?B?REg1VU5aRnlWSGRSR2ZBbGFyM2JLVnZuMnh3bFk2RGl2bXdXVmkyQk0ranFz?=
 =?utf-8?B?eVNHYjZpR3ZSQTFWbDVtbFNsTEwrcDg3bmVWSEtsZkgxaFppY3Y0NzVWNFZG?=
 =?utf-8?B?a0RDUUNBdWYzZGs2d2h0RnAzQ1dwajNUNFY4Ny9BQ25yc0J4Tm90UU94MTBH?=
 =?utf-8?B?emdEdU1yRC9KS2pDdm5IZ0lVM0RXQTN6N1VuL1NsaFR0MzVnZk9qVUhlTmkw?=
 =?utf-8?B?UVFXb2tTUlFwbjBiSDY3dWZkbHhtWEl5bmtBMytxZEhEcmdSYjlBU01jYUNF?=
 =?utf-8?B?UTJ2bDVUd0I5T1JJcDVrZkdjb1VIZFgwUmpFYXZBTHFhZStkODNIemdqa3Jy?=
 =?utf-8?B?N0gza3ZsYUdxQlJTamloY2NPRjdja2Jham9jOXBoSkdKU2QrMHRTTVFybGdj?=
 =?utf-8?B?MWNSQzRtRmgySytPL3ZJV25XYnk2aEFaZGY0N0lTRWFjY2ovRzlrRFo2V0tx?=
 =?utf-8?B?MjlVUmVHOWs4dXJzVmQ3VDhoUFBaWmdCNDREZ2RxWmtwSzNmU1dYYVFlS1VP?=
 =?utf-8?B?TGxkM2doVjNka29wNUNRbXQ2QUhadnhRYjhVeXJabkc3ZzYwdFZwbnA4cjlz?=
 =?utf-8?B?ZDVycktWOFpLNkIrUk5zTFBldE1WVDdSem53c1JIclR1YlRxaHBrMzRPMlZi?=
 =?utf-8?B?OTRZUlUyUlQrdFVQL3VsNHJWZzZMQzRLTFBnbmVlMlJqdzlDaHdoNDlGYVNo?=
 =?utf-8?Q?+RrSuXYN72deV5ESBILUCFeDD?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04657690-d9f4-4463-9f57-08dba59833d8
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 18:22:12.7493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zI4F/6qA8tuaSX9p6+Ph9CEpF6f2P+Q3iEM74Bu/NzrDgJMRHH4GSgLSIRInbRxztKFuZwuocVrOTwEQtd/Bug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6910
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25.08.23 г. 10:01 ч., Josh Poimboeuf wrote:
> Factor out the UNTRAIN_RET[_*] common bits into a helper macro.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>   arch/x86/include/asm/nospec-branch.h | 31 +++++++++-------------------
>   1 file changed, 10 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
> index 51e3f1a287d2..dcc78477a38d 100644
> --- a/arch/x86/include/asm/nospec-branch.h
> +++ b/arch/x86/include/asm/nospec-branch.h
> @@ -288,35 +288,24 @@
>    * As such, this must be placed after every *SWITCH_TO_KERNEL_CR3 at a point
>    * where we have a stack but before any RET instruction.
>    */
> -.macro UNTRAIN_RET
> +.macro __UNTRAIN_RET ibpb_feature, call_depth_insns
>   #if defined(CONFIG_RETHUNK) || defined(CONFIG_CPU_IBPB_ENTRY)
>   	VALIDATE_UNRET_END
>   	ALTERNATIVE_3 "",						\
>   		      CALL_UNTRAIN_RET, X86_FEATURE_UNRET,		\
> -		      "call entry_ibpb", X86_FEATURE_ENTRY_IBPB,	\
> -		     __stringify(RESET_CALL_DEPTH), X86_FEATURE_CALL_DEPTH
> +		      "call entry_ibpb", \ibpb_feature,			\
> +		     __stringify(\call_depth_insns), X86_FEATURE_CALL_DEPTH

so this becomes __stringify(__stringify(RESET_CALL_DEPTH)) etc.

Meaning in the high-level macros you want to pass just 
RESET_CALL_DEPTH/RESET_CALL_DEPTH_FROM_CALL ?

>   #endif
>   .endm
>   
> -.macro UNTRAIN_RET_VM
> -#if defined(CONFIG_RETHUNK) || defined(CONFIG_CPU_IBPB_ENTRY)
> -	VALIDATE_UNRET_END
> -	ALTERNATIVE_3 "",						\
> -		      CALL_UNTRAIN_RET, X86_FEATURE_UNRET,		\
> -		      "call entry_ibpb", X86_FEATURE_IBPB_ON_VMEXIT,	\
> -		      __stringify(RESET_CALL_DEPTH), X86_FEATURE_CALL_DEPTH
> -#endif
> -.endm
> +#define UNTRAIN_RET \
> +	__UNTRAIN_RET X86_FEATURE_ENTRY_IBPB, __stringify(RESET_CALL_DEPTH)
>   
> -.macro UNTRAIN_RET_FROM_CALL
> -#if defined(CONFIG_RETHUNK) || defined(CONFIG_CPU_IBPB_ENTRY)
> -	VALIDATE_UNRET_END
> -	ALTERNATIVE_3 "",						\
> -		      CALL_UNTRAIN_RET, X86_FEATURE_UNRET,		\
> -		      "call entry_ibpb", X86_FEATURE_ENTRY_IBPB,	\
> -		      __stringify(RESET_CALL_DEPTH_FROM_CALL), X86_FEATURE_CALL_DEPTH
> -#endif
> -.endm
> +#define UNTRAIN_RET_VM \
> +	__UNTRAIN_RET X86_FEATURE_IBPB_ON_VMEXIT, __stringify(RESET_CALL_DEPTH)
> +
> +#define UNTRAIN_RET_FROM_CALL \
> +	__UNTRAIN_RET X86_FEATURE_ENTRY_IBPB, __stringify(RESET_CALL_DEPTH_FROM_CALL)
>   
>   
>   .macro CALL_DEPTH_ACCOUNT
