Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 932787F2C18
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 12:54:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234334AbjKULyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 06:54:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234196AbjKULyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 06:54:16 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC83123;
        Tue, 21 Nov 2023 03:54:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DoIHV2AYx0OdxDyjxZ+R0yanDdGPtdP29RtyPbDN2NvgPp1W+rhrt35LTlfmlMrpPZPH0xFFtBlTldud8CuvblBcx4x/7PD7tma6QfTILlxgwFM5unkik/lJonhSO3xNajeZFYnnGX6KtX+QMFO+7hWrJuGUc/M1yyLfaVSgocvomX9YyAf2vFps4T60aY4lPVP0vw860+Rv1Q2ZralifHslc7hSnOPMKOj7B6huxwygIi3bFcSkDEXyo6kSqFwWTmYT+eyR2TUL+OjAxFY7Y6mnGhzZt3D1fEeTGtZ3yxXn4zBCX4KuV/Y/3BV82oqeKpJa8PAhzoJbyLJ6WJoA1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5lStOlIlqfirhdnpECXOEIXymXzsntWjoyR48zuzVr4=;
 b=gNO08g4D7A8IFhPl1s94Iwcl3lK8K1+lQrza7J0DeXo0KK6ACUozeX4vy2TPFH7hsiWAGmOzYdwsFBxPHev6rbhbwGAicowLoFtJKDkMWIUd64Q6BEi66WjI4nQwePmbvTzhnIG1lAPxRwvdnBE9At4UFT5uvZWlkko7kQRe/ul2L4b3u9sO3qe4rjOZXteXqlIriMYf9lNo3BVWjDaFDGSWRorjF0htpqWRwWSGXjANqYNuEzJOoP13StUNLjBgA8nsKkIeKgvKxTgT1qZe2eGquVIv+b8AQkLRFgX4hQ0hBFwx5qt7A5ENGseX2Gb++7SVI8JJ1kSXRwV7MEumWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5lStOlIlqfirhdnpECXOEIXymXzsntWjoyR48zuzVr4=;
 b=keL8kOK3mxRhQmwWHVp358X9dy11arW0h4rQTrCrXgwdcJ0Wm+YOAc9HCAphsbvNtfloTtGnzQqFSokGLs2IjZazvSJGAbpbBSyhfj0Vzln0mFI9WiM08cJGmRPAvhxNzamWtIKFenyY8vVepLX4DlscvsvT3s7Bsj6sWgAeaRY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by MN6PR12MB8514.namprd12.prod.outlook.com (2603:10b6:208:474::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Tue, 21 Nov
 2023 11:54:07 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349%5]) with mapi id 15.20.7002.028; Tue, 21 Nov 2023
 11:54:07 +0000
Message-ID: <fb2d5246-93c3-4bb1-a2e6-1c2c653604b2@amd.com>
Date:   Tue, 21 Nov 2023 12:53:48 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] docs: dt-bindings: add DTS Coding Style document
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
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
 <bd49f17c-7ebf-4e19-b77b-b5ec95375f7d@amd.com>
 <b48293f3-16e3-4980-b900-add0cb7d69f6@linaro.org>
 <CAMuHMdV_gqmf2=cXmZmYgE3aLxvPBr1DVp0cz0C+YrfBVG-8mg@mail.gmail.com>
 <CAA8EJpo6w9N_opJkfDaF-20zwZmn6JHrYYhakqzLFqVtgXaV=Q@mail.gmail.com>
 <6513aefa-b0be-4a29-8c9c-483822217ebf@linaro.org>
