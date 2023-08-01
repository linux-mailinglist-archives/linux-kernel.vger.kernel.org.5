Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9167776BF4D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 23:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbjHAVcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 17:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjHAVcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 17:32:05 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A14CC3
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 14:32:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W8/97rh7dopECzP/Y9HZZbEV55jJaGpUgS/ZY73WBR9oIXhVQv0L6MIglU+EkvUgFlZ3+ovu9kiwuIQqNlTmzVnGRJpVBSGG5EvgaT6Ve1utkQQby8eK/6DEG7wFFaHiKmsbq+F06mDG27gsCe4hvgs5QhXhSAnqS4gY63X0LXnqomlJoQ35Cpc7WwmMQziVm2qlLeN7g+fhn0FHzGuT3e+ucnnVkkbx6CJsiIHwv+QKj17suEu+/N7+wHwkHWpct6VqBTB26nPt75XbqFuLqor+ui8zlC1wfoCTYlnitseeFOPg3L7ZEPsehBKH7piX4DgteTnq+UYOb0wWinHxEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lOW0Ex0ibZiTxuZAwmGIT+jG7EbVhVZPyH0DUfImCCQ=;
 b=MUdkyP/07rHGFaOv58NOdw9j/Nk2JcFQL5RykZpR9LWktq2PmwdOqEBvEQhMU7Qh7Bhkem5YSaKrV/HK6QtOxfJZ4VgzsNypxxg4RrQeKIhf3LAi9if9UaN/Q3sWSHKIhsXaZ6zLmXvNmV7zRFujdbpetJ81EF0wk9kgXXzGRunJCFubl77YAfBrN8CCkHS8T2RY5OjqQxedsDxpU6aiDDTeo3mu8lgbeGz1Kb/WhqAI++tuB9FJcK2UFOMqvd4i4tGnMjzvENKKuboOdYqQRZy4GvWAgf70HgOB85T9x93tMPBpHSUEh3x5d7+MvjCgv/riI6XGPXQhDoyes/KpLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lOW0Ex0ibZiTxuZAwmGIT+jG7EbVhVZPyH0DUfImCCQ=;
 b=16SBVBVrXeixX//GbzL1opppm6Oy7ojy5EhVAWMJd5iqfmP/4FR5sXG9IUxolCiAN0dfxKuabLwSXxWIyyRX/+z69cmgw17QfVBA97arV06MSGe4v4IocMuHJxGR4BR91W57bCy23Y+3oMfphrrJJldJEgMSTXM1pvHi8UXDyBg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by IA1PR12MB7543.namprd12.prod.outlook.com (2603:10b6:208:42d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Tue, 1 Aug
 2023 21:32:00 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d267:7b8b:844f:8bcd]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d267:7b8b:844f:8bcd%7]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 21:31:59 +0000
Message-ID: <e9213337-65a6-c8ae-05d9-ca6838278597@amd.com>
Date:   Tue, 1 Aug 2023 16:31:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] x86/sev: Fix SNP CPUID requests to the hypervisor
Content-Language: en-US
To:     Dionna Amalie Glaze <dionnaglaze@google.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michael Roth <michael.roth@amd.com>,
        Ashish Kalra <ashish.kalra@amd.com>
