Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 131417F2663
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 08:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjKUHdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 02:33:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjKUHdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 02:33:40 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7E0E7;
        Mon, 20 Nov 2023 23:33:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kZDtXcrEQ7VmNbZklY8E24magCvyUCV4I18DaPz0CoV+DDejjDN8Cr3RgsF6O9/aPkNwDdBlpA5Ccx+r3sDhCVxXw9qkcNnjxr8IEYslCFATZrwTKUlLTTJS+bpMH4mFj+TkcmomYe4SOtof/Hrc6FjtbZTCsI7ol7V2xVAPcNRlq5yhz2WLJfu4JF/CxDFVDNq/50QPMw4u9dXSBZwbEOS+nPrsOvmpbem8R1CHMvPeCgQpCQpZH/lw9KaSnQzCzHV52cNbAM/tWpAvi0Dnj0oa+EKmHrOHerEJpdMWC0tmnXPUWZ+UALX1g8vW4ikP1AV8pmFYzgnZNakqcMfBMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ezZipQm0TiYn50WZP0b9WGZ1zBEzj5ziV2/ciaWcAI=;
 b=bQ8cjX61OwjIsRko9qwEg3OqhAvqg9fMsYE37j/fo3KiCcYu+gy+pCf6Z5Aw0px32UGfa084WUzu+Fj7bntH3WnjbfT2eVVVVkzJeU16ZedEtuyIbwTSReAMfqC/iEKc/x7a4Y2XfkSPP2Pus1hgN7WgO1EfB9bFIBfuNxehCgtSVKQRZPruHo/Th6EascFrSODb59Tcl6Jb8XV6/xbT4rzk4xlbhD9T8Ass7efEszPTh0ah0LyGQxxQQ0o47TtK1a2ayerVKZAoZqF7tklFIZN2fGFXGgCvWz23KtsiWhDJwKTUrnxASB3aN8T9qHBqANrswFydEyWppi4TsWWbww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ezZipQm0TiYn50WZP0b9WGZ1zBEzj5ziV2/ciaWcAI=;
 b=YR0UOdeg8YJIRfwlEI2wh/620/25qbpcuQzmhMYilnzBEV0yVzqqrx6UrwCG8f+uzf35nwy205HGVXpWqEBwTuVBqodnnMu10eDZ2ZpbBjTAulrTVgzxOjKflnb9crFSTepODMoX7qhoPwGPOss+lNB6KdXQUx+B14TYOJoOydg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by DS0PR12MB9059.namprd12.prod.outlook.com (2603:10b6:8:c5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Tue, 21 Nov
 2023 07:33:34 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349%5]) with mapi id 15.20.7002.028; Tue, 21 Nov 2023
 07:33:34 +0000
Message-ID: <bd49f17c-7ebf-4e19-b77b-b5ec95375f7d@amd.com>
Date:   Tue, 21 Nov 2023 08:33:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] docs: dt-bindings: add DTS Coding Style document
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, Andrew Davis <afd@ti.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Heiko Stuebner <heiko@sntech.de>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Nishanth Menon <nm@ti.com>, Olof Johansson <olof@lixom.net>,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-arm-msm@vger.kernel.org
References: <20231120084044.23838-1-krzysztof.kozlowski@linaro.org>
 <19358871-009d-4498-9c13-90d5338b1e9f@amd.com>
 <76fa8f61-fe31-4040-a38d-cc05be3f4f17@linaro.org>
 <CAMuHMdW4WPJT0Km7w8RWrGJaztk6QDGoFAn0bdGbrEsw81R1FA@mail.gmail.com>
 <acfdce81-f117-4a1a-a9fe-e2b4b8922adb@linaro.org>
