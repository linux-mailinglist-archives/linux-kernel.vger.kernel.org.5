Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3F87F4089
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 09:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbjKVIuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 03:50:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjKVIuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 03:50:04 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2082.outbound.protection.outlook.com [40.107.100.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B5DBF4;
        Wed, 22 Nov 2023 00:50:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sk2Hyc0EigvJZBE4Tk/lAXqeAgLimtxn8bETcEva6oiPwwcHMH07TRvPnLvaeZRZ+8tSeDPerSX5lXH2dnNJQ2seRTLx5OnE0Hw7UarBd6h+L/stcX/GQ2l6bbFNOTVC+et+mczDA+V1Q43pWUNZFvgs9A7aML6Ae4FFyYFWh+YdbAkXKG2GLYHI/zzlhfLccKYDeSp1pS7HreMg9ij37YlgYzPWCBqvVjX2SJg8/QypXpCDh5kQXxYZw81AyqLDOHusXGirH/sJvSs1yySwqM3IPPIzG/sCyS/3Ipy0OVvCevbJoPKIfsufpS44REeT/fKPQClgUAy/RsYerOjvtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H8QBZlY/+6cdxLCdF3oDHPOLlHxg1EmUYA8K0NgmWH4=;
 b=ezeUYeZnjAxmw0hKHu2AYPDW+wdVygdUNHit5DLFq7Yz2Nh5ZoanGfaXXlQ5KJtKynmIR0QkEb+HT86cCucQOlpdxnUqTiNDW0UdR5iJkSBEncNcLoFuXWElTBA5U16oBwxMfRF0B8BQ16xuuHOi+pPMA+ZU8TPGH+h6XwxLVJ8FWjlnu6HBgG9UGPQ1gusF4YYtQVTMo1ZippI8miZ6JN30XtH2XkLj1nhc9bISAd7M89gMA62nbBzIUoxO6spL6WhijNabA8k+EuOQUDVTCHfiv8gpXwbt3Ktrygw6bfMOrf4xETaVCaivYTd9+64WSy7k3DkvIxLyQ8WzIcs+iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H8QBZlY/+6cdxLCdF3oDHPOLlHxg1EmUYA8K0NgmWH4=;
 b=nEnEqo9eByX/w2o5EoBUzgGhMvc858UuT5XAJ0akUQfFawfMjly1vWaIENB/Mk9ACiDSYWP+myMB109mbkn9uK+gRMmb89HFbDCWrH/Gh0xTifpFvfDhe9+PDbiOx6PwctKfFsqB03cI7TKZe9Jli7Ksv17PX2yPm/80gUdSn/g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by DM6PR12MB4466.namprd12.prod.outlook.com (2603:10b6:5:2ae::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Wed, 22 Nov
 2023 08:49:57 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349%5]) with mapi id 15.20.7002.028; Wed, 22 Nov 2023
 08:49:57 +0000