References: <a5856fa1ebe3879de91a8f6298b6bbd901c61881.1690578565.git.thomas.lendacky@amd.com>
 <CAAH4kHb-7vjsKYQ-JyHZDyKzX857iN+5K1yY9AC9O2yHyBM35w@mail.gmail.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <CAAH4kHb-7vjsKYQ-JyHZDyKzX857iN+5K1yY9AC9O2yHyBM35w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR05CA0016.namprd05.prod.outlook.com
 (2603:10b6:5:3b9::21) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|IA1PR12MB7543:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e4faecb-dbaf-4b89-d814-08db92d6bd16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1BYmu6PL1qSMILN2yx3BD5dRfV/aTQdEc4ecHDwBMyfN1FB5FKmcuVjpqulszlvWo1ZBxEB1pNQrYB2ZuPMpkTqB4HqZ9imn3AajE90i0+Bs8q+nXkAbT3xg5dPiy96oR5Cj0kQ8JWoxI6iANKL1pyEZmIaLfXQt4k4EYDpFlWknO/N66TPMptIjPIUjoErLcJx/8xnPyTT4NPTW+EcXy5SA3Q5HjLmHTjYLgyPkAhAmwbTlvHH5+vuAOS1yJh668lODqXjOCI3NQxqkclele7it/Exu7M67ztFOjvxai5/j30eDqUdkreheqWbtx0qNuV3M6Gz4ObgeTup15JakOMJ1BB7CzlFXF4gHFNACFVjBWA0n81xdu8giwbsOAxLvOWpYsAm6PrcP2XqJqfEJrgdi/UFR88OwL5YZzKPxvdZa98FrCTQHg87C1u7MWKUmQC+zm51adyftzOjSMxydC659eCy3c/ICr8cXjNeE7gmqu4c30Ot9sGcqbzWd/KAnaDI28CXjdgWHKEqCSuopkeZ8vcIpyQMdszSGjtlGzxbMsb0kzQZgPBYyOAw3vGqycQyrXUTGrycq5zojDPDngdz0h6nOD8uxqafPHpQifuserY0GpcS/YZMwXaVsmZ12gidVV6Z0cUMuRq+Q7DFVlg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(376002)(346002)(396003)(136003)(451199021)(186003)(2616005)(36756003)(6512007)(316002)(478600001)(86362001)(54906003)(38100700002)(66946007)(66556008)(66476007)(6486002)(6916009)(4326008)(31696002)(53546011)(26005)(6506007)(41300700001)(8676002)(8936002)(31686004)(5660300002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjZCSnY1ODhQVnZ6UXF4eXdTdDRuMzNQWTY1TVRtNjVjMUdwK0tLeU1nMXlL?=
 =?utf-8?B?S29iRGFaZk9kWVBrcklmS3RaYjZUS2tLRC93cVh3a0NnRFVYcithSGpma200?=
 =?utf-8?B?alNla0Q2RmI1aG5kWGlSOWRMRUZYcG5FeVlTWWFQS3laT1IraGYvRlNGdk1Q?=
 =?utf-8?B?VC9OeHdObmVTRUFBRWRqcUZqU0l0VHJZTGxwSW5PeGRrYmxVenFIbWo3L2wy?=
 =?utf-8?B?MFBiMG56WXlaaHRMYllab04yVktYejRKY0p0RG1TR1JQak9ZUmh6dWdMRFVK?=
 =?utf-8?B?RG5kLzg1WDNNd3premk0eGM4ejdlMUNVQXhzSG5CeUdhZnRDMHZiMEl5ZEd3?=
 =?utf-8?B?MDd6NWF3NmcxbGJuR2xNR3E0UUQyYVZsL0pab3J0Y0wvdkpDR1ZKRjN1bEk0?=
 =?utf-8?B?YW9UVmpCbS9ac2xhYnk0ZFRvMzkwSVBITFBuM3VLSG1PVzgvZzk1NDF6VWow?=
 =?utf-8?B?ZlpNNk1DNWdVL2E2OHllSVE0aGhYdmRCeG04aGJvYVpxekJyQTZtNzlwdGx6?=
 =?utf-8?B?NTBSZC95WEkxZkJFMTEyakdIajhDbmZrS3JsTXpSSzFUTDJNNXYwWk5FL0Zw?=
 =?utf-8?B?b01SN0dDWHRlWS9UUTFSeEJheDRzNzZ5cEx0OVJCYU1aTlhiQlIxZ2xkWFVH?=
 =?utf-8?B?aVN0TFRlejlYOXU0dUEyNFpsemhTOEFKeTY0SlZUaW1NTFdUbklRbC9PNjcw?=
 =?utf-8?B?MTY3VjhJOGh0WWsySE1JMG1PeVNBZjZEWDV4V2liREdTb1ZHOXE0cmJRRWI5?=
 =?utf-8?B?TzI2VUtvcGhkVUFjSCtNOEtuWSsreUV0bzU0bUVTYWZVMmFhRHBTQXZNWjBD?=
 =?utf-8?B?dGY4eGRXOW1rcmZmeVdqTnN4RXFhbncvWmoyc0N2QjRSSjhhMEkzU0tLaDBn?=
 =?utf-8?B?cHBCbXVrSG5vcWtKNWRXYTYvWDJXbGEzb1lyRGF0L3EvQVlONnFMcGRTYTUz?=
 =?utf-8?B?c1UzaXBXUSs2TWQ1Tld5dzhXbTVFeTFzSzVYTlU1N2lzampaRHU1aHBWSFhI?=
 =?utf-8?B?blhmRWJzdmdPZCtsZTdOd3lUV3ZaQlRYKzhCUVhTakF0Z0M3TmxRcnlPcUg2?=
 =?utf-8?B?dUZua0lxRE5BU0cwSzBpMmFnRituTkIyZ3pYMVdPVUtMS0NvSExBTTRYNWdP?=
 =?utf-8?B?MllsUTJMTzBINlpya1hIc2R0N1lwNzFEbHBqcG0wYTlWVjNWbU1kTzNJdEVW?=
 =?utf-8?B?SmV3VkFMVk44Z2I5OW5UZXR6SWNmV1BxekNMdUsvUDBac3liN2hJemlCYitE?=
 =?utf-8?B?cjA1dXZlYlZMTUtaaEVjTmVhaTZ1VmRDSythb0NOeVdBNTA5R3hBQU9IUnhl?=
 =?utf-8?B?aXhURHd5bjNwT085dlUxNEdFcU81SUFKT0NzOERXUVNYUWJmM0tsS1FueWdS?=
 =?utf-8?B?UGtPZ3hsQXk4d3FkcE4xd3YydHo4NjhEU01TVTgvRzFTUmlQSlJFWWxOakh5?=
 =?utf-8?B?TW9USGN6UWc0bDdJTnlSVkU3N3hhREgydlZCQ25MeURxaS80c3pIUEo3WFor?=
 =?utf-8?B?R3lpRDJzam84L29ucUV5MzEzTllqd3ZsYk8yU3RSdWVqdVhxZVd5eThtUlY1?=
 =?utf-8?B?V3lFMmNIT3h3c3Nzbko4MG8xZzhidW5DVGEvaHlhcDJnaVU0NlBDdTRlNHYw?=
 =?utf-8?B?YlpuYW9yRjJ3VUZmZGZwMHo0dUtzS1hjdjFXN3hoK3RzTTgrUC9RcVdQdG9i?=
 =?utf-8?B?eDFtcVE5eHdXYTg5d0tqU1BVVEZadDV3Q3ByNEF2cE5zWU9NN0lKWTVvN0Rh?=
 =?utf-8?B?UTlxaytYS0hFMFROWm51RVB2Tms1QThjTDJvSXFNR0twOWFyLzhZb2dUNVRx?=
 =?utf-8?B?OGpxeUUzVjg2OVBUUWtlT0RoTFNIbFV0N2hFZGhxQTFNak9tTCtPbzRWeE1C?=
 =?utf-8?B?Z3VoVVZUSGE3b0RncUQ0Z0Q2VXRUYXNsVjkxMjlkTEk5K2RYbENXdXNsYWFS?=
 =?utf-8?B?a3VRbzdxUExCb3llbDcveWlSRUJhUTFVSzNMZVE3TTNRSDBObmEvaS9HbUp1?=
 =?utf-8?B?L1NrWlgrMWR1S2FUZk5POU5rZ1hvcXVTeFdjZFFtRjdDcEkrdGxkOE93RXFu?=
 =?utf-8?B?RjAvdmhZZUtYWmhYeTZLZW01bGJNdWpSTDVsZ1RRYVhKUndVQkJ0VUJPcVN3?=
 =?utf-8?Q?fcWBiuA5S5xcmskO4D/zmLGsD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e4faecb-dbaf-4b89-d814-08db92d6bd16
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 21:31:59.8405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eZkt9Hw6X9KnsbuyLSaxff1LWFZvRpo2cV5uwfXfEDhjySacqY6dvMSJ+8dHHWvxaMYeaP+aREnxZI0XTVjR0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7543
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

On 7/31/23 22:58, Dionna Amalie Glaze wrote:
>> Fixes: ee0bfa08a345 ("x86/compressed/64: Add support for SEV-SNP CPUID table in #VC handlers")
>> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> 
> Nice catch.
> 
>> +static int __sev_cpuid_hv_ghcb(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_leaf *leaf)
>> +{
>> +       u32 cr4 = native_read_cr4();
>> +       int ret;
>> +
>> +       ghcb_set_rax(ghcb, leaf->fn);
>> +       ghcb_set_rcx(ghcb, leaf->subfn);
>> +
>> +       if (cr4 & X86_CR4_OSXSAVE)
>> +               /* Safe to read xcr0 */
>> +               ghcb_set_xcr0(ghcb, xgetbv(XCR_XFEATURE_ENABLED_MASK));
>> +       else
>> +               /* xgetbv will cause #GP - use reset value for xcr0 */
>> +               ghcb_set_xcr0(ghcb, 1);
>> +
> 
> Everything looks good except I'm confused by this last comment. I
> thought xgetbv would #UD if OSXSAVE isn't set in cr4. Is that what
> happens after you set it to 1 as some kind of workaround?

Yes, after checking the APM, it would #UD. This code was copied from the 
existing CPUID #VC support. Not sure it requires a new version or if the 
maintainers could fix it up when applying.

Thanks,
Tom

> 
> ....oh I think I do remember hitting this weird technicality when
> setting up CPUID support. I think it'd be helpful to document a little
> bit more why the ghcb's value is xcr0 is relevant at all when cr4's
> OSXSAVE bit is 0 though.
> 
> 
