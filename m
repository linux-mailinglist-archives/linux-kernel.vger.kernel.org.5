Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32976751152
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 21:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbjGLThK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 15:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjGLThH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 15:37:07 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2085.outbound.protection.outlook.com [40.107.101.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA6010F3;
        Wed, 12 Jul 2023 12:37:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SykLDZaWHFknfRG4uMcf576ywhNrhu24Kwpl6EcVoGkrFCd33vFMZTdLRtOOOIv2fNBJQI5DDZg4ruqIaEnJ0LxUp616ZdnpAdU7on+7GYiV9F7mYqAqOvKxJQvnY/MefcmQ3Tr5Zszwh2V6Ll7I0SQt+KHDnnyg7z34lCsk3YCL8APeFwsMimPDGXDH1bFpgPROvfwmcbnPMc1Ty/o6sSfIdwAJ5NuCa9SK64eiMK9KKcWJiYJEaPPRj61wMp+6IsK+i3TU4++3pb/bSKd40gSDNQ6fHDt9jHziNL4/EBX8H0ILnKhq5SqBN4JMjoRmJ0bQrEYbRPY1B4eju9uXxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yc+Zrg0+JJ9GBKa/laZzJcyEfPmPD/F+BCA4vC7LkmA=;
 b=Wip8BqyVNR1e6rVtX6d6uno/4JmD/KDZT2YNBTnL7RQG5Pkp3vQ+sQFXwiO48TeBSqVYd0gt/5TjAj4xtAGvVXFOTswyP2OELB12IjKi7LoOvjcPpIHXFa/cngxgY5vDR7hmc2jnwinL5fzsbH7Q45pDGeRDvfypcA1a66orbN6GQAkob0dv5yJgIeECY6v6cNz6MT16IvYHM4lT2K4i//a3xicGbQFRBDNdbCh6XqVA1sciCBvrDr5iPBKyN7wsWFfWE7FNq1qVjph6+Jn6XZe7NL7/keFjqqYb047dQSPbLKUpwN1K2F1eXsptf7farppabRKHX7wnIN9JgS3CyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yc+Zrg0+JJ9GBKa/laZzJcyEfPmPD/F+BCA4vC7LkmA=;
 b=rrl/MPCxV4sexLCqJWsf0Wb78q1zFj9wWjK9OAybrl7LogFWFrcd0lEY0FOoxoU+QbMJdvlJW4pse7yxurTBRRCTPObHBHkbJr07zhSMDd26q2XjgzoXA8aLLI5RNyIjMM61rVzHvNMAesqmPfey8zsV1g1YEOuSBhtPNbMjpgk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MN0PR12MB5955.namprd12.prod.outlook.com (2603:10b6:208:37e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 12 Jul
 2023 19:37:03 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::f870:5325:36eb:e741]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::f870:5325:36eb:e741%2]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 19:37:03 +0000
Message-ID: <f443880e-fad7-b61e-e832-3cd180ad3a33@amd.com>
Date:   Wed, 12 Jul 2023 14:36:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v5 6/8] x86/resctrl: Display CLOSID and RMID for the
 resctrl groups
Content-Language: en-US
To:     Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     fenghua.yu@intel.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, paulmck@kernel.org, akpm@linux-foundation.org,
        quic_neeraju@quicinc.com, rdunlap@infradead.org,
        damien.lemoal@opensource.wdc.com, songmuchun@bytedance.com,
        peterz@infradead.org, jpoimboe@kernel.org, pbonzini@redhat.com,
        chang.seok.bae@intel.com, pawan.kumar.gupta@linux.intel.com,
        jmattson@google.com, daniel.sneddon@linux.intel.com,
        sandipan.das@amd.com, tony.luck@intel.com, james.morse@arm.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bagasdotme@gmail.com, eranian@google.com,
        christophe.leroy@csgroup.eu, jarkko@kernel.org,
        adrian.hunter@intel.com, quic_jiles@quicinc.com,
        peternewman@google.com
References: <168564586603.527584.10518315376465080920.stgit@bmoger-ubuntu>
 <168564611100.527584.7981937236207103115.stgit@bmoger-ubuntu>
 <94694f76-62e0-3751-3791-936db8b7e3ce@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <94694f76-62e0-3751-3791-936db8b7e3ce@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR06CA0048.namprd06.prod.outlook.com
 (2603:10b6:8:54::24) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|MN0PR12MB5955:EE_
