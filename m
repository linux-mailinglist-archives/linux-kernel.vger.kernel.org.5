Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4666679D404
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 16:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236083AbjILOtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 10:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjILOtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 10:49:14 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E397C12E
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 07:49:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XXomK1xZLDI2vvpHdRNocIdd+ljH7E1rbNrQDkGT8ho0KRw5NGNq+Gn41NTI/SFWlVSQR+7BTKOuyWFtllDqlTukWpvTvtGqkHvKZl5n9/J+SCqJchLyq+qu4XxZIIQZwQcSNOu7EngZ1+hX56130mA0vi1cXFt6WyjKNL6PrIbu2+X3NQyxIGwjmXde0AdoIyPhR/xRjVTfMA9m1mbjSkQhnjuz0Oov+2X3+gdV18uWs6OUu6w4CR8eODbjqlLztMseeKv59ABeBN3VMgHHJd4aMs19CxX+8z372nhAVUnP9SgBExicJdtvqZktjWwLbjIudqXPBc5f1gMT8RgztA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PskZWKUYPcCgAKOWFxpFNtsphMJ7095HeUCeurDD/vg=;
 b=e9/KxZqw7y78GcAkw/lmaytqNfgb5VzvOF7vAptgQOkiW3k3L81RLtU7hRSnhd6nl41n0KvGy1S2KmzybRgpo0lmSBs4ZphZJwsBn/PNNMchXVwsVRAdYMiE2NW54lYVyapFZvJHaD5QYKvEUnIqWAlLy3y8ZJ37VYG4GUbVnxqBe3HIgEsjlzKvONtJqyRAJRZDPaSogaiCNOfX6wzenQzpSQLUk37Atm73gi0AMq0Tb/v2MRweoEpBPybTR/bGFKLh1PqI/hTYadKESGiQDbgAxUjrYtgBBw7ckESv8FUNuEKb6D5QFy0LEgkqgLVrJd/jUlaB3ntIPSDaDnOkUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PskZWKUYPcCgAKOWFxpFNtsphMJ7095HeUCeurDD/vg=;
 b=lUkl9HWiofU83MZj0oUCkErTQC/Ct2EKmF+Ua9nsewJPHZBcfNu5n3ee7VUtJF72Mwa4VAYY6NVF2ql5Ab3IfokIp/KTQCay4huc18GfaMW306MLTmbeZXcQCtijzZct16xoKMrXOoxO2LuGectLdfw1F1oi7+rPIlS94OuVOuE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by IA0PR12MB7601.namprd12.prod.outlook.com (2603:10b6:208:43b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Tue, 12 Sep
 2023 14:49:08 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d267:7b8b:844f:8bcd]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d267:7b8b:844f:8bcd%7]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 14:49:08 +0000
Message-ID: <1c934f15-cc86-714f-e9d7-d7fbe29890dc@amd.com>
Date:   Tue, 12 Sep 2023 09:49:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v9 5/6] x86/sev: Add SNP-specific unaccepted memory
 support
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Christopher Schramm <linux@cschramm.eu>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Roth <michael.roth@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Dionna Glaze <dionnaglaze@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <20230606142637.5171-1-kirill.shutemov@linux.intel.com>
 <cover.1686063086.git.thomas.lendacky@amd.com>
 <a52fa69f460fd1876d70074b20ad68210dfc31dd.1686063086.git.thomas.lendacky@amd.com>
 <101c3910-a164-4b4c-9474-8743dc6d1199@cschramm.eu>
 <905c359a-19d6-6cba-4540-92d03b936525@amd.com>
 <20230912121719.6i6ojvbb6ptw2i2l@box.shutemov.name>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20230912121719.6i6ojvbb6ptw2i2l@box.shutemov.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0100.namprd04.prod.outlook.com
 (2603:10b6:806:122::15) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|IA0PR12MB7601:EE_
