Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD6A7F40AF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 09:57:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233824AbjKVI5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 03:57:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbjKVI5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 03:57:40 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2055.outbound.protection.outlook.com [40.107.101.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C57D9E;
        Wed, 22 Nov 2023 00:57:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dm3mdAmFcGkTc+swHp6EDuzJQYjt8UOYTqhNQ+3n5fXTOqjW8fxqL/vLYTzoNaNuhC7Jd1gohHcBih0EzqkUHh6ezPoRXSsEXI1Z+ZF++GQaZOPslO1yqstlvElb81er0whPiBHqkL7fsWqXO0NgEhGH+rTN7Yj7mJSc0UP6PhL97apetehCUpg4nkw9gIHettVf68zVGZZq5XDGsYKCVgLDToBrk5PIKA2v0jpnCrIPynx2RSdG03z9SsahIWjaRzfPkoo1e+vg6y+UwzzskS962dEQeF4gNq+z2/jk7u79AS0Eztsnu0ffNYoCuPZPqjrNng0zByxlCJKA4M2W+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YYrpxRvg4FWGVlybxyXoe3jDe/613HXdKseNyXgGr0Q=;
 b=SkDgW1mYNnYrjeuUPYJvYck3kzaQXfN65Z1kcyGaOIZx98R0kdUTOBj4P2PtMFiE83ZOg4kag3vIS0xbhs07y4tAuDa5A7Xk8hYJ6MhJv+jghmocd0RloclhUgkh+DM5BnlrOW9TehqIWGexs78+xIjbCAxWR5DH8AkLFuS1nBLfSoQTFufL0LZ4OMR1AL6fSN9tZRSPb4QiHskxK901BnxYAIiaqXSl6sLO+8rCQWlZHCPRPBvAaXoJj/AxE97nGA6dt67hIwAygUj6gck7zRvjHKkCmeW5pfWDh3M5YeGMkpmD1TPmZASmY5YqrEZfmpddJvpQArBUX1DDvmaXuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YYrpxRvg4FWGVlybxyXoe3jDe/613HXdKseNyXgGr0Q=;
 b=MveFqlWRZRZZgyWqynCT7LxdEjTA7BwzQR+u93e+kTgA9aKVOrAkQhs0nmGU48EYtStO/K/r1exurxipgM7WyFxiJAcqpGji7xEp/4JtK95D60X+ezIsKJQ8aTgorhqMRQn5Vf/XeAWU0+6RMTRuX6fER9jprc8edrpSyGh9btg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by DM6PR12MB4233.namprd12.prod.outlook.com (2603:10b6:5:210::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19; Wed, 22 Nov
 2023 08:57:34 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349%5]) with mapi id 15.20.7002.028; Wed, 22 Nov 2023
 08:57:34 +0000
Message-ID: <808270d3-2274-4fb7-a397-38538503b67c@amd.com>
Date:   Wed, 22 Nov 2023 09:57:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] docs: dt-bindings: add DTS Coding Style document
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Dragan Simic <dsimic@manjaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        wens@kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
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
        Heiko Stuebner <heiko@sntech.de>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Nishanth Menon <nm@ti.com>, Olof Johansson <olof@lixom.net>,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-arm-msm@vger.kernel.org
References: <20231120084044.23838-1-krzysztof.kozlowski@linaro.org>
 <6b288a2e-d147-4bd3-b1d4-daf56295d939@gmail.com>
 <01f9ce3b-e6e5-4b05-bf7f-0b3a5f74910a@linaro.org>
 <CAGb2v64Vf5dDwq=KTrxwc=+w+0KUD2KVPMjmHg68Y_yukES5dQ@mail.gmail.com>
 <7232a48b-b9ad-44b5-ae6a-d12dad70b3c4@linaro.org>
 <58a9caacc1226c7c3a2bdfe73ef1791f@manjaro.org>
 <cc4c789c-b595-41eb-b543-9e03549c6e61@amd.com>
 <CAMuHMdWm-gRPHeHyuX3_eR+9chJEw3iiZwCNBnoiRPHzoMAs6w@mail.gmail.com>