X-MS-Office365-Filtering-Correlation-Id: c3180bc6-ed3d-42da-92d2-08db830f5e82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v6ZH6mDzJpyqY/aUw4rb8SYq50R/clkhVgMiZwR0a2ujWnpFw3j8qcCKiQ4sRAw48SUwnnctKSq8eAAqEKKZMP5bIADVmIyzfYl7dxcoCLA+r8PbHdZmkJLDInKDO+DGbOS9uVufyu3GM1JI1V/3zNMBNooks3Od0S0n00cX4svxt74mgY9pI/KtG4lXd19Xm+EPdSKIrJH07+HdnWpizMwjZo/kRvq4F9glxxES1NWf6qx6LHxDUwshz+Fy4shcbwtJFNjyF815Z/O2B64yI4mkdKPOqktLYMvTQKOMQn3cfMSz4suhITEd/QCdKWVVFdkQ+R+Pq7YGW3Fk0YxQq02bluUY3W0NMWoWPRcFzEqSLh668+MYRw9s8EQqvv1yHlt7nxj32DnZiwPBYb3g4CcRDbMM3wWslclDNcNlVAe2rsHkWW3QnDNYOpk9+gsz3VWU0cumoyERR9kkXAzfQWTJb2sy2Gh3QDSzNxEUoyWM7AkTCkOhkENsT2Yhl2ucP12ZfmMU1psZIcgkJeNga1aUC0lmkKH786xgNUulV7HdZs+LP17NVg2OldHm8FnzKGCRH54llI1p0MBpllssJ4EF5ZbxNG9mQQ3YkgZ7MduEddrsazw+H4kxGpYhw+AYtrmunN3X8uPt1vPoh2rnpA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(366004)(346002)(376002)(136003)(451199021)(26005)(6666004)(6486002)(478600001)(53546011)(186003)(6512007)(6506007)(2906002)(3450700001)(66946007)(7416002)(41300700001)(66556008)(316002)(5660300002)(4326008)(66476007)(8676002)(7406005)(8936002)(31696002)(36756003)(2616005)(86362001)(38100700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVNhdXJoREFqWHNtOGRMMGMrY0FmTW9TYnJ4STAxWXFNTXd4eTA5ZFM1d3Vl?=
 =?utf-8?B?TEhzUWxGREdCaWd3L2U5cngyZXBmUVNyc1ZrQlV5bUx0SWRrWm5kbUlMM2w0?=
 =?utf-8?B?TkZZaWc2aXVzeEUxOTJqS3ZFbkxIRE0wcjVxbm9yRHJ4S2szbGZQTG9rMWR4?=
 =?utf-8?B?M3pxc0R5UkovZ0duWk9KT1piSFNLNVhFamhsM1AxOW5pb0RIZXNvNkpaalFn?=
 =?utf-8?B?cmpvUEtPMVI2Y1NDaU1xVHdSZnRHUnFTV3Q0SnlHZnI0Tjdta2wzamE4a1Vz?=
 =?utf-8?B?dHE0UWlDREpnT0tzSitzK3h1azRvZTUyOGdYVGZaYURuSU84WHl6RGFpTTNO?=
 =?utf-8?B?Z3dmdHN4YTRLVEZCNy9RN1NJNnRNSGNOOEFnYnVkd25HNFVJNEVlYmdXQXVa?=
 =?utf-8?B?b25WcDBJbktXdDlZMWlROTREd1FoYmgzSkNvSis1Y1RBcGhzeEpTYi8wdXF5?=
 =?utf-8?B?bktPclF5MjRMUS9JVzllU2JVRUpNMFJjajd6RFJVN05WaWNvUjFqbWEvVyt3?=
 =?utf-8?B?cldBMmdFUXJudW9SbVFMVUgzY1VnYm9sMTBlREs5RUdxTUF2dDZ6OXNCNmJ5?=
 =?utf-8?B?bjdIaFAxeHpvUERXRXBMSHdLeEFQQjA4NzYxZ2Nubk5nMnFqU1hFczJXM1Bw?=
 =?utf-8?B?dUhVUEdXUXUxd0pxeVRhRVlDUTY0V29PZkhvNFFMaERJcGRCRmhhUXpOQnJX?=
 =?utf-8?B?KzlRcFVxM3F5SHlpU0ZaU0hFRXpUN29oU3dHbTVoTTJlWm9ZenQyK3F6ZS9u?=
 =?utf-8?B?MkhXMUxxQ1FzQjg3RWM5bUJoSUFkRFdPK1dHd1J4YWZVSTkxYnh6MWZmd1BC?=
 =?utf-8?B?VGZjNElETUJtSVd0YnQwcVhNbVBnMWdqVGIvdUFXTkxVYjB2OC9FRnNlcVFU?=
 =?utf-8?B?Y3RISkN3T2diL0xwYWRxckluZU5VSXBlaXdsWTFVUGo2Q2IzNUkzQUJZcVZm?=
 =?utf-8?B?TFY5eG9xSlBqNk1MM1FsSVlMQzg5RFFJa1RrZThYZGlwc1VtNldoWDN5eHEr?=
 =?utf-8?B?YWNsczh6YVdFSk9rdytGdUNIUFpSKzN3ckhrMmZSWjFka29EanFvbVREUGdC?=
 =?utf-8?B?ejdzRVA4L1RiK1hPRGhtcCtPOWUva3R3S2hCaUhycVpaMFYvSmxBT1p4em5K?=
 =?utf-8?B?OTFlVUF2QkhqMDdSYTlwK1JZT2NsVVFkcU5sSFI0SDg2M1c1czRqY0dTNCta?=
 =?utf-8?B?RzRGbk9HaXZEYTlFYk9jYWI0RmVQQVhoOHJIemtjbW56UUc3anNDMmR0MXUr?=
 =?utf-8?B?dHdRckpaTHc5dzdjSnVwMEJlMXliRHpNYWFsRCt1YXI1bHdIcUxrVll1cVRX?=
 =?utf-8?B?OUwxRXhQVmo4MXdWbDNZcmpybHdNdzkwTWgweFZLS3JOblo1aUtuSk1tbHhV?=
 =?utf-8?B?VkN4akVHajVzZ2dkR2hnZ2F0dVczTy93UDFEb3ZLRDRZcVR6WnNSKzJtUFdM?=
 =?utf-8?B?MnVMMGRJVnlyRU5IWHVoYnBQcC9JOXlJMG0rMklJa3dLU0J2K1I1R0g3SXJB?=
 =?utf-8?B?T3ZwOWQyTlpkQmZTSGhZY3JIcFpzd0lmek5YNy9qMzZkKzFUUk5BQ0hmU1Fh?=
 =?utf-8?B?TWdvNEVmblE4azQ5ZmVJQ0NWMHEwNHMzR0VoUStHSDV5U2JSeXl0VlpNTkN2?=
 =?utf-8?B?YisvWUVOa3lrbkliVU1qWE01NDdNOVpNTWtsQ3h2R2ZTRzhkcGdjZ0lyK0x2?=
 =?utf-8?B?Z1phdFBmd21VaC83WFNhMVJrLzRTMlBONWFEcldNNkw2WU5EMzR2S09wOHI1?=
 =?utf-8?B?Yi94ckdrcHB2SzVlRXNNbzlDb1I5U1RvdFNVOEIrV0pIL1FyeTF0MlRtVEZa?=
 =?utf-8?B?cGhxaVBTOUx1Q2VUdnYzVWRFampUNHZ5TUF6SU5WS1AycDdUU2pseGUvUFFW?=
 =?utf-8?B?OHlhRHFXZy9GVW95UVJTOE5uMkNUM24xWEVwdEJobnlKQ3NJWEN2MFJzbllP?=
 =?utf-8?B?QmtMZkJ5cVdITndHdXBsOWQ5OStiTEk0VjBCeHMybFpORnFCdXNiMWVMbXlr?=
 =?utf-8?B?TzVKL25oWXJpdzdqT3ViWmZ5MURKY1ZCd0RiWE4rWTA0Skw4eUFYRnFWMXJQ?=
 =?utf-8?B?amt2UnlTd0JrbGlUVit0UG5ZNXdjUElnbG5wTHlhL2djNjZhdDdOdnhZeDFO?=
 =?utf-8?Q?NChk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3180bc6-ed3d-42da-92d2-08db830f5e82
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 19:37:03.8134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GF8V9DDe9/HdbH9IAbFGGBfgnvt8mtLMRQU2xPjQsXi85SG6Ln/Atpql6VGNAfzx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5955
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 7/7/23 16:45, Reinette Chatre wrote:
> Hi Babu,
> 
> On 6/1/2023 12:01 PM, Babu Moger wrote:
>> In x86, hardware uses CLOSID and an RMID to identify a control group and
>> a monitoring group respectively. When a user creates a control or monitor
>> group these details are not visible to the user. These details can help
>> to debug the issues.
> 
> "to debug the issues" -> "to debug issues"? Even so "issues" is vague,
> perhaps just "These details can help debugging."

Sure.
> 
>>
>> Add CLOSID(ctrl_hw_id) and RMID(mon_hw_id) to the control/monitor groups
>> display in resctrl interface. Users can see these details when mounted
> 
> "when mounted with" -> "when resctrl is mounted with"?

Sure.

> 
>> with "-o debug" option.
> 
> Could you please add a snippet to explain the file naming choice? Just a
> mention that this is done in support of other architectures that do not use
> "CLOSID" and "RMID". 
Adding this.

Other architectures do not use "CLOSID" and "RMID". Kept the names
ctrl_hw_id and mon_hw_id to refer "CLOSID" and "RMID" respectively in an
effort to keep the naming generic.

> 
> Considering that, "x86/resctrl: Display hardware ids of resource groups"
> may be a more appropriate subject.
Sure.
-- 
Thanks
Babu Moger