X-MS-Office365-Filtering-Correlation-Id: a342ddea-413f-49e8-85cd-08dbb39f6b11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UDqxgacWR0RaQeMkKdzkGznwwe30Q6lDwGjCymz5uwwIxx3//J6YeImw6+ne4l5j1OaHzC3ooBgTIspu3x+BQ+jsLb39pk/BNf3N/sQTDd9WDu5SzItDbPeJ3pp86tfmk4Tsy0SqJz7g78BSoB1YXLcldmn57qMsyeff2djNIAk1c1U+GnYoVImWSXrTdnq47ifo1iXTOEHa9qgAKjmFc4dE0E497qQy2/JmAWzUCXsjK/KS3GFQhq9Z+t0UhoOeLiO3I6oxJ1pHI4IB6rixAuUSqvSgBKdsNcdd9HEiGDmMOr8BclCbMq4EOl0xk9VwMWip4j3I9doNKmx/8GZ80hTQs/UCrfpFXL9A7svM5SCuhX9gCsODFx6fWbhIcbOQ3WBd9ByjnbOs3Kr28RF7cs8B6aPk7csPJIpAIZY3pd4XGGYQS1848QeF3hwmwXArzQWhMGgBL5kJd/p3pYxjQMhtT2l0e2v/wI64dft512+xfe7y9jAOOEGOidTq+LcZEhPE96WC4hDbVFU97TSydKXeUEpyypnBjYEzEr6NOTJM+HWMWduomd/SzQ28PdooDn7dP+2f/oBAYUHK211UY4QtX+ANx/QvEAmL4x/oIV9TFFv+xbLFpfzAwjWAUHLiGpVlAoh9y/kGlRtI8s2JTQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(346002)(376002)(396003)(1800799009)(451199024)(186009)(66899024)(41300700001)(6486002)(4326008)(5660300002)(8676002)(8936002)(6506007)(6666004)(53546011)(6512007)(6916009)(26005)(478600001)(316002)(66946007)(66556008)(66476007)(2616005)(7416002)(2906002)(86362001)(31696002)(54906003)(38100700002)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eExKV3dPTEFVUVZQSkJIRXExeDVYWTRlZXpxZXJPRjdHVm1CbVN0dDN2bjds?=
 =?utf-8?B?d2dqUjJQTTZQWmtyRTRpS1RDRk9YMnFSQ0R3VEhxbUVvU012UCs3cXJRSC9v?=
 =?utf-8?B?QTB4QVg2ZmlNbDB5amhOVlUycUlId2NSdlF6TWNTc1JEbDdRTnlJSm42cVdm?=
 =?utf-8?B?MU5WYkNLYXR0VE9KaUpaYVFyN3Frd2N3V01UWTZlWmpHNzBqbDBzRE5vQmV5?=
 =?utf-8?B?c1dyWVNPdUxJNmFoRUJHVWxNV0lOVzFONkUyOVdPS0RDd2hrYzZGRWtrMm4v?=
 =?utf-8?B?cVpXWGRrRUR6TVI1QnJON0piR21hVmRVd2lMa280Rm9IUnhZMTdhS3hXdVhX?=
 =?utf-8?B?Rm1OeWJLcTNoZGFPdEdwZCtvc0pROXBZOENGYjhRYVRkTHF6Y1ZiNzZDNE9h?=
 =?utf-8?B?ZnBIMEJXdEZ1WEcxQ3BhK2oxMG42NUI1VEh4cHZjZlpWYUErbnpuZ1BBNjc2?=
 =?utf-8?B?VTJtbUlPb094ajJkWkpNbHI5bGhVcVhzTUVybFV5Z3UxMlFacGV6UkhPVnlk?=
 =?utf-8?B?cVduMmd2REhmZ3RhL0t6ZGdVckd6Vmh5S0o2TXJIY3E3SG9DL1JXZ01xcUVQ?=
 =?utf-8?B?VnRrNFROZ2U2MDNtZVNRaC9sbXpTN3FBbjlXVWxsWklOeHBqY3E5QjMyS3Fq?=
 =?utf-8?B?bXJmdHZMM3pmczI3d1AyQ1VUMGkyc0RGdFFrbnJNZFcybm5LLzh0cDk1SzQ4?=
 =?utf-8?B?d2FtbnFBM3o3MTU1d1JRcUhDZ3orL3hYQnU5Vm1TeTJMWW93bldPZitMbnZs?=
 =?utf-8?B?V1hVRHlON2Jidjl5Q0hIMXdWZ2xUNzZ6UGUvTUYvM3ZtaHpHdmN2a1lUODhZ?=
 =?utf-8?B?NXU4VzVVS1hGdzYxMld2dWt2azNpbXZubXR1VEpwRUZqMld2NVNHeDNqMU9V?=
 =?utf-8?B?Zi9PQmlLdVFIVUVzY20xeXhNeHdIZlZrOGhxZTFueXRvWThha0RscWl5ME81?=
 =?utf-8?B?SHZ4d0JlbmVsY3RuYk1QRERuc2ZnS3MxQVl4RVJwdXNEMktHK2ZRZnVpS0VJ?=
 =?utf-8?B?SFFZcDFOUTJzWUVjR3lud2ROQisvZ2xuVVZRQnFGVVg5bWlkNEdkd1FUZExz?=
 =?utf-8?B?Vnp3T1gyRmVzakdJRHRTdGxyU1pPMlBNTUQwUVI2bCttbmtrcksvTHl6MnVL?=
 =?utf-8?B?aEJES1N5UUVQSC9nZmg3ZlkvcWVCSCt6N0NHY1FFVFBMVTNoR1EyM21QcUxt?=
 =?utf-8?B?d3QwR2Y4eW9KKzRCSFhoVU4zZGdJTGw4WWYwaDRHc3A4TEdiOU14T2FIbUJI?=
 =?utf-8?B?cldKMjU0N2RMeHNWWHdvdGhLV05yK0RVbDJxRjY1bjhHVUllNE9QemsyNHdG?=
 =?utf-8?B?cXU0ZVVBdDFkK2h0WlRqbDJybGdiK2NnTVA4VHZXY2FYMWdEQW50VXRkYk1V?=
 =?utf-8?B?RE9pYVdESHUvT1ZROWQ5bnNDZXNkK0xsTmZSUHV1QmNmZEFqams0SzJyaU9U?=
 =?utf-8?B?Z3UxWkQ3NUc0c295OUU5VnVtd29Xa1p6ZmNZb2Y1YTNQY2ZaOEJMdWsyaWVF?=
 =?utf-8?B?Q3hCMzIvMkRjc0lPM3M5MERsei9vUjBmYnhHbzJZNFE4RUN3T1lFS0tOMngx?=
 =?utf-8?B?bDJOYXRBcHNNWTRCdzFhYUhSTGVGTVhlOU5GWmxEV25kZm53eEdBdkxwa1lG?=
 =?utf-8?B?OTVaeVBPTHhKRHBWNGExTkEzZFMxbXhoZGliczJyQURMN1JZbGxxOU52SXE4?=
 =?utf-8?B?STlRU1IwV0daUm9EUWNuS2VQWDdvdy94NmRJcGlNWnpwOXphU2FJV0NJR2NM?=
 =?utf-8?B?RGRlYW9VNUpXOXYzU0hYZ1FYZ0t0MXZia1pmUHBXcVRKSXlML0hJMUgrODN0?=
 =?utf-8?B?VXpZeVkxSnR3a1M0UGdrcE5uNmdKMkdvRHpsMzA4bjI1TEpucVdzQnAvQzB0?=
 =?utf-8?B?Z3YwZVNIaXJqbmV1QytjVE5TYjYrV0tBQ0hIK3gvYlNTOEorS25vWDI4aURD?=
 =?utf-8?B?MnFkOS9wOWpuR3pnZWRiTjlWTmVzTis2dW1iSllEWU95ZlA5TTRWRkNFWWRx?=
 =?utf-8?B?bEsxTDMxWkpkd2xaTTRmZ1d5Vm5GOG9tTGtiNldMVWpoQkEyYkdVT3VkMldB?=
 =?utf-8?B?a2pQK3NRMGJsUm13ZUUzOXZmVUE0TDZZdmpXMnVYOHFMakZwUXVxMXBOWFpC?=
 =?utf-8?Q?z3hANu6wReqjyZVsMwK+YjPmG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a342ddea-413f-49e8-85cd-08dbb39f6b11
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 14:49:08.2845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fcSMwAF9ka/hGZnuJQTTFb8fFj9VXeZDaztLAV51QntWa9pDoHD1N0RQskGOoErUE8byQZMFRRXEQBLOpjBhwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7601
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/23 07:17, Kirill A. Shutemov wrote:
> On Thu, Sep 07, 2023 at 11:50:15AM -0500, Tom Lendacky wrote:
>>>   From a quick look at
>>>
>>>     [PATCHv14 9/9] x86/tdx: Add unaccepted memory support
>>>
>>> it actually seems very similar for INTEL_TDX_GUEST.
>>>
>>> Ideally UNACCEPTED_MEMORY would not assume EFI either, but the
>>> implementation actually clearly does.
>>
>> @Kirill, is this something you are interested in having as well?
> 
> Unaccepted memory is an EFI feature I don't see how UNACCEPTED_MEMORY can
> be untied from EFI. If there's other (non-EFI) environment that has
> similar concept, sure we can try to generalize it beyond EFI.

Sorry, didn't mean to include the EFI related statement there. Agreed that 
unaccepted memory is only an EFI feature right now.

> 
> TDX guest is only runs with EFI firmware so far, so depending onf EFI and
> EFI_STUB is fine for TDX>

Right, SEV initially only ran on EFI firmware, but others have managed to 
get it working in other environments. So I was just wondering if you would 
also want to split the UNACCEPTED_MEMORY out for TDX similar to what was 
suggested for SEV.

Thanks,
Tom

> 