From:   Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <6513aefa-b0be-4a29-8c9c-483822217ebf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR04CA0121.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::19) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|MN6PR12MB8514:EE_
X-MS-Office365-Filtering-Correlation-Id: ec841a30-c643-45bf-1a84-08dbea8890ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U7MAA1CSEj0IxFb9fm7Z/QGAgrUZeaoiT1TpDw01WNiYtEeQe3xjIiWADAimbrInqSS9Sfp/DhHgBxiS7QwJhtteim5HhUMiC5QA4sWEnuMsG0bVbIAlxJpghxl5kkyX8BXdwlmRuKtQNHzSi0y/0y1w49ySCDooDs/X4MEDyIYsLiZqTY1DzD9QOs9WYj4EVZPcviUZP3NZxpA/ClrIXs2Yzy/oZro7E67lfTBPHy8kqiXaN4gZigB9wGwxlM5Ow/fHdjlph1A0i+IzqW9aKIfQF6t3ZH5cAh3ZmxCDZeuE6Lk3xfagiOsrqfwbeZlcXAbkA2QbxOhgS61YURV0tVMX8CgD9gmmf4t2qs875SIRrQhpxLArEVrzHxH92YRHyO7pXk+IPRDgivMQG3AwjRfa2EB+cZs37McNosEK2GsIRXRMhSjwyK++KOms6xc6mt0k8JqMd44pi4i6I6gjQx24feGDGfR31jYlkI0gb2Vox8HPLg2P4e/Aup7URVfKKnpG/4HBcR2cePBm6ZF0P/z7L6p648YTNG1vc+gVGhsMemQGhi9+NlAzpKV1gkJKzdxr9TvEkVzQG1Wqs08G2Mz6/HeLUL1RDBT9bqMaL7P2TNYq9K8hXsnWX/NAxaV/EKuu14/wB7tlgEN+rUINnqwvV3ALwIiFfOnSu4TX1n9I2Hxm2Lm0YlrLzwYwJKOiBMSgz1si0F3dAbsYT5TgxfyUuA8ACctgeJNC6bSOr+M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(376002)(39860400002)(346002)(230922051799003)(230173577357003)(230273577357003)(451199024)(64100799003)(186009)(1800799012)(83380400001)(6512007)(53546011)(26005)(41300700001)(4326008)(8676002)(8936002)(38100700002)(7416002)(2906002)(44832011)(5660300002)(478600001)(6486002)(6506007)(6666004)(966005)(110136005)(66556008)(66476007)(66946007)(54906003)(316002)(36756003)(31696002)(86362001)(31686004)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmdHcWxTZ2JaVEFJb2c3RGExRHpmbllMZ2MxbjFKdnhNck9mNnhEZnRqWHhP?=
 =?utf-8?B?RU9QaXdDTzhSNitQdlZsaVlRNkVBVVJiMm5IWnJUdXBMYUc0RnlFYVA1OXJR?=
 =?utf-8?B?YzNOV3orR1Z3YWxmQVhWMEd6L1JzaUpQaVNTL3lMdysyZ042YzdzblF3cklx?=
 =?utf-8?B?V3dKWFh3bVRYVjhycytZN21WRFVzRWs4emxLcXN4ZXBrT3FrbXJVYWs4all1?=
 =?utf-8?B?d2t2ai8zbkNHalZGelFDZUFWcGhIcTJ5NW5MclRYc0t2T0Q2bzhNbThXM3ZH?=
 =?utf-8?B?V2phRi9nUE5ONHVvYjN4K1NveGsvRXpCOUt5cUorUXJTKzI2YTd0bnQ2MU1j?=
 =?utf-8?B?and6c01tYVNSam80UjdvMEN4SnpvNFhUWURreWdEcDZkQ0h4ZEUrRjVRU1Z1?=
 =?utf-8?B?QmNESzVkcnAzOHAzcDBOQmU0eE82ZFQ1L1p4blZhNHRubDRzb0FBZkZzTzFT?=
 =?utf-8?B?VDY3Tmphem5TNjNhMHRxK0I2VzNPNVJyUVI0eDIrbFZqYjVsSTVNVHJ0R3Fs?=
 =?utf-8?B?MGZaVkVNTEhCdGRFL2FkUWpMRWNLUVo0K2hJaXhNV0cxZXFLRWl1VDVUTXB5?=
 =?utf-8?B?WFkzSXk4RnZqTUxEQ3ZWSzRkZFJGZDUvRWx1a2hnZCttdG92d3Fub3RjMlFI?=
 =?utf-8?B?UzIyMTZpUkR1dG4xa2JsRWM2TFpmTkt2RUpTWVNseUhsWXBOdituSGsva2NN?=
 =?utf-8?B?dm5sUm5vWm9MQ0J2bi9ySENNWGVjSWhxb1hUVWFsRi9BMWlMMjBoaktLWTZ1?=
 =?utf-8?B?eHo1SStLT0JlZ3pKUmZ1NnhyaS8wVHQxek82WUhhL0RDU0NhSU5nQStjcHls?=
 =?utf-8?B?aWtmZzhQOGVOakZ5cTFjV0wvdVFwRWlzZEJqN3cwKzB5Z29XQlJmMDRqK0pv?=
 =?utf-8?B?TUErWE1zRDQ2eXlNV25leHNiNGJoeGhuVjY2bzNIQmdXTVYzZldwZTZCZkFG?=
 =?utf-8?B?Z0dEdEMxREpua3kxcFl1OUdlQlRwYlhuVmlqNHJldW1iN3JLWUVlREFPYndT?=
 =?utf-8?B?Q1pleXZSeUpDTjNiS2Z4amFPekpyRzFYUzlrb2M0UmRHQk5pVVA1TGY4ZDVQ?=
 =?utf-8?B?Ymp5UGUza01ER0Y2elUwZlhINjBybFlWejhEcVVDRTdSRVRvcEpoMExyMjMx?=
 =?utf-8?B?VEg2enZmL2V2aU5NWGhmblBDZEhMb3kvcUNiNkpMTTBlZ2ViY0kxbHNUdU14?=
 =?utf-8?B?dE44TFJxZm0rVWU2UEdRZDVVMTEza3RPSEpSU0tjc0w0MDRYbmluQlloZTVZ?=
 =?utf-8?B?bys3LzBKZVJwKzJ2amUrczIrM09qT21yYk5IMGluUDVVTmNrbXVTa0x5ejR3?=
 =?utf-8?B?ZHZkczl3Vk95ZUhieHp4TkFtM2pxTmZseVpyUnlrS3hxSldrR0Q0L1RpNzdh?=
 =?utf-8?B?YUJCZmhUcDZyUTJJcC9hUXc2YnZNekNhSU42dThVRTZKZ3FTZXM5WG9WWVI5?=
 =?utf-8?B?QUZhVGlyYTk5a1plYUtlWGNjdFdycU5vdEdQWWt2dUVNRmtFL3NtQUlnL3Q3?=
 =?utf-8?B?RXFkcXhPVVNHSHdEdHQyYUxFRDVBVk10cGpNTXZpbC9xdGZaTXQzeE9RUWhB?=
 =?utf-8?B?V2M5czIrTkNKUWF4ZEJGek1EdU9SN1Q3OWxyR1VtZE9TTTZmSlM4UVZQUytu?=
 =?utf-8?B?MHdRM3ExeHlBTEs0dnQ0S25aaEZzNG9yZkUrNWFIa0ZwUnZYSTl5U0F6WDVk?=
 =?utf-8?B?Vyt1THZHd3B6TmovOTJFQlZuNmUrYXMyOEdyb0wxTXJoanBoVVJ0dXJEd1hT?=
 =?utf-8?B?VnV2R3Y4ckJRRmozdi9IQjhVOTRuY2wwYWlsVnlBWW1WVGphUnVuRHBOYjBk?=
 =?utf-8?B?WVlBQWNuaFhxbzljQnR2L2xhcndacXRlbUxYNW1uekFJME1jbUJHZTh2R2Z6?=
 =?utf-8?B?TS9UdTV6UklBcHQ5RCtBMUZwVTZtTkl2UUdvWWFDS0ZoSUVaeUU3WVd2NStq?=
 =?utf-8?B?OUprT0FIRmFsa3E0djR1Z2dpWjIrSUZZaVBpbTVZNkUzNGRMY3VLcTNTU0Fv?=
 =?utf-8?B?V2dtY05obW94cERoTEptQ0MzVGdpSHBrVldXS3psaGVNVWxpTHNJcklmdGNF?=
 =?utf-8?B?N0dKSlMvbndUMS9qNFBIV2JpUitUK2RzN1RIdlJ2T2laTkJCdzFndThHNVZn?=
 =?utf-8?Q?krEIFDhD6DcNHme5JQf8UBW7E?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec841a30-c643-45bf-1a84-08dbea8890ea
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 11:54:07.3691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EyYNb9Lbf1n++TJh76p/BGx1z6BKpu7MIhitec7TYEKeXpPNTePH86pMF5oMBsnH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8514
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/21/23 11:28, Krzysztof Kozlowski wrote:
> On 21/11/2023 11:13, Dmitry Baryshkov wrote:
>> On Tue, 21 Nov 2023 at 10:09, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>>>
>>> Hi Krzysztof,
>>>
>>> On Tue, Nov 21, 2023 at 8:47 AM Krzysztof Kozlowski
>>> <krzysztof.kozlowski@linaro.org> wrote:
>>>> On 21/11/2023 08:33, Michal Simek wrote:
>>>>> On 11/20/23 20:31, Krzysztof Kozlowski wrote:
>>>>>> On 20/11/2023 20:18, Geert Uytterhoeven wrote:
>>>>>>> On Mon, Nov 20, 2023 at 3:53 PM Krzysztof Kozlowski
>>>>>>> <krzysztof.kozlowski@linaro.org> wrote:
>>>>>>>> On 20/11/2023 15:01, Michal Simek wrote:> >
>>>>>>>>> On 11/20/23 09:40, Krzysztof Kozlowski wrote:
>>>>>>>>>> Document preferred coding style for Devicetree sources (DTS and DTSI),
>>>>>>>>>> to bring consistency among all (sub)architectures and ease in reviews.
>>>>>>>
>>>>>>>>>> +Organizing DTSI and DTS
>>>>>>>>>> +-----------------------
>>>>>>>>>> +
>>>>>>>>>> +The DTSI and DTS files should be organized in a way representing the common
>>>>>>>>>> +(and re-usable) parts of the hardware.  Typically this means organizing DTSI
>>>>>>>>>> +and DTS files into several files:
>>>>>>>>>> +
>>>>>>>>>> +1. DTSI with contents of the entire SoC (without nodes for hardware not present
>>>>>>>>>> +   on the SoC).
>>>>>>>>>> +2. If applicable: DTSI with common or re-usable parts of the hardware (e.g.
>>>>>>>>>> +   entire System-on-Module).
>>>>>>>>>
>>>>>>>>> DTS/DTSI - SOMs can actually run as they are that's why it is fair to say that
>>>>>>>>> there doesn't need to be DTS representing the board.
>>>>>>>>
>>>>>>>> I have never seen a SoM which can run without elaborate hardware-hacking
>>>>>>>> (e.g. connecting multiple wires to the SoM pins). The definition of the
>>>>>>>> SoM is that it is a module. Module can be re-used, just like SoC.
>>>>>>>
>>>>>>> /me looks at his board farm...
>>>
>>>>>>> I guess there are (many) other examples...
>>>>>>
>>>>>> OK, I never had such in my hands. Anyway, the SoM which can run
>>>>>> standalone  has a meaning of a board, so how exactly you want to
>>>>>> rephrase the paragraph?
>>>>>
>>>>> What about?
>>>>>
>>>>> 2. If applicable: DTSI with common or re-usable parts of the hardware (e.g.
>>>>> entire System-on-Module). DTS if runs standalone.
>>>>
>>>> OK, but then it's duplicating the option 3. It also suggests that SoM
>>>> should be a DTS, which is not what we want for such case. Such SoMs must
>>>> have DTSI+DTS.
>>>
>>> So you want us to have a one-line <SoM>.dts, which just includes <SoM>.dtsi?
>>
>> Well, I think it is impossible to run SoM directly. There is a carrier
>> board anyway, which includes at least regulators. So, I guess, the
>> SoM.dts will not be a oneline file.
> 
> Geert claims he has SoM with an USB connector which can run when power
> is supplied by that USB connector. I can imagine a CPU board (so a SoM
> in format of a board, not small DIMM-card) which has connectors e.g. for
> power and a slot for external motherboard for additional, optional
> interfaces.
> 
> Look at picture on 14th page:
> https://www.renesas.com/us/en/document/mat/rza2m-cpu-board-users-manual
> 
> This looks like some case of SoM, although maybe not that popular
> outside of Renesas :)

In our case we have SOMs
https://www.xilinx.com/products/som/kria.html#portfolio

and also carrier cards (CC) like this
https://www.xilinx.com/products/som/kria/kv260-vision-starter-kit.html

and we also have debug boards.

There must be a carrier card in our case and there is power connector (with also 
non sw accessible regulators), jtag, boot pins and for example ttl to usb 
connector for UART but SOM spec describe directly which peripherals are on 
certain pins by default.
It means we have CC card but there is nothing on it to describe for SOM itself.

Our default boot process is to boot with SOM peripherals described by spec. And 
then do CC identification and switching to SOM+CC dtb description at U-Boot.

Some combinations are described here.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/xilinx/Makefile?h=v6.7-rc2#n21

We can create dtsi for SOM and then dts which just one line which includes SOM dtsi.

Thanks,
Michal