From:   Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <acfdce81-f117-4a1a-a9fe-e2b4b8922adb@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR0102CA0071.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::48) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|DS0PR12MB9059:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fc86bc5-4175-420c-307b-08dbea642af5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sTTS9Zoh6/4tc4DcdUXN8C96BKDvLe4+zT9nzzIyX/LByDQEkk2geg4i3+hosAhoU+Iiohw+PhvmDj1OSQhSPHtxBpelunzOGpe1vOCjXeqalheb56EZSuvc3lFtH+oboDC9YXdVjc8H2JV3LAjhxQg9evcf/uM9G1rHW/O1fnbCcCglYFzK6ozuD20gW8F1LYeebCt6gUKka10/eA9TuCXZQBN3KbihouR6jtIRI5bZ43ZYmRmxF7NJZ7q+YDoazza0F3pENyNMpGp2WlmkWbDEFTIhZ+i0N3ysTdR66Ol9sdHwobeUhsE6ETvuXp+bFtMZxJAQfQU09DBGM7AD6OWgHlZjODpo5V5EomsKTPZPwGSMqg51aM6VerDQw3AWow/sbls5RxhOmBYmMfUEJ6PiObjMOoW2Sw3NUHK+AN5egOYjTyPoHhTgeD8gE32ojs88TgRr28E8zNI4eGdWF+qHvuBFunJMG4kToZiFr+rAKKpfVJKVFIxOdQ3XlUedsEmayyx8EpC3vGfl7UXRnLzarlAJsYdyJcMcSKHquQtCWFEgOS47HaVuCYPvTyO4QpiJ+FCjGS5tGwaCU6KobeCTghOznIbfitFnzvU5HKf3Ij4ocrJUbzopCJnp4gB0qKflTPwNVT/AserHeIIXtQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(366004)(396003)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(66556008)(66476007)(66946007)(110136005)(316002)(54906003)(53546011)(6512007)(36756003)(6666004)(6506007)(2616005)(26005)(478600001)(6486002)(38100700002)(31696002)(86362001)(44832011)(5660300002)(7416002)(31686004)(2906002)(8676002)(4326008)(8936002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFdJMlA0Uk00NkJscFp4dktmY1hZckdLbU5xMFdFaHFURmNBN0YreHVFYWMx?=
 =?utf-8?B?SVY4VSt5QWtFSjdNV210MU9qeGN4MTdtMGsrSndGRTIra2k2UzR3RWo4N1ZX?=
 =?utf-8?B?Y3laS3E5L2N0Y0hGZWtzQUpqWFA0d011ak52WnNieWZoT0crSDFNL3hyTTFC?=
 =?utf-8?B?bzFRVGkwazJXc2tIZXNTdndXNnRUb2hTNnlxK2lYNnRPc1JLY1B4a1VtNklG?=
 =?utf-8?B?MkhhZnNPaUM0RFdzQm9SVk9pNGl2QTAyVTExcm9vT29QSUVpUlpEbnltZHZ6?=
 =?utf-8?B?d3ErblJlQlhsblluR3p5cUJRL1NlajBkQ2VEQjlSRFB0T1RLUkE5cG1Qdk1X?=
 =?utf-8?B?TTVxVFdzZnhVVmFjU2MwblFObmNwZGVoWkdDQk90a2tvWDBEZUtFb0luY05G?=
 =?utf-8?B?a3hEanpwUHR6K28vS2t2MUVtWkpieGc5WFNrbjFWcmVSVHRPZ0liZE5vU2RN?=
 =?utf-8?B?aE4reGFCVkhLcExWdXcxU1oxZWtWZUhLNTluQVM0WE5NUmU1TlpKK01SdE5Z?=
 =?utf-8?B?NEpjTUw3TGt1Nk4xVUNxbmtTcGJRTFY5c2pHbW84M29YVmN4d3hQTnFuRFI0?=
 =?utf-8?B?eG54TDJNWndWT2xNOTk1bU5pY1VuUlpxRXVEeEU0clVUcHY2MnNyVHpNbW40?=
 =?utf-8?B?YTVHU1ZDVmFZbjR2L1REZ0NPWms3TnNrUFVScmZhMjhId3lXVm9RMGducWxJ?=
 =?utf-8?B?bnlnWnI5dlg3ME5DYzVuZjI4eXhISDRwL1JLazlPV3ozRGcyR3hYTHA0dmdQ?=
 =?utf-8?B?djVIUlVmcVZVdysyTExnREw5Nko3OExEUTlYU2JvSG5rUk1hQUx0Rk81eFRs?=
 =?utf-8?B?MGZlM0p5RVAwMi8vbDZyWmlid2NUa3dCSy96UU9CMnhDT3Q2MTFJWEY0TmVl?=
 =?utf-8?B?a0dQSlpwT1NoNlpsTzFCZXRFZUp5enZ0eVpoR2FVem4wbFF4aVNRWUN2U1lD?=
 =?utf-8?B?RmNTQ2VQTk53T2gxdHY3KzlOZy9KUUJvNDVDd2lXSnQrWkdIczBPSVhGNFVw?=
 =?utf-8?B?N0dqYXRNM2pSVWVGb0lzTDJMK2c4aG1jQXNVYnVlNThRNFQvdlhDUWhqbVBy?=
 =?utf-8?B?aEswMXBKR0pJNnR0bVdDWGdvanIzNGp2c3JidEVYTXZnTm5leGYzU0t3dTlB?=
 =?utf-8?B?dnMwcmRYd1VuVXdvUjlPZEl3alVlZHdMY3FDUEt0NTI3ZVBBb1BxSnpSU2VH?=
 =?utf-8?B?RFFTcEhoTEowVFI1ZG9wMjd6MFlOS3dlOUQyRm5xazVEY1ZLQmpBZXVGWGZk?=
 =?utf-8?B?dEdwczB1UkFmQm1QVkVMZURyVWxld0pycEcyS05BVkxpSkFLRUFFd2V3ODRP?=
 =?utf-8?B?RnhNMkV1NzFpMXkwci92NlpNSVpBbkFjQ0JDSEdhSGg2dHI1USs5eHM1d0N2?=
 =?utf-8?B?bkJaZDBHSExrWnprVUlkRmxEWjdQNUNYbnhrTGtmNzdXQ2g2SGNZeUNxRVJv?=
 =?utf-8?B?Rnd4T1YzOWRUYXhEQlJSQ0IzcUpEcTBuWk40ZGlvYmY4Nmg0YUtLdTdVcEMw?=
 =?utf-8?B?clZnV0piSUNQYjR3R0FiM1d1WmxRcHByK1RWaG9SREhQSTl0VW93dUdzRzdS?=
 =?utf-8?B?SFhiLzY1R21oVThWaWZsNGVXR3UrcGdlNDZkVzIxZ2d4TjFIcW9rS2tzL0Mv?=
 =?utf-8?B?c0diZ0xmVk9KUCtwQVF3NThNcWVialJYaG9jc0swaHBTcUxkckZUQnNaaW9H?=
 =?utf-8?B?Zmd2S01QQmZPTWc0emk4aWRZY0NnSUhqejViMVRLdEs3bzhZR0NYM2ZXWDJH?=
 =?utf-8?B?bkFaNjZ5a1FUZ01OZ2NHQ3hCYTc5TThvQmZDMkVUUnpubk5yZzljOEdCUGQ2?=
 =?utf-8?B?WnhUeVpGdGtBdjh2MmRkU0UzdU5IRllVemJQcXNuTFR4N2JaUVlacXU4cDY1?=
 =?utf-8?B?ckNmZFc2Z3hDbnZKbEZCaElCY2lqSTdXWUxEK2tUTHF4R2tGQXFkdm5qNHlU?=
 =?utf-8?B?anVVWDlMNlYvcC9wYmh4a2FZVWhLZ3lDVjRiQ3puRjAwVWVuR1ZrVzJYc0JR?=
 =?utf-8?B?TUNKMHdGdk0zUkR5S1pESWRlZ0FoL0dROXpVUEJLelhZZXZxQkR2U0FxbnRl?=
 =?utf-8?B?U3JsbHNyRmVIbUtqWDFGZXpNSGMrd1h5RndxY3BKQS91S0xWTUxVMTZXQkdp?=
 =?utf-8?Q?fFrRom4kn8c6upatQXKUqm0eq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fc86bc5-4175-420c-307b-08dbea642af5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 07:33:34.4001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kUuRIiaOVgPGNsLTgCqxlQf/WmbdjaJCutmUN5Smqoj+iI8Hpti9rgn++fd6pAjA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9059
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/20/23 20:31, Krzysztof Kozlowski wrote:
> On 20/11/2023 20:18, Geert Uytterhoeven wrote:
>> Hi Krzysztof,
>>
>> On Mon, Nov 20, 2023 at 3:53 PM Krzysztof Kozlowski
>> <krzysztof.kozlowski@linaro.org> wrote:
>>> On 20/11/2023 15:01, Michal Simek wrote:> >
>>>> On 11/20/23 09:40, Krzysztof Kozlowski wrote:
>>>>> Document preferred coding style for Devicetree sources (DTS and DTSI),
>>>>> to bring consistency among all (sub)architectures and ease in reviews.
>>
>>>>> +Organizing DTSI and DTS
>>>>> +-----------------------
>>>>> +
>>>>> +The DTSI and DTS files should be organized in a way representing the common
>>>>> +(and re-usable) parts of the hardware.  Typically this means organizing DTSI
>>>>> +and DTS files into several files:
>>>>> +
>>>>> +1. DTSI with contents of the entire SoC (without nodes for hardware not present
>>>>> +   on the SoC).
>>>>> +2. If applicable: DTSI with common or re-usable parts of the hardware (e.g.
>>>>> +   entire System-on-Module).
>>>>
>>>> DTS/DTSI - SOMs can actually run as they are that's why it is fair to say that
>>>> there doesn't need to be DTS representing the board.
>>>
>>> I have never seen a SoM which can run without elaborate hardware-hacking
>>> (e.g. connecting multiple wires to the SoM pins). The definition of the
>>> SoM is that it is a module. Module can be re-used, just like SoC.
>>
>> /me looks at his board farm...
>>
>> The Renesas White-Hawk CPU board can be used standalone, and has a
>> separate power input connector for this operation mode.  As it has RAM,
>> Ethernet, serial console, eMMC, and even mini-DP, it can serve useful
>> purposes on its own.
>> I agree it's not a super-good example, as the board is not really a
>> "SoM", and we currently don't have r8a779g0-white-hawk-cpu.dts, only
>> r8a779g0-white-hawk-cpu.dtsi.
>>
>> The RZ/A2M CPU Board is a real SoM, which can be powered over USB.
>> It has less standard connectors (microSD, USB, MIPI CSI-2), but still
>> sufficient features to be usable on its own.
>> Again, we're doing a bad job, as we only have a DTS for the full eval
>> board (r7s9210-rza2mevb.dts).
>>
>> I guess there are (many) other examples...
> 
> OK, I never had such in my hands. Anyway, the SoM which can run
> standalone  has a meaning of a board, so how exactly you want to
> rephrase the paragraph?

What about?

2. If applicable: DTSI with common or re-usable parts of the hardware (e.g.
entire System-on-Module). DTS if runs standalone.

Thanks,
Michal