Message-ID: <cc4c789c-b595-41eb-b543-9e03549c6e61@amd.com>
Date:   Wed, 22 Nov 2023 09:49:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] docs: dt-bindings: add DTS Coding Style document
Content-Language: en-US
To:     Dragan Simic <dsimic@manjaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     wens@kernel.org,
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
        Geert Uytterhoeven <geert+renesas@glider.be>,
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
From:   Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <58a9caacc1226c7c3a2bdfe73ef1791f@manjaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR08CA0276.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::49) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|DM6PR12MB4466:EE_
X-MS-Office365-Filtering-Correlation-Id: 87c120cd-2e2d-4537-8249-08dbeb38012c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lOfs+lW6Efst2kcpra+mnYsPdVsBopwZ84ik9yVAH+JoQXrMo4IBZr7y7akHTZk2TpoftsKk8Epk/gUXzh8AAAPx3WkLcSfvlE1WxCIYycnOCk6OXruxwUBGab6wU2Kmos+3AnqjfGslMdVWkfS6+92g9g0OJ1a9q5ChudddKV6WIXmECJjLSBkBMWmdS8DebLHX1IzSWfNetS+l2mH3SBXux/bUIo2e6qOCGhFw0zLeb+gEQ2dOc6VEBPG9Q6u5B6YedaVcozx2AdN0rEEKeMCEgUji0wJo0xCJQq0411MiNQwb2Ms8r0LQrrIzaPvSwz7d5/p0/sB1KrUik0HisLHj6Uh8iUDMrzpzuCUB3+7lK1bemSrtjIbyEomNItGHKUKIof+6T5JbPldRG9YrK2y3C+D+X3ocYXxaeGjkqTAOeTY2+EOmmPbwbThvEH+M/D3lAhfBGVGvzzB68rrfyQ1u87CvSrxkTxnj607Nq98chIhv+ZnvGTp4qFlL2x1R66GcBGe5IZdAZYhk2+ujLyncSJ/HSk4CRvq2TFU2mmsDqeTbNMAp1Tot8dS4CZx8ag6H7i0qv139qM7IitOPQ0ERo7DWv25V4TQ2oKcqnXp8NfdOxpQSGiV4ULyvcwBwEAdzEDK2VcsCdHxEWs3+ng==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(366004)(39860400002)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(36756003)(41300700001)(66899024)(86362001)(5660300002)(7416002)(31696002)(44832011)(2906002)(4001150100001)(6512007)(53546011)(6506007)(26005)(66574015)(2616005)(83380400001)(6486002)(478600001)(6666004)(38100700002)(8936002)(8676002)(4326008)(110136005)(54906003)(31686004)(66946007)(66556008)(316002)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEpBeUp2N3ppVnBOdEUrWkZuU2x1Um4wL1F5ZWJLKzVJVkZEVjMxdWRPdXJR?=
 =?utf-8?B?ay9TS0VPMnFrVi85eWl0cUdXbCtNemZBcklzQzFFRkh4WDJiLzgyMEY5S2N6?=
 =?utf-8?B?bzVGQUxmQ1RFVzBnT0dCUUllejhkN3NxSnphMVM2RG02WkRWcDZZNjh3R2hj?=
 =?utf-8?B?bmlZOXVqcXNtLzFIN2w4bXh0c3JrTlVLM2dUSTRUa2dKQTZqRGIrcjRmMlVZ?=
 =?utf-8?B?cEhWSjlyRUI3Ty9QSkMyaDk1NGxDWk5XWWNEVFl2VHZiZ2cwdVorSWcyNWdW?=
 =?utf-8?B?eFp2ZkZJeUU1S3YrVzhWMlJlb1l0RUwyN0JxRUhJZ2lxM2twTWplVEpDKzVj?=
 =?utf-8?B?ZzRGMmtmdEo3Q1Nhd3BiWGNjT1AvajlZc2U4M2RjZ21aWjNGakxwZW0zRjJJ?=
 =?utf-8?B?dFZBSHlGU0h5eWdlSitHdjRsaEZ4WlZ3ZXU2Mng3SEpROFNDQ3hVYnMyZ3RU?=
 =?utf-8?B?MkFjLzFYdGNNcTZ2cUUrNFVIWVRhWHR3NXBhQ1haUk1zTEpXbitiY1pLcFk4?=
 =?utf-8?B?UFJmRVJiTC9XWmNudnh3UWJDdWZFMXpBaUc3SmllMXBMQkdUaHJCcXlkckFY?=
 =?utf-8?B?YjByOGNhOU50ZXhZdTFPRGVSY3lMZUtCRVpVYSs5NjFOMWlNeXZpd2owcmY0?=
 =?utf-8?B?K2NEQ2ZmUk5FbzdOY2pYb2g2L2pjcW1wZFVndzFNQ0dXZVU5dmtSRmh1ZTkz?=
 =?utf-8?B?TUtTd1pXaDlGbW1hYVd6T2dQOFBreXQyZEJJYnI1NER1amJlQjl1bFdmTUQ2?=
 =?utf-8?B?cW5oK0thWlp3enYva0IyM1orbDRRNTRoVXJyTXRRS2NOTU13NCtMencrcEtB?=
 =?utf-8?B?WXZVaGdZSVBFMDZiREdqZ1RNU1pzUWlyQ2JRY3BvdURKQkdPa0g5YnBOcUNz?=
 =?utf-8?B?VlU1MHVKYk9jVEMrRW5kUzFQNjVkTzBQWDFkNCtaaWs2ZUZpM0ZuUzN2M0Iz?=
 =?utf-8?B?MDF6Ymt5WDhGSFV3QlhaMHhUdTdEb1JVQlMyYU5LaVZpNTVzczNHRFNZK0dU?=
 =?utf-8?B?a2hZYkxEY2Q5a3crRWlVOFQ1NkRKT2RVcFpRQ3EvbGVNWXBmdXptdFRGKytO?=
 =?utf-8?B?WnMrL0lqcWpJV0lWdS92NGxTbUx2SDI3Q0FKQjhVTEJYeUNJSE5oeURPQThI?=
 =?utf-8?B?dGdOZkoxeE1mRWZUNnZuTVdsSzdsRnZhZ2EwUnRJTUpVUVFNSU1BamVNN1U3?=
 =?utf-8?B?ZVIxZXVlL01IM2JUNXZDSlhBUUNmdXpyOERzVjdWeVhKejdlcTEzYXFIWlR6?=
 =?utf-8?B?QmI2Mk00RktrdFZTZXo5cDFhL29iblljZHJJU3VGdnhpUnhSeXJyNnJEVVFi?=
 =?utf-8?B?WStuU0lJWTJrSEY2Q25yZVZwYzlwTEl4a05Da0o1emszbjNoNUM0dWpNVnF4?=
 =?utf-8?B?WkZwWVR0QUxTbE1KWEZXMXQrdmlVNlVTbWZEaXFVYWR0dWs3S0JDeUl2eHIv?=
 =?utf-8?B?MmRPMGNqWW41UGY5alpXVE91ZWRFanpsTm55OCtkNE4zMkl2c2k4T3lMZHIx?=
 =?utf-8?B?Y3Y5SHByM2Jja0RSZVgyZXZFVlFaY0FCSExJOE1xUDNibWNuK2ZjdmhqNG9H?=
 =?utf-8?B?YzhsRk1sdWpZQldGd0FVYTMrcVpvNk1KMkRDK3ZRZTRpZjZ3WldJMGY5cTRw?=
 =?utf-8?B?OThvdUNzTld2U3B1cUxJZ2VpMytSWWVsQmxRVXJsa1pFQ0Jkdkw5R2EyOEhI?=
 =?utf-8?B?T1Q4VnNpSTBaRDJML2IrbWhRdW5TNm85STV3LzQ1TzhlcHUwc3NRcE1MYjBv?=
 =?utf-8?B?RmN3MnM5SnVBUEVCUlNOenV2S01tSGhpUEZtWGJ6cnBFSXJjY0FnQ3pOVWdR?=
 =?utf-8?B?SUkvNDh0K2pLSWpGNFFtVHlsaWIrWG1xZS9tUjlza25ydjlvbkFZZHlEaUMw?=
 =?utf-8?B?RUQ0dzR3MVZBNUJoaTZWcGhyZHBtendIVVRKR2xCT210cDRTdHoxT1FmYlVq?=
 =?utf-8?B?Nk5Bakd1Tkpzb2I3SFdJTmJRRmZvL0V2ZUlZWE1JMUxPT05WMWhnMkQrcThp?=
 =?utf-8?B?VEdJdlc3TDJjZ0lmVnY5RTlaMnhZUm1hMFBGT2hLL25EcFg1WW01L3JPbEJx?=
 =?utf-8?B?Rm5LVkVyNEVpd2hzVFVWT3VUN3pCNDRzWkZBUmpYZjkrNXRlQkhOYkYyekR6?=
 =?utf-8?Q?G0pXnsc+63ILbC2h3NhxZevyh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87c120cd-2e2d-4537-8249-08dbeb38012c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 08:49:57.6532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pg9fKGPnHGBo426IF2Gcf6P23pc6CFB0zCZmigaGPVDv4T/BhdYqcdgB078H42SF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4466
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/22/23 09:29, Dragan Simic wrote:
> On 2023-11-22 09:21, Krzysztof Kozlowski wrote:
>> On 22/11/2023 09:09, Chen-Yu Tsai wrote:
>>> On Wed, Nov 22, 2023 at 4:05 PM Krzysztof Kozlowski
>>> <krzysztof.kozlowski@linaro.org> wrote:
>>>>
>>>> On 21/11/2023 14:50, Rafał Miłecki wrote:
>>>>>> +Order of Properties in Device Node
>>>>>> +----------------------------------
>>>>>> +
>>>>>> +Following order of properties in device nodes is preferred:
>>>>>> +
>>>>>> +1. compatible
>>>>>> +2. reg
>>>>>> +3. ranges
>>>>>> +4. Standard/common properties (defined by common bindings, e.g. without
>>>>>> +   vendor-prefixes)
>>>>>> +5. Vendor-specific properties
>>>>>> +6. status (if applicable)
>>>>>> +7. Child nodes, where each node is preceded with a blank line
>>>>>> +
>>>>>> +The "status" property is by default "okay", thus it can be omitted.
>>>>>
>>>>> I think it would really help to include position of #address-cells and
>>>>> #size-cells here. In some files I saw them above "compatible" that seems
>>>>> unintuitive. Some prefer putting them at end which I think makes sense
>>>>> as they affect children nodes.
>>>>>
>>>>> Whatever you choose it'd be just nice to have things consistent.
>>>>
>>>> This is a standard/common property, thus it goes to (4) above.
>>>
>>> It's probably a mix, but AFAIK a lot of the device trees in tree have
>>> #*-cells after "status". In some cases they are added in the board
>>> .dts files, not the chip/module .dtsi files.
>>
>> Existing DTS is not a good example :)
>>
>>>
>>> +1 that it makes sense at the end as they affect child nodes.
>>
>> I still insist that status must be the last, because:
>> 1. Many SoC nodes have address/size cells but do not have any children
>> (I2C, SPI), so we put useless information at the end.
>> 2. Status should be the final information to say whether the node is
>> ready or is not. I read the node, check properties and then look at the end:
>> a. Lack of status means it is ready.
>> b. status=disabled means device still needs board resources/customization
> 
> I agree with the "status" belonging to the very end, because it's both logical 
> and much more readable.  Also, "status" is expected to be modified in the 
> dependent DT files, which makes it kind of volatile and even more deserving to 
> be placed last.

I am just curious if having status property at the end won't affect 
execution/boot up time. Not sure how it is done in Linux but in U-Boot at least 
(we want to have DTs in sync between Linux and U-Boot) of_find_property is 
pretty much big loop over all properties. And status property defined at the end 
means going over all of them to find it out to if device is present.
Not sure if Linux works in the same way but at least of_get_property is done in 
the same way.

It is not big deal on high speed cpus but wanted to point it out.

Thanks,
Michal