From:   Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <CAMuHMdWm-gRPHeHyuX3_eR+9chJEw3iiZwCNBnoiRPHzoMAs6w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR0102CA0086.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::27) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|DM6PR12MB4233:EE_
X-MS-Office365-Filtering-Correlation-Id: f3923fbf-308f-4120-b8f7-08dbeb39113f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VCaq5Or9NfojIy8esvM4+pLdiwnS7XFOCPIq9L637W8p6m1sLanuMIVjDoC5eeg1NcYTzXEmmyzRHIl3Mj1ppwXky/1iF+RPBbB/LVZ4gApn6kjns9XnyiAydSyX5z1J76kgDsrY9Y0CTIZT9Ace47dIn+HNqgmKZAk2Alwq7K0nNWcrSqBYwQtbFwYheqVzzRrKzfDkJzf9scWrjgOa25XSsYbHoC61gHx16BBwITRIaUYqmpTn92/z2D59KcjnGDZ8oX/v+q1ucOXg54+dYmKi/N5phsNahv1E4SQKlkIbmAzzBURS6kvY4yJHzMwmn/yF7tEXZG3oS6MFmhap2hdZwb+yTuCLOLm/EUOkKNp2uMIomOA6Y8vA94HWPI4G7WNBt5qIMoKXRpErnoabLbIdabEOH1u+Qfv3fySJbLYcDDfO9Jx9058bNl++PWpVw6w12bTXehZYRbVQtvwF7HoWI0M4ASslBR/8HlgrXzuKt81un6pRXMaXG+guLq3xluQJU6BUb9tbNdNL3vFI5jSLhEleLqZIyq9Gzp4/40sHMvvQfkys2NGuNvdRkeUyJzPRQEbVun/sFGlvfyz21jhnFdJ1YrjLcRM68sA0ECOhIQL/spsJk5SRlaUasPNiDL1V7TN5tqSWErkvgcLeUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(136003)(346002)(396003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(31686004)(2616005)(26005)(6512007)(36756003)(31696002)(86362001)(38100700002)(83380400001)(7416002)(66574015)(5660300002)(44832011)(2906002)(4001150100001)(6666004)(478600001)(53546011)(6506007)(54906003)(4326008)(8676002)(316002)(6916009)(41300700001)(8936002)(66476007)(6486002)(66946007)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3NJblhCUTBrZytDSlhiOUtSYXNLMldnTGJ6Rk42K1pWY0ZQV0UxN1hHWWFq?=
 =?utf-8?B?d3VQbXNrRG5UOEN3Mis2MXRpbUZZOTQwZ1RYM1plNmRjd3RUU1J0NEJwbTJp?=
 =?utf-8?B?Y082TVhWbkczRkM5UzlUOWxQaXBLaDdHaDNLb0R4TDlmZ0lLa2VyYmN3VkM5?=
 =?utf-8?B?YVVIYXF4US9JRE83M1E0MkU3TnV1K2haU1JCSXF2QjcyMkZxa3lzQkVuSHdx?=
 =?utf-8?B?emY1LzFjS3VIaTNWdndSTjJXeUZ5UnpWNkhzSjlxVnh6akJ3bWVQajIrUzZu?=
 =?utf-8?B?UGFENnJLZW9KcTBHK0owTDBxam5DYXlBMnh6TGYwZGk1aDJCNUpOek5CNVNC?=
 =?utf-8?B?R082WUVyZUtkR3ZjRTU2Mit0TFhvWHJ2Rlg0eUJOSmkwZlJXbnhKS3N0TTdE?=
 =?utf-8?B?cWs2SThnVm9ZVDlmaVpOMW9lN3l6R1VnTnZMMXhJZzkzM2lMQ28zd0w0VnUy?=
 =?utf-8?B?OCsyYUdNam5STC9UZVl2cWZBQ2hnRHVyRVl2SW1EajFzRHZVdjN4NjZpa0VL?=
 =?utf-8?B?R3pvVGU2REU0WXZ4MFZyRGhLRkg1OE55R3VVa3FmaW1pRjJldTBoK2g4QytX?=
 =?utf-8?B?MVlpT3pEeHQvV05uTXJJS0RnbWdabmFrSVMzRlJFdVUzV0tzN1U2S1NWei9Q?=
 =?utf-8?B?QTV0UWhFeFFYVVVsZldCL29BMDQ0aVpQdFVxekpoUUs2QUYwMTRWc0I3d2tJ?=
 =?utf-8?B?ZzVuRjU3VHBXSWh5TnNwdzA1elJNd1NldjZrUXpmWXdWdnpoOUtkNHZHTUor?=
 =?utf-8?B?NmxmdXhnY1NtSkZUODRBQkJqRGt2VzJWVkdoUmZpN2xLeCs5eDdsUlF3bDMr?=
 =?utf-8?B?dnhZU05SNXZtMlRkRnVpMUlCd2NIeTdMSHMzNXdKRkxUaTYvK1V3b2tQSjR6?=
 =?utf-8?B?N3doUU9xcUpMelVJcnpoQ1E1YkFaUnJoblJQU1JPVkpsNTRoNWx6Z1h1UzVU?=
 =?utf-8?B?ak82UVIwMkUvZGd5MFVwVnRjbEdyYjJkVnEvMkNZZzFRMk5nUlBkY1B6Z2Vi?=
 =?utf-8?B?WWovTUJzdUxOZlNnbU1JSVcwdTh5RTRzNjFJbWxtcTlsaEk2eTIxT3I1UE1v?=
 =?utf-8?B?NXQ0WGRVaXg3ZTVHNGY2akJ4aUllUFB0dGY4Z1VreVpRQnkzSWJnZysxaHFk?=
 =?utf-8?B?MXQ5U0VNQ3dSZG16ME5kbHV5SEozTFpxbmxCNEh3ckJzZFBBY3VNZFJhTTZp?=
 =?utf-8?B?V2I4NHRWMXRRS095VlJXZXdZYjhKUFp2K1BERXA1NHRqUlY0QTJHL2tZNlBr?=
 =?utf-8?B?dXl2UThFUEZ1bDQ2SFhKQU4xOHBsUUlHclpKdGRET3R0cTBaNHN5ZUI5UHgy?=
 =?utf-8?B?U25XYkk2M1VKOEJUb1BpT05IdWc0NzVxcVFKNWt5bXM2L3duMnlTMDlWR1U1?=
 =?utf-8?B?TUtUdFlkZ09tVGtsbytDWWtSUDY2TGVFZXpvVGcwSFY4VGZCUjY0akxvWUE3?=
 =?utf-8?B?SVI5MzRRL1h5NjlVWFZtWTFGZzYzZ2tCSUZmZERYWHFHMGVWMEQzV3RPQzhE?=
 =?utf-8?B?ZGE0Vy9PdktQbGxOTlpFVXB5WVNaWFBQWHcwd25KWTRJQmp0MDFoQnZ6NEZV?=
 =?utf-8?B?d1NwYzhPRVVEci9FTkwrcDUzbmNwenJOYy9hQ2E2VHFINTBBcSs4Vm1kQ2dK?=
 =?utf-8?B?SHV4WmpwY2VnYitxUVNWZ3lxejZyYU8rMlYzWTBRc1puYitqMnRTL1NiMThT?=
 =?utf-8?B?eUFpb2JoditKOFRXWWJiM0JkcThqaTdWV1pKMzFCUUcwY2orUW9TWXFLNDRU?=
 =?utf-8?B?cE9QYmZTNTdzME15TG9rYmJnTnJ6NlhxcCt0cFFmbnZqZmFFL1pZZ2pCbnNL?=
 =?utf-8?B?cTVCd0M0VkVlanVFMVlNTi82U1RNTVp1NVhLdnNSTWNPS29PS1pCNGVUalpH?=
 =?utf-8?B?L0ZZM0hWb0dleWNKaHp0UitYL09lZVVFR3B2bzcwNEd6Wjk3RG5mRTJ4dkRB?=
 =?utf-8?B?bWREelhMcTlvQlovOWlNQ3h4aFZlVlhWQTF4Q3V6ZEIvNWtOOXIvWnZJMWky?=
 =?utf-8?B?c2J5em93WnBuTFlzM2dYcC9Od2JvZi9hRDFHc3lxSXROZnMrdi95eXJPdVVV?=
 =?utf-8?B?bDlwOE1DcUFJOWM2ZUZOS3V4bVhkYzRvWWE3RkExMG5sbG1HaDhackhWWDdu?=
 =?utf-8?Q?uPHLGzJRy2d6by8g0Ksp0I0HW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3923fbf-308f-4120-b8f7-08dbeb39113f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 08:57:34.0946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qJNdU2UEOry2Hs0E6YjI5zdbghJ6DO0xMd9KG354WuY3D0zNF8ri2hOKc8RoWEIT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4233
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On 11/22/23 09:53, Geert Uytterhoeven wrote:
> Hi Michal,
> 
> On Wed, Nov 22, 2023 at 9:50 AM Michal Simek <michal.simek@amd.com> wrote:
>> On 11/22/23 09:29, Dragan Simic wrote:
>>> On 2023-11-22 09:21, Krzysztof Kozlowski wrote:
>>>> On 22/11/2023 09:09, Chen-Yu Tsai wrote:
>>>>> On Wed, Nov 22, 2023 at 4:05 PM Krzysztof Kozlowski
>>>>> <krzysztof.kozlowski@linaro.org> wrote:
>>>>>>
>>>>>> On 21/11/2023 14:50, Rafał Miłecki wrote:
>>>>>>>> +Order of Properties in Device Node
>>>>>>>> +----------------------------------
>>>>>>>> +
>>>>>>>> +Following order of properties in device nodes is preferred:
>>>>>>>> +
>>>>>>>> +1. compatible
>>>>>>>> +2. reg
>>>>>>>> +3. ranges
>>>>>>>> +4. Standard/common properties (defined by common bindings, e.g. without
>>>>>>>> +   vendor-prefixes)
>>>>>>>> +5. Vendor-specific properties
>>>>>>>> +6. status (if applicable)
>>>>>>>> +7. Child nodes, where each node is preceded with a blank line
>>>>>>>> +
>>>>>>>> +The "status" property is by default "okay", thus it can be omitted.
>>>>>>>
>>>>>>> I think it would really help to include position of #address-cells and
>>>>>>> #size-cells here. In some files I saw them above "compatible" that seems
>>>>>>> unintuitive. Some prefer putting them at end which I think makes sense
>>>>>>> as they affect children nodes.
>>>>>>>
>>>>>>> Whatever you choose it'd be just nice to have things consistent.
>>>>>>
>>>>>> This is a standard/common property, thus it goes to (4) above.
>>>>>
>>>>> It's probably a mix, but AFAIK a lot of the device trees in tree have
>>>>> #*-cells after "status". In some cases they are added in the board
>>>>> .dts files, not the chip/module .dtsi files.
>>>>
>>>> Existing DTS is not a good example :)
>>>>
>>>>>
>>>>> +1 that it makes sense at the end as they affect child nodes.
>>>>
>>>> I still insist that status must be the last, because:
>>>> 1. Many SoC nodes have address/size cells but do not have any children
>>>> (I2C, SPI), so we put useless information at the end.
>>>> 2. Status should be the final information to say whether the node is
>>>> ready or is not. I read the node, check properties and then look at the end:
>>>> a. Lack of status means it is ready.
>>>> b. status=disabled means device still needs board resources/customization
>>>
>>> I agree with the "status" belonging to the very end, because it's both logical
>>> and much more readable.  Also, "status" is expected to be modified in the
>>> dependent DT files, which makes it kind of volatile and even more deserving to
>>> be placed last.
>>
>> I am just curious if having status property at the end won't affect
>> execution/boot up time. Not sure how it is done in Linux but in U-Boot at least
>> (we want to have DTs in sync between Linux and U-Boot) of_find_property is
>> pretty much big loop over all properties. And status property defined at the end
>> means going over all of them to find it out to if device is present.
>> Not sure if Linux works in the same way but at least of_get_property is done in
>> the same way.
> 
> As the default is "okay", you have to loop over all properties anyway.

No doubt if you don't define status property that you need to loop over all of 
them. We normally describe the whole SOC with pretty much all IPs status = 
disabled and then in board file we are changing it to okay based on what it is 
actually wired out.
It means on our systems all nodes have status properties. If you have it at 
first you don't need to go over all.

Thanks,
Michal
